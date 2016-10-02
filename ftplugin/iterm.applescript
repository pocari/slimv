#! /usr/bin/osascript

on theSplit(theString, theDelimiter)
    set oldDelimiters to AppleScript's text item delimiters
    set AppleScript's text item delimiters to theDelimiter
    set theArray to every text item of theString
    set AppleScript's text item delimiters to oldDelimiters
    return theArray
end theSplit

on IsModernVersion(version)
    set myArray to my theSplit(version, ".")
    set major to item 1 of myArray
    set minor to item 2 of myArray
    set veryMinor to item 3 of myArray
    
    if major < 2 then
        return false
    end if
    if major > 2 then
        return true
    end if
    if minor < 9 then
        return false
    end if
    if minor > 9 then
        return true
    end if
    if veryMinor < 20140903 then
        return false
    end if
    return true
end IsModernVersion

-- joinList from Geert Vanderkelen @ bit.ly/1gRPYbH
-- toDo push new terminal to background after creation
to joinList(aList, delimiter)
    set retVal to ""
    set prevDelimiter to AppleScript's text item delimiters
    set AppleScript's text item delimiters to delimiter
    set retVal to aList as string
    set AppleScript's text item delimiters to prevDelimiter
    return retVal
end joinList

on run arg
    set thecommand to joinList(arg, " ")
    tell application "iTerm"
        activate

        if my IsModernVersion(version) then
            set newWindow to (create window with default profile)
            tell current session of newWindow
                write text thecommand
            end tell
        else
            set myTerm to (make new terminal)
            tell myTerm
                set mysession to (launch session "Default")
                tell mysession
                    write text thecommand
                end tell
            end tell
        end if
    end tell
end run

