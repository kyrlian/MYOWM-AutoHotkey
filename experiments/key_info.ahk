; Display the key name and virtual/scan code.
key  := ":" ; Any key can be used here.
name := GetKeyName(key)
vk   := GetKeyVK(key)
sc   := GetKeySC(key)
MsgBox Format("Name:`t{}`nVK:`t{:X}`nSC:`t{:X}", name, vk, sc)