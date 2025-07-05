/*
 * ReliQ lattice field theory framework: github.com/ctpeterson/ReliQ
 * Source file: src/field/ScalarField.chpl
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

record ScalarField: serializable {
  type T;
  param D: int;
  var lattice: domain(?);
  var field: [lattice] T;

  proc init(type T, lattice: domain(?)) {
    this.T = T; 
    this.D = lattice.rank;
    this.lattice = lattice;
  }

  proc init=(const other: ScalarField(?T)) {
    this.init(T, other.lattice); 
    this.field = other.field; 
  }

  proc init=(const other: [?L] ?T) { this.init(T, L); this.field = other; }

  proc this(args: this.D*int) { return this.field[args]; }

  proc const ref sites { return this.lattice; }

  proc const ref localSublattices(loc: locale = here) { 
    return this.lattice.localSubdomains(loc); 
  }

  proc const ref locales: [] locale { return this.lattice.targetLocales(); }
}

public type 
  IntegerScalarFieldS = ScalarField(int(32),?),
  IntegerScalarFieldD = ScalarField(int(64),?),
  IntegerScalarField = IntegerScalarFieldD(?),

  RealScalarFieldS = ScalarField(real(32),?),
  RealScalarFieldD = ScalarField(real(64),?),
  RealScalarField = RealScalarFieldD(?),

  ComplexScalarField = ScalarField(complex,?);