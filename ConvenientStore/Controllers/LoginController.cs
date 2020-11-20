using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using ConvenientStore.Areas.Admin.Models;
using ConvenientStore.Common;
using Models.EF;
using Models.GetData;
using ConvenientStore.Models;
using System.Net;
using System.Text;
using System.Xml.Linq;
using BotDetect.Web.Mvc;

namespace ConvenientStore.Controllers
{
    /// <summary>
    /// Người thực hiện: Nguyễn Trung Hiếu
    /// </summary>
    public class LoginController : Controller
    {
        ConvenientStoreDBContext db = null;
        public LoginController()
        {
            db = new ConvenientStoreDBContext();
        }
        public void SetAlert(string message, string type)
        {
            TempData["AlertMessage"] = message;
            if (type == "success")
            {
                TempData["AlertType"] = "alert-success";
            }
            else if (type == "warning")
            {
                TempData["AlertType"] = "alert-warning";
            }
            else if (type == "error")
            {
                TempData["AlertType"] = "alert-danger";
            }
        }
        // GET: Admin/Login
        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }
        public ActionResult Logout()
        {
            Session[CommonConstants.USER_SESSION] = null;
            return Redirect("/");
        }
        [HttpPost]
        public ActionResult Login(LoginModel model)
        {
            if (ModelState.IsValid)
            {
                var data = new UserData();
                var result = data.isLogin(model.UserName, Encryptor.SHA256Hash(model.Password), true);
                if (result == 1)
                {
                    var user = data.GetByUserName(model.UserName);
                    var userSession = new UserLogin();
                    userSession.userName = user.UserName;
                    userSession.userID = user.UserID;
                    userSession.groupID = user.GroupID;
                    userSession.name = user.Name;
                    //var listCredentials = data.GetListCredential(model.UserName);
                    var listCredentials = new List<string>();
                    Session.Add(CommonConstants.SESSION_CREDENTIALS, listCredentials);
                    Session.Add(CommonConstants.USER_SESSION, userSession);
                    return RedirectToAction("Index", "Home", new { area = "Admin" });
                }
                else if (result == 2)
                {
                    var user = data.GetByUserName(model.UserName);
                    var userSession = new UserLogin();
                    userSession.userName = user.UserName;
                    userSession.userID = user.UserID;
                    userSession.groupID = user.GroupID;
                    userSession.name = user.Name;
                    Session.Add(CommonConstants.USER_SESSION, userSession);
                    return RedirectToAction("Index", "Home");
                }
                else if (result == -1)
                {
                    ViewBag.ThongBao = "Tài khoản tạm thời bị khóa";
                }
                else
                {
                    ViewBag.ThongBao = "Tên tài khoản hoặc mật khẩu không hợp lệ";
                }
            }
            return View();
        }
        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        [CaptchaValidationActionFilter("CaptchaCode", "registerCaptcha", "Mã xác nhận không đúng!")]
        public ActionResult Register(Register model)
        {
            if (ModelState.IsValid)
            {
                var result = this.db.Users.SingleOrDefault(x => x.UserName == model.UserName);
                if (result == null)
                {
                    if (model.PassWord == model.ConfirmPassWord)
                    {
                        if (model.PassWord.Length >= 6 && model.PassWord.Any(char.IsUpper))
                        {
                            var data = new UserData();
                            var encryptor = Encryptor.SHA256Hash(model.PassWord);
                            model.PassWord = encryptor;
                            var user = new User();
                            user.UserName = model.UserName;
                            user.Email = model.Email;
                            user.Password = model.PassWord;
                            user.Name = model.Name;
                            user.DateOfBirth = model.DateOfBirth;
                            user.Sex = model.Sex;
                            user.Address = model.Address;
                            user.Phone = model.Phone;
                            user.GroupID = "CLIENT";
                            user.Status = true;
                            data.insert(user);
                            SetAlert("Dang ky thanh cong","success");
                            return RedirectToAction("Login", "Login");
                        }
                        else
                        {
                            ViewBag.ThongBao = "Mật khẩu phải chứa ít nhất một chữ in hoa và có ít nhất 6 ký tự";
                        }
                    }
                    else ViewBag.ThongBao = "Mật khẩu không khớp";
                }
                else
                {
                    ViewBag.ThongBao = "Tài khoản đã tồn tại";
                }
            }
            MvcCaptcha.ResetCaptcha("registerCaptcha");
            return View();
        }
        [HttpGet]
        public ActionResult PasswordEmail()
        {
            return View();
        }
        [HttpPost]
        public ActionResult PasswordEmail(MailModel model)
        {
            try
            {
                Random rd = new Random();
                var data = new UserData();
                var user = data.GetByEmail(model.To);
                if (user != null)
                {
                    int securityCode = rd.Next(000000, 999999);
                    //Cấu hình thông tin Gmail
                    var mail = new SmtpClient("smtp.gmail.com", 587)
                    {
                        Credentials = new NetworkCredential("gintokixkagura@gmail.com", "ZXCVB@1999"),
                        EnableSsl = true
                    };
                    //Tạo email
                    var message = new MailMessage("gintokixkagura@gmail.com", model.To);
                    //attach
                    message.Subject = "Yêu cầu đặt lại mật khẩu";
                    string htmlString = @"<html>
                                <body>
                                <p>Chào quý khách,</p>
                                <p>Chúng tôi đã nhận được yêu cầu thay đổi mật khẩu của quý khách.</p>
                                <p>Nhập mã đặt lại mật khẩu sau đây: " + securityCode +
                                "</p>" +
                                "</body>" +
                                "</html>";
                    message.IsBodyHtml = true;
                    message.Body = htmlString;
                    mail.Send(message);
                    var session = new UserChangePassword();
                    session.userID = user.UserID;
                    session.securityCode = securityCode.ToString();
                    Session.Add(CommonConstants.CODE_SESSION, session);
                    return Redirect("~/Login/ChangePassword/" + user.UserID);
                }
                else
                {
                    ViewBag.ThongBao = "Email không tồn tại. Vui lòng nhập lại!";
                    return View(model);
                }
            }
            catch
            {
                ViewBag.ThongBao = "Không gửi được mail, hãy kiểm tra lại kết nối internet";
                return View(model);
            }
        }
        [HttpGet]
        public ActionResult ChangePassword(long id)
        {
            var user = new UserData().GetByID(id);
            var model = new ChangePassword();
            model.userName = user.UserName;
            return View(model);
        }

