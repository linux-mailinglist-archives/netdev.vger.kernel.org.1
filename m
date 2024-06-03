Return-Path: <netdev+bounces-100188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161AA8D8193
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393C51C21656
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E228595C;
	Mon,  3 Jun 2024 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mrbVcqgd";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="MJxRCYsC"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C3C8594E;
	Mon,  3 Jun 2024 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717415481; cv=fail; b=p4Tb5YBRK2ky9N2ImwijHp/Drd1lGI6X0CEBPrcK5XHX7GUh6rV/8k3U7FEmk/lDNKqrNj2hTQ1ZzNKV1avxt2u0U6JVHB1r+mKAYvtzl3aINZUbZoLPIhStWibv1wr18vZpgz0RVqpXDirc/UYP+yeRnygG0GcYQe1lfPcxs2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717415481; c=relaxed/simple;
	bh=x3U6+2SBXef9rl2jxmOKGi4VWnO+mrHseG9HEFkvjAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eceW1LzUpwfUc2YBdQwjxFTz8BwaIl3VGEgNhW5EEeKBZgelbq1HjbERtRyzO7nunHmYLolqPNJSImS/H2T8RPaD5vHozT15b6KJQyEQOV2Iff7OAVaK1/NaHkt6zij3Elm+yPo1a3b7LvHPLjA9+vakN8LowZWlcQOOdstQ5iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mrbVcqgd; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=MJxRCYsC; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 930efd9a219f11efbace61486a71fe2b-20240603
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=x3U6+2SBXef9rl2jxmOKGi4VWnO+mrHseG9HEFkvjAU=;
	b=mrbVcqgdlUsH0/bkQXDNzlczl5MmQnW/0jL/4hfsIzPUzLsA534926RmE8Nynen+vR+YpA+hHG5PjRCaFlGurkLbElJV7RpGZtMd6JOk+QB1niha4038EWidBmkDYRp3XEefBHKy634CdTzsw9HP/Rfg/y1y3GVd4NUuq1O4y5k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:470d7fe9-7114-4dc2-bb2d-21ba19967f4b,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:393d96e,CLOUDID:efe18d93-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 930efd9a219f11efbace61486a71fe2b-20240603
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 790109972; Mon, 03 Jun 2024 19:51:12 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 3 Jun 2024 19:51:11 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 3 Jun 2024 19:51:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnlQS8Il44thv9uGOUPozAw5lf8OzZsKHA8DapMY47DjGO1/hn5h8sRb/O5t0RZuyLWvw+p2N7U+rICUmwXAjYnzoxo7pd811v+hx8x6MOxaOhXPV7FRydgNF9mcLRNgAc0xax4qOwP3ZxQh9c1fPFz2R+tiwgTsiT2rno2UXxuZQFzKPrUbX7TTjFodUw6Sd91lY1bEUwOT/m2lWgTzWC+ByKdSmrqmhBZXfglplpzq1tHVdL7QJlxzEzge1+N7F5ScsKlH9EJ1TUtkaX/Nk6cLYPCS/b93tmgZ5FIkjtKW26ut2mzbH2+KQ8+vP3KZQoxSZo7iSSjwCXIg4VZTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3U6+2SBXef9rl2jxmOKGi4VWnO+mrHseG9HEFkvjAU=;
 b=iRGcp1g/0gRmNnzScMupzwd8TQS98qvoPwaHIWl9x5osmzqzWXcU0TPU3s6MlUjzhlHdyTKTU2Qe97yEcC8GApO6UHChuhFTv6ORrdaM10hmymwuwliX4dRZFfUY735SmFtRyBe94BI9VRZHO1FA4NtP33tHLYbUJQZ6/CnRaNb/XFBsDGDcDawL0hBzkjCF8q9j9RH6HGwYdZsd4scWoczEZHkaF6pXIXq+ScGf84tKqu5sAS1zV1K9zTyYKu8tN5gb4OXSGhuERFKCIRUBIND6+xXkrg7UNRXFjdQZjN9kmYjX2pHgBXvK3yCNHCguKrQ+RsLcZnXolnj2XBXUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3U6+2SBXef9rl2jxmOKGi4VWnO+mrHseG9HEFkvjAU=;
 b=MJxRCYsCa+IhLT6ZAuPTKbKRzr3Qly4ct5E0PxfIjqzkP0z7umA1q6FaUnikEls3Rex7GQotJx1yQTinIgdZJNCh8ualeBMWgklrtCvEqjEDuRXI0hikhhtjNDUgPcTbRmPUlIzji9WHKTrscrh7pZd/Ptj3Kef9Zh/DY/LFj1U=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SEYPR03MB7434.apcprd03.prod.outlook.com (2603:1096:101:13e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.13; Mon, 3 Jun
 2024 11:51:08 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%3]) with mapi id 15.20.7656.007; Mon, 3 Jun 2024
 11:51:07 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dqfext@gmail.com" <dqfext@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>
