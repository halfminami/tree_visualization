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

  $: treeObj = window.treeGrid.main()(ins);
  $: nodePoss = treeObj.vertices;
  $: edgeIndexs = treeObj.edges;
  $: maxX = Math.max(...nodePoss.map((item) => item[0]));
  $: maxY = Math.max(...nodePoss.map((item) => item[1]));

  $: console.log(treeObj);
  function getCenter(pos: [number, number]) {
    return [(pos[0] + 0.5) * $rectWidth, (pos[1] + 0.5) * $rectHeight];
  }
</script>

<svg
  viewBox="0 0 {(maxX + 1) * $rectWidth} {(maxY + 1) * $rectHeight}"
  width={(maxX + 1) * $rectWidth}
  height={(maxY + 1) * $rectHeight}
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
      stroke-width: 2;
    }
  </style>
  {#each edgeIndexs as parentChild}
    {@const parentPos = nodePoss[parentChild[0]]}
    {@const childPos = nodePoss[parentChild[1]]}

    {@const parentP = getCenter(parentPos)}
    {@const childP = getCenter(childPos)}

    <path
      class="edge"
      d="M{parentP[0]} {parentP[1]}, L{childP[0]} {childP[1]}"
    />
  {/each}
  {#each nodePoss as pos}
    {@const p = getCenter(pos)}
    <circle class="vertice" cx={p[0]} cy={p[1]} r={$circleR} />
  {/each}
</svg>

<style>
</style>
