--マジカルシルクハット
if not c511005063.gl_chk then
	c511005063.gl_chk=true
	local regeff=Card.RegisterEffect
	Card.RegisterEffect=function(c,e,f)
		local tc=e:GetOwner()
		if tc then
			local tg=e:GetTarget()
			if tg then
				if c35803249 and tg==c35803249.distg then --Jinzo - Lord
					--Debug.Message('"Jinzo - Lord" detected')
					e:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
				elseif c51452091 and tg==c51452091.distarget then --Royal Decree
					--Debug.Message('"Royal Decree" detected')
					e:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
				elseif c77585513 and tg==c77585513.distg then --Jinzo
					--Debug.Message('"Jinzo" detected')
					e:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
				elseif c84636823 and tg==c84636823.distg then --Spell Canceller
					--Debug.Message('"Spell Canceller" detected')
					e:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
				end
			end
		end
		return regeff(c,e,f)
	end
end
function c511005063.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511005063.condition)
	e1:SetTarget(c511005063.target)
	e1:SetOperation(c511005063.activate)
	c:RegisterEffect(e1)
	--Set Spell or Trap Cards
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCost(c511005063.stcost)
	e2:SetTarget(c511005063.sttar)
	e2:SetOperation(c511005063.stop)
	c:RegisterEffect(e2)
	--Activate set card
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetCondition(c511005063.actcon1)
	e3:SetOperation(c511005063.actop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_BECOME_TARGET)
	e4:SetCondition(c511005063.actcon2)
	e4:SetOperation(c511005063.actop)
	c:RegisterEffect(e4)
	--remain field
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e5)
end
function c511005063.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER)
end
function c511005063.condition(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<3 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return false end
	return Duel.IsExistingMatchingCard(c511005063.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511005063.tgfilter(c)
	return c:IsType(TYPE_MONSTER)
end
function c511005063.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511005063.tgfilter(chkc,tp) end
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>2
		and Duel.IsExistingTarget(c511005063.tgfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,511005063)
	local g=Duel.SelectTarget(tp,c511005063.tgfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,3,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,0,0)
end
function c511005063.spfilter(c,e,tp)
	return Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetCode(),nil,0x11,0,0,0,0,0)
end
function c511005063.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local tc=Duel.GetFirstTarget()
	if tc then
		local fid=c:GetFieldID()
		if tc:IsFaceup() and tc:IsHasEffect(EFFECT_DEVINE_LIGHT) then Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
		else Duel.ChangePosition(tc,POS_FACEDOWN_DEFENSE) end
			local e1=Effect.CreateEffect(tc)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_TYPE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(TYPE_TOKEN)
			e1:SetCondition(c511005063.econ)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1,true)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_REMOVE_RACE)
			e2:SetValue(RACE_ALL)
			tc:RegisterEffect(e2,true)
			local e3=e1:Clone()
			e3:SetCode(EFFECT_REMOVE_ATTRIBUTE)
			e3:SetValue(0xff)
			tc:RegisterEffect(e3,true)
			local e4=e1:Clone()
			e4:SetCode(EFFECT_SET_BASE_ATTACK)
			e4:SetValue(0)
			tc:RegisterEffect(e4,true)
			local e5=e1:Clone()
			e5:SetCode(EFFECT_SET_BASE_DEFENSE)
			e5:SetValue(0)
			tc:RegisterEffect(e5,true)
			local e6=Effect.CreateEffect(tc)
			e6:SetType(EFFECT_TYPE_SINGLE)
			e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e6:SetCode(EFFECT_UNRELEASABLE_SUM)
			e6:SetValue(1)
			e6:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e6,true)
			local e7=e6:Clone()
			e7:SetCode(EFFECT_UNRELEASABLE_NONSUM)
			tc:RegisterEffect(e7,true)
			tc:RegisterFlagEffect(78800019,RESET_EVENT,0x17a0000,0,0,fid)
		end
		for i=1,3 do
			local hat=Duel.CreateToken(tp,511005062)
			Duel.MoveToField(hat,tp,tp,LOCATION_MZONE,POS_FACEDOWN_DEFENSE,true)
				local e1=Effect.CreateEffect(hat)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_CHANGE_TYPE)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e1:SetValue(TYPE_TOKEN)
				e1:SetReset(RESET_EVENT+0x1fe0000)
				hat:RegisterEffect(e1,true)
				local e2=e1:Clone()
				e2:SetCode(EFFECT_REMOVE_RACE)
				e2:SetValue(RACE_ALL)
				hat:RegisterEffect(e2,true)
				local e3=e1:Clone()
				e3:SetCode(EFFECT_REMOVE_ATTRIBUTE)
				e3:SetValue(0xff)
				hat:RegisterEffect(e3,true)
				local e4=e1:Clone()
				e4:SetCode(EFFECT_SET_BASE_ATTACK)
				e4:SetValue(0)
				hat:RegisterEffect(e4,true)
				local e5=e1:Clone()
				e5:SetCode(EFFECT_SET_BASE_DEFENSE)
				e5:SetValue(0)
				hat:RegisterEffect(e5,true)
				local e6=Effect.CreateEffect(tc)
				e6:SetType(EFFECT_TYPE_SINGLE)
				e6:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
				e6:SetValue(c511005063.indval)
				hat:RegisterEffect(e6,true)
				local e7=e1:Clone()
				e7:SetType(EFFECT_TYPE_SINGLE)
				e7:SetCode(EFFECT_CANNOT_ATTACK)
				hat:RegisterEffect(e7,true)
				local e8=e1:Clone()
				e8:SetType(EFFECT_TYPE_SINGLE)
				e8:SetCode(EFFECT_UNRELEASABLE_SUM)
				e8:SetValue(1)
				hat:RegisterEffect(e8,true)
				local e9=e8:Clone()
				e9:SetType(EFFECT_TYPE_SINGLE)
				e9:SetCode(EFFECT_UNRELEASABLE_NONSUM)
				e9:SetValue(1)
				hat:RegisterEffect(e9,true)
				local e10=e1:Clone()
				e10:SetType(EFFECT_TYPE_SINGLE)
				e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e10:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
				e10:SetValue(1)
				hat:RegisterEffect(e10,true)
				local e11=e1:Clone()
				e11:SetType(EFFECT_TYPE_SINGLE)
				e11:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
				e11:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
				e11:SetValue(1)
				--Destroy token
				local e12=Effect.CreateEffect(hat)
				e12:SetCategory(CATEGORY_DESTROY)
				e12:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
				e12:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e12:SetCode(EVENT_FLIP)
				e12:SetOperation(c511005063.desop)
				e12:SetReset(RESET_EVENT+0x1fe0000)
				hat:RegisterEffect(e12)
				hat:RegisterEffect(e11,true)
				hat:SetStatus(STATUS_NO_LEVEL,true)
				hat:RegisterFlagEffect(511005063,RESET_EVENT+0x17a0000,0,0,fid)
			end
		local gs1=Duel.GetMatchingGroup(c511005063.gsfilter,tp,LOCATION_MZONE,0,nil,e,tp)
		Duel.ChangePosition(gs1,POS_FACEDOWN_DEFENSE)
		Duel.ShuffleSetCard(gs1)
		--destroy
		local e13=Effect.CreateEffect(e:GetHandler())
		e13:SetCategory(CATEGORY_DESTROY)
		e13:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e13:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
		e13:SetRange(LOCATION_SZONE)
		e13:SetCode(EVENT_LEAVE_FIELD)
		e13:SetLabelObject(tc)
		e13:SetLabel(fid)
		e13:SetCondition(c511005063.descon)
		e13:SetOperation(c511005063.desop1)
		e13:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e13)
		--
		local e14=Effect.CreateEffect(e:GetHandler())
		e14:SetCategory(CATEGORY_DESTROY)
		e14:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e14:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
		e14:SetRange(LOCATION_SZONE)
		e14:SetCode(EVENT_BATTLE_START)
		e14:SetLabelObject(tc)
		e14:SetLabel(fid)
		e14:SetCondition(c511005063.descon1)
		e14:SetOperation(c511005063.desop)
		e14:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e14)
		--
		local e15=Effect.CreateEffect(e:GetHandler())
		e15:SetCategory(CATEGORY_DESTROY)
		e15:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e15:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
		e15:SetRange(LOCATION_SZONE)
		e15:SetCode(EVENT_BECOME_TARGET)
		e15:SetLabelObject(tc)
		e15:SetLabel(fid)
		e15:SetCondition(c511005063.descon2)
		e15:SetOperation(c511005063.desop)
		e15:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e15)
		--
		local e16=Effect.CreateEffect(e:GetHandler())
		e16:SetCategory(CATEGORY_DESTROY)
		e16:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e16:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
		e16:SetRange(LOCATION_SZONE)
		e16:SetCode(EVENT_FLIP_SUMMON)
		e16:SetLabelObject(tc)
		e16:SetLabel(fid)
		e16:SetCondition(c511005063.descon2)
		e16:SetOperation(c511005063.desop2)
		e16:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e16)
		--
		local e18=Effect.CreateEffect(c)
		e18:SetCategory(CATEGORY_DESTROY)
		e18:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e18:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
		e18:SetCode(EVENT_LEAVE_FIELD)
		e18:SetLabelObject(tc)
		e18:SetOperation(c511005063.desop3)
		c:RegisterEffect(e18)
