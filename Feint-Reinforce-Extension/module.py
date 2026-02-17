import json
from pathlib import Path

from PySide6.QtWidgets import (
    QDialog, QVBoxLayout, QLabel,
    QLineEdit, QSpinBox, QPushButton
)


class Module:
    def __init__(self, module_dir: Path):
        self.module_dir = module_dir
        self.config_path = module_dir / "config.json"

    def load_config(self):
        cfg = {
            "keybind": "x",
            "reinforce_delay_ms": 5
        }
        if self.config_path.exists():
            try:
                cfg.update(json.loads(self.config_path.read_text(encoding="utf-8")))
            except:
                pass
        return cfg

    def save_config(self, cfg: dict):
        self.config_path.write_text(json.dumps(cfg, indent=2), encoding="utf-8")

    def open_settings(self, parent=None):
        cfg = self.load_config()

        dlg = QDialog(parent)
        dlg.setWindowTitle("Better Reinforce")

        layout = QVBoxLayout(dlg)

        desc = QLabel(
            "Burst first:\n"
            "LMB → F → RMB\n\n"
            "Then casts Reinforce after delay.\n"
            "Only runs while Roblox is focused."
        )
        desc.setWordWrap(True)
        layout.addWidget(desc)

        layout.addWidget(QLabel("Keybind:"))
        keybind = QLineEdit(cfg.get("keybind", "x"))
        layout.addWidget(keybind)

        layout.addWidget(QLabel("Reinforce Delay (ms):"))
        delay = QSpinBox()
        delay.setRange(0, 100)
        delay.setValue(int(cfg.get("reinforce_delay_ms", 5)))
        layout.addWidget(delay)

        save_btn = QPushButton("Save")
        layout.addWidget(save_btn)

        def save():
            kb = (keybind.text().strip() or "x")[0]
            self.save_config({
                "keybind": kb,
                "reinforce_delay_ms": int(delay.value())
            })
            dlg.accept()

        save_btn.clicked.connect(save)
        dlg.exec()
