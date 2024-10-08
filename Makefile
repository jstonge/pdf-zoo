
# For each single-page PDFs, we first convert to PNGs
# Then we run OCR on the PNGs
# If the OCR tools do layout analysis and reading-order, we do that as well
# Then we format the data into ocr/results.json
# If the data app doesn't find a layout/reading-order config, it grabs PNGs in assets/

# We follow this structure 
# src/assets/*.png 
# src/data/(faculties|courses|policies|...)/*.pdf
# src/results/(pymupdf|surya|mineru|...)/(faculties|courses|policies|...)/(ocr|reading-order|layout)/*

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

#############################
#
#  PDF to PNG conversion    #
#
#############################

convert-course-dir-pdf-to-png:
	for file in $(COURSES_DIR)/*.pdf; do \
		pdftoppm "$$file" "$${file%.pdf}" -png; \
	done

convert-policies-dir-pdf-to-png:
	for file in $(POLICIES_DIR)/*.pdf; do \
		pdftoppm "$$file" "$${file%.pdf}" -png; \
	done
	mv $(POLICIES_DIR)/*.png src/assets/
	cd src/assets && rename 's/-/_/' * && rename 's/_1//' *

convert-faculties-dir-pdf-to-png:
	for file in $(FACULTY_DIR)/*.pdf; do \
		pdftoppm "$$file" "$${file%.pdf}" -png; \
	done
	mv $(FACULTY_DIR)/*.png src/assets/
	cd src/assets && rename 's/-1//' *


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

mineru-ocr:
	mkdir -p $(MINERU_RES)/courses/ocr
	magic-pdf -p $(COURSES_DIR) -o $(MINERU_RES)/courses/ocr -m auto
	mkdir -p $(MINERU_RES)/courses/reading-order
	for dir in $(MINERU_RES)/courses/ocr/*; do mv $$dir/auto/*layout.pdf $(MINERU_RES)/courses/reading-order; done;

mineru-ocr-faculties:
	mkdir -p $(MINERU_RES)/faculties/ocr
	magic-pdf -p $(FACULTY_DIR) -o $(MINERU_RES)/faculties/ocr -m auto
	mkdir -p $(MINERU_RES)/faculties/reading-order
	for dir in $(MINERU_RES)/faculties/ocr/*; do mv $$dir/auto/*layout.pdf $(MINERU_RES)/faculties/reading-order; done;

mineru-ocr-policies:
	mkdir -p $(MINERU_RES)/policies/ocr
	magic-pdf -p $(POLICIES_DIR) -o $(MINERU_RES)/policies/ocr -m auto
	mkdir -p $(MINERU_RES)/policies/reading-order
	for dir in $(MINERU_RES)/policies/ocr/*; do mv $$dir/auto/*layout.pdf $(MINERU_RES)/policies/reading-order; done;
	for file in $(MINERU_RES)/policies/reading-order/*pdf; do \
		pdftoppm "$$file" "$${file%.pdf}" -png; \
	done
	rm $(MINERU_RES)/policies/reading-order/*pdf
	rename 's/_layout-1//' $(MINERU_RES)/policies/reading-order/*png

	
#########################
#
#         SURYA         #
#
#########################

# https://github.com/VikParuchuri/surya

surya-ocr:
	mkdir -p $(SURYA_RES)/courses/ocr
	surya_ocr $(COURSES_DIR) --images --langs en --results_dir $(SURYA_RES)/courses/ocr

surya-layout:
	mkdir -p $(SURYA_RES)/courses/layout
	surya_layout $(COURSES_DIR) --images --results_dir $(SURYA_RES)/courses/layout

surya-reading-order:
	mkdir -p $(SURYA_RES)/courses/reading-order
	surya_order $(COURSES_DIR) --images --results_dir $(SURYA_RES)/courses/reading-order

# ----------------------------

surya-ocr-p:
	mkdir -p $(SURYA_RES)/policies/ocr
	surya_ocr $(POLICIES_DIR) --images --langs en --results_dir $(SURYA_RES)/policies/ocr

surya-layout-p:
	mkdir -p $(SURYA_RES)/policies/layout
	surya_layout $(POLICIES_DIR) --images --results_dir $(SURYA_RES)/policies/layout

surya-reading-order-p:
	mkdir -p $(SURYA_RES)/policies/reading-order
	surya_order $(POLICIES_DIR) --images --results_dir $(SURYA_RES)/policies/reading-order

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
kosmo:
	python $(PYTHON_DIR)/kosmo.py $(COURSES_DIR) $(RESULTS_DIR)
