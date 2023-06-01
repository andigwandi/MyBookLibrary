using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace Common
{
    internal class Helper
    {
        public string FindValueByKey(string json, string key)
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
