Return-Path: <netdev+bounces-108333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E891EDD9
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 06:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8479A1C2137D
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 04:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C732BB1C;
	Tue,  2 Jul 2024 04:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ixoB122p";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="aBmApR21"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B8D946C;
	Tue,  2 Jul 2024 04:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719894350; cv=fail; b=oAL0x7nSWmkUchyo6uimaEkXiNaf62DjkuoBHBX8bL8hfEGOJybgky/+L4F4iHBT/5ujFyqayJyhKGqw2PfGwojc5LNsmcmTgmq9Wt3ykiDjiixUYBdp8X/z5zZ6//7bXvs8ceYSVBMo4/kh/NPRlwNhROpUyVXr8pWnC36I0pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719894350; c=relaxed/simple;
	bh=t0mLZrwYpEaqIKPtzWOUZg4IT82vnA8rBz/Jvp9u8rk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WOWWqsBOFMmGmpqa5g4g9ZyEbDCiB77/JhHTKeMF26g4rw3AKTWbVkjEL/JosnWTd0tz6FZO8gspecxl8JTPwiumipmmQjd5R53iXQ6eSvXkcYUP14NAjDuyPXqCO1Zdlkzslk4xARl9cY35ErxRv7SxlrpHM3FwQ+k9EggBQu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ixoB122p; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=aBmApR21; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 211a3c20382b11ef99dc3f8fac2c3230-20240702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=t0mLZrwYpEaqIKPtzWOUZg4IT82vnA8rBz/Jvp9u8rk=;
	b=ixoB122pXpZCg7Rx09e7dNTEIy/hdL6GCqfPl/SsdaNmjMFC8Jxtjj7J76xIOw2W/IsYUKsSfzeugMnpmeevPjBlKKgjOtC7nCmH3MEvpM1OxmSDtkjlrXYf9Z5qDaoDKtb2261sN/PADTdahubP9VdSKxFWGI512y3wfjD8lS4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:0a703d87-8db1-45a3-91cb-e46f72736d90,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:5785cc44-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 211a3c20382b11ef99dc3f8fac2c3230-20240702
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1233480064; Tue, 02 Jul 2024 12:25:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 Jul 2024 12:25:34 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 2 Jul 2024 12:25:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2WzTuuDewPiUtmmglMbyppd06rrs8TYz4MyvtewnFNH44RhuPQpcH9fQqdqGLGvppij1Z9fUVTqRn/tKlHLcxgo2dHvZMFbMhKcvbMEHOm4fM9YDCjvS++YaSBhVOWYedESi3QfeUu7ghzIBCewPvqIxZWGCyPrXkHJguz47I7ACjgtdl40i6MWwDEHGbIpLoQ3TQedAk68L69aL8yLh48pKWA0v3k3x/Cfas4tvMRYVH0NwaTRXTHTsSNuHx6JWfW6I8qZr6YN56v0t61loKlikxA5nL+7CI38CU+Fi+309cZEU5KRdzIJnqTWmOFQccGBq4lwIwqNzXcS6Gt/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0mLZrwYpEaqIKPtzWOUZg4IT82vnA8rBz/Jvp9u8rk=;
 b=gBdCYWS//ztWF5uC3W69cWNAsRo5s3akpsMNdY1LdcNT+NThvA4o3gZdG8eoQ2Z5hjIcTSqZmyjkCXedNVqBfULuP49toQk6eClBddwIBgZQSj72r8IbLKrnekyC25qWCSlPuISBIMwUMdkVrAsblTyHsv9qZo6mP3XERQx3oyrLITwzU7iWaCrOUJjHCWNU1cb2GYqAybCqR2QRfTJkz+gklCfY7Q2L3o6fLksLX7bi/e8Inng/BGbZZEEMQ/jYlEiTMuWi+UaP4QZ8dQWFytTWtdDvFgH8/er47mUSZr+Dl9zrF3Pkg++AlXlBu6YqYqAC3TDMBhNsGLIwqlh59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0mLZrwYpEaqIKPtzWOUZg4IT82vnA8rBz/Jvp9u8rk=;
 b=aBmApR21mWA22XVt0M0x0evdjwkreRWjZ3M1iPCSN+uTY2g5Eq4bCU0/TsfFfeF9qlrPPpPusT3cO5Q64YghtxBluU4Jn0nsC/BflEF8oOoU+l9mnksIQej8FDrsiBgEq+8BHm633I2QTZVGrIjysQ9n7LpdIXxKfhOfDllvUjA=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TYZPR03MB6980.apcprd03.prod.outlook.com (2603:1096:400:283::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 04:25:32 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%7]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 04:25:32 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v10 13/13] net: phy: mediatek: Remove unnecessary
 outer parens of "supported_triggers" var
