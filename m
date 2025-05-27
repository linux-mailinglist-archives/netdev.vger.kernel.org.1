Return-Path: <netdev+bounces-193553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B4CAC46A8
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 05:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D1116F8F6
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 03:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D8D1917FB;
	Tue, 27 May 2025 03:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qf3QcC6G";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="aHfXeNL5"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1E2CCDE;
	Tue, 27 May 2025 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748315126; cv=fail; b=brNXnfeGGvvz6dxDU7/9YUPIqOSezn2u8R07ZsUX8c6xcUqAf3Nl7w1R/kwiPmRNTQ5baSxvVx6RrBVz5P+F4k/rkkWD4e3t7i0IkK3YSxlrTybs4RB/vViyy8EH9AguC8Eg0I/Wab+BsmZ6rfYfuvUfaUIBptSxttFJ/Ccs/j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748315126; c=relaxed/simple;
	bh=qOyP6aB7mw/lRn+FwBMD2NwZPMhzwwucdglZg6OTsew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ILW77J4c6CSSigN0vMHqixSnILsIQ5evHv2XlahZ6pi9H9nXVj5oMpK5pgY7VQiv81wsd4Lw7ldgDrr22mgXGHhgDRl5Z+YsbcI5pshse71uUOoZ4Nj5P7aMM+Fs7hI39TnLSTbfDfeuQbXuvSRUZdV/bi0Q1sMseRA5qc8Ttls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qf3QcC6G; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=aHfXeNL5; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 67122b503aa711f0813e4fe1310efc19-20250527
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=qOyP6aB7mw/lRn+FwBMD2NwZPMhzwwucdglZg6OTsew=;
	b=qf3QcC6GOWROvjv9qslfwYPEtU3Q/KmvkWVMvVVmZ/5xQqh0WqYh4acrp/l4hJk+SDKt1S+49UBO96qoKtdRKrIUue+Oacw7BQ3XH405GY5/FpxqK/ejQ156J7iFlCNjzFcb49IQJiXqIE+aOA/Dm1TYlwl0Sb9GC6VbJLpTb0o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:6a22d756-c578-44c9-a3e2-3755132b295f,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:cc4350f1-2ded-45ed-94e2-b3e9fa87100d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 67122b503aa711f0813e4fe1310efc19-20250527
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 732593328; Tue, 27 May 2025 11:05:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 27 May 2025 11:05:08 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 27 May 2025 11:05:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQl/tY+C5GcU0n57DVa9+zmBTaeT+ruznZZv/FblUyboIwrVuRKFwsPbM0TPTJ7rR9c28ZDMXGeS9JVgn6aKleQBMa7LPWyEyutuXRqYJcIg0L9wm1uXLpMoxGEMhgS1lCrv/hHjGc4zBMAnmCFLmrT4sztrJwRjLCPsXXgZiEGTF1LejOuBMgD1QHXrahuuVRJLoxGuomVVz2SX1KHZLE6apLE/gDuYUhb8DV0bqDY2uHzp09tVs/r+C9lriqtW5jkLn4AEioooFr6clFDzin4FUMBygx1NbFyb6bp8EgA+HAUer6xV+hC3lLi/PsZZ5MhgavFlQIfGF58SGFmVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOyP6aB7mw/lRn+FwBMD2NwZPMhzwwucdglZg6OTsew=;
 b=wddYBULAI0jZi+vBaI6li70pTmy2X95pcRsIXeM3rqqQas8hUgUSWA5K2N4sTjfzeaKWxbgCn/seq1hWIK3JzUjpRSr5tZAc/MTyLp4rkbDi2mLDlmAU3u7d2HmmCL0hxjeU+gv8t/0ZA7Qc96v+B0GGSORSkd6TEXgt9/GeHmSZdeH+NPrH/DIqF5dbi0TAzMoQtD8yke8f2M4A+p89jXaKmVX9zLtflGEO+aoPuWOtqHwMgjBAYk332CXGoxUbEHoufoeM8kJzmlkYthCN5kXswuTEy5kpM2Mhm0vWeprDRQlLCFMhsg6fRir34Ib7DZkCIv3hBRbZdTnPFCHzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOyP6aB7mw/lRn+FwBMD2NwZPMhzwwucdglZg6OTsew=;
 b=aHfXeNL5wblFDUxv0IPmB4bnP8KyV8lx/v5TDb2L86P1dHTDKbu8V9HhG08MK8KJzj9zywqZGqWFjbdGcKfnIwUUAIb/b3t4Yme+bu+EIpB8I6ro6zsulR7KQaCo+6pMIuvTQUxLgQYPqiOpcUr2MAVjSjnGDjupbwtPuya4Lvc=
