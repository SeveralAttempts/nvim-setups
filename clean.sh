#!/bin/bash
# ~/.config/nvim/clean.sh - БЕЗОПАСНАЯ очистка

echo "🧹 Очистка кэша Neovim..."

# УДАЛЯЕМ ТОЛЬКО КЭШ, НЕ ПЛАГИНЫ
rm -rf ~/.cache/nvim
rm -rf ~/.local/state/nvim

# НЕ удаляем плагины!
# rm -rf ~/.local/share/nvim/lazy  # ЗАКОММЕНТИРУЙТЕ ЭТУ СТРОКУ!

echo "✅ Кэш очищен. Плагины сохранены."
echo "Для полной переустановки плагинов выполните:"
echo "  rm -rf ~/.local/share/nvim/lazy && nvim"
echo "❗ Attention: It could take some time when Neovim load Lazy again and show you Lazy plugin manager window. Be patient..."
