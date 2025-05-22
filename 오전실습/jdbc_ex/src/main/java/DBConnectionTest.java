import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnectionTest {
    public static void main(String[] args) {
        try {
            // 1. 드라이버 로딩
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 2. 연결 정보
            String url = "jdbc:mysql://localhost:3306/jdbc_ex";
            String user = "scoula";
            String password = "1234";

            // 3. 연결 시도
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println("DB 연결 성공!");

            // 4. 연결 종료
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
