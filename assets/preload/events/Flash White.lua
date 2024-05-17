function onEvent(name,value1,value2)
	if name == 'Flash White' then
		if getPropertyFromClass('ClientPrefs', 'flashing') == true then
		cameraFlash('camGame', 'FFFFFF', '1')
		end
	end
end