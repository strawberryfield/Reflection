Reflection by Roberto Ceccarelli begins here.

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

Chapter Listing verbs

Listing verbs is an action out of world.
Understand "verbs" as listing verbs.
Understand the command "commands" as "verbs".

Report listing verbs:
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
			let num-actions be the number of grammar lines for cmd-alias;
			say "[roman type]: [line break]";
			let skip next be false;
			repeat with x running from 1 to num-actions:
				if skip next is false, say "- [italic type][action name for cte][roman type][line break]";
				let O be action number of cte;
				let cte be the next command table entry of cte;
				let skip next be false;
				let A be action number of cte;
				if O is A, let skip next be true.

Chapter Listing dictionary

Listing dictionary is an action out of world.
Understand "dictionary" as listing dictionary.

Report listing dictionary:
	repeat with d running through the dictionary entries:
		say "[bold type][d][roman type]: ";
		if d is meta-entry, say "meta ";
		if d is verb-entry, say "verb ";
		if d is preposition-entry, say "preposition ";
		if d is noun-entry, say "noun ";
		if d is plural-entry, say "[italic type](plural)[roman type]";
		say line break.

Reflection ends here.

---- DOCUMENTATION ----

Example: * Reflection - Listing verbs.

	*: "Listing verbs"
	
	Include reflection by Roberto Ceccarelli.
	
	Lab is a room.
	
	Test me with "verbs".
	

Example: * Reflection - Listing dictionary.

	*: "Listing dictionary"
	
	Include reflection by Roberto Ceccarelli.
	
	Lab is a room.
	
	Test me with "dictionary".

