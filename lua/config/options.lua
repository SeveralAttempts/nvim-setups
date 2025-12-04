local opt = vim.opt

-- Номера строк
opt.number = true

-- Настройки табуляции и отступов
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

local function setup_dark_cursor()
    -- Темно-серые варианты (от более темного к светлому)
    local dark_colors = {
        cursor = "#222222",      -- Очень темный серый
        insert = "#333333",      -- Темный серый
        visual = "#444444",      -- Средний серый
        normal = "#555555",      -- Светло-серый
    }
    
    -- Применяем цвета
    vim.api.nvim_set_hl(0, "Cursor", { bg = dark_colors.normal })
    vim.api.nvim_set_hl(0, "iCursor", { bg = dark_colors.insert })
    vim.api.nvim_set_hl(0, "vCursor", { bg = dark_colors.visual })
    vim.api.nvim_set_hl(0, "lCursor", { bg = dark_colors.cursor })
    
    -- Также можно изменить цвет выделения (visual mode)
    vim.api.nvim_set_hl(0, "Visual", { bg = "#2a2a2a" })
    
    -- Улучшаем видимость курсора в разных режимах
    vim.opt.guicursor = table.concat({
        "n-v-c-sm:block-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
        "i-ci-ve:ver25-blinkwait700-blinkoff400-blinkon250-iCursor/lCursor",
        "r-cr-o:hor20-blinkwait700-blinkoff400-blinkon250-vCursor/lCursor"
    }, ",")
end

-- Вызываем функцию
setup_dark_cursor()
