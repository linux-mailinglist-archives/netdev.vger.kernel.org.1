Return-Path: <netdev+bounces-166399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E03A35EA5
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DAA3A7555
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216442641C5;
	Fri, 14 Feb 2025 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fYxM/Zph";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dTfM+53k"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2FC263C9D;
	Fri, 14 Feb 2025 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538813; cv=fail; b=tEeIyncFZnjF9R9G0e01KyDGS47CYVpGYJNYUE2eUsOworAYF91rCryNnkPVgR0bkd6m+d1BeDi/+NtM+8uPEWfqpseFRgZ5Vxv5OTxAv5pdoxft546l6DH06AbwcniItVD6Jnlngc5kBaX4wAY9/Od9KMP7lij4OwqPuZi65Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538813; c=relaxed/simple;
	bh=2C9vl1HCoVWPV9Dwb5UQvlJaye8c6vpQYcVIt4MyJk0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IvaGFumwBKqxbF2g7p1IGdRBeW5qjkzotZmqCXHZ3OwBSAdX5ll+RVg2XewLbZh+haRUinq+V5B9Ei//jMoluwWCvdtmLGR/iAkgO/FMPIPh33rCCNFvktmRfq7tXb5aQ8qREW5USW0ZOlXbxs50l1TMgR5RHqSin7ktuo9lqCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fYxM/Zph; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dTfM+53k; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 755478b6ead511efb8f9918b5fc74e19-20250214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2C9vl1HCoVWPV9Dwb5UQvlJaye8c6vpQYcVIt4MyJk0=;
	b=fYxM/ZphivyY60JIgch2ebkUVGKEOL3+K0rzCeEVltlvmR3ZnCMbtfUf+yy514jZ2Z8Jro4sR2UDPhlyLXCTxcUHRwZf59233vL+/+AGS6xENs+2GAAmI6+A/aIfbtz6whq5DCFA9tG6El+qbZeaK9JssCa90sjJhFfYwMDhZXI=;
X-CID-CACHE: Type:Local,Time:202502142113+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:10aede18-d477-4131-a4fa-e103b7740e4d,IP:0,U
	RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:2
X-CID-META: VersionHash:60aa074,CLOUDID:37155bfc-7800-43c5-b97b-ddbe32561a5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 755478b6ead511efb8f9918b5fc74e19-20250214
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 436018046; Fri, 14 Feb 2025 21:13:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Feb 2025 21:13:17 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Feb 2025 21:13:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdBimTIcFYJMWNDDaU7jnim9YMS+/VpLDy4MsTzRyWzuVQx66Xd1s8GpPSTP0id4tFez0kIYsD9pKDAjhpk1iOl31g5dxEKj7lmkAd5AYMTJs3usbjBAVIuQqsOMboh1wkNeG3i2ZoKHRS53FDGhRSOvKot6aUAD6m1O/JMfOSLsjJb5kqamh22AJiAVfEynu71ZH1rCKJuUZolIIET39VOtVNnOEM6ucv9UpGbKMQExAUIgiKuTA0Wm1LfT5g2+t5nrCrkaUC4QB9yFSbmE3T5rJ5poE/OxF1Ftzg1RpxoNIbOGZ/cPMnFH1KqE7VigivHtK5heiGaid+vv2Tshug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2C9vl1HCoVWPV9Dwb5UQvlJaye8c6vpQYcVIt4MyJk0=;
 b=vI5d17AecfQx17/p3g0IbO4qKBHWwN6qB1YH+uvOMGBswVNobyZq5BHRo+ZSwcgsS87a309cNODWs730F4ehzAZ/9KUyO/hNpWqx9+1KzUYfg+FSZzr9+8pG/XDfR94TckNGL0Gj+vqo8lviL8BZwhnfA7Ut5kuVCa/f/M4D8uhB0P8/gqYIjkgRRvrZSPoDckWl8StJBVKvC+aCPLOB7LABN0zQOquWG0HIUihFzFcnDpJprlEwqL+3xzl/jVucfXnXHKWGQ4tO3AIxupUIYJyV6h42djhCGovyMsLZ+ewmIeCnXNtfELIcbl45BL29kwhkdZh5h8AuN3ee8XkXJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C9vl1HCoVWPV9Dwb5UQvlJaye8c6vpQYcVIt4MyJk0=;
 b=dTfM+53kmPq6bhld6XZa1b+MD8WmBjMBtLJUiOlDtmZcVmy5PaDZfZrCBo5+HXRk431z6BCpY/a92X5TG7S2H7LBDdDahzokLMGOdhyTW2FEm7TaGsKMdKNCK8GiSV00d1L6GBMhixJ6DzF0xvF66z/qhUBZsnstJQwjVg8AOS8=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SEYPR03MB7249.apcprd03.prod.outlook.com (2603:1096:101:c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 13:13:14 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 13:13:14 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH net-next 3/3] net: phy: mediatek: add driver for built-in
 2.5G ethernet PHY on MT7988
