BOOKNAME=service-mesh-primer

SOURCE=Book.txt
TARGET=$(BOOKNAME).pdf $(BOOKNAME)-printable.pdf $(BOOKNAME).epub

FILES= $(shell cat Book.txt| grep -v '\#')


$(BOOKNAME).pdf: $(SOURCE) $(FILES) metadata.yaml
	@echo Build $(BOOKNAME).pdf
	pandoc $(FILES) --from=markdown --output=$(BOOKNAME).pdf --template=primer --top-level-division=chapter --pdf-engine=xelatex --metadata-file=metadata.yaml

$(BOOKNAME)-printable.pdf: $(SOURCE) $(FILES) metadata.yaml
	@echo Build $(BOOKNAME)-printable.pdf
	pandoc $(FILES) --from=markdown --output=$(BOOKNAME)-printable.pdf --template=primer --top-level-division=chapter --pdf-engine=xelatex --metadata-file=metadata.yaml -V cropmarks=true

$(BOOKNAME).epub: $(SOURCE) $(FILES) metadata.yaml
	@echo Build $(BOOKNAME).epub
	pandoc $(FILES) --from=markdown --toc --standalone --output=$(BOOKNAME).epub --template=primer --top-level-division=chapter --to=epub3 --metadata-file=metadata.yaml --epub-cover-image images/title_page.jpg

$(BOOKNAME).tex: $(SOURCE) $(FILES) metadata.yaml
	@echo Build $(BOOKNAME).tex
	pandoc $(FILES) --from=markdown --output=$(BOOKNAME).tex --template=primer --top-level-division=chapter --pdf-engine=xelatex --metadata-file=metadata.yaml

all: $(TARGET)

clean:
	@echo "Cleaning..."
	rm -rf $(TARGET)

.PHONY: clean all
.DEFAULT_GOAL := all