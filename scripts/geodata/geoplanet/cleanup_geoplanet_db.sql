-- Worldwide
    update places
    -- Aruba, Burundi, Nicaragua and Paraguay are listed as "Nationality"
    set place_type = "Country"
    where place_type = "Nationality";

-- United Kingdom

    -- City of London
    update places
    set place_type = "Town"
    where id = 12695806;

    -- Isle of Man
    update admins
    set country_code = "IM",
    country_id = 0
    where id = 23424847;

    update places
    set country_code = "IM",
    place_type = "Country"
    where id = 23424847;

    update admins
    set country_code = "IM",
    country_id = state_id, -- Isle of Man is a "state" in GeoPlanet
    state_id = county_id, -- States in Isle of Man are labeled counties
    county_id = 0
    where state_id = 23424847;

    update places
    set country_code = "IM",
    place_type = "State"
    where parent_id = 23424847;

    update postal_codes set country_code = "IM"
    where parent_id in (select id from places where country_code = "IM");

    -- Guernsey
    update admins
    set country_code = "GG",
    country_id = 0
    where id = 23424827;

    update admins
    set country_code = "GG",
    country_id = county_id, -- Guernsey is a "county" in GeoPlanet
    state_id = local_admin_id, -- States in Guernsey are labeled local_admins
    county_id = 0,
    local_admin_id = 0
    where county_id = 23424827;

    update places
    set country_code = "GG",
    place_type = "Country"
    where id = 23424827;

    update places
    set country_code = "GG",
    place_type = "State"
    where parent_id = 23424827;

    update postal_codes set country_code = "GG"
    where parent_id in (select id from places where country_code = "GG");

    -- Jersey
    update admins
    set country_code = "JE",
    country_id = 0
    where id = 23424857;

    update admins
    set country_code = "JE",
    country_id = county_id, -- Jersey is a "county" in GeoPlanet
    state_id = local_admin_id, -- States in Jersey are labeled local_admins
    county_id = 0,
    local_admin_id = 0
    where county_id = 23424857;

    update places
    set country_code = "JE",
    place_type = "Country"
    where id = 23424857;

    update places
    set country_code = "JE",
    place_type = "State"
    where parent_id = 23424857;

    update postal_codes set country_code = "JE"
    where parent_id in (select id from places where country_code = "JE");

    -- shire districts with City in the name are cities
    update places
    set place_type = "Town"
    where country_code = "GB"
    and place_type = "LocalAdmin"
    and name like  "%City%"
    -- except for City of Westminster in London
    and parent_id != 44418;

    -- shire districts 
    update places
    set place_type = "County"
    where country_code = "GB"
    and place_type = "LocalAdmin"
    -- except for boroughs of London
    and parent_id != 44418;

-- Canada

    -- Alberta
    -- listead as both county and state
    update places
    set parent_id = 2344915
    where parent_id = 29375228;

    update admins
    set county_id = 0
    where state_id = 2344915;

    -- Manitoba
    -- listead as both county and state
    update places
    set parent_id = 2344917
    where parent_id = 29375231;

    update admins
    set county_id = 0
    where state_id = 2344917;

    -- Newfoundland and Labrador
    -- listead as both county and state
    update places
    set parent_id = 2344919
    where parent_id = 29375216;

    update admins
    set county_id = 0
    where state_id = 2344919;

    -- Northwest Territories
    -- listed as both county and state
    update places
    set parent_id = 2344920
    where parent_id = 29375229;

    update admins
    set county_id = 0
    where state_id = 2344920;

    -- Saskatchewan
    -- listed as both county and state
    update places
    set parent_id = 2344925
    where parent_id = 29375232;

    update admins
    set county_id = 0
    where state_id = 2344925;

    -- Yukon Territory
    -- listed as both county and state
    update places
    set parent_id = 2344926
    where parent_id = 29375157;

    update admins
    set county_id = 0
    where state_id = 2344926;

    -- Nunavut
    -- listed as both county and state
    update places
    set parent_id = 20069920
    where parent_id = 29375230;

    update admins
    set county_id = 0
    where state_id = 20069920;

