Return-Path: <netdev+bounces-106060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ED19147A5
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13BF1F22133
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 10:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9524136E12;
	Mon, 24 Jun 2024 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ru2GvpyB";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="DZ7ZvhCG"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906B136E11;
	Mon, 24 Jun 2024 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225493; cv=fail; b=rO+e+XyyqY8xv61qLFfUbcH92mr/C9XLNrFNVWnb1/zswyOGws95RlmNpubAUnxwgNZediJvqbQz7KaynMve5X3NH2KijDxr/+PREgX90MXDu76nWlRt3bMF0henOqAB6xmkprBuTrIv3ovfQ+U0ChVPVy3q4mVrCldqJ/QXUAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225493; c=relaxed/simple;
	bh=DfKCYJwVZYMcXZ6Nl+dj+s5d9NO+71ZRFQa2akzg/ls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p9PGZY85sT2ElSawTFdxurZL80XkZlJ+1MPYj4GexIUjAXoHwNUu6RvvEH4Gnj7+q1Bif+6PPVd4sLBsCXPQPjPPs+Xz8AW3B/B24hI2iheyCB4Osqc1kC2r3YnmHK3xfqzi9kx9HZEmVymQEFfHctLVtUtbPYfkmAG0GCqGvVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ru2GvpyB; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=DZ7ZvhCG; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d86b8bfc321511ef8da6557f11777fc4-20240624
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DfKCYJwVZYMcXZ6Nl+dj+s5d9NO+71ZRFQa2akzg/ls=;
	b=Ru2GvpyBqR2ITnhs8XZcc0fxD0yFvzrTqpMYL+NcnYTnyXUg6ZBplXg2QvCb+GQnRYaENXjRfUrFMCUvsy8kEqRrVh0EOz0/9zul9m9mIaKTpDNttQr74NiWxmaw05K6qJ6E4A8G8GjMxHp4Hih/zeLkiV++r3Gyqz+Y3UWkHFk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:636afefc-01c1-4239-b125-054a541a4fd2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:80eb7685-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d86b8bfc321511ef8da6557f11777fc4-20240624
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1700299491; Mon, 24 Jun 2024 18:38:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 24 Jun 2024 18:38:05 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 24 Jun 2024 18:38:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+akFrYTaOpbV4al7IlO8pEAFPnfxJS/rysXxCEY/E+nw9CFE7U47nHFHwwB/z3iKrtQ0TG7w0+sRattL/VlK8t/cFNGMCfoL1dwDs3ji0LXXy1C/hSgs48//+4vO8E9y+DdENkhLKUX+rQS7zCFU/oOg8+PR5hudxMzzVVRoIWN9SavHEKEBl34zWcNDSMcRkMcHkj3Tt32/IsE82cmrimEz036ji0oVOMyZ1mFDRJeoN/VBJQrOMQSp+32v30Eegw1mRyvYUXaMw9mY/YYZFy9RpwT/KI4SYyK0h72QCnp9cZ9OKpdNC2fDNAXqqrw70PtXClqTazajDr9PMxcug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfKCYJwVZYMcXZ6Nl+dj+s5d9NO+71ZRFQa2akzg/ls=;
 b=RY9safK7mKwxijnN3JE0AelPWnbqewDdJdkuCjEgBQCtX3p5KhvuoUpp5dV6R2MMbukbyyeu+S+a8LgNG5JgMQQ0KxzQGxEjZD8W+fH8WLTBElvT1Z9WxT6COO02EtH9h+0YCgVAL6pE1T1+q/9MA/8ez6qb56FERKMVcTUETtIeayykNlx8IfCP93z/jq5auAeyad/CAqWzVFeKohBjK2amVGmz9KTyIzOUiEuBMy95ewpKaBb0D4NoKsQqe3bBn0k5efs66JcprB1ZPDplViMPxUbGdzoiXKZsoC7Sm8QbsT4Zfj14A9fUjRK8N6p9rZnjlxTgRlULITVw0fVxbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfKCYJwVZYMcXZ6Nl+dj+s5d9NO+71ZRFQa2akzg/ls=;
 b=DZ7ZvhCGOaJjvS/yKfW+xNoy2z/NH9HlQZoqEjwbtOf98uncuHoUyxCeN7hUUGB/bWCLZ+Wy1B8WeXj3ki41ZNvTa8I+GHkdpxsXgCHdabV6ryFnRBYUBYX1EMCdbvk46heQvJ8sENB+IyNWVlDFEpJD/XAi2etNqhtuk3btgV4=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SEZPR03MB7193.apcprd03.prod.outlook.com (2603:1096:101:e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 10:38:03 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 10:38:03 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v8 06/13] net: phy: mediatek: Hook LED helper
 functions in mtk-ge.c
