from dataclasses import dataclass
from subprocess import check_output

@dataclass
class MusicMetadata():
    artUrl: str = ""
    length: str = ""
    trackid: str = ""
    album: str = ""
    albumArtist: str = ""
    artist: str = ""
    contentCreated: str = ""
    discNumber: str = ""
    genre: str = ""
    title: str = ""
    trackNumber: str = ""
    useCount: str = ""

    def set_attr(self, attr, value):
        if attr in self.__dict__:
            self.__setattr__(attr, value)

def get_current_playing_metadata():
    command = ["playerctl", "metadata"]
    out = check_output(command).decode('utf-8')
    M = MusicMetadata()
    for line in out.split("\n"):
        if ":" not in line:
            continue
        partition = line.index(":")
        p = line[partition+1:]
        name = ""
        while p[0] != " ":
            name += p[0]
            p = p[1:]
        M.set_attr(name, p.strip())
    return M
