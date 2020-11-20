using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

using ConvenientStore.Areas.Admin.Models;
using ConvenientStore.Common;
using Models.EF;
using Models.GetData;

namespace ConvenientStore
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.IgnoreRoute("{*botdetect}",
                new { botdetect = @"(.*)BotDetectCaptcha\.ashx" });

            routes.MapRoute(
                name: "EditAccount",
                url: "tai-khoan/sua-tai-khoan/{id}",
                defaults: new { controller = "Login", action = "UpdateAccount", id = UrlParameter.Optional },
                namespaces: new[] { "ConvenientStore.Controllers" }
            );

            routes.MapRoute(
                name: "Success",
                url: "dat-hang/thanh-cong/{id}",
                defaults: new { controller = "Cart", action = "Success", id = UrlParameter.Optional },
                namespaces: new[] { "ConvenientStore.Controllers" }
            );

            routes.MapRoute(
                name: "Account",
                url: "tai-khoan/{id}",
                defaults: new { controller = "Login", action = "MyAccount", id = UrlParameter.Optional },
                namespaces: new[] { "ConvenientStore.Controllers" }
            );

            routes.MapRoute(
                name: "Order",
                url: "don-hang/",
                defaults: new { controller = "Order", action = "Index", id = UrlParameter.Optional },
                namespaces: new[] { "ConvenientStore.Controllers" }
            );

            routes.MapRoute(
                name: "Watched Product",
                url: "san-pham/san-pham-da-xem",
                defaults: new { controller = "Product", action = "WatchedProduct", id = UrlParameter.Optional },
                namespaces: new[] { "ConvenientStore.Controllers" }
            );

            routes.MapRoute(
                name: "Favorite Product",
                url: "san-pham/san-pham-yeu-thich",
                defaults: new { controller = "Product", action = "FavoriteProduct", id = UrlParameter.Optional },
                namespaces: new[] { "ConvenientStore.Controllers" }
            );

            routes.MapRoute(
                name: "Product Category",
                url: "san-pham/{metatitle}/{id}",
                defaults: new { controller = "Product", action = "Category", id = UrlParameter.Optional },
                namespaces: new[] { "ConvenientStore.Controllers" }
            );

            routes.MapRoute(
                name: "Product Detail",
                url: "san-pham/chi-tiet/{metatitle}/{id}",
                defaults: new { controller = "Product", action = "Details", id = UrlParameter.Optional },
                namespaces: new[] { "ConvenientStore.Controllers" }
            );

            routes.MapRoute(
                name: "Search",
                url: "tim-kiem",
                defaults: new { controller = "Product", action = "Search", id = UrlParameter.Optional },
                namespaces: new[] { "ConvenientStore.Controllers" }
            );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                                namespaces: new[] { "ConvenientStore.Controllers" }
            );
            //ConvenientStoreDBContext db = new ConvenientStoreDBContext();
            //var list = db.ProductCategories.ToList();
            //foreach(var item in list)
            //{
            //    routes.MapRoute(
            //        name: "Product Category",
            //        url: "{controller}/{action}/{id}",
            //        defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
            //                        namespaces: new[] { "ConvenientStore.Controllers" }
            //    );
            //}
        }
    }
}
