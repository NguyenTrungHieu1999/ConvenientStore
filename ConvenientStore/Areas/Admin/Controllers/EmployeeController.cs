using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ConvenientStore.Areas.Admin.Models;
using ConvenientStore.Common;
using ConvenientStore.Controllers;
using DocumentFormat.OpenXml.EMMA;
using Models.EF;
using Models.GetData;
using Models.ViewModel;

namespace ConvenientStore.Areas.Admin.Controllers
{
    public class EmployeeController : BaseController
    {
        ConvenientStoreDBContext db = null;
        public EmployeeController()
        {
            db = new ConvenientStoreDBContext();
        }
        // GET: Admin/Employee
        [HasCredential(RoleID = "VIEW_EMP")]
        public ActionResult Index(string searchString, int page = 1, int pageSize = 2)
        {
            var data = new EmpData();
            var model = data.ListAllEmployee(searchString, page, pageSize);
            ViewBag.SearchString = searchString;
            return View(model);
        }
        public void SetViewBagUser(long? selectedID = null)
        {
            var userData = new UserData();
            ViewBag.EmpID = new SelectList(userData.ListAll(), "UserID", "Name", selectedID);
        }
        [HttpGet]
        [HasCredential(RoleID = "CREATE_EMP")]
        public ActionResult Create()
        {
            SetViewBagUser();
            return View();
        }
        [HttpPost]
        [HasCredential(RoleID = "CREATE_EMP")]
        public ActionResult Create(EmployeeViewModel model)
        {
            if (ModelState.IsValid)
            {
                model.GroupID = "EMP";
                var data = new EmpData();
                if (data.insert(model) != -1)
                {
                    SetAlert("Thêm nhân viên thành công", "success");
                    return RedirectToAction("Index", "Employee");
                }
                else
                {
                    SetAlert("Người này đã là nhân viên của cửa hàng", "error");
                }
            }
            SetViewBagUser();
            return View();
        }
        [HttpGet]
        [HasCredential(RoleID = "EDIT_EMP")]
        public ActionResult Edit(long ID)
        {
            var session = new EditEmp();
            session.USERID = ID;
            Session.Add(CommonConstants.EMP_SESSION, session);
            var model = new EmpData().GetByID(ID);
            return View(model);
        }
        [HttpPost]
        [HasCredential(RoleID = "EDIT_EMP")]
        public ActionResult Edit(EmployeeViewModel model)
        {
            var session = (EditEmp)Session[CommonConstants.EMP_SESSION];
            model.GroupID = "EMP";
            model.ID = session.USERID;
            var data = new EmpData();
            var user = new UserData();
            model.EmpID = user.GetEMPID(session.USERID);
            var result = data.update(model);
            if (result)
            {
                SetAlert("Sửa nhân viên thành công", "success");
                return RedirectToAction("Index", "Employee");
            }
            else
            {
                SetAlert("Sửa không thành công", "error");
            }
            return View();
        }
        [HttpDelete]
        [HasCredential(RoleID = "DELETE_EMP")]
        public ActionResult Delete(long ID)
        {
            var user = new UserData().GetByID(new EmpData().GetByID(ID).EmpID);
            user.GroupID = "CLIENT";
            new EmpData().UpdateGroupID(user);
            new EmpData().Delete(ID);
            SetAlert("Xóa thành công", "success");
            return RedirectToAction("Index", "Employee");
        }
    }
}