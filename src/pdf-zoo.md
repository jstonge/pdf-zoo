---
toc: false
sql:
  results: combined_results.parquet
---


# Softwares for text extraction from PDFs leaderboard

<div class="warning">This is a prototype.</div>


```js
// Select document class
const select_type = view(Inputs.select(['courses', 'faculties', 'policies'], {value: 'courses', label: "document type" }))
```

```sql id=[...raw_db]
SELECT * FROM results WHERE doc_type = ${select_type}
```

```js
// Select software tool
const select_libname = view(Inputs.select(['surya', 'pymupdf', 'mineru'], {label: "libname", value: "surya" }))
```


```js
const all_fnames = new Set(raw_db.map(d=>d.fname))
```
```js
// Conditional on document type, we have different filenames
const select_fname = view(Inputs.select(all_fnames, {value: all_fnames[0], label: "filename" }))
```

```sql id=[...filtered_data]
SELECT * 
FROM results
WHERE fname = ${select_fname} AND libname = ${select_libname} AND doc_type = ${select_type}
```

```js
// CONFIG == different modes of the software. Maybe there is a better name.
// see below for more.
const select_config = view(Inputs.select(config, {value: 'order', label: "config"}));
```

<div class="grid grid-cols-2">
  <div>${
    Plot.plot({
      height: 800,
      x: {axis: null},
      y: {axis: null},
      marks: [
        Plot.frame(),
        Plot.image(pngdata, {y: 0, x: 1, src: "link", width: 600, height: 800})
        ]
      })
  }
  </div>
  <div>
  ${html`<pre>${filtered_data.map(d => d.text).join('\n')}</pre>`}
  </div>
</div>

```js
const pngdata = [
  {
    link: select_config === null ? 
      `https://raw.githubusercontent.com/jstonge/pdf-zoo/main/src/assets/${select_fname}.png` : 
      `https://raw.githubusercontent.com/jstonge/pdf-zoo/main/src/results/${select_libname}/${select_type}/${select_config}/${select_fname}.png`
  }
]
```

```sql
SELECT * FROM results 
WHERE doc_type = ${select_type}
```

```js
filtered_data.map(d => d.text)
```
---

## File naming conventions

 - `column-layout ([0-3]C)`: 1col, 2col, 3col, TOC (table of content; 0)
 - `hand-annotated (H)`: the document is hand annotated
 - `fake (F)`: simulacra of parent category
 - `noisy (N)`: misc noise
 - `tinted (T)`: page is yellowish or pale
 - `dual pages (D)`
 - `modern (M)`: pdf of 'modern' website
 - `title/angle (A)`: tilted OCR

For instance

```
1CHN_01.pdf # 1 column-layout, with some hand-annotations, and with some noise (here pixelated).
0CAT_01.pdf # Table-of-content style, that is tilted and yellowish 
```

```js
// Conditional on the library, different configs will be possible.
// config name should correspond to path, aka OCR / CONFIGS / DOCUMENT_TYPE / *
const config_surya = ['order', 'layout']
const config_kosmo = []
const config_pymupdf = []
const config_mineru = ['order']
```

```js
let config;

if (select_libname === 'surya') {
  config = config_surya;
} else if (select_libname === 'kosmo') {
  config = config_kosmo;
} else if (select_libname === 'pymupdf') {
  config = config_pymupdf;
} else if (select_libname === 'mineru') {
  config = config_mineru;
} else {
  config = []; // default config if no match
}

```