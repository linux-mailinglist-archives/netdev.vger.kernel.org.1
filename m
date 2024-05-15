Return-Path: <netdev+bounces-96495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ACF8C635A
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 11:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9B81F238A4
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 09:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3527955E5B;
	Wed, 15 May 2024 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kXeChLn4";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="TEJoWnDP"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A253368;
	Wed, 15 May 2024 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763769; cv=fail; b=PQMsPOq4CQ0lx3TtQRJyP+iJT4mP0dKikPI5PwZm6ghiMwgWbPPEEexxeZk+F83LHJpNro0xqc/AZGjXJ6Alis6jVNgpHU595AHFeOiHTm41qzUaYXTVXH7YKkulSH8uIIYtN7qzr5LpFljdt1D4XdIrwFaLUPsrliNCT4jjthg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763769; c=relaxed/simple;
	bh=GmBYN2qdVQ6k+s07mRyqEggw8U7XXlK47OnbNc7I7+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L4xuDg1omWFz1pbb2oSPxjtqZC234gQlWC/TK8VHqf7zPRyPNbpjsljmIbu0kX2Jf5OnSv21JdQ5aaC651+vXYZYJDI4pdPofF5GJjNuY9xUjR5JeSFW6bNQhmU34fHxg9EDfMRXkF3ujkgOkDLfs8crySZ5djcvT/3ns/WXr6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kXeChLn4; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=TEJoWnDP; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e1a99c0e129911ef8065b7b53f7091ad-20240515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GmBYN2qdVQ6k+s07mRyqEggw8U7XXlK47OnbNc7I7+M=;
	b=kXeChLn4GDuuU1EI5KXYKmXgTlAIMT9+rqfzYfEyK/B41VVy8VOELeoSByVBkyCNZlzEY6r/zODb3vkzz0J55EO6HpVjg6PksLfPpbzAugjEb0wd5UhB3EERvX9fWSwt3sDo2vi0WKUjDVtOlJPIVm0N1Thl9pnYqiShFpY1DxA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:5ae3a6b1-0f01-41b4-ab9f-5f6640c97178,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:43d2c892-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e1a99c0e129911ef8065b7b53f7091ad-20240515
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1935060697; Wed, 15 May 2024 17:02:39 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 15 May 2024 17:02:38 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 15 May 2024 17:02:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inZ6JebQyPxN/ft6J3sotmvB7sfHjPvNa8zfKywaOE8LoqOSG1Y84q453mX5pQUOyw7cmts3m8m26lejptcpB7E7Z67zoi7aJev6vmUNRn/gs2Cv46Ls+2QtKql8py6AcbX3cbRc8eSPSH6SYneariLZPyNisGifQKIzF0FI58nPRgB0sERL9xV07AAvc87/R6Idbpe+RW1LHHq8t4HJLRp+lkmzlyZJMEulJDOG4qBSe4R3XRkV5SVK5zXSkZdHWR4oEN+czH/1TI68fN4Iu0VStBhxHbcmmEZOr74ZpNFo+9uEm+06DaEf62GfB3Kdf+0mJizQDr0wZkQNGzjstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmBYN2qdVQ6k+s07mRyqEggw8U7XXlK47OnbNc7I7+M=;
 b=iSGoPYJ7IPmODZ9CbT78or8A2IM+2UKBS/wTMuMIfViPjjSucZzJO8JZf6ZwheXIA/VSH1J2UcPekdg5/gweRtlBAG8i2oofMvJK97MudpKwbpBrpuNwOd9QYWjOlHSYp5JphWECR52JYIFBsLP/vmAxs/SjxPOT9Gw0CcubMzQzH0HY9hEzDp+PIYiVi/9AuVZVpTqvFX0APWGDclz+AXdYDyr/roKr3agLgO3xzg8Hk8yODiThAm2yM69RHrEg2dB4th3W/GYLd1iREdSqCCMb2CGE0eaZLHSxh5y5pQTplTZdxHflHAsgXy3HHVw2+ZNhxkhNyvWXkSabBV5C6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmBYN2qdVQ6k+s07mRyqEggw8U7XXlK47OnbNc7I7+M=;
 b=TEJoWnDPkueA2XU1PaptY49bmlLpR1ZuE1hpzf2St8PY7wubfh/CVMvvZ8vQRk8AQVNvpmeK87FxLKIOJFdKsMgifa5Zx09vdhfoX5Bv0R9X7IugrPQx0KlC2HxQvXtLgN+JpDTKODqrsCgarGPV20Vmj/JbjyeAMSJufFSV7O4=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by TYZPR03MB8727.apcprd03.prod.outlook.com (2603:1096:405:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 09:02:36 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::c7af:9174:8579:b1e6]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::c7af:9174:8579:b1e6%6]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 09:02:36 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net] net: prevent pulling SKB_GSO_FRAGLIST skb
