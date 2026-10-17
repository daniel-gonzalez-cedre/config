// #import "fonts.typ": ink, mono
#import "formatting.typ" as formatting

// // PATCH FONT FOR SUMS AND PRODUCTS
// #let sum = {
//   set text(font: "New Computer Modern Math")
//   $sum$
// }
// #let product = {
//   set text(font: "New Computer Modern Math")
//   $product$
// }

// // PATCH FONT FOR MATHCAL AND MATHSCR
// #let cal = term => {
//   set text(font: "New Computer Modern Math")
//   $cal(term)$
// }
// #let scr = term => {
//   set text(font: "New Computer Modern Math")
//   $scr(term)$
// }

#let display(body, ..args) = {
  set math.lr(size: 100% + 2pt)
  math.display(body, ..args)
}

#let nand = math.class("binary", math.overline(math.and))
#let nor  = math.class("binary", math.overline(math.or))

#let even(x) = $#x$ + " is even"
#let odd(x) = $#x$ + " is odd"
#let prime(x) = $#x$ + " is prime"
#let composite(x) = $#x$ + " is composite"

#let cardinality(x) = math.abs(x)
#let card(x) = math.abs(x)
#let norm(x) = math.bar.v.double + x + math.bar.v.double
// #let suc(n) = $op(frak("s"))(#n)$
#let suc(n) = $op(frak("suc"))(#n)$
#let pre(n) = $op(frak("pre"))(#n)$
#let nat(n) = math.lr(sym.bracket.l.stroked) + n + math.lr(sym.bracket.r.stroked)

#let walk(p) = $#p$ + " is a walk"
#let path(p) = $#p$ + " is a path"
#let circuit(p) = $#p$ + " is a circuit"
#let cycle(p) = $#p$ + " is a cycle"

#let deg(G, ..v) = {
  if v.pos().len() == 0 {
    $formatting.mono("deg")_(#G)$
  } else {
    $formatting.mono("deg")_(#G)(#v.pos().at(0))$
  }
}
// #let degree(G, v) = $formatting.mono(deg)_(G)(v)$

// #let domain(f)   = $op(frak("dom"))(#f)$
// #let codomain(f) = $op(frak("cod"))(#f)$

#let dom(f)      = $op(frak("dom"))(#f)$
#let cod(f)      = $op(frak("cod"))(#f)$
#let ran(f)      = $op(frak("ran"))(#f)$

#let fib = math.class("normal", $cal("F")$)
#let fibonacci = math.class("normal", $cal("F")$)

#let ballot = math.class("normal", $cal("B")$)
#let subcat = math.class("normal", $cal("B")$)
#let subcatalan = math.class("normal", $cal("B")$)

#let cat = math.class("normal", $cal("C")$)
#let catalan = math.class("normal", $cal("C")$)

#let id = math.class("normal", formatting.mono("id"))

#let max = formatting.mono("max")
#let min = formatting.mono("min")

#let unions = math.class("unary", math.union)
#let inters = math.class("unary", math.inter)
#let setminus = math.class("binary", math.without)
#let symdif = math.class("binary", math.triangle)

// #show sym.union.over: sym.gt.eq.slant
#let sets = (
  over: (
    union: math.class("unary", math.union),
    inter: math.class("unary", math.inter),
  ),
  union: math.class("unary", math.union),
  inter: math.class("unary", math.inter),
  minus: math.class("binary", math.without),
  without: math.class("binary", math.without),
  xor: math.class("binary", math.triangle),
)

#let string(finite: true, content) = {
  let ellipsis = if finite {
    ""
  } else {
    "..."
  }
  formatting.mono("\"") + formatting.mono(content) + ellipsis + formatting.mono("\"")
}
#let striing = string.with(finite: false)
#let len = $formatting.mono(weight: "medium", "len")$

#let st = math.mid(math.bar.v)
#let to = math.arrow.r
#let inj = math.arrow.hook
#let sur = math.arrow.twohead
#let monic = math.arrow.hook
#let epic = math.arrow.twohead
#let contradiction = text(
  stroke: (
    thickness: 0.5pt,
    join: "round",
  ),
)[$arrow.zigzag$]
// $arrow.zigzag$
// ϟ
// ☡

#let def = (
  iff: (
    () => context {
      if query(selector(math.equation).before(here())).last().block {
        h(0.75em, weak: true) + math.colon + math.arrow.l.r.double + h(0.75em, weak: true)
      } else {
        math.class("relation", math.colon + math.arrow.l.r.double)
      }
    }
  )(),
  eq: math.class("relation", $:=$),
)

