Return-Path: <netdev+bounces-165865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 848C7A33905
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FEB3A51E3
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D0F20A5E4;
	Thu, 13 Feb 2025 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ek8xYwLa";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hhNY7wTw"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42B8208984;
	Thu, 13 Feb 2025 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432390; cv=fail; b=h9FCiDYGOwAMIPTelAeI6rZ9+9m2tvRuTimpM/gB5VU2clXS1TLDf10qsq5fLnEpqh/4XSJpL+NJ6FY9vKtvdgoCoeHkRjWMq9uNcUzKW3qAIIsY03wTAcyZ2dahGmBFOCUw0K4K9cn8uC69KWhXbNQmfs8WEHWQnh1xdouiLLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432390; c=relaxed/simple;
	bh=JMrvF1NGpkH4NGp4YtDYV3sDBnNjiSF2QZ7eq6FTLVQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XVAah5L6kFdR8r87/V4PLUNQ6CcALCmEuSJR7jtwwU6jg0NoTRDY9U1Iy6oAEVl+qeUYTOKjKRGpAJXTWi3XBqR7O6eA97qUHQS7z/3fPO1DLmwUN6iAXUlJBDEfypnXGkoqwUHt5mw/VzmuMEfOCCzXM0p5SP44Qcb0b3MiRjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ek8xYwLa; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=hhNY7wTw; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b0a1abeee9dd11efb8f9918b5fc74e19-20250213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JMrvF1NGpkH4NGp4YtDYV3sDBnNjiSF2QZ7eq6FTLVQ=;
	b=Ek8xYwLalC+4qgV05h93JaUxXbJUvLRz40igNN7jjhukrUPYNWjN8Mdy1VHd+bwclc5BKJM5alGenzPfKX7UYy03O4xVZPxyYhIj4jPnl1c/oJQThf16ogqDvdF8cD0AYmvYI3MEr46KOFlQsExnQvgJd+P4gO3y+vudWWT+72Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:15492f9b-b124-4b74-b693-eb8579df989f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:60bd8127-6332-4494-ac76-ecdca2a41930,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b0a1abeee9dd11efb8f9918b5fc74e19-20250213
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1088046373; Thu, 13 Feb 2025 15:39:43 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Feb 2025 15:39:41 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 13 Feb 2025 15:39:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Htr0k+WczymHwgu2F25x3gAEr0B1ATMG+9oqmES1zEScHL7LPcB6jKdrfKBEMyZv49tnvwBOVcfpLJSABVe+syhAS1sbHUgCymfc3ayK5Vm+Pes9eF5zsHSL4JM9fJXiqpLUFU0wPhSQ9rjBr0+yfTLTbc6td+GCO8r+4/EEYlwXbB19QjKWF09PUDP2mUoGpRm2XsPuul35dWzC4q+fdTf4u6T3hOIYl/voGYRJ+Je1wQU/WkmlQgZKH9Av1u61hrUSvYMwAs3/0kN0tSNWWh2D89oNfLPenLDkVuYTSi2I9ce2A2VemVtS0b7HtMi5D+u70w/e6RzYiD58P/QPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMrvF1NGpkH4NGp4YtDYV3sDBnNjiSF2QZ7eq6FTLVQ=;
 b=CfmGjApeZnl95456p5UeiCm/cqQQIAROyqWMeG17T3aXj/bdJC7jwnxkvVSrvseooueu95FeOyw4HRme8tG61TiFQ4L3UbnQ7OTxeTQxmbwKzQeYUA+ZEAMvRHMc0P7sNOa9Pu2LgMnuaGYR1U4zw4ez3JIVFjP+0DjUigLrkQ02TFE8LInqTpEnYi9JnAxgXyFBhIuzwK4bqY4T06N0wruEWbpa28RKKLjzrcu7f/qsm5UrrgXgR1paVTg9wxRMbHyZacedM8TSeV+/Eu4rMPOOhgRf6DqJV1Y+CoaLU9JbZ5+STnfTEAGJyZsFgUqbWhK0t5XQY1/VJrsQNzRC1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMrvF1NGpkH4NGp4YtDYV3sDBnNjiSF2QZ7eq6FTLVQ=;
 b=hhNY7wTwCnjws1A16jKwxibZcpUoS+1kmDqgEl4aJq+auyHG2xxTkh2MdGmxvge2pzOekIem1fN6IvqWw8geGvk7Gp4PFUQSH4sJIZpz+heacGRDNatpO0fsewV+UGzppnwnWJQrivY+BQ3HUWmZJDiSZxZj4L9l4vmuhosWbDc=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by KL1PR03MB8001.apcprd03.prod.outlook.com (2603:1096:820:fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 07:39:39 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 07:39:39 +0000
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
	"horms@kernel.org" <horms@kernel.org>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH net-next 1/3] net: phy: mediatek: Add token ring access
 helper functions in mtk-phy-lib
