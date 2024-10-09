
# For each single-page PDFs, we first convert to PNGs
# Then we run OCR on the PNGs
# If the OCR tools do layout analysis and reading-order, we do that as well
# Then we format the data into ocr/results.json
# If the data app doesn't find a layout/order config, it grabs PNGs in assets/

# We follow this structure 
# src/assets/*.png 
# src/data/(faculties|courses|policies|...)/*.pdf
# src/results/(pymupdf|surya|mineru|...)/(faculties|courses|policies|...)/(ocr|order|layout)/*

DATA_DIR=./src/data
COURSES_DIR=$(DATA_DIR)/courses
FACULTY_DIR=$(DATA_DIR)/faculties
POLICIES_DIR=$(DATA_DIR)/policies

PYTHON_DIR=./python

RESULTS_DIR=./src/results

SURYA_RES=$(RESULTS_DIR)/surya
PYMUPDF_RES=$(RESULTS_DIR)/pymupdf
TEXTRA_RES=$(RESULTS_DIR)/textra
MINERU_RES=$(RESULTS_DIR)/mineru

TASK ?= ocr
DOC_TYPE ?= policies


#############################
#
#  PDF to PNG conversion    #
#
#############################

convert-dir-pdf-to-png:
	for file in $(DATA_DIR)/$(DOC_TYPE)/*.pdf; do \
		pdftoppm "$$file" "$${file%.pdf}" -png; \
	done
	mv $(DATA_DIR)/$(DOC_TYPE)/*.png src/assets/
	cd src/assets && rename 's/-1//' *

# To handle all types of PDF to PNG conversions
pdf2pngs:
	$(MAKE) convert-dir-pdf-to-png DOC_TYPE=courses
	$(MAKE) convert-dir-pdf-to-png DOC_TYPE=policies
	$(MAKE) convert-dir-pdf-to-png DOC_TYPE=faculties

#########################
#
#         PYMUPDF       #
#
#########################

pymupdf-ocr:
	mkdir -p $(PYMUPDF_RES)/courses/text-extraction
	python $(PYTHON_DIR)/pymupdf_ocr.py $(COURSES_DIR) $(PYMUPDF_RES)/courses/text-extraction

#########################
#
#         MinerU        #
#
#########################


mineru:
	$(MAKE) mineru-ocr DOC_TYPE=courses
	$(MAKE) mineru-ocr DOC_TYPE=faculties
	$(MAKE) mineru-ocr DOC_TYPE=policies

mineru-ocr:
	mkdir -p $(MINERU_RES)/$(DOC_TYPE)/ocr
	magic-pdf -p $(DATA_DIR)/$(DOC_TYPE) -o $(MINERU_RES)/$(DOC_TYPE)/ocr -m auto
	mkdir -p $(MINERU_RES)/$(DOC_TYPE)/order
	for dir in $(MINERU_RES)/$(DOC_TYPE)/ocr/*; do mv $$dir/auto/*layout.pdf $(MINERU_RES)/$(DOC_TYPE)/order; done;
	for file in $(MINERU_RES)/$(DOC_TYPE)/order/*pdf; do \
		pdftoppm "$$file" "$${file%.pdf}" -png; \
	done
	rm $(MINERU_RES)/$(DOC_TYPE)/order/*pdf
	@if [ "$(DOC_TYPE)" = "policies" ]; then \
	    rename 's/_layout-1//' $(MINERU_RES)/$(DOC_TYPE)/order/*png; \
	else \
	    rename 's/_layout//' $(MINERU_RES)/$(DOC_TYPE)/order/*png; \
	fi

# mineru-ocr:
# 	mkdir -p $(MINERU_RES)/courses/ocr
# 	magic-pdf -p $(COURSES_DIR) -o $(MINERU_RES)/courses/ocr -m auto
# 	mkdir -p $(MINERU_RES)/courses/order
# 	for dir in $(MINERU_RES)/courses/ocr/*; do mv $$dir/auto/*layout.pdf $(MINERU_RES)/courses/order; done;

# mineru-ocr-faculties:
# 	mkdir -p $(MINERU_RES)/faculties/ocr
# 	magic-pdf -p $(FACULTY_DIR) -o $(MINERU_RES)/faculties/ocr -m auto
# 	mkdir -p $(MINERU_RES)/faculties/order
# 	for dir in $(MINERU_RES)/faculties/ocr/*; do mv $$dir/auto/*layout.pdf $(MINERU_RES)/faculties/order; done;

# mineru-ocr-policies:
# 	mkdir -p $(MINERU_RES)/policies/ocr
# 	magic-pdf -p $(POLICIES_DIR) -o $(MINERU_RES)/policies/ocr -m auto
# 	mkdir -p $(MINERU_RES)/policies/order
# 	for dir in $(MINERU_RES)/policies/ocr/*; do mv $$dir/auto/*layout.pdf $(MINERU_RES)/policies/order; done;
# 	for file in $(MINERU_RES)/policies/order/*pdf; do \
# 		pdftoppm "$$file" "$${file%.pdf}" -png; \
# 	done
# 	rm $(MINERU_RES)/policies/order/*pdf
# 	rename 's/_layout-1//' $(MINERU_RES)/policies/order/*png

	
#########################
#
#         SURYA         #
#
#########################

# ref: https://github.com/VikParuchuri/surya
# usage: `make surya DOC_TYPE=policies`

surya:
	$(MAKE) surya-task TASK=ocr DOC_TYPE=$(DOC_TYPE)
	$(MAKE) surya-task TASK=layout DOC_TYPE=$(DOC_TYPE)
	$(MAKE) surya-task TASK=order DOC_TYPE=$(DOC_TYPE)

surya-task:
	mkdir -p $(SURYA_RES)/$(DOC_TYPE)/$(TASK)
	@if [ "$(TASK)" = "ocr" ]; then \
	    surya_$(TASK) $(DATA_DIR)/$(DOC_TYPE) --images --langs en --results_dir $(SURYA_RES)/$(DOC_TYPE)/$(TASK);\
	else \
	    surya_$(TASK) $(DATA_DIR)/$(DOC_TYPE) --images --results_dir $(SURYA_RES)/$(DOC_TYPE)/$(TASK); \
	fi
	mv $(SURYA_RES)/$(DOC_TYPE)/$(TASK)/$(DOC_TYPE)/* $(SURYA_RES)/$(DOC_TYPE)/$(TASK)
	rmdir $(SURYA_RES)/$(DOC_TYPE)/$(TASK)/$(DOC_TYPE)
	@if [ "$(TASK)" = "ocr" ]; then \
	    rename 's/_\d{1,2}_text//' $(SURYA_RES)/$(DOC_TYPE)/$(TASK)/*png; \
	else \
	    rename 's/_\d{1,2}_$(TASK)//' $(SURYA_RES)/$(DOC_TYPE)/$(TASK)/*png; \
	fi

#########################
#
#         TEXTRA        #
#
#########################

# https://github.com/freedmand/textra

textra-ocr:
	mkdir -p $(TEXTRA_RES)/courses/text-extraction
	for pdf in $(COURSES_DIR)/*.pdf; do \
		textra "$$pdf" -o $(TEXTRA_RES)/courses/text-extraction/$$(basename "$${pdf%.pdf}").txt; \
	done

textra-ocr-p:
	mkdir -p $(TEXTRA_RES)/courses/ocr
	for pdf in $(COURSES_DIR)/*.pdf; do \
		textra "$$pdf" -p $(TEXTRA_RES)/courses/ocr/$$(basename "$${pdf%.pdf}").json; \
	done

#############################
#
#         KOSMO 2.5         #
#
#############################

# https://github.com/microsoft/unilm/tree/master/kosmos-2.5
# kosmo:
# 	python $(PYTHON_DIR)/kosmo.py $(COURSES_DIR) $(RESULTS_DIR)
