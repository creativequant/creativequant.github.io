.DEFAULT_GOAL= help
help: ## run help
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'

build: notebooks ## build the website
	jupyter nbconvert notebooks/*.ipynb --to html --output-dir='./posts' --template mytemplate --TemplateExporter.extra_template_basedirs=./mynbconvert/ --TemplateExporter.filters="markdown2html=mynbconvert.filters.my_markdown2html" --TemplateExporter.filters="stripcssstyle=mynbconvert.filters.stripcssstyle"
	nikola build

serve: ## serve the website
	nikola serve -b

deploy: ## deploy the website
	nikola github_deploy
