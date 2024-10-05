# We follow this structure 
# src/assets/*.png 
# src/data/${DOCUMENT_TYPE}/*.pdf
# src/results/${OCR}/${DOCUMENT_TYPE}/${CONFIG}/*

DATA_DIR=./src/data
COURSES_DIR=$(DATA_DIR)/courses
FACULTY_DIR=$(DATA_DIR)/faculties

SRC_DIR=./src

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

convert-mineru-pdf-to-png:
	for file in $(MINERU_RES)/*.pdf; do \
		pdftoppm "$$file" "$${file%.pdf}" -png; \
	done

#########################
#
#         PYMUPDF       #
#
#########################

pymupdf-ocr:
	mkdir -p $(PYMUPDF_RES)/courses/text-extraction
	python $(SRC_DIR)/pymupdf_ocr.py $(COURSES_DIR) $(PYMUPDF_RES)/courses/text-extraction

#########################
#
#         MinerU        #
#
#########################

mineru-ocr:
	mkdir -p $(MINERU_RES)/courses/ocr
	magic-pdf -p $(COURSES_DIR) -o $(MINERU_RES)/courses/ocr -m auto
	mkdir -p $(MINERU_RES)/courses/reading-order
	for dir in $(MINERU_RES)/courses/ocr/*; do mv $dir/auto/*layout.pdf $(MINERU_RES)/courses/reading-order; done;

#!TODO: this doesn;t work
# mineru-reading-order:
# 	for file in $(MINERU_RES)/courses/reading-order/*.pdf; do \
# 		pdftoppm "$$file" "$${file%.pdf}" -png; \
# 	done
# 	rm *pdf  
# 	rename 's/_layout-1//' *

	
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
	python $(SRC_DIR)/kosmo.py $(COURSES_DIR) $(RESULTS_DIR)
