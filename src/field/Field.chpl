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

module Field {
  record ScalarField: serializable {
    type T;
    param D: int;
    var lattice: domain(?);
    var storage: [lattice] T;
  
    proc init(type T, lattice: domain(?)){
      this.T = T; 
      this.D = lattice.rank;
      this.lattice = lattice;
    }

    proc init=(const other: ScalarField(?T))
    {this.init(T,other.lattice); this.storage = other.storage;}

    proc init=(const other: [?L] ?T){this.init(T,L); this.storage = other;}

    /*
    proc operator:(const other: [?L] ?T){
      assert(this.lattice == L);
      this.storage = other;
    }
    */

    proc this(args: this.D*int){return this.storage[args];}

    proc ref sites: domain(?) {return this.lattice;}

    proc ref field: [this.lattice] this.T {return this.storage;}
  }

  public type 
    IntegerScalarFieldS = ScalarField(int(32),?),
    IntegerScalarFieldD = ScalarField(int(64),?),
    IntegerScalarField = IntegerScalarFieldD(?),

    RealScalarFieldS = ScalarField(real(32),?),
    RealScalarFieldD = ScalarField(real(64),?),
    RealScalarField = RealScalarFieldD(?),

    ComplexScalarField = ScalarField(complex,?);

  private inline proc conformable(x: ScalarField(?), y: ScalarField(?)) 
  {assert(x.lattice == y.lattice);}

  private inline proc conformable(x: ScalarField(?), y: [?L] ?T){assert(x.lattice == L);}

  public operator ScalarField.=(ref x: ScalarField(?), y: ScalarField(?))
  {conformable(x,y); x.storage = y.storage;}

  /*
  public operator ScalarField.=(ref x: ScalarField(?), y: [?L] ?T)
  {conformable(x,y); x.storage = y;}
  */

  public inline proc ref ScalarField.set(y: this.T){
    ref xf = this.field;
    const ref 
      doms = this.lattice.localSubdomains(),
      locs = this.lattice.targetLocales();
    coforall (dom,loc) in zip(doms,locs) do {on loc {foreach n in dom do xf[n] = y;}}
  }

  public inline proc ref ScalarField.set(y: [this.lattice] this.T){
    ref xf = this.field;
    const ref 
      doms = this.lattice.localSubdomains(),
      locs = this.lattice.targetLocales();
    coforall (dom,loc) in zip(doms,locs) do {on loc {foreach n in dom do xf[n] = y[n];}}
  }

  public inline proc ref ScalarField.set(y: ScalarField(this.T,this.D,?)){
    ref xf = this.field;
    const ref 
      doms = this.lattice.localSubdomains(),
      locs = this.lattice.targetLocales();
    coforall (dom,loc) in zip(doms,locs) do {on loc {foreach n in dom do xf[n] = y[n];}}
  }

  public inline operator ScalarField.+(x: ScalarField(?X,?D), y: ScalarField(?Y,D)){
    conformable(x,y);
    var z = new ScalarField(X,x.lattice);
    ref zf = z.field;
    const ref 
      doms = z.lattice.localSubdomains(),
      locs = z.lattice.targetLocales();
    coforall (dom,loc) in zip(doms,locs) do {
      on loc {foreach n in dom do zf[n] = x[n] + y[n];}
    }
    return z;
  }

  public inline operator ScalarField.-(x: ScalarField(?X,?D), y: ScalarField(?Y,D)){
    conformable(x,y);
    var z = new ScalarField(X,x.lattice);
    ref zf = z.field;
    const ref 
      doms = z.lattice.localSubdomains(),
      locs = z.lattice.targetLocales();
    coforall (dom,loc) in zip(doms,locs) do {
      on loc {foreach n in dom do zf[n] = x[n] - y[n];}
    }
    return z;
  }
  
  public inline operator ScalarField.*(x: ScalarField(?X,?D), y: ScalarField(?Y,D)){
    conformable(x,y);
    var z = new ScalarField(X,x.lattice);
    ref zf = z.field;
    const ref 
      doms = z.lattice.localSubdomains(),
      locs = z.lattice.targetLocales();
    coforall (dom,loc) in zip(doms,locs) do {
      on loc {foreach n in dom do zf[n] = x[n]*y[n];}
    }
    return z;
  }

  public inline operator ScalarField./(x: ScalarField(?X,?D), y: ScalarField(?Y,D)){
    conformable(x,y);
    var z = new ScalarField(X,x.lattice);
    ref zf = z.field;
    const ref 
      doms = z.lattice.localSubdomains(),
      locs = z.lattice.targetLocales();
    coforall (dom,loc) in zip(doms,locs) do {
      on loc {foreach n in dom do zf[n] = x[n]/y[n];}
    }
    return z;
  }

}