Thread-Topic: [PATCH net-next v10 13/13] net: phy: mediatek: Remove
 unnecessary outer parens of "supported_triggers" var
Thread-Index: AQHay6Xq6EUmQNh2n0GWFI4fqW+kibHhujOAgAEePwA=
Date: Tue, 2 Jul 2024 04:25:31 +0000
Message-ID: <58fcbf403374c5feee1a1d71c51006383f23188e.camel@mediatek.com>
References: <20240701105417.19941-1-SkyLake.Huang@mediatek.com>
	 <20240701105417.19941-14-SkyLake.Huang@mediatek.com>
	 <ZoKRDSVYD_JMhMqW@makrotopia.org>
In-Reply-To: <ZoKRDSVYD_JMhMqW@makrotopia.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TYZPR03MB6980:EE_
x-ms-office365-filtering-correlation-id: 210647a7-0e07-4fef-6bc8-08dc9a4f02db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bjlyWDJZeGF0MjRsaHp2S2NKTzdXUFpMdmhERUVrQURuRVVhUUdsWVlnWXJ5?=
 =?utf-8?B?TnkrYnl4VkJJS21od0tkeDJRYTRra3Vwd0Y3eGwxM210OWFUYkV5L3I4Y3Nq?=
 =?utf-8?B?R3F2cDlDMFNrNVR2ZnhVNGc3N0p2eWprc2pjSkxTVGcwNnZsWXVrS1d6d3FL?=
 =?utf-8?B?ZDJpbXFyaXRFTUhWUnQvaXFsY0tNckZJTjY1T20vY2x2N3ZOc2UzVTJTL3lw?=
 =?utf-8?B?OFhPU29OUmFtVWVUWUdXTW5ZcCtTYWJYM0ZEN2JPSEZ4TWJ4bFRWdWROTFRE?=
 =?utf-8?B?ZDNFdlEvY0JoblUxV2Q3N2tPMW1GcFJUWmE2azE4MldFRnBPVFVoWVpZTmlq?=
 =?utf-8?B?d2VWOWt0YXRTbWRiSjBJRGF0Zld6MjVoS09WWEhSNC9HeFkyUXU4alJUamNa?=
 =?utf-8?B?eVFLaUdiUU9Od0c5MUUvekQ3VUVscVpwSGZ0Y1RzYTBVZEI4WHZ2bmtEWDJK?=
 =?utf-8?B?VUkrTjJENTFpR3lpZWx2MWllRG1rTEFEbWNHcENZMm5ZUEVTd2VFSXc0QlFL?=
 =?utf-8?B?Y01rKy8wOEo4QlZqQlVISGIxK1BOVnJJWlN2OTlQclRESG5QaTVPNU4xSHdJ?=
 =?utf-8?B?WGtRR3BIcnQrNHJLTm45bVRZbEh6NElub1F4dkdpbTVUUmF2WlJYbEtxR05N?=
 =?utf-8?B?cVMxQkZvM1I0bWhmRmdMdGtxYkQ3Z2lEZldSWnNDWWRVRG91ZzdRblZZbTda?=
 =?utf-8?B?SXNuQS83aWtBZkRiK3JEaDdEekFiRjNWSER5M3F6UVAzWERVc21wNklyam1i?=
 =?utf-8?B?MEZYRDRHdys4cCtucjJ0LzlJYkYrRTA2TUhwVjhTQVM2MVNGcWcwOFFiUzJ5?=
 =?utf-8?B?ZHVZbWUvdEhvTmxyWXJ0a2w3eHlqTlpySHRyajNKWHpNV1BQV0VYLzYrQU1P?=
 =?utf-8?B?WmF6SUs2Z2R2NVZQVUptQy94Q1dFTDJUTzM5NVFTTEd0Q2tUWUpzMHpmR2pR?=
 =?utf-8?B?S1ZneDgwOWE0Q2pZR0dLUkZZNVVOUjk5MWtUNW95UEtMQytGWUE4dUhEaFpa?=
 =?utf-8?B?ZTQxcWM3ODR2allZOGRCaERSYkZadWlzTndSNTFNRW4xbHZjbVRmQ3YyZU1z?=
 =?utf-8?B?ZXNBNWhjQ3ExWlNpN2lVbnQxUTBVL2ZDNEkrU2NKYXZNNTd0aEt0OUZxWE94?=
 =?utf-8?B?R0VrRFBKUlh3ekczd2J5SkRiNk93WUR1MDlyVGtRa1ByUkluRWMybTJZYjRY?=
 =?utf-8?B?MFBtQTZMQTF6YnVDVmVPOG4zYlpHSklXUXgwU3NrSHFxaStYOTVMMWNYYURq?=
 =?utf-8?B?Z0hHOE9uZ2w4TUpZQlVmeENYK3RsSCs1Q1BURWttSVFvVmlVWFQ3eTZSTVIw?=
 =?utf-8?B?RGJDT1RRbjM2T3c3TXVjSDd6bHQ3dGRLeU9BTDR0bGdGWUtONlJxWHB4NUYz?=
 =?utf-8?B?QUoyS2NuSUVpc0tSNkNLaWlpUkQ4Z29NODc1R1oralZtSVRkZ0c5THFRVVRh?=
 =?utf-8?B?azhweFJycW9keUIveFhMWllQNG1BVEtKUEVCNWwvWWV5Q21SUUFqSThaNWVZ?=
 =?utf-8?B?QnpmNmRvQytLVExJQmpBM3owZVYxVEl2UFp0OUxMTXBnYkVoWWR0SUoyUlpp?=
 =?utf-8?B?c1grd2d6Q1dHcnNQeTJua1ZkVUh6Mm5yc2Y0TEY2NERxRHBIa1VQemNYdWVP?=
 =?utf-8?B?QmgybExCMDhDT0hLN2NEUmYrajZ2Y294dW53T0UyWWZsMXlUdDRZK0xtcFB2?=
 =?utf-8?B?R3ZkRENvMXlINVN4RUNHS2lkMnJ0TXh5SUZ0QVgzNE1RWmpiVThDVHkwRVBr?=
 =?utf-8?B?b3FPVkI2R2ZFZW1iQmZibVZQQU9MVngzdjJ2QUM5VENpZ3ZFdThHSjAvZGpn?=
 =?utf-8?B?RDdlQUJhbjl1MDloV0p5MjVBaDBsUldFVkxzcTRmWnBZZ05lUWxmZ2gzaFp3?=
 =?utf-8?B?NE9yN2IvTnZDOXF0MjVlWGRLUVZtVk1zaUJTRkZXcUp6dkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWxndDd5bkhBdzhQUzA1ZzVMRnhpTTZxRGNwbTF2eWhMVW8yTkdtbk5yZ2My?=
 =?utf-8?B?STdzc2YyMDNTZ215TGxRblJTVG1UT3RsbUxMM3NqVnBpdE1SOXZyMUVlVnFC?=
 =?utf-8?B?QnY3elM0VUFhN0UzT2ViYmVDMUdPSlc0WUFzNVd6MDJCbDhJN2VlY2ZVU1A0?=
 =?utf-8?B?SVpUbWVadmMzSHJXWm9iVG1SVTFzSU1HcUdvcUlKK1N2UFdZUVoreG14d28z?=
 =?utf-8?B?RHJScWpkRzJjdGRSSzU3NlNVMFFCSTJsZmtlSEZFa2ZZWmtSRFNQL3ZNb1R5?=
 =?utf-8?B?SmFGRDhDaEYvWWxxV00vazdEMGs2T0RGQkhSaXB0bzR6b0w2c2JtR0tDWERm?=
 =?utf-8?B?UG4zTGV0TGFnQVdxK1pIekV4NlViNm5YR1FtMFpMM2gwTUtBRkxSZXU0YWVP?=
 =?utf-8?B?WHBQQUlhWXJvUUtBS2Z3ZG1NRHRhakxoSFRSM3Mva0RLMGhIamxQTVBKcXBQ?=
 =?utf-8?B?cFhvcXZWRUhyYlN2UHVKR3NWamFMNUdFWURsWjFqdzFacXNGVlUvWEE3L3JB?=
 =?utf-8?B?OHlueDAxVWR1Vkg2S252OHhjTWpQUC9RUW5EYWJMV2dqZ0VzdjFZNkIrY2xP?=
 =?utf-8?B?bWRhcUw2bGtBMjJXMW5WREdUWXhvWmt1ZUVhZnZ0ZnRzNS82eG91UXlwZjlJ?=
 =?utf-8?B?VU1Yd3pnWFJDVGZzNlNnejhvWnN4aC9iNkRxM2xoVXBueFFHbU5kOXdlNG4y?=
 =?utf-8?B?OFRzVkpJc0tpZDg4a0NsSWovVkFjUzJ0Y3NIYUk0UXA4UlZ5WnlsTUszWVR5?=
 =?utf-8?B?VGhmVVNDMWJvQ25ENlh4amluQ2xKNG14b1VPWjlUNzU1VEZ1V1MwcFBzZ3I4?=
 =?utf-8?B?K3NYVk5LbFk3aTFqT0N4MmhVZHlyRzU2Smc3NXRFZlRtc2hQdFlRbXBPQnJi?=
 =?utf-8?B?SUZGaHA0dHYyVTVBVUxsOHNYemp6QTRxYmJLTzV0V2s1KzdENFpkNEgyWUZa?=
 =?utf-8?B?Y2M0eWNrNkJYYTNmbzB5aWVRQ1c5RGZlbXRZT1FLY2FDNFd6V2FnTnV3ZTdo?=
 =?utf-8?B?b3VIbWQzUndaN3dUWGE4NUpSNHFxdGkwZkZGNVRuZ2tvMCtvdXdWWU9VS3Fn?=
 =?utf-8?B?Vm1ldFVuYkdCLzlQb2IvbWJzbEZUOTJuWkx6MldsUXcwNXFncGVhRmhLbUtH?=
 =?utf-8?B?UVI2SUVpRUxRVHQzWWJHUEpLTHJGczhSNThCaGdNU2hoUWdOZkVkR3p4V0M5?=
 =?utf-8?B?Nm1COVdNa0R6L092eHNOeVBEaS9VUUN5OWZQWjZtTFkyWkkzdVAwUno5WHZa?=
 =?utf-8?B?aFR0UURSeFh2a051R3dBSDc1aGY0T0hmaWxPYlMxU2pZY0gzR2F0U3JIR1Ji?=
 =?utf-8?B?Vm0xbmtnai9qUzJ5NC90My81eTZzM0tNU25FRHFhNCs2bWVhOE9JQW9LT0Vo?=
 =?utf-8?B?L3QvMEJQLzRSRG5ZRGRjeWpEZ1kzTEluTTBLQTZ1ZzRvSE9KZnJ5SmZZS3Y5?=
 =?utf-8?B?K1VCWitWRlV0Tkk2eGZBUzdwcjBYYVBSTXVhRVhjWDA1eTRFNm9VeVRMci9w?=
 =?utf-8?B?WTBCZlZmQnl2dUJjS3NwNjV1S1k3cWtqbm5lNDlBeEl1YmxKZWg1SGZtdFkr?=
 =?utf-8?B?S3B3eERGSmZZakxiU0t1ZHRTcVk4L0FIbEZoUjU2d2dSUXVyYjVRenIwQlVj?=
 =?utf-8?B?b3FYR1RnVlRlWHpTVmNla0VlSXI1QUUyUDIrUVp4OUdSbWtaYzlyS2M4Q3ZH?=
 =?utf-8?B?eVlabU4xZVAzdmdOYm9LYlkyOWZuTVRIT3NEN0tVaVJmd1p1QzhGZUlxelFL?=
 =?utf-8?B?bnNGTU1oeTZTT0hINlV6NSsvWkVOL3FtY1RRdk9CZTB5QVNPWVZyT2V0dmtI?=
 =?utf-8?B?RkttTUxrOEZEWFk0bDNCamFKNThuSmJWc2JTNzFqWnZYZTAweUN0aXRMQkZY?=
 =?utf-8?B?WklPRDBBR1Y4Tk9UbWtlMVlwVWswQm83cmxIcmhBalBaNU9yWWtlZG1zZkZw?=
 =?utf-8?B?R0FzcU9pSUNqb1FDdXNpdnJLeTFaNk80ai84OWNQcW9Ma283RWdCN29RS0JF?=
 =?utf-8?B?NVVxRVZTTTk3cHFJWWh4czZNZUxLZDEyQ0JNWlc5Y3pRUlhMcTlIMXh1bjBM?=
 =?utf-8?B?WERCVTJUK1h6M1pUQlpMRTc1MklFRzVSL0dJcFpURE1VTGR4VVgzc2NoaHVu?=
 =?utf-8?B?UVNZU25qNUJtT2pKWWNDbkltcTBheWpjVVNEUW55YUVGM1B2b3pVaWxqYmxp?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57916D758408184E925FC1C3BF4B4AFD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210647a7-0e07-4fef-6bc8-08dc9a4f02db
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 04:25:32.0365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8kk88jmvnF5c7LaSfosYm+6xTYsydeqzlNlkwpFL8jPj7l5J1Kq8fz29Wl/iGjuO9IF/ZMgrL84cfG+9caTOPLJihPEqPvBe4H55X1duOxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6980

