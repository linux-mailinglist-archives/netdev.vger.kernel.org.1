Return-Path: <netdev+bounces-190714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E5FAB8644
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133BC3B186E
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F4629ACDF;
	Thu, 15 May 2025 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LOF1eT2y";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nutPhF0L"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FC629ACE2;
	Thu, 15 May 2025 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311428; cv=fail; b=fFnTN5Ba7HEO5Pgwv176mcSHBOH78vWqZiQJouYz7i8/HZWldvC0/dV4a8Miz45FWs4+EpK5TBDa2ORGWc49ftMQHqQz6HLS/VSUp9xdNAdmc6xCN81xYzElsezmKk5nUweoWFaZDfh72oFVdtZjdSgnL92ve3oQm7KZELn96nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311428; c=relaxed/simple;
	bh=WR8b4qILu8AufkEwGXuBpx9tg9wC3BCdEBTzCCf24VI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=huQhnMRCPRYE3hQHRZAHhSj0IJzbStH7+i590V89u/244B6Kw0seOKrTzm6a5+LQDmjT1Gaf/JsLm0dqUzBtjNTIckxVIfGYAFKJoVfhBWoWprcp6FlXRqZr2ey0FbALyHW68ysHZQ0m39ujusoevuGOkalVfQLXfxN/XlNujM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LOF1eT2y; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=nutPhF0L; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7fe6608a318611f0813e4fe1310efc19-20250515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WR8b4qILu8AufkEwGXuBpx9tg9wC3BCdEBTzCCf24VI=;
	b=LOF1eT2ytkhI5gAJ042IVf9m4r4XD8TmR4aLuiTnf+2RmXUNafeJdRDPc5cQSed8L/Kz6V5hAFPZDcXv2wTskUwy1/9HAEQS69TOu8mTms9CFtN/tHBOj1MEYNkhwDppvgTOv/p2DRzZG0x18zk8Nq5pmdHhhFrNB37OLg0cy2g=;
X-CID-CACHE: Type:Local,Time:202505152016+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:dbf75741-8d7e-4e83-b7c4-7f7a4e1230ce,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:681c06c0-eade-4d5b-9f81-31d7b5452436,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7fe6608a318611f0813e4fe1310efc19-20250515
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2060116985; Thu, 15 May 2025 20:16:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 15 May 2025 20:16:57 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 15 May 2025 20:16:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eU4CZ0rtVnJ46CURgZWP2rukHea98P8ldWBqphzwG2VwHEgMNez5lMVVn7YZLO+eBOKQtQktIRwJjN/EpgbWle4E5RmB63MZF0lR5oSTN04q0+lFwdqxi0KYqIdkPP0pH63pkcnlthV7E94SiLkwOdrqlKlqIBXF6Z2WoI75z5PhfTHj3Tx8vcEtcWIxrLQZF/QOSe64aH0udfzslTCL5DAu6i4tSPTZL6ZrAdQvBVQpwbTLdmI99vMvMeV4fHh3VM6qbqTDZ4se2K+3/kuO2qyBz3MjpcJO3oWt8GlQE1J1s8mU5sNuYju7CSKuPbyjScBrBf6+knyvxEctDB5W9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WR8b4qILu8AufkEwGXuBpx9tg9wC3BCdEBTzCCf24VI=;
 b=iVnr0SMO3RTjqdp5XGPZC4Kz0ZsxC8dA/W37W3NFJJp32UIFLc/5tjzc7SMIlN1BaRerqkCvEkJUagR1yniTBj1gxUroFOU9pRJucwkAnTBrniu/gcHfJHRfz0U33SpEpHABKRmCYJaDygO9h8saqQEg8x39+Y3hSPyTXb+XDm5myfqvzv8FwK7i+QTCrAeg2vEPRwYSQoDj4V9ZI0YqsQu18AMJmJsL4huY6bZ1oNwAN0jINBsn2agjz52PF6cZ2Pnava8bdsw7V3B5RzzR8fLG18G3MxxFIkWRvI5Af5DKDCLzr9KqWjl6p87F4jYORKQ+9khvy2XtHUlpD3/rTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR8b4qILu8AufkEwGXuBpx9tg9wC3BCdEBTzCCf24VI=;
 b=nutPhF0LZxKy7h6nYpI8E607yX0C9z5KYUCjGoPXJiNAMo1u34UGzvscYpf9vWe0ifKAPvYYHCrMfeAUIr+60Bmo7QMFEnSHrA3vncRZM+1AiLIcq4vCVX63xxq9TikaSfdlZYUSC+XiPrRPnKfHjl6Vl12dOuq3h+WtiuH24ng=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SEYPR03MB7606.apcprd03.prod.outlook.com (2603:1096:101:148::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 12:16:51 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%3]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 12:16:51 +0000
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
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"balika011@gmail.com" <balika011@gmail.com>
Subject: Re: [PATCH net-next v3 1/2] net: phy: mediatek: Sort config and file
 names in Kconfig and Makefile
