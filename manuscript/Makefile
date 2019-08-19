BOOKNAME=service-mesh-primer

SOURCE=Book.txt
TARGET=$(BOOKNAME).pdf $(BOOKNAME).epub $(BOOKNAME).mobi

FILES= $(shell cat Book.txt| grep -v '\#')


$(BOOKNAME).pdf: $(SOURCE) $(FILES)
	pandoc $(FILES) --from=markdown --output=$(BOOKNAME).pdf \
	--template=primer --top-level-division=chapter --pdf-engine=xelatex \
	--metadata-file=metadata.yaml

$(BOOKNAME).epub: $(SOURCE) $(FILES)
	pandoc $(FILES) \
	--from=markdown \
	--toc \
    --standalone \
	--output=$(BOOKNAME).epub \
	--template=primer \
	--top-level-division=chapter \
	--to=epub3 \
	--metadata-file=metadata.yaml \
	--epub-cover-image images/title_page.jpg

%.mobi: %.epub
	echo "Mobi is still a TODO"
	#ebook-convert $< $@ || true

$(BOOKNAME).tex: $(SOURCE) $(FILES)
	pandoc $(FILES) --from=markdown --output=$(BOOKNAME).tex \
	--template=primer --top-level-division=chapter --pdf-engine=xelatex \
	--metadata-file=metadata.yaml

all: $(TARGET)

clean:
	rm -rf $(TARGET)

.PHONY: clean all
.DEFAULT_GOAL := all