Thread-Topic: [PATCH net-next v8 06/13] net: phy: mediatek: Hook LED helper
 functions in mtk-ge.c
Thread-Index: AQHaw9YjezPhRNvTLke7cRW/y/yKVrHUC9+AgAA7sgCAAnXugA==
Date: Mon, 24 Jun 2024 10:38:03 +0000
Message-ID: <cf3352c3603f6bd02397e23d8fc718d517578df1.camel@mediatek.com>
References: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
	 <20240621122045.30732-7-SkyLake.Huang@mediatek.com>
	 <e1ed191f-7c70-4c34-ad1f-40aaae18582b@lunn.ch>
	 <Znc8HI6noTr7myYP@makrotopia.org>
In-Reply-To: <Znc8HI6noTr7myYP@makrotopia.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SEZPR03MB7193:EE_
x-ms-office365-filtering-correlation-id: 30d77501-5cd0-400e-1921-08dc9439b9fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|7416011|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?bXRtZGtWcmtYRVNxcmRoSHVyZnRFTkgveDhkNkYzTFptQ08wbU1BSmNVeTJm?=
 =?utf-8?B?R09XOGZYRWtqL3loSUlrbjJReDNoeE1TRGtWN0dDQUdtemlScU1MVmZ0dUxP?=
 =?utf-8?B?QXMxUnBRSnRtbXpmWDVudDFYVFhFVEZRTWo1a0hDUnNnVnBOOG42WUtUR2dH?=
 =?utf-8?B?RnZPVU51dFJ6OW4zTnpPaEtIakg2ZEZaaERhNGJSYzB2Qks5V2x2Nmw5TS9s?=
 =?utf-8?B?UEJnQ2dRcnVSTFZhTm9Pa0pHcEl5UHkyTVc4aDJDT244MGJQQVRoQ2NGTzJi?=
 =?utf-8?B?WndqWitycmlVYi9kRmgrNjlVNVZxU3UzM2kyeTJuOExoenBXRk5UUnVpU1V2?=
 =?utf-8?B?ZVRXYkpOdXNnMG5mZExGWHdzWk1JQmhGdjQ1QmZUdnlEQXh0ZU9hRU9kNmk0?=
 =?utf-8?B?b3hhRkVvUk5GajhYQnk1WUhJbUdqSzVBQXFYODZWVS85ell6RTh1aWlFcWxW?=
 =?utf-8?B?L3pVM2JLMVovMEVyaWttaEd6QW9PVUhZRHl1N0hHSkM2azhFL0NwQ08wamxP?=
 =?utf-8?B?UkNEUUQwTmZLd2dEVkNTY2orTjVPMytKT2dzQmJOSTRYTklOa2x4VnVUTHll?=
 =?utf-8?B?NFZIa2ZZUW94QWRuL1AyRURzbVRDbnI2dWFrYmcyTTdzNklXOFRtNDVtTklv?=
 =?utf-8?B?M3ZESDNtem95UDRVeUhuS3l1NGl3SmxkM1hib05WNW5Yb2x1endRZ29sRXJM?=
 =?utf-8?B?bjBSa3lVZExnTDFPbjk3ZkRHRzNnNk51TC9ac1h0d2JWcGpJd0J0NUhKMTlX?=
 =?utf-8?B?d2JkYXBxd0g3MTluaGV6TWtQQ2liV0NTRGFicC9WOHZOSnUvQkF5ME0wUU1k?=
 =?utf-8?B?bTdVckhENnZ2QjV4WHZEcXRBRTNWSmJkQUJPY3liakVLUXNuYmp3K2FKQW1k?=
 =?utf-8?B?SDRqY0JuMzBxRGRCWGl4WEdFY0ZkZFJTVVNjR25tMVdsZUtKZ0ROVFM4aGhx?=
 =?utf-8?B?alBRRW1sUUorYUZlTW5jeHdCK3cvZXh0ckp2YWE2MGFsY2Z6WWJjQlA2R1pp?=
 =?utf-8?B?d2IzTzZaUEd3S3hWeWlxRFpRSnJPTjcwak84YmNTSGJ1VWNtVS80OUo3SCtk?=
 =?utf-8?B?aHlLYWJFU1YxcFhHN2piOS9SYU5wNGF2amJoYUJWcnNkVzFSTmkyZWFVR0Mv?=
 =?utf-8?B?SU9RTnZybXRzTWxzdlBOU0RjZzJHK1htUmpCQ1BGbnB6ZFgxTmE4cmZTRld6?=
 =?utf-8?B?ckZvQW84SUVGcUlhRVFQMmV0eW5jWW5DckhTTFVmZzU0ZkYxbHAvTHdOeDZj?=
 =?utf-8?B?RTduZEQ0SHZqQUFJRGJFNEJqZE1oVnRGL29Pc0ptZjdCVTJIaTR4UXl4elcz?=
 =?utf-8?B?NTd5TldyTGpQMnVLMXRDaDBuNzVUQWZGdUpWM0liQllzampGaGVwZjVnaFov?=
 =?utf-8?B?WnAvTUl1M2lvYlNCMEVBbzQxNW54MXZ2czhEWXQ0MHp4cG5idkdUWDFnanNv?=
 =?utf-8?B?bVVWK0JQQWliQkJ4a1VqY1lNa0xKTzYwNzA0UWNMcjE1a01kV3dOdldvRkx0?=
 =?utf-8?B?U0tyNFkwRUxWbGVRVkVWbkxWZE5uOGVtZS9nak1tM2w0b3dZTUdtZEFEYnFt?=
 =?utf-8?B?bUxmUFZnQ2xSZEdGOCtXYjhNMjdHRjl6MDhNbndtaDk1MWwvUHRzVE9qRDFV?=
 =?utf-8?B?MEhCZS9HbVJub1FBZ1ZMQnNFc1hxT2RmQ0prSEtHN0hWOTU4MXhKZG80UTZv?=
 =?utf-8?B?eEtBQjJwNHA3a1M0dEtPeHBGZWUyaGF6OVljMzZ5c0Zyd2RFN2JCb2dOZUdq?=
 =?utf-8?B?SnM5T1RoL3lSem1MVnl3R3V6eEt0dkluL2h5K3RrSGszWVdhQnRGVWdkcno0?=
 =?utf-8?Q?5mAPNy9gd8c97ZfKhLo+QSoKhUYzYVuPIOEnM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VENNU25hQWMxbG1SeU1acEkyMFB0TTJaRWQ4QXJpaWRSNW5YSkdicUtKcU9r?=
 =?utf-8?B?dFZsc1NqTW5QazRRUmV0cTY4aUZqTGhlNWpDT3dLUzEzcUdMc2h2VThPSXdM?=
 =?utf-8?B?VlZKRFBOQUN3YXg3M3RXaFNpU281TXNsSHVNZUd6Q2dsc2dJZ29UVWJuTWVD?=
 =?utf-8?B?TWFhK29vRjQ1d0tVeDV4dlZwNzF0a0tjVWFTQUp1UUFwR2FYQnI4SXpjUkMw?=
 =?utf-8?B?dUZyRURYb0g0OXZSanFqcXoxN2UzS1ZEY0I5RnoxMDBRZ3MzOUh2V21IcTVv?=
 =?utf-8?B?UU9LT3lIdzlEOFRsQnVkVCthWlhFVmxXM0g3TTlpUTg4OTZkMTMwSGJKTTk2?=
 =?utf-8?B?Ky8rRnd0VFZSeWxUSnVwdGE5c1YvTXFGZ2NDZlJhb1BFTGVjc3lzV0dRYjV2?=
 =?utf-8?B?MzVlMEx3Vk9JR1ZiNGZKc0NFaDMxbkZyWFFmSjkrdkh4dlNpNEVLMjhQRXEr?=
 =?utf-8?B?TTJTOFhVNENGblBHbWRnQnVSR1FGUHFZd0pPSTFoOG9RSDdJQzRPK09ObWRo?=
 =?utf-8?B?Tmx5bFJNYnZWMjVkblBlL3BMSGdVVVlINHJoTjY5T3VyNWVzVzJibDBHQlds?=
 =?utf-8?B?WVRFbXlMWWVkemdlWFJ4TkpZKzFpYlNoeTFrekhxV1oyZ28zN25Hb2tsL1Rm?=
 =?utf-8?B?alZwZEs0S2F6d0pKWWdPampUd1JxemFLaGd3RzRUVjJFUWorZTVHUGIvWWs5?=
 =?utf-8?B?dDhIdVF0c25TQVhuKzVoeG5VL3NwSlljKzdrOE9NUHBWNU5CbHp4Mnp5cUJN?=
 =?utf-8?B?cy9pKzVZZUhXRU0reWZ0dVV5T25yVUtpU2JxZyszT1JSNU0wcVA1QjMxd2dS?=
 =?utf-8?B?RFczdk9nNFNXbVI4dlhscFAvNGkzV3UvZWhpdTZyVTN4QmRGanV1MXB4b1Rk?=
 =?utf-8?B?WkhtcE5wdSsvSnVRa2tsK0YzV21zdGpkNjN1S3JPSDBaVkpyaTZLeGhSRkFY?=
 =?utf-8?B?RFZTc1l0U0J3V3pwT2VDYitKeVN3dWl6VUUrWVllcituY3Vob3hvRGFXSDBD?=
 =?utf-8?B?SzExemV1WjZ1TGpjZDJZYmZUS1NxU0U5bndyRys1eTZtMThZWUhabjI3bEFZ?=
 =?utf-8?B?Wmt1MnhuSnZJV1l6bFZhNWx1ZTlMQkdneDg3cGgyY3o3Vkl4ckhYc1VZcmdj?=
 =?utf-8?B?UU9qRFM3TmdlRG1zR3JPZ3ZhQmFmZzlSRUYzN2hsRHdFaVRxZEhHRWc1WllC?=
 =?utf-8?B?ZlhJVS9FMzQwWkZhK1QyQlBySEpBVjhmcHZVSVFxd1NVc2Z2UUhsTmY5aGMw?=
 =?utf-8?B?YUYrcXkvcnc0ZC9JS3ZNZmg2dHllS0VJSlg4MkVaTmdOM2N4RzJoL2Y5S2JY?=
 =?utf-8?B?aEV0SFliQndlQVFjZ25DSm1CUGt6cUZrKzZ4Zm5UOFdFSXNIT3JsVHRxN2xT?=
 =?utf-8?B?NFl6SDlFcnI4NlNIWUdwZjJxUTBrbVJBV2JBbXlyZ01mOU4xODJiS25UNkVZ?=
 =?utf-8?B?TUhUaUFocXl6YW50RFBpRE5OZUcvUFk2YmRPdnpPR2J1bGN5YVo0RE5ubTFz?=
 =?utf-8?B?bnJLTnBvUndiUGZlbjhiNXhYaTBzWmRNRXZLYmJIN1lDWmpSVlpvbmE4bGkz?=
 =?utf-8?B?cFBSRVdpSkdLUDFOMXI5K1BBUDk3czA5YTFhc1F0eGF6STNncVY2RFphendU?=
 =?utf-8?B?c3gvWUZ3OURyYnBZY0hjS1ZUV2VGNVh0SW9pU1VVODFyRjJsV1VXbTEydTY0?=
 =?utf-8?B?WStZWmhLWGE1OXJIZDFjeHJHK2FpVUtkK3NKa1hIUmg3bnRGb2dtM2hocncz?=
 =?utf-8?B?S0ZuOEJKN2ZLSk8wNC94QUc0endlNjRydE1ZZUhLejE0cjVNZDMyVXBjSk41?=
 =?utf-8?B?NWcwcHdyc3pUdVJORy9kbzBEOWtaNG93Uzc1R00xcDdscldUVW91WnFHM2I2?=
 =?utf-8?B?RHNIUGgwbWZNNXdvVjJiNG84aUVWMkZLMEZ2SGViN1JVMFFmMTJITS9QNmNu?=
 =?utf-8?B?WEJZNG5KVkYzNjY1UXRtdmlrTlNCNGIrbFdYQ3BvQldpakxud0t3ZjRyY2xP?=
 =?utf-8?B?RDgwZFU3aEl6QXRYcmxXTmFRK2Y0d3B2ZUlwcFFacStWWXBxTTBIVmdlRmVO?=
 =?utf-8?B?Z0VlSlJkWDZqSGRhdk9oY2MvQjVlSk9zTTMxaXpyYjJ6WWlxU1Bwc05nNHlN?=
 =?utf-8?B?THNUMlRVa3ZRZk1VUlRqcWxRMnJBYnhXVU9wTGVhVG1lV3VMQkJaRUlXS2w5?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59780642A9573744AA792357D4CEBF3B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d77501-5cd0-400e-1921-08dc9439b9fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 10:38:03.3942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5g3+tX+fxc3xE/pNI5UFDpxbiipCAaOpugRy/tCYbIz1+I3A4nOibQx5skHU/rc1mw2inmoCVFyuG1Yb8JuSD0qj12xkttmrSo8mePEun0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7193
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.849100-8.000000
X-TMASE-MatchedRID: F7tLedRt7ifUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCsup1wbeiPwamlaAItiONP1MkOX0UoduuWHtZs6e3ZMHqM8
	PYJGuHYo3m4BThlKDl5urMMf0bt5MF0CTJL/y/9cSDAzxRL+lMfNYQxCOihTNNEJplIoT86wLaO
	eZrQa/wMF9H9ZT7pg4qiMcz9Yi4r1ccQ8eam5EfdIFVVzYGjNKcmfM3DjaQLHEQdG7H66TyOk/y
	0w7JiZo
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.849100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	EA96DC25DE0B8841443EF4598032BF4333B43D2576F4436EF1D8A7823994FFE32000:8

