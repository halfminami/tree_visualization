<script lang="ts">
  import Controls from './lib/Controls.svelte';
  import DrawTree from './lib/DrawTree.svelte';
  import { adjacent, names } from './lib/service';

  const ins = [
    [1],
    [2],
    [3, 4, 5],
    [6],
    [7],
    [8],
    [9, 10, 11],
    [],
    [12, 13],
    [],
    [],
    [],
    [],
    [],
  ];
  // const ins = [
  //   [],
  //   [4, 5],
  //   [],
  //   [6, 7],
  //   [],
  //   [8],
  //   [],
  //   [9, 10, 11, 12, 0],
  //   [],
  //   [],
  //   [],
  //   [],
  //   [],
  //   [1, 2, 3],
  // ];
  const namesStr = Array(ins.length)
    .fill(0)
    .map((_, i) => i.toString());

  adjacent.set(ins);
  names.set(namesStr);
  let svgEl: SVGSVGElement;
  $: console.log(svgEl);
</script>

<main>
  <section><DrawTree bind:self={svgEl} /></section>
  <section><Controls bind:svgEl /></section>
</main>
