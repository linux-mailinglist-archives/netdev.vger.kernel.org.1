Return-Path: <netdev+bounces-151624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4599F0477
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 06:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA5B284433
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 05:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373B918A93C;
	Fri, 13 Dec 2024 05:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IeY3RfMk";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="phZUhjX9"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5090C6F30F;
	Fri, 13 Dec 2024 05:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734069472; cv=fail; b=pH0tkf9P+TV3IdeU+3P7TSYL/UxQrOcoK97XRh0Nymb6lk/9w5Zqe0WUpRPaxacnaxV/VSJtpPTsMLs8bAtcdJJPIi6tCdGHOk0EtCGVhdB6G89rVpVdL/CHqbc4uHQN8Wb2myhS9YQFrbBPl37ThPAjwg0BErso2XT0KSD9qrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734069472; c=relaxed/simple;
	bh=qLWMoNbeqY84cESCWVfsNOf+8OmkCLP+G6E8CsuZzBc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ho3bd2wLd6XLPu9S0eRgykLI1lYM+WrcXMIlK/M+F+7NtZRQRNaC1d5/ACv3+F1Moen1Mwt288IIFFu6xGJ2XigLljjNGmctiiozshOPFznnVy+0QiVzL1IkmGmvpUWYoQxBqhSuUpMkZ2UQVEh+faVWpALmuGamMnBk/o/1zKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IeY3RfMk; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=phZUhjX9; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 28203e6cb91711efbd192953cf12861f-20241213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=qLWMoNbeqY84cESCWVfsNOf+8OmkCLP+G6E8CsuZzBc=;
	b=IeY3RfMkTtL1VWuk30hGkkGBNyryoaKV3BEnGJCvEcW++Ttz1NMj7fH6PRLRbS0TbNguxSF+ymsZl1M2h/WUB8CFG+QVxZtM4jaRNEAulSXWyckVaXeRITR1yQOZg7WxXd0ZtPZ8YAadp52qazZ0gD06UxBjWArc1AY9kyueuCA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:904d99c9-2c95-4adb-8f27-68b502fa68dc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:2da21113-8f5d-4ac6-9276-7b9691c7b8d6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 28203e6cb91711efbd192953cf12861f-20241213
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 50639644; Fri, 13 Dec 2024 13:57:38 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Dec 2024 13:57:36 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Dec 2024 13:57:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJcv2ACnctwR0vGfCSjcuMoobIl1k52lxcuwnYCMmqGlZfLskIEzcMxjDNJqByKTZLE+c/DS9lipLF/y/ZJuO48ZHFeY3a2uCrLRFZ+n+ierpdnYn+ygG7mAaQ53FSdYMn4uy5G25ZblUHYNO+3U7ban0yAJJEE9CK5zC8DXDsXL2WeTN1vwf1MMc8YOaxyJIgC59Eycpq9sPxllKMWdwlEkNm2tFYFuVxrfLT28F682viEcbBGNX2wwOfzA3wSadimI2pwywQCIwmbJiUCTFyPRkz/Q9MHxWLIbsonpAkYBYwnWVz+3kHbJsaS4W/zp6f2TAUz2dnh26ROIrxuQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLWMoNbeqY84cESCWVfsNOf+8OmkCLP+G6E8CsuZzBc=;
 b=WvNLjgVqx1yR1k0O1y+45FQJ6KJoYRyHrlb4kkUwbgJAQD8gfVTNKLUqABMcQ33gj8NV7S+iRu73EL8oz9f50ycXkBensRImi2ZBse6BNYZC0ZSUGmaMb7mDLGZVyMLuZjbQw3CxCx0KgBGsEq4LQwcd9IQhapx0YG0IAexDOjRBesUdI8Hy+8US+GM5wjRkGakg3v1VglZ84M4JfoAHOGQCv46jR3AVwKKOEGGOavPGcrB+4kF2HyHi5TMFk5SbQwVvy4DVQ3LHhXEnkkKDvG0NbDlyt5bDZ4nIc8nn3f+/W//TE4Df2G4jBmLv9UMoV4gmoevGo+dDGSom4eCPiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLWMoNbeqY84cESCWVfsNOf+8OmkCLP+G6E8CsuZzBc=;
 b=phZUhjX9/rc+woIhjjO0wwGIFRUAyi9sQbJWa5/Y6QOxfo/JWN/XGkZsaiZULooPx03Iiz/QxpLXIQ3wneXe6eVkSV8FFpOMe2nOr7spVaUlsNcrjZHiovdoInMGhwcPDIPLdXQgnsYmpdWirVFb/hbxFKsiKLMiOSP/oh3bAPc=
