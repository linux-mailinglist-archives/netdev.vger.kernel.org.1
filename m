Return-Path: <netdev+bounces-166404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F92A35EF2
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 751CF7A10BC
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF27B263F4B;
	Fri, 14 Feb 2025 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DxLLTYpV";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NTwIDhcQ"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCB226462F;
	Fri, 14 Feb 2025 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539559; cv=fail; b=UEP2/qsPM1oYwGByBm3Bua2C1qdjb5T1AXxtfp0veCf4l+zigx7ZhKVrRxNkeOhGxzwipa4NuW3BnEo6GtZnxKH94J51T3BFioEvYsVI4DEt0lSVTyd+MisSmJMu7EtE9p+cYhjhw3iUizhHTtSOAHP2EPIMjaVNV81oTZF5NzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539559; c=relaxed/simple;
	bh=921dsssOoZNQuvlcHimOmvlv87DLdG1If6E84zld+Sc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iR2CoudAxbaoqu6NhA1+NSLZOsS1cVEGOZZeDWIA9Ng3BNZ3uLWfdstKdS1S755q3PjK1QfUI2IBbmK6RCbXWBYSJAzgFrB10gpYPPZhOXdG4sp9pKImn+Jpd3lng6I6/sHO3Yu0iREKm/Rfa3Sp+1p287IPD7pdlpM+FhveR4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DxLLTYpV; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=NTwIDhcQ; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 36e59c02ead711efbd192953cf12861f-20250214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=921dsssOoZNQuvlcHimOmvlv87DLdG1If6E84zld+Sc=;
	b=DxLLTYpVM0umA0mbBIC9mdYMmsdJ1eA5TQASdr0WeNtFRtV/7kGvJcEvzc5qoQoPb7gqdBdg8+Y7c78neLBvIy6SY15NeIrKpliOMRIzqazWLixw4oELGmnXIWQLV7CkV7y7tBOiZmuyomCiV5qBk0GuTrZTpTTvMS3QtoCw4MU=;
X-CID-CACHE: Type:Local,Time:202502142113+08,HitQuantity:4
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:af809f70-1d38-4986-937e-d6e1ee21f78e,IP:0,U
	RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:2
X-CID-META: VersionHash:60aa074,CLOUDID:39155bfc-7800-43c5-b97b-ddbe32561a5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 36e59c02ead711efbd192953cf12861f-20250214
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 312671472; Fri, 14 Feb 2025 21:25:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Feb 2025 21:25:51 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Feb 2025 21:25:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykda/0Uu7qx5MYtUlWWApMr7AZ/CP0Pp7mFjISI41WqMO3gRLBY7P5UpLCZHSEJ/DsJJQu8lm/LDn7VfFdUWGLuVeHelj5e8LFeV/NTJULagu+ESJ/P+doyqi4qwuNPz/JSJ95o7jnTz5s0xVmTNg8+Z83scyWFUwsegjnDpHoh5w5Xx6Frel1TG7OncgxQ94mefuUxFieA/zfQNWPwm5IZxVulDXEkcCGnQrdAKmTouFQT1w21og1/CvzK0OiQZyb29XVxvrPD7ctFrai5SWGBG8tlYzR7+B+hH8q2vt1OY2+quw8s5dLVJ2IHNKXqo8iZC1CIoObdOBTW9pGSmjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=921dsssOoZNQuvlcHimOmvlv87DLdG1If6E84zld+Sc=;
 b=udDNzv1VcGjJkvTWXwGp/WM1uiD4/ZDt0aZG1rBazxouO8qRBwbGVRhGdcirQqgB/U7oxyeQPkZGOLWUWzPqIYYVXYO7Dj+gtfBTDHwIpzuRiki1tigfq8j9DdAKA6wbz9tRd7jTZbeNpWWNTko2WtwquKgAjE9s39Sgulj1xKnZE1ud1Q8UDP7bA4X7Dxckr0qezbTpcdi4AD78cP8Nq3jlmKCEk+yhrG5SQBUarD3UgQiOJFr8Yg5kJF9y60xNoTux3k2jY/xB1as5mXc4rV7RZ/smsvGaM2qAlOksinxkw1E3DjK3k98joSrFCda0dCOq2fAjxHsEfHUYv3vtNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=921dsssOoZNQuvlcHimOmvlv87DLdG1If6E84zld+Sc=;
 b=NTwIDhcQyonaoRl1mvPCH4FYbDoGJev1aWzEBPuapVDpsJhP1O0GTPO3GOXx4yRKxZqLV36Zjs6ow/GfDs5rfW3kfXGQ+vlDavp133XFQ5Kouv6Cx6h1oqOjDa5BzKI20ypfd3N8eCqjB48Wtk3/hOBgsChbOChmwovmZcyBPCk=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by OSQPR03MB8599.apcprd03.prod.outlook.com (2603:1096:604:297::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 13:25:49 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 13:25:49 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH net-next 3/3] net: phy: mediatek: add driver for built-in
 2.5G ethernet PHY on MT7988
