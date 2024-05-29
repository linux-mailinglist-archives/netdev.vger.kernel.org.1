Return-Path: <netdev+bounces-98870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7368D2BAD
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 06:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C175528657E
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 04:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC8015B13E;
	Wed, 29 May 2024 04:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UP9VJFSD";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Dm3pdL7i"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A76AB8;
	Wed, 29 May 2024 04:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716955920; cv=fail; b=mFgr+wr2LwK7hkPmV+eelTEhXHgrOzqFinD1k0fCl7kP2Bii1DmUMvLYT8SuiaqgY6GoXUrd6YTrO7KSplWpXZsf1tZtuW4tNHZn1Q0m/6Nc2FT1rimYUQdKj6wNZGqqyx9AWmxHEzk2FAoztDbSaPpqc8tjxsUmGwu941Nko18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716955920; c=relaxed/simple;
	bh=ytzfGbp6GyMCLo6fQogoB+XQZlTj3DL9xMOiDKAPX6o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NTxVpdT6gxLRveu2ir++NVArQV1FmjzeX6ZbZM0rloHNXEqxWuWTntDmRhhgJNEzEixq2jTE/ZamR2z1kJ/d/M/SmgXh4eDCoPoWRqKWTgYDvg4mA0E666sEc806IumF/jAp15XchzEzlLJsSo9s9+uX8NKU3p9tFvk0qTfMcP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UP9VJFSD; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Dm3pdL7i; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 92f6c8a61d7111ef8c37dd7afa272265-20240529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ytzfGbp6GyMCLo6fQogoB+XQZlTj3DL9xMOiDKAPX6o=;
	b=UP9VJFSDVQOra3u85NM/XDyHQ9EczXYxnJjRUTCk6G5uY0DqtEsAVt6AqzFzAtsG88Iftuoj+p0X+uPbmEwMaesyYxsj9R4U4x23V/sqapE15W1e+4ftoCjXmhwOiLdKV9yercESS2YEwOyM8G1wpbl0seaAuwsQn5emwJtU/hM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:4eb0f6e6-c663-45e5-92dd-2f54089221cb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:52e6f187-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 92f6c8a61d7111ef8c37dd7afa272265-20240529
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <bc-bocun.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1995053691; Wed, 29 May 2024 12:11:50 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 May 2024 12:11:49 +0800
Received: from SINPR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 May 2024 12:11:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCZ1fC3oqa1tZXs/P4QAE+6ERYcrFKdGdJUkxWGbVOWZ4+3ngEqfZNNVKmElaul/RlGyhSqQ5DWRsY++J+Uthvtnf6unjUMoLDGZSoFAhI5DRqIHtyJeSPZibgHJ4O1bpLK5ZnPl4Ew0Ez4zux56p9eiZ/Km+CWkZCsqhYmeJoSmk29K369IoMToTfzmFFtKludwMfgUgPyPDunOcIMJG4JC8OkMuXkmq3r2mmsl3/t0M2E3+QeZ4hxAa0w2JK6Unw4/PZ0Qpt4781SfXPUzCCqC827oGsK0xtt2f7Kdny7YDfvej9Te3cyKyIFbG+kDI6PPBC/M+eJIu9ZftpiZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytzfGbp6GyMCLo6fQogoB+XQZlTj3DL9xMOiDKAPX6o=;
 b=XAeJ/Xu/nVSXlfQy3jx29eqVNJcpuFFdb2icmpMS4wtq9y6At4QgvR7i+3VdopGFJm/yd9cSzpmeVujnEd0sNGhVX+behlW2Mui18ExM6el5v3gM6Y1VvdrD+jE2oFDTBylAf7DUFdfADbVl48VZnyYSLteRirBJtAadWXW/ia5SxN+wqZUX2MkRPyI3y5KY0c/5HlHZa0NQu08TnkDYHOTgDI4JwSZnOsjAybImH8El0AZQ2H9+RhlCsKEfdSMslNmwOp0MqlBevRFklN1d/doIx2L9EVi+PvHtIhrzMhj0GWABMj0tAPbSbq2G3n7X8mugBQOKQrMPH3EC74aBuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytzfGbp6GyMCLo6fQogoB+XQZlTj3DL9xMOiDKAPX6o=;
 b=Dm3pdL7icEgD0RinGPTOJ3t6Qx8zZu3H1DUvSEonT8Ju20QUm+Pl/J6tus3eAtjbufFjhN+SIxc1powtoYIOUK86p7MClBXLfMBgmMa/KmqohHHJywme/lUocqbEQOb/HCNU0D31Rdo8bvbUik5S9VM054DJwo6jAAT8TvraLDQ=
