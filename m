Return-Path: <netdev+bounces-124900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF4396B56D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F6A281770
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7421CC161;
	Wed,  4 Sep 2024 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Oh1Z2w1R";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="G6etNxrk"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2318A6CF;
	Wed,  4 Sep 2024 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439803; cv=fail; b=i1WI/pjzkR/Ce0OrkDD7bYS3LP4ocVD2+BQssKJZ/Z0GeUgjSdS7NXW8da3w0iehns67SpSXid/K2u9678t21TCYwkTn/0MauhCL4DxKioRWiM7blscuvfRR+cGgs6yppAqMqdw6fd7Sk6h24HUrPmkU78sLvskugZSIIto2TYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439803; c=relaxed/simple;
	bh=H+Mf/rHzTdh/KY46LlMs56l7EvFDpyg5nPHNngEYS0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=noI+SQYqgnNlQrS679GYkChxZSJrwAsLCGWbWNSflA3KRfs0roPg72MMk5iADU6wnvkWVos3tJAul0rrS8TDs0NDkVmsrOmbmn01/khNC4UbbRboINB4QUmfwiYZSi3mhFd8oRHgBHRa5fDn2G0b/uEtAikvBi3kKCYkUDOvPT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Oh1Z2w1R; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=G6etNxrk; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a755ddb66a9a11ef8b96093e013ec31c-20240904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=H+Mf/rHzTdh/KY46LlMs56l7EvFDpyg5nPHNngEYS0c=;
	b=Oh1Z2w1Rw1wjM5dardJubuCyp+C/ghSeH2aP4tjTgMMeUPVYtBF7ofW0E7L9Uu0kuezQVmm3H7HfK1tv2jZRN10mYymV/kLvRQuw96EPk5lCE8hCYzuArcPlwah5s/bTcfkoyo4c7z8OZi7c3Y/fqtTbtxaa2p/SnyNacdE1z9k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:3dc055c0-c9b8-4e63-8a38-12cd895f057c,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6dc6a47,CLOUDID:bd6baccf-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a755ddb66a9a11ef8b96093e013ec31c-20240904
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 52514491; Wed, 04 Sep 2024 16:49:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 4 Sep 2024 01:49:54 -0700
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 4 Sep 2024 16:49:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/bnU5nghI00DA7qnNoiR3A/odmAOtAsijwVLWdB5Olig8QnqyWq3mzqOMfpm7hJHyxRfIQ9s1PIawpayrS1b5/9ALM2CZhCqhspjbkUHkpUFPMSRJvLIliLyk3ZixM+1y6tmHkvTDyqRl0DSxFm1yRe4z48vIq3wCfBwTRbGBRRk8X53XHzDq+SDRysOlJ9roGoqHYIjobeqBjGz7EZcpiwtaPPHWBIKKmhgtv3y6gwf76GOBb30sGo1i1LW6+RmDze6cZIpgOfy5kIFMweukwO32/aiN5p0T1t1J54Js3QC27MeMeN4UzL8b+UiKXcYwu/ypWWz/XAYfhorOCc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+Mf/rHzTdh/KY46LlMs56l7EvFDpyg5nPHNngEYS0c=;
 b=Bq0KE1TgnbIHzNkdPBMiwDWewGz7gRzoVXmbu/E9K3IkjM9FC8H1mJew0Z2JkjlgVwif+rkKaqc5csvBwWlnRSzWkNsdOJaCQU8Y1LsM7gAZatxXzTDpkp9lBIOyPQfqhX6Re+sRY4mf5PXkWg2Iu4U/pcexsTTYxk7FtSwfNjvx03NqE8x7Wst0zOF/dRZEdDJbWoUMGJCnqjwE+ZaHvbTtonJTaOcQGScptyP45MjQD25U4xuMhZSRD4gTg0ftvkhiRc3KzqR9bE7yokb8s9NhKDDzctyK2VUwWitO/b8n8+8HomC5DsdC7lr0TfQB4szdKpf+Dcgyx3VJBNAVNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+Mf/rHzTdh/KY46LlMs56l7EvFDpyg5nPHNngEYS0c=;
 b=G6etNxrk9byXAvZQSvZZqRSxNFt6q1qOsOl3VPS2mAKjsluwggCHWZjd20UEVSy/WLBH0rLgt0jUaqfo3C6wmR/5QXFCQAZgxPKTtObwTLM5fago0lm/gfttbpz2YgaNcmAr/haptBSaqKcxomddSD6y9594GsGMLkl7onEIKoI=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TYSPR03MB7330.apcprd03.prod.outlook.com (2603:1096:400:42e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 4 Sep
 2024 08:49:51 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 08:49:50 +0000
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
Subject: Re: [PATCH net-next v10 11/13] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v10 11/13] net: phy: add driver for built-in
 2.5G ethernet PHY on MT7988
