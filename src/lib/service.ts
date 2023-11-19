import { readable, writable } from 'svelte/store';

export const rectWidth = writable(80);
export const rectHeight = writable(80);
export const circleR = writable(30);
export const textWidth = writable(30);
export const names = writable<string[]>(['0', '1']);
export const adjacent = writable<number[][]>([[1], []]);

class IdCntr {
  #id;
  constructor(n: number) {
    this.#id = n;
  }
  get() {
    const ret = `id-${this.#id}`;
    this.#id++;
    return ret;
  }
}

export const idCntr = new IdCntr(0);

export const descTextWidth = readable(idCntr.get());
export const descCircleR = readable(idCntr.get());
export const descRectWidth = readable(idCntr.get());
export const descRectHeight = readable(idCntr.get());
export const descAdjacent = readable(idCntr.get());
export const descNames = readable(idCntr.get());
export const descDownload = readable(idCntr.get());
export const descEdges = readable(idCntr.get());
