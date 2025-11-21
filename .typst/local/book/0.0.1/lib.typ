#import "@local/colors:0.0.1": *
#import "@local/defs:0.0.1": *

#import "@preview/marge:0.1.0": sidenote

#let page-margin-right = (3.125in, 2.525in).at(0)
#let fullwidth(content) = block(width: 100.0% + (page-margin-right - 1.0125in), content)

#let apostille = sidenote.with(dy: 1.0pt, numbering: none, side: left, format: it => {
  set align(right)
  set text(style: "italic", size: 9.0pt)
  it.default
})
#let marginale = sidenote.with(
  dy: 1.0pt,
  numbering: none,
  padding: (
    left: 2.0em,
    right: 5.0em
  )
)
#let marginalis = sidenote.with(
  dy: 1.0pt,
  numbering: "1",
  padding: (
    left: 2.0em,
    right: 5.0em
  )
)

#let serif(size: 11.0pt) = (
  font: "ETbb",
  size: size,
  fill: color.light.fg1,
  number-type: "old-style",
  number-width: "proportional",
)

#let sans-serif(size: 11.0pt, tracking: 6.0pt, max-size: 48.0pt) = (
  font: "Gill Sans",
  size: size,
  fill: color.light.fg1,
  tracking: if tracking == 0.0pt {
    0.0pt
  } else {
    float(repr(tracking).split("p").at(0)) * float(repr(size).split("p").at(0)) / 48.0 * 1.0pt
  }
)

#let monospace(size: 11.0pt) = (
  font: "TX-02",
  size: size,
  fill: color.light.fg1,
)

#let coverauthorblock(author) = {
  place(top + left, {
    set text( ..sans-serif(size: 20.0pt) )
    align(left, upper(author))
  })
}

#let covertitleblock(title: none) = {
  place(horizon + left, {
    set text( hyphenate: false, ..sans-serif(size: 48.0pt) )
    v(1.0fr)
    for word in title.split() {
      [#upper(word)]
      v(- 32.0pt)
    }
    v(2.0fr)
  })
}

#let coverdateblock(publisher, date) = {
  place(bottom + center, {
    set text( ..sans-serif(size: 14.0pt) )
    if publisher != none {
      [#upper(publisher) #h(1.0fr) #upper(displaydate(date))]
    } else {
      [#h(1.0fr) #upper(displaydate(date))]
    }
  })
}

#let matter_front(doc) = {
  set page(numbering: "i")
  doc
}

#let matter_main(doc) = {
  set page(
    numbering: "1",
    header: context {
      set align(right)
      set text( ..serif() )
      smallcaps(lower(document.title))
      // if counter(page).get().first() > 1 {
      //   if shorttitle != none {
      //     smallcaps(lower(shorttitle))
      //   } else {
      //     smallcaps(lower(title))
      //   }
      // }
    },
    // footer: context {
    //   if type(footer) == array {
    //     footer.at(1)
    //     linebreak()
    //   } else {
    //     footer
    //     linebreak()
    //   }
    // },
  )

  doc
}

#let matter_back(doc) = {
  set page(
    numbering: "i",
  )
  doc
}

#let part(title) = {
  page(header: none, footer: none)[
    #place(horizon + left, {
      v(1.0fr)
      figure(
        kind: "part",
        supplement: none,
        title
      )
      v(2.0fr)
    })
  ]
}

