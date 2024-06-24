Return-Path: <netdev+bounces-106063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150649147AD
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412CF1C206AA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 10:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B091369B6;
	Mon, 24 Jun 2024 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kPVteT+P";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="b83gS+ea"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6E125D6;
	Mon, 24 Jun 2024 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225684; cv=fail; b=A9zxOowzMdVoxIGrwsjPC47xL/cZdQs9bq0Dsaa0K7ngy2IJgnygkHy7eQOm6H8WHS78LVpTfy2uozufC8WbzWR5i+aeOk9jSlBQq+73J/cZi0ZF9MxwzPz2gOVAEABynyt0jqCMboKJgz9Cr2pkSxapxTswdw5TWMYAeRACKDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225684; c=relaxed/simple;
	bh=O+8I89IvXB9Sy+XxZPVHlWXKOXQOWmwT8PK3uBDKY4o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OAsXjQ1zSKWkuN/8iNk0Pw82X1xbsjRXNh+S/ivpWe0dtssY3TypjyyJV36pMJzHHqkIKh8RKd3yVMkFv/TB66s7oTWD8TizBmp6vrfCMtCtQrluBxlZwvwR/yJ1dWYRG9tOHU3Mb4XY1gdTWLRi64Sc0dzTYWkEJGjey2cGEUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kPVteT+P; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=b83gS+ea; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4854c5fa321611ef99dc3f8fac2c3230-20240624
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=O+8I89IvXB9Sy+XxZPVHlWXKOXQOWmwT8PK3uBDKY4o=;
	b=kPVteT+P6iYM/jJijnOO2jAC760VSwZpIgGFOYEbHOwaa7SlleqneGrkXoiIZfopTBSdaeb/hZAwNET2rEtLigyo09HqnjJviGBKxUILrbYRznVfKMqn2l2M/0qlnO4Yt+66JW3BUZRy21pQ515rCDs/U3/GoSPw58HmoiMk6S0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:c019d9ab-d9b5-4372-a5af-b6a388bda92f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:73c1f688-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4854c5fa321611ef99dc3f8fac2c3230-20240624
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 807630300; Mon, 24 Jun 2024 18:41:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 24 Jun 2024 18:41:14 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 24 Jun 2024 18:41:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fd8btj9WMWbjVuzgHLzKgExELyymdu5++7gn3T9xABaILMtM1oKLXV2wgc3jo+Y5AgXPlaUHaelcsVIweDlNq/IGPXO3pV852wTxkRZlQx1zwFMpREEizv96cTUDebD9vTxRpa79D8cHw1jvt15Bpnbe2CJpUZDAn9eRM2WNPQBQSOXB6m+AEaSfYuYlSz/jzwPQoxE9FnArxKRVr4o32+555cxATfcCspFFeLQzqopj6V5HS2eQV21YOEba+EcwF393vTSqU547ubYYP5DqIujMCG7HzCQjPbzlpt4qTU18D67zU8phtNdc6obd00b369aUjfx/TpXNmE2hD30t4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+8I89IvXB9Sy+XxZPVHlWXKOXQOWmwT8PK3uBDKY4o=;
 b=Jkjjl3dDe6ynsjpSs8VvkQ5oGt6ZsR5O+csyN0RGLIVbBnE/6TQ1mbbsYOZJZBKh1qD9JazByzldse6qtGyv4iq+MJWn9mYFK6ig7XfPNj8GS6p/eg8QWTo/cf7VRFr5F68dyKsC0yGsTBn6LS+fJP+fUEg1cPrZUGlylOoIrgiKByqqj6I75WxeZnLR9TnOS3oG+KrQ2qEcdQ15v9DOZV2nl9mpkBg9VcjhyHxoRLf+FkoxmF/OBfIqpjaDETbPsumIVv2ZER9e79V+//Lez7dnR5kB79T3qoa/EpmJQTZ0lcNytUmkWLS+0PCDYIQhH32y0Bz7Mb/al8oaUhkfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+8I89IvXB9Sy+XxZPVHlWXKOXQOWmwT8PK3uBDKY4o=;
 b=b83gS+eaH/GnbjRc5Py4R3f71DuMhrpaVvloNoqDr1ScRmQzMK/pSSurc1rIJu0fWSFBbsr/8g6u1sq56MHKLKWBCqctWBbZaQMTRV/pVi1z6XgRGeYHtPEZKDz7MHk1hhh+JIRiSG7KIblGgY+pnx1mixxCpa+9Ni8mEOYzZGo=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TY0PR03MB6497.apcprd03.prod.outlook.com (2603:1096:400:1be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 10:41:12 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 10:41:12 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux@armlinux.org.uk"
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
Subject: Re: [PATCH net-next v8 09/13] net: phy: mediatek: Add token ring
 access helper functions in mtk-phy-lib
Thread-Topic: [PATCH net-next v8 09/13] net: phy: mediatek: Add token ring
 access helper functions in mtk-phy-lib
Thread-Index: AQHaw9Zd5HKF364J6k6+oMY+On6VprHUD0WAgAKvGwA=
Date: Mon, 24 Jun 2024 10:41:12 +0000
Message-ID: <a4740076aee9b42aab766bcc041fe67a28753d12.camel@mediatek.com>
References: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
	 <20240621122045.30732-10-SkyLake.Huang@mediatek.com>
	 <2c0ce908-55a5-4194-ac7b-68828ed10399@lunn.ch>
In-Reply-To: <2c0ce908-55a5-4194-ac7b-68828ed10399@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TY0PR03MB6497:EE_
x-ms-office365-filtering-correlation-id: b3a45605-2646-470b-31d9-08dc943a2ac8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|7416011|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?Q0U4ZG9XY3BNdjFlNCtRRXFVcyt5bVFiY2dCdzJIYmNYWE5WWEVzTDFUdXkv?=
 =?utf-8?B?a0VTb0NrVnVmUEVSNDV4YmxGWjNrNkhQeURWRU5HMjM4TDIydkJqc2xLTWsz?=
 =?utf-8?B?NXV1YWtXWjFGNzBQTTNuKzd0RjF6UHlMVkY3Y05yUC8xL2xaZTUzeUt5bGw5?=
 =?utf-8?B?S0ZSSnFkcU52cWM1WHVLNlllampTYlkwUWJwc2Z4Wjl5bzhuQUdqSWxXeHdF?=
 =?utf-8?B?ajNEaGdMb0pRS2k4SmRzclFvNGVVS2xUQk1xWXJjNEZqaVpkRk9jemc5VzVi?=
 =?utf-8?B?NGUvNDU0VVl2WTQ2Z3h5Y1Z2Uy92WnFsd1ExUjRVa21mRW1DZW5VcFJ6VFpa?=
 =?utf-8?B?RHVEWkpuWHpWTUUzdkV0MmY5ZGxQTm96V1lKTkt5cU5uREJGYXlKRDYwZjVS?=
 =?utf-8?B?dm1NL2huOUp6ZTJEbHpoOXlKYUJPaHZYdVlkTmEvcDM0enNpNG5DWEJHL09r?=
 =?utf-8?B?M0ptZDdxNWFzT3hRM0dFcHVyQUlOUXpEYWNPT3JnbENDa3pHSVMvZ2NoK3lI?=
 =?utf-8?B?QjFpNEx4Q3ZHNWZmQlRRSCtIUG9OWXNTM253S09nNXZWY1Z6bjc5NCs1NURN?=
 =?utf-8?B?dzdNcjBEYlluM3hvNHg1WXEyZmZ5cTUvOUxHNXpjNmlKREJnWElvTm9SVi9o?=
 =?utf-8?B?eWhXTEFpdXNKb3FlWHlRb0NXM2Yyd2xhYWorOXVRenZZeTlnWEN4WXQwVUtn?=
 =?utf-8?B?VWtDY2VYMGtqZFpWU2ZSTkJGN3FqUktTOGZNSVVkcmMxbFJvMjFRYloyWVlZ?=
 =?utf-8?B?cW9paGVVNmhHbk5FL0swRCtIZGRoRXdhekppczdmM2Uyd21aMlMvSEloUXcx?=
 =?utf-8?B?TDJTeXVqak0xNHhqcHpBWVQ1a0Z0T09tRkZmdE5oWkFtS2wyTldKb1RjMFcr?=
 =?utf-8?B?RUpWWmNTWlQ0ekljdUltNzRCcDA4K1FsRWdQQTZNdnhLVWxSMmVrYU53VjE4?=
 =?utf-8?B?VDZuS09UVENOcTIxK1FBdlZSMHNDb25xZ0g3S3pTU25iREVwc3plWW1UNmI0?=
 =?utf-8?B?MFZHQ08xT0d5M0haMVU1WmFzam1Cb3dySWFqK2MwWGppc2RjTHM4R0hITDls?=
 =?utf-8?B?MkYvYmxaWThXOHF5dGQ1NkpRZzMrc0xYQkRZMi9BcSswT25JUVZYZUVBbTZa?=
 =?utf-8?B?dFJYblBLVEFzTjY4RTVpYTF5STdyUnVzQVZkY1FxOVoySDY3MVNFU3RkS284?=
 =?utf-8?B?RTdaak5pZnVCc2FNWnBVbnN0ODZHRXhFNlFXOVBPR0ZNOTkwcDlOYUdEeEhI?=
 =?utf-8?B?SW9PM0NpL3NrZ3d3bWlJUCt3L2l4SUphdUpsNzMrekdWWGY2cUYzbno2UUQ3?=
 =?utf-8?B?RUQwUkRlb01CNnpLRnBwV0ZBRmZoMjhWWTRmWGcxcWcxM292d2ZVNmFaZ3BP?=
 =?utf-8?B?Q0tTRUhJM0szdzY4SVcrQnJZemlqdUJ3d2FZUXVNL2t2UWo4bmZUaGU3a3Zx?=
 =?utf-8?B?eTdnbzN1bk1LNEoyZThtcXI0THN2eSs3eFRoSHMzekRrUGpHUnZVZTA3aXFB?=
 =?utf-8?B?MlNIQUhCTFRNTFgzWGRiV0hwQUlVYjFIbUozdHFXWWpSWUIxc1FPOEM5RHNh?=
 =?utf-8?B?RGVNTUdaQ0NNMEVzY1dydS9WU3BKYkYzc0xQVWFBTGxVZjIxMlYwdEQ4SUs2?=
 =?utf-8?B?a21WaE1INmM0OXV1ekMwQjRiS2M1M3lPYmI4emw5cGRGalhjeE9odDRPUjJR?=
 =?utf-8?B?UjRjcTRyT3hwTE41bGNDaUd4c2hDYVZESHN6Z0ZBQWpBVTdkS09yM2xMc3d4?=
 =?utf-8?B?cU5UQWgwUEV4MWZmb3BqS05TK012NHB1UmJCMmdsekQyU2xpek1yKzN1V1A2?=
 =?utf-8?B?bU9zWnBvNEpTUGdwK0NYeXRsL05tQ3kwQWZDWWMyUVNzb2ZZQ0R2cHRmMlFz?=
 =?utf-8?B?bHZnU1VMc2Fkb05RRFVoV2ZpWkRiaGFFU0dndFptNC8xZ1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDBRaUVKSy9mSmRWSWNmVTQyU1pLWlk0QUJrc1hicjB5OG5Ic2ZDKzhVbUpH?=
 =?utf-8?B?SENFcElqUGNweGJ2Y0c3a3ZVSE4yN05FSE55enRkZ0FQcHoxTWlPaHhVZ2lH?=
 =?utf-8?B?bE5kK3dKMXg3b2FpQmJ0OHl1WThmYlY5bVBXZ3dxZ0FlS1pYNEcxcHVvU0lF?=
 =?utf-8?B?L1MvdjdDc2ljMWVXUUFrd04xU1pMbW92UE1KN1dGL3l3NFZEcjV4dUYrOG9y?=
 =?utf-8?B?aXpDVFVBT1N4OEQvOTBxVTlaUHpiMmhDQlZRanlQTDd4WklLQnpNamIyYUM3?=
 =?utf-8?B?eitiaGwxYW82VG41TkR2QTV3OHhnOFdZaWhtaTk0UmpaT2l3aGgvMzlkMU9o?=
 =?utf-8?B?NFRNejJ5c1ppd1VRZzJHaFI0UGhYUXNsS2pHM2tMeWdERW5WSGF0ZHdENDhC?=
 =?utf-8?B?SnpaMmI2bzU5QWtheExJOUR2Z1lsbEVMNUVWcXNlMnNzNS9iamhhVjNrUDFX?=
 =?utf-8?B?aDY2Y3ZnTlBqK2hMblNwSDNjZGJhL25xMDdzSFpyaWVtOFRNUWt2SGNmOFlX?=
 =?utf-8?B?cVBaamRJU0RJU2Vnb3lrTlZtQ1RoQnVFeVpxMXM5VEFyTW5tV1VOVVZjVjVB?=
 =?utf-8?B?YllYUnBVdXQ0K0FYR09MOWZObjZ3YlVLSkx1aHpqVGMya09mN3pmOUZVN0Np?=
 =?utf-8?B?RldqQ3RiZDhyKzdvR0lkRzk5WElIV29jeVdqeGdFTEoxSEwwckZiQ2hxZmY0?=
 =?utf-8?B?NGp0cTlxT2RWWHo0eWZuMVF0aGRleE1qUFhEYmo5L29tN0lhd1RaWTFhRng0?=
 =?utf-8?B?N0pNSSsyQzhKSk9jWTFpbWdNM0M5Q1FlU3I4ZU85TWd2M0dWdTRLcndRZ1Z0?=
 =?utf-8?B?SE5rVWVYSGJUd1Z2blpoK1EvWXBFckU2YUp0VXNtNjhHNEhKV2s2WUVqNldO?=
 =?utf-8?B?aFh2OWVrQWlOV0RNUmNaMzdPRXpaY1lDKzhGY3o0dzQvTituVXJYNlZTL256?=
 =?utf-8?B?a1VzamNuVDMxWFluQWlNMkY0ZEhub3FMNFFUZzRmRm1rUjNHclhVODZhWlRQ?=
 =?utf-8?B?OGwyN3dwL1lFWXBMc3QxSS9IaThLMlpTOHpWN0N3MFpsVXRxR1dmcnM5cU84?=
 =?utf-8?B?YkhRL1NYaU15aEFBYThMS0gzTjRYWHMvb1U3eFdwdEpvVmh5NDdBYmlMZGVt?=
 =?utf-8?B?dFhzc3BqSXZMZnp2WDlvOTZKaFNJTmx2YlBMR2dsNjVSNmpHS253TGtod0ds?=
 =?utf-8?B?SW9VcERRVUhtaGF4YWVRQVhiZzFZZDRtTS9odkludEpaUVRvMXNZaFdIVVFn?=
 =?utf-8?B?Zi9rK2dsZ0ptVkNYNDBSRDRsWktsVDV3SGMxRzVRY0hteG54ajRoWWJTV3Zp?=
 =?utf-8?B?YjNYUXZhcTdlSElmc3dtck5HUXBEWldwbDdmYWdkYzVKdnVTNm0vbHkyS3p1?=
 =?utf-8?B?UGtOby90eUczM2pzTHBrWTlhV3pLUlBhRmpQWGE0QS9pYmpQcVNLenVQMGh1?=
 =?utf-8?B?ODFVWCt5TVRPK1R2eGJJM3pkNWRNQTRTNG93RVQ5Tks0R0F6clJkN2ZGbnp2?=
 =?utf-8?B?b2ExbWdFVFhyOFk4WlpxR0kyYXljV1pTbkFsbFRDd25QVmJPVVVKQmozZkxX?=
 =?utf-8?B?SVdRa09qMjNLa09CK1JrS3BRcXpuMFh3UnhPMFFwM1AvMkt6Vk5qTHppSmZK?=
 =?utf-8?B?K2hVcXNRdmthOWxscEIyMjhjWERLcHV6U0I3a1U0ZEIrQjFoNHgvdEFqQ0xr?=
 =?utf-8?B?bHBXSXZtRVhReXh3b08zSzBaZy9qZHM3WjI0OU9IakpOOFE2aUozcmhoSlFq?=
 =?utf-8?B?cDczTm1LNlhFaWY4dmwyL1UrVnJWUFBROFBmeWt3dTJrSjNyWlRVWG54Y3RU?=
 =?utf-8?B?dGxyeGhKY3BxcjM0WEFJdzBJenVoNFFCUFE5aysxRm9jc0dKelBXQXhneEJH?=
 =?utf-8?B?K1EzYy90L1M3ZTYvT1FCTlZPYVBia1JzT1pGQlg0bGJoSjZUdmorMmg4VFdI?=
 =?utf-8?B?dEtIajQvQjNFZlpPd0tLcGE4Tjh6NDkyREhvUys5bXYzTmZ6Q0NLdEFhbmU3?=
 =?utf-8?B?K3JoYU56cVkybWlvT2JINDV1MUIxcFlpc0YzdStFcXFVM2E0WWcwTXNWVU1P?=
 =?utf-8?B?Z3BlN3B5QlNLV2h2NVkxTmN1dVpjZ2FrSnNPdnMwMXFpVnhxUXJpa2FmZjVE?=
 =?utf-8?B?M011cDdMZnp1U2tmNE5WS3JxOW5oRlNNN21yR0JITTNsa0FBTDltMGFUWWZs?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A4392B7F1523F4C95FF00B222495145@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a45605-2646-470b-31d9-08dc943a2ac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 10:41:12.6044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kM1cuA2nvKCyktm4WFMp8CArowwEge2agqf8PU9IV+Ft40yuZnsHr5pzQa57mY+iPU1TvEGbD/9tG49s0bifh3aA7hKY4HyB5zBKb+OriA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6497
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.696800-8.000000
X-TMASE-MatchedRID: F7tLedRt7ifUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCsup1wbeiPwat8Hj/rv1Iph+Mk6ACsw4JlwpnAAvAwazZN7
	dK4/0AdQ5lQXYodrwOd7x/oGnlZAtzB1CJ6qmdNqWLCkl1lq7ByczCwl6L4DDxR3MCi+lBP8yHe
	XTKRzf6NlkoR7rTqHOokd86YtA9DNC/bXMk2XQLIMbH85DUZXyavP8b9lJtWr6C0ePs7A07QKmA
	RN5PTKc
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.696800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	17243D3930833F6CDE6610508F66E7D500E39552AFCAA9C378EEDD0B8B24B2AB2000:8

T24gU2F0LCAyMDI0LTA2LTIyIGF0IDE5OjQxICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBPbiBGcmksIEp1biAyMSwgMjAyNCBhdCAwODoyMDo0MVBNICswODAwLCBT
a3kgSHVhbmcgd3JvdGU6DQo+ID4gRnJvbTogIlNreUxha2UuSHVhbmciIDxza3lsYWtlLmh1YW5n
QG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBUaGlzIHBhdGNoIGFkZGEgVFIodG9rZW4gcmluZykg
bWFuaXB1bGF0aW9ucyBhbmQgYWRkIGNvcnJlY3QNCj4gDQo+IHMvYWRkYS9hZGRzDQo+IA0KPiBw
bHVzICJhZGRzIHRoZSBjb3JyZWN0IG1hY3JvIG5hbWVzIGZvciINCj4gDQo+ID4gbWFjcm8gbmFt
ZSBmb3IgdGhvc2UgbWFnaWMgbnVtYmVycy4gVFIgaXMgYSB3YXkgdG8gYWNjZXNzDQo+ID4gcHJv
cHJpZXRhcnkgcmVnaXN0ZXIgb24gcGFnZSA1MmI1LiBVc2UgdGhlc2UgaGVscGVyIGZ1bmN0aW9u
cw0KPiANCj4gcmVnaXN0ZXJzDQo+IA0KPiA+ICsvKiBjaF9hZGRyID0gMHgyLCBub2RlX2FkZHIg
PSAweGQsIGRhdGFfYWRkciA9IDB4OCAqLw0KPiA+ICsvKiBjbGVhciB0aGlzIGJpdCBpZiB3YW5u
YSBzZWxlY3QgZnJvbSBBRkUgKi8NCj4gPiArLyogUmVnc2lnZGV0X3NlbF8xMDAwICovDQo+ID4g
KyNkZWZpbmUgRUVFMTAwMF9TRUxFQ1RfU0lHTkVMX0RFVEVDVElPTl9GUk9NX0RGRUJJVCg0KQ0K
PiANCj4gU2hvdWxkIHRoYXQgYmUgU0lHTkFMPw0KPiANCj4gQW5kcmV3DQoNClllcywgU0lHTkFM
IGlzIGNvcnJlY3QuIEknbGwgZml4IGFsbCBvZiB0aGUgYWJvdmUgaW4gbmV4dCB2ZXJzaW9uLg0K
DQpCUnMsDQpTa3kNCg==