Thread-Topic: [PATCH net-next 1/3] net: phy: mediatek: Add token ring access
 helper functions in mtk-phy-lib
Thread-Index: AQHbZ7U2F8dh2u3i60iVYqHZPuCCULMeWziAgCaqOoA=
Date: Thu, 13 Feb 2025 07:39:39 +0000
Message-ID: <385ba7224bbcc5ad9549b1dfb60ace63e80f2691.camel@mediatek.com>
References: <20250116012159.3816135-1-SkyLake.Huang@mediatek.com>
	 <20250116012159.3816135-2-SkyLake.Huang@mediatek.com>
	 <5546788b-606e-489b-bb1a-2a965e8b2874@lunn.ch>
In-Reply-To: <5546788b-606e-489b-bb1a-2a965e8b2874@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|KL1PR03MB8001:EE_
x-ms-office365-filtering-correlation-id: 324a130a-92ca-46de-b4f2-08dd4c019298
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UFJzbFZNK20zaTdTeDhySkJ2QWo5VUZTYjNNSmlPVU9vL0IydnEwMEZpTEVG?=
 =?utf-8?B?enBqTWxTUEIrUWRHY3ZBN3ZKck5CN3VON0dWRkdyZkVPektFRTBQRE5aNzhF?=
 =?utf-8?B?RWc2MjFmaGVCdVlPRTJucEhVcFloZStnNjlDWFV5dWVqbjRMZjFOWVFKVWNK?=
 =?utf-8?B?TXNnbWxIaVZwYmVKNmNmSjYyaTQwaWhzNm5zMDY4dS80QXY2bFkxLzV6RGdr?=
 =?utf-8?B?clZKZ09OSVNHeFl5a2V6TmVjRjJldXN1bW1iWkNQdHlVekJYWWV6cTRRRVkr?=
 =?utf-8?B?b1VnVWN6Rnk5N0FXYjIzaXJqM3BUbEpVNFB1MWduK0tNTXdYMDdpUUFlTXNz?=
 =?utf-8?B?U0xrWXp3TWw5WTU5VGl6eHZSZUdLbXZBQjhSRThoaFZvK1JWeGpQeEQ3M2ll?=
 =?utf-8?B?WXVjWXlBVUdQSWFiUldyYnlnWDZKa0tRRmNtM0FWWjNKNWQwdTFQUU5mTmRL?=
 =?utf-8?B?USswWWVrbzFXSERybWZ3bFB6Z0xhVnFhOHVURU1BclJoQWp4dWtiMUIyeVdq?=
 =?utf-8?B?NDkyUkxkWkRhaVFobzd2RzM0N1BINy9xa1RrREk5UW1XbmE1NGFaVEdWbmNY?=
 =?utf-8?B?YzVjZ0ZEZXhXQnNvanAzc1k3YnpHaDYvZnc4ZEN5TlJjcENxWUFhUzB2c1hS?=
 =?utf-8?B?bkRlNzlIM29uc25JZHNqdmZPMG1pUXhOSTRVL3o3M3k3S0dRQndoSC9SSmtX?=
 =?utf-8?B?Yjgva2kxQ2N5OWtZY1ZXbUNIaFl1TkRPRm1vYXh6Vytlby9wQWppelAzSjFj?=
 =?utf-8?B?VjYwZUtNNkovaTBWN1NsbGhtbFhVWVpOSGlHR0ZkK3hZSFhJaS9HVFdsQUdD?=
 =?utf-8?B?NFRlNDVDdFhhZUFxajBHV1Vob3RJN3BhcW5YdmJETHJZbVhodWF1ZENxSEpx?=
 =?utf-8?B?SVlqUm1aSkRVZWtlZnp4Q3R2L09PZWNKdmIweEF4SldORm5yOG1EUm1ZT1l5?=
 =?utf-8?B?R0RlMWw2d216YXpXeFBGb3p0Z2JSLzRoOFN3VTRlNlI3YjlSczQwSkpkemc1?=
 =?utf-8?B?N1Jzd1pjRXhWMXN4OHdXSkNreHpobWt2TURlVUFpd29CM1g4S3p0OW5Lc3RB?=
 =?utf-8?B?eXZOTGhBcFF1MXNNRVFIZFZBUmRKbU1pZ1J5WitFVTBEdFZ4M1dqdmVKYzlY?=
 =?utf-8?B?WkoweEpFVmFLTjJhUzBKN3UrMDdyK0U3QlVBOEk0enVETHpSTHBwNDkyQjU2?=
 =?utf-8?B?cTduSVZCcHFPeTVzWmtEMTczUVAxOTRwUWYwWkkzL2ozVXNHbUJ1RENpYzAw?=
 =?utf-8?B?TnFTZ1FqSWZnNzhUVlE4UWQvMlN3M0tHb042S21mTW9ucUZQWUZ5L3FFNm9n?=
 =?utf-8?B?cStaQ0U2dTk0MTczQlZWdkErd0o1Rm5UazdwUHk5aW00WDY1eXdCNWZwQnBa?=
 =?utf-8?B?ekhHMHNtWFhNNWN3Z0s2ak9takhNTDdqQnNFV3RoNFpCdTRBdnNBdkg4QkEx?=
 =?utf-8?B?UnlhRmJtQ1NCNUhPOHF2MmxUWU1XQTZzSVF1anBrWGFtdHlJeUZHbnN0Z1hL?=
 =?utf-8?B?Y29KdmhPVkNIbWZBcDNUdDVWME83SFRDeHZabTNvSDVWbEp5R1R0bU5kSFNq?=
 =?utf-8?B?UjF4V1hnQ2NodmxRZUIrMlJqdWtMMk5wbjlFVWY4RjJiempLRS9lb2l1bHZm?=
 =?utf-8?B?dEN2UmZpR0Z6aW1YaElPT2c1NlRxUWZ1Mk1OcUhKckFlNGY1Vy9RUHBoRm5v?=
 =?utf-8?B?TGtQRFNwYUlVQnhveG42dXNaNW1IaVVtaWJCUlc4YUdvSHVXcmxGQU45VGlw?=
 =?utf-8?B?RXJRSFkyRmNwZFhVNkptY2JxNS91YUdLL2NkZ0NTalhjNnlpakR3Q3V3MjRS?=
 =?utf-8?B?SXNmUzBmY2QwbU1YSEIvTGZBekdmd2pSRHVQSFRmcUhoNGxlaVFOMks2VTFi?=
 =?utf-8?B?MzRZMVBCNk13WERvcHF5dzAwVTI5OElYSW1kTnphYytYdXZnRFpRVm9JV2t2?=
 =?utf-8?Q?ItvBn2AdK/m/n1ZHLYMNeu43jZamziVJ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RExpd0l6R3RnQStocjBqNDBjdjFBVWdMVGZ3S0pEcncwK1Q1LzFOZ1RXZnZV?=
 =?utf-8?B?Sjg2WDYrTXlRL3M0ajY1b29TeGh2UTA1WFBpdWdZY3lUNnJTNk9VeTk3U1Zv?=
 =?utf-8?B?ekFIamhXbmk5S0s3dEExNldtU3VLejUwSTRvWlh4cVVDaWlrcDROc3A0SU13?=
 =?utf-8?B?eFZZbHFwaUFyUWtvdjZYQmNQMjJKdGFpbTE5bm1jc0NFNkF5em5KSXhNQzRF?=
 =?utf-8?B?ekRRT1BiaUJiZGh5U1dSWEc2YXd1STIrMkVBRXh0WnJTNythY0JRNjkvbHE1?=
 =?utf-8?B?UXJESGpaS0Z1M08vZkRDRDM5elRKajlFYSswUUFneWs5cEZhV0dkbUgvS2Rt?=
 =?utf-8?B?Rnd4N25IS0dIdGRVVks1RmdYbGNSdFpoZ0JFMHdLYXNLMjRwSVZtdTg1RVJ2?=
 =?utf-8?B?bWlmdTJjQjV0NjNPOEdmc0N3eEZPZ2t0ZGJiVlI3K1QwMlRVV1VDa0VmMitt?=
 =?utf-8?B?WTlMK2Q5QjdPWTlBcFR6ZTArd1BzYk4xUlplcVlLZ2tjS2RPaVExU2h4ckxT?=
 =?utf-8?B?bTlNVW5zTG1CQnlyaHhRVmIyd1Y2dnpweExsU1ZZZEhFMnhRc0thVGRlK1VN?=
 =?utf-8?B?bjdjRWZDeWVDdDhKMXZSTFBaN1drcldWbjc4RGswVFBIL1NzRGtzbnZTVHpr?=
 =?utf-8?B?MzVUWm9oaU8xUVpMd0xwY1ZQZHI4TEdicE9YVmRtNVoxNml4Mi9ZclBINmJV?=
 =?utf-8?B?OGNCRGhMZlJYdklNN1BUa1F1UGswMDZsUWRnN1pIaGVQWGZGN2ExQTM0ZG1E?=
 =?utf-8?B?TnhTOEF0ZmQ1LzZTWEw3Qmo3RkVVT0hvOHNqbnRwdWRVcUNOQVR3algyekR3?=
 =?utf-8?B?RkNVUHpOSXdSeUxKQnhUZnJnWGZCT05seHFFeDRnUW54ZmczakswKzZ0UVNz?=
 =?utf-8?B?L1Ayck1XbWcvUjhielhoUEg0S0ZDODViUWhjMXZ5WkMweFpmRmROeGZlWDhT?=
 =?utf-8?B?UWF1ZkRnWjlGazg2Y25VY0t2SlBYSXltVWQ4K29rUmFIR2ZpMXZGMEk0RnNG?=
 =?utf-8?B?N2JlZmdENGVQaFErSm9iZFBRU2N2UEpkbG1xQnJ2YlBzb1FNYklFd3hhdmo1?=
 =?utf-8?B?MUxEMHE3UU1QVzVZRW4vNVVZMDNBcktwT2pjQWZhOHZEZnUzZnhhbHlGaWNm?=
 =?utf-8?B?aDNNMlZaVmRLZ3NkS2xQb2tRaXMvNUlRWVIrQWNoc2FIMng3Zk5hZU04T3ZU?=
 =?utf-8?B?N2dqWXZKbGlrcVVEUHV4TUFOL3FmcENBRU9ONG82ckhaamZzcXpQK2psZm1n?=
 =?utf-8?B?NHNVRi9XeHZaWi9aelZiNUtqZFBEcG15MU52T1ovMnBiM2I1M2R4cll2UEZF?=
 =?utf-8?B?NkNiZ3Vuc05xRXBlQ3FOVVlib0oxakVBbGxWa1FQY1oycVJhM3QrK0l6bTcw?=
 =?utf-8?B?L0xTaWxTUHBhTjQ5eTFya1M4aEVpN2Z2U2s5TUxOcm40ZTdBS0FKMjRnZVRY?=
 =?utf-8?B?QTFaWk5QMXo3VFBiUW0vS1pVN09jRk4vbDVnQ0h3MW4rc1JrUk53Q3ZnYVlo?=
 =?utf-8?B?dnRoQzNZelRKV2NDK0FqYlVwZUVweHF0K2pyZldRRGRzaDgyK0E2TjFTa1dv?=
 =?utf-8?B?WjJHMmpqVXJMdmtFMUs3ZEtNbFFPUktnbC83eUw1SEpJSERuTkdVTElkQWky?=
 =?utf-8?B?b3ZrR3BOU0VlUWQvc2x6SXgzaEs5V3Z1bDdsQ1JKTm5RNmRPK29hVWdocG5J?=
 =?utf-8?B?TmRJajVIV2JHNEhMUnk3NWN4eXgzc3JRamVpUUtEeWdGQmNTR1Nma2RjYnlK?=
 =?utf-8?B?Y0ZIcWJkUWY1S1JsWWdBTkNwaHhNQ0lGOVlBc2ZIcHI4em9SaXFEb2t3Rnpz?=
 =?utf-8?B?MTF6Z1lFQVNCZFJHTDJxUHdLVE0ydEUxOXVUTmxoZEJlNGVGUjdMWlpOTFYy?=
 =?utf-8?B?WDVVckh4b3BZQlB0NWRxVUREZU9UaSt0N0QybVB3YXAvTGp1SzVBNXQ4d1Y0?=
 =?utf-8?B?N1BQV3Q4YlVNQ2tBWVJrMGxObnlxNHNHUTQ5V3lNUzFkUWFsSzlheHAxdFZu?=
 =?utf-8?B?UFg2c2xxQTd3WDVNclVEKytlUFFvNVNpaktaaHZaYUNQWDkwTXB4RjlnUGp0?=
 =?utf-8?B?NE9QNzZuYURCRVpiNmY1eVdNMFVwSFMzRHpTSjBvZFlISkZOK1NVdDl5OGNv?=
 =?utf-8?B?M2htYlM2bGE5ZDYvMnYxcUkrWE4xSllMZnJKM21CSUlFMlEzVUJYeXVtaUli?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E429D67CCF9F24FA731EB26C9FFFBA8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324a130a-92ca-46de-b4f2-08dd4c019298
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 07:39:39.4580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yor20M2V/811euJ2q4A2mNaJzs7yzA4oo7n/7lTuNtVAmQg2Ni53dgwbKbjGZGjhEbbxaV462sSZlcrZKfS8A30bRJWSdPY8/RJFsLBCoDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8001

