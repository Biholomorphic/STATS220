// #let headingArray = ()
#let s = state("x", (0,))
#let cheatSheet(
  title: "",
  blackNWhite: false,
  doc,
) = {
  set document(title: title)
  set page(
    paper: "a4",
    margin:(
      6.34mm
    )
  )
  set heading(
    numbering: "1.a.I"
  )


  let mine = counter("my counter")
  mine.update(())

  let countArray = (0,)

  let countUp(part) = {
    // let array = (0,0,0)
    let parent = part.at(0)
    // mine.at(0)
    [#parent]
    [#mine.get()]
    if mine.get() == none{
      [nononene]
    } else {
      [something]
    }
    [\ test: #part : #mine.get()]
    mine.update(part)
  }
  let increaseCount(headerNum, array) = {
    let parent = headerNum.at(0) -1
    let child = headerNum.at(1)
    // [#parent #child]
    let newCount = array
    if(newCount.at(parent, default: -1) == 0) { // change the value at a position
      newCount.pop()
      newCount.push(child)
      // count.at(headerNum.at(0), default: 0)
    } else { // add a new value to the thingy

      // newCount.push(12)  
      newCount.push(child)  
    }
    return (newCount)
    // return(parent, child)
    // return(newCount.at(parent, default: -1))
  }
  let findColour(test) = {
    mine.final()
  }
  show heading.where(level: 1): it => [
    // #mine.update(1)
    #rect([#it.body ], width:100%,fill: red, radius: .5em)
  ]

  let arrayManage(hArray, index, newItem) = {
    if hArray != none{
    if hArray.at(index, default:-1) == -1 {
      hArray.push(newItem)
    } else {
    hArray.remove(index)
    hArray.insert(index, newItem)
    }
    return hArray
  }}

  show heading.where(level: 2): it => [
    #rect(it.body, width:100% -2em,fill: red, radius: .5em)
    // #countArray
    // #let headingArray = s.get()
    #let vars = counter(heading).get()
    vars: #vars
    before: #s.get()
    function:#s.update(arrayManage(s.get(), vars.at(0)- 1, vars.at(1)+1))
    after: #s.get()
    // #context s.update(headingArray)
  ]
  doc
  
}