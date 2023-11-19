import { describe, expect, test } from 'vitest';
import { makeAdjacent } from '../lib/makeAdjacent';

describe('make an adjacency list from edges', () => {
  test('small tree', () => {
    const okAdjacent = [[1], []];
    const okNames = ['0', '1'];
    const edges: [string, string][] = [['0', '1']];
    runTest(edges, '0', okAdjacent, okNames);
  });

  test('adjacency list and names (1)', () => {
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
    runTest(edges, '0', okAdjacent, okNames);
  });

  test('adjacency list and names (2)', () => {
    const okAdjacent = [
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
    const edges: [string, string][] = [
      ['1', '4'],
      ['1', '5'],
      ['1', '13'],
      ['5', '8'],
      ['13', '2'],
      ['13', '3'],
      ['3', '6'],
      ['3', '7'],
      ['7', '9'],
      ['7', '10'],
      ['7', '11'],
      ['7', '12'],
      ['7', '0'],
    ];
    runTest(edges, '13', okAdjacent, okNames);
  });
});

function runTest(
  edges: [string, string][],
  head: string,
  okAdjacent: number[][],
  okNames: string[]
) {
  // map returned names index and modify okAdjacent
  const okNamesMap = new Map<string, number>();

  okNames.forEach((c, i) => okNamesMap.set(c, i));

  const ret = makeAdjacent(edges, head);
  // names should contain same elements
  expect(ret.names).toHaveLength(okNames.length);
  expect(ret.names).toEqual(expect.arrayContaining(okNames));

  const okNamesIndxToRetNamesIndx = new Map<number, number>();
  ret.names.forEach((item, i) => {
    okNamesIndxToRetNamesIndx.set(okNamesMap.get(item)!, i);
  });
  const checkAdjacent: number[][] = [];
  okAdjacent.forEach(
    (item, i) =>
      (checkAdjacent[okNamesIndxToRetNamesIndx.get(i)!] = item
        .concat([])
        .map((d) => okNamesIndxToRetNamesIndx.get(d)!))
  );

  expect(ret.adjacent).toStrictEqual(checkAdjacent);
}
