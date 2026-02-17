import json
from pathlib import Path
from PySide6.QtWidgets import QDialog, QVBoxLayout, QLabel, QSpinBox, QPushButton


class Module:
    def __init__(self, module_dir: Path):
        self.module_dir = module_dir
        self.config_path = module_dir / "config.json"

    def open_settings(self, parent):
        dlg = QDialog(parent)
        dlg.setWindowTitle("Parry Indicator Settings")

        layout = QVBoxLayout(dlg)
        layout.addWidget(QLabel("Display duration (ms):"))

        duration_box = QSpinBox()
        duration_box.setRange(500, 60000)

        cfg = self.load_config()
        duration_box.setValue(int(cfg.get("duration_ms", 3000)))

        layout.addWidget(duration_box)

        save_btn = QPushButton("Save")
        layout.addWidget(save_btn)

        def save():
            cfg["duration_ms"] = int(duration_box.value())
            self.save_config(cfg)
            dlg.accept()

        save_btn.clicked.connect(save)
        dlg.exec()

    def load_config(self):
        if not self.config_path.exists():
            return {"duration_ms": 3000}
        try:
            return json.loads(self.config_path.read_text(encoding="utf-8"))
        except Exception:
            return {"duration_ms": 3000}

    def save_config(self, data):
        self.config_path.write_text(json.dumps(data, indent=2), encoding="utf-8")