Subject: Re: [PATCH net-next v5 4/5] net: phy: mediatek: Extend 1G TX/RX link
 pulse time
Thread-Topic: [PATCH net-next v5 4/5] net: phy: mediatek: Extend 1G TX/RX link
 pulse time
Thread-Index: AQHaskSf1DfXvyWrZkOPqw4pAUjQdrGvkmKAgABeO4CAAAKXgIAFcNmAgABRQQCAAD7KAA==
Date: Mon, 3 Jun 2024 11:51:07 +0000
Message-ID: <e1c0be6ef63f31867de8a75697c8db163710f969.camel@mediatek.com>
References: <20240530034844.11176-1-SkyLake.Huang@mediatek.com>
	 <20240530034844.11176-5-SkyLake.Huang@mediatek.com>
	 <ZlhTtSHRVrjWO0KD@shell.armlinux.org.uk>
	 <a6280b885cf1cffa845310e7e565e1dd7421dc66.camel@mediatek.com>
	 <Zlik7TfUsOanlBMV@shell.armlinux.org.uk>
	 <e25de8898d594d14ade148004fdddb1f2c5b47f7.camel@mediatek.com>
	 <Zl15fh7y2oZmFfd7@shell.armlinux.org.uk>
In-Reply-To: <Zl15fh7y2oZmFfd7@shell.armlinux.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SEYPR03MB7434:EE_
x-ms-office365-filtering-correlation-id: 69c1f5da-214a-4d3d-f057-08dc83c3749c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QzFzR280TFpPa1pYWVpRMkg4K2o0NXBaSUFrb3Z3cmwzYTkwRnA5RjBwU1J1?=
 =?utf-8?B?TURBODh1cjRoREVYZEFqRUxieUgxOE5zL2NkRnN0UDFLVTZ1SWd0SEw0ZXJu?=
 =?utf-8?B?eW4wWXZXcUdmV3BIRkZtb3c4Uzh2ZlNEejZzZzJTWTVnRmEvd2NKZkg5SEpx?=
 =?utf-8?B?UUNLNTZ6TEVSU3FkUU1vVHFZV2lBSHJDMUxmdTllNm54cER6RDZNZC9Nd2hl?=
 =?utf-8?B?Q2g1TFJzNGxoVTkxVkUzY2xLNGltR3ZPcWxMMklqRWNnNXRzSnEvMEVQMXFI?=
 =?utf-8?B?akh2TmhsRDNlKzRjTmJtSGZ2U1BPV0FLeDhva2tmOThGcFN3MDlaSklBK0RQ?=
 =?utf-8?B?Slg4b2ttWUlBa2dBNjRSeWd0SHlrRmx0TTRWVDI5Rjh4ZitFdERKV1RYcDQx?=
 =?utf-8?B?MXpxQ0JHV0hEcjBTSWdBNEw0Y25aRTNoMFZ4cWlodktocDlER0FpNGVwaHRt?=
 =?utf-8?B?T0ZxczZ3aHFWTFRtRklVZXN6T1NGSnJuZnZtSzN5MVE5WWcxOHpXam5VSVB1?=
 =?utf-8?B?b3NSekEvNldxeGhuYUN4ODF1Qks0UlZHc2ZuSmtGUlBzdmNLemlxLzlrZFRM?=
 =?utf-8?B?ZE45NkRiYmpBMGRMYmVQYzdVWm5QMkZNVWdvYVZGUzZqUnVtUzJIZ2dGK2dk?=
 =?utf-8?B?NzJndTNnbnBUMkx6UGVNNStqcmE1T2RlWlBhL1V2SFVGWGsxR2RCWEhGclpF?=
 =?utf-8?B?L1NQOUxROWROQWplalRHdDV1ZzE4S01PZWtCejRIb1BMZUpwYTVQSWVqSWdx?=
 =?utf-8?B?V01VRi9MblltWVdua1U5KzdHUWozU2dHRUkxOXgzSkZ3dkNKYVZmN2V0Tisr?=
 =?utf-8?B?SUhvZkgxVnErZXF2cFBDSXdiWGRwMktPMVEwOHJ6SWptK0g1RXBxclRrcGM3?=
 =?utf-8?B?NjlBSmFYcWVoNzZNZ0I3ZU9Jck5YQU9VNDY2LzVLamlSVlgrNWF2TEZWcEQx?=
 =?utf-8?B?SkdLL01KU29OSjN3cDUvZitNZGJhbFRwRUZmTDdZcGJqdHVxSHpwdWtnWkU4?=
 =?utf-8?B?REtPb3lqcmVXYkVWRzkra1ZIVU4vdkpuUnlYRVBCdk1EemJuSHcvOEZnTk52?=
 =?utf-8?B?dmNEWXc1R0tlTGkycmlsbm9ORWxkRTczODZibHM5bndCQ0N2TURLOUhUSEJQ?=
 =?utf-8?B?VXlKQmkzbEZHem5oN2tpSWQ5QjdQcm5uR0gva0plZnEwVmdpUVVzeS93eUtC?=
 =?utf-8?B?ZTZLWUlKa2VZOStIdDlxM3BaR2JueGJIRjVvdHVhdjVQYk1vMHBvNk1MN1Zn?=
 =?utf-8?B?amFieGQwdW5tQ0piOTQxMXlNRVZ5T04xSkN1SHVKTmhZcEk4S2NiZXVkZyth?=
 =?utf-8?B?R0xIazE0bG5xc3BWZE1aK1QzY2ZkWEJvSkFEYTEzanlVT3RoM1liMjZLcytm?=
 =?utf-8?B?RXRINjU3YStHeUJZMDZSNU5BQk5TZVQxbGNnNExoWDZGSHZFbksrc2hWRFJB?=
 =?utf-8?B?V1dRNlBBOE9vTFVEV3hmSytIQVgySVJCT1dUK1FxTWdyRWlrY1QvVzlPSzhv?=
 =?utf-8?B?d2xONnJ2Nkw4dCsyWUpXZjMxVnVNN0JpMjJub2U2T2dvOGxZWi9XTFpqK2s3?=
 =?utf-8?B?UWVHVUNCUmQwOGtEdmdjdWJDSVNGVmZtaXJlNG5RTzh5dnFBblRTbzZJalRo?=
 =?utf-8?B?YW5TU0RhbzJkaGJVSXJIR1dTVWUvdms3YTZTd2VhN0pDcWZScEhURGIvZFJQ?=
 =?utf-8?B?S1FOSk5tSFpRbVpMck5nOFFWVGEwTENpcVRWQzdRQjFaWkY4SmJMQkxodFE4?=
 =?utf-8?Q?3cIuda3fZimMFgKPaC2FXx9L4pO55WjbyqNGhtT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlZJbElia0QrUXMxblRCQXFzdFdkWjFJMytSUU9wOEl0emQwMGtSckN6K01h?=
 =?utf-8?B?eFluYThpZ3JWZGh0bm9Qckt3ZGsyVzB1enR1M2Z3cDRJNzcwZjJubEdldFBm?=
 =?utf-8?B?M0h2bUE5bjVjUm5UdTFjUlQ0Ukk3Yi9nRElQcmYrQWIwTDhGTkY4ejUvemxp?=
 =?utf-8?B?OXhtTXIxWkM0ajJlbS9WcGN4OXUxbDdja0xFTkt4eCtPMGVjenlsUGhEWE1E?=
 =?utf-8?B?LzAwbnh6bURLeEg1cmVmekVtSTRmT25sRzd2WmUwbmVBYzFOTFF5clNGSzdQ?=
 =?utf-8?B?K0NrRjRyOGYxTUFOQVRFcXJ0TUZLQTBLcHlSQ2VBSVM2RHJrUTlha2VBRkpS?=
 =?utf-8?B?ZEUrZFRuVGVnOFhEaVFBWGdhQ3lRYUFmbkRxTHYyUnpZR0ZnbGw1d2NuQWJ4?=
 =?utf-8?B?RitZcENFaXdXZ1Y3ZXl3MVhMNzNURXc4N2hRYUtKMk5yYUFnaVpEUXV0emJm?=
 =?utf-8?B?aWJUYXBrK1oybVRVbEVEbXFTVjVBaGx5ZGoyYi9lYTFOSjZhMXFXYWN2U0xY?=
 =?utf-8?B?bGR2YUJTcEFPM0RxeG5ZUk40eFQ1bkxyeStvZXo1eUc4akFIRHI5eVo1N0VF?=
 =?utf-8?B?WEtzYVRLeEtwWmV1SjcrOHhvbDFXTk05dkcweHNaQklCWDVjTGVpNTB2Q1Fl?=
 =?utf-8?B?TjBnUDU2eDB0L0N5OHB5WmFrejQ4cnVFejYrc1d6dURnNHI3U3RCRmdPNTc5?=
 =?utf-8?B?S1oySnN4TnpWdHhLc0xYMXFhWnh4NFkvSlY4RlE3RTVaOHY1aE5PYU1zWFpN?=
 =?utf-8?B?RGZYTUdsODNHbGl0aFNadCtUTE1nbEZ4SWw2ais2eVlUMzFXa0RVZmhpU1dI?=
 =?utf-8?B?TDk1WTlQV1FuYUhKdnJMbXBLWTl0a1RKVXYrT0dKaDNBbU5kSzlQWDRDWmp6?=
 =?utf-8?B?U2szZUdMMTFKLzZ2eHNYUmRSUHhleHRLa051aXBDZjhBZFdidWpnRnk3S25U?=
 =?utf-8?B?TDZjTnNTc293Vlh1VDhlZDhQc2JRQzhrblpBVGtXcFlZZFozZ3BYZVVUUEJw?=
 =?utf-8?B?VFFHdlVQaFJ2K2RvVEUzSHkxSUdPUURFTTVuYWRyTDBKcjdYeVdVbHJ4M2N0?=
 =?utf-8?B?S2NlZStjNFpDdVU3c3BsTTNXclZ0NEFTNDlvU2VoU3NxYmF0Rjg1QkFFdHZZ?=
 =?utf-8?B?T1lqVjdhQ2FLcTFsRERzTjZUcEZPeXVYdUJDUXFsUFNNSFpKb2JxM0Z1dHNJ?=
 =?utf-8?B?NndXWWd2MC9NOVExUjVMTTVOaEZXZEptZTl3a1pSaHZVejhrK0kzNDlGU3FS?=
 =?utf-8?B?bE03WGQralBNR2J2K3k2aHhrWHFkMG1MZktlWDNpZ09zZHkyQmpzUHNyNm5w?=
 =?utf-8?B?R3BKQkhmMkdoazZOK1pNaVozVTFHY2hrb0pXdmE5VmxuMU02cVhmcEt5dkpZ?=
 =?utf-8?B?LzJJQ1IzRVNTR1p5bmhFaFVPelBTWUlaVTYvbWxONXBtRkl2aXhTWDhwUlYz?=
 =?utf-8?B?YjUrVlFyb1UreG9RTys0QlNLY3JVTnNodGRlRmJxNnZDMnFlREpvMmQyZC9k?=
 =?utf-8?B?NE5OcmNUcWxpYW9jMWIxeUNIWnM4UkJuTFFuSmJ0SVZFSFdJRUxQSDl2KzVa?=
 =?utf-8?B?Z2FkL0lPbUJaWGxGNkpRZWtEWVNwN2lkM0RVQnF4Ukc5b3B0RGV6OGsrUTcz?=
 =?utf-8?B?dVYxYnhPK2RwelZjYmJlQ20wVzY3eE9HT1hFN2hvYy9iSEZHY2Nkak1EUG9L?=
 =?utf-8?B?MlF4U2J6VkIyOVQxZ21SSWxCWHl4YW1Bdzd0dVRHa0RKYnZiSzNDUHhMU29a?=
 =?utf-8?B?WWtmQnZGNW1sdmtkNSt0RWFodVJmdGVOWnF5YUV0V1M3UjJ3ai9lc2hBYm8v?=
 =?utf-8?B?ZnJaKzVRSSticlY3M24wek1aenJ6MDR3c0tBMXlLT2RlSHVDYkJxY1ZXL1pz?=
 =?utf-8?B?bVJSaGxPc1RwSmRKRkd4YWZYM1diZVJ2MU5rdkI3TmVrSHdRa0RaOUdwTS80?=
 =?utf-8?B?K0c2UkttVnNGbTJYckVmNmJ4ZTFEcTZMTDNLRDAxdlFuek9Hd0pzQlVGTTdn?=
 =?utf-8?B?dFJUYlhQYUU3NVpKU2dsTHUwbnJwbjg0dDFvUm85TEFhM3VuM0xoMWd2eU9R?=
 =?utf-8?B?KzlxSmh4dTNiZFdmbGtUd3k5SjkrZWRzbENReWt6VDMrajZWNkhuWmVwWWtk?=
 =?utf-8?B?V2lxRU5Ga0xMOHd4QnRJQ1R4R2xMd29QR2cxTWtYRmF2K3M0eUdYalpzemN5?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F3697A93D98F64B8E50932F7A3C5623@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c1f5da-214a-4d3d-f057-08dc83c3749c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 11:51:07.7740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zT4yq1Ck9MkimNsyxU8fbeQCtCbgWaNwkNTvOPhtLDXQnAO4Vds29YSgVN1lA8XuT4JDU+Fq3FN8mhOtYTCtNWAqPdIa3ezpErfKpU2FBqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7434

