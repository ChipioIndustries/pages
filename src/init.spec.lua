local contentToTest = {
	Array = {
		345;
		34534;
		7856;
		123;
		34534;
		7856;
		123;
	};
	Empty = {};
	Short = {
		476;
		8756;
	};
}

local pageSizesToTest = {
	NoPages = 0;
	OneItemPage = 1;
	TwoItemPage = 2;
}

return function()
	describe("Pages", function()
		local Pages = require(script.Parent)

		for contentName, content in pairs(contentToTest) do
			for sizeName, size in pairs(pageSizesToTest) do
				it(contentName .. ", " .. sizeName, function()
					local callbackCount = 0

					local function callback()
						callbackCount += 1
					end

					local pages = Pages.new(content, size, callback)

					local page1 = pages:GetCurrentPage()
					expect(page1).to.be.a("table")

					if size > 0 then
						local pageCount = math.max(math.ceil(#content / size), 1)

						for i = 1, pageCount - 1 do
							pages:AdvanceToNextPageAsync()
							local pageContents = pages:GetCurrentPage()
							expect(#pageContents).to.equal((pages.IsFinished and #content - size * i) or size)
						end

						expect(callbackCount).to.equal(pageCount - 1)
					end

					expect(pages.IsFinished).to.equal(true)

					expect(function()
						pages:AdvanceToNextPageAsync()
					end).to.throw()
				end)
			end
		end
	end)
end