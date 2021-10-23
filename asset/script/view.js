function XMLHttpFetch(url) {
  var responseText;
  var request = window.XMLHttpRequest || ActiveXObject;
  var xhr = new request("MSXML2.XMLHTTP.3.0");

  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
      responseText = this.responseText;
    }
  };

  xhr.open("GET", url, false);
  xhr.send();

  return responseText;
}

// Get the '<head>' and '<body>' content for the page
var bodyHTML;
var headHTML;

if (fetch) {
  bodyHTML = await (await fetch("/asset/html/document.body.html")).text();
  headHTML = await (await fetch("/asset/html/document.head.html")).text();
} else {
  bodyHTML = XMLHttpFetch("/asset/html/document.body.html");
  headHTML = XMLHttpFetch("/asset/html/document.head.html");
}

// Ensure that '<meta name="viewport"...' is set
document.head.insertAdjacentHTML(
  "beforeend",
  '<meta name="viewport" content="width=device-width, initial-scale=1" />'
);

var firstChild;
var title = document.title;
var wrapper = document.createElement("wrapper");

// Store the template 'head' markup
wrapper.innerHTML = headHTML;

// Populate the current document's 'head' section
// with the template content
while ((firstChild = wrapper.firstChild)) {
  document.head.appendChild(firstChild);
}

// Store the template 'body' markup
wrapper.innerHTML = bodyHTML;

// Get the view content from the current document
var contentHTML = document.body.innerHTML;

var updateView = () => {
  // Set the document title
  document.title = title;

  // Reset the current document's 'body' section
  while ((firstChild = document.body.firstChild)) {
    document.body.removeChild(firstChild);
  }

  // Populate the current document's 'body' section
  // with the template content
  while ((firstChild = wrapper.firstChild)) {
    document.body.appendChild(firstChild);
  }

  // Store the view content
  wrapper.innerHTML = contentHTML;

  // Cache the '#view' element
  var viewElement = document.getElementById("view");

  // Populate the view content
  while ((firstChild = wrapper.firstChild)) {
    viewElement.appendChild(firstChild);
  }
};

// Load the view when the document is ready
if (
  document.readyState === "complete" ||
  document.readyState === "loaded" ||
  (!(window.ActiveXObject || "ActiveXObject" in window) &&
    document.readyState === "interactive")
) {
  updateView();
} else {
  document.addEventListener("DOMContentLoaded", updateView, 0);
}
