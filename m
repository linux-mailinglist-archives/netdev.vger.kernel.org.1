Return-Path: <netdev+bounces-140615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66D59B73FA
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 05:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382F31F23E23
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 04:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9DA13A89A;
	Thu, 31 Oct 2024 04:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mHwdH7/3";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NNyCmsjU"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC913174B;
	Thu, 31 Oct 2024 04:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730350634; cv=fail; b=carzkidvqOPtUdICO3FR9v9qYSGai2zPl5xRhsSTxusg/PY1CE21cOHNiCacUxRAWWj//mFNOm+o9Ugk8baAZQ1HnZj/eiQO1O6X097p//SQJHKHgL0BWVVggvgGs3WiN3Sto/3/qg7/1hJhgEqXoERqUWaOpDH8AWPBGN7yeSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730350634; c=relaxed/simple;
	bh=3AqgrlCka0v5cV5Nvv47/isyyb+zfgshxpfVuVlViMg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DC9idNagefK+5KrqQfyczSE4qsYT24hz2y9nwNqD8mTgox9zL+e4MuUEewbQ3ZKUEnigaNW1l+SVZCrFg6rENb1yHswK2vb5WzpgFjYoLsj8LIzHAOVzAJD45ADreGEXtt3wIVpiIu+1hrmtr553YnAfTp0+Kco79JsKZYfmuwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mHwdH7/3; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=NNyCmsjU; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 925e9214974411efbd192953cf12861f-20241031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=3AqgrlCka0v5cV5Nvv47/isyyb+zfgshxpfVuVlViMg=;
	b=mHwdH7/3Nwx3fifg2GBGDLMoT2or3wePvon9UYBM9ZvMpepaMUxwAuU8WAi5mWwdXgQ5Ns+rZeiuvr0EM+3/sq0RHdzvN5TngIFHnkJShP4Vlrg/Auoe+G2Ky8cOyLKBNW3EcCmPt7rRuulrbWpZnv6t2xMNHn2kHBgcG9U2q6w=;
X-CID-CACHE: Type:Local,Time:202410311257+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:59754782-4be1-483f-a0ce-5d31e2fb6ff7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:868a53e7-cb6b-4a59-bfa3-98f245b4912e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 925e9214974411efbd192953cf12861f-20241031
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2099352158; Thu, 31 Oct 2024 12:57:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 31 Oct 2024 12:57:02 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 31 Oct 2024 12:57:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f76dIjBvVgJYprs/RnEXnan74vhtC9bvJgLoqe2Z+OMn+47IuAE+bdGe4ZErbUdUNWJPYMcryZ5XG8vGENIlNdcFeeMi8+Y3hFFwzN+voPo0MqOUh0dLUgeETwL7G5DcKkQ3H+K55AhA9yypKEw5dJCp7UDBvYlol/2mVDxPNzL0R8Lf2ou0pAH8YY7oqUAcNX5DJblap7qs2DFyLq/dd3Q7/K+8qOIRAyMvvAqie6lJR+pezvPd93CrtQx7qKizQxjZRhJgBnNRiY+PqBkasiJdFPEN8Wgk2lyK6JIiYzyZMFF17nQ/SKGhm9KejSPTom0zAFfaibyyCssIfnRc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AqgrlCka0v5cV5Nvv47/isyyb+zfgshxpfVuVlViMg=;
 b=px46JKv1HK6Nlcj4y+RcTw/4kb+Qk0xE9vYi1jo9SAzqLQn18ZSjLZ1+Knvdg72IWiIef1jAVFMvYRYDm4rPg1/4x98yV8cofCRjKSHLKqB/ah+SZOwtTjv1TmQV8CQXWInH4JT/OR1PmGa44JYbiyy0P0JZLkszyCdVJThHihp1AcoKdhrCeJi36yqA00ZoObliERQ1nwmd3pDFWulVgv+LpWz+zDLhxvOM9bgnfy7nL23kZr2uOFYUkWTQ2O91DpyP69wg6MGR/KApVI/Icez6nYuNoaJ1bqnr0E3oOGgXjnXphhXiGV5/NbTWFuZFQh/JFpBUYh41b4AWlXHRIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AqgrlCka0v5cV5Nvv47/isyyb+zfgshxpfVuVlViMg=;
 b=NNyCmsjUwvbbbkg4fpsL87Y+LL3GF5O2zpl2DRKx3xxacWGzgmstFYlkWLBAIuxVHHDHcuhFuUHidQPe//mpyRM23BKSh6VXBvNJDo51dUcwd7yZrazLIAUpryy/k9PyLYwefr2FJddQIancc9a3RBFuIU9o6n+2BEKGj6lEQCA=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TYSPR03MB7524.apcprd03.prod.outlook.com (2603:1096:400:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.28; Thu, 31 Oct
 2024 04:56:59 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 04:56:59 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next 2/5] net: phy: mediatek: Move LED helper
 functions into mtk phy lib
