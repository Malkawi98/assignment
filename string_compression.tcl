proc stringCompress {input} {
    #stringCompress returns the shortest of abbreviated characters of a string or the original string
    # :input is the given string
    set size  [string length $input]
    if {$size <= 1} {
        return "$input$size"
    }
    set counter 1
    set output ""
    for {set index 1} {$index < $size} {incr index} {

        if {[string index $input $index] == [string index $input [expr {$index -1}]]} {
            incr counter
        } else {
            set temp [string index $input [expr {$index -1}]]
            set output "$output$temp$counter"
            set counter 1
        }
    }
    set temp [string index $input [expr {$size -1}]]
    if {$counter > 0} {
        set output "$output$temp$counter"
    }
    return $output

}
  puts "Enter a text to compress"
  gets stdin testString
  set originalSize [string length $testString]
  set compressed [stringCompress $testString]
  set sizeCompressed [string length $compressed]
  if {$originalSize <= $sizeCompressed} {
      puts $testString  
  } else {
      puts $compressed
  }
