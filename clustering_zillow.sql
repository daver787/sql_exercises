USE zillow;
SELECT Z.basementsqft,
Z.bathroomcnt,
Z.bedroomcnt,
Z.calculatedbathnbr,
Z.finishedfloor1squarefeet,
Z.calculatedfinishedsquarefeet,
Z.finishedsquarefeet12,
Z.finishedsquarefeet13,
Z.finishedsquarefeet15,
Z.finishedsquarefeet50,
Z.finishedsquarefeet6,
Z.fips,
Z.fireplacecnt,
Z.fullbathcnt,
Z.garagecarcnt,
Z.garagetotalsqft,
Z.hashottuborspa,
Z.latitude,
Z.longitude,
Z.lotsizesquarefeet,
Z.poolcnt,
Z.poolsizesum,
Z.propertycountylandusecode,
Z.propertyzoningdesc,
Z.regionidcity,
Z.regionidcounty,
Z.regionidneighborhood,
Z.regionidzip,
Z.roomcnt,
Z.threequarterbathnbr,
Z.unitcnt,
Z.yardbuildingsqft17,
Z.yardbuildingsqft26,
Z.yearbuilt,
Z.numberofstories,
Z.fireplaceflag,
Z.structuretaxvaluedollarcnt,
Z.taxvaluedollarcnt,
Z.assessmentyear,
Z.landtaxvaluedollarcnt,
Z.taxamount,
Z.taxdelinquencyflag,
Z.taxdelinquencyyear,
Z.censustractandblock,
Z.logerror,
Z.transactiondate,
Z.year,
plt.propertylandusedesc,
st.storydesc,
ct.typeconstructiondesc,
act.airconditioningdesc,
bct.buildingclassdesc,
hst.heatingorsystemdesc
 FROM (
(SELECT properties_2016.*,
pred16.logerror,
pred16.transactiondate,
'2016' AS year
FROM properties_2016
JOIN predictions_2016 AS pred16 ON (properties_2016.parcelid=pred16.parcelid)
WHERE properties_2016.latitude IS NOT NULL AND properties_2016.longitude IS NOT NULL AND pred16.transactiondate IS NOT NULL
LIMIT 1000
)
UNION
(SELECT properties_2017.*,
pred17.logerror,
pred17.transactiondate,
'2017' AS year
 FROM properties_2017
JOIN predictions_2017 AS pred17 ON (properties_2017.parcelid=pred17.parcelid)
WHERE properties_2017.latitude IS NOT NULL AND properties_2017.longitude IS NOT NULL AND pred17.transactiondate IS NOT NULL
LIMIT 1000
) )AS Z
LEFT JOIN propertylandusetype AS plt ON (Z.propertylandusetypeid=plt.propertylandusetypeid)
LEFT JOIN storytype AS st ON (Z.storytypeid=st.storytypeid)
LEFT JOIN typeconstructiontype AS ct ON (Z.typeconstructiontypeid=ct.typeconstructiontypeid)
LEFT JOIN airconditioningtype AS act ON (Z.airconditioningtypeid=act.airconditioningtypeid)
LEFT JOIN architecturalstyletype AS ast ON (Z.architecturalstyletypeid=ast.architecturalstyletypeid)
LEFT JOIN buildingclasstype AS bct ON (Z.buildingclasstypeid=bct.buildingclasstypeid)
LEFT JOIN heatingorsystemtype AS hst ON (Z.heatingorsystemtypeid=hst.heatingorsystemtypeid)