-- Portugal
    -- "County" in GeoPlanet is admin_level=7 (municipio) in OSM, switch to Town
    update places
    set place_type = "Town"
    where country_code = "PT"
    and place_type = "County";

    -- there are now Towns parented by Towns, so make their parent_id point to their parent's parent
    -- Note: SQLite can only do correlated subqueries, no joined updates, hence the clunky syntax
    update places
    set parent_id = (select p_sub.parent_id from places p_sub where p_sub.id = places.parent_id)
    where id in (select p1.id from places p1 join places p2 on p1.parent_id = p2.id 
                 where p1.country_code = "PT" and p1.place_type = "Town" and p2.place_type = "Town");

    -- "State" in GeoPlanet is admin_level=6 in OSM, switch to County
    -- except for Azores and Madeira
    update places
    set place_type = "County"
    where country_code = "PT"
    and place_type = "State"
    and id not in (15021776, 2346570);

    update admins
    set county_id = state_id
    where country_code = "PT"
    and state_id not in (15021776, 2346570);

    update admins
    set county_id = 0
    where country_code = "PT"
    and state_id in (15021776, 2346570);

    update admins
    set state_id = 0
    where country_code = "PT"
    and state_id not in (15021776, 2346570);

-- Japan
    update places
    set place_type = "LocalAdmin"
    where country_code = "JP"
    and name like "%区";

    update places
    set place_type = "Suburb"
    where country_code = "JP"
    and name like "%丁目";

-- United States
    -- DC
    -- listed as both county and state
    update places
    set parent_id = 2347567
    where parent_id = 12587802;

    update admins
    set county_id = 0
    where state_id = 2347567;

    -- Boroughs of NYC
    -- listed as counties, make them LocalAdmin
    update places
    set place_type = "LocalAdmin"
    where id in (
        12589314, -- Bronx
        12589335, -- Brooklyn
        12589342, -- Manhattan
        12589352, -- Queens
        12589354 -- Staten Island
    );

    update admins
    set local_admin_id = county_id,
    county_id = 0
    where county_id in (
        12589314, -- Bronx
        12589335, -- Brooklyn
        12589342, -- Manhattan
        12589352, -- Queens
        12589354 -- Staten Island
    );

-- Germany

    -- "LocalAdmin" level are usually Gemeindes (municipalities) when they are parented by counties
    -- and city districts when parented by towns
    update places
    set place_type = "Town"
    where country_code = "DE"
    and place_type = "LocalAdmin"
    and parent_id in (select id from places where country_code = "DE" and place_type = "County");


-- India - OK

-- France
    -- "LocalAdmin" level are cities except for the Arondissements
    -- of Paris, Marseille, and Lyon
    update places
    set place_type = "Town"
    where country_code = "FR"
    and place_type = "LocalAdmin"
    and parent_id not in (
        615702, -- Paris
        610264, -- Marseille
        609125 -- Lyon
    );

-- Poland
    -- "LocalAdmin" level is either gmina (municipality) or city in OSM.
    -- Since the "gmina" prefix is not used, we'll say city
    update places
    set place_type = "Town"
    where country_code = "PL"
    and place_type = "LocalAdmin";

-- Sweden
    -- "County" level is admin_level=7 in OSM (kommun) which are municipalities
    update places
    set place_type = "Town"
    where country_code = "SE"
    and place_type = "County";

    -- fix Towns parented by Towns
    update places
    set parent_id = (select p_sub.parent_id from places p_sub where p_sub.id = places.parent_id)
    where id in (select p1.id from places p1 join places p2 on p1.parent_id = p2.id 
                 where p1.country_code = "SE" and p1.place_type = "Town" and p2.place_type = "Town");

    update admins
    set county_id = 0
    where country_code = "SE";

-- Brasil
    -- Many admin levels in Brasil, but in GeoPlanet "County" simply repeats the city name
    update places
    set place_type = "Town"
    where country_code = "BR"
    and place_type = "County";

    -- fix Towns parented by Towns
    update places
    set parent_id = (select p_sub.parent_id from places p_sub where p_sub.id = places.parent_id)
    where id in (select p1.id from places p1 join places p2 on p1.parent_id = p2.id 
                 where p1.country_code = "BR" and p1.place_type = "Town" and p2.place_type = "Town");

    update admins
    set county_id = 0
    where country_code = "BR";