Received: from TYZPR03MB7963.apcprd03.prod.outlook.com (2603:1096:400:451::12)
 by SEZPR03MB8015.apcprd03.prod.outlook.com (2603:1096:101:17d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 27 May
 2025 03:05:06 +0000
Received: from TYZPR03MB7963.apcprd03.prod.outlook.com
 ([fe80::74b:1a26:a3e0:7d51]) by TYZPR03MB7963.apcprd03.prod.outlook.com
 ([fe80::74b:1a26:a3e0:7d51%7]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 03:05:06 +0000
From: =?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "willemb@google.com" <willemb@google.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "edumazet@google.com"
	<edumazet@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	=?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
Subject: Re: [PATCH v2] t: fix udp gso skb_segment after pull from frag_list
Thread-Topic: [PATCH v2] t: fix udp gso skb_segment after pull from frag_list
Thread-Index: AQHbzgawz4fFnfYFRkaD6azHevSjTA==
Date: Tue, 27 May 2025 03:05:06 +0000
Message-ID: <86f69e6d3aba5b6a05a79efcf06e575e2dfe9185.camel@mediatek.com>
References: <20250526062638.20539-1-shiming.cheng@mediatek.com>
	 <68347db362e10_28cacc29479@willemb.c.googlers.com.notmuch>
	 <1fa8a9fd42a1835b6644bbb8e2b966b57167e698.camel@mediatek.com>
In-Reply-To: <1fa8a9fd42a1835b6644bbb8e2b966b57167e698.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7963:EE_|SEZPR03MB8015:EE_
x-ms-office365-filtering-correlation-id: 40ac3076-6e70-4117-1c61-08dd9ccb48a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VFEvenprNFBDUXJqQnlRYUp3MWVwbTRobC9xczh4cVdocXNhL2ZlVk4yNG9I?=
 =?utf-8?B?RUpSc0FHU3VEakxzOHdvbjFiTUd0KzdlYVVhOEdFNVJ2dnpyQzQ1MG9VRExV?=
 =?utf-8?B?N1lhdWMyRWYzc2NxSmJIeklKOW1DNFlrZzhiTEVvRCtNbEFZNXBPMkoraVVD?=
 =?utf-8?B?VytNWU5OZnFLcXI1K3R6L2gyazlJU3BRL1h6cllScnZHTzAwSXZ2N1BHZDZN?=
 =?utf-8?B?S08vVXhvMVdIbjhjOWVjb2k1MkRnQUxsT1puOWUrczBZWC9scWZXUGV0Tkpr?=
 =?utf-8?B?VUdqaVZUdE5MdjVNNHRHOUw1dy9tbWVRWDBDbWpkcXZ5OWJVMEJUaHlNODhS?=
 =?utf-8?B?UVI5bU9KUW1kS2FvWmtpNnNNTXRsbUFVRXhFTWl1eGlDdjM2YTVuMDIzOEV0?=
 =?utf-8?B?VFVoWExFemcyZ0FURXh1MjAwTXpDY2laRGpsOGNLaHBMZ29RSkt4ZkpJRE41?=
 =?utf-8?B?Qzh2M2IyM3pQNThheUZSVWU1eXFwdVFnZXpxcDgyVGV5cnpaeHA3QWNsNG5j?=
 =?utf-8?B?a1hWcnNnR25YWTlvK3ZBZUd6bkYrSENKNFNvVjRkUkt3NER4Ykt4WmFJYXlq?=
 =?utf-8?B?Rms4SndyRmo0S0FFbmt6emxwcElVUU5qaFo3UHNSOHpINUx5dTJlUVMvTmpR?=
 =?utf-8?B?VjdVTDRUaE1GcFJxazNkZ1hBeklhdWRFUDZTTU1MdDdWWUM0WGQ3Y0ppdjJo?=
 =?utf-8?B?U1NiTG04TGtGSGJRQnkydUZUNDk5VHJ4NGludG1sWDRVakJmVTFLMm1SUGRU?=
 =?utf-8?B?dnRqWWNDQ2x1dnZJWVlOZHVXWU9rL3U3ajhyYTlJRUNveXBib1IyVnh2V0JM?=
 =?utf-8?B?dExOMmhpb3QyUFZPeVJibm9vUUVySVNSRVBZdHRlOWZyR015QWp2NHM2aVI2?=
 =?utf-8?B?Nkg3eGphL254UHhaa1RvMmFobXp5WHhJem43eHhiSmRaRko4M3hwcTFzb29D?=
 =?utf-8?B?Rzh4RGRreXZweFJSMmhvUTFUeTBpVUQ1Z3FLTFdGQ3Z5OUtnc0FZTGJtdnJY?=
 =?utf-8?B?WVVQRkowdHFMRnhBclRjNU5CZlJuc0F3RzJETnprZXZENlJwejhpcVdRakhP?=
 =?utf-8?B?b3phdUdhNzhvanVFeUlpeVEyV0NyYlRBdUJ5MnlrdWF1UlE4Mnhid2hIYmo3?=
 =?utf-8?B?UDQvalFjdXdtWWt3ZzZ0TXZnRTZ1ajVmVmNMcFdNQi9mWHZPMmttZGkxbXFC?=
 =?utf-8?B?SU5WTnYyR0tEbEtWeTFzS1Z6L2czbmpQbjQ4dmRucXZ3cERzbmF5TG82OThC?=
 =?utf-8?B?VjB1SXNDRWY5cUtMdUdhZFlwaXltR0JsZmZvenYvNDJ1Yld5ODJ1UXRvMVNj?=
 =?utf-8?B?RlU1VHNQdWRGdXhicHYxbThEa3E5NG9WUURuNjRCYnphRENHQi9QNG13S3hG?=
 =?utf-8?B?Wm96aEIyc1VhanRvZHNJUFU4YU1tOTE3OTZFYkIxeFZ3RDIwdGY3NU1IaHgy?=
 =?utf-8?B?V29tMS9YZ1RwQmlBb1FFbG5VQWd6dnFOaUtSUUFqMWtzMEY4UlBTN0MvVlZD?=
 =?utf-8?B?eUFtVnQvejhERis0WVQvcmhNT012K2dTaFV0bHY2SkpOTHJlclpSOUgxV1VT?=
 =?utf-8?B?ak4xUEdVMlhuckVvSnJwZVN4bC9iZHhYYWJkSUhDWG55a054RWtYeXQ3TGRl?=
 =?utf-8?B?ZEZydGp1Z25LMklqc1dWczFiK05wMS9nQmZWSllESmxMem1vNm93VkZSZkJz?=
 =?utf-8?B?ZlNRYkxWVUFTN2FvbStoOTlDT0NQTlRsTlJqSmZhakFnL2FZQkE3NHJISHpI?=
 =?utf-8?B?YnRGOFR6S2FCMmRtdFJJdUprSGZ6WndTNXhQbENwbFVuL3pVMFNHUDR1UE41?=
 =?utf-8?B?OEZXTjZxVVozYS9TaU1kVHlHL3Z1ZS9yNWRocUlRU0FZMkJkL2Zxcy9UdlEy?=
 =?utf-8?B?WjVsdzV5T2pldU1LWlREdE9xVWZCZ3pLU1pSZzRPeGNKMlAxbVNxNXFSN1k1?=
 =?utf-8?B?MC9OSGpTWm5hcXVGa3Robkk5clZCVXRrUldhT3o1Vkg4ZnppQmd4NHg3RXhL?=
 =?utf-8?Q?R+LfMafnGhfFX02neJcyGmdzYBTfoU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7963.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVBDWTB0dFQxbXNxVldoeWJqa2M5OFdpbzJqNlQzOVRUc1hrUENsa0NOYzIz?=
 =?utf-8?B?K1Fmak01WlFCZFhvRjFwQ21INEdBbTdOckNZeE9PZU51NmJWbTVuWUZ1Nlhx?=
 =?utf-8?B?RFdqbUwrbFUyTkZmVURscGIwV2RDK1JlZTNDKzZqOUQwaXhnQy9HMEZST1Jt?=
 =?utf-8?B?eUJ0MUxTb3JOdWEwQThjWVBxTjJ2UU1ORWUwMnlQSjV6ZkFydTFaUWdHSXd6?=
 =?utf-8?B?TS9zKzBRZEdzVEk3ZTFMRE91TlpTaWtGSWJpWEFOMUZwS2dqa2tOZFZFMWJw?=
 =?utf-8?B?OU9jM0d2QmpGQVZSUWVTT1VZZDhCMkUvOHNXMllDWWk3MlNmZ1J5U3hTTjBn?=
 =?utf-8?B?M2MzeUozUC9uVUdFUU1KL0IrMU5oS3dDMzVwMmowaDRJK3RkS0Eva3E2UFlv?=
 =?utf-8?B?UXFwOE1rMVFHL083Sjk5TWttMG9ZRXFub2NiZldvdi90TXJuN2M2a1lRaUNH?=
 =?utf-8?B?ejdKZGZhSzFjTjBWTy9ZZVh2Q09WaGxweVZxS1BhTEZVMjVJVERrWkdzRTd0?=
 =?utf-8?B?ZlBCZDkxbWN0azQxci9QVDgyU0Z5NjdndzRZZk5ZYWo4NVRXYnNrZDRkYXkv?=
 =?utf-8?B?T01ZR0tJNUZOMTF0WDZQRWR5SXJsOFdqazY5YlNINHh6a1d4V2FUTm9xOE9l?=
 =?utf-8?B?VlQ0TEpvemlDdmNvNTE0bWZ6RXlHQ2JocklpbDMzTEFsR0tySVVMcDZ1cUpQ?=
 =?utf-8?B?QTZtR0ZNblpLNGlJYWJQMlNDY3F3blprK2VwVkRzZFM2T2VSSmxTdlR6TUxM?=
 =?utf-8?B?VnNQdGdsNmU0UFRYNkFtbmlJeDlwRlFyQVJKeUJ0SGp1Z0xYZUU4TTZXK0pt?=
 =?utf-8?B?TmVPSFlHRVcrM3FlWnpEMFJXZ0ZSYkpMbEV5Z3ZVZUFlVlJOS215NzdacThq?=
 =?utf-8?B?eHgyT3RITDVmTUNDb3h0R0FpNzdCenFmbWd4VVJvdWZ3Mk8zVHkxQTZoaHRU?=
 =?utf-8?B?Zi9wVm1TVHVhT1dXTDlkVmlsVVNzWlRLL1plNWUzWHpINkhhMzdDOXNxeEFD?=
 =?utf-8?B?YVdvaFFHYUEzTTRaWEgwSzBwYm5XeW9KWXJlQitxRkF2ZTVVaDYxQVYxQmdF?=
 =?utf-8?B?MzFoN3FJSDF4SG95TXplMC9NcFpTdnVvQmNDZnl5R01wT3RhMFZsaHlKNWxl?=
 =?utf-8?B?ZlVIOEFjSW9lNnZ0RDRNMGVjSGJudFVnakNuSHRockJ0WlZQS1I2aEF6QTJl?=
 =?utf-8?B?MkUrUTYydW5rbTRYR2RHaGNSN3ozdThNTXdVNzhVU3FVMUFCWTQzeGZWeUFw?=
 =?utf-8?B?dFNDdVN4bkJhMThSUFdVNzFkWkx1YlA2N0piWWZaUUgyd1kvKzRlZjBMSSt5?=
 =?utf-8?B?WkV5dWI0RWw3RVZPa2Z5c3VZVklxejdkaXdXNmd0NUgwK1I5clg5Q2tMYlgy?=
 =?utf-8?B?VzI0S1NOYm40NCtOaUJuby9aNTU3THlGcEJOT2c2T1YzY0dGZWxLMmVIWHo5?=
 =?utf-8?B?SWh3Vm9vSVdSUzE2Vmd3Um8xcFgrWDdPYzIrUlphbmdnR1V4RWNSaHRtdm1E?=
 =?utf-8?B?d3ZDQXZpSTRTZzB6eFhCZmxhVTNVMS9pYk11MWdEMFowcDhBZ0I1ak03TkEv?=
 =?utf-8?B?cldRYkhFMzlBL1Y2Wm9FLzI5WU1GVWlkejFQdVlkUUY0aUo4NGpPeTQ0akht?=
 =?utf-8?B?NXV5WFQzNE82UTQrYnl4ZWI4dlREZ0k3cGNEc1hSdk1EallQNjdER0Z1Yk93?=
 =?utf-8?B?WFBFemlKS1BtR0hDSTNab20xWU1yN0gwcFVXMTkrdjBXTXhKMkttQy9VR3h3?=
 =?utf-8?B?c0xLeC9MdjY0VlpqR1A0Z0ZLcTVCQlc0bFI3a3lnb20zVDgzMmY3dGc5bXg3?=
 =?utf-8?B?Y1hBei9xenI1N1pFVWpud2tIN1BsS0phVGNDSGtWaVJEc2RZK3lSNDZpVExt?=
 =?utf-8?B?eXR0MlVPYUNTbUF4YVZGL3QvejFjbjFJMDJaOU92bDhic29xeWhUR2VVb096?=
 =?utf-8?B?ZUIzc2lhcFMvbm1nNVJOU3VHNDNCMUw3TDlSWHlKM2daSVQ5b1FxL3lURzd6?=
 =?utf-8?B?bUNPODFuc0tYTk9aMGUzT0ZodDY0K1FMYXNWMlNyVGZhZVpoSHQ0NXVtU1Zw?=
 =?utf-8?B?NWd6UWc3SFhzUUN5MERKcmpOb095S0oxWDVoeDlrT3hEK3JQUm42by9JUENl?=
 =?utf-8?B?c25KY0Mrb0pXQ1llVUJNZUF1aVB1ZC9OVXducStPa3AvVy9GbDlVd0NLTVVP?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <827597E91CF0204A8D2AD54FBA0FE7DB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7963.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ac3076-6e70-4117-1c61-08dd9ccb48a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 03:05:06.7153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FXwxYZN051pNaq0Z2Gc0NLM3uobZBEXRyKGCX6KnQIvepWoQuM5LBlpiqEY60Eol0ngUKVxK8nDaCn8vQL8iahHE8zo3l17nuUyNkOdiDYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8015

T24gVHVlLCAyMDI1LTA1LTI3IGF0IDEwOjU2ICswODAwLCBTaGltaW5nIENoZW5nIHdyb3RlOg0K
PiBPbiBNb24sIDIwMjUtMDUtMjYgYXQgMTA6NDEgLTA0MDAsIFdpbGxlbSBkZSBCcnVpam4gd3Jv
dGU6DQo+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMNCj4gPiB1bnRpbA0KPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5k
ZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gDQo+ID4gDQo+ID4gcy90L25ldA0KPiA+IA0KPiA+IHMv
W1BBVENIIHZYXS9bUEFUQ0ggbmV0IHZYXQ0KPiANCj4gSXQgaGFzIGFscmVhZHkgYmVlbiB1cGRh
dGVkIGluIHYzLg0KPiANCj4gPiANCj4gPiBTaGltaW5nIENoZW5nIHdyb3RlOg0KPiA+ID4gRGV0
ZWN0IGludmFsaWQgZ2VvbWV0cnkgZHVlIHRvIHB1bGwgZnJvbSBmcmFnX2xpc3QsIGFuZCBwYXNz
IHRvDQo+ID4gPiByZWd1bGFyIHNrYl9zZWdtZW50LiBpZiBvbmx5IHBhcnQgb2YgdGhlIGZyYWds
aXN0IHBheWxvYWQgaXMNCj4gPiA+IHB1bGxlZA0KPiA+ID4gaW50byBoZWFkX3NrYiwgV2hlbiBz
cGxpdHRpbmcgcGFja2V0cyBpbiB0aGUgc2tiX3NlZ21lbnQNCj4gPiA+IGZ1bmN0aW9uLA0KPiA+
IA0KPiA+IFB1bmN0dWF0aW9uIGlzIG9mZg0KPiANCj4gSXQgaGFzIGFscmVhZHkgYmVlbiB1cGRh
dGVkIGluIHYzLg0KPiANCj4gPiANCj4gPiA+IGl0IHdpbGwgYWx3YXlzIGNhdXNlIGV4Y2VwdGlv
biBhcyBiZWxvdy4NCj4gPiA+IA0KPiA+ID4gVmFsaWQgU0tCX0dTT19GUkFHTElTVCBza2JzDQo+
ID4gPiAtIGNvbnNpc3Qgb2YgdHdvIG9yIG1vcmUgc2VnbWVudHMNCj4gPiA+IC0gdGhlIGhlYWRf
c2tiIGhvbGRzIHRoZSBwcm90b2NvbCBoZWFkZXJzIHBsdXMgZmlyc3QgZ3NvX3NpemUNCj4gPiA+
IC0gb25lIG9yIG1vcmUgZnJhZ19saXN0IHNrYnMgaG9sZCBleGFjdGx5IG9uZSBzZWdtZW50DQo+
ID4gPiAtIGFsbCBidXQgdGhlIGxhc3QgbXVzdCBiZSBnc29fc2l6ZQ0KPiA+ID4gDQo+ID4gPiBP
cHRpb25hbCBkYXRhcGF0aCBob29rcyBzdWNoIGFzIE5BVCBhbmQgQlBGIChicGZfc2tiX3B1bGxf
ZGF0YSkNCj4gPiA+IGNhbg0KPiA+ID4gbW9kaWZ5IGZyYWdsaXN0IHNrYnMsIGJyZWFraW5nIHRo
ZXNlIGludmFyaWFudHMuDQo+ID4gPiANCj4gPiA+IEluIGV4dHJlbWUgY2FzZXMgdGhleSBwdWxs
IG9uZSBwYXJ0IG9mIGRhdGEgaW50byBza2IgbGluZWFyLiBGb3INCj4gPiA+IFVEUCwNCj4gPiA+
IHRoaXMgIGNhdXNlcyB0aHJlZSBwYXlsb2FkcyB3aXRoIGxlbmd0aHMgb2YgKDExLDExLDEwKSBi
eXRlcyB3ZXJlDQo+ID4gPiBwdWxsZWQgdGFpbCB0byBiZWNvbWUgKDEyLDEwLDEwKSBieXRlcy4N
Cj4gPiA+IA0KPiA+ID4gV2hlbiBzcGxpdHRpbmcgcGFja2V0cyBpbiB0aGUgc2tiX3NlZ21lbnQg
ZnVuY3Rpb24sIHRoZSBmaXJzdCB0d28NCj4gPiA+IHBhY2tldHMgb2YgKDExLDExKSBieXRlcyBh
cmUgc3BsaXQgdXNpbmcgc2tiX2NvcHlfYml0cy4gQnV0IHdoZW4NCj4gPiA+IHRoZSBsYXN0IHBh
Y2tldCBvZiAxMCBieXRlcyBpcyBzcGxpdCwgYmVjYXVzZSBoc2l6ZSBiZWNvbWVzDQo+ID4gPiBu
YWdhdGl2ZSwNCj4gPiA+IGl0IGVudGVycyB0aGUgc2tiX2Nsb25lIHByb2Nlc3MgaW5zdGVhZCBv
ZiBjb250aW51aW5nIHRvIHVzZQ0KPiA+ID4gc2tiX2NvcHlfYml0cy4gSW4gZmFjdCwgdGhlIGRh
dGEgZm9yIHNrYl9jbG9uZSBoYXMgYWxyZWFkeSBiZWVuDQo+ID4gPiBjb3BpZWQgaW50byB0aGUg
c2Vjb25kIHBhY2tldC4NCj4gPiA+IA0KPiA+ID4gd2hlbiBoc2l6ZSA8IDAsICB0aGUgcGF5bG9h
ZCBvZiB0aGUgZnJhZ2xpc3QgaGFzIGFscmVhZHkgYmVlbg0KPiA+ID4gY29waWVkDQo+ID4gPiAo
d2l0aCBza2JfY29weV9iaXRzKSwgc28gdGhlcmUgaXMgbm8gbmVlZCB0byBlbnRlciBza2JfY2xv
bmUgdG8NCj4gPiA+IHByb2Nlc3MgdGhpcyBwYWNrZXQuIEluc3RlYWQsIGNvbnRpbnVlIHVzaW5n
IHNrYl9jb3B5X2JpdHMgdG8NCj4gPiA+IHByb2Nlc3MNCj4gPiA+IHRoZSBuZXh0IHBhY2tldC4N
Cj4gPiANCj4gPiBObyBsb25nZXIgbWF0Y2hlcyB0aGUgY3VycmVudCBwYXRjaA0KPiANCj4gSXQg
aGFzIGFscmVhZHkgYmVlbiB1cGRhdGVkIGluIHYzLg0KPiANCj4gPiANCj4gPiA+IEJVR19PTiBo
ZXJl77yaDQo+ID4gPiBwb3MgKz0gc2tiX2hlYWRsZW4obGlzdF9za2IpOw0KPiA+ID4gd2hpbGUg
KHBvcyA8IG9mZnNldCArIGxlbikgew0KPiA+ID4gICAgIEJVR19PTihpID49IG5mcmFncyk7DQo+
ID4gPiAgICAgc2l6ZSA9IHNrYl9mcmFnX3NpemUoZnJhZyk7DQo+ID4gPiANCj4gPiA+ICAgICBl
bDFoXzY0X3N5bmNfaGFuZGxlcisweDNjLzB4OTANCj4gPiA+ICAgICBlbDFoXzY0X3N5bmMrMHg2
OC8weDZjDQo+ID4gPiAgICAgc2tiX3NlZ21lbnQrMHhjZDAvMHhkMTQNCj4gPiA+ICAgICBfX3Vk
cF9nc29fc2VnbWVudCsweDMzNC8weDVmNA0KPiA+ID4gICAgIHVkcDRfdWZvX2ZyYWdtZW50KzB4
MTE4LzB4MTVjDQo+ID4gPiAgICAgaW5ldF9nc29fc2VnbWVudCsweDE2NC8weDMzOA0KPiA+ID4g
ICAgIHNrYl9tYWNfZ3NvX3NlZ21lbnQrMHhjNC8weDEzYw0KPiA+ID4gICAgIF9fc2tiX2dzb19z
ZWdtZW50KzB4YzQvMHgxMjQNCj4gPiA+ICAgICB2YWxpZGF0ZV94bWl0X3NrYisweDljLzB4MmMw
DQo+ID4gPiAgICAgdmFsaWRhdGVfeG1pdF9za2JfbGlzdCsweDRjLzB4ODANCj4gPiA+ICAgICBz
Y2hfZGlyZWN0X3htaXQrMHg3MC8weDQwNA0KPiA+ID4gICAgIF9fZGV2X3F1ZXVlX3htaXQrMHg2
NGMvMHhlNWMNCj4gPiA+ICAgICBuZWlnaF9yZXNvbHZlX291dHB1dCsweDE3OC8weDFjNA0KPiA+
ID4gICAgIGlwX2ZpbmlzaF9vdXRwdXQyKzB4MzdjLzB4NDdjDQo+ID4gPiAgICAgX19pcF9maW5p
c2hfb3V0cHV0KzB4MTk0LzB4MjQwDQo+ID4gPiAgICAgaXBfZmluaXNoX291dHB1dCsweDIwLzB4
ZjQNCj4gPiA+ICAgICBpcF9vdXRwdXQrMHgxMDAvMHgxYTANCj4gPiA+ICAgICBORl9IT09LKzB4
YzQvMHgxNmMNCj4gPiA+ICAgICBpcF9mb3J3YXJkKzB4MzE0LzB4MzJjDQo+ID4gPiAgICAgaXBf
cmN2KzB4OTAvMHgxMTgNCj4gPiA+ICAgICBfX25ldGlmX3JlY2VpdmVfc2tiKzB4NzQvMHgxMjQN
Cj4gPiA+ICAgICBwcm9jZXNzX2JhY2tsb2crMHhlOC8weDFhNA0KPiA+ID4gICAgIF9fbmFwaV9w
b2xsKzB4NWMvMHgxZjgNCj4gPiA+ICAgICBuZXRfcnhfYWN0aW9uKzB4MTU0LzB4MzE0DQo+ID4g
PiAgICAgaGFuZGxlX3NvZnRpcnFzKzB4MTU0LzB4NGI4DQo+ID4gPiAgICAgX19kb19zb2Z0aXJx
KzB4MTQvMHgyMA0KPiA+ID4gDQo+ID4gPiAgICAgWyAgMTE4LjM3NjgxMV0gW0MyMDExMzRdIGRw
bWFpZl9yeHEwX3B1czogW25hbWU6YnVnJl1rZXJuZWwNCj4gPiA+IEJVRw0KPiA+ID4gYXQgbmV0
L2NvcmUvc2tidWZmLmM6NDI3OCENCj4gPiA+ICAgICBbICAxMTguMzc2ODI5XSBbQzIwMTEzNF0g
ZHBtYWlmX3J4cTBfcHVzOg0KPiA+ID4gW25hbWU6dHJhcHMmXUludGVybmFsDQo+ID4gPiBlcnJv
cjogT29wcyAtIEJVRzogMDAwMDAwMDBmMjAwMDgwMCBbIzFdIFBSRUVNUFQgU01QDQo+ID4gPiAg
ICAgWyAgMTE4LjM3Njg1OF0gW0MyMDExMzRdIGRwbWFpZl9yeHEwX3B1czoNCj4gPiA+IFtuYW1l
Om1lZGlhdGVrX2NwdWZyZXFfaHcmXWNwdWZyZXEgc3RvcCBEVkZTIGxvZyBkb25lDQo+ID4gPiAg
ICAgWyAgMTE4LjQ3MDc3NF0gW0MyMDExMzRdIGRwbWFpZl9yeHEwX3B1czoNCj4gPiA+IFtuYW1l
Om1yZHVtcCZdS2VybmVsDQo+ID4gPiBPZmZzZXQ6IDB4MTc4Y2MwMDAwMCBmcm9tIDB4ZmZmZmZm
YzAwODAwMDAwMA0KPiA+ID4gICAgIFsgIDExOC40NzA4MTBdIFtDMjAxMTM0XSBkcG1haWZfcnhx
MF9wdXM6DQo+ID4gPiBbbmFtZTptcmR1bXAmXVBIWVNfT0ZGU0VUOiAweDQwMDAwMDAwDQo+ID4g
PiAgICAgWyAgMTE4LjQ3MDgyN10gW0MyMDExMzRdIGRwbWFpZl9yeHEwX3B1czoNCj4gPiA+IFtu
YW1lOm1yZHVtcCZdcHN0YXRlOg0KPiA+ID4gNjA0MDAwMDUgKG5aQ3YgZGFpZiArUEFOIC1VQU8p
DQo+ID4gPiAgICAgWyAgMTE4LjQ3MDg0OF0gW0MyMDExMzRdIGRwbWFpZl9yeHEwX3B1czogW25h
bWU6bXJkdW1wJl1wYyA6DQo+ID4gPiBbMHhmZmZmZmZkNzk1OThhZWZjXSBza2Jfc2VnbWVudCsw
eGNkMC8weGQxNA0KPiA+ID4gICAgIFsgIDExOC40NzA5MDBdIFtDMjAxMTM0XSBkcG1haWZfcnhx
MF9wdXM6IFtuYW1lOm1yZHVtcCZdbHIgOg0KPiA+ID4gWzB4ZmZmZmZmZDc5NTk4YTVlOF0gc2ti
X3NlZ21lbnQrMHgzYmMvMHhkMTQNCj4gPiA+ICAgICBbICAxMTguNDcwOTI4XSBbQzIwMTEzNF0g
ZHBtYWlmX3J4cTBfcHVzOiBbbmFtZTptcmR1bXAmXXNwIDoNCj4gPiA+IGZmZmZmZmMwMDgwMTM3
NzANCj4gPiA+ICAgICBbICAxMTguNDcwOTQxXSBbQzIwMTEzNF0gZHBtYWlmX3J4cTBfcHVzOiBb
bmFtZTptcmR1bXAmXXgyOToNCj4gPiA+IGZmZmZmZmMwMDgwMTM4MTAgeDI4OiAwMDAwMDAwMDAw
MDAwMDQwDQo+ID4gPiAgICAgWyAgMTE4LjQ3MDk2MV0gW0MyMDExMzRdIGRwbWFpZl9yeHEwX3B1
czogW25hbWU6bXJkdW1wJl14Mjc6DQo+ID4gPiAwMDAwMDAwMDAwMDAwMDJhIHgyNjogZmFmZmZm
ODEzMzhmNTUwMA0KPiA+ID4gICAgIFsgIDExOC40NzA5NzZdIFtDMjAxMTM0XSBkcG1haWZfcnhx
MF9wdXM6IFtuYW1lOm1yZHVtcCZdeDI1Og0KPiA+ID4gZjlmZmZmODAwYzg3ZTAwMCB4MjQ6IDAw
MDAwMDAwMDAwMDAwMDANCj4gPiA+ICAgICBbICAxMTguNDcwOTkxXSBbQzIwMTEzNF0gZHBtYWlm
X3J4cTBfcHVzOiBbbmFtZTptcmR1bXAmXXgyMzoNCj4gPiA+IDAwMDAwMDAwMDAwMDAwNGIgeDIy
OiBmNGZmZmY4MTMzOGY0YzAwDQo+ID4gPiAgICAgWyAgMTE4LjQ3MTAwNV0gW0MyMDExMzRdIGRw
bWFpZl9yeHEwX3B1czogW25hbWU6bXJkdW1wJl14MjE6DQo+ID4gPiAwMDAwMDAwMDAwMDAwMDBi
IHgyMDogMDAwMDAwMDAwMDAwMDAwMA0KPiA+ID4gICAgIFsgIDExOC40NzEwMTldIFtDMjAxMTM0
XSBkcG1haWZfcnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdeDE5Og0KPiA+ID4gZmRmZmZmODA3N2Ri
NWRjOCB4MTg6IDAwMDAwMDAwMDAwMDAwMDANCj4gPiA+ICAgICBbICAxMTguNDcxMDMzXSBbQzIw
MTEzNF0gZHBtYWlmX3J4cTBfcHVzOiBbbmFtZTptcmR1bXAmXXgxNzoNCj4gPiA+IDAwMDAwMDAw
YWQ2YjYzYjYgeDE2OiAwMDAwMDAwMGFkNmI2M2I2DQo+ID4gPiAgICAgWyAgMTE4LjQ3MTA0N10g
W0MyMDExMzRdIGRwbWFpZl9yeHEwX3B1czogW25hbWU6bXJkdW1wJl14MTU6DQo+ID4gPiBmZmZm
ZmZkNzk1YWE1OWQ0IHgxNDogZmZmZmZmZDc5NWFhN2JjNA0KPiA+ID4gICAgIFsgIDExOC40NzEw
NjFdIFtDMjAxMTM0XSBkcG1haWZfcnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZdeDEzOg0KPiA+ID4g
ZjRmZmZmODA2ZDQwYmMwMCB4MTI6IDAwMDAwMDAxMDAwMDAwMDANCj4gPiA+ICAgICBbICAxMTgu
NDcxMDc1XSBbQzIwMTEzNF0gZHBtYWlmX3J4cTBfcHVzOiBbbmFtZTptcmR1bXAmXXgxMToNCj4g
PiA+IDAwNTQwMDA4MDAwMDAwMDAgeDEwOiAwMDAwMDAwMDAwMDAwMDQwDQo+ID4gPiAgICAgWyAg
MTE4LjQ3MTA4OV0gW0MyMDExMzRdIGRwbWFpZl9yeHEwX3B1czogW25hbWU6bXJkdW1wJl14OSA6
DQo+ID4gPiAwMDAwMDAwMDAwMDAwMDQwIHg4IDogMDAwMDAwMDAwMDAwMDA1NQ0KPiA+ID4gICAg
IFsgIDExOC40NzExMDRdIFtDMjAxMTM0XSBkcG1haWZfcnhxMF9wdXM6IFtuYW1lOm1yZHVtcCZd
eDcgOg0KPiA+ID4gZmZmZmZmZDc5NTliMDg2OCB4NiA6IGZmZmZmZmQ3OTU5YWVlYmMNCj4gPiA+
ICAgICBbICAxMTguNDcxMTE4XSBbQzIwMTEzNF0gZHBtYWlmX3J4cTBfcHVzOiBbbmFtZTptcmR1
bXAmXXg1IDoNCj4gPiA+IGY4ZmZmZjgxMzJhYzU3MjAgeDQgOiBmZmZmZmZjMDA4MDEzNGE4DQo+
ID4gPiAgICAgWyAgMTE4LjQ3MTEzMV0gW0MyMDExMzRdIGRwbWFpZl9yeHEwX3B1czogW25hbWU6
bXJkdW1wJl14MyA6DQo+ID4gPiAwMDAwMDAwMDAwMDAwYTIwIHgyIDogMDAwMDAwMDAwMDAwMDAw
MQ0KPiA+ID4gICAgIFsgIDExOC40NzExNDVdIFtDMjAxMTM0XSBkcG1haWZfcnhxMF9wdXM6IFtu
YW1lOm1yZHVtcCZdeDEgOg0KPiA+ID4gMDAwMDAwMDAwMDAwMDAwYSB4MCA6IGZhZmZmZjgxMzM4
ZjU1MDANCj4gPiANCj4gPiBQbGVhc2UgdHJ1bmNhdGUgdG8gdGhlIG1vc3QgcmVsZXZhbnQgaW5m
b3JtYXRpb24uDQo+IA0KPiBJdCBoYXMgYWxyZWFkeSBiZWVuIHVwZGF0ZWQgaW4gdjMuDQo+IA0K
PiA+IA0KPiA+IFRoYXQgW25hbWU6Li5dIHN0dWZmIGxvb2tzIG9kZCB0b28/IElzIHRoaXMgbm9y
bWFsIGRtZXNnPyBJZiBzbywNCj4gPiB3aGF0DQo+ID4gaXMgdGhlIHBsYXRmb3JtLg0KPiANCj4g
VGhlIGRldmljZSB3aGVyZSB0aGUgaXNzdWUgb2NjdXJyZWQgaXMgQW5kcm9pZCBNZWRpYXRlayBt
b2JpbGUNCj4gcGxhdGZvcm0uIFRocmVhZCBhbmQgbmFtZSBhcmUgcmVsYXRlZCB0byBNZWRpYXRl
ay4NCg0KVGhlIGluY2x1ZGVkIHRocmVhZCBhbmQgbmFtZSBsb2cgaW5mb3JtYXRpb24gYXJlIGxp
a2VseSBmcm9tIHRoZQ0KaW50ZXJydXB0ZWQgdGhyZWFkLCB0aGlzIGNhbiBiZSBzZWVuIGZyb20g
dGhlIHN0YXJ0aW5nIGlycSBmdW50aW9uIGluDQp0aGUgY2FsbCBzdGFjayhfX2RvX3NvZnRpcnEr
MHgxNC8weDIwKS4NCj4gDQo+IA0KPiA+IA0KPiA+IEluIHRoaXMgY2FzZSwgdGhlIChwb3NzaWJs
eSBzb21ld2hhdCB0cnVuY2F0ZWQpIHN0YWNrIHRyYWNlIGFuZA0KPiA+IGV4cGxpY2l0DQo+ID4g
a2VybmVsIEJVRyBhdCBzdGF0ZW1lbnQgcHJvYmFibHkgc3VmZmljZS4NCj4gPiANCj4gPiA+IEZp
eGVzOiBhMWU0MGFjNWI1ZTkgKCJuZXQ6IGdzbzogZml4IHVkcCBnc28gZnJhZ2xpc3Qgc2VnbWVu
dGF0aW9uDQo+ID4gPiBhZnRlciBwdWxsIGZyb20gZnJhZ19saXN0IikNCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFNoaW1pbmcgQ2hlbmcgPHNoaW1pbmcuY2hlbmdAbWVkaWF0ZWsuY29tPg0KPiA+ID4g
LS0tDQo+ID4gPiAgbmV0L2lwdjQvdWRwX29mZmxvYWQuYyB8IDQgKysrKw0KPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL25l
dC9pcHY0L3VkcF9vZmZsb2FkLmMgYi9uZXQvaXB2NC91ZHBfb2ZmbG9hZC5jDQo+ID4gPiBpbmRl
eCBhNWJlNmU0ZWQzMjYuLmVjMDViYjdkMWUyMiAxMDA2NDQNCj4gPiA+IC0tLSBhL25ldC9pcHY0
L3VkcF9vZmZsb2FkLmMNCj4gPiA+ICsrKyBiL25ldC9pcHY0L3VkcF9vZmZsb2FkLmMNCj4gPiA+
IEBAIC0yNzMsNiArMjczLDcgQEAgc3RydWN0IHNrX2J1ZmYgKl9fdWRwX2dzb19zZWdtZW50KHN0
cnVjdA0KPiA+ID4gc2tfYnVmZiAqZ3NvX3NrYiwNCj4gPiA+ICAgICAgIGJvb2wgY29weV9kdG9y
Ow0KPiA+ID4gICAgICAgX19zdW0xNiBjaGVjazsNCj4gPiA+ICAgICAgIF9fYmUxNiBuZXdsZW47
DQo+ID4gPiArICAgICBpbnQgcmV0ID0gMDsNCj4gPiA+IA0KPiA+ID4gICAgICAgbXNzID0gc2ti
X3NoaW5mbyhnc29fc2tiKS0+Z3NvX3NpemU7DQo+ID4gPiAgICAgICBpZiAoZ3NvX3NrYi0+bGVu
IDw9IHNpemVvZigqdWgpICsgbXNzKQ0KPiA+ID4gQEAgLTMwMSw2ICszMDIsOSBAQCBzdHJ1Y3Qg
c2tfYnVmZiAqX191ZHBfZ3NvX3NlZ21lbnQoc3RydWN0DQo+ID4gPiBza19idWZmICpnc29fc2ti
LA0KPiA+ID4gICAgICAgICAgICAgICBpZiAoc2tiX3BhZ2VsZW4oZ3NvX3NrYikgLSBzaXplb2Yo
KnVoKSA9PQ0KPiA+ID4gc2tiX3NoaW5mbyhnc29fc2tiKS0+Z3NvX3NpemUpDQo+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIF9fdWRwX2dzb19zZWdtZW50X2xpc3QoZ3NvX3NrYiwN
Cj4gPiA+IGZlYXR1cmVzLCBpc19pcHY2KTsNCj4gPiA+IA0KPiA+ID4gKyAgICAgICAgICAgICBy
ZXQgPSBfX3NrYl9saW5lYXJpemUoZ3NvX3NrYik7DQo+ID4gPiArICAgICAgICAgICAgIGlmIChy
ZXQpDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIocmV0KTsNCj4g
PiANCj4gPiBjb2RlIExHVE0sIHRoYW5rcy4NCj4gPiANCj4gPiA+ICAgICAgICAgICAgICAgIC8q
IFNldHVwIGNzdW0sIGFzIGZyYWdsaXN0IHNraXBzIHRoaXMgaW4NCj4gPiA+IHVkcDRfZ3JvX3Jl
Y2VpdmUuICovDQo+ID4gPiAgICAgICAgICAgICAgIGdzb19za2ItPmNzdW1fc3RhcnQgPSBza2Jf
dHJhbnNwb3J0X2hlYWRlcihnc29fc2tiKQ0KPiA+ID4gLQ0KPiA+ID4gZ3NvX3NrYi0+aGVhZDsN
Cj4gPiA+ICAgICAgICAgICAgICAgZ3NvX3NrYi0+Y3N1bV9vZmZzZXQgPSBvZmZzZXRvZihzdHJ1
Y3QgdWRwaGRyLA0KPiA+ID4gY2hlY2spOw0KPiA+ID4gLS0NCj4gPiA+IDIuNDUuMg0KPiA+ID4g
DQo+ID4gDQo+ID4gDQo=

