#import "@local/colors:0.0.1": *
#import "@local/fonts:0.0.1": *
#import "@local/maths:0.0.1": *
#import "@local/defs:0.0.1": *

#let header = {
  // set text(  )
  place(
    float: true,
    center + top,
    [
      #box(
        image(width: 2.0in, "assets/illinois.pdf")
        + v(4.0em)
      )
      #h(1.0fr)
      #box[
        #set align(right)
        The Grainger College of Engineering \
        Siebel School for Computing and Data Science \
        Siebel Center for Computer Science \
        201 North Goodwin Avenue \
        Urbana, IL 61801 USA
      ]
    ]
  )
}

#let footer = {
  place(
    float: true,
    left + bottom,
    [
      Sincerely,

      #smallcaps[
        #strong[Daniel Gonzalez Cedre, PhD] \
        Assistant Teaching Professor \
        Siebel School for Computing and Data Science \
        University of Illinois Urbana-Champaign
      ]
    ]
  )
}

#let letter(
  title: [The Title],
  shorttitle: none,
  author: "Daniel Gonzalez Cedre",
  date: datetime.today(),
  publisher: none,
  paper: "us-letter",
  paper_color: "natural",
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

  set par(justify: false)

  set text( ..fonts.serif, size: 11.0pt )
  show raw: set text( ..fonts.mono, size: 9.0pt )

  show quote: set text(size: 11.0pt, style: "italic")
  set smallcaps(all: true)
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

  header
  doc
  footer
}