Thread-Topic: [PATCH net-next 3/3] net: phy: mediatek: add driver for built-in
 2.5G ethernet PHY on MT7988
Thread-Index: AQHbZ7WXaWwg6/r4eESVGpzWtCL1+LMYpNSAgC5QJ4A=
Date: Fri, 14 Feb 2025 13:13:14 +0000
Message-ID: <73333d85a63eeb984077df8e27b8c75e6270efed.camel@mediatek.com>
References: <20250116012159.3816135-1-SkyLake.Huang@mediatek.com>
	 <20250116012159.3816135-4-SkyLake.Huang@mediatek.com>
	 <Z4hnv2lzy8Ntd_Hp@makrotopia.org>
In-Reply-To: <Z4hnv2lzy8Ntd_Hp@makrotopia.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SEYPR03MB7249:EE_
x-ms-office365-filtering-correlation-id: 5c9a9646-fee0-491d-ee0f-08dd4cf956f6
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d3NKcGlFQzZXbDE1YXIxUVp3TWtIUkJSV000S3BTeU0zNEdDSWpBMTFtYU5T?=
 =?utf-8?B?cTJBS3lSazZWYWVrb3cxQm1yMFRHRWZwZWtjVWxBSUNRbUgzdEhmMFMxbnpu?=
 =?utf-8?B?NWU5M0Z2Ky9ucHdxTnNGZ2c5S005dDVWNk5qbm9qRHVtRkFtU1JpV2hwYnpp?=
 =?utf-8?B?U2pnVVhuMmlWM01lekJnZUk2YXozL0QrTnFZMFM4ZUQwYkFETnNibmRSMGZK?=
 =?utf-8?B?MHMwNEVnNjBRS05MR2UvYUJMNSthNTNUOVVMakhYeDNZWlljemkzYWt0Qnds?=
 =?utf-8?B?eHczVFk1eDc4VzZ3R2cvbVhxTWpFTStySHF0NkJqTmRpRE9VVUZaVTkwYmlj?=
 =?utf-8?B?QkpLMDNLNDRPV0NtdytSRnlzSDFpRXFNVWRPVkJGZW44US9qOFM5cTA5eFpR?=
 =?utf-8?B?L3RyTkZTbUNmSCtISE0zQUZvWEQ3VHdCT3FKM29JVzhpdlV6cm1NUHhlQlFu?=
 =?utf-8?B?NzRnMHB6UkJwV2Zmb01WRjlwbUZjNEtkY0V6WlJkRHdGTWtjQUJtWlp4Zk44?=
 =?utf-8?B?dVIzN0xHaXBIQTA0ZlBKeXFLcDdWMzZ1TStzK2JoMHFVamdCU0dZU3lCYmhY?=
 =?utf-8?B?RXVQM1RDRzlVWlE0OEF5MWlWMEIwWWVoNnR2anhtbWdtNG5qVnBtUVgvZzZt?=
 =?utf-8?B?TlE2N1dNTzJiNTdDa0lKL250N3RzQTFDdFR6Z3h2eWFiRnZVNHdyQUptTVR2?=
 =?utf-8?B?WFlFVVRpa2ZsUmZ2OFZmdVFWRXB0SHhsa2FhWEpLVkE2Yis3MEZ6bUVaVGhJ?=
 =?utf-8?B?NDFabk16RjA2eXBUVkl5dWF0SXh0ZlR5VXhKY0RzRTVOVGh3MnJocU9adHFY?=
 =?utf-8?B?RjBOYU9mUmhIdVNKbGVUNW9IUlRrN0NCQys2TDllb2FGTStpazVlV0crbjFU?=
 =?utf-8?B?MHUxZEQwdHlNRnhmNVlHVEVOQjdpSk5YQndEQUMyODhOY3RQcnNTUTR5WU9a?=
 =?utf-8?B?OHRzVEZ1Y1dVbVk2YjZ5amsydHNVYmZDSUY2RXdMTElMSERTa0JlN0FnbFFE?=
 =?utf-8?B?VVhOTHJDRWEwVVlaMEU5WFZHNW51U3k4MllVcnNrQXVDRGNETk9xMmhoYUk1?=
 =?utf-8?B?N0R1UXVXSDJkanB5MVRZUkRvZzl5SGkrY3BMK254dWY2T01UMjFOWVRRdkxD?=
 =?utf-8?B?NTFvYXZzdFJSN01RbkRpV01MYnR2V2Z6TWlyd3RYaG9BcUx6UzBSa1QrLzls?=
 =?utf-8?B?L1hOb1RPU1ArU3BEdzhMZGp1V0F3SFBVVkNjQ1RMUjg5dXM4V3U1SFROSk1y?=
 =?utf-8?B?VXQxQVAxck1CMzFtWVgrN21qT2hTYkE2WlRpZWpZWmRSLzZvM0YvREdEVkxr?=
 =?utf-8?B?QjBlNGtsTkE4aFg5R1R0VUw3T0t1Z0NNRDlJSWlUNDlYT1F5a21ObEZxWHFD?=
 =?utf-8?B?SStFM2RMaGRtdE8wYmVJekh3WVFOWDlrTm01RDh1WjBtWWRMZFBmbFZBQlMx?=
 =?utf-8?B?bWpQempSSkJvSFgrNU9KNTd3VlRvekgwTU9KZkRPL2oxUGhoM3oxRGwycFRj?=
 =?utf-8?B?aVJjRGg1SUJub3Uzc0dVbk5sNTFnSmlUNnhKSEhDN0EvSjlpQm84YXNVMFVn?=
 =?utf-8?B?RWkrMVJsaE53Q2NsTTdrVVBMWW4vWUl1cjVLaVg1aWNWVUZ2ZjlCS3RTZVFT?=
 =?utf-8?B?bEozMTVHb1pMZE45WmZtMFRacVFsZUswK1E2ZTBEa0pEZ3hjaVdPbGV3MFdi?=
 =?utf-8?B?NHlxQnJLOGsxanNlbTFSekFVaU1rcWtDcC9nYTB1KzBaWGZwRzBMdnZ4RUtu?=
 =?utf-8?B?dmg0NnRBRnVMQ1U3Y3VPOGhDdGFxaEJ4dXoxbDQ5MUM5VFkvNHkwcmJnVFEx?=
 =?utf-8?B?Q1VUR203RDNTQVhPUkVpdVNRb05Gc0VuRWp3NWs0SWFaZ1FKR25oTnd2eHFP?=
 =?utf-8?B?V3pOZXgxSEhYV0VGcmc2WGRsczY0SzlyWGJva2V3NTI5aDkxeXA4UC9DMWNX?=
 =?utf-8?Q?FeQnk403XF+taJe/6SoNuc6kooKwnZR4?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bE5ZbjZNanVnSWJubVRnSVFtWkFJelVTaVhLWVl4ZzVtTkZEWFZyeHJHRlVm?=
 =?utf-8?B?SVljTXFUUXk3UXA3ZkxsVnJ4T0pqQS9VZ2gyVGh6b2VYdkRhK1BrY1Jza0ZN?=
 =?utf-8?B?dXoxa2crL0REUGJCbHVYekhTaGQ4Qisyd2wzRDRUU25DT0EvQ2s0UllibEh5?=
 =?utf-8?B?d1dLZTZiMit2UVJHRGx0RnhuSVJZQ3JqRTJuaWdpYUNlK3FMR3k3ZTZndmhT?=
 =?utf-8?B?NWhidzBYT0t5U0NpQUNFUFZnenRXeGdCWC9jMGRyaDd6WVRmNjRpK09KcXoz?=
 =?utf-8?B?MElTZEdPVjllMVRJQjY2ajNmMEVYKzJ0dnlDTEIwWEFKRmtRL3NUUzYyWmdU?=
 =?utf-8?B?MEdWckJqRjJPaUZWNmMyZEUxM3JLN2YvM1A3ZmsxMWpJNW5FTHdJNENRcnpC?=
 =?utf-8?B?SDc1R1VzWHNDK1IvdEV0VmtPQ0tvTVVNM2k1aHNuZWNtYVFHM1B2RUVwVjBE?=
 =?utf-8?B?WjJSMC9xK1l0am1IeVVhL2dsVDlTYzVZbjZieSt0Z040WitQLzVwaFIrMEFW?=
 =?utf-8?B?NGIybVdmeGRiZDNwQ0hqcXF4WDFiSmsxN240THd3dkNVVjg1REdtUFIrZTJo?=
 =?utf-8?B?bU9zcFJORHNqSm9rVUxldmsxeEQ1aGt0YUUyNnp3emFKR0o0RnBSa0krajd2?=
 =?utf-8?B?T2JNcDYvVnI3RTliMVBEd0JKODU1Z0tibUlUSFpuU2ROanNiWUZrTmhMVmk4?=
 =?utf-8?B?amxpdWVyZk5MZGc4MTBnVTRicVArc1htZUkwKzdlcWpIOWJvOHlNT1FUWFpa?=
 =?utf-8?B?TllzWnhzOWpCQk5CeTZzSXRIcldZak1NTDJMMFE3UDFDdU5vWUlITlA0WUFQ?=
 =?utf-8?B?UzUwYXdxOWp3czRESGEzQWhKVWFocUFacUNLYXZVbGdEK2pYK1h5eWFucmJM?=
 =?utf-8?B?bnNsWmdhWDdMQjlEcm0vYkxkOElRdy9uZXE0UXJzZWU4Sk5ReGdQbkliZWly?=
 =?utf-8?B?cDZvS0RiUExoZkh4cDdCaVZ1V282ZGIwNVc5YUlkajJBMWtENmZBczNFQVdY?=
 =?utf-8?B?N0l2dWxxL3U0VXV6WGJEVWVjcDFNdVk2R2ZsL00ydm85Z05VeHdzeVN4OWRG?=
 =?utf-8?B?UHIwSnpnK2pBb2xBRHEvOE9WTE5YVFd1b3BhSWYxcGwwYVNwVzZsYkZjTFdE?=
 =?utf-8?B?Nld4NlJFeWEwK3JidkZQd2prRDBFbGtlWWhYZ0RJb1dOdzdJMms2OUdJZm1q?=
 =?utf-8?B?MEVicWg0bWpaN0Fvd1hGSytBYi9uNU1GQmUwZFBwTWF1OVNEb3d0Z3VGckd5?=
 =?utf-8?B?dEN5K3VnWExLVzMzYS9TNEFNMDhoQUFEcDNWVG9ETEpaRHk4cFJtSktCTmNS?=
 =?utf-8?B?TXRWTjVMWE5SamFFM3JLOTNNZ1ZMQmNXYzZ5aS9QMDFaMXVKU0F0RTU5Rlp1?=
 =?utf-8?B?K0dETXlIeWY4NWlkWjdSSGFnZ3ZRSnFMVjhmMnhSWk5ob1Yrdk40V1dhUnR1?=
 =?utf-8?B?NkN2QTJLdUJNVHMrdzRHRnNvMGR1ZmcxWWNMRXNaenNpTWNCeUZsZ2JBbTRo?=
 =?utf-8?B?R1FQenhNYnZMVXdLODRHR3BiMGJzYlI4VFFIZFRlS2YzNFhGT1l1a1BNRzlZ?=
 =?utf-8?B?MFlhd1FBTUI1a0RTNksyMlNSczdNWC81aHVEWGQ0OG1jSnpWU0FNaVpQd1Rx?=
 =?utf-8?B?Q2RBOTcrWHp2cmROMHNvbzkremRxK216Y3lpaDcyUjBzemhVVW9KUGRyU0Fq?=
 =?utf-8?B?QWdPL1NOVnNJVVhmTWJ3MCtZeDdKMFdvUFRyK1NFdGdwNUJSWWlCSWk0Mi9X?=
 =?utf-8?B?RzQ4NUlHUFBwYzBqb3h1RWtrZUgvZ3ZjaXFLMHA2aDRRR2h6M1I3dm9XTE1O?=
 =?utf-8?B?ODdHb0grZlk3ZFo0cElkT0xLaTdkTHhvajQyNlF6eGs4UzBlUkY3UGwvbk5W?=
 =?utf-8?B?ZUNnWDNPR21VRGg5OFh1K0N6am42UU5WTFlWUDlzYWpFZjdoNHU3U1BiWVoy?=
 =?utf-8?B?TU5JYjRDZ2dnUXVkRWVUK1IwdmRhT1QzRXFXdkxmL1VFSzFFK2JPQzg0Z25n?=
 =?utf-8?B?R2dUWW5oQ3JuZnBDK3JpeHd1dU1Ma042MzZlOTR1RkcyYjFiREdLanF3N0ph?=
 =?utf-8?B?QmcrSVplVSt1U2hvMldFSHp5d3ppaWFDZEVodElRd24rNXJSNE4rdk94b0tD?=
 =?utf-8?B?SlhZckEzTjBUTFB1VEFuTW52L1NmUm1mMjArbXpiUlFIQ0NYb1hiNmpta1VV?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2545F56A15A9314C884CBD577644182B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9a9646-fee0-491d-ee0f-08dd4cf956f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 13:13:14.5606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHcOXcIJf4jLS1GQSqcVhnO1cnf72Ps62XyPfYNBc1gwWBqlG7K0ygCGFCtuqBJjgNJRbGaCfK0CS0HTPnmwgrpfp6qCUSi/a+B4yTzf4QQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7249

