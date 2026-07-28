from fabric.widgets.box import Box
from fabric.widgets.label import Label
from fabric.widgets.centerbox import CenterBox
from fabric.widgets.wayland import WaylandWindow as Window
from .music_player import MusicPlayer

WIDTH = 1920

class Menu(Window):
    def __init__(
        self,
        monitor_id,
    ):
        margin_lr = (WIDTH - 800) >> 1
        super().__init__(
            name="menu",
            layer="top",
            anchor="left top right",
            margin=f"5px {margin_lr}px -2px {margin_lr}px", # nesw
            exclusivity="none",
            visible=False,
            monitor=monitor_id
        )
            
        self.children = CenterBox(
            name="start-bar",
            start_children=[
                MusicPlayer(
                    name="music_player"
                ),
            ]
        )

        return self.show_all()
