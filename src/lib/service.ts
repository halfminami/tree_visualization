import { writable } from 'svelte/store';

export const rectWidth = writable(100);
export const rectHeight = writable(100);
export const circleR = writable(30);
export const textWidth = writable(30);
export const names = writable<string[]>([]);
export const adjacent = writable<number[][]>([]);
