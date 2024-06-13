Return-Path: <netdev+bounces-103160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC76B9069F3
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D18283803
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 10:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ECE142627;
	Thu, 13 Jun 2024 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eN1EoUkU";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tsfl5zr+"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F42B2555B;
	Thu, 13 Jun 2024 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274498; cv=fail; b=eJCp2CYqvpiyaPrckZCVJbJRBATH8U/ubEjPREsFlsdgRaoZ2kHTk/p8fJmbCSpNFOThC4VYwobvwLpDhSSop9dqMXzFL2j2FTZ2xpxR7xjhlO5Pt2s8F/uGMW54gE6t0GpU5mKzETltm/ehDeW+/NQBSWVPfm7ctIhQAcua8RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274498; c=relaxed/simple;
	bh=/hax2E5DjkQQJqmXNtbhhlLoBhIuK0O6YJZpcW5x6s0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VsmFSzkqtuQInGSruadYLDtfAO5eGXhNHJBBecA0OnLFyj6hDYSeCYeYeV/OKFWqHdk52TlOO5RgWw9bBD41H+iqVo1RKVmcGrJvpxt7fP2PoGl1UGaRJcX2HAaaSdpeuH6bZN3Nn+cbyJOwXFG0d8k92pggKCJ79y53fES47uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eN1EoUkU; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=tsfl5zr+; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9e8bf178296f11efa54bbfbb386b949c-20240613
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/hax2E5DjkQQJqmXNtbhhlLoBhIuK0O6YJZpcW5x6s0=;
	b=eN1EoUkUIA2NZIuQvqrRJJP7hOY8ObucehMNn5yluvKDUQyCIAdU2yhJ1oJMm0qqCSk8+PPJURmOzG0R0+lDPhrSbVd1qIy64RsZOuDo0gikCQ4RAOK+cRnfGWD7jKMwopeZn1Y8rS5M5V2dfpBdwJAeQmSrQ20mE2Gp6G8DYZg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:a93fc727-0ec7-4643-8525-e987264af2a0,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:393d96e,CLOUDID:ded38844-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 9e8bf178296f11efa54bbfbb386b949c-20240613
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 470974376; Thu, 13 Jun 2024 18:28:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 13 Jun 2024 18:28:03 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 13 Jun 2024 18:28:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XX6MgqPE/t0N1S4W477/9vQg7xxsOkJ2ML4nYJ3x9hCIQZ+E3v3zrUv95vNYygbN8qYQJSyNTA/zCVMk8w/LT7wsiYKPZGL2eQx3noGRTsOzUCvTPQm+5GDHrYODFDzAsYSLrcYuobB6AtyPYJyKk8ExyRj34MRn1ppF5ve+PextxqJbYu6Mv3uDzYEpXr9MX6NJUX7o4Bqkw6628zyTKWtT1Q2ke50gz1oX4BeDQMo+VXez+J/hncpA6GR1pEJWJwKJbJl6kpYV8KspQrB3vyPdaQKiDHvYDFekAMyqeh4MI2yKQb+QIZmH0oi0zvkfYAED4rLcUGQreHYgWw6lfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hax2E5DjkQQJqmXNtbhhlLoBhIuK0O6YJZpcW5x6s0=;
 b=n6bu/BE5qBs9IwD5ahiV4IEAWxSj+9JzvuI80k4te7xsTHJ/65ECJAV6axTCDGH0ekYQAS7HQL8Q0OfEqCFq2Iq1W8oG6Rh+srCbvOS/VscD+CyYrDB9pou299Rmy2aGZfh32YKvQ74vXT1wqiZFxEG8Do6FWTtyrIcL3Sakmnnny+3H/5mXqG8lldoVkHepGHDngJWM7/aKW0FfM6WXO7G6Rrn0+2KpvmFvnwZV/QtoxIyqa794K7FnFFBbxKEAh/rBJfei7qiVxCiCRzLUx5xjbqgu+RKQ9tm0VBRF9XtnPQap0tMUoMKY++LeJKtMcJSpWasout6RTmm6W1Easg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hax2E5DjkQQJqmXNtbhhlLoBhIuK0O6YJZpcW5x6s0=;
 b=tsfl5zr+QemQGbOweeL50QXsTDHqNTZaBtVR7+Zlyf63sgrOhfYr+AzmS23O7/+qyptuN6HiECqHBdVTWoZrVGQwWstRp/OQgrxYZiLWqiWZZ6HUSJyxbU3IVXgNeg5muzaPEaXf9VF3khF0ZcgnnSr8I7jQgxnjQNEjg1kWwIc=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SI2PR03MB6664.apcprd03.prod.outlook.com (2603:1096:4:1eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 10:28:01 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%3]) with mapi id 15.20.7677.021; Thu, 13 Jun 2024
 10:28:00 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v6 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v6 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Index: AQHatbCSfQp9e/Gy/kieT40tWkycBLG2B36AgAAB4wCAAALJAIAAE7iAgAAPaQCAABR+gIAAGQMAgADuNYCAAFXRAIAN7IUA
