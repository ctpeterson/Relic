/*
 * ReliQ lattice field theory framework: github.com/ctpeterson/ReliQ
 * Source file: src/lattice/Lattice.chpl
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

module Lattice {
  module BravaisLattice {
    private use BlockDist;
    private use StencilDist;

    private proc defaultPadding(param r: int): r*int {var p: r*int; return p;}
    
    public proc BlockDistSimpleCubicLattice(geometry: domain(?)): domain(?) {
      const blockDistGeometry = new BlockDist.blockDist(boundingBox = geometry);
      return blockDistGeometry.createDomain(geometry);
    }

    public proc PaddedBlockDistSimpleCubicLattice(
      geometry: domain(?),
      param rank: int = geometry.rank,
      tasksPerLocale: int = dataParTasksPerLocale,
      minGranularity: int = dataParMinGranularity,
      padding: rank*int = defaultPadding(rank),
      ignoreRunning: bool = dataParIgnoreRunningTasks,
      periodic: bool = true
    ): domain(?) {
      const stencilDistGeometry = new StencilDist.stencilDist(
        boundingBox = geometry,
        dataParTasksPerLocale = tasksPerLocale,
        dataParIgnoreRunningTasks = ignoreRunning,
        dataParMinGranularity = dataParMinGranularity,
        fluff = padding,
        periodic = periodic
      ); 
      return stencilDistGeometry.createDomain(geometry);
    }
  }
}