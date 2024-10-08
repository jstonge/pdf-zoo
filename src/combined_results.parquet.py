import pandas as pd
import sys
import pyarrow as pa
import pyarrow.parquet as pq
from pathlib import Path
import json

results_dirs = Path("src/results")

# Combined all results into a single dataframe

dfs = []

lib2text = {
    'surya': 'ocr', # they say ocr, but unclear
    'tesseract': 'ocr', 
    'pymupdf': 'text-extraction',
    'textra': 'ocr',
    'mineru': 'ocr'
}

for lib_res in results_dirs.glob("*"):
    libname = lib_res.name

    # if libname == 'surya':
    #     break
 
    for document_type in lib_res.glob("*"):
        
        res_file = document_type / lib2text[libname] / "results.json"
        
        if res_file.exists() == False:
            break

        with open(res_file) as f:
            data = json.load(f)
            
        rows = []
        for fname, content in data.items():
            for item in content:
                for i, line in enumerate(item.get("text_lines", [])):
                    rows.append({
                        "fname": fname, 
                        "text": line["text"], 
                        "line_id": i
                        })

        df = pd.DataFrame(rows)
        df["libname"] =  libname
        df["doc_type"] =  document_type.name
        dfs.append(df)

df_long = pd.concat(dfs)

# Write DataFrame to a temporary file-like object
buf = pa.BufferOutputStream()
table = pa.Table.from_pandas(df_long)
pq.write_table(table, buf, compression="snappy")

# Get the buffer as a bytes object
buf_bytes = buf.getvalue().to_pybytes()

# Write the bytes to standard output
sys.stdout.buffer.write(buf_bytes)