Date: Thu, 13 Jun 2024 10:28:00 +0000
Message-ID: <a6c79128dca5b99951e95527bd2b51a4ae7b42fd.camel@mediatek.com>
References: <20240603121834.27433-1-SkyLake.Huang@mediatek.com>
	 <20240603121834.27433-6-SkyLake.Huang@mediatek.com>
	 <Zl3ELbG8c8y0/4DN@shell.armlinux.org.uk> <Zl3Fwoiv1bJlGaQZ@makrotopia.org>
	 <Zl3IGN5ZHCQfQfmt@shell.armlinux.org.uk> <Zl3Yo3dwQlXEfP3i@makrotopia.org>
	 <Zl3lkIDqnt4JD//u@shell.armlinux.org.uk> <Zl32waW34yTiuF9u@makrotopia.org>
	 <Zl4LvKlhty/9o38y@shell.armlinux.org.uk>
	 <864a09b213169bc20f33af2f35239c6154ca81e3.camel@mediatek.com>
	 <Zl8bjNzdB7g1fRyn@makrotopia.org>
In-Reply-To: <Zl8bjNzdB7g1fRyn@makrotopia.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SI2PR03MB6664:EE_
x-ms-office365-filtering-correlation-id: 0be0b58c-2154-43cd-6f6c-08dc8b93803e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|7416008|38070700012;
x-microsoft-antispam-message-info: =?utf-8?B?bGdvdHZEaUNYdURPbERkc0dlUVgyQk8zVDNjZzMwc0QwaXJpcXJaWXZtYkdz?=
 =?utf-8?B?MjlGYlpESGM5L2JPS0hBSVFBYmZsWGgzOXBZRmZUU1J0OVZ1R3k1WWlwWGVy?=
 =?utf-8?B?QVBRbmlyUmtJVEpqRkExb0FnUVJJSDhWTmVZRmJTYm9tSjhqL29xWlc3aTRY?=
 =?utf-8?B?TTN4SlQySHQ4ZGVrTlRVRUN0MHpwemtMVU95SjRjQlBCL1lpN2ZhM01WRWNy?=
 =?utf-8?B?NWlLWWVPYnlncDM3eGtoSUs2ZXFodHNxL2ZGRW1zano1MyttUm9nd2ZRYTdw?=
 =?utf-8?B?eEM1Tyt2NWlEMUNjL1FEVG12eEI1THRyQmpzYkNaTDR5YkMyUFRqQ29BNlln?=
 =?utf-8?B?ZzlCMFpIdlpjNEoxSjcvRGtPRERiUytKWXR5U3NKZTMxY29UTXI1d2RObkpM?=
 =?utf-8?B?dVIzRFpJbzZGWWl6U29hS3ptNlJscDkvdENpR0pKV3VlcGJrS0pHUVpJUGJO?=
 =?utf-8?B?d1lncDdPcUtBVkxrdS9kbjdvdlowcktVUFRub1VwczhZU1BhVm5BYWxWT2Nk?=
 =?utf-8?B?dkJWd1oybXZtV0NValJqMHB2enRGRzZHQlZLN2Z3cmxKNngxMG93KzZFYzVY?=
 =?utf-8?B?NmZISGRFME1oVnNJT29sb0ZSN09qZHdlZ3R0WnBKaDlPWkQ3MUI4Zk04ZU5n?=
 =?utf-8?B?WnpaRXY3NXA5aklSZFNxODJpZmVOVlY1RHlGZTJPY2JXQmFpNWszSTk4aDFS?=
 =?utf-8?B?dlJsNU1waFM4cms2S2MzeGdhY3B4ZEF0dDArN0JVRlREVFlqbXAwRjN1UER3?=
 =?utf-8?B?S1o4UzE3cFl3ZTVMd05ES3BZMW1YM0g3bStvZ0R0K1dEMklRSnBtOWlwVWNC?=
 =?utf-8?B?djBncHdUazhRcEVnZEdpMFZyQ3BVdlZUcGliSnJyRmZxNlpjdTZqZXk1WU9i?=
 =?utf-8?B?L1F0U1pXS0dseC8xdUpoMWprbVVuU3A1L3hta21aYzNVeHJoMVNvWGVrSUxu?=
 =?utf-8?B?b2p1MGw5clk1cEt5cmlXTFMxelUvR2owaFBJYUNFcGhBNGU4MUVGa0U2dmpo?=
 =?utf-8?B?Uktpc2R3Rnk2QmhkVkdadVJKSVZVNWNIN2paSEYxVm9lTitaaVJucnRxQVBD?=
 =?utf-8?B?NzRWd3VnOTNmcDQxNUozUkFIYk4zUURkcDJCMzlBeUREMjFqd1BDeEZoOE42?=
 =?utf-8?B?UXpkeTY2NGhCTzFQZm5YZng5RCtrWHFYNmFReVpwWk1yUlVlMC9pQ3JvazFR?=
 =?utf-8?B?Sm91UEdTM0xzSThQTDl6ZXk3QU9ZY000RWdlbGJ3TURRVUdMRElkRG1rc0tR?=
 =?utf-8?B?SFdPK3FuRFErTXhTQXF2ay9iUkJvQUlhcitONzVJUGhNWGdhVVp6NkxhYzJ6?=
 =?utf-8?B?S0xuQnZ1NUdmd3kwSWNyMFhyaUF2ZGxKcXhyQjVHN3F5b3JOemFOQTZEY3Jh?=
 =?utf-8?B?d2NpZ1BrdkdjUmxBUkdEZ2dwTndxTE1lQW94enVJSkorTjlHL1BYcnd4VGNn?=
 =?utf-8?B?d2VmeXNyZXFIR25KZUlsdUpNdTdINloxTkRXM3RrSFBRbEVPNVV6MU5TNXlu?=
 =?utf-8?B?NVQ5YTNtZHFsbkpPYVozMDZqQ1cyb2JTM2dJbTZ3NTBFOUIxRnN3dTQxbkZT?=
 =?utf-8?B?eUxhYXAyaEd5bmlrQzM5Y2tjZzBQUWhIeXMvZ2hsbzVpUUxWbWJldmYrWHBX?=
 =?utf-8?B?dm55UDVKZC9qV0oyUmRBZGFtQTlPUHpaUFVsZXBEL3pnSU1pcUhLanVnak1K?=
 =?utf-8?B?YUZZaGpCN2RNVGNFMUVjZEptZTFDNzJIRDJNc2dhRmFtWDF3OGhpNnJBYVJO?=
 =?utf-8?Q?Dr0LNGa15bqXPgj5v6qpY8wS3CNhO8YK/PImJpy?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(7416008)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjVIcGtrUFZhcy9kak1FZ3A5NFlhZmpPWlhkNk5HcDV3WU9ScEI3dzh4ejlW?=
 =?utf-8?B?L1U1V3JkS29ZRGdhd3BLZGdwMkVrTk0rSGlTMFhnYnZuZTE5Rzd1dk8yQ09k?=
 =?utf-8?B?SGprWWdVSVh5N3dYNytIT2c1YUExUjkrcUFEZWRIRGM2YWZsdkIvWHJEUkQ2?=
 =?utf-8?B?aXk5NUJuQUM3OWlYbTdLOHR5Z0MxUnpXSjJPN0xlR2UvN2U4ajZOY0dNK0Uz?=
 =?utf-8?B?NDhQQmNKcnZXT080cUw4U1habXRMeXFqQXlTaElTbTh3SUhnZENueCsrZkhX?=
 =?utf-8?B?N0JORFQwV3pPNDlreCs4VStibG9MVm1jOVhGUVE2bkQ5ajREZDRCK0FPVGti?=
 =?utf-8?B?a01GRHplcmVuTloxb043YWRSU3hpcnFjWHYrSnFPMHp4OXhyTndJMHdXN3NH?=
 =?utf-8?B?bHdYczBnc1BwNjFOWkdxek4zOFhzNVJZRmtsZnJqMjlONDZTZWhteFBZWnY2?=
 =?utf-8?B?MGlIZEZ3L0NTa093dmtjbWVYMDNTN1FhdnZHRE1wQjZSZnJrTHl1aUw5WU5Q?=
 =?utf-8?B?Y3lCWUwyamluQWNvRy9hYnY3R0VUOFNLejVVUGdra1p5bllVTmxTai9IUkJh?=
 =?utf-8?B?TDRkaHhRNnBsS2FvSUl2aFAxOWRDQmpHdVVrNnhnZElLdEsyT3lvMmxCbHM0?=
 =?utf-8?B?ay8wd0tXYU9vUUxFeVIwZUpBVlFEZlI4dTFsUWhhdEFPN2dHaDFETTNWci80?=
 =?utf-8?B?cklTS2p0S2FCTjltZ1pkZlBkTk5tWldRSjk1aFgyV2JNZkdKaTJ0QmpZdnhY?=
 =?utf-8?B?YkdpZFpLRElNUkpTOFFzVW1FcWdMNERxTnNTTzFmQTBPQUhiZWduVmF6UG1n?=
 =?utf-8?B?UWRlZUdiUVJHY0RTNHIrUGtjYnowZThUZk5NMHFmbFRUM2FoMVFjRDA1Wlh1?=
 =?utf-8?B?eHI4ZDZEc0FNUVZaM2F3MkZuZEx0US9KaDlvZWxLOGtHd3k4ODFqdWRnaUIx?=
 =?utf-8?B?Q090R084bGdFTFNWME95TUFmdnh5T1Nmd0lmbDNKZVhQQkwwVmV6NHBoaHJK?=
 =?utf-8?B?RDlLc0lVb2cxWDEzTFh3cytxemZINlpKeUNEcjNvbnc2V2ZJWExjb0tRWUc2?=
 =?utf-8?B?Y3RrTmFxMi9HN3BTeWp3Sm9OQzFnSnJZeERPN0V5MWZRbHlvNW01SVhDZTg5?=
 =?utf-8?B?eEIvYUNSZlc1MXEzQVJtVG5QczBXRVVGOTBjQ21LR2ZTaDZ3YSt3UVY3M1JS?=
 =?utf-8?B?anpiNmJqWkw4Y3lVMzBMTzdTdzErVDNDaEU3REcvaHNkYUEzZWkyRU5DdjJN?=
 =?utf-8?B?eWxjTHFxK3hmTU5hQXRiNXp0UUhTY01IWlhXbDNQRVptaUpjb1hYLzNpUlhI?=
 =?utf-8?B?dDdMQndtTDBVQlFjTU8wTWcwdDJ4azNvS0J2ZmdLNG5qZnNlOU9lQThObFJP?=
 =?utf-8?B?eXpNYmFLNEZBTEk1MitlTEk3NUdQakY4UlptQ0lMZDJOMS9Ja1pmUzdyNFY3?=
 =?utf-8?B?M1BPVmRPSXRYSzU0VEthc09PUDdKZ1I1R2JaVFpLcjVvL3ZRWW9zUUlsUGpS?=
 =?utf-8?B?cFFYWmVlY2JpS1d2UmVLWk53RVpKcHdYWmpaZzl1R3ppSFJPb1RQeUFub0xQ?=
 =?utf-8?B?SC9BOHpYUnRCS29idzRwekxXVVdNQWhyVHNzYTJyTWlJNi9LeUF1c0h5K0Jj?=
 =?utf-8?B?OFgvVHE5anRkUFlNVjRLNXZRUStuSUVxSHhkTDk5OGljS1J3QmR0MWhwUjhT?=
 =?utf-8?B?Tm0yL3Q4ZDVFWU9SSVZhNHpabVM1azN2UjQzTm1BVVdheXZCU2Jjc3piK3Nz?=
 =?utf-8?B?dFVJMmdVNktwZnRkdFN1amVXMGVzeUtqaVBjL21GaWhITmJsODFJS3hwSWs5?=
 =?utf-8?B?cEJ4d2p2Ti9ZOVpwcFlNUjRIS3R3QUNCU0UrTVdqekhGZ1RRUTM4NExkT28z?=
 =?utf-8?B?T1lxZnJRRElGUnJ5Q3FjZHdheE5Wa1k0bFg2SWJOWTJEKzAzZ3AyMlpDdkdn?=
 =?utf-8?B?Z1hWWUlHeVpvSndreUsvRk9OWmo2aWdjeVJmQUNIQytGUExmNXhvZ2luZ2ZQ?=
 =?utf-8?B?WjkvL2xaUHJQSXhLRmltUVhTd1BJWVVrUG9zQktCOE9yNmpMdE9aZUNsZ0pl?=
 =?utf-8?B?cVJDNUUyTXZ3d1l5UXVGVm81YzBVVzlMQlhNaC8xRDN6aHBXU1lrejlMM0xl?=
 =?utf-8?B?V010d0MzRjg1NTBIV0tNc29aOURqa2RpbG1OU2JvdzBnV29DY1h1S1BSNW1y?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F8CB4B02FF0A042A7C57472C4B6731E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be0b58c-2154-43cd-6f6c-08dc8b93803e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 10:28:00.7516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0o5BMHDZfeuifwFOD7qazJcIqWsxFmjr5x00Ca+UiMf02Zo5SXHaesAUZYlRiwD5EjZiqSQSrE1CO551F4b2Qm7vkQIoUC5/E/BwGdxzy+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6664

