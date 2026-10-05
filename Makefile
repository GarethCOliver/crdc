DRAFT := draft-campbell-crdc
VERSION ?= 00
DOCNAME := $(DRAFT)-$(VERSION)

.PHONY: all xml txt html check idnits clean

all: xml txt html

$(DOCNAME).xml: $(DRAFT).md
	sed "s/$(DRAFT)-latest/$(DOCNAME)/g" $(DRAFT).md | kramdown-rfc > $(DOCNAME).xml
	xmllint --noout $(DOCNAME).xml

$(DOCNAME).txt: $(DOCNAME).xml
	xml2rfc --v3 --text $(DOCNAME).xml -o $(DOCNAME).txt

$(DOCNAME).html: $(DOCNAME).xml
	xml2rfc --v3 --html $(DOCNAME).xml -o $(DOCNAME).html

xml: $(DOCNAME).xml
txt: $(DOCNAME).txt
html: $(DOCNAME).html

check: $(DOCNAME).xml $(DOCNAME).txt
	xmllint --noout $(DOCNAME).xml
	-idnits $(DOCNAME).txt

clean:
	rm -f $(DRAFT)-[0-9][0-9].xml $(DRAFT)-[0-9][0-9].txt $(DRAFT)-[0-9][0-9].html
