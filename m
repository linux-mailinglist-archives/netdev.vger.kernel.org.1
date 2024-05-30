Return-Path: <netdev+bounces-99266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8858D4405
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 05:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2C71C21030
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F373DBB7;
	Thu, 30 May 2024 03:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QyH9PzeZ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="iasr005h"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69E51DDCE;
	Thu, 30 May 2024 03:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039420; cv=fail; b=gRqkv9awbIURN/FMFKtbblzVKSf79Et1j+kHDXOADDuQZI/i7i4Dj/31jm7zspohd0xjSpwq51xv5UGIzPg9TJIVVYxWx22DZ8zivzIVplOUaSNYtEWR9/yi8RgsXdfDVNcMnRCbzoGUAKPdJ04qVwHQN/DQ5B60nh4sYlIebjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039420; c=relaxed/simple;
	bh=klTMA5lWdEY50NLOd7X5BeeK6VCBZQiVMWI4QZkvuMc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XVFiJFJYtVVJhI8RlJmZ2GKNAGmssCgxnhoHCdqS4mwG1rE6lYAd17a6uVshmkIkLDm9ojqdZ2KOinFTPlUu3iOvsOLWe9v55J/LmvT52u1Qmt/yym04/Gf0hs2c2iWcU6S8QHCvFnHEyK3nXdwUfQZ3ZDJvi3/DycZgIm3SPBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QyH9PzeZ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=iasr005h; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ff4aefd81e3311efbfff99f2466cf0b4-20240530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=klTMA5lWdEY50NLOd7X5BeeK6VCBZQiVMWI4QZkvuMc=;
	b=QyH9PzeZI8chupUHdHHa7Y1YEo1YUi9N/Nqd3eLbqQHdJqntZJGZSypYUhE2RPD1BSZPhDn7AgFSohmm3+D0vZR3xfabdVDbFBA9vJn3oRcKKHSjwyFzQA5emTYZ3xMQ/jWXbiWgbjRg74RL47mdehzcN0KBzSjXxqj4+6VTDuw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:69d6e03c-a24f-40b1-a28c-1e64b72659f2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:e9487d84-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ff4aefd81e3311efbfff99f2466cf0b4-20240530
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2091242919; Thu, 30 May 2024 11:23:34 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 May 2024 20:23:33 -0700
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 30 May 2024 11:23:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHDNpzLoxHTQ20uBX9kMLYe0ogH0F7Sg+wWOKJCTuuUKPkKZQLqF6MV83Jpo1IxVSUZjgZvhgoJqt/CIoO16MEhrXv97VxhZVKT/YeOMCZLIaV+De/7wJrLFqwPBrPlYaN4MEp+XShY6CNrWVSswkuJ357+gB4IeXQoHDBkAA9viKacyThadCSuerpRKXgqrkgk9mC1ebbu+cZxAhrvAcNjmNGUIAS8FlEAwy2w+4cC2FFK/o4sD6/nI9yxGG6E53TBH84rpro1Qr+hTgt4/eebfQ+6dlgwtIeg4gWCxZ9Iq8Ql3MxMmTJ51Y/vOD7rB+scnXVpO2NACCUKp2PAQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klTMA5lWdEY50NLOd7X5BeeK6VCBZQiVMWI4QZkvuMc=;
 b=oDhVepRJYzowb0w7R3lXromZJlgzT5VGwZWqtd98xDyGZPmMz1hovK4UfU5pBt9vMpJewokS4t/eBNXY8RDj9iIWZDltF1718Vq/ewb/X4gh9X5FxZg3gNlFFaZXP+1v7e+h26OBhrMHtA1z7GWH8FvJ3Wk5wAkrLPJy2eaGqz/jJOOGjW1h9BcUshoCzJhWhBCb8pfte+5PwR/Log+Qx40hpsJDJ5aeeICmydA5EwT1nX5tY6tmPcNnMQYeog+MeftBKjLjVBrdxulq/odntLyseZUyTKmvOd5ujKGm09SSxw6MHpsqC8bd+fHdJM7pe30hb4qrkra1P1xX4NWLCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klTMA5lWdEY50NLOd7X5BeeK6VCBZQiVMWI4QZkvuMc=;
 b=iasr005hDMQhakuPVtT+2/t05g/BL1O631aHB7kFXq4i2/n7oJ6LmDkvwTTAqdPLZRFmv6wwBF2i++ZhYQxn+rUEtpommjnVpguw8Tm1TrB0Y8R6UvcU1Anq5m2GH27hXCKgQ5wPCmNPiqt6RKbKZ3y3XQ4Lh4SbuhlRJVpsGsI=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by OSQPR03MB8576.apcprd03.prod.outlook.com (2603:1096:604:275::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.13; Thu, 30 May
 2024 03:23:30 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%3]) with mapi id 15.20.7633.017; Thu, 30 May 2024
 03:23:30 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "horms@kernel.org" <horms@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v4 1/5] net: phy: mediatek: Re-organize MediaTek
 ethernet phy drivers