#let book(
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
    fill: if paper_color == "natural" { color.misc.natural } else { color.misc.bleached },
    number-align: center,
    // numbering: none,
    header: none,
    footer: none,
  )

  set par(
    justify: true,
    // leading: 0.65em,
    // spacing: 0.65em,
    // first-line-indent: 1.0em,
  )

  // show quote: set text(style: "italic")
  show quote: set text( ..serif(size: 10.0pt), style: "italic" )
  show quote: set pad(left: 1in, right: 0in)
  set quote(block: true)
  show quote.where(block: true): it => {
    set par(justify: false)
    set align(left)
    set text( ..serif(size: 10.0pt) )
    pad(
      left: 1.0in,
      right: 0.0in,
      text(style: "italic", llap[\u{201C}] + it.body + [\u{201D}])
      + linebreak()
      + h(1.0fr) + text(size: 9.0pt, style: "normal", [--- ] + it.attribution)
    )
  }

  set text( ..serif() )
  show raw: set text(font: "TX-02")
  // show raw: set text(font: "TX-02", size: 1.0em)

  show figure: set figure.caption(separator: [.#h(0.5em)])
  show figure.caption: set align(left)
  show figure.caption: set text( ..serif() )

  set enum(indent: 1.0em, body-indent: 1.0em)
  show enum: set par(justify: false)

  set list(indent: 1.0em, body-indent: 1.0em)
  show list: set par(justify: false)

  // show figure.where(kind: table): set figure(numbering: "I")
  show figure.where(kind: table): set figure(supplement: [Tab.], numbering: "1")
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: image): set figure(supplement: [Fig.], numbering: "1")
  // show figure.where(kind: image): set figure.caption(position: bottom)
  show figure.where(kind: raw): set figure(supplement: [Alg.], numbering: "1")
  show figure.where(kind: raw): set figure.caption(position: top)
  show figure.where(kind: "part"): set text( ..serif(size: 24.0pt), style: "italic", weight: "bold" )

  coverauthorblock(author)
  covertitleblock(title: title)
  coverdateblock(publisher, date)

  pagebreak()

  place(bottom + left, [
    #set text(size: 11.0pt)
    These notes are intended for #raw("CS173") at the University of Illinois Urbana-Champaign. \
    Copyright #sym.copyright #date.display("[year]") Daniel Gonzalez Cedre
  ])

  pagebreak()

  // set heading(numbering: "1.1")
  // show heading.where(level: 2): it => {
  //   v(1.3em, weak: true)
  //   text(size: 13.0pt, weight: "regular", style: "italic", it)
  //   v(1.0em, weak: true)
  // }
  // show heading.where(level: 3): it => {
  //   v(1.0em, weak: true)
  //   text(size: 11.0pt, style: "italic", weight: "thin", it)
  //   v(0.65em, weak: true)
  // }

  show heading.where(level: 1): it => {
    set text( ..serif(size: 22.0pt), style: "italic" )
    block(
      v(32.0pt + 48.0pt)
      + it.body
    )
  }
  show outline.entry.where(level: 1): set block(above: 32.0pt, below: 12.0pt)
  show outline.entry.where(level: 1): set text( ..serif(size: 16.0pt), style: "italic", weight: "bold" )
  show outline.entry.where(level: 1): it => link(
    it.element.location(),
    it.indented(
      it.prefix(),
      [ #it.body() #h(1.0fr) #text(style: "normal", it.page()) ]
    ),
  )
  show outline.entry.where(level: 2): set block(above: 8.0pt, below: 8.0pt)
  show outline.entry.where(level: 2): set text( ..serif(size: 11.0pt), style: "italic", weight: "bold" )
  show outline.entry.where(level: 2): it => link(
    it.element.location(),
    it.indented(
      it.prefix(),
      [ #it.body() #h(1.0fr) #text(style: "normal", it.page()) ]
    ),
  )
  show outline.entry.where(level: 3): set block(above: 8.0pt, below: 8.0pt)
  show outline.entry.where(level: 3): set text( ..serif(size: 11.0pt), style: "italic", weight: "regular" )
  show outline.entry.where(level: 3): it => link(
    it.element.location(),
    it.indented(
      hide(it.prefix()),
      [ #it.body() #h(1.0fr) #text(style: "normal", it.page()) ]
    ),
  )

  outline(depth: 3, indent: 1.0em)

  counter(page).update(0)
  set page(
    margin: (right: page-margin-right, rest: auto),
    header: context {
      if query(selector(heading.where(level: 1))).filter(h => h.location().page() == here().page()).len() == 0 {
        // llap[#counter(page).display()#h(1.0em)] + smallcaps(lower(query(selector(heading.where(level: 1)).before(here())).last().body))
        fullwidth(
          smallcaps(lower(query(selector(heading.where(level: 1)).before(here())).last().body))
          + h(1.0fr)
          + counter(page).display()
          + v(1.0em)
        )
        // fullwidth(
        //   smallcaps(lower(query(selector(heading.where(level: 1)).before(here())).last().body))
        //   + h(1.0fr)
        //   + counter(page).display()
        //   + v(1.0em)
        // )
        // fullwidth(
        //   smallcaps(lower(title))
        //   + h(1.0fr)
        //   + smallcaps(lower(query(selector(heading.where(level: 1)).before(here())).last().body))
        //   + "    "
        //   + counter(page).display()
        //   + v(1.0em)
        // )
      }
    }
  )

  set heading(
    numbering: (..nums) => ( nums.pos().slice(0, 1).map(x => x - 1) + nums.pos().slice(1,) ).map(str).join(".")
  )

  show heading.where(level: 1): it => {
    set text( ..serif(size: 22.0pt), style: "italic", weight: "bold" )
    block(
      below: 18.0pt,
      v(32.0pt + 48.0pt)
      + counter(heading).display()
      + v(0.0pt)
      + it.body
    )
  }
  show heading.where(level: 2): it => {
    set text( ..serif(size: 13.0pt), style: "italic", weight: "bold" )
    block(
      above: 22.0pt,
      below: 16.0pt,
      llap[#counter(heading).display()#h(12.0pt)]
      + it.body
    )
  }
  // show heading.where(level: 1): it => {
  //   set text( ..serif(size: 22.0pt), style: "italic", weight: "bold" )
  //   v(32.0pt + 48.0pt)
  //   counter(heading).display()
  //   v(0.0pt)
  //   it.body
  //   v(0.0pt)
  // }
  // show heading.where(level: 2): it => {
  //   set text( ..serif(size: 13.0pt), style: "italic", weight: "bold" )
  //   [ #llap[#counter(heading).display()#h(12.0pt)]#it.body #v(0.0pt) ]
  // }
  show heading.where(level: 3): it => {
    set text( ..serif(size: 11.0pt), style: "italic", weight: "regular" )
    block(
      llap[#counter(heading).display()#h(12.0pt)]
      + it.body
    )
  }

  // show quote: it => {
  //   it
  // }

  show link: set text(luma(50))

  doc

  show bibliography: set text( ..serif(size: 9.0pt) )
  show bibliography: set par(justify: false)
  set bibliography(title: none)
  if bib != none {
    heading(level: 1, [Bibliography])
    bib
  }
}

// #let sidenotecounter = counter("sidenotecounter")
// #let sidenote(dy: - 2.0em, numbered: true, content) = {
//   set text( ..serif(size: 9.0pt) )
//   if numbered {
//     sidenotecounter.step()
//     text(weight: "bold", super(sidenotecounter.display()))
//   }
//   // margin-note
//   if numbered {
//     super(sidenotecounter.display())
//   } else {
//     content
//   }
// }
