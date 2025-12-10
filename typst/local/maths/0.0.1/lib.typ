#import "@local/colors:0.0.1": *
#import "@local/fonts:0.0.1": *
#import "@local/defs:0.0.1": llap

#let maths(doc) = {
  show math.gt.eq: math.gt.eq.slant
  show math.lt.eq: math.lt.eq.slant

  show math.nothing: math.diameter
  show math.emptyset: math.diameter

  doc
}

#let cardinality(x) = math.abs(x)
#let card(x) = math.abs(x)
#let norm(x) = math.bar.v.double + x + math.bar.v.double
#let suc(n) = math.frak("suc") + "(" + n + ")"
#let nat(n) = math.lr(sym.bracket.l.stroked) + n + math.lr(sym.bracket.r.stroked)

#let string(finite: true, content) = {
  let ellipsis = if finite {
    ""
  } else {
    "..."
  }
  mono("\"") + mono(content) + ellipsis + mono("\"")
}
#let striing = string.with(finite: false)
#let len = $mono(weight: "medium", "len")$

#let st = math.mid(math.bar.v)
#let to = math.arrow.r
#let contradiction = text(
  stroke: (
    paint: color.off.black,
    thickness: 0.375pt,
    join: "round",
  ),
  $#rotate(
    30.0deg,
    reflow: true, math.arrow.zigzag
  )$
)
// #let contradiction = text(
//   stroke: (
//     paint: color.off.black,
//     thickness: 0.375pt,
//     join: "round",
//   )
// )[$arrow.zigzag$]

#let implies = context {
  if query(selector(math.equation).before(here())).last().block {
    h(0.75em, weak: true) + math.arrow.r.double + h(0.75em, weak: true)
  } else {
    math.arrow.r.double
  }
}

#let iff = context {
  if query(selector(math.equation).before(here())).last().block {
    h(0.75em, weak: true) + math.arrow.l.r.double + h(0.75em, weak: true)
  } else {
    math.arrow.l.r.double
  }
}

#let proves = context {
  if query(selector(math.equation).before(here())).last().block {
    h(0.75em, weak: true) + math.tack.r + h(0.75em, weak: true)
  } else {
    math.tack.r
  }
}

#let entails = context {
  if query(selector(math.equation).before(here())).last().block {
    h(0.75em, weak: true) + math.tack.r.double + h(0.75em, weak: true)
  } else {
    math.tack.r.double
  }
}

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

#let counter-case = counter("case")
#let case(content, title: "Case", numbering: true, size: fonts.sizes.cases) = {
  if numbering { counter-case.step() }
  context {
    let number = if numbering {
      " " + counter-case.display()
    } else {
      ""
    }
    let head = title + number + ":"
    set text(size: size)
    block(
      inset: (x: 0.6em),
      text(weight: "bold", style: "italic", head) + linebreak() + content
    )
  }
}

#let case-basis(content) = case(content, title: "Basis Step", numbering: false)
#let case-inductive(content) = case(content, title: "Inductive Step", numbering: false)

#let counter-axiom = counter("axiom")
#let axiom(content, numbering: true, title: "Axiom", name: "", punctuation: ".", headbreak: true) = {
  if numbering { counter-axiom.step() }
  name = if name != "" { ": " + name }
  context {
    let number = if numbering {
      " " + counter-axiom.display()
    } else {
      ""
    }
    let headline = if headbreak {
      text(size: fonts.sizes.titles, style: "italic", weight: "bold", title + number + name + punctuation) + h(1.0fr) + v(- 0.6em)
    } else {
      text(size: fonts.sizes.titles, style: "italic", weight: "bold", title + number + name + punctuation)
    }
    block( headline + content )
  }
}

