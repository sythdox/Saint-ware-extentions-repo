from PySide6.QtWidgets import QDialog, QVBoxLayout, QLabel, QPushButton


class Module:
    def __init__(self, module_dir):
        self.module_dir = module_dir

    def open_settings(self, parent):
        dlg = QDialog(parent)
        dlg.setWindowTitle("S Remover")

        layout = QVBoxLayout(dlg)

        label = QLabel("There aren't any configs for this one bud.")
        layout.addWidget(label)

        close_btn = QPushButton("Close")
        layout.addWidget(close_btn)

        close_btn.clicked.connect(dlg.accept)
        dlg.exec()

    @staticmethod
    def uninstall(module_dir):
        # Nothing to clean up
        return
