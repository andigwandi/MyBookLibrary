using MBL.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace MBL.Controllers
{
    public class FindKeyController : Controller
    {
        // GET: FindKeyController
        public ActionResult Index()
        {
            return View();
        }

        // GET: FindKeyController/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: FindKeyController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: FindKeyController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(FindKeyModel findKeyModel)
        {
            try
            {
               var key = findKeyModel.Key;
                var data = findKeyModel.Data;
                ViewBag.returnVal = FindValueByKey(data, key);

                return View(nameof(Index));
            }
            catch
            {
                return View(nameof(Index));
            }
        }


        // GET: FindKeyController/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: FindKeyController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: FindKeyController/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: FindKeyController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }


        private dynamic FindValueByKey(string json, string key)
        {
            Newtonsoft.Json.Linq.JObject? data = Newtonsoft.Json.JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JObject>(json);

            if (data.TryGetValue(key, out var value))
            {
                return value.ToString();
            }

            return "Key not found";
        }
    }


}
