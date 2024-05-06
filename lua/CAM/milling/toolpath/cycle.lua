local M={}-- canned cycles, and geometry-naive toolpaths (many of which are used for linking)

function M.tap()
end

function M.helix()
end

-- same as helix(), but with parameters meant for threading
function M.thread()
end

-- params = ID, OD, WOC
function M.spiral()
end

function M.face()
end

return M
