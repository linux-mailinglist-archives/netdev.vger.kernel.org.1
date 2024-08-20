Return-Path: <netdev+bounces-120108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8D095853D
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB29228A2A5
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 10:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141C718E020;
	Tue, 20 Aug 2024 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Z+amzKyi";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kFj5J+X9"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98B118DF79;
	Tue, 20 Aug 2024 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151205; cv=fail; b=HHtB66Ep/UtV9Xj8EXyuHqa3yWR9QtnVgBCuqeA6TDOdVySnlqVCNEG5d+qYOzh82ZIHiAcPEB+yrTBf5vUUn2CISlkTGIMLxV0XZNMI3oj/xBgrMswD1zrqV0bNpG0iY1dhNGgE0MZlE3qLOKmgGl0ZNHvGBDfp8oh5wu9tAdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151205; c=relaxed/simple;
	bh=zg1ZiK061MI/ixYLVWkRd1wYJOxOsNR9A5k1Gu9BaNE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lddNsgh3RqbURiJQtDeetAmlNum7fvdgi9i7a10VL0Mo2Ar6bJDDp0rTTy9q8ke7zQ943WJHFURIVR/s9Q/88vF6VVbp7C74fl8uVAlcMnuRt9RWTh8vz9ZGWx0Wu+fq1RC0VDqqtArcXX7ZsDs3shJkmS70Mqzz0a85K/QyOz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Z+amzKyi; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=kFj5J+X9; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 66b888585ee211ef8b96093e013ec31c-20240820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zg1ZiK061MI/ixYLVWkRd1wYJOxOsNR9A5k1Gu9BaNE=;
	b=Z+amzKyiKt9SYTZ1FVnBmk/p/0BQLEkbtjfYbX/0qZL2c+z8DSYNJ7VlQllA+J1EM1SUsLmOJZzyPFkXtCLOWwC5kyrBYzuENRedjqPAo4GeJhc2U4auBSHlsemIjk+AotAPKtdB9e05bFjvKcvR9ERNjZAVYb4qmqrcAAU+IGM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:20ffedc2-fbd8-45e6-b6be-19440a394edb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:c569a5be-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 66b888585ee211ef8b96093e013ec31c-20240820
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <tze-nan.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 401460511; Tue, 20 Aug 2024 18:53:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 20 Aug 2024 18:53:15 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 20 Aug 2024 18:53:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNE38SZXhJBxUbRx1A5798+YlRpaQtZHF5OPB5Uq6G6hFmQSxON/ylSD1PIjhOM4Gev/UlpwuUO2B0h9Z7yng7HNVHuTE42/dBWw3MSKDKSlFmsiMardTibnLrjz/WtDBxkDX1LzhZm+xP4MQpaBV9vJnw8FTBthO6YtrUMOkSaUhkjFXp/7whb26z9BEvzmvl0/syYLB3UE615C3g4Y40UXyg36eG/RjWpRhXC+jk9qIATyqt+ugfA9kEYdsRbAb/luCD8pZhCSRN9L67S/mCvPRKLk+sLJCJu7anqM964hYuDN+/pN5ixvNo3L1apfAIdk1+D1hM49qE1fhUmtwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zg1ZiK061MI/ixYLVWkRd1wYJOxOsNR9A5k1Gu9BaNE=;
 b=u/ZSQsFWt55Kr6xs40HCuSBz+UPKlg5FqGmRTRmNW8lvcPxavX9fVVHKuPH42oBNanGtnvqaD0vHaXAuSHXv73DZd1oq7wUM0qQ8+rMsqa4uSWXKzY7D6yMLqbWlewQDz/2ZytuWVqo7YTXD+MMAVe7FVejEDArw5xAK+hFUrPRjodIrSstDSVzjYb3ENv7FpZHCObYw9KzIwyfllzwGQWfFrSbYOQOnXuziw2SPKafvmmsHsObwhMBQ1+X5+VfK5Pq9RnTqvh9q08lF+QffCaVBpEPthWIX+Z+JmQ4gHKDPhQ9Amu94b8EPC6/mbs8E2gr4UBZijeMiwJrCfEnBqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zg1ZiK061MI/ixYLVWkRd1wYJOxOsNR9A5k1Gu9BaNE=;
 b=kFj5J+X9+y7dJsEWtK+3eTepniJkPj2+gCfBrmd8jzr0uQUrP+FXuATfv9dR0/XhGSkJO8JSKuwr9uGStjBpY9vuxh/8oup82HSy/9LOQjLJ1qGAELJ4hGcYh6cXpPVbNygud4l62uVPPB7elNgmpVM5CGMftuaitrI/hGvAhbw=
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com (2603:1096:400:33a::11)
 by TYSPR03MB7990.apcprd03.prod.outlook.com (2603:1096:400:47c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 10:53:12 +0000
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350]) by TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350%6]) with mapi id 15.20.7849.018; Tue, 20 Aug 2024
 10:53:11 +0000
From: =?utf-8?B?VHplLW5hbiBXdSAo5ZCz5r6k5Y2XKQ==?= <Tze-nan.Wu@mediatek.com>
To: "kuniyu@amazon.com" <kuniyu@amazon.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>, wsd_upstream <wsd_upstream@mediatek.com>,
	=?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	=?utf-8?B?WWFuZ2h1aSBMaSAo5p2O6Ziz6L6JKQ==?= <Yanghui.Li@mediatek.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] net/socket: Check cgroup_bpf_enabled() only once in
 do_sock_getsockopt
