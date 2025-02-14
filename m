Return-Path: <netdev+bounces-166282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F0BA3555E
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 04:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED72E1891706
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 03:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25CF1531C0;
	Fri, 14 Feb 2025 03:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nyGyJICQ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="VfTlJIBc"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AFF78F34;
	Fri, 14 Feb 2025 03:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739504128; cv=fail; b=Dp5P0R0J64PtCZLLoR0dZ8NzZf57toku2Yq+V48eB5FS7A86vOcytmT95BBigmOeJzIODmrntpDu+KlZh0yCQFc96QfmPilTJFhkfpMKf3pXzehUq+95sJYxMl/XTV7S8lPWn5fE+02xcL/DuGnNUC0TP9oWbxhPLnlapH7Az18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739504128; c=relaxed/simple;
	bh=1vMaN4MwbAlKTEG4bfp1wQ8f8VXAdwAQ5IChGDakrcY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R0rscFNhrjFrM72TOkWbavTCloZiQOEsIYQ2ISiW+9NAM7mBxa3MV7DytngCRrTVkmHqCFBUwoVhPisw51L9U8GLzfFuHbyks5riNvMPSMtlLX65yY9tOY2VUS8oXQkQivvJE6qPzy6b5s+fPDBDiWVzZjMpw8D9TtL4sQaXkOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nyGyJICQ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=VfTlJIBc; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b412de04ea8411efbd192953cf12861f-20250214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1vMaN4MwbAlKTEG4bfp1wQ8f8VXAdwAQ5IChGDakrcY=;
	b=nyGyJICQ/ifgBTWKrY85uAo3oIukOMOjLCCVrI1dmZJivAKz3+QaHXNCHeQNJFxI+v8YNc9+2qhUu1iKCzyTCnt0BfL1DgMJZBLQdbZnArqFH+t8SDkhVph7xiRk78CIidCdHTC6JkREFKNHbK+rMTkEBG9GoE8CWWO1NA4tJEg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:6800df8e-049a-4eca-b135-5448a286a6fa,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:1d545a8f-637d-4112-88e4-c7792fee6ae2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b412de04ea8411efbd192953cf12861f-20250214
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 832097907; Fri, 14 Feb 2025 11:35:14 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Feb 2025 11:35:13 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Feb 2025 11:35:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fi9amiaaxkB6ApsgGg56k6eCk55LTZ17OCOdb35reu5lJGDkgVj+Y5Jl7tjGFdiYxivAIHRhJmgAuIwxxDBCZVxvU/MPOETepOTN6bPRJmp3XkMEXZr8u8QhJIaxhUBbQvs2/BMB+q18ZGD1xdCANwgb7EFMMJOtJ55asWoQyeCdT78993A+bFYqxv0qSsVoAqrAHUdQ2IGCetv79tf1/+Wu9WQJB7Ar0orA0/aB7N1Y0C/qxWoOaMOSQfzuLxiRBwlKwQD54dQvQE8NjrlVLF26VieaIbZZZnk7DB6RflCBLVS2U+a5egpd/G6YLJNpzQDZOsdAHwnJAxcGyPAV/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vMaN4MwbAlKTEG4bfp1wQ8f8VXAdwAQ5IChGDakrcY=;
 b=hziUe/HXqrNd7jDUJcjCMH/dj3M7fkbPuHAYA9QjniYMWks585EspsGnFMkY/uEA0NNFGnhsf8L6W1Nlj8XQ7W57iALBMuE8Ub3m4j9fLFFw6vqHR9ImGCWnbILidReR18z0CytTDIiROeckdZDiv+ZLqltzmodUoyyrj5xKdqF+yfrcYwvT9MBPSDz8sYLanPMW/3vOEdjcrx4+U6G+P8OlV04ysCOYao85GLTRoS6otliWaJTSV/4ZmoXwZlhIEuUa1Uw1q4XQ+66wRRx6xHAfXlm180t3ifQB4f3bQMgBkk9p1mSDv29Y9UhseD1j21/vlk3VJTm5A5lgWdQY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vMaN4MwbAlKTEG4bfp1wQ8f8VXAdwAQ5IChGDakrcY=;
 b=VfTlJIBcX9JiN/qGqFuOe8JjqwpBHkeygVcIhZAa9bM9TIweaewS7PxSw86cfe9NNCPElMDnZHIpQ9XuYW2azvCnAoCEYlmuDT9XqaK+tHVB25o0hmwrXAvzMbP/RHh93L7elkgrMZX50tCVuETRHh02MYrp6k41bjwheGvy0OQ=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by KL1PR03MB7456.apcprd03.prod.outlook.com (2603:1096:820:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 03:35:11 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 03:35:11 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>
CC: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net-next 1/3] net: phy: mediatek: Add token ring access
 helper functions in mtk-phy-lib
