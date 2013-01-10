site.url = "http://www1.hertz.megiteam.pl"
# blog = controllers.blog
blog.enabled = False
blog.path = ""
blog.name = "Kamil's site"
blog.description = "Kamil E"
blog.timezone = "Europe/Warsaw"
blog.post.date_format = "%Y-%m-%d %H:%M:%S"
blog.post_default_filters = {
     "html": "syntax_highlight",
     "markdown": "syntax_highlight, markdown",
     "textile": "syntax_highlight, textile",
    "rst": "syntax_highlight, rst",
}
site.file_ignore_patterns = [
    ".*/_.*",
    ".*/#.*",
    ".*~$",
    ".*/\..*\.swp$",
    ".*/\.(git|hg|svn|bzr)$",
    ".*/.(git|hg)ignore$",
    ".*/CVS$",
    ".*/Makefile*$",
    ".*/site.tar.gz$",
]