end
function c511005063.tdfilter(c)
	return c:IsFaceup() and c:IsCode(511005063)
end
function c511005063.econ(e)
	return Duel.IsExistingMatchingCard(c511005063.tdfilter,tp,LOCATION_SZONE,0,1,nil)
		or Duel.IsEnvironment(511005063)
end
function c511005063.dfilter(c,fid)
	return c:GetFlagEffectLabel(511005063)==fid
end
function c511005063.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return eg:IsExists(c511005063.dfilter,1,nil,tp) and tc and eg:IsContains(tc)
end
function c511005063.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c511005063.descon1(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return tc==Duel.GetAttackTarget()
end
function c511005063.desfilter(c,e,tp)
	return c:GetFlagEffect(511005063)~=0 or c:GetFlagEffect(78800020)~=0 and c:IsType(TYPE_TOKEN)
end
function c511005063.desop1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511005063.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,e:GetHandler())
	Duel.Destroy(g,REASON_EFFECT)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c511005063.dfilter(c,fid)
	return c:GetFlagEffectLabel(78800019)==fid
end
function c511005063.descon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return eg:IsExists(c511005063.dfilter,1,nil,tp) and tc and eg:IsContains(tc)
end
function c511005063.desop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local g=Duel.GetMatchingGroup(c511005063.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,e:GetHandler())
	Duel.Destroy(g,REASON_EFFECT)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	Duel.ChangePosition(tc,POS_FACEUP_ATTACK)
