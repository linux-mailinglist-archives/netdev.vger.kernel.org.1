Return-Path: <netdev+bounces-190115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FE9AB535E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CA76460997
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E6D253F1B;
	Tue, 13 May 2025 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rj+8OrXM";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Iu+gDr0X"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B791B1F4CBF;
	Tue, 13 May 2025 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134132; cv=fail; b=M5JC5s0J5YA5CRtHEzxrKGnK9/uXTWfV+xGfRsXEZkSVSZRkbbwleKMoMjTqyLbV+RFghepZ3oTccVAquyefxJxiSghbnAOtHN/zKKqYAdfIjjf5VSB97pfYxLY+ejs3LWY0x7KjEqzGFxO/afCzWIai6izlQrtZ9Ze+VYWdW3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134132; c=relaxed/simple;
	bh=JAZ594IMZenc6hI4ffwlRPppJJEi8bff3FOGQA9bhoo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gU7MeZMg4P0bty4hiTlV7anUfjMyEYGikSX3vSjS3szNqcHisrDh5PaX5ID/5eu0++cUg85dsv0UpAEIErQKCWB7Wu6VlSIk6+Ungn6ddwlkw5h/Bmuh8D1YM6Y/Ix777/7hMeYqvRkmDV9uaUiQWJKdOhYAHlYiYlMdn0VxQTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rj+8OrXM; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Iu+gDr0X; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b2da0f762fe911f0813e4fe1310efc19-20250513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JAZ594IMZenc6hI4ffwlRPppJJEi8bff3FOGQA9bhoo=;
	b=rj+8OrXM0DDyKyP0xpns6JKNx2DnhdBBCfUJclhi0zYoIgUMEp0zRbILaz/ezN1tS0RsrzSeBD5WwvaE1SWwxN1JHWypkqlNIjTcJLQaH+4qSSDX0PirAmLQe6h97db8HBiUQ2W0+agIeF/7Guyczr0lv2kVuL1XcsXwgClQyH8=;
X-CID-CACHE: Type:Local,Time:202505131856+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:3923a806-de19-43d3-bb67-4f772833141e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:7b6af7f9-d2be-4f65-b354-0f04e3343627,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b2da0f762fe911f0813e4fe1310efc19-20250513
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 787821695; Tue, 13 May 2025 19:02:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 13 May 2025 19:02:00 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 13 May 2025 19:02:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXZA/GdF0TdfTFvSuvWOaYE94DVe+wJkwDBZM+2NcWlAuM8HO0Pf+KGeVGcRInhCjou4Kr+nrXUPbKGi4Z3ocK8qDKK8Q5WDKDnj1osgRZa1euayBbRn/HHqQEGKUKfTFmn/a+NcCo5AGivzRf/dYJqSSKdHSqHanMuzmIUlbET48N6HhoSXSvfs9QmVSJ44T5GnhJGcimJl2AdO22QWaMN8f9yN1++wKE78VhYZUlLNkhRjKfrjuUj4Wy/j9XKdPHPhH7XANNAHC77xtTx3SVz9xdIrqwP9FU4tCzA2JSdq72TiA6kVAeG0a+waHUComu1KX+zlLXxOkc7ES+rxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAZ594IMZenc6hI4ffwlRPppJJEi8bff3FOGQA9bhoo=;
 b=g2hFZVhDI4MFnfbHWcbedFHwUOG9ZM/p10zZHFmE6I6fRmShFCsu96Su6dos3n650lRF1P3LhNtZaxCLV/evdgHYV74v7xzwQ8BY8YMJJVoaVN95n3DK19RW2SMYBO4gg0VEQwcLxKaq2c96JVCST13KowNHGO9Q/C3xqXL7TZlvkcXDGq3Vhj1MytPP9B9fY1CHM50l4CotHstgwOwMN9pR4QM+f3I+zs+V4QL7RoTCN7jrT6I67SeXVGym+iddKCissTmoqhOfhmCC+7+P+1hmwU+8G0yLgjkbwZ4B1Ewmp36tICDiXeeH5/ZVbeAgNg1RWIsjuaCqxsydh6vXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAZ594IMZenc6hI4ffwlRPppJJEi8bff3FOGQA9bhoo=;
 b=Iu+gDr0XmE8E+Yg0T2X0eUKsU34SPuH1Pex8fgmcaX/Tg3fzQxNxB4V0I+vIuCWcm/5OCJNdV0m/h3Zp7i5t5ocE68ZYQa7FV79Bd5uWBERu479TG8wsjDl01IAihhsG6ZtocdbON55pUFyC7YkcC/Pag2Ky0CjB2IByJ1To4Xk=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TY1PPF545DE4E28.apcprd03.prod.outlook.com (2603:1096:408::a58) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Tue, 13 May
 2025 11:01:57 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%3]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 11:01:57 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: phy: mediatek: add driver for
 built-in 2.5G ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v2 3/3] net: phy: mediatek: add driver for
 built-in 2.5G ethernet PHY on MT7988
