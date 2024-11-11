Return-Path: <netdev+bounces-143653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC7B9C37BA
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 06:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E84E28102C
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 05:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B5514658F;
	Mon, 11 Nov 2024 05:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="QX8sTc67"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65D713E3F5;
	Mon, 11 Nov 2024 05:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731302531; cv=fail; b=UhdOG4X5F0TUo5l+uCNQogOm/x+swJ7D3jYKTLOa40TuTyYT0Afwv12NZfOiK3U+B4SFX2thJW/n+gRsGX1mgobSveRxesXEbaCOra/kGt26wnXjwVyPmkLvvc+PRiYgWPrGnDbCA7pamz/wmjcG6FzfsqIzRRj0D8kVtboEXLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731302531; c=relaxed/simple;
	bh=9YMi8cVew2qw4XEaSyTzC57XT0QFi8AxZQKrRtaiW1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dv5cYfZs6z6lDq2ZCfGLEXxdIiT8NEHn9bbvyPHcGX72qm4pyV6317fnACmN4ggDUFxlxT+NzawogC8fA9kWahuADDho+WIvNQWofz8lhDfUsNn1GbUUpIjWOGIdiDgU2T5IddrJXgcCpkRuyIAWG7pX05y6QUU9++RaYUki3hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=QX8sTc67; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB4770L031497;
	Sun, 10 Nov 2024 21:21:33 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42uakrg3ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 21:21:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXMZY0FzpMuzwcrdMKpOqaZQc2u9nAfz5TACOglwFJ20wu5MRzvHfqrKyRksOmeaOgDCKrJrBQB3m4W6B552UG5TyVud/WHB9N9r031grawillkECRotL7dY7QYKSZsivjJOXC6Gru+mS+GinDUTHZoyDerroXTrUMVz/7SaLFMlr/K9h9bY6rzWg/BAZmfiGZli8o3TLJrK8p9LWxN0x/XA2ViJoPPdTARiTQkFbL3z2j9j1ys+P4M8eyk9vkklEaZVAX77tvYmH+gsR+t0hAkuw8zt/2MF4VfQiyfuaOgym84xiVIfLQb8vw+C3mMDSQ9B+w6hHGHZE8OSrNkfwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YMi8cVew2qw4XEaSyTzC57XT0QFi8AxZQKrRtaiW1A=;
 b=JQrvQwZHh9INXQ2RB4tx1288LSNhVGwsCrYOuF7xMq731fuMr/LwblSpw37S8GJKpzd51xRffdCqsZ5xkQrxrSzv8e2PzxGq2jFj6ZiPxEt/VTGQ88sC4wUFewQ8h6rkZA2IbX8kJzSGQiibCiSHhbEFtd/zZgMzzlhxukS46fvMExkoQImtZj0CdMeNHui5CCEUz6zvTVJg/EZ8gzoQJk1PcmSGMoBp82CCPzGNFRciRyMw3PkPPddcSPiz2MLUCnd8GegsGMBfpfqjRPp9WPWA9tZZm9/WxrunBtpHjBJU8tYY5Nw/BPMfpEarz3+3vPzY+SyJInBoohfOOp4jjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YMi8cVew2qw4XEaSyTzC57XT0QFi8AxZQKrRtaiW1A=;
 b=QX8sTc67mCva+SkOEpwenzPB3Vsjos6REWGTRJ+pqcoa20vtbSTGj1q06TFgwETcHpQOM04dnxyVv3jxTCNYUfMYgEH2/khlvvV1xDjYO8jXSNZh+z+Bvshrri8ZaJWh0gR6AY0lgD5wJhRsL4jHAGaDxT3emV1EVGb8t/0Nx+A=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by CH0PR18MB4193.namprd18.prod.outlook.com (2603:10b6:610:bc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 05:21:30 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 05:21:30 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Haseeb Gani <hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>,
        "thaller@redhat.com"
	<thaller@redhat.com>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com" <kheib@redhat.com>,
        "egallen@redhat.com"
	<egallen@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "frank.feng@synaxg.com"
	<frank.feng@synaxg.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew
 Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        Satananda
 Burla <sburla@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v3 1/7] octeon_ep: Add checks to fix
 double free crashes.
