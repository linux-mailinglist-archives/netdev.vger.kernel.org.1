Return-Path: <netdev+bounces-107140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EA291A148
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1587E283231
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 08:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D177602D;
	Thu, 27 Jun 2024 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="m+EKQurl";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="MyYAq5Cb"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26401CAB3;
	Thu, 27 Jun 2024 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476382; cv=fail; b=SE3SJut4iRWF5FKA70QTBFhC2BfuaNH31G96bqkAY05sNaaW2G8elxffIIJARuOE5YFj72Irh9w9BQnfCO1/JGdPlf/wthKEYexPFEMcReJsONU/naIrt8UaG7OlOwvOoL0yXFPAt6v5xdqk1HYySnG8B8xEjOLrlYIqvR6cbDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476382; c=relaxed/simple;
	bh=9deqkuSHXrQKm9rvt83Bmm0PWZf91LS4PeHdWqghQPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tiobicR2juMxtYfcZLOu1yTpPPTodzyO4iCpMseqBOrQu/BYXTAGPDQx8EK1EvJpopSudCyJc23a3e/2bhN5H67BHEVpLTC1izb+VRDeRwUsAAuvHA0T9vr+FjC36MkFsTFyYoQTkMMxseoBdjY0uA5BjZ+Jll5bvUsBw8KqEbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=m+EKQurl; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=MyYAq5Cb; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fc4f5518345d11ef8da6557f11777fc4-20240627
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9deqkuSHXrQKm9rvt83Bmm0PWZf91LS4PeHdWqghQPQ=;
	b=m+EKQurlvCizR8eLbBnxkZ7zrH0bveiX7Tw/o4k+YUYsjG64Jssw8pP2ClWCFMGjQSKeIAYP9BmbH7GyORJGpsgpexp85P8pIK25nGXEM4TESlOM1pV2eZUizA0jqwNh/JX2Xfcn+pGdPVOCrfPEXNkgTzYagD3sWG5UIKwutb0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:31f7ee4c-7c6f-4c84-8140-5e642f795eae,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:5dec7f94-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: fc4f5518345d11ef8da6557f11777fc4-20240627
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 311185446; Thu, 27 Jun 2024 16:19:34 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 27 Jun 2024 16:19:32 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 27 Jun 2024 16:19:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXW4kxlmXMW04wvTomsu/bQ5GPhul03yv7734QSiBx0xTfi4WUb/SYxnYBNKRByZ7YAwyoWogztFyM3YwKRQKP5cVQ7QcY0caXdVXRgbo2kLNj4EIr5E0hQ9Blo8oH4cFsTM/EKf9TYEGgIdDpjPsqxGqmA4oZHfIGB5RVgAaelzNOAvGvmF9n0tjNBKe3hkDkUnIFfqdvtwqQTcci3EslIzf9XV2e4AUBpBEzVcjv/FQQbz9UkhQ2r+L4Awsua6pJFzpo+pOkGIS0ZJavEshCAF79kmDA/Jy46MyiKw14kMMw2MYhFEhGRvOMJazuSBvuxPipYNP8NI08c7IH/xJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9deqkuSHXrQKm9rvt83Bmm0PWZf91LS4PeHdWqghQPQ=;
 b=iI6PFblGycwKvmV/gI4jbSGB0aQ6AAvrhN8rBhqVUZLLvNALYH/fjN9SgP10TKWL0P+XT3HQMGNuStt5GAVDMXmGxV4ZfQREsfbUeH/mmit3DmW+/oAqSS0dr970XnXGdcztpklIR2J43oyOYhFMs4ILQlhjMq3TT5B7sHNwwffmwMUsRJCtwgP40R8SBXPDuZRiGiBQfSMCu/keZCaPeUiJ83JnZaG5ZiLqzka5KMguXnKCHsKCYby1V5xLWx2eEpsMH1WKnNUVpQ9pq5UMiU/dN0C3DntpS1s+pZ4ugpXoGkw1YuAKbz1ClJLCJ60b+MJW4PGEFE5T/mT4Ej1Tfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9deqkuSHXrQKm9rvt83Bmm0PWZf91LS4PeHdWqghQPQ=;
 b=MyYAq5CbgCLj8+R1j17Cw9tj/QfhlHkSgK1FEh07vXL0KFzJpIqnQ66jmv2hsHT+w38Cuyhqy41XGfJ89koLeAntC+o2OEHtxenLxmy3bNWaQ+3wypLyElcwO9agqy+/UpZW2wvEkW33Mg8moeBQ9MTJNr9GpON7dcfKgYOqWKI=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TYUPR03MB7137.apcprd03.prod.outlook.com (2603:1096:400:344::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 08:19:30 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%7]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 08:19:30 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "horms@kernel.org" <horms@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v9 11/13] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v9 11/13] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Index: AQHax7bHOmuSB9/M6EOb5Zny9hwr27HaZIWAgADhggA=
