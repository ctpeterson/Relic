/*
 * ReliQ lattice field theory framework: github.com/ctpeterson/ReliQ
 * Source file: test/tfield/tField.chpl
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

private use Lattice;
private use Field;

// chpl tField.chpl ../../src/field/Field.chpl ../../src/lattice/Lattice.chpl
proc main() {
  const 
    geometry = {1..8,1..8,1..8,1..8},
    lattice = Lattice.BravaisLattice.PaddedBlockDistSimpleCubicLattice(geometry);
  var
    iphi = new Field.IntegerScalarField(lattice),
    rphi = new Field.RealScalarField(lattice),
    rpsi = new Field.RealScalarField(lattice),
    rphica = rphi,
    rphicb = rphi.storage,
    cphi = new Field.ComplexScalarField(lattice);
  rpsi.set(3.0);
  rphi.set(rpsi);
  rphi.set(rpsi.storage);
  rphi.set(rpsi.field);
  //rphi = rpsi.field;
  rphi.set(2.0);
  rpsi = rphi + rphi;
  rpsi = rphi*rpsi;
  rpsi = rphi - rpsi;
  rphi = rpsi/rphi;
}