Thread-Topic: [PATCH net-next v3 1/2] net: phy: mediatek: Sort config and file
 names in Kconfig and Makefile
Thread-Index: AQHbxL8yoN6oQ1UpMECaVAqh+h90SLPSCJEAgAGUZgA=
Date: Thu, 15 May 2025 12:16:50 +0000
Message-ID: <ccbe276a0e04b4ac6d001cd7b32a65e268be8382.camel@mediatek.com>
References: <20250514105738.1438421-1-SkyLake.Huang@mediatek.com>
	 <20250514105738.1438421-2-SkyLake.Huang@mediatek.com>
	 <2147e0e3-44c0-4fd8-916d-53291dc86a6a@lunn.ch>
In-Reply-To: <2147e0e3-44c0-4fd8-916d-53291dc86a6a@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SEYPR03MB7606:EE_
x-ms-office365-filtering-correlation-id: 47a8190f-165f-46fe-cf12-08dd93aa5f67
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WFNycWg2TUFmaVpBMWM1OW1PVzJGTHpVQ1MySi9EYlFvQlZjWWpGazVvYUs1?=
 =?utf-8?B?UTlXK2RUM0dhdllIejlwQTE3UU4waUg3ck8reFlHWHR3ZTBpV0JNQXdQWnZB?=
 =?utf-8?B?clR1clEzV21Vcm1hTjNjc1lVVE9VL2QrRmVYaXo5K29uS2NSMmQzTjA2dTk4?=
 =?utf-8?B?ZVZWYVAyTDQ2MEM0dUxNaHFPbHRKSURXcGg4bnBta2NkVzdmQzF2YVUzekRq?=
 =?utf-8?B?NTFXWGt0Z2RiSTczNkNwTHNjakNKWkRKNmxIZmlER24yUlVZMWVYWVBIa1hT?=
 =?utf-8?B?RjBWSHNDUU5wUnBkN3ZFSHFJT3d3UVFKZDNFa043TW80UFozSmNaSTdBODVY?=
 =?utf-8?B?REthY1A3Y2JCUWxETEZCMG9UOWg2Sk9PQUw5N2VucnpjVXNnaFY4cHVUd1V2?=
 =?utf-8?B?blZOakRIZTQvY29NQkFlcDJ2MmZhT0NtaVNZdzBtZGhjbWhCM2RHdkt0MW1H?=
 =?utf-8?B?WFIvemdYb2ZOc3lXQzUvVjNXemxvTVNsWXEwdFE5SGYvUEU5Nmt3UFRRSHlP?=
 =?utf-8?B?UURjU3lJaDRqQTBnZXNIK1ZPay85WkNjaFRrZDFMSVVQaXVqQzZjMkZqYnpF?=
 =?utf-8?B?S1p0OVF5aVVabFd1WEJyaVRqd2pwWlAyQ0xWYlhFaGZrNVJwSVNxSUZ5alFm?=
 =?utf-8?B?UkhhR3hyc3lzNmlpTTlzQzJhOWNvcFZ4RkR1bWFZZzhJY0ZuaEx0S3Bndm9z?=
 =?utf-8?B?djk0Z0NCV1p2V2Q0YjVyVHFKM1AvSzgzN3F0QTdzVjFHVXM4dSsvdWNoRHBV?=
 =?utf-8?B?L1BxaG4zcVVTQ2NoMjNUT1BBSFdJQ1lxYnBCa1ROUW10dWJucFppL0dzZlV3?=
 =?utf-8?B?dVRNemdSYkRKeVJwYmFjQi9GdUFlVk9udFVuNGVUakhzL2tDMVM2RXo5UTZ2?=
 =?utf-8?B?cmxqQURJWDNtOVV0WDhVaFNWNXpwdzdJR0Y2WDRRak91NEZLWEhNNldZdUhu?=
 =?utf-8?B?SGUwTWFtV3hZQlJJWm9GNE5DTStycXdEQkNkcENmdTNIVUtTczVvYnFtdnc1?=
 =?utf-8?B?aEZBcTUrYzFETFd6YXJlY1BlY3lHdDdCbXlzUmI3MExSMU0veUVHckJBcUxm?=
 =?utf-8?B?ZUhJMk9zOFRneVQ1dWVkd1VPNkNlM3UxcXh2V2h3cmhGd3JWMWhOdXRmZUYv?=
 =?utf-8?B?S041VXFwT1ZaalFGdUU2S2ljQVg2bzJGMWRUamRyZSs0aWZjaTNyV2NiSzNE?=
 =?utf-8?B?K0hNM3hqd3pMVWoyVjkxU3ZpWEt6V25RTEJRSUVEVjJlNDFaL0dOcUVFTi8v?=
 =?utf-8?B?VHFQV1piYnBvblI0WDBtQXZDNGpIRDdYb1UrMFV1UEllUjBaOXNZRC9pYWlZ?=
 =?utf-8?B?WWIvYjVxL0hiSHF3d0N0SDlSc24yQy81ME5GaXAvYTk0ZmduYXdUeHpuVFFZ?=
 =?utf-8?B?OXdFSkZqSDREZXpnenhOdnZSMWIzYitJYkdROTZoZVIyWmhWMVZBMkZZa1Vu?=
 =?utf-8?B?S2VOTzBlOEdBeXRWMnZ2MEgzcDIzWFAzWHE1UDRDaDcyK2VzQXNUZWltNjNx?=
 =?utf-8?B?SGtVS3J1Zks2OGtpREJsUjVzTnNaTGpjYTFHOTBVdFJRL2ZmcjJvSjVSb2xW?=
 =?utf-8?B?KzQzWWNYTHU1RnFsQkQ0R0dyRlZZbXp5MnFtY2J1YUloVmlRMnFnZDBCak5w?=
 =?utf-8?B?cG9YU2IvaXIwVnF3S3U1Q21LU1p2Nk55R2h3dzVqUEhVNzdmVnZjazBZV0ht?=
 =?utf-8?B?RUhsK3l2dWJqYkY0ZFoxTG4xWFBhclNsak5mcGpPN2RGc2VxbTNWZVJuTG1r?=
 =?utf-8?B?K0xiQjBnNTY5MTcwY0VnUk5MWHRudXFRVVE3S1p2RE1zanBjVm5UVm8rYk9G?=
 =?utf-8?B?a2tXb0dzUk81NE1hOGVLQitvZmk3VWNNajB5SExzdmNna2pWZ0NjdjVTeXZv?=
 =?utf-8?B?djNoOVVJRmJvNnlqY1l3R09JVUt1bmw4MThWbTltd2ZZdVNMOTZwVU0xK3Mz?=
 =?utf-8?B?ZXQ2Y0RTVXJjeUxDYVZGQ0tDcDFObWpsalFDOVE4Q1paQ1VxKzI2TGRGSFpY?=
 =?utf-8?Q?5MBEn0z5XWIuk97emGXbayKfIqZggc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUt5eGM2elNCS1Z0aEZiaFVBdDFlVno0Yis0YnNnUzRzNHRRWXNJby9EY29G?=
 =?utf-8?B?emRSMTJmRjIvOVF3Sjc1cTFSaWozU0s0UExiVUkrenE1eGgrdkFzZ0pjRkla?=
 =?utf-8?B?em00ZFIwbThObXRRSW15dVpld0plMmZLMWFNckRMZCt4WUNHcURkZFIwZytw?=
 =?utf-8?B?UmMxa0VZYk43Y01NdDR5REdMV0hDWnJ3ZGNDSThXaW5uNzBUNWRqWTdFZVFW?=
 =?utf-8?B?emdIaXV0dVFUWEZmbzhkNXhrWlRvNVBBVDRSM3h5aDBGaDJqL3A0RFQvL0Jp?=
 =?utf-8?B?ZXJVOWFOWERFVllYN3llcVhqalp2OFBKZWo5S2FGdGhXTmd6aG8rVzNCMXc1?=
 =?utf-8?B?a3RUakh3T1E3YWU2N1FqampwWW9VWHRkS0JIS2RIQjA1Yk9FOGFxYVEwRXBV?=
 =?utf-8?B?MTNTdTNqWTJuSTBqam9tVTRFdUhmc2tsNUJIeVRBbFBkb1dNQ0lFd3dIcWZ0?=
 =?utf-8?B?Vmpsc0ZGSU44b0hXUDhrNzE3WlpmWUx6YkZ2MTN4K0VRU3NuL1FUZ2J2LzBW?=
 =?utf-8?B?YWErRTEza055TElaL2p1VWNhNVJhV1VUSklvWG80OWdOK3NINmNiMDRtRkdN?=
 =?utf-8?B?aFdTRkxtc0ZLbWdNQWxPU0s4dEpnTklKcG1TaDB6a3FuaExVZEFkYTFDcm5r?=
 =?utf-8?B?anB0VlkwM0JmdSs2T3Z5NjFzZ2syVGFGVGU0TVBLR1lmV25Eam0wL2NkekxN?=
 =?utf-8?B?a2plMnphL1dsQXhENmJWZ091MlBqaWFMMVAxcE1Ud1hScU5zNXZRT1p0eU5k?=
 =?utf-8?B?VjZYZUViMWQ3UFVyc0ZjamUzblN6MlE2U08vb2lpU3lXT1NWQlZuOTh6TVd2?=
 =?utf-8?B?cXphRzM5RjQxK0U1QTVCWHBOZVE1eml0RjYwcDRKYVlaVFN1YUxjMWt4dWlJ?=
 =?utf-8?B?UHRZTTFTK0tMcFFUM1FXUXV0dGRIYkc3d3BSb1dzdlQ0am5QMkpkdUM0Risx?=
 =?utf-8?B?dC91eGdFMVFrQW8xZnlIa3NSUUFMTTk3TzlQYmY2WWUyUk1zL0dVazlaKzJS?=
 =?utf-8?B?QVUrOGZ4aGgwWjhMNjRlZ2xwcXJGR1Y5SXAyTklWN3F2NDdlQ1BoTTJxSW01?=
 =?utf-8?B?NlNxYW8zdExXT054TmIwaDljZWgrc2dHZDVKcEpmVExsc1VwdTNQY0pSdGRY?=
 =?utf-8?B?RGFIVk9SSU5takF6dDNSckx5eHZjQTNEUTNHTlQ2L1hzVVQvZUxzay9iSVZj?=
 =?utf-8?B?Qy8rdEZuaXZyNU1sMG5EUWxqTWxvOUFYRXdtQkRmTUMvYUJsTlpZS3d2Z25P?=
 =?utf-8?B?Q2ZLS0I3Z1FtMVVsZ0tUR0wxVGVRL1J2S0NKcDczdWNWcXVyREpLbWRXTjdL?=
 =?utf-8?B?YWtHdE05MUk2SmFHektMSnYrOVdtMXA0ZEI0c0VzZm5yUnNhZGV0RStIQytC?=
 =?utf-8?B?NmpHZGRzRU1zdFR2eXY4dndCb2psUTRRWWxIYXQ2TUJRbmRNUW40M3R4Uk9p?=
 =?utf-8?B?Y09KU21NdmZSUzYxVW02bXFRUk1UVVRRZDREY056K2hRZkx3VXF4NlJlQjZQ?=
 =?utf-8?B?RnJKUjE2T0RoZXVpVXlyeUt2Y3l1Z25XU2poU0dNVkhOWFdLVjllZzgzanQx?=
 =?utf-8?B?ZWgvdWlESmQ3NjBZUEo2MHplcDNYVGd3UGYvQXg3M1hjZW9kTGJhcllIQUpM?=
 =?utf-8?B?bGZvYkR1SDAyK1lhN00xcHVMTXlLZElZaVRTRUdYWmtBWHBTWVZ4OWUxaldw?=
 =?utf-8?B?RWJSM25JMG5GSG1rWHFjbWxjOUlQYktVbmppUk5wdGdXb2RCYWMzM2l6ZThX?=
 =?utf-8?B?aEhEZDAzcHI2eFR2ZWJZRDJyWWdVR2Zsb3liMG1OcFlvQzJXc2RhSnRkeTIy?=
 =?utf-8?B?cFRUenpBcSt2NmRGU3dMZkNlTndkUjZGVUh6bDRSTE1TM1dqc1c5MzR5MXlG?=
 =?utf-8?B?bk5QSVBEWVZBYXRQK0RoNmExWG05RmFRZnc5bVFVc1MyUHY1a0hiU3lYUUZ0?=
 =?utf-8?B?N3I4eWV1UkdFRHBwS2dydE5ZR0NUYUpUTW5TVlcwSGUzMmlqdWlqQ1JvZ1BD?=
 =?utf-8?B?Z0c3Qmp5RVZkaXplTGdXbTgyTWhqU3VoNVMvRmNSTHptQjRoRDQ4SmMwaHZQ?=
 =?utf-8?B?MFQ4TzBoS1hoWHpUbHpJZDg0YUhoeFRIdjNaSFVjWmZXMDJJZWkvbGhHUzZw?=
 =?utf-8?B?bk5BOVJhNm5IVnRFRUtzVjFWWkpUT0RhdGQrSmFOTVF1bVd3b2RINU8zZzhB?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08E5FF56CDCCB54B9E1C5610DCA2F8A5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a8190f-165f-46fe-cf12-08dd93aa5f67
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 12:16:51.0482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qc7rXJzf+QESqD7gZXom/MeHBGfdcveF88hkd0LA1jcF+lAlc0DaLXTp45px2qjbisHVVYGVSkA/9UET1Qz3DOdH0FMW+xSctX8eToqoAjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7606