Thread-Topic: [PATCH net-next 2/5] net: phy: mediatek: Move LED helper
 functions into mtk phy lib
Thread-Index: AQHbKre/s5nfeVrdN02x9+bm3IrIorKf1QCAgAB4MIA=
Date: Thu, 31 Oct 2024 04:56:59 +0000
Message-ID: <29352dda1b5c647c30e48fbb31e7781fdab43d9f.camel@mediatek.com>
References: <20241030103554.29218-1-SkyLake.Huang@mediatek.com>
	 <20241030103554.29218-3-SkyLake.Huang@mediatek.com>
	 <7cb014a6-ec64-4482-b85c-44f29760d186@lunn.ch>
In-Reply-To: <7cb014a6-ec64-4482-b85c-44f29760d186@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TYSPR03MB7524:EE_
x-ms-office365-filtering-correlation-id: 92cf09bd-6213-4830-a694-08dcf968739f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RERqQTI0ekx1TWVmSFh2OXI5Qk9xK2VsTmg3R3VqcjVNRjVmV25YUDRHeG5w?=
 =?utf-8?B?QVR2RUR1M1VuL0lRZUdudjJvcXZqN1I3aTZVNk1QblI3TXZhQUo4UDJETmJZ?=
 =?utf-8?B?czdiTUlEdTl2WlBoc1lHMEc5WHVTLys3RmlPRGhVK1FRUWUra1E4YlVXMTBk?=
 =?utf-8?B?dTJCcjA2SHk3c0g2OXZKdGhVZHBLTlNXbW5BQnJwZk5qQWRUS1FPTGh2bmVJ?=
 =?utf-8?B?M0trODhENUdxWUZLN2FHRXJQNzBod01QSHk4M29YQjF0aDQ1Y1Y3RVpLZjZu?=
 =?utf-8?B?dlhIeGtJY2F1RFBQaVg0c0tTM0FlYjVRTWoxWEV3S1NlMzFmeFFlVWtaMHVk?=
 =?utf-8?B?cVAwU2RoTkttSmlZRW16SzlpdmtHeUE3b1ZpQlRlN3k4eWN1TXhpYUpNL1ZM?=
 =?utf-8?B?MFJKSEJZVXJBRHZaYmcvd1JmZFRvcmZoMzNaMUsyZy8yakJIYk9nbnJkTS9p?=
 =?utf-8?B?ZldKcDM2UDR4L2RJR1RNY1FBcXY4ZXdJUUo0a0wxdjM0L3pWSUkrK251ZmlW?=
 =?utf-8?B?ZVI1ZjhLVThhZ0s0Yk1vQ0RYNkYrRkMyVHpXVFl2N21EemxLUjZzWlVWOVl2?=
 =?utf-8?B?emxkZXhDUmdvU2NJSG1XcW5wN0c4bGdBd1NBRDNBSG8wZ0hhRlA4TUpuaUYv?=
 =?utf-8?B?SWpRNHlXSWIrTVEwclArWUQ5N3VIaDVON2pMdmJ4NUluUmZneVBXUkVjeXM3?=
 =?utf-8?B?VGoxdW5XUXRxTXRTU0p6MWZ0MVAzSmN2WlpiRWdsN0ppaTlPRC9UVGlPQW5k?=
 =?utf-8?B?NEl2VGg4UDg5VGtTbEpZRVlFYk1XelNwZlJ3MDlpZ3BVa1k0K0NCS05qMTh1?=
 =?utf-8?B?M2x1R05BR08za0YvSXhqaDg0Zm02L3dwZFlHMUV2TGxUZ1lHV0JjRlNEKzlu?=
 =?utf-8?B?S0NxbEZvTTZkN1dDUVcyd1g3SzNKaTJWTDd1UE9GMWVhT3lOY09KYTVPZ2Zq?=
 =?utf-8?B?ZzIwb09WUXpzWUEwRmFCWkYramFDUVYybnpVeW56YVZMSXJHY1JITUtHSnJn?=
 =?utf-8?B?L1NhTXA4RDRxYW0xdU9IenlRYmNFZGpPeFcvU1B1L3FUeTQyMUdOdlFRdWUx?=
 =?utf-8?B?QUc3RjN3NXpvZGZvUGpIWUhyeERPaitidURGREVkc2FGcmRQL0hmZjhBNits?=
 =?utf-8?B?Q1JwSW11ZVhuTy80Z0Y2N096eEIyajNHMTJNTzA0MEdjVFROT1JDL29heThT?=
 =?utf-8?B?ZGM1ZXpSTnJPU1lvTEdYU29yNk11Z3JhZmZxaUo3SXRESW5MMGY2bThLL2Zy?=
 =?utf-8?B?bzZtNUtjZ1JIZmRody8xVkRURGRETDVVRjNkN1JYbnkvaXhPeUhWUFBLYTg2?=
 =?utf-8?B?VEc0UTZ5Z2JOK2p2RWhRSGNLMHdpSkozL1M3S0ljNjRHS3Y4MTFneHF6NTc1?=
 =?utf-8?B?ZFRzMU1wR3NMK1BucldLeEc3ME9UZ2lTWklWcUFyRVRxU1pZZ3VYV1duSW1w?=
 =?utf-8?B?NU5LczdUZGZCNk9nVlRGL0Q5WXVrSCtJYWtRemFhSUt4NXY0eXlHWmRMTkJL?=
 =?utf-8?B?VXFtMlMxcmFZV29rdWg1eGhGSUpMdmd1bG51NzNLQ2NYUlBJUnJqekNhS2cz?=
 =?utf-8?B?cGxqZXk0Z2xnR2JoRXF2dEVaamxSZUViYldWOXhOR0ZCMGZyR0lwTHVGa2Jq?=
 =?utf-8?B?dmJ3ck9LR1hVeGYxa1c1cXlBdHJIODNiTmFJZEw4UFJ2VXpaY1VSVzN4Vnc4?=
 =?utf-8?B?dVpQTlB5bUY1cmhYOVkzMVNINnFncm83ZHRnSVc3cEsxcWt4cGhnT0NJZHFy?=
 =?utf-8?B?MmgxUitNOUtnSGoxQVdyWXlabHVEZ0txUDR2c2lidnRiKzNHWnBJUFFWRElS?=
 =?utf-8?Q?DkSp04TXNvvOSoztJQ4dKQrPI8LPetoDL7wBU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azhyYmY2WEFxMXppU1Y3ajZCdythQXZJNmJPSElwV0QrSlhLbURnZTZoWDl3?=
 =?utf-8?B?N0YzVW9GcXlLNWZnN0UrSHJQemd0OEJ1L25xRnUvWmptTmFLdGtjdkJobUUr?=
 =?utf-8?B?ZS9YVXV5T2V4RHVDVTdtLzFjdFpBTkJsUTdZUm01eFNjY2ZNSjBsWGtNZGxB?=
 =?utf-8?B?UHhTUHVuRXdCaXlkTnB0T2g3cG5iaUpJQUNXdjRmeEQvQVhUNTB1VnVlQzUw?=
 =?utf-8?B?WG54OTl4VC9nREoyRnR1cEhJTG5UaUVsZzRtRzQ4L3BDRFdCdSsrSmlyMFJB?=
 =?utf-8?B?dWw3TEk0S0FLRmRUd0Fub1V2WG9ldDZPc3h0aXV3RVZpVWRTcndkbkIrL1Zx?=
 =?utf-8?B?TEZsZCtkUzFZSWdTdVlhZGwwaHdCOEdmNU0wTjg0QzFyT2dzYUdCa0xJYWpX?=
 =?utf-8?B?UHltZmxZVldER21uV0hRamk0cTBSZnRucTVhRlBFUzB0Y2NMRXJucnF3YnVp?=
 =?utf-8?B?dUZOWCttMEtBeml5QzNJeDhJVFVZR2FxRDhQUUJQaUNhaDBKMVBubkRIdjF0?=
 =?utf-8?B?M2ZoQklGRmZNOVFOTWgwY1I2Vm0zV2JMeGJ3d2lsYVIzelJkZGVPK1YveTFB?=
 =?utf-8?B?S1hRSkpVbjQ5YzNNSVI2RjRNS01zMXB5UDIxcGl3bm10RnVDb3RjZnNHYlBG?=
 =?utf-8?B?K3A1YTFKQkN1ajdxdlpOS1JWL1V4RU5KR3hhWnpkNmNYaUZVcytlUnBYbTA5?=
 =?utf-8?B?Z255OVBhcWt5eDlXcDQrUTZaOG5IL2E0bzNQVEkxOFhOZU9iQkg4cnJxZjh2?=
 =?utf-8?B?ay9HRE5tY3M3cWFiQ2FCZU5vbTNpZEoxTEVjNm1qdmRpcVZrWkNOV1MxTXRu?=
 =?utf-8?B?RVMxWnFQWEpoUGw2b0EzQnZoWHBsVFpHYlZZVWhiRGw0L0kwUk5uM2NXUUsz?=
 =?utf-8?B?SUxIQXpLYjZrQUtmMGlkWkNpditKdmc2QlpOSVIreWM2VlJnTnd4cFkzSzB3?=
 =?utf-8?B?QUZndS9mTVBiblQzbHZzbzFNczl6N3dCNkw0THhYK080eGJGaStDbUNqQ3hi?=
 =?utf-8?B?TjkyZUFpeldqaDlGc3ZhdERaMlk2b2tvNGo0K0p0K2NCbnFKOUhwNGUwcTVY?=
 =?utf-8?B?WlJJM2o0UGJyMS9Ec2lHL1hKenNOK0FhenN6K0VLQXZmd0VyS0JkZkZvdkJI?=
 =?utf-8?B?aGExN0pQRzlBRkM0cWVvcnIzNiswQWRaV3RGMFhmVFRJU1hhaEFRNHJFM21O?=
 =?utf-8?B?cGhOcVAwL3lsRTU3cUpIb05OZlRoKzV6NGd4cDh0UmZlSzh6eWFiL3dlUGx4?=
 =?utf-8?B?UEVrYVkwcElnSjYwdW5Ma1dUcXpuRytkSXdSd3lFSWQyTTRjbWU5ZlpUWUhN?=
 =?utf-8?B?NmI1WFNsMmRyMXZTZitySmZyaDE5Q2VHbXJZN3drUkFmd1NhRG5ReEhxQzBv?=
 =?utf-8?B?eDl2b1ZSRHRNQ2hXYml4NVRENWlnWXpiZk0zc01oMVE5L1VwMjJSWU1SbXRu?=
 =?utf-8?B?dnBzS3JUMmxHbmtJalZ4Tml6TnVQYzd6enp1dWs3ZGlvaFpETFJNTnpvcSts?=
 =?utf-8?B?TnBIbzBSaVNEUU9UT2M5VWZyT21BKzlpelRyNXN6RGJNTU5BaDd2UlB0YVJu?=
 =?utf-8?B?RzBwYWxWdFNxYUQranBpQWR2bUUwV21hL0tKOEU0S2twdC9UOURwZjduTzhs?=
 =?utf-8?B?Ym1BMzZkc0pWbHlLS3RwcTFoU2haOHRXaExxSzQzRjU5MFBXeFpRcFlORTJo?=
 =?utf-8?B?eS93TEZUK1FmSkpDUjB0QTRJcktub0RnYkdVS29SRGs4K1ZiUC9HVXE1R2R0?=
 =?utf-8?B?YkxEbnQ2NjZrclJWUnpxMHcyZDBVYWtPVzJxci9qRTIrb1gzcHdCRmpBSm5B?=
 =?utf-8?B?UjJaWU44RWE5NE00bjdWckZ6cFI1dmF0QmNueTdpdGVNZVFBZUNKdk40aXVr?=
 =?utf-8?B?YlJ1UTZMOGRkb2FnL3BCOGJtNlM0ZHVEamtzSjN1QWF1cWZ5VGo3cW9aallQ?=
 =?utf-8?B?NGo0ZDZVc1lsNllTUjJFWDJIR1FwODdKcitkNXdtWkF3bnV4Skx4bXliWjNl?=
 =?utf-8?B?VXhzcVJuK1EvSkc0Y3hSWkZhNnd4S1ByQm5pOGt4VXlzVks2dW5YbDZGa2Vt?=
 =?utf-8?B?OHhmZksxaXF1UnpsOTIvQnUzb3VjcWxpN0VSN1l1eWh2OE0xVU81TVRaRVFl?=
 =?utf-8?B?bnZuanlxeTN5aThOWmRTNVR3Y0FKNUMwcy80VlJ5dFJSWHlXaHFuaHg3TGpa?=
 =?utf-8?Q?7mKZ0lsgzYjRM3TjZtW7Sek=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <213BBF4702739040B083FAED201A622C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cf09bd-6213-4830-a694-08dcf968739f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 04:56:59.1444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U54U3tYPCMJuftSLuejxdXED6XIWqtFGlRIbSkcL35gvfi9z7ThK5jzfHuXmvuO3/woMUW0aIRzbeO+R0FRweJufM/8NCTVVPjinDCrI9RM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7524
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.860300-8.000000
X-TMASE-MatchedRID: Y6GLOewO+JjUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCifZYRtbOr2tFYJUGv4DL3zljSRvSGpq3A2G3vz8l/IEVoL
	GBk+cFXhgrYx6ioZiu7YdV0Ty7tRzf02f+pD+/c5or4yxPAz7WbWTdtEh1dU02oLGTNKlb9cCt/
	CFcKVHCVMkmRLuq2Fa4B9iQLPbPG9bivT24aMi7cnUT+eskUQPfS0Ip2eEHnylPA9G9KhcvZkw8
	KdMzN86KrauXd3MZDXJkHrmVWhUvpBbIn3wnfUUBkb/YrpJJmTbftr0sEcNfCBMNyGlbOw7
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.860300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DA58EA824051604261CE64FC7F437F80D31B9C08C4ACEDED32F981C6D373BD9F2000:8

