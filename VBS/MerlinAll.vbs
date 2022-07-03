' Show the Merlin windows Charater and play all animations

Set objVoice = CreateObject("SAPI.SpVoice")
strAgentPath = "c:\windows\msagent\chars\Merlin.acs"
Set objAgent = CreateObject("Agent.Control.2")
objAgent.Connected = TRUE
objAgent.Characters.Load "Merlin", strAgentPath
Set objCharacter = objAgent.Characters.Character("Merlin")

objCharacter.MoveTo 500,400
objCharacter.Show
objCharacter.Play "Acknowledge"
objCharacter.Play "Alert"
objCharacter.Play "Announce"
objCharacter.Play "Blink"
objCharacter.Play "Confused"
objCharacter.Play "Congratulate"
objCharacter.Play "Congratulate_2"
objCharacter.Play "Decline"
objCharacter.Play "DoMagic1"
objCharacter.Play "DoMagic2"
objCharacter.Play "DontRecognize"
objCharacter.Play "Explain"
objCharacter.Play "GestureDown"
objCharacter.Play "GestureLeft"
objCharacter.Play "GestureRight"
objCharacter.Play "GestureUp"
objCharacter.Play "GetAttention"
objCharacter.Play "GetAttentionContinued"
objCharacter.Play "GetAttentionReturn"
'objCharacter.Play "Hearing_1"
'objCharacter.Play "Hearing_2"
'objCharacter.Play "Hearing_3"
'objCharacter.Play "Hearing_4"
objCharacter.Play "Hide"
objCharacter.Play "Idle1_1"
objCharacter.Play "Idle1_2"
objCharacter.Play "Idle1_3"
objCharacter.Play "Idle1_4"
objCharacter.Play "Idle2_1"
objCharacter.Play "Idle2_2"
objCharacter.Play "Idle3_1"
'objCharacter.Play "Idle3_2"
objCharacter.Play "LookDown"
objCharacter.Play "LookDownBlink"
objCharacter.Play "LookDownReturn"
objCharacter.Play "LookLeft"
objCharacter.Play "LookLeftBlink"
objCharacter.Play "LookLeftReturn"
objCharacter.Play "LookRight"
objCharacter.Play "LookRightBlink"
objCharacter.Play "LookRightReturn"
objCharacter.Play "LookUp"
objCharacter.Play "LookUpBlink"
objCharacter.Play "LookUpReturn"
objCharacter.Play "MoveDown"
objCharacter.Play "MoveLeft"
objCharacter.Play "MoveRight"
objCharacter.Play "MoveUp"
objCharacter.Play "Pleased"
objCharacter.Play "Process"
'objCharacter.Play "Processing"
objCharacter.Play "Read"
objCharacter.Play "ReadContinued"
'objCharacter.Play "Reading"
objCharacter.Play "ReadReturn"
objCharacter.Play "RestPose"
objCharacter.Play "Sad"
objCharacter.Play "Search"
'objCharacter.Play "Searching"
objCharacter.Play "Show"
objCharacter.Play "StartListening"
objCharacter.Play "StopListening"
objCharacter.Play "Suggest"
objCharacter.Play "Surprised"
objCharacter.Play "Think"
'objCharacter.Play "Thinking"
objCharacter.Play "Uncertain"
objCharacter.Play "Wave"
objCharacter.Play "Write"
objCharacter.Play "WriteContinued"
objCharacter.Play "WriteReturn"
'objCharacter.Play "Writing"

objCharacter.Hide

Do While objCharacter.Visible = TRUE
    Wscript.Sleep 100
Loop