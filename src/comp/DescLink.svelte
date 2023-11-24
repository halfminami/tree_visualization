<script lang="ts">
  import { descQuestion } from '../lib/service';

  export let id: string;
  export let text = '?';
  export let className = '';
</script>

<a
  href="#{id}"
  class="link-secondary link-underline-opacity-25 {className}"
  on:click={() => document.getElementById(id)?.focus()}
  aria-labelledby={$descQuestion}>{text}</a
>
