Return-Path: <netdev+bounces-219329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCF3B40FD2
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 00:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0E61B644C8
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9EE21CC71;
	Tue,  2 Sep 2025 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CpwGLA45";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="H1sC+WTk"
X-Original-To: netdev@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C772332F76E;
	Tue,  2 Sep 2025 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756850722; cv=fail; b=hKss8hMa5cNUcpHWBTW0RefFqRWZxDVOf8r6hPBM2rqndFVxrhDh4jQznivkEmeNDqTRKpyLF/1Q5+QIr05m0S4GQU/qJJg3xGjg+L7ViaG7wk7ol9V/KglnlCLSkLPuns9gocHWaQ8jQL+0RoD8RPhQi6NCcvQPxZbdVghXuhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756850722; c=relaxed/simple;
	bh=Ue4tRmCPwiiiWwObx8upNoKNiThw9khI2/yO3pWmXao=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B8Ob6QsRfMM5lBWtNS9xzKyUP5TlhPyZEhmJtFAXKVSXSHKsspWSCHEKSeqagddFEtx8tfte3kPkld3Gqd2c+fL78UhZNKAE0rWO+R+psuxI1CKMRguakThvlucpzPPt4H0egbhv1eoVyXkKk2dAEERLJPb4tXtfD8IuDyE4Y5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CpwGLA45; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=H1sC+WTk; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756850721; x=1788386721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ue4tRmCPwiiiWwObx8upNoKNiThw9khI2/yO3pWmXao=;
  b=CpwGLA45eFfQ0g6tDEGomd91HZZ/1wKqrzp8ALC/LKKzl3Qv44QWgIKI
   ymNCGAv10DRGzcETHmKLvfyxqy5DMpWyDlnqAwTfKNwurVGDLmsd2AL95
   ihRfSywfFJvrBtP+JExD4TQEbgpLcDA+bToM/pQtAu1Jfxb2CkZybsyRH
   y064ym7asOTEJ8GuFtolTvU7zJG/Hn/zhEXUTRdUyu/04HNFj93PYleAS
   GY3sluEr00FgVNQ8fwsdgkX/KLjq+pIIH+Ul511A26aDi1w88nlzLcqQX
   niifY5SGFSeotvm3PVeF7xK3hRVAuz/o6BmEAKTJI2uxvXh9imCQP8h+Z
   w==;
X-CSE-ConnectionGUID: pAa/Ym4RRCOk6OPI8YpsbA==
X-CSE-MsgGUID: vvxq164MS7erwNjqBtou1A==
X-IronPort-AV: E=Sophos;i="6.18,233,1751212800"; 
   d="scan'208";a="107285543"
Received: from mail-dm6nam04on2082.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([40.107.102.82])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2025 06:05:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAZMXr26z+BqX0UKn7hibWGEEcFrbv3bBH4/+CC2ZxbTJbErBNeuDWWeol2wdIo2w1Y/68CZdvWit/fOiN56ubF3f66MhI77Q8QTMMY/YhdWHvzyDpLHwQVeeiVNlFLwEQaLBV9jgtSAuxJrPrglVMu3jRnoPtaM3XaDELOLUXQql2tbd4BliwZKRENdocZTFaMaUCZpSmsaiABCG7l2S8x66U+aRlNhLP2UTR/BEttylSI4X+EYvjaNxTPVDudKwzTmzd6JW4eLv5dlhBzyiE7GhjfAgXP6NoNl2e8JcObW5dgwBb42l9OzRCQaaUV9SJZ1ik0xYv3fYpYbxirkEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ue4tRmCPwiiiWwObx8upNoKNiThw9khI2/yO3pWmXao=;
 b=Sosx2aJyi+f6BQlPxJShlB73XQYfJOVedH/nmJX7xk9CzzBZqYK/JdKREnnY76WFVzu1Zxv9LcdMomK0lP0e32MffuhM6Ey/caysxyZV6uO0WG4tWFT5DKlCnKVT1+q13NLxBZ2ASI0Xfw/Rbl1f70c11DUCTACbeITdq5VgdOFBE5sxs2RcoL1KK3M6FDwiLWLS+SKbWU5RygxMcG2HdS/jQ1p53euwL/xAnZfX/PeyI17dNc/x4qdVrheEVgS8qXL3QxXVbVnxyBHid8Uc+EnVQyOZ+aIjDZaibPApa318jymdqPYi1dvJKfWBrI1XvrckB7YbjZjbjulE2IYRlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ue4tRmCPwiiiWwObx8upNoKNiThw9khI2/yO3pWmXao=;
 b=H1sC+WTkKNKe6MA2ByMj+CWnxCi/4yeYRczwnSyl+dnT12XZPus8Ijta5ZITO2o6JdklaBJdF8sccjI4Y1vjw32F4mZEjVbA0xWXtyOLxLN4iui8KPOG5gaZB8mhuHN50hDDIZLqRJFpjQACoUNrCKnr50G4rl7fNUj/6f34K4Y=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by SJ0PR04MB7823.namprd04.prod.outlook.com (2603:10b6:a03:300::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 22:05:10 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9031.014; Tue, 2 Sep 2025
 22:05:10 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "horms@kernel.org" <horms@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Alistair
 Francis <Alistair.Francis@wdc.com>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2] net/tls: support maximum record size limit
