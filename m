Return-Path: <netdev+bounces-190112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6EEAB5347
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E3E17EF86
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD962857F9;
	Tue, 13 May 2025 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BKTTSbZf";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ZUD8u+Os"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE1527E7D2;
	Tue, 13 May 2025 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747133772; cv=fail; b=htm9bjW7B7JqPD7Ik5zZss2T1irb7i0sIKdrs37EdDCHFj/Pokli5C2FUHzhsr0q8p9d35OQ6o45eGvZ41IWJ1qrRnJokZovjBEFlFFyrtUUK97fectGLRn2TuCx6rfiW5/Wfpai83vOk11oTlJK/Jg+SaJ0knBeU4XfuuIcuRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747133772; c=relaxed/simple;
	bh=P1EFsiLqernbfwj2SPBI3YYISCUfuCotsiCnrKO/wCM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SW7yIa3AmwmON32/1aWq5srMn+Ldm4JAuU8praxfBFkQn2zEcddhxybV5zsvoPjmylDIkQjFcDmeuW7KuRm517QUYMJaiTa/MftN/tjFywXZLoWk/7ip+18WwT5vw4R4rPl7QZocd+8O+avbyjA9GaRQr/7rKUcbAkI7B5gqICE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BKTTSbZf; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ZUD8u+Os; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dd76d5122fe811f082f7f7ac98dee637-20250513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=P1EFsiLqernbfwj2SPBI3YYISCUfuCotsiCnrKO/wCM=;
	b=BKTTSbZfTedv2a5MNg2RqFkV5MXQta0kQYXkyOkWIG0o6v6rlnE/Wwm5IeXkiTQiw1Eg1LGWDj07Up5+VXJlCQrSjubGnakWgLLUZOncDEW8vJbQyoEaywjZbaldtMQzNIzKSql1orsBZZDYXDWlKvQRl7WxVzGIYXLPD5Dc8rA=;
X-CID-CACHE: Type:Local,Time:202505131812+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:1927e089-93db-43dc-b2c7-4422f7d4b691,IP:0,UR
	L:0,TC:0,Content:10,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:0ef645f,CLOUDID:ae58e8e0-512b-41ef-ab70-9303a9a81417,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:4|50,EDM:-3,IP:nil,URL:80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: dd76d5122fe811f082f7f7ac98dee637-20250513
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 835511462; Tue, 13 May 2025 18:56:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 13 May 2025 18:56:02 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 13 May 2025 18:56:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W59Tk25K7qhYScWc60G1U+h6VXhGoj0szH+p6wvpWcMDgtiwEyk1f4cZJI6eZIRjhruxv5I8olv+/IEpZhvegxfWX3T6IU/sZjEiN+RL0ok/2cym8XqPgIBHAgBH5n5QK8bKzIOPwk4Ih/RJLD/C0njEn1oiqk9Bt4Ussrn1pjpc0Rj5AumroIqWK22sSDoXXAr4LlgwPONFce2JU3eiB+yxh2pWHL+dfuyyjeizZEIjIRfATGmgSSNy5cTpbUaV7/Rc3MgGQ5S5LMlgNSW+Gn2n1tQZF+r9/VdRYxEVtAEarFMsXz1AGP/YAluHBKdI4dMf+wgmtVdbfP+tzeYOKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1EFsiLqernbfwj2SPBI3YYISCUfuCotsiCnrKO/wCM=;
 b=d3u2aJIbIL0k8gGMtNlifEweGuehHNf9wpe3wEDEczi4tIY6tKbs5O1QMw0W+/ZgLGlJ1jQMxbqauRvjI2tf4vgP1CMZNnBzR1kpFUpsJYSszBzmg7LDPVvttIbq+E7sD7tQQ76wEhkmMLEHOKPRVnnxRawv8z78HLHY++JpK3/ExEqUZBi3hpcI2S+MwOFUrc/wKaI3D0d0tbKk0ffYN4AGeFtAn2TrtVYI2tnTtnsxEK4J13vQscxaWUJNy2u+mv7sIylbRCZI+euQfvJvsSpAYoxrypyoNRrw+vBFIkbIlAg1WI9R0LdDEN8M36lPpsWIkMW9I8Y7BqYvB30Srg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1EFsiLqernbfwj2SPBI3YYISCUfuCotsiCnrKO/wCM=;
 b=ZUD8u+Os9N9dnLDpxNokgTEtgFGahCum8Qmnw0YG3fwvlikX2TXgMAAGeECbTWZd8ppOoDnr+fZyZJhzRtsHBHQo699w9lq3skvFB/h+RFrZM51yng6+nwwsSz/X9+YTrOXDDNqlfppz6/JwA1tThKuh2G+EnqGkhk3TRx8yCOA=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TYSPR03MB8157.apcprd03.prod.outlook.com (2603:1096:400:473::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Tue, 13 May
 2025 10:55:58 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%3]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 10:55:57 +0000
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
Subject: Re: [PATCH net-next v2 3/3] net: phy: mediatek: add driver for
 built-in 2.5G ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v2 3/3] net: phy: mediatek: add driver for
 built-in 2.5G ethernet PHY on MT7988
