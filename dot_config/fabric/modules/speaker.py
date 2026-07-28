from fabric import Fabricator
from fabric.widgets.box import Box
from fabric.widgets.eventbox import EventBox
from fabric.widgets.label import Label
import subprocess
import re
from .icons import SPEAKER_ICONS
import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gdk

SECOND = 1000

class VolumeWidgetContent(Box):
    def __init__(
        self,
        sink_name="DEFAULT_SINK",
        **kwargs,
    ):
        super().__init__(**kwargs)
        self.sink_name = sink_name
        self.speaker_icons = {
            int(s): SPEAKER_ICONS[s]()
            for s in SPEAKER_ICONS
        }
        label = Label()
        self.set_spacing(5)
        self.volume = 0
        self.volume_bin = 0
        self.fabricator = lambda _: Fabricator(
            interval=1*SECOND,
            on_changed=lambda _, value: (
                label.set_label(f"{value}%"),
                self.update_icon(value)
            ),
            poll_from=lambda _: self.get_volume(),
        )

        self.add(self.speaker_icons[100])
        self.add(label)

        self.build(self.fabricator)
        self.show_all()

    def update_icon(self, volume):
        if self.volume == volume:
            return
        self.volume = volume
        volume_bin = min(
            [(i, abs(volume - i)) for i in [0,33,66,100]],
            key = lambda f: f[1]
        )[0]
        if self.volume_bin == volume_bin:
            return
        self.volume_bin = volume_bin
        self.children = [
            self.speaker_icons[volume_bin],
            self.children[1]
        ]

    def do_invoke_function(self):
        self.fabricator(None).do_invoke_function()

    def get_volume(self):
        output = subprocess.check_output(
            ["pactl", "get-sink-volume", f"@{self.sink_name}@"]
        ).decode()
        match = re.search(r"(\d+)%", output)
        vol = 0
        if match:
            vol = int(match.group(1))

        return vol

class VolumeWidget(EventBox):
    def __init__(
        self,
        sink_name="DEFAULT_SINK",
        **kwargs,
    ):
        super().__init__(**kwargs)
        self.sink_name = sink_name
        self.increment = 5
        self.children = VolumeWidgetContent(
            name=kwargs['name'],
            sink_name=sink_name,
        )
        self.add_events(Gdk.EventMask.SCROLL_MASK)
        self.connect("scroll-event", self.do_handle_scroll)
        self.show_all()

    def do_handle_scroll(self, _, event: Gdk.EventScroll):
        match event.direction:
            case Gdk.ScrollDirection.UP:
                self.volume_up()
            case Gdk.ScrollDirection.DOWN:
                self.volume_down()
        self.children[0].fabricator(None)
    
    def volume_up(self):
        subprocess.Popen(["pactl", "set-sink-volume", f"@{self.sink_name}@", f"+{self.increment}%"])
        self.children[0].do_invoke_function()

    def volume_down(self):
        subprocess.Popen(["pactl", "set-sink-volume", f"@{self.sink_name}@", f"-{self.increment}%"])
        self.children[0].do_invoke_function()