end
function c511005063.desop3(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsStatus(STATUS_FLIP_SUMMON_TURN) then return false end
	local g=Duel.GetMatchingGroup(c511005063.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,e:GetHandler())
	Duel.Destroy(g,REASON_EFFECT)
	Duel.ChangePosition(tc,tc:GetPreviousPosition()) 
	if tc and tc:IsDefensePos() then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
	end	
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c511005063.costfilter(c)
	return c:GetFlagEffect(511005063)~=0 and c:IsType(TYPE_TOKEN) 
end
function c511005063.stcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511005063.costfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511005063.costfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511005063.spstfilter(c,e,tp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c511005063.sttar(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511005063.spstfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511005063.stop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	local g=Duel.GetMatchingGroup(c511005063.spstfilter,tp,LOCATION_HAND,0,nil,e,tp)
	if g:GetCount()<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,511005063)
	local sg=g:Select(tp,1,1,nil)
	local tc=sg:GetFirst()
	while tc do
	Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,POS_FACEDOWN_DEFENSE,true)
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(TYPE_TOKEN)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_REMOVE_RACE)
		e2:SetValue(RACE_ALL)
		tc:RegisterEffect(e2,true)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_REMOVE_ATTRIBUTE)
		e3:SetValue(0xff)
		tc:RegisterEffect(e3,true)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_SET_BASE_ATTACK)
		e4:SetValue(0)
		tc:RegisterEffect(e4,true)
		local e5=e1:Clone()
		e5:SetCode(EFFECT_SET_BASE_DEFENSE)
		e5:SetValue(0)
		tc:RegisterEffect(e5,true)
		local e6=Effect.CreateEffect(tc)
		e6:SetType(EFFECT_TYPE_SINGLE)
		e6:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e6:SetValue(c511005063.indval)
		tc:RegisterEffect(e6,true)
		local e7=e1:Clone()
		e7:SetType(EFFECT_TYPE_SINGLE)
		e7:SetCode(EFFECT_CANNOT_ATTACK)
		tc:RegisterEffect(e7,true)
		local e8=e1:Clone()
		e8:SetType(EFFECT_TYPE_SINGLE)
		e8:SetCode(EFFECT_UNRELEASABLE_SUM)
		e8:SetValue(1)
		tc:RegisterEffect(e8,true)
		local e9=e8:Clone()
		e9:SetType(EFFECT_TYPE_SINGLE)
		e9:SetCode(EFFECT_UNRELEASABLE_NONSUM)
		e9:SetValue(1)
		tc:RegisterEffect(e9,true)
		local e10=e1:Clone()
		e10:SetType(EFFECT_TYPE_SINGLE)
		e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e10:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
		e10:SetValue(1)
		tc:RegisterEffect(e10,true)
		local e11=e1:Clone()
		e11:SetType(EFFECT_TYPE_SINGLE)
		e11:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
		e11:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
		e11:SetValue(1)
		tc:RegisterEffect(e11,true)
		tc:SetStatus(STATUS_NO_LEVEL,true)
		tc:RegisterFlagEffect(78800020,RESET_EVENT+0x17a0000,0,0)
		tc=sg:GetNext()
		sg:KeepAlive() 
	end
	local gs1=Duel.GetMatchingGroup(c511005063.gsfilter,tp,LOCATION_MZONE,0,nil,e,tp)
	Duel.ChangePosition(gs1,POS_FACEDOWN_DEFENSE)
	Duel.ShuffleSetCard(gs1)
