Return-Path: <netdev+bounces-169419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C0DA43CAB
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E908D3A1610
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5899E267B91;
	Tue, 25 Feb 2025 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mu54dzei";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Uh9i8sLG"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0482026770E;
	Tue, 25 Feb 2025 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481224; cv=fail; b=cPFDL+BAppUKKZDLBbnn3OrEGjt8tIZTMvyp4Cs5dfWljCni45QgQnnFuerd5vve+hqr1W7u0VzrOtaIQNBHh5owh3GkrJTxjH88dlfsbc7VQPpfnU8+Qjf+swMQC6KTstMGv3s7fGhL0cg4z7LMaoA2Eu0K7UjIv9KPklA1HjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481224; c=relaxed/simple;
	bh=/6ZgseTjOcZCbprooc/4R4yiplhRiO5tFubmOIT+gFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tviCROBNgd4EBjWvnS8BtsykPeBjNK2qZRrdyC8wx4Li9UB8v/MHYUOxvhglF11JwWRN70oOnY0d0S79OJNrKU0Tb0TnmS9vf+N3npgntLsM4VPp9nQlKpKL9ttzVqDBLvJ8DTfr2Iau47fPdn3WylAD9YDWf0+08vstI1irwg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mu54dzei; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Uh9i8sLG; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: aa9cab02f36711efaae1fd9735fae912-20250225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/6ZgseTjOcZCbprooc/4R4yiplhRiO5tFubmOIT+gFg=;
	b=mu54dzeiFoPHk+GsvzewQU5Ba9ECMYWAf4QlUrCaffqh8tYURTCjtYNoUyGkwdqo1lXyZgTXTx+Ha2uCsHkflukc7XPQ5yCjRgmaJHZDEtZ5semmPoCxB7UuzQu7Xi2lXg5Cj+kz4/gOXBFD+yTpi6V8ZyrhABb9iMdec6SPWB4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:4264cb66-0d49-4d99-9da8-df818d5adb3d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:c3d4e6d9-654e-41f2-8a8e-a96c1e834c64,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: aa9cab02f36711efaae1fd9735fae912-20250225
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1424820420; Tue, 25 Feb 2025 19:00:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 25 Feb 2025 19:00:02 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 25 Feb 2025 19:00:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHyr1WE+UUaZkbnWBW4Z2MbRmnpd6qC2xm7x/SCevQMv9SvvCRWrMNizKVhbwBZpOj/4EcLIu9lxWGIkYHCyZKHB0n9m6rucIL05z671O4CkMvb9nPIB+gmeSNtPPcKy1Xh/jS9fjhNUZDdT0G7iw7WqjP56RxJ2OhpbbdY6qGdG7zHXpWjdiW0Rr/EwfDuitJp4HnhdckoqpUi64D5rUuQHLR7UEHi2V9RsmBBlvSqTHKIqzDAZA39MEossGXL96nbI7tX7a847eZzZHct1tBaghpXdUvnxCirN2pfQ8qvV4C+DB7Qr1RfYLW7v6oR12irWO/UvXPwLMRf3efKK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6ZgseTjOcZCbprooc/4R4yiplhRiO5tFubmOIT+gFg=;
 b=cE8WBry6zBqH9ljJ1yUdbIR5Ir12yYhjrUWQl22zZPmdlpQeihEmkGEiOOZpp1q02GaWORpLwdhqZ9U4ar44jgOPAjtoSMHabkLn9wXWLKv7HvAK5p20/qsxVsjbuYfVAwa7DlnlGWZhkgWsQ1fObn6UWPw2sSQMXTriBS4hSme1dbdJwFNWrErLPKcmfUQh3UkohNgy4MdEUoSITnsMTIrPPi786Z+bh+4knLNRrEAy5F+2I9hXyZYsUL9LpUrpZLWNo5kL9i/1qh5VgAyrlzN7F+8IKNZy6/s5dRtlEUF3UG0knniz84x8wznSYuvAvAe9++K25zDeY6Dh46M0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6ZgseTjOcZCbprooc/4R4yiplhRiO5tFubmOIT+gFg=;
 b=Uh9i8sLGrn/YjbjapugaaJh8UV8HwsJXtLiKu7JxiZ7mB0X0F/fHoE0V9SpA1/Jn/AqGRGgN17dyFImrTkqB5VxK9M9X1G+Xh4Q6KBjM4x0lI3jv5/bJs01hxn+F/2OPV9/XfuUUYmzy36HXQEKqbdlBduV8wXSMGux8QqVMME4=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by OSQPR03MB8697.apcprd03.prod.outlook.com (2603:1096:604:292::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 11:00:00 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 10:59:59 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, =?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?=
	<steven.liu@mediatek.com>, "davem@davemloft.net" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>, "dqfext@gmail.com"
	<dqfext@gmail.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/3] net: phy: mediatek: Add 2.5Gphy firmware
 dt-bindings and dts node
