Return-Path: <netdev+bounces-274390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK9aBJcOzmmnkgYAu9opvQ
	(envelope-from <netdev+bounces-274390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:37:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8763848B6
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 999B7309C3CF
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 06:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEA431D39A;
	Thu,  2 Apr 2026 06:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="vArZpz09";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="cqr3Mykq"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9B93019BA;
	Thu,  2 Apr 2026 06:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111440; cv=fail; b=jE1Y9E1H2rr7rHmWTq6+44qZAHjo+aSn8NOXpEkoqdyGh96ZTSVU0M0lxHT8Gf4Af20kkZD1+JFt+cqqcoU2Ca2JkaGNcrj4GXkx9gHty0Cu3CC6O5/4W1M7RobA4ZEz0l1szAmDS9ayPkpgT2ZE7zyG+5I0IRpg7GKXnv/ixeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111440; c=relaxed/simple;
	bh=j4B9WAC4nWbWRSZTlEA8bW+raD/sxOPjjbVIwUusSQg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rElcMceILjEqHGwcg9/vv3Lpk7qIhQZ6RCiBcr23QtVNcrhSRhpKU9P1h9OkxITA30x3j8FaeqWYuhuWzsaBZbNQnEqLLPRhzl0P9KgLoC6NHuPFIOoxlLoMOrXuT7dU1yaMo7k7iU1YKF0Wo+a1LM3IusIALnYvJCS/UhAWonA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=vArZpz09; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=cqr3Mykq; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 701d42a22e5d11f19a16598d5ca7f8ec-20260402
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=j4B9WAC4nWbWRSZTlEA8bW+raD/sxOPjjbVIwUusSQg=;
	b=vArZpz09heNDMpbbDRtubQCZZ6RApnol1biNQ8ViQYG81gYnHvOrDsmL3TvnzPaIwiaB0ZJYa/2v7jCpartzs3Z2P6nDMZshj+6JsDIrnFXM/EvABU5qXyqv2HaVfpTV3jK7+jp5i0D58Q7ygPkcKlK1Jc0apo3hK5rW7p2YWXc=;
X-CID-CACHE: Type:Local,Time:202604021430+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1e32e728-774a-4be3-a2fd-dd5959386ec0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:8c7bfb8e-6df4-4a3d-a7a4-fbdc42d669ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
	l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 701d42a22e5d11f19a16598d5ca7f8ec-20260402
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 11603281; Thu, 02 Apr 2026 14:30:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 2 Apr 2026 14:30:20 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 2 Apr 2026 14:30:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4g4rEw/JPZAEqkNImKGiZsvfqd7Oe7FqrLPCeVZvsOVB4sivTEXkHh+GqPZjIRAQR06n3sIuEeZn9uL1LctqaIfRhGiSkG2HfdxauMGrQxdP3USbEOjGE0YvFr6tZPpbOHOd9pVBTFp09d542Gw5e9lqvtsR3j673hi7AHvK2nHcLyrkjJDcC9QuPO2EkX1VJfEo9COa4+x7x/vsMhmPP7BwptExXQUH4XhCLCs3JazH132k+6Yi3LA5lDEv+if4uNUeiOHr4pgxVNFfHvRYOl+UBbwWtbTGNLajlaMij9pZ0i0KzKN8pz3RA1z6GMgjN1h9hdZIPpoTG4K9lwzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4B9WAC4nWbWRSZTlEA8bW+raD/sxOPjjbVIwUusSQg=;
 b=bT5k1BcB65yrfxE1NQTGjkFv2K3wfa6Oei0eFLDhOqUweeGCjhiLHPqIN2CFY9Sco2MS5M/FKWHnN7zrodEuYMUnBG7FxL9syywZJc728r8AAqV6ax7sQmlqBv9cizua6QBYeBEi6b5DfBnjcbLuqeKz6k3yWr1K4NQi7YubvRkw6vdKxeYitncZ9UJv4kuYOPI0NOHNJ1ABgsgMH5gdODBOsHTx9SoMxiPzFju1WSVbKc5a2+j7METn2uFTQvv50mln8c/4YtwPLZasu6AuEmw4rbtR9u2aY6n5F09LwQ5LDAErX/rT37pAhB1eqM1xuKBZ8PwUhsl2HpENcTm75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4B9WAC4nWbWRSZTlEA8bW+raD/sxOPjjbVIwUusSQg=;
 b=cqr3MykqB567in7hAOhvJdSXaX9eCQdo4HNdPGT2/EFbG7RLRtUwG/wGqjAE2Lb0SLdINOElWRJ3IRGw245lRT3sq+a7ftWnp7o0C5KW8KC+upmwpAAVZTye9iH9aWM0EDR6hF43+YgZUhMi5PyPaq2Ro10l7sUTssGloz2pi9I=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEZPR03MB8357.apcprd03.prod.outlook.com (2603:1096:101:199::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 2 Apr
 2026 06:30:15 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1fe4:fb59:1b1:1646]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1fe4:fb59:1b1:1646%6]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 06:30:15 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "sboyd@kernel.org" <sboyd@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, Laura Nao <laura.nao@collabora.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "richardcochran@gmail.com" <richardcochran@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: =?utf-8?B?R3VhbmdqaWUgU29uZyAo5a6L5YWJ5p2wKQ==?=
	<Guangjie.Song@mediatek.com>, "kernel@collabora.com" <kernel@collabora.com>,
	=?utf-8?B?U2lyaXVzIFdhbmcgKOeOi+eak+aYsSk=?= <Sirius.Wang@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	=?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?= <Paul-pl.Chen@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Nicolas Prado
	<nfraprado@collabora.com>, =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?=
	<Singo.Chang@mediatek.com>, "wenst@chromium.org" <wenst@chromium.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: Re: [PATCH v5 23/27] clk: mediatek: Add MT8196 disp-ao clock support
