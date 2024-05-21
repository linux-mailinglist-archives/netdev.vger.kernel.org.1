Return-Path: <netdev+bounces-97304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015E98CAA7D
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 11:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6873D1F2263D
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 09:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FFE56440;
	Tue, 21 May 2024 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="I1Ird2/m";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ssSI94l8"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E543856766;
	Tue, 21 May 2024 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716282471; cv=fail; b=Ae+z7K6OhxjkyQxAejP9X9i2D8c2yzMj91JuRzPtaWvkpscGHmcvNEiPeJ5myewmMtVsCCCPuMzUMg7Ui2Gr3MmlEtppL0aYpXYXPsLPh2kTERC3dXkKYmnwsgYbFXiYq02Pqr4wkknse1pJrSuZ4RTA/qN0I2odM+WL+Hn7hbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716282471; c=relaxed/simple;
	bh=mjf8EQQOZEGfHAer+V2Np4s9QMmFmN1J00DAu9hnPqs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XDUZttMVCGdNFotjOqgpOcOVu33B6lr+2SYLJWV/y3OMFk9qoZ90lSQic6f5ZnquTYQOwhNYw/8Pmus1f7nKoJLrwZkYoAseURjX/dSAO6SO+4NmgtQpR0XeymwJRvhdIGvmwhEc0xT9AePnqwdCfluNT4a50h5FNQajQHU4qSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=I1Ird2/m; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ssSI94l8; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 93b2ed22175111ef8065b7b53f7091ad-20240521
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mjf8EQQOZEGfHAer+V2Np4s9QMmFmN1J00DAu9hnPqs=;
	b=I1Ird2/mR0VsLihP0u26U53mb3So4zKn8yiqTNyKedOEzvso0bTwhoYjaSZj55RXBARVm4/Nt2CyK8z+0IPA1nDkK68VSp7BdtbRXvIO8nqdY6fITNjJivPR+1sd5oK6zAuH4tubQ4awG5eIYfusRNKjkZiW452WaM78GQ/c3QU=;
