# -*- coding: utf-8 -*-

######################################################################
# This is your site's Blogofile configuration file.
# www.Blogofile.com
#
# This file doesn't list every possible setting, it relies on defaults
# set in the core blogofile _config.py. To see where the default
# configuration is on your system run 'blogofile info'
#
######################################################################

######################################################################
# Basic Settings
#  (almost all sites will want to configure these settings)
######################################################################
## site_url -- Your site's full URL
# Your "site" is the same thing as your _site directory.
#  If you're hosting a blogofile powered site as a subdirectory of a larger
#  non-blogofile site, then you would set the site_url to the full URL
#  including that subdirectory: "http://www.yoursite.com/path/to/blogofile-dir"
site.url = "http://akson.sgh.waw.pl/~ke48003"

#### Blog Settings ####
blog = controllers.blog

## blog_enabled -- Should the blog be enabled?
#  (You don't _have_ to use blogofile to build blogs)
blog.enabled = True

## blog_path -- Blog path.
#  This is the path of the blog relative to the site_url.
#  If your site_url is "http://www.yoursite.com/~ryan"
#  and you set blog_path to "/blog" your full blog URL would be
#  "http://www.yoursite.com/~ryan/blog"
#  Leave blank "" to set to the root of site_url
#blog.path = "/blog"
blog.path = ""

## blog_name -- Your Blog's name.
# This is used repeatedly in default blog templates
blog.name = "Kamil's site"

## blog_description -- A short one line description of the blog
# used in the RSS/Atom feeds.
blog.description = "Kamil E"

## blog_timezone -- the timezone that you normally write your blog posts from
blog.timezone = "Europe/Warsaw"

blog.post.date_format = "%Y-%m-%d %H:%M:%S"

blog.post_default_filters = {
    "markdown": "syntax_highlight, markdown",
    "textile": "syntax_highlight, textile",
    "org": "syntax_highlight, org",
    "rst": "syntax_highlight, rst",
    "html": "syntax_highlight"
}

site.file_ignore_patterns = [
".*/_.*",
".*/#.*",
".*~$",
".*/\..*\.swp$",
".*/\.(git|hg|svn|bzr)$",
".*/.(git|hg)ignore$",
".*/CVS$",
".*/Makefile$",
".*/site.tar.gz$",
]

## foo - function called before a build starts with no args
#pre_build = foo
def get_repo():
    import os
    os.popen('rsync -av ../kamil_mod/repository/ _site/repository')

post_build = get_repo
