Version 1 of Reflection by The Strawberry Field begins here.

[
Reflection © 2025 by Roberto Ceccarelli - The Strawberry Field 
is licensed under CC BY-NC-SA 4.0. 
To view a copy of this license, 
visit https://creativecommons.org/licenses/by-nc-sa/4.0/

Reflection by The Strawberry Field is free software: 
you can redistribute it and/or modify it
under the terms of the Creative Commons BY-NC-SA license.

Reflection is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
See the license for more details.
]

Book Dictionary

Include Lexicography (for glulx only) by Zed Lopez.

Chapter API

Include  (- 
[ReadShortInt addr ret;
	ret = addr->1 + addr->0 * $100;
	return ret;
];
-)

To decide what number is action number of (a - command-table-entry): (- ReadShortInt({a}) & $3ff -)

To decide if action of (a - command-table-entry) is reversed: (- ((ReadShortInt({a}) & $400) ~= 0) -)

To decide what command-table-entry is the next command table entry of (a - command-table-entry): (- UnpackGrammarLine({a}) -)

Include (-
[ PrintGrammarLines address lines;
lines = address->0;
address++;
while (lines > 0) {
  address = UnpackGrammarLine(address);
  PrintGrammarLine();
  print "^";
  lines--;
}
];

[ PrintGrammarLine pcount;
	print " * ";
	for (:((line_token-->(pcount)) ~= ENDIT_TOKEN):(pcount)++) {
		if (((((line_token-->(pcount))->(0)))&(16))) {
			print "/ ";
		}
		PrintToken((line_token-->(pcount)));
		print " ";
	}
	print "-> ";
	style underline;
	SayActionName(action_to_be);
	if (action_reversed) {
		print " (with nouns reversed)";
	}
	style roman;
];
[ PrintToken token;
	AnalyseToken(token);
	switch (found_ttype) {
		ILLEGAL_TT:
			print "<illegal token number ";
			print token;
			print ">";
			;
		ELEMENTARY_TT:
			switch (found_tdata) {
				NOUN_TOKEN:
					print "[something]";
					;
				HELD_TOKEN:
					print "[something preferably held]";
					;
				MULTI_TOKEN:
					print "[things]";
					;
				MULTIHELD_TOKEN:
					print "[things preferably held]";
					;
				MULTIEXCEPT_TOKEN:
					print "[other things]";
					;
				MULTIINSIDE_TOKEN:
					print "[things inside]";
					;
				CREATURE_TOKEN:
					print "[someone]";
					;
				SPECIAL_TOKEN:
					print "[special]";
					;
				NUMBER_TOKEN:
					print "[number]";
					;
				TOPIC_TOKEN:
					print "[text]";
					;
				ENDIT_TOKEN:
					print "END";
					;
			}
			;
		PREPOSITION_TT:
			print (address) found_tdata;
			;
		ROUTINE_FILTER_TT:
			print "[something specific]";
			;
		ATTR_FILTER_TT:
			DebugAttribute(found_tdata);
			;
		SCOPE_TT:
			print "[something in specific scope]";
			;
		GPR_TT:
			print "Routine(";
			print found_tdata;
			print ")";
			;
	}
];
-).

To say grammar lines content of/for/-- (c - command-table-entry): (- PrintGrammarLines({c}-1); -)


Chapter Listing verbs

Listing verbs is an action out of world.
The listing verbs action translates into Inter as "VerbsList".
Understand "verbs" as listing verbs.
Understand the command "commands" as "verbs".

Report listing verbs (this is the report listing verbs rule):
	repeat with v running through the dictionary entries:
		unless v is verb-entry, next;
		if v is meta-entry, next;
		let cmd-alias be the command verb of v;
		let cte be the command table entry for cmd-alias;
		let cmd-action be the action name for cte;
		if "[cmd-action]" exactly matches the text "", next;
		say "[bold type][v][roman type]";
		unless "[v]" exactly matches the text "[cmd-alias]":
			say " [italic type](same as [roman type][cmd-alias][italic type]) [roman type][line break]";
		otherwise:
			say "[roman type]: [line break]";
			say "[grammar lines content for cte]".
				
Chapter Listing dictionary

Listing dictionary is an action out of world.
The listing dictionary action translates into Inter as "DictionaryList".
Understand "dictionary" as listing dictionary.

Report listing dictionary (this is the report listing dictionary rule):
	repeat with d running through the dictionary entries:
		say "[bold type][d][roman type]: ";
		if d is meta-entry, say "meta ";
		if d is verb-entry, say "verb ";
		if d is preposition-entry, say "preposition ";
		if d is noun-entry, say "noun ";
		if d is plural-entry, say "[italic type](plural)[roman type]";
		say line break.

Book Versions

To say story serial number: (- PrintSerialNumber(); -).
Include (-
[ PrintSerialNumber i;
	for (i=0 : i<6 : i++) print (char) ROM_GAMESERIAL->i;
];
-).

To say inform7 version: (- PrintI6Text(I7_VERSION_NUMBER); -).

To say inform6 version: (- PrintI6Version(); -).
Include (-
[ PrintI6Version i;
	for (i=0 : i<4 : i++) print (char) ROM_INFORMVERSION->i;
];
-).

To say debug mode:  (- 
print "";
#ifdef DEBUG;
print " / D";
#endif; 
-)

[---]
Reflection ends here.

---- DOCUMENTATION ----

Example: * Reflection - Listing verbs.

	*: "Listing verbs"
	
	Include reflection by The Strawberry Field.
	
	Lab is a room.
	
	Test me with "verbs".
	

Example: * Reflection - Listing dictionary.

	*: "Listing dictionary"
	
	Include reflection by The Strawberry Field.
	
	Lab is a room.
	
	Test me with "dictionary".


Example: * Reflection - Versions.

	*: "Versions"
	
	Include reflection by The Strawberry Field.
	
	Lab is a room.
	The serial is here. The description is "Story serial number is: [story serial number]".
	The inform7 is here. The description is "Inform7 version: [inform7 version][debug mode]".
	The inform6 is here. The description is "Inform6 version: [inform6 version]".
	
	Test me with "x serial/x inform7/x inform6".