T24gTW9uLCAyMDI0LTA2LTAzIGF0IDA5OjA2ICswMTAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gTW9uLCBKdW4gMDMsIDIwMjQgYXQgMDM6MTU6MzZB
TSArMDAwMCwgU2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKSB3cm90ZToNCj4gPiBPbiBUaHUsIDIw
MjQtMDUtMzAgYXQgMTc6MTAgKzAxMDAsIFJ1c3NlbGwgS2luZyAoT3JhY2xlKSB3cm90ZToNCj4g
PiA+ICAgDQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cw0KPiB1bnRpbA0KPiA+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhl
IHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+ICBPbiBUaHUsIE1heSAzMCwgMjAyNCBhdCAw
NDowMTowOFBNICswMDAwLCBTa3lMYWtlIEh1YW5nICjpu4PllZ/mvqQpDQo+IHdyb3RlOg0KPiA+
ID4gPiBJJ20gbm90IGdvaW5nIHRvIGhhbmRsZSB0aW1lb3V0IGNhc2UgaGVyZS4gSWYgd2UgY2Fu
J3QgZGV0ZWN0DQo+ID4gPiA+IE1US19QSFlfRklOQUxfU1BFRURfMTAwMCBpbiAxIHNlY29uZCwg
bGV0IGl0IGdvIGFuZCB3ZSdsbA0KPiBkZXRlY3QgaXQNCj4gPiA+ID4gbmV4dCByb3VuZC4NCj4g
PiA+IA0KPiA+ID4gV2l0aCB0aGlzIHdhaXRpbmcgdXAgdG8gb25lIHNlY29uZCBmb3IgTVRLX1BI
WV9GSU5BTF9TUEVFRF8xMDAwDQo+IHRvIGJlDQo+ID4gPiBzZXQuLi4NCj4gPiA+IA0KPiA+ID4g
PiA+ID4gK2ludCBtdGtfZ3BoeV9jbDIyX3JlYWRfc3RhdHVzKHN0cnVjdCBwaHlfZGV2aWNlICpw
aHlkZXYpDQo+ID4gPiA+ID4gPiArew0KPiA+ID4gPiA+ID4gK2ludCByZXQ7DQo+ID4gPiA+ID4g
PiArDQo+ID4gPiA+ID4gPiArcmV0ID0gZ2VucGh5X3JlYWRfc3RhdHVzKHBoeWRldik7DQo+ID4g
PiA+ID4gPiAraWYgKHJldCkNCj4gPiA+ID4gPiA+ICtyZXR1cm4gcmV0Ow0KPiA+ID4gPiA+ID4g
Kw0KPiA+ID4gPiA+ID4gK2lmIChwaHlkZXYtPmF1dG9uZWcgPT0gQVVUT05FR19FTkFCTEUgJiYg
IXBoeWRldi0NCj4gPiA+ID4gPiA+YXV0b25lZ19jb21wbGV0ZSkgew0KPiA+ID4gDQo+ID4gPiBB
cmUgeW91IHN1cmUgeW91IHdhbnQgdGhpcyBjb25kaXRpb24gbGlrZSB0aGlzPyBXaGVuIHRoZSBs
aW5rIGlzDQo+ID4gPiBkb3duLA0KPiA+ID4gYW5kIDFHIHNwZWVkcyBhcmUgYmVpbmcgYWR2ZXJ0
aXNlZCwgaXQgbWVhbnMgdGhhdCB5b3UnbGwgY2FsbA0KPiA+ID4gZXh0ZW5kX2FuX25ld19scF9j
bnRfbGltaXQoKS4gSWYgTVRLX1BIWV9GSU5BTF9TUEVFRF8xMDAwIGRvZXNuJ3QNCj4gZ2V0DQo+
ID4gPiBzZXQsIHRoYXQnbGwgdGFrZSBvbmUgc2Vjb25kIGVhY2ggYW5kIGV2ZXJ5IHRpbWUgd2Ug
cG9sbCB0aGUgUEhZDQo+IGZvcg0KPiA+ID4gaXRzIHN0YXR1cyAtIHdoaWNoIHdpbGwgYmUgZG9u
ZSB3aGlsZSBob2xkaW5nIHBoeWRldi0+bG9jay4NCj4gPiA+IA0KPiA+ID4gVGhpcyBkb2Vzbid0
IHNvdW5kIHZlcnkgZ29vZC4NCj4gPiA+IA0KPiA+ID4gLS0gDQo+ID4gPiBSTUsncyBQYXRjaCBz
eXN0ZW06IA0KPiBodHRwczovL3d3dy5hcm1saW51eC5vcmcudWsvZGV2ZWxvcGVyL3BhdGNoZXMv
DQo+ID4gPiBGVFRQIGlzIGhlcmUhIDgwTWJwcyBkb3duIDEwTWJwcyB1cC4gRGVjZW50IGNvbm5l
Y3Rpdml0eSBhdCBsYXN0IQ0KPiA+IA0KPiA+IEkgYWRkIGFub3RoZXIgY29uZGl0aW9uIHRvIG1h
a2Ugc3VyZSB3ZSBlbnRlcg0KPiA+IGV4dGVuZF9hbl9uZXdfbHBfY250X2xpbWl0KCkgb25seSBp
biBmaXJzdCBmZXcgc2Vjb25kcyB3aGVuIHdlIHBsdWcNCj4gaW4NCj4gPiBjYWJsZS4NCj4gPiAN
Cj4gPiBJdCB3aWxsIGxvb2sgbGlrZSB0aGlzOg0KPiA+ID09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+ICNkZWZpbmUgTVRL
X1BIWV9BVVhfQ1RSTF9BTkRfU1RBVFVTMHgxNA0KPiA+ICNkZWZpbmUgICBNVEtfUEhZX0xQX0RF
VEVDVEVEX01BU0tHRU5NQVNLKDcsIDYpDQo+ID4gDQo+ID4gaWYgKHBoeWRldi0+YXV0b25lZyA9
PSBBVVRPTkVHX0VOQUJMRSAmJiAhcGh5ZGV2LT5hdXRvbmVnX2NvbXBsZXRlKSANCj4gew0KPiA+
IHBoeV9zZWxlY3RfcGFnZShwaHlkZXYsIE1US19QSFlfUEFHRV9FWFRFTkRFRF8xKTsNCj4gPiBy
ZXQgPSBfX3BoeV9yZWFkKHBoeWRldiwgTVRLX1BIWV9BVVhfQ1RSTF9BTkRfU1RBVFVTKTsNCj4g
PiBwaHlfcmVzdG9yZV9wYWdlKHBoeWRldiwgTVRLX1BIWV9QQUdFX1NUQU5EQVJELCAwKTsNCj4g
DQo+IFdlIHByb3ZpZGUgYSBoZWxwZXIgZm9yIHRoaXM6DQo+IA0KPiByZXQgPSBwaHlfcmVhZF9w
YWdlZChwaHlkZXYsIE1US19QSFlfUEFHRV9FWFRFTkRFRF8xLA0KPiAgICAgIE1US19QSFlfQVVY
X0NUUkxfQU5EX1NUQVRVUyk7DQo+IA0KPiBidXQgcGxlYXNlIGNoZWNrICJyZXQiIGZvciBlcnJv
cnMuDQo+IA0KPiAtLSANCj4gUk1LJ3MgUGF0Y2ggc3lzdGVtOiBodHRwczovL3d3dy5hcm1saW51
eC5vcmcudWsvZGV2ZWxvcGVyL3BhdGNoZXMvDQo+IEZUVFAgaXMgaGVyZSEgODBNYnBzIGRvd24g
MTBNYnBzIHVwLiBEZWNlbnQgY29ubmVjdGl2aXR5IGF0IGxhc3QhDQoNCk9LLCBJJ2xsIGZpeCB0
aGlzIGluIHY2Lg0KDQpTa3kNCg==

