# PDF zoo

Each entry looks like
```
### [Library Name](https://github.com/username/repo-name)
tags: `#tag1`, `#tag2`, `#tag3`  
deps: [dependency1](#dependency1), [dependency2](#dependency2)  
inst: `organization/company`  
paper: https://arxiv.org/abs/paper-id  
date: Month Year  
live: https://demo-url.com/  
models: [model_name](#model_name)  
> Brief description of what the tool does and its key capabilities or strengths.

<img src="image-url" alt="schema workflow" width="600">
```

where dependencies are other libraries in the documents and tags can be found in the TAGxonomy below.

<details><summary>TAGxonomy!</summary>
	
## Primary Category Tags
- `#trad` - Traditional/classic OCR approaches
- `#model-based` - Modern neural network-based OCR
- `#llm` - Large language model-based OCR
- `#toolkit` - Multi-purpose libraries with various features
- `#ocr-free` - Transformer models that bypass traditional OCR steps

## Functionality Tags
- `#readingOrder` - Tools that determine text reading sequence
- `#layoutAnalysis` - Document layout understanding and analysis
- `#pdf2markdown` - PDF to markdown conversion
- `#layout` - General layout processing capabilities
- `#multiModal` - Handles multiple input types (text, images, etc.)
- `#PDF-wrangling` - PDF manipulation and processing
- `#tableExtraction` - Specialized table detection and extraction
- `#formulaOCR` - Mathematical formula and equation recognition
- `#handwriting` - Handwritten text recognition
- `#multilingual` - Multi-language support
- `#structuring` - Converting unstructured text to structured data
- `#gpu` - GPU acceleration support
- `addTextLayer` - Adds searchable text layers to PDFs (note: no # symbol)
</details>

## Traditional/Classic OCR Engines

The original OCR approach using rule-based algorithms and pattern matching.

### [tesseract](https://github.com/tesseract-ocr/tesseract) 
tags: `#trad`
> Mother of all OCR tools. It was there when the world wide web was invented. More recently runs LSTM under the hood.

## Modern Model-Based OCR

OCR powered by deep learning neural networks, trained on large datasets.

### [easyOCR](https://github.com/JaidedAI/EasyOCR)
tags: `#model-based`
> Ready-to-use OCR with 80+ language support and minimal setup required.

<img src="https://github.com/JaidedAI/EasyOCR/raw/master/examples/easyocr_framework.jpeg" alt="easyOCR" width="600"> 

### [textra](https://github.com/freedmand/textra)
tags: `#model-based`
> CLI tool using Apple's APIs for OCR on images, PDFs, and audio files (macOS only).

### [PaddleOCR](https://github.com/PaddlePaddle/PaddleOCR)
tags: `#model-based`, `#toolkit`  
deps: [PaddlePaddle](#PaddlePaddle)
> Comprehensive multilingual OCR toolkit with training capabilities and mobile deployment support.

## Modern LLM-Based OCR

Large language models that can "read" images and understand context.

### [GOT-ocr2](https://huggingface.co/stepfun-ai/GOT-OCR2_0)
tags: `#llm`   
paper: 2405.14295  
date: Sep 2024  
> Large language model specifically designed for optical character recognition tasks.

### [florence](https://huggingface.co/microsoft/Florence-2-large)
tags: `#llm`  
paper: 2311.06242  
date: Feb 2025 
> Microsoft's multimodal LLM capable of OCR along with other vision-language tasks.

### [kosmos-2.5](https://github.com/microsoft/unilm/tree/master/kosmos-2.5)
tags: `#llm`, `#multiModal`  
date: Sep 2023  
> Microsoft's multimodal model specialized for reading text-intensive images.

### [molmo](https://huggingface.co/collections/allenai/molmo-66f379e6fe3b8ef090a8ca19)
live: https://molmo.allenai.org/  
> AllenAI's multimodal model with OCR capabilities.

### [olmocr](https://github.com/allenai/olmocr)
tags: `#pdf2markdown`, `#llm`    
deps: poppler-utils, [Qen2-VL-7B-Instruct](#Qen2-VL-7B-Instruct)
date: Feb 2025  
live: https://olmocr.allenai.org/  
paper: https://arxiv.org/abs/2502.18443
> LLM-based approach for converting PDFs to markdown with OCR capabilities.

OLMOcr provides a cool innovation note in their technical report, called "document anchoring":

> Document anchoring extracts coordinates of salient elements in each page (e.g., text blocks and images) and injects them alongside raw text extracted from the PDF binary file. [...]
>
>Document anchoring processes PDF document pages via the PyPDF library to extract a representation of the page’s structure from the underlying PDF. All of the text blocks and images in the page are extracted, including position information. Starting with the most relevant text blocks and images, these are sampled and added to the prompt of the VLM, up to a defined maximum character limit. This extra information is then available to the model when processing the document.

<img width="700" alt="image" src="https://github.com/user-attachments/assets/bd07424c-a989-4e5d-b8b8-bba3a97f86cf" />


## Advanced OCR with Layout Analysis

### [surya](https://github.com/VikParuchuri/surya) 
tags: `#model-based`, `#readingOrder`, `#layoutAnalysis`  
deps: [Donut](#donut)
> Modern OCR with advanced layout analysis and reading order detection.

### [donut](https://github.com/clovaai/donut/)
tags: `#ocr-free`
> Document understanding transformer that processes documents without traditional OCR preprocessing.

## OCR-Enabled Toolkits

Libraries that include OCR as one feature among many document processing tools.

### [OCRmyPDF](https://github.com/ocrmypdf/OCRmyPDF)
tags: `addTextLayer`
> Adds searchable OCR text layers to scanned PDFs using tesseract or other engines.

### [PyMuPDF](https://github.com/pymupdf/PyMuPDF)
tags: `#toolkit`  
deps: [tesseract](#tesseract) (OCR)
> PDF manipulation library with optional OCR capabilities via tesseract.

### [docling](https://github.com/DS4SD/docling)
tags: `#layout`   
paper: https://arxiv.org/pdf/2408.09869  
deps:  [easyocr](#easyocr) (ocr, default), [tesseract](#tesseract) (ocr, optionnal), [pypdfium2](#pypdfium2)  
<img width="699" alt="Screenshot 2024-10-13 at 9 35 40 AM" src="https://github.com/user-attachments/assets/7201f24c-acc5-482f-b280-283b65812f9e">
> Document layout analysis toolkit with integrated OCR options.

### [spacylayout](https://github.com/explosion/spacy-layout)
tags: `#layout`, `#llm`   
paper: https://explosion.ai/blog/pdfs-nlp-structured-data  
deps:  [docling](#docling) (ocr, default)  
date: Dec 2024  
> SpaCy extension for PDF layout analysis with OCR integration.

## PDF-to-Markdown with OCR

### [marker](https://github.com/VikParuchuri/marker)
tags: `#pdf2markdown`  
deps: [surya](#surya) (OCR), [texify](#texify) (clean and format each block)  
models: [pdf_postprocessor_t5](#pdf_postprocessor_t5)
> High-accuracy PDF to markdown conversion using advanced OCR and post-processing.

### [nougat](https://github.com/facebookresearch/nougat)
tags: `#pdf2markdown`  
deps: [donut](#donut)
> Facebook Research's neural OCR model for academic document processing.

### [MinerU](https://github.com/opendatalab/MinerU)
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
> Comprehensive PDF processing pipeline with OCR, layout analysis, and markdown conversion.

## Text Extraction (Not OCR)

These tools extract text already embedded in PDFs rather than performing OCR on images:

### [pdfminer.six](https://github.com/pdfminer/pdfminer.six)
tags: `#trad` 
> Python3 fork of pdfminer for extracting embedded text from PDFs using layout information.

### [pdfplumber](https://github.com/jsvine/pdfplumber)
tags: `#toolkit`  
deps: [pdfminer.six](#pdfminer.six)
> Detailed PDF analysis for characters, lines, and tables using embedded text.

### [pypdf2](https://github.com/py-pdf/pypdf)
tags: `#toolkit`  
> Pure Python library for PDF manipulation (splitting, merging, text extraction).

### [pypdfium2](https://github.com/pypdfium2-team/pypdfium2)
tags: `#PDF-wrangling`
inst: `google`  
> Python binding to Google's PDFium for PDF rendering and text extraction.

### [pdfium](https://pdfium.googlesource.com/pdfium/)
tags: `#PDF-wrangling`
> Google's PDF library for rendering, inspection, and dynamic document creation.

### [PDF Extract Kit](https://github.com/opendatalab/PDF-Extract-Kit)
tags: `#toolkit`, `#model-based`
> Comprehensive PDF processing toolkit with both text extraction and OCR capabilities.

## Structuring unstructured text using LLMs

Tools that take raw or unstructured text and convert it into structured formats like JSON, tables, or organized data.

### [NuExtract](https://huggingface.co/numind/NuExtract)
tags: `#llms`  
> NuExtract is a version of phi-3-mini, fine-tuned on a private high-quality synthetic dataset for information extraction. To use the model, provide an input text (less than 2000 tokens) and a JSON template describing the information you need to extract.

### [langextract](https://github.com/google/langextract)
tags: `#llms`  
>  A Python library for extracting structured information from unstructured text using LLMs with precise source grounding and interactive visualization. 

## Relevant Models

### [PaddlePaddle](https://github.com/PaddlePaddle/Paddle)
> Practical ultra lightweight OCR system, support 80+ languages recognition, provide data annotation and synthesis tools, support training and deployment among server, mobile, embedded and IoT devices

### [StructEqTable Deploy](https://github.com/UniModal4Reasoning/StructEqTable-Deploy)

### [UniMERNet](https://github.com/opendatalab/UniMERNet)

### [YOLOv8](https://github.com/ultralytics/ultralytics)

### [layoutlmv3](https://github.com/microsoft/unilm/tree/master/layoutlmv3)

### [pdf_postprocessor_t5](https://huggingface.co/vikp/pdf_postprocessor_t5)

### [unilm](https://github.com/microsoft/unilm)

### [Qen2-VL-7B-Instruct](https://huggingface.co/Qwen/Qwen2-VL-7B-Instruct)

## Other ressources

 - [tesseract's tips to improve output quality]https://tesseract-ocr.github.io/tessdoc/ImproveQuality.html
 - [pdfminer.six's converting pdf to text](https://pdfminersix.readthesrc.io/en/latest/topic/converting_pdf_to_text.html)
 - [pypdf's why extraction is hard](https://pypdf.readthesrc.io/en/latest/user/extract-text.html#why-text-extraction-is-hard)
 - [OCR vs text extraction](https://pypdf.readthesrc.io/en/latest/user/extract-text.html#ocr-vs-text-extraction)

## Repo organization

```
├── Makefile                         
├── src
│   ├── data
│   │    ├── courses
│   │    |    └── [fname-convention].pdf
│   │    ├── faculties
│   │    |    └── [fname-convention].pdf
│   │    └── catalog-info
│   │         └── [fname-convention].pdf
│   └── results
│        └── pkg*
│             ├── order
│             ├── ocr
│             └── layout
│                ├── courses
│                  ├── [fname-convention].png
|                  └── results.json
│                ├── faculties
│                  ├── [fname-convention].png
|                  └── results.json
│                └── catalog-info
│                  ├── [fname-convention].png
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
