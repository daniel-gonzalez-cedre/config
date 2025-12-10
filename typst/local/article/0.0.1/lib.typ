#import "@local/colors:0.0.1": *
#import "@local/fonts:0.0.1": *
#import "@local/maths:0.0.1": *
#import "@local/defs:0.0.1": *

#import "@preview/marge:0.1.0": sidenote

#let page-margin-right = (3.125in, 2.25in).at(1)
#let fullwidth(content) = block(width: 100.0% + (page-margin-right - 1.0125in), content)

#let apostille( ..args ) = {
  set text(size: 11.0pt, style: "italic")
  sidenote(
    dy: 1.0pt,
    numbering: none,
    side: left,
    format: it => {
      set align(right)
      it.default
    },
    ..args
  )
}
#let marginale( ..args ) = {
  set text(size: 11.0pt)
  sidenote(
    dy: 1.0pt,
    numbering: none,
    padding: (
      left: 2.0em,
      right: 4.0em
    ),
    format: it => { it.default },
    ..args
  )
}
#let marginalis( ..args ) = {
  set text(size: 11.0pt)
  sidenote(
    dy: 1.0pt,
    numbering: "1",
    padding: (
      left: 2.0em,
      right: 4.0em
    ),
    format: it => { it.default },
    ..args
  )
}

#let sidefigure( fig, dy: 0.0pt, caption: none ) = {
  marginale(dy: dy)[
    #box( figure( fig, caption: caption ) )
  ]
}

#let article(
  title: [The Title],
  shorttitle: none,
  author: "Daniel Gonzalez Cedre",
  date: datetime.today(),
  publisher: none,
  toc: true,
  bib: none,
  paper: "us-letter",
  paper_color: "natural",
  header: none,
  footer: none,
  doc
) = {
  set document(
    title: title,
    author: author,
    date: date,
  )

  set page(
    paper: paper,
    fill: if paper_color == "natural" { color.paper.natural } else { color.paper.bleached },
    header: none,
    footer: none,
  )

  set par(
    justify: true,
    // leading: 0.65em,
  )

  show quote: set text( ..fonts.serif, size: 10.0pt, style: "italic" )
  show quote: set pad(left: 1in, right: 0in)
  set quote(block: true)
  show quote.where(block: true): it => {
    set par(justify: false)
    set align(left)
    set text( ..fonts.serif, size: 10.0pt )
    pad(
      left: 1.0in,
      right: 0.0in,
      text(style: "italic", llap[\u{201C}] + it.body + [\u{201D}])
      + linebreak()
      + h(1.0fr) + text(size: 9.0pt, style: "normal", [--- ] + it.attribution)
    )
  }

  set text( ..fonts.serif, size: 11.0pt )
  show raw: set text( ..fonts.mono, size: 9.0pt )

  set underline(
    offset: 2.0pt,
    stroke: (
      cap: "round",
      dash: "dotted",
    )
  )

  show figure: set figure.caption(separator: [.#h(0.5em)])
  show figure.caption: set align(left)
  show figure.caption: set text( ..fonts.serif, size: 9.0pt )

  set enum(indent: 1.0em, body-indent: 1.0em)
  show enum: set par(justify: false)

  set list(indent: 1.0em, body-indent: 1.0em)
  show list: set par(justify: false)

  show figure.where(kind: table): set figure(supplement: [Tab.], numbering: "1")
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: image): set figure(supplement: [Fig.], numbering: "1")
  show figure.where(kind: raw): set figure(supplement: [Alg.], numbering: "1")
  show figure.where(kind: raw): set figure.caption(position: top)

  // show heading.where(level: 1): it => {
  //   set text( ..fonts.serif, size: 22.0pt, style: "italic" )
  //   block(
  //     v(32.0pt + 48.0pt)
  //     + it.body
  //   )
  // }
  // show outline.entry.where(level: 1): set block(above: 32.0pt, below: 12.0pt)
  // show outline.entry.where(level: 1): set text( ..fonts.serif, size: 16.0pt, style: "italic" )
  // show outline.entry.where(level: 1): it => link(
  //   it.element.location(),
  //   it.indented( it.prefix(), [ #it.body() #h(1.0fr) #text(style: "normal", it.page()) ] ),
  // )
  // show outline.entry.where(level: 2): set block(above: 8.0pt, below: 8.0pt)
  // show outline.entry.where(level: 2): set text( ..fonts.serif, size: 11.0pt, style: "italic" )
  // show outline.entry.where(level: 2): it => link(
  //   it.element.location(),
  //   it.indented( it.prefix(), [ #it.body() #h(1.0fr) #text(style: "normal", it.page()) ] ),
  // )
  // show outline.entry.where(level: 3): set block(above: 8.0pt, below: 8.0pt)
  // show outline.entry.where(level: 3): set text( ..fonts.serif, size: 11.0pt, style: "italic" )
  // show outline.entry.where(level: 3): it => link(
  //   it.element.location(),
  //   it.indented( hide(it.prefix()), [ #it.body() #h(1.0fr) #text(style: "normal", it.page()) ] ),
  // )

  set page(
    margin: (right: page-margin-right, rest: auto),
    header: context {
      fullwidth(
        emph(displaydate(date))
        + h(1.0fr)
        + smallcaps(lower(title))
        + h(2.0em)
        + counter(page).display()
        + v(1.0em)
      )
    }
  )

  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    set text( ..fonts.serif, size: 18.0pt, style: "italic", weight: "bold" )
    block(
      above: 22.0pt,
      below: 16.0pt,
      llap[#counter(heading).display()#h(12.0pt)]
      + it.body
    )
  }
  show heading.where(level: 2): it => {
    set text( ..fonts.serif, size: 13.0pt, style: "italic", weight: "bold" )
    block(
      above: 22.0pt,
      below: 16.0pt,
      llap[#counter(heading).display()#h(12.0pt)]
      + it.body
    )
  }
  show heading.where(level: 3): it => {
    set text( ..fonts.serif, size: 11.0pt, style: "italic", weight: "regular" )
    block(
      llap[#counter(heading).display()#h(12.0pt)]
      + it.body
    )
  }

  // show link: set text(luma(50))

  doc

  show bibliography: set text( ..fonts.serif, size: 9.0pt )
  show bibliography: set par(justify: false)
  set bibliography(title: none)
  if bib != none {
    heading(level: 1, [Bibliography])
    bib
  }
}