Thread-Index: AQHbgqn0+oUccgrII0yLc8X4a8i6V7NOxe+AgIIf8IA=
Date: Tue, 13 May 2025 10:55:57 +0000
Message-ID: <062fff7f65bb9654922be4cac34e3c6fe01d7029.camel@mediatek.com>
References: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
	 <20250219083910.2255981-4-SkyLake.Huang@mediatek.com>
	 <724eff11-c6d1-40e1-a99f-205f5426a07d@lunn.ch>
In-Reply-To: <724eff11-c6d1-40e1-a99f-205f5426a07d@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TYSPR03MB8157:EE_
x-ms-office365-filtering-correlation-id: cfa666e2-132f-4ea2-ed33-08dd920cbddf
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SEtuL2NILzh6L3VEaUtVVDNoZlFnRDNZVTlCSUlVc1NGQThsTjdSdXFqUHRK?=
 =?utf-8?B?VXJRaXE3aEVRU2hlVVd3N3MwOERhSGluenY3SWwwblFiM2RueElGY2tGbFFw?=
 =?utf-8?B?WFJQWWFzMnJ3MVRQSW1sYU9RaE00ODV1VUk0ZUtVTFRmYlZJZFFUNGJ6Tzh1?=
 =?utf-8?B?M0t2L3I1dWttNWFaeVM5eWl3UlZRKys5aHN5NmhTaFhkVDFrdXRSZHlDcG5E?=
 =?utf-8?B?NWVZcFpBLzJIenU5QjI3VCtXZGlscUNHKys2Y2VIcE9RMmgvWTRaR0tlei81?=
 =?utf-8?B?UVFoZkVWRlB5RmVMZGQvL2tCY1c5UTh3NEdaVmRHQ0liVU5HRFV1cEx1MTM4?=
 =?utf-8?B?ekxoNmhCSWhXMDdZcTVxZVRqNE5mOXpZK2YvVkRoS2wrUlkrU0duazBEbkRC?=
 =?utf-8?B?cUxjeFVSUVJXODR3VGVDakFrZTFtMHJnQmgzeVN6dHYraFFTSXN4cjNNRUox?=
 =?utf-8?B?VDdsT0k5LzUxc1FkdVVGUWhiQ0xyTnpSMGdkWHVSSGFBd0g2bWMwR25qV1lk?=
 =?utf-8?B?SG9zK0lLK2lLNTRJZGRXTUs2Rmxha1o2UkI0OXNPeWZPMFBxb0p1VnlIVVNr?=
 =?utf-8?B?RjJ6WHgwR0g4cndoY3B0dmd5eWxwRlVpNFFPOUhlTnl6WVFZT3VBT3NXeVlS?=
 =?utf-8?B?Z3dyemRjTkIzMHBPR1dXSlRWRDRMc2pRdUkrblkwZ2p0eXRKWml2VHk3Nk1M?=
 =?utf-8?B?a3VjY3IzQ1dXSm9EZ0h0eThNdkpxRXU1YjRIR0dBdTRQaU5HMVR2aFFGckxq?=
 =?utf-8?B?QnlBQXQrLytuTG5VUXhqZ3dtV1ZQQTV3YVZvSkVhTXpjZ1BmTTRwSElKL2Js?=
 =?utf-8?B?dVVnVklyVzQrL3F0WE16Zlo1SlUySkZEV1dpYU5veUhKdWRJdjc5WXdUWENa?=
 =?utf-8?B?K0RKVFdHZDVrUVIzOXJ1WGlpRStNMlVCeVhLRlVVYnZzQmNJYzhQMWFhZmE2?=
 =?utf-8?B?UHNFcGc4MTRaaUY5NlRkYnFVSlpMQUVrNHkzeEJ4OXlmdUx3OXhvM2dVc3Yx?=
 =?utf-8?B?bFhMZEZuNUVud2FzNFYwOWRxUmI0UjJWdyttS3ZJYUJVV3d0aFlQdzA4RzVQ?=
 =?utf-8?B?Qm1RUHlVbFk5UlhUYkNkU1pzVkhBaHdKQzRoVnRNTEkrMUVXTnNpVXV6S3c3?=
 =?utf-8?B?anhQTThLVWVlYmdsZ0ZOcXNuai9HekdCRTV4bThZeFUzQktZZjExSHRNQzRl?=
 =?utf-8?B?cXpRdHRlNkttYzZOdlVvSm5VMytuSVh5TFJvR2tVamUxWjNIbGVjbFFGdkMy?=
 =?utf-8?B?emdFblpXZysrZWxiSEQ5SUJLODJ0aXRpWktCUGg0OXFmTVpsQTNYMzhmd1VZ?=
 =?utf-8?B?c05idGFHVml1L0RObmRtU01kNmp3ZlNKYzBwVDVHbEZpL2dreWJMSUpMRWdG?=
 =?utf-8?B?VExQdDltTVA3eURpbTlyb09NeHl4bzVPVFR5azI3MnFyQVhqUll0V0lkZHBz?=
 =?utf-8?B?VENqcXROQVh5YTlwc1BHVjhlYndEYkZEbDFTVWhXM3hrZTZQSXYvSnhjZjBR?=
 =?utf-8?B?dUJSMDBqNXJrUDlLU2JOZkxnVzRpaHJhYVp0RllPYWM5a1dRNHUrQm01Sk5I?=
 =?utf-8?B?cW9JNUpBQmNiUkFzUE5sMU9FNXNMVVdtTm9YL0pwZEF4T2xhWkJMZTVPTERk?=
 =?utf-8?B?NW1SSXRzTGJYRG0wY2J1K2J4bkRQeExnWTFhVDhaZHozWm9FN0JEWmNwWTZ3?=
 =?utf-8?B?WUtMd09XdWJheDRrUXNoWURNYlBOQ1BaUURqaWtIbU1JOXlVeXB3ODhVdC9Q?=
 =?utf-8?B?NmdPelA4NXhJUnNVajlqK3NNUjM3bGs5eGhZaVgzQWdqclZyMTZ4bUxKMkcz?=
 =?utf-8?B?NG5FY0dUZWF6SlJySlRqYjNrUkVHRldNNnRzb0JXQzErYkhMOUlGQXdoWGk4?=
 =?utf-8?B?K0dKaE1RUGxxTDNoQXIyN0tnZ1ArcFBlWlZVb1ZLU1BUMVptZ1ZWVGdhc21l?=
 =?utf-8?B?NGVtNVNSZVY5dmtKWlNjMTIyY2txNnFCQVFqTkk3VW5lckNGVWI0TlRhS1A4?=
 =?utf-8?Q?5pSkEH1cbkGAGesZMD1kqFEHQfKbyg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUgzbGI3VlVndmxEMXJaNUJOTnVxQURQZVIvdGdUZ2JidGFkNWxNZ2Ewb0dt?=
 =?utf-8?B?aDE4a2E2VEY3eldCcHN3UmhlU2RORWtzSGNMT2dIQkQ0U2JZOUlmdDVLdFNE?=
 =?utf-8?B?QzNkRlNWcHpjSzNQMnYzSjBHZ0ZOWWxnMWI5U0xGNXo3WHFiTmYwYWhMa0pJ?=
 =?utf-8?B?MllPbUEzZGZHWGJITUJ4WTEyTExVUDhFRnZ6QWM4eWJlZlJLcTBnZnhEM1E0?=
 =?utf-8?B?cHV3ZXdtalRLQ0xmZG5VWVJWbjBmN2h4eC9iRmtNd092aW5PbFhackhoUG9i?=
 =?utf-8?B?aGJFSHk0NG1zQm5MaCtVd0FrSVRoNm10empXdGgwSTIzbENCODU4ZHoyQW5Z?=
 =?utf-8?B?a2w1VVpGbUV6VXFYUy9MeEFOWVpKUlR6VXZDaUhVV3EzV0lvZjZVMkZCdjNH?=
 =?utf-8?B?S0dCZFNEekNBMERZMUhha3J6OThXMUdkTmhtOGZ0dTRoUjNhdExVRGMxenBo?=
 =?utf-8?B?c1dyVnN6ZzV1cnF2cmVyMm1oYkMwdEM5NlV6NWFCdytLWmdoYU5uSldyZGRY?=
 =?utf-8?B?V29MWXFRWVdWcDVaQW1QUkhKZHhYbGwydlFtbVB6KzhUaFl1emhBcFRIVW5t?=
 =?utf-8?B?WEFmVDJaN3h0T0Y1TldPYjRQZFU4V0ZZZWJCSXB1aUpWc3gxUW1TSS9VYUdC?=
 =?utf-8?B?clJicUJEY1BHRlFrenRqa1NGYjlkR3hEYlk5cmpnTW5aREx6WGVJMnhXbWVh?=
 =?utf-8?B?OGF5dStKajAvTko4YkdLeFRZNEhJdnp5dGJRNlFsbC9WZzZpbmlnckpvWlBk?=
 =?utf-8?B?SkZ1NWx6NHRObGR4a0lRaDNQMDFHYklHcDh0enJxTjhzR1NZZktlK24zOFlY?=
 =?utf-8?B?QnBpaWs5Mm5paW1yUjFQcXJ0NHNzZ1JObVBMd09WeitKZ2g3VENtQjltQTVm?=
 =?utf-8?B?TVVLUmlSOVBTdjl5THdEM25uSDg3S0tyWGhvYmhpRlIxVTJzVFFpMkNpcG1u?=
 =?utf-8?B?aVQvK3VWRDRxUmhBWVNYNFlHb2pMcVJ5M2Y0VEswdnhoSTUzVWt3Q0I2dnhB?=
 =?utf-8?B?V3BBTkhieW9IN3V0ZDNSRmNBcXRKUkpTTFBSY0dpSW9Oejhic0ZsZ1o1Mjdv?=
 =?utf-8?B?bVZTbkZNQWFOL1M3bmFqWDJsMHEza2ZXbFphaTB6UWFKZnVsTGk0RndReklJ?=
 =?utf-8?B?bDczY2svM2doWkIwTVRFa001ZFhlYVo3MWNWaDJBa0p4alQ5aWl2NlBQKzF3?=
 =?utf-8?B?UWR4MjNVdFJqUjZ5a25QVUFuMzhXWWExa1FtN1pvYndGWUpzZGRmYXErc09I?=
 =?utf-8?B?S0JuQ1EvaEYxcTlkQWwyNW9Zd1lkanhnMVprbndwRGt4UTNhcTlyL2NNcFF4?=
 =?utf-8?B?VjJ4cndsWEc2L3ErbHFOaVBLV3FaRnZibDk0QUFZYUpHVWtKRTRHQzNNVFgv?=
 =?utf-8?B?TW1ZeTJYc0cxeTl2WU5SWloxVTlUcUFEU1k0NGw0M0VHanVtMjFrM2RIdktX?=
 =?utf-8?B?Wnl3UTRHcSt2VEV4dUJ4Rk11TS96QVNCWDFrejNVUHJET1gyQnhvZFpId1Jq?=
 =?utf-8?B?b3JvMXgveEg3QUZaOFpwWjZwUGpENVRadzBxRlBkbmFGem1QMEpKbHhqWXRH?=
 =?utf-8?B?TjRBQUJ2djcxSHJ2M0RNUU45aXFFUTRHVTZTNDhKK0NpY2cwZ3haZWhRTDNE?=
 =?utf-8?B?ZUFzWGNWcFFOQmM1VTkyK2w5Z29XNEpWQ2w1WGlLS0JaMXdocVhSbG5LNHN1?=
 =?utf-8?B?K0RwM3ZjVXE5bVJaSTJvUTVGOW5URmVrSTRtQkRqUFhPY21Ld0xLOGNJem91?=
 =?utf-8?B?eTRwR2M0NnRIeDBoc3VvaW1DdHg0RE9TbVovQVpJTEFBZFd5UmppWGd3bU9F?=
 =?utf-8?B?a2dVSjVWL01aLzlvaW9LVFY1UWIvTXMvUENQOHQ5SzIzN1RyZkpWa1RQd3du?=
 =?utf-8?B?SS9RSTJtelZielBscWkyY3V1SElRVFZCT3hQVUZDRW1YcGI0MjFCTFp3aHZQ?=
 =?utf-8?B?enVNbEUxRVQ4QUNBSllwdU9XS2pnbzdsdHFvZk94bExUVnBkM3AxNEpIczF0?=
 =?utf-8?B?eEtXcmNsVGlHVTV2YWVlSU14VnJVVmRicmlHbk13NXpUY3kyZmcxdG16RXRK?=
 =?utf-8?B?WDFUbXlvYTRWSnNFOE00RnduTHlxQ3VhLzRzQ2hSN2lYaHkvbFZzUWo2eHJp?=
 =?utf-8?B?RGY2bkp4aWZpcndBVnJmdXE0dFVPUG5JeWNaWmxXcVpCVWoxMTB5eCs5Ulp3?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F74D768462054F4B9FA7861A113A56E4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa666e2-132f-4ea2-ed33-08dd920cbddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 10:55:57.8769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMtRyQ6FktiA4EElpv7RITkUcurV/eUBzZZgxBuZhfuvGxDWVlsyflAI/mJoGYRNUgHxWyvje3DqkdghXBB4ny4CdP79igHjG4EjMw3xXrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8157

