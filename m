Return-Path: <netdev+bounces-111415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B334930DC9
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 08:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2AB2B20DBB
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 06:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A908C13957C;
	Mon, 15 Jul 2024 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Nnhm+pq7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D6E33F9;
	Mon, 15 Jul 2024 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721023394; cv=fail; b=RLtYHTo53S5wUrZcw6vidPkKUXk6w9hfw4jeWbu1ma3OCk17tBoTZ2kRJ4NRsLQ6mtjRXewVG7heDylcYTMW4SbyDVzLLB821KHr6/pskwYUFwYj9XDDsKNSPNV9VvYC5p2lcCl289D87i21MFiwU/FqP7h4i0K0Gt5TxCM9N5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721023394; c=relaxed/simple;
	bh=PPVqd3N5tcb/5QzZD8kyrHWSZyfny0eP7xdvzgui/Tw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=NOjupdf3y6xkc58zAb8QBq7KR+HqMHs/MAf08ksfnrZTb8IXRAcjX5uLny8Hu4fNkGZnhneWNhsTubMocx50AzuXsijy9hEvQfyJpC8/JrUzy6XTlXzd8ihoLl3jXLjGaL7tR/OEFwHFko2nTdjV2SM5Yg1jpNbBBzKio1NuIMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Nnhm+pq7 reason="signature verification failed"; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46F0Ldu2009289;
	Sun, 14 Jul 2024 23:02:32 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40cs5d8pa0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 23:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRVAyrECDJI/aaWieTDdCh6Qc2qAoRxnuCYnCbY89ETsWeFfoAEfQ3n1NYlNS4UdkVQY/avRXQxEMCsrUpY3O62iWutz0k/Mag4kTDAZUhSQLNII06zcZ+J13WIEKp0jlAycA5pRffxezcWLemnPhY/J2VvOYA+gX4UVcWxJK9Oz811OlNWyPJyRvqQM2y8kBfbh/zgvmaexnqvVa8rwoi/ePx8Obo4rPS8T1GnRm4YwBIa/76Sdelmi8+x49LMdzQ44xCjaNLbX4y1DVC4PsCTx9nzQGhUhF55emg7HtmvzbeQZMG6NW6cRfJ9XXCMu3FSXLfoFex5eRxverMK+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hFoOK2hsjs2VTXmWg/ZJSG/Y9+9BE2IlXrBNpA3TrM=;
 b=MYYiFi3DGc3p9aTs3vZ1R7/3Et+DvJKatWuU9NouMaVVcYjbvnwtQBuTZfRM6Fo/8hsiGVSTrYpFHRpYRm7RWzNQLYHjFkEOhVogZz5tDryJj1UFKX/hxVxwVDELTATjh+7G4MiRfoh3OHpQGNqtoxDa79pXMo5b+/P6pP8ebszquGPw5Y+WBqbBlbYGTDAfsYIZh2LNZwy9nqjrmDjzsj0AUjThUfnm3EoMQful30uO69hjv+9qGJgWAZLW+8wZLtJAvjq6XErWbO7fm1NdFalwpSps8Ebfee6KDWOuh7AGwu2Rlvi9mOd2IWbtmGbTsyNoDqKE01CI6IFWh6Z1dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hFoOK2hsjs2VTXmWg/ZJSG/Y9+9BE2IlXrBNpA3TrM=;
 b=Nnhm+pq7UUeaFAxXBIjUhnW4pJUXUsRu5cxmyruWP36C7gy2+iyzc1Xmh1bswgfwh0t88r7ocnsY7fYnznNeqVs22Xtedoh+U1t7Wrt4h1GDiNqdTmyI0heCkMtht5BnkBSMFCthzAwGljzmFlt2HBvDSnxu6PN35Uro+pEFVRE=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by PH0PR18MB5072.namprd18.prod.outlook.com (2603:10b6:510:16c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 06:02:27 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 06:02:27 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: MD Danish Anwar <danishanwar@ti.com>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Roger
 Quadros <rogerq@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "srk@ti.com" <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: RE: [EXTERNAL] [PATCH net-next v3] net: ti: icssg-prueth: Split out
 common object into module
Thread-Topic: [EXTERNAL] [PATCH net-next v3] net: ti: icssg-prueth: Split out
 common object into module
Thread-Index: AQHa1FQURN+agENc/kaUevnfzJpFObH0VPpAgABozICAApIDAA==
Date: Mon, 15 Jul 2024 06:02:27 +0000
Message-ID: 
 <BY3PR18MB47074FAABD900C79FFB0BDACA0A12@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240712120636.814564-1-danishanwar@ti.com>
 <BY3PR18MB4707DE9F8280CE67EDF3D146A0A72@BY3PR18MB4707.namprd18.prod.outlook.com>
 <8ef9cb0a-9e0a-4f2e-8799-546ce2be63a7@lunn.ch>
In-Reply-To: <8ef9cb0a-9e0a-4f2e-8799-546ce2be63a7@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|PH0PR18MB5072:EE_
x-ms-office365-filtering-correlation-id: c8d07b10-dbe6-4800-a580-08dca493b44c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?eWtzUXNvL3Z2UzFSWStIZXZwZlJFOU1ROTFaUWlnMEhaOEpVT1VZV0sxdUpm?=
 =?utf-8?B?bGlLdkVqUUsrLytQaXV6YlZCRkhrUWJnMVZvMDM5TW13MlBRcWlaRGM5WHl5?=
 =?utf-8?B?VGJpRG5HNWcvSXpMbXB4MFdvOFhmaFc5S0F1QmV3U2JmeUd5WGdCVWlUQVI0?=
 =?utf-8?B?ck1wNEJEVWYwM2t6TW0xQWVoYi9hWS9PQVZIbXlEQmE5d1ZBVnZMRkZUK01y?=
 =?utf-8?B?OGdFL09Yek11RGlsTkhBUGJGMVByRmJBcy9MQ0VXYS8yVXI2Zm8xVzBvb2xn?=
 =?utf-8?B?dUIvS0VUTnMxMEIvbHZDd1oxVjg3dStPekoyUmxId0VOelM0VjlkdVFtbDhz?=
 =?utf-8?B?VEJrODZKK3VxUzFmQzRIbnZxV3hISFhHakowamJiOGVIY3h1WkwxSzQvclAr?=
 =?utf-8?B?aVR6QjhjTkJacU12Q056YW5oSm5XZUQxYnRFT3lXM1ZEbllUZGRmZTBSRWFH?=
 =?utf-8?B?VTYvK282VzFCZ3VaQmhnOTJ4Z0ZMYjM2dU42Q01ld1RCa0luMFVLSERoZVBk?=
 =?utf-8?B?ZXlRWmFDRkJtSVQzMCtoWTZMNnpJVlR6cXFUOU8vV3d0R1FnOUtvSDI4anBE?=
 =?utf-8?B?a0l5MndnV25BY0hHZHRpaGtZc3NNQm5GZEJvRmQzSU94WC9JeEJRQ2V4aGVO?=
 =?utf-8?B?SEdobUQ5RmZSTUQ3NkczNDUrcHJyZjhMY0RBZkNiUW9BbWxuTGx1T2k4Q01t?=
 =?utf-8?B?NGc1cnArdFJuRzh3MDlERHcrUjE1NStHS3pQUzIwL2R6TzFKSVB2b0IxWUIx?=
 =?utf-8?B?K0g2anN6T3R4R1lBUE0rZ0pLYm13RkVUVkd4RUhJTCtTbW9XTVV2L0txQTcr?=
 =?utf-8?B?OWErZC9rbmlyVFR3c1FYNGNvWlR5dDdHK3o3MjhiRlk5aFRPUzJMbUxrV2Zr?=
 =?utf-8?B?ZTFvVVlMczJLd0N4WlpnSklpTTBVY0RjSWhMbFphOHZIa29Hdlh5TjdIalAz?=
 =?utf-8?B?clRoeG1LQVMwODN5SmI2UHNCUWpteTF5SVRzOVJTMlZ1V1l5RjBEQ1o3WHlG?=
 =?utf-8?B?enNYNXUyWGZnc2RHdXQvYTdwWEZiVW1Da2N5NzhvbFlxMC9Wa2ovZEpxZDd1?=
 =?utf-8?B?NmNVZWFSZWVyOTNrVEZNRE9vM3JDRXcwS2NJN3ZwUmRwMkZKVi9tb3hXQlVM?=
 =?utf-8?B?dlpIQXBNeURIRVZVWnlONUJYa1NPQWR0K0xPR3UrbklzNHVxdlhZVjFUM2xF?=
 =?utf-8?B?SUMvVzAzYWJVaWRhbkdHdy8zU25PeEZNQXVQOVNNYnNQWU9ZMDdTVGFkRVEr?=
 =?utf-8?B?SThNSmErRm5LejNUdlp0VERiM2pmNUJ6WHJKZGNvUWxLWW5ZdmhEdXVPcm9M?=
 =?utf-8?B?Z2x3eHN0Sisxdk5idXNtRW1RRjJGaE5RM29nMDQ4RGRhcnEvQWFlVjl1VGpL?=
 =?utf-8?B?emVIYzFpWkU1SWx6TmkwbDNWZW1Vb3RhNHY4MU9DZWRKTFdvRFNtelZuYXdO?=
 =?utf-8?B?VWJLditYWjdFMHQyaGVqbm9GNGRSQjhhUFh3SFVWckhlaGkxLzY2Y09mTm1h?=
 =?utf-8?B?R3ZabVBqSXlBdGdQUVlzVmcyZXhUdTR3bkxUUzRQWjNZY0VlVVc5YlBISDRj?=
 =?utf-8?B?Mlc4Ynh5UUl1bk5WS0IycU03RjllYW1QQVM1ZUtSY3FjcmlvVG9obGpFbzZP?=
 =?utf-8?B?R3lPdkhpT3BUK0JPQjFycFRwOXJLZE1lNXc2ZlpPWkFITWNMSCs3RmRPWEJp?=
 =?utf-8?B?OHprSjN6VGJNdU5BUGlyOTh3cGFwTTQrUGU1WnFuNHErSlQvSVhiZTlQYzJ2?=
 =?utf-8?B?SXp3dDYza0ZVbFVESW45b0hqN09rdUxRVFQxOEV5UWpVK2JnaVZqYmhNVzJv?=
 =?utf-8?Q?cTFs6MYrgu4wDNFsOmigkopiIYNoHSt0NLJOU=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TXZubEhVYjNnWThWT3NSUGkxWm9lSlpLc3J4L280VUNmN1kyNlJPUnFBVEZ3?=
 =?utf-8?B?dnV0TEZycFo3L2JCc1FHVzE2eHpqNjRTdXYwUy8xK0sza0x5QU5iSHpidjR6?=
 =?utf-8?B?UTc5a1RrOEw1ZG5PM1VuUTBVM3k5WVRxVTJENlFYb1NLR3dGekh0VEtoWGc3?=
 =?utf-8?B?bFpaemVDTHZUbEM0RmZ0VkR2aTdKa3VZVVI5TG1UK3A2bDZmSzR2cDlVcUhM?=
 =?utf-8?B?RG93Z1gyakRkUmpocll5U3ZsdnZETW1TUHlTRjdwU09HUzlpdmhuL242YUNU?=
 =?utf-8?B?K0hGbC9OWnpENXVHTkhBMzdxKzJPUytGdVR4ZHdra1ZBMC9UeXFBQW94T3dp?=
 =?utf-8?B?eURxVFQwd0xzemUwZHpDeXdmOXNyYWFLT2dyYWg0WGVvbStGTlljbVVyT3Uz?=
 =?utf-8?B?ekFKc1NFSGdKMTdkZ3A0eEFDLy81MTlBU1ZsMXNNeXJBbThZOHF3bnFzOWZS?=
 =?utf-8?B?eVdaUVc0RUxMck4rZ2pld2RJS3VGdkFVc1RNWjFLNzFSYTBGNGRwQXI5U0Zk?=
 =?utf-8?B?a3pmcVB2aS9sanN6M1BXNURaQnFJRE85eTBWUTJIRHVhcGFTNS9Pblo4SkhL?=
 =?utf-8?B?Ujl3Y3ZoSmZickthblNubzIwSDhicVlMamp6L1pzTU91TVBTd0ZLZ0Z2OUNa?=
 =?utf-8?B?b2kwNUNZVlhscFpsSkVyWkZXZmNZOHR6WnBvY0xaSk0welNDWWVvVG5VRzls?=
 =?utf-8?B?UkxWNERRYURtcGxsMFdzTjRhZmZmWFhzRy9wZzVoU1BnaWROSHFDRzIxU2t2?=
 =?utf-8?B?dmJKbHVWa0hqR0Z5aC9vTm1SMDZSZjFCRXQ3Yk5kY3EzaENBekZoS01FOE51?=
 =?utf-8?B?SThpRE5IeDgyL1JvWXJSK2J3QlNvZEZadFFnL0xHb1JBYU1qaFRiaHE2ck1w?=
 =?utf-8?B?Wm9SVlpKWlBuYng1c0lPUmNVVmR5NmxJZDN1QlZOTWVoTEpIZTJGOVo5NVBp?=
 =?utf-8?B?Yjk2WHM3S2JxU1YxUFhXS25ZUTU5aDJCQm5veW5rLzM0UU15YVUxS01pb1Vq?=
 =?utf-8?B?RnJIUEVVcXd0STZVY1lQVVU1OXRsTnVzczlLaUNhSUZ5ZHpzTWROenBLQWVQ?=
 =?utf-8?B?WUlMdG80RVFnMXc3eGd0cGJKeUhXM2ZmcjRTUCtaNk0vL0ZtbkliNDA0OHZT?=
 =?utf-8?B?YTRncnpWSGZXZGZqZERwblNmR0N5Q3ZrUWpFK21PMGhabjc5UmRUNFRPQmpP?=
 =?utf-8?B?di8rYzNRYmkyQ25JOWJWS2QzRnFNdnNMN2NudThCU2s5eFZsVmxCai9hdU0w?=
 =?utf-8?B?V1I3TVRuNTVyZm13TEFCMjZURXFHVVVJdUNjSGxkQW8wQ2J5VHJmaXEzV2w3?=
 =?utf-8?B?aDhMNnI4WDljRndVQ0IzTk5DTFphbGVkZDBZOTF3SkdDaTFNZktkR0J1c2cw?=
 =?utf-8?B?NTZlNXdrbFRqY2RBaGNVcDEwWG1jSS83aGhTSXNlSWZQVmFZUTNCL2lpWnRx?=
 =?utf-8?B?VklJcnU4VEYyZS9yMk8wVUkwQ3hUb2pJcVdoRVA5ZmVXZHFIeS8zTVBxNEpu?=
 =?utf-8?B?UTVZUGE4ZHhtVThXZ2JQQ2piU2RkZW9oelRqbjZIQ3QzRVR4UjE3ZDU0bkl3?=
 =?utf-8?B?VWdJTkNRRVozV2NPYW5JYVlkOFVsRFRodTJsL0lBRkVqN3BKOGpucThTb0dQ?=
 =?utf-8?B?aE13SjVLK2htbzlPUTFsVUhtY1BpUEVCVjI1MnJZa1dUYk4rOFJEWVZobW5k?=
 =?utf-8?B?eUw0dHJGSkllL25oSUtDb1FvZUlicGlTWU9qYU15Mnd3QzFnTThnVjl3NC9U?=
 =?utf-8?B?TmlFT2duUGdEMFVhNnJBRzkzWVh0ZEZGQms1M05Ma3c2djEza0lueUZlRFVR?=
 =?utf-8?B?YXd5SXVsajNOUGo1SE5yejZvcWFpZHU0eHByY3paQVBmR0U5RmRNNVJWU3ZD?=
 =?utf-8?B?ZlloVjVhQ0dvN0hoVUxyTHMwU0NrSGw0ZmM5VWxwclUzRmNPVkJCSnVZOGJI?=
 =?utf-8?B?eElPZG9yOEkwRFBCenZxSU1ZcUVzcHpLc29wVjhBdjVXSTV2WmhtekVGSmlk?=
 =?utf-8?B?NUJiRnZ5RlJpeGlTNUQ1NXIwYkQzR2tYMWpGbk9ZYzBNYVNWT0hpRWxSdVBG?=
 =?utf-8?B?dkhXZy9nazBMOVJqMHU5M09YZzlUMlhuS2tLN0NXRG5EK2RhZVhic2V1Qnhj?=
 =?utf-8?Q?vzZZstRtftUMDBFPPF1NgC0Zt?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d07b10-dbe6-4800-a580-08dca493b44c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 06:02:27.1312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXCUODIzSy1Ham/B9MzbLAQzWFGfVniDIINiL3C7986rrfzVLSuAfFXvvdV7CQJHdoJmr9F6qlKylRO2yUeQYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5072
X-Proofpoint-ORIG-GUID: RUuFVvq3AcISRR7fkyxrvi4Vipzg4ZNl
X-Proofpoint-GUID: RUuFVvq3AcISRR7fkyxrvi4Vipzg4ZNl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_02,2024-07-11_01,2024-05-17_01


> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Saturday, July 13, 2024 8:15 PM
> To: Sai Krishna Gajula <saikrishnag@marvell.com>
> Cc: MD Danish Anwar <danishanwar@ti.com>; Heiner Kallweit
> <hkallweit1@gmail.com>; Simon Horman <horms@kernel.org>; Dan
> Carpenter <dan.carpenter@linaro.org>; Jan Kiszka
> <jan.kiszka@siemens.com>; Wolfram Sang <wsa+renesas@sang-
> engineering.com>; Diogo Ivo <diogo.ivo@siemens.com>; Roger Quadros
> <rogerq@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Jakub Kicinski
> <kuba@kernel.org>; Eric Dumazet <edumazet@google.com>; David S. Miller
> <davem@davemloft.net>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org; srk@ti.com; Vignesh
> Raghavendra <vigneshr@ti.com>; Thorsten Leemhuis <linux@leemhuis.info>
> Subject: Re: [EXTERNAL] [PATCH net-next v3] net: ti: icssg-prueth: Split =
out
> common object into module
>=20
> On Sat, Jul 13, 2024 at 08:=E2=80=8A33:=E2=80=8A42AM +0000, Sai Krishna G=
ajula wrote: > > -----
> Original Message----- > > From: MD Danish Anwar <danishanwar@=E2=80=8Ati.=
=E2=80=8Acom> >
> > Sent: Friday, July 12, 2024 5:=E2=80=8A37 PM > > To: Heiner Kallweit
>=20
> On Sat, Jul 13, 2024 at 08:33:42AM +0000, Sai Krishna Gajula wrote:
> > > -----Original Message-----
> > > From: MD Danish Anwar <danishanwar@ti.com>
> > > Sent: Friday, July 12, 2024 5:37 PM
> > > To: Heiner Kallweit <hkallweit1@gmail.com>; Simon Horman
> > > <horms@kernel.org>; Dan Carpenter <dan.carpenter@linaro.org>; Jan
> > > Kiszka <jan.kiszka@siemens.com>; Wolfram Sang <wsa+renesas@sang-
> > > engineering.com>; Diogo Ivo <diogo.ivo@siemens.com>; Andrew Lunn
> > > <andrew@lunn.ch>; Roger Quadros <rogerq@kernel.org>; MD Danish
> Anwar
> > > <danishanwar@ti.com>; Paolo Abeni <pabeni@redhat.com>; Jakub
> > > Kicinski <kuba@kernel.org>; Eric Dumazet <edumazet@google.com>;
> > > David S. Miller <davem@davemloft.net>
> > > Cc: linux-arm-kernel@lists.infradead.org;
> > > linux-kernel@vger.kernel.org; netdev@vger.kernel.org; srk@ti.com;
> > > Vignesh Raghavendra <vigneshr@ti.com>; Thorsten Leemhuis
> > > <linux@leemhuis.info>
> > > Subject: [EXTERNAL] [PATCH net-next v3] net: ti: icssg-prueth: Split
> > > out common object into module
> > >
> > > icssg_prueth.=E2=80=8Ac and icssg_prueth_sr1.=E2=80=8Ac drivers use m=
ultiple common .c
> files.
> > > These common objects are getting added to multiple modules. As a
> > > result when both drivers are enabled in .config, below warning is see=
n.
> > > drivers/net/ethernet/ti/Makefile:
> > > icssg_prueth.c and icssg_prueth_sr1.c drivers use multiple common .c
> files.
> > > These common objects are getting added to multiple modules. As a
> > > result when both drivers are enabled in .config, below warning is see=
n.
> > >
> > > drivers/net/ethernet/ti/Makefile: icssg/icssg_common.o is added to
> > > multiple
> > > modules: icssg-prueth icssg-prueth-sr1
> > > drivers/net/ethernet/ti/Makefile: icssg/icssg_classifier.o is added
> > > to multiple
> > > modules: icssg-prueth icssg-prueth-sr1
> > > drivers/net/ethernet/ti/Makefile: icssg/icssg_config.o is added to
> > > multiple
> > > modules: icssg-prueth icssg-prueth-sr1
> > > drivers/net/ethernet/ti/Makefile: icssg/icssg_mii_cfg.o is added to
> > > multiple
> > > modules: icssg-prueth icssg-prueth-sr1
> > > drivers/net/ethernet/ti/Makefile: icssg/icssg_stats.o is added to
> > > multiple
> > > modules: icssg-prueth icssg-prueth-sr1
> > > drivers/net/ethernet/ti/Makefile: icssg/icssg_ethtool.o is added to
> > > multiple
> > > modules: icssg-prueth icssg-prueth-sr1
> > >
> > > Fix this by building a new module (icssg.o) for all the common object=
s.
> > > Both the driver can then depend on this common module.
> > >
> > > Some APIs being exported have emac_ as the prefix which may result
> > > into confusion with other existing APIs with emac_ prefix, to avoid
> > > confusion, rename the APIs being exported with emac_ to icssg_ prefix.
> > >
> > > This also fixes below error seen when both drivers are built.
> > > ERROR: modpost: "icssg_queue_pop"
> > > [drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!
> > > ERROR: modpost: "icssg_queue_push"
> > > [drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!
> > >
> > > Reported-and-tested-by: Thorsten Leemhuis <linux@leemhuis.info>
> > > Closes: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> > <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-  >> >
> > 3A__lore.kernel.org_oe-2Dkbuild-2Dall_202405182038.ncf1mL7Z-2Dlkp-
> > > 40intel.com_&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3Dc3MsgrR-U-
> > > HFhmFd6R4MWRZG-8QeikJn5PkjqMTpBSg&m=3DnS910f-bVPllINeciu3zcX-
> > > RmmuaN-hU--Y3YDvgknBD5A8sRk6hE3pZSocV-
> > > 37f&s=3DsIjxhBrYXEW3mtC1p8o5MaV-xpJ3n16Ct0mRhE52PCQ&e=3D
> > > Fixes: 487f7323f39a ("net: ti: icssg-prueth: Add helper functions to
> > > configure
> > > FDB")
> > > Reviewed-by: Roger Quadros <rogerq@kernel.org>
> > > Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> > > ---
> > > Cc: Thorsten Leemhuis <linux@leemhuis.info>
>=20
> > > base-commit: 2146b7dd354c2a1384381ca3cd5751bfff6137d6
> > > --
> > > 2.34.1
> > >
> > Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
>=20
> Please trim emails when replying.
>=20
> If you look what everybody else does with tags like this, they place it d=
irectly
> after the Signed-off-by: and delete the actual patch.

Sure Andrew,  thanks for the suggestion.

>=20
>    Andrew

