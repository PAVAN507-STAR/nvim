import java.util.*;

public class test3 {
  public static void main(String[] args) {
    try (Scanner sc = new Scanner(System.in)) {
      int t = sc.nextInt();
      while (t-- > 0) {
        solve(sc);
      }
    }
  }

  public static void solve(Scanner sc) {
    int t = sc.nextInt();
    System.out.println(t);
  }
}
