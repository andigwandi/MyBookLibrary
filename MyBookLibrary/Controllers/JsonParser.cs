using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace MyBookLibrary.Controllers
{
    public class JsonParser : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public IActionResult FindValue(string json, string key)
        {
            // Parse the JSON data and find the value based on the key
            string value = FindValueByKey(json, key);

            // Return the value as a JSON response
            return View(value);
        }

        private string FindValueByKey(string json, string key)
        {
            // Implement your logic here to find the value based on the key in the JSON data
            // For example, you can use Newtonsoft.Json library to parse the JSON and retrieve the value

            // Sample implementation
            Newtonsoft.Json.Linq.JObject? data = Newtonsoft.Json.JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JObject>(json);

            if (data.TryGetValue(key, out var value))
            {
                return value.ToString();
            }

            return "Key not found";
        }
    }
}
