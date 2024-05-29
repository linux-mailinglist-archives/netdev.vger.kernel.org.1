Return-Path: <netdev+bounces-98873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F4D8D2C99
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 07:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245631F25C4D
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 05:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45392168C28;
	Wed, 29 May 2024 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="A9Cgbimb";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gJXohKAq"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404F816192F;
	Wed, 29 May 2024 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960981; cv=fail; b=fJq3LdMqBfLNyp/bqMq8Wn87xvN8o/YZxsZtSHZq8385MyBIzID3i4Qj3JvXvL1EyzgtYD10eKGPg7NWs11qhYP+nv4yAdcjdDFk1pZrCCbl3kqI2fNJERwE7rYaYL2gRKPm6H4xCjouXtuTSKJM64wUVbE83oOzX2ku0FHZp9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960981; c=relaxed/simple;
	bh=pSxrvzAJbZxKDRm9gmxxadSs90Jz9Fq17waYFddbVVE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MfRLvYE9GtzM5FNFdidHebYu16IyrG7xcc6391mnZMMoJXcNb82l6gS1h6c565MwXnGhkYgAUl/gBjpkMtzYmg0F5wivGNf9xxC9aY6VJHo0kdYJNsmRGGqleVIUGUomgKvftijO3/Aoe/0/DrsHDzd3qlVyBbOMxhbTMijjZzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=A9Cgbimb; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=gJXohKAq; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5acf24581d7d11ef8c37dd7afa272265-20240529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pSxrvzAJbZxKDRm9gmxxadSs90Jz9Fq17waYFddbVVE=;
	b=A9Cgbimbjz+8pyh+aPsVh48Z2O22lcFAbo7X+nh+K3FFabxVusXxxZ9i3lw2t8Iuhe7oscDjbH5qVLSCpYLHswob9OTCorMsPFaZpxauH2nZzkehzScGSsWC0WNnteOYnuuC59rYlQME1VAJvl+luHO7L67slE+pK3wAX38+08s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:2bdcf115-0601-4c8d-a631-8ea1369abc75,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:6b0af043-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 5acf24581d7d11ef8c37dd7afa272265-20240529
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <bc-bocun.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1029636943; Wed, 29 May 2024 13:36:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 May 2024 13:36:08 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 May 2024 13:36:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+o0S21X22Vzp0yzKxfgowhy5hY/GuCcz5YTcHJNPBikDFkM+mPwTGVzKL9YVhlAI8sL+nvBwCXTvkDWFXG42e8WsBWMf7IcT8M/VIEhVGBQuBRyu5SBI704Lm+e5LFLQB6SMAulydANPhnew7LKR/Lq6eaj66MTDoWYY6IDj+8iaw6l+PYjwoI4mew7AXbJpUcP3Ch7EZVAHWIkf2s817Xpa7l0BACRBUW3GAe46/+uEE1QmfW/xBjTyLI+LI80luIQYgooxbOlcDjB/CJXpwhP9IDhRq1cDU8Fsm5nMoFsZ6Picau7G/Y+j6MYw/JVaKwC+w11qHdjo9kldDMDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSxrvzAJbZxKDRm9gmxxadSs90Jz9Fq17waYFddbVVE=;
 b=bvaB5WzjIBUZbP+ZqoyS9eR5WlHKiBchHQgpwSNm5SOKfE0L/oijpiVzf5xyNThFrce3vR0qz6seGRhIGbKT2WhwEK+dqg/ls6HV582WX9LSOWxpNGvLXAeDHNYtUyw9NrHf8yjtFzyzja0EQ8blTAyvJUDEM0MZPD3uEiG+2o012HJ2qoV7DaLcXNbGlWdggxD5sAUk0n6inqoM1Ai6acDVEqYZqBM9XwvdIUj7zxCvmnTDLsE/VxQ48PybrwkM0jIw0U45Seu+f9xg1V5Jj4J/+RhnLIc3TENLSQq9K1nVEKqTnckYS0QfkpAJdYygfzKe96Gr1fWf+fT+BgA5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSxrvzAJbZxKDRm9gmxxadSs90Jz9Fq17waYFddbVVE=;
 b=gJXohKAqAeT4x1etEZDU//9dCJh6GYSrzS6z4jsQ2C4VPk5UuFAhAbWCD+VTm4KzLP9o0CczTQw/msAs9nAc1kHbJg/doCWhTFbv0i36oM3NA1uEoXFK32AyK8JKZJEZWeAw/idhIPsJHKm+k53lJ/V7wNit+k3p08aUo8BGEoA=