-- Romania - OK

-- Spain
    update places
    set place_type = "Town"
    where country_code = "ES"
    and place_type = "LocalAdmin";

-- Taiwan
    update places
    set place_type = "Town"
    where country_code = "TW"
    and place_type = "State"
    and name like "%市";

    -- Places with place_type=Town ending in 鎮 should be city_district
    update places
    set place_type = "LocalAdmin"
    where country_code = "TW"
    and place_type = "Town"
    and name like "%鎮"
    and parent_id in (select id from places where country_code = "TW" and place_type = "Town");


    -- update cities within top-level cities to be city_district (ending with 區/qu, not 市/shi)
    update places
    set place_type = "LocalAdmin",
    name = printf("%s區", substr(name, 1, length(name) - 1))
    where country_code = "TW"
    and place_type = "Town"
    and name like "%市"
    -- top-level cities in Taiwan
    and parent_id in (select id from places where parent_id = 23424971 and name like "%市");


    -- Places ending with qu (區) should be city_district
    update places
    set place_type = "LocalAdmin"
    where country_code = "TW"
    and place_type = "County"
    and name like "%區";

    -- Places ending with xiàn (縣) should be state_district
    update places
    set place_type = "County"
    where country_code = "TW"
    and place_type = "State"
    and name like "%縣";

    -- Places ending with xiāng (鄉) should be city
    update places
    set place_type = "Town"
    where country_code = "TW"
    and place_type = "County"
    and name like "%鄉";

    -- Places ending with lǐ (里) should be suburb
    update places
    set place_type = "Suburb"
    where country_code = "TW"
    and place_type = "County"
    and name like "%里";

-- Italy
    update places
    set place_type = "Town"
    where country_code = "IT"
    and place_type = "LocalAdmin";

-- Netherlands
    -- boroughs of Amsterdam should be city_district
    update places
    set place_type = "LocalAdmin"
    where id in (
        734698, -- Westpoort
        727281 -- Amsterdam Zuidoost
    );

    -- municipalities (cities) in OSM
    update places
    set place_type = "Town"
    where country_code = "NL"
    and place_type = "County";

-- Norway
    -- suburbs of Oslo
    update places
    set place_type = "LocalAdmin"
    where country_code = "NO"
    and place_type = "County"
    and parent_id = 862592;

    -- the rest are municipalities (cities) in OSM
    update places
    set place_type = "Town"
    where country_code = "NO"
    and place_type = "County"
    and parent_id in (select id from places where country_code = "NO" and place_type = "State");

-- Turkey
    -- Istanbul (city)
    update places
    set parent_id = 2347289
    where id = 2344116;

    update admins
    set county_id = 0
    where id = 2344116;

    -- districts of Istanbul
    update places
    set parent_id = 2344116, -- Istanbul (city)
    place_type = "LocalAdmin"
    where parent_id = 2347289 -- Istanbul (province)
    and place_type = "County";

-- Bulgaria
    -- municipalities (cities) in OSM
    update places
    set place_type = "Town"
    where country_code = "BG"
    and place_type = "County";

    update admins
    set county_id = 0
    where country_code = "BG";

-- Argentina - OK

-- Indonesia
    
    -- Set sub-municipalities of Jakaarta (e.g. Jakarta Barat) to city
    update places
    set place_type = "Town"
    where parent_id = 1047378 -- Jakarta (city)
    and place_type = "County";

-- Luxembourg

    -- Set suburbs of Luxembourg (city) to city_district
    update places
    set place_type = "LocalAdmin"
    where parent_id = 979721  -- Luxembourg City
    and place_type = "Suburb";

-- Switzerland
    -- using postal codes for Zürich the city
    update postal_codes
    set parent_id = 784794 -- Zürich (city)
    where parent_id = 12593130; -- Zürich (county)

-- Australia - OK

