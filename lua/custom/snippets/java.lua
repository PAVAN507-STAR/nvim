-- ~/.config/nvim/lua/custom/snippets/java.lua

-- Correctly require the luasnip functions
local ls = require("luasnip")
local s = ls.s
local t = ls.t
local i = ls.i

return {
	s("cpmain", {
		t("import java.util.*;"),
		t({ "import java.io.*;", "" }),
		t("public class Main {"),
		t("    public static void main(String[] args) {"),
		t("        try (Scanner sc = new Scanner(System.in)) {"),
		t("            int t = sc.nextInt();"),
		t("            while (t-- > 0) {"),
		t("                solve(sc);"),
		t("            }"),
		t("        }"),
		t("    }"),
		t(""),
		t("    public static void solve(Scanner sc) {"),
		t("        "),
		i(0),
		t("    }"),
		t("}"),
	}),
}
