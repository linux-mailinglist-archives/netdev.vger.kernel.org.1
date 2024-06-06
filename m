Return-Path: <netdev+bounces-101238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DA48FDCED
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43227284BF9
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315BC18EB8;
	Thu,  6 Jun 2024 02:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="brLWTwpo";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="SlwSyQJd"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285F5182BD;
	Thu,  6 Jun 2024 02:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717641822; cv=fail; b=jzwq1td7ubgPlhiREuYGhYKoELb2BamvX2IrvMFeDp5Hz6kATPM3SkvM3Sfgpb7D7WH/GQKx98hMMc/N201o6S2UZfjDJkcx3DhnXr+eVfbWKY4elU4Ifog4xOXtVBIl8ya11ct+eCaIqdxIL+YV/2wzNKi4smzPXdEuFPwoMNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717641822; c=relaxed/simple;
	bh=w71XxzZ8n+RV5EH2f4MiHH+PUt3nHQERj+NKwPgdO1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CS39rxqbfXJGkcHVb5LKy2KHyZyoJztvlMu4bKiAk5vOPUGqhW0OJ1cGt4IkrZhx+D9AtR/s9y34clNJL4i8Ebl/z8eClR5KW5wX6K5ljR2syC6A3+j+nyHt3slUSBergCv8IpAT6sUTT4l7Ov0riHQ/hMD4im+UAuCUXCX5uD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=brLWTwpo; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=SlwSyQJd; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 90eca42a23ae11efbace61486a71fe2b-20240606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=w71XxzZ8n+RV5EH2f4MiHH+PUt3nHQERj+NKwPgdO1A=;
	b=brLWTwpoz4Wk2RXPQkT+0TQVMSHH0sTzQ/697NKAk4uwlmTxnieoqpdwCBLAngXUt8Pl+W2NS+TQV+6mZ0MISBE7xTzeN9o+D8ZThHli5jelxrqmJzgI3pLRmIMBCdf1KbAl4k3XHzb+Ek/RTxBfSkJAArUkW/lZG25Gw2Y3Zzg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:a8607761-29be-4e5f-9e56-9ea305744394,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:eaedab93-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 90eca42a23ae11efbace61486a71fe2b-20240606
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <bc-bocun.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 600130954; Thu, 06 Jun 2024 10:43:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Jun 2024 10:43:33 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 6 Jun 2024 10:43:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXrjIaotVShx5uRRkbYT5NWLmWc7cgQY78u4D/yOlWIo9XkIh4Laqeu/T032GiD3zus8SQ/1GijtNwxO7v5tXlIEK+hPmWwDY7V9ssf1XUOMJVaoMJ9GmEAlYyQQxuLJ1vH3mSCn9vf4sJWSbTx5Y/wb+Q/5mTE8Q6yKZdjATnufS2Ikah7ojHh0QK2JcgXoNUycU4L0N04fD8+ALc1KGp6bBJRBemwsmX5Vc7xzfcONEdQx7d4HUd6L0G5pmqbbiXYBbe3G//3+e1VJiAGxvOxV7SBKKCptq5BDy0VoVqib0IWA1Qk+M/zcEfMIfYBcN/8cgfU5j/L9eczl5/KZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w71XxzZ8n+RV5EH2f4MiHH+PUt3nHQERj+NKwPgdO1A=;
 b=SWhbjrNTy8VXC/Y5wzlNJMeG3VYlOJ/+zcMhAHRO8Ptpxi+in9fjwj0ZJF2v61N2KMsk04QFccxFIaqsDrcs3aS+0rdOHp/Q6XiQ5NddjQvnO+fquxDcBNd4oHIBEH9p/2j1tbLp0gZRlrwln7wN/tODxRnkQbVDwKmjLiMESRAPwIkDaSsldGw0YiA1TDx7s2ZQfwCyXOxaPwNMzz9pXZ+itLkGtlnI9Clff72OuSFuq/5W/HwDdnshApFwnwohjU6OJqu6tpWuPWPEaXHAXfsgCMzDJW3fkp2TMiXbRboe2uUuXKdRS1RGN3Jo2E0h77g4j/6AjvZgFe0s097Upg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w71XxzZ8n+RV5EH2f4MiHH+PUt3nHQERj+NKwPgdO1A=;
 b=SlwSyQJdqA15HHohEFeUK0af9gVH++htoVSaJRkDO7/PVHLpuEBRbnvSPPrt/VdOy72Y1IwfugzH+Ynnqo9Qi3JpY70Mq5hdO2nlIrBzoGF9+oZxH6YKA/S3hwOdljbA7j/9aPNjeEK9wUmsN7OOaxLhDsZK/w6T9TDVa/kslZc=
