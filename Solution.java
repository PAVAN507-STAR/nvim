import java.util.*;


public class Solution {
  public static void main(String[] args) {
    // Write your solution here
    Scanner sc = new Scanner(System.in);
    int n = sc.nextInt(), x = sc.nextInt(), mod = 1000000007;
    int[] a = new int[n];
    for (int i = 0; i < n; i++)
      a[i] = sc.nextInt();
    int[][] dp = new int[n + 1][x + 1];
    for (int i = 0; i < n; i++) {
      dp[i][0] = 1;
    }
    for (int i = n - 1; i >= 0; i--) {
      for (int k = 1; k <= x; k++) {
        dp[i][k] = dp[i + 1][k];
        if (k - a[i] >= 0) {
          dp[i][k] = (dp[i][k] + dp[i][k - a[i]]) % mod;
        }
      }
    }
    System.out.println(dp[0][x]);
    sc.close();
  }
}