Thread-Index: AQHay6W85idQ8hnfk0ODpiyAitmPOLIfNosAgBKRBgCAFe/uAA==
Date: Wed, 4 Sep 2024 08:49:50 +0000
Message-ID: <38189661f30032715783e8860318fe9e50258e47.camel@mediatek.com>
References: <20240701105417.19941-1-SkyLake.Huang@mediatek.com>
	 <20240701105417.19941-12-SkyLake.Huang@mediatek.com>
	 <ebeb75a3-a6b1-46b3-b1e8-7d8448eb23f6@lunn.ch>
	 <c21fe0db83dd665d4725ffedc51db9063dbe2f3d.camel@mediatek.com>
In-Reply-To: <c21fe0db83dd665d4725ffedc51db9063dbe2f3d.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TYSPR03MB7330:EE_
x-ms-office365-filtering-correlation-id: d31b867a-2485-4899-4386-08dcccbe89b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eFdzTzFjbjZLbFZKcWhZQVZSU0F5N0VKSnZzMUhuNHdrZ1Z2YVBWQ3F2SDRu?=
 =?utf-8?B?UGp0blNaVlc2MUdkR2wyNWh1cy9YVVJzazZ2SElaWnk5VElaT2Rjcm1YZUNi?=
 =?utf-8?B?SENNaXVuanhueWJsUi9HYkFDWURBR2tWa2NWTHd3VDdZc2JQRU5wTlRLOU5G?=
 =?utf-8?B?bitoOVVESGRUY2xNUVhhemg5WFNzNks5QTZUSzNHakRNK1ZGRzU2U2JCejJm?=
 =?utf-8?B?Tzkxd2RCOVlmVkxDZlIwRnNZYVcxUGJ4TDZMSVB3ZjgwS21Bc0pHRy9pNnFu?=
 =?utf-8?B?UVVZWER3MUdURnAwSGNoaDI4MitqZjNqU1FhQjE5eW5PNzRjSDhXeVBtNGFx?=
 =?utf-8?B?b2phY1hMR29RUWRzdzVLSHRFRFQ3QjA5OU1ySnVFKytCTXpza1lHZzZQTGVV?=
 =?utf-8?B?cXpEWUpDVURUc2tuNzNvVUFHOVljTUpqdkxOc1RpcEJrZWZ0N3dpQjBvN3VM?=
 =?utf-8?B?V0I1WjNVVTR1dXVaVHFYRVZDMHdsd20wMUVFNHNISVBxOG9kc05JS01zV1dT?=
 =?utf-8?B?UENRTWRiZkpKanp0NjRBSngzN1NPMU0wcGEzK3lHWWYxVVZDWjZ1ZkdUQmdh?=
 =?utf-8?B?OVExeGV0eFFsZW5HMXY0QkF1eDJMRHRTUmU4NngvMmpkcWNoTGpwMjJCaWxW?=
 =?utf-8?B?RE4yQmtqVkFBN1k2SjIvSjJyQjNrM3Y1ZytKcnUzK3oxVlhXN09ld3JSWXpX?=
 =?utf-8?B?ekN5V2FmMFZOL2NFamtWNlRYV1NoNmthWHJOeUY4UzNiOFlDY0lXMmVMOGd0?=
 =?utf-8?B?YXc2bFJuaC96cy9rYTBDS2xDSE1WSE0rcHkxMlIrZ3RaNVpKbWdRTHF5aEtK?=
 =?utf-8?B?eE9UMFYvb2hOakJnVm5EclNpdXQyeitYc3hpK0VCOXR1K1NZRUR0VStmN0p3?=
 =?utf-8?B?SXFNNisxUUQ2SCsvQjhBSWJEOUJIQUdQeEs1UTZNUEFDTEtiNm52Ti9aTXFG?=
 =?utf-8?B?V3NUSzVvVUh0M3lTa29UYVpIQ0ZNVXBSMmVXbHZOUWN4emFwcWowZTArZ0Zs?=
 =?utf-8?B?TWxYL2VpNHNldi9YMm85Z0ZZU3dCZzNOei85Q0dMRmZSUk1LaUlrQUlIVDZN?=
 =?utf-8?B?VmxoeGVHekE1RUxjbEdzUGJtNUFrdU9qZUpPTVBSRFBKVmdYbWM2SUxhSEdh?=
 =?utf-8?B?dWZvSDBPNHJITTVQdkF1RXA2eWNkMm44aXVveG1rbTU2ZXZnbHp0YjI0clVw?=
 =?utf-8?B?cVNKRW5JUmhkRG1qWHVGdnA2djcwVDcwUTd4REdwa2ZIVy9Obkt5UUU2dWlV?=
 =?utf-8?B?SU9RQnEwMWhwck9pa3E1NkJKaE1VWEwvR3Eyck1Dc1ZodGY5NXR5NjNsSHMz?=
 =?utf-8?B?TVdZdTJpTHE5R0xKVVF0TzA2T2Y0aEYvZnlUdWV2WWFrSHdPQUwrU2d6OGVq?=
 =?utf-8?B?R1RuTm90M0RrYkh2YnRPMUJhTFNma2dHTEdaUnRxaXUzQU94UHBuR0VPN2kx?=
 =?utf-8?B?TGhiZHU0SHFodTVBZkNRclp0ZFRIUHdZS3hHdmFscWxjYUhiM045bHBaNWRR?=
 =?utf-8?B?bVFVcVltdDJoSW5jNXBVelFBMHNtY3NPeG5ETjNnMW03Mzk1L1RDYkxDVGcv?=
 =?utf-8?B?aUU3RXQ1dENnclpEUHdSTkEyNkMwandmNnJZaEdsWUFzWndXWGRhVEhxTTJS?=
 =?utf-8?B?RWZrWlozaHg2eXA1M2xjbTdHeTBiNE1RRURpSGFWZm85UXhscGV3ZVpWOUEy?=
 =?utf-8?B?ay81REZHdlFqbzhyd1dKYUxXRk8vQmpOckhMNUtLZ29pN0FJTk5heGJHeXQr?=
 =?utf-8?B?VkVQWHBwNWJ5S21FRHFsaXh0c2ZiM3c0RnA0c2QrWll0VFdrL3Z1NkxzdHk4?=
 =?utf-8?B?SHFQYTg3Y0xReGlkb0QzWTdHOFpmWlZJcEFLSjFIMFFaNHNpQU12WlpOdVRk?=
 =?utf-8?B?VGF5SURkQ1NCRzZHbCtjNUo1TGNiblVjTzRlclVZdFpMN2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmtUdk4rZHhGNndmYnB2WkdtQllIdzR2M241THgxeWo0bWtvUjBKdnFaK2oy?=
 =?utf-8?B?QWtPemg5NFFlTUh2VFVDN0JsZlN1a0dCOFFWSjgyc1FoTXd1a0dmbTMzQ0tM?=
 =?utf-8?B?a1NodlV0QUJ6K1lKa09SaUtLcUsrUmVqVzc1OUsraUowRWNiVEUySGZqTTdF?=
 =?utf-8?B?MHl4Nk90VS81N2VwNmVWYVdzZUFoZDZSL281Vm5OZVlEcTJYU1gxT0lzMVFy?=
 =?utf-8?B?aWFnWUg4T1R5SEV2Uk1TOXE0dHUvM2R5K2lSaXFiRnN3OC9VSE1QOTJtTUI4?=
 =?utf-8?B?WVV3WWVuSW1CZzErbzhuWEFUUkpFcjVUSkZaYW1Rb0szeG16VUI3eXJDK0hD?=
 =?utf-8?B?bDh2WElyeUtMeE1hdjJMTk5XWStSMnZtZ1NCVkt3RXlFMGlZMWxkc1Y5TGE3?=
 =?utf-8?B?aWk3UXJMdlBDSlF5NTI5WXZRbWVtZDExTTVsTThwV2hCQWwxVU02WkZuOThB?=
 =?utf-8?B?RkczZFJKbGhyYXczdktVL0tTa3MyOFpjNzJzZnNldFdzL2dybHNzUDlPa2Rz?=
 =?utf-8?B?SVVmWHBpZWgxK0VSWXlWTXdQZ1VnSkFKVGp6UW9wazVaOUIwOWFlMFprWnd0?=
 =?utf-8?B?dkJyRHBKek5MbVpBeEVaMjM2aVlEalhtUUZxMTJkZG5JWGRhTXEyMTVQRC8w?=
 =?utf-8?B?R0QzV0ZKS2N6UnhQYXNNTkYzZStTNUxDeUtaK0tncWxQUVZuOEpFeXJzZ1F2?=
 =?utf-8?B?RFBHR1dPL1RQUFhsdTlhRUhRSUVtdUVCRlRLRUZlRENpMWx3UmMzK1BETjND?=
 =?utf-8?B?cE13WGdObkdWYTJHV1pCN2ZqV2p2bndUV3h4UW1lNTJKRTJ3MnU5cHBvUDZY?=
 =?utf-8?B?czh0MHNhemlRbDlkOFkySlljUFVpZDg3dUlleG9GZ2dHM1MxdU5PRHNQOGlU?=
 =?utf-8?B?Wk1YbnpNaVJoQTFBMUFXL0srT3QvRGt3Z0RPdFBTdzcvc2Fza1NwK21ocTlB?=
 =?utf-8?B?aWVLTHIxR05sK1E3b2hvSWZyc1hEV0hjNnNRZUh5RmZJMUhMYUk5dTRsTWlK?=
 =?utf-8?B?aGlkelpoZERVTHpuODZNZFkzRUllbk5nT000c0d4Tk12NS9tT1RCSlVGRzJD?=
 =?utf-8?B?cU4vUXRGSjl5RUJON0RMNnprVVEwQ1kwUkIwbTBsZkxZL1Eya0NWOFZvWk5Z?=
 =?utf-8?B?T2VGd1NGNjFYTVREUTJCTmlWd045UG9IYy9iZStVWDBUK1FwUnppMGxva1J4?=
 =?utf-8?B?YXdSUkZrNzlIVllxaXBSNm9rcGxmN3RMRWF1VnhNWEFTU2FBM3JPeXRqc2wx?=
 =?utf-8?B?ZHY1K000cjk2YUxQQUZiVmsvYkVtN2xvR1FzRzd3STVuZUZBOTRGNHBmTkdX?=
 =?utf-8?B?Yk9CNkRxeVVPSnl6T0tPeG9sY2lQUXhMcFoxbWJ0YXFCWnJUQ2FpTWtObnFI?=
 =?utf-8?B?SUphUVZTc1VHUmEzSWJjV0tvRXh6ZWxLQjJ0THZXQk9ZWExyeTFZYUI2cEFY?=
 =?utf-8?B?L09tWDc5WlhYUmZsbFB5bC9rOGZGcDB0dXE5ZVdYZUpwSnpnVGIxaGx5bmU4?=
 =?utf-8?B?amhTWktNRUUxYWQ5bHJRT2ZReG1SUGFLbU5BNHZ3ZGN5M0R2N2E1a3Q3RWhN?=
 =?utf-8?B?d1lsUDJWdEtYU1lQbW92WTBhMjFMZktYUGVFOUxTOUEwRGhQaEJveUtZZHlq?=
 =?utf-8?B?eHRmcjl6bm83MWl4dDl4TVF1UGJRZVdaQXZKU3ZqZU95cklKMmdaTmtsTUJt?=
 =?utf-8?B?Zyt2OEdMK2xKZVJpUEZFdmhKUytNT3RuZ051V3J2TmRZT2VtVlpDd2N0OFpo?=
 =?utf-8?B?SG9qNWxsWFRHWlczejZJaThzMVE5bWY3eURuNGppc3pob295Rnh2NFZ2bVor?=
 =?utf-8?B?aTFKamdySE5US0kreG1VZGlXNVpWOUJlVDA4TTlUNEd0MWVqZEVxYnJFa01I?=
 =?utf-8?B?VTRsVHlxUkg3MnV5Vm4zNHNzbGNOdzQ1QWw2NGZ1MElkekhjQjl0dk0vT0F4?=
 =?utf-8?B?OVNlVWg4ZDJ3ZzRNSDJxTEx3Z0cvazFreGFBdHJaTVNDdFJ3RmZJbG04ZFNv?=
 =?utf-8?B?MC9sdEU4eFh0YkNkbEVHelpQVTB3VWtkN2FzSzltMGc1SFVMZW5PQzc4VDFo?=
 =?utf-8?B?dm1HRE9lUmppOU1vK3VRcXdtdldHRUVPajRCdXJZZ0gzNkpvNXBUTnVKQUxq?=
 =?utf-8?B?WVFSV1Q5SFZkWis4ZjgvN3RHcTRhYitLOEZEZ3dsTW9ZcEdJeTZlSjZQVTNh?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1418BA8B8594534DAFF74B2B7DBF11F4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31b867a-2485-4899-4386-08dcccbe89b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 08:49:50.5715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hu/4Q39ftPI6QBEqNJm9/wYhM7PbN/5m0LTewPdM+gTIfyXj5vPB0WZUGC+ZrPgGFD2iDvG5O7KmoWQz66ylKaVvpdyBC/K7HwWBOxLd5rY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7330

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDE3OjQ5ICswODAwLCBTa3lMYWtlLkh1YW5nIHdyb3RlOg0K
PiBPbiBGcmksIDIwMjQtMDgtMDkgYXQgMTY6MTcgKzAyMDAsIEFuZHJldyBMdW5uIHdyb3RlOg0K
PiA+ICAJIA0KPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzDQo+ID4gdW50aWwNCj4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUg
c2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ICA+ICtzdGF0aWMgaW50IG10Nzk4eF8ycDVnZV9w
aHlfY29uZmlnX2FuZWcoc3RydWN0IHBoeV9kZXZpY2UNCj4gPiAqcGh5ZGV2KQ0KPiA+ID4gK3sN
Cj4gPiA+ICtib29sIGNoYW5nZWQgPSBmYWxzZTsNCj4gPiA+ICt1MzIgYWR2Ow0KPiA+ID4gK2lu
dCByZXQ7DQo+ID4gPiArDQo+ID4gPiArLyogSW4gZmFjdCwgaWYgd2UgZGlzYWJsZSBhdXRvbmVn
LCB3ZSBjYW4ndCBsaW5rIHVwIGNvcnJlY3RseToNCj4gPiA+ICsgKiAyLjVHLzFHOiBOZWVkIEFO
IHRvIGV4Y2hhbmdlIG1hc3Rlci9zbGF2ZSBpbmZvcm1hdGlvbi4NCj4gPiA+ICsgKiAxMDBNLzEw
TTogV2l0aG91dCBBTiwgbGluayBzdGFydHMgYXQgaGFsZiBkdXBsZXggKEFjY29yZGluZw0KPiA+
ID4gdG8NCj4gPiA+ICsgKiAgICAgICAgICAgSUVFRSA4MDIuMy0yMDE4KSwgd2hpY2ggdGhpcyBw
aHkgZG9lc24ndCBzdXBwb3J0Lg0KPiA+ID4gKyAqLw0KPiA+ID4gK2lmIChwaHlkZXYtPmF1dG9u
ZWcgPT0gQVVUT05FR19ESVNBQkxFKQ0KPiA+ID4gK3JldHVybiAtRU9QTk9UU1VQUDsNCj4gPiAN
Cj4gPiBJIGFzc3VtZSB5b3UgaGF2ZSBzZWVuIFJ1c3NlbGxzIHBhdGNoZXMgaW4gdGhpcyBhcmVh
LiBQbGVhc2UgY291bGQNCj4gPiB5b3UNCj4gPiB0ZXN0IGFuZCByZXZpZXcgdGhlbS4gRGVwZW5k
aW5nIG9uIHdoaWNoIGdldHMgbWVyZ2VkLCB5b3UgbWlnaHQNCj4gPiBuZWVkDQo+ID4gdG8gY29t
ZSBiYWNrIGFuZCBjbGVhbiB0aGlzIHVwIGxhdGVyLg0KPiA+IA0KPiA+ICAgIEFuZHJldw0KPiAN
Cj4gWWVzIEkndmUgc2VlbiBSdXNzZWxscycgcGF0Y2ggd2hpY2ggZm9yY2VzIEFOIG9uIGZvciBz
cGVlZCA+PSAxRy4NCj4gQ291bGQgSSBzZW5kIGFub3RoZXIgcGF0Y2ggdG8gY2xlYW4gdGhpcyB1
cD8gVGhpcyBwYXRjaHNldCBpcyBzZW50IGENCj4gbW9udGggYWdvLiBJIG5lZWQgc29tZSB0aW1l
IHRvIHJlYnVpbGQgbXkgdGVzdGluZyBlbnZpcm9ubWVudC4NCj4gDQo+IEJScywNCj4gU2t5DQoN
CkdlbnRsZSBwaW5nLg0KDQpCUnMsDQpTa3kNCg==