#let deff = context {
  if query(selector(math.equation).before(here())).last().block {
    h(0.75em, weak: true) + sym.colon + math.arrow.l.r.double + h(0.75em, weak: true)
  } else {
    math.space + sym.colon + math.arrow.l.r.double + math.space
  }
}

#let implies = math.class("relation", math.arrow.double)
// #let implies = context {
//   if query(selector(math.equation).before(here())).last().block {
//     h(0.75em, weak: true) + math.arrow.r.double + h(0.75em, weak: true)
//   } else {
//     math.space + math.arrow.r.double + math.space
//   }
// }

#let implied = math.class("relation", math.arrow.double.l)
// #let impliedby = context {
//   if query(selector(math.equation).before(here())).last().block {
//     h(0.75em, weak: true) + math.arrow.l.double + h(0.75em, weak: true)
//   } else {
//     math.space + math.arrow.l.double + math.space
//   }
// }

#let iff = math.class("relation", math.arrow.double.l.r)
// #let iff = context {
//   if query(selector(math.equation).before(here())).last().block {
//     h(0.75em, weak: true) + math.arrow.l.r.double + h(0.75em, weak: true)
//   } else {
//     math.space + math.arrow.l.r.double + math.space
//   }
// }

#let syntax = (
  equiv: context {
    if query(selector(math.equation).before(here())).last().block {
      h(0.75em, weak: true) + math.tack.l + math.tack.r + h(0.75em, weak: true)
    } else {
      h(0.5em, weak: true) + math.tack.l + math.tack.r + h(0.5em, weak: true)
    }
  }
)

#let semantics = (
  equiv: context {
    if query(selector(math.equation).before(here())).last().block {
      h(0.75em, weak: true) + math.tack.ll + math.tack.rr + h(0.75em, weak: true)
    } else {
      h(0.5em, weak: true) + math.tack.ll + math.tack.rr + h(0.5em, weak: true)
    }
  }
)

#let proves = context {
  if query(selector(math.equation).before(here())).last().block {
    h(0.75em, weak: true) + math.tack.r + h(0.75em, weak: true)
  } else {
    // math.tack.r
    h(0.5em, weak: true) + math.tack.r + h(0.5em, weak: true)
  }
}

#let notproves = context {
  if query(selector(math.equation).before(here())).last().block {
    h(0.75em, weak: true) + math.tack.r.not + h(0.75em, weak: true)
  } else {
    // math.tack.r
    h(0.5em, weak: true) + math.tack.r.not + h(0.5em, weak: true)
  }
}

#let provedby = context {
  if query(selector(math.equation).before(here())).last().block {
    h(0.75em, weak: true) + math.tack.l + h(0.75em, weak: true)
  } else {
    // math.tack.r
    h(0.5em, weak: true) + math.tack.l + h(0.5em, weak: true)
  }
}

#let models = context {
  if query(selector(math.equation).before(here())).last().block {
    h(0.75em, weak: true) + math.tack.rr + h(0.75em, weak: true)
  } else {
    h(0.5em, weak: true) + math.tack.rr + h(0.5em, weak: true)
  }
}

#let notmodels = context {
  if query(selector(math.equation).before(here())).last().block {
    h(0.75em, weak: true) + math.tack.rr.not + h(0.75em, weak: true)
  } else {
    h(0.5em, weak: true) + math.tack.rr.not + h(0.5em, weak: true)
  }
}

#let satisfies = context {
  if query(selector(math.equation).before(here())).last().block {
    h(0.75em, weak: true) + math.tack.rr + h(0.75em, weak: true)
  } else {
    h(0.5em, weak: true) + math.tack.rr + h(0.5em, weak: true)
  }
}

#let notsatisfies = context {
  if query(selector(math.equation).before(here())).last().block {
    h(0.75em, weak: true) + math.tack.rr.not + h(0.75em, weak: true)
  } else {
    h(0.5em, weak: true) + math.tack.rr.not + h(0.5em, weak: true)
  }
}

#let satisfiedby = context {
  if query(selector(math.equation).before(here())).last().block {
    h(0.75em, weak: true) + math.tack.ll + h(0.75em, weak: true)
  } else {
    h(0.5em, weak: true) + math.tack.ll + h(0.5em, weak: true)
  }
}

// #let modeledby = context {
//   if query(selector(math.equation).before(here())).last().block {
//     h(0.75em, weak: true) + math.tack.l + h(0.75em, weak: true)
//   } else {
//     // math.tack.r
//     h(0.5em, weak: true) + math.tack.l + h(0.5em, weak: true)
//   }
// }
