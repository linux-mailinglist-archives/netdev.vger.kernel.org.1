Return-Path: <netdev+bounces-166402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F215EA35F1D
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C489C168B58
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A342641CE;
	Fri, 14 Feb 2025 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="imV4AMwF";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="iPPKSMwL"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3798877102;
	Fri, 14 Feb 2025 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539411; cv=fail; b=dKEJoqAj1ylVmcmOR94Zrd+lWqW8uynRiFm1e0evwCn36YjPsciKzSWQ9qdjbY4nZKZY3OofBgnZxhNquKCWmcI/G850l+CDlyUUSpQr0Mvg1H4hpgWQSOWvZM+Ue41A1PQYgTC1Vqv6fNVEspU/OAGcQuLp+7Cmzqk5e5TFwxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539411; c=relaxed/simple;
	bh=9yTwwjgFhAkmPKG606F8GO9hfxt9/O91BZJEeZ3o9TA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hdmSFXhGhFjZamiOK/XrYDSOm6k1f8bwWVrDv3TZik7v5gvBE9CO/V+eAsjOdH58vwbrZhWsXZRsLVDELlYTZ4a9xrnBmfOakenzmhnh03ytU6/vqYOI9Aw0vwRYG8aX5K19v3qfeByU3G3L5MWRZv4ZUPzEoPt4yWR+PrWYGmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=imV4AMwF; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=iPPKSMwL; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: de3b38aaead611efbd192953cf12861f-20250214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9yTwwjgFhAkmPKG606F8GO9hfxt9/O91BZJEeZ3o9TA=;
	b=imV4AMwFvUh1fvhHeiDg6a4uCQIUBUxhM4UpaMr+V+po4o94qaScThd43GXYJtgxRsLtZh9goxKuP/KSiK+pYvjDQKuJGP7xvMmjPpEt7ZKu22100zrxpSKNAUGHFma4POWI222XLIUhJB3GaM8j3//uQARSMZ5otumdofek2+8=;
X-CID-CACHE: Type:Local,Time:202502142113+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:09d414fe-328f-4b37-99a4-916c86dd6ad5,IP:0,U
	RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:2