Thread-Topic: [PATCH net] net: prevent pulling SKB_GSO_FRAGLIST skb
Thread-Index: AQHamXh3SQ+1lKsnl0u0DlYO3sGEgbF/Qx+AgBjXXoA=
Date: Wed, 15 May 2024 09:02:35 +0000
Message-ID: <bc69f8cc4aed8b16daba17c0ca0199fe6d7d24a8.camel@mediatek.com>
References: <20240428142913.18666-1-shiming.cheng@mediatek.com>
	 <20240429064209.5ce59350@kernel.org>
In-Reply-To: <20240429064209.5ce59350@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|TYZPR03MB8727:EE_
x-ms-office365-filtering-correlation-id: 42fbf050-fb23-41d8-1323-08dc74bdc3a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?c3lYNGdJUVV2TTZaYUh0ZnprZUJGVi9ZMHh2NTI1SW5CQW1MTVc1UlA5cEUv?=
 =?utf-8?B?ZzNWUU5ibEM3ZTNvZGE1b3BVNVdCUUIrMS9FWDlaKzlOazF6cUQ5UGMveVJr?=
 =?utf-8?B?MWJjM0ZGQTB0cWdHMklSMURSTndGVWczV2dnZ1V0VTRtSGJJc3VFMStJOVdQ?=
 =?utf-8?B?RUVBUkhpWDRPczNSQ2FvTGg5UDFrbmpjalozcHVWZWs2WEJMVFhLemN0Lzc5?=
 =?utf-8?B?aXJ6Ri84UkkxNXhpVllTUHdtT0ZmTVZRYnhoREN1a3NQNWxYSjNJZzVVRGlt?=
 =?utf-8?B?aGY3ODY0NWxqWnJZOHBWcmNwZ3RYYVdtQjlFa1NvQXcvK1N4Z0dMczJVZEw4?=
 =?utf-8?B?bUdHQTMrWVVUTUprVWNOL0swVTYwcWZVRW1sM05XdE5OejNxcGt6aGxFMmtu?=
 =?utf-8?B?TkpBbXppRDNsWHhnSVg1M1k5aitmYS9oRks4NkFvcnNMN0JMcVNOdlkzczVH?=
 =?utf-8?B?bHpnV0tXTW5meHZjQWRNaFovSnJpSDJJK3IzdmtjVWJxYThYeTBKclJuTm1v?=
 =?utf-8?B?WXphWjdNWkF0YVRVSkhmKytYb0pYTkFuL0F3RE8zRWpYOWlsSmZZa1gwV0FM?=
 =?utf-8?B?SzFuVG1MYThINU15aWwzN3VDZDlsTmdHa3VTM2ZXNnJmSmxGbHFFZ3cvSExw?=
 =?utf-8?B?VC81Q2haaExtMmtJQnU3MXJ6aGU3dktJTVc2VDYyWHJyUlpRd2FXb3lRV2dT?=
 =?utf-8?B?S3lPaC9JZS9EUFlSNDBodnh3a2RaNElBeE8yZGUyVlkzbHZOcnh1Znp4NjdI?=
 =?utf-8?B?RzVUZForU1ZFNjJUaUFKS3IvUzRuU3FCSXpKd3pISUJocTlLWVNXZXFZNXJS?=
 =?utf-8?B?SUpqNDc3bGJqNjFEdWNSbTNHMC9ESG43a28xZ2JSV2VqQ25zaGV1dk5DQkht?=
 =?utf-8?B?MVZiZ0F6QkJpL0xwZFRXUU0zZWlPSUZaRnFzY2VqQXkwbVR2dVlJWXhzY2lL?=
 =?utf-8?B?NnNRNjBKak5rT29PZlJFVWZDTWtWTVVXMFhySnI3cEFINmd4dkVyMWtzT2tw?=
 =?utf-8?B?UjBoYklmTG5QMGFHTk82WlB4YWZwdHVEV2tkTjAycE9TdThJQXR3eFVlTVpC?=
 =?utf-8?B?SEczSlJZWkNjUlArU2xvMDNrcEpaZDdOWjlCMjZ0cWJEdUxNQjJaOU53K0F1?=
 =?utf-8?B?QnJHV1FXaTI1Z2tEeGFDVmNTQ1U5TytzMHVJdW1HM1FrU1g1dGpxNEpHbXlY?=
 =?utf-8?B?R2NheDJ3bXh1U3BlMm5xVW1wVGdjMVl0QTFVbFlTYlVKK0U0a0RvMGxGM0ZI?=
 =?utf-8?B?MmJqblk5MWVCQ2c2NXVZY3QzeWhFTnNWS1l3S0R1RGwxTDcwQjVHT2phRkgx?=
 =?utf-8?B?ZEh0UXZmbVUyeEpuUXhlVmdjSGI3NlpnTlJnM1h2UzU3clNWQ0dlWVNxclJk?=
 =?utf-8?B?QnNJcFNCQ2x0YnNmaEJCMXRNL1lFd2NCTzdWajlSNXRLSUJhaHdhS2M4cW9z?=
 =?utf-8?B?R0NjY3pRaEdLQWFxaXM3enNjL2k3TWlwN3lMUTZiazZrZzc4WG1nV3cvRWU4?=
 =?utf-8?B?UEZ3YmZ6ekhUT0E0UUdLZ3ZNdC9NWVF2VUIrZmpKYlFERVNtd1I5OEZnc0R0?=
 =?utf-8?B?NTJnYzNieW9OcHk2bTZ0c2NkVDVuUkJHTTdEQlJERVdueFhXcldKSW9rbVBJ?=
 =?utf-8?B?N0x6VHR1UTBNRHI5RytSZkxUbys5aDR4ZlZyMitDR3NsdTBNSExhYVAyZHRU?=
 =?utf-8?B?a2NHM0FCNHpWTEhLMlZvTlpQZDJ2WjdMLzFMRDM1WE1zRUIvN2xPRU50d21m?=
 =?utf-8?B?OFBpNjBKaDI2Q1gzUG56SStxYUVUbFYzbmh2eWNqQXBGTFo0RVNJVENPYUJN?=
 =?utf-8?B?a3piOU1JWHQ4d0RVV096dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nyt6QUJFU3Z6UlBxM0Ixd2I3WUExT0xSQVNpL09LeFdoTGZaM0svU0JKdzVT?=
 =?utf-8?B?UkNocGptNkVBKzNxRHA0SFNQOWJqTG9CeithbHVqekI1dEF6ZWxmTjVaUmwz?=
 =?utf-8?B?VjhnRktuckxJbE14dFR1b2h2TFR2dk8wMjVINk55eFB1Rjg2TXRrUkcwa25k?=
 =?utf-8?B?L3JKL0V5VlY5b1lyTndYamIxbzFiTjFsM0YxV1Y4YzZTc3FKeFhuaytNWTV3?=
 =?utf-8?B?VkkxamdsMWtleXVXMGxQMllkZ0tMWGJ0YS82cm0wSTZOeDZKS0hYNFhlc3FK?=
 =?utf-8?B?RkdET2lteDdGOXArYXJBa1JVU0FIS2lNbHl0UjhaN3IrMERNTXg1TVJhRCt5?=
 =?utf-8?B?Nlg0dHBtcGlSVlUyWWlnOEZ6ZHdoR0lzYUI3RDNvMGluWFpiUTRONDZKRVUw?=
 =?utf-8?B?alRWZ2FwWmJ2TWR2RWplL1VaeThFOXdkVlFFWVFTcFRhVldLektydkhoaWZV?=
 =?utf-8?B?ZmVmL2NaSFR0R0VPNmt5bVJXOSt6WEZnZ1hPbStNL0dDWHpkVGhzbDlzUlpm?=
 =?utf-8?B?UHBJOXRVWkg0YWJIbCt0NkRJcVpUb25DM3hMUDZ0cWpCRGNSVWVkS1FxSGw4?=
 =?utf-8?B?eTNlTExkbFJrNUxGMEszQ04zTjJkajhaZUxIWGtqSHFmMmhTamVZanEzKzEv?=
 =?utf-8?B?a0ZySDlra3RBTk9uajVFZ0YzcXNQY0RCSm8yRlcwdHYrSkRITWVwdXNMUU5O?=
 =?utf-8?B?TFlkNFZvQWdENTJhSU5zNU9qVEhSZTArN3BuQ2dJa1c5Vk5KTkxjaHdDZUhL?=
 =?utf-8?B?cFJvVzdwVUZjS0lDS3hubng5elJHVDNJZ3JwajhMcHJsUVpzTXI2NjNGKzZZ?=
 =?utf-8?B?WFduUWJ4WnlpS2REbHgxVnBPdUsvOGQ3NS8xNEgvVDJMU0JSYnpKbVAxSWpU?=
 =?utf-8?B?aitYa0U5c3VnZ3VlZFlaUzk0VWhDNkw0UFJOb2dFUWlRZUNxZ01KRkJYT2l6?=
 =?utf-8?B?b2ZMRUlrU1hsSlQyQWxSS2lUNXBwYWVzcFpOYjM2cXZGMndqUy9zWTRwZ0NS?=
 =?utf-8?B?OWRyRjNpeDY0VU9acm9udHRJejQwOFoxNXpwUERZaGRCQ1M5ckhWTGUrbTBT?=
 =?utf-8?B?dlVzZXlLWjVkN082NTNoZlhPUEQyZmVzT1hBNFBHNVM3aHc4V2JoOTdrSmlC?=
 =?utf-8?B?RUxvTjFsWjRmUmdBYXZyeExVcUZuYVBkdmppQ1pGUVhrMzFFVzR6Vzk5OHBK?=
 =?utf-8?B?aXFpZ0JSSWN1ZmpwMXUzNzZFVlRGNGlYY2ZXeGJTaFY4cVNKOUpMeHE1dHJB?=
 =?utf-8?B?N01JK0cwMXJUVy9aYTE5eXZCdEN6V3EyOStnRTRuMytDeTdjbnpsQzRhemZt?=
 =?utf-8?B?TFVwWWxKRXVDWjZkdVdFMjQzd0FJTWgwRnBVdnYyb2VicTRPTmRKMU1mcmtn?=
 =?utf-8?B?cHQ0ZDZQaXIxbkpqUXBhcm0raVVkUXZWejlaVUxvMXcwZWhXeHhDNHdsTFg5?=
 =?utf-8?B?dmlXWlg1Y0ZjcTFlbVlLaWthTS9MZU83UEdJaVhOcXJBbTd2U2hiK3BKT0Ra?=
 =?utf-8?B?TEJYcVUxSUtGWlV6Q3BiQy9iU0l1b1FxTVp3Uit3cUh4eFZvd3dxUDNUUW84?=
 =?utf-8?B?REhzeDBxS2ZUZ2lSMkhFV0R0NHVQT0hucnlNeW1KL0FrblY3d0RRK1lyNytr?=
 =?utf-8?B?aks2VU95K1hiODJrWitVbmtlRWlYaHZjQjBDUVpqME1idllQOWVKVDhPYVpP?=
 =?utf-8?B?T2ZFblNQT0UrWERLdy9VdGtnWklrdnM1VkFidytOdTE3VGpoZnhqblROemRZ?=
 =?utf-8?B?MVh0eklGYzl2cWtWc0JPVUV6V28zL0hQQjNZU2gvNjl0U2FmYVFMZ3ZwaEdp?=
 =?utf-8?B?UG1kTWJ1YjFId01lZm1zK3J4eFoyaThUeFpWMWEwRHJLZFk4TU03RGZzZDd1?=
 =?utf-8?B?YTJneCtSS1ppbm9odnFBL1lod1A0RDdlaE5nVmtsTzRKMEhUd2tOZjRKZXdG?=
 =?utf-8?B?TTV2dWxsdGpIUlo4MWFPd0E1OU5ReXgxd01Md1FLM21EWDdxa3J0TFBRcXBi?=
 =?utf-8?B?RUZlTWFuRi9VUkM0V2grRHVsb1dhVjQ4d0ZOR3FvZTNNWWVueklCTStqeHJi?=
 =?utf-8?B?Tkk0R0YyeGo1ckRWMzBjU0FnTjlkRElWYUNIOVJoZHF2bUY1bk1RNGxmNEFh?=
 =?utf-8?B?M1V3RTZPbm9ENGFEL1YrbGp5WnkwUDRqMFhXZG5kSFZGdFAwVzMvVXZqUCt4?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C608972FC0A88148AA930ECB62414F0B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42fbf050-fb23-41d8-1323-08dc74bdc3a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 09:02:35.9272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SwPxWkR4pMNxPBfFwZ0JVgbqaIfPjU+dMwWH+EudmPyFVT2RK86jZgSf3GGaI5FSbWMdYSJ5AaDu4cZXUrRdYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8727

