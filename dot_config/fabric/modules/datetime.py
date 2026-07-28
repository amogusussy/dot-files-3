from fabric.widgets.datetime import DateTime
from babel.dates import format_datetime
from datetime import datetime

class LangDateTime(DateTime):
    def __init__(
        self,
        locale="en",
        **kwargs,
    ):
        self.locale = locale
        super().__init__(**kwargs)

    def do_format(self) -> str:
        now = datetime.now()
        return format_datetime(
            now,
            format=self._formatters[self._current_index],
            locale=self.locale
        )
