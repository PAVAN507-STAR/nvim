-- ~/.config/nvim/lua/custom/snippets/java.lua
local ls = require("luasnip")
local s = ls.s
local d = ls.dynamic_node

return {
  -- Define a snippet with trigger "cpmain"
  s("cpmain",
    -- Use a dynamicNode to generate the content when the snippet is expanded
    d(1, function()
      local class_name = vim.fn.expand("%:t:r")
      if not class_name or class_name == "" then
        class_name = "Main" -- Fallback to "Main" if the filename is empty
      end

      -- The full text of the snippet we want to generate
      local snippet_body = string.format([[
import java.io.*;
import java.util.*;

public class %s {
    public static void main(String[] args) {
        try (Scanner sc = new Scanner(System.in)) {
            int t = sc.nextInt();
            while (t-- > 0) {
                solve(sc);
            }
        }
    }

    public static void solve(Scanner sc) {
        $0
    }
}
]], class_name)

      -- A dynamicNode's function must return a new snippet object.
      -- We create it here by parsing the text we just generated.
      return ls.parser.parse_snippet("dynamic_java_template", snippet_body)
    end)
  ),
}
