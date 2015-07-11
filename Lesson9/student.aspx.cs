using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Lesson9.Models;
using System.Web.ModelBinding;

namespace Lesson9
{
    public partial class student : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if save wasnot clicked and we have a student id
            if (!IsPostBack && (Request.QueryString.Count > 0))
            {
                GetStudent();
            }
        }
        protected void GetStudent()
        {
            // populate form
            Int32 StudentID = Convert.ToInt32(Request.QueryString["StudentID"]);
            //Connect
            using (comp2007Entities db = new comp2007Entities())
            {
                Student s = (from objs in db.Students
                             where objs.StudentID == StudentID
                             select objs).FirstOrDefault();

                //Map student to controls
                if (s != null)
                {
                    txtLastName.Text = s.LastName;
                    txtFirstMidName.Text = s.FirstMidName;
                    txtEnrollmentDate.Text = s.EnrollmentDate.ToString("yyyy-mm-dd");
                }

                //enrollments - this code goes in the same method that populates the student form but below the existing code that's already in GetStudent()              
                var objE = (from en in db.Enrollments
                            join c in db.Courses on en.CourseID equals c.CourseID
                            join d in db.Departments on c.DepartmentID equals d.DepartmentID
                            where en.StudentID == StudentID
                            select new { en.EnrollmentID, en.Grade, c.Title, d.Name });

                grdCourses.DataSource = objE.ToList();
                grdCourses.DataBind();

            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            //use EF to connect to SQL Server
            using (comp2007Entities db = new comp2007Entities())
            {

                //use the Student model to save the new record
                Student s = new Student();
                Int32 StudentID = 0;

                //check query string
                if (Request.QueryString["StudentID"] != null)
                {
                    //Get url
                    StudentID = Convert.ToInt32(Request.QueryString["StudentID"]);

                    //Get Student
                    s = (from objs in db.Students
                         where objs.StudentID == StudentID
                         select objs).FirstOrDefault();
                }

                s.LastName = txtLastName.Text;
                s.FirstMidName = txtFirstMidName.Text;
                s.EnrollmentDate = Convert.ToDateTime(txtEnrollmentDate.Text);

                if (StudentID == 0)
                {
                    db.Students.Add(s);
                }
                db.SaveChanges();

                //redirect to the updated students page
                Response.Redirect("students.aspx");
            }
        }

        protected void grdCourses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //get selected record id
            Int32 EnrollmentID = Convert.ToInt32(grdCourses.DataKeys[e.RowIndex].Values["EnrollmentID"]);

            using (comp2007Entities db = new comp2007Entities())
            {
                //get selected record
                Enrollment objE = (from en in db.Enrollments
                                   where en.EnrollmentID == EnrollmentID
                                   select en).FirstOrDefault();

                //delete
                db.Enrollments.Remove(objE);
                db.SaveChanges();

                //refresh the data on the page
                GetStudent();
            }
        }
    }
}