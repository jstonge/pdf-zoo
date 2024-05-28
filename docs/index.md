---
toc: false
---

```js
const select_type = view(Inputs.select(['courses'], {label: "document type" }))
```

```js
const select = view(Inputs.select(Object.keys(surya_res), {label: "filename", value: Object.keys(surya_res)[0] }))

```
<!-- 
```js
const surya_res = FileAttachment("results/surya/courses/results.json").json();
``` -->

```js
const surya_res = FileAttachment("results/surya-reading-order/courses/results.json").json();
```

```js
const nb_lines = surya_res[select][0]['text_lines'].map(d=>d.text).length
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
    link: `https://raw.githubusercontent.com/jstonge/pdf-zoo/main/docs/assets/${select}.png`
  }
]
```