T24gV2VkLCAyMDI1LTAyLTE5IGF0IDE2OjQ3ICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+IA0KPiANCj4gPiArY29uZmlnIE1FRElBVEVLXzJQNUdFX1BIWQ0KPiA+ICvCoMKg
wqDCoCB0cmlzdGF0ZSAiTWVkaWFUZWsgMi41R2IgRXRoZXJuZXQgUEhZcyINCj4gPiArwqDCoMKg
wqAgZGVwZW5kcyBvbiAoQVJNNjQgJiYgQVJDSF9NRURJQVRFSykgfHwgQ09NUElMRV9URVNUDQo+
ID4gK8KgwqDCoMKgIHNlbGVjdCBNVEtfTkVUX1BIWUxJQg0KPiA+ICvCoMKgwqDCoCBoZWxwDQo+
ID4gK8KgwqDCoMKgwqDCoCBTdXBwb3J0cyBNZWRpYVRlayBTb0MgYnVpbHQtaW4gMi41R2IgRXRo
ZXJuZXQgUEhZcy4NCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoCBUaGlzIHdpbGwgbG9hZCBuZWNl
c3NhcnkgZmlybXdhcmUgYW5kIGFkZCBhcHByb3ByaWF0ZSB0aW1lDQo+ID4gZGVsYXkuDQo+ID4g
K8KgwqDCoMKgwqDCoCBBY2NlbGVyYXRlIHRoaXMgcHJvY2VkdXJlIHRocm91Z2ggaW50ZXJuYWwg
cGJ1cyBpbnN0ZWFkIG9mDQo+ID4gTURJTw0KPiA+ICvCoMKgwqDCoMKgwqAgYnVzLiBDZXJ0YWlu
IGxpbmstdXAgaXNzdWVzIHdpbGwgYWxzbyBiZSBmaXhlZCBoZXJlLg0KPiANCj4gUGxlYXNlIGtl
ZXAgdGhlIGZpbGUgc29ydGVkLCB0aGlzIHNob3VsZCBiZSB0aGUgZmlyc3QgZW50cnkuDQo+IA0K
SSdsbCBzb3J0IGluIHRoaXMgd2F5IGluIHYzOg0KY29uZmlnIE1FRElBVEVLXzJQNUdFX1BIWQ0K
Li4uDQpjb25maWcgTUVESUFURUtfR0VfU09DX1BIWQ0KLi4uDQpjb25maWcgTVRLX05FVF9QSFlM
SUINCi4uLg0KY29uZmlnIE1FRElBVEVLX0dFX1BIWQ0KLi4uDQoNCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvcGh5L21lZGlhdGVrL01ha2VmaWxlDQo+ID4gYi9kcml2ZXJzL25ldC9waHkv
bWVkaWF0ZWsvTWFrZWZpbGUNCj4gPiBpbmRleCA4MTQ4NzlkMGFiZTUuLmM2ZGI4YWJkMmM5YyAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9waHkvbWVkaWF0ZWsvTWFrZWZpbGUNCj4gPiAr
KysgYi9kcml2ZXJzL25ldC9waHkvbWVkaWF0ZWsvTWFrZWZpbGUNCj4gPiBAQCAtMiwzICsyLDQg
QEANCj4gPiDCoG9iai0kKENPTkZJR19NVEtfTkVUX1BIWUxJQinCoMKgwqDCoMKgwqDCoMKgICs9
IG10ay1waHktbGliLm8NCj4gPiDCoG9iai0kKENPTkZJR19NRURJQVRFS19HRV9QSFkpwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICs9IG10ay1nZS5vDQo+ID4gwqBvYmotJChDT05GSUdf
TUVESUFURUtfR0VfU09DX1BIWSnCoMKgwqAgKz0gbXRrLWdlLXNvYy5vDQo+ID4gK29iai0kKENP
TkZJR19NRURJQVRFS18yUDVHRV9QSFkpwqDCoMKgwqAgKz0gbXRrLTJwNWdlLm8NCj4gDQo+IEkg
c3VwcG9zZSB5b3UgY291bGQgc2F5IHRoaXMgZmlsZSBpcyBzb3J0ZWQgaW4gcmV2ZXJzZSBvcmRl
ciBzbyBpcw0KPiBjb3JyZWN0Pw0KPiANCkknbGwgY2hhbmdlIHRoaXMgaW4gdjMgaW4gdGhpcyB3
YXk6DQpvYmotJChDT05GSUdfTUVESUFURUtfMlA1R0VfUEhZKSAgICAgKz0gbXRrLTJwNWdlLm8N
Cm9iai0kKENPTkZJR19NRURJQVRFS19HRV9TT0NfUEhZKSAgICArPSBtdGstZ2Utc29jLm8NCm9i
ai0kKENPTkZJR19NVEtfTkVUX1BIWUxJQikgICAgICAgICArPSBtdGstcGh5LWxpYi5vDQpvYmot
JChDT05GSUdfTUVESUFURUtfR0VfUEhZKSAgICAgICAgKz0gbXRrLWdlLm8NCg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9waHkvbWVkaWF0ZWsvbXRrLTJwNWdlLmMNCj4gPiBiL2RyaXZl
cnMvbmV0L3BoeS9tZWRpYXRlay9tdGstMnA1Z2UuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5hZGIwM2RmMzMxYWINCj4gPiAtLS0gL2Rldi9udWxs
DQo+ID4gKysrIGIvZHJpdmVycy9uZXQvcGh5L21lZGlhdGVrL210ay0ycDVnZS5jDQo+ID4gQEAg
LTAsMCArMSwzNDYgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAr
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9iaXRmaWVsZC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgv
ZmlybXdhcmUuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICsjaW5jbHVk
ZSA8bGludXgvbnZtZW0tY29uc3VtZXIuaD4NCj4gDQo+IElzIHRoaXMgaGVhZGVyIG5lZWRlZD8N
Cj4gDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+ID4gKyNpbmNsdWRlIDxs
aW51eC9vZl9wbGF0Zm9ybS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcGluY3RybC9jb25zdW1l
ci5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcGh5Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9w
bV9kb21haW4uaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gDQo+IEFu
ZCB0aGVzZSB0d28/IFBsZWFzZSBvbmx5IHVzZSB0aG9zZSB0aGF0IGFyZSBuZWVkZWQuDQo+IA0K
SSdsbCByZW1vdmUgbGludXgvbnZtZW0tDQpjb25zdW1lci5oPi88bGludXgvcG1fZG9tYWluLmg+
LzxsaW51eC9wbV9ydW50aW1lLmg+IGluIHYzLiBJIGZvcmdvdA0KcmVtb3ZpbmcgdGhlbSBhZnRl
ciBkZXZlbG9waW5nIHRoaXMgZHJpdmVyLg0KDQo+ID4gK3N0YXRpYyBpbnQgbXQ3OTh4XzJwNWdl
X3BoeV9sb2FkX2Z3KHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYpDQo+ID4gK3sNCj4gPiArDQo+
ID4gK8KgwqDCoMKgIHdyaXRldyhyZWcgJiB+TUQzMl9FTiwgbWN1X2Nzcl9iYXNlICsgTUQzMl9F
Tl9DRkcpOw0KPiA+ICvCoMKgwqDCoCB3cml0ZXcocmVnIHwgTUQzMl9FTiwgbWN1X2Nzcl9iYXNl
ICsgTUQzMl9FTl9DRkcpOw0KPiA+ICvCoMKgwqDCoCBwaHlfc2V0X2JpdHMocGh5ZGV2LCBNSUlf
Qk1DUiwgQk1DUl9SRVNFVCk7DQo+ID4gK8KgwqDCoMKgIC8qIFdlIG5lZWQgYSBkZWxheSBoZXJl
IHRvIHN0YWJpbGl6ZSBpbml0aWFsaXphdGlvbiBvZiBNQ1UgKi8NCj4gPiArwqDCoMKgwqAgdXNs
ZWVwX3JhbmdlKDcwMDAsIDgwMDApOw0KPiANCj4gRG9lcyB0aGUgcmVzZXQgYml0IGNsZWFyIHdo
ZW4gdGhlIE1DVSBpcyByZWFkeT8gVGhhdCBpcyB3aGF0IDgwMi4zDQo+IGRlZmluZXMuIHBoeV9w
b2xsX3Jlc2V0KCkgbWlnaHQgZG8gd2hhdCB5b3UgbmVlZC4NCg0KQ0wyMiByZXNldCBiaXQgd2ls
bCBiZSBjbGVhcmVkIHJpZ2h0IGFmdGVyIEkgc2V0IGl0IG9uIE1UNzk4OC4NCnVzbGVlcF9yYW5n
ZSgpIGhlcmUgaXMgdXNlZCB0byBhbGxvdyB0aGUgTUNVIHRvIHN0YWJpbGl6ZSwgcmF0aGVyIHRo
YW4NCnRvIHdhaXQgZm9yIHRoZSByZXNldCB0byBjb21wbGV0ZS4NCj4gDQo+ID4gK8KgwqDCoMKg
IGRldl9pbmZvKGRldiwgIkZpcm13YXJlIGxvYWRpbmcvdHJpZ2dlciBvay5cbiIpOw0KPiANCj4g
ZGV2X2RiZygpLCBpZiBhdCBhbGwuIFlvdSBoYXZlIGFscmVhZHkgc3BhbW1lZCB0aGUgbG9nIHdp
dGggdGhlDQo+IGZpcm13YXJlIHZlcnNpb24sIHNvIHRoaXMgYWRkcyBub3RoaW5nIHVzZWZ1bC4N
Cg0KV2VsbCB0aGVuLi4uIEluIHYzLCBJJ2xsIHJlbW92ZSB0aGlzIGxpbmUgYW5kIHByaW50IGZp
cm13YXJlIHZlcnNpb24gYXQNCmxhc3QgbGlrZSB0aGlzOg0KDQpmb3IgKGkgPSAwOyBpIDwgTVQ3
OTg4XzJQNUdFX1BNQl9GV19TSVpFIC0gMTsgaSArPSA0KQ0KCXdyaXRlbCgqKCh1aW50MzJfdCAq
KShmdy0+ZGF0YSArIGkpKSwgcG1iX2FkZHIgKyBpKTsNCg0Kd3JpdGV3KHJlZyAmIH5NRDMyX0VO
LCBtY3VfY3NyX2Jhc2UgKyBNRDMyX0VOX0NGRyk7DQp3cml0ZXcocmVnIHwgTUQzMl9FTiwgbWN1
X2Nzcl9iYXNlICsgTUQzMl9FTl9DRkcpOw0KcGh5X3NldF9iaXRzKHBoeWRldiwgTUlJX0JNQ1Is
IEJNQ1JfUkVTRVQpOw0KLyogV2UgbmVlZCBhIGRlbGF5IGhlcmUgdG8gc3RhYmlsaXplIGluaXRp
YWxpemF0aW9uIG9mIE1DVSAqLw0KdXNsZWVwX3JhbmdlKDcwMDAsIDgwMDApOw0KDQpkZXZfaW5m
byhkZXYsICJGaXJtd2FyZSBkYXRlIGNvZGU6ICV4LyV4LyV4LCB2ZXJzaW9uOiAleC4leFxuIiwN
CgkgYmUxNl90b19jcHUoKigoX19iZTE2ICopKGZ3LT5kYXRhICsNCgkJCQkgIE1UNzk4OF8yUDVH
RV9QTUJfRldfU0laRSAtIDgpKSksDQoJICooZnctPmRhdGEgKyBNVDc5ODhfMlA1R0VfUE1CX0ZX
X1NJWkUgLSA2KSwNCgkgKihmdy0+ZGF0YSArIE1UNzk4OF8yUDVHRV9QTUJfRldfU0laRSAtIDUp
LA0KCSAqKGZ3LT5kYXRhICsgTVQ3OTg4XzJQNUdFX1BNQl9GV19TSVpFIC0gMiksDQoJICooZnct
PmRhdGEgKyBNVDc5ODhfMlA1R0VfUE1CX0ZXX1NJWkUgLSAxKSk7DQoNCnByaXYtPmZ3X2xvYWRl
ZCA9IHRydWU7DQoNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBoeWRldi0+ZHVwbGV4
ID0gRFVQTEVYX0ZVTEw7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBGSVhNRToN
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBUaGUgY3VycmVudCBmaXJtd2FyZSBh
bHdheXMgZW5hYmxlcyByYXRlDQo+ID4gYWRhcHRhdGlvbiBtb2RlLg0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqLw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGh5ZGV2
LT5yYXRlX21hdGNoaW5nID0gUkFURV9NQVRDSF9QQVVTRTsNCj4gDQo+IENhbiB3ZSB0ZWxsIGN1
cnJlbnQgZmlybXdhcmUgZm9yIGZ1dHVyZSBmaXJtd2FyZT8gSXMgdGhpcyBhY3R1YWxseQ0KPiBm
aXhhYmxlPw0KPiANCldlIGRlY2lkZWQgdG8gYWx3YXlzIGVuYWJsZSByYXRlIGFkYXB0YXRpb24g
bW9kZSBmb3IgTVQ3OTg4J3MgY3VycmVudA0KYW5kIGZ1dHVyZSBidWlsdC1pbiAyLjVHYkUgZmly
bXdhcmUuIEknbGwgcmVtb3ZlIEZJWE1FIGNvbW1lbnQgaGVyZSBpbg0KdjMuDQoNCj4gPiArwqDC
oMKgwqAgfQ0KPiA+ICsNCj4gPiArwqDCoMKgwqAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+
IA0KPiANCj4gDQo+ID4gK3N0YXRpYyBpbnQgbXQ3OTh4XzJwNWdlX3BoeV9wcm9iZShzdHJ1Y3Qg
cGh5X2RldmljZSAqcGh5ZGV2KQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgIHN0cnVjdCBtdGtfaTJw
NWdlX3BoeV9wcml2ICpwcml2Ow0KPiA+ICsNCj4gPiArwqDCoMKgwqAgcHJpdiA9IGRldm1fa3ph
bGxvYygmcGh5ZGV2LT5tZGlvLmRldiwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVvZihzdHJ1Y3QgbXRrX2kycDVnZV9waHlfcHJpdiks
DQo+ID4gR0ZQX0tFUk5FTCk7DQo+ID4gK8KgwqDCoMKgIGlmICghcHJpdikNCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArwqDCoMKgwqAg
c3dpdGNoIChwaHlkZXYtPmRydi0+cGh5X2lkKSB7DQo+ID4gK8KgwqDCoMKgIGNhc2UgTVRLXzJQ
NUdQSFlfSURfTVQ3OTg4Og0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogVGhlIG9y
aWdpbmFsIGhhcmR3YXJlIG9ubHkgc2V0cyBNRElPX0RFVlNfUE1BUE1EDQo+ID4gKi8NCj4gDQo+
IFdoYXQgZG8geW91IG1lYW4gYnkgIm9yaWdpbmFsIGhhcmR3YXJlIj8NCj4gDQo+IFlvdSB1c2Ug
UEhZX0lEX01BVENIX01PREVMKE1US18yUDVHUEhZX0lEX01UNzk4OCksIHNvIGRvIHlvdSBtZWFu
DQo+IHJldmlzaW9uIDAgaXMgYnJva2VuLCBidXQgcmV2aXNpb24gMSBmaXhlZCBpdD8NCj4gDQpJ
J2xsIGZpeCB0aGlzIGFtYmlndW91cyBjb21tZW50IHRvOg0KLyogVGhpcyBidWlsdC1pbiAyLjVH
YkUgaGFyZHdhcmUgb25seSBzZXRzIE1ESU9fREVWU19QTUFQTUQuIFNldCB0aGUgICoNCnJlc3Qg
YnkgdGhpcyBkcml2ZXIgc2luY2UgUENTL0FOL1ZFTkQxL1ZFTkQyIG1tZHMgZXhpc3QuDQogKi8N
Cg0KPiANCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBoeWRldi0+YzQ1X2lkcy5tbWRz
X3ByZXNlbnQgfD0gTURJT19ERVZTX1BDUyB8DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgTURJT19ERVZTX0FOIHwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBNRElPX0RFVlNfVkVORDEgfA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIE1ESU9fREVWU19WRU5EMjsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFr
Ow0KPiA+ICvCoMKgwqDCoCBkZWZhdWx0Og0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIC1FSU5WQUw7DQo+ID4gK8KgwqDCoMKgIH0NCj4gPiArDQo+ID4gK8KgwqDCoMKgIHBy
aXYtPmZ3X2xvYWRlZCA9IGZhbHNlOw0KPiA+ICvCoMKgwqDCoCBwaHlkZXYtPnByaXYgPSBwcml2
Ow0KPiA+ICsNCj4gPiArwqDCoMKgwqAgbXRrX3BoeV9sZWRzX3N0YXRlX2luaXQocGh5ZGV2KTsN
Cj4gDQo+IFRoZSBMRURzIHdvcmsgd2l0aG91dCBmaXJtd2FyZT8NCj4gDQo+IMKgwqDCoCBBbmRy
ZXcNCj4gDQo+IC0tLQ0KPiBwdy1ib3Q6IGNyDQpJJ2xsIHJlbW92ZSB0aGlzIGxpbmUgdjMgYW5k
IHByb3Bvc2UgTEVEIHBhcnQgaW4gbGF0ZXIgcGF0Y2hzZXQuDQoNCkJScywNClNreQ0K

