from fabric.widgets.box import Box
import urllib.request
from fabric.widgets.button import Button
from fabric.widgets.image import Image
from fabric.widgets.label import Label
from gi.repository import GdkPixbuf, Gdk
import urllib
from services.music_manager import get_current_playing_metadata, MusicMetadata
import gi
gi.require_version("Gtk", "3.0")

def pixbuf_from_url(url):
    data = urllib.request.urlopen(url).read()
    loader = GdkPixbuf.PixbufLoader()
    loader.write(data)
    loader.close()
    return loader.get_pixbuf()


class MusicPlayer(Box):
    metadata: MusicMetadata
    def __init__(
        self,
        **kwargs
    ):
        super().__init__(
            **kwargs,
            orientation="vertical",
            size=(20,60)
        )
        self.metadata: MusicMetadata = get_current_playing_metadata()

        image_pixbuf = pixbuf_from_url(self.metadata.artUrl)
        image_pixbuf = image_pixbuf.scale_simple(200, 200, True)
        image = Image(
            name="music_player_image",
            children=Label(self.metadata.title),
            pixbuf=image_pixbuf,
            size=(200,200),
        )

        self.add(image)

        self.add(Box(
            name="music_metadata",
            orientation="vertical",
            children=[
                Box(
                    name="music_player_songname",
                    children=Label(self.metadata.title)
                ),
                Box(
                    name="music_player_album",
                    children=Label(self.metadata.album)
                ),
                Box(
                    name="music_player_artist",
                    children=Label(self.metadata.artist)
                ),
                # controls
                Box(
                    name="music_controls",
                    children=[
                        Button(
                            label="Back",
                        ),
                        Button(
                            label="Pause",
                        ),
                        Button(
                            label="Forward",
                        ),
                    ]
                )
            ]
        ))

        return self.show_all()

    def update_metadata(self):
        self.metadata = get_current_playing_metadata()