Thread-Topic: [PATCH v2] net/socket: Check cgroup_bpf_enabled() only once in
 do_sock_getsockopt
Thread-Index: AQHa8u8mQR9dZ10Pa0i12v5uJc1ZeA==
Date: Tue, 20 Aug 2024 10:53:11 +0000
Message-ID: <cf901029738d3c1be033451e31c85dfe906b437b.camel@mediatek.com>
References: <20240819155627.1367-1-Tze-nan.Wu@mediatek.com>
	 <20240819181825.18235-1-kuniyu@amazon.com>
In-Reply-To: <20240819181825.18235-1-kuniyu@amazon.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7183:EE_|TYSPR03MB7990:EE_
x-ms-office365-filtering-correlation-id: 9f512f07-36a5-43f5-6b9d-08dcc1064907
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OVhTbkpxeUN0OFFFbGJmWnRjaWNEQ3JSVkxxUUd0OTNxaHRLcmVGanJZbGZs?=
 =?utf-8?B?Q3oyNnBGS0w2QS85L05tRitmTXY1UWhKVUxiOXlBdndFNnF2bzh3RkFuaDNW?=
 =?utf-8?B?d1VONXhWalYrVG1ZTHN3MEVEVUxXRklzS1dIb1IwZnZKVXdzUndITjc2YkMx?=
 =?utf-8?B?WDNJTlJRVmc1QTBTY1lFcGpBUlUyb0hDY2V3YUkyTmFpdDFhTFc0M0JmdmtQ?=
 =?utf-8?B?cTJWYkZ0L0ZYdGF6UFdDajYySmpOSVJIN3JhRXlkdVNIYmtmbXF5dDBscUZD?=
 =?utf-8?B?WjNBa2pEdmRhUlduMkVTTTc3MjhvVStuaW5Jc01xNmtrbTlIb2JVUFBYOTcx?=
 =?utf-8?B?N2hERTRwQ3lpSlpHMlBIbTA5dnFhSmE0THFxWXBORTAvYm1JVUxlemVzOEEr?=
 =?utf-8?B?K1lFMVpiUHpsU0xkZGdiTU9XWFNZUEllUEJlUEtpY2ZpcXh3Y2pxUXBxbjJG?=
 =?utf-8?B?dGNWT204SGVzWjJXMWJTSHR2dGw5cy8waThnMlloa1lzUHFkMVdleHRyejdR?=
 =?utf-8?B?UjJwR1Z5R0t5M24wK2cyd1Y2N0lxU3hxZ0xZbUYxMGpTdTVrRzRWcXNzZjMv?=
 =?utf-8?B?M0dTTE53SWdoV0htVFNOdThDUEhJMy9iMnd6cDNwVFJER0sxWHdjb2xKYWN3?=
 =?utf-8?B?RkpNOXkrS1VMcW91RjBTUUVldGQ0OGtleWREYWwxem44Z0V0NEV2d3cwWGlx?=
 =?utf-8?B?YzR0WGNaRXU5SHZObERtajNUcHV5S0xtZUlpMzl6WDgreEliQ0EycG5LNEZM?=
 =?utf-8?B?c1NQclpmNkVtNW1URTBkd1Q4NG9KUjg1N3FJRmRkV050S3JxUGVMbXEzdTJv?=
 =?utf-8?B?Q3NqMloybWVISzliWkJ0RHFtUmoxR3JiZ1FPQkc3RERSenFCY3dnZHgxbFlM?=
 =?utf-8?B?YWtOeCtYaERHYUZWenJEMDJvaWZROWdKMGNnMnYvUU45M2hGb3F4YStoUDF1?=
 =?utf-8?B?WXMzcVdsVGNCNUg0WXB4Vk16TGM0VVoyYTBDb1BVcjczcGhqc1FOaUdFM25s?=
 =?utf-8?B?ZzROMmFHcUNsanlnYkpZb3d4YytPQWRWbkMzM01SY3JrWG9ORGkwMXh6N21z?=
 =?utf-8?B?MTlwalVMVGZIZStkcWRxNmFJM2owZ3BTM0VGbWJXVHJUc3dMWnZUcDE1UGk2?=
 =?utf-8?B?am92YlVlSG9PcHp3bjlBcGtOM1FtVjJMV0NmelcyZXArbWJscm5hM0ttNVlI?=
 =?utf-8?B?ak1GNlBCQWRXSVRoV0g5VWxZU2ZTeDNKZkJPZ3hMREs4RG5VOWplWFZNTzZo?=
 =?utf-8?B?c2U1R0pQRktlRkZGam9Tb0FLbnN6SHZ3SER1Sy9lNnNPaE1jcTcyRkxBSEVj?=
 =?utf-8?B?MlM0bGc3ZEg3Z3RRaFBrSDFhcU45aTZuNm5QdnlyK2ttcVRtY29iWGgzaWxk?=
 =?utf-8?B?a0sxdkFBWmN3WXZKdVYzRWJEQjlhWlNDQWtBM3AvaFRYMEN2WFMwdTlZVDdy?=
 =?utf-8?B?S2NVOXdRc1Q2RHcvRjlHWENiUDRhR0RWVFFtV1lEUDJXTmhVVkVxelU3eXYy?=
 =?utf-8?B?ZFZGWFkrMXJNOUlYRHgzc2sxSUVoYk84SUNrQkdWK0lpalgzT1pDR09WSEN1?=
 =?utf-8?B?N1BuR1l2elpYWVM3dzQvMGx5bnZhcFhhV2czeSsrNjVSYnNVMmFwS09ZRDdx?=
 =?utf-8?B?a1daankxRkVqbTNLKzZ3Uko2T0pKK0ViUkdmYmhGUkxHZ0dMVXJDQlgwRldr?=
 =?utf-8?B?SWI3REpUaGF5bDJ3RmhwcE0velYzV1ZNdnU3aXdYU3RBaHpqSFRKSStYNXYw?=
 =?utf-8?B?bURLQ2ZIWGQvd0g1ZEFWclhVYnZncUNONE1LMzdRc3FrZFpzNWZnTTVOaVVB?=
 =?utf-8?Q?K/wojhVa8hmjjJJKowjt7YiW3EJJRj1trQR/M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7183.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V01jWldxOXZQNzE0Ky9aQitJbStPWStJWTdjd0FFZlFrMnM3SEtiTGUvRys4?=
 =?utf-8?B?WWZpQkVTZlE3L2pZV2JST01CQXJMVlAwblRLNG1wTi9iTloyZkhKeFYxMlZx?=
 =?utf-8?B?V1dXNFlWc3ltb0M0b2hYSXBWZkNBL2JUWTNrTlladU9DYXpaRStkb1J4dE12?=
 =?utf-8?B?bjloenNqRDBOSzRGdktuU05zbmpBQy96Q3BRYm1xTExIcEFBaW1Jd0lCTW93?=
 =?utf-8?B?UWJtV1AxbGdQNXczYUx3dTNHUUZhVW8wZUN6T2dqWXFqdmZIcFBOY0VRRk83?=
 =?utf-8?B?MnhTejBYQ3FLMElGZzBxQjZpQ2RGWlRiNXU4RytsTk9kbTNjaVQzc1dMcEZ4?=
 =?utf-8?B?MHhYR2hJdXpZVjFXRVpMa0lNbDBYWStSb1ZvVC9Bb2hwb0lGKzNFVndFakRN?=
 =?utf-8?B?VVNEYWlYcVdaU1loTzZjR0tod2lidE93SVE3SmR6UG1ZeWhPWGMyaitHaWpN?=
 =?utf-8?B?eFVhYWw2ZGNPY2NlRUpPUURwbXZhcnFhQWVQcEdZWXpFS0lQVVdYaUJwRnpL?=
 =?utf-8?B?Zk8yeFdwem5ydmpyeWVwb1phMzhlYncxWW4wT3c0Q2ZBam1pYTkrcWxOY2FT?=
 =?utf-8?B?YzFabVB0eTVLMENkbE92THlKZlVIUytUTGk4TXZZTUowWmlZcmd1UEY5aGtG?=
 =?utf-8?B?TksxTS9yWmd1STBHZU03bzZ2VUZhUkpkZnY3b3J1eFlYakdvaVZUWDE3SHRN?=
 =?utf-8?B?TmZQN0RZYzliaWpxOUNlTHhIN0lrVFgvUXRrUGdpakFRQXh3RzRqbUlGYWMv?=
 =?utf-8?B?T2RwWmd5YUoyOEpZd01pZ2RYZDIrYlNPTmNISVRrRzQxR3ZTc0RPbEZYRE5W?=
 =?utf-8?B?bVlITGZQclhobTFUZVdXK2w2bU40T09PeFh4Y3FicThRc2dJazBnSUdmWmhx?=
 =?utf-8?B?RmJaNG1veFVUUWZVSTkxd0wzZEtGVkY1NCtCUVZrdHVFeFY1Q2FGOWRaTk94?=
 =?utf-8?B?MDNjNXZvL3hJZm9kL0VERFBGTjlCV2RtNmxjMUY0cElaNGNuUHdaOVYyYWZo?=
 =?utf-8?B?Lzk2ZDRWTzhXZU0zM2txd1ZCamRvVk1jS2lGZ3pYYjlLazdlU3VzYU1sTkVI?=
 =?utf-8?B?WVFabW00VTNhemQ4QWI4WjR6R3NOMnU2aUFCcHBqcWt2c3hVdXVadWk0QS8x?=
 =?utf-8?B?VUlNYXVhUm13eTc5RWR4c2ZLVnN3RkJpVXNaWE9aSjdRUzRWdHpOL2FVS3JR?=
 =?utf-8?B?c29kUWFXR0lEUzJtVUc2eEd6cDFyVThZekt0bW1EQ2RxMFl3SmNvbGhUUXd2?=
 =?utf-8?B?bHdWb0V2OE1DeTlrelVwUWZxaWpYeGxhVzBUZERieDhIQ2pwdlFvak4yMmtj?=
 =?utf-8?B?czArY1RoaHA0eU5PNmJtdjA5d1I3OTM2RW1IRHZYY0N3M3pmMDhZREYwOUti?=
 =?utf-8?B?Mkcvc3h0RE94bHNkVGYxME93WWs1ZXFETC9PbnZZc0s3eEJVVDhPMTdNSVVN?=
 =?utf-8?B?NnBmYnZxWjRDZ2JaR1p5d0pDaDJ4UWk1c1czdXdWTDdsQnJVd2tKYVNseWJL?=
 =?utf-8?B?Q1RIVllTcE1xYXFvcG04MGd1VS9yQnY3MTc3bFU4amZ2MlVIN1dZeUxhV25v?=
 =?utf-8?B?a0lQak5kcXdQVmc0RkgxYTkvcHJWZWJza2FNNDVkcHNjL1NEU1RIeis4aG84?=
 =?utf-8?B?YW9RN1dyRUk1aHRwZnBVWWNxdTd6WHExWHBadDNlL1kwRU1KYmluNTVabGh2?=
 =?utf-8?B?YzdXWlJCUnczdHZlTnZZRFJxM2I3NS80YXBBTGVhbTgxSGx3QkdrL1dNbkps?=
 =?utf-8?B?RXlnb0pobDZqWTd0ampyOXRjSUJMYWc3SnE2YmdQS01LVHhrQnlMVnFRZ2JC?=
 =?utf-8?B?eHBIeDlHSnBTRHo2V1pMVDRLQXpZUU5lTC95eVlxaGFoT1pBamtyazFWMkZo?=
 =?utf-8?B?dE5DMjRyVEI1K0UvSGNnS1FveHIwcUJqMFA4RGdzUEZMUm5YN2ZveFcxZ0Fm?=
 =?utf-8?B?SmpRMXYwWXFWQWdRdUpsbzcrdXFOVk1SWW9MajdtelN4SEtqaHdPU05WV2lI?=
 =?utf-8?B?SjZMOWZKUjFQZVVrdW5VTlB5Z2RiMXZ6Z0UzdHd3VHR5ck91ZmFiUXpmTHBZ?=
 =?utf-8?B?cGdGVkZZcEttT2duSkc0M3ZOaVBZbDhDTjlyMFF0NUhTbGJzM2xOZGJFYzli?=
 =?utf-8?B?MDIrSGpWeWlBQndsZ2VMU1pVQ0pYYWNCU2p0NUVKM0dmbWtNaU4wQTNXZWRS?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCD581208AAED849AD5BE1B1934E215C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7183.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f512f07-36a5-43f5-6b9d-08dcc1064907
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 10:53:11.8516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPlLUr0CYwQPAvaoZdTZim1tpBAa/iex+uMtHLyt74iB/lL9CCKJspHLV+wWHdAly7ugt7t3aIbV1h/nKB+uJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7990
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--29.195900-8.000000
X-TMASE-MatchedRID: YHXf/4QH9w3UL3YCMmnG4omfV7NNMGm++WzVGPiSY8gNcckEPxfz2DEU
	xl1gE1bkfdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+Cx+Mk6ACsw4JhjQD3m2MCf7mky
	Rf0kyQl7h86Pz6wHGfxleFt8BdZ33SoBVPxvX5SRIcJTn2Hkqse4dka7Cjort/xo/oQhwtYQxQF
	dQvpxEAPXHgPYQYVg7udo6rX/SRGsfSeW2aiWyCVCi/xDHcDzfvz6rXsYUspFXPwnnY5XL5BnXQ
	1lmRV8SUAbfT4SSg9w3CMN93nwDYMW+SL2IEvd8NlkA5i6kjNqy4iyjvVWToiz+5QCTrE/s+Vih
	Xqn9xLERzw695MTyJ3/5PTwtcqwIiNCj8jDazVKXXOyNnX/prAXXmzqmsIi7xSZxKZrfThOThOv
	Bn5q9Ts71BXFuo4beJRLVsctdVLlufzckypRuvdTebYqixzILbd6rGhWOAwRFDR0AKGX+XM/Zhv
	Iiu2K6+o+q9c3HQEXxYQcMcn1GarftqC1wgmw4ngIgpj8eDcDBa6VG2+9jFNQdB5NUNSsi1GcRA
	JRT6POOhzOa6g8KrZRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--29.195900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B57634979458DB45326982C1298600ED6AD6625D171538CF4EEEBC5FA4FD97F72000:8

