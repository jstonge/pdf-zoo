# script to run pymuydf to extract text from pdfs

import pymupdf
import sys
from pathlib import Path
import json

def ocr_pdf(pdf_dir, output_dir):
    # ocr_output_dir = output_dir / "ocr"
    # ocr_output_dir.mkdir(exist_ok=True)
    
    out = {}
    for pdf_path in pdf_dir.glob("*.pdf"):
        pdf = pymupdf.open(pdf_path)
        
        text_lines = []
        for block in pdf[0].get_text("blocks"):
            text_lines.append({
                'bbox': block[:4], #x0, y0, x1, y1,
                'text': block[4],
                'block_no': block[5],
                'block_type': block[6],
            })
            
        out[pdf_path.stem] = [
            {"text_lines": text_lines}
        ]
        
        pdf.close()

    with open(output_dir / "results.json", "w") as f:
        json.dump(out, f, indent=2)
    
if __name__ == "__main__":
    pdf_dir = Path(sys.argv[1])
    output_dir = Path(sys.argv[2])
    ocr_pdf(pdf_dir, output_dir)