import { describe, expect, test } from 'vitest';
import { makeAdjacent } from '../lib/makeAdjacent';

describe('make an adjacency list from edges', () => {
  test('adjacency list and names', () => {
    const okAdjacent = [
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
    const okNames = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
    ];
    // map returned names index and modify okAdjacent
    const okNamesMap = new Map<string, number>();

    okNames.forEach((c, i) => okNamesMap.set(c, i));

    const edges: [string, string][] = [
      ['0', '1'],
      ['1', '2'],
      ['2', '3'],
      ['2', '4'],
      ['2', '5'],
      ['3', '6'],
      ['4', '7'],
      ['5', '8'],
      ['6', '9'],
      ['6', '10'],
      ['6', '11'],
      ['8', '12'],
      ['8', '13'],
    ];
    const ret = makeAdjacent(edges, '0');
    expect(ret.names).toHaveLength(okNames.length);
    expect(ret.names).toEqual(expect.arrayContaining(okNames));

    const okNamesIndxToRetNamesIndx = new Map<number, number>();
    ret.names.forEach((item, i) => {
      okNamesIndxToRetNamesIndx.set(okNamesMap.get(item)!, i);
    });
    const checkAdjacent: number[][] = [];
    okAdjacent.forEach(
      (item, i) => (checkAdjacent[okNamesIndxToRetNamesIndx.get(i)!] = item)
    );
    checkAdjacent.map((item) =>
      item.map((item) => okNamesIndxToRetNamesIndx.get(item))
    );

    expect(ret.adjacent).toStrictEqual(checkAdjacent);
  });
});
