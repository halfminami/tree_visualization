<script lang="ts">
  import {
    rectWidth,
    rectHeight,
    circleR,
    textWidth,
    names,
    adjacent,
  } from './service';

  export let svgEl: SVGSVGElement | null = null;
  let adjacentValue = stringOfAdjacent($adjacent);
  let namesValue = $names.join('\n');
  $: $adjacent = parseAdjacent(adjacentValue);
  $: $names = namesValue.split('\n');

  function parseAdjacent(str: string) {
    return str.split('\n').map((item) => {
      const li = item.split(' ');
      if (li[0].length) {
        return li.map((d) => parseInt(d));
      } else {
        return [];
      }
    });
  }
  function stringOfAdjacent(l: number[][]) {
    return l.map((item) => item.join(' ')).join('\n');
  }

  const svgPre = (viewBox: string) =>
    `<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="${viewBox}">`;
</script>

<label
  >text width is <output>{$textWidth}px</output><input
    type="range"
    bind:value={$textWidth}
    min="1"
    max="100"
  /></label
>
<label
  >rect width is <output>{$rectWidth}</output><input
    type="range"
    bind:value={$rectWidth}
    min="1"
    max="150"
  /></label
>
<label
  >rect height is <output>{$rectHeight}</output><input
    type="range"
    bind:value={$rectHeight}
    min="1"
    max="150"
  /></label
>
<label
  >circle radius is <output>{$circleR}</output><input
    type="range"
    bind:value={$circleR}
    min="1"
    max="100"
  /></label
>
<label>input adjacent nodes<textarea bind:value={adjacentValue} /></label>
<label>input nodes names<textarea bind:value={namesValue} /></label>
<!-- pass edges and create adjacent nodes list -->
{#if svgEl}
  <button
    on:click={() => {
      console.log(
        svgEl &&
          new XMLSerializer()
            .serializeToString(svgEl)
            .replace(
              /\<svg.*?\>/,
              svgPre(
                `${svgEl.viewBox.baseVal.x} ${svgEl.viewBox.baseVal.y} ${svgEl.viewBox.baseVal.width} ${svgEl.viewBox.baseVal.height}`
              )
            )
      );
      if (svgEl) {
        const bl = new Blob(
          [
            new XMLSerializer()
              .serializeToString(svgEl)
              .replace(
                /\<svg.*?\>/,
                svgPre(
                  `${svgEl.viewBox.baseVal.x} ${svgEl.viewBox.baseVal.y} ${svgEl.viewBox.baseVal.width} ${svgEl.viewBox.baseVal.height}`
                )
              ),
          ],
          { type: 'image/svg+xml;charset=utf-8' }
        );
        const url = URL.createObjectURL(bl);

        const a = document.createElement('a');
        a.href = url;
        a.download = 'download.svg';
        a.click();
        a.remove();
      }
    }}>click me</button
  >
{/if}
