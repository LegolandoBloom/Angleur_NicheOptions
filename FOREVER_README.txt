A majority of Addons cannot save user preferences right now, due to a bug. 

To remedy this temporarily, I have created the file: "forever_savedVariables.lua". Please locate it in Angleur_NicheOptions's AddOn Folder.

Upon opening it, you need to the section marked as: _______________________________ You can change these _______________________________

 ┌─────────────────────────────┐                                                              
 │ forever_savedVariables.lua  │                                                              
 ├─────────────────────────────┴─────────────────────────────────────────────────────────────┐
 │                                                                                           │
 │                                            .                                              │
 │                                            .                                              │
 │                                            .                                              │
 │                                                                                           │
 │  -- _______________________________ You can change these _______________________________  │
 │  local More_ExtraItems = DISABLED                                                         │
 │  local TurnOff_ClickToMove_While_Fishing = DISABLED                                       │
 │  local Sit_While_Fishing = DISABLED                                                       │
 │  -- ____________________________________________________________________________________  │
 │                                                                                           │
 │                                            .                                              │
 │                                            .                                              │
 │                                            .                                              │
 │                                                                                           │
 └───────────────────────────────────────────────────────────────────────────────────────────┘

Here, you can change some of the default settings to your liking.
                                                                                                                                  
    ┌───────────────────────────────┐             ┌───────────────────────────────┐                                            
If  │ SomethingSomething == ENABLED │   making it │SomethingSomething == DISABLED │ will disable that feature. And vice versa. 
    └───────────────────────────────┘             └───────────────────────────────┘                                            
                                                                                                                                  
For settings that aren't as simple as a disable/enable, there will be further instructions to the right of it describing how to change them.


I recommend not changing anything beyond the part marked as ___You can change these___ unless you are somewhat knowledgeable in lua.