#let counter-theorem = counter("theorem")
#let theorem(content, numbering: true, title: "Theorem", name: "", punctuation: ".", headbreak: true) = {
  if numbering { counter-theorem.step() }
  name = if name != "" { ": " + name }
  context {
    let number = if numbering {
      " " + counter-theorem.display()
    } else {
      ""
    }
    let headline = if headbreak {
      text(size: fonts.sizes.titles, style: "italic", weight: "bold", title + number + name + punctuation) + h(1.0fr) + v(- 0.6em)
    } else {
      text(size: fonts.sizes.titles, style: "italic", weight: "bold", title + number + name + punctuation)
    }
    block( headline + content )
  }
}

#let counter-lemma = counter("lemma")
#let lemma(content, numbering: true, title: "Lemma", name: "", punctuation: ".", headbreak: true) = {
  if numbering { counter-lemma.step() }
  name = if name != "" { ": " + name }
  context {
    let number = if numbering {
      " " + counter-lemma.display()
    } else {
      ""
    }
    let headline = if headbreak {
      text(size: fonts.sizes.titles, style: "italic", weight: "bold", title + number + name + punctuation) + v(- 0.6em)
    } else {
      text(size: fonts.sizes.titles, style: "italic", weight: "bold", title + number + name + punctuation)
    }
    block( headline + content )
  }
}

#let counter-corollary = counter("corollary")
#let corollary(content, numbering: true, title: "Corollary", name: "", punctuation: ".", headbreak: true) = {
  if numbering { counter-corollary.step() }
  name = if name != "" { ": " + name }
  context {
    let number = if numbering {
      " " + counter-corollary.display()
    } else {
      ""
    }
    let headline = if headbreak {
      text(size: fonts.sizes.titles, style: "italic", weight: "bold", title + number + name + punctuation) + h(1.0fr) + v(- 0.6em)
    } else {
      text(size: fonts.sizes.titles, style: "italic", weight: "bold", title + number + name + punctuation)
    }
    block( headline + content )
  }
}

#let counter-exercise = counter("exercise")
#let exercise(content, numbering: true, title: "Exercise", name: "", punctuation: ".", headbreak: false) = {
  if numbering { counter-exercise.step() }
  name = if name != "" { ": " + name }
  context {
    let number = if numbering {
      // llap[#counter-exercise.display()#h(0.5em)]
      " " + counter-exercise.display()
    } else {
      ""
    }
    let headline = if headbreak {
      // text(size: fonts.sizes.titles, style: "italic", weight: "bold", number + title + name + punctuation) + h(1.0fr) + v(- 0.6em)
      text(size: fonts.sizes.titles, style: "italic", weight: "bold", title + number + name + punctuation) + h(1.0fr) + v(- 0.6em)
    } else {
      // text(size: fonts.sizes.titles, style: "italic", weight: "bold", number + title + name + punctuation)
      text(size: fonts.sizes.titles, style: "italic", weight: "bold", title + number + name + punctuation)
    }
    block(
      // stroke: 1.0pt + color.light.blackish,
      // // fill: color.misc.clarified,
      // radius: 2.0pt,
      // outset: (x: 0.5em, y: 0.5em),
      // inset: 0.0em,
      headline + content
    )
  }
}

#let proof(content, title: "Proof", punctuation: ".", headbreak: false, qedbreak: false, qed: none) = {
  // set page(fill: color.misc.cream)
  counter-case.update(0)
  let headline = if headbreak {
    title + punctuation + v(- 0.6em)
  } else {
    title + punctuation + " "
  }
  // if qed == none { qed = text(size: 9.0pt, style: "italic", weight: "bold", "quod erat demonstrandum") }
  if qed == none { qed = smallcaps(lower("QED")) }
  let qedline = if qedbreak {
    v(- 0.6em) + h(1.0fr) + qed
  } else {
    h(1.0fr) + qed
  }
  block(
    // above: 1.0em,
    text(size: fonts.sizes.titles, style: "italic", weight: "bold", headline)
    + content
    + text(size: fonts.sizes.titles, style: "normal", weight: "bold", qedline)
  )
}
