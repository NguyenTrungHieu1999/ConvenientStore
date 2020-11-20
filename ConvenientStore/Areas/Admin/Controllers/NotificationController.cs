using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using ConvenientStore.Areas.Admin.Models;
using ConvenientStore.Common;
using Models.EF;
using Models.GetData;

namespace ConvenientStore.Areas.Admin.Controllers
{
    public class NotificationController : BaseController
    {
        ConvenientStoreDBContext db = null;
        public NotificationController()
        {
            db = new ConvenientStoreDBContext();
        }
        //Xóa thẻ
        public string RemoveHtml(string text)
        {
            return Regex.Replace(text, "<[^>]*>", string.Empty);
        }
        // GET: Admin/Notification
        public ActionResult Index(string searchString, int page = 1, int pageSize = 2)
        {
            var data = new NotificationData();
            var model = data.ListAllNotification(searchString, page, pageSize);
            ViewBag.SearchString = searchString;
            return View(model);
        }
        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Create(Notification notification)
        {
            if (ModelState.IsValid)
            {
                var session = (UserLogin)Session[CommonConstants.USER_SESSION];
                if(session==null)
                {
                    return RedirectToAction("Login", "Login");
                }
                var data = new NotificationData();
                notification.CreateDate = DateTime.Now;
                notification.CreateBy = session.name;
                notification.ModifiedDate = DateTime.Now;
                notification.ModifiedBy = session.name;
                data.insert(notification);
                SetAlert("Thêm thông báo thành công", "success");
                return RedirectToAction("Index", "Notification");
            }
            return View();
        }
        [HttpGet]
        public ActionResult Edit(long ID)
        {
            var notification = new NotificationData().GetByID(ID);
            return View(notification);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(Notification notification)
        {
            if (ModelState.IsValid)
            {
                var session = (UserLogin)Session[CommonConstants.USER_SESSION];
                if (session == null)
                {
                    return RedirectToAction("Login", "Login");
                }
                var data = new NotificationData();
                notification.ModifiedDate = DateTime.Now;
                notification.ModifiedBy = session.name;
                var result = data.update(notification);
                if (result)
                {
                    SetAlert("Sửa thông báo thành công", "success");
                    return RedirectToAction("Index", "Notification");
                }
                else
                {
                    SetAlert("Sửa thông báo không thành công", "error");
                }
            }
            return View();
        }
        [HttpDelete]
        public ActionResult Delete(long ID)
        {
            new NotificationData().Delete(ID);
            SetAlert("Xóa thành công", "success");
            return RedirectToAction("Index", "Notification");
        }
        [HttpPost]
        public JsonResult ChangeStatus(long id)
        {
            var result = new NotificationData().ChangeStatus(id);
            return Json(new
            {
                status = result
            });
        }
    }
}