X-CID-META: VersionHash:60aa074,CLOUDID:39155bfc-7800-43c5-b97b-ddbe32561a5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: de3b38aaead611efbd192953cf12861f-20250214
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 630893251; Fri, 14 Feb 2025 21:23:24 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Feb 2025 21:23:23 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Feb 2025 21:23:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uhe53fjrB58mlz1Z5QDr6uqo1uPx3fGv5o7lQrby+aFBVYYx4PJBY81pVzGFCt3mD9YJ5vetjK/JIQIU7h2q4+2RxzAQ+iRyewbhXSxtb3RmFodLPgJtmzma71v+kvYF5hV7GrE/aEH+eg5gkdXMzlnuhipPNMNzRd7wQvoUTnFok7i8tNZC5cLvpYIP0gojOxuhWz/GqdJeD0sBHUYnNqz+sQQ9+sbGwWiqUDYJz7TBvcZce4f4hZtL81oIa6TPSJDwmanBY8xntsMDVHI9rpMz10RuHF1jY1W5rB48jwWvPW3sjrOYHU+J/pyYLy+qLqjCLqj3PV3+WwUXTtAWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yTwwjgFhAkmPKG606F8GO9hfxt9/O91BZJEeZ3o9TA=;
 b=jDUdedSkMO5LZPoAuyUccxsaLMegKjF4Cf0RVqIXf9ELchks9ffVcS78PwmE/uqVKQzVOhIU1fpqYRWS1q/YR+gKdI1DpSmFAyIEbeQnaKlJsu50NAcnPuuqA0T11uOj0dce7FDxhnReCXm1Y95Zp7zzUuNjMdYE1QmJkQRVa9GiYlDcKLw9dqr4Y9K6wQVf75Ea0Z13bqh+BgMceSLMEoEubHk2/PQd1EKW2zIDYyAgslt3MFkj3sc8+ipA6IqXUzahJv0/5mSx7fCvE+eAqMXVK9l8N6Nw/YBCAS9Sntu6Rcd9AwZp+oP3zYkAOr0Btw3QKeObUNWE2x1dlhwRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yTwwjgFhAkmPKG606F8GO9hfxt9/O91BZJEeZ3o9TA=;
 b=iPPKSMwLTK2o1MtqK6ysTn/CHcyjekd8whp3UODpXILJyf6I0LSEueG792elCrynw6x5n6FD9foAZpUILtg+HnJrnnbEkME0+0y+AYsW0DtwHub/DHywuKG2PA4NEqXWQN77wnPiVlJnzySuOpzMs2ZBNmZFZVZqflB9Me/5gOU=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by KL1PR03MB7152.apcprd03.prod.outlook.com (2603:1096:820:d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 13:23:17 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 13:23:17 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>, "dqfext@gmail.com" <dqfext@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "horms@kernel.org"
	<horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, "krzk@kernel.org"
	<krzk@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC: =?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>
Subject: Re: [PATCH net-next 3/3] net: phy: mediatek: add driver for built-in
 2.5G ethernet PHY on MT7988
Thread-Topic: [PATCH net-next 3/3] net: phy: mediatek: add driver for built-in
 2.5G ethernet PHY on MT7988
Thread-Index: AQHbZ7WXaWwg6/r4eESVGpzWtCL1+LMZWaeAgC2eIoA=
Date: Fri, 14 Feb 2025 13:23:17 +0000
Message-ID: <e58dabed4915e5c2dcece5f047e045ca08f836b6.camel@mediatek.com>
References: <20250116012159.3816135-1-SkyLake.Huang@mediatek.com>
	 <20250116012159.3816135-4-SkyLake.Huang@mediatek.com>
	 <df2a463c-102c-4eb1-905d-96dbd926db7e@kernel.org>
In-Reply-To: <df2a463c-102c-4eb1-905d-96dbd926db7e@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|KL1PR03MB7152:EE_
x-ms-office365-filtering-correlation-id: f62138b8-5cbd-4f9d-1783-08dd4cfabe21
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U0Frczh1OFhhRWZBeldpNzk3WjUyNXRkQlRISzg3ZmdiL2IzeTRQdVczSnhT?=
 =?utf-8?B?WGs4VGFZYzVRNnRrMERUdlo3WTRWUU81ZXBLOFowa0JVNHk4ZkVmUTRaWUR6?=
 =?utf-8?B?bWJtVG9mdEdKdUVjVEh6eEdzODNRTHlsRXFwc0hQOWZDbFlqWHpHekE0K0ZM?=
 =?utf-8?B?OWhudHRYbXlRZTY4aTRFQTVOSVRWNndPU1Yzd1o0QVprUGpKSEhhRTh2RW9T?=
 =?utf-8?B?dUVEK3pRQlNtSkRuSzhFR3dOQ1FnUy81U1dGT1hqMWd0M0IwR3VHVG96S2dZ?=
 =?utf-8?B?Uk1maWVJWWx5RVROWmc4TzQ3YS9RRzZXZ09jZDE0K2crNWhSRU5JVmNHWkZj?=
 =?utf-8?B?SHJiUk5xZEpCcXpld3lwanFvczhXOVJPTm9VZGJ4SzJiUU0zS0QxTStieGdt?=
 =?utf-8?B?M05GRHJpSDZqRWhYZVZzM3pxUi9WT3d2R2RFdjNBSUFFd3EyTVNOSkpKZmFw?=
 =?utf-8?B?anFSc1hPUmlhMlpFL2RGaVpGWjFoLzhacTBWOEdaUElUU3JFMDV3YW5TeXB6?=
 =?utf-8?B?WjVVaERzczlnVjZYSGdzQndTbXIrZDk4b2Q0TlQxNWpPdFE3bEtXM1ZpellU?=
 =?utf-8?B?ZzY1UmVkWHdIbEhERGVMejhmV0lZWXVUak1JcEk3RitDU0dyd2dUcGxXTVJM?=
 =?utf-8?B?QU5ObDFmbUhxQnM0ZVNhY1pyYittcWJPOUlXTTBTbGJTVW5LRlRja0tWb2Rq?=
 =?utf-8?B?VkF6b21ENllQMDgvTkN5VmYzTDh1bVpOY2FlR0c3RGtwYzVKWXRCUE14TUw5?=
 =?utf-8?B?Rk0wVHZHck9lTHNLeERqRkZLaFpMRlNVa2FFUS83QnNpMUo3VmU1QW9wN0N5?=
 =?utf-8?B?K2VxQ2dQM3NRUEZKS1EwZ1h4Wkppb2JOV2xiWFNXSDBJSjdFUmd6UDRKMUtD?=
 =?utf-8?B?cmVrM3ZKNXF3N2Uxbncycm5TcVV3VXdyY1NqZnFVL0xXbzhrL1V4OU9rdmZZ?=
 =?utf-8?B?N0N0d2pLeVdPd0pKVnNNN2hIZ2R1VTFMZStJWE03eks0MGc2M2JaVk9LOHdR?=
 =?utf-8?B?aUJId1Rjem9yS2RMbEZKKzM2cmI2WFAzWVVvMjB3WWhycUgva2FZYkRpNzEy?=
 =?utf-8?B?ZXMwRncvaHJWbnNsakdDa0I4UFR5cktuZjNRT3RsaEQydThKS0MrSi9zWk1r?=
 =?utf-8?B?NlVTUzlMcEtMdnFEeFJvQ2J1dGdoM3lKd0JzRWVTOUQvZTNpWHAzYVpXeGZv?=
 =?utf-8?B?WkhWTmMrekV2OWZQK3JNYlo5YTRlM0lsYTVZdDY5azBUZ0JvYkJ5aW1CS25i?=
 =?utf-8?B?UFRBL3hHRDFWZ1Rnek5ZZ05ROFZkZmhHNFJIYjJQeW40QytwajBGZ0xOdnVI?=
 =?utf-8?B?MGplY0hFdDRaQUNhbXhwcm1RaDVma3g5aGl3WW9yTlBRenB1QlRDSy9kUmZ5?=
 =?utf-8?B?Szg2N0Z4WmNLS3pBZE44a09rem05clJNUVdSSXQxaTJES3dtbWRUUGVnVjNV?=
 =?utf-8?B?WnR6bUlvaTFHZ05zQ3J4SDBoclBTb1JlNHRadW1YYmZsWGU4WG9WSDR4OFNp?=
 =?utf-8?B?emgzc1d4TCt2ZWFhcHQ3WWRBVkFiWW0zNkxIa3l6UStZV1pNbHBrWGtLVUxj?=
 =?utf-8?B?VlVOT0FOQUczcE1JR093MWwySytnVDNub0NVOXNQRnN2MlFFL2pvRFdlblpn?=
 =?utf-8?B?TFJUeHBPYitXYU9jcDB3QlZhWnRhLy9qOTF5TjlZZEd3cmpzZGNGTkU1empT?=
 =?utf-8?B?UGRPLzNMTm5pd2NrYnNUYnBvOG9aY0drL3ZhSi9KTmExblVOS2puNzhyKzdv?=
 =?utf-8?B?U1RER0NVRmJleXRKcWdHcjBHOEdFMHNIcjhnQjlmNWVDVHVsT0NzV0lVTDVm?=
 =?utf-8?B?eHpBZFJ0aEd6cFA0NnRBZTNEQkxsNGZmZk9aSUlMZS9nQlJmMWpmcnc3YjZK?=
 =?utf-8?B?aEEzam0rUG5BMWlpaEVXemVDb1BZNkszZ2dFMUltSWRkTFpDMnlBTDdhMm1i?=
 =?utf-8?B?eVZEQ1dOTzkrcjEzSHc0ZDhhMTduNTZFbWYzbnJWS2xDR2F0c2dIZlpXOTBP?=
 =?utf-8?B?Wmc1N2owUGlBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1Jxd0ExbE03OXpCUWRBYTE3NS9KOFJ2aGI5SWN0MWdJU1lCOHdDZkVQdVdW?=
 =?utf-8?B?UFZva3hqWlVRd0hkTzFVM2RSZ2RsYzVSR0R5cWRqcmt3VUYwTXhEWEVFZmtH?=
 =?utf-8?B?YUVobDUyQVk0eDFEdnp2WnNpRlpRV2hkcnpOKzFsSldvVzF6emxSeHYydU9H?=
 =?utf-8?B?aFlwQlVkb3BzaFdyYjZ4Nlp2TmxhRmRWNkhraEJmQytVTGlnT2pSbnRuZzZz?=
 =?utf-8?B?M2VlRjkxKzNOODBpb1hVK1l0UXBCbnlIVmRzcUoxUC8yanU1Y1BqdGtzanFz?=
 =?utf-8?B?cFR1b3BRS2xteUZidHpTcVRtMEZocTU3NTVmdW9yUDd1OE9MY1NoUHhiNnE4?=
 =?utf-8?B?UXBDTmJnM2dBd1Zmc2NEdnQzenQ0QWRBN3g3RFl5VmNZSTJieEdlbS9nMHdP?=
 =?utf-8?B?emJ4OGZsSmU3ZkdJdlBobkhtemNybEVIcE1TSkV2U0E3VnZsY0haQmtwbmFC?=
 =?utf-8?B?aTcwUUJuQmo1U3grSXJQdmpLbDdieEc5dDRpOE9OQkIrYkJiNW9vZENJdE91?=
 =?utf-8?B?TUNBWnEyOXVyN096d0pNM2xtaG9QUW1xOTlSZnJ5OW1SbUdhRzBNdzhlU2hR?=
 =?utf-8?B?SStRNDA3SCtSaHc3SFF1VWVYU29mZ29jWldRMUFNYmNXd1haMmxWckVRUGt1?=
 =?utf-8?B?cjIrd2tpNEFqZkFJRU5CZFl1WmNqR0hrQzZUZVdORHJUbXp5c0VXODdsRGhn?=
 =?utf-8?B?Qzh3c3p4anN3Yk80K0ExRHZqME9PUGIzbU5wbVNBN1RKd3JMaDQvaUF3cE5D?=
 =?utf-8?B?MmpzaSttaDJzQ2hGcGs4cXEvV1lVYkQxalBNOHk1ZmZRbXEvN3lhQ1R0cWRY?=
 =?utf-8?B?dnFFc2w3SlMvTGw0bkpNUTY0angzdStJYUVaYUs3eUdxeDR2YTI0blZiZktP?=
 =?utf-8?B?VENKVXBsV0s4WXF6RVl5NFkrd2l2eEFDTy9MOTV3R1ZXTW94bUU2eTU5RXEx?=
 =?utf-8?B?UzdEdW5ITHlzWTNuZk9FL2wwTDROSmc3enVXbmdNNGZoS1pZMU1YaSs4N2g5?=
 =?utf-8?B?Yllod1pyNS9BT2NzTkZjNThTZjRaLzJzaCtyU0pnaGNDV0NLVmw1cmg5dWlC?=
 =?utf-8?B?bFgyaEloWGY2Rzlpd2dmTUplQTFtOWNEaWloSXNwK2xnWkhjTU0yZzZ2aC9x?=
 =?utf-8?B?WklPVTFSVUpWeTdoeDVNaW1yTisyemM3bUEwTDN1Q21rQ0NNb0s4NnZHbGMv?=
 =?utf-8?B?dXRCRVczelZVaGlLQlZXQnBnVkU0d1BtNUlTaFlZY3A5R0pZVzlnOExXZTgy?=
 =?utf-8?B?WDBmd0ZDMi9lS0ZtVG1uZkh6M3dIdGpKam1KR2RkVnBrWGwzaU9MSGVSUnds?=
 =?utf-8?B?Znhtdzd5WlBmRXlCNWJrcmZ3QjN2cmlhNGhyRzd0YWhXZGJEWnVmMVVRNEdQ?=
 =?utf-8?B?c0h3aGJSck1nSWZhdm1pNUxyOGc0dlFHYUhOcUU5U2h6aEVSTlZLbWttdWVR?=
 =?utf-8?B?ZXY2c2FmKzZtNlpxRmV0UlBleDJ6ajM1Yzh5MTFOdDFpMk9TaTVoOWo0WDQ2?=
 =?utf-8?B?QzJHczd6Uyt1YW9FYjFKdkxUUXlWenR1bTMvWk84K3kyT05hY3FnZjN1ZlBW?=
 =?utf-8?B?MWloelJWcEFEOGRWckJGZHNvSlo5dWplcXhhcXN2M3hERm1IVXZ0OFN6aHVx?=
 =?utf-8?B?Y0RRQzg3MGZHUUdOdC9rSXNodGt1YjNSS2k3NDU3R0d3cktqN3B0N3Bsd0Fk?=
 =?utf-8?B?VDBHd2YzZnlVdUNBeWNjOFVoMmhBeHZPQTJsK3ozSHozRTY2NEF6Rkdrc3M0?=
 =?utf-8?B?b1N4dmhBYVI3M2E5eiszbXJxNnBHZXBPNURlMW1GMmQ2UlF4SUQ1U281MFJy?=
 =?utf-8?B?MVV3NjZpaStLM1RwYThrT2t0UmFkajdtUGJrTTVYQ2RSd084YzN4R0ZHQStV?=
 =?utf-8?B?bWxLbVJUdFU2YjBtWE44OCt3N1NhcXBHMUEyOFdTY2JweXBLaVpGVFV5NjdV?=
 =?utf-8?B?TlRhN0N4YlRUSWxMTTN0NTNYMTBsUnpDVWhjZmg4c0RqKy84YjZFWEM1VlJr?=
 =?utf-8?B?Smdnc1lJOGpPTWNpMWhiaDBSVVdmM01YcjZ3YmZuRmE4NVVCbGNDOVN6YUVW?=
 =?utf-8?B?dThtOGFLclc4QWtKZ2JSajRrQ1U4Wkx0MHoza2VHbk9odkQyMDNKVU1OMzFE?=
 =?utf-8?B?b1FPVDlXZ2lrU3FmOVJxbUVYTWdrRlNoQTFKMFB1Y2RVbWR1cm92VDdDVnFF?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B762BC7BDF517D4F8DD43385DFE216CA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f62138b8-5cbd-4f9d-1783-08dd4cfabe21
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 13:23:17.1505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96Pu2WpokQp+MOgw2G4g+gxSlJpSSq/JPp7WZsQeV1rZnf78YValKIaEWNRDqvMQyRcFqDuU0cPIQNQ0HQUaWSwLNo3fdQyHVZP3GT+BGUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7152

T24gVGh1LCAyMDI1LTAxLTE2IGF0IDEzOjQ1ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBPbiAxNi8wMS8yMDI1IDAyOjIxLCBTa3kgSHVhbmcg
d3JvdGU6DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG10Nzk4eF8ycDVnZV9waHlfbG9hZF9mdyhz
dHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgIHN0cnVjdCBt
dGtfaTJwNWdlX3BoeV9wcml2ICpwcml2ID0gcGh5ZGV2LT5wcml2Ow0KPiA+ICvCoMKgwqDCoCB2
b2lkIF9faW9tZW0gKm1jdV9jc3JfYmFzZSwgKnBtYl9hZGRyOw0KPiA+ICvCoMKgwqDCoCBzdHJ1
Y3QgZGV2aWNlICpkZXYgPSAmcGh5ZGV2LT5tZGlvLmRldjsNCj4gPiArwqDCoMKgwqAgY29uc3Qg
c3RydWN0IGZpcm13YXJlICpmdzsNCj4gPiArwqDCoMKgwqAgc3RydWN0IGRldmljZV9ub2RlICpu
cDsNCj4gPiArwqDCoMKgwqAgaW50IHJldCwgaTsNCj4gPiArwqDCoMKgwqAgdTMyIHJlZzsNCj4g
PiArDQo+ID4gK8KgwqDCoMKgIGlmIChwcml2LT5md19sb2FkZWQpDQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gPiArDQo+ID4gK8KgwqDCoMKgIG5wID0gb2ZfZmlu
ZF9jb21wYXRpYmxlX25vZGUoTlVMTCwgTlVMTCwgIm1lZGlhdGVrLDJwNWdwaHktDQo+ID4gZnci
KTsNCj4gDQo+IFRoZXJlIGlzIG5vIHN1Y2ggY29tcGF0aWJsZS4gWW91IGNhbm5vdCBqdXN0IGFk
ZCB1bmRvY3VtZW50ZWQNCj4gYmluZGluZ3MuDQo+IA0KPiBBbHNvLCBkZXZpY2VzIHNob3VsZCBu
b3QganVzdCBsb29rIGZvciBzb21lIHJhbmRvbSBjb21wYXRpYmxlcy4NCj4gRXhwcmVzcw0KPiBw
cm9wZXIgcmVsYXRpb25zaGlwcyB3aXRoIHBoYW5kbGVzIG9yIG5vZGUgaGllcmFyY2h5Lg0KPiAN
CkhpIEtyenlzenRvZiwNCiAgT0suIEknbGwgYWRkIGR0LWJpbmRpbmdzJyBkb2N1bWVudCBpbiBu
ZXh0IHZlcnNpb24uDQoNCkJSLA0KU2t5DQo+IA0K

