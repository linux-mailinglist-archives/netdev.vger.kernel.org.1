Return-Path: <netdev+bounces-31439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EA578D7D5
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 19:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36C61C20443
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 17:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DF4747A;
	Wed, 30 Aug 2023 17:34:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF7B6FB2
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 17:34:08 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B64193
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 10:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZhk4C5XJ8o+bVFvju7Omwc9riuiZwbe680Z6LfP7PgeGkEhiXzb0JdpECTB2Ea/OgLv7TEqadBPcAvgN/1Z5kXspa7R3KyMoWRnVmjTBaxpC+HE76XY9qTfJIjPYbKsCwTOgJR6tDCDwkaFZs5BCIUqzo0H+UnMKOUU3tYZ7kscTvMg/SteUhl5QpTchWo+1c9suXbr5duDO+AOncJ39OS/o+l6lW/umPzULr+oVaOcqP3oFsnS6ZaChpJKwqore65/43nHfYbJX/NkwlmEg18Yq1KnqZGwM/DXb4aivAxOuc3cbWV3ZjGl6JfQlSwHhlattcYSBIuBS1TYJ6lyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1kdzg/IWy4p+5TiCXYP2ZXy6HvvA0YZONiVuJCbOcA=;
 b=kGBR/hccGS/COh5Rf2Z9miu46cQ1seu26zSH5vKetBQSe6V6WRYHYK7OUedkDtpNzbOi5NwRFBWoY95rHSQp3xVg3sMlWKD9OsgyB1/BWl7Aun0KULFdOTsjc1xENkz0+iDYpaaXvV0TpmYkSaVA9chmXryNybWHB2fbtDegGtylQlhIwjLgwDo8gVV/gv1BNyslCRCr2G9Aqx0v+C1/84b+qcYwSrXvSzyOZs/Ss+b2etcsR6aJPZL6ddyBhQb8//zbvZdoo2dDOMHq1mxOOlxwbKxyOzzuAMNNybFMvEJ8ruiS14dvNQEpglqY9GEssFAsJyIkeimD2VYc47eeKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1kdzg/IWy4p+5TiCXYP2ZXy6HvvA0YZONiVuJCbOcA=;
 b=mePfJ72SrcoqzlWnOzUwrdJltyy6RO/eImoWeX5bKdTbru7neZvyfNZx7pLXXxcHzpiCCmLtDLcaKqD3u7TfsPyvT2qWoMjcRfk9ebUntvMfjS9oed0g4irrNVFZNMwdz9hYnw2qEdhblaAXLJX1fQFeEy8xOD6Hm0wdnYcw3JT4SM/i+HaWaUY7Wo9Fiz9vIuTt7mPeEhYcl0AU7/YGoHVyxRQwLhmJx23LEA+JcTftgGsUGaVPR4mdR4YLoVdMsykPhrCnITH37wJhG13NGUpb9QxQlBeBkff540ogG6VQNi2rNwMqAhDCgmA5HJN+PTxAcx14WaJ9xbmTirSuGg==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by BY5PR10MB4372.namprd10.prod.outlook.com (2603:10b6:a03:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 17:34:02 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::7777:4ee1:2806:a6cb]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::7777:4ee1:2806:a6cb%7]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 17:34:02 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: kernel spam: r8152 2-3.1:1.0: load rtl8153b-2 v2 04/27/23
 successfully
Thread-Topic: kernel spam: r8152 2-3.1:1.0: load rtl8153b-2 v2 04/27/23
 successfully
