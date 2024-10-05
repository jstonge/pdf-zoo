import sys
import pyarrow as pa
import pyarrow.parquet as pq
from pathlib import Path
import json

results_dirs = Path("src/results")

# Dictionary to map library names to extraction types
lib2text = {
    'surya': 'ocr',  # they say ocr, but unclear
    'tesseract': 'ocr',
    'pymupdf': 'text-extraction',
    'textra': 'ocr',
    'mineru': 'ocr'
}

rows = []

# Iterate through all result directories
for lib_res in results_dirs.glob("*"):
    libname = lib_res.name

    for document_type in lib_res.glob("*"):
        
        res_file = document_type / lib2text.get(libname, '') / "results.json"
        
        if not res_file.exists():
            continue

        with open(res_file) as f:
            data = json.load(f)

        for fname, content in data.items():
            for item in content:
                for i, line in enumerate(item.get("text_lines", [])):
                    rows.append({
                        "fname": fname,
                        "text": line["text"],
                        "line_id": i,
                        "libname": libname,
                        "doc_type": document_type.name
                    })

# Convert list of rows to a PyArrow Table
schema = pa.schema([
    ('fname', pa.string()),
    ('text', pa.string()),
    ('line_id', pa.int32()),
    ('libname', pa.string()),
    ('doc_type', pa.string())
])

# Build the PyArrow Table
columns = {key: [] for key in schema.names}
for row in rows:
    for key, value in row.items():
        columns[key].append(value)

table = pa.Table.from_pydict(columns, schema=schema)

# Write the table to a temporary buffer with compression
buf = pa.BufferOutputStream()
pq.write_table(table, buf, compression="snappy")

# Get the buffer as a bytes object
buf_bytes = buf.getvalue().to_pybytes()

# Write the bytes to standard output
sys.stdout.buffer.write(buf_bytes)
