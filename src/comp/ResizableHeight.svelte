<script lang="ts">
  import { onDestroy } from 'svelte';

  let parentClass: string = '';
  export { parentClass as class };

  export let resizeLabelId: string;

  let main: HTMLDivElement | null = null;
  let bottom: HTMLDivElement | null = null;
  let isMouseDown = false;
  export let height: number | undefined = undefined;
  $: height = main?.clientHeight;

  const listenerMouseUp = () => (isMouseDown = false);
  const cleanListenerMouseUp = () =>
    window.removeEventListener('mouseup', listenerMouseUp);
  $: if (isMouseDown == true) {
    window.addEventListener('mouseup', listenerMouseUp); // or {once: true}
  } else {
    cleanListenerMouseUp();
  }
  onDestroy(cleanListenerMouseUp);

  // child element (<slot />) must be resized automatically (height: 100%) or set height (exported) at the same time
  const listenerMouseMove = (e: MouseEvent) => {
    height = height
      ? Math.max(height + e.pageY - (bottom ? bottom.offsetTop : 0), 1)
      : height;
  };
  const cleanListenerMouseMove = () =>
    window.removeEventListener('mousemove', listenerMouseMove);
  $: if (isMouseDown == true) {
    window.addEventListener('mousemove', listenerMouseMove);
  } else {
    cleanListenerMouseMove();
  }
  onDestroy(cleanListenerMouseMove);
</script>

<div class="fit {parentClass}" style="height:{height}px;" bind:this={main}>
  <slot />
  <div
    class="bottom"
    role="button"
    tabindex="-1"
    on:mousedown={() => (isMouseDown = true)}
    bind:this={bottom}
    aria-labelledby={resizeLabelId}
  ></div>
</div>

<style>
  .bottom {
    height: 0.5em;
    width: 100%;
    background-color: #aaa;
    cursor: ns-resize;
  }
</style>
