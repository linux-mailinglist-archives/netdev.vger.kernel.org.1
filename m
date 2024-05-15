Return-Path: <netdev+bounces-96496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311AF8C635F
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 11:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A801F23BB2
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 09:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0212D54BFE;
	Wed, 15 May 2024 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="l1hhX76e";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="oOJtuUq4"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA658AA5;
	Wed, 15 May 2024 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763957; cv=fail; b=r+H3dsKvd1CPzYECMDe+O8q7r+nUviHkhZoQ09dfuWTXsf6I5Jy0/RDRwxKD4Ifti2DahSn857fb7og+oQ3CKKuVuiG7PAtxQ0q2hY53d0W6QexA4dYliSuPX/xZtYZFCoogoIyaHJL7gR2+wfbFD6WYmOxnaNj3dRWo986i4XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763957; c=relaxed/simple;
	bh=7KelmWcqJ773MHbSDZGZ/mvbDFPBFKWrwNW02K7QLBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eNpwA2yCnr3oz+nTYhlcjwnm5hj80xVAXzxk9shQPdM/nYB+vxmAY+UCncRlKW3Vpj2uVkgtft1kB9Kud1MLnFIiPk+nOoAR45yuxtN9aGJ7E6XI5PRmVXrSm5ZHpCggYYvxhQQ9PYYgXCMV2WHRrPr7dePoYF+UG2s3A3NiLGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=l1hhX76e; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=oOJtuUq4; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5441d326129a11ef8065b7b53f7091ad-20240515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7KelmWcqJ773MHbSDZGZ/mvbDFPBFKWrwNW02K7QLBE=;
	b=l1hhX76eO5KPLmLuLE70HuVh5qK5X+PDL/Gp1uQu9h6/KofR9NanfXUcLlccVKfGwb+uwQou9xbD5LDjMKEyiC9JaPvtQFMohX3wWofhuDlEi5XPoGbCXe9v4glizeJqHawHOb6Q28LFG9zPgFrDGwAeOHtWxdsC/E11eH7nrD8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:5860efe7-2121-430f-b769-bef66e0679ad,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:8f671efc-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5441d326129a11ef8065b7b53f7091ad-20240515
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1592023292; Wed, 15 May 2024 17:05:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 15 May 2024 17:05:50 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 15 May 2024 17:05:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQLcQeUWqkfittBCVRxnwLT2HJHI9xqCAVyNNzwjutylZQK/K803Y39F00imvvp85COW+cNxPGzt/8etNg0nP3Wp/KkBu6Sf/CE/hxHmlZagA60lO/68ehiWPqdQTp6ysTLHdL71AnL2Loa4wFqBrkwDsnpjIFN3G8jxQoOvijT13IunFPux2Lu05HVVdZY/pwBy72P1YextrFkt44O6w4ONTwcYlElydaCWgeixW6wMJvgSZjPYscV+956lgFO207/nAJZLS8+9AEa/g/aXiTerK7HT2T4wmZV+1HUCucGLW8hAO4+IyE+bsW5F5RvXqkbf+E64MFX0ZEBjdxlowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KelmWcqJ773MHbSDZGZ/mvbDFPBFKWrwNW02K7QLBE=;
 b=M5gj+79LW5TFctvbkeHi+pM21MtpVZWVLh0eNrt73gNhs7E2cKKCEXZ+3V9Wx0r3cj7HDhGRkO1RQGr1BhPxwU4UiaUhVF6UmS0zNAi51gfVnT0heTJPWmYR5amqGSmvb0G7gj2RiOtSiFtI/bgcr0Q++dRQw9HpY2FnAMhhlQ7n0xdNQqqKzJJB0yB2ymnlhZkbA8J+fH/t0rpvaA7bR5oE8srofHa/vXRgqdgpWcxfPajiibwBkl1S3v3D8xezW5Ku7iO5dxuTF/IBRh/LN+rWGNIJyqGbKCqHBtASaoFvdcI/5IFz/F3eR6clJWGIP2q0xZ1q0XN+rtyhH+qCVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KelmWcqJ773MHbSDZGZ/mvbDFPBFKWrwNW02K7QLBE=;
 b=oOJtuUq4/dDFALLhfS4Hjr7F4Z6bNTvQ7WG96QdphQn2kptEfOyZVph0j4Tu7g2kJ42KMgHTyv0ZneX7zk86tAaSq9tQze58bKULAg3dlTz7iP9XzXAiIp1P5r1zG597u8vGbH1TfwyqRhO9ZpYXmsUTfHoE4N23TUqn4pbmSIM=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by TY0PR03MB6450.apcprd03.prod.outlook.com (2603:1096:400:1ad::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Wed, 15 May
 2024 09:05:47 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::c7af:9174:8579:b1e6]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::c7af:9174:8579:b1e6%6]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 09:05:47 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, =?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"edumazet@google.com" <edumazet@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: drop pulled SKB_GSO_FRAGLIST skb
