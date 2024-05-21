Return-Path: <netdev+bounces-97298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9608CA9D4
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 10:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A7C1C2097C
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 08:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97B153E36;
	Tue, 21 May 2024 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CdkLRtmL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mrkUJmHU"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD1F2209F;
	Tue, 21 May 2024 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716279472; cv=fail; b=ZawdFDTQ0KNb3KGsXinI3XXoD6AeTXKJAF5fslplqLAohthFaTmNwe1zPDvcCwHhGBiqhH91WnxqJndcHpXqc7IXr2wcMsobgCANe7EfjPzB4uQlACy6Shp1pxDG4WeRSRGknjI696O3N3rA+7+aC/pT2ZtU0L7eInHiuV+AoVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716279472; c=relaxed/simple;
	bh=5AhTj3AaMMb5QbRWzJbqV9IpzTm0oPJNu0JGAeVxFyU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dBg+LOR7DK9KwUgiiisEtb2mahMy/8TB6WSkJ2UALW6PMN1cMB1s9CvPixWVgJyW5wShMvN3hamikMm5eMPZK8N5JjYZSD3U9xmx7yMKt3p7px8x7sjM9ryQIwiSAWN3oCDkHD1QO8VP3Qr0y6TfktZWnli2ibGSQ39SYCZ0xHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CdkLRtmL; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=mrkUJmHU; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9550a5c2174a11ef8065b7b53f7091ad-20240521
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5AhTj3AaMMb5QbRWzJbqV9IpzTm0oPJNu0JGAeVxFyU=;
	b=CdkLRtmLp6OvzWickAXbyIPcx9OxVhQ5nGlEZGj0+/lw1IzWz+RsWecws6z/UYK/duShhpyfJse8RulA/74umLt6lnxlV+NKBr+aucv3cIKhGSd6OtGKww0z9ZdAfr8yDt5c4sSaBvukCfgpoFTkYycu9kuEg/ZRAa09NOI7PnM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:7ad4bd56-71bc-40a0-b58c-e247c1697ab1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:000d9f87-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 9550a5c2174a11ef8065b7b53f7091ad-20240521
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 65719932; Tue, 21 May 2024 16:17:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 21 May 2024 16:17:34 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 21 May 2024 16:17:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYnDeFMDBLDMkKeYLeZkr9zWP/vBdqvce+pcl5CrxQNyHFWjbSLBjCsNN8pFcRzdhXLYS1ItxOe5aAC8Xdd4RZ5HCZBByC+tWUSCmygmrng6NGlc9H55+EKUTHQXTswxjpmdppvTNjm6HLVsP45g+6qqZMDCQF5zt5if4uc5vsKJ2LIBwHrsW9s9uIi1i+0IGGeqX7G4TuTSCtKSHC36QD71tdsuUmkUhIt9c5FazFH8defGiuE/7qtoC03WjBPRvUdin80EmvY8DxO5RdzoPYDo6mu2K9J1xesx505yRFJqnW6rLT1dQhqsd3Z7mTsmLDLeqihm4CZ7bpDbja7rJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AhTj3AaMMb5QbRWzJbqV9IpzTm0oPJNu0JGAeVxFyU=;
 b=Xls/KFJdGT5DsxWGeyfRYW3RgUp5K6JJIUNT58T/e5MnseIAh6mS6jdqpV6HFZkVXzLWg1HCsgMnD0ksMnpgR3JoS/J8i2uch5bUuIdjIVAr0Lj1bZEjJx2puzsDe9goL8E9BeCT04knMLzvIG2MhqbvewfIYKA2wMIoO2IagJ6f/kPDmsCmmhALZmYMtd+g43dYMR4LW02MX42cL3ToA3yQMmVWt8480IyDvHlRlZVwaqS9/BFcVF6qghYK6omoJaDbK9GM1SGlRCSTon+4e7R852kRVzl94z4Cy/tqG7fmuWfoOhCFhmTLKOwf8MXBzi0dhXihtP1j0wvLgi8FBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AhTj3AaMMb5QbRWzJbqV9IpzTm0oPJNu0JGAeVxFyU=;
 b=mrkUJmHUyIZW5SLokwpeso5KhJGl6V9lwxmxcjh8omP/DCppPQ8o1MWHfWEQRvs04pWf/ROG1cDgEuuoyx7fPwuU6CzKelt1HSKlYOXYYGGx061y+6JPxnzxyF9a29TKp5/kCHWEmVWeuNH63nQ2QE8APSKDA+jndEAL4yhroOQ=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SG2PR03MB6634.apcprd03.prod.outlook.com (2603:1096:4:1de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.16; Tue, 21 May
 2024 08:17:33 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.7611.013; Tue, 21 May 2024
 08:17:32 +0000
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
Thread-Index: AQHaqqo0nm3iQO4q8kqKvRUSCwrNqbGgH9UAgAE5fYA=
Date: Tue, 21 May 2024 08:17:32 +0000
Message-ID: <ab5df65ebd52dfd54231b9b12657d47218df8f25.camel@mediatek.com>
References: <20240520113456.21675-1-SkyLake.Huang@mediatek.com>
	 <20240520113456.21675-6-SkyLake.Huang@mediatek.com>
	 <1158a657-1b95-4d7f-9371-41eec5388441@lunn.ch>
In-Reply-To: <1158a657-1b95-4d7f-9371-41eec5388441@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SG2PR03MB6634:EE_
x-ms-office365-filtering-correlation-id: 417aebfc-f5ca-48fa-96b1-08dc796e76e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?d21EYnhEdDZKOE0xcFlZR0tMWWNhN3BHc2t6V3AxYXovMDVRN0ZOS2FQUUo2?=
 =?utf-8?B?RTNoaFVLQVRkaGpvbWJuc3JuQ1dPeER0WmZQdnFpTUo1TjJFdk43OTVYdzVi?=
 =?utf-8?B?dG5YZWJrYTF4SGVyWmJJSkg5dUNNMjFLTUdJU1Y4WHp1L0Ywd3IzNnlYRjR0?=
 =?utf-8?B?UWVCRzg4WDZuZitUZWY0RzgzVGFGUXZkZXh2bSt3OXBsQTVORjJlTkZhZjJx?=
 =?utf-8?B?bkhVbVljOGU4S0luVVdFZmtzSldCcHF2aW0wR3o2SmNRaGJFNllDZEt1K2ZV?=
 =?utf-8?B?clpoeDErMy9uanY4QnpwN0Q2bEFVQ0ZmOWc4bk91Q1ZtQ1NGSEl4b1IyVFBT?=
 =?utf-8?B?bjVzUDV6Q3dDYkRzUWV3Y3VhKzNPdXl0QklQaDZZTFBuU0dWTllaa0FDR1cx?=
 =?utf-8?B?T0RXOFlqNkZQR0RMTjZzM2NCUjlsL0lEcWpBbzlaTHdZYVZhQ2NxalhQMGMy?=
 =?utf-8?B?V05mM3c4bjhXTmFGdk1CSjN4SkZVdGRGV3liTXVBK3RwSXhsbDFGNlNOdTFY?=
 =?utf-8?B?dWJDdkYvaUV2UzFxZ0lLOGRJTW1nTGthSWpZd3ltaWdZQnUyYUZIOXgrZnJI?=
 =?utf-8?B?dWtqem41aDhCVUg5UGZCbXZ0K1VxdzdYS21uSlVwRG5uVm1FTURlS1BtL3Qv?=
 =?utf-8?B?NmxKaE5uRE1nQ1ZUbFlKcWRWVXJ2bmMvTHc2Qjd4SmlRdmJaSTdNV2thamxz?=
 =?utf-8?B?UHJhLzNZY0wxWWoyNEFScFN2MFRtRDZBYkNQN0tqYW9TaktoZEhPS3NPNEZJ?=
 =?utf-8?B?RDR2cDlnMEQ2ZXpJUTVjUU1EOFdDR1V6S1QxQ1RWZkVUZm56TE5yc045RHQ0?=
 =?utf-8?B?TllsNm9uazhZM0FsamxMOXh2VlZHTkRRa3NoWkloQ3dJM0pRZE9IaUU3cE9v?=
 =?utf-8?B?U21PQnhpQUVVeHNMVUZBTUZzZWtqc0k5czFZMk1mVzBoOHNkaXZnN3dkRFdm?=
 =?utf-8?B?dkpyY2QyNzVUakU0MERjWkJsQjNEZUI3b0Z0M1hsYjBrb21ocWtEdG5VTlNm?=
 =?utf-8?B?bGl4SklSR0FGNHhIbHJ5UldsVW1IVW5BeGNHSXlENjR4Q25nYWJpSmN1Nzh2?=
 =?utf-8?B?NjRKTGY3NDlvYjIybnMwSDEvbzZvb0wwd05uM1I2YmtGVTRtUVZ0V3JLbXF6?=
 =?utf-8?B?TjQra0E3cjBJZTU1WG9GYzRSVXlkekg1bGt4RG8vY0hUU1hRYmRPRzJTQmdC?=
 =?utf-8?B?SkoxeVJDclBkeWpMSFdUK1FzeUZiOU5XbWphMTYvQ1FZWDhzYUJ2VmNlY0Q1?=
 =?utf-8?B?MWV4Q3c5MkZUWTVZWlNERzlCVUJBS3NDanZ2K3FrTnA2OGVNWkxDMmt0WEdC?=
 =?utf-8?B?Ny9KQ1pwKzNNWUZIUXc5aXpsWnh3WVNYbU9VWk1TdEJCbWhva1pTeittV3pv?=
 =?utf-8?B?WGxXQWNGejdKelQ1OWl2TmIxZlVYUmY5RE9IMjFSVnJab1lIQWVLUU5jMTR4?=
 =?utf-8?B?aFdJOVBpVFZBblJUQnBvb2JpU2c0THRYMXVLTHhyVjBUOFUwNi8yRW1wVFFw?=
 =?utf-8?B?Y3BDYlFRYm9hUEZsYWErL2FWNjY5ZFNnSmo2OXJ4SEplYzQrT0l4cjJqOW5l?=
 =?utf-8?B?UExocVRwVU5zUk15WTZjYzJMdEY4eVpuOUk0Q1YrcmY0dy9jQzkxWVBUMUhB?=
 =?utf-8?B?bTJ5bFdReFlFSEpiK013NXQreUVkN2lTa3BpZ0hlZHUrYy84RzZHNzJWQjN5?=
 =?utf-8?B?aEZSSVpHOFkyN1k5eEpsaGU1Q01OYnZuTEJuTENPTHZ1SnBsOVNzQUY3UE9J?=
 =?utf-8?B?ZHdVOTR6cW1lazd0UU9BUjBlYVc5Nk91TjdweDM1M2tLclRnb3BtTG12eTgr?=
 =?utf-8?B?SWFXWk4zS3FyZ2YrMFJ4QT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDZJa1BPKzQ3Y0FPSnF5cUFQOFRPZGFUU1lNVnZvUHkrUHhZQlFsaDdZaENO?=
 =?utf-8?B?SDdWZFRwdTFmUkZkV2xDV2xVOENBYWdpbmU3RGVaT1B6bWVrT3doL3YyUkFR?=
 =?utf-8?B?ZytrQU1BVEF6MlFHdFRxVWZ2U3h1YzFmeTRQUy9Kd2k4czNZV3RhVHVLVEF3?=
 =?utf-8?B?cU5aeW92Z0hWVTdRL29VWDhPNzlSVVJNaWo4OERzMlJ5ZUVYL0dQNGNRREZ1?=
 =?utf-8?B?MEV6c2hqRklZckswOVlPbnNMQlRyRkZjN2hDbnV3a3VGT3Bwd0huQ1BvWW9H?=
 =?utf-8?B?WW5YTExxUC9Ia1J3UHM2SmV1VVE1cGdtbmFrNHk3Y3B4eHFkL0xvQWNTVTR3?=
 =?utf-8?B?RzlHcURDc1V2ZlAyaUwxNVQwUTQzb2ZaWndtSERlb3U0NW1yOE9WUzZXSjR4?=
 =?utf-8?B?ZUI0UUlwV0hTbTdpbUw4eHBkNlJ5NEM5dkozNmdVbU9zSlppOXp4cFIrd3FT?=
 =?utf-8?B?Ui9nUU9CQzg2Wkowcmcybmp3U2FkeUpNbHdUc25zMktGNUt0UysrY09MQlNR?=
 =?utf-8?B?UGU0c01mMTgzQll5MEUzSktFWE04elJYQkNQRC9LUGozWXFFdys3UVhzQS9P?=
 =?utf-8?B?WGNqZVYzSHpGd3NMT0pPWHNwOHByeU0zYjJZTEZGVldySVpWYjBBNzNqZVll?=
 =?utf-8?B?c0RYd2liODJSOHVVMFMwV210Yi9VenhMTVA4a09ack5zVndjOENpb2R6U21m?=
 =?utf-8?B?WnlvTXByQ3NTSE14aDJTcmVFamdpZkEvdnZTcVFUdFIxWHVDOUJsWE0ydHNt?=
 =?utf-8?B?TVIxR1JKOXBpeURKL2EvcVRUL0EzM2lHRm1xMFViWVhLVUdMMkZXemJtdTlr?=
 =?utf-8?B?OGFkcXppTHhSOHRacjI3NEp2VmxoWC9Qa3ZsSkptMjRPWEVxVUZSRXhwd1Zx?=
 =?utf-8?B?Y2E0Y3VxRitOcXdnNVJRRWFaQnhtNFpxSkNnT2RtUmpsTGprcFlxN0VIN2M2?=
 =?utf-8?B?SUI1cjRZWlZWSk95bEUvNjVFQ3piU1BDYjRzb2FsMXZueVdqZUtmVElvWWUx?=
 =?utf-8?B?M3lTa004bGw4NEtYb3VwYnJUSDNIbW9KZFNEcTZvSVZ3QTF3VStNMlZSQXFv?=
 =?utf-8?B?dERBanREVFRlTTZhVWJXS01UUzVRUVJqa0MwUTFwVjluRUVRU3Z3K0xLdVdN?=
 =?utf-8?B?TTZVSmlnUXB2aTd4N2JLUmYxbTJlOGdYOEdLblFhUnp1NjYvekxrU0M0a3Az?=
 =?utf-8?B?Zk5hQ3ozOXdyakpqRXI4ZDRNRXN2K1g3Y2F2NkVkT1Z0WWI1N0pJR3JrdnNx?=
 =?utf-8?B?VTFhT2hTUDIzOWptb3NDTmMyVjFwaTc1b05CUGNpd3VXU3NjK25kcjBuMFpR?=
 =?utf-8?B?aWFWbEE0bFlLZW1RZjJQcjVEcGhpN0JsNmVvMmlzc290T3pIa3QrTERUR1BI?=
 =?utf-8?B?SlJFZkI4QU1wYTRWaDNBSGxoZTZTQkVDNUZWTTJkb01DRTV5ZDROMElEbmNY?=
 =?utf-8?B?c3lRbTB5b016RHFnSXdPU2R0NTFBd1J2cVBIRUFjVk5MQ3pQeG9kVmpyR0lt?=
 =?utf-8?B?YUdUendQNEZVV3dxYk1KcWxna0l4SHcxTkVzbnpqVkNQUE9SZXhMQXBPazkw?=
 =?utf-8?B?RDBlVGxqRS9XZ21NdCtaWkJPRWRsblVWeEM0aE56TUZGNnp6UXZTMlE5Vkpq?=
 =?utf-8?B?eVFIbTNxRzUyejFHeCsySkl3a3FoVTFLU0FkaEJKNUllTWtUY0FYaXhwaXRJ?=
 =?utf-8?B?MXFocndlMENENTRRczBnS29OQ2s4TDloN0RkckxwbTBXVFQxWmxQd3FISVFy?=
 =?utf-8?B?djJNOFFqc0o1akZTTVVwcVFIL2o1WkZGWlc2WUZaaVZnZFBnNXRGZ1dYQjFm?=
 =?utf-8?B?Z0duSm02eHVua3d3Qm85eFk5UTZvOXpTaWI0U0xEbWFzWkpOZk1VVUlIck1R?=
 =?utf-8?B?ZUMyV2s5bGk5L3k0UFljS2ZYd3FUUHlOMkR5Q1BoRVdqNzdqekg5QkNpOWx6?=
 =?utf-8?B?ZmFBeFp1UVNiNjUyNHBuRXA1amtJZmFnejVXdnhkM0tZZFhBbjFVYmZXRHc5?=
 =?utf-8?B?ZkJEdDhIdSt3anJXMk01dkFVQXdRYjk4a3lKaFNKa1prUWNac0cycElXT0Rr?=
 =?utf-8?B?TjlraTVvRGVnbTlJaFJnOHlTbis5YWF6QmsrY1RmS2VyYkxndmFzZnJ2cS81?=
 =?utf-8?B?QjU5STZDc283TEdXK0ZBV2NLbThlenJTSHVQNjc2d1hxVEQwbEQ4RjVjKzYv?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7677D54D99373348A7D21934B0DEFCEF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417aebfc-f5ca-48fa-96b1-08dc796e76e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 08:17:32.7916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +veahHC7mMoStMKLvESF77X7Udbbaic0T95YQgFVust8ae3C6nhMiCY93eqly+MlMBBngZKdLvS9jWaOqyCTaxqJsCj6rN6J/MrV5q1wz0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6634
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.115700-8.000000
X-TMASE-MatchedRID: u8usGLXufdjUL3YCMmnG4t7SWiiWSV/1jLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo24pdq9sdj8LW5+1figft3LvHSsb509cZ3ilv
	Ab18i4hMxBO4rsHPOMI3/d0NuPcI1XqbZn4+AZIuuG6vp8tkx51PgO2JKQydY+Cckfm+bb6AS9q
	LLLUpjh7e9VDBobMgNCUzRu+qer0IzYvrhb3stxp4CIKY/Hg3AwWulRtvvYxTWRN8STJpl3PoLR
	4+zsDTtAqYBE3k9Mpw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.115700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5CB6089CA0DB9559D1643E7B3A62BE926FA0EDCDE8E5C380EB4DD26FA40A4E772000:8

T24gTW9uLCAyMDI0LTA1LTIwIGF0IDE1OjM1ICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
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
DQo+ID4gK3JldHVybiAtRUlOVkFMOw0KPiA+ICt9DQo+IA0KPiAuLi4NCj4gDQo+ID4gK3N0YXRp
YyBpbnQgbXQ3OTh4XzJwNWdlX3BoeV9wcm9iZShzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0K
PiA+ICt7DQo+ID4gK3N0cnVjdCBtdGtfaTJwNWdlX3BoeV9wcml2ICpwcml2Ow0KPiA+ICsNCj4g
PiArcHJpdiA9IGRldm1fa3phbGxvYygmcGh5ZGV2LT5tZGlvLmRldiwNCj4gPiArICAgIHNpemVv
ZihzdHJ1Y3QgbXRrX2kycDVnZV9waHlfcHJpdiksIEdGUF9LRVJORUwpOw0KPiA+ICtpZiAoIXBy
aXYpDQo+ID4gK3JldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArc3dpdGNoIChwaHlkZXYtPmRy
di0+cGh5X2lkKSB7DQo+ID4gK2Nhc2UgTVRLXzJQNUdQSFlfSURfTVQ3OTg4Og0KPiA+ICtwcml2
LT5wbWJfYWRkciA9IGlvcmVtYXAoTVQ3OTg4XzJQNUdFX1BNQl9CQVNFLA0KPiBNVDc5ODhfMlA1
R0VfUE1CX0xFTik7DQo+ID4gK2lmICghcHJpdi0+cG1iX2FkZHIpDQo+ID4gK3JldHVybiAtRU5P
TUVNOw0KPiA+ICtwcml2LT5tZDMyX2VuX2NmZ19iYXNlID0gaW9yZW1hcChNVDc5ODhfMlA1R0Vf
TUQzMl9FTl9DRkdfQkFTRSwNCj4gPiArIE1UNzk4OF8yUDVHRV9NRDMyX0VOX0NGR19MRU4pOw0K
PiA+ICtpZiAoIXByaXYtPm1kMzJfZW5fY2ZnX2Jhc2UpDQo+ID4gK3JldHVybiAtRU5PTUVNOw0K
PiA+ICsNCj4gPiArLyogVGhlIG9yaWdpbmFsIGhhcmR3YXJlIG9ubHkgc2V0cyBNRElPX0RFVlNf
UE1BUE1EICovDQo+ID4gK3BoeWRldi0+YzQ1X2lkcy5tbWRzX3ByZXNlbnQgfD0gKE1ESU9fREVW
U19QQ1MgfCBNRElPX0RFVlNfQU4gfA0KPiA+ICsgTURJT19ERVZTX1ZFTkQxIHwgTURJT19ERVZT
X1ZFTkQyKTsNCj4gPiArYnJlYWs7DQo+ID4gK2RlZmF1bHQ6DQo+ID4gK3JldHVybiAtRUlOVkFM
Ow0KPiA+ICt9DQo+IA0KPiBIb3cgY2FuIHByaXYtPm1kMzJfZW5fY2ZnX2Jhc2Ugb3IgcHJpdi0+
cG1iX2FkZHIgbm90IGJlIHNldCBpbg0KPiBtdDc5OHhfMnA1Z2VfcGh5X2NvbmZpZ19pbml0KCkN
Cj4gDQo+IEFuZHJldw0KVXNlIGNvbW1hbmQgIiRpZmNvbmZpZyBldGgxIGRvd24iIGFuZCB0aGVu
ICIkaWZjb25maWcgZXRoMSB1cCIsDQptdDc5OHhfMnA1Z2VfcGh5X2NvbmZpZ19pbml0KCkgd2ls
bCBiZSBjYWxsZWQgYWdhaW4gYW5kIGFnYWluLiBwcml2LQ0KPm1kMzJfZW5fY2ZnX2Jhc2UgJiBw
cml2LT5wbWJfYWRkciBhcmUgcmVsZWFzZWQgYWZ0ZXIgZmlyc3QgZmlybXdhcmUNCmxvYWRpbmcu
IFNvIGp1c3QgY2hlY2sgdGhlc2UgdHdvIHZhbHVlcyBhZ2FpbiBmb3Igc2FmZXR5IG9uY2UgcHJp
di0NCj5md19sb2FkZWQgaXMgb3ZlcnJpZGVkIHVuZXhwZWN0ZWRseS4NCg==

