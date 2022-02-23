local Pages = {}
Pages.__index = Pages

function Pages.new(content, pageSize, advanceCallback)
	local self = {
		_advanceCallback = advanceCallback;
		_pages = {};
		_currentPage = 1;
		_pageSize = pageSize;
		IsFinished = false;
	}

	if pageSize and pageSize > 0 then
		local contentSize = math.max(#content, 1)
		for pageIndex = 1, math.ceil(contentSize / pageSize) do
			local page = {}
			for index = 1, pageSize do
				local pageStart = (pageIndex - 1) * pageSize
				local nextIndex = pageStart + index
				if content[nextIndex] then
					table.insert(page, content[nextIndex])
				end
			end
			table.insert(self._pages, page)
		end
	else
		self._pages[1] = content
	end

	setmetatable(self, Pages)
	self:_updateIsFinished()

	return self
end

function Pages:_updateIsFinished()
	if self._currentPage == #self._pages then
		self.IsFinished = true
	end
end

function Pages:AdvanceToNextPageAsync()
	if self._currentPage < #self._pages then
		if self._advanceCallback then
			self._advanceCallback()
		end
		self._currentPage += 1
		self:_updateIsFinished()
	else
		error("Already on last page")
	end
end

function Pages:GetCurrentPage()
	return self._pages[self._currentPage]
end

return Pages