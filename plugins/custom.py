__author__ = 'yuanboshe'

from pelican import signals

# add jinja2ex tests
def generator_init(sender):
    custom_tests = sender.settings['JINJA_TESTS']
    sender.env.tests.update(custom_tests)

def register():
    signals.generator_init.connect(generator_init)