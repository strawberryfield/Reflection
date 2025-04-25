# Reflection

Commands to retrieve data from compiled glulx

## Introduction

In December 2024, Zed Lopez published on the infiction.org forum a small extension called [Lexicography](https://intfiction.org/t/getting-parser-info/72551/8?u=strawberryfield)
with which all words known to the parser could be extracted by type: verbs, nouns, prepositions...

Studying this code was very useful for learning some of the inner machinery of Inform and also an opportunity to learn how to work with Inform 6 at a low level.

In my work I build programs in the C# language, and I often make use of reflection APIs to access code properties that I cannot know at development time because they are interchangeable modules that are hooked up at run-time.

So, also taking advantage of Zed Lopez's extension, I created these functions that allow you to create updated documentation directly from compiled code.

This code is used by my game [Espresso Moka](https://strawberryfield.altervista.org/espressomoka/index.php?lang=en)

## Available functions

### Actions

#### Listing verbs

Listing verbs is an action out of world.  
The listing verbs action translates into Inter as "VerbsList".  
The specification of the listing verbs action is "Returns to the player a list of all the verbs recognised by the game as commands. For each one, it gives either the synonym or the list of related grammar lines.
The information is taken from the compiled tables, so no information about alternative words (separated by a slash) or object kinds filters can be provided.
This is an action out of world."

Understand "verbs" as listing verbs.  
Understand the command "commands" as "verbs".

#### Listing dictionary

Listing dictionary is an action out of world.  
The listing dictionary action translates into Inter as "DictionaryList".  
The specification of the listing dictionary action is "Returns to the player a list of all the words known by the game.
It was initially provided as an example of the extension ‘Lexicography’.
This is an action out of world."

Understand "dictionary" as listing dictionary.

### Sayable expressions

**grammar lines content of/for/-- (c - command-table-entry)**   
Prints the grammar lines for a given command

**story serial number**  
Prints the story serial number

**inform7 version**  
Prints the Inform7 compiler version

**inform6 version**  
Prints the Inform6 compiler version

**debug mode**  
Prints "/D" if the story is compiled in debug mode**

**IFID code**  
Prints the IFID of the game

**interpreter version**  
Prints the version of the running interpreter

**VM version**  
Prints the version of the running virtual machinery

**interpreter name**  
Prints the name of the running interpreter (if known)

## Documentation

See examples enclosed.
