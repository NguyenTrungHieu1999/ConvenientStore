using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.EF;
using Models.ViewModel;
using PagedList;

namespace Models.GetData
{
    public class OrderData
    {
        ConvenientStoreDBContext db = null;
        public OrderData()
        {
            db = new ConvenientStoreDBContext();
        }
        public List<OrderViewModel> GetOrderList(long userID)
        {
            var model = (from a in db.Bills
                         join b in db.BillDetails
                         on a.BillID equals b.BillID
                         join c in db.Products on b.ProductID equals c.ProductID
                         where a.UserID == userID
                         select new OrderViewModel()
                         {
                             billID = a.BillID,
                             userID = userID,
                             productID = b.ProductID,
                             metaTitle=c.MetaTitle,
                             quantity = b.Quantity,
                             price = b.Price,
                             name = c.Name,
                             image = c.Image
                         }).OrderBy(x => x.billID);
            return model.OrderByDescending(x=>x.billID).ToList();
        }
    }
}