T24gVHVlLCAyMDI0LTA2LTA0IGF0IDE0OjUwICswMTAwLCBEYW5pZWwgR29sbGUgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gVHVlLCBKdW4gMDQsIDIwMjQgYXQgMDg6NDI6NTdBTSArMDAwMCwg
U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKSB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjQtMDYtMDMg
YXQgMTk6MzAgKzAxMDAsIFJ1c3NlbGwgS2luZyAoT3JhY2xlKSB3cm90ZToNCj4gPiA+ICAgDQo+
ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cw0KPiB1bnRpbA0KPiA+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gPiA+ICBPbiBNb24sIEp1biAwMywgMjAyNCBhdCAwNjowMDo0OVBN
ICswMTAwLCBEYW5pZWwgR29sbGUgd3JvdGU6DQo+ID4gPiA+IE9uIE1vbiwgSnVuIDAzLCAyMDI0
IGF0IDA0OjQ3OjI4UE0gKzAxMDAsIFJ1c3NlbGwgS2luZyAoT3JhY2xlKQ0KPiA+ID4gd3JvdGU6
DQo+ID4gPiA+ID4gT24gTW9uLCBKdW4gMDMsIDIwMjQgYXQgMDM6NTI6MTlQTSArMDEwMCwgRGFu
aWVsIEdvbGxlIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gTW9uLCBKdW4gMDMsIDIwMjQgYXQgMDI6
NDE6NDRQTSArMDEwMCwgUnVzc2VsbCBLaW5nDQo+IChPcmFjbGUpDQo+ID4gPiB3cm90ZToNCj4g
PiA+ID4gPiA+ID4gT24gTW9uLCBKdW4gMDMsIDIwMjQgYXQgMDI6MzE6NDZQTSArMDEwMCwgRGFu
aWVsIEdvbGxlDQo+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgSnVuIDAzLCAyMDI0
IGF0IDAyOjI1OjAxUE0gKzAxMDAsIFJ1c3NlbGwgS2luZw0KPiA+ID4gKE9yYWNsZSkgd3JvdGU6
DQo+ID4gPiA+ID4gPiA+ID4gPiBPbiBNb24sIEp1biAwMywgMjAyNCBhdCAwODoxODozNFBNICsw
ODAwLCBTa3kgSHVhbmcNCj4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBBZGQgc3Vw
cG9ydCBmb3IgaW50ZXJuYWwgMi41R3BoeSBvbiBNVDc5ODguIFRoaXMNCj4gZHJpdmVyDQo+ID4g
PiB3aWxsIGxvYWQNCj4gPiA+ID4gPiA+ID4gPiA+ID4gbmVjZXNzYXJ5IGZpcm13YXJlLCBhZGQg
YXBwcm9wcmlhdGUgdGltZSBkZWxheSBhbmQNCj4gPiA+IGZpZ3VyZSBvdXQgTEVELg0KPiA+ID4g
PiA+ID4gPiA+ID4gPiBBbHNvLCBjZXJ0YWluIGNvbnRyb2wgcmVnaXN0ZXJzIHdpbGwgYmUgc2V0
IHRvIGZpeA0KPiA+ID4gbGluay11cCBpc3N1ZXMuDQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gPiA+IEJhc2VkIG9uIG91ciBwcmV2aW91cyBkaXNjdXNzaW9uLCBpdCBtYXkgYmUg
d29ydGgNCj4gPiA+IGNoZWNraW5nIGluIHRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4gLmNvbmZpZ19p
bml0KCkgbWV0aG9kIHdoZXRoZXIgcGh5ZGV2LT5pbnRlcmZhY2UgaXMNCj4gb25lIG9mDQo+ID4g
PiB0aGUNCj4gPiA+ID4gPiA+ID4gPiA+IFBIWSBpbnRlcmZhY2UgbW9kZXMgdGhhdCB0aGlzIFBI
WSBzdXBwb3J0cy4gQXMgSQ0KPiA+ID4gdW5kZXJzdGFuZCBmcm9tIG9uZQ0KPiA+ID4gPiA+ID4g
PiA+ID4gb2YgeW91ciBwcmV2aW91cyBlbWFpbHMsIHRoZSBwb3NzaWJpbGl0aWVzIGFyZSBYR01J
SSwNCj4gPiA+IFVTWEdNSUkgb3INCj4gPiA+ID4gPiA+ID4gPiA+IElOVEVSTkFMLiBUaHVzOg0K
PiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+ICtzdGF0aWMgaW50IG10Nzk4
eF8ycDVnZV9waHlfY29uZmlnX2luaXQoc3RydWN0DQo+ID4gPiBwaHlfZGV2aWNlICpwaHlkZXYp
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICt7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICtzdHJ1Y3QgcGlu
Y3RybCAqcGluY3RybDsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gK2ludCByZXQ7DQo+ID4gPiA+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+IC8qIENoZWNrIHRoYXQgdGhlIFBIWSBpbnRlcmZh
Y2UgdHlwZSBpcyBjb21wYXRpYmxlICovDQo+ID4gPiA+ID4gPiA+ID4gPiBpZiAocGh5ZGV2LT5p
bnRlcmZhY2UgIT0gUEhZX0lOVEVSRkFDRV9NT0RFX0lOVEVSTkFMDQo+ICYmDQo+ID4gPiA+ID4g
PiA+ID4gPiAgICAgcGh5ZGV2LT5pbnRlcmZhY2UgIT0gUEhZX0lOVEVSRkFDRV9NT0RFX1hHTUlJ
ICYmDQo+ID4gPiA+ID4gPiA+ID4gPiAgICAgcGh5ZGV2LT5pbnRlcmZhY2UgIT0gUEhZX0lOVEVS
RkFDRV9NT0RFX1VTWEdNSUkpDQo+ID4gPiA+ID4gPiA+ID4gPiByZXR1cm4gLUVOT0RFVjsNCj4g
PiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBUaGUgUEhZIGlzIGJ1aWx0LWludG8gdGhl
IFNvQywgYW5kIGFzIHN1Y2ggdGhlDQo+IGNvbm5lY3Rpb24NCj4gPiA+IHR5cGUgc2hvdWxkDQo+
ID4gPiA+ID4gPiA+ID4gYWx3YXlzIGJlICJpbnRlcm5hbCIuIFRoZSBQSFkgZG9lcyBub3QgZXhp
c3QgYXMNCj4gZGVkaWNhdGVkDQo+ID4gPiBJQywgb25seQ0KPiA+ID4gPiA+ID4gPiA+IGFzIGJ1
aWx0LWluIHBhcnQgb2YgdGhlIE1UNzk4OCBTb0MuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiBUaGF0J3Mgbm90IGhvdyBpdCB3YXMgZGVzY3JpYmVkIHRvIG1lIGJ5IFNreS4NCj4gPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IElmIHdoYXQgeW91IHNheSBpcyBjb3JyZWN0LCB0aGVu
IHRoZSBpbXBsZW1lbnRhdGlvbiBvZg0KPiA+ID4gPiA+ID4gPiBtdDc5OHhfMnA1Z2VfcGh5X2dl
dF9yYXRlX21hdGNoaW5nKCkgd2hpY2ggY2hlY2tzIGZvcg0KPiA+ID4gaW50ZXJmYWNlIG1vZGVz
DQo+ID4gPiA+ID4gPiA+IG90aGVyIHRoYW4gSU5URVJOQUwgaXMgbm90IGNvcnJlY3QuIEFsc28g
aXQgbWVhbnMgdGhhdA0KPiA+ID4gY29uZmlnX2luaXQoKQ0KPiA+ID4gPiA+ID4gPiBzaG91bGQg
bm90IHBlcm1pdCBhbnl0aGluZyBidXQgSU5URVJOQUwuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IFRoZSB3YXkgdGhlIFBIWSBpcyBjb25uZWN0ZWQgdG8gdGhlIE1BQyAqaW5zaWRlIHRoZSBj
aGlwKg0KPiBpcw0KPiA+ID4gWEdNSUkNCj4gPiA+ID4gPiA+IGFjY29yZGluZyB0aGUgTWVkaWFU
ZWsuIFNvIGNhbGwgaXQgImludGVybmFsIiBvciAieGdtaWkiLA0KPiA+ID4gaG93ZXZlciwgdXAg
dG8NCj4gPiA+ID4gPiA+IG15IGtub3dsZWRnZSBpdCdzIGEgZmFjdCB0aGF0IHRoZXJlIGlzICoq
b25seSBvbmUgd2F5KioNCj4gdGhpcw0KPiA+ID4gUEhZIGlzDQo+ID4gPiA+ID4gPiBjb25uZWN0
ZWQgYW5kIHVzZWQsIGFuZCB0aGF0IGlzIGJlaW5nIGFuIGludGVybmFsIHBhcnQgb2YNCj4gdGhl
DQo+ID4gPiBNVDc5ODggU29DLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJbWhvLCBhcyB0
aGVyZSBhcmUgbm8gYWN0dWFsIFhHTUlJIHNpZ25hbHMgZXhwb3NlZCBhbnl3aGVyZQ0KPiBJJ2QN
Cj4gPiA+IHVzZQ0KPiA+ID4gPiA+ID4gImludGVybmFsIiB0byBkZXNjcmliZSB0aGUgbGluayBi
ZXR3ZWVuIE1BQyBhbmQgUEhZICh3aGljaA0KPiBhcmUNCj4gPiA+IGJvdGgNCj4gPiA+ID4gPiA+
IGluc2lkZSB0aGUgc2FtZSBjaGlwIHBhY2thZ2UpLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkg
ZG9uJ3QgY2FyZSB3aGF0IGdldHMgZGVjaWRlZCBhYm91dCB3aGF0J3MgYWNjZXB0YWJsZSBmb3IN
Cj4gdGhlDQo+ID4gPiBQSFkgdG8NCj4gPiA+ID4gPiBhY2NlcHQsIGp1c3QgdGhhdCBpdCBjaGVj
a3MgZm9yIHRoZSBhY2NlcHRhYmxlIG1vZGVzIGluDQo+ID4gPiAuY29uZmlnX2luaXQoKQ0KPiA+
ID4gPiA+IGFuZCB0aGUgLmdldF9yYXRlX21hdGNoaW5nKCkgbWV0aG9kIGlzIG5vdCBjaGVja2lu
ZyBmb3INCj4gaW50ZXJmYWNlDQo+ID4gPiA+ID4gbW9kZXMgdGhhdCBhcmUgbm90IHBlcm1pdHRl
ZC4NCj4gPiA+ID4gDQo+ID4gPiA+IFdoYXQgSSBtZWFudCB0byBleHByZXNzIGlzIHRoYXQgdGhl
cmUgaXMgbm8gbmVlZCBmb3Igc3VjaCBhDQo+IGNoZWNrLA0KPiA+ID4gYWxzbw0KPiA+ID4gPiBu
b3QgaW4gY29uZmlnX2luaXQuIFRoZXJlIGlzIG9ubHkgb25lIHdheSBhbmQgb25lIE1BQy1zaWRl
DQo+ID4gPiBpbnRlcmZhY2UgbW9kZQ0KPiA+ID4gPiB0byBvcGVyYXRlIHRoYXQgUEhZLCBzbyB0
aGUgdmFsdWUgd2lsbCBhbnl3YXkgbm90IGJlIGNvbnNpZGVyZWQNCj4gPiA+IGFueXdoZXJlDQo+
ID4gPiA+IGluIHRoZSBkcml2ZXIuDQo+ID4gPiANCj4gPiA+IE5vLCBpdCBtYXR0ZXJzLiBXaXRo
IGRyaXZlcnMgdXNpbmcgcGh5bGluaywgdGhlIFBIWSBpbnRlcmZhY2UNCj4gbW9kZSBpcw0KPiA+
ID4gdXNlZCBpbiBjZXJ0YWluIGNpcmN1bXN0YW5jZXMgdG8gY29uc3RyYWluIHdoYXQgdGhlIG5l
dCBkZXZpY2UNCj4gY2FuDQo+ID4gPiBkby4NCj4gPiA+IFNvLCBpdCBtYWtlcyBzZW5zZSBmb3Ig
bmV3IFBIWSBkcml2ZXJzIHRvIGVuc3VyZSB0aGF0IHRoZSBQSFkNCj4gPiA+IGludGVyZmFjZQ0K
PiA+ID4gbW9kZSBpcyBvbmUgdGhhdCB0aGV5IGNhbiBzdXBwb3J0LCByYXRoZXIgdGhhbiBqdXN0
IGFjY2VwdGluZw0KPiA+ID4gd2hhdGV2ZXINCj4gPiA+IGlzIHBhc3NlZCB0byB0aGVtICh3aGlj
aCB0aGVuIGNhbiBsZWFkIHRvIG1haW50YWluYWJpbGl0eSBpc3N1ZXMNCj4gZm9yDQo+ID4gPiBz
dWJzeXN0ZW1zLikNCj4gPiA+IA0KPiA+ID4gU28sIGV4Y3VzZSBtZSBmb3IgZGlzYWdyZWVpbmcg
d2l0aCB5b3UsIGJ1dCBJIGRvIHdhbnQgdG8gc2VlIHN1Y2gNCj4gYQ0KPiA+ID4gY2hlY2sgaW4g
bmV3IFBIWSBkcml2ZXJzLg0KPiA+ID4gDQo+ID4gPiAtLSANCj4gPiA+IFJNSydzIFBhdGNoIHN5
c3RlbTogDQo+IGh0dHBzOi8vd3d3LmFybWxpbnV4Lm9yZy51ay9kZXZlbG9wZXIvcGF0Y2hlcy8N
Cj4gPiA+IEZUVFAgaXMgaGVyZSEgODBNYnBzIGRvd24gMTBNYnBzIHVwLiBEZWNlbnQgY29ubmVj
dGl2aXR5IGF0IGxhc3QhDQo+ID4gDQo+ID4gSGkgUnVzc2VsbC9EYW5pZWwsDQo+ID4gICBJTU8s
IHdlIGNhbiBjaGVjayBQSFlfSU5URVJGQUNFX01PREVfSU5URVJOQUwgJg0KPiA+IFBIWV9JTlRF
UkZBQ0VfTU9ERV9YR01JSSBpbiBjb25maWdfaW5pdCgpIG9yIHByb2JlKCkuIEhvd2V2ZXIsDQo+
ID4gUEhZX0lOVEVSRkFDRV9NT0RFX1VTWEdNSUkgaXNuJ3Qgc3VwcG9ydGVkIGJ5IHRoaXMgcGh5
LCBhbmQNCj4gPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWRpYXRlay9tdGtfZXRoX3BhdGguYyB1
c2VzDQo+ID4gUEhZX0lOVEVSRkFDRV9NT0RFX1VTWEdNSUkgdG8gc3dpdGNoIG5ldHN5cyBwY3Mg
bXV4IChzZXQNCj4gPiBNVVhfRzJfVVNYR01JSV9TRUwgYml0IGluIFRPUF9NSVNDX05FVFNZU19Q
Q1NfTVVYKSBzbyB0aGF0IFhGSS1NQUMNCj4gY2FuDQo+ID4gYmUgY29ubmVjdGVkIHRvIGV4dGVy
bmFsIDEwR3BoeS4NCj4gPiAgIFNvLCBiYXNpY2FsbHksIGZvciAxc3QgWEZJLU1BQyBvbiBtdDc5
ODg6DQo+ID4gLSBQSFlfSU5URVJGQUNFX01PREVfWEdNSUkvUEhZX0lOVEVSRkFDRV9NT0RFX0lO
VEVSTkFMOiBidWlsdC1pbg0KPiA+IDIuNUdwaHkNCj4gDQo+IFdoeSBib3RoPyBXb3VsZG4ndCBq
dXN0IFBIWV9JTlRFUkZBQ0VfTU9ERV9JTlRFUk5BTCBiZSBtb3JlIGNsZWFyPw0KPiBUaGVyZSBp
cyBubyBYR01JSSBpbnRlcmZhY2UgZXhwb3NlZCBhbnl3aGVyZSBhbmQgYm90aCAiaW50ZXJuYWwi
IGFuZA0KPiAieGdtaWkiIHdvdWxkIGJlIHVzZWQgdG8gZXhwcmVzcyB0aGUgZXhhY3Qgc2FtZSB0
aGluZy4NCj4gDQpTaW5jZSBJIGZvdW5kIG91dCB0aGF0IHRoZXJlJ3MgcGh5LW1vZGU9ImdtaWki
IGluIG10Nzk4MS1yZmIuZHRzIG9uDQpvcGVuV1JULCBJIHRob3VnaHQgbWF5YmUgd2UgbmVlZCBn
bWlpJmludGVybmFsIGZvciBtdDc5ODEncyBidWlsdC1pbg0KR2JFIGFuZCB4Z21paSZpbnRlcm5h
bCBmb3IgbXQ3OTg4J3MgYnVpbHQtaW4gMi41R2JFLg0KDQpodHRwczovL2dpdC5vcGVud3J0Lm9y
Zy8/cD1vcGVud3J0L29wZW53cnQuZ2l0O2E9YmxvYjtmPXRhcmdldC9saW51eC9tZWRpYXRlay9m
aWxlcy02LjYvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc5ODEtcmZiLmR0cztoPWIy
YmI2OTI5NTYyZWJkNTg1NTA0NzdjZGJmODgzOGQ4YmIzOGQ0ODk7aGI9cmVmcy9oZWFkcy9tYWlu
DQoNCkhvd2V2ZXIsIHRoYXQgc2VlbXMgbGlrZSBhIGZvcmdvdHRlbiBsZWZ0LW92ZXIgYXMgeW91
IG1lbnRpb25lZC4NClNvIEknbGwgZm9sbG93IHlvdXIgcmVjb21tZW5kYXRpb24gYW5kIHJlbW92
ZSBYR01JSSBjaGVjayBpbiB2NyBzbyB0aGF0DQptdGstZ2Utc29jLmMgJiBtdGstMnA1Z2UuYyBm
b2xsb3cgdGhlIHNhbWUgbG9naWMgc2luY2UgdGhlc2UgdHdvDQpkcml2ZXJzIGFyZSBib3RoIGZv
ciBidWlsdC1pbiBldGhlcm5ldCBwaHkuDQoNClNreQ0KPiA+IC0gUEhZX0lOVEVSRkFDRV9NT0RF
X1VTWEdNSUk6IGV4dGVybmFsIDEwR3BoeQ0KPiA+IA0KPiA+ICAgSSBhZGQgY2hlY2sgaW4gY29u
ZmlnX2luaXQoKToNCj4gPiAvKiBDaGVjayBpZiBQSFkgaW50ZXJmYWNlIHR5cGUgaXMgY29tcGF0
aWJsZSAqLw0KPiA+IGlmIChwaHlkZXYtPmludGVyZmFjZSAhPSBQSFlfSU5URVJGQUNFX01PREVf
WEdNSUkgJiYNCj4gPiAgICAgcGh5ZGV2LT5pbnRlcmZhY2UgIT0gUEhZX0lOVEVSRkFDRV9NT0RF
X0lOVEVSTkFMKQ0KPiA+IHJldHVybiAtRU5PREVWOw0KPiA+IA0KPiA+ICAgQWxzbywgdGVzdCB3
aXRoIGRpZmZlcmVudCBwaHkgbW9kZSBpbiBkdHM6DQo+ID4gW1BIWV9JTlRFUkZBQ0VfTU9ERV9V
U1hHTUlJXQ0KPiA+IFsgICAxOC43MDIxMDJdIG10a19zb2NfZXRoIDE1MTAwMDAwLmV0aGVybmV0
IGV0aDE6IG10a19vcGVuOiBjb3VsZA0KPiBub3QNCj4gPiBhdHRhY2ggUEhZOiAtMTkNCj4gPiBy
b290QE9wZW5XcnQ6LyMgY2F0IC9wcm9jL2RldmljZS10cmVlL3NvYy9ldGhlcm5ldEAxNTEwMDAw
MC9tYWNAMS9wDQo+IGh5LWMNCj4gPiBvbm5lY3Rpb24tdHlwZQ0KPiA+IHVzeGdtaWkNCj4gPiAN
Cj4gPiBbUEhZX0lOVEVSRkFDRV9NT0RFX0lOVEVSTkFMXQ0KPiA+IFsgICAxOC4zMjk1MTNdIG10
a19zb2NfZXRoIDE1MTAwMDAwLmV0aGVybmV0IGV0aDE6IFBIWSBbbWRpby0NCj4gYnVzOjBmXQ0K
PiA+IGRyaXZlciBbTWVkaWFUZWsgTVQ3OTg4IDIuNUdiRSBQSFldIChpcnE9UE9MTCkNCj4gPiBb
ICAgMTguMzM5NzA4XSBtdGtfc29jX2V0aCAxNTEwMDAwMC5ldGhlcm5ldCBldGgxOiBjb25maWd1
cmluZyBmb3INCj4gPiBwaHkvaW50ZXJuYWwgbGluayBtb2RlDQo+ID4gcm9vdEBPcGVuV3J0Oi8j
IGNhdCAvcHJvYy9kZXZpY2UtdHJlZS9zb2MvZXRoZXJuZXRAMTUxMDAwMDANCj4gPiAvbWFjQDEv
cGh5LWNvbm5lY3Rpb24tdHlwZQ0KPiA+IGludGVybmFsDQo+ID4gDQo+ID4gU2t5DQo=

