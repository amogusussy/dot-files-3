from fabric import Application
from fabric.utils import get_relative_path, monitor_file
from modules import Menu

if __name__ == "__main__":
    menus = [Menu(i) for i in range(2)]
    app = Application("menu", menus[0])  
    style_path = get_relative_path("./style.css")

    style_monitor = monitor_file(style_path)
    style_monitor.connect("changed", lambda _: app.set_stylesheet_from_file(style_path))
    app.set_stylesheet_from_file(style_path)
    app.run()
