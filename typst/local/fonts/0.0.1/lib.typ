#import "@local/colors:0.0.1": color

#let sans-track(size: 11.0pt, tracking: 12.0pt, max-size: 48.0pt) = {
  return float(repr(tracking).split("p").at(0)) * float(repr(size).split("p").at(0)) / 48.0 * 1.0pt
}

#let fonts = (
  sans: (
    font: "Gill Sans",
    fill: color.off.black,
    tracking: sans-track()
  ),
  serif: (
    font: "ETbb",
    fill: color.off.black,
    number-type: "old-style",
    number-width: "proportional",
  ),
  mono: (
    font: "TX-02",
    fill: color.off.black,
  ),
  frak: (
    font: "KJV1611",
    fill: color.off.black,
  ),
  sizes: (
    titles: 1.0em,
    theorems: 1.0em,
    cases: 0.9em,
  ),
)

#let sans = text.with( ..fonts.sans )
#let serif = text.with( ..fonts.serif )
#let mono = text.with( ..fonts.mono, size: (10 / 11) * 1.0em )
#let fraktur = text.with( ..fonts.frak )

// #set text( ..font-serif, size: 11.0pt )
// // #show math.equation: set text( ..font-mono, size: 11.0pt )
// #show raw: set text( ..font-mono, size: 9.0pt )
// // #show math.text: text.with( ..font-serif, size: 11.0pt )
