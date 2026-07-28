import psutil


class Usage:
    def __init__(
        self,
        number_of_widgets=2,
    ):
        self.usage = 0
        self.cont = 0
        self.number_of_widgets = number_of_widgets

    def usage_function(self):
        return None

    def get_usage(self):
        if (self.cont % self.number_of_widgets) != 0:
            self.cont += 1
            return self.usage
        self.cont += 1
        self.usage = self.usage_function()

        return self.usage


class RamUsage(Usage):
    def usage_function(self):
        mem = psutil.virtual_memory()
        usage = mem.total - mem.available
        return usage
    
class CPUUsage(Usage):
    def usage_function(self):
        return psutil.cpu_percent(interval=None)