Received: from KL1PR03MB8285.apcprd03.prod.outlook.com (2603:1096:820:10e::13)
 by SEZPR03MB7591.apcprd03.prod.outlook.com (2603:1096:101:132::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 05:57:34 +0000
Received: from KL1PR03MB8285.apcprd03.prod.outlook.com
 ([fe80::fc6e:1c9b:c9c6:ca6b]) by KL1PR03MB8285.apcprd03.prod.outlook.com
 ([fe80::fc6e:1c9b:c9c6:ca6b%4]) with mapi id 15.20.8207.020; Fri, 13 Dec 2024
 05:57:31 +0000
From: =?utf-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?=
	<Liju-clr.Chen@mediatek.com>
To: "corbet@lwn.net" <corbet@lwn.net>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "krzk@kernel.org" <krzk@kernel.org>,
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
Subject: Re: [PATCH v13 01/25] virt: geniezone: enable gzvm-ko in defconfig
Thread-Topic: [PATCH v13 01/25] virt: geniezone: enable gzvm-ko in defconfig
Thread-Index: AQHbNn01wa/NjP5Jt06CzkTKxIxBpbLg4z4AgAL3kQA=
Date: Fri, 13 Dec 2024 05:57:31 +0000
Message-ID: <d711de9ef517cc85fbb16a30ac21bd4c44c8f863.camel@mediatek.com>
References: <20241114100802.4116-1-liju-clr.chen@mediatek.com>
	 <20241114100802.4116-2-liju-clr.chen@mediatek.com>
	 <1ecf2e8c-86cd-4ba2-832b-014a05a80d26@kernel.org>
In-Reply-To: <1ecf2e8c-86cd-4ba2-832b-014a05a80d26@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB8285:EE_|SEZPR03MB7591:EE_
x-ms-office365-filtering-correlation-id: 2041a8cb-b743-4fd5-6838-08dd1b3b0859
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?Tnc4T3puenlyTTZVcjM3K25qRGl6ZDl2cFlOY0F4bFJ5aTZuZkFiTjNyRWQv?=
 =?utf-8?B?UVdiQzJ2NXErL3BqVXl5OVlISG9WREU2QXhFM1VmUnBNbmhTUldPcGRYSU9U?=
 =?utf-8?B?Yk1JU0FmeG04alREUW5sYVFQd3dhVXBqU2FzVy9UVy83dlMzMVFTUGlXYzRx?=
 =?utf-8?B?QlZtbU1TWXM4NkVYMXpDZ3lJUjRmM1ViRllJUUt2NDZrRjJOcTIrYWlWMnAr?=
 =?utf-8?B?QjZzUUxpY3kxNWQyQkIyOU9FY0VuUldPWW9WVkJzRmV2cUFJaEZqRU4zVTNG?=
 =?utf-8?B?RWwrSE5XV2pDZU1VNUE3TWxIYWJodlYwRHJGcVRWWGJ4MFNIRGJsbDhLOFVw?=
 =?utf-8?B?NmVYbDFXYktXVXNsTDlVN0NvRGlvZFgyTDVCZWpLa1owRFFzcW5ENFdHb3lC?=
 =?utf-8?B?eXJKNjIyd0FUS1FtMzhnNEkyOTcxclFDSU93REFITXBuY3ZVdE5XWWlTRXZr?=
 =?utf-8?B?ODVYeWhHOGxUOWhvUDJOdFlHTmx2WEVwbERlb25IQnZHZVNqbUhkVy82Umdz?=
 =?utf-8?B?dkFoMTJRUnhkY254ZG8zTGlTWUpMcVBjeWd4cTl3YVJYRHNsZ2lCbmx4UTBx?=
 =?utf-8?B?RU1xVWFINFdSSUEvUlpJdG11NXZESnptOURWS0JzSXZBU3RHRERVRE4weDcv?=
 =?utf-8?B?VXN2bUtBMTFNQ0VVWkc5Y0prRlkvZysyd1dsYk5kcVBpRnVBc3M3azRkQ2dL?=
 =?utf-8?B?U3YzYXBwR29xaTRiZVhTby9leUN5eTBsK0M0VERFLzBkeXhJQmRqVVR3QXgy?=
 =?utf-8?B?M0REb1lvOWE1TWMzZFlEY1J0MktMTDd2RkRVVlNaUk9NTitQaVpNS2hKUVRX?=
 =?utf-8?B?czQxbGZuMzZrWldlbXJYdlhWNnJzQy8vREQrOTJvalpkM3ZlcWJUbU1lUTd5?=
 =?utf-8?B?eWNOVGc3UXM2dk5mcGRtQnVCckF1M2NKdWl2SE9wRFRyeEdaVnpTTncrM3JL?=
 =?utf-8?B?bGxEY3hibmU1VlFGVHR0VWRzZW80T3RQTDVYQ1JtY295RVRyc1AzQ3RBdXF5?=
 =?utf-8?B?M042d1ZuMlVUNnAxZERwZzUwaENLVU41VlEvSW1PVXF1SU5aQjB5OGRHL1hK?=
 =?utf-8?B?THFoV0I0N2JWY1R1S3FNMjR0Y0hDd0hJY3FKR21LU2JzUnUxU1N4NTJpa2hB?=
 =?utf-8?B?bW1FR1YxK09oMk9iM3o4RE5mS1hPaDlMTVpwemo1ZDJDeGlKRDRGaGlNMDh5?=
 =?utf-8?B?bVZoc05VUlVRVkNXRmtOaFE3cVJZYkxSZlJscDJlNHNEeDI3OUt0MXhyWWMx?=
 =?utf-8?B?Q2Rqa1VoR0ZPTnNEKzdaMllFclZnTjJIWXlnVnNWcEFTYmZ6a21YT3JFdTg3?=
 =?utf-8?B?V2tMazNLdGM4bEdSeDV2dXVBeHdYZkhFTnRDNlJQTkZoVVBhYS96YmdWVWJv?=
 =?utf-8?B?QnRRVXVJUUVpVWdjU1dQdzhDVmRhSGcxMjBPQzRzRDd2b2N5ekc5TTFEZFNq?=
 =?utf-8?B?RWt4TXFlVjd2c2hMUlkzdWc4MlpzWFZFam0zNDkrRmFGL1lSVWhlTkEwbUJI?=
 =?utf-8?B?MTBBNXFCS3N3N1RITklVeDd6MER6NC9lTVlZdWtGYXprZWRydFNqTlI5OTJK?=
 =?utf-8?B?dlFvU3ZhMWJlNVUyamorWU5zSGQveHhONVlKRWoxZGlEY2p5OGtjZ1h1MTA0?=
 =?utf-8?B?Y1c5Q2Y5VU5KVlBVQTR1ZWJ4NWFhNDZQU29tOFp1ck42TytpR3Ztdi9KRWR5?=
 =?utf-8?B?RnR2TjFuZmxzSmxIUEFvV3l3Z0xPZG1TRDFIbjZSMFRvOURmTlR4UmVpUU44?=
 =?utf-8?B?bnJKZFFiSm1YMUNZSGFaUGhoS0htd2tzbVpLaVFFNGVoeUYzbTJUcnV1RkdX?=
 =?utf-8?B?R0Vwa1kyWU5uYzVpZ3Yzb3VLWTZJVDZjdzgzaEx5WFlNYVcxMEF3VUtTMk41?=
 =?utf-8?B?U3R2c2dnMGxjZ3FRTHZBbmdpN09OL21sVytyL3lpUHJpVlFRdGdxVUlSaWNq?=
 =?utf-8?Q?3mJ0UFTvUDrhNkjO1uNVXI/3s4jiC0YP?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB8285.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHNyQ3BBN3h3eWl0b3BuVEpvS0ZsNzF4L21HV2YwaHV5RENTY3pDOExYeDJZ?=
 =?utf-8?B?bjM1dzZCL1ZzVHloZVRtbVVwM3JUOGIwc0dCL2VvK050cEF3SnBpYUlJeGJl?=
 =?utf-8?B?aXM5MWE0QWoxWEVGSDI1bzVpdFZhYmg1UUkyTnJENkwxS0ZVZVdsTGl1ZFc4?=
 =?utf-8?B?SU9yTHV1eE1TUjZTTFdPZFYzZVJkdG9oTWJnS093bmJRUHdBRkVmZ2hZeTdZ?=
 =?utf-8?B?SzkyNjNtQTVnZCtVUEs2RUZYTFppZ3RPVkFhc0NuUU1ReHl3bmFZU2kzZzk3?=
 =?utf-8?B?UFM3MlVwV0FuN3RmSmkrdDNKK1B4NldGWGVYZ1BYZ3VZdUhGaG11MStWaTVM?=
 =?utf-8?B?Q05YM3BwQlBLdDh3aGppbyszd1V0WHFHLzhENktEeTAxWklTVmJLVTI2MlA4?=
 =?utf-8?B?TldRaVRVMjd1ejhlbnNTL2FZcTcrVk5oYXZrVDFBeHUzeWVyNXlGblJPWlBF?=
 =?utf-8?B?dHB2VG1kdTh0ZFk2RU9GamJJWU4zcHFpbG9ubEZ6aFFaamQ2UXpqZDdwcTll?=
 =?utf-8?B?VGJZY2tGUzkzS0lhYzhsaGZHSVk3Z0g5MjIxWXRHSVJxVFRmUW9VSXhFU29q?=
 =?utf-8?B?QXpPRGNuZWQ5WG9rb3lYeFYrZUIyV0pVY0o1aWVtVGpLSSszeGtEek9Ncnda?=
 =?utf-8?B?Q01mQk9lWmpNdmJsNjhkUGN5WnFzcTlHM2U5dmdUWkx3aGg4TkhJekxkK0ZC?=
 =?utf-8?B?b2ppdmJqY3BOSXJwQXArSFJJSlhJOTJCQ0p1ODA1Uks0eldLWVQ1L0NPVXFr?=
 =?utf-8?B?YnZwbXVYUGk4WDVERW1uMUZGQjh0RGpxN3lUVmJTcDZtdml1cGJUaFlrbW9t?=
 =?utf-8?B?MGFkclRCVjVnbTA4YmFQUjBpMXA0SEt3MzRuQ21JUXY2blJ1QnZQMVZnSE5j?=
 =?utf-8?B?aUt2Ti9LQTJEY0c1N0Nzc0krbWpTUGFOMC9ITnNLZ29ESThXUzZLUjlMVzlU?=
 =?utf-8?B?V20wVTErbjdYQXZ2M0ZXdzhBNnY2RUw2Y3lQZnEwWmFSM0pCeWh3VGNCWGhw?=
 =?utf-8?B?bXZoNFJtOEs4Rlpwa1gwSDJMVFR5ZEdockxhc1BNalc0SForcWZyWDZLTnhy?=
 =?utf-8?B?aVVhcTZiQ0F1alZvRytKR2d3MlNmbExxODNBNlkzNDVPcGF2K1E5UVhNeFJI?=
 =?utf-8?B?RlhhTmFib0lBTlE5dWQ1WGk5UHZlTmU5M210M3RuRkNpSjQ4MVVIZmQ0ZTdz?=
 =?utf-8?B?TmZqdVlJNkVJbXIrbCtSWlpHUjFBVVd3bEU1WUwrdjg3Ti85aEhZNzhxWmdn?=
 =?utf-8?B?SHN5R3JGcDJnVzQ2U1RiT0ZJU3QveDRVZlRjSHlTaWFrQ0JRTEMrTm9tL09s?=
 =?utf-8?B?NU4wSDN4cmdVazhrd09vbkgwQjd0ZDM0aC9DbXN2aVc1bm4wYno1K2RObzNH?=
 =?utf-8?B?eTE4Wm83cUNmQ2RuclZFSGROMVRRR1VYV0NwUFE5TEUvVi9lNXlDa3RqY1p3?=
 =?utf-8?B?d2NGZFo0VnNoM2xlWTV3bEtRc0ZHazBwd3V5dG9OSkN5T1R5V05tVE9Ub2E3?=
 =?utf-8?B?MXkvcnpJUlhtcEQwV1FVUEZ4dWNVQmxzbEpLUHkxRm56aWFaS1kzUUdBbjBT?=
 =?utf-8?B?MXZBZFQ0MlJkdFVkZDdkZUJGV25DRVN0V0EydWNyenZzemRiN0R0SitPdFpC?=
 =?utf-8?B?NTVUYklBV3ByQmdTeVg2VjlXY0JRT1kwMmluTmlDdWNTVitObFhQbytlTFlG?=
 =?utf-8?B?YU55dlVTSmY0NG1aSmRKdXRjZnBia3ZONmZPZFVVYmVSbzZsN05rdmxwMDhD?=
 =?utf-8?B?c0FLelcxN2FBb3ExN1JZWVNmUWZXN3ZoYUc5T1NsMXYrQnRtTERIK3hzT3FS?=
 =?utf-8?B?RTFVUlQvVUFkU3F3bjBIaUxCZDd3anltL093ZytQUXNwVEFTQTJDQ0VvaDhF?=
 =?utf-8?B?U1RaL2FPRnEzVGZRd0g4Z1Z5RklmNjVYb0doQ2tGQlQ1b29nc3JGT0FLQUR2?=
 =?utf-8?B?RE5JajdxRTl2YkhpMUFiWUFHL1ZURDNqUXZ6Z2JKcEFnM05XTk9TZ3dSNk41?=
 =?utf-8?B?TUNDRFVyZ3ZVRVpEYkVYeFVUK3lyRzFraE01K29DS09UWUFSbFVvUW0vamVj?=
 =?utf-8?B?bmFRbCtQSUh6dElrTXdJWERBVG5xa3pNTkhZWkF1TThPbXJidzJ5VVoyRHRa?=
 =?utf-8?B?dUVWK0hoWDlETlNmSVpDSzVUTDdkTWcyamRGWWxEOUF0UGgrZnBGMEtUVENa?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A227F33B0CDCCD4A852017EF4861A399@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB8285.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2041a8cb-b743-4fd5-6838-08dd1b3b0859
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 05:57:31.3013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i4+RIVi3j+2nXOg2h00yMZYHkh4IgR9GCElu1NW16rWXG7V6f+GMbInSvDUarCj9hTEl9yAstef5nuREPpGRqj7b7Y9OgModBk/8/zEsF8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7591

T24gV2VkLCAyMDI0LTEyLTExIGF0IDA5OjM4ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDE0LzExLzIwMjQgMTE6MDcsIExpanUtY2xyIENoZW4g
d3JvdGU6DQo+ID4gRnJvbTogWWluZ3NoaXVhbiBQYW4gPHlpbmdzaGl1YW4ucGFuQG1lZGlhdGVr
LmNvbT4NCj4gPiANCj4gDQo+IFBsZWFzZSB1c2Ugc3ViamVjdCBwcmVmaXhlcyBtYXRjaGluZyB0
aGUgc3Vic3lzdGVtLiBZb3UgY2FuIGdldCB0aGVtDQo+IGZvcg0KPiBleGFtcGxlIHdpdGggYGdp
dCBsb2cgLS1vbmVsaW5lIC0tIERJUkVDVE9SWV9PUl9GSUxFYCBvbiB0aGUNCj4gZGlyZWN0b3J5
DQo+IHlvdXIgcGF0Y2ggaXMgdG91Y2hpbmcuDQo+IA0KPiANCj4gPiBBZGQgY29uZmlnIGluIGRl
ZmNvbmZpZyB0byBlbmFibGUgZ3p2bSBkcml2ZXIgYnkgZGVmYXVsdA0KPiANCj4gVGhpcyB3ZSBz
ZWUgZnJvbSB0aGUgZGlmZi4gWW91IG11c3QgZXhwbGFpbiB3aHkgd2Ugd2FudCBpdC4NCj4gDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWWluZ3NoaXVhbiBQYW4gPHlpbmdzaGl1YW4ucGFuQG1l
ZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZaS1EZSBXdSA8eWktZGUud3VAbWVkaWF0
ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExpanUgQ2hlbiA8bGlqdS1jbHIuY2hlbkBtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgfCAy
ICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZw0KPiA+IGIvYXJjaC9hcm02NC9j
b25maWdzL2RlZmNvbmZpZw0KPiA+IGluZGV4IGQxMzIxOGQwYzMwZi4uMGY2M2Q0ODM3YjYxIDEw
MDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcNCj4gPiArKysgYi9h
cmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQo+ID4gQEAgLTE3MzMsMyArMTczMyw1IEBAIENP
TkZJR19DT1JFU0lHSFRfU1RNPW0NCj4gPiAgQ09ORklHX0NPUkVTSUdIVF9DUFVfREVCVUc9bQ0K
PiA+ICBDT05GSUdfQ09SRVNJR0hUX0NUST1tDQo+ID4gIENPTkZJR19NRU1URVNUPXkNCj4gPiAr
Q09ORklHX1ZJUlRfRFJJVkVSUz15DQo+ID4gK0NPTkZJR19NVEtfR1pWTT1tDQo+IA0KPiBEb2Vz
IG5vdCBsb29rIGxpa2UgcGxhY2VkIGNvcnJlY3RseSwgYWNjb3JkaW5nIHRvIHNhdmVkZWZjb25m
aWcuDQo+IA0KPiBJIHN0aWxsIGRvIG5vdCBzZWUgYW55IHJlYXNvbiB0byBoYXZlIGl0IGVuYWJs
ZWQuDQo+IA0KPiBZb3VyIHBhdGNoZXMgaGF2ZSB3ZWlyZCBvcmRlciBvciB0aGlzIGlzIGp1c3Qg
d3JvbmcuIFRoZXJlIGlzIG5vIHN1Y2gNCj4gdGhpbmcgYXMgIk1US19HWlZNIi4gVXNlIGdpdCBn
cmVwLCBpZiB5b3UgZG8gbm90IGJlbGlldmUgbWUuDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiBLcnp5c3p0b2YNCg0KSGkgS3J6eXN6dG9mLA0KVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRz
LiBJIGFncmVlIHdpdGggeW91ciBzdWdnZXN0aW9ucy4NCldlIHdpbGwgcmVtb3ZlIHRoaXMgcGF0
Y2ggaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KQmVzdCByZWdhcmRzLA0KTGlqdSBDaGVuDQo=