-- Finland
    -- "LocalAdmin" level is city in OSM.
    update places
    set place_type = "Town"
    where country_code = "FI"
    and place_type = "LocalAdmin";

-- Czech Republic
    -- Use the prefix okres for Czech counties
    update places
    set name = printf("okres %s", name)
    where country_code = "CZ"
    and place_type = "County";

    -- LocalAdmins used here don't appear to have a corresponding type in OSM
    update places
    set parent_id = (select p_sub.parent_id from places p_sub where p_sub.id = places.parent_id)
    where id in (
        select p1.id
        from places p1
        join places p2
            on p1.parent_id = p2.id
        where p1.country_code = "CZ"
        and p1.place_type = "Town"
        and p2.place_type = "LocalAdmin"
    );

    update places
    set place_type = "Town"
    where country_code = "CZ"
    and place_type = "LocalAdmin";

-- Hungary
    -- Set Budapest's parent_id to the state
    update places
    set parent_id = 12577915
    where id = 804365;

    -- Set districts of Budapest to city_district, parented by Budapest the city
    update places
    set parent_id = 804365,
    place_type = "LocalAdmin"
    where parent_id = 12577915
    and place_type = "County";

    -- These are suburbs in OSM
    update places
    set place_type = "Suburb"
    where parent_id = 12593336 -- Bátonyterenye
    and place_type = "Town";

    -- Set all other counties to town
    update places
    set place_type = "Town"
    where country_code = "HU"
    and place_type = "County";

-- Algeria - OK

-- South Africa
    -- these are municipalities/cities
    update places
    set place_type = "Town"
    where country_code = "ZA"
    and place_type = "LocalAdmin";

-- Malaysia
    -- LocalAdmins used here don't appear to have a type in OSM
    update places
    set parent_id = (select p_sub.parent_id from places p_sub where p_sub.id = places.parent_id)
    where id in (
        select p1.id
        from places p1
        join places p2
            on p1.parent_id = p2.id
        where p1.country_code = "MY"
        and p1.place_type = "Town"
        and p2.place_type = "LocalAdmin"
    );

    update places
    set place_type = "Town"
    where id = 1140856; -- Bayan Lepas

    update places
    set parent_id = 1141153, -- George Town
    place_type = "Suburb"
    where parent_id = 56013581
    and id != 1141153 -- except George Town itself
    and place_type = "Town";

    update postal_codes
    set parent_id = 1149014 -- Kampong Sungai Gelugor
    where parent_id = 1149059; -- Kampong Sungai Keluang

    update postal_codes
    set parent_id = 1155026 -- Petaling Jaya
    where parent_id = 56013632; -- Petaling (county)

    update postal_codes
    set parent_id = (
        select p2.id
        from places p1
        join places p2
            on p1.id = p2.parent_id
        where p1.id = postal_codes.parent_id
        and p1.place_type = "County"
        and p2.place_type = "Town"
        and p1.name = p2.name
        limit 1
    )
    where parent_id in (
        select distinct p1.id
        from places p1
        join places p2
            on p1.id = p2.parent_id
        where p1.country_code = "MY"
        and p1.place_type = "County"
        and p2.place_type = "Town"
        and p1.name = p2.name
    );

-- Austria
    -- Set Vienna's parent to the state
    update places
    set parent_id = 2344716
    where id = 551801;

    -- Use the prefix Bezirk for Austrian counties
    update places
    set name = printf("Bezirk %s", name)
    where country_code = "AT"
    and place_type = "County";


    -- Postal codes assigned to a LocalAdmin with a coterminous city should use the city
    update postal_codes
    set parent_id = (
        select p2.id
        from places p1
        join places p2
            on p1.id = p2.parent_id
        where p1.id = postal_codes.parent_id
        and p1.place_type = "LocalAdmin"
        and p2.place_type = "Town"
        and p1.name = p2.name
        limit 1
    )
    where parent_id in (
        select distinct p1.id
        from places p1
        join places p2
            on p1.id = p2.parent_id
        where p1.country_code = "AT"
        and p1.place_type = "LocalAdmin"
        and p2.place_type = "Town"
        and p1.name = p2.name
    );

    -- Towns parented by a LocalAdmin should be parented by the grandparent County
    update places
    set parent_id = (select p_sub.parent_id from places p_sub where p_sub.id = places.parent_id)
    where id in (
        select p1.id
        from places p1
        join places p2
            on p1.parent_id = p2.id
        where p1.country_code = "AT"
        and p1.place_type = "Town"
        and p2.place_type = "LocalAdmin"
    );

    -- Convert all other LocalAdmins to cities
    update places
    set place_type = "Town"
    where country_code = "AT"
    and place_type = "LocalAdmin";

    -- Except the few districts/boroughs of Vienna listed in GeoPlanet
    update places
    set place_type = "LocalAdmin"
    where id in (542098, 551778);

