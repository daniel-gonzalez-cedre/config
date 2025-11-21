#let maths(doc) = {
  show math.gt.eq: math.gt.eq.slant
  show math.lt.eq: math.lt.eq.slant

  show math.nothing: math.diameter
  show math.emptyset: math.diameter

  doc
}

#let counter-case = counter("case")
#let case(content, title: "Case", numbering: true) = {
  if numbering { counter-case.step() }
  context {
    let number = if numbering {
      " " + counter-case.display()
    } else {
      ""
    }
    let head = text(weight: "bold", title + number + ":")
    block(
      head + linebreak() + content
    )
  }
}
#let case-basis(content) = case(content, title: "Basis Step", numbering: false)
#let case-inductive(content) = case(content, title: "Inductive Step", numbering: false)

#let proof(content, uline: false, newline: true) = {
  counter-case.update(0)
  let title = if uline {
    text(style: "italic", weight: "bold", underline("Proof") + ": ")
  } else {
    text(style: "italic", weight: "bold", "Proof: ")
  }
  let qed = smallcaps(lower("Q.E.D."))
  let qedline = if newline {
    v(- 0.6em) + h(1.0fr) + qed
  } else {
    h(1.0fr) + qed
  }
  block(
    title + v(- 0.6em) + content + qedline
  )
}

#let to = $arrow.r$
#let implies = math.arrow.r.double
#let contradiction = text(stroke: black + 0.6pt)[$arrow.zigzag$]
#let cardinality(x) = $|#x|$
