<script lang="ts">
  import DescLink from '../comp/DescLink.svelte';
  import WrapRange from '../comp/WrapRange.svelte';
  import WrapTextarea from '../comp/WrapTextarea.svelte';
  import { makeAdjacent } from './makeAdjacent';
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

  const exs: { edges: [string, string][]; head: string }[] = [
    { edges: [['0', '1']], head: '0' },
    {
      edges: [
        ['0', '1'],
        ['1', '2'],
        ['2', '3'],
        ['2', '4'],
        ['2', '5'],
        ['3', '6'],
        ['4', '7'],
        ['5', '8'],
        ['6', '9'],
        ['6', '10'],
        ['6', '11'],
        ['8', '12'],
        ['8', '13'],
      ],
      head: '0',
    },
    {
      edges: [
        ['1', '4'],
        ['1', '5'],
        ['1', '13'],
        ['5', '8'],
        ['13', '2'],
        ['13', '3'],
        ['3', '6'],
        ['3', '7'],
        ['7', '9'],
        ['7', '10'],
        ['7', '11'],
        ['7', '12'],
        ['7', '0'],
      ],
      head: '13',
    },
  ];

  export let svgEl: SVGSVGElement;
  let adjacentValue = stringOfAdjacent($adjacent);
  let namesValue = $names.join('\n');
  let edgesValue = '';
  let edgesHead = '';
  setEx(exs[1]);
  $: $adjacent = parseAdjacent(adjacentValue);
  $: $names = namesValue.split('\n');

  $: (() => {
    let ok = true;
    const mp: [string, string][] = edgesValue.split('\n').map((item) => {
      // read one space at left
      // empty string is ok
      // but one may want to edit it through adjacent and names
      const p = item.indexOf(' ');
      if (p < 0) {
        ok = false;
        return ['', ''];
      } else {
        return [item.slice(0, p), item.slice(p + 1)];
      }
    });
    if (ok) {
      let made;
      try {
        made = makeAdjacent(mp, edgesHead);
      } catch (e) {
        let err = e as Error;
        console.log(err.message);
        return;
      }
      $adjacent = made.adjacent;
      $names = made.names;
    } else {
      // TODO: inform invalid
      console.log('edge pair must contain one space');
    }
  })();

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
  function setEx(ex: { edges: [string, string][]; head: string }) {
    edgesValue = ex.edges.map((item) => item.join(' ')).join('\n');
    edgesHead = ex.head;
  }
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
    <div class="col-8">
      <WrapTextarea
        id={idCntr.get()}
        lab="input edge pair"
        bind:value={edgesValue}
        desc={$descEdges}
      />
    </div>
    <div class="col-4">
      <WrapTextarea
        id={idCntr.get()}
        lab="input head"
        bind:value={edgesHead}
        input={true}
        desc={$descEdges}
      />
    </div>
  </div>
  <div class="row">
    <button
      class="btn btn-dark m-auto"
      on:click|preventDefault={() => {
        adjacentValue = stringOfAdjacent($adjacent);
        namesValue = $names.join('\n');
      }}>edge pair -&gt; adjacent nodes and names</button
    >
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
  <div class="row">
    {#each exs as ex, i}
      <button
        class="btn btn-secondary me-2"
        on:click|preventDefault={() => {
          setEx(ex);
        }}>example {i}</button
      >
    {/each}
  </div>
  {#if svgEl}
    <div class="row">
      <div class="col">
        <button
          class="btn btn-primary"
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
  button {
    width: fit-content;
  }
</style>