Thread-Topic: [PATCH net-next 1/3] net: phy: mediatek: Add token ring access
 helper functions in mtk-phy-lib
Thread-Index: AQHbZ7U2F8dh2u3i60iVYqHZPuCCULMeWziAgCaqOoCAAGHIgIAAA/+AgAAfCICAAMk5gA==
Date: Fri, 14 Feb 2025 03:35:10 +0000
Message-ID: <ea348d0a4b30c4926ba16a6e79cb52196aebcf47.camel@mediatek.com>
References: <20250116012159.3816135-1-SkyLake.Huang@mediatek.com>
	 <20250116012159.3816135-2-SkyLake.Huang@mediatek.com>
	 <5546788b-606e-489b-bb1a-2a965e8b2874@lunn.ch>
	 <385ba7224bbcc5ad9549b1dfb60ace63e80f2691.camel@mediatek.com>
	 <64b70b2d-b9b6-4925-b3f6-f570ddb70e95@lunn.ch>
	 <Z633GUUhyxinwWiP@makrotopia.org>
	 <81234e04-f37c-4b10-81e6-d8508c9fb487@lunn.ch>
In-Reply-To: <81234e04-f37c-4b10-81e6-d8508c9fb487@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|KL1PR03MB7456:EE_
x-ms-office365-filtering-correlation-id: d3ed5fbb-6332-4f92-6901-08dd4ca895e1
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M05hcHl2WG1nRUplRDV4dFhRbFZGbk1LOVIzTlJmR3hzZkJ6eENUODU5KzBu?=
 =?utf-8?B?ZUN6M1YvT0FScUoyU2JBQ29SVFBnTm5tWUxnU0wrdmdxTDRFNkFXVVpjcWw5?=
 =?utf-8?B?aEo5WWtvRFo3VDFJV2wycGtzOExTQnQ3NFNMT0ZhNml0aHIrd21zSERRbHpI?=
 =?utf-8?B?OXh5R3pNbW1kMlNJcWlWaTZGeU4zd3VSUExJeGFKMmFON0xPcE9DZU1jZlQv?=
 =?utf-8?B?eFV2ZHduY1VWekh6TDlzOWh4L0l3dW50a2JTTnd6aVdJaU5naTc2MXlVZ3hp?=
 =?utf-8?B?OFJ2SXRxcmNXaXBlTGlFdzY5UDc2TXdFa2k4eWVMTFI4dSszRkpaV1FwbUFC?=
 =?utf-8?B?aUdkQ2F1Q1RYaFdpb2t6MGhvYndlc1pUdVI0ZDZaeTFDakNqTlJPK2JXY0pj?=
 =?utf-8?B?eVZqcnV2TGcvU2hGKzkyNHhkRlhmL0tid3Bmb3VpWVlDZkNuQ3ZNUzJOVnFD?=
 =?utf-8?B?NldXL2JuZXBXbEZDSi9pTWcrcGdRWndjMTI3N0VnbkxxZ2RCUjZ1eGVjb3A4?=
 =?utf-8?B?Z0tmTDNrbzNacUcyWmpQVUtsTVgzV0VYVUFWbGpWVGdTTFZZb0x6RUVQcEpu?=
 =?utf-8?B?bEFtcFViUk1rejREUVlDMUIxd2JmS1B4SmJwK0pxek5PTkhPSzJaK0oxSE83?=
 =?utf-8?B?R25VODNiNFMxTXpjOEpQK2VXdkM1dFhDbmRscVplQWwzdVZBNjF1QnIxekx3?=
 =?utf-8?B?cmZVcXZYOWQ0K0JsWU9hU2FZVEdnMGJoMjJTM2doMnJBWVRMY3hpVW1hSHR0?=
 =?utf-8?B?SmYzUVRxNE1WdGZIUGEvWWZzWVpFZUpOeWs1OEZWbUc3ZXdBNFloY01VZ2tR?=
 =?utf-8?B?VlduOElzT0pZL3lLNXZrdUZWMnNuTWJiVzR2Z0FaVytQb3YzblNFTWxJVGEx?=
 =?utf-8?B?SzhmUzFDZ1hMYkxtYlpUUXFDbEY3MFpwbVFyeXgvWGIyY3ZHcE5JZmpWcjVa?=
 =?utf-8?B?ZUxNaWhTRlRCRlRwdVIwREFVNlFtTzNBd24yRnU5aG9YKzNnSjdYcU8vcnR1?=
 =?utf-8?B?QVEyTksvQkR4NHpTakVqNDZLSTVCZHZwU2JSbVNVWFV0bGsvSFpYNTdLVXIx?=
 =?utf-8?B?eHVwTCtBVlJicHJUZHFKOENVZysyTFJZVHZYNzFycjhQUXZOYzVyRHVFQmxn?=
 =?utf-8?B?bEh3T0lkRnc2TTV0cEtGOWp2ZWJ3T3NlMFlmSk9UZXE2N1oxQ2Q0c1VEVmEz?=
 =?utf-8?B?ZDJUZ2dRWmFaSHgrdXVIc21hclZ5YWQxTzFCN2JlanBLdXI3OFNnRFljbWRU?=
 =?utf-8?B?Z1UyMEdYRWkvdWhNQVM0b2hqOG02WUNkOHRvMVlkTHNjaThhUkJRSU1QM09u?=
 =?utf-8?B?d0xVbEhrUmIvTE41ZThqckFsUm1neTRjb0RxYnUrUGszRlIwTjFtYTNpMGpy?=
 =?utf-8?B?OWJlT3lROXRrSzdtWDhQV0FuNnpiNjBueTBhQkFRc0Z2Mm9OM2UrRXg0Y2tW?=
 =?utf-8?B?Sm9Sa3R6S2tVQllUaUJQdGk1ZnFkOVRZY0xtWUhqYlBoV1VXSUoyL1B3eGlT?=
 =?utf-8?B?akV2QTBIenZVZUc1ZFhjc0xKdVNzV09BZWdlbndXZG1QSGgxR1c1ZFdxejFZ?=
 =?utf-8?B?MU5vUXRXdys5TCtXTThhT1ppeDlJM0dhTFAwZEdlTVAvMGtTOXRoM2JLU0dQ?=
 =?utf-8?B?a3ZENnRuaEJSQTAxWTcvSXpnZ0dkczZ6NXVLYjYxT3p4cDUyRmMzeFBxUGlM?=
 =?utf-8?B?TGNrSVNQdzQzeXlYOTE5dEJubkFlUGUvR1QzNHZMRlJFZlRBS1JRVXkxMWVG?=
 =?utf-8?B?cW05Z1hKRnRqVzlydEJuc012ZHd1blNGT0xJOHlWVnc3dllSVDVac0phZXBt?=
 =?utf-8?B?RUE0U212cjNmV0h0OWk3Zm1nNGJVNjJlRFV0NTkvYkFLN0YwaEtjNFdZb2FG?=
 =?utf-8?B?ZGM3TE1EdHhtSzB4MXcyRjBSVDNwNjkvOWVZQnlINE5PYW8zSjhHMGQwalc4?=
 =?utf-8?Q?OyRoIelSckerHmuJxza2agnk6791kCoz?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUJIK1c1bzZ6dVVOLzR2a3YwckVMdEc1REgwc2dETFBUa2NwRjh2M2UvV1F1?=
 =?utf-8?B?RlFqUzdhOXhUcmkvKzhvalFkY0pCa09BRGVPdnAyK1RyaTBxZ2c5Mkk3c0VX?=
 =?utf-8?B?R2dtWG0wT0pDK2JJQ0JKSG5VQTJiNWpDWTdudnQyTEcwL1M2bXhRMDlRaEJR?=
 =?utf-8?B?Ym9OcVpQM1gyQmYwbUc4V2ZtM21RNkwxblBvRDRZNU5HSEF6K0NrZDZTTlZl?=
 =?utf-8?B?a1RJOUlWUmcwY2QzT3F6RlBaU01vcVBXRU1iMlZFM1lRRXhZdU5ubXQzb0pL?=
 =?utf-8?B?aS92UEh4U0d1eXhKYWFaSkdJVmJaMVVKUUxYWnZMSjdIaHBoTzFvb3Vhczdq?=
 =?utf-8?B?R3VSeWVDQlBJN3A1NTdXd2pZR0xsVzVQMEIyODBYZEkycDNHV1gwWDFMZGFE?=
 =?utf-8?B?MWpPZmVHOGoyWjd2K2RPUjREL2JrSUY4ejl3TVFDbVBZbm1XTTdCTzZxRk9W?=
 =?utf-8?B?TkFXQWd1VDRFSlhDVE83ck8vd3d1RnFoWURWTFhRQjkxNjJzbTVVWEYvR0Jy?=
 =?utf-8?B?VVhDMVhxT3FLdVJMcmpjK2VveTYrUnZxekdYZW5Vck5GeUIyRlJLRk5NMTdR?=
 =?utf-8?B?MG9Sb21wcUpjb2N4Z1V4cG9keDFZQm9UaE5xVXdzVVRqWnJqK0cvY1B5MzRp?=
 =?utf-8?B?b29BZTRqVHNLeDR2WnRBSHRWblpaOEVxcHdhOEcxcXNKK21Eb3poRFNGenUy?=
 =?utf-8?B?bk11a1dqc28vY25lQTNvYWdNN1RmSDBhZTJwMmFXSmQwNXdPblhqSndVd1I1?=
 =?utf-8?B?aHNVSldFakFoRktJcTVaN2cvQnZWODZ5M3lkWlNXUWVNRXJVRnFXU1l5QVBJ?=
 =?utf-8?B?RW9HbEpaVFMwc3dTQnZyV21kTGVINDBCeEczc2VJc1l1MkNGS0RPMDNISXZE?=
 =?utf-8?B?cnpaWkxQSkRoUDFZZ2Y1b2lPRzE3c0ovTk1MalhCOFQzZFBWMVN5bHZyend4?=
 =?utf-8?B?WFZmSExlMGRYTWZLUVdxOGtjSHMzTXZHY09pU0N6Rk1TQ1I4UUVPY3N5WGdG?=
 =?utf-8?B?QVRSd0hoR2dQTEdQSHZrbCtOR3lKVi9LbEFPTkZZOHJMdkZITVBaYW1kb2dy?=
 =?utf-8?B?NkVGS1JRQmFyUEs5aTBocm1kMFk5ejRGU2xBdXhITW0wVTRDRmdJWEFGNkN2?=
 =?utf-8?B?TlIvZHhYTzQxbHBlUXhxQlVxWndSVm43anVMUEFHREpybzdhZnh3SXVob1Jz?=
 =?utf-8?B?bkVSckNvajcraUJXd3RYOHdyS0J1Tit5RC9qcHdzdlhWcUNzT203Y3hmdG9n?=
 =?utf-8?B?MmpiTGNsY0dWc0Y1UmFyekxETkltOVVUVWRVbjcxM21CVGRFMHZvT1hTSDY1?=
 =?utf-8?B?NVhRaitJTGc1ZHdwRERTSlRuWmF0ZnZmQ2VzZWdKemU4eEFVeXA0bDRDSXR0?=
 =?utf-8?B?UUFvSTlsZXBicWowNE5tNlJxeXNQbDdSQk8rQUdLcUs5Sjc0cXRKUnUvQUVo?=
 =?utf-8?B?WUlUU3d1RXgxTWpPZHdTbVFUL1VVclRGZ0RCSElLTTJKMVN2b2JRR3pDbTI3?=
 =?utf-8?B?MlRDSzQvMFZqQTNRemdVU1g3Tis0VENJUTJUZ0dLQ2JmWnQ4OThMdmpUaS9h?=
 =?utf-8?B?WUJmN293WVoveTh5OHFxNXEwTzIvOHA5cUFOWFBDTTBZSFdUV2tqOURqZUoy?=
 =?utf-8?B?clhMR3RvQW5pcXNjYVlKQm1PWmtGN3RsRkNDaHBUNlp2TWdmSnZFcm1ZZkRO?=
 =?utf-8?B?SjdxdTZwVmp1VE12a1VEOURPYUlmdkNmck5qbmRtbVhxVXFYbmFMZ3FmK3A0?=
 =?utf-8?B?eDJORzJac0VsMXppQkJoZUNZV2hMbGpkSVV0VnYrYXl4UFdGQW1LVU1CWEsx?=
 =?utf-8?B?SHhPajlrZm5nYWFidXVuRjZEM3hldWkrcWZTOUVGQzVUdUdGbVdHUTFZVm0r?=
 =?utf-8?B?cEc3VDRZNWdlUWhvWVpnN2xkNlpGVzJ5MkNRRDRRTGRxN1luL1ExeTVvYmhC?=
 =?utf-8?B?OVhCRWVIZTBYOGE4RDRaWmMwY0RFK3FQS1FqZGRKdU5TcHBrR0Z3UmJCNFJE?=
 =?utf-8?B?Ym5RTDhrTEFuL29ldm5aSGUvUGZnSk10S29pak5kVWxjWjFxNGc0Y3ZKZmlt?=
 =?utf-8?B?WS9iVG94NDB3SW5MUG5pUW5HK0FGQStZTllwK3dpc3h1c09QVExsSlJuYXZL?=
 =?utf-8?B?ZksvUmFKdG4yTWJQb1V0R2RrZGprS1J4dGRScHdzN0RXUDBtS0VOcFZjMkRF?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51787A4DE86D364FB7EB4C1D447FB39C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ed5fbb-6332-4f92-6901-08dd4ca895e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 03:35:10.8718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iIn+DEIGN6mkt0nxD6X+mZd4k/r5qI/K8jrA/nDTZY2zedKRclAiS459DQdRItFS7qMXWlzSS4CTBLzgM2VDSd/BZ3hRMqTw0Kxyoe24nWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7456

