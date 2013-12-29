__author__ = 'yuanboshe'
import re
import os
import glob

# function

# filters
def path2filename(value):
    m = re.search(r'([-\w]*).\w*$', value)
    if m:
        return m.group(1)
    else:
        return None

def image_main_path(article):
    filename = path2filename(article.source_path)
    if vars(article).has_key("icon"):
        icon = article.icon
    else:
        icon = "main.*"
    image_path = os.path.join(os.path.dirname(__file__), "content", "images", filename, icon)
    paths = glob.glob(image_path)
    if len(paths) > 0:
        image_path = paths[0].replace('\\', '/')
        match = re.search('(/images/\S*)$', image_path)
        image_path = match.group(1)
        return image_path
    else:
        return None

# tests
def test_tests(value):
    if value is True:
        return True
    else:
        return False