T24gTW9uLCAyMDI0LTA3LTAxIGF0IDEyOjIwICswMTAwLCBEYW5pZWwgR29sbGUgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gTW9uLCBKdWwgMDEsIDIwMjQgYXQgMDY6NTQ6MTdQTSArMDgwMCwg
U2t5IEh1YW5nIHdyb3RlOg0KPiA+IEZyb206ICJTa3lMYWtlLkh1YW5nIiA8c2t5bGFrZS5odWFu
Z0BtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gVGhpcyBwYXRjaCByZW1vdmVzIHVubmVjZXNzYXJ5
IG91dGVyIHBhcmVucyBvZiAic3VwcG9ydGVkX3RyaWdnZXJzIg0KPiB2YXJzDQo+ID4gaW4gbXRr
LWdlLmMgJiBtdGstZ2Utc29jLmMgdG8gaW1wcm92ZSByZWFkYWJpbGl0eS4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBTa3lMYWtlLkh1YW5nIDxza3lsYWtlLmh1YW5nQG1lZGlhdGVrLmNvbT4N
Cj4gPiAtLS0NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvcGh5L21lZGlhdGVrL210ay1n
ZS5jDQo+IGIvZHJpdmVycy9uZXQvcGh5L21lZGlhdGVrL210ay1nZS5jDQo+ID4gaW5kZXggOTBm
Mzk5MC4uMDUwYTRmNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9waHkvbWVkaWF0ZWsv
bXRrLWdlLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9waHkvbWVkaWF0ZWsvbXRrLWdlLmMNCj4g
PiBAQCAtMTUyLDE0ICsxNTIsMTQgQEAgc3RhdGljIGludA0KPiBtdDc1M3hfcGh5X2xlZF9icmln
aHRuZXNzX3NldChzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2LA0KPiA+ICB9DQo+ID4gIA0KPiA+
ICBzdGF0aWMgY29uc3QgdW5zaWduZWQgbG9uZyBzdXBwb3J0ZWRfdHJpZ2dlcnMgPQ0KPiA+IC0o
QklUKFRSSUdHRVJfTkVUREVWX0ZVTExfRFVQTEVYKSB8DQo+ID4gLSBCSVQoVFJJR0dFUl9ORVRE
RVZfSEFMRl9EVVBMRVgpIHwNCj4gPiAtIEJJVChUUklHR0VSX05FVERFVl9MSU5LKSAgICAgICAg
fA0KPiA+IC0gQklUKFRSSUdHRVJfTkVUREVWX0xJTktfMTApICAgICB8DQo+ID4gLSBCSVQoVFJJ
R0dFUl9ORVRERVZfTElOS18xMDApICAgIHwNCj4gPiAtIEJJVChUUklHR0VSX05FVERFVl9MSU5L
XzEwMDApICAgfA0KPiA+IC0gQklUKFRSSUdHRVJfTkVUREVWX1JYKSAgICAgICAgICB8DQo+ID4g
LSBCSVQoVFJJR0dFUl9ORVRERVZfVFgpKTsNCj4gPiArQklUKFRSSUdHRVJfTkVUREVWX0ZVTExf
RFVQTEVYKSB8DQo+ID4gK0JJVChUUklHR0VSX05FVERFVl9IQUxGX0RVUExFWCkgfA0KPiA+ICtC
SVQoVFJJR0dFUl9ORVRERVZfTElOSykgICAgICAgIHwNCj4gPiArQklUKFRSSUdHRVJfTkVUREVW
X0xJTktfMTApICAgICB8DQo+ID4gK0JJVChUUklHR0VSX05FVERFVl9MSU5LXzEwMCkgICAgfA0K
PiA+ICtCSVQoVFJJR0dFUl9ORVRERVZfTElOS18xMDAwKSAgIHwNCj4gPiArQklUKFRSSUdHRVJf
TkVUREVWX1JYKSAgICAgICAgICB8DQo+ID4gK0JJVChUUklHR0VSX05FVERFVl9UWCk7DQo+IA0K
PiBUaG9zZSBsaW5lcyBhcmUgYWRkZWQgd2l0aGluIHRoZSBzYW1lIHNlcmllcyBieSBwYXRjaCAw
Ni8xMw0KPiAoIm5ldDogcGh5OiBtZWRpYXRlazogSG9vayBMRUQgaGVscGVyIGZ1bmN0aW9ucyBp
biBtdGstZ2UuYyIpLg0KPiBJIGdldCBhbmQgbGlrZSB0aGUgaWRlYSBvZiBkb2luZyB0aGluZ3Mg
b25lIGJ5IG9uZSwgYnV0IGluIHRoaXMgY2FzZQ0KPiBpbnN0ZWFkIG9mIGVkaXRpbmcgd2hhdCB5
b3UgaGF2ZSBqdXN0IGFkZGVkLCBiZXR0ZXIgbW92ZSB0aGUgY29tbWl0DQo+IHJlbW92aW5nIHRo
ZSB1bm5lY2Vzc2FyeSBwYXJlbnRoZXNlcyBzb21ld2hlcmUgYmVmb3JlIGNvcHlpbmcgdGhlbSB0
bw0KPiB0aGUgbXRrLWdlLmMgZHJpdmVyIGluIHBhdGNoIDYvMTMuDQo+IA0KPiBBbGwgdGhlIHJl
c3QgbG9va3MgZ29vZCB0byBtZSBub3cuDQoNCkluZGVlZCwgSSBkaWQgdGhpcyBvbiBwdXJwb3Nl
IHNvIHRoYXQgcGF0Y2ggMTMvMTMgd2lsbCBzaG93IHRoYXQgd2h5DQptdGstZ2Utc29jLmMncyAm
IG10ay1nZS5jJ3MgcGFyZW5zIGFyb3VuZCAic3VwcG9ydGVkX3RyaWdnZXJzIiB2YXINCm5lZWRz
IHRvIGJlIHJlbW92ZWQuIEhvd2V2ZXIsIGlmIHRoaXMgZG9lcyBjYXVzZSBwcm9ibGVtcyBmb3Ig
cmV2aWV3aW5nDQphbmQgaWYgdGhlcmUncyBuZXh0IHZlcnNpb24gZm9yIHRoaXMgc2VyaWVzLCBJ
IGNhbiBtb3ZlIGl0IHRvIHBhdGNoDQo2LzEzLg0KDQpCUnMsDQpTa3kNCg==

