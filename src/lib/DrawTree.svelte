<script lang="ts">
  import {
    rectWidth,
    rectHeight,
    circleR,
    textWidth,
    names,
    adjacent,
    statusLog,
  } from './service';

  $: treeObj = (() => {
    let r: { vertices: [number, number][]; edges: [number, number][] };
    try {
      r = window.treeGrid.main()($adjacent);
      $statusLog = 'Done!';
    } catch (e) {
      r = { vertices: [[0, 0]], edges: [] };
      $statusLog = 'The tree of adjacent nodes may be invalid';
    }
    return r;
  })();
  $: nodePoss = treeObj.vertices;
  $: edgeIndexs = treeObj.edges;
  $: maxX = Math.max(...nodePoss.map((item) => item[0]));
  $: maxY = Math.max(...nodePoss.map((item) => item[1]));

  function getCenter(pos: [number, number], w: number, h: number) {
    return [(pos[0] + 0.5) * w, (pos[1] + 0.5) * h];
  }

  export let self: SVGSVGElement;
  export let labelledBy: string;
</script>

<svg
  viewBox="0 0 {(maxX + 1) * $rectWidth} {(maxY + 1) * $rectHeight}"
  width={(maxX + 1) * $rectWidth}
  height={(maxY + 1) * $rectHeight}
  bind:this={self}
  aria-labelledby={labelledBy}
>
  <style>
    .vertice {
      fill: white;
      stroke: black;
      stroke-width: 2;
    }
    .edge {
      fill: transparent;
      stroke: black;
      stroke-width: 3;
    }
    .text {
      font-family: system-ui, sans-serif;
    }
  </style>
  {#each edgeIndexs as parentChild}
    {@const parentPos = nodePoss[parentChild[0]]}
    {@const childPos = nodePoss[parentChild[1]]}

    {@const parentP = getCenter(parentPos, $rectWidth, $rectHeight)}
    {@const childP = getCenter(childPos, $rectWidth, $rectHeight)}

    <path
      class="edge"
      d="M{parentP[0]} {parentP[1]} L{childP[0]} {childP[1]}"
    />
  {/each}
  {#each nodePoss as pos}
    {@const p = getCenter(pos, $rectWidth, $rectHeight)}
    <circle class="vertice" cx={p[0]} cy={p[1]} r={$circleR} />
  {/each}
  {#each $names as s, i}
    {@const pos = nodePoss[i]}
    {#if pos}
      {@const p = getCenter(pos, $rectWidth, $rectHeight)}
      <text
        class="text"
        x={p[0]}
        y={p[1]}
        dx={(-$circleR * s.length) / 3}
        dy={$circleR / 3}
        style="font-size:{$textWidth}px">{s}</text
      >
    {/if}
  {/each}
</svg>