Thread-Topic: [PATCH net-next v2 1/3] net: phy: mediatek: Add 2.5Gphy firmware
 dt-bindings and dts node
Thread-Index: AQHbgqnLe8B1VmttFEm1xmvjplPof7NOv+6AgAABHwCACSJvgA==
Date: Tue, 25 Feb 2025 10:59:59 +0000
Message-ID: <ff96f5d38e089fdd76294265f33d7230c573ba69.camel@mediatek.com>
References: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
	 <20250219083910.2255981-2-SkyLake.Huang@mediatek.com>
	 <a15cfd5d-7c1a-45b2-af14-aa4e8761111f@lunn.ch>
	 <Z7X5Dta3oUgmhnmk@makrotopia.org>
In-Reply-To: <Z7X5Dta3oUgmhnmk@makrotopia.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|OSQPR03MB8697:EE_
x-ms-office365-filtering-correlation-id: d4b0470c-51af-4461-d662-08dd558b8c3d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M2hCRmhBZEFiZHBqbmVodkZkQWJYeGxTQkh6alg4MU1YTVpIKytGTzl3RGsr?=
 =?utf-8?B?WWhXME9TdmpEVzI3OXVTaE8zQmVHckJ2aVFtaDV2VkFlaGk5UkRtT0F1TDVz?=
 =?utf-8?B?ZEdVazVnMHJwT0JNMVk0RmlsSHhZZ25mN2hSSUV3VEFLZHhra0dNeTBwbW82?=
 =?utf-8?B?M3kweUdwa2ZHUlJCZFB6VVFtQkhKK3B4cDcyM0pSSzcxYUtIdXVqVG1FeWRY?=
 =?utf-8?B?NkVYNVh4SDIzeFZmVXZkL3NXN0VFUTVLbDVHUjR3M3ZvMVJ1ekRUaUYwYStq?=
 =?utf-8?B?b1o0SXNsUVNPREdTRzZPYlJvOXVWM1BoT0k3TDZYcnV5R2Q3dlhsa3VqSmRY?=
 =?utf-8?B?ZlFDZVFFSzJYcWNTRExPbkFoMHhua1RVa3czWXhieXAvV1YvN0h6MGwvQmc5?=
 =?utf-8?B?RVJYYmxCNEJ6blhGVXJ2ajVNN2ZIYVU0NDdFcGxlWEk3bkthQ2hjdjY2MHUv?=
 =?utf-8?B?OVgvTWNuc0Y3eVpBRE9iaXdheWthZVU2cFJqQml3eUpoQTBKWFBQZDVFUGpG?=
 =?utf-8?B?K2EwZlhycmFWMHNCZkt2eVk1cXlCb1lnNm95SW9RSHp0YW5TdXlMb3JGaFBX?=
 =?utf-8?B?czcrcHBBTVJYa2VmZnZ1ckh1NGtZWG91OUtGbHdVdlQycDNwdis5bnVKU0JE?=
 =?utf-8?B?Qk9HWXZFT0lUUkVJcWs0b003Q0RYVmR0TWVOUGo0YXhTRGhhVXBIRC9vVjV0?=
 =?utf-8?B?TkJxNmtzaVczeUR1V3ZJRkhkUEUyVjRqTy9SdFlvNWVDZ2tjeGc1SXJMQXNw?=
 =?utf-8?B?OGJ2Q2N0Q3J3c3R3Vi80NHlWZWFWTGh4R2E1RG5ScTFSMmJFOUFheDFTZVd3?=
 =?utf-8?B?MXhpOVJwVHVHVEszSkdDeW91dUJTcU1OTkVoenI0NHVBK0xrTHBFbkQrUVdy?=
 =?utf-8?B?RG9LczBpTHM3bG5PR2d4Y3ZBNkVBaDdMcEg4VnQ5N0RNTDhkcytHUWlwUUxw?=
 =?utf-8?B?bzF2aHlMOHFPeHBKOWlSSmdwN3BOdnhhODhPSjdmU3VCU2hTZ1V3bElkTE5I?=
 =?utf-8?B?UW9Sd2ZGKzUvd0lSN1JuMFc0S3FybzJJUUExa0xpR3htUCtRQThBNkpmdDND?=
 =?utf-8?B?TTRGbVZQWW1SNDN0YnhtZnE1TW1yVjJtSG5FeWRVTVFsM2hySmo1N0tTdFli?=
 =?utf-8?B?NjhiMlZKKzVMcUxUa202dldZTEpUUzd3U2FPTlRrTXBpNEkvWFJsVTVJbG1r?=
 =?utf-8?B?YmpCbnA4UTVyUXZ4SUtBM25nUmhxSW9CdHdUTUpsWVExUlVsOURYZEYyaDMz?=
 =?utf-8?B?UkZoakFoRXB1WUJKcWU1Vno1bjVZc1pVNXdTUWFiN3A0QW5RRlFQWGdSVEY1?=
 =?utf-8?B?clFObGRwOUo0eldNeWtvcTBsT0J0Z3ZSMHBTVkozZzZSYitCMGQzMFJNRHQy?=
 =?utf-8?B?UXB5VHJ5ZStoSlhWT2RKdVk1aWRlK21nZ1FOeE1tMkhpQmxSd1h1VjFWN215?=
 =?utf-8?B?SWRDMVpXVTJCN0gxYzRLQUh0SGphRmxkWnhudUNmTDJDNGcwc3QzWDhxcytL?=
 =?utf-8?B?VksvR0pGU3RRMmVYVFQ3c2RoWndMbFl3bW5TU0w2NHhBSEZaUGxqWXVQdGNi?=
 =?utf-8?B?N1dyY1FVdGZwUTJwRmV4ckNKQ2FrdFBjazlOVDhhZ081RjdBRXFWQmsrbHJy?=
 =?utf-8?B?YnB6eTBBUUJyL09OdVpVNDJhVVhibzJuTDhwcHRoRXNYaUJBaUVVOGZ3OVh1?=
 =?utf-8?B?eW1UM1A5NmlOcWNpVjFKMkg1cFJDeGI5c216OEphT0R3VTBzYnBkU3Zudi9G?=
 =?utf-8?B?OG52UzJ1OFpydWVsR2RxNkUza2ZiTS93MTBNMis5YVJwR3lxU01NbnpaMk1p?=
 =?utf-8?B?UG9HZUt6SElEOTRabmV1VWVQK2lZNklhM0ZFTXpiMVFOeDhOVndvZ25jV2ZN?=
 =?utf-8?B?bUFUeDU4WFIvVmNLK2NnU3dzQXBDNXU0NUlyRXN3cXBnSVprbUdZQ0F5WHAx?=
 =?utf-8?Q?Pt5OAhj5f0AXxNtCpr6LDMVIyt4d2Tue?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXBjeVBobUk4WGhySlZjVWVtWStuWERyRUdIT0lzci9nSm1QMFZWNGYxakJn?=
 =?utf-8?B?K09CdDJDQitlMGJhQzlWNFdpZStIYk1ZNFVXeTNvaUs5WVNpSk5uNGRpYVhU?=
 =?utf-8?B?b28rMkZhSlJFMHlKc09PTjVhbmhwTDNSUVlaZkJGaHV6aFdFejNXSDZuNVhn?=
 =?utf-8?B?N1VjRitYZkthWk1pQWcrdHJNZkNIN0g1M1JRL2xxbDByWUl1VURJSDVDOUpl?=
 =?utf-8?B?ZXFCZEwzZndjcFVBc2dQQ1ZqZ3FwV1BaMEhNK3VtMkMvTUh5Y3AxVDZyeEFG?=
 =?utf-8?B?MkgxMW54L0ZUOXdDaTd2ZStMb0JGRXdUV0pnUktSdzJPdy9JWkpZSUgzSWZI?=
 =?utf-8?B?UGp2QVNUdFBLSlRQTWdKbDYxWGtUVnZOb1BJeHcxeS8xaERVTExoeUpFSUxH?=
 =?utf-8?B?Kys4Tm9POUNtdmpBWHBoVG9PaVNrT3JHZDVvVUxpaGpDb1dVcElmaW1wOHNO?=
 =?utf-8?B?bEZORnRPVUNWeFRQclBoK05Bc2lOOTJNT0Rrd2Y3OUlXL1hHR29yclhacUZM?=
 =?utf-8?B?c0pybTJyNkYrMVV6UHZJNTJDSXBpY0l5QnNlbEdFYWRzR1BJUkVtb3pXZFpQ?=
 =?utf-8?B?bnpoS1M1R2cyR3I0Mkh2TXdTT0dXZEFYMFdHY2JMRnE4dnlnM0djWGlaenJZ?=
 =?utf-8?B?SEdUai95U01IVmpRbzRGMHFmSGU1ZjVjVFRuQlhDQUQrRTlpUGF3WEYxbXl3?=
 =?utf-8?B?b0p6V3pWdCtjWjNpQkkwamk5b3E0amkrbjJvVGtqSnB0VzRVMndWcXNwUXNV?=
 =?utf-8?B?ZW0zYXZoYkkxQ0I1ZXNTbHYvazJXS0lKUC9HK29MYWtoSDluZURMV3I5czNV?=
 =?utf-8?B?MTJUODc4RFFNY004MDJtaHdIWVhBeHoySXlxckVGck95SDZNVkhzVDloUzc3?=
 =?utf-8?B?bmlPTDRGdzdVQ3dSZkNPWW5YL0FTdThqNHNjZlRYbjZIMXh1UDRTeWREMXNv?=
 =?utf-8?B?aHF6YTh1WmZpcXdNNWNobmZOUE1yUm03NGFFZGdvVjdPM1dtNFNwOVY2L2k3?=
 =?utf-8?B?YjQ3L2pGaE5MY0Ywb3pERG01REVyUzI4Rm81a1ZyU205czBYTllVbzR4Wm1y?=
 =?utf-8?B?NzVHRTlXbHBwY1QzSmNaUW5wSVNmOWQydHpBUnh1WXRoZGhDK0xLcGVyOUlW?=
 =?utf-8?B?R0pzV3NqYUpTMGlUcDZlbWQ0NTNhZTBhM1k4Y1hzOU8xbXFjdnMvVmdXeVBV?=
 =?utf-8?B?NjJPSi9BQ2Jpb0l5TU0wV1NnUDdPVnhvRzg3ckZ6eXhjSFlIT2pmZkZpbExh?=
 =?utf-8?B?RW9CbHhDL0t6L1lKSHYwQWFBQTc4NC9tWVh4L3c4OXZ2RFRjZjJBR0ZWU0Rz?=
 =?utf-8?B?Y3Q3dTZuN293U0ZoalFId05QVEd3VHhlUHplMkQ1ZjJVcFNqRGtRdFZzUmdY?=
 =?utf-8?B?MFdLM2VwaC9xSHlRUXN3eEZNckhJcEtPeXVwWFBDaFZ0V0Z3VGVuYzEvMEJt?=
 =?utf-8?B?aVR6ZUMvaHlZcG8yd3FITEZLYkJsUmJhMWUvOElhc3J2bE5PMUVxT1Z6TXMv?=
 =?utf-8?B?ZFREaDRJMU8zOFd5RDgrS05jWm9xVW5oNzZqSHJsZ25mUU80bWJEMXM2dE14?=
 =?utf-8?B?eEpLZ3FCaUVEbEIxWXo1QnlBVnB4SXo5WVdJcTVacTVXY0FPd2huMVI5TlZ4?=
 =?utf-8?B?SEQ1OGpLY2NiaFp1U0pDSS9OdFdmcmkrS0F3eDlPSXMyUXZOT2ZYWHVPbXgx?=
 =?utf-8?B?VG9mbnFmU1kvQklIbnlRMFQwazRWVndadHhIa05VT1pTTyt4R04yV1I3RHFw?=
 =?utf-8?B?NkFSS3hvaHZPaldmeTFNc2xKVEJQVksxczlyVHJLK1JDbVhZZlliSXkwbUZO?=
 =?utf-8?B?Y2VoaDg5R2s5ZHlZeHhIbVppcUJzbXppeml1RXN0QWNmWUNyajNtTGx0bVB4?=
 =?utf-8?B?RlI4a1A0UmtIcnlBanIyVGxCRFdteVlPdnVMTHRKbWVnSmZBdUoxdnlKRTN0?=
 =?utf-8?B?Sk9UUkVEVXpxTFg0dmg1bW9SNm9uT2NHSTBxQ01iNVhmS2wwYUNkWlk0VFdE?=
 =?utf-8?B?VFNTelRPcGYyblRuZzQwTjlvL0U4NXd2SzI3cVRPU2lkN2laZC9SVkdWcG1k?=
 =?utf-8?B?Y2Zicm9QOWpmN0xvRDNIWkpBMmtsZDJFYjNCRlo0WWgrMDFXeFlFTnR4b1VT?=
 =?utf-8?B?c0U1QUUxVjNoRE9aQWViTlQrZXY1cFBMKzdhMEkwcmR4S0ppRkVDTGtoVW5I?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <225D908C2A5EE249A60466F81B382F37@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b0470c-51af-4461-d662-08dd558b8c3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 10:59:59.8101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlywFN9HSWWvTUxcvmuvwdY17QNZTiJqoYMOYJ8TCDsvXS4NiQ2hzPizqmFt/s3+7xbYUDTEJLk64iZ3ChDCCz1nQtJXG4wlNpxUH+Yc1uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8697

