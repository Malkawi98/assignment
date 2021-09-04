proc uniqueList {listOfValues} {
  #uniqueList keeps the first recorded occurrences of a characters from a list
  # :listOfValues is the given list to be checked
  set unique {}
  foreach item $listOfValues {
    dict set unique $item ""
  }
return [dict keys $unique]
}

  set unique [uniqueList { 3 6 8 tx 3 7  1 4 tx 6 2 9 6 }]
  puts $unique