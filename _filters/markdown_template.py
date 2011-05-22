import markdown
import logging

config = {
    'name': "Markdown",
    'description': "Renders markdown formatted text to HTML",
    'aliases': ['markdown']
    }


#Markdown logging is noisy, pot it down:
#logging.getLogger("MARKDOWN").setLevel(logging.DEBUG)


def run(content):
    return markdown.markdown(content)
