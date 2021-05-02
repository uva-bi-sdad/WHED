using WebDriver
using WebDriver: HTTP.request, HTTP.URI, base64decode
using Cascadia: parsehtml, Selector, attrs, getattr, nodeText
capabilities = Capabilities("chrome")
wd = RemoteWebDriver(capabilities)
status(wd)
session = Session(wd)
navigate!(session, "https://whed.net/choisir.php?country=Afghanistan")
elem = Element(session, "css selector", "body > form > label:nth-child(10) > input")
click!(elem)
elem = Element(session, "css selector", "body > form > p > input:nth-child(2)")
click!(elem)


ss = write(joinpath(@__DIR__, "img.png"), base64decode(screenshot(session)))

navigate!(session, "https://whed.net/results_institutions.php?chx=results_institutions.php&nbr_ref_pge=2117&sort=InstNameEnglish&afftri=yes&Chp1=United%20States%20of%20America")
webpage = parsehtml(source(session));
results = eachmatch(Selector("#results > li > .details > h3 > a"), webpage.root);
ids = getproperty.(match.(r"(?<=\?).*", getattr.(results, "href")), :match)

response = request("GET", URI(scheme = "https", host = "whed.net", path = "/detail_institution.php", query = ids[1]))
html = parsehtml(String(response.body))
country = nodeText(eachmatch(Selector(".country"), html.root)[1])
id = nodeText(eachmatch(Selector("#contenu > p.tools.fleft > span"), html.root)[1])
address = eachmatch(Selector("#contenu > div:nth-child(7)"), html.root)[1][2]
nodeText(address[7])
address[2]







body > form > label:nth-child(10) > input
body > form > label:nth-child(10) > input

wd = WebDriver


homepage = request("GET",
                   URI(scheme = "https",
                       host = "whed.net",
                       path = "/home.php"))
html = parsehtml(String(homepage.body))
countries = eachmatch(Selector("#pays > option"), html.root)
gencountries = eachmatch(Selector("#pays > optgroup"), html.root)
opts = getattr.(countries[2:end], "value")
filter!(x -> !occursin(" - ", x), opts)
grp_opts = getattr.(getindex.(gencountries, 1), "value")
all_countries = sort!(union!(opts, grp_opts))
filter(x -> occursin("United States", x), all_countries)

url = URI(scheme = "https",
          host = "whed.net",
          path = "/results_institutions.php",
          query = Dict("Chp1" => "United States of America",
                       "afftri" => "yes",
                       "chx" => "results_institutions.php",
                       "nbr_ref_pge" => 2117,
                       "sort" => "InstNameEnglish"))
url = URI(scheme = "https",
          host = "whed.net",
          path = "/results_institutions.php",
          query = Dict("Chp1" => "Venezuela"))
ven = request("GET", "https://whed.net/results_institutions.php?chx=results_institutions.php&afftri=yes&Chp1=Venezuela%20%28Bolivarian%20Republic%20of%29")
chk = URI("https://whed.net/results_institutions.php?chx=results_institutions.php&nbr_ref_pge=2117&sort=InstNameEnglish&afftri=yes&Chp1=United%20States%20of%20America")
url == chk
WebDriver.HTTP.URIs.ensurevalid(URI(scheme = "ftpfsff", host = "me.con"))
