<script lang="ts">
  import DescLink from './comp/DescLink.svelte';
  import ResizableHeight from './comp/ResizableHeight.svelte';
  import Controls from './lib/Controls.svelte';
  import Description from './lib/Description.svelte';
  import DrawTree from './lib/DrawTree.svelte';
  import { descSvg, idCntr } from './lib/service';

  const formId = idCntr.get();
  const headingId = idCntr.get();

  let resizeHeight: number | undefined;
  $: console.log(resizeHeight);

  let svgEl: SVGSVGElement;
</script>

<header class="navbar bg-body-tertiary shadow-sm">
  <div class="container-fluid">
    <span class="navbar-brand" id={headingId}>Tree SVG</span>
  </div>
</header>

<main class="container my-5">
  <section>
    <h1>Draw Tree with SVG <DescLink id={$descSvg} /></h1>
    <ResizableHeight class="m-auto my-3" bind:height={resizeHeight}>
      <div
        class="svgwrap"
        style="height:{resizeHeight == undefined
          ? '50svh'
          : `${resizeHeight}px`};"
      >
        <output form={formId} class="svg m-auto d-block">
          <DrawTree bind:self={svgEl} labelledBy={headingId} />
        </output>
      </div>
    </ResizableHeight>
  </section>
  <section>
    <h1>Edit the Tree</h1>
    <form id={formId}>
      <Controls bind:svgEl />
    </form>
  </section>
</main>

<aside>
  <section class="container my-5">
    <h1>Description</h1>
    <Description />
  </section>
</aside>

<footer class="navbar bg-primary-subtle mt-5">
  <nav>
    <ul class="nav">
      <li class="navi-item">
        <a
          href="https://github.com/halfminami/tree_visualization"
          class="nav-link">this repo</a
        >
      </li>
    </ul>
  </nav>
</footer>

<style>
  .svg,
  .svgwrap {
    border: 0.2rem dotted gray;
  }
  .svgwrap {
    background-color: ghostwhite;
    /* height: 100%; */
    width: 100%;
    overflow: auto;
  }
  .svg {
    width: fit-content;
    height: fit-content;
  }
</style>