Thread-Topic: [PATCH net] net: drop pulled SKB_GSO_FRAGLIST skb
Thread-Index: AQHamXiLeVYDS0cC3UmcRJMDEXnF5rF/PnaAgBjc6wA=
Date: Wed, 15 May 2024 09:05:47 +0000
Message-ID: <3a9388af81eba384e8fb15b1559b87de3ab04e1e.camel@mediatek.com>
References: <20240428143010.18719-1-shiming.cheng@mediatek.com>
	 <662f9fc92a908_2e2f1d294c2@willemb.c.googlers.com.notmuch>
In-Reply-To: <662f9fc92a908_2e2f1d294c2@willemb.c.googlers.com.notmuch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|TY0PR03MB6450:EE_
x-ms-office365-filtering-correlation-id: 99cff648-8a08-4321-1b88-08dc74be358c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Ry9Mb3Y1TEdYaGMxTUVZZXNLTVpFREkrTTZoOFFyOGgzQ3YwNE5SN1BWbFl6?=
 =?utf-8?B?ekYvcC9OSU5QZWIreTRicFlIbDl3NCtEb0dwTnRGUk9Db3lPVWxNb3JJTUZX?=
 =?utf-8?B?TFhkMlVJb2pXS1NheDIvQ2JreDBDajBmRVpvZDBoZUY4Q09CQUY5MWJFOXVS?=
 =?utf-8?B?ZUVBYnlwMWd6RmVoL1E2UFBwK3U0bjRGSEJQQ2xob2ErOG1FWGp5cERJK3lX?=
 =?utf-8?B?cVd0UjhlVW94K2tuNHBNOTJQcHlEbDFCWW1Qbko4amFYR1orc2dzWjkzMXBM?=
 =?utf-8?B?aE5mWUp4amhlNWF2ZVVkODE3UU5hbTJ0cjArOXo0T3ZObThBMU1PMFhkZDhV?=
 =?utf-8?B?UTRzK1lNV2YwemRzdUlVWWUwN0ZTT3g4cFhRbUs2RDFmTE5aM0ZRVG96ZDVL?=
 =?utf-8?B?ZUhkRjlFWXF2TmllL2czQUJyM2hvMTJRWHRVa2g2VUowR3ZSMEFmQ1lLbDZz?=
 =?utf-8?B?aklXSTlJU0ZPUytYSUlreG1oMnN1cDRqWE90MTlQMzlVUXZUS1Z1dWtmR3lV?=
 =?utf-8?B?MzRwcTdQaXZkUDI2Rm9WR0dsYjhBZXZhalBlTmVPdkh3L1luTFpicGxrNUla?=
 =?utf-8?B?cUQzbXVTbEIwc09nTVpFUllXMnMrcUExMCtWS0hHd0k3YkY1UWROR1RNRG5o?=
 =?utf-8?B?YlFPcDFyeUpwTnNuclRpdTFVK2JQSXR5a1dWWGcyZ0Y3MlFVblJmS2g3OU1S?=
 =?utf-8?B?VHhZVFhLRXp4MlVYZ2NTb2NmWlUxZzJBdmZYcnljL0xMeDcvZXNKZ3NTaUs2?=
 =?utf-8?B?K2NBc0s4ekxIRzBXVnlJYVdWbnNLTzNXQzlaaENaM2JUYzBjTDVuSjdrS0lV?=
 =?utf-8?B?eHpyaVNWczlMVDlOUE1FNzdKRHU1WlhiWlBXOGw0ZUtNcndFMGRRbDV2ZnJP?=
 =?utf-8?B?RVlTb1Vuby80SEVsMXhEOWk2U3Jia01kY1VzQ2JCbklMNkV0YVgyZUIzRjdU?=
 =?utf-8?B?aWM2VmFrV2JPVkpOZVRmK3RYS2Vsa05tNWhjNEUyZjkrSUFicWVMMHdCTmF0?=
 =?utf-8?B?YmNzelpRQVFnSnFsV0JIRThiWUo4dXRDSlFDQVN6L2tQQ05zMWRPTllWQkkv?=
 =?utf-8?B?NEJPNjlnMmI5Z1VoU0JvekdGdGpGeWdGVEZwK1AwcndJKzBnRjRiVHUzQldq?=
 =?utf-8?B?SjJRWGNWTlpHZ2dMUHlmd0NyTWw0U2h1YjNSNjZUay8vMDJRUXlWa3JoVksx?=
 =?utf-8?B?TVJTZTdoekNhc2NmZGYrT0MvMEVzRGhiaExKTWQ4MERMSWVQTFB3NUZ2bDM4?=
 =?utf-8?B?Lys1Y3BFTXpKMmFGZ0VGM1NaQW9yNkxzR1FZSzJmYnJJbHVLanhOVWpvVXlQ?=
 =?utf-8?B?clA4aGZGcWN1Q3FsSFlFcGMwQWdGYk9VSWljQjBHMFB5RllCeXNHRkc2bXNJ?=
 =?utf-8?B?enJWWXpDNzBhSWNnYURBaTJ1WGhHd0N4a1pJc2Q2N2k0NDVseVBmOVJIaEtI?=
 =?utf-8?B?bVRHampjUHhUdlcrakxJQXZpR3VWVThjTzVvRFRKSisvRGNjZWZxWnB1Z01U?=
 =?utf-8?B?L0tuZkJWbGRDVmpNaHJSQlc1a0RiaEl3MlVnZ0tydzZzMWk2eHlxclhId29M?=
 =?utf-8?B?dVEwbUtsd3NHQm9pSFVocENNUXBSQzdwQ2RiYjZTOUgwaVlsSUg3VkdYd3dU?=
 =?utf-8?B?T0prWnpxRVNUK1F2SER0VzVkU1REdTI2NytkbUEvK3UvY1EyYUJ2YzNtcVBV?=
 =?utf-8?B?Z1lOUmd6NlFuZTRqNGMvUUU0bkJwZUJlRk0xY1ZWbU90SkkrQURaNzRxMFlm?=
 =?utf-8?B?Qk0vMVRGbEVwaGkzT1UwU3pLVWhhTFhteUwzblB3QWM3ajU4MmZqK3pOUkRK?=
 =?utf-8?B?VjZrL1Y4YkY0NytmTFNsUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEdLc0VyZkFNYlMwZ3Ryb204dDJ6MWRSMU9wV3MybUQrU2lNd2twVk51NFNC?=
 =?utf-8?B?NFQxZ0RJZWFwZmxTU0kzMVd4YnNFaUNNWWxIUnFRcVJlYXU5cnBBb2JSQXBi?=
 =?utf-8?B?QnlBVkpGY3FienFDVGU4RUhBVnQ0elpVb3pHTXJ0U25ub1UzS3lyN0JSaVpE?=
 =?utf-8?B?RHBLN2ZWVnRBdlh1WUtLay9QeW54b2crQk9BN0tkeUM2VmhOcnhVZE5jblRZ?=
 =?utf-8?B?SG5MWGhteFB6SENyaENKODRwK0tibW85ZTJEdnlwRjFpdXd4UERjYTQ5RnNs?=
 =?utf-8?B?WFFXa1kzM3RmRzJSTGk5c0FrLzhwQ2xnVlEwdTFSTEZ0V3RaSFl1b0VsbUg3?=
 =?utf-8?B?dU44dHhCakFJV2JsUCt5K2tLakdVTVhoNFl5OWZCaWZaQmI4VVFsNUNrbzFi?=
 =?utf-8?B?SndxMkJqejdSamcxRmJxZndHM29XTjd4emY2N0twb09vRXd3akN6c1Y4MVRX?=
 =?utf-8?B?L2xTNDZ1VjczTWhxVzJ1WnpJcmpPSWYydHhVWWRvU1dpZnAwdTJlajVOSWd3?=
 =?utf-8?B?R2hzdUZHeFZTMG81azJhYmp6dUhqZFAvWGhZZngybkZoZ1ZDQUMxb0tLeStl?=
 =?utf-8?B?MW0wNzRWb296ekZGYWZUQzlDK1gyT0liWFVERXZSVVlVV3VVemRTZDdGbkhH?=
 =?utf-8?B?WDd4cVBYYThFbnJiQXJPbkxLRll5b2E3Z1BtV2l1R2VSM2RJc2RSMVlaVXlk?=
 =?utf-8?B?dUhSZ2hWYzFKTUhvWTlja0R3Y1JZalFLckFOYlRhYUxqZ2dMWm5IemsrbkxL?=
 =?utf-8?B?bWxxL1JDU1NtK1hGSTh6S01zZXI1MFF5VUVkRk9YelV3dkhXTTFIdndSWW83?=
 =?utf-8?B?b0FzTXNZbjNMb0JtVXFTcTZlc1lMQit3SGlsVjR4Y2xoZnJBTk1KTUF1bGp3?=
 =?utf-8?B?Vk9FcjZFRHUrZEZ5enNOVzNGTjA0NFRPcWVodWJiVmJsTWM2OWFoVzZsL3dS?=
 =?utf-8?B?dVczNElHLzdmRnBJUTFGQWRiMmZVUFQrVExRODVQaWJjbXh3UTJyVm8rL0Rj?=
 =?utf-8?B?RHVZVjI0RlNueEV0eEkzVk04bzRtL0tpdWtIUzhiMzF5UEZ5MzdRbTVLbDNh?=
 =?utf-8?B?OUt3N2VySE45TmNXNW1TejdobThjQW9ubHVDcytQaTdkalB1aHJIWGVJN0sz?=
 =?utf-8?B?TnZNR1NmV3QzVElxSkYrMHdoOStaNUpxYXBkMmVCc2NtMHBMRlVpZFhZemwv?=
 =?utf-8?B?Mm5YOUE2aFB5S2xNVGpISXZvUmVqakhuR2dRajdWNnF2ck8wUnBIUTZwYkVB?=
 =?utf-8?B?MFN6RU1FYXdDOFVsVVIzRTlOT0FsRGw5S2M3QVB1ZkRoNlZDaDIwMmsvSUMr?=
 =?utf-8?B?bkgxekJzenZmaGtLbDBpSXovMlVwb3VvYzBLWWRpK00wQlFxUndVUUE1MWtU?=
 =?utf-8?B?eTA5c0VuNHM3ajM1ZkljNnhEY0ErVlVmeGFuSDZpb3p0TytzczcrMGNPZUMz?=
 =?utf-8?B?ZTJvQWpUK2tJSkV1ejBCZStHRGk1bmtyWjlocm8xMDhoOTV6TEMvbDhKRlhj?=
 =?utf-8?B?dkI5ZGVpc1NXQzBhNldwelJmM2FUdHhHaE9qQ0EvcWJhOEZDVjhTSHBLZnN1?=
 =?utf-8?B?NHdIWTgvbjkwdkRrNFVKRnd3K3YxNjF3Z1I5REkvdDlZaVBrbXFXMjRjV0Zl?=
 =?utf-8?B?Mng0aDgrOUxkenZrT1NWejd2YUR3TGtOb1FOSklxU0J5MnIxODRxdFFMMUlP?=
 =?utf-8?B?MENTMzRFdWI5Y2hnWkg5cmorbHMvS3BMRys0MFY1ZFlublVLZnF0Qk1vSlZa?=
 =?utf-8?B?YmJsc0puN0x1SEFNUFowVlBtOXRZdEtoM1gyaHRtVDBxYTFueXc4RTFScXc1?=
 =?utf-8?B?TjdqUUIwM1NEL2pTK1NKK0xhUlV0aXY3cFlia01oN3JiTHhnR3JpemZrSTRo?=
 =?utf-8?B?QW9wUW9ZSTd6Nk1iQ015L0l5UXhqaXZtVWxHM0tpb2V4eW5BeU1QRGR2ODQz?=
 =?utf-8?B?Y3NXM2lXdnRqYVZZSEZOVkl0V2YwKzA4OXFhWWNoUFhsQ2h0c3oyWGpkTVdx?=
 =?utf-8?B?V2wyTVUzdjBwZ1hCRUFJSWpZN1RQMUJST2NZQ1lWNmNUZXJwVEFPbGZVZEdB?=
 =?utf-8?B?R2NmaXczMmdYZ3JsNUw5SmF5QlpKWWVNOWxFK3N2Y05mc25jSEl3T0ZqT1k0?=
 =?utf-8?B?Z0NHK3V1ZUY4V3RMb0FKek9QSVFianhHT1pvTm1pcDFHK2NteFVvcTNkeGoy?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C541ABD1256DE4D87B26D687AF2B920@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cff648-8a08-4321-1b88-08dc74be358c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 09:05:47.0626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ipRWp3KyMZKFqTCTdyWa9j8xbzSXewINwmIjIa6Ft1Plk37SAm1QtCb2tZPTuGceEDFrlFDsBkN/yEXM+wzuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6450