Date: Thu, 27 Jun 2024 08:19:30 +0000
Message-ID: <e3a31911c1e1154dc1989a8f2851ea741a8b1b2f.camel@mediatek.com>
References: <20240626104329.11426-1-SkyLake.Huang@mediatek.com>
	 <20240626104329.11426-12-SkyLake.Huang@mediatek.com>
	 <20240626185221.GC3104@kernel.org>
In-Reply-To: <20240626185221.GC3104@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TYUPR03MB7137:EE_
x-ms-office365-filtering-correlation-id: 7dba7b7d-3c14-4f08-03d9-08dc9681de4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y0g4N2J4RFJsbUVtRml3clZDZ3ZCeVVsSmtOTmFZbDRaQTlQWDNUenJ2enNS?=
 =?utf-8?B?MWxaK081dzlwa0ROWHVKcEZUblh5OTFVN2pCaUxNNmg0N3NYUUltUkNDMjMr?=
 =?utf-8?B?ajhZMTVWRDR6REdjOTAzWlV3ODNFNjZrYWxReHNaYUFHT0w3OWkxeGZaUUlt?=
 =?utf-8?B?b3EybEFPcnpLQWhrM2ROQnZtRlJuYmZZUkhvazZJSDlmMTdLY1VIWm1uZGdw?=
 =?utf-8?B?MzVyTHA5TUV5ZlROYTVLQjFBU0FTSjZ3UWlUVGRQcmNyRWt6eE1jT094ZTJW?=
 =?utf-8?B?bTNNbTFmVGJ6RWNsWlFML2hKL1kvUHMwUy9XUGZjSDdhdGRyRzVMTWl6Wit1?=
 =?utf-8?B?Mm5mN0hNMVJpays0c1pWTGgyWkNsbkcrYzlaN1hRYXhYU3haSVRvaVpmUXBW?=
 =?utf-8?B?SklOYUVNWFFFRjZjWkpnUVVQcXN4NU03NzY1SlBGOG1Sd0tTNXVMRkw1bGxX?=
 =?utf-8?B?TzJPem5LYUNjcGNpY1A3RDJHOFY5TDlwWktNdmd1NDhNSi9sTmk4YUlzU0t1?=
 =?utf-8?B?V0JoMjlucHBxbmZrdU53eEtxMmNOYTgxRFp6MFR3M2RJU3dmV0doaGRtZDlC?=
 =?utf-8?B?MlZTQ0NpaEd4RXd6ZWJrakRhaE90ZkdCRnNUWXBSbW5rK0xsbGhrREFlT0RH?=
 =?utf-8?B?blBka0p4d3F3RDdlNy9VVUM3Wk5uQW9uMTVWVit3dEJMcEc5OWxaSUloT3o3?=
 =?utf-8?B?Z3hIT1IzM1Z4OGZGeFg3RGIxUjY5VEhlRWgyY3BhR1MwY2JKdTZiTlEwekFJ?=
 =?utf-8?B?REQwMy9LV2p3NjhrWCt1L0pUY0hiU0ptZXphVXU0WTl6ck94T2dKc21FQkdV?=
 =?utf-8?B?cWg3aGFlSnpVNnNpRXViZEVaaTY0YXhMV2FBVzBRQW91cTFueE1IUXNHNmJ6?=
 =?utf-8?B?NjB0dnIxNGdzQzdhdWFDaGF1cmxQbThvUzBpSXNhZVZMdzd5YjRhWjFxS1BM?=
 =?utf-8?B?Mys2d2ZFSFNobWpwa2RoL05zV3R6SjI0bTQ1SWJCYjRRaWVVVE9Cbi81LzFs?=
 =?utf-8?B?MEpPbVIraFBnSVM4REwxMDVjalAxTFhEMFJnUXoyd0wxOGdaSkswVDRkTkRY?=
 =?utf-8?B?WEEwN1YxOTFuNWdXTE1SUE0xV1h6YmdUY25MTU1xZXUyWWRNR25FYVgwMzBP?=
 =?utf-8?B?cWc2dHdiNHNBanl3S3llaFp0YWE0cklZNUlrS1dwVG9oRXU0UExJOW54VGJP?=
 =?utf-8?B?R1p1d3cyRzJxdFVQNUE2eDM3c0h0ZCtFR3BBK3k4Ky9DY29oRitaSkpXWGtq?=
 =?utf-8?B?RkExcGgydytIby9CaytHNHQxYkdTOElQYW5nNnRuSituemd2ZjllODBTY291?=
 =?utf-8?B?bmtGcGNqL085ZjBmblBWcy9ZYUJRN3JCRVFOMTlTV2g2UFRvS0dEZnZKcVh2?=
 =?utf-8?B?Z0FMaXBHOFlLUUVNY3lkRTN0YjBERnd4UlNiOWcvYjVFcURhbmVLYlloeGJN?=
 =?utf-8?B?d21UNGdvK0JBOVBsNFRjUXBaa2theit2bjFqajIyMzc3Zm1XZEVhaURBOGl3?=
 =?utf-8?B?V2RWWnY3RE9lQkVFdGpxaGRIU0s2TzU3UmhuOENiRFZ4QWtIeDNBS2RDZXlo?=
 =?utf-8?B?U3Fna3M1MnlLM1U4VkJxNy9uWDNJWDVsRHFXeXhXdGRPS20wNjdremRNSFVu?=
 =?utf-8?B?WHJQaGY5WVNWZEllQ082YThBZkgwSmhIQVd3VjZkUkVJVFF3VVNvT1IvdVgr?=
 =?utf-8?B?SVZhbktWWU90aWJuNnpKcjdkYmRpNTBMMlozd2JFUUNEbTJxdnpnbWFhVnNk?=
 =?utf-8?B?bEh0eDBrQ2FOQnp1ZlF1MmxIQ0ZKTmJJV3Fac2J1Wk9kSUFUK2RLQk9ENUpm?=
 =?utf-8?B?Y1I5VTYrQ1VNTXhFZmMxWW5TZ2Z3ZzR0SlhXTjJONmk0SmQvTDlraW1VdTRn?=
 =?utf-8?B?MCtzcE8vTXBHNkd0WDVPOU9zUWtORnRsaXRnQnNsNWlrekE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFBRaGNrOHhWVitqRDZKWTVWaHgxUW5kRDUwbG15TU84SWZFNEc3WnZ4a0lR?=
 =?utf-8?B?K25HcVNWazdNNkRBMjdCWDhRd3RaWlNkSGRQdHBySk9tdENVakhXZ1dpWk5l?=
 =?utf-8?B?OEhNQlVZeGRpVGtsTG0zbnZHcWloYmlQeTEvRzYyUWNyaTErbm9pODU3RlRt?=
 =?utf-8?B?U2FqN1BwYVVRNmI1MThIdUF3QVZka3FOTDcvRHdRT2VkMENJeTdsQ05TWXNn?=
 =?utf-8?B?UExRYmxxSkpLWTlqSmFQOFpOeTU3WGZHMmJhVHo1ZFArWGpRQ1QybFRreXlO?=
 =?utf-8?B?RnJXR1pnTFZKR21TT0F0eG00Q3lOSFdsSmlwZUU4SVNjUktZbVdla0RFMml1?=
 =?utf-8?B?YmtvMDZyOXpEWHJoMk9yck9SdU45QlgzV0FPMENiWlB3UEJCYWUzSDhPTzhE?=
 =?utf-8?B?M3JUb2pyYzAyNGdscUtOY3JQNVRFbkI1RVZvNWlUN0xDdjNoMnJ0MU9oN3BV?=
 =?utf-8?B?OHpsYTFmZzIwaEJ1UXVEcjRBbU53UERlU2ZMSVFWWGtzQlBxcXZMdVJ3S1FE?=
 =?utf-8?B?TXQ1NDgweFFNd3I3YmxSUHUyS1FhQnhXZlFKbVlRYzBlYk5aS0xKNDR3RHp3?=
 =?utf-8?B?eGtMN0daRHFrSmIrMW1kbVg2dUdOK0M5UXVlQzU0akxlZlR2N1B6UkRROENa?=
 =?utf-8?B?eHRlTURrZUdNUFkxdFBMSWxnNVRMZVlnNmxXcUVkREw0cVdNMkpnek9TYk5J?=
 =?utf-8?B?YVlSUWw5V09iRlJPbTc4NVc3MEdjamZmZmx6WE13dUtrNGk4QWNTZ3liNEIx?=
 =?utf-8?B?UVU2Z01abUZTc3U1L3lYMmZnbE1VamkzSFVNbnNkWERKVGtTMjNBVytYMHpL?=
 =?utf-8?B?a3lVV1RTd1ZzS0pQOXJISnBXNXZncEd5SlRMTHZBRnRIMEJHbm5QNnNtdWdT?=
 =?utf-8?B?b1V5TnFZdVFrdWMzck1TRU1UNUh4akEybUNqdnlQSkNhMm9WS3NFWHRaK1M5?=
 =?utf-8?B?dWJpckNMcG5vQVhOS21qZjdiYVFwVkJ0RTlBU25EYW5xb1V6REhCZmJFTzBm?=
 =?utf-8?B?eG9BWEpIOVdiR1dEcjR0cFNsakxJNWU4Z0VNWXNvcm9UZ2U1RmJST3BmN0I3?=
 =?utf-8?B?cmF5TEFDMXZoUzhvaHZaRGN0VlpGamIvVWxjRlgveXBDOGsvZG5MSDhBN09k?=
 =?utf-8?B?eFpibmwyOFNCQXF0WFd2ZkdRSk40bHdYMXlEemR0V0MvTXo0aWVrOC81VXcy?=
 =?utf-8?B?b3RtMTUyZks5bmJtd1cwbXNuOFFwd0wyMU5MVFp6WndESyt6dnUyVXJ6TnhU?=
 =?utf-8?B?OUQ1TEZKNFdoNzN0RHpiL2xlU1JsYktpd2kxZXphZmM4QWY4TllJODhhR1Rt?=
 =?utf-8?B?UFhpeHkrYnhxdzNpUHB6NkkzeHNVOXRmVVIyMW9mZjR4ZVd4dm1menJSYXB3?=
 =?utf-8?B?aG5yN0NqSC82dkw1YU5UVU54TWF4SjJ0cFVWbGdhQlMrb0pkMGp3RWl2aUp5?=
 =?utf-8?B?MFJoODkzbnJTRzZqZmZ1cldqQkNFKzVuSE41U2RRbTlhU0wra2FGQ1RUYUI1?=
 =?utf-8?B?bGFKWE9sSXZXZVJIOGpDTlMxWFV1SXhpWkI2ZE9EWHd4SGsxMG8zWmV0WDhq?=
 =?utf-8?B?a1ptWVY5d3pVVWZNcnR3ejRsbUE4dkhsUnZZTUFMTTlJNGljOE9ibnBhK29X?=
 =?utf-8?B?ZHNsRFloc2xVQVplUkIvQUdVaWR5YnAvVjN3aHhoSlJkeGlTTGZyd01WNmRZ?=
 =?utf-8?B?TXZhNzdjZUI4a1ZDQU1jRkxoMjRvbVpGd2h2Y1kvZVR6cnY1N0d4U1NYaGQw?=
 =?utf-8?B?SFlaZ29XU2ZkajN0TnVUaGt2dWNZeUhDZjNWNzI1MWtuVURudDQ5QU8wM1NE?=
 =?utf-8?B?VURVSFBTVnY5alFhN3Z2a0lZczU5N1FNdXJtQ3VHeWdKQmNDTE5MUm1oS2hl?=
 =?utf-8?B?WjRPR0JocjhRRGtIbnlTUDJRZDBZdXdNdVVwck9oU2lFUWhKNC9WTTJSZnpJ?=
 =?utf-8?B?WnIwQzJnRVZzNVJaR2ZIa0R2T2NLeTZUQnBCTzY2NWFjUEhuNVRqeC8vU1lU?=
 =?utf-8?B?Mk8zSGMxUU9vdXgxM3RreWsrQ2VyMlBEZFlhV3VCQ3NwWW9RcjZiaVZlMmlI?=
 =?utf-8?B?N1JVYzFKZkUvSzl4Nmw2WlhlcTMwb1lDK29tTTdpZlJFVUR1RXI3eHdXWUFt?=
 =?utf-8?B?OFJVUy8wc2d4Nkx4NWVkRktkVldQellDQmNkWjdOVVlNNlM3T3B3NkVDWWtP?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC49B049C7252A4BA90FC7991845BFD3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dba7b7d-3c14-4f08-03d9-08dc9681de4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 08:19:30.4167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WyQdqms66fI5RBN4PhOkwLQ/wb8X4Gadwu1+kKovJSaI+vsa0nXGrxFfMzebpSXynjVve3DTlgZwkNS93u93dzSOvwuFDxUm764zn1aXozk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7137
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--26.001200-8.000000
X-TMASE-MatchedRID: UWn79NfEZzbUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCsup1wbeiPwat8Hj/rv1Iph+Mk6ACsw4JlwpnAAvAwaznEw
	Nky7vSPHTsNEaOlKWVxKZqBe94N0ikKjL2IOi2LAVglQa/gMvfILFgHaE9Li9uqWf6Nh7tmFLbT
	Uf+O4SvPsmW5TzbulVK+sgZLSnUSA0CYUOpITAYnTnOygHVQpOu56wFPSkMVGi1YG5GcTOT/Lrs
	caVtLwEwAgTFwPrPa7qR0ztm0W62Ln7Y5gLH5cIB7TqRAYVohZCs7hdHoFFA88t31mcoTIry8NC
	oR1t/U0unDiIZYz9S52oLZ8u2T3EQv21zJNl0CyDGx/OQ1GV8rHlqZYrZqdI+gtHj7OwNO0CpgE
	TeT0ynA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--26.001200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	9C4B75D09AC28C10515320023DF5260A562143A89E530B04A6C441C13C55CC4C2000:8

