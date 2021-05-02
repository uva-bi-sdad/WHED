using WebDriver
using WebDriver: HTTP.request, HTTP.URI, base64decode
using Cascadia: parsehtml, Selector, attrs, getattr, nodeText
capabilities = Capabilities("chrome")
wd = RemoteWebDriver(capabilities)
status(wd)
session = Session(wd)
navigate!(session, "https://app.smartsheet.com/b/form/d4ff720727c74ed0bfa80bf5541babee")
ss = write(joinpath(@__DIR__, "img.png"), base64decode(screenshot(session)))


using LibPQ: Connection, execute, prepare, Interval, load!, prepare
using Dates
conn = Connection("dbname = postgres")
execute(conn, "CREATE TEMPORARY TABLE libpqjl_test (x tsrange);")
x = Interval(floor(now() - Second(3), Second),
             floor(now(), Second),
             false,
             true)
stmt = prepare(conn, "INSERT INTO libpqjl_test VALUES(\$1);")
execute(stmt, (x,))
load!([(x = x,)], conn, "INSERT INTO test VALUES(\$1);")