Thread-Topic: [PATCH v2] net/tls: support maximum record size limit
Thread-Index: AQHcG7sim/DTbd3pdkmC4DloIxkjarR/xUqAgACujAA=
Date: Tue, 2 Sep 2025 22:05:10 +0000
Message-ID: <ca3313461aac2a7e6e81c2dff16ea8fcd5caa607.camel@wdc.com>
References: <20250902033809.177182-2-wilfred.opensource@gmail.com>
	 <20250902114027.GD15473@horms.kernel.org>
In-Reply-To: <20250902114027.GD15473@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|SJ0PR04MB7823:EE_
x-ms-office365-filtering-correlation-id: 95b053aa-d5c1-4fc8-a4c5-08ddea6cc91b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TmZuSGZwclVqcElWRVpKZ2VINWxXYWxqNFhJMDNWVzE4QUFLMXBHQnZPRWRh?=
 =?utf-8?B?dTNsV05TMUxCeTBkZnpDSTVRaWVYRFdVb2FBSXZYcUhhb0tvTERtYUtZT3Rj?=
 =?utf-8?B?UjRRZy95UWw1MUVTVzAyK1lzVlNEUkJVR0lBeXprVVcyMzdKSWUwMTdpV3d5?=
 =?utf-8?B?My9KOURVR1kyUkdqZWVMYXFmaFJpbC9CemM5TGNIanFJUUIzRk5JM3RYQWFj?=
 =?utf-8?B?RUZYWll1TlhGMzBGYVNSdFJ2Z3Fjdlo4UGpEQXd3bklnM3NhUXlmY1hJQ0dP?=
 =?utf-8?B?bXk4MU0xM054RXpzYmR1QWZlYU1EUmVJTDdTaUVJRTJsWUZhY0ZYYUQreXZI?=
 =?utf-8?B?bUZKaS8vM1VvTnRBakk1VlVRUHJ4WDZZc3poQm1aek8vM1Y3cjljVWZxYU1z?=
 =?utf-8?B?UjVqRDNZK0doVkxyRUFTS2w2OXJYY2lLaEJ2RDRDdTgwbFJyUXBxNFFqUkNp?=
 =?utf-8?B?K1pwRkpEaGo1eGZ6Y0JmSmFtVE14cm9nSzNsUU1PbmJ2Qmc3RldGci95VHdR?=
 =?utf-8?B?YjkxVWJVY1hlK3RwUGE0ZDFCQTFhdFBzUW51SWNMYkNVZWxDOEwyZGJMdlBz?=
 =?utf-8?B?MDdIYUphM0RXdHNCQWhCUnJSeWlrdlh0TEpvajJXNm95aFYzWFVxaEs5b1Zj?=
 =?utf-8?B?d0U0bFVKYllpZUR6WnZlNFNPQXU3VDJ4a2o3ZTdyY3UxM0VRbHBSSlh5akN0?=
 =?utf-8?B?YVo0RnpSNCsycStOM3k2R002WjdlbUZJVlp1d0tRVnZPR1h4SUFwNUlNclRm?=
 =?utf-8?B?amlCVFF1UTBuRm90SFJja2Q5UDE4VjNzN0h3VnRBNllEZkRGZ0o3blpJTzFL?=
 =?utf-8?B?UkhMM0xJbSs4NVovZE5rVllmNFNrT2YzQy90Q0p1dWtNbTVIZjRlTlZsUDBo?=
 =?utf-8?B?TjRsdUxkUW10MkdMcjFHbTJ0Wm54b0RiNmZiZFpPS1hXVll6WDRYNnFTZy9x?=
 =?utf-8?B?OHhzdzF4SC81eXpENXlXYm1SZjMrZTM5QXgrR0U0cUNaNVdvR2l3aGxMWmNo?=
 =?utf-8?B?T2Q2MG03SjI4NEpEYU5RSlp4QTFaYWhXV1ZIR1AyaXRYbXZKdTg2Q1VvWHNi?=
 =?utf-8?B?YnhBWG9BR1dNT3RNdUdFanUwZlJiNGxBRHE1UmlIaUE3d09oZzJUWk1LcEFI?=
 =?utf-8?B?L3liR3l5OWRqWnFPT3cvWmVBRWkzcE82TjRhaWt1WnNHNXB5VzF3c050b0Na?=
 =?utf-8?B?NWJUdDkxNkRYN2pWQjVsSTh0OVgzMGMyeE9ZWEdDekhCcHBKNElZN1Flb3ZG?=
 =?utf-8?B?aERldXFQbENzOXU5My9Cc0x0OGlSNDlDalRDSFdvemwyemZSUmc5QnRBb2pU?=
 =?utf-8?B?OUZzcVlleS9aWE8xK1ZQVHl4NS9yR3JSUG4xeDlITk5YZ1FQK0NGamJBRGhL?=
 =?utf-8?B?clZqZ0RjTHcwMG1DbEl3ZEVhejRjbXRZbTA0UXVsU0UyTUNOTDlHVVFudWZB?=
 =?utf-8?B?aEdCU1ZaRkJFeVVwdFNSR01VN2pFeS85SFZtTCtrZkZzNy9lZmZmWWJSc1Nz?=
 =?utf-8?B?Znc4aHRZK0pobWVOQWhVczFPcWpiMTgxM1hYN09STlpLUElOOWtLUnBOakJ3?=
 =?utf-8?B?SjEveVo3aWNxcHk3blRYeGlHOXhOeC90NkUwVFJhVm55YnlYMXpQZElOeTgr?=
 =?utf-8?B?ZHZXWEd2eGxVWnphYTE1WXdVWjh5aVVseXFGZjlld0xpVEp1Yk8zTXp6QURk?=
 =?utf-8?B?UEg0YVJicHdVcFgrdEM2dkdRNnAxZGttZXFqOXFsa1pyWlM2RG5rOEZ1OFFQ?=
 =?utf-8?B?d285UFlad0xIZkI0S1dvQ3N4SHlyWlR6MU93V0hmclBLYXF3Z3pkUzJvYnhZ?=
 =?utf-8?B?V285cWhEa29UdmV3WUhxYUhVNHByZUFrNFJtN1BuaW9mUE5wTmRkdUorenpC?=
 =?utf-8?B?eGVQbHBwZytCeWMxNTZENW51Rko3RDJQNVgvSmQrVG9QOTBpQWpGaytpMlpK?=
 =?utf-8?B?UVF1UWRCWmlKT01hS0xiV2dxYjNrR2lCZmlZMnFFeGxOWmxwUzhtaWtNeEta?=
 =?utf-8?B?UWZXNFUwT3hRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ai9XN04zRGYwMHdGMHdOWUYvRFdOS3ZySVJjSTROcHZUcXN3YW9vODRlSWJy?=
 =?utf-8?B?bk1Fak93WGppQ2FzRm4vM21XUlpYYUlKUHJMVHArR0NVRjd5Y3UwV1F1cHdl?=
 =?utf-8?B?bEUxZ0h6a2gvMXo4RGJtUHN6SzRhVS9BYXNwUk1TVTg4dU9VWUF2M0dFQ1U5?=
 =?utf-8?B?Zmo3ajZoQ2FzYURlVTNqNkJUZUF4NE5GRGJIN0JDRUtnTWhlSllvVjBBWnVa?=
 =?utf-8?B?T2lZN1ZGMVpraE05VDJ1b29QdjU4NXBjbnRJdFFQV3VPQXJ1T3RrRWxSckJW?=
 =?utf-8?B?bVRITSt5bzlVVWtYN3M0aFdlMi9Qa3I3WkJYbHdvSlFYNmNjaElONXluVmp6?=
 =?utf-8?B?aWRDUW9XY3gvVEovQWdaMm45VTM2OUs4R2JEeEY1dHdraXB6cnV4andCRVBL?=
 =?utf-8?B?ZzJVYXRyWnpXdFpiU0dYWU9ZRnpObGMvT0xlVlB6c3F1MWZIUG95Z1pkQ3l3?=
 =?utf-8?B?bURhVXFiTVNGcmQweXNFTmtlR3FFa3ZERTFBd2ZzTTNFMkJkeXB0aHdJUXVL?=
 =?utf-8?B?RFRuNHA5NVpxVlBtQlhPalA2WFcyM0dwbmduOFNqREhFWUExL0RtN01HLzdr?=
 =?utf-8?B?RUx2SjJCampYenVQYkhib3A4OXB5RWJTWG94cHA5K1FwdFZPUTAzQjJyWHZH?=
 =?utf-8?B?dXJmQm53MnptUDNWdmhjRlRQbyszanVndFkxcWVqektQd1NoeHZNSnp2Qkpl?=
 =?utf-8?B?eXFTbWIyQ0NaR3JWaTMwYmFrVXd1VUc4ZjJ6dGNhMERScEV3L0s0Wkd1MWNU?=
 =?utf-8?B?cDF5UXNvVVg4c2ZsWGI5ampCTFVGR3dVNkxzQUZpWisvUThldmNIUHJtMm52?=
 =?utf-8?B?TWFmT1Z1T2dTY0JqMTE1SGVMdFl2OUhzd2dtMkhkUFY3Qk1kVnVJRVl4REgv?=
 =?utf-8?B?eW1SOS94N3B0UmdPM29MeVhZTEFvTTRUSGhKNTNJK0NQeVF3REJ0MmtOUWQz?=
 =?utf-8?B?dGlTNzRVMCs0TUtrN3RkWkpoc3pVUkRUSDJpTWRmNm5iTTRwazljYkF6Mmhi?=
 =?utf-8?B?elZ2RWpPVDE1Q3VETElCZjR1N2ZVbWRQSnYzYjZxRTFpaGhiMXNvUXZsVU5s?=
 =?utf-8?B?VmpMaVdjcDlxRjVMdDlKSnFuSzdxU1UxOXI5ZDA4OHEyMnFCdUx2SnFsd0Fu?=
 =?utf-8?B?eEdmU0lGM29BRjVGbklTU0lOT3NDZlk5aE01R0lCM0hlUFdwY2lVdnA3dGRj?=
 =?utf-8?B?SjJ4UlZwa2wwVUZDQ04yKzZMbTBrRUhZLzdsZm5qRjFZQ0FyWFhhRUtOT3Bw?=
 =?utf-8?B?ZXBqMEdyQjRIdGVUTFIxMlFjYXBsOXMzbm8yQlhYS1NUU0FkU3RFRGg0K1Jo?=
 =?utf-8?B?bit6UXFlQTJtSSs4YTNrTGxWU0pGbTRFY2xvNUhlT3lhclhzcGxEQlY0aGY5?=
 =?utf-8?B?OXN5T1RQZ0ZoOTVnV2tJNGt1ZVIwN2I4aFJXWmpiWVp6c3NrTVVLc3pWbUtC?=
 =?utf-8?B?cWJJZ1FSVG80R2ZJZFE1dmtpWkFiZDdYTy9tNnYzTkxZSjRNdWZ5L1hGdWkv?=
 =?utf-8?B?Rk50YWF0b1RJQ0QzeitBREx5a3hEKytFTUVYUGl6NXE4RmtyNWhNUGkyWUZs?=
 =?utf-8?B?dDhpaWllLzNnWW1PUllIbDlnSXNnOTFrY3g0eDZaK05lWkU0emQyY1hvSFVk?=
 =?utf-8?B?SFhmWG42amd5NHA5bTY4WjUzL29pVE5BUHpjbXZHc2Z6M0R0SG9qQU15MnJI?=
 =?utf-8?B?UFBqNVpQNTY4YkJ0cTJsSlh2ZkNNRTNwY0IrZ3IvWXNXdEZFWlRzL3N4S3hO?=
 =?utf-8?B?L3Q2OTI0RjhlZGNYeGt2SWVoQ1NYeXFQZWhrMTNNRVd4M05TZkVydWxQMTFh?=
 =?utf-8?B?WEwvVkZPZVJsQk1lUDI2bXc1MkxVOUloZVoxTmRWN0Ztb3pyMGVUOStqVHdE?=
 =?utf-8?B?MVZmSkZvOFhrSG10ZXBnUTkwcG4vOTE0bHRyYjZadnIzWWc1aGJpeElNVW5W?=
 =?utf-8?B?SUV2MGxEVkVNMUpTK0RkOE5hZ0d6TVpEYUVkQmVpUGpkcENQaTMxMCt5WXQ1?=
 =?utf-8?B?eEY3MFBmc1ZMc29ZWXRFOHBTRlkzZDJVcWFYejNOTUgzK0dSRTcvM0Q2RnpD?=
 =?utf-8?B?NGJoN2w0ZWpwVExxNmhxa3RPak45b3dlNUc5T0NqUW1NOVloS3N0YityNXQ4?=
 =?utf-8?B?dThKVU5BZTZKVUgyM0VDREVvbEFlNnRRU0RvVnlpL0pCWEZjaXdMOGlWZWwy?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66D5CF87C6066B439B5387EA5376A5A3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ywcOLfKtLMUNUJaImenhPTBUgiMV0y1HM+MgAAOlF/A11toaiqXhj54JO0PiOD4jQcgORdbWZqW3zsN9GPgSI6vHGX9p+RbWNvAVyWWxBlvHiGdJmTwa51wlWJv9vF81a2Geci1kcv46pT36CaTK7UlB0eBkZPEnGHuG5K7DZEhsfiPTFoTSgNGA9Fzmsrv9tfr3yB082AtII47u7VpE4fQOy0ILkK1ma4PEErUNxe8cvhe1/iK0lUzKr+NMoquFTgqx3jVm8vA5neo2nXoJY6EPMxgT8l0sv1f0p040w4eeA/Q1bqiFd4LGZ73Iw2iC1EpVudShyxdoiRM4zovpSJ0Enpk4884H4SqoMo2n6JKx1MuCuyLi5+pCvh1kY8U+fvN2Or8vw96tYqTJ1mtVDuQjiUUhDNSbvzWrW7KBSk2xnPhOk/NrdVs1HgczwPTMK1MZAmBua927l8RRITal7o90c7rQMwOKtXOqVmCAnrO3ZEt/1oU/fOX2JbJy5U3qqavlyvnwU8BAs1wdluMZwixIyg6xET7mEs9zRu8/bHAY6n0071t/OYlgpeLeV+QDJRUXMrDMSbjrZWpnfvsfQReiJ6VPXCt+Gpru/2nh+9E2CkaqKmwrdWcUcI7epoj5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b053aa-d5c1-4fc8-a4c5-08ddea6cc91b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 22:05:10.7632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cCw9bHYVGbZdK/Po1qcG9tM9J9MscGmeN0TRhqsFK37n6ltQhVQL/f/TQ9SgbhaCJ6zBPshMhZnCFcxHuigmUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7823