Thread-Topic: [PATCH v5 23/27] clk: mediatek: Add MT8196 disp-ao clock support
Thread-Index: AQHcGNelXPSfqVm58E66r9ASuZOvZbXMoqQA
Date: Thu, 2 Apr 2026 06:30:14 +0000
Message-ID: <2d418383ff2d6ff40ffb3b4f8e2b0c0e665c3b58.camel@mediatek.com>
References: <20250829091913.131528-1-laura.nao@collabora.com>
	 <20250829091913.131528-24-laura.nao@collabora.com>
In-Reply-To: <20250829091913.131528-24-laura.nao@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEZPR03MB8357:EE_
x-ms-office365-filtering-correlation-id: dad3cc44-7977-4940-5ec1-08de90814d00
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: HYdzAOIOh4Dlcqd7JAbiz5POJM6U526vM9vq65xrzcMZAUjJBACx+aVImD8FQ+nnY7i2RNCUtGS4xNCu/VRATk+UQvtmtRF6ZrLDHjf8sZkHPdEqa0ZKRyR9yBSpfB/0ZpWu0H0E2ToVro16fxQC/zTy1Ncic+wAQMBf5HnpBaoPAo8K9RENd7GAj4AanNhqDCWOGTBr0V6ajkbGkZ9sLNVdg06p++6tE5GoftQ8hnsHqpDH78XjCao7cpXasQg61uScM+T2n7qdL9YC+UGQL+bL6tX8az4veCEqtGBLwVXTD3w+A5sWggIrdVmO/vVL5JC5wxmbM3GEMIwNusZNA38Ur4MBqJ3cnIEiAfMey+216n+e3GEFJmrNOrikNGhffYzdGkK4OeccJqg9vqCJXDoLAWKLOtUotfxCTUM6UVOXm40/ujoyCuAJlcPoSmtZpIbmxXD4GMDDm54QkCJzW8zgcibIIgokpU73Jxgw73qlSKWmK+ViKG6CbpvTYq/bt3KrEAuX9RKkMzB3ePnT0grOYkVkLOuCE/1SgzOkZR6ffu6IankZFdk+auqFfYCIcr3Z8LY/+6XW8pcYTzUJgd9BwDBQswtdn6lLh5YUizo+TQlosIvBG9fMZMExr1zkXbm6w+pLQbWNIew9qmJPbigr/FkMA6Aev5cDSlCg7Qgk5V2ZkdLijDemx26qkLNjULJuh9PokPrYUBVk00W3ZZSh0bMF3XEMaN1zhWsrdkYbwCJkiyIQYx/7D7z3ToxMtsCVA27figCtjM9QEeaLr6Sj+yDLby5VXPBgjZ1tBCcsEpoKnU/w33wl7oa8Cvpo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WURHWUdDVUJXU2ZoT1ZjL1JEQXMyMEtubVdTS2ZKMm5YelNjTDA0MWdCM2sw?=
 =?utf-8?B?MUNha1pzdWlsUTRpVTZQM0tGcndxZVo5elVWdHlzL0FpN1J5alZwZWlaZytn?=
 =?utf-8?B?ZWU4ZHl0ZXN5YXNZVWEvajJLamhTdVRpWm1IeGFxWmtZWE1sQVJ2d2s0VDZO?=
 =?utf-8?B?SDgzT2lBUFZqWjVCRzUrTGoyQis0VDJPM1BsVW1hMk9XRGVQYTlKNWsyK21s?=
 =?utf-8?B?YmJKa0Z5emM3Q05QSkRVYmhFUkpPMkloaUhlS1VuZURZdHVrVmtkc3dVY2tW?=
 =?utf-8?B?NUV6b1hFaTlHdVlUNEtObXh0TzcyNHJVZy9Cc3pjVVQ1bW5TKzF3aC9IUXkw?=
 =?utf-8?B?KzNJSVUxc0tGOUxsZmtudFhWU2I3ajEvNVdCTVpGNEczWjFBSXZ5QnV1SjlQ?=
 =?utf-8?B?ZkVObWxxWTU4S1g5R3RVYlhCZE41czJ5NUZGbTZ4dFdocDlpMnpzbksycDdz?=
 =?utf-8?B?MjZENUpEV3VlSHhNWnF4SFRhcWZieEpTN0xpSTBqa1ZjM2lqeGJ3Myt6eUlK?=
 =?utf-8?B?NmpPSVhleGJWOStzVy9CTER6cHByTkcvTEY0M1dPMHpCSXlGb0N2Z2JJSHRi?=
 =?utf-8?B?U2xMbFBkNHVtaVNqUkJDdVc4WGloRnBaaDZjY3dsY0dKa1BsUE9yeW1TbWRS?=
 =?utf-8?B?YTVkOXRkZEFQY3pjbHQxQy9xL1oyRnRGMUhud21tdHRlRithdmJGSkNWZ1pJ?=
 =?utf-8?B?anI1aElxM1R3alB6OEdIUXdWbHp4RHUxcWFWZ2xRWkx2MGpWem10N2MxUndv?=
 =?utf-8?B?c0wyQStQdHdqRHdmUElScDkxS0UyQVo3K3BSd01GS2cyd29EdnN4WXJId3h0?=
 =?utf-8?B?aXlpMEFVQ3J0RXVoWUg2b04yODFOcThwMGd2QkRBbXpmalkwZStvODVWeVcy?=
 =?utf-8?B?a2EwK0l5MFNCV3RpMHFCNDBGYmdEbEF5enlpZTdkZ2xid3hnd25JM0QrN3U1?=
 =?utf-8?B?RFA0SVFlWXo4VllNZUFJbUhlSEx1ejhzaHBENTl6MEVxODl2TWErQW9HS001?=
 =?utf-8?B?OW5oQjNtdUJKUlA5bjMyZS90c2xwZ3ZpNUdUWE9ycGJ4WUZjQ1hYdXYwWkJL?=
 =?utf-8?B?K2NCRThtTit6eVNrVDUyRGt2SnF1VTNXeXlRKzFJTXVWV3pEaC9RWGN1aUtX?=
 =?utf-8?B?ejZaZXIzUzRIWUNudnpJUzg5WklUZ2VqTmljWFI0UVlWaE5vRmtvcXpBa2tV?=
 =?utf-8?B?V1pkVFZKbkllOXB1Q2xtQkEwNDNaTTN1M0M5dHBXcndLcEFPR1VOOGxOQ3dU?=
 =?utf-8?B?SVk3UTFzaytEbXJvSGE1RXRwOHB0VzFWS3lhbHk2dkhUUkFmTStGZlJpbDEz?=
 =?utf-8?B?dXBnQ2dYQ2l2Z0d3NWJOUUdEUkNDYXdJRlljRUFHLzZpUXJDSWw2K3VqbG9E?=
 =?utf-8?B?bjRISVBoc2E3K081Mzd2UGRCNTNRZWxCbUNpU2FEaTN6YldsdnBjdTNtUDdl?=
 =?utf-8?B?WnZCZjl1cXI0TGNQaHU2NGhMRUduVFBNU0hDbFNuZjBNa0RhYVpZQUZKZ0Y2?=
 =?utf-8?B?ajE0emVoS1ozZW5EQjhjZVNZMW9IY01talB5YWpMMmphVXFLZ0NnVDE0RDcv?=
 =?utf-8?B?eElYTnhrL3ZZRXhndXRDMXM5OEMxaVFRMVJLOHlzck13RzRyZnhIU1pVSlVu?=
 =?utf-8?B?Rm1tUDBYVEhMb09Ka0duUDkrcmNER0M2OVVSaTZZbnRqTkNOZUdYTW9zTDRq?=
 =?utf-8?B?TjRjZ1QyUHMwbW5PcStZbHkrU1JOWEFENzdITVQrblRtVkEzcklCUWFjVkJF?=
 =?utf-8?B?VDczSlBBZmswYmNudmNyU2dIOFQ2R2kvR2x2SHN5eXBHN1dZcWRvcFVnUzRq?=
 =?utf-8?B?ODFLL0l0SmpWYjZkWkVMbHliSVZBTVFtTTJ4UUpYV1U0YlNKTEJwWHc2Z0t3?=
 =?utf-8?B?MzhEOVdhMWpBSDRsU1RIMlpOL0huZFVIWW5KT1ZDbk9OWU5vSS9HaHlmYzRE?=
 =?utf-8?B?aSs4N1NxQ2ROQTBIMUZFYkZMTkRKdE9hRE42YVRhV1orTmJWdXZWN3krTWsv?=
 =?utf-8?B?ZlBmZ29JWFZHNmZ2dEtPdXFSVDJoWTNweUpFMXNlbGgxdjUxTE5SS3pzR25x?=
 =?utf-8?B?Y2FEMlUrSXJBSGV1UFlySnRFbVROQSszVzBlNVZoeXNlUzJ6aTQ5R3J4dnVV?=
 =?utf-8?B?bTkrUU5tNjExbHdWL3BvQzdnTWlXankrRkdDMVZ1NVNqMlpQSmNhQmtoM0Fs?=
 =?utf-8?B?NmhuM3ZraXkvVTlZTFJEU1RsbmRmRHR2ZlZOaHFKZFFIV2YzRjIvUk1ZUytk?=
 =?utf-8?B?VlFWSTZSRTBzenphNC8zTDZyczNLMWRYbVJMaDFyaWVySG51MElpWEhmdHV5?=
 =?utf-8?B?ODFKUUNZK29VUmd2ZExTUi9XUFM1cUpOajB4aXRxTXR2NW84cmg3dGJLT1dH?=
 =?utf-8?Q?1ne8LJBKWdQ4Deek=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BE1E26B47BB724384D92C99B2C50EE7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YyBip5vVvgBmwpjqBhaVo2NbkNfiQL9QRctXBKhxKO6WAVGweU4W8ihd+Ejbw5rwjNCYiZDkaF4S3cGthU4gsyxYIRBZloMwqyIqksu+yVXpA02oNBvw1gf4OnXyb9XqSOQIRF5sWawW+ax85m6OvLUqK21CMvcz5xgw60Tu+AuYO/oyAu+qubUDkZzuJzQ4OROvPPZF+OBIIBdJHOf0qwUozUEuZUbQ26tRVweV5bUCOkwJ/JjTBCoLg8FdFMWzO4fEmBcUG+QnrZ34tOiAIObzuxqlAvRysie208BPzIiVo2z5A6eDg+rN0mHqjuxh7JpIrRNgv7yWaQwDJbT6Dw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad3cc44-7977-4940-5ec1-08de90814d00
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 06:30:14.9617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mexQR/mRYVm9ZH31gbhps/dhp9tWHV5z3Jkx7h8NPG0pOj5L3Y3f5i0oNuN90qxmvb+iOaSbkZ6o1RGxM+Cto6W22gnOO82Ieooh+x+xqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8357
X-MTK: N
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-274390-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,collabora.com,pengutronix.de,baylibre.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediateko365.onmicrosoft.com:dkim,mediatek.com:dkim,mediatek.com:email,mediatek.com:mid,collabora.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason-JH.Lin@mediatek.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: CE8763848B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gRnJpLCAyMDI1LTA4LTI5IGF0IDExOjE5ICswMjAwLCBMYXVyYSBOYW8gd3JvdGU6DQo+IEFk
ZCBzdXBwb3J0IGZvciB0aGUgTVQ4MTk2IGRpc3AtYW8gY2xvY2sgY29udHJvbGxlciwgd2hpY2gg
cHJvdmlkZXMNCj4gY2xvY2sgZ2F0ZSBjb250cm9sIGZvciB0aGUgZGlzcGxheSBzeXN0ZW0uIEl0
IGlzIGludGVncmF0ZWQgd2l0aCB0aGUNCj4gbXRrLW1tc3lzIGRyaXZlciwgd2hpY2ggcmVnaXN0
ZXJzIHRoZSBkaXNwLWFvIGNsb2NrIGRyaXZlciB2aWENCj4gcGxhdGZvcm1fZGV2aWNlX3JlZ2lz
dGVyX2RhdGEoKS4NCj4gDQo+IFJldmlld2VkLWJ5OiBOw61jb2xhcyBGLiBSLiBBLiBQcmFkbyA8
bmZyYXByYWRvQGNvbGxhYm9yYS5jb20+DQo+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5v
IERlbCBSZWdubw0KPiA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBMYXVyYSBOYW8gPGxhdXJhLm5hb0Bjb2xsYWJvcmEuY29tPg0KPiAt
LS0NCj4gwqBkcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoCAyICstDQo+IMKgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5Ni12ZGlz
cF9hby5jIHwgODANCj4gKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDIgZmlsZXMgY2hhbmdl
ZCwgODEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTk2LXZkaXNwX2FvLmMNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZQ0KPiBiL2RyaXZlcnMvY2xrL21l
ZGlhdGVrL01ha2VmaWxlDQo+IGluZGV4IGZlNTY5OTQxMWQ4Yi4uNWI4OTY5ZmYxOTg1IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZQ0KPiArKysgYi9kcml2ZXJz
L2Nsay9tZWRpYXRlay9NYWtlZmlsZQ0KPiBAQCAtMTU3LDcgKzE1Nyw3IEBAIG9iai0kKENPTkZJ
R19DT01NT05fQ0xLX01UODE5Nl9JTVBfSUlDX1dSQVApICs9DQo+IGNsay1tdDgxOTYtaW1wX2lp
Y193cmFwLm8NCj4gwqBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTZfTUNVU1lTKSArPSBj
bGstbXQ4MTk2LW1jdS5vDQo+IMKgb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTk2X01EUFNZ
UykgKz0gY2xrLW10ODE5Ni1tZHBzeXMubw0KPiDCoG9iai0kKENPTkZJR19DT01NT05fQ0xLX01U
ODE5Nl9NRkdDRkcpICs9IGNsay1tdDgxOTYtbWZnLm8NCj4gLW9iai0kKENPTkZJR19DT01NT05f
Q0xLX01UODE5Nl9NTVNZUykgKz0gY2xrLW10ODE5Ni1kaXNwMC5vIGNsay0NCj4gbXQ4MTk2LWRp
c3AxLm8NCj4gK29iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5Nl9NTVNZUykgKz0gY2xrLW10
ODE5Ni1kaXNwMC5vIGNsay0NCj4gbXQ4MTk2LWRpc3AxLm8gY2xrLW10ODE5Ni12ZGlzcF9hby5v
DQo+IMKgb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTk2X1BFWFRQU1lTKSArPSBjbGstbXQ4
MTk2LXBleHRwLm8NCj4gwqBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTZfVUZTU1lTKSAr
PSBjbGstbXQ4MTk2LXVmc19hby5vDQo+IMKgb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MzY1
KSArPSBjbGstbXQ4MzY1LWFwbWl4ZWRzeXMubyBjbGstDQo+IG10ODM2NS5vDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTk2LXZkaXNwX2FvLmMNCj4gYi9kcml2
ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTk2LXZkaXNwX2FvLmMNCj4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi5mZGRiNjlkMWMzZWINCj4gLS0tIC9kZXYvbnVs
bA0KPiArKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTk2LXZkaXNwX2FvLmMNCj4g
QEAgLTAsMCArMSw4MCBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b25seQ0KPiArLyoNCj4gKyAqIENvcHlyaWdodCAoYykgMjAyNSBNZWRpYVRlayBJbmMuDQo+ICsg
KsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEd1YW5namllIFNvbmcgPGd1
YW5namllLnNvbmdAbWVkaWF0ZWsuY29tPg0KPiArICogQ29weXJpZ2h0IChjKSAyMDI1IENvbGxh
Ym9yYSBMdGQuDQo+ICsgKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIExh
dXJhIE5hbyA8bGF1cmEubmFvQGNvbGxhYm9yYS5jb20+DQo+ICsgKi8NCj4gKyNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9jbG9jay9tZWRpYXRlayxtdDgxOTYtY2xvY2suaD4NCj4gKw0KPiArI2luY2x1
ZGUgPGxpbnV4L2Nsay1wcm92aWRlci5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0K
PiArI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRm
b3JtX2RldmljZS5oPg0KPiArDQo+ICsjaW5jbHVkZSAiY2xrLWdhdGUuaCINCj4gKyNpbmNsdWRl
ICJjbGstbXRrLmgiDQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGVfcmVncyBt
bV92X2NnX3JlZ3MgPSB7DQo+ICsJLnNldF9vZnMgPSAweDEwNCwNCj4gKwkuY2xyX29mcyA9IDB4
MTA4LA0KPiArCS5zdGFfb2ZzID0gMHgxMDAsDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IG10a19nYXRlX3JlZ3MgbW1fdl9od3ZfcmVncyA9IHsNCj4gKwkuc2V0X29mcyA9IDB4
MDAzMCwNCj4gKwkuY2xyX29mcyA9IDB4MDAzNCwNCj4gKwkuc3RhX29mcyA9IDB4MmMxOCwNCj4g
K307DQo+ICsNCj4gKyNkZWZpbmUgR0FURV9NTV9BT19WKF9pZCwgX25hbWUsIF9wYXJlbnQsIF9z
aGlmdCkgewlcDQo+ICsJCS5pZCA9IF9pZCwJCQkJXA0KPiArCQkubmFtZSA9IF9uYW1lLAkJCQlc
DQo+ICsJCS5wYXJlbnRfbmFtZSA9IF9wYXJlbnQsCQkJXA0KPiArCQkucmVncyA9ICZtbV92X2Nn
X3JlZ3MsCQkJXA0KPiArCQkuc2hpZnQgPSBfc2hpZnQsCQkJXA0KPiArCQkub3BzID0gJm10a19j
bGtfZ2F0ZV9vcHNfc2V0Y2xyLAlcDQo+ICsJCS5mbGFncyA9IENMS19PUFNfUEFSRU5UX0VOQUJM
RSB8CVwNCj4gKwkJCSBDTEtfSVNfQ1JJVElDQUwsCQlcDQo+ICsJfQ0KPiArDQo+ICsjZGVmaW5l
IEdBVEVfSFdWX01NX1YoX2lkLCBfbmFtZSwgX3BhcmVudCwgX3NoaWZ0KSB7CVwNCj4gKwkJLmlk
ID0gX2lkLAkJCQlcDQo+ICsJCS5uYW1lID0gX25hbWUsCQkJCVwNCj4gKwkJLnBhcmVudF9uYW1l
ID0gX3BhcmVudCwJCQlcDQo+ICsJCS5yZWdzID0gJm1tX3ZfY2dfcmVncywJCQlcDQo+ICsJCS5o
d3ZfcmVncyA9ICZtbV92X2h3dl9yZWdzLAkJXA0KPiArCQkuc2hpZnQgPSBfc2hpZnQsCQkJXA0K
PiArCQkub3BzID0gJm10a19jbGtfZ2F0ZV9od3Zfb3BzX3NldGNsciwJXA0KPiArCQkuZmxhZ3Mg
PSBDTEtfT1BTX1BBUkVOVF9FTkFCTEUsCQlcDQo+ICsJfQ0KPiArDQo+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IG10a19nYXRlIG1tX3ZfY2xrc1tdID0gew0KPiArCUdBVEVfSFdWX01NX1YoQ0xLX01N
X1ZfRElTUF9WRElTUF9BT19DT05GSUcsDQo+ICJtbV92X2Rpc3BfdmRpc3BfYW9fY29uZmlnIiwg
ImRpc3AiLCAwKSwNCj4gKwlHQVRFX0hXVl9NTV9WKENMS19NTV9WX0RJU1BfRFBDLCAibW1fdl9k
aXNwX2RwYyIsICJkaXNwIiwNCj4gMTYpLA0KPiArCUdBVEVfTU1fQU9fVihDTEtfTU1fVl9TTUlf
U1VCX1NPTU0wLCAibW1fdl9zbWlfc3ViX3NvbW0wIiwNCj4gImRpc3AiLCAyKSwNCj4gK307DQo+
ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Nsa19kZXNjIG1tX3ZfbWNkID0gew0KPiAr
CS5jbGtzID0gbW1fdl9jbGtzLA0KPiArCS5udW1fY2xrcyA9IEFSUkFZX1NJWkUobW1fdl9jbGtz
KSwNCj4gK307DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG9mX21h
dGNoX2Nsa19tdDgxOTZfdmRpc3BfYW9bXSA9IHsNCj4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10ODE5Ni12ZGlzcC1hbyIsIC5kYXRhID0NCj4gJm1tX3ZfbWNkIH0sDQoNCkhpIExhdXJh
LA0KDQpXZSBhcmUgZ29pbmcgdG8gc2VuZCBtdGstbW1zeXMgZHJpdmVyIGZvciBNVDgxOTYgcmVj
ZW50bHksIGJ1dCB3ZSBmb3VuZA0KdGhlIGNvbXBhdGlibGUgbmFtZSBpcyB1c2VkIGhlcmUuDQoN
CkFzIHlvdXIgY29tbWl0IG1lc3NhZ2UsIHZkaXNwLWFvIGlzIGludGVncmF0ZWQgd2l0aCB0aGUg
bXRrLW1tc3lzDQpkcml2ZXIsIHdoaWNoIHJlZ2lzdGVycyB0aGUgdmRpc3AtYW8gY2xvY2sgZHJp
dmVyIHZpYSANCnBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcl9kYXRhKCkuDQoNClNob3VsZG4ndCB0
aGlzIGNvbXBhdGlibGUgbmFtZSBiZWxvbmcgdG8gbW1zeXMgZHJpdmVyIGZvciBNVDgxOTY/DQoN
Cj4gKwl7IC8qIHNlbnRpbmVsICovIH0NCj4gK307DQo+ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9m
LCBvZl9tYXRjaF9jbGtfbXQ4MTk2X3ZkaXNwX2FvKTsNCj4gKw0KPiArc3RhdGljIHN0cnVjdCBw
bGF0Zm9ybV9kcml2ZXIgY2xrX210ODE5Nl92ZGlzcF9hb19kcnYgPSB7DQo+ICsJLnByb2JlID0g
bXRrX2Nsa19wZGV2X3Byb2JlLA0KPiArCS5yZW1vdmUgPSBtdGtfY2xrX3BkZXZfcmVtb3ZlLA0K
PiArCS5kcml2ZXIgPSB7DQo+ICsJCS5uYW1lID0gImNsay1tdDgxOTYtdmRpc3AtYW8iLA0KPiAr
CQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9jbGtfbXQ4MTk2X3ZkaXNwX2FvLA0KDQpJbiBj
bGstbXQ4MTk2LW92bDAvb3ZsMS9kaXNwMC9kaXNwMS5jLCB0aGV5IHVzZSBgLmlkX3RhYmxlYCBp
bnN0ZWFkIG9mDQpgLm9mX21hdGNoX3RhYmxlYCBoZXJlLiBTaG91bGRuJ3QgdGhpcyBhbGlnbiB0
byB0aGVtPw0KDQpSZWdhcmRzLA0KSmFzb24tSkggTGluDQoNCj4gKwl9LA0KPiArfTsNCj4gK21v
ZHVsZV9wbGF0Zm9ybV9kcml2ZXIoY2xrX210ODE5Nl92ZGlzcF9hb19kcnYpOw0KPiArDQo+ICtN
T0RVTEVfREVTQ1JJUFRJT04oIk1lZGlhVGVrIE1UODE5NiB2ZGlzcF9hbyBjbG9ja3MgZHJpdmVy
Iik7DQo+ICtNT0RVTEVfTElDRU5TRSgiR1BMIik7DQoNCg==