Thread-Index: AQHZ22gq+XlBr1kOi0St5Llj21ZEog==
Date: Wed, 30 Aug 2023 17:34:01 +0000
Message-ID: <01a445d7a344d3c4a93aaf6590d5883158f448d6.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|BY5PR10MB4372:EE_
x-ms-office365-filtering-correlation-id: ca9d75a1-7ead-415f-ee38-08dba97f4cef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CHncIg6i2+rVne3YDDr4AvcYtZKuatRZLQulWb34wAVH+MBg4QyMiGkIeIhIzoHC61gM2TbeatYknXF6hkkp/c99jN5v/slIlADUb0119VW20PhorbU2BwwK+JgpP3u1MNW+GnRoSWWI4uJ4457sH44KhvGhcL7NF0ZLuE9d1b+cZxN9OcKDuwKDzHRz6SYZI+TpcvbmjywmOT+ujlIpmUDbqvyW04NFtxXpQRuZtbMg/6dhqTdaljNG0c28yKnO2R+3JffsXtjAiCmUbQXDjRd2BL40qAplYD012qVG49v8xibvDnqtkro1i8xbdhA7izauTNoSxGC39Tk3ZjxDh3pWE47YoCbXEi/n61OVwvs7Wqmwjr4rOx+yoptdBUpuoIHEUP6JAEfIUjvrxUqYN8ZRitsrjsb7sG/lzcEOgu1dn8V91Zca4QZR8luWm0ssYH1lyAFCtHdyPfSJPi+CU8OlDTF6rHJNtbtJFvhZgrs4txX+anrXE+4j9aPSjXhC11KfvEe35VyRsgrquZx3+XUYc+r47HNAFZbJ/6GHK7u4nOzHpUoxLSqk8mNNsOBYyT1oaGrLB+ZrwrBfiymAfTYArnNo41gyGWhYfBRJ0TblMMwYbwVlB7iqdI172T7V
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(39850400004)(136003)(1800799009)(451199024)(186009)(36756003)(6512007)(8936002)(86362001)(478600001)(6506007)(66446008)(66476007)(91956017)(316002)(6486002)(64756008)(76116006)(41300700001)(66946007)(66556008)(6916009)(71200400001)(5660300002)(2616005)(8676002)(83380400001)(4744005)(2906002)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDZaVURhZldDdEFLQU1qUXNQOUhySkRtL0Jvdkp4VEpSRVZZTXJoSTNrcnRF?=
 =?utf-8?B?dkNxV2JiUzdwSms1VmJqbzBmeEJqZ2JGRTVxbDB2cEx4bkg5T2VDRnlMSXpT?=
 =?utf-8?B?SmtGbEo5Y21nNkg0VTJpdGdlUlloVnFBc09iNFpIc2daRlpvd3F3dXVxaytv?=
 =?utf-8?B?cWdlYklNaVVQNDRLZGRBQWVrNkxUOWNuVG9udW13NDI1RVR4TDJ6a3pENStG?=
 =?utf-8?B?aWpWVjNFZmJaUUh6VjhtVWZtTG9ZOE5RUUhzVGs4RXh0WVF1NHNRcW5FSTlt?=
 =?utf-8?B?UExVVzlZNHZaSHNjSEtpZy9vQktxR2gxTXp6bGdIb2cvNkxtV0FGRzZTbENs?=
 =?utf-8?B?Zmd6NU9kcnZLaTFMaGdNd29Qdi9yMGhHOHR4MUJJM2ZxdlpGUUhLV2RETGlx?=
 =?utf-8?B?dlgvSEdJRTd1a3RWcDhUZHE1RGxLdkpzTzV5cUJoNHNIckFuTmFRdGdLY2Vm?=
 =?utf-8?B?eE56cnJ1cVdxMzNxanlUWll6RE9URjBrdk1ybCt0Y2tER3BuUGYzUHdFWXNP?=
 =?utf-8?B?NUNWM0t4eTJRM1FPSVcvMjRTeWwxeWJ5TkVtRzErL3ViMUNMMmw4V0hxa3lS?=
 =?utf-8?B?TWgyUkw2SHhyVTBjWlBDMzI5Q3BoVzZYQnFma3oyQy9rRjIrdlFINXp6U084?=
 =?utf-8?B?Z3paV25YdXdZN2NwY1l0dk1UV2lNaEJtaW5hVUdvcGFUMlh2VG1QNFAxUVhU?=
 =?utf-8?B?UEkybmsvekxZbkJyaGFyYUNRTndCUHFYQTFQU0lLazN5Q3FkTVpCcnNmeU44?=
 =?utf-8?B?c1hnQTZyZ3dJSzc0Skw4RXJIYW9jWk1KZW9WMTFhSlBEaTg2NUhOZnFiNW1B?=
 =?utf-8?B?cFpTeml2MUtaU0U5Q2NKOGl6UTNtOXNqeWJMdzhzZm5zdWMwUXYxU2ZXSlNI?=
 =?utf-8?B?Y2dHTGlpTjRIRGJkYWZsd1RJVXl4U1N5b3F4NkJaVGR6djN5bzNXNyswaGNL?=
 =?utf-8?B?dUpGZWJkd1g5RmJ4V1BwdkZWSERrSldJWHE4bDNyS0dJclFNaWhzZmdxVWNi?=
 =?utf-8?B?Vk1DZ0VxeFB3OFhhN2czRFVnVFZxVkYrK2REdzgzNEIzZDVHek1pMjdxaVBQ?=
 =?utf-8?B?NVorU0RBVUltZW9LRHFwcnovUEFadjM4WlE1cUlFdTFOVEFsdHRKN2VObmxH?=
 =?utf-8?B?ODhXSVkxcm9sRDgzdzFrM1o1eHc4eXRXOVplTlhZQklVN0hITzQyV2k2cEEx?=
 =?utf-8?B?K1pXOURQUDJGTml4cGQvUmlYNCtLd2oxeUNvdmZzUmdjMHFZRWxycE9aTnNC?=
 =?utf-8?B?d01Lb0ZvUGZIdUdtZlEzTHhlNjVqMVl1MVU4SzNHTXZGUDhpSXpWOFpjalFl?=
 =?utf-8?B?a0RUelphZGhGT1BicVFMZ2RacEZTOUYxWWVxVHJzNjM0WjdONzkxa0Y0Rld0?=
 =?utf-8?B?b1VSVGZOR2lCUEUvK3lMeHl1TFRsT1lRWGxUNTB4T2V5YUZ4ek1yTksvMENW?=
 =?utf-8?B?dXdwQUQyWjhtVi9GeVVINkFGMTNIVlJ0ZzFBdUQxcVdoOER2eUUrUFhGQVZ5?=
 =?utf-8?B?dlRWYU9tTlI5UGwzeVdoUmV0MTQ3MXZ3cGN1WGw2SldlOVl4bzk1dnVLa2Z3?=
 =?utf-8?B?M0ZOTDl1T2JzSm92VFFhaUozOWJIY3hXK3JqSXNLNVJ1MjdIc2JUbnZ5QUQ4?=
 =?utf-8?B?V3p4eUZEUHZoby9sVm8xNm9kUUYxWm55aDMrOHgrenl1NGsrVE5mYzV3VVMz?=
 =?utf-8?B?SGpPNm5HYW9xeCtYajBoY1p6RDB1Nkg2bkFraFRDZjVFUGJ2bkVSSTFEMGF0?=
 =?utf-8?B?MW8vTW83UWZYOENCM1gwZ3o0c1R1V3hrbktOazZHckpUd2paYTR6Rzh1VzBC?=
 =?utf-8?B?aElhZ2I4cWkxc214NG5KbGFFQWxTeTVLM0ZHays0SHhkQU9TTnByNVBkc2hn?=
 =?utf-8?B?SHh1aFJtK1VHSTNNK05PWDdZVzNXdW9XVHFiSFlGSU9CRXBvOW1pOTEwbjRS?=
 =?utf-8?B?d0xzelQ5ZlhyMTVhKzdYcy96d1QvMXpnUVFsZUE2YTZycVRHSWJJSm05Ni9k?=
 =?utf-8?B?L3BYYWVBK09nL2hkclJ1UGNoMWlDTGxqdGpHM2dIQURaK01YTHZQQ2xGbUVB?=
 =?utf-8?B?MXRsWmNJVi9YZVRzamcwbVp3RXlER0c2WER0K2ExNlBIMlNWMzJTV3V0Y2xU?=
 =?utf-8?B?cFd2UTdZYW5Oc2FjekhCVWJGUkhpYUtsVytGR2RZa08vZkVKejRHckE3Q2VP?=
 =?utf-8?Q?7/0TjMGj0vfQ3Eg4RchQFAwVWvbC4a4JKAuBJgi7JRCV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5189BA22E0CFE49997164EE98DA5F2E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9d75a1-7ead-415f-ee38-08dba97f4cef
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 17:34:01.9230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vlLJmnAS3F71ZxVDgAD7NPyvxKmgL3vkGaq5O3XSXZ1Xzc0qVDSHol0p2ujorE+AY+TWe38/thUeSisHwiP9LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4372
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

