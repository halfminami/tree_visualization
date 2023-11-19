<script lang="ts">
  import WrapRange from './WrapRange.svelte';
  import {
    rectWidth,
    rectHeight,
    circleR,
    textWidth,
    names,
    adjacent,
    idCntr,
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
      <WrapRange
        id={idCntr.get()}
        lab="text width is"
        step={1}
        bind:value={$textWidth}
      />
    </div>
    <div class="col">
      <WrapRange
        id={idCntr.get()}
        lab="circle radius is"
        step={1}
        bind:value={$circleR}
      />
    </div>
  </div>
  <div class="row">
    <div class="col">
      <WrapRange
        id={idCntr.get()}
        lab="rect width is"
        bind:value={$rectWidth}
        max={150}
      />
    </div>
    <div class="col">
      <WrapRange
        id={idCntr.get()}
        lab="rect height is"
        bind:value={$rectHeight}
        max={150}
      />
    </div>
  </div>
  <div class="row">
    {#if adjacentValue != undefined}
      {@const id = idCntr.get()}
      <label for={id} class="form-label">input adjacent nodes</label>
      <textarea {id} bind:value={adjacentValue} class="form-control" />
    {/if}
  </div>
  <div class="row">
    {#if namesValue != undefined}
      {@const id = idCntr.get()}
      <label for={id} class="form-label">input nodes names</label>
      <textarea {id} bind:value={namesValue} class="form-control" />
    {/if}
  </div>
  <!-- pass edges and create adjacent nodes list -->
  <!-- input examples -->
  {#if svgEl}
    <div class="row">
      <button
        class="btn btn-primary mx-2"
        style="width:fit-content"
        on:click|preventDefault={() => {
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
