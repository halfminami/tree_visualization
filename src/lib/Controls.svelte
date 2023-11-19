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

<div class="container-fluid">
  <div class="row">
    <div class="col">
      <label
        >text width is <output>{$textWidth}px</output><input
          type="range"
          bind:value={$textWidth}
          min="1"
          max="100"
        /></label
      >
    </div>
    <div class="col">
      <label
        >rect width is <output>{$rectWidth}</output><input
          type="range"
          bind:value={$rectWidth}
          min="1"
          max="150"
        /></label
      >
    </div>
  </div>
  <div class="row">
    <div class="col">
      <label
        >rect height is <output>{$rectHeight}</output><input
          type="range"
          bind:value={$rectHeight}
          min="1"
          max="150"
        /></label
      >
    </div>
    <div class="col">
      <label
        >circle radius is <output>{$circleR}</output><input
          type="range"
          bind:value={$circleR}
          min="1"
          max="100"
        /></label
      >
    </div>
  </div>
  <div class="row">
    <label
      >input adjacent nodes<textarea
        bind:value={adjacentValue}
        class="form-control"
      /></label
    >
  </div>
  <div class="row">
    <label
      >input nodes names<textarea
        bind:value={namesValue}
        class="form-control"
      /></label
    >
  </div>
  <!-- pass edges and create adjacent nodes list -->
  {#if svgEl}
    <div class="row">
      <button
        class="btn btn-primary mx-2"
        style="width:fit-content"
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
        }}>download svg</button
      >
    </div>
  {/if}
</div>

<style>
  .row {
    margin-top: 1em;
  }
</style>
