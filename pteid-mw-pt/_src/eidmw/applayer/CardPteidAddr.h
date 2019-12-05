/*-****************************************************************************

 * Copyright (C) 2017 Luiz Lemos - <luiz.lemos@caixamagica.pt>
 *
 * Licensed under the EUPL V.1.1

****************************************************************************-*/

#ifndef CARDPTEIDADDR_H_INCLUDED
#define CARDPTEIDADDR_H_INCLUDED

// common address defines - ok
#define PTEIDNG_FIELD_ADDRESS_POS_TYPE                          0
#define PTEIDNG_FIELD_ADDRESS_LEN_TYPE                          2
#define PTEIDNG_FIELD_ADDRESS_POS_COUNTRY                       2
#define PTEIDNG_FIELD_ADDRESS_LEN_COUNTRY                       4

// specific portuguese address details - ok
#define PTEIDNG_FIELD_ADDRESS_POS_DISTRICT                      6
#define PTEIDNG_FIELD_ADDRESS_LEN_DISTRICT                      4
#define PTEIDNG_FIELD_ADDRESS_POS_DISTRICT_DESCRIPTION          10
#define PTEIDNG_FIELD_ADDRESS_LEN_DISTRICT_DESCRIPTION          100
#define PTEIDNG_FIELD_ADDRESS_POS_MUNICIPALITY                  110
#define PTEIDNG_FIELD_ADDRESS_LEN_MUNICIPALITY                  8
#define PTEIDNG_FIELD_ADDRESS_POS_MUNICIPALITY_DESCRIPTION      118
#define PTEIDNG_FIELD_ADDRESS_LEN_MUNICIPALITY_DESCRIPTION      100
#define PTEIDNG_FIELD_ADDRESS_POS_CIVILPARISH                   218
#define PTEIDNG_FIELD_ADDRESS_LEN_CIVILPARISH                   12
#define PTEIDNG_FIELD_ADDRESS_POS_CIVILPARISH_DESCRIPTION       230
#define PTEIDNG_FIELD_ADDRESS_LEN_CIVILPARISH_DESCRIPTION       100
#define PTEIDNG_FIELD_ADDRESS_POS_ABBR_STREET_TYPE              330
#define PTEIDNG_FIELD_ADDRESS_LEN_ABBR_STREET_TYPE              20
#define PTEIDNG_FIELD_ADDRESS_POS_STREET_TYPE                   350
#define PTEIDNG_FIELD_ADDRESS_LEN_STREET_TYPE                   100
#define PTEIDNG_FIELD_ADDRESS_POS_STREETNAME                    450
#define PTEIDNG_FIELD_ADDRESS_LEN_STREETNAME                    200
#define PTEIDNG_FIELD_ADDRESS_POS_ABBR_BUILDING_TYPE            650
#define PTEIDNG_FIELD_ADDRESS_LEN_ABBR_BUILDING_TYPE            20
#define PTEIDNG_FIELD_ADDRESS_POS_BUILDING_TYPE                 670
#define PTEIDNG_FIELD_ADDRESS_LEN_BUILDING_TYPE                 100
#define PTEIDNG_FIELD_ADDRESS_POS_DOORNO                        770
#define PTEIDNG_FIELD_ADDRESS_LEN_DOORNO                        20
#define PTEIDNG_FIELD_ADDRESS_POS_FLOOR                         790
#define PTEIDNG_FIELD_ADDRESS_LEN_FLOOR                         40
#define PTEIDNG_FIELD_ADDRESS_POS_SIDE                          830
#define PTEIDNG_FIELD_ADDRESS_LEN_SIDE                          40
#define PTEIDNG_FIELD_ADDRESS_POS_PLACE                         870
#define PTEIDNG_FIELD_ADDRESS_LEN_PLACE                         100
#define PTEIDNG_FIELD_ADDRESS_POS_LOCALITY                      970
#define PTEIDNG_FIELD_ADDRESS_LEN_LOCALITY                      100
#define PTEIDNG_FIELD_ADDRESS_POS_ZIP4                          1070
#define PTEIDNG_FIELD_ADDRESS_LEN_ZIP4                          8
#define PTEIDNG_FIELD_ADDRESS_POS_ZIP3                          1078
#define PTEIDNG_FIELD_ADDRESS_LEN_ZIP3                          6
#define PTEIDNG_FIELD_ADDRESS_POS_POSTALLOCALITY                1084
#define PTEIDNG_FIELD_ADDRESS_LEN_POSTALLOCALITY                50
#define PTEIDNG_FIELD_ADDRESS_POS_GENADDRESS_NUM                1134
#define PTEIDNG_FIELD_ADDRESS_LEN_GENADDRESS_NUM                12

// generic foreign address details - ok
#define PTEIDNG_FIELD_FOREIGN_ADDRESS_POS_COUNTRY_DESCRIPTION   6
#define PTEIDNG_FIELD_FOREIGN_ADDRESS_LEN_COUNTRY_DESCRIPTION   100
#define PTEIDNG_FIELD_FOREIGN_ADDRESS_POS_ADDRESS               106
#define PTEIDNG_FIELD_FOREIGN_ADDRESS_LEN_ADDRESS               300
#define PTEIDNG_FIELD_FOREIGN_ADDRESS_POS_CITY                  406
#define PTEIDNG_FIELD_FOREIGN_ADDRESS_LEN_CITY                  100
#define PTEIDNG_FIELD_FOREIGN_ADDRESS_POS_REGION                506
#define PTEIDNG_FIELD_FOREIGN_ADDRESS_LEN_REGION                100
#define PTEIDNG_FIELD_FOREIGN_ADDRESS_POS_LOCALITY              606
#define PTEIDNG_FIELD_FOREIGN_ADDRESS_LEN_LOCALITY              100
#define PTEIDNG_FIELD_FOREIGN_ADDRESS_POS_POSTAL_CODE           706
#define PTEIDNG_FIELD_FOREIGN_ADDRESS_LEN_POSTAL_CODE           100
#define PTEIDNG_FIELD_FOREIGN_ADDRESS_POS_GENADDRESS_NUM        806
#define PTEIDNG_FIELD_FOREIGN_ADDRESS_LEN_GENADDRESS_NUM        12

#endif // CARDPTEIDADDR_H_INCLUDED
