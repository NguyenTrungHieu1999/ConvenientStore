using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
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
    public class ProductController : Controller
    {
        // GET: Product
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult RenderBarcode(string code)
        {
            Image img = null;
            using (var ms = new MemoryStream())
            {
                var writer = new ZXing.BarcodeWriter() { Format = BarcodeFormat.CODE_128 };
                writer.Options.Height = 40;
                writer.Options.Width = 140;
                writer.Options.PureBarcode = true;
                img = writer.Write(code);
                img.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                return File(ms.ToArray(), "image/jpeg");
            }
        }
        public ActionResult RenderQRcode(string code)
        {
            Image img = null;
            using (var ms = new MemoryStream())
            {
                var writer = new ZXing.BarcodeWriter();
                writer.Format = BarcodeFormat.QR_CODE;
                writer.Options.Height = 500;
                writer.Options.Width = 500;
                writer.Options.PureBarcode = true;
                img = writer.Write(code);
                img.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                return File(ms.ToArray(), "image/jpeg");
            }
        }
        [HttpGet]
        public ActionResult Details(long id)
        {
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            if(session==null)
            {
                ViewBag.Session = "null";
            }
            else
            {
                ViewBag.Session = session;
                ViewBag.Watched = session;
            }
            var product = new ProductData().ViewDetail(id);
            //Thêm barcode
            Image img = null;
            using (var ms = new MemoryStream())
            {
                var writer = new ZXing.BarcodeWriter() { Format = BarcodeFormat.CODE_128 };
                writer.Options.Height = 40;
                writer.Options.Width = 140;
                writer.Options.PureBarcode = true;
                img = writer.Write(product.BarCode);
                img.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                ViewBag.BarcodeImage = "data:image/png;base64," + Convert.ToBase64String(ms.ToArray());
                //return File(ms.ToArray(), "image/jpeg");
            }
            ViewBag.Product = product;
            //ViewBag.Comment = new CommentData().GetListComment(id);
            ViewBag.Type = new ProductData().RelateProduct(product.ProductID, product.CategoryID);
            ViewBag.User = new UserData().ListAll();
            ViewBag.Rating = new RatingData().ListProductRate(id);
            var productRate = new ProductRate()
            {
                ProductID = product.ProductID
            };
            return View(productRate);
        }
        [HttpPost]
        public ActionResult SendRate(ProductRate rate, double rating)
        {
            if(rating.ToString()==null)
            {
                rating = 0;
            }
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            var temp = new RatingData().Rated(session.userID, rate.ProductID);
            if(temp==null)
            {
                rate.UserID = session.userID;
                rate.RateStar = rating;
                new RatingData().insert(rate);
                var rateList = new RatingData().ListAll();
                var count = 0;
                double? star = 0;
                foreach (var obj in rateList)
                {
                    if (obj.ProductID == rate.ProductID)
                    {
                        star = star + obj.RateStar;
                        count++;
                    }
                }
                star = star / count;
                var product = new ProductData().GetByID(rate.ProductID);
                product.RateStar = star;
                new ProductData().UpdateRatingStar(product);
                return RedirectToAction("Details", "Product", new { id = rate.ProductID });
            }
            else
            {
                var productRate = new RatingData().GetByID(temp.ID);
                productRate.RateStar = rating;
                productRate.CommentContent = rate.CommentContent;
                new RatingData().update(productRate);
                var rateList = new RatingData().ListAll();
                var count = 0;
                double? star = 0;
                foreach (var obj in rateList)
                {
                    if (obj.ProductID == rate.ProductID)
                    {
                        star = star + obj.RateStar;
                        count++;
                    }
                }
                star = star / count;
                var product = new ProductData().GetByID(rate.ProductID);
                product.RateStar = star;
                new ProductData().UpdateRatingStar(product);
                return RedirectToAction("Details", "Product", new { id = rate.ProductID });
            }
        }
        public JsonResult ListName(string q)
        {
            var data = new ProductData().ListName(q);
            return Json(new
            {
                data = data,
                status = true
            }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult Category(long id)
        {
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            if (session == null)
            {
                ViewBag.Session = "null";
            }
            else
            {
                ViewBag.Session = session;
                ViewBag.Watched = session;
            }
            var model = new CategoryData().PageProduct(id);
            ViewBag.Category = new CategoryData().ViewDetail(id);
            return View(model);
        }
        public ActionResult Search(string keyword)
        {
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            if (session == null)
            {
                ViewBag.Session = "null";
            }
            else
            {
                ViewBag.Session = session;
            }
            ViewBag.Product = new ProductData().Search(keyword);
            ViewBag.keyWord = keyword;
            return View();
        }
        public ActionResult FavoriteProduct()
        {
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            if(session==null)
            {
                return RedirectToAction("Login", "Login");
            }
            ViewBag.FavoriteProduct = new ProductData().ListFavoriteProduct(session.userID);
            ViewBag.Product = new ProductData().ListAll();
            return View();
        }
        public ActionResult WatchedProduct()
        {
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            if (session == null)
            {
                return RedirectToAction("Login", "Login");
            }
            ViewBag.WatchedProduct = new ProductData().ListWatchedProduct(session.userID);
            ViewBag.Product = new ProductData().ListAll();
            return View();
        }
        public ActionResult Add(long id)
        {
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            if(session==null)
            {
                return RedirectToAction("Login", "Login");
            }
            var data = new ProductData().ListFavoriteProduct(session.userID);
            //Trở lại trang chi tiết sản phẩm khi sản phẩm này đã được yêu thích
            foreach (var item in data)
            {
                if(item.ProductID==id)
                {
                    var temp = new ProductData().GetByID(id);
                    return Redirect("/san-pham/chi-tiet/" + temp.MetaTitle + "/" + id);
                }
            }
            var favorite = new FavoriteProduct();
            favorite.UserID = session.userID;
            favorite.ProductID = id;
            new ProductData().InsertFavoriteProduct(favorite);
            var product = new ProductData().GetByID(id);
            return Redirect("/san-pham/chi-tiet/" + product.MetaTitle + "/" + id);
        }
        public ActionResult AddWatchedProduct(long id)
        {
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            if (session == null)
            {
                return RedirectToAction("Login", "Login");
            }
            var data = new ProductData().ListWatchedProduct(session.userID);
            //Trở lại trang chi tiết sản phẩm khi sản phẩm này đã được yêu thích
            foreach (var item in data)
            {
                if (item.ProductID == id)
                {
                    var temp = new ProductData().GetByID(id);
                    return Redirect("/san-pham/chi-tiet/" + temp.MetaTitle + "/" + id);
                }
            }
            var watched = new WatchedProduct();
            watched.UserID = session.userID;
            watched.ProductID = id;
            new ProductData().InsertWatchedProduct(watched);
            var product = new ProductData().GetByID(id);
            return Redirect("/san-pham/chi-tiet/" + product.MetaTitle + "/" + id);
        }
        public ActionResult Delete(long id)
        {
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            if (session == null)
            {
                return RedirectToAction("Login", "Login");
            }
            var favorite = new ProductData().GetFavotiteProduct(session.userID, id);
            new ProductData().DeleteFavoriteProduct(favorite.ID);
            return RedirectToAction("FavoriteProduct", "Product");
        }
    }
}