T24gV2VkLCAyMDI1LTAyLTE5IGF0IDE1OjMwICswMDAwLCBEYW5pZWwgR29sbGUgd3JvdGU6DQo+
IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiANCj4gDQo+IE9uIFdlZCwgRmViIDE5LCAyMDI1IGF0IDA0OjI2OjIxUE0gKzAx
MDAsIEFuZHJldyBMdW5uIHdyb3RlOg0KPiA+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gPiArwqAg
TWVkaWFUZWsgQnVpbHQtaW4gMi41RyBFdGhlcm5ldCBQSFkgbmVlZHMgdG8gbG9hZCBmaXJtd2Fy
ZSBzbw0KPiA+ID4gaXQgY2FuDQo+ID4gPiArwqAgcnVuIGNvcnJlY3RseS4NCj4gPiA+ICsNCj4g
PiA+ICtwcm9wZXJ0aWVzOg0KPiA+ID4gK8KgIGNvbXBhdGlibGU6DQo+ID4gPiArwqDCoMKgIGNv
bnN0OiAibWVkaWF0ZWssMnA1Z3BoeS1mdyINCj4gPiA+ICsNCj4gPiA+ICvCoCByZWc6DQo+ID4g
PiArwqDCoMKgIGl0ZW1zOg0KPiA+ID4gK8KgwqDCoMKgwqAgLSBkZXNjcmlwdGlvbjogcG1iIGZp
cm13YXJlIGxvYWQgYWRkcmVzcw0KPiA+ID4gK8KgwqDCoMKgwqAgLSBkZXNjcmlwdGlvbjogZmly
bXdhcmUgdHJpZ2dlciByZWdpc3Rlcg0KPiA+ID4gKw0KPiA+ID4gK3JlcXVpcmVkOg0KPiA+ID4g
K8KgIC0gY29tcGF0aWJsZQ0KPiA+ID4gK8KgIC0gcmVnDQo+ID4gPiArDQo+ID4gPiArYWRkaXRp
b25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gPiArDQo+ID4gPiArZXhhbXBsZXM6DQo+ID4gPiAr
wqAgLSB8DQo+ID4gPiArwqDCoMKgIHBoeWZ3OiBwaHktZmlybXdhcmVAZjAwMDAwMCB7DQo+ID4g
PiArwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gIm1lZGlhdGVrLDJwNWdwaHktZnciOw0KPiA+ID4g
K8KgwqDCoMKgwqAgcmVnID0gPDAgMHgwZjEwMDAwMCAwIDB4MjAwMDA+LA0KPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgPDAgMHgwZjBmMDAxOCAwIDB4MjA+Ow0KPiA+ID4gK8KgwqDCoCB9
Ow0KPiA+IA0KPiA+IFRoaXMgaXMgbm90IGEgZGV2aWNlIGluIGl0c2VsZiBpcyBpdD8gVGhlcmUg
aXMgbm8gZHJpdmVyIGZvciB0aGlzLg0KPiA+IA0KPiA+IEl0IHNlZW1zIGxpa2UgdGhlc2Ugc2hv
dWxkIGJlIHByb3BlcnRpZXMgaW4gdGhlIFBIWSBub2RlLCBzaW5jZSBpdA0KPiA+IGlzDQo+ID4g
dGhlIFBIWSBkcml2ZXIgd2hpY2ggbWFrZSB1c2Ugb2YgdGhlbS4gVGhpcyBjYW5ub3QgYmUgdGhl
IGZpcnN0IFNvQw0KPiA+IGRldmljZSB3aGljaCBpcyBib3RoIG9uIHNvbWUgc29ydCBvZiBzZXJp
YWwgYnVzLCBidXQgYWxzbyBoYXMNCj4gPiBtZW1vcnkNCj4gPiBtYXBwZWQgcmVnaXN0ZXJzLg0K
PiANCj4gSSdtIGFmcmFpZCBpdCBpcy4uLg0KPiANCkl0J3MgYWN0dWFsbHkgTUNVJ3MgbWVtb3J5
IG1hcHBlZCByZWdpc3RlcnMuIFRoaXMgTUNVIHdpbGwgY29udHJvbCBhbGwNCm9mIHRoaXMgYnVp
bHQtaW4gdGhlIDIuNUdwaHkncyBiZWhhdmlvcnMgYW5kIGl0IHByb3ZpZGVzIGZhc3RlciBidXMN
CmFjY2VzcyBzcGVlZCB0aGFuIE1EQy9NRElPLg0KDQo+ID4gUGxlYXNlIGxvb2sgYXJvdW5kIGFu
ZCBmaW5kIHRoZSBjb3JyZWN0IHdheSB0byBkbyB0aGlzLg0KPiANCj4gV291bGQgdXNpbmcgYSAn
cmVzZXJ2ZWQtbWVtb3J5JyByZWdpb24gYmUgYW4gb3B0aW9uIG1heWJlPw0KT3IgbWF5YmUganVz
dCBsZWF2ZSB0aG9zZSBtYXBwZWQgcmVnaXN0ZXJzJyBhZGRyZXNzZXMgaW4gZHJpdmVyIGNvZGUN
CihtdGstMnA1Z2UuYyk/IExpa2U6DQojZGVmaW5lIE1UNzk4OF8yUDVHRV9QTUJfQkFTRSAoMHgw
ZjEwMDAwMCkNCiNkZWZpbmUgTVQ3OTg4XzJQNUdFX1BNQl9MRU4gICgweDIwMDAwKQ0KDQpJJ20g
bm90IHN1cmUgd2hpY2ggaXMgbW9yZSBMaW51eCB1cHN0cmVhbSBzdHlsZS4NCg0KQlJzLA0KU2t5
DQo=

