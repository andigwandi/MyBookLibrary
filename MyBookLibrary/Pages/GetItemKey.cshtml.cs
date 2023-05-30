using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace MyBookLibrary.Pages
{
    public class JsonParser : PageModel
    {
        [BindProperty]
        public string JsonData { get; set; }

        [BindProperty]
        public string Key { get; set; }

        public string Value { get; set; }
        public void OnPost()
        {
            // Parse the JSON data and find the value based on the key
            Value = FindValueByKey(JsonData, Key);
        }

        private string FindValueByKey(string json, string key)
        {
            // Implement your logic here to find the value based on the key in the JSON data
            // For example, you can use Newtonsoft.Json library to parse the JSON and retrieve the value

            // Sample implementation
            var data = Newtonsoft.Json.JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JObject>(json);

            if (data.TryGetValue(key, out var value))
            {
                return value.ToString();
            }

            return "Key not found";
        }
    }
}
