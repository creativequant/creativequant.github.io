from nbconvert.filters.markdown_mistune import MarkdownWithMath, IPythonRenderer


class My_IPythonRenderer(IPythonRenderer):
    def image(self, src, title, text):
        """Rendering a image with title and text.

        :param src: source link of the image.
        :param title: title text of the image.
        :param text: alt text of the image.
        """
        # in my conf images in markdown start with ../
        # I am replacing them removing ..
        if src.startswith('..'):
            src = src[2:]
        html = super().image(src, title, text)
        return f"""

                                     <span class="image main">{html}</span>"""

    def header(self, text, level, raw=None):
        html = '<h%d>%s</h%d>\n' % (level, text, level)
        if level == 1:
            html = f"""
                                    <header class="main">
                                        {html}                                    </header>
            """
        return html

    def hrule(self):
        """Rendering method for ``<hr>`` tag."""
        if self.options.get('use_xhtml'):
            return '<hr />\n'
        return """
                                     <hr class="major" />

"""


def my_markdown2html(source):
    """Convert a markdown string to HTML using mistune"""
    return MarkdownWithMath(renderer=My_IPythonRenderer(
        escape=False)).render(source)


def stripcssstyle(source):
    """ Remove style tag from html"""
    from bs4 import BeautifulSoup
    soup = BeautifulSoup(source, features="lxml")

    for t in soup.find_all("style"):
        t.replaceWith('')
    return soup.html.body.div.prettify()