end
function c511005063.indval(e,re)
	local rc=re:GetHandler()
	return not rc:IsCode(81210420)
end
function c511005063.gsfilter(c)
	return c:IsFacedown() and c:GetFlagEffect(511005063)~=0 or c:GetFlagEffect(78800019)~=0 or c:GetFlagEffect(78800020)~=0
end
function c511005063.actfilter(c,tp)
	return c:GetFlagEffect(78800020)~=0 and c:IsControler(tp)
end
function c511005063.actcon1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511005063.actfilter,1,nil,tp) and Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE)>0
end
function c511005063.actcon2(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and eg:IsExists(c511005063.actfilter,1,nil,tp) and Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE)>0
end
function c511005063.actop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc and tc:GetFlagEffect(78800020)~=0 and tc:CheckActivateEffect(false,false,false)~=nil then
		local tpe=tc:GetType()
		local te=tc:GetActivateEffect()
		local tg=te:GetTarget()
		local co=te:GetCost()
		local op=te:GetOperation()
		e:SetCategory(te:GetCategory())
		e:SetProperty(te:GetProperty())
		Duel.ClearTargetCard()
		if bit.band(tpe,TYPE_FIELD)~=0 then
			local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
			if Duel.IsDuelType(DUEL_OBSOLETE_RULING) then
				if fc then Duel.Destroy(fc,REASON_RULE) end
				fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
				if fc and Duel.Destroy(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
			else
				fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
				if fc and Duel.SendtoGrave(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
			end
		end
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
		tc:CreateEffectRelation(te)
		if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 and not tc:IsHasEffect(EFFECT_REMAIN_FIELD) then
			tc:CancelToGrave(false)
		end
		if te:GetCode()==EVENT_CHAINING then
			local te2=Duel.GetChainInfo(chain,CHAININFO_TRIGGERING_EFFECT)
			local tc=te2:GetHandler()
			local g=Group.FromCards(tc)
			local p=tc:GetControler()
			if co then co(te,tp,g,p,chain,te2,REASON_EFFECT,p,1) end
			if tg then tg(te,tp,g,p,chain,te2,REASON_EFFECT,p,1) end
		elseif te:GetCode()==EVENT_FREE_CHAIN then
			if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
			if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
		else
			local res,teg,tep,tev,tre,tr,trp=Duel.CheckEvent(te:GetCode(),true)
			if co then co(te,tp,teg,tep,tev,tre,tr,trp,1) end
			if tg then tg(te,tp,teg,tep,tev,tre,tr,trp,1) end
		end
		Duel.BreakEffect()
		local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
		if g then
			local etc=g:GetFirst()
			while etc do
				etc:CreateEffectRelation(te)
				etc=g:GetNext()
			end
		end
		tc:SetStatus(STATUS_ACTIVATED,true)
		if not tc:IsDisabled() then
			if te:GetCode()==EVENT_CHAINING then
				local te2=Duel.GetChainInfo(chain,CHAININFO_TRIGGERING_EFFECT)
				local tc=te2:GetHandler()
				local g=Group.FromCards(tc)
				local p=tc:GetControler()
				if op then op(te,tp,g,p,chain,te2,REASON_EFFECT,p) end
			elseif te:GetCode()==EVENT_FREE_CHAIN then
				if op then op(te,tp,eg,ep,ev,re,r,rp) end
			else
				local res,teg,tep,tev,tre,tr,trp=Duel.CheckEvent(te:GetCode(),true)
				if op then op(te,tp,teg,tep,tev,tre,tr,trp) end
			end
		else
			--insert negated animation here
		end
		Duel.RaiseEvent(Group.CreateGroup(tc),EVENT_CHAIN_SOLVED,te,0,tp,tp,Duel.GetCurrentChain())
		if g and tc:IsType(TYPE_EQUIP) and not tc:GetEquipTarget() then
			Duel.Equip(tp,tc,g:GetFirst())
		end
		tc:ReleaseEffectRelation(te)
		if etc then	
			etc=g:GetFirst()
			while etc do
				etc:ReleaseEffectRelation(te)
				etc=g:GetNext()
			end		
		end
	end
end
