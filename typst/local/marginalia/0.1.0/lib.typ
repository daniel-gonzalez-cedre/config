#import "@preview/marginalia:0.3.1" as marginalia: show-frame, note, notefigure, wideblock

#let _paper-size = state("_paper-size", "us-letter")
#let _font-size = state("_font-size", 10pt)

#let setup_defaults = (  // A4 paper size, 11pt font
  alternate: false,  // whether to alternate inner/outer on every page
  inner: (  // inner (usually left) margin
    sep: 5mm,  // padding between inner column and main body
    width: 15mm,  // width of inner column
    far: 5mm,  // padding between inner column and page border
  ),
  outer: (  // outer (usually right) margin
    sep: 5mm,  // padding between outer column and main body
    width: 15mm,  // width of outer column
    far: 5mm,  // padding between outer column and page border
  ),
  top: 25mm,  // top margin
  bottom: 25mm,  // bottom margin
  clearance: 12pt,  // padding between adjacent notes
  text-style: (  // text-tyle parameter for notes
    size: 9.35pt,
    style: "normal",
    weight: "regular"
  )
)

#let setup_a4 = setup_defaults

#let setup_us-letter = (  // 8.5in × 11.0in US paper size, 10pt font
  alternate: false,  // whether to alternate inner/outer on every page
  inner: (  // inner (usually left) margin
    far: 5.7mm,  // 5mm
    width: 15mm,  // 15mm
    sep: 5mm,  // 5mm
  ),
  outer: (  // outer (usually right) margin
    far: 5.7mm,  // 5mm
    width: 50mm,  // 15mm
    sep: 5mm,  // 5mm
  ),
  top: 25.7mm,  // top margin
  bottom: 25.7mm,  // bottom margin
  clearance: 12pt,  // padding between adjacent notes
  text-style: (  // text-tyle parameter for notes
    size: 8.5pt,
    style: "normal",
    weight: "regular"
  )
)

#let setup(
  paper-size: "us-letter",
  font-size: 10pt,
  alternate: false,
  inner: auto,
  outer: auto,
  vertical: auto,
  // clearance: 7.5pt,
  clearance: 8pt,
  text-style: auto,
  doc
) = {
  _paper-size.update(lower(paper-size))
  _font-size.update(font-size)
  if lower(paper-size) == "us-letter" {
    inner = (
      far: 5.7mm,
      width: 15mm,
      sep: 5mm
    )
    outer = (
      far: 5.7mm,
      width: 50mm,
      sep: 5mm
    )
    vertical = 25.7mm
  } else if lower(paper-size) == "a4" {
    inner = (
      far: 5mm,
      width: 15mm,
      sep: 5mm
    )
    outer = (
      far: 5mm,
      width: 50mm,
      sep: 5mm
    )
    vertical = 25mm
  } else {
    panic("unsupported paper size: " + _paper-size.get())
  }

  show: marginalia.setup.with(
    alternate: alternate,
    inner: inner,
    outer: outer,
    top: vertical,
    bottom: vertical,
    clearance: clearance
  )

  set figure(gap: 0pt)

  show figure.where(kind: image): set figure.caption(position: top)
  show figure.caption.where(kind: image): marginalia.note.with(
    alignment: "top",
    counter: none,
    shift: "avoid",
    keep-order: true,
    text-style: (
      size: 0.85 * font-size,
      style: "normal",
      weight: "regular"
    )
  )

  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption.where(kind: table): marginalia.note.with(
    alignment: "top",
    counter: none,
    shift: "avoid",
    keep-order: true,
    text-style: (
      size: 0.85 * font-size,
      style: "normal",
      weight: "regular"
    )
  )

  show figure.where(kind: raw): set figure.caption(position: bottom)

  doc
}

// NOTE IN OUTER MARGIN WITH NUMBERING
// USAGE: #marginalis(...)[my note here]
#let marginalis( ..args ) = {
  context marginalia.note(
    side: "outer",
    alignment: "baseline",
    counter: counter("marginalis-page-" + str(here().page())),
    numbering: (..i) => super(numbering("1", ..i)),
    link-anchor: true,
    text-style: (
      size: 0.85 * _font-size.get(),
      style: "normal",
      weight: "regular",
    ),
    ..args
  )
}

// NOTE IN OUTER MARGIN WITHOUT NUMBERING
// USAGE: #marginale(...)[my note here]
#let marginale( ..args ) = {
  context marginalia.note(
    side: "outer",
    alignment: "baseline",
    counter: none,
    numbering: none,
    anchor-numbering: none,
    text-style: (
      size: 0.85 * _font-size.get(),
      style: "normal",
      weight: "regular"
    ),
    ..args
  )
}

// NOTE IN INNER MARGIN WITHOUT NUMBERING
// USAGE: #apostille(...)[my note here]
#let apostille( ..args ) = {
  context marginalia.note(
    side: "inner",
    alignment: "baseline",
    counter: none,
    numbering: none,
    anchor-numbering: none,
    text-style: (
      size: 0.85 * _font-size.get(),
      style: "italic",
      weight: "regular"
    ),
    ..args
  )
}

// SMALL FIGURE IN OUTER MARGIN
// USAGE: #illumination( image(...), caption: "my caption here" )
#let illumination(..args) = {
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: image): set figure.caption(position: bottom)
  context marginalia.notefigure(
    side: "outer",
    alignment: "caption-top",
    text-style: (
      size: 0.85 * _font-size.get(),
      style: "normal",
      weight: "regular"
    ),
    show-caption: (number, caption) => {
      box(width: 100%, {
        number
        caption.supplement
        [ ]
        caption.counter.display(caption.numbering)
        caption.separator
        caption.body
      })
    },
    ..args
  )
}
// #let illumination = marginalia.notefigure.with(alignment: "caption-top")

#let fullblock(body) = {
  wideblock(
    box(
      width: 100%,
      inset: (
        top: 0pt,
        bottom: 0pt,
        left: 0pt,
        right: 2cm,
      )
    )[#body]
  )
}
