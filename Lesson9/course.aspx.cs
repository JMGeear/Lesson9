using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//model references for EF
using Lesson9.Models;
using System.Web.ModelBinding;

namespace Lesson9
{
    public partial class course : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetDepartments();

                //get the course if editing
                if (!String.IsNullOrEmpty(Request.QueryString["CourseID"]))
                {
                    GetCourse();
                }
            }
        }

        protected void GetCourse()
        {
           
            //connect to db via EF
            using (comp2007Entities db = new comp2007Entities())
            {
                Int32 CourseID = Convert.ToInt32(Request.QueryString["CourseID"]);

                Course objC = (from c in db.Courses
                               where c.CourseID == CourseID
                               select c).FirstOrDefault();

                //populate the form
                txtTitle.Text = objC.Title;
                txtCredits.Text = objC.Credits.ToString();
                ddlDepartment.SelectedValue = objC.DepartmentID.ToString();
            

                
            }

           
        }

        protected void GetDepartments()
        {
            using (comp2007Entities db = new comp2007Entities()) 
            {
                var deps = (from d in db.Departments
                            orderby d.Name
                            select d);

                ddlDepartment.DataSource = deps.ToList();
                ddlDepartment.DataBind();

                //enrollments - this code goes in the same method that populates the student form but below the existing code that's already in GetStudent()              
                var objE = (from en in db.Enrollments
                            join cr in db.Courses on en.CourseID equals cr.CourseID
                            join d in db.Departments on cr.DepartmentID equals d.DepartmentID
                            join s in db.Students on en.StudentID equals s.StudentID
                            select new { en.EnrollmentID, s.LastName, s.FirstMidName, cr.Title, d.Name });

                grdStudents.DataSource = objE.ToList();
                grdStudents.DataBind();
            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            //use EF to connect to SQL Server
            using (comp2007Entities db = new comp2007Entities())
            {

                Course objC = new Course();

                if (!String.IsNullOrEmpty(Request.QueryString["CourseID"]))
                {
                    Int32 CourseID = Convert.ToInt32(Request.QueryString["CourseID"]);
                    objC = (from c in db.Courses
                            where c.CourseID == CourseID
                            select c).FirstOrDefault();
                }

                //populate the course from the input form
                objC.Title = txtTitle.Text;
                objC.Credits = Convert.ToInt32(txtCredits.Text);
                objC.DepartmentID = Convert.ToInt32(ddlDepartment.SelectedValue);

                if (String.IsNullOrEmpty(Request.QueryString["CourseID"]))
                {
                    //add
                    db.Courses.Add(objC);
                }

                //save and redirect
                db.SaveChanges();
                Response.Redirect("courses.aspx");
            }
        }

        protected void grdStudents_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //get selected record id
            Int32 EnrollmentID = Convert.ToInt32(grdStudents.DataKeys[e.RowIndex].Values["EnrollmentID"]);

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
                GetCourse();
            }
        }



    }
}