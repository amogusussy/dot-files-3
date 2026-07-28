from math import log2, floor
import random
from fabric import Fabricator
from fabric.widgets.label import Label
from fabric.widgets.box import Box
import psutil
from services.usage import RamUsage, CPUUsage

SECOND = 1000
CPU_FORMAT = "CPU {:2.1f}%"
RAM_USAGE = RamUsage()
CPU_USAGE = CPUUsage()

class TextPoll(Box):
    def __init__(self,
        func = lambda: "",
         formatter = lambda value: "",
        **kwargs,
    ):
        super().__init__(**kwargs)
        self.func = func
        self.formatter = formatter
        self.children = [
            Label()
        ]

        self.build(
            lambda progress: Fabricator(
                interval=1*SECOND,
                on_changed=lambda _, value: progress.children[0].set_label(
                    self.formatter(value)
                ),
                poll_from=lambda _: self.func(),
            )
        )
        self.show_all()

    def set_value(self, value):
        self.label = value
        self.show_all()

class RamWidget(TextPoll):
    def __init__(self, **kwargs):
        self.bar_id = random.randrange(1<<32)
        super().__init__(
            func=lambda: RAM_USAGE.get_usage(),
            formatter=self.do_format,
            **kwargs
        )

    def do_format(self, value):
        units = ["", "K", "M", "G", "T"]
        ind = floor(log2(value)/10)
        x = value/(1<<(10*ind))
        return f"{x:.2f}{units[ind]}"


class CPUWidget(TextPoll):
    def __init__(self, **kwargs):
        super().__init__(
            func=lambda: CPU_USAGE.get_usage(),
            #func=self.get_perc,
            formatter = lambda value: CPU_FORMAT.format(value),
            **kwargs
        )

    def get_perc(self):
        N = 50
        s = sum(psutil.cpu_percent() for _ in range(N))
        return s/N
