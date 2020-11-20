using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ConvenientStore.Areas.Admin.Models;
using ConvenientStore.Common;
using ConvenientStore.Models;
using Models.EF;
using Models.GetData;

namespace ConvenientStore.Controllers
{
    /// <summary>
    /// Người thực hiện: Nguyễn Trung Hiếu
    /// </summary>
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            ViewBag.Session = session;
            ViewBag.Product = new ProductData().ListAll();
            ViewBag.ProductCategory = new CategoryData().ListAllCategory();
            ViewBag.SpecialOffer = new ProductData().ListSpecialOffer();
            ViewBag.Rating = new RatingData().ListAll();
            return View();
        }
        [ChildActionOnly]
        public ActionResult MainMenu()
        {
            ViewBag.SubMenu = new CategoryData().ListAllCategory();
            return PartialView();
        }
        [ChildActionOnly]
        public ActionResult MenuTop()
        {
            ViewBag.Notification = new NotificationData().ListAllNotification();
            return PartialView();
        }
        [ChildActionOnly]
        public ActionResult Slide()
        {
            var model = new CategoryData().ListAll();
            return PartialView(model);
        }
        [ChildActionOnly]
        public PartialViewResult Cart()
        {
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            var list = new List<CartModel>();
            if (session != null)
            {
                var cart = new CartData().GetByUserID(session.userID);
                var product = new ProductData().ListAll();
                //var cart = Session[CommonConstants.CartSession];
                //if (cart != null)
                //{
                //    list = (List<CartModel>)cart;
                //}
                foreach (var temp in cart)
                {
                    foreach (var item in product)
                    {
                        if (temp.ProductID == item.ProductID)
                        {
                            var cartModel = new CartModel();
                            cartModel.CartID = temp.CartID;
                            cartModel.UserID = session.userID;
                            cartModel.Product = item;
                            cartModel.Quantity = temp.Quantity;
                            list.Add(cartModel);
                        }
                    }
                }
            }
            return PartialView(list);
        }
    }
}