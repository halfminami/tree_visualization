import './app.css';
import App from './App.svelte';

declare global {
  var treeGrid: any;
}

const app = new App({
  target: document.getElementById('app')!,
});

export default app;
