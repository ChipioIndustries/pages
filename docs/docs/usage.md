---
sidebar_position: 2
---

# Usage

Begin by requiring the module.

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Pages = require(ReplicatedStorage.Packages.Pages)
```

A new Pages object can be created with the constructor:

```lua
local pages = Pages.new()
```

The constructor receives the contents to pagify, the optional page size, and the optional callback to run prior to returning from `AdvanceToNextPageAsync`.

```lua
local contents = {
	356456;
	765;
	8568757;
}

local pageSize = 2

local function onAdvance()
	-- yield to simulate asynchronicity (is that a real word?)
	task.wait(0.2)
end

local pages = Pages.new(contents, pageSize, onAdvance)
```

To get the current page, call `GetCurrentPage`:

```lua
local currentPage = pages:GetCurrentPage()

for index, value in ipairs(currentPage) do
	print(index, value)
end
```

If `IsFinished` is false, you can advance to the next page:

```lua
while true do
	local currentPage = pages:GetCurrentPage()
	for index, value in ipairs(currentPage) do
		print(index, value)
	end
	if pages.IsFinished then
		break
	else
		pages:AdvanceToNextPageAsync()
	end
end
```