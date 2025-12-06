
-- Auto insert CP template for every NEW .cpp file
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.cpp",
  callback = function()
    local lines = {
      "#include <bits/stdc++.h>",
      "using namespace std;",
      "#define int long long",
      "#define endl \"\\n\"",
      "#define mod 1000000007;",
      "const int inf = 1e18;",
      "",
      "",
      "/*",
      "Observations",
      "\t",
      "    If I can solve it, how would the soln be?",
      "*/",
      "",
      "void solve() {",
      "    ",
      "}",
      "",
      "signed main() {",
      "    ios::sync_with_stdio(false);",
      "    cin.tie(nullptr);",
      "",
      "    int t;",
      "    cin >> t;",
      "    while (t--) {",
      "        solve();",
      "    }",
      "    return 0;",
      "}",
      "",
      "// Golden Rules",
      "/*",
      "    Solutions are simple.",
      "",
      "    Proofs are simple.",
      "",
      "    Implementations are simple.",
      "*/",
    }

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.api.nvim_win_set_cursor(0, {16, 4}) -- Moves cursor inside solve()
  end,
})