Thread-Topic: [EXTERNAL] Re: [PATCH net v3 1/7] octeon_ep: Add checks to fix
 double free crashes.
Thread-Index: AQHbMbI9ovCa+Fu9y02Z/3B5ZFyELLKvD78AgAJ/aFA=
Date: Mon, 11 Nov 2024 05:21:30 +0000
Message-ID:
 <PH0PR18MB4734F7C5CD86F64D9074E395C7582@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20241108074543.1123036-1-srasheed@marvell.com>
 <20241108074543.1123036-2-srasheed@marvell.com>
 <bdaa8da4-aa72-43de-8b05-88ed52573a8a@linux.dev>
In-Reply-To: <bdaa8da4-aa72-43de-8b05-88ed52573a8a@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|CH0PR18MB4193:EE_
x-ms-office365-filtering-correlation-id: e7e5cc88-83b9-4518-23c2-08dd0210b300
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QmIyRUI2aFltZVBHNlVpYmN1WjJTM0ExYWp2M1NySlJzUURON0VyYU5PUjA2?=
 =?utf-8?B?cnVldE9nd05nZCt5Rk9CVFc1NCsrNWc0NW52N0tWQ21sTUUxcjV5Rko4b0FQ?=
 =?utf-8?B?QSt4Y0JRbTJOc2RWZmxTbGFySGVZaXp0QUxETXF0RU83Q2Q2YkVOWHQrcDAy?=
 =?utf-8?B?MnZQUnZ4MnhUVjdFaEJwQmVBeG1ObmlWVzJDSUlJZ0pCNWRVWWx4NE5YVlVZ?=
 =?utf-8?B?ZXRnYUV2V0NTQWVxNEhtTUVlSzYxYjFoMDh6SDMzeVhOandnQ2JjTkJGQTZj?=
 =?utf-8?B?cy8vZEVZd3A1MXdMU3dFL2Q2R0RDODVBbCs2U1JpcFpDcXJXSnI3cVlXUjdn?=
 =?utf-8?B?Q2N1RVdkZ0UyOXVLRjY3RWJvWExpdUNnMnB0VGRUSGxoZjVRajJ1SU1lS1Bx?=
 =?utf-8?B?UUYrbnFRbHFtTXhHSFhieXY2ZDBGL1dCY2ZmQWZOREJndHVrMEZjSHNJeks1?=
 =?utf-8?B?U0xPU1pxZXYvLysvN3puRmFNbHVCWkE1aEFIZDlqN1RkaGRtS1k3dWFmVHFS?=
 =?utf-8?B?OFJwY3Bnck5WRk9wbFJxTTVtTTNFTGNoN3RldkloUmNXallNcHlZekRzU0lv?=
 =?utf-8?B?NExMTUR0YkpLOGJaWEYvbVF5QnNOaVRqRnVoT3Vham1Xd3RDRm9STnVBV2pp?=
 =?utf-8?B?dVVUdHFkMWY0c3BhbkJHL1dJWlNCeG4wV1JIcEVQZEhDanlTWWRpYjdSOEdV?=
 =?utf-8?B?Vkw5L2Z1THNFVDRwNkMyenRUdThCTUEwWHlEdGNVNUdOTXBoT1VlOGZxdHg4?=
 =?utf-8?B?LzExMkEwOGVmOE5LbHpBQmw2c1ZWNm9ZeDR3R2V1SzJ3WXo4VlhMSkFWaUVn?=
 =?utf-8?B?eHA1SERFdGs2WVZ1SWcwSWtvQXR6TDRCcDd4MTk0eFFzOU5wVEFVWlN3UmNw?=
 =?utf-8?B?ODMwYzZQMU15TGNiQUg5NHMvWVltWUQrWEk1RnFEMy9iaUR0V3pHWFlJMnpq?=
 =?utf-8?B?SjRiYlpQTDlmUktKNWxhL2Jxell2cFgxczFzK0ZLMEt0OFBzWk5vaFR5UFBy?=
 =?utf-8?B?aHZvN3JsdWFWWWhjamY1NnR5dlpKZEJIUEJDUWV0VWp3RmVTd0kwQ2w2TW1K?=
 =?utf-8?B?MGNLeWhIbmh2OXVLdVlxVDRybHZDMzN3NmR2RmxzM3NqdGQzZDB4V20xaGxh?=
 =?utf-8?B?Zkk0QWJ0U0lpZ0tRTENwUTM2QmJHZERtQTBzZ2V5eHp6aXFPVzMzOWM5amxY?=
 =?utf-8?B?MmdPNzd6TktLVjd3dlYzOGVoSFE3RjhnYlVHOXkvV0hsNUxyY2EyOXIyRFF6?=
 =?utf-8?B?d2dGSHJFOXBja01ya1MrR0VVTkgyMWtSakFydTQ3dEpQQmpLamY4S0drM0dl?=
 =?utf-8?B?bEpTNU4rRG5lOG1mZzdhZm9jUDI5aklpazVzemJhVDRDQ3czNTNyYjc3UVFW?=
 =?utf-8?B?Y2dmQytwaU4yL21kN1NMTEJnNWNLV25HMmlkZEk4VnVLVXNSbjh6ak91TnFa?=
 =?utf-8?B?SkM5MXA2YzhhQ1dMcGlzOHhzTUdnQXZoTDIra1N5VU51V2NNUkV1Mjc4Q1VZ?=
 =?utf-8?B?SzF2aVBveWZFdUNRNWZGOE1MLzc4M0NZREhmdFIvNHdHeDRiSFJ1UHBWbHNN?=
 =?utf-8?B?OEJsaFpwc280c1VUN2tTVHREUEVBRjhxMHpYenlNZHNwU3U1T2x3ZWNkcTVq?=
 =?utf-8?B?MElXbEhCWGt2dEpmbEpORE96L0NJcnhnMXFaR0RrNGgrSmRpL0Q4WUpBRzJJ?=
 =?utf-8?B?TUt5dkhaVnhkam9PYkdiRkdDZVJ4Q0lCTmpoTGhJSHJFcXBVRDFOcXNWc0dq?=
 =?utf-8?B?Mld2bWp5RTdYMGdPUi8xK3F6REVJcFp5bUtmSDBmZGZNQ3hHU3RBSkIzUEtm?=
 =?utf-8?Q?TcXnz9yh13KSYx/6AtzuT9B5QNZDaZmYwsMdA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGt0clAvRlRLTUw5aFI4cFltZGVzM2xsUnZPMVBmUmZKQjc0czIrOXpwbVdW?=
 =?utf-8?B?aFZSY2F5ckY4UjkvRmZUbWZYVmRTSE9FVUl1UEoyYk1LVjBudGpialNPN0Ez?=
 =?utf-8?B?K3ZSWDQrSC9ZVzE1YkdCSStWKzFtbkMvRDhKdkx0a3dCT0VHRGxmL1VGN1A4?=
 =?utf-8?B?emJHSjRBekRGZnpXazNIOGRBTFdIb3Q1NGhwbVhpTFcrK21HQ3FDb295MTUy?=
 =?utf-8?B?ZGFGMStPOFZ0ZnZuNkJ6RXhqTE1ESnpYQmVYOFdWZGloWnhJWmxWS0xMcmhn?=
 =?utf-8?B?aGxBSjgzQ2dKYXltRW9DUzJzZk1KTWxJWWdoK29FTGFpQWIzeEhWbUJOYzR5?=
 =?utf-8?B?ZlFaRWxLTktBalF0SFR1UDNyMmowb3dETjM2dS9lNFRXTXExS29SNUFRY2pz?=
 =?utf-8?B?WXUzR1FoNkoyQ1FzL25mSDJXZVhlM1ZqbDN6TmhrMlV4VnFaaXhDL0Q5TWpj?=
 =?utf-8?B?T3JpWGk4b2NxYXZaVnczOU83T3hVTXlRanQyR01VWmxMT3BjY0thRnRIZnlx?=
 =?utf-8?B?dXdDZnNxdEMxRlFsUVFrUVJxMjQ5TjZJeFF4QlJwZVNQQmxJRElTZGVDaTBi?=
 =?utf-8?B?YzlxR3dCSTJsYzV6aHpUaElyQmxFR1pRQ2w5YTFlQ0lzbG1lME9VcUhreWxR?=
 =?utf-8?B?OFFUU0EzSGJBNU9lTkp5b0YyMWVRUVlPY3NoMHZxc0s4bU1WY256aXZncTRi?=
 =?utf-8?B?U1lhaWlrZzUrVUJiaFZ1UDFBV0lhS3BsZVdkV3NvU1hOcGp5eGxNbktYZzgx?=
 =?utf-8?B?aWdkdllHelFRZ0RKNWZLeGNwS005MEJNOEhqc082Q0ZWZ29IT1pzM2F1b2I1?=
 =?utf-8?B?SzYxdHY1bWZTbStkeFpnZDJSK3RpYzI3cjF0VXplY3lxaXNWVklyS1FCcFhp?=
 =?utf-8?B?blNqckxxT1paZnpWSlA5TGlnUjlORGU0ODkwSVNSVmtva0RBU3hFUnFSWWRV?=
 =?utf-8?B?L0JraW9hNURPYnVCVzFSM0VpOUFybG5CYmlER0VpbTFkOTdXR2E1UkYyR0JW?=
 =?utf-8?B?Z1JTNVVqUktKcUhEeHIrRW5jSGcyZHhtbTRyb3YwNk40elBJenJGOTJJR2h4?=
 =?utf-8?B?LzdYTWJFNGFQdFd5bWJmbDk0Tzd6cHJqcEtFRXZBT0dQcEF1WEFhMkV3RmJm?=
 =?utf-8?B?bzJnNlRJQWxFSnhaV2VpL0dEaW9GajdTejJqb2d4SWJFQ0VSN3ZLN1hYMW1Z?=
 =?utf-8?B?OHZVcVhRaVdpdGtTM2tYOHVLQm9iR0tkSmV2dFRsei94a0lZeXpzTE5Eb3M4?=
 =?utf-8?B?YlpFOC9pY1lFODFCcGM4elViK2h2eGE2TSt6UVQ4VFJxUGNIdWpWL1NCVFVN?=
 =?utf-8?B?YktmbXVweHVQdkxhOGxqYlh0MEVqYU5Na3oyTnFhb1p6eS90RFhVNnNyT1NM?=
 =?utf-8?B?TktJYllRRE1tZEgyaHowOVk3R3IwTlkxNFUvV2Nic0ZKVHQwY1VVb1pKWktV?=
 =?utf-8?B?VnhGNXZ4YXM4TFJoK25nNFBuOGdxOUNTWlVXWEY4L29ZTUNDc25PVmVCdnph?=
 =?utf-8?B?OW96RUJhRTFqY3dGY3V6S2RCTFJEKzFwR0dSTm1wTlhNT2tFbHE5WkhPYnFC?=
 =?utf-8?B?SUZJK1pjWWFSNVpFTEpPWWNlVWJXSitpa095QTFsbXgxWVVyVURUSWlBNkdF?=
 =?utf-8?B?U3hsV2xFTUNjVUdiUzFkU1VRYXI4RXBOaVpHd3R5L1JTeDYyc0lUd1l2NFVi?=
 =?utf-8?B?VFhQQmZXZC8wbXRKNzY2WjBOTmhWMUt1cTVSNlJhT2pWaTRIMExxeENRWmMy?=
 =?utf-8?B?eUIrdCtHeUhWZGl3aDRGYTlTWnE0VFJtbXd5ejkvWnY3MDlvQVJqUnUxRmJX?=
 =?utf-8?B?QXNJSW5ncTNHZ3dyMVNibnBVNzZqbHpGMTNlUXFVaWRyeTZVMUlJNm4yTDVz?=
 =?utf-8?B?ZW01RzJOZU9rQkwzMDl4ZUhJV0NhMkorZ3lacnlwWnJ2U1AzMUwwTjQ1VzJH?=
 =?utf-8?B?KzFDODRzbHpMZWQzaGIzaDRFSWU0YllNZkQxdTFHOUdGNURDbFpZZkl6ZVNO?=
 =?utf-8?B?RjMzWTlPV0l6UUJ4bDRaUFpSNisyN1NVczJCajNzUUR2MXJmMVl4bEROMHdq?=
 =?utf-8?B?eEJ1UHBVWEVMNDdkYk9INUNtTUVEMlB2aXJ0aStaTzZkSjl0dEIvVWtQUnp5?=
 =?utf-8?Q?Swu7JPJz6oUGnCMr4dY4zWVEi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e5cc88-83b9-4518-23c2-08dd0210b300
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 05:21:30.1873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqEOeM/4oHXHsb9rfNkC3yz3jZTciVZmYdbcRI5SK93OeK0scnO7c1izMViGN8NNFDTszFnFZI23jJAejkobqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4193
X-Proofpoint-ORIG-GUID: pc5c0Tis2pgWop1whi9Uif-MusTLJhNN
X-Proofpoint-GUID: pc5c0Tis2pgWop1whi9Uif-MusTLJhNN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

