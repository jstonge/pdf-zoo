DATA_DIR=./docs/data
COURSES_DIR=$(DATA_DIR)/courses

SRC_DIR=./src

RESULTS_DIR=./results
SURYA_RES=$(RESULTS_DIR)/surya

convert-pdf-to-png:
	for file in docs/data/courses/*; do pdftoppm $file -png; done
	
#######################
#
#     TESTING OCR     #
#
#######################

# https://github.com/VikParuchuri/surya
surya:
	surya_ocr $(COURSES_DIR) --images --langs en --results_dir $(SURYA_RES)