using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System.Threading;
using Microsoft.Rest;
using Microsoft.Azure.Management.Metadata;
using Microsoft.Azure.Services.AppAuthentication;

namespace fn_mybooklibrary
{
    public static class GetAzureMetadata
    {
        [FunctionName("GetAzureMetadata")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = null)] HttpRequest req,
            ILogger log)
        {
            var logger = executionContext.GetLogger("MetadataFunction");
            log.LogInformation("C# HTTP trigger function processed a request.");

            string name = req.Query["name"];

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            dynamic data = JsonConvert.DeserializeObject(requestBody);
            name = name ?? data?.name;

            string responseMessage = string.IsNullOrEmpty(name)
                ? "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."
                : $"Hello, {name}. This HTTP triggered function executed successfully.";

            return new OkObjectResult(responseMessage);
        }

        [FunctionName("GetMetadata")]
        public static HttpResponseData Run([HttpTrigger(AuthorizationLevel.Function, "get")] HttpRequestData req,
                                           FunctionContext executionContext)
        {
            var logger = executionContext.GetLogger("MetadataFunction");
            logger.LogInformation("C# HTTP trigger function processed a request.");

            // Get the Azure AD access token using managed identity or other authentication mechanism
            var accessToken = new AzureServiceTokenProvider().GetAccessTokenAsync("https://managedmetadata.azure.net").Result;

            // Create the metadata client using the access token
            var credentials = new TokenCredentials(accessToken);
            var metadataClient = new MetadataClient(credentials);

            // Retrieve metadata from Azure Managed Metadata Service
            var metadata = metadataClient.Metadata.Get();

            // Process the metadata and return the response
            var response = req.CreateResponse();
            response.Headers.Add("Content-Type", "application/json");
            response.WriteString(metadata.ToString());

            return response;
        }
    }
}
