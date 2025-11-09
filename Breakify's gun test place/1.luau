-- next time? maybe add a handshake?
local replicated_storage = cloneref(game:GetService("ReplicatedStorage")) :: ReplicatedStorage;
local remotes: {[number]: RemoteEvent} = {replicated_storage.ExploitDetectedEvent, replicated_storage.AntiExploitDetectedEvent}; -- change the names and i'll show no mercy :3
local table_find: ({any}, any) -> number? = table.find;
local hookmetamethod = @native function(...: any): (...any) -> (...any)
	local self: any, method: string, closure: (...any) -> (...any) = select(1, ...), select(2, ...), select(3, ...);
	local metatable: {any} = getrawmetatable(self);
	local method: (...any) -> (...any)? = rawget(metatable, method);
	if (type(method) == "function" and iscclosure(method) and oth and oth.hook) then
		return oth.hook(method, closure);
	end;
	return hookmetamethod(...);
end;
local hookfunction = @native function(...: any): any
	local target: (...any) -> (...any) = select(1, ...);
	if (iscclosure(target) and oth and oth.hook) then
		return oth.hook(...);
	end;
	return hookfunction(...);
end;
for _: unknown, v: (...any) -> (...any) in (getgc(false)) do
	if (type(v) == "function" and islclosure(v) and not isexecutorclosure(v)) then
		if (debug.info(v, "n") == "Crash") then
			hookfunction(v, @native function(): ()
				return;
			end);
			continue;
		end;
		local constants: {any} = debug.getconstants(v);
		local index: number? = table_find(constants, "UGCValidationService");
		if (index) then
			debug.setconstant(v, index, "StudioPublishService");
		end;
	end;
end;
local namecall; namecall = hookmetamethod(game, "__namecall", newcclosure(@native function(...: any): any
	if (getthreadidentity() ~= 2) then return namecall(...); end;
	local args: {any} = {...};
	local self: Instance = args[1];
	local method: string = getnamecallmethod();
	if (type(self) == "userdata" and typeof(self) == "Instance" and method == "FireServer" and self.ClassName == "RemoteEvent" and table_find(remotes, self)) then
		return;
	end;
	return namecall(...);
end));
local FireServer; FireServer = hookfunction(remotes[1].FireServer, newcclosure(@native function(...: any): any
	if (getthreadidentity() ~= 2) then return FireServer(...); end;
	local args: {any} = {...};
	local self: Instance = args[1];
	if (type(self) == "userdata" and typeof(self) == "Instance" and self.ClassName == "RemoteEvent" and table_find(remotes, self)) then
		return;
	end;
	return FireServer(...);
end));