T24gV2VkLCAyMDI1LTA1LTE0IGF0IDE0OjA5ICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+IA0KPiANCj4gT24gV2VkLCBNYXkgMTQsIDIwMjUgYXQgMDY6NTc6MzdQTSArMDgw
MCwgU2t5IEh1YW5nIHdyb3RlOg0KPiA+IEZyb206IFNreSBIdWFuZyA8c2t5bGFrZS5odWFuZ0Bt
ZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gU29ydCBjb25maWcgYW5kIGZpbGUgbmFtZXMgaW4gS2Nv
bmZpZyBhbmQgTWFrZWZpbGUgaW4NCj4gPiBkcml2ZXJzL25ldC9waHkvbWVkaWF0ZWsvIGFjY29y
ZGluZyB0byBzZXF1ZW5jZSBpbiBNQUlOVEFJTkVSUy4NCj4gDQo+IElmIHlvdSB1c2UgIm1ha2Ug
bWVudWNvbmZpZyIgeW91IHdpbGwgbm90aWNlIFBIWXMgYXJlIHNvcnRlZCBieQ0KPiB0cmlzdGF0
ZSBzdHJpbmcuIFNvIGhhdmluZyBHaWdhYml0IGJlZm9yZSBTb2MgaXMgY29ycmVjdC4NCj4gDQo+
ID4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L21lZGlhdGVrL01ha2VmaWxlDQo+ID4gKysrIGIvZHJp
dmVycy9uZXQvcGh5L21lZGlhdGVrL01ha2VmaWxlDQo+ID4gQEAgLTEsNCArMSw0IEBADQo+ID4g
wqAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gK29iai0kKENPTkZJR19N
RURJQVRFS19HRV9TT0NfUEhZKcKgwqDCoCArPSBtdGstZ2Utc29jLm8NCj4gPiDCoG9iai0kKENP
TkZJR19NVEtfTkVUX1BIWUxJQinCoMKgwqDCoMKgwqDCoMKgICs9IG10ay1waHktbGliLm8NCj4g
PiDCoG9iai0kKENPTkZJR19NRURJQVRFS19HRV9QSFkpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICs9IG10ay1nZS5vDQo+ID4gLW9iai0kKENPTkZJR19NRURJQVRFS19HRV9TT0NfUEhZ
KcKgwqDCoCArPSBtdGstZ2Utc29jLm8NCj4gDQo+IFRoZXNlIHNob3VsZCBiZSBpbiBhbHBoYWJl
dGljIG9yZGVyIGJhc2VkIG9uIENPTkZJR18uIFNvDQo+IENPTkZJR19NVEtfTkVUX1BIWUxJQiBp
cyB3aGF0IHNob3VsZCBtb3ZlLg0KPiANCj4gwqDCoMKgIEFuZHJldw0KPiANCj4gLS0tDQo+IHB3
LWJvdDogY3JxOg0KDQpPb3BzLiBJIG1pc3VuZGVyc3Rvb2Qgd2hhdCB5b3Ugc2FpZCBpbiBwcmV2
aW91cyBwYXRjaHNldC4NCkknbGwgcmVhcnJhbmdlIHRoaXMgdG86DQpvYmotJChDT05GSUdfTUVE
SUFURUtfR0VfUEhZKSAgICAgICAgKz0gbXRrLWdlLm8NCm9iai0kKENPTkZJR19NRURJQVRFS19H
RV9TT0NfUEhZKSAgICArPSBtdGstZ2Utc29jLm8NCm9iai0kKENPTkZJR19NVEtfTkVUX1BIWUxJ
QikgICAgICAgICArPSBtdGstcGh5LWxpYi5vDQoNCkJScywNClNreQ0KDQo=

