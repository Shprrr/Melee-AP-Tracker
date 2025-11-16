-- Utility function to get the index of a value in an array
function GetIndex(array, searchValue)
    local index = 0
    for _, value in pairs(array) do
        if value == searchValue then
            return index
        end
        index = index + 1
    end
    return nil
end