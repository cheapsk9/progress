--!optimize 2
--!nolint
local h=Progress local k local l l={emptyFunction=function()end,createAndRunCoro=function(_,...)local a,_=coroutine.resume(coroutine.create(_),...) if not a then h:ShowToast({Title="Callback Error",Text=_,Duration=10,Type=5})end end,generic_Callback=function(_,b)_.Value=b local a=_.Callback local _=_.Changed if type(a)=="function"then l.createAndRunCoro(a,b)end if type(_)=="function"then l.createAndRunCoro(_,b)end end,generic_Changed=function(a,_)a.Changed=_ _(a.Value)end,generic_SetValue=function(_,a)_.__Element:SetValue(a)end,colorPicker_Display=function(a)local _=a.__Element _:SetValue(Color3.fromHSV(a.Hue,a.Sat,a.Vib),_.Transparency)end,colorPicker_SetHSVFromRGB=function(c,_)local a,_,b=Color3.toHSV(_) c.Hue=a c.Sat=_ c.Vib=b end,colorPicker_SetValueRGB=function(b,a,_)b.Transparency=_ or 0 b:SetHSVFromRGB(a) b:Display()end,colorPicker_SetValue=function(b,_,a)local _=Color3.fromHSV(unpack(_)) b:SetValueRGB(b,_,a)end,dropdown_Callback=function(_,b)if _.Multi then local a={} for _,_ in next,b do a[_]=true end b=a else b=b[1]end l.generic_Callback(_,b)end,dropdown_SetValues=function(_,a)if a then _.Values=a _.__Element:SetValues(a)end end,dropdown_SetValue=function(_,a)local b=_.__Element if _.Multi then local c={} local _=_.Values local d=0 for _ in next,a do d=d+1 c[d]=_ end b:SetSelection(c)else b:SetSelection({a})end end,keybind_SetValue=function(b,a,_)a=a or b.Key _=_ or b.Mode b.Value=a b.Mode=_ end,keybind_OnClick=function(_,a)_.Clicked=a end,keybind_DoClick=function(b)local _=b.Callback local a=b.Clicked if type(_)=="function"then l.createAndRunCoro(_,b.Toggled)end if type(a)=="function"then l.createAndRunCoro(a,b.Toggled)end end,keybind_GetState=function(_)return _.Toggled end} local g={Paragraph=function(_,a)local _=_:CreateElement("Label",{Label={Title=a.Title or"",Text=a.Content or"",PrimaryContent=a.Section}}) return{},_ end,Button=function(_,b)local a=b.Callback local _=_:CreateElement("Button",{Label={Title=b.Title or"Button",Text=b.Description or""},Simple=true}) if type(a)=="function"then _.Click:Connect(function()l.createAndRunCoro(a)end)end return{},_ end,Toggle=function(_,b,d)local f=d.Title local c=d.Description f=f and tostring(f)or"Toggle" c=c and tostring(c)or"" local a=d.Default or false local e local _=_:CreateElement("Toggle",{Value=a,Label={Title=f,Text=c},OnChanged=function(_)l.generic_Callback(e,_)end}) e={__Index=b,Value=nil,Title=f,SetValue=l.generic_SetValue,Callback=d.Callback or l.emptyFunction,OnChanged=l.generic_Changed,Type="Toggle"} k.Options[b]=e l.generic_Callback(e,a) return e,_ end,Slider=function(_,b,j)local i=j.Title local g=j.Description i=i and tostring(i)or"Slider" g=g and tostring(g)or"" local e=j.Min local d=j.Max local a=tonumber(j.Default)or(e+d)/2 local c=j.Rounding local f=10^-c f=f<=1 and f or 1 local h local _=_:CreateElement("Slider",{Label={Title=i,Text=g},Min=e,Max=d,Value=a,Step=f,OnChanged=function(_)l.generic_Callback(h,_)end}) h={__Index=b,Value=nil,Min=e,Max=d,Rounding=c,Title=i,SetValue=l.generic_SetValue,Callback=j.Callback or l.emptyFunction,OnChanged=l.generic_Changed,Type="Slider"} k.Options[b]=h l.generic_Callback(h,a) return h,_ end,Dropdown=function(_,b,h)local f=h.Title local e=h.Description f=f and tostring(f)or"Dropdown" e=e and tostring(e)or"" local i=h.Default local d=h.Values local c=h.Multi local a=i if not c then if type(i)=="number"then i=d[i]end a={i}end local g local _=_:CreateElement("Dropdown",{Label={Title=f,Text=e},Values=d,Selected=a,MultiSelect=c,SelectionLocks=not h.AllowNull,OnSelectionChanged=function(_)l.dropdown_Callback(g,_)end}) g={__Index=b,Values=d,Value=i,Multi=c,Buttons={},Opened=false,Callback=h.Callback or l.emptyFunction,OnChanged=l.generic_Changed,Type="Dropdown",SetValue=l.dropdown_SetValue,SetValues=l.dropdown_SetValues} k.Options[b]=g l.generic_Callback(g,i) return g,_ end,Colorpicker=function(_,a,f)local e=f.Title local d=f.Description e=e and tostring(e)or"Color Picker" d=d and tostring(d)or"" local c=f.Default or Color3.new() local b=f.Transparency local g local _=_:CreateElement("ColorPicker",{Label={Title=e,Text=d},Value=c,AlphaEnabled=not not b,Alpha=b or 0,OnChanged=function(_,a)g.Transparency=a l.generic_Callback(g,_)end}) g={__Index=a,__Element=_,Value=c,Transparency=b or 0,Title=e,Callback=f.Callback or l.emptyFunction,OnChanged=l.generic_Changed,Type="Colorpicker",Display=l.colorPicker_Display,SetHSVFromRGB=l.colorPicker_SetHSVFromRGB,SetValueRGB=l.colorPicker_SetValueRGB,SetValue=l.colorPicker_SetValue} k.Options[a]=g g:SetHSVFromRGB(c) g:Display() return g,_ end,Keybind=function(_,a,c)local b=c.Title local _=c.Description b=b and tostring(b)or"Toggle" _=_ and tostring(_)or"" local _=c.Default or false local b local _={Destroy=l.emptyFunction,SetLabel=l.emptyFunction} b={__Index=a,Value=c.Default,Toggled=false,Mode=c.Mode or"Toggle",Callback=c.Callback or l.emptyFunction,ChangedCallback=c.ChangedCallback or l.emptyFunction,OnChanged=l.generic_Changed,Type="Keybind",GetState=l.keybind_GetState,SetValue=l.keybind_SetValue,OnClick=l.keybind_OnClick,DoClick=l.keybind_DoClick} k.Options[a]=b return b,_ end,Input=function(_,c,h)local d=h.Title local e=h.Description d=d and tostring(d)or"Text Box" e=e and tostring(e)or"" local g=h.Default g=g and tostring(g)or"" local b=h.Numeric or false local a=h.Finished or false local f local d=_:CreateElement("TextBox",{Label={Title=d,Text=e},Value=g,PlaceholderText=h.Placeholder,Numeric=b}) if a then d.FocusLost:Connect(function(_,_)l.generic_Callback(f,d.Value)end)else d.OnChanged=function(_)l.generic_Callback(f,_)end end f={__Index=c,Value=g,Numeric=b,Finished=a,SetValue=l.generic_SetValue,Callback=h.Callback or l.emptyFunction,OnChanged=l.generic_Changed,Type="Input"} k.Options[c]=f l.generic_Callback(f,g) return f,d end} local function d(_)_.__Element:Destroy() k.Options[_.__Index]=nil end local function e(_,a)_.__Element:SetLabel({Title=a})end local function f(_,a)_.__Element:SetLabel({Text=a})end local function b(b,a,_,c)local b=b.__Base local a,_=g[a](b,_,c) a.__Element=_ a.Destroy=d a.SetTitle=e a.SetDesc=f return a end local c={} local a=function(a,_)return setmetatable({__Base=a.__Page:CreateSection(_,true),Type="Section"},{__index=c})end for d in next,g do c["Add"..d]=function(a,c,_)return b(a,d,c,_)end end local b=true k={Version="V2",Options={},SetTheme=l.emptyFunction,ToggleAcrylic=l.emptyFunction,ToggleTransparency=l.emptyFunction,CreateWindow=function(_,_)if b then b=false h:SetFluentTranslationHack() local b=_.SubTitle local _=_.MinimizeKeybind if b then h.Window:SetSubtitle(b)end if _ then local _ end return{AddTab=function(_,_)local b=_.Title or"" local _=h.Hub:CreatePage(b,_.Icon) return setmetatable({__Page=_,__Base=_,Selected=false,Name=b,AddSection=a,Type="Tab"},{__index=c})end,Dialog=function(_,_)h.Window:ShowDialog({Title=_.Title,Text=_.Content,Buttons=_.Buttons})end,SelectTab=function(_,_)end}end end,Notify=function(_,_)return h:ShowToast({Title=_.Title,Text=_.Content,Duration=_.Duration,Type=0})end,Destroy=function(_)h.Window:Close()end} return k