Thread-Topic: [PATCH net-next 3/3] net: phy: mediatek: add driver for built-in
 2.5G ethernet PHY on MT7988
Thread-Index: AQHbZ7WXaWwg6/r4eESVGpzWtCL1+LMeYJgAgCiX5wA=
Date: Fri, 14 Feb 2025 13:25:49 +0000
Message-ID: <2f0638583f9856499664659b5748056aa5f027c8.camel@mediatek.com>
References: <20250116012159.3816135-1-SkyLake.Huang@mediatek.com>
	 <20250116012159.3816135-4-SkyLake.Huang@mediatek.com>
	 <df67baa5-0f3d-4a42-a327-00452787908a@lunn.ch>
In-Reply-To: <df67baa5-0f3d-4a42-a327-00452787908a@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|OSQPR03MB8599:EE_
x-ms-office365-filtering-correlation-id: dd0f52d0-822a-4e84-64da-08dd4cfb18fa
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Ymo0aEUxeGZqSXdLZTJ6ZGpnSFozMEZ2YVpURmg0eEFTN0hZZWozQnhXS3RO?=
 =?utf-8?B?SzFEcXhMZTFmVzVwcWtEUnRhRDE3Q0k0STcva1VRUkw4cEVZZ3E1RDZFaW9l?=
 =?utf-8?B?OG05b1Rra1Qwck1MaTBkRWx5bU9VMFJ5d0FQV1U4SFlDamk0SHZHYlhPVllo?=
 =?utf-8?B?VW5jVm03QVBSMVgwbVJqM3hocHlzUlVxbVpMWXgybmxNbk13b0F6Y0tZK2k0?=
 =?utf-8?B?RWFEK3dDLzlLUUx2enBWVFcySFhuR2tzOEpaWTdyOXN2bHd5UWFrZFFkS0E3?=
 =?utf-8?B?MFRtdzRESDZyUys4KzV6WXl5NmlEb01HVFNmZkx5Lzl4T0NaZFMwVnpwZTlO?=
 =?utf-8?B?bW9RcWxzTEoyY1pkL2xNOGJvSjRjWU0vOHRwSk90QnRrRlNXdXovVXNxaDNn?=
 =?utf-8?B?azQ4eVljR0RUam1IUXJpRmNYZ09ieXNrWXN1V0l0WGxJT244bUExRWFONEZl?=
 =?utf-8?B?bThSYjJEbFd3eVlCY2pnaGRDRG9pcWs4NUVGSnV1ZzFHbTJmYmFuOUlYU2ls?=
 =?utf-8?B?UW91enQ0RjlrUEgzSTRMNFVENWZEQkhndnpHR0pVT0NYd0VzcVk5Zk9UWlN6?=
 =?utf-8?B?L0R0Z2s3R3EyeGljRWNjM1V3QVdWVU5WTGNqc2RmL1dxbjF3ejNLUEJrbDZq?=
 =?utf-8?B?MHpVejFBNVIwQkU1T3JwUFNZdHdNYmhBN3BmSVoxdTBmTUw0NUdMc053RzJv?=
 =?utf-8?B?VVRFWWI4cWZEUFpMR3BCOUZqUHR2aUJNdSt4K0Jwc3hyaCtJcnVHS1I4WHo5?=
 =?utf-8?B?elJsWm8rMHhnZHhibWd1ZXhpcTdLeWVpOTBqWWdFVCt3aVhzd3JKRlFLdG5y?=
 =?utf-8?B?NnRpMVd6TUxZaTdkakN4cVV2eDdZb2FYeFlDcDJzR3dvSGl2MnhOVFdZc3FF?=
 =?utf-8?B?aW5LaFBuNnovbnRNQzB2cWtUeW1LQ2JWV1dickpuR2pmVUJvT3BPRXcyVWJ1?=
 =?utf-8?B?bXhQaER2YmRCL0NGNVJRUG9JTU0vaGRZMGZTaUt0czNmQzlCMTg4MFV3NVJm?=
 =?utf-8?B?Z2xBMHV1MW5icjNxYVFQeC91RXBTbThJeU96aHlVYkxld3pPbWZjczV0bmFR?=
 =?utf-8?B?U2lrQWc5NXNsU1ZydzZudWJRdWozRkRLY3pHSlVaUDBGQVE5QzY0QkxNd0ZM?=
 =?utf-8?B?QzV6aHhGVDlTKzZtUzVXM3l0SnV0dFUraVMvUVdVWkZMd3FRT2VMWTl4Tk9D?=
 =?utf-8?B?R1MrY0VFMTVOQkVjL0t2TWx0aW54bG15MUZMZVlEdHlkSTJVa1cxVE93VWo2?=
 =?utf-8?B?SkNBK0pwK1ZoRFdYdkpSS2gxTTN5eG0rS3JUbTdiTXJHUTZxTFppN0VXSmRG?=
 =?utf-8?B?RG10VGtwTnhSOG80eE9HbGlPZ1NFZUx0RnZvd09zbDJsSmdFVXNTTy85MmJn?=
 =?utf-8?B?REtXNFRDNlhjTDhTMFIvZkpIdkNad1RhV2RFWjIwNHhCTjIzejNIL2lNOFZJ?=
 =?utf-8?B?VFNtOHZjcWVhRmVkaE5QOTdMd0lLY0JoTE4wZk1kMEt3SllYbzBlNW9LdU00?=
 =?utf-8?B?WkZOaWdsZXQ1QWsreXgxNnhTT2V1SnVoSWFBMStZV2dGS21ZNjZuOGhOeGpC?=
 =?utf-8?B?UGwvVk9LMi9ORWxWN3kwK0tHSDhYem1OTXJCRTJEVmlsVjFnSTExb0M4c3Ry?=
 =?utf-8?B?RVJoNUZwakxPbmtHWW1EaEI0WnVtSENmakR1KzROZitHMWNvUldwRTdlSXBm?=
 =?utf-8?B?UmhFWWlhR3hEQzYzdTNVcDk2RUEvWmxjK2ovOHpnRE0yZEE0eFMrZ1ZCbzcx?=
 =?utf-8?B?KzAzamxVRmRQTmV5ajBqY21yaDRid25YejFNQkg3SSs0ZklFTFI0ZEQ5cUt0?=
 =?utf-8?B?S09odW1uUmIwemdBa2VIRnZDbFlOYnFENkZtaEQ5S2owYUhuSnUzbTBhUmZS?=
 =?utf-8?B?QlVSWitSWmZtTUJqS3BDTHVXdE5oREJUaDEzeUhRUkdSSFBxOW9tK0VWSDZp?=
 =?utf-8?Q?ZNLOUewQa/p1ltnv72TfAEq4NZqYRKIq?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmFlbndiYmRqKzZsWCtGNjBveFNZRjJ1OVl2WTdqaVgzWElxdGZNOW1aa0o1?=
 =?utf-8?B?MjNPUjRHak9FcGc5MHE0OS91azAzayttOE5HbTZ4Z3dlM3Z4OEpkb200YXgr?=
 =?utf-8?B?TEE1WDNHekhONkVDejJheGRRRnB0dlBSLzUrK0Q5cjNURGd3eENWMXQ3N1hT?=
 =?utf-8?B?dUFmd3FUTmlaVExYWjdDRXFreEU0ZHI0WmZYYWZZTmRjMmZvRVdUclFESlk4?=
 =?utf-8?B?M055MTBRNkRzWHVESExlVCtLa1FKQ000TFNHK2k3RE1mUW1GaWkyQmQ2dFE4?=
 =?utf-8?B?Ukpkb01lcjZXNU54VVZVRVpmMmRQWmx0QWYrYUwza0o3RVdXMk94WHVhRU9K?=
 =?utf-8?B?eW55UFJkdEZ0MWtPdGZwU2pIWmgrb2tkS21DMXVDSEl4UnpWTmZUa0hFWEZa?=
 =?utf-8?B?dVZ2aUMwVkd4a1E0QTd6VlJPeXVTVGpUTXlsdTRiY25xL1g4cTRJZWxCYkQv?=
 =?utf-8?B?UFNJSVFId05UNjBWQUFGdDlab0JBekROWHlYOE42MDNtMmNjZzdLeGpxckph?=
 =?utf-8?B?eGw2RTNzWndvS0xTR1JGeStMWlpXMjZrR1dhdnhRY0hZTDBxY2RkbEx0cmF3?=
 =?utf-8?B?TFBoSTlCRzVmSndjcVQ0QURaaTEwaFN6enpvdkxKZm16RzZVbVNsQ2poVXI4?=
 =?utf-8?B?T3N5ZEVTWTdXdzBWTDR0UGxSampoMzE3TWIvVENXenYwV2tEUEVUclVXSFBC?=
 =?utf-8?B?OXlhb3k1dUpaUWhsaHdHWWo3bWgzcFlYUXNud05jQ3plSnpZQWVSY05rVzd1?=
 =?utf-8?B?dlpiRXNxYWYrQVZ3dzZrS1JpTmdVdnA4ajR5NzhOelIvTVZWU3pJYzdvZC9h?=
 =?utf-8?B?NTlZQWd3a2xxbjFaK3llQ09uV0o4ZllhWnRzVXAxL3hXWkZ5OUpnUVd3L3JF?=
 =?utf-8?B?SnMrM3hEelBzN0xGU0ZuRndxL1BFbUdjREMwVmtJUjArdFBtc2pXa0dKUWUw?=
 =?utf-8?B?OXBjbnlaMzJsdG5FYzBmLzJYVXUyOXJhVEJrdnFHME42UFdTNHBJVlBZR2g2?=
 =?utf-8?B?eHcxVDRVQytpVGJ5VHllTXNMa3VZSVVMdnVrck95bkZPbWFvVWlhVS9aam55?=
 =?utf-8?B?czRVMktuZUNZNTV3ek5rNURIR0phQlNvN1pZbGFEbkl4RSs0UU1KcVNmL2Rj?=
 =?utf-8?B?Vkk0VTFzdGgyVGFGaU5vSkpLU3pDM29TS2ZJOCtPYmpybDAwZ0VLQXMxMkRM?=
 =?utf-8?B?bUliRnpzY3Q3QU5ibW9kbG9uMThXOUhsS1YxN0JDbGx4TEhKOWRCSEhqRFVG?=
 =?utf-8?B?Rk5Xa0JIelBJZUNOVnVWbnBvK0UrcjR1MFdMODkwdmRETU41aCtaTUhoR3h5?=
 =?utf-8?B?alVPaVNOM0JKYzkvZHgveGxZakhGcVdSOWNuQmhCRVUxOVJNQktnWjd6dGk1?=
 =?utf-8?B?RE03Nzh6N2g0ZWRxOEM4VnJ0QS9ieHUrSS9mWnFKbFppTmpmWUQ4NzJ1S1Zn?=
 =?utf-8?B?MGFrOUNQcDBoMllkRmR5N0NDMGVRVTdCeENUZGx5OGhXUmY5Um5GbkFQR2Nn?=
 =?utf-8?B?c3VQV0FRa1JqS01wWXM2clV1WEhmaXNTR2hyRXp6UEhRdmgvdEtuYzBNbmpw?=
 =?utf-8?B?TnBONzRPajlncjhQOWpKVjM5MDRZQVVCazNoOVBmbDFhQWRYTndBbW9YNU9Y?=
 =?utf-8?B?T0E0VEFpcHc3SVJRNnJjS0lRN2dlTjFjWlNnZnZBNFpUYTBRZVp1Wi9RV2Jv?=
 =?utf-8?B?dDB0M2FvYmIxdEVQOXBkNkFCUXhqK0Y2NU0xL3V6alRNZnFvajVaa2tpc1cr?=
 =?utf-8?B?TzY3SWtFMU92blU0MlV1MWh3SVlUQlFtRTdIOUJCK3ZXZDQvdi9WbXNpNXZa?=
 =?utf-8?B?RnRESXBqWitCNGlFaVBRaGg1NVJKZjQ1MjJMQmJSOXJjMkhoUzhOZitkTFFy?=
 =?utf-8?B?dEN1YXBMb0JYY2YrMzR5dENQVE1oUzlYa2dpVmZrcXIvdmMrSGtHZ3hUTHFh?=
 =?utf-8?B?YmpPblBIbitiYzFIeGJtSGM2Nk9ITXQ5M0RYTDhqMkNxYkhuN0dGVENYeWxv?=
 =?utf-8?B?RHNnaktrS0pDd0w0d2tVTVlVN1p5UGUxcTVsanJ4SHpPUlRRcU84cEE4ZkpL?=
 =?utf-8?B?ajB1UFBIMDNsdXVGcjdSdFpITnFmQTY1VmU1WGRuS0FqYXF3NE5wazlnb3pI?=
 =?utf-8?B?WGNMWUdhR3ZPbEFnSXpXM2ZrNWl1cUNNNVM0S0VpN0tPSmdNcjUzNTd4OGgy?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEB6C00C23B0EA4C9109CE82F8081FAD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0f52d0-822a-4e84-64da-08dd4cfb18fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 13:25:49.5625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TMdnKTsNdLV11ydBqtajr3g2MSO/+D51U/lIXXResakipgO/sj0YJzZE5/F92KdZJFp7yUCfrHYV78/WQCXe/Um+p7X7kJGvmT8y4G2mQ4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8599

