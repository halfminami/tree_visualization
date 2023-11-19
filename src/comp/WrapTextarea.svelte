<script lang="ts">
  import DescLink from './DescLink.svelte';

  export let id: string;
  export let lab: string;
  export let value: string;
  export let className = '';
  export let desc = '';
  export let input = false;
</script>

<label for={id} class="form-label {className}"
  >{lab}
  <DescLink id={desc} /></label
>
{#if input}
  <input {id} bind:value class="form-control {className}" />
{:else}
  <textarea {id} bind:value class="form-control {className}" />
{/if}
