# Pdf Zoo

See [Makefile](./Makefile) for which OCR has been done.

## OCR-tools

#### [tesseract](https://github.com/tesseract-ocr/tesseract) 
tags: `#trad`
> Mother of all OCR tools. It was there when the world wide web was invented. More recently runs LSTM under the hood.

#### [pdfminer.six](https://github.com/pdfminer/pdfminer.six)
tags: `#trad` 
> Community maintained fork of `pdfminer` to support Python3.0. It is not model-based in that it uses layout embedded in pdfs to extract content (I think?).

#### [pdfplumber](https://github.com/jsvine/pdfplumber)
tags: `#toolkit`  
deps: [pdfminer.six](#pdfminer.six)
>  Plumb a PDF for detailed information about each char, rectangle, line, et cetera — and easily extract text and tables. 

#### [OCRmyPDF](https://github.com/ocrmypdf/OCRmyPDF)
tags: `addTextLayer`
> OCRmyPDF adds an OCR text layer to scanned PDF files, allowing them to be searched.

#### [pypdf2](https://github.com/py-pdf/pypdf)
tags: `#toolkit`  
> A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files 

#### [PyMuPDF](https://github.com/pymupdf/PyMuPDF)
tags: `#toolkit`  
deps: [tesseract](#tesseract) (OCR)

#### [easyOCR](https://github.com/JaidedAI/EasyOCR)
tags: `#model-based`

 <img src="https://github.com/JaidedAI/EasyOCR/raw/master/examples/easyocr_framework.jpeg" alt="easyOCR" width="600"> 

#### [surya](https://github.com/VikParuchuri/surya) 
tags: `#model-based`, `#readingOrder`, `#layoutAnalysis`  
deps: [Donut](#donut)

#### [pypdfium2](https://github.com/pypdfium2-team/pypdfium2)
tags: `#PDF-wrangling`
inst: `google`  
> Python 3 binding to PDFium, a powerful and liberal-licensed library for PDF rendering, inspection, manipulation and creation.

#### [pdfium](https://pdfium.googlesource.com/pdfium/)
tags: `#PDF-wrangling`
> This example shows that a PDF document can be dynamically created using page objects. You can create multiple page objects and place them anywhere on the page. There are several types of page objects: paths, forms, images and text objects

#### [textra](https://github.com/freedmand/textra)
tags: `#model-based`
> Can be used as CLI to convert images, PDFs, and audio files to text. It uses Apple's APIs, which is annoying when we deploy to a server.

#### [PaddleOCR](https://github.com/PaddlePaddle/PaddleOCR)
tags: `#model-based`, `#toolkit`  
deps: [PaddlePaddle](#PaddlePaddle)
> Awesome multilingual OCR toolkits

#### [PaddlePaddle](https://github.com/PaddlePaddle/Paddle)
tags: `#model-based`  
> Practical ultra lightweight OCR system, support 80+ languages recognition, provide data annotation and synthesis tools, support training and deployment among server, mobile, embedded and IoT devices

#### [marker](https://github.com/VikParuchuri/marker)
tags: `#pdf2markdown`  
deps: [surya](#surya) (OCR), [texify](#texify) (clean and format each block)  
models: [pdf_postprocessor_t5](#pdf_postprocessor_t5)
>  Convert PDF to markdown quickly with high accuracy 

#### [nougat](https://github.com/facebookresearch/nougat)
tags: `#pdf2markdown`  
deps: [donut](#donut)

#### [donut](https://github.com/clovaai/donut/)
tags: `#ocr-free`

#### [MinerU](https://github.com/opendatalab/MinerU)
tags: `#layoutAnalysis`, `#pdf2markdown`  
deps: [PDF-Extract-Kit](#pdfextractkit), , [LayoutLMv3](#layoutlmv3), [YOLOv8](#yolov8), [UniMERNet](#unimernet), [StructEqTable](#structeqtable), [PaddleOCR](#paddleocr)  
paper: https://arxiv.org/abs/2409.18839  
<img width="641" alt="minerU_pipeline" src="https://github.com/user-attachments/assets/1d041939-1c51-40f7-a634-94b7f2fc3a70">
```
# minerU has its own environment
conda create -n MinerU python=3.10
conda activate MinerU
pip install -U magic-pdf[full] --extra-index-url https://wheels.myhloli.com
```

#### [PDF Extract Kit](https://github.com/opendatalab/PDF-Extract-Kit)
tags: `#toolkit`, `#model-based`

#### [GOT-ocr2](https://huggingface.co/stepfun-ai/GOT-OCR2_0)
tags: `#llm`   
paper: 2405.14295  
date: Sep 2024  

#### [docling](https://github.com/DS4SD/docling)
tags: `#layout`   
paper: https://arxiv.org/pdf/2408.09869  
deps:  [easyocr](#easyocr) (ocr, default), [tesseract](#tesseract) (ocr, optionnal), [pypdfium2](#pypdfium2)  
<img width="699" alt="Screenshot 2024-10-13 at 9 35 40 AM" src="https://github.com/user-attachments/assets/7201f24c-acc5-482f-b280-283b65812f9e">

#### [florence](https://huggingface.co/microsoft/Florence-2-large)
tags: `#llm`  
paper: 2311.06242  
date: July 2024  

#### [kosmos-2.5](https://github.com/microsoft/unilm/tree/master/kosmos-2.5)
tags: `#llm`, `#multiModal`  
date: Sep 2023  
> Kosmos-2.5 is a multimodal literate model by Microsoft for machine reading of text-intensive images [^1]

#### [molmo](https://huggingface.co/collections/allenai/molmo-66f379e6fe3b8ef090a8ca19)
live: https://molmo.allenai.org/  

## Relevant Models

#### [StructEqTable Deploy](https://github.com/UniModal4Reasoning/StructEqTable-Deploy)

#### [UniMERNet](https://github.com/opendatalab/UniMERNet)

#### [YOLOv8](https://github.com/ultralytics/ultralytics)

#### [layoutlmv3](https://github.com/microsoft/unilm/tree/master/layoutlmv3)

#### [pdf_postprocessor_t5](https://huggingface.co/vikp/pdf_postprocessor_t5)

#### [unilm](https://github.com/microsoft/unilm)


## Tagxonomy
 - `ocr-free`: OCR-free transformer models mean that that the authors found a way to not do OCR (e.g. Tesseract or something like that) as preliminary steps in their modeling workglow.


## Other ressources

 - [tesseract's tips to improve output quality]https://tesseract-ocr.github.io/tessdoc/ImproveQuality.html
 - [pdfminer.six's converting pdf to text](https://pdfminersix.readthesrc.io/en/latest/topic/converting_pdf_to_text.html)
 - [pypdf's why extraction is hard](https://pypdf.readthesrc.io/en/latest/user/extract-text.html#why-text-extraction-is-hard)
 - [OCR vs text extraction](https://pypdf.readthesrc.io/en/latest/user/extract-text.html#ocr-vs-text-extraction)


## Repo organization

```
├── Makefile                         
├── src
│   ├── data
│   │    ├── courses
│   │    |    └── [fname-convention].pdf
│   │    ├── faculties
│   │    |    └── [fname-convention].pdf
│   │    └── catalog-info
│   │         └── [fname-convention].pdf
│   └── results
│        └── pkg*
│             ├── order
│             ├── ocr
│             └── layout
│                ├── courses
│                  ├── [fname-convention].png
|                  └── results.json
│                ├── faculties
│                  ├── [fname-convention].png
|                  └── results.json
│                └── catalog-info
│                  ├── [fname-convention].png
|                  └── results.json
└── src                             
   └── run-pkg*.py
```

 - `data/`: data organized by content types.
 - `results/`: results organized by package.

```
#results.json minimal example (based on surya)
{
    "1CM_01": [
        {
            "text_lines": [
                {
                    "text": "Courses : Catalogue 2010-11 : University of Vermont"
                },
               ...
            ]
         }
      ],
    ...
}
```

```
#results.json with bbox information (based on surya)
{
    "1CM_01": [
        {
            "text_lines": [
                {
                   "polygon": [
                        [
                            2,
                            4
                        ],
                        [
                            266,
                            4
                        ],
                        [
                            266,
                            20
                        ],
                        [
                            2,
                            20
                        ]
                    ],
                    "confidence": 0.96875,
                    "text": "Courses : Catalogue 2010-11 : University of Vermont",
                    "bbox": [
                        2,
                        4,
                        266,
                        20
                    ]
                },
               ...
            ]
         }
      ],
    ...
}
```

## Adding more PDF types

First, you need to make sure to have `poppler` install to convert pdf to pngs. See [here](https://github.com/UB-Mannheim/zotero-ocr/wiki/Install-pdftoppm) for instructions. Each OCR tool might have more or less involved dependencies as well. See the section of the tool for the dependencies. Now, say we want to add new pdfs for `policies`. It takes the form of adding the relevant step to the `Makefile`.

 - Add the PDFs in a new dir called `src/data/policies`
 - Convert PDF to PNGs in Make
```
convert-policies-dir-pdf-to-png:
	for file in $(POLICIES_DIR)/*.pdf; do \
		pdftoppm "$$file" "$${file%.pdf}" -png; \
	done
```
 - Use the different softwares to extract text data, e.g. minerU (making sure you did `conda activate MinerU` beforehand):
```
mineru-ocr-policies:
	mkdir -p $(MINERU_RES)/policies/ocr
	magic-pdf -p $(POLICIES_DIR) -o $(MINERU_RES)/policies/ocr -m auto
	mkdir -p $(MINERU_RES)/policies/order
	for dir in $(MINERU_RES)/policies/ocr/*; do mv $dir/auto/*layout.pdf $(MINERU_RES)/policies/order; done;
```
 - When adding documents to `order/`, we must make sure to provide PNGs. Then they must be pushed to the github.
 - Finally, we wrangle the data in `wrangle.py` if the output from previous step is not formatted properly. The data app is expecting a single `results.json` in OCR following the aforementionned format.


## Changelog

 - 2024-10-04: adding https://github.com/opendatalab/MinerU, reorganizing the README.

[^1]: To use Kosmo2.5, we had to clone `https://github.com/microsoft/unilm.git` as git submodule. We encapsulate the OCR tool within its own conda environment. You should do the same. It also only run on [Flash Attention 2](https://github.com/Dao-AILab/flash-attention), so we run the code on the VACC's A100s.
