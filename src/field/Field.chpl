/*
 * ReliQ lattice field theory framework: github.com/ctpeterson/ReliQ
 * Source file: src/field/Field.chpl
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

//hierarchy:
//  - locales can implement parallel tasks -- locales can be virtual
//  - tasks can be specified on a per-locale basis -- how used?
//  - in principle, foreach can leverage vectorized hardware acceleration

module Field {
  public use ScalarField;
  public use ScalarFieldImpl;

  //public use TensorField;
  //public use TensorFieldImpl;

  //public use GaugeField;
  //public use GaugeFieldImpl;
}