T24gU3VuLCAyMDI1LTAxLTE5IGF0IDE4OjMxICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToKPiAK
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbAo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuCj4gCj4gCj4gPiArwqDCoMKgwqAgbnAgPSBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxM
LCBOVUxMLCAibWVkaWF0ZWssMnA1Z3BoeS0KPiA+IGZ3Iik7Cj4gPiArwqDCoMKgwqAgaWYgKCFu
cCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9FTlQ7Cj4gCj4gVGhl
IGRldmljZSB0cmVlIGJpbmRpbmcgbmVlZCBkb2N1bWVudGluZy4KPiAKPiA+ICvCoMKgwqDCoCAv
KiBXcml0ZSBtYWdpYyBudW1iZXIgdG8gc2FmZWx5IHN0YWxsIE1DVSAqLwo+ID4gK8KgwqDCoMKg
IHBoeV93cml0ZV9tbWQocGh5ZGV2LCBNRElPX01NRF9WRU5EMSwgMHg4MDBlLCAweDExMDApOwo+
ID4gK8KgwqDCoMKgIHBoeV93cml0ZV9tbWQocGh5ZGV2LCBNRElPX01NRF9WRU5EMSwgMHg4MDBm
LCAweDAwZGYpOwo+IAo+IDB4MTEwMCBhbmQgMHgwMGRmIGFyZSBtYWdpYyBudW1iZXJzLCBiaXQg
MHg4MDBlIGFuZCAweDgwMGYgYXJlCj4gbm90LiBQbGVhc2UgYWRkICNkZWZpbmVzLgo+IAo+IAo+
ID4gKwo+ID4gK8KgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBNVDc5ODhfMlA1R0VfUE1CX0ZXX1NJ
WkUgLSAxOyBpICs9IDQpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdyaXRlbCgqKCh1
aW50MzJfdCAqKShmdy0+ZGF0YSArIGkpKSwgcG1iX2FkZHIgKyBpKTsKPiA+ICvCoMKgwqDCoCBk
ZXZfaW5mbyhkZXYsICJGaXJtd2FyZSBkYXRlIGNvZGU6ICV4LyV4LyV4LCB2ZXJzaW9uOgo+ID4g
JXguJXhcbiIsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmUxNl90b19jcHUoKigo
X19iZTE2ICopKGZ3LT5kYXRhICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1UNzk4OF8yUDVH
RV9QTUJfRldfU0laRSAtCj4gPiA4KSkpLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICooZnctPmRhdGEgKyBNVDc5ODhfMlA1R0VfUE1CX0ZXX1NJWkUgLSA2KSwKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqKGZ3LT5kYXRhICsgTVQ3OTg4XzJQNUdFX1BNQl9GV19TSVpF
IC0gNSksCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKihmdy0+ZGF0YSArIE1UNzk4
OF8yUDVHRV9QTUJfRldfU0laRSAtIDIpLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICooZnctPmRhdGEgKyBNVDc5ODhfMlA1R0VfUE1CX0ZXX1NJWkUgLSAxKSk7Cj4gPiArCj4gPiAr
wqDCoMKgwqAgd3JpdGV3KHJlZyAmIH5NRDMyX0VOLCBtY3VfY3NyX2Jhc2UgKyBNRDMyX0VOX0NG
Ryk7Cj4gPiArwqDCoMKgwqAgd3JpdGV3KHJlZyB8IE1EMzJfRU4sIG1jdV9jc3JfYmFzZSArIE1E
MzJfRU5fQ0ZHKTsKPiA+ICvCoMKgwqDCoCBwaHlfc2V0X2JpdHMocGh5ZGV2LCBNSUlfQk1DUiwg
Qk1DUl9SRVNFVCk7Cj4gPiArwqDCoMKgwqAgLyogV2UgbmVlZCBhIGRlbGF5IGhlcmUgdG8gc3Rh
YmlsaXplIGluaXRpYWxpemF0aW9uIG9mIE1DVSAqLwo+ID4gK8KgwqDCoMKgIHVzbGVlcF9yYW5n
ZSg3MDAwLCA4MDAwKTsKPiA+ICvCoMKgwqDCoCBkZXZfaW5mbyhkZXYsICJGaXJtd2FyZSBsb2Fk
aW5nL3RyaWdnZXIgb2suXG4iKTsKPiAKPiBXZSBnZW5lcmFsbHkgZG9uJ3Qgc3BhbSB0aGUgbG9n
IGZvciAiSGFwcHkgRGF5cyIgY29uZGl0aW9ucy4gUGxlYXNlCj4gb25seSBsb2cgaWYgZmlybXdh
cmUgZG93bmxvYWQgZmFpbHMuCj4gClRoYW5rcy4gSSdsbCBmaXggYWxsIHRoZSBhYm92ZS4KCj4g
PiArc3RhdGljIGludCBtdDc5OHhfMnA1Z2VfcGh5X2dldF9mZWF0dXJlcyhzdHJ1Y3QgcGh5X2Rl
dmljZQo+ID4gKnBoeWRldikKPiA+ICt7Cj4gPiArwqDCoMKgwqAgaW50IHJldDsKPiA+ICsKPiA+
ICvCoMKgwqDCoCByZXQgPSBnZW5waHlfYzQ1X3BtYV9yZWFkX2FiaWxpdGllcyhwaHlkZXYpOwo+
ID4gK8KgwqDCoMKgIGlmIChyZXQpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biByZXQ7Cj4gPiArCj4gPiArwqDCoMKgwqAgLyogVGhpcyBwaHkgY2FuJ3QgaGFuZGxlIGNvbGxp
c2lvbiwgYW5kIG5laXRoZXIgY2FuIChYRkkpTUFDCj4gPiBpdCdzCj4gPiArwqDCoMKgwqDCoCAq
IGNvbm5lY3RlZCB0by4gQWx0aG91Z2ggaXQgY2FuIGRvIEhEWCBoYW5kc2hha2UsIGl0IGRvZXNu
J3QKPiA+IHN1cHBvcnQKPiA+ICvCoMKgwqDCoMKgICogQ1NNQS9DRCB0aGF0IEhEWCByZXF1aXJl
cy4KPiA+ICvCoMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqAgbGlua21vZGVfY2xlYXJfYml0KEVU
SFRPT0xfTElOS19NT0RFXzEwMGJhc2VUX0hhbGZfQklULAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGh5ZGV2LT5zdXBwb3J0ZWQpOwo+IAo+IFNv
IGl0IGNhbiBkbyAxMEJhc2VUX0hhbGY/IFdoYXQgYWJvdXQgMTAwMEJhc2VUX0hhbGY/Cj4gCj4g
QXMgeW91IHNhaWQgc29tZXdoZXJlLCAxMC8xMDAvMUcgYXJlIG5vdCBpbiB0aGUgQzQ1IHNwYWNl
LiBTbyBkb2VzCj4gZ2VucGh5X2M0NV9wbWFfcmVhZF9hYmlsaXRpZXMoKSByZXBvcnQgdGhlc2Ug
ZmVhdHVyZXM/Cj4gCj4gwqDCoMKgwqDCoMKgwqAgQW5kcmV3Ck5vcGUuIEl0IGNhbiBuZWl0aGVy
IGRvIDEwQmFzZVRfSGFsZiBub3IgMTAwMEJhc2VUX0hhbGYuIDEwICYgMTAwMApCYXNlX0hhbGYg
Yml0cyBhcmUgYWxyZWFkeSBjbGVhcmVkIGluIGZpcm13YXJlLgoKQlJzLApTa3kK

