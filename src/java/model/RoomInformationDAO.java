
package model;

import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

public class RoomInformationDAO extends MyDAO{
    public List<RoomInformation> getRoomInformation(String xRoomID) {
    List<RoomInformation> t = new ArrayList<>();
    xSql = 
         "WITH CTE AS ( " +
                "    SELECT s.StudentID, s.StudentName, a.RoomID, a.AssignmentEnd, p.Status, " +
                "           ROW_NUMBER() OVER (PARTITION BY s.StudentID ORDER BY a.AssignmentEnd DESC) AS RowNum " +
                "    FROM Students s " +
                "    LEFT OUTER JOIN Assignments a ON s.StudentID = a.StudentID " +
                "    JOIN Payments p ON a.AssignmentID = p.AssignmentID " +
                "    WHERE a.RoomID = ? AND a.AssignmentEnd > GETDATE() " +
                "    AND (p.Status = 'Pending' OR p.Status = 'Completed') " +
                ") " +
                "SELECT StudentID, StudentName, RoomID, AssignmentEnd FROM CTE WHERE RowNum = 1";
    String xStudentID;
    String xStudentName;
    Date xAssignmentEnd;
    RoomInformation x;
    try {
      ps = con.prepareStatement(xSql);
      ps.setString(1, xRoomID);
      rs = ps.executeQuery();
      while(rs.next()) {  
        xStudentID = rs.getString("StudentID");  
        xStudentName = rs.getString("StudentName");
        xAssignmentEnd = rs.getDate("AssignmentEnd");
        x = new RoomInformation(xStudentID,xStudentName,xRoomID,xAssignmentEnd);
        t.add(x);
      }
      rs.close();
      ps.close();
     }
     catch(Exception e) {
        e.printStackTrace();
     }
    return(t);
  }
}