T24gTW9uLCAyMDI0LTA0LTI5IGF0IDA2OjQyIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICBPbiBTdW4sIDI4IEFwciAyMDI0IDIyOjI5OjEzICswODAwIHNoaW1p
bmcuY2hlbmdAbWVkaWF0ZWsuY29tIHdyb3RlOg0KPiA+IEZyb206IFNoaW1pbmcgQ2hlbmcgPHNo
aW1pbmcuY2hlbmdAbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEJQRiBvciBUQyBjYWxsZXJzIG1h
eSBwdWxsIGluIGEgbGVuZ3RoIGxvbmdlciB0aGFuIHNrYl9oZWFkbGVuKCkNCj4gPiBmb3IgYSBT
S0JfR1NPX0ZSQUdMSVNUIHNrYi4gVGhlIGRhdGEgaW4gZnJhZ2xpc3Qgd2lsbCBiZSBwdWxsZWQN
Cj4gPiBpbnRvIHRoZSBsaW5lYXIgc3BhY2UuIEhvd2V2ZXIgaXQgZGVzdHJveXMgdGhlIHNrYidz
IHN0cnVjdHVyZQ0KPiA+IGFuZCBtYXkgcmVzdWx0IGluIGFuIGludmFsaWQgc2VnbWVudGF0aW9u
IG9yIGtlcm5lbCBleGNlcHRpb24uDQo+ID4gDQo+ID4gU28gd2Ugc2hvdWxkIGFkZCBwcm90ZWN0
aW9uIHRvIHN0b3AgdGhlIG9wZXJhdGlvbiBhbmQgcmV0dXJuDQo+ID4gZXJyb3IgdG8gcmVtaW5k
IGNhbGxlcnMuDQo+IA0KPiBPbmUgb2YgdGhlIGZpeGVzIHlvdSBwb3N0ZWQgYnJlYWtzIHRoZQ0K
PiANCj4gICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvdWRwZ3JvX2Z3ZC5zaA0KPiANCj4g
c2VsZnRlc3QuIFBsZWFzZSBpbnZlc3RpZ2F0ZSwgYW5kIGVpdGhlciBhZGp1c3QgdGhlIHRlc3Qg
b3IgdGhlIGZpeC4NCg0KRGVhciBKYWt1YiwNClNvcnJ5IGZvciBsYXRlIHJlc3BvbnNlLg0KQXMg
d2UgZG8gbm90IG1ha2Ugc2VsZnRlc3QgYmVmb3JlLCBJIHRyeSB0byBidWlsZCBhIHRlc3QgZW52
aXJvbm1lbiBhbmQNCmNvc3QgdGltZSB0byBhcHBseSBzdWRvIGFjY2VzcyByaWdodCBpbiBvdXIg
Y29tcGFueSBzZXJ2ZXIuIE5vdyBpdA0KYmxvY2tzIHRvIGdlbmVyYXRlIHhkcF9kdW1teS5icGYu
by4gQ291bGQgeW91IHBsZWFzZSBnaXZlIHNvbWUgZ3VpZGxpbmUNCmFib3V0IHRoZSBzY3JpcHQg
dGVzdCBzdGVwPyBUaGFua3MuDQoNCkNvdWxkIHlvdSBnaXZlIG1vcmUgaW5mbyBhYm91dCB0aGUg
ZmFpbGVkIHNpdHVhdGlvbj8gIA0KSXMgaXQgdGhpcyBmaXggIltQQVRDSCBuZXRdIG5ldDogcHJl
dmVudCBwdWxsaW5nIFNLQl9HU09fRlJBR0xJU1Qgc2tiIg0KZmFpbGVkPw0KV2hpY2ggY2FzZSBp
cyBmYWlsZWQ/DQpJcyBpdCBwb3NzaWJsZSB0aGF0IHRoZSB0ZXN0IGNhc2UgaGFzIGlzc3VlPw0K
DQoNCj4gIHsNCj4gPiAraWYgKHNrYl9pc19nc28oc2tiKSAmJg0KPiA+ICsgICAgKHNrYl9zaGlu
Zm8oc2tiKS0+Z3NvX3R5cGUgJiBTS0JfR1NPX0ZSQUdMSVNUKSAmJg0KPiA+ICsgICAgIHdyaXRl
X2xlbiA+IHNrYl9oZWFkbGVuKHNrYikpIHsNCj4gPiArcmV0dXJuIC1FTk9NRU07DQo+ID4gK30N
Cj4gPiArDQo+IA0KPiBNb3N0IGNhbGxlcnMgb2Ygc2tiX2Vuc3VyZV93cml0YWJsZSBwdWxsIGxl
c3MgdGhhbiBoZWFkbGVuLg0KPiBJdCBtaWdodCBiZSBnb29kIHRvIHN0YXJ0IHdpdGggdGhlIHdy
aXRlX2xlbiBjaGVjay4gQmVmb3JlDQo+IGxvb2tpbmcgYXQgZ3NvIHR5cGUuDQo+IA0KDQpEZWFy
IFdpbGxlbSwNCkkgd2lsbCB1ZHBhdGUgYXMgeW91ciBhZHZpY2UgaW4gdjIgYXM6DQoraWYgKHdy
aXRlX2xlbiA+IHNrYl9oZWFkbGVuKHNrYikgJiYgc2tiX2lzX2dzbyhza2IpICYmDQorICAgIChz
a2Jfc2hpbmZvDQooc2tiKS0+Z3NvX3R5cGUgJiBTS0JfR1NPX0ZSQUdMSVNUKSkgew0KDQpBYm91
dCBzZWxmdGVzdHMvbmV0L3VkcGdyb19md2Quc2ggY2FzZSBmYWlsZWQsIGRvIHlvdSBrbm93IHRo
ZSByZWFzb24NCm9yIGhhdmUgYW55IGFkdmljZT8NCg0KVGhhbmtzDQpMZW5hDQoNCg==

