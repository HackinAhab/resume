// Function sets the document characteristics and builds the header.  Parameters
// override cli arguments.
//
// If no parameters are included, will be populated from cli key value arguments in the form:
//   ` typst compile doc.typ --input key=value `
#let conf(title: none, author: none, email: none, linkedin: none, github: none, doc) = {

  let title = { if title == none { sys.inputs.at("title", default: "Default Title")} }
  let author = { if author == none { sys.inputs.at("author", default: "Default Author") } }
  let email = { if email == none { sys.inputs.at("email", default: "mailto:spam@example.com") } }
  let linkedin = { if linkedin == none { sys.inputs.at("linkedin", default: "https://www.linkedin.com/") } }
  let github = { if github == none { sys.inputs.at("github", default: "https://github.com") }}

  set document(author: author, title: "resume")
  set text(
    font: "IBM Plex Sans",
    size: 11pt,
    lang: "en"
  )

  set page(
    margin: (x: 5em, y: 4em)
  )

  set align(left + top)
  
  align(center)[
    #show: text(weight: 700, 1.75em, title)
  ]
  align(center)[
    #show: text((link(linkedin)[LinkedIn],link(email),link(github)[Github]).join("  |  "))
  ]
  set par(justify: true)
  doc
}

// Returns a horizontal line across the page to divide sections
// -> str
#let chiline() = {v(-3pt); line(length: 100%); v(-5pt)}

// Creates an entry paragraph
#let entry_par(company, title, date, bullets) = {
  text(
    weight: "bold",
    company
  )
  box(
    width: 1fr,
    align(
       alignment.right,
       date
    )
  )
  "\n"
  title
  "\n"
  list(
    ..bullets
  )
}

// Creates a resume body entry such as job or project
#let entry(company, title, date, bullets) = {
  par(
    leading: 0.60em,
    entry_par(company, title, date, bullets)
  )
}


// Creates a certifications entry
#let cert(bullets) = {
  par(
    leading: 0.60em,
    list(
      ..bullets
    )
  )
}

// Creates a degree entry
#let degree(school, degree, graduation_date, additional: "") = {
  text(
    weight: "bold",
    school
  )
  "\n"
  text(
    style: "italic",
    degree
  )
  box(
    width: 1fr,
    align(
      alignment.right,
      graduation_date
    )
  )
  additional
}

#let skill_entry(skills) = {
  list(
    ..skills
  )
}

// Entry for skills
#let skills_block(skills) = {
  box(height: 40pt,
  columns(2, gutter: 11pt)[
    #set par(justify: true)
    #show: skill_entry(skills)
  ]
  )
}