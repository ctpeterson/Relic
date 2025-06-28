/*
 * ReliQ lattice field theory framework: github.com/ctpeterson/ReliQ
 * Source file: src/lattice/BravaisLattice.chpl
 * Author: Curtis Taylor Peterson <curtistaylorpetersonwork@gmail.com>
 *
 * MIT License
 * 
 * Copyright (c) 2025 Curtis Taylor Peterson
 *  
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *  
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

private use GeneralLattice;
private use StencilDist;

type PaddedCell = StencilDist.stencilDist;

private proc makeZero(param rank: int){var t: rank*int; return t;}

class SimpleCubicLattice: GeneralLattice.Lattice(?) {
  proc init(
    geometry: domain(?),
    padding: geometry.rank*int = makeZero(geometry.rank),
    periodic: bool = true
  ){
    const stencil = new PaddedCell(geometry, fluff = padding, periodic = periodic);
    super.init(geometry.rank,GeneralLattice.Tile.SQUARE);
    this.L = stencil.createDomain(geometry);
  }
}