T24gVGh1LCAyMDI1LTAyLTEzIGF0IDE2OjM0ICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+IA0KPiANCj4gPiA+ID4gVGhvc2UgcmVnaXN0ZXJzIHdpdGggTXJ2bCogcHJlZml4
IHdlcmUgb3JpZ2luYWxseSBkZXNpZ25lZCBmb3INCj4gPiA+ID4gY29ubmVjdGlvbiB3aXRoIGNl
cnRhaW4gTWFydmVsbCBkZXZpY2VzLiBJdCdzIG91ciBEU1ANCj4gPiA+ID4gcGFyYW1ldGVycy4N
Cj4gPiA+IA0KPiA+ID4gV2lsbCB0aGlzIGNvZGUgd29yayB3aXRoIHJlYWwgTWFydmVsbCBkZXZp
Y2VzPyBJcyB0aGlzIFBIWQ0KPiA+ID4gYWN0dWFsbHkNCj4gPiA+IGxpY2Vuc2VkIGZyb20gTWFy
dmVsbD8NCj4gPiANCj4gPiA+IEZyb20gd2hhdCBJIHVuZGVyc3Rvb2QgdGhlIHR1bmluZyBvZiB0
aG9zZSBwYXJhbWV0ZXJzIGlzIHJlcXVpcmVkDQo+ID4gdG8gY29ubmVjdCB0byBhIE1hcnZlbGwg
UEhZIGxpbmsgcGFydG5lciBvbiB0aGUgb3RoZXIgZW5kLg0KPiANCj4gSWYgc28sIHRoZSBuYW1p
bmcgaXMgYmFkLiBJIGFzc3VtZSB5b3UgbmVlZCB0aGUgc2FtZSBzZXR0aW5ncyBmb3INCj4gTWlj
cm9jaGlwLCBBdGhlcm9zLCBCcm9hZGNvbSwgZXRjLiBUaGVzZSBzZXR0aW5ncyBqdXN0IHR1bmUg
dGhlDQo+IGhhcmR3YXJlIHRvIGJlIHN0YW5kYXJkcyBjb25mb3JtaW5nPw0KPiANCj4gwqDCoMKg
wqDCoMKgwqAgQW5kcmV3DQo+IA0KVGhpcyBwYXJ0IGlzIHByZXR0eSBvbGQgb2xkIG9sZCBkZXNp
Z24uIFNvbWUgY29tcGF0aWJpbGl0eSBpc3N1ZXMgd2VyZQ0KZmlyc3RseSBmb3VuZCBvbiBNYXJ2
ZWxsIGxpbmsgcGFydG5lcnMsIHNvIHRoZSByZWdpc3RlcnMgYXJlIG5hbWVkDQphY2NvcmRpbmds
eS4gQW5kIHllcywgbm93LCB0aG9zZSBLZi9LcCBzZXR0aW5ncyB3aWxsIGJlIHVzZWQgZm9yDQpj
b25uZWN0aW9uIHdpdGggb3RoZXIgbGluayBwYXJ0bmVycy4gSG93ZXZlciwgaWYgSSBjaGFuZ2Ug
dGhlIHJlZ2lzdGVyDQpuYW1lcywgaXQgdmlvbGF0ZXMgb3VyIGhhcmR3YXJlIHJlZ2lzdGVyIG1h
cCBhcHBsaWNhdGlvbiBub3RlLiBJZiB0aGlzDQpkb2VzIGJvdGhlciwgSSBjYW4gYWRkIHNvbWUg
Y29tbWVudHMgYmVmb3JlIHRoZXNlIG1hY3JvcyBsaWtlOg0KDQovKiBNcnZsKiBwcmVmaXggb25s
eSBtZWFucyB0aGF0IGluIHRoZSB2ZXJ5IGJlZ2lubmluZyB3ZSB0dW5lIHRoZQ0KICogcGFyYW1l
dGVycyB3aXRoIE1hcnZlbGwgbGluayBwYXJ0bmVycy4gVGhlc2Ugc2V0dGluZ3Mgd2lsbCBiZSB1
c2VkDQrCoCogZm9yIGFsbCBsaW5rIHBhcnRuZXJzIG5vdy4NCiAqLw0KDQpCUnMsDQpTa3kNCg==

