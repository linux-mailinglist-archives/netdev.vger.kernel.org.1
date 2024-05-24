Return-Path: <netdev+bounces-97916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9255E8CE064
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 06:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1A02B20913
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 04:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1B13218B;
	Fri, 24 May 2024 04:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hz4YeK7e";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nnqFA75q"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ACE2574B;
	Fri, 24 May 2024 04:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716525561; cv=fail; b=Tibs0InCQV+zBgFDp96tXiEcB//R4ABORwfeog/Ic+MeBQrz5+yQlQctL7+7ZU88haqO6kSxeDKmOo2sYT6jM6MjfdBv5XCZwtJk6vFusfhNP/1eu7X5TYnOjPWNdSK8xJf7l9yfF4Vox06eH+vykZkYAFjvO6upKOUHl2jdu0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716525561; c=relaxed/simple;
	bh=TLaX29PEBFrUE8Ia0Gvrqih809tARCNH4HQEEdqOcwk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gs5edD2M/Pd/qxkSW8oN6aHpDiGsqNe4YD3kWAXdEfNTS5oYkKqe/gm2YTK3APrPUaTWTCaTYMsYhQNZlLmLJAw/yyeIM+BiQwohzVEsKrd84HlbxiN15fvazlqARk0F3kZA0VYCxhwYh4StkOJVi0L46cXQkKP/VQXxvWiVk7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hz4YeK7e; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=nnqFA75q; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8d7780f2198711efbfff99f2466cf0b4-20240524
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TLaX29PEBFrUE8Ia0Gvrqih809tARCNH4HQEEdqOcwk=;
	b=hz4YeK7eOs30ZPMbl15D//Ic0DTLsXmuS6teSGR6PHq8P/aJZITAxyRnPfW3HbpKIjg5L6gTJHHxSB0norE97p8+ydDfGxTwYCDnZuvQCaN5Ybmr1Ow0uaAXBT1+HaH4TEOWjDnvij13YZic55vtOP6E1homR59ESBLKlElXZRw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:4e54a506-86ec-45e7-a07d-e652e278e540,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:112e2893-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8d7780f2198711efbfff99f2466cf0b4-20240524
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 687082113; Fri, 24 May 2024 12:39:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 24 May 2024 12:39:03 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 24 May 2024 12:39:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPJwJe8drTUgxGSwORnzfV3rcrWmt81zhlUen+M/xvAqNAe1p2O6ZH1jryCPc8axHpbTgHGREV0fuSVkiHHHCZZPucuPGXWtaBvAA0rHe7iy9ZxXFKOEY8mUKC8AqDraX2usdxZdz1Hy5n0GWIiWwUYhe7ZdDWchhmrVi/dj2AOlnFFNf9iDlbd+5zNipgNuc3L7XMd3edkh6BbkgkQYM9miNP21ss9t6W61u3kLTe2VTqT04n2UQXXVxBDpPQfVdIiSXjZxsrxAqNbW8GZsoNUopEQhYTsie8xlj9XJGKumsz/rSHtO+Dq7dD2+NZlW9fjBZl6INz6/NAkOpr67Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLaX29PEBFrUE8Ia0Gvrqih809tARCNH4HQEEdqOcwk=;
 b=Zel4HtExs/uwbPXC2QLymJRB3oBX370ykTxN02j14S6ACpe/837Dxe3l8EFyuic/vVxK4wUlc1eJsNR6qJf5ya09TBpHg6/0orOE9NYVswcKAbrZz/bh9q0bEGLJKv7U6+OuYrHzgeXBxM31Q/BYMIiwC+2XcsmobT+i8yWvGPp+L2RdaC3O+JolW2npjbCxPWA44A26yJN4rbMSLoXGXs3XttJJA6FmwQdQvRPuwaNyV0cL87XL4Ab7OElcfmergYsflYrDzFnM6ZRS1zh5s2T31bRZiS8VMDgagJJXyw/4ChniztXqrWMhhYAJ027GT5yI82Z375RXI0TvwCttNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLaX29PEBFrUE8Ia0Gvrqih809tARCNH4HQEEdqOcwk=;
 b=nnqFA75q9p+J/ml524dSyP2RtlPpk4eRcGc9MQ90XiAR8kOqGJTa5DWRqq+BJrgbAEeo4RtHNq1ZL563LdiNiaWXHsLXz6sL+3klhcp4adb9y8ZL+oZe8x5IoEiKDLXMy5Zfzs4cP7aDOVNBzTRIKpjZ30VHcjcSuHuvGR+sw3o=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SEYPR03MB7413.apcprd03.prod.outlook.com (2603:1096:101:140::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17; Fri, 24 May
 2024 04:38:59 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.7611.013; Fri, 24 May 2024
 04:38:59 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dqfext@gmail.com" <dqfext@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>
Subject: Re: [PATCH net-next v3 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v3 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Index: AQHaqqo0nm3iQO4q8kqKvRUSCwrNqbGgH2GAgAFH7QCAAImfAIAD4lKA
Date: Fri, 24 May 2024 04:38:58 +0000
Message-ID: <26c6f9268fde4ee5b9201b107e39233b333a79d6.camel@mediatek.com>
References: <20240520113456.21675-1-SkyLake.Huang@mediatek.com>
	 <20240520113456.21675-6-SkyLake.Huang@mediatek.com>
	 <62b19955-23b8-4cd1-b09c-68546f612b44@lunn.ch>
	 <f7bc69930796b3797dc0e31237267e045a86f823.camel@mediatek.com>
	 <5b437ed2-1404-47f8-a320-f44dee98dfee@lunn.ch>
In-Reply-To: <5b437ed2-1404-47f8-a320-f44dee98dfee@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SEYPR03MB7413:EE_
x-ms-office365-filtering-correlation-id: f0b4289b-02fc-4ba4-fc98-08dc7bab6dae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Mkx6NGtJekFMeWpQT01BOXROVm40NzJ2RG1FcVhIeUdrSkVXNnJZVDJySlBu?=
 =?utf-8?B?alNVTE8xRHh0WEJMaFRqck41bmpGbUhtQ3Z0ZUN6cSsrTVZ3N2dyRTFYNjdC?=
 =?utf-8?B?ZThUNHRSL3pLZUVrUXdaWGxOZWJUbWtFNGs4NUJWVDc3OGs1SGQyaFVWc0Fm?=
 =?utf-8?B?WERoN3FaeEsxeGE4dWorSzkwd0VxWHVKd3FPTVUwN3RiR0tOUEw5bVpGbXgz?=
 =?utf-8?B?bzBWTzJJWXd1Z3psakwvOWNNbFBHeTQycHcyWk9QNVBZKys4TTg5YXVpY3o0?=
 =?utf-8?B?RjBXanNoVXdQOTFmUnlJTDhuNlZxZmprNlFPZHQrbEhFTGdSYmd3cTIwR0Y3?=
 =?utf-8?B?RlVyNGtPWW1aTkI5cjZOQmc5aHJ6eXJHQTl2d2xLMUxCV21pbmJkWDZuZVVn?=
 =?utf-8?B?bkRES2NoWE1aNVFCeVUvL283bzl5MGcvZVRaV2RaNnprS2duQStwOElpL21E?=
 =?utf-8?B?RVU5RDJZY3pSc0pWdVhieWZ3Y0hEUDhjK1FKeU51YmVvb3NucFlyK0N2TEZD?=
 =?utf-8?B?bDFqQ3ZJeS9KSGtJOFp2MlVOejR0anh4ZlU2M3NGYzdwOUxjUUJrdy9Za0J5?=
 =?utf-8?B?allndEphNFllejlyTmE3NHArVUk3bHNjQ1JwZkY2S0gyUjk0YW9NSE91ckp2?=
 =?utf-8?B?eFFobGZYcSsrM2RTMW9IU3l2bis0MHdtaUZKVlNhSm9jeTNvL0pNV0ljWVQw?=
 =?utf-8?B?cW5JaW9IT1FIOGlHdElScHZaaHA4WUxBOFJkTTVqZGI2dzEzS2F1Skk1YkEv?=
 =?utf-8?B?QVhFQ1ViemtOOVYvdU1qU3M1WWZvaE9PZWluZ2NtblpIOUFsVGZHYUdSSCtw?=
 =?utf-8?B?MDlXRDlNUk5zSUtodlBCVjlYWHhQWG41N3RaTDdMZEs2d1NrbXlkczZUOENM?=
 =?utf-8?B?R1pPa1ROMjhneU1rZDNNYmVlWFFsR0Q4UUtTYjJudkYrTzdtVWZiUUduRDFX?=
 =?utf-8?B?eUFtRVIvM0ZNQitmZ1lBcmRwQzU1b2hGYSs0eXdQb2cyeWJVM3U3Q0xXaUNh?=
 =?utf-8?B?cVA2cVYrTHFESXk0Y01LcWxCb1JLeDV2WlR1Y1dJdmROdjN6Z3Nad0RVYWVk?=
 =?utf-8?B?LzBNRys3d2UrOWlyVGJVOUN0UWJCaHB5TjBNV1BocG1nR1QxUHY5cGlZUDVw?=
 =?utf-8?B?K2huRXkwU3FUOUN1a3h3bVBmdnhxWFZ6SWJnOElrZTRTT0JYMVlhOHJ5djZr?=
 =?utf-8?B?STV5MVlKb05nbHJrVU9OdVp0V2JFczVRQWtYd3haWklqNE9aNjJHbldxenBI?=
 =?utf-8?B?aVB4bkRYRkYyVGNHUldHbDdwam5teW5xaFQrMVpZQ0Y2T3YxNWlueTBzbnBz?=
 =?utf-8?B?TktNZnR0TXRCRXJWNzVhY1RmcUMwaEpsTzhJZnJkNGxycGNJNnVkN2RmNFlF?=
 =?utf-8?B?UDVycmZROUVJbXEwQjdiZi80OEFwZXlpUzh3OU5Id2s3MTBkaUd3MmJVaE5w?=
 =?utf-8?B?Qi91WlRYdzJ6cFJmOXpiQlEyNERnOXZ3bVBHYXl3UXlHL1c0RHk3N3NTam1s?=
 =?utf-8?B?dGRLOXV4VUxOdFdQWGNYMWt1RUVyMm5jRDZ6UnpNaWIzeUM5dWt2M2lFWXBw?=
 =?utf-8?B?SWhDYjR4SnJRbVNVUEVRMUFTTTYrTE9CN1JvMTJSNllxcGllMjRiMkFzTU1G?=
 =?utf-8?B?Z0RXNTlSOXV2UEg4NjdXV25EbnZkL1V3RVorL1ozL1ZWMktidWZudG9xdDhO?=
 =?utf-8?B?aThUNG5jemJwd3cxVHJmZWJ1UTdlSExZd242QjVsajVTQ2lMWFhjOFgwNlNV?=
 =?utf-8?Q?3+AqYdAlIh61x/FIjY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3BYdW9DZVMwamNEOTh4T21NSDJ3U2RjOTRteFFOaTBMOWk5TTJzcUlKTytn?=
 =?utf-8?B?NTJPbkZrZ3ZIbWQ0SE5CZmhHT2NlOFJJTlg4L0NSeXhXY0RBSldkcVNpQzRY?=
 =?utf-8?B?SDhMT1JrVlpWYmlJYW9JODg3Q2haOC95S1dGNmphU1IvQWJlbXNTRWdOVnJZ?=
 =?utf-8?B?MU96OXNLcU5ZbEI3WE1EdmxWU0dxMnRBZHdKUVoxbmVnbWhtWksxRE5sWEc2?=
 =?utf-8?B?LzhRSW9WZytvODRoMTk3bnZtMVEvbUVqUThPVWpiMmJkc3puY00rNGpPbDJL?=
 =?utf-8?B?cGhUdGdXaVBwSy9wVVJyNmpnY2pyVWtGZXVSTEg0eHErOE1pdEdqTG4rN2tr?=
 =?utf-8?B?RW1QRGtsRkh1TmNudTdtWlhyUlZkZEFjU1BxZ0did3l0bWdnTkQ2cDZGbTc0?=
 =?utf-8?B?UGlNYk14TXh5YmRuVjg1M0s0U0h4TXd0cFpyQXJWQVRRaE82RGt0OGJTQ3V6?=
 =?utf-8?B?VUdsMERlSFkyTjNWcVVjZ0h2cURualpleTBtS3J6RXlxeDVTaHlCZmprM2hZ?=
 =?utf-8?B?aC9PQU9ESjl3WktvVmd1cEIrYVZaL3ZYMk9MTmY4L1pwWmZsU0NDRnRLSDRo?=
 =?utf-8?B?bWxkazVYbFJLYzA2M3hYNW5ueU9leFJjM0FIT21JZG96WFlHZFJNRDcxalla?=
 =?utf-8?B?Q2pwWG80cVpadmlrTjRWak9xYXpObWx2OTVjVXN2VkRUeVcwKzVvUFdiOVhl?=
 =?utf-8?B?MnBWUkRhTDAvK0FIVWtLazRXZGhsbUZNRW5MV0t4YkJBdFIyQlo5NGJ5NXFt?=
 =?utf-8?B?MW02dld0YVliUU94TTB3MzVwVDJHbnZjSXVMVFF5aWtES2FkNjVzYnVtbUVT?=
 =?utf-8?B?WmJ5T3dYMHFvWTh1NEVXWk5ybVZmY0NqOW0zZngzTFNlTjdoYjFRdS9nNmtC?=
 =?utf-8?B?T3JHY3QyYnlrSE9ERHFOZ2FvUmJSUExxbEg0UWtQMU5sdW96c0JjTGQvdzNi?=
 =?utf-8?B?TlVNVmp0TWRrM29FQkpOSHY5R1RIa29BbVgvWHphNE5VdUJPNCtPWWpRaGtP?=
 =?utf-8?B?cmZCeXBxSFdzS1dtWGhnTVRsSkZxRHYxd2FDQzJ1MFRvaWFHZDRUVlljK3l2?=
 =?utf-8?B?bk1kdlhJS3dwblJGS2tPdktEbTZaeGc0aDhCQzZwWDc0bHZCMGhvQXM1SFdR?=
 =?utf-8?B?SEdxdlhjbzBFR2txTmExcFhsVm1MVU5CYnFjTzBldE1YUDZ0L3BEYXFENjIr?=
 =?utf-8?B?MkpHaUgvZEQzSUFPeEIyNVJFQTIyY0hpeVJ2UG1lTUlDa1J6WEJWL0tjOHox?=
 =?utf-8?B?ZHE3OVBNMkthTDNJY0libG1md3o3eVZSVE5JTk9uQUJRYzRsVnlPZnhrMzRq?=
 =?utf-8?B?QXpxMzhwQTdSQjF0cU1wbkNTMWdGdkRqK1JtTkV0SVFndnVYdktGOGtrVThz?=
 =?utf-8?B?U2JFbncwdFFGbjlpU0lrSEd3NjJvSUxqZHJaVmtqQ3pweHZ5ZDRkWjZ4VHFv?=
 =?utf-8?B?OEdta2tFRXhtZk1OeHNRTHYzQ1ZKYjZjVHVNNzY4TzBEUnBoNmVoSlA4MTIx?=
 =?utf-8?B?ZnZHdU9ieFlidGxpbGlrOWdad05HWDJoa0UvYTgySmVZUE1sWUNkRnpFWjYv?=
 =?utf-8?B?NjJpN3Z0eGozYTNPOHVZeS9IMXdEMHU2Z2lGMWdaS29UWGNkcEdqZXJPRHlX?=
 =?utf-8?B?QVh0QUJkTGx1SFBaZUVqK2ppbVlsTW5tREYzQXJJTDAwNDFUSkQ0c3M3VkJI?=
 =?utf-8?B?LzBMTVhXb2owczk1YzdiZnE5Rm8yNjd4VTBwR1pkbU5takswSGRyS29Dclk5?=
 =?utf-8?B?MlpxNGQ3amZ0ZUJEWXZLcnRjTEtVKzYySHJ5ZHZBTWl5a0JXczVtYmYwbHM3?=
 =?utf-8?B?QlpzdjZiNjB4OVp4MnU1bVV5bXlkZ0VtM3JtdDFGV041N2RhRWtWU0M0M2hm?=
 =?utf-8?B?Qm5HQm1BZjlEOVZmM0krTnhEaU5xc0xmdHBPZ2I5MzdZaWw3UjFGYmpzRXhG?=
 =?utf-8?B?Q25zNXQwQnJ2THlMNlkrQTRtOFl6MUdOc1hiVnNKV2hvVVFGSlgxemVXZU1S?=
 =?utf-8?B?azZPazhrVmdkQ2drYnFBQ3JxVHkwZUtqRUh2QnRobi95bDVoS3FSVy9OUUhW?=
 =?utf-8?B?bTQ2dm1QWFBrVlR5eDJjZ3ZMRzZzOFpieSsrVTV0MDJkWlNlY3FJMUZzYWVU?=
 =?utf-8?B?M0RQRTVGcTFQUXNaWDNkS2FsYzltcCtSTnFjN1E4Zkh1emJVdmVIVjJJNjJJ?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E23586733B57B24CB71CFF37131404CF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b4289b-02fc-4ba4-fc98-08dc7bab6dae
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 04:38:58.9426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MYgCZ6uOd8bgWjmQTJOXIDqtmex+Ts5vnpf3Sga2SSPghlC0hCJ76EwkDx++lXcMzjXfiwy7ttQOvnDI7b9obVzH3EA6aJXjcWueRfcXOSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7413
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.153200-8.000000
X-TMASE-MatchedRID: CML2QBp/u5TUL3YCMmnG4ia1MaKuob8PfjJOgArMOCZVnlXbJ/yBmsLm
	p4jPUF8tqfqaPd9j/B5dnm0FfuSykr2bzku6Foxm0Xw0ILvo/uUjkrgJ37Rqj+DDaaUo0WXQT/d
	mRd5jU4CwNKmrJljjNNdeeSVkMBdJQ3rgNn7o6BVIRA38P/dwbj49+ukeLY91VI7KaIl9NhfImJ
	UezF9c+DXbr7+yAv7iwivlVkVEYOJUHnl2REyzzB+WEMjoO9WWbbJe5V+4LlJLgo8+IIHbcFBoo
	oH1dbXg/H13OX809gh+WREjl9udEqPBPcIql37oB7TqRAYVohbJ5SXtoJPLyAppfQKZjI9nk66/
	gtVjZsWqO3P3SPRU+XTknTo0IKBZmNUnbH74NQuL+98BLtDcez4H4hoqLeJJxSZxKZrfThNoXb2
	Nk/Zfl8vuusssvZ6c9p8IfppiH3baVScbiljcbPp1plqEbuqxieyBFTE1+ceY/Ue6G7XIMnf9IJ
	1pa64HvraAq8G66T513TkHObNXgYjQo/Iw2s1SliwpJdZauwcpWss5kPUFdBaPqOMEqiT0sYKQL
	FUbB7tSQhM6YLEQScAXJwvxia7WXHEPHmpuRH3SBVVc2BozSlkMvWAuahr8+gD2vYtOFhgqtq5d
	3cxkNQP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.153200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	E4095FB9BDC312C3F7A4EE013279D3AD11934C2755DD4C6FCA7A2FF0245CD2A22000:8

T24gVHVlLCAyMDI0LTA1LTIxIGF0IDE5OjIwICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
PiA+ID4gKy8qIFNldHVwIExFRCAqLw0KPiA+ID4gPiArcGh5X3NldF9iaXRzX21tZChwaHlkZXYs
IE1ESU9fTU1EX1ZFTkQyLCBNVEtfUEhZX0xFRDBfT05fQ1RSTCwNCj4gPiA+ID4gKyBNVEtfUEhZ
X0xFRF9PTl9QT0xBUklUWSB8IE1US19QSFlfTEVEX09OX0xJTksxMCB8DQo+ID4gPiA+ICsgTVRL
X1BIWV9MRURfT05fTElOSzEwMCB8IE1US19QSFlfTEVEX09OX0xJTksxMDAwIHwNCj4gPiA+ID4g
KyBNVEtfUEhZX0xFRF9PTl9MSU5LMjUwMCk7DQo+ID4gPiA+ICtwaHlfc2V0X2JpdHNfbW1kKHBo
eWRldiwgTURJT19NTURfVkVORDIsIE1US19QSFlfTEVEMV9PTl9DVFJMLA0KPiA+ID4gPiArIE1U
S19QSFlfTEVEX09OX0ZEWCB8IE1US19QSFlfTEVEX09OX0hEWCk7DQo+ID4gPiA+ICsNCj4gPiA+
ID4gK3BpbmN0cmwgPSBkZXZtX3BpbmN0cmxfZ2V0X3NlbGVjdCgmcGh5ZGV2LT5tZGlvLmRldiwg
ImkycDVnYmUtDQo+ID4gPiBsZWQiKTsNCj4gPiA+IA0KPiA+ID4gQ2FsbHMgdG8gZGV2bV9waW5j
dHJsX2dldF9zZWxlY3QoKSBpcyBwcmV0dHkgdW51c3VhbCBpbiBkcml2ZXJzOg0KPiA+ID4gDQo+
ID4gPiANCj4gPiANCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L0Mv
aWRlbnQvZGV2bV9waW5jdHJsX2dldF9zZWxlY3QNCj4gPiA+IA0KPiA+ID4gV2h5IGlzIHRoaXMg
bmVlZGVkPyBHZW5lcmFsbHksIHRoZSBEVCBmaWxlIHNob3VsZCBkZXNjcmliZSB0aGUNCj4gbmVl
ZGVkDQo+ID4gPiBwaW5tdXggc2V0dGluZywgd2l0aG91dCBuZWVkZWQgYW55dGhpbmcgYWRkaXRp
b25hbGx5Lg0KPiA+ID4gDQo+ID4gVGhpcyBpcyBuZWVkZWQgYmVjYXVzZSB3ZSBuZWVkIHRvIHN3
aXRjaCB0byBpMnA1Z2JlLWxlZCBwaW5tdXgNCj4gZ3JvdXANCj4gPiBhZnRlciB3ZSBzZXQgY29y
cmVjdCBwb2xhcml0eS4gT3IgTEVEIG1heSBibGluayB1bmV4cGVjdGVkbHkuDQo+IA0KPiBTaW5j
ZSB0aGlzIGlzIHVudXN1YWwsIHlvdSBzaG91bGQgYWRkIGEgY29tbWVudC4gQWxzbywgZG9lcyB0
aGUNCj4gZGV2aWNlDQo+IHRyZWUgYmluZGluZyBleHBsYWluIHRoaXM/IEkgZXhwZWN0IG1vc3Qg
RFQgYXV0aG9ycyBhcmUgdXNlZCB0bw0KPiBsaXN0aW5nIGFsbCB0aGUgbmVlZGVkIHBpbnMgaW4g
dGhlIGRlZmF1bHQgcGlubXV4IG5vZGUsIGFuZCBzbyB3aWxsDQo+IGRvDQo+IHRoYXQsIHVubGVz
cyB0aGVyZSBpcyBhIGNvbW1lbnQgaW4gdGhlIGJpbmRpbmcgYWR2aXNpbmcgYWdhaW5zdCBpdC4N
Cj4gDQpUaGVuIEknbGwgYWRkIGNvbW1lbnRzIGFuZCByZW1vdmUgInJldHVybmluZyBlcnJvciBp
ZiBwaWNudHJsIHN3aXRjaGluZw0KZmFpbHMiIGxpa2UgdGhpczoNCi8qIFN3aXRjaCBwaW5jdHJs
IGFmdGVyIHNldHRpbmcgcG9sYXJpdHkgdG8gYXZvaWQgYm9ndXMgYmxpbmtpbmcgKi8NCnBpbmN0
cmwgPSBkZXZtX3BpbmN0cmxfZ2V0X3NlbGVjdCgmcGh5ZGV2LT5tZGlvLmRldiwgImkycDVnYmUt
bGVkIik7DQppZiAoSVNfRVJSKHBpbmN0cmwpKSB7DQoJZGV2X2VycigmcGh5ZGV2LT5tZGlvLmRl
diwgIkZhaWwgdG8gc2V0IExFRCBwaW5zIVxuIik7DQp9DQoNCkFjdHVhbGx5IGN1cnJlbnQgZHJp
dmVycy9uZXQvcGh5L21lZGlhdGVrLWdlLXNvYy5jIGhhcyB0aGUgc2FtZQ0KbWVjaGFuaXNtLCB3
aGljaCB1dGlsaXppbmcgZ2JlLWxlZCBwaW5tdXggZ3JvdXAgaW4NCm10Nzk4OF9waHlfZml4X2xl
ZHNfcG9sYXJpdGllcygpOg0KDQovKiBPbmx5IG5vdyBzZXR1cCBwaW5jdHJsIHRvIGF2b2lkIGJv
Z3VzIGJsaW5raW5nICovDQpwaW5jdHJsID0gZGV2bV9waW5jdHJsX2dldF9zZWxlY3QoJnBoeWRl
di0+bWRpby5kZXYsICJnYmUtbGVkIik7DQppZiAoSVNfRVJSKHBpbmN0cmwpKQ0KCWRldl9lcnIo
JnBoeWRldi0+bWRpby5idXMtPmRldiwgIkZhaWxlZCB0byBzZXR1cCBQSFkgTEVEDQpwaW5jdHJs
XG4iKTsNCg0KQWN0dWFsbHkgdGhvc2UgcGlubXV4IGdyb3VwcyBleGlzdCBpbiBkcml2ZXJzL3Bp
bmN0cmwvbWVkaWF0ZWsvcGluY3RybC0NCm10Nzk4OCBvZiBjdXJyZW50IG9wZW5XUlQgdHJlZToN
Cg0KaHR0cHM6Ly9naXQub3BlbndydC5vcmcvP3A9b3BlbndydC9vcGVud3J0LmdpdDthPWJsb2I7
Zj10YXJnZXQvbGludXgvbWVkaWF0ZWsvZmlsZXMtNi4xL2RyaXZlcnMvcGluY3RybC9tZWRpYXRl
ay9waW5jdHJsLW10Nzk4OC5jO2g9OWY5MjkxMTI0NTIyYzkxNmM0ZTkyZjE1OThlMGJlNDRjM2Jh
ZGFkNTtoYj1mMTZkYzRiNDJmYjI2NWFmZmIyMjk4ZTgxNWE3Y2UwYTEzZDYwZGE2DQoNCkkgYmVs
aWV2ZSB0aGlzIHdpbGwgYmUgdXBzdHJlYW1lZCBsYXRlci4NCg0KPiA+ID4gSXQgaXMgYSBiaXQg
bGF0ZSBkb2luZyB0aGlzIG5vdy4gVGhlIHVzZXIgcmVxdWVzdGVkIHRoaXMgYSBsb25nDQo+IHRp
bWUNCj4gPiA+IGFnbywgYW5kIGl0IHdpbGwgYmUgaGFyZCB0byB1bmRlcnN0YW5kIHdoeSBpdCBu
b3cgcmV0dXJucw0KPiBFT1BOT1RTVVBQLg0KPiA+ID4gWW91IHNob3VsZCBjaGVjayBmb3IgQVVU
T05FR19ESVNBQkxFIGluIGNvbmZpZ19hbmVnKCkgYW5kIHJldHVybg0KPiB0aGUNCj4gPiA+IGVy
cm9yIHRoZXJlLg0KPiA+ID4gDQo+ID4gPiAgICAgICBBbmRyZXcNCj4gPiBNYXliZSBJIHNob3Vs
ZG4ndCByZXR1cm4gRU9QTk9UU1VQUCBpbiBjb25maWdfYW5lZyBkaXJlY3RseT8NCj4gPiBJbiB0
aGlzIHdheSwgX3BoeV9zdGF0ZV9tYWNoaW5lIHdpbGwgYmUgYnJva2VuIGlmIEkgdHJpZ2dlciAi
JA0KPiBldGh0b29sDQo+ID4gLXMgZXRodG9vbCBldGgxIGF1dG9uZWcgb2ZmIg0KPiA+IA0KPiA+
IFsgIDUyMC43ODEzNjhdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiA+
IHJvb3RAT3BlbldydDovIyBbICA1MjAuNzg1OTc4XSBfcGh5X3N0YXJ0X2FuZWcrMHgwLzB4YTQ6
IHJldHVybmVkOg0KPiAtOTUNCj4gPiBbICA1MjAuNzkyMjYzXSBXQVJOSU5HOiBDUFU6IDMgUElE
OiA0MjMgYXQNCj4gZHJpdmVycy9uZXQvcGh5L3BoeS5jOjEyNTQgX3BoeV9zdGF0ZV9tYWNoaW5l
KzB4NzgvMHgyNTgNCj4gPiBbICA1MjAuODAxMDM5XSBNb2R1bGVzIGxpbmtlZCBpbjoNCj4gPiBb
ICA1MjAuODA0MDg3XSBDUFU6IDMgUElEOiA0MjMgQ29tbToga3dvcmtlci91MTY6NCBUYWludGVk
Og0KPiBHICAgICAgICBXICAgICAgICAgIDYuOC4wLXJjNy1uZXh0LTIwMjQwMzA2LWJwaS1yMysg
IzEwMg0KPiA+IFsgIDUyMC44MTQzMzVdIEhhcmR3YXJlIG5hbWU6IE1lZGlhVGVrIE1UNzk4OEEg
UmVmZXJlbmNlIEJvYXJkIChEVCkNCj4gPiBbICA1MjAuODIwMzMwXSBXb3JrcXVldWU6IGV2ZW50
c19wb3dlcl9lZmZpY2llbnQgcGh5X3N0YXRlX21hY2hpbmUNCj4gPiBbICA1MjAuODI2MjQwXSBw
c3RhdGU6IDYwNDAwMDA1IChuWkN2IGRhaWYgK1BBTiAtVUFPIC1UQ08gLURJVA0KPiAtU1NCUyBC
VFlQRT0tLSkNCj4gPiBbICA1MjAuODMzMTkwXSBwYyA6IF9waHlfc3RhdGVfbWFjaGluZSsweDc4
LzB4MjU4DQo+ID4gWyAgNTIwLjgzNzYyM10gbHIgOiBfcGh5X3N0YXRlX21hY2hpbmUrMHg3OC8w
eDI1OA0KPiA+IFsgIDUyMC44NDIwNTZdIHNwIDogZmZmZjgwMDA4NGI3YmQzMA0KPiA+IFsgIDUy
MC44NDUzNjBdIHgyOTogZmZmZjgwMDA4NGI3YmQzMCB4Mjg6IDAwMDAwMDAwMDAwMDAwMDAgeDI3
Og0KPiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gWyAgNTIwLjg1MjQ4N10geDI2OiBmZmZmMDAwMDAw
YzU2OTAwIHgyNTogZmZmZjAwMDAwMGM1Njk4MCB4MjQ6DQo+IGZmZmYwMDAwMDAwMTJhYzANCj4g
PiBbICA1MjAuODU5NjEzXSB4MjM6IGZmZmYwMDAwMDAwMWQwMDUgeDIyOiBmZmZmMDAwMDAwZmRm
MDAwIHgyMToNCj4gMDAwMDAwMDAwMDAwMDAwMQ0KPiA+IFsgIDUyMC44NjY3MzhdIHgyMDogMDAw
MDAwMDAwMDAwMDAwNCB4MTk6IGZmZmYwMDAwMDNhOTAwMDAgeDE4Og0KPiBmZmZmZmZmZmZmZmZm
ZmZmDQo+ID4gWyAgNTIwLjg3Mzg2NF0geDE3OiAwMDAwMDAwMDAwMDAwMDAwIHgxNjogMDAwMDAw
MDAwMDAwMDAwMCB4MTU6DQo+IGZmZmY4MDAxMDRiN2I5NzcNCj4gPiBbICA1MjAuODgwOTg4XSB4
MTQ6IDAwMDAwMDAwMDAwMDAwMDAgeDEzOiAwMDAwMDAwMDAwMDAwMTgzIHgxMjoNCj4gMDAwMDAw
MDBmZmZmZmZlYQ0KPiA+IFsgIDUyMC44ODgxMTRdIHgxMTogMDAwMDAwMDAwMDAwMDAwMSB4MTA6
IDAwMDAwMDAwMDAwMDAwMDEgeDkgOg0KPiBmZmZmODAwMDgzNzIyMmYwDQo+ID4gWyAgNTIwLjg5
NTIzOV0geDggOiAwMDAwMDAwMDAwMDE3ZmU4IHg3IDogYzAwMDAwMDBmZmZmZWZmZiB4NiA6DQo+
IDAwMDAwMDAwMDAwMDAwMDENCj4gPiBbICA1MjAuOTAyMzY1XSB4NSA6IDAwMDAwMDAwMDAwMDAw
MDAgeDQgOiAwMDAwMDAwMDAwMDAwMDAwIHgzIDoNCj4gMDAwMDAwMDAwMDAwMDAwMA0KPiA+IFsg
IDUyMC45MDk0OTBdIHgyIDogMDAwMDAwMDAwMDAwMDAwMCB4MSA6IDAwMDAwMDAwMDAwMDAwMDAg
eDAgOg0KPiBmZmZmMDAwMDA0MTIwMDAwDQo+ID4gWyAgNTIwLjkxNjYxNV0gQ2FsbCB0cmFjZToN
Cj4gPiBbICA1MjAuOTE5MDUyXSAgX3BoeV9zdGF0ZV9tYWNoaW5lKzB4NzgvMHgyNTgNCj4gPiBb
ICA1MjAuOTIzMTM5XSAgcGh5X3N0YXRlX21hY2hpbmUrMHgyYy8weDgwDQo+ID4gWyAgNTIwLjky
NzA1MV0gIHByb2Nlc3Nfb25lX3dvcmsrMHgxNzgvMHgzMWMNCj4gPiBbICA1MjAuOTMxMDU0XSAg
d29ya2VyX3RocmVhZCsweDI4MC8weDQ5NA0KPiA+IFsgIDUyMC45MzQ3OTVdICBrdGhyZWFkKzB4
ZTQvMHhlOA0KPiA+IFsgIDUyMC45Mzc4NDFdICByZXRfZnJvbV9mb3JrKzB4MTAvMHgyMA0KPiA+
IFsgIDUyMC45NDE0MDhdIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiA+
IA0KPiA+IE5vdyBJIHByZWZlciB0byBnaXZlIGEgd2FybmluZyBsaWtlIHRoaXMsIGluDQo+ID4g
bXQ3OTh4XzJwNWdlX3BoeV9jb25maWdfYW5lZygpOg0KPiA+IGlmIChwaHlkZXYtPmF1dG9uZWcg
PT0gQVVUT05FR19ESVNBQkxFKSB7DQo+ID4gZGV2X3dhcm4oJnBoeWRldi0+bWRpby5kZXYsICJP
bmNlIEFOIG9mZiBpcyBzZXQsIHRoaXMgcGh5IGNhbid0DQo+ID4gbGluay5cbiIpOw0KPiA+IHJl
dHVybiBnZW5waHlfYzQ1X3BtYV9zZXR1cF9mb3JjZWQocGh5ZGV2KTsNCj4gPiB9DQo+IA0KPiBU
aGF0IGlzIHVnbHkuDQo+IA0KPiBJZGVhbGx5IHdlIHNob3VsZCBmaXggcGh5bGliIHRvIHN1cHBv
cnQgYSBQSFkgd2hpY2ggY2Fubm90IGRvIGZpeGVkDQo+IGxpbmsuIEkgc3VnZ2VzdCB5b3UgZmly
c3QgbG9vayBhdCBwaHlfZXRodG9vbF9rc2V0dGluZ3Nfc2V0KCkgYW5kIHNlZQ0KPiB3aGF0IGl0
IGRvZXMgaWYgcGFzc2VkIGNtZC0+YmFzZS5hdXRvbmVnID09IFRydWUsIGJ1dA0KPiBFVEhUT09M
X0xJTktfTU9ERV9BdXRvbmVnX0JJVCBpcyBub3Qgc2V0IGluIHN1cHBvcnRlZCwgYmVjYXVzZSB0
aGUNCj4gUEhZDQo+IGRvZXMgbm90IHN1cHBvcnQgYXV0b25lZy4gSXMgdGhhdCBoYW5kbGVkPyBE
b2VzIGl0IHJldHVybiBFT1BOT1RTVVBQPw0KPiBVbmRlcnN0YW5kaW5nIHRoaXMgbWlnaHQgaGVs
cCB5b3UgaW1wbGVtZW50IHRoZSBvcHBvc2l0ZS4NCj4gDQo+IFRoZSBvcHBvc2l0ZSBpcyBob3dl
dmVyIG5vdCBlYXN5LiBUaGVyZSBpcyBubyBsaW5rbW9kZSBiaXQgaW5kaWNhdGluZw0KPiBhIFBI
WSBjYW4gZG8gZm9yY2VkIHNldHRpbmdzLiBUaGUgQk1TUiBoYXMgYSBiaXQgaW5kaWNhdGluZyB0
aGUgUEhZDQo+IGlzDQo+IGNhcGFibGUgb2YgYXV0by1uZWcsIHdoaWNoIGlzIHVzZWQgdG8gc2V0
DQo+IEVUSFRPT0xfTElOS19NT0RFX0F1dG9uZWdfQklULiBIb3dldmVyIHRoZXJlIGlzIG5vIGJp
dCB0byBpbmRpY2F0ZQ0KPiB0aGUNCj4gUEhZIHN1cHBvcnRzIGZvcmNlZCBjb25maWd1cmF0aW9u
LiBUaGUgc3RhbmRhcmQganVzdCBhc3N1bWVzIGFsbCBQSFlzDQo+IHdoaWNoIGFyZSBzdGFuZGFy
ZCBjb25mb3JtaW5nIGNhbiBkbyBmb3JjZWQgc2V0dGluZ3MuIEFuZCBpIHRoaW5rDQo+IHRoaXMN
Cj4gaXMgdGhlIGZpcnN0IFBIWSB3ZSBoYXZlIGNvbWUgYWNyb3NzIHdoaWNoIGlzIGJyb2tlbiBs
aWtlIHRoaXMuDQo+IA0KVGhhbmtzIGZvciB5b3VyIGNsZWFyIGV4cGxhbmF0aW9uLg0KDQo+IFNv
IG1heWJlIHdlIGNhbm5vdCBmaXggdGhpcyBpbiBwaHlsaWIuIEluIHRoYXQgY2FzZSwgdGhlIE1B
QyBkcml2ZXJzDQo+IGtzZXR0aW5nX3NldCgpIHNob3VsZCBjaGVjayBpZiB0aGUgdXNlciBpcyBh
dHRlbXB0aW5nIHRvIGRpc2FibGUNCj4gYXV0b25lZywgYW5kIHJldHVybiAtRU9QTk9UU1VQUC4g
QW5kIGkgd291bGQga2VlcCB0aGUgc3RhY2sgdHJhY2UNCj4gYWJvdmUsIHdoaWNoIHdpbGwgaGVs
cCBkZXZlbG9wZXJzIHVuZGVyc3RhbmQgdGhleSBuZWVkIHRoZSBNQUMgdG8NCj4gaGVscA0KPiBv
dXQgd29yayBhcm91bmQgdGhlIGJyb2tlbiBQSFkuIFlvdSBjYW4gcHJvYmFibHkgYWxzbyBzaW1w
bGlmeSB0aGUNCj4gUEhZDQo+IGRyaXZlciwgdGFrZSBvdXQgYW55IGNvZGUgd2hpY2ggdHJpZXMg
dG8gaGFuZGxlIGZvcmNlZCBzZXR0aW5ncy4NCj4gDQo+IEFuZHJldw0KPiANCkFjY29yZGluZyB0
byB0aGlzLCBJIHRoaW5rIG1heWJlIHdlIG1heSBuZWVkIHRvIHBhdGNoDQpkcml2ZXJzL25ldC9l
dGhlcm5ldC9tZWRpYXRlay9tdGtfZXRoX3NvYy5jIGxhdGVyLiBJJ2xsIGZpeA0KbXQ3OTh4XzJw
NWdlX3BoeV9jb25maWdfYW5lZygpIGxpa2UgdGhpcyBmaXJzdDoNCg0KaWYgKHBoeWRldi0+YXV0
b25lZyA9PSBBVVRPTkVHX0RJU0FCTEUpDQoJcmV0dXJuIC1FT1BOT1RTVVBQOw0K

