proc readFile {} {
    #checks if file exists if so it reads it's data
    if {[file exists input.txt]} {
        set fp [open "input.txt" r]
        set lines [split [read $fp] "\n"]
        close $fp
        return $lines
    } else {
        puts "File doesn't exist"
        return 0
        }}

        proc primeTest n {
            #check if a number is a prime
            set max [expr {wide(sqrt($n))}]
            if {$n%2==0} {return 0}
            for {set i 3} {$i<=$max} {incr i 2} {
                if {$n%$i==0} {return 0}
            }
            return 1
        }


        proc main {} {
            #splits the file and checks the given rules
            set lines [readFile]
            if {[string is false $lines]} {return}
            set counters [dict create prime 0 composite 0 strings 0 invalid 0]
            set firstTwoIntegerSummattion [dict create summation 0]
            set concantedString ""
            set maxValue [expr {-2**31}]
            set maxValueString 0


            foreach line $lines {
                set splitLine [split $line " "]
                set firstPart [lindex $splitLine 0]
                set firstChar [string index $firstPart  0]
                #check if the first part of each line is a whole number
                if {[string is integer $firstPart] && ![string is space $firstPart]} {
                    # print the first two integers found
                    if { [expr [dict get $counters prime] + [dict get $counters strings]  ] <=2 } {
                        dict incr firstTwoIntegerSummattion summation $firstPart;
                    }
                    #finds the largest integer in the file
                    if {[expr [dict get $counters prime] + [dict get $counters composite]]==0} {
                        set maxValue $firstPart
                        set maxValueString $line
                    }
                    if {[expr $maxValue < $firstPart]} {
                        set maxValue $firstPart
                        set maxValueString $line
                    }

                    set primeCheck [primeTest $firstPart]
                    if {$primeCheck} {
                        puts [expr {$firstPart / 2.0}]
                        dict incr counters prime;

                    } else  {
                        puts [expr {$firstPart * 3.75}]
                        dict incr counters composite;
                    }
                    #checks if the first character is a string
                } elseif {[string is alpha $firstChar] && ![string is space $firstPart]} {

                    if { [expr [dict get $counters strings]] <= 3 } {
                        set concantedString "$concantedString$line"
                    }
                    puts $line
                    dict incr counters strings;
                } else {
                    puts "INVALID LINE"
                    dict incr counters invalid;
                }
            }
            report $lines $counters $firstTwoIntegerSummattion $concantedString $maxValueString $maxValue

        }





        proc report {lines counters firstTwoIntegerSummattion concantedString maxValueString maxValue} {
            #prints a general report about the file
            set minLineLength [expr 2**31]
            puts "------------------------------"
            foreach item [dict keys $counters] {
                set value [dict get $counters $item]
                puts "$item had a total of $value occurrences"
            }
            puts "summation of the first two integers is [dict get $firstTwoIntegerSummattion summation]"
            puts "$concantedString"

            puts "------------------------------"
            foreach line $lines {
                set lineLength [string length $line]
                puts "$line length of the line $lineLength \n"
                if {![string is space $line]} {

                    if {[expr $lineLength < $minLineLength]} {

                        set minLineLength $lineLength
                    }
                }
            }
            puts "------------------------------"

            puts "Line with maximum integer value found in the file is \" $maxValueString \" with length of $maxValue characters"
            puts "Minimum length of \"non-empty string\" in the whole file $minLineLength"


        }


        main