Thread-Topic: [PATCH net-next v4 1/5] net: phy: mediatek: Re-organize MediaTek
 ethernet phy drivers
Thread-Index: AQHaq2f0hOqtUFWDDE2mdhQgZlXm8LGh40uAgA1HXwA=
Date: Thu, 30 May 2024 03:23:30 +0000
Message-ID: <5ec4de4f38f49d6ff8dc49637ccf6a295f504e13.camel@mediatek.com>
References: <20240521101548.9286-1-SkyLake.Huang@mediatek.com>
	 <20240521101548.9286-2-SkyLake.Huang@mediatek.com>
	 <20240521163639.GB839490@kernel.org>
In-Reply-To: <20240521163639.GB839490@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|OSQPR03MB8576:EE_
x-ms-office365-filtering-correlation-id: 75612103-7f45-48b1-104a-08dc8057e0fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZDgrSW8vUCtrd3pKbDRwcFdyUlBXQitBSCtubU5XTGZnRXJPTkZ5REx3aEVj?=
 =?utf-8?B?cDgrM2xGYkFnUWR6ODJVZi9NaWV6UnRwWE1iUXFoM2cxNElrRzlhbnQrYnF6?=
 =?utf-8?B?VzZQaFMzamQ3cklack42cHhhSUdsQXc3dVJtWGU1K0RZSkdzSXZ6T2ViWWVU?=
 =?utf-8?B?SnV1MEtWZTV1WVNPMmJtaHhiRGc5dUR2VmFNSVhTR1ZDT29iUHJqdWNuTWE4?=
 =?utf-8?B?Z214anRwYnVWUDRGbzFqNkNRMXpma0tSMWs4OTJIYWUvbERFUXZEbHVTNjRt?=
 =?utf-8?B?Skg4U2xyNHBSQ01ka2lwNElWQzhzeDZ6K25QTXRYY1laeUQ5YjhmYTRHZk5E?=
 =?utf-8?B?akF4MGIrMm5lYWdkc3JTc3N4anlHczFzWjZJWnJ3TTkwZENoVlhDMnd0VWQr?=
 =?utf-8?B?enJHcmRPbE1WN3UwTlVZWXl6WXByVEZIbjAxL0dOaUh3VEd1QjBBMU9pekdi?=
 =?utf-8?B?OURmTWNUWVU0K0ZIcVBvRUVrYjQzcG1wODZnTEY4NE1vVUZlMVRVL0IzdE4v?=
 =?utf-8?B?SGVpdnREUUFNcWVDZjFhWlN2MnBvQWw0cmtSaCs0VnJtQ0Zqa0Q2Z2RxcnNj?=
 =?utf-8?B?NWs3Rk1mcjljd1Z0d2g2dkhwekxPVyt4TkNxYnRqRjlzMFdTVDJFQWJNTjMy?=
 =?utf-8?B?dXJ4K25hWi92dG81dStTSEM0Q0I2WHZTejVkUDliQmV3RXF1ckZtSWFqaGt1?=
 =?utf-8?B?QXlQNDRpbVkrZndNc1gweXAzV013Sy9uVXYrM3doYXRFTldXb05aUGZJNTZM?=
 =?utf-8?B?cjdRZkhOQittbDJiR2NYVjlldUpTVm5qTnZKeGZxaDlqei95RTF0Wk5MNHFC?=
 =?utf-8?B?bWpUL3cyZjA0dE50aElKclNoOGVvTnVhaTVDa2xLVmlyZWFmaWNmNDRjcHdw?=
 =?utf-8?B?a2VBY2JLVEx4QTZrekp2cUpSNVp5bUphbHFwK21zVnAxV2FvY1l0Y3o5R3Y5?=
 =?utf-8?B?ViszcWVaZk04S1N3b0l3RTNkSGVldWNQU2JsM244UWZmdThSdDlLMEpqQXFC?=
 =?utf-8?B?YTFaTE91UlZRL25ITFNwTlhiRzMrMHprRGJ1TmloQ1BSQ25MVlJMYVVqa0Vh?=
 =?utf-8?B?ZG9nR0xKV05BQ1pQdkRKVnh1bW1iNDRUM3Z4THFPTjIya0lnNzV2Y3Nqd1hp?=
 =?utf-8?B?TThjaUVUVld2R0dkWkx2MEZ2dFpRMjJPaTFsaG1uRDdkWi9mMDJOWWhnaFRm?=
 =?utf-8?B?cnI3NDUzeENxNjJpQXRMRWhhWDNDSjBuSW5Sa1NhTXUvb241K1hVNXhhQlR6?=
 =?utf-8?B?VXRsdFFpZFdzUG1rOC90ZDUvaE9heFIrTHZ5MGRxUkxoVXBMQjRsaDFoMXg4?=
 =?utf-8?B?Q241dDljaWtza1FIVkg0citYdVlOdGloZUJKRDlaWFpWWVFwV1lMYzZ1V2g4?=
 =?utf-8?B?eE1LcWJtamphMERFSWV3d1AxSDhTenpsS3U1TzRwOTEvbUFjbVNhR3VONGw1?=
 =?utf-8?B?ZFZKNW5GSkNaclV1U0JjK2YxR2hCMlNZcHhpNWFNbUF6dVpyUmZlZFlFd1BY?=
 =?utf-8?B?d0pOeUNIUnBJNENaVzFtNmtybnFoalZqeWFQcVlpRmxLL1ZxNWVwNWt2Y1ZC?=
 =?utf-8?B?REFkNERNZmJxcVAzZnVvOWgvMGNlbjNhcnJNdDdkQW94WHVZS0hpUDdYUGZG?=
 =?utf-8?B?UlhmZlV2OWU1M2pBSU9obVlvY0tBdlBtRSs3czRRQ0d1dVc3OFE5MS9RenZU?=
 =?utf-8?B?VTVUMThGR1RuZklzTCs1WlhEeXQ2Nmo0WlJVczBIcGFCRkZzNHhiTjU3RkQ1?=
 =?utf-8?B?Wk9qVkxBUC9SQ21qRkhlNFRVeWN3NTFTOGpQL29uRTlBUGRMeGJDazVIcERk?=
 =?utf-8?B?QThUelZ3VXIyeklhaGs3Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWFrMDQ5MjF4VWNqbWNMNTBOdGJoV0xMbmdRM2NkNXpNZWUvVUJoQjRwNW54?=
 =?utf-8?B?VmZSUHlwUDZ1WTV3VUpRU2RGcmNFNGhEMS9jclh6bjNrVWlNSWJKQVFQUzEv?=
 =?utf-8?B?clFFZ2N2Nnc2ZFgvcmlMenM0ejZPcTVYV0F5TjBYclRKcUxEMC9uakhuSWtv?=
 =?utf-8?B?cHRzcHplTHhYMzRGYWlvOStMNjVwU2tHbEN0eTZLbmk4RklxWEJzZjQxUTRh?=
 =?utf-8?B?RFFObzQrUnhUZHloNXlUZWxiYUc0SjlTemYxNVlIblhpYWo3U0FSdG9SRzVM?=
 =?utf-8?B?Ty83WFgvdjNSaWdSZUNSeHB5azFpZ0FnSURGaHowNzE1RC9GL2xRK2Ezbm14?=
 =?utf-8?B?RWRJM3VHbElMNWFFS2MwSXVMdlpsanV0RDFPUURJL0dncG1NSnpQZmlpTkFB?=
 =?utf-8?B?VnZPd2dYayt0WVNMbzR6ZktxWXd2aThPS2hSZ2FVSGYwd3h3REQ1aEkyQ2Rw?=
 =?utf-8?B?SW0rZWp6Z3RuaE9tK3RIZUNmcjFSa0JCTVNlZzJyWjdWeitIaTE3djV3Q3dQ?=
 =?utf-8?B?OG9pa3ZJWWJrVUpZV2x3clFpR3RjckVKVjVvZXdwTmsxWmhVSjljMGxBTWdN?=
 =?utf-8?B?eDl4dm9pRmVnNEcvTTBRM0NlcWp2MnoycUdjZ2doNU15WTI0NnFzVTBvVUV2?=
 =?utf-8?B?VjBES2JPOEcyM0dVbFZnNmJ4anR3bGhmTkR4Wkh4UXFWSjgrajZmZ2NETlQ2?=
 =?utf-8?B?dzVZaWFXM29vMEthSW84WU5iN2MzTjY2UDRHdUorV2tNTVF3R3FzdnlhQXJF?=
 =?utf-8?B?T3BuVlN5cUlFRnFVNmJhTlRwMWxCQTFTZGpLR1JOTXhJMHkybnJKSjdxWjJ5?=
 =?utf-8?B?Rm80RS9EWUpGUlZWZEtVTDVtekVPUkI5WGRuTCtvaDYwTHNpVUhkNnZLbzBS?=
 =?utf-8?B?U3krQ3lLbUJKTHUrWVZxRHU2NDJPbWt2YjNPdk5wWXhTOFNqeXVJYmhrUzF4?=
 =?utf-8?B?eTBrRXcrS2dXZmlpZ1RiUTgrVVE5TjI2NU9KbFBsQ011RS9jcjdNU3pWRVpB?=
 =?utf-8?B?YlJQd0JNdkszUk5JQW9mK1hzTWUzOWkrT1dxeGlGZjZ3T3JQV0FXUWk1QmVD?=
 =?utf-8?B?N3VkZHJXWG5QcktaMER3YVF6VEZLcVQyeXpmUWR5UjVob3lxMThzMTBWTUhs?=
 =?utf-8?B?MjJVeW9UWnlINUMwakpVdExmSnFUWE52Zk8wRXdDTEtwSWlXV2ZHWUx5V1pX?=
 =?utf-8?B?SjhrRGhoNFVUaFptZ2FxVFZiUVU1MjllZlU3RHdSdjJkakJXZUIvY2ZUNVls?=
 =?utf-8?B?UmI5d3o4RDlqL3loQ2Z1M3UyRVJaS0drVG85OG9JT3EzaUR5RTM0L1BTRGx3?=
 =?utf-8?B?MWw0MDYxbUtPRFBMMURqaS9lMkRpU2tKRTJxWnRhU2JyWHYrU1VPVmM5cjJq?=
 =?utf-8?B?TFlzWVpVck1kbFFGSGNLRG4wRVhKT0lGQnZ1U3p4VHBLaGZ4RWNvUUFja0c0?=
 =?utf-8?B?eGkvbnVxUDdlODlZaVhQKzBnQXJ5VmNST04rTENDU2Vid2NOT1pNeE10VDBN?=
 =?utf-8?B?WHh2d0FSQjNwUjg5SUpZV0c5OHdJVXkzdy9COExVUmtvU3R2VzZSK2xDZ0NI?=
 =?utf-8?B?U0ZHbVl3ZDRYaktvNnp0SWZIQzJTRlV5SDRKVFJiMUFhUlJXdFBzWGhmYjFS?=
 =?utf-8?B?VENzbGl1OFNoSTlRVU1Fc2ZENUZOYUFzb1JwSnh0eCtCYTdZdGxBYnNZZm9L?=
 =?utf-8?B?dUFFeVloczdKYk9BWHlpRXJveEhadkNCQXV4SkhNL3ZoR3ZBOU05WE9vekpQ?=
 =?utf-8?B?Z1lHa1I1VWJ4a3hpZGlZZ3B1VFlFQ3dTQzdLblpEeFd4NzdYRS9vbmduSXds?=
 =?utf-8?B?cmpGZmRJNzVWaGpjL01BcjRBc05VMEJGdUV4MVBhT3UyMmlYWlVRY25CeW9B?=
 =?utf-8?B?eDFBcVZBUTFJOVAwd3Z1eDlSOGNjcXdCZGJyZVIwVkFHclBjM2Qya21sWHEw?=
 =?utf-8?B?Y25iNmRIMEtYNHROL2psZnNHb0s0a2xqakQyVDE4ZXFmSEVwUHArRzM1Kzli?=
 =?utf-8?B?OWNuQkNRL0F2OFljOUF6UitIMmR0bHlHOWFPR0NONDl4MUtGWnRtMkZndEd2?=
 =?utf-8?B?VjhMa2grS29XRnlzeXJoUUdnWmx1bHRvZk1jcmtFNy9XN1BnVitMa1VBaGlU?=
 =?utf-8?B?R3dkL1JWZk84bDFSK0RjYXZEWUFRNklNc25rMnNSMlRmeG5yaUtrbjdndnY1?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D45A22596ADE24B9FADD3C339783FB6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75612103-7f45-48b1-104a-08dc8057e0fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 03:23:30.4611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u3tANbobE1/Nr+g7/3kT7oQKu9+FBTkrMLD3lf2ZbM5cOsGjh1ytgISe5c7O513Efu1UlmxjVou4qlB7a59NkHfbOzXVX9k8ES6mVGFo4Ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8576