Thread-Index: AQHbgqn0+oUccgrII0yLc8X4a8i6V7NOXWgAgIJ8NACAAA3ugA==
Date: Tue, 13 May 2025 11:01:57 +0000
Message-ID: <0f52f7d005e2bf6449568812002ee95dc9b6c346.camel@mediatek.com>
References: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
	 <20250219083910.2255981-4-SkyLake.Huang@mediatek.com>
	 <Z7WleP9v6Igx2MjC@shell.armlinux.org.uk>
	 <74ce0275952a9c60af87ded9d64ca7301fd69d0f.camel@mediatek.com>
In-Reply-To: <74ce0275952a9c60af87ded9d64ca7301fd69d0f.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TY1PPF545DE4E28:EE_
x-ms-office365-filtering-correlation-id: aec154b8-7732-4a79-521c-08dd920d9415
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ejhyZXBWRUhHb3Q0NkdFYnFlSmp5bXA1OENpYU1MeUVTRmluQzdaOHo5YzVH?=
 =?utf-8?B?NVN3YzJoZGRxSEJ0SVlkL3FkVEpGak5DbTBvSmtudGJVSXFhZnhJVm1SaFVN?=
 =?utf-8?B?U1J0UEhrRjJDRUxFOWZUakE3anl6anpOQU15V1Y2K1p4YzlhMDZiYmNoUUNB?=
 =?utf-8?B?bEhhL01ZN1YvbzJkU1FyanBHOURSRkJxeG8xWjVsL2crMWhKZEZONG5SQmk1?=
 =?utf-8?B?L3ZReitsYnB6Y3JnYndnWVFIWDN6WTJLd3RhSTRBS1ZyYXRPOVRhVlR5TGdT?=
 =?utf-8?B?Vjg0TFhnNGl5QmJvT2pTTnk2eWdscnY1OWNwSG0zRzkyWGw3R2h6c2hpVFBQ?=
 =?utf-8?B?MnVPODRFa1BwUVRYQm5VUXJWTEdjNGNmdzR4UGhsejE1bEhBYkNyZ2N6Y3Qx?=
 =?utf-8?B?ZHFuaGdZS1Z0ZnN2YVc1eUVLczNrMEhmN1FEQUFWT1A0UjRmWjVXV25CUDc3?=
 =?utf-8?B?REpXelIxRW5jWmF6amQ2QUN4NVNneTU0OFNQVVkrdU85cnVpR3ZEd2NIRVo3?=
 =?utf-8?B?bUtRVis4K2tNc084T2g4aDVxYXl6VHB2MlVXUzVEWWh2MVZYaXBiWW9pTEtV?=
 =?utf-8?B?YXdsZ2N3TmZVYTNEUDl1L1B2SlV4bmNOODR3NXRYc0Vtd25ORDdTZ1pLVUVZ?=
 =?utf-8?B?S0RWOGtFcFU5ak9ZbWo1VFdRQSt1WmtzN1hnTjV1RXhqS1RNdS9rUHFLcXNp?=
 =?utf-8?B?NWIvbHpTa25aOXZmNEdGQXIwMzhCdWRxWmUrVy92ZWRaNVZTcXZNNjcyNnRy?=
 =?utf-8?B?UW9HdGxDYlB1U0JMLzVxRnJodHNlQmRXUGpmWm5vcVBIdnpSdlBvaDRhc2Y4?=
 =?utf-8?B?cVorOGFqTnIwRFF6Zm16UWtrWldJOERKVWRvV05HQTA2eENFVnZSU29oTWFi?=
 =?utf-8?B?NTRvcHYybzA2VkRQaXpZalFodzAzSHE0Tml3M1BLN2lNbGFMN0xablRLaWhI?=
 =?utf-8?B?YlR4Q1BsZTZndWlLTWxMK0tKS05FZjNHR2RiSjBRMWw3d3UyOHlldTB4TDcz?=
 =?utf-8?B?V2FGcVJPb0lxOCsxN09KYTNpKyttVk9qWGd6V2lXYk1iTWZkQUZuWUlzZHlo?=
 =?utf-8?B?WGQyNi9uRXNWT1I3RUV0SFhqb2ppWFVjaDMvVnNhQTQzYVA4Uzh2Q0hxRFJ1?=
 =?utf-8?B?QzBueXN2UGtwYk0vVUdtMUFvTE95aWI1MkhMeUtocThQS24zZDd1OGRYSXFG?=
 =?utf-8?B?c1F6eFZUTXBNRG5xRzZ6N1ZNVGxiYWtuRC80MTgwTEwwbnpTaHRMaWRvU0du?=
 =?utf-8?B?U2xwZjdJc2N2TWIyZGxtaXprNUlmYzdiM2NCT0d1MXpneXdjWExWemFkM0F0?=
 =?utf-8?B?V2NSYWFvVnlNWjlrQ0JDSVlMN05jTkJpVzM2ZEF1b3g3WXZQbzR5VUxwVzBH?=
 =?utf-8?B?QWJvSXdsZ0lEY0daM0d6ZVA4Nk52akFTQ3ZkSlhIWHV3SkdyWFBpWDI5NjEx?=
 =?utf-8?B?OFFsVGpjQ0dHYzhVZHVtQ3Z1dGhDcjVHbmlLKzJQY25FWWJCWndwK1F0YWJY?=
 =?utf-8?B?R01GTXFJZlRSWjk4U0cyVmRLMnlnYkZuY1p4b1pGeXRnZVZob2QxWDBJTE1x?=
 =?utf-8?B?Y1VGM3pITkJzd0U3VUlWcGFJVHJMMTJHQkFMVnIvTVVCMXgvVThQOTd6cEtG?=
 =?utf-8?B?YVBLQjNmWHNnN0ZpS2xWSmVCMmhUbFIrVVJMQlpZcVZhcHJwdlJ4eVBHeVR1?=
 =?utf-8?B?cEJIL1lrQzlwVURMS0x0UG9iVUt6ZloxT01QbGRHNE1oZzRtY0xDcTlpR1k1?=
 =?utf-8?B?b2x3T0kxdExNazR6bitSV1grckpLaTlSeVNiRmhHaDZiUlVNdU0wZkcrS1I0?=
 =?utf-8?B?Z0hPcTN5MzZjcCtIcTFBaVhzb3d2R3IzRGVUWDRFNzhCcmNIYTF6YWZ1OFdM?=
 =?utf-8?B?aVpMSWI3ZlRBOEorQVdCVEZ4S1lZMkVUdXBMa29TR251NXNDS3FUYTE5ZjVM?=
 =?utf-8?Q?AyWv09MYl58=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUFGNzUvNklVcTQvdEowTTZLL0t4bHZMUlVGd2FoS01pVnYzVXl1dUNsZkFB?=
 =?utf-8?B?YURHOGV0eFhSeW9NRkZWUDIzcnFQOVFjQnF0bXpyWjBDN0JnVG45d00rUXZk?=
 =?utf-8?B?Y05jZGh6cVBFeU1FdzBXTkFwZXJrcmRnRS8rUndreEJCOUhsSG14WUwwazY2?=
 =?utf-8?B?VVVobWNReGVwbFIxelRtOGN1eVMvTVEzRmJZZG9uVFUyVWxFZjVQSjZNb09X?=
 =?utf-8?B?bVVHYW5tNjQxNFNaVHc5a2t5OVllNmtFSy9BYmFKWWZwRkpMc1lrUlprQlpF?=
 =?utf-8?B?TjMxa09HN1duQUF3ZGx3TkIyVFB0RStvOGZYai84dmJ0V0hXbjlzTUp0VTZw?=
 =?utf-8?B?eG1JbExpT1l6TFA4cHJyelIxMHQxY2pQcnh2alFrVklCeHc5WUJzL1ZMRlcy?=
 =?utf-8?B?TlRmKzNEeWhOY29WeWpubXQvbldPUkk1UnVUa2szQTJVeFEzbHdYMUN4TG9C?=
 =?utf-8?B?WFZ6dWZldHE2cURXS0RQZnBGbng1NmxWdUN2NCtXT2dpU3JGc1Bha0JZbjJD?=
 =?utf-8?B?d1FtenpJSm1uL3hlZUhxTlVYSGRiYko3YmdyaC9jcyt5dzYwR25yK1B2NzJ6?=
 =?utf-8?B?bnJxM0NXVDQyTmdwYWY0Nnp4MVJXbkRxd2Uxbm16amZqemlLWG9oNHpCWE1z?=
 =?utf-8?B?ODgyOXdDNXVvcGdKbkFuaWNBVlcyeDhZTExhcGRQSGhrT1Q4bEY3R2tuR1JQ?=
 =?utf-8?B?S2E3K1UzOHJIVm1FeDlHT1pxWWRQK3NjbGwrb25PK0V0WXlJc3dwQVVWYVZF?=
 =?utf-8?B?TXMyZTg1aDVvRWdZRmRSRmxXTlJKK0RDYloyaDRQcGhYMDZhaldrQW1yRmgx?=
 =?utf-8?B?aDg0eG5NbWVSYTNNTVYzMmROOVZzNXYvZnlnY3M3cDMwYzVCamZreG03NUNr?=
 =?utf-8?B?WHJEbjdvcWx0WkY4K0VieC9UdzArZTQ2dmZYaUpVeWQ5R0VvQkFKb0Zad2JT?=
 =?utf-8?B?Q0k4eVdHaFI0QjhZY1REenE3ZEtQZHREalBwWlRITnc1eVQvR2FNYTdIbTdN?=
 =?utf-8?B?eFZMTTlyWVpLWW5UQjg2OXBSOXorVmhGd1BvSVFuZERRM3NBcXVtTUVTUzdl?=
 =?utf-8?B?eGEvMDRVVDd5MFRCOERvaWl6V1dWVkZ1YnJYcnA1Z3dxNHFuSFFRVklkT09C?=
 =?utf-8?B?U0JLT0hvanQ4N0k1RlprNFMwSjM4YnRrYWRjTi8yZkpINk5OSE1xdk8zZ0lr?=
 =?utf-8?B?cjcvTDdpM09yN21FQ1VQNUN0aVlwUDV3Y1FRbkREak9ERTMrL3NNdVA4K1NH?=
 =?utf-8?B?MkhpcGRUc2I1SlFWUG5mcmZxRk9TeGV5U3RXZ0tTSURwWERIeWtjcjVrQytW?=
 =?utf-8?B?cngxZURnUlFhZWozS1ZZQkpLTk5VY2pMdDczUm8wSFRTM09nTEtMbnRQenRv?=
 =?utf-8?B?QllYb1lRS3htcjdSNUxOQmVWOUpBa3EySmRhZ1VOeHV4SDFpWmJhb01HWkJR?=
 =?utf-8?B?U0ZhRDY0VlNFZjFWYmttb25IcmpXT1ZVbFcrdGxHYWRRdlBDamxjZGdEUHpS?=
 =?utf-8?B?Q2pOaWgvdEJITU9kMFNSZEZOTitZQzlOaUxlNWY2eGQyNVcvZDFVRUNVeUYy?=
 =?utf-8?B?NVFsMmhKRXdhK1E5YTF2aVhnSFlPUUdBRWM4b1RxMDczN2JqY3doRlZOcXBL?=
 =?utf-8?B?OVRJSjVJZ0xiYU1EOTQxZXNJVTJCL1NGOXFlc282RWhGeGxZTHNjNUZUK2RO?=
 =?utf-8?B?dnA1YWdTOUdUNCtHV0N6dmZIbjlDWE5TR0VWQjh1TGdyUy9xWGlob2JES2V6?=
 =?utf-8?B?Y1hhekFiWFplZC9TaEN2eTBSY0haZmx0QXY4T0s4MlJKWFhQL0YyazZxWTF4?=
 =?utf-8?B?VmdYRnluOUtHOE1Gb3VDWm9pZDdBTEEwSnhUQkNOU21aNXlPdkhucFcvSlk0?=
 =?utf-8?B?NnI4dmpCT0FnTzF4QzE4SGZaNVluWTd4bHNkRkVOait6WWNuSnh2ZWluUU9p?=
 =?utf-8?B?WjdzWEdYanhFeC9tSjZNZWR6THd5QUtSWndQSlZHazJ3QWwrOGtJOVlQbW1R?=
 =?utf-8?B?K2VTRlFFWHE0WWdSaVBka3ZoV0xzVlZDVllOWDY5ZExRTjZYZXc0dU1Mb05S?=
 =?utf-8?B?bXQrbElMZkxJN3VUekx4cWNkZk14K1l1dEtwaTBpNW91Wndtc1pjNTgwNllS?=
 =?utf-8?B?aEhQVXlvTU54dFlpZnNNY2F5OUI2M0pqMFQ1YWtlVkpvSkpaZjA0VTE3V04z?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <696693E2DA53594795E4C7314E2C371E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec154b8-7732-4a79-521c-08dd920d9415
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 11:01:57.2523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHfuyrwqXYeh0MK80+1tlkDnVaw92TYYR5rR+EuOf1JrCFVS1hEZB5+blKYey7O+J8M8QaDVaFZ7kCs2gCKNme8FKY3wGgQvLIJmd455v8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF545DE4E28