T24gU3VuLCAyMDI1LTAxLTE5IGF0IDE4OjEyICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+IA0KPiANCj4gPiArLyogY2hfYWRkciA9IDB4MSwgbm9kZV9hZGRyID0gMHhmLCBk
YXRhX2FkZHIgPSAweDEgKi8NCj4gPiArLyogTXJ2bFRyRml4MTAwS3AgKi8NCj4gPiArI2RlZmlu
ZSBNUlZMX1RSX0ZJWF8xMDBLUF9NQVNLwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgR0VOTUFTSygyMiwNCj4gPiAyMCkNCj4gPiArLyogTXJ2bFRyRml4MTAwS2Yg
Ki8NCj4gPiArI2RlZmluZSBNUlZMX1RSX0ZJWF8xMDBLRl9NQVNLwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR0VOTUFTSygxOSwNCj4gPiAxNykNCj4gPiArLyog
TXJ2bFRyRml4MTAwMEtwICovDQo+ID4gKyNkZWZpbmUgTVJWTF9UUl9GSVhfMTAwMEtQX01BU0vC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR0VOTUFTSygxNiwNCj4g
PiAxNCkNCj4gPiArLyogTXJ2bFRyRml4MTAwMEtmICovDQo+ID4gKyNkZWZpbmUgTVJWTF9UUl9G
SVhfMTAwMEtGX01BU0vCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
R0VOTUFTSygxMywNCj4gPiAxMSkNCj4gDQo+IFdoYXQgZG9lcyB0aGUgTXJ2bCBwcmVmaXggc3Rh
bmQgZm9yPw0KPiANCj4gVGhpcyBwYXRjaCBpcyBwcmV0dHkgbXVjaCBpbXBvc3NpYmxlIHRvIHJl
dmlldyBiZWNhdXNlIGl0IG1ha2VzIHNvDQo+IG1hbnkgY2hhbmdlcy4gUGxlYXNlIHNwbGl0IGl0
IHVwIGludG8gbG90cyBvZiBzbWFsbCBzaW1wbGUgY2hhbmdlcy4NCj4gDQo+IMKgwqDCoCBBbmRy
ZXcNCj4gDQo+IC0tLQ0KPiBwdy1ib3Q6IGNyDQpUaG9zZSByZWdpc3RlcnMgd2l0aCBNcnZsKiBw
cmVmaXggd2VyZSBvcmlnaW5hbGx5IGRlc2lnbmVkIGZvcg0KY29ubmVjdGlvbiB3aXRoIGNlcnRh
aW4gTWFydmVsbCBkZXZpY2VzLiBJdCdzIG91ciBEU1AgcGFyYW1ldGVycy4NCg0KSSdsbCBzcGxp
dCB0aGlzIGNoYW5nZSB1cCBpbiB2Mi4NCg0KQlJzLA0KU2t5DQo=

