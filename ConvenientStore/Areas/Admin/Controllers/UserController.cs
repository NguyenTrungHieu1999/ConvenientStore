using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ConvenientStore.Areas.Admin.Models;
using ConvenientStore.Common;
using Models.EF;
using Models.GetData;

namespace ConvenientStore.Areas.Admin.Controllers
{
    public class UserController : BaseController
    {
         ConvenientStoreDBContext db = null;
        public UserController()
        {
            db = new ConvenientStoreDBContext();
        }
        // GET: Admin/User
        [HasCredential(RoleID = "VIEW_USER")]
        public ActionResult Index(string searchString, int page = 1, int pageSize = 2)
        {
            var data = new UserData();
            var model = data.ListAllUser(searchString, page, pageSize);
            ViewBag.SearchString = searchString;
            return View(model);
        }
        [HttpGet]
        [HasCredential(RoleID = "ADD_USER")]
        public ActionResult Create()
        {
            return View();
        }
        [HttpPost]
        [HasCredential(RoleID = "ADD_USER")]
        public ActionResult Create(User user)
        {
            var result = this.db.Users.SingleOrDefault(x => x.UserName == user.UserName);
            if (ModelState.IsValid)
            {
                if(result==null)
                {
                    if (user.Password.Length >= 6 && user.Password.Any(char.IsUpper))
                    {
                        var data = new UserData();
                        var encryptor = Encryptor.SHA256Hash(user.Password);
                        user.Password = encryptor;
                        user.GroupID = "CLIENT";
                        data.insert(user);
                        SetAlert("Thêm user thành công", "success");
                        return RedirectToAction("Index", "User");
                    }
                    else
                    {
                        SetAlert("Mật khẩu phải chứa ít nhất một chữ in hoa và có ít nhất 6 ký tự","error");
                    }
                }
                else
                {
                    SetAlert("Tên tài khoản đã tồn tại", "error");
                }
            }
            return View();
        }
        [HttpGet]
        [HasCredential(RoleID = "EDIT_USER")]
        public ActionResult Edit(long ID)
        {
            var user = new UserData().GetByID(ID);
            return View(user);
        }
        [HttpPost]
        [HasCredential(RoleID = "EDIT_USER")]
        public ActionResult Edit(User user)
        {
            var data = new UserData();
            var result = data.update(user);
            if (result)
            {
                SetAlert("Sửa user thành công", "success");
                return RedirectToAction("Index", "User");
            }
            else
            {
                SetAlert("Sửa không thành công", "error");
            }
            return View();
        }
        [HttpPost]
        public JsonResult ChangeStatus(long id)
        {
            var result = new UserData().ChangeStatus(id);
            return Json(new
            {
                status = result
            });
        }
    }
}