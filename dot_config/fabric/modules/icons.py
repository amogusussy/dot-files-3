from fabric.utils import get_relative_path
from fabric.widgets.svg import Svg


# lambdas because gtk doesnt let clones
SPEAKER_ICONS = {
    "100": lambda: Svg(
        svg_file=get_relative_path("../icons/speakers/speaker_100.svg"),
        size=20
    ),
    "66": lambda: Svg(
        svg_file=get_relative_path("../icons/speakers/speaker_66.svg"),
        size=20
    ),
    "33": lambda: Svg(
        svg_file=get_relative_path("../icons/speakers/speaker_33.svg"),
        size=20
    ),
    "0": lambda: Svg(
        svg_file=get_relative_path("../icons/speakers/speaker_0.svg"),
        size=20
    ),
}