SGkgVmFkaW0sDQoNCk9uIDA4LzExLzIwMjQgMDc6NDUsIFNoaW5hcyBSYXNoZWVkIHdyb3RlOg0K
Pj4gRnJvbTogVmltbGVzaCBLdW1hciA8bWFpbHRvOnZpbWxlc2hrQG1hcnZlbGwuY29tPg0KPj4g
DQo+PiBBZGQgcmVxdWlyZWQgY2hlY2tzIHRvIGF2b2lkIGRvdWJsZSBmcmVlLiBDcmFzaGVzIHdl
cmUNCj4+IG9ic2VydmVkIGR1ZSB0byB0aGUgc2FtZSBvbiByZXNldCBzY2VuYXJpb3MNCj4+IA0K
Pj4gRml4ZXM6IDM3ZDc5ZDA1OTYwNiAoIm9jdGVvbl9lcDogYWRkIFR4L1J4IHByb2Nlc3Npbmcg
YW5kIGludGVycnVwdCBzdXBwb3J0IikNCj4+IFNpZ25lZC1vZmYtYnk6IFZpbWxlc2ggS3VtYXIg
PG1haWx0bzp2aW1sZXNoa0BtYXJ2ZWxsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFNoaW5hcyBS
YXNoZWVkIDxtYWlsdG86c3Jhc2hlZWRAbWFydmVsbC5jb20+DQo+DQo+QXMgeW91IHJlcG9zdGVk
IGluIDwyNGgsIGNvdWxkIHlvdSBwbGVhc2UgdGFrZSBhIGxvb2sgYXQgdGhlIGNvbW1lbnRzIGlu
IHYyPw0KPg0KPkZZSSwgMjRoIHJ1bGUgaW4gbmV0ZGV2Og0KPmh0dHBzOi8vdXJsZGVmZW5zZS5w
cm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fZG9jcy5rZXJuZWwub3JnX3Byb2Nlc3Nf
bWFpbnRhaW5lci0yRG5ldGRldi5odG1sJmQ9RHdJQ2FRJmM9bktqV2VjMmI2UjBtT3lQYXo3eHRm
USZyPTFPeExENHktb3hybGdRMXJqWGdXdG1MejFwbmFEakQ5NnNEcS0+Y0tVd0s0Jm09VmNZX3BC
bVl3cWd5ZEpJTGx6NDkxNmlVV05QamVwUHVCZmUzcDRjdzcxeXl6aVY3Z3ZXZ29EVjlwRVkxZ3Ex
ZyZzPXRBcm9CUFl2eURwMEhOX0hWdDFqRGlXS25Cck1leXkwYnpUcThBRWdBNjQmZT0NCj4NCj5U
aGFua3MuDQoNCkV4dHJlbWVseSBzb3JyeSBmb3IgdGhhdCwgSSBoYWQgbm90aWNlZCB0aGUgZml4
ZXMgY29tbWVudCB3YXMgbWlzc2luZyBhbmQgbWlzdGFrZW5seSB0aG91Z2h0IHRoYXQgaXQgaGFk
IGJlZW4gYSBkYXkuIFN1cmUsIEknbGwgdGFrZSBhIGxvb2sgYXQgdGhlIHYyIGNvbW1lbnRzDQoN
ClRoYW5rcyBmb3IgeW91ciB0aW1lIQ0K

