Return-Path: <netdev+bounces-73695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E227085DA4A
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 14:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFBF21C234A6
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB327BB03;
	Wed, 21 Feb 2024 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="pq8arJHx";
	dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b="CFS5wZuq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00183b01.pphosted.com (mx0b-00183b01.pphosted.com [67.231.157.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD987BAED
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522008; cv=fail; b=TtoEL8n5yHRCkAyOHhVXJLULIlKRjCXIjsgG0panXkMz6DFKeh8afBwCU79zOYw2YWyTjkFTdGlRCxpEcztv/ciMXHKFr86Y03n3Rud75UoX3pCTEx8i5vhQ6AGB1bk7u0+qpWnXWnOmyety0AxkH9/6cjxTAIQI+vXSU/nFtSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522008; c=relaxed/simple;
	bh=F2llZAwyCb1Tq0YQBh2bIaA7Ou3qBps543aJXeXzDuk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t14s9WbvqjSwmabtoyRRRmyRwU0yhPyquCga96b/8JnGu/cQb++npWebBWuyAeAv1whpeVCW9D1oZGDam/B3aVvYrZ2FeoP63wT3fZDhZRO/2adhx832aU8jZCYK3lSSUdsaGA9FmemzCQw8bSea3iTA1qwgFSSwHAZwj4Zplyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=pq8arJHx; dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b=CFS5wZuq; arc=fail smtp.client-ip=67.231.157.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
	by mx0b-00183b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L8olTN017939;
	Wed, 21 Feb 2024 05:21:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	pphosted-onsemi; bh=F2llZAwyCb1Tq0YQBh2bIaA7Ou3qBps543aJXeXzDuk=; b=
	pq8arJHxm7neRBmMTn7jSuITGZTjLqe/6tWqyZfYQ+gUrZFEhBIpAyp77rnhkOdj
	3icbWQr3Iy0kC1dWQKQjvASlD66HxPYme3+Pdm5b0LDOo5cicTXVN/lsM7D7mASz
	yidv0j+46F2qeeUw2ojFT4Dtq9X2VnfqKZvsHBnkAg34vhfXrTHiTBS3+saBHB7s
	ujtZYJ6OSPM4Vr/XyVeAt9ND6SVFLyyYXD8hggUvRUPAfD9rw0n4gWLAssFK4LfY
	Szu27dFi0ZKLjusaT1qmCKdaHsa4Pb0yXawseQYg3cro05mqiHeLVDS8+JZ47J4T
	lZCDk63jIpkDEV5RdRyfrg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0b-00183b01.pphosted.com (PPS) with ESMTPS id 3wd21f20jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 05:21:25 -0700 (MST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpEsS4PD4vGBnOzi1t2NnthUSFuAJH48rti7S2DkgKnJ86cEbopKLZdUsYVLthAeSxNfQL4ow/cXrI8kmBAJylkqhjS0EvxGbGwHO/d2UeURfpZBYSypmFFH2P2bMik6vuBcuczs2ePlwH/JoGTcBdCxkbTmGKp+T9+Jp34CT+TGUiw6++//tzNlPknyHb1Z+EK90x822w03m7/d0c+xoA3kAxD7hSKNR1u2MHO6/p2Ay1xqyCecUMTJXcOns2uHvZrTl1BWcj/6maP/mr5hNUv6tsSlX9HxxwVN7CkQdfXCAunGtGWZgfGaqP7Brb9cDiMep6rGvCkVLPSqrGy79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2llZAwyCb1Tq0YQBh2bIaA7Ou3qBps543aJXeXzDuk=;
 b=EfQa15gsXf64sHBgcSLADKV6ttXnx0POzao7yepJb3WAi6YHbrnF9MxPvVRaZqYrxTTnowAWt28TgoJ53n9t38v/LpiUOQasg+6L2qUSpftnmeLl8+gXRMB+ddJ36q1+JrAU2U4G7kk1Elgiu7TuIt8bXdmK2ICVYLNdezGDL4CRofE13GB3O8ytnaKFz4TUoSL0fo+Mr3Sr5BL4bcg2TlmSVpenhh4hR13MUAcZg2pzOBmwZTKhbXoxmdt1moGIjeNb98ErL/2g38YmbPS3EtetRyFrPTxSjeAgTeEO992QHUvmy9ZeosWxlW45Yfy0P4+5ufQh3djoNbVBRR7lMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onsemi.com; dmarc=pass action=none header.from=onsemi.com;
 dkim=pass header.d=onsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onsemi.onmicrosoft.com; s=selector2-onsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2llZAwyCb1Tq0YQBh2bIaA7Ou3qBps543aJXeXzDuk=;
 b=CFS5wZuqztWDe1eqE28Qzk90QZ6ss86u7Q6Zd4cQ/w3zk3IgDuewoaYr4rv3jBmYI+AlcBoGqlrpxdJpIxwOdTGPQ2ERZgUOJHS41cLdJAbjvBoMBzIgmcFn6dq1/EDncBAe0a6PcQZ6w+grRQCaFFG8L7G5Fa3eKDp9/em4wC8=
Received: from BY5PR02MB6786.namprd02.prod.outlook.com (2603:10b6:a03:210::11)
 by SJ0PR02MB8466.namprd02.prod.outlook.com (2603:10b6:a03:3f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 12:21:23 +0000
Received: from BY5PR02MB6786.namprd02.prod.outlook.com
 ([fe80::e3b6:5a44:b5a2:2199]) by BY5PR02MB6786.namprd02.prod.outlook.com
 ([fe80::e3b6:5a44:b5a2:2199%5]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 12:21:23 +0000
From: Piergiorgio Beruto <Pier.Beruto@onsemi.com>
To: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Steen.Hegelund@microchip.com"
	<Steen.Hegelund@microchip.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "Horatiu.Vultur@microchip.com"
	<Horatiu.Vultur@microchip.com>,
        "Woojung.Huh@microchip.com"
	<Woojung.Huh@microchip.com>,
        "Nicolas.Ferre@microchip.com"
	<Nicolas.Ferre@microchip.com>,
        "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>,
        "Thorsten.Kummermehr@microchip.com"
	<Thorsten.Kummermehr@microchip.com>,
        Selvamani Rajagopal
	<Selvamani.Rajagopal@onsemi.com>
Subject: RE: [PATCH net-next v2 0/9] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Thread-Topic: [PATCH net-next v2 0/9] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Thread-Index: AQHaYSVbSeYqQvjhI0CUznc288rgz7ERbtkAgABPWoCAAolcAIAAdlrw
Date: Wed, 21 Feb 2024 12:21:23 +0000
Message-ID: 
 <BY5PR02MB678696DBEF2A6A5F5E61A02F9D572@BY5PR02MB6786.namprd02.prod.outlook.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <1e6c9bf1-2c36-4574-bd52-5b88c48eb959@lunn.ch>
 <5e85c427-2f36-44cc-b022-a55ec8c2d1bd@microchip.com>
 <e819bb00-f046-4f19-af83-2529f2141fa6@lunn.ch>
 <cbfbf3f6-45b7-4f40-bc05-d3e964e55cc7@microchip.com>
In-Reply-To: <cbfbf3f6-45b7-4f40-bc05-d3e964e55cc7@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB6786:EE_|SJ0PR02MB8466:EE_
x-ms-office365-filtering-correlation-id: 24e1b3ea-88f9-4c4d-97ef-08dc32d79e5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Hi+zpEgkkLhIoVXkqNgOW41i/nxzgPtFgIceGFSo2T9TDSBEFeQJAYE37hJhZOdD/E4CGHxc0X2mom7XBU03KD31tZkCLPmRpvCs41YtgcwYxlHIZBhm9PwpLLyttFsfcqNXdOuImQQx6JrbsOx3ZZbZF2ObQ/eB6GHdw/Xh4+yYTON6yteURY9Y0yKROxENgDsJHvUv/CzClsGFkZ+2t04jWFk5X+bG6bjifHjscm9uc2Pni5OMofb7GQHfBEQoGZb96g4/J0PZfl10yE+raQMHVMjgXGUAiIVPWiCpPFR40pltseQUxESRDMdceJu5FYGMzHr+RI9pjmd4HcXgqnpdfxU1Ddp7iVxjprrYVnIDtb2KALc1rZX5NY3Pa0VglRAVofwjRQNWKyYzxn+sqDSsInZYUvcgjmwoRh6WGnXV5eB/75wceyA7WrygSjYij/UOlWV5bVHTDoMq/C1Bnz25a99Ml3XZJb70v84bBtB7l9KL9ST9TZq+u0yulTzlCEt6Buhx47IxVfgHyoilPNx4+X9lJrKqaVImaU0MfuG6G61STdej2Cky0a4bG4EnkIqIVLd4pgCHoK5QP6R3yUTHL1YtMJoycWjjDXzGXuK5DeNBLobpNSOolmjTdtMu
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6786.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UFRZcTBUcDc4dTlDdExYc3k1empCN1J5Mk02dEI2ZWVrWk5YVkJ2Ukc5NTRt?=
 =?utf-8?B?WnpGY2F1WHEyaHJSZDI3N09zcHJqRlRVWXhueS95MmIyclBjeEFSU1lKV0VC?=
 =?utf-8?B?NGZMMFUxbVFIS3FGTm9jK2ZkTll0YTQydDR2aHltdkpvekk1MHA2SXJOVEg5?=
 =?utf-8?B?RDZ1Wkw4VXdUa0dUa0lPT0NIL29lTHFoZzdmUmdXZVd6c0J2c2UzYXhBcHFV?=
 =?utf-8?B?dVk5dnJEb0xLRTRDSnFVcmUwMTBRZWJOUXgybGFwWVVzanMxckpOMGtKTExJ?=
 =?utf-8?B?MjJ1QlUvbWh6YlpkMVFuNzlQVS9wVjhJQkJ4bnZqK3VSNXA2Y1JVYlQ2Z2xo?=
 =?utf-8?B?ZTlZbmtua0xvWEkrOHFMQXdEeGkrSU5TSlVBNmh3Y3g0VWdJaHgxV3NsZGNN?=
 =?utf-8?B?dEd1K3RuQThtM3E0WkZsRzM4NmcwcGkrOVJxS0pobFd3L0R5V3FkTTQvRXdD?=
 =?utf-8?B?MmZjNjBvUG1QRnVqaGdrYXYxZEY1N2lSWTB5cnlnYmpFWFpOMTdrZDR0UEp1?=
 =?utf-8?B?SDEzUGpxWllnOHFJYkVRODd3SDBObGg1TnRwUklpMG54RmxhaG5pYlpJVGky?=
 =?utf-8?B?aEJkVmVrNXNnYVNaR0JCUXFsbE9EZkcxMm5JOU1rMXQ4UlZXQlVvaVd5L0xF?=
 =?utf-8?B?L25YT3BhS3NWZDNhU1pNYmZVN1F5SlQwNU5wV2FlKy9LcGoxMElYYm5zeSta?=
 =?utf-8?B?U29lejd4V3NuSENnSWZtSUtMWlBuTFNFTUlJOXZWUFBJbzcwNHlaL2JHYmpO?=
 =?utf-8?B?LzNMSjVPMU82M1FLK2p6Y095UWZKQ0U5SFRmSDdkVWNrY0FUVVlxMDRNUnVo?=
 =?utf-8?B?NS8xZmFxS25BMHFaZGU1M1p2ZXprdkFob0ZrOUhtQXpWdVNFYUNQeGF6Nmsz?=
 =?utf-8?B?MEFKOXF5ajFIMVA5ekVqRmlYdkUvRkNWWmdmWjJtdURjaUxESW9aMWo3VzVJ?=
 =?utf-8?B?dmhDY3FTaWJya0VwVFE2VDl5d0tQT1NQblZFczBwZGNLVElVbWFJR2piMnI3?=
 =?utf-8?B?RElhQ3pVNlhOQTVZQkZqcFhQTTg2UzhQNFh1dE9JbHVuaDZJR2cxY0Y4SWtm?=
 =?utf-8?B?bE9Tb1BoVDUwYkRMVmlHRGFLZEgyWWQ3am1PSEF2dldZbUdOam94YW1lbW4z?=
 =?utf-8?B?NTRyaVdWOHJZdFFKaWd5S2Z3WDI1dytvOGNtaU1GMnBBenVXeklORjE3Vjg2?=
 =?utf-8?B?a3FpQ3ljR29CaGFob2ZkMnowSjVuNFovRHd5UU1rUENOb0ZqbjJERlpYQWs4?=
 =?utf-8?B?UWIxOFdySHc2eXBWU1h2NUlkMFpQUnU1S05Fd1pXaVRFYUpNb1FkQTg5M1Vo?=
 =?utf-8?B?VHVPbU1yd29uYTJKT3FEOFBucnJWVTBaWk1tL2xJNEp5bGx0UnlVRjcyWHV2?=
 =?utf-8?B?YnFXdEVwMmVXOWI3bHgrSXExdWxhZjg1dmY4cDN0QUxtQzRvQVNZVWVJcGdS?=
 =?utf-8?B?c3JheTZrL2xiTlNHa2daTzdLcGk4Nmx2ck9WUnpEWVY5ZEV4NnRJSHV0MHRB?=
 =?utf-8?B?M1hJWlFwY3pORXBFam1mcnpnTU1jZVBQa1prVCtRVXUxOVpDUERHejR4Q1A1?=
 =?utf-8?B?RGY3V1VqK0dmbzJ6bTNOSmlLYS8wNm5WSFMyZ1I5TFFDSEpOVWtBS1BhWVJJ?=
 =?utf-8?B?cm5GQXlWVHdWSzBmRllOZFoyTWovcEgrR2x6RlpwNGZJWEJpMlpTS0ZrWHpr?=
 =?utf-8?B?eVFPRE13cUNwWFg4cmY4aGFJZm9CcmkxU1g0RloyQ25tWGxRbXZJQm1MK1gx?=
 =?utf-8?B?b0RlT3pNd08rTEg3OEpnRGxFNzdoY1czb0hDSHlOWmdhSEVsdmhNc1hHMjFD?=
 =?utf-8?B?dmhvbFZGTFZ1VklOMDRHRW11V0Q0ZHpVaE1yUkJWZm5aZFRXZEJWb1ZkbDNs?=
 =?utf-8?B?ekZZeGd6amtLWWNidDNJNVA2Z0I0VU5vejZxSVJCL1RGTmdsTmxxc0tNdDR4?=
 =?utf-8?B?MHRnNFEwUzVwRGU4SDRHUGVJZ2tCYzBzdGV5OWlvOXNvNjJma29DRURqc2tE?=
 =?utf-8?B?c0JDUHB3NjArY1h1OWQyRk80NkRaZXQwSE5nMXZ6V1g4My9uOWpBdU0xN0dC?=
 =?utf-8?B?U2hwSENBdTY4SHZVbmVXU0gzcTR0MEltbTczaEpOOEhDTFFCaGIwR1NNaVcy?=
 =?utf-8?Q?Co2VbPpMEWD21Ellg93k1746S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6786.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e1b3ea-88f9-4c4d-97ef-08dc32d79e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 12:21:23.6030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CX4FWQp6dB/Nfh8NyvYA2Vhi8cCH6Q1KLOpYjASx92MPqtMBiZ6Bq5MMZs4WySwIVFrxIkK1JmgHzx4deKbm6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8466
X-Proofpoint-GUID: k9aWp7iI7gkJk5EnPih3UkETNJ3VURBs
X-Proofpoint-ORIG-GUID: k9aWp7iI7gkJk5EnPih3UkETNJ3VURBs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxscore=0 clxscore=1011 spamscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402210096

SGkgYWxsLA0KdGhhbmsgeW91IGZvciB0aGlzIGRpc2N1c3Npb24uDQoNClNpbmNlIHRoaXMgZnJh
bWV3b3JrIGlzIHN1cHBvc2VkIHRvIGJlIGEgYmFzZSBmb3IgZXZlcnkgcG90ZW50aWFsIE9BLVRD
NiBNQUNQSFkgaW1wbGVtZW50YXRpb24sIEkgcHJvcG9zZSB0aGlzIGNvdWxkIGJlIGEgam9pbnQg
d29yay4NClNlbHZhbWFuaSBhbmQgSSBzcG90dGVkIHNvbWUgcG9pbnRzIGluIHRoZSBjb2RlIHdo
ZXJlIHdlIGNvdWxkIG9wdGltaXplIHRoZSBwZXJmb3JtYW5jZSBhbmQgd2Ugd291bGQgbGlrZSB0
byBhZGQgdGhlIHJlcXVpcmVkIGNoYW5nZXMgdG8gYWNjb21tb2RhdGUgYWxsIHBvdGVudGlhbCBp
bXBsZW1lbnRhdGlvbnMuDQoNCldvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIHNoYXJlIHdpdGggdGhl
IGdyb3VwIHRoZSBsYXRlc3QgcGF0Y2hlcz8NCg0KVGhhbmtzLA0KUGllcmdpb3JnaW8NCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNy
b2NoaXAuY29tIDxQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbT4gDQpTZW50OiAy
MSBGZWJydWFyeSwgMjAyNCAwNjoxNQ0KVG86IGFuZHJld0BsdW5uLmNoDQpDYzogZGF2ZW1AZGF2
ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlA
cmVkaGF0LmNvbTsgU3RlZW4uSGVnZWx1bmRAbWljcm9jaGlwLmNvbTsgbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsgSG9yYXRpdS5WdWx0dXJAbWljcm9jaGlwLmNvbTsgV29vanVuZy5IdWhAbWljcm9j
aGlwLmNvbTsgTmljb2xhcy5GZXJyZUBtaWNyb2NoaXAuY29tOyBVTkdMaW51eERyaXZlckBtaWNy
b2NoaXAuY29tOyBUaG9yc3Rlbi5LdW1tZXJtZWhyQG1pY3JvY2hpcC5jb207IFBpZXJnaW9yZ2lv
IEJlcnV0byA8UGllci5CZXJ1dG9Ab25zZW1pLmNvbT47IFNlbHZhbWFuaSBSYWphZ29wYWwgPFNl
bHZhbWFuaS5SYWphZ29wYWxAb25zZW1pLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5l
eHQgdjIgMC85XSBBZGQgc3VwcG9ydCBmb3IgT1BFTiBBbGxpYW5jZSAxMEJBU0UtVDF4IE1BQ1BI
WSBTZXJpYWwgSW50ZXJmYWNlDQoNCltFeHRlcm5hbCBFbWFpbF06IFRoaXMgZW1haWwgYXJyaXZl
ZCBmcm9tIGFuIGV4dGVybmFsIHNvdXJjZSAtIFBsZWFzZSBleGVyY2lzZSBjYXV0aW9uIHdoZW4g
b3BlbmluZyBhbnkgYXR0YWNobWVudHMgb3IgY2xpY2tpbmcgb24gbGlua3MuDQoNCk9uIDE5LzAy
LzI0IDg6MDAgcG0sIEFuZHJldyBMdW5uIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IA0KPiB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPj4gSGkgQW5kcmV3LA0KPj4NCj4+ICAgRnJvbSBNaWNyb2No
aXAgc2lkZSwgd2UgaGF2ZW4ndCBzdG9wcGVkL3Bvc3Rwb25lZCB0aGlzIGZyYW1ld29yayANCj4+
IGRldmVsb3BtZW50LiBXZSBhcmUgYWxyZWFkeSB3b3JraW5nIG9uIGl0LiBJdCBpcyBpbiB0aGUg
ZmluYWwgc3RhZ2Ugbm93Lg0KPj4gV2UgYXJlIGRvaW5nIGludGVybmFsIHJldmlld3MgcmlnaHQg
bm93IGFuZCB3ZSBleHBlY3QgdGhhdCBpbiAzIHdlZWtzIA0KPj4gdGltZSBmcmFtZSBpbiB0aGUg
bWFpbmxpbmUgYWdhaW4uIFdlIHdpbGwgc2VuZCBhIG5ldyB2ZXJzaW9uICh2Mykgb2YgDQo+PiB0
aGlzIHBhdGNoIHNlcmllcyBzb29uLg0KPiANCj4gSGkgUGFydGhpYmFuDQo+IA0KPiBJdCBpcyBn
b29kIHRvIGhlcmUgeW91IGFyZSBzdGlsbCB3b3JraW5nIG9uIGl0Lg0KPiANCj4gQSBoYXZlIGEg
ZmV3IGNvbW1lbnRzIGFib3V0IGhvdyBMaW51eCBtYWlubGluZSB3b3Jrcy4gSXQgdGVuZHMgdG8g
YmUgDQo+IHZlcnkgaXRlcmF0aXZlLiBDeWNsZXMgdGVuZCB0byBiZSBmYXN0LiBZb3Ugd2lsbCBw
cm9iYWJseSBnZXQgcmV2aWV3IA0KPiBjb21tZW50cyB3aXRoaW4gYSBjb3VwbGUgb2YgZGF5cyBv
ZiBwb3N0aW5nIGNvZGUuIFlvdSBvZnRlbiBzZWUgDQo+IGRldmVsb3BlcnMgcG9zdGluZyBhIG5l
dyB2ZXJzaW9uIHdpdGhpbiBhIGZldyBkYXlzLCBtYXliZSBhIHdlZWsuIElmIA0KPiByZXZpZXdl
cnMgaGF2ZSBhc2tlZCBmb3IgbGFyZ2UgY2hhbmdlcywgaXQgY2FuIHRha2UgbG9uZ2VyLCBidXQg
DQo+IGdlbmVyYWwsIHRoZSBjeWNsZXMgYXJlIHNob3J0Lg0KPiANCj4gV2hlbiB5b3Ugc2F5IHlv
dSBuZWVkIHRocmVlIHdlZWtzIGZvciBpbnRlcm5hbCByZXZpZXcsIHRoYXQgdG8gbWUgDQo+IHNl
ZW1zIHZlcnkgc2xvdy4gSXMgaXQgc28gaGFyZCB0byBnZXQgYWNjZXNzIHRvIGludGVybmFsIHJl
dmlld2Vycz8gRG8gDQo+IHlvdSBoYXZlIGEgdmVyeSBmb3JtYWwgcmV2aWV3IHByb2Nlc3M/IE1v
cmUgd2F0ZXJmYWxsIHRoYW4gaXRlcmF0aXZlIA0KPiBkZXZlbG9wbWVudD8gSSB3b3VsZCBzdWdn
ZXN0IHlvdSB0cnkgdG8ga2VlcCB5b3VyIGludGVybmFsIHJldmlld3MgDQo+IGZhc3QgYW5kIGxv
dyBvdmVyaGVhZCwgYmVjYXVzZSB5b3Ugd2lsbCBiZSBkb2luZyBpdCBsb3RzIG9mIHRpbWVzIGFz
IA0KPiB3ZSBpdGVyYXRlIHRoZSBmcmFtZXdvcmsuDQoNCkhpIEFuZHJldywNCg0KV2UgdW5kZXJz
dGFuZCB5b3VyIGNvbmNlcm4uIFdlIGFyZSB3b3JraW5nIG9uIHRoaXMgdGFzayB3aXRoIGZ1bGwg
Zm9jdXMuIA0KSW5pdGlhbGx5IHRoZXJlIHdlcmUgc29tZSBpbXBsZW1lbnRhdGlvbiBjaGFuZ2Ug
cHJvcG9zYWwgZnJvbSBvdXIgaW50ZXJuYWwgcmV2aWV3ZXJzIHRvIGltcHJvdmUgdGhlIHBlcmZv
cm1hbmNlIGFuZCBjb2RlIHF1YWxpdHkuIA0KQ29uc2VxdWVudGx5IHRoZSB0ZXN0aW5nIG9mIHRo
ZSBuZXcgaW1wbGVtZW50YXRpb24gdG9vayBzb21lIHdoaWxlIHRvIGJyaW5nIGl0IHRvIGEgZ29v
ZCBzaGFwZS4NCg0KT3VyIGludGVybmFsIHJldmlld2VycyBTdGVlbiBIZWdlbHVuZCBhbmQgSG9y
YXRpdSBWdWx0dXIgYXJlIGFjdGl2ZWx5IHBhcnRpY2lwYXRpbmcgaW4gcmV2aWV3aW5nIG15IHBh
dGNoZXMuIEkgYWxyZWFkeSBoYXZlIHRhbGtlZCB0byB0aGVtIGFuZCB3ZSBhcmUgaW4gcHJvZ3Jl
c3MgdG9nZXRoZXIgdG8gZ2V0IHRoZSBuZXh0IHZlcnNpb24gcmVhZHkgZm9yIHRoZSBzdWJtaXNz
aW9uLiBXZSBhcmUgdHJ5aW5nIG91ciBsZXZlbCBiZXN0IGFuZCB3b3JraW5nIGhhcmQgdG8gcHVz
aCB0aGUgbmV4dCBzZXQgb2YgcGF0Y2hlcyB0byB0aGUgbWFpbmxpbmUgYXMgc29vbiBhcyBwb3Nz
aWJsZS4NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+ICAgICAgICAgIEFuZHJl
dw0KPiANCg0K

