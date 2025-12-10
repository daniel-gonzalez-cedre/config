#let circa = [_ca._]
#let ca = [_ca._]
#let BC = smallcaps("bc")
#let AD = smallcaps("ad")

#let llap(body) = {
  box(width: 0.0pt)[#h(-100cm)#h(1.0fr)#body]
}

#let nth(num) = {
  let rem = calc.rem(num, 10)
  if num not in (11, 12, 13) {
    if rem == 1 { return str(num) + super[st] }
    if rem == 2 { return str(num) + super[nd] }
    if rem == 3 { return str(num) + super[rd] }
  }
  return str(num) + super[th]
}

#let displaydate(date) = {
  let year = date.display("[year]")
  let month = date.display("[month repr:long]")
  let day = date.display("[day padding:none]")
  return nth(date.day()) + " of " + month + ", " + year
}