T24gU2F0LCAyMDI0LTA2LTIyIGF0IDIyOjAzICswMTAwLCBEYW5pZWwgR29sbGUgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gU2F0LCBKdW4gMjIsIDIwMjQgYXQgMDc6Mjk6NDVQTSArMDIwMCwg
QW5kcmV3IEx1bm4gd3JvdGU6DQo+ID4gPiBbLi4uXQ0KPiA+ID4gK2lmIChpbmRleCA+IDEpDQo+
ID4gPiArcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArDQo+ID4gDQo+ID4gSXQgbG9va3MgbGlrZSB0
aGlzIHRlc3QgY291bGQgYmUgbW92ZWQgaW50byB0aGUgY29tbW9uIGNvZGUuIEl0DQo+IHNlZW1z
DQo+ID4gbGlrZSBhbGwgdmFyaWFudHMgaGF2ZSBhIHNpbmdsZSBMRUQuDQo+IA0KPiBFeGFjdGx5
IHR3byBMRURzLCB3aGljaCBpcyB3aGF0IGluZGV4ID4gMSBjaGVja3MgZm9yLCBidXQgeWVzLCBp
dA0KPiBzaG91bGQgYmUgbW92ZWQgdG8gY29tbW9uIGNvZGUuDQo+IA0KSSdsbCBhZGQgbXRrX3Bo
eV9sZWRfbnVtX2RseV9jZmcoKSBpbiBtdGstcGh5LWxpYi5jIGxpa2UgdGhpczoNCg0KaW50IG10
a19waHlfbGVkX251bV9kbHlfY2ZnKHU4IGluZGV4LCB1bnNpZ25lZCBsb25nICpkZWxheV9vbiwN
CgkJCSAgICB1bnNpZ25lZCBsb25nICpkZWxheV9vZmYsIGJvb2wgKmJsaW5raW5nKQ0Kew0KCWlm
IChpbmRleCA+IDEpDQoJCXJldHVybiAtRUlOVkFMOw0KDQoJaWYgKGRlbGF5X29uICYmIGRlbGF5
X29mZiAmJiAoKmRlbGF5X29uID4gMCkgJiYgKCpkZWxheV9vZmYgPg0KMCkpIHsNCgkJKmJsaW5r
aW5nID0gdHJ1ZTsNCgkJKmRlbGF5X29uID0gNTA7DQoJCSpkZWxheV9vZmYgPSA1MDsNCgl9DQoN
CglyZXR1cm4gMDsNCn0NCkVYUE9SVF9TWU1CT0xfR1BMKG10a19waHlfbGVkX251bV9kbHlfY2Zn
KTsNCg0KQWxzbyBmaXggKl9waHlfbGVkX2JsaW5rX3NldCgpIGluIG10ay1nZS5jL210ay1nZS1z
b2MuYy9tdGstMnA1Z2UuYw0KbGlrZSB0aGlzOg0KDQpzdGF0aWMgaW50IG10Nzk4eF9waHlfbGVk
X2JsaW5rX3NldChzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2LCB1OA0KaW5kZXgsDQoJCQkJICAg
IHVuc2lnbmVkIGxvbmcgKmRlbGF5X29uLA0KCQkJCSAgICB1bnNpZ25lZCBsb25nICpkZWxheV9v
ZmYpDQp7DQoJc3RydWN0IG10a19zb2NwaHlfcHJpdiAqcHJpdiA9IHBoeWRldi0+cHJpdjsNCgli
b29sIGJsaW5raW5nID0gZmFsc2U7DQoJaW50IGVyciA9IDA7DQoNCgllcnIgPSBtdGtfcGh5X2xl
ZF9udW1fZGx5X2NmZyhpbmRleCwgZGVsYXlfb24sIGRlbGF5X29mZiwNCiZibGlua2luZyk7DQoJ
aWYgKGVyciA8IDApDQoJCXJldHVybiBlcnI7DQoNCgllcnIgPSBtdGtfcGh5X2h3X2xlZF9ibGlu
a19zZXQocGh5ZGV2LCBpbmRleCwgJnByaXYtPmxlZF9zdGF0ZSwNCgkJCQkgICAgICAgYmxpbmtp
bmcpOw0KCWlmIChlcnIpDQoJCXJldHVybiBlcnI7DQoNCglyZXR1cm4gbXRrX3BoeV9od19sZWRf
b25fc2V0KHBoeWRldiwgaW5kZXgsICZwcml2LT5sZWRfc3RhdGUsDQoJCQkJICAgICBNVEtfR1BI
WV9MRURfT05fTUFTSywgZmFsc2UpOw0KfQ0KDQpCUnMsDQpTa3kNCg==

