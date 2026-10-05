DRAFT := draft-campbell-crdc
VERSION ?= 00
DOCNAME := $(DRAFT)-$(VERSION)

.PHONY: all xml txt html md check idnits clean

all: xml txt html md

$(DOCNAME).xml: $(DRAFT).md
	sed "s/$(DRAFT)-latest/$(DOCNAME)/g" $(DRAFT).md | kramdown-rfc > $(DOCNAME).xml
	xmllint --noout $(DOCNAME).xml

$(DOCNAME).txt: $(DOCNAME).xml
	xml2rfc --v3 --text $(DOCNAME).xml -o $(DOCNAME).txt

$(DOCNAME).html: $(DOCNAME).xml
	xml2rfc --v3 --html $(DOCNAME).xml -o $(DOCNAME).html

$(DOCNAME).md: $(DOCNAME).html
	pandoc -f html -t gfm --wrap=none $(DOCNAME).html -o $(DOCNAME).md

xml: $(DOCNAME).xml
txt: $(DOCNAME).txt
html: $(DOCNAME).html
md: $(DOCNAME).md

check: $(DOCNAME).xml $(DOCNAME).txt
	xmllint --noout $(DOCNAME).xml
	-idnits $(DOCNAME).txt

clean:
	rm -f $(DRAFT)-[0-9][0-9].xml $(DRAFT)-[0-9][0-9].txt $(DRAFT)-[0-9][0-9].html $(DRAFT)-[0-9][0-9].md
