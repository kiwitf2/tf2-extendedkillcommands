::kill_immune_conds <-
[
	Constants.ETFCond.TF_COND_INVULNERABLE,
	Constants.ETFCond.TF_COND_PHASE,
	Constants.ETFCond.TF_COND_INVULNERABLE_HIDE_UNLESS_DAMAGED,
	Constants.ETFCond.TF_COND_INVULNERABLE_USER_BUFF,
	Constants.ETFCond.TF_COND_INVULNERABLE_CARD_EFFECT,
]

// dr gordbort weapon kill effect
::DrGMe <- function () {

	if(!self.IsAlive())
	{
		return
	}

	foreach (cond in kill_immune_conds)
		self.RemoveCondEx(cond, true)

	self.TakeDamageCustom(self, self, null, Vector(), Vector(), 9999, 0, Constants.ETFDmgCustom.TF_DMG_CUSTOM_PLASMA)
}

// sun on a stick/phlog weapon kill effect
::AshMe <- function () {

	if(!self.IsAlive())
	{
		return
	}

	local ash_proxy_weapon = CreateProxyWeapon("ragdolls become ash")

	// make the player not invincible
	foreach (cond in kill_immune_conds)
		self.RemoveCondEx(cond, true)

	NetProps.SetPropEntity(ash_proxy_weapon, "m_hOwner", self)

	// Deal the damage with the weapon
	self.TakeDamageCustom(self, self, ash_proxy_weapon,
		Vector(0,0,0), Vector(0,0,0),
		99999.0, Constants.FDmgType.DMG_CLUB | Constants.FDmgType.DMG_PREVENT_PHYSICS_FORCE,
		Constants.ETFDmgCustom.TF_DMG_CUSTOM_BURNING
	)

	local ragdoll = NetProps.GetPropEntity(self, "m_hRagdoll")
	if (ragdoll)
		NetProps.SetPropInt(ragdoll, "m_iDamageCustom", 0)

	EntFireByHandle(ash_proxy_weapon, "kill", "", 0, null, null)
}

// australium weapon kill effect
::GoldMe <- function () {

	if(!self.IsAlive())
	{
		return
	}

	local gold_proxy_weapon = CreateProxyWeapon("turn to gold")

	// make the player not invincible
	foreach (cond in kill_immune_conds)
		self.RemoveCondEx(cond, true)

	NetProps.SetPropEntity(gold_proxy_weapon, "m_hOwner", self)

	// Deal the damage with the weapon
	self.TakeDamageEx(self, self, gold_proxy_weapon,
		Vector(0,0,0), Vector(0,0,0),
		99999.0, Constants.FDmgType.DMG_CLUB | Constants.FDmgType.DMG_PREVENT_PHYSICS_FORCE
	)

	local ragdoll = NetProps.GetPropEntity(self, "m_hRagdoll")
	if (ragdoll)
		NetProps.SetPropInt(ragdoll, "m_iDamageCustom", 0)

	EntFireByHandle(gold_proxy_weapon, "kill", "", 0, null, null)
}

// spycicle kill effect
::FreezeMe <- function () {

	if(!self.IsAlive())
	{
		return
	}

	// Don't allow razorback to block it
    local razorback
    for (local wearable = self.FirstMoveChild(); wearable; wearable = wearable.NextMovePeer())
    {
        if (wearable.GetClassname() == "tf_wearable_razorback")
        {
            wearable.DisableDraw()
            razorback = wearable
        }
    }

	local freeze_proxy_weapon = CreateProxyWeapon("freeze backstab victim")

	// handling for making player die

	// make the player not invincible
	foreach (cond in kill_immune_conds)
		self.RemoveCondEx(cond, true)

	NetProps.SetPropEntity(freeze_proxy_weapon, "m_hOwner", self)

	// Deal the damage with the weapon
	self.TakeDamageCustom(self, self, freeze_proxy_weapon,
		Vector(0,0,0), Vector(0,0,0),
		99999.0, Constants.FDmgType.DMG_CLUB | Constants.FDmgType.DMG_PREVENT_PHYSICS_FORCE,
		Constants.ETFDmgCustom.TF_DMG_CUSTOM_BACKSTAB
	)

	if (razorback)
        razorback.EnableDraw()

	local ragdoll = NetProps.GetPropEntity(self, "m_hRagdoll")
	if (ragdoll)
		NetProps.SetPropInt(ragdoll, "m_iDamageCustom", 0)

	EntFireByHandle(freeze_proxy_weapon, "kill", "", 0, null, null)
}

::CreateProxyWeapon <- function (attribute) { // todo, is id and classname even needed?
	local proxy_weapon = Entities.CreateByClassname("tf_weapon_bat")
	NetProps.SetPropInt(proxy_weapon, "m_AttributeManager.m_Item.m_iItemDefinitionIndex", 939)
	NetProps.SetPropBool(proxy_weapon, "m_AttributeManager.m_Item.m_bInitialized", true)
	proxy_weapon.DispatchSpawn()
	proxy_weapon.DisableDraw()

	// Add the attribute that creates ice statues
	proxy_weapon.AddAttribute(attribute, 1.0, -1.0)

	return proxy_weapon
}