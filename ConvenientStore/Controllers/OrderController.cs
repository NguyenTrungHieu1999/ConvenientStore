using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ConvenientStore.Areas.Admin.Models;
using ConvenientStore.Common;
using Models.EF;
using Models.GetData;
using ZXing;

namespace ConvenientStore.Controllers
{
    /// <summary>
    /// Người thực hiện: Nguyễn Trung Hiếu
    /// </summary>
    public class OrderController : Controller
    {
        // GET: Order
        public ActionResult Index()
        {
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            if(session==null)
            {
                return RedirectToAction("Login", "Login");
            }
            ViewBag.Order = new OrderData().GetOrderList(session.userID);
            return View();
        }
    }
}