T24gVHVlLCAyMDI0LTA1LTIxIGF0IDE3OjM2ICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3BoeS9tZWRpYXRlay9LY29uZmlnDQo+IGIvZHJp
dmVycy9uZXQvcGh5L21lZGlhdGVrL0tjb25maWcNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+IGluZGV4IDAwMDAwMDAuLjJmYTNhNzgNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIv
ZHJpdmVycy9uZXQvcGh5L21lZGlhdGVrL0tjb25maWcNCj4gPiBAQCAtMCwwICsxLDIyIEBADQo+
ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPiA+ICtjb25maWcg
TUVESUFURUtfR0VfUEhZDQo+ID4gK3RyaXN0YXRlICJNZWRpYVRlayBHaWdhYml0IEV0aGVybmV0
IFBIWXMiDQo+ID4gK2hlbHANCj4gPiArICBTdXBwb3J0cyB0aGUgTWVkaWFUZWsgbm9uLWJ1aWx0
LWluIEdpZ2FiaXQgRXRoZXJuZXQgUEhZcy4NCj4gPiArDQo+ID4gKyAgTm9uLWJ1aWx0LWluIEdp
Z2FiaXQgRXRoZXJuZXQgUEhZcyBpbmNsdWRlIG10NzUzMC9tdDc1MzEuDQo+ID4gKyAgWW91IG1h
eSBmaW5kIG10NzUzMCBpbnNpZGUgbXQ3NjIxLiBUaGlzIGRyaXZlciBzaGFyZXMgc29tZQ0KPiA+
ICsgIGNvbW1vbiBvcGVyYXRpb25zIHdpdGggTWVkaWFUZWsgU29DIGJ1aWx0LWluIEdpZ2FiaXQN
Cj4gPiArICBFdGhlcm5ldCBQSFlzLg0KPiA+ICsNCj4gPiArY29uZmlnIE1FRElBVEVLX0dFX1NP
Q19QSFkNCj4gPiArYm9vbCAiTWVkaWFUZWsgU29DIEV0aGVybmV0IFBIWXMiDQo+IA0KPiBIaSwN
Cj4gDQo+IFRoaXMgcGF0Y2ggY2hhbmdlcyB0aGlzIGtjb25maWcgb3B0aW9uIGZyb20gdHJpc3Rh
dGUgdG8gYm9vbC4NCj4gDQo+IFRoaXMgc2VlbXMgdG8gYnJlYWsgYWxsbW9kY29uZmlnIGJ1aWxk
cy4NCj4gDQo+IEkgdGhpbmsgdGhhdCBpcyBiZWNhdXNlIE1FRElBVEVLX0dFX1NPQ19QSFkgaXMg
YnVpbHRpbiB3aGlsZQ0KPiBQSFlMSUIgaXMgYSBtb2R1bGUsIGFuZCB0aGlzIGRyaXZlciB1c2Vz
IHN5bWJvbHMgZnJvbSBQSFlMSUIuDQo+IA0KDQpTb3JyeSB0aGlzIHdhcyBteSBmYXVsdC4gSSds
bCBjaGFuZ2UgaXQgYmFjayB0byB0cmlzdGF0ZSBpbiB2NS4NCg0KU2t5DQo=