T24gVHVlLCAyMDI1LTA5LTAyIGF0IDEyOjQwICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IA0KW3NuaXBdDQo+IEhpIFdpbGZyZWQsDQo+IA0KPiBJJ2xsIGxlYXZlIHJldmlldyBvZiB0aGlz
IGFwcHJvYWNoIHRvIG90aGVycy4NCj4gQnV0IGluIHRoZSBtZWFudGltZSBJIHdhbnRlZCB0byBw
YXNzIG9uIGEgbWlub3IgcHJvYmxlbSBJIG5vdGljZWQgaW4NCj4gdGhlIGNvZGUNCj4gDQo+ID4g
ZGlmZiAtLWdpdCBhL25ldC90bHMvdGxzX3N3LmMgYi9uZXQvdGxzL3Rsc19zdy5jDQo+ID4gaW5k
ZXggYmFjNjVkMGQ0ZTNlLi45ZjkzNTlmNTkxZDMgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L3Rscy90
bHNfc3cuYw0KPiA+ICsrKyBiL25ldC90bHMvdGxzX3N3LmMNCj4gPiBAQCAtMTAzMyw2ICsxMDMz
LDcgQEAgc3RhdGljIGludCB0bHNfc3dfc2VuZG1zZ19sb2NrZWQoc3RydWN0IHNvY2sNCj4gPiAq
c2ssIHN0cnVjdCBtc2doZHIgKm1zZywNCj4gPiDCoAl1bnNpZ25lZCBjaGFyIHJlY29yZF90eXBl
ID0gVExTX1JFQ09SRF9UWVBFX0RBVEE7DQo+ID4gwqAJYm9vbCBpc19rdmVjID0gaW92X2l0ZXJf
aXNfa3ZlYygmbXNnLT5tc2dfaXRlcik7DQo+ID4gwqAJYm9vbCBlb3IgPSAhKG1zZy0+bXNnX2Zs
YWdzICYgTVNHX01PUkUpOw0KPiA+ICsJdTE2IHJlY29yZF9zaXplX2xpbWl0Ow0KPiA+IMKgCXNp
emVfdCB0cnlfdG9fY29weTsNCj4gPiDCoAlzc2l6ZV90IGNvcGllZCA9IDA7DQo+ID4gwqAJc3Ry
dWN0IHNrX21zZyAqbXNnX3BsLCAqbXNnX2VuOw0KPiA+IEBAIC0xMDU4LDYgKzEwNTksOSBAQCBz
dGF0aWMgaW50IHRsc19zd19zZW5kbXNnX2xvY2tlZChzdHJ1Y3Qgc29jaw0KPiA+ICpzaywgc3Ry
dWN0IG1zZ2hkciAqbXNnLA0KPiA+IMKgCQl9DQo+ID4gwqAJfQ0KPiA+IMKgDQo+ID4gKwlyZWNv
cmRfc2l6ZV9saW1pdCA9IHRsc19jdHgtPnJlY29yZF9zaXplX2xpbWl0ID8NCj4gPiArCQkJwqDC
oMKgIHRsc19jdHgtPnJlY29yZF9zaXplX2xpbWl0IDoNCj4gPiBUTFNfTUFYX1BBWUxPQURfU0la
RTsNCj4gPiArDQo+ID4gwqAJd2hpbGUgKG1zZ19kYXRhX2xlZnQobXNnKSkgew0KPiA+IMKgCQlp
ZiAoc2stPnNrX2Vycikgew0KPiA+IMKgCQkJcmV0ID0gLXNrLT5za19lcnI7DQo+IA0KPiByZWNv
cmRfc2l6ZV9saW1pdCBpcyBzZXQgYnV0IG90aGVyd2lzZSB1bnVzZWQuDQo+IERpZCB5b3UgZm9y
Z2V0IHRvIGFkZCBzb21ldGhpbmcgaGVyZT8NCj4gDQo+IElmIG5vdCwgcGxlYXNlIHJlbW92ZSBy
ZWNvcmRfc2l6ZV9saW1pdCBmcm9tIHRoaXMgZnVuY3Rpb24uDQpIZXkgU2ltb24sDQoNClllcywg
dGhpcyBpcyBhbiBlcnJvci4gSSB3aWxsIGZpeHVwLiBUaGFuayB5b3UuDQoNClJlZ2FyZHMsDQpX
aWxmcmVkDQo=