        [HttpPost]
        public ActionResult ChangePassword(ChangePassword model)
        {
            var session = (UserChangePassword)Session[CommonConstants.CODE_SESSION];
            var user = new UserData().GetByUserName(model.userName);
            if (user != null)
            {
                if (session != null)
                {
                    if (session.userID == user.UserID)
                    {
                        if(session.securityCode==model.securityCode)
                        {
                            if (model.passWord.ToString() != model.confirmPassWord.ToString())
                            {
                                ViewBag.ThongBao = "Mật khẩu không khớp";
                            }
                            else
                            {
                                if (model.passWord.Length >= 6 && model.passWord.Any(char.IsUpper))
                                {
                                    var encryptor = Encryptor.SHA256Hash(model.passWord);
                                    user.Password = encryptor;
                                    new UserData().UpdatePassword(user);
                                    Session[CommonConstants.CODE_SESSION] = null;
                                    SetAlert("Doi mat khau thanh cong", "success");
                                    return RedirectToAction("Login", "Login");
                                }
                                else
                                {
                                    ViewBag.ThongBao = "Mật khẩu phải chứa ít nhất một chữ in hoa và có ít nhất 6 ký tự";
                                }
                            }
                        }
                        else
                        {
                            ViewBag.ThongBao = "Mã bảo mật sai";
                        }
                    }
                    else
                    {
                        ViewBag.ThongBao = "Mã bảo mật sai";
                    }
                }
                else
                {
                    ViewBag.ThongBao = "Mã bảo mật sai";
                }
            }
            else { ViewBag.ThongBao = "Tên tài khoản hoặc mật khẩu không hợp lệ"; }
            return View();
        }
        public ActionResult MyAccount(long id)
        {
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            if (session == null)
            {
                return RedirectToAction("Login", "Login");
            }
            var model = new UserData().GetByID(session.userID);
            return View(model);

        }
        [HttpGet]
        public ActionResult UpdateAccount(long id)
        {
            var user = new UserData().GetByID(id);
            return View(user);
        }
        [HttpPost]
        public ActionResult UpdateAccount(User user)
        {
            var session = (UserLogin)Session[CommonConstants.USER_SESSION];
            if (session == null)
            {
                return RedirectToAction("Login", "Login");
            }
            if (user.UserID == session.userID)
            {
                if (new UserData().UserUpdate(user))
                {
                    return Redirect("~/tai-khoan/" + user.UserID);
                }
                else
                {
                    ViewBag.ThongBao = "Không cập nhật được";
                    return View();
                }
            }
            ViewBag.ThongBao = "Bạn không có quyền thực hiện hành động này";
            return View();
        }
    }
}