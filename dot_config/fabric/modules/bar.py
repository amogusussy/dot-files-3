from fabric.widgets.box import Box
from fabric.widgets.centerbox import CenterBox
from fabric.widgets.wayland import WaylandWindow as Window
from fabric.hyprland.widgets import HyprlandWorkspaces, WorkspaceButton
from . import LangDateTime, RamWidget, CPUWidget, VolumeWidget

class StatusBar(Window):
    def __init__(
        self,
        monitor_id,
    ):
        super().__init__(
            name="bar",
            layer="top",
            anchor="left top right",
            margin="5px 4px -2px 4px",
            exclusivity="auto",
            visible=False,
            monitor=monitor_id
        )
            
        self.children = CenterBox(
            name="bar",

            start_children=Box(
                name="start-bar",
                children=HyprlandWorkspaces(
                    name="workspaces",
                    spacing=4,
                    buttons=[
                        WorkspaceButton(
                            id=ws_id,
                            label=str(ws_id),
                        )
                        for ws_id in range(1, 10)
                    ]
                )
            ),

            center_children=Box(
                name="mid-bar",
                children=LangDateTime(
                    name="clock",
                    formatters=("󱑆 HH:mm |  y d MMMM",),
                    #locale="es"
                )
            ),

            end_children=Box(
                name="end-bar",
                children=[
                    VolumeWidget(
                        name="volume_widget"
                    ),
                    RamWidget(
                        name="ram_widget",
                    ),
                    CPUWidget(
                        name="cpu_widget",
                    ),
                ]
            )
        )

        return self.show_all()
