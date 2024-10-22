Return-Path: <netdev+bounces-137701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 246509A9631
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 04:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952011F226A3
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 02:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A455013777F;
	Tue, 22 Oct 2024 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SAUnwk8S";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="sr+UMNld"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167AD1EB31;
	Tue, 22 Oct 2024 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729563697; cv=fail; b=kZMehBDUEGev6QR9DP/AUuVjDxPjA2ybS2NWYzaLrL9p7VkAnixXTm77ulFvvr5Xuq/kYy0QFoB3JScgAD+eqQdgu87D5IKrcbmtJ7NXr2Et+vGA9XZ8n9PexwF7G2EFs81KZeemKKXY32pUNwQ9qG6BXwMfYx9v2f2Dkg2mBaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729563697; c=relaxed/simple;
	bh=8Hobt6OKLexB4eLW4p1UVfGGD+dkLDmKV32RM3r6Cs0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GCPKdoRHzRn/0tJ965cE1Xp+XiT3gQhOx1q7rY28IIsXzCuclwxIouwlvMnl/Zaub63E+LvqDNwi+MvLBRydpush5IKMp8Q/qQ4AL9GSb/D2ndE4JjcC5cP/0RWv58W3NjMahJHjAvjapkDOE0GBaGRLWMBWSMwe8cs4is0ECoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SAUnwk8S; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=sr+UMNld; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 58cf396a901c11efbd192953cf12861f-20241022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8Hobt6OKLexB4eLW4p1UVfGGD+dkLDmKV32RM3r6Cs0=;
	b=SAUnwk8Sg7GJqs4hPlATzdq7zgdVpv7DV1c4z9FGyuxRp86G/5Q0JwENUlOJd3ncW1jYNsnx3ooSAAMsSXZh/PCsWUHLRiWRgatlM8Mhe7OScFj0oo9TuLVAUksCv9p2DfIgZRx4WEkC4TAAr8REB/s8KaYy4VUIDXlF1Pc0g3c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:6394b453-9003-4aca-9503-79d84890f8d9,IP:0,U
	RL:0,TC:0,Content:2,EDM:0,RT:2,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:4
X-CID-META: VersionHash:b0fcdc3,CLOUDID:32f49e41-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 58cf396a901c11efbd192953cf12861f-20241022
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 764845070; Tue, 22 Oct 2024 10:21:29 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 22 Oct 2024 10:21:28 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 22 Oct 2024 10:21:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAiYP3w2LVwI5v9VAWmqQr7j2gA0NQF41yPvkwLpe9y/V4mWHWdw3IqF3kBR7krrMpSB6A5yv2wzd5CNR78Y39TIgkr1ZRBfChdza4hu5y0KmztEgQgmZoIJGpQQK0yWNqxtvo+oISBz6nFtROstHBQUim/gcueHDTYa8EDO4ULQB1OvyWQvmfofW+gp7qy51ZzVTm59EwRkF6RGgmE5hVAyCUdHfBe3ngnr1yHAkin27kAleNzAWqYkhoP75ns9KCVYcwhsYq+koTHhu6U7xUHbiT18S30vGMSy4bhNYrIhFIrSK2tvO+77w2b1Qf9Alh/UE6EYCWduhQK4ccbUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Hobt6OKLexB4eLW4p1UVfGGD+dkLDmKV32RM3r6Cs0=;
 b=zJ0OnRObtGAUgjI3TIRYB9fmPf/zvxg1nx6Zfnv7F/OglcgEQJR35zxvaRFKOqJXd56PGFRVeop1dzlpfCOhow59CuxF06o9RZ4+oG0lEENi4e/FWdcnw8cNiYZp1/uhaAhNcen+RmBgPxl7za4XPXsmRQlry9+HJL+R9BZMGjQJ7DLi3SjTPtuQ/zI+qTA20WlHByJmLooswBF+93cSGxyR3OIiVNuAl3+3vmtgIwYACjT3W18DJYVQFTzHwnGd0lHzJSVUik2TjIBTVCBlyhRgeq5ubLN8YX4SY+WNfjcQNVM1nFJgDV+NRl54SN+RpmyLJkFwCzzkwjFQkfBiqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Hobt6OKLexB4eLW4p1UVfGGD+dkLDmKV32RM3r6Cs0=;
 b=sr+UMNldzycZopYw3cw6C7KWELTpjSx/+txNl9y1WbPFDkeozjO7DlhTmhShFNczbyOVINmknyzW9kKG+XccyhX4mwsW1vZPjERMZDm7FcA++eq/B3ZKtejD1ZPZugSbUIdqJO5AR2dS1sc//Msd+ZKo6AwuR6wq8UaVAC7BsCM=
