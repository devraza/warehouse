#let conf(title: none, doc) = {
  show link: underline
  show raw: set text(font: "Iosevka Comfy")
  set text(
    font: "EtBembo",
    size: 10pt
  )
  set page(
    paper: "a4",
    margin: 1cm,
  )
  set par(
    justify: true,
    leading: 0.52em,
  )
  align(left, text(font: "EtBembo", size: 24pt, weight: 900)[
    #title
  ])
  line(length: 70%)

  set align(left)
  doc
}