T24gV2VkLCAyMDI0LTA2LTI2IGF0IDE5OjUyICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gV2VkLCBKdW4gMjYsIDIwMjQgYXQgMDY6NDM6MjdQTSArMDgwMCwg
U2t5IEh1YW5nIHdyb3RlOg0KPiA+IEZyb206ICJTa3lMYWtlLkh1YW5nIiA8c2t5bGFrZS5odWFu
Z0BtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gQWRkIHN1cHBvcnQgZm9yIGludGVybmFsIDIuNUdw
aHkgb24gTVQ3OTg4LiBUaGlzIGRyaXZlciB3aWxsIGxvYWQNCj4gPiBuZWNlc3NhcnkgZmlybXdh
cmUsIGFkZCBhcHByb3ByaWF0ZSB0aW1lIGRlbGF5IGFuZCBmaWd1cmUgb3V0IExFRC4NCj4gPiBB
bHNvLCBjZXJ0YWluIGNvbnRyb2wgcmVnaXN0ZXJzIHdpbGwgYmUgc2V0IHRvIGZpeCBsaW5rLXVw
IGlzc3Vlcy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTa3lMYWtlLkh1YW5nIDxza3lsYWtl
Lmh1YW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+IC4uLg0KPiANCj4gSGkgU2t5LA0KPiANCj4gU29y
cnkgZm9yIG5vdCBwcm92aWRpbmcgdGhpcyByZXZpZXcgZWFybGllciBpbiB0aGUgcHJvY2Vzcy4N
Cj4gDQpJdCdzIG9rLg0KDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3BoeS9tZWRpYXRl
ay9tdGstMnA1Z2UuYw0KPiBiL2RyaXZlcnMvbmV0L3BoeS9tZWRpYXRlay9tdGstMnA1Z2UuYw0K
PiANCj4gLi4uDQo+IA0KPiA+ICtzdGF0aWMgaW50IG10Nzk4eF8ycDVnZV9waHlfbG9hZF9mdyhz
dHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0KPiA+ICt7DQo+ID4gK3N0cnVjdCBtdGtfaTJwNWdl
X3BoeV9wcml2ICpwcml2ID0gcGh5ZGV2LT5wcml2Ow0KPiA+ICt2b2lkIF9faW9tZW0gKm1kMzJf
ZW5fY2ZnX2Jhc2UsICpwbWJfYWRkcjsNCj4gPiArc3RydWN0IGRldmljZSAqZGV2ID0gJnBoeWRl
di0+bWRpby5kZXY7DQo+ID4gK2NvbnN0IHN0cnVjdCBmaXJtd2FyZSAqZnc7DQo+ID4gK2ludCBy
ZXQsIGk7DQo+ID4gK3UxNiByZWc7DQo+ID4gKw0KPiA+ICtpZiAocHJpdi0+ZndfbG9hZGVkKQ0K
PiA+ICtyZXR1cm4gMDsNCj4gPiArDQo+ID4gK3BtYl9hZGRyID0gaW9yZW1hcChNVDc5ODhfMlA1
R0VfUE1CX0ZXX0JBU0UsDQo+IE1UNzk4OF8yUDVHRV9QTUJfRldfTEVOKTsNCj4gPiAraWYgKCFw
bWJfYWRkcikNCj4gPiArcmV0dXJuIC1FTk9NRU07DQo+ID4gK21kMzJfZW5fY2ZnX2Jhc2UgPSBp
b3JlbWFwKE1UNzk4OF8yUDVHRV9NRDMyX0VOX0NGR19CQVNFLA0KPiA+ICsgICBNVDc5ODhfMlA1
R0VfTUQzMl9FTl9DRkdfTEVOKTsNCj4gPiAraWYgKCFtZDMyX2VuX2NmZ19iYXNlKSB7DQo+ID4g
K3JldCA9IC1FTk9NRU07DQo+ID4gK2dvdG8gZnJlZV9wbWI7DQo+ID4gK30NCj4gPiArDQo+ID4g
K3JldCA9IHJlcXVlc3RfZmlybXdhcmUoJmZ3LCBNVDc5ODhfMlA1R0VfUE1CX0ZXLCBkZXYpOw0K
PiA+ICtpZiAocmV0KSB7DQo+ID4gK2Rldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGxvYWQgZmlybXdh
cmU6ICVzLCByZXQ6ICVkXG4iLA0KPiA+ICtNVDc5ODhfMlA1R0VfUE1CX0ZXLCByZXQpOw0KPiA+
ICtnb3RvIGZyZWU7DQo+ID4gK30NCj4gPiArDQo+ID4gK2lmIChmdy0+c2l6ZSAhPSBNVDc5ODhf
MlA1R0VfUE1CX0ZXX1NJWkUpIHsNCj4gPiArZGV2X2VycihkZXYsICJGaXJtd2FyZSBzaXplIDB4
JXp4ICE9IDB4JXhcbiIsDQo+ID4gK2Z3LT5zaXplLCBNVDc5ODhfMlA1R0VfUE1CX0ZXX1NJWkUp
Ow0KPiA+ICtyZXQgPSAtRUlOVkFMOw0KPiA+ICtnb3RvIGZyZWU7DQo+IA0KPiBJdCBzZWVtcyB0
aGF0IHRoaXMgbGVha3MgYW55IHJlc291cmNlcyBhbGxvY2F0ZWQgYnkNCj4gcmVxdWVzdF9maXJt
d2FyZSgpOg0KPiBJIHRoaW5rIGEgY2FsbCB0byByZWxlYXNlX2Zpcm13YXJlKCkgaXMgbmVlZGVk
IGluIHRoaXMgdW53aW5kIHBhdGguDQo+IA0KPiBGbGFnZ2VkIGJ5IFNtYXRjaC4NCj4gDQpQbGVh
c2Ugc2VlIHRoZSBmaXggZG93biBiZWxvdy4NCg0KPiA+ICt9DQo+ID4gKw0KPiA+ICtyZWcgPSBy
ZWFkdyhtZDMyX2VuX2NmZ19iYXNlKTsNCj4gPiAraWYgKHJlZyAmIE1EMzJfRU4pIHsNCj4gPiAr
cGh5X3NldF9iaXRzKHBoeWRldiwgTUlJX0JNQ1IsIEJNQ1JfUkVTRVQpOw0KPiA+ICt1c2xlZXBf
cmFuZ2UoMTAwMDAsIDExMDAwKTsNCj4gPiArfQ0KPiA+ICtwaHlfc2V0X2JpdHMocGh5ZGV2LCBN
SUlfQk1DUiwgQk1DUl9QRE9XTik7DQo+ID4gKw0KPiA+ICsvKiBXcml0ZSBtYWdpYyBudW1iZXIg
dG8gc2FmZWx5IHN0YWxsIE1DVSAqLw0KPiA+ICtwaHlfd3JpdGVfbW1kKHBoeWRldiwgTURJT19N
TURfVkVORDEsIDB4ODAwZSwgMHgxMTAwKTsNCj4gPiArcGh5X3dyaXRlX21tZChwaHlkZXYsIE1E
SU9fTU1EX1ZFTkQxLCAweDgwMGYsIDB4MDBkZik7DQo+ID4gKw0KPiA+ICtmb3IgKGkgPSAwOyBp
IDwgTVQ3OTg4XzJQNUdFX1BNQl9GV19TSVpFIC0gMTsgaSArPSA0KQ0KPiA+ICt3cml0ZWwoKigo
dWludDMyX3QgKikoZnctPmRhdGEgKyBpKSksIHBtYl9hZGRyICsgaSk7DQo+ID4gK3JlbGVhc2Vf
ZmlybXdhcmUoZncpOw0KPiA+ICtkZXZfaW5mbyhkZXYsICJGaXJtd2FyZSBkYXRlIGNvZGU6ICV4
LyV4LyV4LCB2ZXJzaW9uOiAleC4leFxuIiwNCj4gPiArIGJlMTZfdG9fY3B1KCooKF9fYmUxNiAq
KShmdy0+ZGF0YSArDQo+ID4gKyAgTVQ3OTg4XzJQNUdFX1BNQl9GV19TSVpFIC0gOCkpKSwNCj4g
PiArICooZnctPmRhdGEgKyBNVDc5ODhfMlA1R0VfUE1CX0ZXX1NJWkUgLSA2KSwNCj4gPiArICoo
ZnctPmRhdGEgKyBNVDc5ODhfMlA1R0VfUE1CX0ZXX1NJWkUgLSA1KSwNCj4gPiArICooZnctPmRh
dGEgKyBNVDc5ODhfMlA1R0VfUE1CX0ZXX1NJWkUgLSAyKSwNCj4gPiArICooZnctPmRhdGEgKyBN
VDc5ODhfMlA1R0VfUE1CX0ZXX1NJWkUgLSAxKSk7DQo+ID4gKw0KPiA+ICt3cml0ZXcocmVnICYg
fk1EMzJfRU4sIG1kMzJfZW5fY2ZnX2Jhc2UpOw0KPiA+ICt3cml0ZXcocmVnIHwgTUQzMl9FTiwg
bWQzMl9lbl9jZmdfYmFzZSk7DQo+ID4gK3BoeV9zZXRfYml0cyhwaHlkZXYsIE1JSV9CTUNSLCBC
TUNSX1JFU0VUKTsNCj4gPiArLyogV2UgbmVlZCBhIGRlbGF5IGhlcmUgdG8gc3RhYmlsaXplIGlu
aXRpYWxpemF0aW9uIG9mIE1DVSAqLw0KPiA+ICt1c2xlZXBfcmFuZ2UoNzAwMCwgODAwMCk7DQo+
ID4gK2Rldl9pbmZvKGRldiwgIkZpcm13YXJlIGxvYWRpbmcvdHJpZ2dlciBvay5cbiIpOw0KPiA+
ICsNCj4gPiArcHJpdi0+ZndfbG9hZGVkID0gdHJ1ZTsNCj4gPiArDQo+ID4gK2ZyZWU6DQo+ID4g
K2lvdW5tYXAobWQzMl9lbl9jZmdfYmFzZSk7DQo+ID4gK2ZyZWVfcG1iOg0KPiA+ICtpb3VubWFw
KHBtYl9hZGRyKTsNCj4gPiArDQo+ID4gK3JldHVybiByZXQgPyByZXQgOiAwOw0KPiANCj4gSSdt
IGZlZWxpbmcgdGhhdCBJJ20gbWlzc2luZyBzb21ldGhpbmcgaW5jcmVkaWJseSBvYnZpb3VzLA0K
PiBidXQgY291bGQgdGhpcyBzaW1wbHkgYmU6DQo+IA0KPiByZXR1cm4gcmV0Ow0KPiANCj4gPiAr
fQ0KPiANCj4gLi4uDQpUaGFua3MuIEknbGwgZml4IGxpa2UgdGhpczoNCg0Kc3RhdGljIGludCBt
dDc5OHhfMnA1Z2VfcGh5X2xvYWRfZncoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCnsNCglp
bnQgcmV0LCBpOw0KCS4uLg0KDQoJaWYgKCFtZDMyX2VuX2NmZ19iYXNlKSB7DQoJCXJldCA9IC1F
Tk9NRU07DQoJCWdvdG8gZnJlZV9wbWI7DQoJfQ0KDQoJcmV0ID0gcmVxdWVzdF9maXJtd2FyZSgm
ZncsIE1UNzk4OF8yUDVHRV9QTUJfRlcsIGRldik7DQoJaWYgKHJldCkgew0KCQlkZXZfZXJyKGRl
diwgImZhaWxlZCB0byBsb2FkIGZpcm13YXJlOiAlcywgcmV0OiAlZFxuIiwNCgkJCU1UNzk4OF8y
UDVHRV9QTUJfRlcsIHJldCk7DQoJCWdvdG8gZnJlZTsNCgl9DQoNCglpZiAoZnctPnNpemUgIT0g
TVQ3OTg4XzJQNUdFX1BNQl9GV19TSVpFKSB7DQoJCWRldl9lcnIoZGV2LCAiRmlybXdhcmUgc2l6
ZSAweCV6eCAhPSAweCV4XG4iLA0KCQkJZnctPnNpemUsIE1UNzk4OF8yUDVHRV9QTUJfRldfU0la
RSk7DQoJCXJldCA9IC1FSU5WQUw7DQoJCWdvdG8gcmVsZWFzZV9mdzsNCgl9DQoNCgkuLi4NCglm
b3IgKGkgPSAwOyBpIDwgTVQ3OTg4XzJQNUdFX1BNQl9GV19TSVpFIC0gMTsgaSArPSA0KQ0KCQl3
cml0ZWwoKigodWludDMyX3QgKikoZnctPmRhdGEgKyBpKSksIHBtYl9hZGRyICsgaSk7DQoJLyog
UmVtb3ZlIG9yaWdpbmFsIHJlbGVhc2VfZmlybXdhcmUoZncpIGhlcmUgKi8NCgkuLi4NCg0KcmVs
ZWFzZV9mdzoNCglyZWxlYXNlX2Zpcm13YXJlKGZ3KTsNCmZyZWU6DQoJaW91bm1hcChtZDMyX2Vu
X2NmZ19iYXNlKTsNCmZyZWVfcG1iOg0KCWlvdW5tYXAocG1iX2FkZHIpOw0KDQoJcmV0dXJuIHJl
dDsNCn0NCg0KQlJzLA0KU2t5DQo=

