.DEFAULT_GOAL= help
help: ## runs tests
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'

build: notebooks ## builds the website
	jupyter nbconvert notebooks/*.ipynb --to html --output-dir='./posts' --template jinja2template --TemplateExporter.extra_template_basedirs=./ --TemplateExporter.filters="markdown2html=pymods.filters.my_markdown2html" --TemplateExporter.filters="stripcssstyle=pymods.filters.stripcssstyle"

