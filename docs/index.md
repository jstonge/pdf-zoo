---
toc: false
---

# OCR leaderboard

<div class="warning">This is a prototype. Right now, the text on the right doesn't not follow the reading order shown in the left. I still need to do that. I still need to also add an option to add a contender, so that we can compare two different OCR on the same PDF.</div>

<!-- DOCUMENT LOGIC -->

```js
const select_type = view(Inputs.select(['courses'], {label: "document type" }))
```

```js
// Conditional on document type, we have different filenames
const select = view(Inputs.select(Object.keys(surya_res), {label: "filename", value: Object.keys(surya_res)[0] }))
```

<!-- OCR LOGIC -->

```js
const select_ocr = view(Inputs.select(['surya', 'kosmo-2.5'], {label: "OCR", value: "surya" }))
```

```js
// Conditional on the OCR, different configs will be possible.
// config name should correspond to path, aka OCR / CONFIGS / DOCUMENT_TYPE / *
config_surya = ['reading-order']
config_kosmo = []
```

```js
const select_config = view(
  Inputs.select(select_ocr === 'surya' ? config_surya : config_kosmo, {label: "config" })
  )
```

```js
// Once OCR and Configs are chosen, grab the results
// Remains to be seen if this is the best way to do it.
// I like the format of surya. We should have a universal converter from all other OCR to this one.
// That is, we have a json with keys being the filename (png associated with PDF), then values is a list
// with one of the element being the dictionary containing text by line. For each line, there is metadata
// about bboxing.
const surya_res = FileAttachment(`results/${select_ocr}/${select_config}/${select_type}/results.json`).json();
```

<div class="grid grid-cols-2">
  <div>${
    Plot.plot({
      height: 800,
      x: {axis: null},
      y: {axis: null},
      marks: [
        Plot.frame(),
        Plot.image(data, {y: 0, x: 1, src: "link", width: 600, height: 800})
        ]
      })
  }
  </div>
  <div>${
    Plot.plot({
      height: nb_lines < 50 ? 800 : nb_lines > 150 ? 3500 : 2500,
      y: {type: "point", tickSize: 0},
      marks: [
        Plot.text(
          surya_res[select][0]['text_lines'].map(d=>d.text),
          {
            y: (d, i) => 1 + i, // paragraph number
            lineWidth: 200,
            frameAnchor: "middle",
            fontSize: 13
          }
        )
      ]
    })     
  }
  </div>
</div>


```js
const data = [
  {
    link: `https://raw.githubusercontent.com/jstonge/pdf-zoo/main/docs/results/surya-reading-order/courses/${select}.png`
  }
]
```

```js
surya_res
```

```js
const nb_lines = surya_res[select][0]['text_lines'].map(d=>d.text).length
```