VXNpbmcgTGVub3ZvIDQwQVkgVVNCIHR5cGUgQyBkb2NrIHdoaWNoIGhhcyBhbiBldGhlcm5ldCBw
b3J0KG5vdCBjb25uZWN0ZWQpLg0KSW4gbXkgbGFwdG9wIEkgc2VlIHRoZXNlIG1zZ3MgcmVwZWF0
aW5nIGVuZGxlc3NseToNCg0KW1dlZCBBdWcgMzAgMTk6MDU6MzAgMjAyM10gcjgxNTIgMi0zLjE6
MS4wOiBsb2FkIHJ0bDgxNTNiLTIgdjIgMDQvMjcvMjMgc3VjY2Vzc2Z1bGx5DQpbV2VkIEF1ZyAz
MCAxOTowNjowMSAyMDIzXSByODE1MiAyLTMuMToxLjA6IGxvYWQgcnRsODE1M2ItMiB2MiAwNC8y
Ny8yMyBzdWNjZXNzZnVsbHkNCltXZWQgQXVnIDMwIDE5OjA5OjAzIDIwMjNdIHI4MTUyIDItMy4x
OjEuMDogbG9hZCBydGw4MTUzYi0yIHYyIDA0LzI3LzIzIHN1Y2Nlc3NmdWxseQ0KW1dlZCBBdWcg
MzAgMTk6MTE6MzggMjAyM10gcjgxNTIgMi0zLjE6MS4wOiBsb2FkIHJ0bDgxNTNiLTIgdjIgMDQv
MjcvMjMgc3VjY2Vzc2Z1bGx5DQpbV2VkIEF1ZyAzMCAxOToxMzozNCAyMDIzXSByODE1MiAyLTMu
MToxLjA6IGxvYWQgcnRsODE1M2ItMiB2MiAwNC8yNy8yMyBzdWNjZXNzZnVsbHkNCltXZWQgQXVn
IDMwIDE5OjE0OjA5IDIwMjNdIHI4MTUyIDItMy4xOjEuMDogbG9hZCBydGw4MTUzYi0yIHYyIDA0
LzI3LzIzIHN1Y2Nlc3NmdWxseQ0KLi4uDQoNClRoZXkgYmVnaW4gYXMgc29vbiBhcyBvbmUgZG8g
aWZjb25maWcgdXAgb24gdGhlIEkvRiBjb25uZWN0ZWQgdG8gVVNCIERvY2sncyBldGggSS9GDQoN
Cmtlcm5lbCA2LjEuNTAgKHRoZSBtZXNzYWdlcyBoYXMgYWx3YXlzIGJlZW4gdGhlcmUpDQoNCiBK
b2NrZQ0K

