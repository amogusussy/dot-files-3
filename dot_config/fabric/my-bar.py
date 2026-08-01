from fabric import Application
from fabric.utils import get_relative_path, monitor_file
from modules import StatusBar
import logging

logging.basicConfig(
    filename='/home/matthew/.config/fabric/logfile.log',
    encoding='utf-8', 
    level=logging.DEBUG,
)

if __name__ == "__main__":
    bars = [StatusBar(i) for i in range(2)]
    app = Application("statusbars", bars[0])  
    style_path = get_relative_path("./style.css")

    style_monitor = monitor_file(style_path)
    style_monitor.connect("changed", lambda _: app.set_stylesheet_from_file(style_path))
    app.set_stylesheet_from_file(style_path)
    app.run()
