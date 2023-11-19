<script lang="ts">
  import DescLink from '../comp/DescLink.svelte';
  import WrapRange from '../comp/WrapRange.svelte';
  import WrapTextarea from '../comp/WrapTextarea.svelte';
  import {
    rectWidth,
    rectHeight,
    circleR,
    textWidth,
    names,
    adjacent,
    idCntr,
    descTextWidth,
    descCircleR,
    descRectWidth,
    descRectHeight,
    descAdjacent,
    descNames,
    descDownload,
    descEdges,
  } from './service';

  export let svgEl: SVGSVGElement;
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
        desc={$descTextWidth}
      />
    </div>
    <div class="col">
      <WrapRange
        id={idCntr.get()}
        lab="circle radius is"
        step={1}
        bind:value={$circleR}
        desc={$descCircleR}
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
        desc={$descRectWidth}
      />
    </div>
    <div class="col">
      <WrapRange
        id={idCntr.get()}
        lab="rect height is"
        bind:value={$rectHeight}
        max={150}
        desc={$descRectHeight}
      />
    </div>
  </div>
  <div class="row">
    <WrapTextarea
      id={idCntr.get()}
      lab="input adjacent nodes"
      bind:value={adjacentValue}
      desc={$descAdjacent}
    />
  </div>
  <div class="row">
    <WrapTextarea
      id={idCntr.get()}
      lab="input nodes names"
      bind:value={namesValue}
      desc={$descNames}
    />
  </div>
  <!-- pass edges and create adjacent nodes list -->
  <!-- input examples -->
  {#if svgEl}
    <div class="row">
      <div class="col">
        <button
          class="btn btn-primary"
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
        ><DescLink id={$descDownload} className="ms-2" />
      </div>
    </div>
  {/if}
</div>

<style>
  .row {
    margin-top: 1em;
  }
</style>
