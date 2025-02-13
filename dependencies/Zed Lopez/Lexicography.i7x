Version 1 of Lexicography (for glulx only) by Zed Lopez begins here.

"Dictionary utilities."
	
Include (-
[ ClobberDict x i j;
j = x + DICT_ENTRY_BYTES;
for ( i = x : i < j : i = i + 1 ) x->0 = 0;
];
-)

to clobber-dict-entry (d - dictionary-entry): (- ClobberDict({d}); -).

to clobber (t - text):
  let s be the substituted form of t;
  repeat with d running through the dictionary entries begin;
    if s is the substituted form of "[d]" begin;
      clobber-dict-entry d;
      break;
    end if;
  end repeat;


Include (-
global dictionaryStartAddr;
!Constant DICT_ENTRY_BYTES = (3 + DICT_WORD_SIZE) * 4;
Constant IS_VERB = 1;
Constant IS_META = 2;
Constant IS_PLURAL = 4;
Constant IS_PREPOSITION = 8;
Constant IS_BIT4 = 16;
Constant IS_BIT5 = 32;
Constant IS_BIT6 = 64;
Constant IS_NOUN = 128;
-)

Definition: a dictionary-entry is plural-entry if I6 condition "(((*1)->#dict_par1) & IS_PLURAL)" says so (its dict_par1 plural bit is set).
Definition: a dictionary-entry is meta-entry if I6 condition "(((*1)->#dict_par1) & IS_META)" says so (its dict_par1 meta bit is set).
Definition: a dictionary-entry is verb-entry if I6 condition "(((*1)->#dict_par1) & IS_VERB)" says so (its dict_par1 verb bit is set).
Definition: a dictionary-entry is preposition-entry if I6 condition "(((*1)->#dict_par1) & IS_PREPOSITION)" says so (its dict_par1 preposition bit is set).
Definition: a dictionary-entry is noun-entry if I6 condition "(((*1)->#dict_par1) & IS_NOUN)" says so (its dict_par1 noun bit is set).
Definition: a dictionary-entry is bit4-entry if I6 condition "(((*1)->#dict_par1) & IS_BIT4)" says so (its dict_par1 bit4 is set).
Definition: a dictionary-entry is bit5-entry if I6 condition "(((*1)->#dict_par1) & IS_BIT5)" says so (its dict_par1 bit5 is set).
Definition: a dictionary-entry is bit6-entry if I6 condition "(((*1)->#dict_par1) & IS_BIT6)" says so (its dict_par1 bit6 is set).

To init dict start addr: (- dictionaryStartAddr = #dictionary_table + WORDSIZE; -)

A command-verb is a kind of value. command-verb #0 specifies a command-verb.

command-verb-list is a list of command-verbs variable.

[first when play begins:]
after starting the virtual machine:
    init dict start addr;
    repeat with d running through the dictionary entries begin;
      unless d is a verb-entry, next;
      let cmd-verb be the command verb of d;
      now cmd-verb enverbenates d;
      let cmd-text be the substituted form of "[cmd-verb]";
    end repeat;
    now command-verb-list is the list of command-verbs that the verb-to-dict relation relates;

To decide what command-verb is the command verb of/for (d - dictionary-entry):
    (- DictionaryWordToVerbNum({d}) -)

A dictionary-entry is a kind of value. dictionary-entry #0 specifies a dictionary-entry.

To repeat for/with (v - nonexisting command-verb variable) running/-- through/in the/-- command verbs begin -- end loop:
    (-
 for ({-my:0} = (+ command-verb-list +), {-my:1} = 1, {v} = LIST_OF_TY_GetItem({-my:0}, 1) : {-my:1} < LIST_OF_TY_GetLength({-my:0}) : {-my:1}++, {v} = LIST_OF_TY_GetItem({-my:0}, {-my:1})  ) -)

To decide what dictionary-entry is the entry of/for (n - number): (- dictionaryStartAddr + DICT_ENTRY_BYTES * {n} -).

A grammar-line is a kind of value. grammar-line #0 specifies a grammar-line.

To decide what number is the number of grammar lines of/for/-- (v - command-verb):
  (- (VM_CommandTableAddress({v}))->0 -)

A command-table-entry is a kind of value. command-table-entry #0 specifies a command-table-entry.

To decide what command-table-entry is the command table entry of/for (d - command-verb): (- (VM_CommandTableAddress({d})+1) -)

Include (-

[ actionNameOf c d;
 @aloads c 0 d;
 return d;
 ];

-)

To decide what action name is the action name of/for (c - command-table-entry): (- actionNameOf({c}) -)

To decide what K is a/an/-- (unknown - a value) cast as a/an/-- (name of kind of value K): (- {unknown} -).

Verb-to-dict relates various command-verbs to various dictionary-entries.
The verb to enverbenate means the verb-to-dict relation.

action-to-verb relates one action name to various command-verbs.
The verb to enact means the action-to-verb relation.

action-to-grammar-line relates one action name to various grammar-lines.
The verb to topicalize means the action-to-grammar-line relation.

Command-verb-to-command-table-entry relates one command-table-entry to various command-verbs.
The verb to command-verb-tabulate means the command-verb-to-command-table-entry relation.


To say (d - dictionary-entry): (- print (address) {d}; -).

To say (v - command-verb):
  say the dictionary-entry to which v relates by the verb-to-dict relation;


To repeat for/with (d - nonexisting dictionary-entry variable) running/-- through/in the/-- dictionary entries begin -- end loop:
(- for ({-my:0} = 0, {d} = dictionaryStartAddr : {-my:0} < #dictionary_table-->0 : {-my:0}++, ({d} = {d} + DICT_ENTRY_BYTES) ) -)


Definition: an object is originally publicly-named rather than originally privately-named if I6 condition "(*1).#name" says so (it has automatically-generated dictionary entries).

To repeat for/with (d - nonexisting dictionary-entry variable) running/-- through/in the/-- dictionary entries for/of (o - object) begin -- end loop:
(- for ({-my:0} = 0, {d} = {o}.&name-->0 : {-my:0} < ({o}.#name/WORDSIZE) : {-my:0}++, {d} = {o}.&name-->{-my:0}) -)

Include (-
[ WordID n o;
if (n < 0 or n >= o.#name/WORDSIZE) return 0;
return o.&name-->(n - 1);
];
-)

[ TODO better name ]
To decide what dictionary-entry is understood word id (n - a number) of/for (o - object): (- WordID({n},{o}) -).

To decide what dictionary-entry is unsafe understood word id (n - a number) of/for (o - object): (- {o}.&name-->({n} - 1) -).

To decide what number is the number of understood words of/for (obj - object): (- ({obj}.#name)/WORDSIZE -)

to remove default kind-name plurals: (- objectloop(({-my:0} provides name) && 
  ({-my:0}.#name > WORDSIZE) && 
  ((({-my:0}.&name-->1)->#dict_par1) & IS_PLURAL))
    {-my:0}.&name-->1 = {-my:0}.&name-->0; -)

Lexicography ends here.

---- Documentation ----

yes, documentation sure would be nice.
