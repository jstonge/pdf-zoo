# Pdf Zoo

See [Makefile](./Makefile) for which OCR has been done.

## Kosmo2.5

To use Kosmo2.5, we had to clone `https://github.com/microsoft/unilm.git` as git submodule. We encapsulate the OCR tool within its own conda environment. You should do the same. It also only run on [Flash Attention 2](https://github.com/Dao-AILab/flash-attention), so we run the code on the VACC's A100s.

## References for the OCR

### Traditional

 - https://github.com/VikParuchuri/surya
 - https://github.com/ocrmypdf/OCRmyPDF

### Model-based OCR

 - https://github.com/microsoft/unilm/tree/master/kosmos-2.5
 - https://github.com/freedmand/textra
 - https://github.com/PaddlePaddle/PaddleOCR

### Pdf2markdown

 - https://github.com/VikParuchuri/marker
 - https://github.com/facebookresearch/nougat (builds on top of `donut`)

### Wrappers

 - https://github.com/pdfminer/pdfminer.six
 - https://github.com/pymupdf/PyMuPDF

### OCR-free models

 - https://github.com/clovaai/donut/