Received: from SEZPR03MB7219.apcprd03.prod.outlook.com (2603:1096:101:ef::15)
 by SEYPR03MB6698.apcprd03.prod.outlook.com (2603:1096:101:6b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 04:11:47 +0000
Received: from SEZPR03MB7219.apcprd03.prod.outlook.com
 ([fe80::6198:1b1c:c38e:fae4]) by SEZPR03MB7219.apcprd03.prod.outlook.com
 ([fe80::6198:1b1c:c38e:fae4%4]) with mapi id 15.20.7633.001; Wed, 29 May 2024
 04:11:46 +0000
From: =?utf-8?B?QmMtYm9jdW4gQ2hlbiAo6Zmz5p+P5p2RKQ==?=
	<bc-bocun.chen@mediatek.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>, "sgoutham@marvell.com"
	<sgoutham@marvell.com>
CC: =?utf-8?B?TWFyay1NQyBMZWUgKOadjuaYjuaYjCk=?= <Mark-MC.Lee@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>, =?utf-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?=
	<Sam.Shih@mediatek.com>, "linux@fw-web.de" <linux@fw-web.de>, "nbd@nbd.name"
	<nbd@nbd.name>, "john@phrozen.org" <john@phrozen.org>, "lorenzo@kernel.org"
	<lorenzo@kernel.org>, "frank-w@public-files.de" <frank-w@public-files.de>,
	Sean Wang <Sean.Wang@mediatek.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [net v2] net: ethernet: mtk_eth_soc: handle dma buffer size soc
 specific
Thread-Topic: [net v2] net: ethernet: mtk_eth_soc: handle dma buffer size soc
 specific
Thread-Index: AQHasXMYNi3xSZU3p0KmKIWq/uy+z7GtmbyA
Date: Wed, 29 May 2024 04:11:46 +0000
Message-ID: <395096cbf03b25122b710ba684fb305e32700bba.camel@mediatek.com>
References: <20240527142142.126796-1-linux@fw-web.de>
	 <BY3PR18MB4737D0ED774B14833353D202C6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
	 <kbzsne4rm4232w44ph3a3hbpgr3th4xvnxazdq3fblnbamrloo@uvs3jyftecma>
In-Reply-To: <kbzsne4rm4232w44ph3a3hbpgr3th4xvnxazdq3fblnbamrloo@uvs3jyftecma>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7219:EE_|SEYPR03MB6698:EE_
x-ms-office365-filtering-correlation-id: dfad1de2-64b1-406c-2efd-08dc7f9574c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?T01vYWZ5UHNDTEY2aVhNUzBpc1FHYWZEUmNHREUwOE5pY0Q5MDJUeWdiQlBk?=
 =?utf-8?B?KzJwaERXcmJXREFvVG4wTDBuNW5BWG54SjY1OWMxT1l3bXZDOXFRZXFyVzFR?=
 =?utf-8?B?SkZxY2F3eldpQ0tSQkR4UnJZbUhCdUpRT2ZwQjlhRUwwZHczNHpxUk0vZW9u?=
 =?utf-8?B?ejRLTXJzQzBQOU8yQWlNVDRQbUdqOWF3OXdRYWphZldndk5sck5qa0hJS3Ny?=
 =?utf-8?B?RXo1ZEFqN0YxOTFkWVBDaFJwbEJhOCt4cmluRkhmOXhhR3F4V3YxVy9VdmFD?=
 =?utf-8?B?cmRtSXpXQnlOdHBHRFhlQUsvTkMzdXNDRDBhRy9LQ3VrbWRWZGZ4V2ZLMStk?=
 =?utf-8?B?YkVGSjlBSWwvV2xucThiZUJMdS9Yb3hGWmxiSzZwRUYxRkxCUHdLUm1hY2RU?=
 =?utf-8?B?cE5yTHNuMEpWOTdSaXdhaGEzT21iYzNCYWI1dWgzSm0xUDgxTnBkaUNIS0NE?=
 =?utf-8?B?RTN1VTJNMVVyUHQ2dy9sMGdnZzgwVWN5RHp3Tmlsa3RZR0czOHh5RXRPZVJE?=
 =?utf-8?B?RjA1blBJZUpJYjZDVWd4d3BSTEFHeTNnZzcvSXJuajd0aWE3Z3c3REdlSUVL?=
 =?utf-8?B?QWZoZWFKR2VreFBoYlV1c0NTaExQa242VzFjam0rWmxkNEY0TUlTdFNLeGg0?=
 =?utf-8?B?MHpWektndFU1VFNPT1o4b0ZuMG9lUUR6cFVlTGhqYlRMMUVKcXgyZzBjbkNF?=
 =?utf-8?B?VWdZdzU4TDdmMzZrQzF0REpDbC9KWXkrV2xmdVhoWEdvVEVPSWMxd0VBOEdF?=
 =?utf-8?B?YVM3ZVFGbjk0aXV0RUxvcG0rYjRiK0lwQTRnWS9nM0YwbWFSa1BvS0prVFVw?=
 =?utf-8?B?U0V6TzlBLzFObVdISklUVW1oUTZkMHExclFiYVo5KzdpWktGUDI3M202SW0v?=
 =?utf-8?B?TGhORWUvRTAxcDZZd0s3bEtVNkxOc3FFNE9kRDBpNmltUExmemljZ3hBRlVI?=
 =?utf-8?B?dVNsL1VEUWVDMXZmOXRYWW5WSFVndFZyZlBOT2ZGTEkrUU1WZ2I3TTFyRkdo?=
 =?utf-8?B?YmZySTk1VWYwYVpUdnF4WHdONnE2ZlNwVVU1TXRwMnRKdk92Vm5SZXBLRDdT?=
 =?utf-8?B?ZXduU1VQVnMxaFlwM0JWR0RlNUpYQlVXUG1NK25aNGpkT0FrSW42SitQQVpZ?=
 =?utf-8?B?MkVBNU9qalhZdlpMYzJVbmlZaU9CNkRlTWJqOVhMTUY4ZUxlcmN0QWpmMG13?=
 =?utf-8?B?SCtaNUw2SU1HNitpVmtyYk5wZWN0a1p1bjdPWTd4Z01oSjJsOXlycStmSndK?=
 =?utf-8?B?ZGxyL0M2RWc4UFhkUHA1KzgvVithL2pvWkkzUkduT1krTmR3MTJnQXkvTjZU?=
 =?utf-8?B?R3BQeUJLU2lBank5Q0k5VWVIdnMvWitiV1lIbUhuWS8xeHJJMUxhbkNBeHJz?=
 =?utf-8?B?bDVuVitCVEhHUDI0ai9SSDFBRXRaWHgxL0t3UXhrT2VPNTZ0M1Rna2hSWnZM?=
 =?utf-8?B?UjFxSFhoNmdKVlNPZDZxYSszdGZEU1FIQi9qVXhUMkUwaU01T0FSQ0M5eGZo?=
 =?utf-8?B?WXNERzkxOHA0LzNuSkR3aFhJSzUzU0hvRmFNUWJLa1hlWlVTZW14N3E3WDNR?=
 =?utf-8?B?Rk5OSTlCU3VyU1JUaVlJRU9oZlpRVjE1WkFIaGVXRTVwUkpTc0lhclNzTWJ4?=
 =?utf-8?B?N3h6bEZyVDJLOGNZdEovVE10YjZXU1ZvQy9rT2xyblJzRkt4enR2VGZRUVF0?=
 =?utf-8?B?ZUI3K2ZNUjhSZ0ZML2VNK3FiVHVQODRmUVUvNW1ZLzA0a051RFBzei9nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7219.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YldRRzUwck5HZHNhQ1pvbGJTdkF1MXNqRWZUbUxUNWg4Vklwamk5OURWa1c2?=
 =?utf-8?B?M2RZZUFEcmgzY1JYSytIcFNtajdGZ01HY24yR1crcEZJYWsyYy9KYjhiTmlm?=
 =?utf-8?B?ZDNXZ2tKMlYyWTdUb2xXYlUycU5FQmNwdDBsWHZKcW5xb1ErbURQMzhsNVFC?=
 =?utf-8?B?V2ZnbCtPOE9IMTdjNFFBcEhsNGJja1FqSndzSkl5cUd6U1BNS21hYjNFTDlq?=
 =?utf-8?B?YS9NalRrczJNcG9vRDNWWVY1cWVLOTV0SHJXQk0yK3laM2UvbEJrTFRQbnR4?=
 =?utf-8?B?WFJjYzk1cFhnZmV2eDVJa0lRbEdEQWs2d1BWMmEraFc5VlNEZkRSZm03K2hB?=
 =?utf-8?B?a01nVTZqSmcxcW1WZUlrNUJzTFp1NXo1MHdFUU5sbU1nSXlzU3lDQ3lYTlNQ?=
 =?utf-8?B?VUw2Y0o5ZlhmMEE3bCtUeC82c29kTVZsMC9FLzdpVndOY2orblpwWWdzazRU?=
 =?utf-8?B?UkRPTlpFSTZYaXB1dHpMN3U0ekI0N2diMFBOV0I3dzhnZVN2VEJ4OHhBSHZJ?=
 =?utf-8?B?R3JIdjVBU3oxRlkvY0FPay9DcEM1MVdqOENzMjJDYTErK0hHQ1JVZ05zZDJq?=
 =?utf-8?B?U29HTjVvSkYwU0Q1T1lwbGVxTXlmd3lxbExtRU14VHU1QnhPbmZqZitxNld2?=
 =?utf-8?B?ZGpMVHdMRG00ckdMWEJ4Y256aEV1dzBFekwvbHYrWEQ2U01OVnlHWmhHaGp3?=
 =?utf-8?B?V0k1dTFxNU1pRDQxTFVBNUtzZ1JvUWpTdm9YRnVwOGczTHoyTnBNWXpyVHJK?=
 =?utf-8?B?UWhOOUtpOTR2RkFtaXRDQ09hcVJaaGY2WHU1aG5MaTN0SjU1SkYyQ3l6MW5n?=
 =?utf-8?B?aWdBVHpSS09rU0JsK1l1c1ZndXZGaEFzaWI4Y3hybnVzdUpoOWErNGJxL0Vx?=
 =?utf-8?B?TlYwcU05bzc1VzNHZ0dQSEV3SXFDbHFlRitJV1BscXQvbDNsTTdwYWRuSXNs?=
 =?utf-8?B?VTM0UG84SEszVkx2b0drUUNVSlJqTDVveHJiaDVPbjFSMkg4SGVyNk9lK05h?=
 =?utf-8?B?VFZ0a2kzOVpuRUE2MzVubHB1TVJUK0xoNXBrMFJDTXNnc3Via1ZYdFNwaG5m?=
 =?utf-8?B?VlpFZnJJQ1VCbWFSQWI2cnQ3MVplVHpaVHZmWWo5U0k3blBhMmpJVnJFWUxl?=
 =?utf-8?B?SFB4UUx3TDBtSm9BTExmK0QwbUZSTGZ1eEgvdE9MVjdmMGcvdktFMGwwc0RC?=
 =?utf-8?B?cHcweEFEdDVyNkRQV3N4TWZvWDJuTytxUUhmdHZtbEJUcUFlZHpDRnpBK2JD?=
 =?utf-8?B?NkM2NzdPMGF0TDJQS2MrYUJBNFoxNFp6RlhoWnFMcDZjeHlvQjBTemtGaGVL?=
 =?utf-8?B?c0d3THNNaEplZTVPUWMvVVBNS1lBbUtWZ2NuQjhCdnh2aEpuSHQxbzVLN3Bi?=
 =?utf-8?B?ZHViZ0dUWjBoazgreE1ac1Q3MFZsTEtIT0VOUGxvaE8wOVh6MEtXOTlwcVZv?=
 =?utf-8?B?c1FRek0yaFpycCt4SS83NXQ1Nm1EUlBNcHprUGVoV0sybXFLbXNpV1dnYjJJ?=
 =?utf-8?B?SDJXc0czQW1mSXlla3VQVHdjTldYb0N1QnRhRThnck02UE0xa3VaOUVHTXY2?=
 =?utf-8?B?OFk0eFJXa2dzNlNzOCtsLzNTU3EvTnIzTXM3T1RuOVp0RmRrbVNMN3pvVjVE?=
 =?utf-8?B?Y3FPZnRnZ2RZc3ZCRXFVZUtZSW5CZjRHYTM3RzljdWlkYWFlMnEwS3ozSldy?=
 =?utf-8?B?U1N1YlhLT29oRWRkdStSc1I0Vm5ZYWk0eExwanZwVzVJbUxaQXlrMHJhcnBP?=
 =?utf-8?B?ek9vRWhYQXBFb0FIcWQxQ2RHY1NXMDI0UzlPVGVJVm9sSmI1MDh6MkFybTZv?=
 =?utf-8?B?RkhnQUMxdGQxaUZ2a1E5U0xUWGozY3FkaE9FcWcyUU9weDErb3NkSDQwSDNz?=
 =?utf-8?B?UmNJNWt2emdkSFNpczJpZkd2VmZUYi9PaE5iMDlRU2t6NGJJNDFlK2l0SDhW?=
 =?utf-8?B?U2cxY2NGdktnTUZnWlN1TUdKRW10a2tLbE9BSUhYQTVRVUlYa3RlWkUyNmZs?=
 =?utf-8?B?dlRtQnhzNE4xdWVxMDRPL2hnSDY4dTRtdzZxc055dEFETFV3NzRnd0w1amlU?=
 =?utf-8?B?V0pvei9BNmhsSXhRWFBvUXk5MktBMVozWS9vdGtCaHpndHhoQlBYZmtnaGgz?=
 =?utf-8?B?Si9XTmdYRUpJbHI1Q3FSUE53ODBpU1lETFQrOTZwb3prSVhxTVFkRXg1TGsy?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D009D97FB6CD347A92DA62EFF100993@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7219.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfad1de2-64b1-406c-2efd-08dc7f9574c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 04:11:46.5273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LVJCEpuzsXT5yVSXSxzRUDzotIwHR9F5aCyjlakoOO9fOeqWP/nNslIZ94Q1VkIiGwiK/uJXzUnwyVOnFJklqib7ZHGc76K+pB4W2dLJJ0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6698
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--26.708100-8.000000
X-TMASE-MatchedRID: 2Ti2c92MxSzUL3YCMmnG4t7SWiiWSV/1jLOy13Cgb4+MbDv6XkOHDUBJ
	M/mYBBD+TWLw2jvbfpyzIWmpuaej2Ilvam4hFbRyGfRQPgZTkiooUVkB7ifJngCGaccd4ae9eth
	SXZTKhZQDz7AtxeLAyvaaEZAHJRde0H/zLeBgX29tzb3s8Aa1Zm73ma3jsPM2E+5bAfeaWur6WY
	1kIqgZYbWEf7jcZ0rRAbY5HH0TJqljAM4vu3dHIefHZObG8JsoZ/rAPfrtWC1+YesuCgkiXOSZX
	qpiw34HOoiim1NgVGtBGwXX3mH+mlR4DXnutEoP9Ib/6w+1lWS/yN2q8U674tJ7M1ozJhSCyPi6
	SSBr6hSOZeCFEeL54dI2P+WSbScQVJbgo5fZJ2tYzrSv7yqexgXXmzqmsIi7zhY2/o0jwSSraRW
	KBb9AMv6UxfLsKhz5giRLZTsVNVu7JfBr9Xl5CkKOU/UJTrz29wSy1hQSK6Fh7WbOnt2TB2U27l
	gHBvmca/HcwdaOSDu3wZiSi+ft0xIdodPaDBh9qbg9uWhLYLdr9+Kgn2XgeOdTjSOFC/vqo8WMk
	QWv6iUVR7DQWX/WkVlmYwhSwhAaC24oEZ6SpSkgbhiVsIMQKxZ5+8y352uC
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--26.708100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	F6238C8A5B3146CF97D7D2164EAF19760D1A3DCEA05622461176024537089AC22000:8

T24gTW9uLCAyMDI0LTA1LTI3IGF0IDE3OjEzICswMTAwLCBEYW5pZWwgR29sbGUgd3JvdGU6DQo+
ID4gT24gTW9uLCBNYXkgMjcsIDIwMjQgYXQgMDM6NTU6NTVQTSBHTVQsIFN1bmlsIEtvdnZ1cmkg
R291dGhhbQ0KPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gPiBGcm9tOiBGcmFuayBXdW5kZXJsaWNoIDxs
aW51eEBmdy13ZWIuZGU+DQo+ID4gPiA+ID4gPiBTZW50OiBNb25kYXksIE1heSAyNywgMjAyNCA3
OjUyIFBNDQo+ID4gPiA+ID4gPiBUbzogRmVsaXggRmlldGthdSA8bmJkQG5iZC5uYW1lPjsgU2Vh
biBXYW5nIDwNCj4gPiA+ID4gPiA+IHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+Ow0KPiA+ID4gPiA+
ID4gTWFyayBMZWUgPE1hcmstTUMuTGVlQG1lZGlhdGVrLmNvbT47IExvcmVuem8gQmlhbmNvbmkN
Cj4gPiA+ID4gPiA+IDxsb3JlbnpvQGtlcm5lbC5vcmc+OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVt
QGRhdmVtbG9mdC5uZXQ+DQo+ID4gPiA7IEVyaWMNCj4gPiA+ID4gPiA+IER1bWF6ZXQNCj4gPiA+
ID4gPiA+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVs
Lm9yZz47DQo+ID4gPiBQYW9sbw0KPiA+ID4gPiA+ID4gQWJlbmkNCj4gPiA+ID4gPiA+IDxwYWJl
bmlAcmVkaGF0LmNvbT47IE1hdHRoaWFzIEJydWdnZXIgPA0KPiA+ID4gbWF0dGhpYXMuYmdnQGdt
YWlsLmNvbT47DQo+ID4gPiA+ID4gPiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+ID4g
PiA+ID4gPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4gPiA+
ID4gPiBDYzogRnJhbmsgV3VuZGVybGljaCA8ZnJhbmstd0BwdWJsaWMtZmlsZXMuZGU+OyBKb2hu
DQo+ID4gPiBDcmlzcGluDQo+ID4gPiA+ID4gPiA8am9obkBwaHJvemVuLm9yZz47IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmc7IA0KPiA+ID4gPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4gPiA+ID4gPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgDQo+
ID4gPiA+ID4gPiBsaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gPiA+
ID4gRGFuaWVsIEdvbGxlIDxkYW5pZWxAbWFrcm90b3BpYS5vcmc+DQo+ID4gPiA+ID4gPiBTdWJq
ZWN0OiBbbmV0IHYyXSBuZXQ6IGV0aGVybmV0OiBtdGtfZXRoX3NvYzogaGFuZGxlIGRtYQ0KPiA+
ID4gYnVmZmVyDQo+ID4gPiA+ID4gPiBzaXplIHNvYyBzcGVjaWZpYw0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+IEZyb206IEZyYW5rIFd1bmRlcmxpY2ggPGZyYW5rLXdAcHVibGljLWZpbGVzLmRl
Pg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoZSBtYWlubGluZSBNVEsgZXRoZXJuZXQgZHJp
dmVyIHN1ZmZlcnMgbG9uZyB0aW1lIGZyb20NCj4gPiA+IHJhcmx5IGJ1dA0KPiA+ID4gPiA+ID4g
YW5ub3lpbmcgdHgNCj4gPiA+ID4gPiA+IHF1ZXVlIHRpbWVvdXRzLiBXZSB0aGluayB0aGF0IHRo
aXMgaXMgY2F1c2VkIGJ5IGZpeGVkIGRtYQ0KPiA+ID4gc2l6ZXMNCj4gPiA+ID4gPiA+IGhhcmRj
b2RlZCBmb3INCj4gPiA+ID4gPiA+IGFsbCBTb0NzLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
IFVzZSB0aGUgZG1hLXNpemUgaW1wbGVtZW50YXRpb24gZnJvbSBTREsgaW4gYSBwZXIgU29DDQo+
ID4gPiBtYW5uZXIuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gRml4ZXM6IDY1NmU3MDUyNDNm
ZCAoIm5ldC1uZXh0OiBtZWRpYXRlazogYWRkIHN1cHBvcnQgZm9yDQo+ID4gPiBNVDc2MjMNCj4g
PiA+ID4gPiA+IGV0aGVybmV0IikNCj4gPiA+ID4gPiA+IFN1Z2dlc3RlZC1ieTogRGFuaWVsIEdv
bGxlIDxkYW5pZWxAbWFrcm90b3BpYS5vcmc+DQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBG
cmFuayBXdW5kZXJsaWNoIDxmcmFuay13QHB1YmxpYy1maWxlcy5kZT4NCj4gPiANCj4gPiA+ID4N
Cj4gPiA+ID4gLi4uLi4uLi4uLi4uLi4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVkaWF0ZWsvbXRrX2V0aF9zb2MuYw0KPiA+ID4g
PiA+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWRpYXRlay9tdGtfZXRoX3NvYy5jDQo+ID4g
PiA+ID4gPiBpbmRleCBjYWU0NjI5MGE3YWUuLmYxZmYxYmU3MzkyNiAxMDA2NDQNCj4gPiA+ID4g
PiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lZGlhdGVrL210a19ldGhfc29jLmMNCj4g
PiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lZGlhdGVrL210a19ldGhfc29j
LmMNCj4gPiANCj4gPiA+ID4NCj4gPiA+ID4gLi4uLi4uLi4uLi4uLg0KPiA+ID4gPiA+ID4gQEAg
LTExNDIsNDAgKzExNDIsNDYgQEAgc3RhdGljIGludCBtdGtfaW5pdF9mcV9kbWEoc3RydWN0DQo+
ID4gPiBtdGtfZXRoDQo+ID4gPiA+ID4gPiAqZXRoKQ0KPiA+ID4gPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNudCAqIHNvYy0NCj4gPiA+ID4gPiA+ID50eC5kZXNjX3NpemUsDQo+
ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmV0aC0NCj4gPiA+ID4gPiA+
ID5waHlfc2NyYXRjaF9yaW5nLA0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEdGUF9LRVJORUwpOw0KPiA+IA0KPiA+ID4gPg0KPiA+ID4gPiAuLi4uLi4uLi4uLi4uLg0K
PiA+ID4gPiA+ID4gLSAgZm9yIChpID0gMDsgaSA8IGNudDsgaSsrKSB7DQo+ID4gPiA+ID4gPiAt
ICAgICAgZG1hX2FkZHJfdCBhZGRyID0gZG1hX2FkZHIgKyBpICogTVRLX1FETUFfUEFHRV9TSVpF
Ow0KPiA+ID4gPiA+ID4gLSAgICAgIHN0cnVjdCBtdGtfdHhfZG1hX3YyICp0eGQ7DQo+ID4gPiA+
ID4gPiArICAgICAgZG1hX2FkZHIgPSBkbWFfbWFwX3NpbmdsZShldGgtPmRtYV9kZXYsDQo+ID4g
PiA+ID4gPiArICAgICAgICAgICAgICAgICAgZXRoLT5zY3JhdGNoX2hlYWRbal0sIGxlbiAqDQo+
ID4gPiA+ID4gPiBNVEtfUURNQV9QQUdFX1NJWkUsDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAg
ICAgICAgRE1BX0ZST01fREVWSUNFKTsNCj4gPiA+ID4gPiA+DQo+ID4gDQo+ID4gPiA+DQo+ID4g
PiA+IEFzIHBlciBjb21taXQgbXNnLCB0aGUgZml4IGlzIGZvciB0cmFuc21pdCBxdWV1ZSB0aW1l
b3V0cy4NCj4gPiA+ID4gQnV0IHRoZSBETUEgYnVmZmVyIGNoYW5nZXMgc2VlbXMgZm9yIHJlY2Vp
dmUgcGt0cy4NCj4gPiA+ID4gQ2FuIHlvdSBwbGVhc2UgZWxhYm9yYXRlIHRoZSBjb25uZWN0aW9u
IGhlcmUuDQo+IA0KPiA+DQo+ID4gKkkgZ3Vlc3MqIHRoZSBtZW1vcnkgd2luZG93IHVzZWQgZm9y
IGJvdGgsIFRYIGFuZCBSWCBETUENCj4gZGVzY3JpcHRvcnMNCj4gPiBuZWVkcyB0byBiZSB3aXNl
bHkgc3BsaXQgdG8gbm90IHJpc2sgVFggcXVldWUgb3ZlcnJ1bnMsIGRlcGVuZGluZw0KPiBvbg0K
PiA+IHRoZQ0KPiA+IFNvQyBzcGVlZCBhbmQgd2l0aG91dCBodXJ0aW5nIFJYIHBlcmZvcm1hbmNl
Li4uDQo+ID4NCj4gPiBNYXliZSBzb21lb25lIGluc2lkZSBNZWRpYVRlayAoSSd2ZSBhZGRlZCB0
byBDYyBub3cpIGFuZCBtb3JlDQo+ID4gZmFtaWxpYXINCj4gPiB3aXRoIHRoZSBkZXNpZ24gY2Fu
IGVsYWJvcmF0ZSBpbiBtb3JlIGRldGFpbC4NCg0KV2UndmUgZW5jb3VudGVyZWQgYSB0cmFuc21p
dCBxdWV1ZSB0aW1lb3V0IGlzc3VlIG9uIHRoZSBNVDc5ODg4IGFuZA0KaGF2ZSBpZGVudGlmaWVk
IGl0IGFzIGJlaW5nIHJlbGF0ZWQgdG8gdGhlIFJTUyBmZWF0dXJlLg0KV2Ugc3VzcGVjdCB0aGlz
IHByb2JsZW0gYXJpc2VzIGZyb20gYSBsb3cgbGV2ZWwgb2YgZnJlZSBUWCBETUFEcywgdGhlDQpU
WCBSaW5nIGFsb21vc3QgZnVsbC4NClNpbmNlIFJTUyBpcyBlbmFibGVkLCB0aGVyZSBhcmUgNCBS
eCBSaW5ncywgd2l0aCBlYWNoIGNvbnRhaW5pbmcgMjA0OA0KRE1BRHMsIHRvdGFsaW5nIDgxOTIg
Zm9yIFJ4LiBJbiBjb250cmFzdCwgdGhlIFR4IFJpbmcgaGFzIG9ubHkgMjA0OA0KRE1BRHMuIFR4
IERNQURzIHdpbGwgYmUgY29uc3VtZWQgcmFwaWRseSBkdXJpbmcgYSAxMEcgTEFOIHRvIDEwRyBX
QU4NCmZvcndhcmRpbmcgdGVzdCwgc3Vic2VxdWVudGx5IGNhdXNpbmcgdGhlIHRyYW5zbWl0IHF1
ZXVlIHRvIHN0b3AuDQpUaGVyZWZvcmUsIHdlIHJlZHVjZWQgdGhlIG51bWJlciBvZiBSeCBETUFE
cyBmb3IgZWFjaCByaW5nIHRvIGJhbGFuY2UNCmJvdGggVHggYW5kIFJ4IERNQURzLCB3aGljaCBy
ZXNvbHZlcyB0aGlzIGlzc3VlLg0KIA0KPiA+DQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18NCj4gPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dA0KPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+IGh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0K

