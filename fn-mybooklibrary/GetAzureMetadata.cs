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
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;

namespace fn_mybooklibrary
{
    public static class GetAzureMetadata
    {

        [FunctionName("GetMetadata")]
        public static HttpResponseData Run([HttpTrigger(AuthorizationLevel.Function, "get")] HttpRequestData req,
                                           FunctionContext executionContext)
        {
            //var logger = executionContext.GetLogger("MetadataFunction");
            //logger.LogInformation("C# HTTP trigger function processed a request.");

            //// Get the Azure AD access token using managed identity or other authentication mechanism
            //var accessToken = new AzureServiceTokenProvider().GetAccessTokenAsync("https://managedmetadata.azure.net").Result;

            //// Create the metadata client using the access token
            //var credentials = new TokenCredentials(accessToken);
            //var metadataClient = new MetadataClient(credentials);

            //// Retrieve metadata from Azure Managed Metadata Service
            //var metadata = metadataClient.Metadata.Get();

            // Process the metadata and return the response
            var response = req.CreateResponse();
            response.Headers.Add("Content-Type", "application/json");
            response.WriteString("something");

            return response;
        }
    }
}
