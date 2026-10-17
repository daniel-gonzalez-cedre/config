#import "@local/maths:0.1.0" as maths
#import "@local/tables:0.1.0" as tables
#import "@local/marginalia:0.1.0" as marginalia: marginalis, marginale, apostille, fullblock, wideblock

#import "src/formatting.typ": llap, display-date, display-year, display-month, display-day
#import "src/colors.typ" as colors
#import "src/fonts.typ" as fonts

#let question = block.with(
  height: 1fr,
  width: 100%,
  // stroke: (bottom: 0.6pt),
  stroke: 0.6pt,
  inset: 6pt,
  sticky: true,
)

#let option = box(circle(radius: 3.6pt, stroke: colors.fg + 0.6pt, fill: none))
#let answer = box(circle(radius: 3.6pt, stroke: colors.fg + 0.6pt, fill: colors.fg))

#let exam(
  author: "Daniel Gonzalez Cedre",
  title: "Exam",
  number: "",
  version: "",
  date: datetime.today(),
  semester: none,
  publisher: none,
  university: none,
  course: none,
  code: none,
  paper-size: "us-letter",
  paper-color: "natural",
  font-size: 10pt,
  doc
) = {
  show: maths.setup.with(
    body-font: "Palatino Linotype",
    math-font: "New Computer Modern Math"
  )

  set document(
    title: title + " " + str(number) + " " + str(version),
    author: author,
    date: date,
  )

  set page(
    paper: paper-size,
    fill: if paper-color in ("pulp", "natural") { colors.paper.pulp } else { colors.paper.bleached },
    header:
      fullblock(
        underline(smallcaps("name:"))
        + box(
          width: 1.0fr,
          baseline: 2pt,
          line(
            length: 100.0%,
            stroke: 0.6pt + colors.fg
          )
        )
        + underline(smallcaps("netid:"))
        + box(
          width: 1.0fr,
          baseline: 2pt,
          line(
            length: 100.0%,
            stroke: 0.6pt + colors.fg
          )
        )
        + v(0.6em)
      ),
    footer: context {
      // set text(size: 0.85*font-size)
      // fullblock(
      //   align(center)[
      //     $frac(#text( ..fonts.select("Palatino Linotype") )[#counter(page).display()], #text( ..fonts.select("Palatino Linotype") )[#counter(page).final().first()], style: "skewed")$
      //   ]
      // )
      fullblock(align(center)[#counter(page).display()])
    },
  )

  set par(justify: true)

  set text(
    ..fonts.select("Palatino Linotype"),
    fill: colors.ink,
    size: font-size
  )

  show raw: set text( ..fonts.select("TX-02"), size: 1em )
  show raw.where(block: true): set text( ..fonts.select("TX-02"), size: 1em/0.8 )

  set smallcaps(all: true)

  set underline(offset: 2pt)

  show quote.where(block: false, quotes: true): text.with(..fonts.select("Palatino Linotype"), style: "italic")
  show quote.where(block: false, quotes: auto): text.with(..fonts.select("Palatino Linotype"), style: "italic")
  show quote.where(block: false, quotes: false): text.with(..fonts.select("Palatino Linotype"), style: "normal")

  let symbol_repeater(depth, symbol, tight: false) = {
    assert(depth >= 0)
    if depth == 0 {
      return symbol
    } else {
      if tight {
        return symbol_repeater(depth - 1, symbol, tight: tight) + h(-1pt) + symbol
      } else {
        return symbol_repeater(depth - 1, symbol, tight: tight) + symbol
      }
    }
  }

  // set list(indent: 1.0em, body-indent: 1.0em)
  show list: set par(justify: true)
  set list(marker: depth => symbol_repeater(depth, sym.quote.chevron.r.single, tight: true))
  // set list(marker: depth => {
  //   let char = sym.quote.chevron.r.single
  //   let mark = ""
  //   for i in range(depth) {
  //     mark = mark + char
  //   }
  //   return mark
  // })

  // set enum(indent: 1.0em, body-indent: 1.0em)
  show enum: set par(justify: true)
  set enum(numbering: "1.a.")

  show figure.where(kind: image): set figure(supplement: [Figure], numbering: "1.")
  show figure.where(kind: image): set figure.caption(separator: [ ])

  show: tables.setup
  show figure.where(kind: table): set figure(supplement: [Table], numbering: "1.")
  show figure.where(kind: table): set figure.caption(separator: [ ])

  show figure.where(kind: raw): set figure(supplement: [Algorithm], numbering: "1.")
  show figure.where(kind: raw): set figure.caption(separator: [ ])

  // show: marginalia.show-frame
  show: marginalia.setup.with(
    paper-size: "us-letter",
    font-size: 10pt,
  )

  set heading(numbering: "1")

  show heading.where(level: 1): it => {
    set text(size: 12pt, style: "italic", weight: "regular")
    block(
      above: 24pt,
      below: 16pt,
      // llap[#counter(heading).display()#h(0.8em)] + it.body
    )[#llap(margin: 13.5pt)[#counter(heading).display()]#it.body]
  }
  show heading.where(level: 2): it => {
    set text(size: 12pt, style: "italic", weight: "regular")
    block(
      above: 24pt,
      below: 16pt,
    )[#it.body]
  }
  // show heading.where(level: 2): it => {
  //   set text(size: 12pt, style: "italic", weight: "regular")
  //   block(
  //     above: 11pt,
  //     below: 11pt,
  //     it.body
  //   )
  // }
  show heading.where(level: 3): it => {
    set text(size: 12pt, style: "italic", weight: "regular")
    block(
      above: 11pt,
      below: 24pt,
      it.body
    )
  }

  if version == "" {
    [
      #set text(style: "italic", weight: "regular")
      #text(size: 15pt)[#title #number]
      #v(-6pt)
      #text(size: 12pt)[#course]
      #v(-4pt)
      #text(size: 12pt)[#display-date(long: true, date)]
    ]
  } else {
    [
      #set text(style: "italic", weight: "regular")
      #text(size: 15pt)[#title #number ver. #version]
      #v(-6pt)
      #text(size: 12pt)[#course]
      #v(-4pt)
      #text(size: 12pt)[#display-date(long: true, date)]
    ]
  }

  doc
}

#let quiz(
  author: "Daniel Gonzalez Cedre",
  title: "Quiz",
  number: "",
  version: "",
  date: datetime.today(),
  semester: none,
  publisher: none,
  university: none,
  course: none,
  code: none,
  paper-size: "us-letter",
  paper-color: "natural",
  font-size: 10pt,
  doc
) = {
  show: maths.setup.with(
    body-font: "Palatino Linotype",
    math-font: "New Computer Modern Math"
  )

  set document(
    title: title + " " + str(number) + " " + str(version),
    author: author,
    date: date,
  )

  set page(
    paper: paper-size,
    fill: if paper-color in ("pulp", "natural") { colors.paper.pulp } else { colors.paper.bleached },
    header:
      fullblock(
        underline(smallcaps("name:"))
        + box(
          width: 1.0fr,
          baseline: 2pt,
          line(
            length: 100.0%,
            stroke: 0.6pt + colors.fg
          )
        )
        + underline(smallcaps("netid:"))
        + box(
          width: 1.0fr,
          baseline: 2pt,
          line(
            length: 100.0%,
            stroke: 0.6pt + colors.fg
          )
        )
        + v(0.6em)
      ),
    footer: context {
      // set text(size: 0.85*font-size)
      // fullblock(
      //   align(center)[
      //     $frac(#text( ..fonts.select("Palatino Linotype") )[#counter(page).display()], #text( ..fonts.select("Palatino Linotype") )[#counter(page).final().first()], style: "skewed")$
      //   ]
      // )
      fullblock(align(center)[#counter(page).display()])
    },
  )

  set par(justify: true)

  set text(
    ..fonts.select("Palatino Linotype"),
    fill: colors.ink,
    size: font-size
  )

  show raw: set text( ..fonts.select("TX-02"), size: 1em )
  show raw.where(block: true): set text( ..fonts.select("TX-02"), size: 1em/0.8 )

  set smallcaps(all: true)

  set underline(offset: 2pt)

  show quote.where(block: false, quotes: true): text.with(..fonts.select("Palatino Linotype"), style: "italic")
  show quote.where(block: false, quotes: auto): text.with(..fonts.select("Palatino Linotype"), style: "italic")
  show quote.where(block: false, quotes: false): text.with(..fonts.select("Palatino Linotype"), style: "normal")

  let symbol_repeater(depth, symbol, tight: false) = {
    assert(depth >= 0)
    if depth == 0 {
      return symbol
    } else {
      if tight {
        return symbol_repeater(depth - 1, symbol, tight: tight) + h(-1pt) + symbol
      } else {
        return symbol_repeater(depth - 1, symbol, tight: tight) + symbol
      }
    }
  }

  // set list(indent: 1.0em, body-indent: 1.0em)
  show list: set par(justify: true)
  set list(marker: depth => symbol_repeater(depth, sym.quote.chevron.r.single, tight: true))
  // set list(marker: depth => {
  //   let char = sym.quote.chevron.r.single
  //   let mark = ""
  //   for i in range(depth) {
  //     mark = mark + char
  //   }
  //   return mark
  // })

  // set enum(indent: 1.0em, body-indent: 1.0em)
  show enum: set par(justify: true)
  set enum(numbering: "1.a.")

  show figure.where(kind: image): set figure(supplement: [Figure], numbering: "1.")
  show figure.where(kind: image): set figure.caption(separator: [ ])

  show: tables.setup
  show figure.where(kind: table): set figure(supplement: [Table], numbering: "1.")
  show figure.where(kind: table): set figure.caption(separator: [ ])

  show figure.where(kind: raw): set figure(supplement: [Algorithm], numbering: "1.")
  show figure.where(kind: raw): set figure.caption(separator: [ ])

  // show: marginalia.show-frame
  show: marginalia.setup.with(
    paper-size: "us-letter",
    font-size: 10pt,
  )

  set heading(numbering: "1")

  show heading.where(level: 1): it => {
    set text(size: 12pt, style: "italic", weight: "regular")
    block(
      above: 24pt,
      below: 16pt,
      // llap[#counter(heading).display()#h(0.8em)] + it.body
    )[#llap(margin: 13.5pt)[#counter(heading).display()]#it.body]
  }
  show heading.where(level: 2): it => {
    set text(size: 12pt, style: "italic", weight: "regular")
    block(
      above: 24pt,
      below: 16pt,
    )[#it.body]
  }
  // show heading.where(level: 2): it => {
  //   set text(size: 12pt, style: "italic", weight: "regular")
  //   block(
  //     above: 11pt,
  //     below: 11pt,
  //     it.body
  //   )
  // }
  show heading.where(level: 3): it => {
    set text(size: 12pt, style: "italic", weight: "regular")
    block(
      above: 11pt,
      below: 24pt,
      it.body
    )
  }

  if version == "" {
    [
      #set text(style: "italic", weight: "regular")
      #text(size: 15pt)[#title #number]
      #v(-6pt)
      #text(size: 12pt)[#course]
      #v(-4pt)
      #text(size: 12pt)[#display-date(long: true, date)]
    ]
  } else {
    [
      #set text(style: "italic", weight: "regular")
      #text(size: 15pt)[#title #number ver. #version]
      #v(-6pt)
      #text(size: 12pt)[#course]
      #v(-4pt)
      #text(size: 12pt)[#display-date(long: true, date)]
    ]
  }

  doc
}