T24gV2VkLCAyMDI0LTEwLTMwIGF0IDIyOjQ2ICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiA+ICt2b2lkIG10a19waHlfbGVkc19zdGF0ZV9pbml0KHN0cnVjdCBwaHlf
ZGV2aWNlICpwaHlkZXYpDQo+ID4gK3sNCj4gPiArICAgICBpbnQgaTsNCj4gPiArDQo+ID4gKyAg
ICAgZm9yIChpID0gMDsgaSA8IDI7ICsraSkNCj4gPiArICAgICAgICAgICAgIHBoeWRldi0+ZHJ2
LT5sZWRfaHdfY29udHJvbF9nZXQocGh5ZGV2LCBpLCBOVUxMKTsNCj4gPiArfQ0KPiANCj4gVGhp
cyBkb2VzIGFwcGVhciB0byBiZSB0aGUgc2FtZSBhcyB3aGF0IGl0IGlzIHJlcGxhY2luZywgYnV0
IGl0IGFsc28NCj4gc2VlbXMgb2RkLg0KPiANCj4gV2h5IGlzIGFuIGluaXQgZnVuY3Rpb24gZG9p
bmcgYSBnZXQ/IEkgYXNzdW1lIGl0IGlzIHRvIGRvIHdpdGgNCj4gc2V0dGluZw0KPiBwcml2LT5s
ZWRfc3RhdGU/IEJ1dCBsZWRfc3RhdGUgaXMgbm90IHVzZWQgaW4gc2V0dGluZyAqcnVsZXMsIHdo
aWNoDQo+IGlzDQo+IHdoYXQgbGVkX2h3X2NvbnRyb2xfZ2V0KCkgaXMgYWxsIGFib3V0LiBTbyBt
YXliZSBpbiBhIGZvbGxvdyB1cA0KPiBwYXRjaCwNCj4gbW92ZSB0aGUgYWN0dWFsIGluaXQgY29k
ZSBvdXQgb2YgbGVkX2h3X2NvbnRyb2xfZ2V0KCk/DQo+IA0KPiBSZXZpZXdlZC1ieTogQW5kcmV3
IEx1bm4gPGFuZHJld0BsdW5uLmNoPg0KPiANCj4gICAgIEFuZHJldw0KDQpJIHRoaW5rIEkgZ290
IHlvdXIgcG9pbnQuIEluIGEgZm9sbG93IHVwIHBhdGNoLCBJJ2xsIGRvIHRoZSBmb2xsb3dpbmcN
CmNoYW5nZToNCg0KW1BzdWVkbyBjb2RlXQ0KLyogQ3VycmVudGx5ICovDQptdGtfcGh5X2xlZF9o
d19jdHJsX2dldCgpIHsNCglnZXRfbGVkX2h3X3NldHRpbmdzKCk7IC8vb24gJiBibGluaw0KDQoJ
c2V0L2NsZWFyICZwcml2LT5sZWRfc3RhdGUgYWNjb3JkaW5nIHRvIGxlZF9od19zZXR0aW5ncw0K
DQoJZ2V0ICpydWxlcyBhY2NvcmRpbmcgdG8gbGVkX2h3X3NldHRpbmdzDQp9DQoNCi8qIENoYW5n
ZSBpbnRvICovDQpnZXRfbGVkX2h3X3NldHRpbmdzKCkNCg0KbXRrX3BoeV9sZWRzX3N0YXRlX2lu
aXQoKSB7IC8qIEFjdHVhbCBsZWRfc3RhdGUgaW5pdCBjb2RlICovDQoJZ2V0X2xlZF9od19zZXR0
aW5ncygpOyAvL29uICYgYmxpbmsNCg0KCXNldC9jbGVhciAmcHJpdi0+bGVkX3N0YXRlIGFjY29y
ZGluZyB0byBsZWRfaHdfc2V0dGluZ3MNCn0NCg0KbXRrX3BoeV9sZWRfaHdfY3RybF9nZXQoKSB7
DQoJZ2V0X2xlZF9od19zZXR0aW5ncygpIGluIHJlZ2lzdGVyOyAvL29uICYgYmxpbmsNCg0KCWdl
dCAqcnVsZXMgYWNjb3JkaW5nIHRvIGxlZF9od19zZXR0aW5ncw0KfQ0KDQpCUnMsDQpTa3kNCg==

