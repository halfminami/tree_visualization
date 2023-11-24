<script lang="ts">
  import DescLink from '../comp/DescLink.svelte';
  import WrapRange from '../comp/WrapRange.svelte';
  import WrapTextarea from '../comp/WrapTextarea.svelte';
  import { makeAdjacent, examples } from './makeAdjacent';
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
  let edgesValue = '';
  let edgesHead = '';
  setEx(examples[1]);
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

  const acOtherId = idCntr.get();
  const acOtherParId = idCntr.get();
  const acNodesId = idCntr.get();
  const acNodesParId = idCntr.get();

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
    <div class="col-8">
      <WrapTextarea
        id={idCntr.get()}
        lab="input node pairs of edges"
        bind:value={edgesValue}
        desc={$descEdges}
      />
    </div>
    <div class="col-4">
      <WrapTextarea
        id={idCntr.get()}
        lab="input a top node name"
        bind:value={edgesHead}
        input={true}
        desc={$descEdges}
      />
    </div>
  </div>
  <div class="accordion">
    <div class="accordion-item">
      <div class="accordion-header">
        <button
          class="accordion-button collapsed"
          type="button"
          id={acNodesParId}
          data-bs-toggle="collapse"
          data-bs-target="#{acNodesId}"
          aria-expanded="false"
          aria-controls={acNodesId}
        >
          Nodes' Settings
        </button>
      </div>
      <div
        class="accordion-collapse collapse"
        id={acNodesId}
        data-bs-parent="#{acNodesParId}"
      >
        <div class="accordion-body">
          <div class="row">
            <button
              class="btn btn-dark m-auto"
              on:click|preventDefault={() => {
                adjacentValue = stringOfAdjacent($adjacent);
                namesValue = $names.join('\n');
              }}>edges -&gt; adjacent nodes and names</button
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
              lab="input nodes' names"
              bind:value={namesValue}
              desc={$descNames}
            />
          </div>
        </div>
      </div>
    </div>
    <div class="accordion-item">
      <h3 class="accordion-header">
        <button
          class="accordion-button collapsed"
          type="button"
          id={acOtherParId}
          data-bs-toggle="collapse"
          data-bs-target="#{acOtherId}"
          aria-expanded="false"
          aria-controls={acOtherId}>Other Settings</button
        >
      </h3>
      <div
        class="accordion-collapse collapse"
        id={acOtherId}
        data-bs-parent="#{acOtherParId}"
      >
        <div class="accordion-body">
          <div class="row">
            <div class="col">
              <WrapRange
                id={idCntr.get()}
                lab="text width:"
                step={1}
                bind:value={$textWidth}
                desc={$descTextWidth}
              />
            </div>
            <div class="col">
              <WrapRange
                id={idCntr.get()}
                lab="circle radius:"
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
                lab="rect width:"
                bind:value={$rectWidth}
                max={150}
                desc={$descRectWidth}
              />
            </div>
            <div class="col">
              <WrapRange
                id={idCntr.get()}
                lab="rect height:"
                bind:value={$rectHeight}
                max={150}
                desc={$descRectHeight}
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="row">
    {#if examples.length}
      <span style="width:fit-content">set sample input:</span>
    {/if}
    {#each examples as ex, i}
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
  .row,
  .accordion {
    margin-top: 1em;
  }
  button:not([class~='accordion-button']) {
    width: fit-content;
  }
</style>
