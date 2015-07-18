#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals
import sys

AUTHOR = u'Yuanbo She'
SITENAME = u'Yuanbo She'
SITEURL = ''

TIMEZONE = 'Asia/Shanghai'
DATE_FORMATS = {
    'en':('usa','%a, %d %b %Y'),
    'zh':('chs','%Y-%m-%d'),
    'jp':('jpn','%Y/%m/%d (%a)'),
}
DEFAULT_DATE = (1987, 6, 16, 22, 0, 0)

# windows locale: http://msdn.microsoft.com/en-us/library/cdax410z%28VS.71%29.aspx
LOCALE = ['usa', 'chs', 'jpn',        # windows
          'en_US', 'zh_CN', 'ja_JP']  # Unix/Linux 
DEFAULT_LANG = u'zh'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None

# Blogroll
LINKS = (('Old blog', 'http://www.cnblogs.com/freedomshe'), )

# Social widget
SOCIAL = (('You can add links in your config file', '#'),
          ('Another social link', '#'),)

DEFAULT_PAGINATION = 10

# Uncomment following line if you want document-relative URLs when developing
RELATIVE_URLS = False

PATH = 'content'
DEFAULT_CATEGORY ='Others'
DISPLAY_PAGES_ON_MENU = False
DISPLAY_CATEGORIES_ON_MENU = True
THEME = 'themes/ybs'

#URLs
ARTICLE_DIR = 'blog'
ARTICLE_URL = 'blog/{date:%Y}-{date:%m}-{slug}.html'
ARTICLE_SAVE_AS = 'blog/{date:%Y}-{date:%m}-{slug}.html'
ARTICLE_LANG_URL = 'blog/{date:%Y}-{date:%m}-{slug}-{lang}.html'
ARTICLE_LANG_SAVE_AS = 'blog/{date:%Y}-{date:%m}-{slug}-{lang}.html'
PAGE_DIR = 'pages'
PAGE_URL = 'pages/{slug}.html'
PAGE_SAVE_AS = 'pages/{slug}.html'
CATEGORY_SAVE_AS = 'blog/category/{slug}.html'
CATEGORY_URL = 'blog/category/{slug}.html'
TAG_SAVE_AS = 'blog/tag/{slug}.html'
TAG_URL = 'blog/tag/{slug}.html'
AUTHOR_SAVE_AS = None
AUTHORS_SAVE_AS = None
DIRECT_TEMPLATES = ('index', 'blog/index', 'blog/tags', 'blog/categories', 'blog/dates', '404')
PAGINATED_DIRECT_TEMPLATES = ('blog/index',)
TEMPLATE_PAGES = {'about.html': 'about.html',
                  'welcome.html': 'welcome/index.html'}
#                  'pages/home.html': 'index.html'}

MENUITEMS = (('Home', 'index.html'),
             ('About', 'abouts.html'),
             ('Pages', 'pages.html'),
             ('Blog', 'categories.html'))

PLUGIN_PATH = 'plugins'
PLUGINS = ['custom', 'sitemap']
SITEMAP = {
    "format": "xml",
    "priorities": {
        "articles": 0.9,
        "indexes": 0.3,
        "pages": 0.3,
    },
    "changefreqs": {
        "articles": "monthly",
        "indexes": "daily",
        "pages": "monthly",
    }
}

# include jinja2ex script path
import os
sys.path.append(os.path.abspath(''))
import jinja2ex as jinja2
JINJA_FILTERS = { 'path2filename': jinja2.path2filename,
                  'image_main_path': jinja2.image_main_path, }
JINJA_TESTS = {'test_tests': jinja2.test_tests,}

STATIC_PATHS = ['images', 'CNAME']

FILENAME_METADATA = '(?P<date>\d{4}-\d{2}-\d{2})_(?P<slug>.*)'

EXTRA_TEMPLATES_PATHS = ['partial']
