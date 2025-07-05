/*
 * ReliQ lattice field theory framework: github.com/ctpeterson/ReliQ
 * Source file: src/field/implementation/ScalarFieldImpl.chpl
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

private use ScalarField;

private inline proc conformable(x: ScalarField(?), y: ScalarField(?)) 
{assert(x.lattice == y.lattice);}

private inline proc conformable(x: ScalarField(?), y: [?L] ?T)
{assert(x.lattice == L);}

operator ScalarField.=(ref x: ScalarField(?), y: ScalarField(?))
{conformable(x,y); x.field = y.field;}

inline proc ref ScalarField.set(x: this.T) {
  ref tf = this.field;
  coforall loc in this.locales {
    on loc {
      forall sites in this.localSublattices(loc) { foreach n in sites do tf[n] = x; }
    }
  }
}

inline proc ref ScalarField.set(x: [?D] ?T) {
  conformable(this,x);
  ref tf = this.field;
  coforall loc in this.locales {
    on loc {
      forall sites in this.localSublattices(loc) { foreach n in sites do tf[n] = x[n]; }
    }
  }
}

inline proc ref ScalarField.set(x: ScalarField(?T, ?D, ?)) {
  conformable(this,x);
  ref tf = this.field;
  coforall loc in this.locales {
    on loc {
      forall sites in this.localSublattices(loc) { foreach n in sites do tf[n] = x[n]; }
    }
  }
}

inline operator ScalarField.+(x: ScalarField(?X, ?D), y: ScalarField(?Y, D)) {
  conformable(x,y);
  var z = new ScalarField(x.T, x.lattice);
  ref zf = z.field;
  coforall loc in z.locales {
    on loc {
      forall sites in z.localSublattices(loc) {
        foreach n in sites do zf[n] = x[n] + y[n];
      }
    }
  }
  return z;
}

inline operator ScalarField.-(x: ScalarField(?X, ?D), y: ScalarField(?Y, D)) {
  conformable(x,y);
  var z = new ScalarField(x.T, x.lattice);
  ref zf = z.field;
  coforall loc in z.locales {
    on loc {
      forall sites in z.localSublattices(loc) {
        foreach n in sites do zf[n] = x[n] - y[n];
      }
    }
  }
  return z;
}

inline operator ScalarField.*(x: ScalarField(?X,?D), y: ScalarField(?Y,D)) {
  conformable(x,y);
  var z = new ScalarField(x.T, x.lattice);
  ref zf = z.field;
  coforall loc in z.locales {
    on loc {
      forall sites in z.localSublattices(loc) {
        foreach n in sites do zf[n] = x[n]*y[n];
      }
    }
  }
  return z;
}

inline operator ScalarField./(x: ScalarField(?X,?D), y: ScalarField(?Y,D)) {
  conformable(x,y);
  var z = new ScalarField(x.T, x.lattice);
  ref zf = z.field;
  coforall loc in z.locales {
    on loc {
      forall sites in z.localSublattices(loc) {
        foreach n in sites do zf[n] = x[n]/y[n];
      }
    }
  }
  return z;
}