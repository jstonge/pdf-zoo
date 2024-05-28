---
toc: false
---


```js
Plot.plot({
      marks: [
        Plot.image(
          refs.filter(d => select === "all" ? d : d.entryTags.type == select), 
          { 
            y: d => d.entryTags.year+"-"+d.entryTags.month+"-"+d.entryTags.day,  
            x: (d, i) => i % 2 === 0  ? 30 + 3 * 16 * 0.5 : -30 - 3 * 16 * 0.5,
            src: d => d.entryTags.link,
            width: 270
        })
      ]
    })
```


```js

```