## Configurable CJK puncutation width adjustment with support for vertical reading hack
I wasn't satisfied with the hardcored metrics, so in the past I did binary patching.

The vertical reading hack (koreader/koreader#11469) made this more complex because
the width of some glyphs (?!:;) can be reduced in the horizontal mode, but not in
vertical mode (the height will be reduced otherwise). This motivates me to add logic
and API to the rendering engine to handle these requirements.

### How to use this
1. Clone koreader/koreader.
2. Run `./kodev fetch-thirdparty`.
3. Apply these patches:

- `vert/crengine-0001-textlang-configurable-and-vertical-variant-cjk-width-adjustment-table.patch`: to `base/thirdprty/kpvcrlib/crengine/`
- `vert/koreader-base-0001-cre-add-functions-for-cjk-width-adjustment.patch`: to `base/`

4. Build and install.
5. Put these into the `koreader/patches` folder:

- `vert/2-cre-rotate-japanese-book.lua`
- `vert/2-cre-apply-cjk-width-adjustment-table-override.lua`.

6. Edit `settings.reader.lua` (you should exit KOReader first):
	- Add a `cre_cjk_width_adjustment_table_override` entry. See `vert/2-cre-apply-cjk-width-adjustment-table-override.lua` for an example.

### Credits
- `vert/2-cre-rotate-japanese-book.lua`: Based on https://github.com/plateaukao/koreader_patch_vertical_read/blob/c7e84319c9354432a5e7aabf0655afbe44aefb2c/2-cre-rotate-japanese-book.lua


---

## 支援直排的可自訂中日文標點寬度調整
你有發現嗎？KOReader會自動調整連續標點的寬度，讓標點之間不要留太多空白，也可以讓避頭尾行為不會造成行長差異過大，這就是InDesign的排字調整跟OpenType `chws`功能在做的事。

不過KOReader在排版繁體中文的時候，標點寬度調整沒有簡中跟日文激進，而是在需要避頭尾時才壓縮寬度。我自己覺得很醜，所以有一段時間是手動改那個壓縮數值的表格。

後來又在試直排的字體跟介面支援，處理完字體之後是沒什麼大問題，不過問號、冒號跟驚嘆號的高度被壓縮了……回去看表格會發現預設在繁體中，這些標點是設定成必要時最多可以縮減1/4的寬度。很合理嘛它們左右都有空白，可是排版引擎不知道現在是直排，所以就縮到高度了。

總之我試圖在這個直排hack的基礎上再加更多hack，讓排版引擎在直排的時候切換成不同的表格，也讓表格不要寫死在程式裡面，可以從設定檔修改。

使用方式看上面。