-- China
    -- special cities that have state status
    update places
    set name = replace(name, "直辖市", "市"),
    place_type = "Town"
    where id in (
        12578011, -- Beijing
        12578012, -- Shanghai
        12578017, -- Tianjin
        20070171  -- Chongqing
    );

    -- City districts should be directly parented by their city
    update places
    set parent_id = (select p_sub.parent_id from places p_sub where p_sub.id = places.parent_id)
    where id in (
        select p1.id
        from places p1
        join places p2
            on p1.parent_id = p2.id
        where p1.country_code = "CN"
        and p1.place_type = "LocalAdmin"
        and p2.place_type = "County"
        and p2.parent_id in (
            12578011, -- Beijing
            12578012, -- Shanghai
            12578017, -- Tianjin
            20070171  -- Chongqing
        )
    );

    -- City districts should be directly parented by their city
    update places
    set parent_id = (select grandparent.parent_id from places parent join places grandparent on parent.parent_id = grandparent.id where parent.id = places.parent_id)
    where id in (
        select p1.id
        from places p1
        join places p2
            on p1.parent_id = p2.id
        join places p3
            on p2.parent_id = p3.id
        where p1.country_code = "CN"
        and p1.place_type = "LocalAdmin"
        and p3.parent_id in (
            12578011, -- Beijing
            12578012, -- Shanghai
            12578017, -- Tianjin
            20070171  -- Chongqing
        )
    );

    -- GeoPlanet has 4 digit postcodes. They're correct but Chine uses 6 digits and pads with zeros
    update postal_codes
    set name = printf("%s00", name)
    where country_code = "CN"
    and length(name) = 4;

    -- LocalAdmin ending with shi (市) should be city
    update places
    set place_type = "Town"
    where country_code = "CN" 
    and name like "%市"
    and place_type in ("County", "LocalAdmin");

    -- Prefecture-level cities are labeled counties
    update places
    set place_type = "Town"
    where country_code = "CN"
    and place_type = "County"
    and replace(name, " ", "") not like "%自治州";


    -- Counties are labeled LocalAdmin
    update places
    set place_type = "County"
    where country_code = "CN" 
    and place_type = "LocalAdmin"
    and name like "%县";


-- New Zealand
    -- Hokianga Harbour is listed as a bay in OSM and these "suburbs" are villages around the bay
    update places
    set place_type = "Town"
    where place_type = "Suburb"
    and parent_id = 28645523;

    -- Silverdale listed as town in OSM
    update places
    set place_type = "Town"
    where id = 2350555;

    -- Wellington is both a city and a region
    update places
    set name = "Wellington Region"
    where id = 15021762;

-- Philippines
    -- States in GeoPlanet are admin_level=3 (country_region) in libpostal
    update places
    set place_type = "CountryRegion"
    where country_code = "PH"
    and place_type = "State";

    -- Counties in GeoPlanet are admin_level=4 (state) in libpostal
    update places
    set place_type = "State"
    where country_code = "PH"
    and place_type = "County";

-- Pakistan - OK

-- Lebanon - OK

-- Lithuania
    -- LocalAdmins are admin_level=6 (state_district)
    update places
    set place_type = "County"
    where country_code = "LT"
    and place_type = "LocalAdmin";

    -- Suburbs are admin_level=10 (city_district)
    update places
    set place_type = "LocalAdmin"
    where country_code = "LT"
    and place_type = "Suburb";
