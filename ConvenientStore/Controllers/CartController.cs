using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ConvenientStore.Common;
using ConvenientStore.Models;
using Models.EF;
using Models.GetData;
using System.Web.Script.Serialization;
using System.Net.Mail;
using System.Net;
using System.Drawing;
using System.IO;
using ZXing;

namespace ConvenientStore.Controllers
{
    /// <summary>
    /// Người thực hiện: Nguyễn Trung Hiếu
    /// </summary>
    public class CartController : Controller
    {
        // GET: Cart
        public ActionResult Index()
        {
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            if (session == null)
            {
                return RedirectToAction("Login", "Login", new { area = "" });
            }
            var list = new List<CartModel>();
            var cart = new CartData().GetByUserID(session.userID);
            var product = new ProductData().ListAll();
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
            return View(list);
        }
        public ActionResult AddCart(long productID, int quantity)
        {
            bool exists = false;
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            if (session == null)
            {
                return RedirectToAction("Login", "Login", new { area = "" });
            }
            var list = new List<CartModel>();
            var cart = new CartData().GetByUserID(session.userID);
            var product = new ProductData().ListAll();
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
            foreach (var item in list)
            {
                //Cập nhât hàng hóa đã có sẵn
                if(item.Product.ProductID==productID)
                {
                    item.Quantity = item.Quantity + quantity;
                    var temp = new Cart();
                    temp.CartID = item.CartID;
                    temp.UserID = session.userID;
                    temp.ProductID = item.Product.ProductID;
                    temp.Quantity = item.Quantity;
                    new CartData().Update(temp);
                }
            }
            foreach(var item in list)
            {
                if (item.Product.ProductID == productID)
                {
                    exists = true;
                    break;
                }
            }
            if (exists == false)
            {
                var cartModel = new Cart();
                cartModel.UserID = session.userID;
                cartModel.ProductID = productID;
                cartModel.Quantity = quantity;
                new CartData().Insert(cartModel);
            }
            return Redirect(Request.UrlReferrer.ToString());
        }
        public JsonResult DeleteAll()
        {
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            if (session == null)
            {
                RedirectToAction("Login", "Login", new { area = "" });
            }
            var list = new CartData().ListAllUserCart(session.userID);
            foreach(var item in list)
            {
                new CartData().Delete(item);
            }
            return Json(new
            {
                status = true
            });
        }
        public JsonResult Delete(long ID)
        {
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            if (session == null)
            {
                RedirectToAction("Login", "Login", new { area = "" });
            }
            var list = new CartData().ListAllUserCart(session.userID);
            foreach (var item in list)
            {
                if (item.ProductID == ID)
                {
                    new CartData().Delete(item);
                }
            }
            return Json(new
            {
                status = true
            });
        }
        public JsonResult Update(string cartModel)
        {
            var jsonCart = new JavaScriptSerializer().Deserialize<List<CartModel>>(cartModel);
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            if (session == null)
            {
                RedirectToAction("Login", "Login", new { area = "" });
            }
            var list = new List<CartModel>();
            var cart = new CartData().GetByUserID(session.userID);
            var product = new ProductData().ListAll();
            foreach (var temp in cart)
            {
                foreach (var item in product)
                {
                    if (temp.ProductID == item.ProductID)
                    {
                        var model = new CartModel();
                        model.CartID = temp.CartID;
                        model.UserID = session.userID;
                        model.Product = item;
                        model.Quantity = temp.Quantity;
                        list.Add(model);
                    }
                }
            }
            foreach(var item in list)
            {
                var jsonItem = jsonCart.SingleOrDefault(x => x.Product.ProductID == item.Product.ProductID);
                if (jsonItem != null)
                {
                    item.Quantity = jsonItem.Quantity;
                    var model = new Cart();
                    model.CartID = item.CartID;
                    model.UserID = session.userID;
                    model.ProductID = item.Product.ProductID;
                    model.Quantity = item.Quantity;
                    new CartData().Update(model);
                }
            }
            return Json(new
            {
                status = true
            });
        }
        [HttpGet]
        public ActionResult Payment()
        {
            decimal? total = 0;
            decimal? totalMoney = 0;
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            if (session == null)
            {
                RedirectToAction("Login", "Login", new { area = "" });
            }
            else
            {
                ViewBag.User = new UserData().GetByID(session.userID);
                var list = new List<CartModel>();
                var cart = new CartData().GetByUserID(session.userID);
                var product = new ProductData().ListAll();
                foreach (var temp in cart)
                {
                    foreach (var item in product)
                    {
                        if (temp.ProductID == item.ProductID)
                        {
                            var model = new CartModel();
                            model.CartID = temp.CartID;
                            model.UserID = session.userID;
                            model.Product = item;
                            model.Quantity = temp.Quantity;
                            list.Add(model);
                            total = total + model.Quantity * model.Product.PromotionPrice;
                        }
                    }
                }
                totalMoney = total;
                Session.Add(CommonConstants.BILL_SESSION, totalMoney);
                ViewBag.Total = total;
                return View(list);
            }
            return View();
        }
        [HttpPost]
        public ActionResult Payment(string Address, string CreditCard)
        {
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            var bill_session = (decimal?)Session[CommonConstants.BILL_SESSION];
            if(session==null)
            {
                return RedirectToAction("Login", "Login");
            }
            else
            {
                if(bill_session != null)
                {
                    var user = new UserData().GetByID(session.userID);
                    var cart = new CartData().GetByUserID(session.userID);
                    try
                    {
                        var bill = new Bill
                        {
                            UserID = session.userID,
                            CreateDate = DateTime.Now,
                            TotalMoney = bill_session.Value,
                            Status = 0,
                            Address = Address,
                            CreditCard = CreditCard
                        };
                        //Thêm vào hóa đơn
                        var id = new BillData().insert(bill);
                        if (id != -1)
                        {
                            var list = new List<CartModel>();
                            if (session == null)
                            {
                                return RedirectToAction("Login", "Login");
                            }
                            else
                            {
                                var product = new ProductData().ListAll();
                                foreach (var temp in cart)
                                {
                                    foreach (var item in product)
                                    {
                                        if (temp.ProductID == item.ProductID)
                                        {
                                            var model = new CartModel();
                                            model.CartID = temp.CartID;
                                            model.UserID = session.userID;
                                            model.Product = item;
                                            model.Quantity = temp.Quantity;
                                            list.Add(model);
                                        }
                                    }
                                }
                                var detaildata = new BillDetailData();
                                foreach (var item in list)
                                {
                                    var detail = new BillDetail();
                                    detail.BillID = id;
                                    detail.ProductID = item.Product.ProductID;
                                    detail.Price = item.Product.PromotionPrice;
                                    detail.Quantity = item.Quantity;
                                    //Thêm vào chi tiết hóa đơn
                                    var check = detaildata.insert(detail);
                                    if (check == -1)
                                    {
                                        ViewBag.ThongBao = "Đặt hàng thất bại!";
                                        return View(cart);
                                    }
                                }
                                try
                                {
                                    //Gửi mail
                                    var mail = new SmtpClient("smtp.gmail.com", 587)
                                    {
                                        Credentials = new NetworkCredential("gintokixkagura@gmail.com", "ZXCVB@1999"),
                                        EnableSsl = true
                                    };
                                    DateTime UpdatedTime = bill.CreateDate ?? DateTime.Now;
                                    //Tạo email
                                    var message = new MailMessage("gintokixkagura@gmail.com", user.Email);
                                    //attach
                                    message.Subject = "Hóa đơn điện tử";
                                    string htmlString = @"<html>
                                <body>
                                <p>Chào quý khách,</p>
                                <p>Vào " + UpdatedTime.ToString("dddd, dd MMMM yyyy") +
                                            " bạn đã mua hàng tại <a href=https://localhost:44377/ >ConvenientStore</a></p>" +
                                            "<p>Chân thành cảm ơn quý khách.</p>" +
                                            "</body>" +
                                            "</html>";
                                    message.IsBodyHtml = true;
                                    message.Body = htmlString;
                                    mail.Send(message);
                                }
                                catch
                                {

                                }
                                //Xóa hàng khỏi giỏ hàng khi đã mua
                                if (cart != null)
                                {
                                    foreach (var item in list)
                                    {
                                        foreach (var userCart in cart)
                                        {
                                            if (item.Product.ProductID == userCart.ProductID)
                                            {
                                                new CartData().Delete(userCart);
                                            }
                                        }
                                    }
                                }
                                Session[CommonConstants.BILL_SESSION] = null;
                                return Redirect("~/dat-hang/thanh-cong/" + bill.BillID);
                            }
                        }
                        else
                        {
                            ViewBag.ThongBao = "Đặt hàng thất bại ở bill id!";
                            return View();
                        }
                    }
                    catch (Exception)
                    {
                        ViewBag.ThongBao = "Đặt hàng thất bại ở exception!";
                        return View();
                    }
                }
                ViewBag.ThongBao = "Đặt hàng thất bại, đã có lỗi xảy ra";
                return View();
            }
        }
        public ActionResult Success(long id)
        {
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            if (session == null)
            {
                return RedirectToAction("Login", "Login");
            }
            var model = new BillData().ListBillByID(session.userID, id);
            ViewBag.UserName = session.name;
            return View(model);
        }
        public ActionResult RenderQRcode(string code)
        {
            Image img = null;
            using (var ms = new MemoryStream())
            {
                var writer = new ZXing.BarcodeWriter();
                writer.Format = BarcodeFormat.QR_CODE;
                writer.Options.Height = 160;
                writer.Options.Width = 160;
                writer.Options.PureBarcode = true;
                img = writer.Write(code);
                img.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                return File(ms.ToArray(), "image/jpeg");
            }
        }
    }
}