Received: from SEZPR03MB7219.apcprd03.prod.outlook.com (2603:1096:101:ef::15)
 by SEYPR03MB7892.apcprd03.prod.outlook.com (2603:1096:101:166::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16; Wed, 29 May
 2024 05:36:07 +0000
Received: from SEZPR03MB7219.apcprd03.prod.outlook.com
 ([fe80::6198:1b1c:c38e:fae4]) by SEZPR03MB7219.apcprd03.prod.outlook.com
 ([fe80::6198:1b1c:c38e:fae4%4]) with mapi id 15.20.7633.001; Wed, 29 May 2024
 05:36:06 +0000
From: =?utf-8?B?QmMtYm9jdW4gQ2hlbiAo6Zmz5p+P5p2RKQ==?=
	<bc-bocun.chen@mediatek.com>
To: =?utf-8?B?TWFyay1NQyBMZWUgKOadjuaYjuaYjCk=?= <Mark-MC.Lee@mediatek.com>,
	"linux@fw-web.de" <linux@fw-web.de>, "nbd@nbd.name" <nbd@nbd.name>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>, Sean Wang
	<Sean.Wang@mediatek.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?TWFzb24tY3cgQ2hhbmcgKOW8teWTsue2rSk=?=
	<Mason-cw.Chang@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
	=?utf-8?B?Q2hhay1rZWkgTGFtICjmnpfmvqTln7op?= <Chak-kei.Lam@mediatek.com>,
	"john@phrozen.org" <john@phrozen.org>, "frank-w@public-files.de"
	<frank-w@public-files.de>, =?utf-8?B?TmVhbCBZZW4gKOWatOS7leS9syk=?=
	<Neal.Yen@mediatek.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>
Subject: Re: [net v2] net: ethernet: mtk_eth_soc: handle dma buffer size soc
 specific
Thread-Topic: [net v2] net: ethernet: mtk_eth_soc: handle dma buffer size soc
 specific
Thread-Index: AQHasXMYNi3xSZU3p0KmKIWq/uy+z7GtsUsA
Date: Wed, 29 May 2024 05:36:06 +0000
Message-ID: <67e46c939bb3eb000c6e032b0b49c0ed58bd04a7.camel@mediatek.com>
References: <20240527142142.126796-1-linux@fw-web.de>
In-Reply-To: <20240527142142.126796-1-linux@fw-web.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7219:EE_|SEYPR03MB7892:EE_
x-ms-office365-filtering-correlation-id: 070f5588-228a-4173-1499-08dc7fa13cdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009|921011;
x-microsoft-antispam-message-info: =?utf-8?B?emN6TGRkUUQzTG5DZVBnWmxwMkx5Z0FtRXAzRzcwUlpiS0lVNzJDYlZOWXgv?=
 =?utf-8?B?L1IrdUZ0V2ZWd0NtMHE5NVhFa3JxQjhtS09FYzZSNVlMVmxQLzVWdytydlEw?=
 =?utf-8?B?NkxkcXFLV29Gb0U2S0hTSWVvMFZnTGxCK0NNNWJWL2RVTkZmd3ZSOGw0L2gr?=
 =?utf-8?B?bnJ2R0tkTUxZK0hyMEU0bHoyU2o3QnRGaHJWMXFuOTV5THB2QnJUOFNReFMr?=
 =?utf-8?B?dW1nb0tzM0NGK0lxZ3I1YVpPNDdjZ2N6UnRCRTNTZkRVZ0xiYjMrSnd1OXBZ?=
 =?utf-8?B?YkFwZGttMEFxbG1Lbm5vUDVTd09OWGZLOFg4dlNIR2ZESytkU1dVK0h0N2JU?=
 =?utf-8?B?cWpFSCsxSElLWTJQclZpWGFQWk01T29hdkxqbkxpdW9TUTVSeld4bDl2U3N1?=
 =?utf-8?B?K0QreURkOUp2dTJqOGhLZHBUb2piZ3VmZHVOWUpCWGxyUnVjbm1lSU1YaHpm?=
 =?utf-8?B?aXNGVUs4UzlEVWh4Q3V4MlpBWmhCYWhSanhnN09PN1EzSEk2dWZUaFZkTURB?=
 =?utf-8?B?djNFVysyM0M4dnB5a3ZlYWIzbUQwZzZtTG81TXlZWWtRY0RmL2t5NnFOQWgy?=
 =?utf-8?B?MS9zaDhBSi9vUHIrNnZ3SUVWL2dsRE5iTGpUUGFQaFZMZ1J6NllFZEhRNHJo?=
 =?utf-8?B?SEdSRUtuMU1XbDIxSnN5L0xzUXMvRTdESEtKaWVEMjF1MVlld0F3RTllSVZi?=
 =?utf-8?B?U3JZMC9taGM5QnZyS1ErY2lEYU5BOWlJczNXQU1xaG9xdzcrcDk3NUV1Y25V?=
 =?utf-8?B?dmloVTZwVjA5WVhYazQ0S2JWVlFEc1B3SDk4WU5ncCtMTHlIVlgxdVdkRmRT?=
 =?utf-8?B?QjVKK0xzKzh0R2hHSVI2RlNIZVVTUUNLTDhBWjhFUWZrak5Gakx6RjNGVVlP?=
 =?utf-8?B?NFd6bXhsMHI5Yk5ndTNBd0IxTHYzR2sxRC9CU2tsN0l3L2JMVmNTT3dKRit2?=
 =?utf-8?B?dmJOek5MYm1DNDN2S0ZQbkJ3dk9MYTBZcS9ZaGtmcDZSdWVuZGIzdHZ3TXF0?=
 =?utf-8?B?bWpMVmFkSDY2clJtVlNsckRwdWR5L1dVZklCQVQzNGpobE1uMzhINDVKMjZL?=
 =?utf-8?B?Z2JzeStpWmphTVhuL0YwajJHT2xKeGJ6azkyNDRoUXJncGRQbEdRLzRsT3Fn?=
 =?utf-8?B?WG9vUVNOUW1WNmZjaS82aVB3cjFhQnNwdDhMNGRzRXNNOERUTk9hRWZURGpp?=
 =?utf-8?B?Z2p5Y3haK0htQ3U1dHNodjZjYWlaMFZQakdTeXhHZ3ZoeVd5MjB4WW5qSEIw?=
 =?utf-8?B?b044VDVJRC9mR2lmbjZrNXZ0WXIwTXlwN2EvOVNPMjVDbitUMXRkMGJyY0My?=
 =?utf-8?B?UVZWZXNlaXpQR3JkaEtKTTJCYjdSWlRFZUIvTVJaR082ekdDam10NnhMT1VM?=
 =?utf-8?B?T3VoWjMvazlsT2VEZEUyQVR2SWljemVRQUw0Zk9hYlVhZWp4Q1ZuRmJTMzVQ?=
 =?utf-8?B?SGVhNTMwamFXaE05ZHErelFIbTJTU1pmYkx1dWk5NEJtd1pBbUJEaWYrVW12?=
 =?utf-8?B?SHg1VUVKbVJvSU41MzlSVG8zd2dUK2hhNFNyMEoxdmN6Y0VEK280N0J5cWNl?=
 =?utf-8?B?L21JQWlmUVgzalFtZDZKNEFXeHM0WXlySmYrcG9vaWZWUnEreld6NkVtUFJP?=
 =?utf-8?B?SXpVOGhXdTB0UnJxaGQrNS9xMHNUR0FGSUJoZWRnQ3ozS0xYNUFBSEp6N0lJ?=
 =?utf-8?B?cEZ4eEZtRng5K0hHMWdYZldzdDZtQm9LMXl0cUNkaUJNNXJ6WFBUaDM2SFZ2?=
 =?utf-8?Q?Jv1XWhp4X7nXttvNFE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7219.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1NXM2h0K0NvWDJTOG41cWhMbEJKRzRaeFdCU2FjTzBjRDZXUVVGVE95Qkpv?=
 =?utf-8?B?RFE0bDdjODdJWWpldjZFbGs3dVhmZTA5cHV3MnFmYjlFU0VnZ0NyeXFUMzNl?=
 =?utf-8?B?WmxrR21NaVo0WGZhRHV1RHhzUjlLbmNJWDNDTCt3cDl0UEJ2alVWYW4yemNR?=
 =?utf-8?B?UThHZWZ3enVIUXNrZWR4MDk2R1ZiZ29pUVN2SkVpZGtvTStkZUJtZHRWVUJx?=
 =?utf-8?B?NkVxeTc3Mi85bFc0bTdSUXkvRi9McUFuK2hUdzZhVWsrQzh2YVRmVW5wREFJ?=
 =?utf-8?B?N3lSNmZSV1Izd01vbXNmY0dqaXJJOHNKN2NJUXdpTy85d3hHMmFON243WHdv?=
 =?utf-8?B?N3ZCeE1JQWE1c3o1VFRXcXB4dDQyYkFpZEoyR08zVnRSR2pDclVJeEl5MVpN?=
 =?utf-8?B?UE5VSVA5ZW9xZklzTEJERkUzZ2tCaFRkRmNJVTh1ek1QUS9kRFdSUEh2ZnA1?=
 =?utf-8?B?NGRDc3BBTkhLa0JUMFBjeTAwekJ4Ym1CYmJETHVMU2FOY25Cc3BId1lZVndH?=
 =?utf-8?B?TDE1Nkw4QkMwVWY5SUlWNlh5S3VEcTg0WFRaWVVZMVM1Z0dSZjVkVmozeENZ?=
 =?utf-8?B?OS9GckZXQ0Q3citMM0x5dU9CYmpyM040d3pabkYzcWZidUc0blE2RFBGejVF?=
 =?utf-8?B?OTNpUS83QzYvSjlaQkFrendvRldhWGhRdnBPUkVCMDV6cTFiUEJZUkR3djJL?=
 =?utf-8?B?djB1QzNTMGd4K0dxR0pycTY1QktMeGxUbTVxOEI3Qm1IOElodVUxOElBTE9F?=
 =?utf-8?B?SUNSbVBVRG96WmtEcHlEWmdTaUkrS0xUaXQ3eEpuTDFPTjNFdS9ZdUZDbWRn?=
 =?utf-8?B?amxwNWxLbjROcjlkUlFyTlBYT1Vka2VtTmhRRGNSUzNmV1k5RmM3ODc1MHov?=
 =?utf-8?B?cTlIVTFVTFhodDduS0NneDlkY3M3YTdFcWFHODY0QTdTalVVd1BpMUFHS0ps?=
 =?utf-8?B?Uk1sS2VSN05RZy9wT0xOc2U2cFBUVytxaGp4d0FlT0NCdFJ6cGNUa1VxTDN5?=
 =?utf-8?B?Yno5R2UxeDZiS1JYaDFsNnpoeTFaOEdMUVE5VFFYSGNySXlraVUxdC9VV0dn?=
 =?utf-8?B?b0FqRCt5aXI0MzBoUmQwYVZVSjB5SGtPV1VqRmpWbVMweDVOVFd1L0RaUHZK?=
 =?utf-8?B?endSSmp4aXB3OGRLUFJFN2NWOFkwbjkrV2ZVNFhBbXVxVXFGaUxiWjhzeVV5?=
 =?utf-8?B?S0FCMlQrVVNTWDN6RkxUWWNYa2c3ZUh4U21oZnFjcW0rTmhrTVVYZlp0Z0xE?=
 =?utf-8?B?NDhMYUdYSFpJRkZMQmo4OWRKL1Q1WFA4OE1UZVZkZXRYanNsNWp0MHYrbWlP?=
 =?utf-8?B?UDJBVHJXby9qMkk3RStaMGo1akEzLzE1bC80dGdlaFdNaUI4RExEVVJLMmQz?=
 =?utf-8?B?SjFZUmRrMzhaNW9qZjRtemE0bWJBUDh3TWsvSlV1N3FNMkl5SkNpQ05RRGZr?=
 =?utf-8?B?U1lKWHZ2NDhKcElBZE9EMmtqaE1hOTlaUUJhN3E1MDdCZ0xWNm9USzcwMCs2?=
 =?utf-8?B?aVljU1k2SHQ1YXo1WEJBNEVLS2I1SFdGWDZ2VUk2UEVUdVZUWEJ1WWpMSTUr?=
 =?utf-8?B?Ri8vcC9IRGFIWjBQNEx2ZHdjSGQ0SEVES0JPWHFkM1lJemR4ckJRNExZbk5K?=
 =?utf-8?B?VWt6dlB1WkZGTTFNN3g4TGcwZG84NmxIQ0xacDJxV3VJSGhRT0RHUDZVbkhj?=
 =?utf-8?B?N2p1WmVvdDN3SEVTS1E4QU1RVTlWdDRJMTZlV21DSEozbCtod3p0T2E4RThB?=
 =?utf-8?B?TVNHalM0QUhTMVZyVGszU3B0NU9BbEZrenBNaVQrYlQrN0VMWE9HMUhoUTJm?=
 =?utf-8?B?eXM3Yi85dDUzTithTUlBdDRwekM4UUVkUk82cFJLYWFVeE9KUHhvNVBNSDZy?=
 =?utf-8?B?bTVVKys1eXBNNUdsVThjMDdJcUk3bjE4VEJUbnAzZTNhV1NpQUtIUDZGSS9q?=
 =?utf-8?B?dGJMMW1hVGV6UkIxak1kMGZiUVhHVHpTektJYUh1Q2l6aTdocVhhTFJ6ZmJM?=
 =?utf-8?B?THVPQzd3Q2phSGFQcmc2aVNRV1pSaTI0d0xiS3Bhd0lpR2ZNYk91RDVFTG4x?=
 =?utf-8?B?ZmRueHZkVFdHamZsSFQyTDFHT2w1VmFPRkZUNHUyNXNheUdBbFRwUUhPcWcw?=
 =?utf-8?B?UTFVbGg3V0JaeDIzaW5mMnNKUC9WTkg5RUsyaFpEVFNtNWwwcGlzMWxyL3V6?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <885C21BFC7125A4EA05AD3D5231F4ED6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7219.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070f5588-228a-4173-1499-08dc7fa13cdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 05:36:06.7121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFExB55ub57GWknRGkgZL487h7yXFdAIFH3bvogzVlRnAUvMT7p5D56TMoraPv215YMUPMN7tHC912h3USk8N/pOoOTyGds5iB9HnODTat8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7892

T24gTW9uLCAyMDI0LTA1LTI3IGF0IDE2OjIxICswMjAwLCBGcmFuayBXdW5kZXJsaWNoIHdyb3Rl
Og0KPiBGcm9tOiBGcmFuayBXdW5kZXJsaWNoIDxmcmFuay13QHB1YmxpYy1maWxlcy5kZT4NCj4N
Cj4gVGhlIG1haW5saW5lIE1USyBldGhlcm5ldCBkcml2ZXIgc3VmZmVycyBsb25nIHRpbWUgZnJv
bSByYXJseSBidXQNCj4gYW5ub3lpbmcgdHggcXVldWUgdGltZW91dHMuIFdlIHRoaW5rIHRoYXQg
dGhpcyBpcyBjYXVzZWQgYnkgZml4ZWQNCj4gZG1hIHNpemVzIGhhcmRjb2RlZCBmb3IgYWxsIFNv
Q3MuDQo+DQo+IFVzZSB0aGUgZG1hLXNpemUgaW1wbGVtZW50YXRpb24gZnJvbSBTREsgaW4gYSBw
ZXIgU29DIG1hbm5lci4NCj4NCj4gRml4ZXM6IDY1NmU3MDUyNDNmZCAoIm5ldC1uZXh0OiBtZWRp
YXRlazogYWRkIHN1cHBvcnQgZm9yIE1UNzYyMw0KPiBldGhlcm5ldCIpDQo+IFN1Z2dlc3RlZC1i
eTogRGFuaWVsIEdvbGxlIDxkYW5pZWxAbWFrcm90b3BpYS5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6
IEZyYW5rIFd1bmRlcmxpY2ggPGZyYW5rLXdAcHVibGljLWZpbGVzLmRlPg0KPiAtLS0NCj4gc29y
cnkgZm9yIG11bHRpcGxlIHBvc3RpbmcgaW4gZmlyc3QgdmVyc2lvbg0KPg0KPiBiYXNlZCBvbiBT
REs6DQo+IA0KaHR0cHM6Ly9naXQwMS5tZWRpYXRlay5jb20vcGx1Z2lucy9naXRpbGVzL29wZW53
cnQvZmVlZHMvbXRrLW9wZW53cnQtZmVlZHMvKy9mYWMxOTRkNjI1M2QzMzllMTVjNjUxYzA1MmI1
MzJhNDQ5YTA0ZDZlDQo+DQo+IHYyOg0KPiAtIGZpeCB1bnVzZWQgdmFyaWFibGUgJ2FkZHInIGlu
IDMyYml0IGJ1aWxkDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVkaWF0ZWsvbXRr
X2V0aF9zb2MuYyB8IDEwNSArKysrKysrKysrKysrLS0tLQ0KPiAtLQ0KPiAgZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWVkaWF0ZWsvbXRrX2V0aF9zb2MuaCB8ICAgOSArLQ0KPiAgMiBmaWxlcyBjaGFu
Z2VkLCA3OCBpbnNlcnRpb25zKCspLCAzNiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L21lZGlhdGVrL210a19ldGhfc29jLmMNCj4gYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tZWRpYXRlay9tdGtfZXRoX3NvYy5jDQo+IGluZGV4IGNhZTQ2MjkwYTdh
ZS4uZjFmZjFiZTczOTI2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWRp
YXRlay9tdGtfZXRoX3NvYy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lZGlhdGVr
L210a19ldGhfc29jLmMNCi4uLi4uLi4uLi4uLi4uDQo+IEBAIC01MTc2LDYgKzUyMDEsOCBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19zb2NfZGF0YSBtdDc5ODFfZGF0YSA9DQo+IHsNCj4gICAg
ICAgIC5kZXNjX3NpemUgPSBzaXplb2Yoc3RydWN0IG10a190eF9kbWFfdjIpLA0KPiAgICAgICAg
LmRtYV9tYXhfbGVuID0gTVRLX1RYX0RNQV9CVUZfTEVOX1YyLA0KPiAgICAgICAgLmRtYV9sZW5f
b2Zmc2V0ID0gOCwNCj4gKyAgICAgIC5kbWFfc2l6ZSA9IE1US19ETUFfU0laRSg0SyksDQo+ICsg
ICAgICAuZnFfZG1hX3NpemUgPSBNVEtfRE1BX1NJWkUoMkspLA0KPiAgICB9LA0KPiAgICAucngg
PSB7DQo+ICAgICAgICAuZGVzY19zaXplID0gc2l6ZW9mKHN0cnVjdCBtdGtfcnhfZG1hKSwNCj4g
QEAgLTUxODMsNiArNTIxMCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3NvY19kYXRhIG10
Nzk4MV9kYXRhID0NCj4gew0KPiAgICAgICAgLmRtYV9sNF92YWxpZCA9IFJYX0RNQV9MNF9WQUxJ
RF9WMiwNCj4gICAgICAgIC5kbWFfbWF4X2xlbiA9IE1US19UWF9ETUFfQlVGX0xFTiwNCj4gICAg
ICAgIC5kbWFfbGVuX29mZnNldCA9IDE2LA0KPiArICAgICAgLmRtYV9zaXplID0gTVRLX0RNQV9T
SVpFKDFLKSwNCj4gICAgfSwNCj4gIH07DQo+ICANCj4gQEAgLTUyMDIsNiArNTIzMCw4IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3NvY19kYXRhIG10Nzk4Nl9kYXRhID0NCj4gew0KPiAgICAg
ICAgLmRlc2Nfc2l6ZSA9IHNpemVvZihzdHJ1Y3QgbXRrX3R4X2RtYV92MiksDQo+ICAgICAgICAu
ZG1hX21heF9sZW4gPSBNVEtfVFhfRE1BX0JVRl9MRU5fVjIsDQo+ICAgICAgICAuZG1hX2xlbl9v
ZmZzZXQgPSA4LA0KPiArICAgICAgLmRtYV9zaXplID0gTVRLX0RNQV9TSVpFKDRLKSwNCj4gKyAg
ICAgIC5mcV9kbWFfc2l6ZSA9IE1US19ETUFfU0laRSgySyksDQo+ICAgIH0sDQo+ICAgIC5yeCA9
IHsNCj4gICAgICAgIC5kZXNjX3NpemUgPSBzaXplb2Yoc3RydWN0IG10a19yeF9kbWEpLA0KPiBA
QCAtNTIwOSw2ICs1MjM5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfc29jX2RhdGEgbXQ3
OTg2X2RhdGEgPQ0KPiB7DQo+ICAgICAgICAuZG1hX2w0X3ZhbGlkID0gUlhfRE1BX0w0X1ZBTElE
X1YyLA0KPiAgICAgICAgLmRtYV9tYXhfbGVuID0gTVRLX1RYX0RNQV9CVUZfTEVOLA0KPiAgICAg
ICAgLmRtYV9sZW5fb2Zmc2V0ID0gMTYsDQo+ICsgICAgICAuZG1hX3NpemUgPSBNVEtfRE1BX1NJ
WkUoMUspLA0KPiAgICB9LA0KPiAgfTsNCj4gIA0KPiBAQCAtNTIyOCw2ICs1MjU5LDggQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfc29jX2RhdGEgbXQ3OTg4X2RhdGEgPQ0KPiB7DQo+ICAgICAg
ICAuZGVzY19zaXplID0gc2l6ZW9mKHN0cnVjdCBtdGtfdHhfZG1hX3YyKSwNCj4gICAgICAgIC5k
bWFfbWF4X2xlbiA9IE1US19UWF9ETUFfQlVGX0xFTl9WMiwNCj4gICAgICAgIC5kbWFfbGVuX29m
ZnNldCA9IDgsDQo+ICsgICAgICAuZG1hX3NpemUgPSBNVEtfRE1BX1NJWkUoNEspLA0KPiArICAg
ICAgLmZxX2RtYV9zaXplID0gTVRLX0RNQV9TSVpFKDRLKSwNCj4gICAgfSwNCj4gICAgLnJ4ID0g
ew0KPiAgICAgICAgLmRlc2Nfc2l6ZSA9IHNpemVvZihzdHJ1Y3QgbXRrX3J4X2RtYV92MiksDQo+
IEBAIC01MjM1LDYgKzUyNjgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19zb2NfZGF0YSBt
dDc5ODhfZGF0YSA9DQo+IHsNCj4gICAgICAgIC5kbWFfbDRfdmFsaWQgPSBSWF9ETUFfTDRfVkFM
SURfVjIsDQo+ICAgICAgICAuZG1hX21heF9sZW4gPSBNVEtfVFhfRE1BX0JVRl9MRU5fVjIsDQo+
ICAgICAgICAuZG1hX2xlbl9vZmZzZXQgPSA4LA0KPiArICAgICAgLmRtYV9zaXplID0gTVRLX0RN
QV9TSVpFKDFLKSwNCj4gICAgfSwNCj4gIH07DQouLi4uLi4uLi4uLi4uLg0KVGhhbmsgeW91IGZv
ciBhc3Npc3RpbmcgaW4gdXBzdHJlYW1pbmcgdGhpcyBwYXRjaCBmcm9tIHRoZSBtYWlubGluZSBN
VEsNCmRyaXZlci4NCkN1cnJlbnRseSwgdGhlIFJTUyBmZWF0dXJlIGhhcyBub3QgYmVlbiB1cHN0
cmVhbWVkLiBJdCBpcyByZWNvbW1hbmRlZA0KdG8gdXNlIDIwNDggRE1BRHMgZm9yIGJvdGggVFgg
YW5kIFJYIFJpbmdzIG9uIHRoZSBNVDc5ODEvODYvODguDQoNCg0K