T24gVHVlLCAyMDI1LTA1LTEzIGF0IDE4OjEyICswODAwLCBTa3lMYWtlLkh1YW5nIHdyb3RlOg0K
PiBPbiBXZWQsIDIwMjUtMDItMTkgYXQgMDk6MzMgKzAwMDAsIFJ1c3NlbGwgS2luZyAoT3JhY2xl
KSB3cm90ZToNCj4gPiANCj4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+IHVudGlsDQo+ID4geW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiANCj4gPiANCj4gPiBPbiBXZWQsIEZl
YiAxOSwgMjAyNSBhdCAwNDozOToxMFBNICswODAwLCBTa3kgSHVhbmcgd3JvdGU6DQo+ID4gPiAr
c3RhdGljIGludCBtdDc5OHhfMnA1Z2VfcGh5X2NvbmZpZ19pbml0KHN0cnVjdCBwaHlfZGV2aWNl
DQo+ID4gPiAqcGh5ZGV2KQ0KPiA+ID4gK3sNCj4gPiA+ICvCoMKgwqDCoCBzdHJ1Y3QgcGluY3Ry
bCAqcGluY3RybDsNCj4gPiA+ICvCoMKgwqDCoCBpbnQgcmV0Ow0KPiA+ID4gKw0KPiA+ID4gK8Kg
wqDCoMKgIC8qIENoZWNrIGlmIFBIWSBpbnRlcmZhY2UgdHlwZSBpcyBjb21wYXRpYmxlICovDQo+
ID4gPiArwqDCoMKgwqAgaWYgKHBoeWRldi0+aW50ZXJmYWNlICE9IFBIWV9JTlRFUkZBQ0VfTU9E
RV9JTlRFUk5BTCkNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9E
RVY7DQo+ID4gPiArDQo+ID4gPiArwqDCoMKgwqAgcmV0ID0gbXQ3OTh4XzJwNWdlX3BoeV9sb2Fk
X2Z3KHBoeWRldik7DQo+ID4gPiArwqDCoMKgwqAgaWYgKHJldCA8IDApDQo+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+ID4gDQo+ID4gRmlybXdhcmUgc2hvdWxk
IG5vdCBiZSBsb2FkZWQgaW4gdGhlIC5jb25maWdfaW5pdCBtZXRob2QuIFRoZSBhYm92ZQ0KPiA+
IGNhbGwgd2lsbCBibG9jayB3aGlsZSBob2xkaW5nIHRoZSBSVE5MIHdoaWNoIHdpbGwgcHJldmVu
dCBhbGwgb3RoZXINCj4gPiBuZXR3b3JrIGNvbmZpZ3VyYXRpb24gdW50aWwgdGhlIGZpcm13YXJl
IGhhcyBiZWVuIGxvYWRlZCBvciB0aGUNCj4gPiBsb2FkDQo+ID4gZmFpbHMuDQo+ID4gDQo+ID4g
VGhhbmtzLg0KPiA+IA0KPiA+IC0tDQo+ID4gUk1LJ3MgUGF0Y2ggc3lzdGVtOg0KPiA+IGh0dHBz
Oi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3d3dy5hcm1saW51eC5vcmcudWsvZGV2ZWxv
cGVyL3BhdGNoZXMvX187ISFDVFJOS0E5d01nMEFSYnchaVYtMVZpUEZzVVYtbExqN2FJeWNhbjhu
ZXJ5NnNRTzN0Nm1rcGRsYl9HVzhoc3doeGM0ZWpKb3p4cWtVM3MyV3p4U2l6czRrZmRDNzd5cjdI
R0dSSXVVJA0KPiA+IEZUVFAgaXMgaGVyZSEgODBNYnBzIGRvd24gMTBNYnBzIHVwLiBEZWNlbnQg
Y29ubmVjdGl2aXR5IGF0IGxhc3QhDQo+IA0KPiBBY3R1YWxseSwgSSB3cm90ZSBmdyBsb2FkaW5n
IGZsb3cgaW4gLnByb2JlLiBIb3dldmVyLCBkdXJpbmcgYm9vdA0KPiB0aW1lLA0KPiAucHJvYmUg
aXMgY2FsbGVkIGF0IHZlcnkgZWFybHkgc3RhZ2UgKGFib3V0IHRoZSBmaXJzdCAycyBhZnRlcg0K
PiBib290aW5nDQo+IGludG8gTGludXggS2VybmVsKS4gQXQgdGhhdCB0aW1lLCBmaWxlc3lzdGVt
IGlzbid0IHJlYWR5IHlldCBhbmQgcGh5DQo+IGRyaXZlciBjYW4ndCBsb2NhdGUgL2xpYi9maXJt
d2FyZS9tZWRpYXRlay9tdDc5ODgvaTJwNWdlLXBoeS1wbWIuYmluLg0KPiBBZGRpbmcgIi1FUFJP
QkVfREVGRVIiIGRvZXNuJ3QgaGVscCBhdCB0aGlzIG1vbWVudC4gSSdtIG5vdCBzdXJlIGhvdw0K
PiBhcXVhbnRpYSBhbmQgcXQyMDI1IGRyaXZlcnMgaGFuZGxlIHRoaXMuDQo+IA0KPiBCdXQgYW55
d2F5LCBtdDc5ODgncyBidWlsdC1pbiBwaHkgZHJpdmVyIGxvYWRzIGZpcm13YXJlIGluIG9ubHkg
YSBmZXcNCj4gbXMuIFRoaXMgaXMgdmlhIGludGVybmFsIGJ1cyBpbnN0ZWFkIG9mIE1ESU8gYnVz
LCBzbyBsb2FkaW5nIHNwZWVkIGlzDQo+IG11Y2ggZmFzdGVyLiBXaWxsIHRoaXMgaGF2ZSBhbnkg
aW1wYWN0LCBpZiB0aGF0J3MgdGhlIGNhc2U/DQo+IA0KPiBCUnMsDQo+IFNreQ0KDQpUaGlzIG1l
c3NhZ2UgaXMgcmVwbGllZCBpbiB3cm9uZyBwbGFjZS4gUGxlYXNlIGlnbm9yZSwgdGhhbmtzLg0K
DQpCUnMsDQpTa3kNCg==

