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
   public class BillDetailData
    {
        ConvenientStoreDBContext db = null;
        public BillDetailData()
        {
            db = new ConvenientStoreDBContext();
        }
        public BillDetail GetByID(long ID)
        {
            return db.BillDetails.SingleOrDefault(x => x.ID == ID);
        }

        public IEnumerable<BillDetail> ListAllBillDetails(string searchString, int page, int pageSize)
        {
            if(searchString!=null)
            {
                long id = long.Parse(searchString);
                IQueryable<BillDetail> model = db.BillDetails.OrderBy(x => x.ID);
                if (!string.IsNullOrEmpty(searchString))
                {
                    model = model.Where(x => x.BillID == id);
                }
                return model.OrderBy(x => x.ID).ToPagedList(page, pageSize);
            }
            return db.BillDetails.OrderBy(x => x.ID).ToPagedList(page, pageSize);
        }
        //Thêm, xóa, sửa 
        public long insert(BillDetail entity)
        {
            try
            {
                db.BillDetails.Add(entity);
                db.SaveChanges();
                return entity.BillID;
            }
            catch
            {
                return -1;
            }
        }
        public List<ProductViewModel> ProductID()
        {
            List<int> countList = new List<int>();
            List<long?> productID = new List<long?>();
            var model  = db.BillDetails.ToList();
            var groups = model.GroupBy(x => x.ProductID).Select(x => new ProductViewModel {
                productID = x.Key, quantity = x.Sum(n=>n.Quantity) }).OrderByDescending(x => x.quantity).Take(5).ToList();
            return groups;
        }
        public int? GetProductPerMonth(ProductViewModel product, int month)
        {
            int? count = 0;
            var billList = db.Bills.Where(x => x.CreateDate.Value.Month == month).ToList();
            var model = db.BillDetails.ToList();
            foreach(var bill in billList)
            {
                foreach(var item in model)
                {
                    if (bill.BillID == item.BillID && item.ProductID == product.productID)
                    {
                        count = count + item.Quantity;
                    }
                }
            }
            return count;
        }
        //View Details
        public BillDetail ViewDetail(long id)
        {
            return db.BillDetails.SingleOrDefault(x => x.ID == id);
        }
        public bool update(BillDetail entity)
        {
            try
            {
                var billdetail = db.BillDetails.SingleOrDefault(x => x.ID == entity.ID);
                billdetail.BillID = entity.BillID;
                billdetail.ProductID = entity.ProductID;
                billdetail.Quantity = entity.Quantity;
                billdetail.Price = entity.Price;
                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
        public bool Delete(long ID)
        {
            try
            {
                var billdetail = db.BillDetails.SingleOrDefault(x => x.ID == ID);
                db.BillDetails.Remove(billdetail);
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
