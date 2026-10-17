#import "fonts.typ" as fonts
#import "colors.typ" as colors

// #let define = text.with(fill: luma(25%), style: "italic", weight: "bold")
// #let define = text.with(style: "italic", weight: "bold")
#let define(end: "", style: "italic", weight: "bold", ..args, it) = {
  if end != "" {
    [#text(style: style, weight: weight, ..args)[#it]#text(style: style)[#end]]
  } else {
    [#text(style: style, weight: weight, ..args)[#it]]
  }
}

#let hyperlink( ..args ) = text(
  style: "italic",
  fill: colors.blue,
)[#link( ..args )]

#let url( ..args ) = text(
  ..fonts.select("TX-02"),
  fill: colors.blue,
  // size: (9 / 10) * 1.0em,
)[#link( ..args )]

#let circa = [_ca._]  // CIRCA
#let ca = [_ca._]  // CIRCA
#let cf = [_cf._]  // CONFERRE
#let Eg = [_E.g.,_]  // EXEMPLI GRATIA
#let eg = [_e.g.,_]  // EXEMPLI GRATIA
#let etal = [_et al._]  // ET ALII
#let etc = [_etc._]  // ET CETERA
#let ibid = [_ibid._]  // IBIDEM
#let Ie = [_I.e.,_]  // ID EST
#let ie = [_i.e.,_]  // ID EST
#let NB = [_N.B._]  // NOTA BENE
#let nb = [_n.b._]  // NOTA BENE
#let qv = [_q.v._]  // QUOD VIDE
#let qqv = [_qq.v._]  // QUAE VIDE
#let sl = [_s.l._]  // SENSU LATO
#let ss = [_s.s._]  // SENSU STRICTO
#let vide = [_vide_]  // VIDE
#let viz = [_viz._]  // VIDELICET
#let vs = [_vs._]  // VERSUS
#let BC = smallcaps("bc")
#let AD = smallcaps("ad")

#let diacritic = (
  grave: (
    single: x => x + "\u{300}",
    double: x => x + "\u{30F}"  // NOT SUPPORTED
  ),
  acute: (
    single: x => x + "\u{301}",
    double: x => x + "\u{30B}"
  ),
  dot: (
    over:   x => x + "\u{307}",
    double: x => x + "\u{308}",
    under:  x => x + "\u{323}"
  ),
  umlaut:   x => x + "\u{308}",
  diaresis: x => x + "\u{308}",
  tilde: x => x + "\u{303}",
  circumflex: x => x + "\u{302}",
  caron: x => x + "\u{30C}",  // NOT SUPPORTED
)

// #let sc(it) = {
//   show regex("([A-Z,a-z])+"): it => { smallcaps(lower(it)) }
//   it
// }

#let llap(margin: 0pt, it) = {
  box(width: 0.0pt)[
    #h(-100cm)#h(1.0fr)#it#h(margin)
  ]
}

#let nth(num) = {
  num = int(num)
  let rem = calc.rem(num, 10)
  if num not in (11, 12, 13) {
    if rem == 1 { return str(num) + super[st] }
    if rem == 2 { return str(num) + super[nd] }
    if rem == 3 { return str(num) + super[rd] }
  }
  return str(num) + super[th]
}

#let display-date(date, short: false, long: false, year: true) = {
  if year {
    let year = date.display("[year]")
    let month = date.display("[month repr:long]")
    let day = date.display("[day padding:none]")
    if short {
      return month + " " + day + ", " + year
    } else if long {
      return nth(day) + " day of " + month + " of the year of our Lord " + year
    } else {
      return nth(day) + " of " + month + ", " + year
    }
  } else {
    let month = date.display("[month repr:long]")
    let day = date.display("[day padding:none]")
    if short {
      return month + " " + day
    } else if long {
      return nth(day) + " day of " + month
    } else {
      return nth(day) + " of " + month
    }
  }
}

#let display-day(date) = nth(date.display("[day padding:none]"))
#let display-month(date) = date.display("[month repr:long]")
#let display-year(date) = date.display("[year]")