Received: from SEZPR03MB8273.apcprd03.prod.outlook.com (2603:1096:101:19a::11)
 by SG2PR03MB6455.apcprd03.prod.outlook.com (2603:1096:4:1c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 02:21:22 +0000
Received: from SEZPR03MB8273.apcprd03.prod.outlook.com
 ([fe80::f7ac:70cb:3cb4:acac]) by SEZPR03MB8273.apcprd03.prod.outlook.com
 ([fe80::f7ac:70cb:3cb4:acac%7]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 02:21:22 +0000
From: =?utf-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?=
	<Liju-clr.Chen@mediatek.com>
To: "corbet@lwn.net" <corbet@lwn.net>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	=?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= <Ze-yu.Wang@mediatek.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, =?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?=
	<Yingshiuan.Pan@mediatek.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"will@kernel.org" <will@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?S2V2ZW5ueSBIc2llaCAo6Kyd5a6c6Iq4KQ==?=
	<Kevenny.Hsieh@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, =?utf-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?=
	<PeiLun.Suei@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, =?utf-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?=
	<shawn.hsiao@mediatek.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, =?utf-8?B?Q2hpLXNoZW4gWWVoICjokYnlpYfou5Ip?=
	<Chi-shen.Yeh@mediatek.com>
Subject: Re: [PATCH v12 02/24] docs: geniezone: Introduce GenieZone hypervisor
Thread-Topic: [PATCH v12 02/24] docs: geniezone: Introduce GenieZone
 hypervisor
Thread-Index: AQHa4loHXj3BRZIhrEqFOT9rcqMUQbIPULcAgIM8v4A=
Date: Tue, 22 Oct 2024 02:21:22 +0000
Message-ID: <d9986bc048468ab30a63a3cd570df3c5b1e933e5.camel@mediatek.com>
References: <20240730082436.9151-1-liju-clr.chen@mediatek.com>
	 <20240730082436.9151-3-liju-clr.chen@mediatek.com>
	 <190e49bb-88d2-49fe-a228-c379c33503c1@infradead.org>
In-Reply-To: <190e49bb-88d2-49fe-a228-c379c33503c1@infradead.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB8273:EE_|SG2PR03MB6455:EE_
x-ms-office365-filtering-correlation-id: 12ec6a7d-bc43-4913-40dd-08dcf24038d4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Tkx5ck1NK2poQkc4QWlodTNWTUkvdElZMGlDL0NPRWxrZWxkNUI2dFB1UlMz?=
 =?utf-8?B?eEFyTFBMQ29sVUVwUzVzNGdJR1RlZ1o5NkhvcVlrU3A4bDNxeEp4NTR1bnRO?=
 =?utf-8?B?RFYyNHhWSmlyWEJiQ0xQdS91L1AwVCtFTzNpS0tZaVJHeERiVU1mU3g3R3Q4?=
 =?utf-8?B?cU5MU1lUaWtUaW9HOHJQUGRiWjQ3MndmYSt2WmVLbGhSSlVkTVcwRlVvWWtx?=
 =?utf-8?B?Q2pZRW1pY09jYTQvWmZBSFlSZVg1NkdEMjlXTWVlNnNVbSs3WEI2YVlpZVBz?=
 =?utf-8?B?SEVwaGFJNHhKKzQ0RU9keG9qWHNjS1Q2WTQvZDI3SEt5djA3UTloNzJFVWxR?=
 =?utf-8?B?MEw0MjE0SUlJaGhIbkJDWUdPa0JLT0VIbVhrdUlzWmlTcmREQzF3eUZJalZk?=
 =?utf-8?B?Rml3T200MU51TE9sRlh3WERpbTZGTk0yNzk1UzB2L3lMdkVXYXdSRldCN2dY?=
 =?utf-8?B?aFhyWlhUSEtEelFPakZhbThTdHRBaU1KQmVJY2FsdkVTcFhvWUVWRWNFM0Nw?=
 =?utf-8?B?elVYK09jV3ZvUnRLdzB1S0JMYzBYdENwYkJBTG93UDlwbnBNNTJXMGhiRHJ3?=
 =?utf-8?B?U0ljeGxST0dhV0h2TjVGTmFoWnZVdFUzcTFmOEJtYStFeUJFWFNlTGJTVkND?=
 =?utf-8?B?VHFsNElwZVZZeVltMXJIaitra0MwejFjMThPTitRZ1pGSWZyY0tSMW5ndS9k?=
 =?utf-8?B?N2R1WE5zSVpqSjUwakRIbW40SjhmUGhXYUorZEhadzZCZFhvVWVyRnBIVXpW?=
 =?utf-8?B?WEJTL1Zmb2k0elhORldEWi8yTnh2M3lQR1JodjgyOFJxQUIzRStLM2dtNlIw?=
 =?utf-8?B?Si9lY3BUUnRzL2JOZ1p6b2R4RTRVNmpSaTNFUEJCaFBWTDIrYnRQT2VEbXFW?=
 =?utf-8?B?a042cTdlakVkYXY1alJaQmNaa3JkT0RUNzYzalg5NTBESUJ4cFJmR09qc1hr?=
 =?utf-8?B?OHNSOGJzbll3K1RXUkYvSFBUYWZrSS8wV3Zkdm9FQ29sNlJCdXh2ODF6djgy?=
 =?utf-8?B?K0ljSHZteWU5U1czbkNxSkJzK0R3NkNGajMxYmlOcXN0d0JFdkRLVURwcDlt?=
 =?utf-8?B?eUpCYUlTRHhBcHQ5ck1KcmJ6UjVSTEtQOUdGVkRWM0lHaVhjczBndkFDYzVY?=
 =?utf-8?B?OFFwUmNpclBxK042NG1RTTlkU1dNR01VWVZhUUJld2dNYjNzVVNTRlg5d29r?=
 =?utf-8?B?RG1rT0ZJSU1EUWJXY0I4bDMrZ3VVMUJtenZNemtkeTZZSWdKdWNFeUYxYWJ6?=
 =?utf-8?B?R3RVeDFJWC9KSGg2VjJhNi9hc1FGR04xMzlpVXgyNk12dHpOVnBrL0kzQWc0?=
 =?utf-8?B?bFMvVk45MzZSWGp6bDJuaFRBUldhK2hFSm1vbEk4YXAzcjQwTktSMkRtU2sx?=
 =?utf-8?B?eVZyakx4WW5PekRqLzBwUzg5Rk1wTnhocWZZR0V1WDlMVjdpaU5ackNVYWpH?=
 =?utf-8?B?NnlraURyTjVBbTF6Q3hSUkZVTkc5V0UwR1hVOElsU0piSmtMZzhKaFJaS2Jt?=
 =?utf-8?B?Z3IrcFhiakxYMEthWCs2VTRuT3M0dUIvV0xaa0pQdmFJUjMrRUZLZ3gzOFlU?=
 =?utf-8?B?OGJQU00zMXc0eHM3OFhHSU5kSDVUb212ZXVlb3lmbXVLL29venRQaWRTRzRl?=
 =?utf-8?B?T01GcURZMUpJQWtGVmRoYm53RGQ0RC9sTXliWG4zeWFOWWZ4dnRVYitucVlx?=
 =?utf-8?B?a2RjZk5XSXM0bzhmRW9FZ3l4bGROeEh1Y0gxYW1lNGdzRFo3eUxQZ2JlSXZQ?=
 =?utf-8?B?K0hnUlF0d01vSldLN1VMRG8xb3h0c2dZVFZhOGNUVnJWQk80bk1NcDg0Q0FW?=
 =?utf-8?B?Mm5nZlFoUXhGREpBd1ZyWUdoaFpRVkRDN0V0OHRZcXgvUmczUi9RTFNoRmVs?=
 =?utf-8?Q?798ZUkHNk1v7s?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB8273.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnZjUWJoYW5FWmhLSGJMVVRiMlRqSnI1RzdpK01yOVB5N1RRdGVxTFE4VEpD?=
 =?utf-8?B?K3ZSWnMxN0xndnZXbDJWbm14blpMRkFsUUZpUjQ2VkVIMXoxSGd3NGVIZHlp?=
 =?utf-8?B?NjIyMWZWZFhMc3c0WHR0YWIxbWR1bDNlaDh2TCtoTUZROUhVeENnaHlEUDli?=
 =?utf-8?B?ZUt6TTlOZm4yNEd5aXBONDZQQ0JKQzg2a2w4d1FzL1QzQjUxS3VPM0l4Risz?=
 =?utf-8?B?MTdwVGRUVURneWJmYmlEejFwUGdJRHRDbmN4RFhKNGxUVkZWYVFscXBRcjUr?=
 =?utf-8?B?ZFVOZG5YekJkZHpSVmVsMmRjOU9FNmo5Z2tVeGV4S3RCMXpKZWxsNitVVXVr?=
 =?utf-8?B?VDVTa2FoSFlMQ1Nrbm9EQ1diNlZyRC81MGhwMkM1T21vNGtYZ01wS0YvYlNo?=
 =?utf-8?B?bk0wQkZXcFd3eUpCeVdUZUJrcGJsQktKZEZxU3VYbjJyenpmMjh1OWY3RTNE?=
 =?utf-8?B?RkRCMzZidnFJQ2owUFlQWjdmd0laNEpZVFJBUE9HSUdkNTJGM3VVZmVOdk5D?=
 =?utf-8?B?a29iZWdQTHFFZkVJNHNWN2lGckp5UHgwcWx5Smd6VVRmdmhxR0p0R3EyVGht?=
 =?utf-8?B?aDExVExENjgyY1VOVktFVnZYWmZrMEtxbTJWZk9YZ1pDWHRGM1RMTlpHbUJ4?=
 =?utf-8?B?NG1FcU03WmlPOEczbmVZNHZ0TDZoT2dPUjRKQmtiWmx2VmRXL2lncnd4Rnh3?=
 =?utf-8?B?cFV2ZUZnSXVVMTlhUVFaeVNETndQclJ2dVVqWnZLQjBaS1dtR2FHdFo0ZzZK?=
 =?utf-8?B?SzdVbG5CQ3o4ZklhMExFZ3k0ajBLdDlwSHhFbFlJUWtmSTBoMW0xMzFMcHd6?=
 =?utf-8?B?ZWcyZDM4TDhUTThOZDRvaUF3ZGdtVnNkYnM4L0lFcnlkZDhlM3ZsTW9DMTFq?=
 =?utf-8?B?ckd4ZUF2TUppOWlLVS80VTQzVmtGT3p6Y1dlb0JvM2REOGNBaUhQLzFva2xG?=
 =?utf-8?B?Mzh5T3BHUnI3c01mU0VPMHdJR0M4L2hHRE9VcFZiWThNVEVUSElrM09pM3B2?=
 =?utf-8?B?MkE0WENueUY5eGhZdldJUW4yaW9IR2c3RkFnalQ2eTcraWg0OVJKQ3VLb2xh?=
 =?utf-8?B?TmI3S0VIeEo1TlJwcEpWSlU4ZkljYVYyRkFKY2JiQmNGRVlwR1JaZlBubzZy?=
 =?utf-8?B?UFlaK09XVlN2ejZHK0N1emNXNXF6aDdDN0RnOG5vbnczcFI4UjJOUjhRR1hj?=
 =?utf-8?B?TjV1N2tBZGlzSU9zeVhTTlBHWXVBRXFZL3luZzRXV0VpVkFtcGFvL0tGSzNk?=
 =?utf-8?B?VHhBQjVIVTkwc2p0dGp1UHNYQ3pPM08xUWV2bU9uUktGQ1FnVFNxOW1Rd0Mw?=
 =?utf-8?B?cnpsSVlDdko3Q1RxRTFxK0xmUVRMZE8wSDBvOWkvSVg4eHUwYjRCUW1mMFhQ?=
 =?utf-8?B?bHNLMzQxZ244aG00MVhNLzNHdW5LalpCZElJTHpaMmRHMWdhb2VuYTZsTlBM?=
 =?utf-8?B?QkJWbXdNa1dKMUVEYWRSTGxsSmlIeGdvMWs3by9xd2UvMnhMaTc3dC9ydC9s?=
 =?utf-8?B?UCtZbk8vd2dFUGNYMjdPWkI5c0tpQjdGaXZ3M3ZNZWQ4ZWxkM2hNN2FpY3lY?=
 =?utf-8?B?b0svbllJaFZoNXA4WXVvVkd0cXorcURBbEREM1lEL1B0ekJMZ1p5aFpRUWhW?=
 =?utf-8?B?Vi83M1dpMm9Jckt0S2FhUkdRcDBCbjBjVzFYdkEzYVNZaWNzNVQ3SDIzd0JL?=
 =?utf-8?B?NERKUFVDZlpiVDBJNXVZUW9ocUVFRTA4dmVleTVMeDBnNnQ0S2htc1JVKzNN?=
 =?utf-8?B?bmUzNUk4UFdyWnMyamhXMzdFTytvTEY5WVpMSGswUkZtaHVIYnJjOVlzc1ps?=
 =?utf-8?B?OFFqY2pJSm1MZHJ2aTZqUU1NRVFhcDVmUFIwc2I0RmgrcEVWR1o1ZWgyQTFu?=
 =?utf-8?B?bWRCUTdlYksxNlB5bndBQ1lleUNjbXlITVpWdWJWTHc4clFrbERmdG44cnFK?=
 =?utf-8?B?QTZEdlhvWERFZFlsZEhxVHZ2dDFrUVlSSzJMSmNvQ3MyU1dqU2p5aUw1eGc0?=
 =?utf-8?B?T0R5emJzTVUwVGhBSDRTVmFxd29VQlRQZGxpeGdQc3pTaC9EVlFuMGZTQ1I3?=
 =?utf-8?B?SlpMcURBRWZGMkRBZHFFdWx0eWx2Q1ppNUdkTk96bUV1UzR1enNZM2dIMWkz?=
 =?utf-8?B?RDFWdmk0Wnh4ZGl2UFd1MUJBUU9Fc0ZGZHZoRy9ZK0RQaWtHNFlpWGFSYmF4?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DC6FDBEBBED3A4BA53E2432351B5402@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB8273.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ec6a7d-bc43-4913-40dd-08dcf24038d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 02:21:22.4766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TOEuTri8chmLjUX9ofFjXUEroQQtsU+Prs03dvdwP4YXzQgrxX235lBqVHrYN/8eIzJStWXufQYO80+HY/qB6rbWQaT5eHP94nQqtEU4ZXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6455
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--28.460600-8.000000
X-TMASE-MatchedRID: ediyJTvK8erUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCmNvKIW9g24omlaAItiONP1WjiXAsVR2K2sxtqQk3w55l0B
	rH8BQUYUrIhHNwiG1WVwGtnf+OY/EYlldA0POS1LJ5W6OZe5hhfNYQxCOihTNX0jyhj9/Qq6PC/
	RN2FStyvbV5XlUng0nYCgvwslmwAUEQqIqKFLtToSvKOGqLLPK+LidURF+DB05yqWxi+AoVWlys
	1PDhWLoxLuwGGsx46FQQ+NZniMkn+BX8Ypq0C8lwCZxkTHxccnLBdK2mpaYljMVY5itbDoDwB8g
	zNQ+eE4QipsrfhmDl7nMBkcbojkqGNZpatR+Wd6L9v4vFTanjljouBj2ga+/xaQNbiRXdZrWYaE
	vasc9FxXpA3A9dgOrtVz8cckwXLd8tzbYIxQT6xi14cCd2FejQKuv8uQBDjo76cr3lZK7RIQi0Y
	Fm8f1J9Q/QM4HVoryiMrPG3zrZ/foYkWHhe7M1R6Cqe38Szle51wB2BUjzGVc/CedjlcvkJu64C
	WLCWnrpZeYlhXHmHFqaNr+WR0vnlYSFi/RRLjcHtOpEBhWiFm3rdD5aWlvImyiLZetSf8n5kvmj
	69FXvKEwgORH8p/AjaPj0W1qn0SQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--28.460600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A1C7BAFD2EC29515403F0B2530D45B8507E74D95797E218EFB647755A91E01C62000:8

T24gVHVlLCAyMDI0LTA3LTMwIGF0IDA3OjEzIC0wNzAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgSGktLQ0KPiANCj4gT24gNy8zMC8yNCAxOjI0IEFNLCBMaWp1LWNsciBD
aGVuIHdyb3RlOg0KPiA+IEZyb206IFlpbmdzaGl1YW4gUGFuIDx5aW5nc2hpdWFuLnBhbkBtZWRp
YXRlay5jb20+DQo+ID4gDQo+ID4gR2VuaWVab25lIGlzIE1lZGlhVGVrIHByb3ByaWV0YXJ5IGh5
cGVydmlzb3Igc29sdXRpb24sIGFuZCBpdCBpcw0KPiBydW5uaW5nDQo+ID4gaW4gRUwyIHN0YW5k
IGFsb25lIGFzIGEgdHlwZS1JIGh5cGVydmlzb3IuIEl0IGlzIGEgcHVyZSBFTDINCj4gPiBpbXBs
ZW1lbnRhdGlvbiB3aGljaCBpbXBsaWVzIGl0IGRvZXMgbm90IHJlbHkgYW55IHNwZWNpZmljIGhv
c3QgVk0sDQo+IGFuZA0KPiA+IHRoaXMgYmVoYXZpb3IgaW1wcm92ZXMgR2VuaWVab25lJ3Mgc2Vj
dXJpdHkgYXMgaXQgbGltaXRzIGl0cw0KPiBpbnRlcmZhY2UuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogWWluZ3NoaXVhbiBQYW4gPHlpbmdzaGl1YW4ucGFuQG1lZGlhdGVrLmNvbT4NCj4gPiBD
by1kZXZlbG9wZWQtYnk6IFlpLURlIFd1IDx5aS1kZS53dUBtZWRpYXRlay5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogWWktRGUgV3UgPHlpLWRlLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBMaWp1IENoZW4gPGxpanUtY2xyLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0K
PiA+ICBEb2N1bWVudGF0aW9uL3ZpcnQvZ2VuaWV6b25lL2ludHJvZHVjdGlvbi5yc3QgfCA4Nw0K
PiArKysrKysrKysrKysrKysrKysrDQo+ID4gIERvY3VtZW50YXRpb24vdmlydC9pbmRleC5yc3Qg
ICAgICAgICAgICAgICAgICB8ICAxICsNCj4gPiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDYgKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA5NCBpbnNl
cnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL3ZpcnQvZ2Vu
aWV6b25lL2ludHJvZHVjdGlvbi5yc3QNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi92aXJ0L2dlbmllem9uZS9pbnRyb2R1Y3Rpb24ucnN0DQo+IGIvRG9jdW1lbnRhdGlvbi92
aXJ0L2dlbmllem9uZS9pbnRyb2R1Y3Rpb24ucnN0DQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmYyODA0NzYyMjhiMw0KPiA+IC0tLSAvZGV2L251bGwN
Cj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL3ZpcnQvZ2VuaWV6b25lL2ludHJvZHVjdGlvbi5yc3QN
Cj4gPiBAQCAtMCwwICsxLDg3IEBADQo+ID4gKy4uIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wDQo+ID4gKw0KPiA+ICs9PT09PT09PT09PT09PT09PT09PT09DQo+ID4gK0dlbmllWm9u
ZSBJbnRyb2R1Y3Rpb24NCj4gPiArPT09PT09PT09PT09PT09PT09PT09PQ0KPiA+ICsNCj4gPiAr
T3ZlcnZpZXcNCj4gPiArPT09PT09PT0NCj4gPiArR2VuaWVab25lIGh5cGVydmlzb3IgKGd6dm0p
IGlzIGEgdHlwZS0xIGh5cGVydmlzb3IgdGhhdCBzdXBwb3J0cw0KPiB2YXJpb3VzIHZpcnR1YWwN
Cj4gPiArbWFjaGluZSB0eXBlcyBhbmQgcHJvdmlkZXMgc2VjdXJpdHkgZmVhdHVyZXMgc3VjaCBh
cyBURUUtbGlrZQ0KPiBzY2VuYXJpb3MgYW5kDQo+ID4gK3NlY3VyZSBib290LiBJdCBjYW4gY3Jl
YXRlIGd1ZXN0IFZNcyBmb3Igc2VjdXJpdHkgdXNlIGNhc2VzIGFuZA0KPiBoYXMNCj4gPiArdmly
dHVhbGl6YXRpb24gY2FwYWJpbGl0aWVzIGZvciBib3RoIHBsYXRmb3JtIGFuZCBpbnRlcnJ1cHQu
DQo+IEFsdGhvdWdoIHRoZQ0KPiA+ICtoeXBlcnZpc29yIGNhbiBiZSBib290ZWQgaW5kZXBlbmRl
bnRseSwgaXQgcmVxdWlyZXMgdGhlIGFzc2lzdGFuY2UNCj4gb2YgR2VuaWVab25lDQo+ID4gK2h5
cGVydmlzb3Iga2VybmVsIGRyaXZlcihhbHNvIG5hbWVkIGd6dm0pIHRvIGxldmVyYWdlIHRoZSBh
YmlsaXR5DQo+IG9mIExpbnV4DQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICBkcml2ZXIgKGFs
c28NCj4gDQo+ID4gK2tlcm5lbCBmb3IgdkNQVSBzY2hlZHVsaW5nLCBtZW1vcnkgbWFuYWdlbWVu
dCwgaW50ZXItVk0NCj4gY29tbXVuaWNhdGlvbiBhbmQgdmlydGlvDQo+ID4gK2JhY2tlbmQgc3Vw
cG9ydC4NCj4gPiArDQo+ID4gK1N1cHBvcnRlZCBBcmNoaXRlY3R1cmUNCj4gPiArPT09PT09PT09
PT09PT09PT09PT09PQ0KPiA+ICtHZW5pZVpvbmUgbm93IG9ubHkgc3VwcG9ydHMgTWVkaWFUZWsg
QVJNNjQgU29DLg0KPiA+ICsNCj4gPiArRmVhdHVyZXMNCj4gPiArPT09PT09PT0NCj4gPiArDQo+
ID4gKy0gdkNQVSBNYW5hZ2VtZW50DQo+ID4gKw0KPiA+ICsgIFZNIG1hbmFnZXIgYWltcyB0byBw
cm92aWRlIHZDUFVzIG9uIHRoZSBiYXNpcyBvZiB0aW1lIHNoYXJpbmcgb24NCj4gcGh5c2ljYWwN
Cj4gPiArICBDUFVzLiBJdCByZXF1aXJlcyBMaW51eCBrZXJuZWwgaW4gaG9zdCBWTSBmb3IgdkNQ
VSBzY2hlZHVsaW5nDQo+IGFuZCBWTSBwb3dlcg0KPiA+ICsgIG1hbmFnZW1lbnQuDQo+ID4gKw0K
PiA+ICstIE1lbW9yeSBNYW5hZ2VtZW50DQo+ID4gKw0KPiA+ICsgIERpcmVjdCB1c2Ugb2YgcGh5
c2ljYWwgbWVtb3J5IGZyb20gVk1zIGlzIGZvcmJpZGRlbiBhbmQgZGVzaWduZWQNCj4gdG8gYmUN
Cj4gPiArICBkaWN0YXRlZCB0byB0aGUgcHJpdmlsZWdlIG1vZGVscyBtYW5hZ2VkIGJ5IEdlbmll
Wm9uZSBoeXBlcnZpc29yDQo+IGZvciBzZWN1cml0eQ0KPiA+ICsgIHJlYXNvbi4gV2l0aCB0aGUg
aGVscCBvZiBnenZtIG1vZHVsZSwgdGhlIGh5cGVydmlzb3Igd291bGQgYmUNCj4gYWJsZSB0byBt
YW5pcHVsYXRlDQo+IA0KPiBJcyB0aGlzIGNoYW5nZSBhY2NlcHRhYmxlPzoNCj4gDQo+ICAgICAg
ICAgICAgICBXaXRoIHRoZSBoZWxwIG9mIHRoZSBnenZtIG1vZHVsZSwgdGhlIGh5cGVydmlzb3Ig
aXMgYWJsZQ0KPiB0byBtYW5pcHVsYXRlDQo+IA0KSGkgUmFuZHksDQpTdXJlLCB0aGFuayB5b3Ug
Zm9yIHlvdXIgY29tbWVudC4NCldpbGwgdXBkYXRlIGluIG5leHQgdmVyc2lvbi4NCg0KPiA+ICsg
IG1lbW9yeSBhcyBvYmplY3RzLg0KPiA+ICsNCj4gPiArLSBWaXJ0dWFsIFBsYXRmb3JtDQo+ID4g
Kw0KPiA+ICsgIFdlIG1hbmFnZSB0byBlbXVsYXRlIGEgdmlydHVhbCBtb2JpbGUgcGxhdGZvcm0g
Zm9yIGd1ZXN0IE9TDQo+IHJ1bm5pbmcgb24gZ3Vlc3QNCj4gDQo+ICAgICAgcy9XZSBtYW5hZ2Ug
dG8gZW11bGF0ZS9UaGUgZ3p2bSBoeXBlcnZpc29yIGVtdWxhdGVzLw0KPiANCj4gb3Igc29tZXRo
aW5nIGxpa2UgdGhhdC4uLg0KPiANCj4gPiArICBWTS4gVGhlIHBsYXRmb3JtIHN1cHBvcnRzIHZh
cmlvdXMgYXJjaGl0ZWN0dXJlLWRlZmluZWQgZGV2aWNlcywNCj4gc3VjaCBhcw0KPiA+ICsgIHZp
cnR1YWwgYXJjaCB0aW1lciwgR0lDLCBNTUlPLCBQU0NJLCBhbmQgZXhjZXB0aW9uDQo+IHdhdGNo
aW5nLi4uZXRjLg0KPiA+ICsNCj4gPiArLSBJbnRlci1WTSBDb21tdW5pY2F0aW9uDQo+ID4gKw0K
PiA+ICsgIENvbW11bmljYXRpb24gYW1vbmcgZ3Vlc3QgVk1zIHdhcyBwcm92aWRlZCBtYWlubHkg
b24gUlBDLiBNb3JlDQo+IGNvbW11bmljYXRpb24NCj4gDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaXMgcHJvdmlkZWQNCj4gDQo+ID4gKyAgbWVjaGFuaXNtcyB3ZXJlIHRv
IGJlIHByb3ZpZGVkIGluIHRoZSBmdXR1cmUgYmFzZWQgb24gVmlydElPLQ0KPiB2c29jay4NCj4g
DQo+ICAgICAgICAgICAgICAgICBhcmUgdG8gYmUgcHJvdmlkZWQNCj4gb3INCj4gICAgICAgICAg
ICAgICAgIHdpbGwgYmUgcHJvdmlkZWQNCj4gDQo+ID4gKw0KPiA+ICstIERldmljZSBWaXJ0dWFs
aXphdGlvbg0KPiA+ICsNCj4gPiArICBUaGUgc29sdXRpb24gaXMgcHJvdmlkZWQgdXNpbmcgdGhl
IHdlbGwta25vd24gVmlydElPLiBUaGUgZ3p2bQ0KPiBtb2R1bGUgd291bGQNCj4gDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVGhl
IGd6dm0NCj4gbW9kdWxlDQo+IA0KPiA+ICsgIHJlZGlyZWN0IE1NSU8gdHJhcHMgYmFjayB0byBW
TU0gd2hlcmUgdGhlIHZpcnR1YWwgZGV2aWNlcyBhcmUNCj4gbW9zdGx5IGVtdWxhdGVkLg0KPiAN
Cj4gICAgICByZWRpcmVjdHMNCj4gDQo+ID4gKyAgSW9ldmVudGZkIGlzIGltcGxlbWVudGVkIHVz
aW5nIGV2ZW50ZmQgZm9yIHNpZ25hbGluZyBob3N0IFZNDQo+IHRoYXQgc29tZSBJTw0KPiA+ICsg
IGV2ZW50cyBpbiBndWVzdCBWTXMgbmVlZCB0byBiZSBwcm9jZXNzZWQuDQo+ID4gKw0KPiA+ICst
IEludGVycnVwdCB2aXJ0dWFsaXphdGlvbg0KPiA+ICsNCj4gPiArICBBbGwgSW50ZXJydXB0cyBk
dXJpbmcgc29tZSBndWVzdCBWTXMgcnVubmluZyB3b3VsZCBiZSBoYW5kbGVkIGJ5DQo+IEdlbmll
Wm9uZQ0KPiANCj4gICAgICAgICAgaW50ZXJydXB0cyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBhcmUgaGFuZGxlZA0KPiANCj4gPiArICBoeXBlcnZpc29yIHdpdGggdGhlIGhlbHAgb2Yg
Z3p2bSBtb2R1bGUsIGJvdGggdmlydHVhbCBhbmQNCj4gcGh5c2ljYWwgb25lcy4NCj4gPiArICBJ
biBjYXNlIHRoZXJlJ3Mgbm8gZ3Vlc3QgVk0gcnVubmluZyBvdXQgdGhlcmUsIHBoeXNpY2FsDQo+
IGludGVycnVwdHMgd291bGQgYmUNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgIG5vIGd1ZXN0
IFZNIHJ1bm5pbmcsIHBoeXNpY2FsIGludGVycnVwdHMgYXJlDQo+IA0KPiA+ICsgIGhhbmRsZWQg
YnkgaG9zdCBWTSBkaXJlY3RseSBmb3IgcGVyZm9ybWFuY2UgcmVhc29uLiBJcnFmZCBpcw0KPiBh
bHNvIGltcGxlbWVudGVkDQo+ID4gKyAgdXNpbmcgZXZlbnRmZCBmb3IgYWNjZXB0aW5nIHZJUlEg
cmVxdWVzdHMgaW4gZ3p2bSBtb2R1bGUuDQo+ID4gKw0KPiA+ICtQbGF0Zm9ybSBhcmNoaXRlY3R1
cmUgY29tcG9uZW50DQo+ID4gKz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiAr
DQo+ID4gKy0gdm0NCj4gPiArDQo+ID4gKyAgVGhlIHZtIGNvbXBvbmVudCBpcyByZXNwb25zaWJs
ZSBmb3Igc2V0dGluZyB1cCB0aGUgY2FwYWJpbGl0eQ0KPiBhbmQgbWVtb3J5DQo+ID4gKyAgbWFu
YWdlbWVudCBmb3IgdGhlIHByb3RlY3RlZCBWTXMuIFRoZSBjYXBhYmlsaXR5IGlzIG1haW5seSBh
Ym91dA0KPiB0aGUgbGlmZWN5Y2xlDQo+ID4gKyAgY29udHJvbCBhbmQgYm9vdCBjb250ZXh0IGlu
aXRpYWxpemF0aW9uLiBBbmQgdGhlIG1lbW9yeQ0KPiBtYW5hZ2VtZW50IGlzIGhpZ2hseQ0KPiA+
ICsgIGludGVncmF0ZWQgd2l0aCBBUk0gMi1zdGFnZSB0cmFuc2xhdGlvbiB0YWJsZXMgdG8gY29u
dmVydCBWQSB0bw0KPiBJUEEgdG8gUEENCj4gPiArICB1bmRlciBwcm9wZXIgc2VjdXJpdHkgbWVh
c3VyZXMgcmVxdWlyZWQgYnkgcHJvdGVjdGVkIFZNcy4NCj4gPiArDQo+ID4gKy0gdmNwdQ0KPiA+
ICsNCj4gPiArICBUaGUgdmNwdSBjb21wb25lbnQgaXMgdGhlIGNvcmUgb2YgdmlydHVhbGl6aW5n
IGFhcmNoNjQgcGh5c2ljYWwNCj4gQ1BVIHJ1bm5hYmxlLA0KPiANCj4gVGhlIGVuZGluZyAicnVu
bmFibGUiIGRvZXNuJ3Qgc2VlbSB0byBmaXQgaGVyZSAtIG9yIEkganVzdCBjYW4ndA0KPiBwYXJz
ZSB0aGF0Lg0KPiANCj4gPiArICBhbmQgaXQgY29udHJvbHMgdGhlIHZDUFUgbGlmZWN5Y2xlIGlu
Y2x1ZGluZyBjcmVhdGluZywgcnVubmluZw0KPiBhbmQgZGVzdHJveWluZy4NCj4gPiArICBXaXRo
IHNlbGYtZGVmaW5lZCBleGl0IGhhbmRsZXIsIHRoZSB2bSBjb21wb25lbnQgd291bGQgYmUgYWJs
ZQ0KPiB0byBhY3QNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0
aGUgdm0gY29tcG9uZW50IGlzIGFibGUgdG8gYWN0DQo+IA0KPiA+ICsgIGFjY29yZGluZ2x5IGJl
Zm9yZSB0ZXJtaW5hdGVkLg0KPiANCj4gICAgICAgICAgICAgICAgICBiZWZvcmUgdGVybWluYXRp
b24uDQo+IG9yDQo+ICAgICAgICAgICAgICAgICAgYmVmb3JlIGJlaW5nIHRlcm1pbmF0ZWQuDQo+
IG9yDQo+ICAgICAgICAgICAgICAgICAgYmVmb3JlIGV4aXQuDQo+IA0KPiA+ICsNCj4gPiArLSB2
Z2ljDQo+ID4gKw0KPiA+ICsgIFRoZSB2Z2ljIGNvbXBvbmVudCBleHBvc2VzIGNvbnRyb2wgaW50
ZXJmYWNlcyB0byBMaW51eCBrZXJuZWwNCj4gdmlhIGlycWNoaXAsIGFuZA0KPiA+ICsgIHdlIGlu
dGVuZCB0byBzdXBwb3J0IGFsbCBTUEksIFBQSSwgYW5kIFNHSS4gV2hlbiBpdCBjb21lcyB0bw0K
PiB2aXJ0dWFsDQo+ID4gKyAgaW50ZXJydXB0cywgdGhlIEdlbmllWm9uZSBoeXBlcnZpc29yIHdv
dWxkIHdyaXRlIHRvIGxpc3QNCj4gcmVnaXN0ZXJzIGFuZCB0cmlnZ2VyDQo+IA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaHlwZXJ2aXNvciB3cml0ZXMgdG8gbGlzdCByZWdpc3Rl
cnMNCj4gYW5kIHRyaWdnZXJzDQo+IA0KPiA+ICsgIHZJUlEgaW5qZWN0aW9uIGluIGd1ZXN0IFZN
cyB2aWEgR0lDLg0KPiANCj4gDQo+IEhUSC4NCj4gLS0gDQo+IH5SYW5keQ0KDQpCUg0KTGlqdQ0K