T24gVGh1LCAyMDI1LTAxLTE2IGF0IDAxOjU4ICswMDAwLCBEYW5pZWwgR29sbGUgd3JvdGU6Cj4g
Cj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW50aWwKPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lgo+IAo+IAo+IEhpIFNreSwKPiAKPiBPbiBUaHUsIEphbiAxNiwgMjAyNSBhdCAwOToyMTo1
OEFNICswODAwLCBTa3kgSHVhbmcgd3JvdGU6Cj4gPiBGcm9tOiBTa3kgSHVhbmcgPHNreWxha2Uu
aHVhbmdAbWVkaWF0ZWsuY29tPgo+ID4gCj4gPiBBZGQgc3VwcG9ydCBmb3IgaW50ZXJuYWwgMi41
R3BoeSBvbiBNVDc5ODguIFRoaXMgZHJpdmVyIHdpbGwgbG9hZAo+ID4gbmVjZXNzYXJ5IGZpcm13
YXJlIGFuZCBhZGQgYXBwcm9wcmlhdGUgdGltZSBkZWxheSB0byBtYWtlIHN1cmUKPiA+IHRoYXQg
ZmlybXdhcmUgd29ya3Mgc3RhYmx5LiBBbHNvLCBjZXJ0YWluIGNvbnRyb2wgcmVnaXN0ZXJzIHdp
bGwKPiA+IGJlIHNldCB0byBmaXggbGluay11cCBpc3N1ZXMuCj4gPiAKPiA+IFNpZ25lZC1vZmYt
Ynk6IFNreSBIdWFuZyA8c2t5bGFrZS5odWFuZ0BtZWRpYXRlay5jb20+Cj4gPiAtLS0KPiA+IMKg
TUFJTlRBSU5FUlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqDCoCAxICsKPiA+IMKgZHJpdmVycy9uZXQvcGh5L21lZGlhdGVrL0tjb25maWfCoMKg
wqDCoCB8wqAgMTEgKwo+ID4gwqBkcml2ZXJzL25ldC9waHkvbWVkaWF0ZWsvTWFrZWZpbGXCoMKg
wqAgfMKgwqAgMSArCj4gPiDCoGRyaXZlcnMvbmV0L3BoeS9tZWRpYXRlay9tdGstMnA1Z2UuYyB8
IDM0Mwo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiDCoDQgZmlsZXMgY2hhbmdl
ZCwgMzU2IGluc2VydGlvbnMoKykKPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0
L3BoeS9tZWRpYXRlay9tdGstMnA1Z2UuYwo+ID4gCj4gPiBbLi4uXQo+ID4gK3N0YXRpYyBpbnQg
bXQ3OTh4XzJwNWdlX3BoeV9wcm9iZShzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQo+ID4gK3sK
PiA+ICvCoMKgwqDCoCBzdHJ1Y3QgbXRrX2kycDVnZV9waHlfcHJpdiAqcHJpdjsKPiA+ICsKPiA+
ICvCoMKgwqDCoCBwcml2ID0gZGV2bV9remFsbG9jKCZwaHlkZXYtPm1kaW8uZGV2LAo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2Yoc3Ry
dWN0IG10a19pMnA1Z2VfcGh5X3ByaXYpLAo+ID4gR0ZQX0tFUk5FTCk7Cj4gPiArwqDCoMKgwqAg
aWYgKCFwcml2KQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT01FTTsK
PiA+ICsKPiA+ICvCoMKgwqDCoCBzd2l0Y2ggKHBoeWRldi0+ZHJ2LT5waHlfaWQpIHsKPiA+ICvC
oMKgwqDCoCBjYXNlIE1US18yUDVHUEhZX0lEX01UNzk4ODoKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgLyogVGhlIG9yaWdpbmFsIGhhcmR3YXJlIG9ubHkgc2V0cyBNRElPX0RFVlNfUE1B
UE1ECj4gPiAqLwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwaHlkZXYtPmM0NV9pZHMu
bW1kc19wcmVzZW50IHw9IE1ESU9fREVWU19QQ1MgfAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgTURJT19ERVZTX0FOIHwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIE1ESU9fREVWU19WRU5EMSB8Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBNRElPX0RFVlNfVkVORDI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFr
Owo+ID4gK8KgwqDCoMKgIGRlZmF1bHQ6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiAtRUlOVkFMOwo+ID4gK8KgwqDCoMKgIH0KPiA+ICsKPiA+ICvCoMKgwqDCoCBwcml2LT5m
d19sb2FkZWQgPSBmYWxzZTsKPiA+ICvCoMKgwqDCoCBwaHlkZXYtPnByaXYgPSBwcml2Owo+ID4g
Kwo+ID4gK8KgwqDCoMKgIG10a19waHlfbGVkc19zdGF0ZV9pbml0KHBoeWRldik7Cj4gCj4gQ2Fs
bGluZyBtdGtfcGh5X2xlZHNfc3RhdGVfaW5pdCgpIGNhbid0IHdvcmsgd2l0aG91dCBhbHNvIGRl
ZmluaW5nCj4gbGVkX2h3X2NvbnRyb2xfZ2V0KCkgZm9yIHRoYXQgZHJpdmVyLgo+IAo+IFRoaXMg
aXMgd2hhdCBtdGtfcGh5X2xlZHNfc3RhdGVfaW5pdCgpIGRvZXM6Cj4gwqDCoMKgwqDCoMKgwqAg
Zm9yIChpID0gMDsgaSA8IDI7ICsraSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cGh5ZGV2LT5kcnYtPmxlZF9od19jb250cm9sX2dldChwaHlkZXYsIGksIE5VTEwpOwo+IAo+IFRo
ZSBkcml2ZXIgbGFja2luZyBsZWRfaHdfY29udHJvbF9nZXQoKSBtZXRob2QgKHNlZSBiZWxvdykg
d2lsbCBtYWtlCj4gdGhpcyBhIGNhbGwgdG8gYSBOVUxMIGZ1bmN0aW9uIHBvaW50ZXIuCj4gCj4g
SW1obyBpdCdzIGZpbmUgdG8gYWRkIHRoZSBkcml2ZXIgd2l0aG91dCBzdXBwb3J0IGZvciB0aGUg
TEVEcyBmb3Igbm93Cj4gYW5kIGFkZCBMRUQgc3VwcG9ydCBsYXRlciBvbi4gQnV0IGluIHRoYXQg
Y2FzZSB5b3UgYWxzbyBzaG91bGRuJ3QKPiBjYWxsCj4gbXRrX3BoeV9sZWRzX3N0YXRlX2luaXQo
KS4KCkhpIERhbmlhbCwKICBUaGFua3MuIEkgbWlzc2VkIHRoaXMuIEknbGwgcmVtb3ZlIG10a19w
aHlfbGVkc19zdGF0ZV9pbml0KCkKdGVtcG9yYXJpbHkgYW5kIHN1Ym1pdCBpdCB3aXRoIExFRCBz
dXBwb3J0IGxhdGVyLgoKQlJzLApTa3kK