T24gTW9uLCAyMDI0LTA0LTI5IGF0IDA5OjI1IC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gIHNoaW1pbmcuY2hlbmdAIHdyb3RlOg0KPiA+IEZyb206IFNoaW1p
bmcgQ2hlbmcgPHNoaW1pbmcuY2hlbmdAbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEEgU0tCX0dT
T19GUkFHTElTVCBza2Igd2l0aG91dCBHU09fQllfRlJBR1MgaXMNCj4gPiBleHBlY3RlZCB0byBo
YXZlIGFsbCBzZWdtZW50cyBleGNlcHQgdGhlIGxhc3QNCj4gPiB0byBiZSBnc29fc2l6ZSBsb25n
LiBJZiB0aGlzIGRvZXMgbm90IGhvbGQsIHRoZQ0KPiA+IHNrYiBoYXMgYmVlbiBtb2RpZmllZCBh
bmQgdGhlIGZyYWdsaXN0IGdzbyBpbnRlZ3JpdHkNCj4gPiBpcyBsb3N0LiBEcm9wIHRoZSBwYWNr
ZXQsIGFzIGl0IGNhbm5vdCBiZSBzZWdtZW50ZWQNCj4gPiBjb3JyZWN0bHkgYnkgc2tiX3NlZ21l
bnRfbGlzdC4NCj4gPiANCj4gPiBUaGUgc2tiIGNvdWxkIGJlIHNhbHZhZ2VkLiBCeSBsaW5lYXJp
emluZywgZHJvcHBpbmcNCj4gPiB0aGUgU0tCX0dTT19GUkFHTElTVCBiaXQgYW5kIGVudGVyaW5n
IHRoZSBub3JtYWwNCj4gPiBza2Jfc2VnbWVudCBwYXRoIHJhdGhlciB0aGFuIHRoZSBza2Jfc2Vn
bWVudF9saXN0IHBhdGguDQo+ID4gDQo+ID4gVGhhdCBjaG9pY2UgaXMgY3VycmVudGx5IG1hZGUg
aW4gdGhlIHByb3RvY29sIGNhbGxlciwNCj4gPiBfX3VkcF9nc29fc2VnbWVudC4gSXQncyBub3Qg
dHJpdmlhbCB0byBhZGQgc3VjaCBhDQo+ID4gYmFja3VwIHBhdGggaGVyZS4gU28gbGV0J3MgYWRk
IHRoaXMgYmFja3N0b3AgYWdhaW5zdA0KPiA+IGtlcm5lbCBjcmFzaGVzLg0KPiA+IA0KPiA+IEZp
eGVzOiAzYTEyOTZhMzhkMGMgKCJuZXQ6IFN1cHBvcnQgR1JPL0dTTyBmcmFnbGlzdCBjaGFpbmlu
Zy4iKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoaW1pbmcgQ2hlbmcgPHNoaW1pbmcuY2hlbmdAbWVk
aWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExlbmEgV2FuZyA8bGVuYS53YW5nQG1lZGlh
dGVrLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBXaWxsZW0gZGUgQnJ1aWpuIDx3aWxsZW1iQGdv
b2dsZS5jb20+DQoNCkRlYXIgZXhwZXJ0cywNCkNvdWxkIHlvdSBwbGVhc2UgaGVscCB0byB1cGRh
dGUgdGhlIHVwc3RyZWFtIHByb2dyZXNzPw0KDQpUaGFua3MNCkxlbmENCg0KDQo=

