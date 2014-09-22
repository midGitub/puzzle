--[[
    记录所有的关卡信息
--]]


--[[
    关卡的历史信息
--]]
LEVEL_HISTORY =
{
    timeValue = "timeValue",
    touchValue = "touchValue",
    moveValue = "moveValue",
}


--[[
    练习模式关卡
--]]
PRACTIESELEVEL =
{
    [1] =
    {
        name = "NoSelection",
        message = "",

        boolSortMode = false,
        sortMode = false,

        boolPutMode = false,
        putMode = false,

        image =
        {
            plist = "Images/Puzzle/beedo_min.plist",
            name = "beedo_min",

            width = 140,
            widthNum = 2,
            height = 140,
            heightNum = 2,
        }
    },

    [2] =
    {
        name = "SortMode",
        message = "",

        boolSortMode = false,
        sortMode = true,

        boolPutMode = false,
        putMode = false,

        image =
        {
            plist = "Images/Puzzle/beedo_middle.plist",
            name = "beedo_middle",

            width = 140,
            widthNum = 3,
            height = 140,
            heightNum = 3,
        }
    },

    [3] =
    {
        name = "PutMode",
        message = "",

        boolSortMode = false,
        sortMode = false,

        boolPutMode = false,
        putMode = true,

        image =
        {
            plist = "Images/Puzzle/beedo_middle.plist",
            name = "beedo_middle",

            width = 140,
            widthNum = 3,
            height = 140,
            heightNum = 3,
        }
    },

    [4] =
    {
        name = "BothMode",
        message = "",

        boolSortMode = false,
        sortMode = true,

        boolPutMode = false,
        putMode = true,

        image =
        {
            plist = "Images/Puzzle/beedo_max.plist",
            name = "beedo_max",

            width = 140,
            widthNum = 4,
            height = 140,
            heightNum = 4,
        }
    },

    [5] =
    {
        name = "Select",
        message = "",

        boolSortMode = true,
        sortMode = nil,

        boolPutMode = true,
        putMode = nil,

        image =
        {
            plist = "Images/Puzzle/beedo_max.plist",
            name = "beedo_max",

            width = 140,
            widthNum = 4,
            height = 140,
            heightNum = 4,
        }
    },
}