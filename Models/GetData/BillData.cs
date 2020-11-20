using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.EF;
using PagedList;
using Models.ViewModel;

namespace Models.GetData
{
    public class BillData
    {
        ConvenientStoreDBContext db = null;
        public BillData()
        {
            db = new ConvenientStoreDBContext();
        }
        public Bill GetByID(long ID)
        {
            return db.Bills.Find(ID);
        }

        public IEnumerable<Bill> ListAllBill(string searchString, int page, int pageSize)
        {
            return db.Bills.OrderBy(x => x.BillID).ToPagedList(page, pageSize);
        }
        public List<Bill> ListAll()
        {
            return db.Bills.ToList();
        }
        public List<OrderViewModel> ListBillByID(long userID, long id)
        {
            var model = (from a in db.Bills
                         join b in db.BillDetails
                         on a.BillID equals b.BillID
                         join c in db.Products on b.ProductID equals c.ProductID
                         where a.UserID == userID && a.BillID==id
                         select new OrderViewModel()
                         {
                             billID = a.BillID,
                             userID = userID,
                             productID = b.ProductID,
                             metaTitle = c.MetaTitle,
                             quantity = b.Quantity,
                             price = b.Price,
                             name = c.Name,
                             image = c.Image
                         }).OrderBy(x => x.billID);
            return model.ToList();
        }
        public List<BillViewModel> ExportExcel()
        {
            var model = (from a in db.Bills
                         join b in db.Users
                         on a.UserID equals b.UserID
                         select new BillViewModel()
                         {
                             billID = a.BillID,
                             userID = b.UserID,
                             name = b.Name,
                             createDate=a.CreateDate,
                             totalMoney = a.TotalMoney,
                             status = a.Status,
                             billStatus="",
                             address = a.Address,
                             creditCard = a.CreditCard,
                         }).OrderBy(x => x.billID);
            return model.ToList();
        }
        //Thay đổi tình trạng giao hàng
        public int ChangeStatus(long id)
        {
            try
            {
                var bill = db.Bills.Find(id);
                if (bill.Status == 0)
                {
                    bill.Status = 1;
                }
                else if (bill.Status == 1)
                {
                    bill.Status = 2;
                }
                else if (bill.Status == 2)
                {
                    bill.Status = 3;
                }
                else if (bill.Status == 3)
                {
                    bill.Status = 4;
                }
                else if (bill.Status == 4)
                {
                    bill.Status = 5;
                }
                //user.Status = !user.Status;
                db.SaveChanges();
                return bill.Status;
            }
            catch
            {
                return -1;
            }
        }
        //Thêm, xóa, sửa 
        public long insert(Bill entity)
        {
            try
            {
                db.Bills.Add(entity);
                db.SaveChanges();
                return entity.BillID;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }
        public bool update(Bill entity)
        {
            try
            {
                var bill = db.Bills.Find(entity.BillID);
                bill.UserID = entity.UserID;
                bill.CreateDate = entity.CreateDate;
                bill.TotalMoney = entity.TotalMoney;
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
                var bill = db.Bills.Find(ID);
                db.Bills.Remove(bill);
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        public decimal? GetRevenue(int month)
        {
            var model = db.Bills.Where(x => x.CreateDate.Value.Month == month).ToList();
            decimal? revenue = 0;
            foreach(var item in model)
            {
                revenue = revenue + item.TotalMoney;
            }
            return revenue;
        }
        public int? GetCustomer(int month)
        {
            var model = db.Bills.Where(x => x.CreateDate.Value.Month == month).ToList();
            var list = model.Select(x => x.UserID).Distinct();
            return list.Count();
        }
    }
}
