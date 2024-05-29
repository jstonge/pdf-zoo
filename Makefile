DATA_DIR=./docs/data
COURSES_DIR=$(DATA_DIR)/courses

SRC_DIR=./src

RESULTS_DIR=./docs/results

SURYA_RES=$(RESULTS_DIR)/surya
SURYA_OCR_RES=$(SURYA_RES)/ocr
SURYA_LAYOUT_RES=$(SURYA_RES)/layout
SURYA_ORDER_RES=$(SURYA_RES)/reading-order

convert-pdf-to-png:
	for file in docs/data/courses/*; do pdftoppm $file -png; done
	
#########################
#
#         SURYA         #
#
#########################

# https://github.com/VikParuchuri/surya

surya-ocr:
	surya_ocr $(COURSES_DIR) --images --langs en --results_dir $(SURYA_OCR_RES)

surya-layout:
	surya_layout $(COURSES_DIR) --images --results_dir $(SURYA_LAYOUT_RES)

surya-reading-order:
	surya_order $(COURSES_DIR) --images --results_dir $(SURYA_ORDER_RES)


#############################
#
#         KOSMO 2.5         #
#
##############################

# https://github.com/microsoft/unilm/tree/master/kosmos-2.5
kosmo:
	python $(SRC_DIR)/kosmo.py $(COURSES_DIR) $(RESULTS_DIR)