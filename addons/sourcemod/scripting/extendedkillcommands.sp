#include <sourcemod>
#include <sdktools>

public Plugin myinfo =
{
	name = "Extended Kill Commands",
	author = "kiwi",
	description = "i'm so sorry for how i coded this",
	version = "1.0",
	url = "http://www.sourcemod.net/"
};

// please look away this code sucks 

public void OnPluginStart()
{
    ServerCommand("script_execute sm_extendedkillcommands")

    RegAdminCmd("tf_freezekill", FreezeCommand, 0, "same as kill command, but works like the spycicle");
    RegAdminCmd("tf_goldkill", GoldCommand, 0, "same as kill command, but works like an australium weapon");
    RegAdminCmd("tf_drgkill", DrGCommand, 0, "same as kill command, but works like a dr gordbort weapon");
    RegAdminCmd("tf_ashkill", AshCommand, 0, "same as kill command, but works like the sun on a stick");
}

public Action FreezeCommand(int client, int args)
{
    SetVariantString("FreezeMe");
    AcceptEntityInput(client, "CallScriptFunction");
    return Plugin_Handled;
}

public Action GoldCommand(int client, int args)
{
    SetVariantString("GoldMe");
    AcceptEntityInput(client, "CallScriptFunction");
    return Plugin_Handled;
}

public Action DrGCommand(int client, int args)
{
    SetVariantString("DrGMe");
    AcceptEntityInput(client, "CallScriptFunction");
    return Plugin_Handled;
}

public Action AshCommand(int client, int args)
{
    SetVariantString("AshMe");
    AcceptEntityInput(client, "CallScriptFunction");
    return Plugin_Handled;
}