X-CID-CACHE: Type:Local,Time:202405211617+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:2c0e2f62-7848-4c8d-b04d-75cde9aa3906,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:000d9f87-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 93b2ed22175111ef8065b7b53f7091ad-20240521
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1500193386; Tue, 21 May 2024 17:07:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 21 May 2024 02:07:39 -0700
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 21 May 2024 17:07:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCGtUq+KvISThbXqDXMNWAkX+t2M0VNLJRg5MYD510dm8irYWempp+uIx+rOtXit/i3lMmlRXCZix/Qpu5FJUhyRXMg0F1bOKBYdpGJG2BIFH+mTPKXy67dizHP32pRbuz6JjUOfclfT9iDJtVK+2krNzRXnKglTqsqR1XiijkbKyRUEt4mj+BAIWlWC7xUMBUcOncI3wDe8nOdmO7yvqz4OZLePQ3/PdGEkfrwnIXIIBEVus3VxvAKRmWRTJzfpVK6ar0rjHUEyq8fseI6r0doEycWVO2+pTjqLXj0nVu4xP6OWWLwsTWIYkGryn+0Ta6gt6TuRY8KndOvNZbem4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjf8EQQOZEGfHAer+V2Np4s9QMmFmN1J00DAu9hnPqs=;
 b=lkdrICDlgKHjAaSa1+tAae28QpLlTE+UiNtnRTOH96t8ovpmaLiVF0nfXBSIxWGkzUER9nEqk/AfLy93qJ+9oUm/A/44JNIoRitVi/9NvB5VTLwtrKSfrcgd2VvxmA5N2zAI6/+rbCUYdwLATuHp4XysnxHC9e/S36tkKdnYz6wdxKcBro1JCCKlXjv42sly65Zh7TxQWHHTWTJY1I1NBGaFDgunRzjbrl+K9pna/RI/UjonhPAfr6VW4OmyhR4da5Fu/noi85UR/qtZRNgGEd0ZG+Nv33KYSCL+Inl/vvwRFPW/W2r6xwb5jMos6kcYURTJfJRmDHlr2ejWJ9nTWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjf8EQQOZEGfHAer+V2Np4s9QMmFmN1J00DAu9hnPqs=;
 b=ssSI94l8Te76iDOp148XixNpqj7C7rfhwR4P3E2tpCNa/m/8DmKVRhwXwf+d4+e40QjYlngQvSLWTX8fko03IDFsIAUDz7MjPrZ7p9JG7oqR3ZvWaSH5U9tVaZnV+MeAM+jFwd5bldlrBg+WGh4FDa6S4uMciqag98Vh5FdQxds=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SEYPR03MB7697.apcprd03.prod.outlook.com (2603:1096:101:147::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17; Tue, 21 May
 2024 09:07:37 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.7611.013; Tue, 21 May 2024
 09:07:37 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux@armlinux.org.uk"
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
Subject: Re: [PATCH net-next v3 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v3 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Index: AQHaqqo0nm3iQO4q8kqKvRUSCwrNqbGgH2GAgAFH7QA=
Date: Tue, 21 May 2024 09:07:36 +0000
Message-ID: <f7bc69930796b3797dc0e31237267e045a86f823.camel@mediatek.com>
References: <20240520113456.21675-1-SkyLake.Huang@mediatek.com>
	 <20240520113456.21675-6-SkyLake.Huang@mediatek.com>
	 <62b19955-23b8-4cd1-b09c-68546f612b44@lunn.ch>
In-Reply-To: <62b19955-23b8-4cd1-b09c-68546f612b44@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SEYPR03MB7697:EE_
x-ms-office365-filtering-correlation-id: a0cd05a8-e455-4dad-e9e4-08dc79757590
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SnZwOWo4MHlWMWV5ZG94bGJ6YkJqMGpWcUdSenphOFNiQ1E4dVMxRDlWaHhN?=
 =?utf-8?B?Q2dRQkxZbHdkZDZiOVFxK0dwaS94dEQ1UklkV0M1SDJqMXJqb3Z6QWgveDVY?=
 =?utf-8?B?a3laTUlOeTFNMmY4WlNCSkkvcmhsckcrQVNjMFNDOWZVNHBCSXJId1B0eVRu?=
 =?utf-8?B?azhVV3JxSUtWR3lsbXdoVS9jVk42K3hFLzhsZ1VWaThBSFExR1AvOTNrZmYy?=
 =?utf-8?B?QWVWNkZwU0J5TFcrRWJaZDVSSHBxNDNuUHh6MHZ6NXVXRll0N3g5S2ZNUnhx?=
 =?utf-8?B?Uzd6bGRqa2Nhb2FsK0d6TkVWTVd2ejFiSUM3cU9ZdXhCZkw0Z1VFNGw3OWEy?=
 =?utf-8?B?SktoZHpoVUpqY0dxZzZUM0JVM0NQYlVkZm9jdHJnaWFwaUVMMTNpVFZuTVg4?=
 =?utf-8?B?RmJkTFNSajhsYzJCQ253TjZMNzhxRmtnUUhNVjlnQmhVNlEyL0luUnhLYlNJ?=
 =?utf-8?B?bnFvT3FIYUExdzN6NmpMbkFmYmV6WElCbCt0ZmhsalhHUzFsQ2ZyUDNMUzA1?=
 =?utf-8?B?a1k4b25pZU1qdFFURm9ZV1lDUzdPdzZDektDZmpzMTZUeWRuSzMwMktwWlZV?=
 =?utf-8?B?Z1VuV3RCSXlsOGRBQXduNEh5N1lOTkx0VDV4WXFCcDUxVkpCcjBWYnR3VFhH?=
 =?utf-8?B?TGdieDZoSzR4bUUvMkliV3JTcXNDSjFlNmpnTmJNbHJCNVdVZ0podTlUek4r?=
 =?utf-8?B?T2F1ZlhvdGRwY3hFUkJLU1lOTG5EbjB3aVhrTDNSZ3U3cy9QYnJzZXlRQi9W?=
 =?utf-8?B?cTlMOS9mM2VwR29IMStDUU40WUVwTGdFOGZSVG85MTZrVmFNWmd6aTVXSTdS?=
 =?utf-8?B?bW16eFBnazk3U3dPYm1kRjcvaWViVjNGbFNpelRWNDZSRE9FakdYb1VSVjhl?=
 =?utf-8?B?eDZsdkFIa2Y2VTV3c3JVMFBsQm1WMXJkaitiZWkzNFYxaGRFQmd5YTRWdm1s?=
 =?utf-8?B?WnBZTGQ0b1p1U0h1akRET3JoMEFZY21aaHc1UjhjOEdDa0sza3FDclhwZmlZ?=
 =?utf-8?B?YXM3L3BmMEhXNmFobnkvUlFFeU5ISzAvTnFuS1o4bEpneWVJN09TOTdMS2pW?=
 =?utf-8?B?TklaOGRZLytscGVEa2FMNWd5dzA3cm1pY011RktQNkhtTm4zSHpZUDdDUWty?=
 =?utf-8?B?SFVlN1A0SjhWK2NYQklGU3AvOHNhRWtoOCtXR1ozTWw4OXhNbzl5VWhtSjMw?=
 =?utf-8?B?ODJoNmlFQWdMb21qWFB3QWxwRTRqUHZXMEphOEF2YmhqSjBBZ1lzRmRJVkFE?=
 =?utf-8?B?cE8yaU1pVnpWR0Q3N2w0dzlkM0ZJOXNSZ0E3TXl3ZWlNVGFiSGF1OXVmZzVY?=
 =?utf-8?B?VWZTQkw1RWlmM1RkTU5hNUpIbDlvamJiUGMrK0M3b2dpeUNOMDlsWGxlVk54?=
 =?utf-8?B?VFZLYnpRZUNwREh5NmUrelVMNkxZUGpyRmJwS1ZMdFJCZWdiOTl2MmY0aXht?=
 =?utf-8?B?QmNsT2pwaTEraysvNlUxclduUXhWTmFJWUZBdnJSUEwrQXlDOGZXanVZQ3JZ?=
 =?utf-8?B?bUdTL1NBTDZZUDJPbFBYWmt0QkVCaGF4b1hHWnRweHpZdlhuWVF4cU8reWVw?=
 =?utf-8?B?ZEw5MG1HZ3g2aGc5ci9TRkZpb1ZqMjd6Z25aNFhNZmtJbWlJMDBHeGlQOTY4?=
 =?utf-8?B?RnY0M0x0OGFRUGxKdVlpTy93WUYzK3J2dnJKOW04QXpHOTI3dElkVkRLMm1j?=
 =?utf-8?B?OWdFQTdZL0R5SGltRHRhMXMrZjB5YW9lc0tzMmpGK0RaSFJiMlJYZHo0Wm56?=
 =?utf-8?Q?wSL8UsjGafFRQM0pvc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alZHa1IwMUplZlNnUWVZeDdqbUJJZnVRLytwa0xKVFVjSFpqaFNhZjRxUlBl?=
 =?utf-8?B?YUdvR1JBUkxyUkVCV2pjS0VLQUZKODRicmZMR1h4ZEthZEVhM05ESUFMZDAv?=
 =?utf-8?B?OFVZdFA1ejlibFVRZlliRnB0UU92bVNFeWhYTERjTUk4dkR0N0RINDJoSTlF?=
 =?utf-8?B?N1ltSVV2ZHdDbThZUEMrMWRkNG1tWGJVZjg3ZlpQSHhwSHpOeVRYUWRZYktr?=
 =?utf-8?B?WU9UREVxQURGNVhlNmh2KzdZVWx6THZMMG8zZGJGTmt5LzNNUnZpVGZDL01W?=
 =?utf-8?B?dThWK3NBTHdmUVlnbHpsUGxNdjMwV25oTG40SDhhUTIyWEMwV214anBLd0Jq?=
 =?utf-8?B?dGNLNXpLY0F3MGh6K0ZhSDJpUXl1ZC82SHVWa2lKUXFmZ1VNK0tpaEt1aEVy?=
 =?utf-8?B?dXQ3akRRYU9XdUxxREtJUnVNeWJoWUpLNDZIUWw3MmRoYkUvUG1PM3RFNnh3?=
 =?utf-8?B?K2dwVHo5eW9xd0RZbjhGQ1Foa041VFBBbnhKUHRPamE2Z2lOZEQySy84VlAv?=
 =?utf-8?B?QmlRTm4rMjZKems5UlNrRHF2Z21qaFpac1RqMkQxTitGa0FyQ2xOMWJ3aGpC?=
 =?utf-8?B?WU14MU80VXJkYVhGRnA2bXIyTGFubHoyZjVsN0FuUHJlalJMZFlvWHhydEhy?=
 =?utf-8?B?SW9Ld2k5U3d6cjJHcmp1V2tWOFFlV0Q1eEZ2NDlBNjViQW5mRFpxMkg5elhV?=
 =?utf-8?B?d3JhMkk0L3JMckk1azQxT05WdS9YcG5aTk5QRENUdDV1SEZXd29VMGFzbk84?=
 =?utf-8?B?bDRnRUJmVk85NVV2SVNLKzUrcnRkRFNHUHJacWFhbnQzSTN0S2tvK1RvZFph?=
 =?utf-8?B?TnFiU0xOTE9LUHZUcGtJelBXNkZUNEtqbzhUQzh0bWRuRzVWaXdQWW11RHls?=
 =?utf-8?B?Ky84Q3dDakhtTXl4eDBhQmFlQXpRTWZIYXZHbXZLMFp6amVIR2NkWERXRjBk?=
 =?utf-8?B?VDR3Ykk0NnpkZDJrZTh2anJtVHZTVnhzYjFFNzJVZGJWa0sralBzZUNMemhU?=
 =?utf-8?B?TTNxL0xyZEZLL2pVOVIrc3lTMUNtU3hjUHcwZnFCU2libzI5NWpTa0dwZnFG?=
 =?utf-8?B?Y1FwaFVwWGdxRlpibDB2SFh0LzQzRlo3VHpiNzQ4cE9UditCWjFyR2RoVkRW?=
 =?utf-8?B?ZHlBMDdxVmUzQ2FqYytDbGozTG5FNFBTVTIvZVJIcTYxL1hrZHZBWHR4YVVR?=
 =?utf-8?B?Ym1zWGRHS29NMVVpZlVpcW1ZQ2hJU1o2UlRZc1M5bDRUeUpyVVNvWTVBSGRI?=
 =?utf-8?B?WDlIUjFvVWFldnlMZiswbXhvWEJVZlJTRWM4WFFoN09SQ05Zd2l0SVpjN2tx?=
 =?utf-8?B?YXRWam1ibkZtUWFrd1ZPaVljVVRML0cwMllCSU91VVpHTHN4YjlYd0hUaDBT?=
 =?utf-8?B?QUVFbTJlUnhDZmUxaXcvakVoUHV1L3I4ZkU0WkRUT1k3bnR3eG01L05JMWZk?=
 =?utf-8?B?alBqV3Q0VHZIam1TTWx4OGdkRGpJSnpPUGUzU0p2Z0lVaUhBbElVamRCSHUx?=
 =?utf-8?B?QTBTUUxla1I1OTBQdnorWHVOU0p3aFJvbmg0Y2VTMGFRWFRtU2s5elltNHJN?=
 =?utf-8?B?QnRGOCtiMjV1djc3dkllaUZxeXVQNXF5UEpPQ2ttVllOdS80TFR6a0ZJUU9J?=
 =?utf-8?B?QVY3Rm12Qi9RSmwwcm41WC9IclpTbzJkZkQxQzV2R2dxRnJ3ekFYQldZVG9o?=
 =?utf-8?B?YVZnTTZLUjhvUkpueUo1c25id05zSDJVZ0phWFBCZUhiQU5FQUJaTzI1UUVE?=
 =?utf-8?B?TEI1U1kwZlBNYW1QU05vU3JIOXZBSTVUdGpTYkVQRkxkWUVmU3ZVTVgrd29k?=
 =?utf-8?B?V0tXdGpuZVhUb3JpN2sySG9HQmczeS9VWis5U1AyakE1SkJLODR5YXN5L0tB?=
 =?utf-8?B?UTlXRWV5VGozSU5kbzB3QjhsSzZ1dUtBKzd3c3U0alpteFNKSEhxY29zYlVm?=
 =?utf-8?B?NHBJRzl0NEtFZjdOdnkrQUF0d0l5R016RWdUa1B0OVcvc0diS0huTEtVeEVZ?=
 =?utf-8?B?S0w4N0FFZjBPcE8vOTBPMEZub2xJeEU2K3hXcmNNb3N3UFAzNjh6RVB3Qlkv?=
 =?utf-8?B?WU1Jci9VdUFkbDhrQUZiZ2FqYUlsNlp5U2JDbHQ2bEZJYkhDaGdpSUZNaFdm?=
 =?utf-8?B?WkpyK2NoanVhWHZ6Y0RGRGxReFdhZi9qdUs1dVVZcm5ublhlcC9va2lSc1Y3?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF1EC9D7FC79274AB3774830851344A1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0cd05a8-e455-4dad-e9e4-08dc79757590
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 09:07:37.0063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PmttTi44iHRmUbwwY8lecfyf2xgb3CfkXLYU/mWlMVKCJ3qs/hxz6Bhk9iW1ZBEqKo8K6d3f0WIVmlxFJcAVRU3QhV+VZ1QBhkV3RDM9vB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7697

T24gTW9uLCAyMDI0LTA1LTIwIGF0IDE1OjMzICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICA+ICtzdGF0aWMgaW50IG10Nzk4eF8ycDVnZV9waHlfY29uZmlnX2luaXQo
c3RydWN0IHBoeV9kZXZpY2UNCj4gKnBoeWRldikNCj4gPiArew0KPiA+ICtzdHJ1Y3QgbXRrX2ky
cDVnZV9waHlfcHJpdiAqcHJpdiA9IHBoeWRldi0+cHJpdjsNCj4gPiArc3RydWN0IGRldmljZSAq
ZGV2ID0gJnBoeWRldi0+bWRpby5kZXY7DQo+ID4gK2NvbnN0IHN0cnVjdCBmaXJtd2FyZSAqZnc7
DQo+ID4gK3N0cnVjdCBwaW5jdHJsICpwaW5jdHJsOw0KPiA+ICtpbnQgcmV0LCBpOw0KPiA+ICt1
MTYgcmVnOw0KPiA+ICsNCj4gPiAraWYgKCFwcml2LT5md19sb2FkZWQpIHsNCj4gPiAraWYgKCFw
cml2LT5tZDMyX2VuX2NmZ19iYXNlIHx8ICFwcml2LT5wbWJfYWRkcikgew0KPiA+ICtkZXZfZXJy
KGRldiwgIk1EMzJfRU5fQ0ZHIGJhc2UgJiBQTUIgYWRkcmVzc2VzIGFyZW4ndCB2YWxpZFxuIik7
DQo+ID4gK3JldHVybiAtRUlOVkFMOw0KPiA+ICt9DQo+ID4gKw0KPiANCj4gaHR0cHM6Ly93d3cu
a2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9jb2Rpbmctc3R5bGUuaHRtbA0KPiAN
Cj4gICA2KSBGdW5jdGlvbnMNCj4gDQo+ICAgRnVuY3Rpb25zIHNob3VsZCBiZSBzaG9ydCBhbmQg
c3dlZXQsIGFuZCBkbyBqdXN0IG9uZSB0aGluZy4gVGhleQ0KPiAgIHNob3VsZCBmaXQgb24gb25l
IG9yIHR3byBzY3JlZW5mdWxzIG9mIHRleHQgKHRoZSBJU08vQU5TSSBzY3JlZW4NCj4gICBzaXpl
IGlzIDgweDI0LCBhcyB3ZSBhbGwga25vdyksIGFuZCBkbyBvbmUgdGhpbmcgYW5kIGRvIHRoYXQg
d2VsbC4NCj4gDQo+IFRoaXMgaXMgYSBiaWcgZnVuY3Rpb24sIHdoaWNoIGRvZXMgbXVsdGlwbGUg
dGhpbmdzLiBNYXliZSBwdWxsIHRoZQ0KPiBkb3dubG9hZGluZyBvZiBmaXJtd2FyZSBpbnRvIGEg
aGVscGVyLg0KPiANCkFncmVlLiBJJ2xsIG1vdmUgdGhpcyBwYXJ0IHRvIGFub3RoZXIgZnVuY3Rp
b24uDQoNCj4gPiArcmV0ID0gcmVxdWVzdF9maXJtd2FyZSgmZncsIE1UNzk4OF8yUDVHRV9QTUIs
IGRldik7DQo+ID4gK2lmIChyZXQpIHsNCj4gPiArZGV2X2VycihkZXYsICJmYWlsZWQgdG8gbG9h
ZCBmaXJtd2FyZTogJXMsIHJldDogJWRcbiIsDQo+ID4gK01UNzk4OF8yUDVHRV9QTUIsIHJldCk7
DQo+ID4gK3JldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK2lmIChmdy0+c2l6ZSAhPSBN
VDc5ODhfMlA1R0VfUE1CX1NJWkUpIHsNCj4gPiArZGV2X2VycihkZXYsICJGaXJtd2FyZSBzaXpl
IDB4JXp4ICE9IDB4JXhcbiIsDQo+ID4gK2Z3LT5zaXplLCBNVDc5ODhfMlA1R0VfUE1CX1NJWkUp
Ow0KPiA+ICtyZXR1cm4gLUVJTlZBTDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArcmVnID0gcmVhZHco
cHJpdi0+bWQzMl9lbl9jZmdfYmFzZSk7DQo+ID4gK2lmIChyZWcgJiBNRDMyX0VOKSB7DQo+ID4g
K3BoeV9zZXRfYml0cyhwaHlkZXYsIE1JSV9CTUNSLCBCTUNSX1JFU0VUKTsNCj4gPiArdXNsZWVw
X3JhbmdlKDEwMDAwLCAxMTAwMCk7DQo+ID4gK30NCj4gPiArcGh5X3NldF9iaXRzKHBoeWRldiwg
TUlJX0JNQ1IsIEJNQ1JfUERPV04pOw0KPiA+ICsNCj4gPiArLyogV3JpdGUgbWFnaWMgbnVtYmVy
IHRvIHNhZmVseSBzdGFsbCBNQ1UgKi8NCj4gPiArcGh5X3dyaXRlX21tZChwaHlkZXYsIE1ESU9f
TU1EX1ZFTkQxLCAweDgwMGUsIDB4MTEwMCk7DQo+ID4gK3BoeV93cml0ZV9tbWQocGh5ZGV2LCBN
RElPX01NRF9WRU5EMSwgMHg4MDBmLCAweDAwZGYpOw0KPiA+ICsNCj4gPiArZm9yIChpID0gMDsg
aSA8IE1UNzk4OF8yUDVHRV9QTUJfU0laRSAtIDE7IGkgKz0gNCkNCj4gPiArd3JpdGVsKCooKHVp
bnQzMl90ICopKGZ3LT5kYXRhICsgaSkpLCBwcml2LT5wbWJfYWRkciArIGkpOw0KPiA+ICtyZWxl
YXNlX2Zpcm13YXJlKGZ3KTsNCj4gPiArDQo+ID4gK3dyaXRldyhyZWcgJiB+TUQzMl9FTiwgcHJp
di0+bWQzMl9lbl9jZmdfYmFzZSk7DQo+ID4gK3dyaXRldyhyZWcgfCBNRDMyX0VOLCBwcml2LT5t
ZDMyX2VuX2NmZ19iYXNlKTsNCj4gPiArcGh5X3NldF9iaXRzKHBoeWRldiwgTUlJX0JNQ1IsIEJN
Q1JfUkVTRVQpOw0KPiA+ICsvKiBXZSBuZWVkIGEgZGVsYXkgaGVyZSB0byBzdGFiaWxpemUgaW5p
dGlhbGl6YXRpb24gb2YgTUNVICovDQo+ID4gK3VzbGVlcF9yYW5nZSg3MDAwLCA4MDAwKTsNCj4g
PiArZGV2X2luZm8oZGV2LCAiRmlybXdhcmUgbG9hZGluZy90cmlnZ2VyIG9rLlxuIik7DQo+ID4g
Kw0KPiA+ICtwcml2LT5md19sb2FkZWQgPSB0cnVlOw0KPiANCj4gU28gdGhlcmUgaXMgbm8gd2F5
IHRvIGtub3cgaWYgdGhpcyBoYXMgYWxyZWFkeSBoYXBwZW5lZD8gTWF5YmUgdGhlDQo+IGJvb3Rs
b2FkZXIgZG93bmxvYWRlZCB0aGUgZmlybXdhcmUgc28gaXQgY291bGQgVEZUUCBib290PyBMaW51
eCB3aWxsDQo+IGRvd25sb2FkIHRoZSBmaXJtd2FyZSBhZ2Fpbiwgd2hpY2ggaXMgYSB3YXN0ZSBv
ZiB0aW1lLg0KPiANCk5vcm1hbCBNVEsncyBpbnRlcm5hbCAyLjVHcGh5IGZpcm13YXJlIGxvYWRp
bmcgcHJvY2VkdXJlIHdpbGwgYmUgbGlrZToNCjEuIHJlcXVlc3QgZmlybXdhcmUNCjIuIHdyaXRl
IGZpcm13YXJlIHRvIGNvcnJlc3BvZGluZyBtZW1vcnkgYWRkcmVzcyB2aWEgc2J1czJwYnVzKGZh
c3Rlcg0KdGhhbiBNRElPKQ0KMy4gVHJpZ2dlciBNQ1UgdG8gcnVuIGZpcm13YXJlIGJ5IHNldHRp
bmcgTUQzMl9FTiBiaXQuDQoNCiAgICBTbyBsb2dpY2FsbHksIHdlIGNhbiBkZXRlcm1pbmUgaWYg
ZmlybXdhcmUgaXMgbG9hZGVkIGJ5DQpib290bG9hZGVyKFVib290KSBvciBub3QgYnkgcmVhZGlu
ZyBNRDMyX0VOIGJpdCAoc3RlcCAzIGFib3ZlKS4NCkhvd2V2ZXIsIGlmIHN0ZXAyIGlzIGJ5cGFz
c2VkLCBNRDMyX0VOIGJpdCBjYW4gc3RpbGwgYmUgc2V0IGlmIENMMjINCnJlc2V0IChCTUNSX1JF
U0VUKSBpcyB0cmlnZ2VyZWQgYnkgdXNlci4gSW4gdGhpcyBjYXNlLCBpbnRlcm5hbA0KMi41R3Bo
eSdzIE1DVSBpcyBydW5uaW5nIG5vdGhpbmcuDQogICAgVGhhdCBpcyB0byBzYXksIGZvciBzYWZl
dHksIHdlIG5lZWQgdG8gbG9hZCBmaXJtd2FyZSBhZ2FpbiByaWdodA0KYXRmZXIgYm9vdGluZyBp
bnRvIExpbnV4IGtlcm5lbC4gQWN0dWFsbHksIHRoaXMgdGFrZXMganVzdCBhYm91dCAxMW1zLg0K
DQo+ID4gK2lvdW5tYXAocHJpdi0+bWQzMl9lbl9jZmdfYmFzZSk7DQo+ID4gK2lvdW5tYXAocHJp
di0+cG1iX2FkZHIpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICsvKiBTZXR1cCBMRUQgKi8NCj4gPiAr
cGh5X3NldF9iaXRzX21tZChwaHlkZXYsIE1ESU9fTU1EX1ZFTkQyLCBNVEtfUEhZX0xFRDBfT05f
Q1RSTCwNCj4gPiArIE1US19QSFlfTEVEX09OX1BPTEFSSVRZIHwgTVRLX1BIWV9MRURfT05fTElO
SzEwIHwNCj4gPiArIE1US19QSFlfTEVEX09OX0xJTksxMDAgfCBNVEtfUEhZX0xFRF9PTl9MSU5L
MTAwMCB8DQo+ID4gKyBNVEtfUEhZX0xFRF9PTl9MSU5LMjUwMCk7DQo+ID4gK3BoeV9zZXRfYml0
c19tbWQocGh5ZGV2LCBNRElPX01NRF9WRU5EMiwgTVRLX1BIWV9MRUQxX09OX0NUUkwsDQo+ID4g
KyBNVEtfUEhZX0xFRF9PTl9GRFggfCBNVEtfUEhZX0xFRF9PTl9IRFgpOw0KPiA+ICsNCj4gPiAr
cGluY3RybCA9IGRldm1fcGluY3RybF9nZXRfc2VsZWN0KCZwaHlkZXYtPm1kaW8uZGV2LCAiaTJw
NWdiZS0NCj4gbGVkIik7DQo+IA0KPiBDYWxscyB0byBkZXZtX3BpbmN0cmxfZ2V0X3NlbGVjdCgp
IGlzIHByZXR0eSB1bnVzdWFsIGluIGRyaXZlcnM6DQo+IA0KPiANCmh0dHBzOi8vZWxpeGlyLmJv
b3RsaW4uY29tL2xpbnV4L2xhdGVzdC9DL2lkZW50L2Rldm1fcGluY3RybF9nZXRfc2VsZWN0DQo+
IA0KPiBXaHkgaXMgdGhpcyBuZWVkZWQ/IEdlbmVyYWxseSwgdGhlIERUIGZpbGUgc2hvdWxkIGRl
c2NyaWJlIHRoZSBuZWVkZWQNCj4gcGlubXV4IHNldHRpbmcsIHdpdGhvdXQgbmVlZGVkIGFueXRo
aW5nIGFkZGl0aW9uYWxseS4NCj4gDQpUaGlzIGlzIG5lZWRlZCBiZWNhdXNlIHdlIG5lZWQgdG8g
c3dpdGNoIHRvIGkycDVnYmUtbGVkIHBpbm11eCBncm91cA0KYWZ0ZXIgd2Ugc2V0IGNvcnJlY3Qg
cG9sYXJpdHkuIE9yIExFRCBtYXkgYmxpbmsgdW5leHBlY3RlZGx5Lg0KDQo+ID4gK3N0YXRpYyBp
bnQgbXQ3OTh4XzJwNWdlX3BoeV9nZXRfZmVhdHVyZXMoc3RydWN0IHBoeV9kZXZpY2UNCj4gKnBo
eWRldikNCj4gPiArew0KPiA+ICtpbnQgcmV0Ow0KPiA+ICsNCj4gPiArcmV0ID0gZ2VucGh5X2M0
NV9wbWFfcmVhZF9hYmlsaXRpZXMocGh5ZGV2KTsNCj4gPiAraWYgKHJldCkNCj4gPiArcmV0dXJu
IHJldDsNCj4gPiArDQo+ID4gKy8qIFdlIGRvbid0IHN1cHBvcnQgSERYIGF0IE1BQyBsYXllciBv
biBtdDc5ODguIFNvIG1hc2sgcGh5J3MgSERYDQo+IGNhcGFiaWxpdGllcyBoZXJlLiAqLw0KPiAN
Cj4gU28geW91IG1ha2UgaXQgY2xlYXIsIHRoZSBNQUMgZG9lcyBub3Qgc3VwcG9ydCBoYWxmIGR1
cGxleC4gVGhlIE1BQw0KPiBzaG91bGQgdGhlbiByZW1vdmUgaXQsIG5vdCB0aGUgUEhZLg0KPiAN
Cj4gPiArbGlua21vZGVfY2xlYXJfYml0KEVUSFRPT0xfTElOS19NT0RFXzEwMGJhc2VUX0hhbGZf
QklULCBwaHlkZXYtDQo+ID5zdXBwb3J0ZWQpOw0KPiA+ICsNCj4gPiArcmV0dXJuIDA7DQo+ID4g
K30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgbXQ3OTh4XzJwNWdlX3BoeV9yZWFkX3N0YXR1cyhz
dHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0KPiA+ICt7DQo+ID4gK2ludCByZXQ7DQo+ID4gKw0K
PiA+ICsvKiBXaGVuIE1ESU9fU1RBVDFfTFNUQVRVUyBpcyByYWlzZWQgZ2VucGh5X2M0NV9yZWFk
X2xpbmsoKSwgdGhpcw0KPiBwaHkgYWN0dWFsbHkNCj4gPiArICogaGFzbid0IGZpbmlzaGVkIEFO
LiBTbyB1c2UgQ0wyMidzIGxpbmsgdXBkYXRlIGZ1bmN0aW9uIGluc3RlYWQuDQo+ID4gKyAqLw0K
PiA+ICtyZXQgPSBnZW5waHlfdXBkYXRlX2xpbmsocGh5ZGV2KTsNCj4gPiAraWYgKHJldCkNCj4g
PiArcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gK3BoeWRldi0+c3BlZWQgPSBTUEVFRF9VTktOT1dO
Ow0KPiA+ICtwaHlkZXYtPmR1cGxleCA9IERVUExFWF9VTktOT1dOOw0KPiA+ICtwaHlkZXYtPnBh
dXNlID0gMDsNCj4gPiArcGh5ZGV2LT5hc3ltX3BhdXNlID0gMDsNCj4gPiArDQo+ID4gKy8qIFdl
J2xsIHJlYWQgbGluayBzcGVlZCB0aHJvdWdoIHZlbmRvciBzcGVjaWZpYyByZWdpc3RlcnMgZG93
bg0KPiBiZWxvdy4gU28gcmVtb3ZlDQo+ID4gKyAqIHBoeV9yZXNvbHZlX2FuZWdfbGlua21vZGUg
KEFOIG9uKSAmIGdlbnBoeV9jNDVfcmVhZF9wbWEgKEFODQo+IG9mZikuDQo+ID4gKyAqLw0KPiA+
ICtpZiAocGh5ZGV2LT5hdXRvbmVnID09IEFVVE9ORUdfRU5BQkxFICYmIHBoeWRldi0+YXV0b25l
Z19jb21wbGV0ZSkgDQo+IHsNCj4gPiArcmV0ID0gZ2VucGh5X2M0NV9yZWFkX2xwYShwaHlkZXYp
Ow0KPiA+ICtpZiAocmV0IDwgMCkNCj4gPiArcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKy8qIENs
YXVzZSA0NSBkb2Vzbid0IGRlZmluZSAxMDAwQmFzZVQgc3VwcG9ydC4gUmVhZCB0aGUgbGluaw0K
PiBwYXJ0bmVyJ3MgMUcNCj4gPiArICogYWR2ZXJ0aXNlbWVudCB2aWEgQ2xhdXNlIDIyDQo+ID4g
KyAqLw0KPiA+ICtyZXQgPSBwaHlfcmVhZChwaHlkZXYsIE1JSV9TVEFUMTAwMCk7DQo+ID4gK2lm
IChyZXQgPCAwKQ0KPiA+ICtyZXR1cm4gcmV0Ow0KPiA+ICttaWlfc3RhdDEwMDBfbW9kX2xpbmtt
b2RlX2xwYV90KHBoeWRldi0+bHBfYWR2ZXJ0aXNpbmcsIHJldCk7DQo+ID4gK30gZWxzZSBpZiAo
cGh5ZGV2LT5hdXRvbmVnID09IEFVVE9ORUdfRElTQUJMRSkgew0KPiA+ICtyZXR1cm4gLUVPUE5P
VFNVUFA7DQo+ID4gK30NCj4gDQo+IEl0IGlzIGEgYml0IGxhdGUgZG9pbmcgdGhpcyBub3cuIFRo
ZSB1c2VyIHJlcXVlc3RlZCB0aGlzIGEgbG9uZyB0aW1lDQo+IGFnbywgYW5kIGl0IHdpbGwgYmUg
aGFyZCB0byB1bmRlcnN0YW5kIHdoeSBpdCBub3cgcmV0dXJucyBFT1BOT1RTVVBQLg0KPiBZb3Ug
c2hvdWxkIGNoZWNrIGZvciBBVVRPTkVHX0RJU0FCTEUgaW4gY29uZmlnX2FuZWcoKSBhbmQgcmV0
dXJuIHRoZQ0KPiBlcnJvciB0aGVyZS4NCj4gDQo+ICAgICAgIEFuZHJldw0KTWF5YmUgSSBzaG91
bGRuJ3QgcmV0dXJuIEVPUE5PVFNVUFAgaW4gY29uZmlnX2FuZWcgZGlyZWN0bHk/DQpJbiB0aGlz
IHdheSwgX3BoeV9zdGF0ZV9tYWNoaW5lIHdpbGwgYmUgYnJva2VuIGlmIEkgdHJpZ2dlciAiJCBl
dGh0b29sDQotcyBldGh0b29sIGV0aDEgYXV0b25lZyBvZmYiDQoNClsgIDUyMC43ODEzNjhdIC0t
LS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0Kcm9vdEBPcGVuV3J0Oi8jIFsgIDUy
MC43ODU5NzhdIF9waHlfc3RhcnRfYW5lZysweDAvMHhhNDogcmV0dXJuZWQ6IC05NQ0KWyAgNTIw
Ljc5MjI2M10gV0FSTklORzogQ1BVOiAzIFBJRDogNDIzIGF0IGRyaXZlcnMvbmV0L3BoeS9waHku
YzoxMjU0IF9waHlfc3RhdGVfbWFjaGluZSsweDc4LzB4MjU4DQpbICA1MjAuODAxMDM5XSBNb2R1
bGVzIGxpbmtlZCBpbjoNClsgIDUyMC44MDQwODddIENQVTogMyBQSUQ6IDQyMyBDb21tOiBrd29y
a2VyL3UxNjo0IFRhaW50ZWQ6IEcgICAgICAgIFcgICAgICAgICAgNi44LjAtcmM3LW5leHQtMjAy
NDAzMDYtYnBpLXIzKyAjMTAyDQpbICA1MjAuODE0MzM1XSBIYXJkd2FyZSBuYW1lOiBNZWRpYVRl
ayBNVDc5ODhBIFJlZmVyZW5jZSBCb2FyZCAoRFQpDQpbICA1MjAuODIwMzMwXSBXb3JrcXVldWU6
IGV2ZW50c19wb3dlcl9lZmZpY2llbnQgcGh5X3N0YXRlX21hY2hpbmUNClsgIDUyMC44MjYyNDBd
IHBzdGF0ZTogNjA0MDAwMDUgKG5aQ3YgZGFpZiArUEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTIEJU
WVBFPS0tKQ0KWyAgNTIwLjgzMzE5MF0gcGMgOiBfcGh5X3N0YXRlX21hY2hpbmUrMHg3OC8weDI1
OA0KWyAgNTIwLjgzNzYyM10gbHIgOiBfcGh5X3N0YXRlX21hY2hpbmUrMHg3OC8weDI1OA0KWyAg
NTIwLjg0MjA1Nl0gc3AgOiBmZmZmODAwMDg0YjdiZDMwDQpbICA1MjAuODQ1MzYwXSB4Mjk6IGZm
ZmY4MDAwODRiN2JkMzAgeDI4OiAwMDAwMDAwMDAwMDAwMDAwIHgyNzogMDAwMDAwMDAwMDAwMDAw
MA0KWyAgNTIwLjg1MjQ4N10geDI2OiBmZmZmMDAwMDAwYzU2OTAwIHgyNTogZmZmZjAwMDAwMGM1
Njk4MCB4MjQ6IGZmZmYwMDAwMDAwMTJhYzANClsgIDUyMC44NTk2MTNdIHgyMzogZmZmZjAwMDAw
MDAxZDAwNSB4MjI6IGZmZmYwMDAwMDBmZGYwMDAgeDIxOiAwMDAwMDAwMDAwMDAwMDAxDQpbICA1
MjAuODY2NzM4XSB4MjA6IDAwMDAwMDAwMDAwMDAwMDQgeDE5OiBmZmZmMDAwMDAzYTkwMDAwIHgx
ODogZmZmZmZmZmZmZmZmZmZmZg0KWyAgNTIwLjg3Mzg2NF0geDE3OiAwMDAwMDAwMDAwMDAwMDAw
IHgxNjogMDAwMDAwMDAwMDAwMDAwMCB4MTU6IGZmZmY4MDAxMDRiN2I5NzcNClsgIDUyMC44ODA5
ODhdIHgxNDogMDAwMDAwMDAwMDAwMDAwMCB4MTM6IDAwMDAwMDAwMDAwMDAxODMgeDEyOiAwMDAw
MDAwMGZmZmZmZmVhDQpbICA1MjAuODg4MTE0XSB4MTE6IDAwMDAwMDAwMDAwMDAwMDEgeDEwOiAw
MDAwMDAwMDAwMDAwMDAxIHg5IDogZmZmZjgwMDA4MzcyMjJmMA0KWyAgNTIwLjg5NTIzOV0geDgg
OiAwMDAwMDAwMDAwMDE3ZmU4IHg3IDogYzAwMDAwMDBmZmZmZWZmZiB4NiA6IDAwMDAwMDAwMDAw
MDAwMDENClsgIDUyMC45MDIzNjVdIHg1IDogMDAwMDAwMDAwMDAwMDAwMCB4NCA6IDAwMDAwMDAw
MDAwMDAwMDAgeDMgOiAwMDAwMDAwMDAwMDAwMDAwDQpbICA1MjAuOTA5NDkwXSB4MiA6IDAwMDAw
MDAwMDAwMDAwMDAgeDEgOiAwMDAwMDAwMDAwMDAwMDAwIHgwIDogZmZmZjAwMDAwNDEyMDAwMA0K
WyAgNTIwLjkxNjYxNV0gQ2FsbCB0cmFjZToNClsgIDUyMC45MTkwNTJdICBfcGh5X3N0YXRlX21h
Y2hpbmUrMHg3OC8weDI1OA0KWyAgNTIwLjkyMzEzOV0gIHBoeV9zdGF0ZV9tYWNoaW5lKzB4MmMv
MHg4MA0KWyAgNTIwLjkyNzA1MV0gIHByb2Nlc3Nfb25lX3dvcmsrMHgxNzgvMHgzMWMNClsgIDUy
MC45MzEwNTRdICB3b3JrZXJfdGhyZWFkKzB4MjgwLzB4NDk0DQpbICA1MjAuOTM0Nzk1XSAga3Ro
cmVhZCsweGU0LzB4ZTgNClsgIDUyMC45Mzc4NDFdICByZXRfZnJvbV9mb3JrKzB4MTAvMHgyMA0K
WyAgNTIwLjk0MTQwOF0gLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tDQoNCk5v
dyBJIHByZWZlciB0byBnaXZlIGEgd2FybmluZyBsaWtlIHRoaXMsIGluDQptdDc5OHhfMnA1Z2Vf
cGh5X2NvbmZpZ19hbmVnKCk6DQppZiAocGh5ZGV2LT5hdXRvbmVnID09IEFVVE9ORUdfRElTQUJM
RSkgew0KCWRldl93YXJuKCZwaHlkZXYtPm1kaW8uZGV2LCAiT25jZSBBTiBvZmYgaXMgc2V0LCB0
aGlzIHBoeSBjYW4ndA0KbGluay5cbiIpOw0KCXJldHVybiBnZW5waHlfYzQ1X3BtYV9zZXR1cF9m
b3JjZWQocGh5ZGV2KTsNCn0NCg==