T24gTW9uLCAyMDI0LTA4LTE5IGF0IDExOjE4IC0wNzAwLCBLdW5peXVraSBJd2FzaGltYSB3cm90
ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIg
b3IgdGhlIGNvbnRlbnQuDQo+ICBGcm9tOiBUemUtbmFuIFd1IDxUemUtbmFuLld1QG1lZGlhdGVr
LmNvbT4NCj4gRGF0ZTogTW9uLCAxOSBBdWcgMjAyNCAyMzo1NjoyNyArMDgwMA0KPiA+IFRoZSBy
ZXR1cm4gdmFsdWUgZnJvbSBgY2dyb3VwX2JwZl9lbmFibGVkKENHUk9VUF9HRVRTT0NLT1BUKWAg
Y2FuDQo+IGNoYW5nZQ0KPiA+IGJldHdlZW4gdGhlIGludm9jYXRpb25zIG9mIGBCUEZfQ0dST1VQ
X0dFVFNPQ0tPUFRfTUFYX09QVExFTmAgYW5kDQo+ID4gYEJQRl9DR1JPVVBfUlVOX1BST0dfR0VU
U09DS09QVGAuDQo+ID4gDQo+ID4gSWYgYGNncm91cF9icGZfZW5hYmxlZChDR1JPVVBfR0VUU09D
S09QVClgIGNoYW5nZXMgZnJvbSAiZmFsc2UiIHRvDQo+ID4gInRydWUiIGJldHdlZW4gdGhlIGlu
dm9jYXRpb25zIG9mDQo+IGBCUEZfQ0dST1VQX0dFVFNPQ0tPUFRfTUFYX09QVExFTmAgYW5kDQo+
ID4gYEJQRl9DR1JPVVBfUlVOX1BST0dfR0VUU09DS09QVGAsIGBCUEZfQ0dST1VQX1JVTl9QUk9H
X0dFVFNPQ0tPUFRgDQo+IHdpbGwNCj4gPiByZWNlaXZlIGFuIC1FRkFVTFQgZnJvbQ0KPiBgX19j
Z3JvdXBfYnBmX3J1bl9maWx0ZXJfZ2V0c29ja29wdChtYXhfb3B0bGVuPTApYA0KPiA+IGR1ZSB0
byBgZ2V0X3VzZXIoKWAgd2FzIG5vdCByZWFjaGVkIGluDQo+IGBCUEZfQ0dST1VQX0dFVFNPQ0tP
UFRfTUFYX09QVExFTmAuDQo+ID4gDQo+ID4gU2NlbmFyaW8gc2hvd24gYXMgYmVsb3c6DQo+ID4g
DQo+ID4gICAgICAgICAgICBgcHJvY2VzcyBBYCAgICAgICAgICAgICAgICAgICAgICBgcHJvY2Vz
cyBCYA0KPiA+ICAgICAgICAgICAgLS0tLS0tLS0tLS0gICAgICAgICAgICAgICAgICAgICAgLS0t
LS0tLS0tLS0tDQo+ID4gICBCUEZfQ0dST1VQX0dFVFNPQ0tPUFRfTUFYX09QVExFTg0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW5hYmxlDQo+IENHUk9V
UF9HRVRTT0NLT1BUDQo+ID4gICBCUEZfQ0dST1VQX1JVTl9QUk9HX0dFVFNPQ0tPUFQgKC1FRkFV
TFQpDQo+ID4gDQo+ID4gVG8gcHJldmVudCB0aGlzLCBpbnZva2UgYGNncm91cF9icGZfZW5hYmxl
ZCgpYCBvbmx5IG9uY2UgYW5kIGNhY2hlDQo+IHRoZQ0KPiA+IHJlc3VsdCBpbiBhIG5ld2x5IGFk
ZGVkIGxvY2FsIHZhcmlhYmxlIGBlbmFibGVkYC4NCj4gPiBCb3RoIGBCUEZfQ0dST1VQXypgIG1h
Y3JvcyBpbiBgZG9fc29ja19nZXRzb2Nrb3B0YCB3aWxsIHRoZW4gY2hlY2sNCj4gdGhlaXINCj4g
PiBjb25kaXRpb24gdXNpbmcgdGhlIHNhbWUgYGVuYWJsZWRgIHZhcmlhYmxlIGFzIHRoZSBjb25k
aXRpb24NCj4gdmFyaWFibGUsDQo+ID4gaW5zdGVhZCBvZiB1c2luZyB0aGUgcmV0dXJuIHZhbHVl
cyBmcm9tIGBjZ3JvdXBfYnBmX2VuYWJsZWRgIGNhbGxlZA0KPiBieQ0KPiA+IHRoZW1zZWx2ZXMg
YXMgdGhlIGNvbmRpdGlvbiB2YXJpYWJsZSh3aGljaCBjb3VsZCB5aWVsZCBkaWZmZXJlbnQNCj4g
cmVzdWx0cykuDQo+ID4gVGhpcyBlbnN1cmVzIHRoYXQgZWl0aGVyIGJvdGggYEJQRl9DR1JPVVBf
KmAgbWFjcm9zIHBhc3MgdGhlDQo+IGNvbmRpdGlvbg0KPiA+IG9yIG5laXRoZXIgZG9lcy4NCj4g
PiANCj4gPiBDby1kZXZlbG9wZWQtYnk6IFlhbmdodWkgTGkgPHlhbmdodWkubGlAbWVkaWF0ZWsu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlhbmdodWkgTGkgPHlhbmdodWkubGlAbWVkaWF0ZWsu
Y29tPg0KPiA+IENvLWRldmVsb3BlZC1ieTogQ2hlbmctSnVpIFdhbmcgPGNoZW5nLWp1aS53YW5n
QG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGVuZy1KdWkgV2FuZyA8Y2hlbmct
anVpLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFR6ZS1uYW4gV3UgPFR6
ZS1uYW4uV3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IA0KPiA+IENoYWduZXMgZnJvbSB2
MSB0byB2MjogDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDgxOTA4MjUxMy4y
NzE3Ni0xLVR6ZS1uYW4uV3VAbWVkaWF0ZWsuY29tLw0KPiA+ICAgSW5zdGVhZCBvZiB1c2luZyBj
Z3JvdXBfbG9jayBpbiB0aGUgZmFzdHBhdGgsIGludm9rZQ0KPiBjZ3JvdXBfYnBmX2VuYWJsZWQN
Cj4gPiAgIG9ubHkgb25jZSBhbmQgY2FjaGUgdGhlIHZhbHVlIGluIHRoZSB2YXJpYWJsZSBgZW5h
YmxlZGAuDQo+IGBCUEZfQ0dST1VQXypgDQo+ID4gICBtYWNyb3MgaW4gZG9fc29ja19nZXRzb2Nr
b3B0IGNhbiB0aGVuIGJvdGggY2hlY2sgdGhlaXIgY29uZGl0aW9uDQo+IHdpdGgNCj4gPiAgIHRo
ZSBzYW1lIHZhcmlhYmxlLCBlbnN1cmluZyB0aGF0IGVpdGhlciB0aGV5IGJvdGggcGFzc2luZyB0
aGUNCj4gY29uZGl0aW9uDQo+ID4gICBvciBib3RoIGRvIG5vdC4NCj4gPiANCj4gPiBBcHByZWNp
YXRlIGZvciByZXZpZXdpbmcgdGhpcyENCj4gPiBUaGlzIHBhdGNoIHNob3VsZCBtYWtlIGNncm91
cF9icGZfZW5hYmxlZCgpIG9ubHkgdXNpbmcgb25jZSwNCj4gPiBidXQgbm90IHN1cmUgaWYgIkJQ
Rl9DR1JPVVBfKiIgaXMgbW9kaWZpYWJsZT8obm90IGZhbWlsaWFyIHdpdGgNCj4gY29kZSBoZXJl
KQ0KPiA+IA0KPiA+IElmIGl0J3Mgbm90LCB0aGVuIG1heWJlIEkgY2FuIGNvbWUgdXAgYW5vdGhl
ciBwYXRjaCBsaWtlIGJlbG93IG9uZToNCj4gPiAJKysrIGIvbmV0L3NvY2tldC5jDQo+ID4gCSAg
CWludCBtYXhfb3B0bGVuIF9fbWF5YmVfdW51c2VkOw0KPiA+IAkgCWNvbnN0IHN0cnVjdCBwcm90
b19vcHMgKm9wczsNCj4gPiAJIAlpbnQgZXJyOw0KPiA+IAkrCWJvb2wgZW5hYmxlZDsNCj4gPiAJ
DQo+ID4gCSAJZXJyID0gc2VjdXJpdHlfc29ja2V0X2dldHNvY2tvcHQoc29jaywgbGV2ZWwsIG9w
dG5hbWUpOw0KPiA+IAkgCWlmIChlcnIpDQo+ID4gCSAJCXJldHVybiBlcnI7DQo+ID4gCQ0KPiA+
IAktCWlmICghY29tcGF0KQ0KPiA+IAkrCWVuYWJsZWQgPSBjZ3JvdXBfYnBmX2VuYWJsZWQoQ0dS
T1VQX0dFVFNPQ0tPUFQpOw0KPiA+IAkrICAgaWYgKCFjb21wYXQgJiYgZW5hYmxlZCkNCj4gPiAJ
CQltYXhfb3B0bGVuID0NCj4gQlBGX0NHUk9VUF9HRVRTT0NLT1BUX01BWF9PUFRMRU4ob3B0bGVu
KTsNCj4gPiANCj4gPiBCdXQgdGhpcyB3aWxsIGNhdXNlIGRvX3NvY2tfZ2V0c29ja29wdCBjYWxs
aW5nIGNncm91cF9icGZfZW5hYmxlZA0KPiB1cCB0bw0KPiA+IHRocmVlIHRpbWVzICwgV29uZGVy
aW5nIHdoaWNoIGFwcHJvYWNoIHdpbGwgYmUgbW9yZSBhY2NlcHRhYmxlPw0KPiA+IA0KPiA+IC0t
LQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2JwZi1jZ3JvdXAuaCB8IDEzICsrKysrKy0tLS0tLS0NCj4g
PiAgbmV0L3NvY2tldC5jICAgICAgICAgICAgICAgfCAgOSArKysrKystLS0NCj4gPiAgMiBmaWxl
cyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9icGYtY2dyb3VwLmggYi9pbmNsdWRlL2xpbnV4L2Jw
Zi0NCj4gY2dyb3VwLmgNCj4gPiBpbmRleCBmYjNjM2U3MTgxZTYuLjI1MTYzMmQ1MmZhOSAxMDA2
NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2JwZi1jZ3JvdXAuaA0KPiA+ICsrKyBiL2luY2x1
ZGUvbGludXgvYnBmLWNncm91cC5oDQo+ID4gQEAgLTM5MCwyMCArMzkwLDE5IEBAIHN0YXRpYyBp
bmxpbmUgYm9vbA0KPiBjZ3JvdXBfYnBmX3NvY2tfZW5hYmxlZChzdHJ1Y3Qgc29jayAqc2ssDQo+
ID4gIAlfX3JldDsJCQkJCQkJCQ0KPiAgICAgICAgXA0KPiA+ICB9KQ0KPiA+ICANCj4gPiAtI2Rl
ZmluZSBCUEZfQ0dST1VQX0dFVFNPQ0tPUFRfTUFYX09QVExFTihvcHRsZW4pCQkJDQo+ICAgICAg
ICBcDQo+ID4gKyNkZWZpbmUgQlBGX0NHUk9VUF9HRVRTT0NLT1BUX01BWF9PUFRMRU4ob3B0bGVu
LCBlbmFibGVkKQkJDQo+IAkgICAgICAgXA0KPiANCj4gUGxlYXNlIGtlZXAgXCBhbGlnbmVkLiAg
U2FtZSBmb3Igb3RoZXIgcGxhY2VzLg0KPiANCj4gDQo+ID4gICh7CQkJCQkJCQkJDQo+ICAgICAg
ICBcDQo+ID4gIAlpbnQgX19yZXQgPSAwOwkJCQkJCQkNCj4gICAgICAgIFwNCj4gPiAtCWlmIChj
Z3JvdXBfYnBmX2VuYWJsZWQoQ0dST1VQX0dFVFNPQ0tPUFQpKQkJCQ0KPiAgICAgICAgXA0KPiAN
Cj4gQ2FuIHlvdSBhc3NpZ24gJ2VuYWJsZWQnIGhlcmUgdG8gaGlkZSBpdHMgdXNhZ2UgaW4gdGhl
IG1hY3JvID8NCg0KIEhpIEt1bml5dWtpLA0KDQogTm8gUHJvYmxlbSwgYW5kIHRoYW5rcyBmb3Ig
eW91ciByZWNvbW1lbmRhdGlvbi4NCiBWZXJzaW9uIDMgaGFzIGhpZGUgdGhlIGNncm91cF9icGZf
ZW5hYmxlZCBpbiBtYWNybywNCiBhbmQgZml4IHRoZSBjb2Rpbmcgc3l0bGUgaXNzdWUuDQoNCiAt
LVR6ZS1uYW4NCj4gIA0KPiANCj4gPiArCWlmIChlbmFibGVkKQkJCSAgICAgICBcDQo+ID4gIAkJ
Y29weV9mcm9tX3NvY2twdHIoJl9fcmV0LCBvcHRsZW4sIHNpemVvZihpbnQpKTsJCQ0KPiAgICAg
ICAgXA0KPiA+ICAJX19yZXQ7CQkJCQkJCQkNCj4gICAgICAgIFwNCj4gPiAgfSkNCj4gPiAgDQo+
ID4gICNkZWZpbmUgQlBGX0NHUk9VUF9SVU5fUFJPR19HRVRTT0NLT1BUKHNvY2ssIGxldmVsLCBv
cHRuYW1lLA0KPiBvcHR2YWwsIG9wdGxlbiwgICBcDQo+ID4gLQkJCQkgICAgICAgbWF4X29wdGxl
biwgcmV0dmFsKQkJDQo+ICAgICAgICBcDQo+ID4gKwkJCQkgICAgICAgbWF4X29wdGxlbiwgcmV0
dmFsLCBlbmFibGVkKQkNCj4gCSAgICAgICBcDQo+ID4gICh7CQkJCQkJCQkJDQo+ICAgICAgICBc
DQo+ID4gIAlpbnQgX19yZXQgPSByZXR2YWw7CQkJCQkJDQo+ICAgICAgICBcDQo+ID4gLQlpZiAo
Y2dyb3VwX2JwZl9lbmFibGVkKENHUk9VUF9HRVRTT0NLT1BUKSAmJgkJCQ0KPiAgICAgICAgXA0K
PiA+IC0JICAgIGNncm91cF9icGZfc29ja19lbmFibGVkKHNvY2ssIENHUk9VUF9HRVRTT0NLT1BU
KSkJCQ0KPiAgICAgICAgXA0KPiA+ICsJaWYgKGVuYWJsZWQgJiYgY2dyb3VwX2JwZl9zb2NrX2Vu
YWJsZWQoc29jaywNCj4gQ0dST1VQX0dFVFNPQ0tPUFQpKQkJICAgIFwNCj4gPiAgCQlpZiAoIShz
b2NrKS0+c2tfcHJvdC0+YnBmX2J5cGFzc19nZXRzb2Nrb3B0IHx8CQkNCj4gICAgICAgIFwNCj4g
PiAgCQkgICAgIUlORElSRUNUX0NBTExfSU5FVF8xKChzb2NrKS0+c2tfcHJvdC0NCj4gPmJwZl9i
eXBhc3NfZ2V0c29ja29wdCwgXA0KPiA+ICAJCQkJCXRjcF9icGZfYnlwYXNzX2dldHNvY2tvcHQs
CQ0KPiAgICAgICAgXA0KPiA+IEBAIC01MTgsOSArNTE3LDkgQEAgc3RhdGljIGlubGluZSBpbnQN
Cj4gYnBmX3BlcmNwdV9jZ3JvdXBfc3RvcmFnZV91cGRhdGUoc3RydWN0IGJwZl9tYXAgKm1hcCwN
Cj4gPiAgI2RlZmluZSBCUEZfQ0dST1VQX1JVTl9QUk9HX1NPQ0tfT1BTKHNvY2tfb3BzKSAoeyAw
OyB9KQ0KPiA+ICAjZGVmaW5lIEJQRl9DR1JPVVBfUlVOX1BST0dfREVWSUNFX0NHUk9VUChhdHlw
ZSwgbWFqb3IsIG1pbm9yLA0KPiBhY2Nlc3MpICh7IDA7IH0pDQo+ID4gICNkZWZpbmUgQlBGX0NH
Uk9VUF9SVU5fUFJPR19TWVNDVEwoaGVhZCx0YWJsZSx3cml0ZSxidWYsY291bnQscG9zKQ0KPiAo
eyAwOyB9KQ0KPiA+IC0jZGVmaW5lIEJQRl9DR1JPVVBfR0VUU09DS09QVF9NQVhfT1BUTEVOKG9w
dGxlbikgKHsgMDsgfSkNCj4gPiArI2RlZmluZSBCUEZfQ0dST1VQX0dFVFNPQ0tPUFRfTUFYX09Q
VExFTihvcHRsZW4sIGVuYWJsZWQpICh7IDA7IH0pDQo+ID4gICNkZWZpbmUgQlBGX0NHUk9VUF9S
VU5fUFJPR19HRVRTT0NLT1BUKHNvY2ssIGxldmVsLCBvcHRuYW1lLA0KPiBvcHR2YWwsIFwNCj4g
PiAtCQkJCSAgICAgICBvcHRsZW4sIG1heF9vcHRsZW4sIHJldHZhbCkgKHsNCj4gcmV0dmFsOyB9
KQ0KPiA+ICsJCQkJICAgICAgIG9wdGxlbiwgbWF4X29wdGxlbiwgcmV0dmFsLA0KPiBlbmFibGVk
KSAoeyByZXR2YWw7IH0pDQo+ID4gICNkZWZpbmUgQlBGX0NHUk9VUF9SVU5fUFJPR19HRVRTT0NL
T1BUX0tFUk4oc29jaywgbGV2ZWwsIG9wdG5hbWUsDQo+IG9wdHZhbCwgXA0KPiA+ICAJCQkJCSAg
ICBvcHRsZW4sIHJldHZhbCkgKHsgcmV0dmFsOw0KPiB9KQ0KPiA+ICAjZGVmaW5lIEJQRl9DR1JP
VVBfUlVOX1BST0dfU0VUU09DS09QVChzb2NrLCBsZXZlbCwgb3B0bmFtZSwNCj4gb3B0dmFsLCBv
cHRsZW4sIFwNCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L3NvY2tldC5jIGIvbmV0L3NvY2tldC5jDQo+
ID4gaW5kZXggZmNiZGQ1YmM0N2FjLi41MzM2YTI3NTViYjQgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0
L3NvY2tldC5jDQo+ID4gKysrIGIvbmV0L3NvY2tldC5jDQo+ID4gQEAgLTIzNjUsMTMgKzIzNjUs
MTYgQEAgaW50IGRvX3NvY2tfZ2V0c29ja29wdChzdHJ1Y3Qgc29ja2V0ICpzb2NrLA0KPiBib29s
IGNvbXBhdCwgaW50IGxldmVsLA0KPiA+ICAJaW50IG1heF9vcHRsZW4gX19tYXliZV91bnVzZWQ7
DQo+ID4gIAljb25zdCBzdHJ1Y3QgcHJvdG9fb3BzICpvcHM7DQo+ID4gIAlpbnQgZXJyOw0KPiA+
ICsJYm9vbCBlbmFibGVkOw0KPiANCj4gUGxlYXNlIGtlZXAgcmV2ZXJzZSB4bWFzIHRyZWUgb3Jk
ZXIuDQo+IA0KaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9tYWludGFpbmVyLW5ldGRl
di5odG1sI2xvY2FsLXZhcmlhYmxlLW9yZGVyaW5nLXJldmVyc2UteG1hcy10cmVlLXJjcw0KPiAN
Cj4gDQo+ID4gIA0KPiA+ICAJZXJyID0gc2VjdXJpdHlfc29ja2V0X2dldHNvY2tvcHQoc29jaywg
bGV2ZWwsIG9wdG5hbWUpOw0KPiA+ICAJaWYgKGVycikNCj4gPiAgCQlyZXR1cm4gZXJyOw0KPiA+
ICANCj4gPiAtCWlmICghY29tcGF0KQ0KPiA+IC0JCW1heF9vcHRsZW4gPSBCUEZfQ0dST1VQX0dF
VFNPQ0tPUFRfTUFYX09QVExFTihvcHRsZW4pOw0KPiA+ICsJaWYgKCFjb21wYXQpIHsNCj4gPiAr
CQllbmFibGVkID0gY2dyb3VwX2JwZl9lbmFibGVkKENHUk9VUF9HRVRTT0NLT1BUKTsNCj4gPiAr
CQltYXhfb3B0bGVuID0gQlBGX0NHUk9VUF9HRVRTT0NLT1BUX01BWF9PUFRMRU4ob3B0bGVuLA0K
PiBlbmFibGVkKTsNCj4gPiArCX0NCj4gPiAgDQo+ID4gIAlvcHMgPSBSRUFEX09OQ0Uoc29jay0+
b3BzKTsNCj4gPiAgCWlmIChsZXZlbCA9PSBTT0xfU09DS0VUKSB7DQo+ID4gQEAgLTIzOTAsNyAr
MjM5Myw3IEBAIGludCBkb19zb2NrX2dldHNvY2tvcHQoc3RydWN0IHNvY2tldCAqc29jaywNCj4g
Ym9vbCBjb21wYXQsIGludCBsZXZlbCwNCj4gPiAgCWlmICghY29tcGF0KQ0KPiA+ICAJCWVyciA9
IEJQRl9DR1JPVVBfUlVOX1BST0dfR0VUU09DS09QVChzb2NrLT5zaywgbGV2ZWwsDQo+IG9wdG5h
bWUsDQo+ID4gIAkJCQkJCSAgICAgb3B0dmFsLCBvcHRsZW4sDQo+IG1heF9vcHRsZW4sDQo+ID4g
LQkJCQkJCSAgICAgZXJyKTsNCj4gPiArCQkJCQkJICAgICBlcnIsIGVuYWJsZWQpOw0KPiA+ICAN
Cj4gPiAgCXJldHVybiBlcnI7DQo+ID4gIH0NCj4gPiAtLSANCj4gPiAyLjQ1LjINCj4gDQo=