Received: from SEZPR03MB7219.apcprd03.prod.outlook.com (2603:1096:101:ef::15)
 by SEYPR03MB7272.apcprd03.prod.outlook.com (2603:1096:101:88::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 02:43:31 +0000
Received: from SEZPR03MB7219.apcprd03.prod.outlook.com
 ([fe80::6198:1b1c:c38e:fae4]) by SEZPR03MB7219.apcprd03.prod.outlook.com
 ([fe80::6198:1b1c:c38e:fae4%4]) with mapi id 15.20.7656.012; Thu, 6 Jun 2024
 02:43:30 +0000
From: =?utf-8?B?QmMtYm9jdW4gQ2hlbiAo6Zmz5p+P5p2RKQ==?=
	<bc-bocun.chen@mediatek.com>
To: =?utf-8?B?TWFyay1NQyBMZWUgKOadjuaYjuaYjCk=?= <Mark-MC.Lee@mediatek.com>,
	"linux@fw-web.de" <linux@fw-web.de>, "nbd@nbd.name" <nbd@nbd.name>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>, "jacob.e.keller@intel.com"
	<jacob.e.keller@intel.com>, Sean Wang <Sean.Wang@mediatek.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "john@phrozen.org" <john@phrozen.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "frank-w@public-files.de"
	<frank-w@public-files.de>, "daniel@makrotopia.org" <daniel@makrotopia.org>
Subject: Re: [net v3] net: ethernet: mtk_eth_soc: handle dma buffer size soc
 specific
Thread-Topic: [net v3] net: ethernet: mtk_eth_soc: handle dma buffer size soc
 specific
Thread-Index: AQHatevbN56VeYptsUOq0Xe/fHeWnLG4MGyAgAHaWwA=
Date: Thu, 6 Jun 2024 02:43:30 +0000
Message-ID: <fae028b5aac5c22bda7dc7d1028d408551160a7c.camel@mediatek.com>
References: <20240603192505.217881-1-linux@fw-web.de>
	 <b2cb86f7-c16a-44d2-a7b9-eb379784ff83@intel.com>
In-Reply-To: <b2cb86f7-c16a-44d2-a7b9-eb379784ff83@intel.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7219:EE_|SEYPR03MB7272:EE_
x-ms-office365-filtering-correlation-id: c9a8781c-55c0-4de9-2c4e-08dc85d2734f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005|921011|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?a1ZWL1dCbjVQU25udjNvTHNjSjNQdHgxQ3JHaEZ1SEFzK0VQajZlTTcyZmpi?=
 =?utf-8?B?RlR1K1pCQnA2Um9QZ1FVSXVWVUhLRUJBKzNaT21qRGF6ajA1ZlNJaEtiWWJL?=
 =?utf-8?B?b1pHQnpaemQzTER4eHhvTUJxdkdwSCtvSGJTNGJhQnZDZGZyOHV6TWswOUN2?=
 =?utf-8?B?ODZHQUdmV0U3SW94K2l6bGxqZ0g4TW5STzFlTzVnbDg5NFNFRjRMMmRGdGhT?=
 =?utf-8?B?dUxlUi95VllWc2VyNTFNaEhKMFNmTGV3Qnd5bmIrU011SlFMTU0vRUlFcWQ3?=
 =?utf-8?B?QXNTd01tMEhBelA2cFF3T29hcUNDNWFrWWNJOEdUVlBXUjRDT1dUcTFPNldu?=
 =?utf-8?B?cFU3Ykk0VXk0WUlNMFhzZWk1SXBTY2JrMjR0ckV1NklVVnhzbkJQZE83VlJo?=
 =?utf-8?B?Z2dlMmUzU3J5YU9TY2MyTnNhNSt0UE9icjdzVHdRRTF2UUwzNW9oOE4zWmd4?=
 =?utf-8?B?OHhhSVh0VVRBRmtpVy94NVNGcGowRE1wbnNVcUt5UFFHUEd5dUxEcG10dml5?=
 =?utf-8?B?TXVzVzVnN3dtUFd4Q3NyQUJuTTZaVlN0d3NtU2p1MGpFd2xxVGVqbzVNQUJP?=
 =?utf-8?B?TGJJSlRXd0Q4SzlXZ2pBbXdHeUNneGFrVmRndDBQY1pZaE9Ja3FyWXkxRytU?=
 =?utf-8?B?M2YrZDV5WitXMkVvUEpvMDdiaThEbDhpbWVRZHN4M3AxU3g0RGUydVg4aWJD?=
 =?utf-8?B?SXJ2NG9MQ0RaczJhWjI2ZGRWME0rNnRLNFdCY0tGKzNPdjZvTk5ZcGZudFVr?=
 =?utf-8?B?b2Z0NkdDQUFEZ0Y2YTI2TGJoSEc5TzVmY3NpUGVRNlRvRm1sUEx2Uy9RUHZp?=
 =?utf-8?B?WXRWREFZWWl3eTZmVmxsNUxHci85S3ZqYmdCa3ByS083U0l2WmViMEE2akwr?=
 =?utf-8?B?L2NBWWhaWXhzdGNiN1A3VERoZ1dxYm8vUWlUQ0g4WCtEb1N3YTRteHh6TjUz?=
 =?utf-8?B?ZFBYVm1OaVdKR25PSlJ5Tjc3ak5WSTVpOUduMXJDcjVDeVErZXIzRE90SmhP?=
 =?utf-8?B?RGdVekpBaEZObGxRSWY4UEU1dDdQY0pQOVJXZlhpL1c5VTMyakxkeXdKRndH?=
 =?utf-8?B?NGYyUTVWQm5wZFF6WExIdXM3NEtBQ0tOOE9DdlJvbXpUTTFBNVVpckZFSloz?=
 =?utf-8?B?UDByQkxvUWxoMXV1N1pmZnlyK24vUTJvMnpSNkRSNmlCV3ZhMHRic2V5dlZZ?=
 =?utf-8?B?YU9XK2UwYi9ubXlnZWdFbkh5Y04xaWdDUFZqZFJKczRpSGpZNDRVbXd6c0hG?=
 =?utf-8?B?RUlLWFpVWE45VlFOWmNDWmZydDA4R09URVBPUlRrR28waTJtcDBySWwrZTA1?=
 =?utf-8?B?K2hScDhFRGVWQVMvSGt3M0kzeGs3WHlWWmJCQU8rajM1dnZnZmhaeUNMSzF2?=
 =?utf-8?B?L3lBV28yM3hQL3JFa1luVVhma0VCUDdzRnhkUS9waHdnK3MyOGhITzR2a2Nk?=
 =?utf-8?B?VVJBQzdtQTFzUTRPQ1Y2akRUQnZ2S3l0ZVZRZGJKOFdtWkFBZGFCS3dxdWVl?=
 =?utf-8?B?Ulcvc21WbnZzY3ZVQ2NrRjQzSWpkZzdvTlNtcWVqN3VDZnFCRmFSYUQyRU51?=
 =?utf-8?B?VjRaMURqYVdVMDh3S1FXOVFqM3d1WEw0Rkdsb0RLbjJhakZPc1RYNWFDTjh5?=
 =?utf-8?B?amMySXFKKys1UnBaTUUzRlhGYlVJZTBSOU1hOTdOTXdHdXcvNVZubU1JN2N3?=
 =?utf-8?B?T0taanJpRUJwVUl0dEQzYzJiR2ZGekUxbkRHVDNsVHA2UmE0YXJ2WGdhOUVZ?=
 =?utf-8?B?TzNnWm85c0tteEVXaHkwS0NDdUY3L0s3VGw4SEtBdzhWckUvOGtaN0hJTTQy?=
 =?utf-8?B?dmxGZ2E5SkFqd0R5L2xhaCsvYzNEd09OSVhCODZKK0xLUE51dDd6NlYxRVNa?=
 =?utf-8?Q?LLdavhR0wEPDe?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7219.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzVGRHlFQnQ4MExYcEpYZWJvL05OWFRWNjVjT29QUVlvUlJiaTh3NjRrS21L?=
 =?utf-8?B?dVN6czh2aUJPRkVSbHlVMWo1cXMyakkzL1AvTXZTdlV0dXg0TGUxaU91emhq?=
 =?utf-8?B?TUxCbk5TVjNEVHM2ODBveHg4Y3J6bmZrS1YrbWJGcFh1YU1qTDZjS2gxbEVG?=
 =?utf-8?B?RExYalJ0WU83M2pUc0JiYlpLaDFjOC9VbTQvNXYzeDZxTkxpeWpQVmt1TGRt?=
 =?utf-8?B?bXV2LzFJZ29BZVJ4R3hCMHdXQ1c3aDQxRWFQM05RR3lRbEQ4QVplZDFCOVda?=
 =?utf-8?B?NjNzMm5sNFlZdk1CaGcrRnBuZVdUd2RLZFBtN2pHTGtURE93bVlYU2E3N200?=
 =?utf-8?B?MDNFbyt5TC9UblorM1V0YWhkZ2V0TjBUL09RZ3ZsT1dGcWg2OGNtcmNPcjVC?=
 =?utf-8?B?bEVpMTY0SXpvSTNRY0VlYjZQZ3M5UHBCMjRUV0FkYVkvOHcwZExKemlONEF1?=
 =?utf-8?B?ODhzRUoybHlSSG9WdmhqRzcrUGtFelVNbUJ0WG51YU1jRFZwbDI1UmdLOU1G?=
 =?utf-8?B?T1Zia0tLdHVMblA2c1Y3UElSU0RxYVEyYWRqS3ZFRkUvSHFuQ2J3azlPNUts?=
 =?utf-8?B?QTM1Z0VleHhNVTNNTDhObGFzK1J1V01mSUZaMVc1UzV1QTYzcXVtR2o3bWNL?=
 =?utf-8?B?S3MwNjNqZUh5Z3NyNUxrcDR2NTExeXFKS0JzY3RQWlBpZ3FKTk12aGpPMXJz?=
 =?utf-8?B?SFo0NlpKY0E0cWdPMDVHUmdKMXFhRXkvUzFpR0hoSGxRdnFOTGlicllncXcv?=
 =?utf-8?B?TDNCekVBUUE5S3hyWWoyRFFLQzN6T1FRekUzY0RLVG1UMmZwdzZ0ek9KMkZz?=
 =?utf-8?B?cFViMmNmNUU0WTRLbzhUU1BkSlIxZldCYlBuaHFLVlVxeGZwV25uclZNZFND?=
 =?utf-8?B?eTZuNEhPQTZ1aEdhOHZQejRtbjkxdUI5RHhQR3VTSGJKZk8xSU9uZzNiYlFC?=
 =?utf-8?B?TC9ERzhVeEpQWDc5UjF5V3NlYkxwUnE4N1hVeUpRSFdmaU90S2ZzRmtTZldp?=
 =?utf-8?B?OFoyVWVIdzBvejR5alRmc2ZJLzFwdFIvVVdhWDczZFMvdy9ya3h2M0plZ0F1?=
 =?utf-8?B?QWxzczB5dG5oNStuUm14WGU1V0dSbDhDWmdyQjZQUDhZOXRFOFRoV2RydUFJ?=
 =?utf-8?B?akFNUlVza2p5b3dWY05LVUNTR1NVajdaYVdDb0NhN3BPdVBYTk9NNDFoWTZL?=
 =?utf-8?B?WjRpaVd3K1JEOVp3NGZFRGlLQS8xakdLQ21FUXU4ODJHOUZsRUEvOFNPVTY3?=
 =?utf-8?B?elFvSGpKeTEwMzdOYlh5NWwxVzgyS0VtWEloNjdlbVllMWFxVkxodXYzME8x?=
 =?utf-8?B?VmZQUThxRWJaTnRTYVlISnQ5MmVONWdUMElDdzJlclROV3gvR09Lbi81cXBX?=
 =?utf-8?B?bXBpbnNrZWcySU5OVEFwbXRyMVFIOWFQM3hURUVTanpkY1RWYWlsUHVzZFVI?=
 =?utf-8?B?eW5BeWY4bHV2dE1nc0JKaWh1SU9OOCtCczlVYjNDZWc1SVFkbGVDdVdpRnBa?=
 =?utf-8?B?aE9ta013WVZzMUM4UTA1SXlnWkJVRDFRMCs5cXhtT1FXbGhlVTFvcUQzeXU3?=
 =?utf-8?B?NkhsUWptSVgzeTBWZDE0TDdLRUF0Q3Q2SktUSlY2UmdScXpPcDdpakRhaXNq?=
 =?utf-8?B?dFptMHNaNWl0UERJRzNDdlk3MEFKdlVaVDVEc0RzZU04c0FXSEUzOVlpVHpn?=
 =?utf-8?B?KytmNUlCc3JEMlNWeXJxWjkzOVBDenJxeXBhZXhkK3ZVQWtqSXpMZWU2Rmhi?=
 =?utf-8?B?ZVhPVVN0dkxVcXRhTWl3MUlsSzRPSWpVSFJ1WDdnWm5XZm1wb1ArenZWR3Np?=
 =?utf-8?B?NkZDd3JaRXlSZVRRSlk0S0V0M2FHQXNPY2M1bDQyajdtL2lwdC90Z1E0R3h5?=
 =?utf-8?B?U0FLemxXUW9zMzVLUmdlSG9oWFhDeFhCSlV6K2plaGVmWmlUZ2lOSm1TaGxy?=
 =?utf-8?B?cldKREt4NzU2bW1kb3BJNm81S2MwcGtxUUV5NTFMR3BncUY1ZVVuS3VvUzZo?=
 =?utf-8?B?U09vc1ltVk9BNzN4cU9NUEpKY2pHYWN0MGFWbnpsa1QyelV4UzRZV2VMWDlZ?=
 =?utf-8?B?clliakNKbUFCRWo5MWt1aENNdDB6azlFU2orN2k2NzQxeGR4ZHZ2WnhocDRJ?=
 =?utf-8?B?alVUa1NMKzRET1BXQUxRWm8rdlQzK0RMdDJ4KzlPMkNNWFJLYTNwVTlnSmxG?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE354BBBAACB1A489C741ABB4617CBC2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7219.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a8781c-55c0-4de9-2c4e-08dc85d2734f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 02:43:30.3918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BzCtuXMTYQNrKtGPbKZOgQPKXm1zxBfyv3tG7L+uvBgNHJ/XWE//TM4F1Sa5FE1GwY2BJYm+nRgeg03wuPlsnw3KaWeNs/YiyPIBmcV2Tx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7272

T24gVHVlLCAyMDI0LTA2LTA0IGF0IDE1OjI1IC0wNzAwLCBKYWNvYiBLZWxsZXIgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgDQo+IA0KPiBPbiA2LzMvMjAyNCAxMjoyNSBQTSwgRnJhbmsgV3VuZGVy
bGljaCB3cm90ZToNCj4gPiBAQCAtMTE0Miw0MCArMTE0Miw0NiBAQCBzdGF0aWMgaW50IG10a19p
bml0X2ZxX2RtYShzdHJ1Y3QgbXRrX2V0aA0KPiAqZXRoKQ0KPiA+ICAgICAgICAgY250ICogc29j
LT50eC5kZXNjX3NpemUsDQo+ID4gICAgICAgICAmZXRoLT5waHlfc2NyYXRjaF9yaW5nLA0KPiA+
ICAgICAgICAgR0ZQX0tFUk5FTCk7DQo+ID4gKw0KPiA+ICBpZiAodW5saWtlbHkoIWV0aC0+c2Ny
YXRjaF9yaW5nKSkNCj4gPiAgcmV0dXJuIC1FTk9NRU07DQo+ID4gIA0KPiA+IC1ldGgtPnNjcmF0
Y2hfaGVhZCA9IGtjYWxsb2MoY250LCBNVEtfUURNQV9QQUdFX1NJWkUsIEdGUF9LRVJORUwpOw0K
PiA+IC1pZiAodW5saWtlbHkoIWV0aC0+c2NyYXRjaF9oZWFkKSkNCj4gPiAtcmV0dXJuIC1FTk9N
RU07DQo+ID4gK3BoeV9yaW5nX3RhaWwgPSBldGgtPnBoeV9zY3JhdGNoX3JpbmcgKyBzb2MtPnR4
LmRlc2Nfc2l6ZSAqIChjbnQgLQ0KPiAxKTsNCj4gPiAgDQo+ID4gLWRtYV9hZGRyID0gZG1hX21h
cF9zaW5nbGUoZXRoLT5kbWFfZGV2LA0KPiA+IC0gIGV0aC0+c2NyYXRjaF9oZWFkLCBjbnQgKiBN
VEtfUURNQV9QQUdFX1NJWkUsDQo+ID4gLSAgRE1BX0ZST01fREVWSUNFKTsNCj4gPiAtaWYgKHVu
bGlrZWx5KGRtYV9tYXBwaW5nX2Vycm9yKGV0aC0+ZG1hX2RldiwgZG1hX2FkZHIpKSkNCj4gPiAt
cmV0dXJuIC1FTk9NRU07DQo+ID4gK2ZvciAoaiA9IDA7IGogPCBESVZfUk9VTkRfVVAoc29jLT50
eC5mcV9kbWFfc2l6ZSwNCj4gTVRLX0ZRX0RNQV9MRU5HVEgpOyBqKyspIHsNCj4gPiArbGVuID0g
bWluX3QoaW50LCBjbnQgLSBqICogTVRLX0ZRX0RNQV9MRU5HVEgsIE1US19GUV9ETUFfTEVOR1RI
KTsNCj4gPiArZXRoLT5zY3JhdGNoX2hlYWRbal0gPSBrY2FsbG9jKGxlbiwgTVRLX1FETUFfUEFH
RV9TSVpFLA0KPiBHRlBfS0VSTkVMKTsNCj4gPiAgDQo+ID4gLXBoeV9yaW5nX3RhaWwgPSBldGgt
PnBoeV9zY3JhdGNoX3JpbmcgKyBzb2MtPnR4LmRlc2Nfc2l6ZSAqIChjbnQgLQ0KPiAxKTsNCj4g
PiAraWYgKHVubGlrZWx5KCFldGgtPnNjcmF0Y2hfaGVhZFtqXSkpDQo+ID4gK3JldHVybiAtRU5P
TUVNOw0KPiA+ICANCj4gPiAtZm9yIChpID0gMDsgaSA8IGNudDsgaSsrKSB7DQo+ID4gLWRtYV9h
ZGRyX3QgYWRkciA9IGRtYV9hZGRyICsgaSAqIE1US19RRE1BX1BBR0VfU0laRTsNCj4gPiAtc3Ry
dWN0IG10a190eF9kbWFfdjIgKnR4ZDsNCj4gPiArZG1hX2FkZHIgPSBkbWFfbWFwX3NpbmdsZShl
dGgtPmRtYV9kZXYsDQo+ID4gKyAgZXRoLT5zY3JhdGNoX2hlYWRbal0sIGxlbiAqIE1US19RRE1B
X1BBR0VfU0laRSwNCj4gPiArICBETUFfRlJPTV9ERVZJQ0UpOw0KPiA+ICANCj4gPiAtdHhkID0g
ZXRoLT5zY3JhdGNoX3JpbmcgKyBpICogc29jLT50eC5kZXNjX3NpemU7DQo+ID4gLXR4ZC0+dHhk
MSA9IGFkZHI7DQo+ID4gLWlmIChpIDwgY250IC0gMSkNCj4gPiAtdHhkLT50eGQyID0gZXRoLT5w
aHlfc2NyYXRjaF9yaW5nICsNCj4gPiAtICAgIChpICsgMSkgKiBzb2MtPnR4LmRlc2Nfc2l6ZTsN
Cj4gPiAraWYgKHVubGlrZWx5KGRtYV9tYXBwaW5nX2Vycm9yKGV0aC0+ZG1hX2RldiwgZG1hX2Fk
ZHIpKSkNCj4gPiArcmV0dXJuIC1FTk9NRU07DQo+ID4gIA0KPiA+IC10eGQtPnR4ZDMgPSBUWF9E
TUFfUExFTjAoTVRLX1FETUFfUEFHRV9TSVpFKTsNCj4gPiAtaWYgKE1US19IQVNfQ0FQUyhzb2Mt
PmNhcHMsIE1US18zNkJJVF9ETUEpKQ0KPiA+IC10eGQtPnR4ZDMgfD0gVFhfRE1BX1BSRVBfQURE
UjY0KGFkZHIpOw0KPiA+IC10eGQtPnR4ZDQgPSAwOw0KPiA+IC1pZiAobXRrX2lzX25ldHN5c192
Ml9vcl9ncmVhdGVyKGV0aCkpIHsNCj4gPiAtdHhkLT50eGQ1ID0gMDsNCj4gPiAtdHhkLT50eGQ2
ID0gMDsNCj4gPiAtdHhkLT50eGQ3ID0gMDsNCj4gPiAtdHhkLT50eGQ4ID0gMDsNCj4gPiArZm9y
IChpID0gMDsgaSA8IGNudDsgaSsrKSB7DQo+ID4gK3N0cnVjdCBtdGtfdHhfZG1hX3YyICp0eGQ7
DQo+ID4gKw0KPiA+ICt0eGQgPSBldGgtPnNjcmF0Y2hfcmluZyArIChqICogTVRLX0ZRX0RNQV9M
RU5HVEggKyBpKSAqIHNvYy0NCj4gPnR4LmRlc2Nfc2l6ZTsNCj4gPiArdHhkLT50eGQxID0gZG1h
X2FkZHIgKyBpICogTVRLX1FETUFfUEFHRV9TSVpFOw0KPiA+ICtpZiAoaiAqIE1US19GUV9ETUFf
TEVOR1RIICsgaSA8IGNudCkNCj4gPiArdHhkLT50eGQyID0gZXRoLT5waHlfc2NyYXRjaF9yaW5n
ICsNCj4gPiArICAgIChqICogTVRLX0ZRX0RNQV9MRU5HVEggKyBpICsgMSkgKiBzb2MtPnR4LmRl
c2Nfc2l6ZTsNCj4gPiArDQo+ID4gK3R4ZC0+dHhkMyA9IFRYX0RNQV9QTEVOMChNVEtfUURNQV9Q
QUdFX1NJWkUpOw0KPiA+ICtpZiAoTVRLX0hBU19DQVBTKHNvYy0+Y2FwcywgTVRLXzM2QklUX0RN
QSkpDQo+ID4gK3R4ZC0+dHhkMyB8PSBUWF9ETUFfUFJFUF9BRERSNjQoZG1hX2FkZHIgKyBpICoN
Cj4gTVRLX1FETUFfUEFHRV9TSVpFKTsNCj4gPiArDQo+ID4gK3R4ZC0+dHhkNCA9IDA7DQo+ID4g
K2lmIChtdGtfaXNfbmV0c3lzX3YyX29yX2dyZWF0ZXIoZXRoKSkgew0KPiA+ICt0eGQtPnR4ZDUg
PSAwOw0KPiA+ICt0eGQtPnR4ZDYgPSAwOw0KPiA+ICt0eGQtPnR4ZDcgPSAwOw0KPiA+ICt0eGQt
PnR4ZDggPSAwOw0KPiA+ICt9DQo+IA0KPiBUaGlzIGJsb2NrIG9mIGNoYW5nZSB3YXMgYSBiaXQg
aGFyZCB0byB1bmRlcnN0YW5kIHdoYXQgd2FzIGdvaW5nIG9uLA0KPiBidXQNCj4gSSB0aGluayBJ
IGdldCB0aGUgcmVzdWx0IGlzIHRoYXQgeW91IGVuZCB1cCBhbGxvY2F0aW5nIGRpZmZlcmVudCBz
ZXQNCj4gb2YNCj4gc2NyYXRjaF9oZWFkIHBlciBzaXplIHZzIHRoZSBvcmlnaW5hbCBvbmx5IGhh
dmluZyBvbmUgc2NyYXRjaF9oZWFkDQo+IHBlcg0KPiBkZXZpY2U/DQo+IA0KPiBQZXJoYXBzIHlv
dSBjYW4gZXhwbGFpbiwgYnV0IHdlJ3JlIG5vdyBhbGxvY2F0aW5nIGEgYnVuY2ggb2YNCj4gZGlm
ZmVyZW50DQo+IHNjcmF0Y2hfaGVhZCBwb2ludGVycy4uIEhvd2V2ZXIsIGluIHRoZSBwYXRjaCwg
dGhlIG9ubHkgcGxhY2VzIHRoYXQNCj4gd2UNCj4gbW9kaWZ5IHNjcmF0Y2hfaGVhZCBhcHBlYXIg
dG8gYmUgdGhlIGFsbG9jYXRpb24gcGF0aCBhbmQgdGhlIGZyZWUNCj4gcGF0aC4uDQo+IGJ1dCBJ
IGNhbid0IHNlZW0gdG8gdW5kZXJzdGFuZCBob3cgdGhhdCB3b3VsZCBpbXBhY3QgdGhlIHVzZXJz
IG9mDQo+IHNjcmF0Y2ggaGVhZD8gSSBndWVzcyBpdCBjaGFuZ2VzIHRoZSBkbWFfYWRkciB3aGlj
aCB0aGVuIGNoYW5nZXMgdGhlDQo+IHR4ZA0KPiB2YWx1ZXMgd2UgcHJvZ3JhbT8NCg0KSW4gb3Vy
IGhhcmR3YXJlIGRlc2lnbiwgd2UgbmVlZCB0byBhbGxvY2F0ZSBhIGxhcmdlIG51bWJlciBvZiBm
cV9kbWENCmJ1ZmZlcnMgZm9yIGJ1ZmZlcmluZyBpbiB0aGUgaGFyZHdhcmUtYWNjZWxlcmF0ZWQg
cGF0aC4gRWFjaCBmcV9kbWENCmJ1ZmZlciByZXF1aXJlcyAyMDQ4IGJ5dGVzIG9mIG1lbW9yeSBm
cm9tIHRoZSBrZXJuZWwuIEhvd2V2ZXIsIHRoZQ0KZHJpdmVyIGNhbiBvbmx5IHJlcXVlc3QgdXAg
dG8gNCBNQiBvZiBjb250aWd1b3VzIG1lbW9yeSBhdCBhIHRpbWUgaWYgd2UNCmRvIG5vdCB3YW50
IHRvIHJlcXVlc3QgYSBsYXJnZSBjb250aWd1b3VzIG1lbW9yeSBmcm9tIHRoZSBDTUENCmFsbG9j
YXRvci4gVGhlcmVmb3JlLCBpbiB0aGUgcHJldmlvdXMgZHJpdmVyIGNvZGUsIHdlIGNvdWxkIG9u
bHkNCmFsbG9jYXRlIDIwNDggZnFfZG1hIGJ1ZmZlcnMgKDIwNDggKiAyMDQ4IGJ5dGVzID0gNCBN
QikuDQogDQpXaXRoIHRoZSBNVDc5ODgsIHRoZSBFdGhlcm5ldCBiYW5kd2lkdGggaGFzIGluY3Jl
YXNlZCB0byAyKjEwIEdicHMsDQp3aGljaCBtZWFucyB3ZSBuZWVkIHRvIGFsbG9jYXRlIG1vcmUg
ZnFfZG1hIGJ1ZmZlcnMgKGluY3JlYXNlZCB0byA0MDk2KQ0KdG8gaGFuZGxlIHRoZSBidWZmZXJp
bmcuIENvbnNlcXVlbnRseSwgd2UgbmVlZCB0byBtb2RpZnkgdGhlIGRyaXZlcg0KY29kZSB0byBh
bGxvY2F0ZSBtdWx0aXBsZSBjb250aWd1b3VzIG1lbW9yeSBhbmQgYXNzaWduIHRoZW0gaW50byB0
aGUNCmZxX2RtYSByaW5nLg0KDQo+IE9rLg0KPiANCj4gSSBzb3J0IG9mIHVuZGVyc3RhbmQgd2hh
dHMgZ29pbmcgb24gaGVyZSwgYnV0IGl0IHdhcyBhIGZhaXIgYml0IHRvDQo+IGZ1bGx5DQo+IGdy
b2sgdGhpcyBmbG93Lg0KPiANCj4gT3ZlcmFsbCwgSSdtIG5vIGV4cGVydCBvbiB0aGUgcGFydCBv
ciBETUEgaGVyZSwgYnV0Og0KPiANCj4gUmV2aWV3ZWQtYnk6IEphY29iIEtlbGxlciA8amFjb2Iu
ZS5rZWxsZXJAaW50ZWwuY29tPg0K

