<script lang="ts">
  import {
    rectWidth,
    rectHeight,
    circleR,
    textWidth,
    names,
  } from './lib/service';

  // const ins = [
  //   [1],
  //   [2],
  //   [3, 4, 5],
  //   [6],
  //   [7],
  //   [8],
  //   [9, 10, 11],
  //   [],
  //   [12, 13],
  //   [],
  //   [],
  //   [],
  //   [],
  //   [],
  // ];
  const ins = [
    [],
    [4, 5],
    [],
    [6, 7],
    [],
    [8],
    [],
    [9, 10, 11, 12, 0],
    [],
    [],
    [],
    [],
    [],
    [1, 2, 3],
  ];

  $: nodePoss = window.treeGrid.main()(ins).vertices;
  $: maxX = Math.max(...nodePoss.map((item) => item[0]));
  $: maxY = Math.max(...nodePoss.map((item) => item[1]));
</script>

<svg
  viewBox="0 0 {(maxX + 1) * $rectWidth} {(maxY + 1) * $rectHeight}"
  width={(maxX + 1) * $rectWidth}
  height={(maxY + 1) * $rectHeight}
>
  <style>
  </style>
  {#each nodePoss as pos}
    <circle
      class="vertice"
      cx={(pos[0] + 0.5) * $rectWidth}
      cy={(pos[1] + 0.5) * $rectHeight}
      r={$circleR}
    />
  {/each}
</svg>

<style>
  .vertice {
    fill: white;
    stroke: black;
    stroke-width: 2;
  }
</style>
