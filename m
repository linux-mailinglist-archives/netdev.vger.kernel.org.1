Return-Path: <netdev+bounces-143657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A3F9C37D1
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 06:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557F0280C36
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 05:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D5813C689;
	Mon, 11 Nov 2024 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="egeDjXED"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BA314A4CC;
	Mon, 11 Nov 2024 05:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731303014; cv=fail; b=i0hvsilr+kfYUir7RajW0g0jgprnqobFg707JNM49Gi0J/4UUyT2qchubjsQq5fsUt2eiRCv0Pi3/SAI1IDIoHjb5xhefKnRqBkgWspZ1nAHjG0MqLCJ/Fwynu1076vuTHvZRct+wdgMDEeHH4hOq52gW4EppKE4Dmidhi2N6Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731303014; c=relaxed/simple;
	bh=cmPHS7CAFTFzBEmnlLRAcikwfX2yiqP1BGkgAN5EipU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BlJfc5HRjDIYKI4K0z9Zh1SWfzokJnGRTsgNGi+o83YjdGT03JXFwbf/oieA5V7H5jnHqc1KeyjbMugRLdUZ4qCQ4HUM4SMq6Eq5PfRp94SVKylzAEfhPVXMxUF+VTVSznkIE15GzTSLQoNhPU6i5tA7Y7m6e37+mNaH2lZgSMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=egeDjXED; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB47XWi032216;
	Sun, 10 Nov 2024 21:29:57 -0800
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42uakrg3t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 21:29:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJXR95FskYiSqw89x5PO0XqJ5BXYmq8rvl+qrQkK6dJR3lLnSEIasPGDLfLK8VUBDDewNMjYUyyceX+Oov/60afOFVNveRaK5wy4z3YDhu1wmeFTXVG3rKH69nnO9QSprJOVvAWveMwJ9z88k6O+W8yUlolJKfvy7ntrjaxFrPFkOpQaFsY+5jyW2SPKcW16vIwn2B3Ku0h7Y3VO479HC48LoQWzeYHATYvXaItG1WS+PO2ALN0ZOzFoWbqUYzbRpM8DypK3PsacGK6dODi1G8u0V/61drf1Vr8CMBFEYFgUc/p+rqr2KI9SPdloEGA5aZhK3MXGd6x2dU9uCmY1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmPHS7CAFTFzBEmnlLRAcikwfX2yiqP1BGkgAN5EipU=;
 b=T4Ltlkl3vNISui30D0uGKiwALy+lMoMeZ6jUzstK+5wu5ygmvfO+eHAbFzjSIzlEagBION6vn/snzfE00/iulWkqHUDPI8+mbwiydQRen0yMr04Y8GI8iZa2pIzt36QUoUesrOCQLy05uNMxLfs4j069mIuF1SQjpU6cn7NM6YGyQK7DEJT8rUfq3QGmCMvrY2IH9AMxmOpHQ6n9eC8Cm7H417f0LUd4oBCOYGX5rOnT0cvaTAoNCTzomdqXgUahMOGUo9gxahoVxYLLStysYevXgEkTgi2y02mq1LYob3Q+DXYz+1ea4cDcq8YZlrJKCgzL6565C5F+CUj336LskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmPHS7CAFTFzBEmnlLRAcikwfX2yiqP1BGkgAN5EipU=;
 b=egeDjXED0aH0TQ+LY7r24S4zFTgYpKivyhgUaTr/W+rLExCbZeLWhPKxFOFWwZ8uPmZNdnwb2H7ev42XF/X4GGR24L8uO1LEzz6vsh2kHqzeUjloWPLhxPqqiqtNLrVhq0n6qlnYGAw9Q2yx3Z3hxLSFmqNKmx9M5w76p3Vo1Jg=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by MN2PR18MB3558.namprd18.prod.outlook.com (2603:10b6:208:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 05:29:53 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 05:29:53 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani
	<hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>,
        Vimlesh Kumar
	<vimleshk@marvell.com>,
        "thaller@redhat.com" <thaller@redhat.com>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com"
	<kheib@redhat.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        "frank.feng@synaxg.com"
	<frank.feng@synaxg.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew
 Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next] octeon_ep: add ndo ops for VFs in
 PF driver
Thread-Topic: [EXTERNAL] Re: [PATCH net-next] octeon_ep: add ndo ops for VFs
 in PF driver
Thread-Index: AQHbMQ7r6a98mFMvh0GRdt6yXROXLLKwhAYAgAEND0A=
Date: Mon, 11 Nov 2024 05:29:53 +0000
Message-ID:
 <PH0PR18MB47348854DEA380C378C5F2E0C7582@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20241107121637.1117089-1-srasheed@marvell.com>
 <20241110131846.GL4507@kernel.org>
In-Reply-To: <20241110131846.GL4507@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|MN2PR18MB3558:EE_
x-ms-office365-filtering-correlation-id: 3668a374-1f17-4454-fab0-08dd0211ded4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d3JHU2NRNFhKakE1SmhwSFRyNDFjSC9yUUhWYUNXanFiVC9KalZZTUJOUkpq?=
 =?utf-8?B?K1QveTJNc3RlSVkxOUNNUXZkNVNjcHpQc2IxUDVseUlJV1pPc2pjRjk4Y28y?=
 =?utf-8?B?WHlaTWFySGpkZkduM2ZFYkh5SUZoaDVreTBoODArVkFld0V2c2pBVjdqNmtW?=
 =?utf-8?B?d09MRDFjTEtUVWJyTGMyTnEybmNZUm5iT0JRWmpxbzgvbnFVc0hHQ216eUhZ?=
 =?utf-8?B?cWZ2S2NuMzJEZjl2a1ZJZTBoNDZ5NUNPd3V2bjNBelp4VXM5S2QyTzlSc3FW?=
 =?utf-8?B?L21GWEVjY2JGZENuQTBndTF0Z0d4UlZwNG42Wk1JQVFES1BQS1BPeG9ZQnM0?=
 =?utf-8?B?emd2UU9rek13WDg4R2pCREFRRFBEeXNvYXcwODRrOXJhdW50cFo4dDRadnpH?=
 =?utf-8?B?THFGWmJrVE1zdnVDVS9BczRSSDRRMmZtMGdZbm84U3llTHRQSnB1Q0wrZ1JT?=
 =?utf-8?B?aTV2WWkwYXZnZmZQMkJzQy9iL1JVV0tXb0lHTHdhVFp6OFZLU3JzUFRxTUpo?=
 =?utf-8?B?bTljTlNhOW45U1drSG9GOE5XVFBJK0tNRno5aGhLQTJPQWs0NkQxZVFnb3l6?=
 =?utf-8?B?OHhqTmUrU2tOU2cvbWlIU3YxRFVYQkNkb3FrSGlJZ1hrYVhrbHpxMittUjc1?=
 =?utf-8?B?YmpQYTlHbHFSNWc3cEFNS0UyRnZiTE85T0xELys5UDlCYkN5WTFrVm9TcXhq?=
 =?utf-8?B?ejVsWnREMlYzQ0JacC9qUGlWMFhENy9NaERzNHRSWERLb0dXRGxPZy8wZVlY?=
 =?utf-8?B?UFRuOUxFZTA1TGhYd1Y5QUlQWlZoT3hoODJhNWJOSmlWeURPQTJLY0EzZXFQ?=
 =?utf-8?B?b29pRVJJWktLekV1WTlCVVZZZ1JzcFZWY1pPYWNaeS9PNzlBcTlmMlZOYlJP?=
 =?utf-8?B?M01PcUhjSmpQV015REs3NkI3eElLaE9kaUp3Wk1ycll5OUxtZ1hkVzBuVWg4?=
 =?utf-8?B?WThyZzRTVElMOCt1UUkxSU1hSjh2UGFneG1kN1NWc1ZmT1plQU84OUJsWTRk?=
 =?utf-8?B?S1VBRGZGSG5vZEkwUGhkbGU1QU5yTlBndjVISmxzV1RURUx0QlFSa2NiNm9S?=
 =?utf-8?B?SStMM3FLZ0djSmY5cnk2cUhJSEJqUE54a1FrVEZhYzFVdDc0MU1ZcXBSTTFW?=
 =?utf-8?B?TmhpT1JvUExVa3ZUb2ptQjhIeWtVNWJydFpReWlmT1BIemNqT0VzaEh2M2ZZ?=
 =?utf-8?B?TC9qM1NZN2tBcFdienlLVitLM1B6L2NhZGhRVlBiUGZZTndPcG9aU1dESFJE?=
 =?utf-8?B?TkQ5U1paZlQveXNsQk9CanZ0dGpPbkIvTVYrQm1HY2x1SmJFaUpwMHA4V0VF?=
 =?utf-8?B?V1BQcmI2MWtqZlRib254amxyNUNodmx6YlcyTEJ0TGp2TEdGV2ptR0tZZTFt?=
 =?utf-8?B?SUZoWDNLeG5HeHcreHp4OWl0RHFTem9MSjlJc0xqbkJTOGVnKzE1VWdoTlp6?=
 =?utf-8?B?V3FpYytHRFhFYXMxZytIeEsvYnRBdWZxTU4walA4alZFTStzMWY2Qk9sT0Rv?=
 =?utf-8?B?dnVXQ1ZHVFpUTms4dGlHTHVBZmFwYXFlUHBkSXJURnZic3h1bmErbGdOcEQr?=
 =?utf-8?B?dkZDU3Y3NDdkdWtQQnBicXcraDBEY3FWK3VzZEllSkM1a3Z4aGVwVXpYckJS?=
 =?utf-8?B?OU1rZHROajBpaXB0cXB3WGtOYUxxTE1DN0NOcmNtaXB3RkQ0L0syejdZK1pM?=
 =?utf-8?B?RU9jTDlORkhLMG1UWFNUVlBWeEVlMnkvdi95NTE1M1F2SEo3dEhxUXFMVHBT?=
 =?utf-8?B?S0NHRGtlNW9RNmxUMmFaNkkwSHVKelU4dWNBcTREcEpUYXYrZHh2M1V2OGF3?=
 =?utf-8?Q?9p1tyZYlqx72aBQ2qzRfStlkJrksZemk9vevs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGdnOG5qUXBpWWkvOG5DeXJBWWJtNTQ2ZTExVlREVjJhdGFtbG16YWdUK2RY?=
 =?utf-8?B?dDM2SUxtVUx0a0ZqUWI2aVNUVnkxMFZrZzFNOFVuZ3VpNzZCTmZLS0s5RFdJ?=
 =?utf-8?B?ZW9WMG4yTkhNQ1VvSmpBT0FMMVpER0lpYnlJVGVCUVB2TzhYeCtVckVJNlpU?=
 =?utf-8?B?aHFDaEpITFFKazIxODFqbW9SMVV0TlZiazFDdnZPVGQ3Mm8vMElDZEJLUmZy?=
 =?utf-8?B?K0FaSzY2am5FZW5KU2ROcTZhblJPazhNV0toMXZoOWxFZ2hneTB5VzB2aW8v?=
 =?utf-8?B?VDhRcEZiV25LT3Z0TS9pbTVBb1ppOWVFT011TFNXcWt2Zk1TTzNjUXlzaWZt?=
 =?utf-8?B?UzRFTTQzKzR5L0pkRTdUYks0cDB1bmpETDZCMjlSUWZ3SlJmdFlxQWFGMHBB?=
 =?utf-8?B?UDlGRXZ5cUdsS0ZQSGZkcHVmWDBVeWQwSFJUKzlnQk1aWGxuMEl4RktxdnF5?=
 =?utf-8?B?MU5Na01WK3Q3MVVlTGJpZUJDZWRVTnFvTG9iaDF4VVpjdDhqekdyQ21PL0Zu?=
 =?utf-8?B?K0RkK2R4WWlmTFd5UjNZa0JxR1V2SE4vUzYweFdaVnpCTTBrS042blpQbUtT?=
 =?utf-8?B?NkZ5UWRXc0p3cnZRQWVCOCtXNkdGbXlkc2RYZ3RwRnp0azdDREliUTZibExF?=
 =?utf-8?B?UEp4cW9iVTZpODZKSVZ0NXBXRlNxRUFlQndXeEs5d04wM1QxOGdIN0I5Yzk3?=
 =?utf-8?B?OFptYUVaNVJIRmlPVEp3WS8vRWJGNzJoS005VEVraGtFN1A2U3g0Rmd1VGl1?=
 =?utf-8?B?N1ZpQUJhZ2JlZ0Yyem95ZUlpalc2WlNtdmpNVU9qSWJzREVyTTQ1djg5ait4?=
 =?utf-8?B?ZjQzRGdtd2xsNkdDdzJndmE1SmJ6WjhxY2lLLzBGSWhvaFJmSWt0NkU2blg0?=
 =?utf-8?B?VFBNV2FvMzFIU2twNVhveXVCckxmVEF3TFdTbllwWFdpV1BzUXBXVWExNjNL?=
 =?utf-8?B?UGVzbUZLeVlPTCt1QzRETFUrUGhYTVBqb3pMMXhkbHJRME9GZFBWWjYyci96?=
 =?utf-8?B?V01TTFRhRkU0QjJLY281QlNQbnoxU29UVGMwTkgwbCsxeVc3QU1VQ3RQQ0tk?=
 =?utf-8?B?LzY0VEROc0o1U3c5SWFLMkM1OWdTd21MK1hzUmMzcUU1TnR2ZnlEYncvWllF?=
 =?utf-8?B?Y0JWb1R0dHUwM1p6UnRNdkI4RnVwUzRJOHVMYk41c3Fpekp4M2xTdllYVHdn?=
 =?utf-8?B?Vno4N3BTZW9sekRINytibk8wUTBIcENZV1dvYm5tRFM3NjIybGJYTGdORGIr?=
 =?utf-8?B?a2RSUGNnTXROV0ZpOWQ1MWs3YzI5SkVEWm9tYWU1Sms4U3lLRUlKUmw4SEVE?=
 =?utf-8?B?RmpGazNtQkhoUlY1WFBDa2xETmNFeThOUjdNbkptc0p5bVpqMlY0eXNEN0Z5?=
 =?utf-8?B?d2tUb1hkMFVRMTRiVDBlRVVXMEZmZVlIdngvVG4vSG5jU2I0bU8zcWpjTWov?=
 =?utf-8?B?RU1EUE1rRkxwekU4RXZTTWU0Z2p6ZmV1RUwzbC9VWlRlTXExOVRkbXJrT1Bx?=
 =?utf-8?B?bkY1THRFYXBlTDJnQ0pueXNTSVFENDZtRUtiaE9ZUXF5YzBNT1JFNHBtaCtP?=
 =?utf-8?B?RDBlVW9vY0ZJRnZIYXdpOHNDc2F0bExrT09xeGRkang4RHlQYU9ib0VGN3Fa?=
 =?utf-8?B?UHA5Rkc3ekRaUldDMzhkeWltZzM5R0ZuNUpRM0FmV2NBQ3pjdTQ1VnlRVzVB?=
 =?utf-8?B?ZW9SMWpzM1A2QUN1MnhMV1RMRWhpRGJWeVcyaUEzSFBKcTVlS3U4ZGtNZzdM?=
 =?utf-8?B?UXJjbm1UUVFuV2IyVklIb3hsYmR6K2RWM3poQllsd2hVR2E5TVpNUys4eHlV?=
 =?utf-8?B?bitwUWVHTUE0WlV3bnVIdFdXcUNRK3VQYjNHbzRNTWl2bUhXckZHRU5NQlVa?=
 =?utf-8?B?UDFVMGR4anBmRFU5U1JNcHA1M0xtcXVMcVJJcHNWbDBWZlpEM3IzdlpaeHRZ?=
 =?utf-8?B?STQvWnREakprN0toaHMzYjdyc01HdEpIOHBsQWlpUUJUdWJmdHhIY2FIY0lr?=
 =?utf-8?B?OVJtRlI5VU5kOFhtSGVnVHpFQ3d6dlFNWlEvWlUzZnhHYlNqWWxoaVdUTGFR?=
 =?utf-8?B?aFc1TUE0R2wwSTg5TGF3UXdDZUZWeU5BWXBXdHl2eFZpTzJyb1N3RFpLY1ls?=
 =?utf-8?Q?tE/aKqN1vQKvgBduPb5Qx9kSO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3668a374-1f17-4454-fab0-08dd0211ded4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 05:29:53.2622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TvWX42s9NN2PlrDBaCEjuhlvxuIxDvYu/snMy4oFzcXQexKPwB/IN4yivXe8aRuqW0AWcUNXz5m/BHpRGsMAHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3558
X-Proofpoint-ORIG-GUID: uigkttJzk7gvUNm8HwRWa-o9U5KUHfsN
X-Proofpoint-GUID: uigkttJzk7gvUNm8HwRWa-o9U5KUHfsN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

SGkgU2ltb24sDQoNCk9uIFRodSwgTm92IDA3LCAyMDI0IGF0IDA0OjE2OjM3QU0gLTA4MDAsIFNo
aW5hcyBSYXNoZWVkIHdyb3RlOg0KPj4gVGhlc2UgQVBJcyBhcmUgbmVlZGVkIHRvIHN1cHBvcnQg
YXBwbGljYWl0b25zIHRoYXQgdXNlIG5ldGxpbmsgdG8gZ2V0IFZGDQo+PiBpbmZvcm1hdGlvbiBm
cm9tIGEgUEYgZHJpdmVyLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBTaGluYXMgUmFzaGVlZCA8
bWFpbHRvOnNyYXNoZWVkQG1hcnZlbGwuY29tPg0KPg0KPi4uLg0KPg0KPj4gK3N0YXRpYyBpbnQg
b2N0ZXBfc2V0X3ZmX3ZsYW4oc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgaW50IHZmLCB1MTYgdmxh
biwgdTggcW9zLCBfX2JlMTYgdmxhbl9wcm90bykNCj4+ICt7DQo+PiArCXN0cnVjdCBvY3RlcF9k
ZXZpY2UgKm9jdCA9IG5ldGRldl9wcml2KGRldik7DQo+PiArDQo+PiArCWRldl9lcnIoJm9jdC0+
cGRldi0+ZGV2LCAiU2V0dGluZyBWRiBWTEFOIG5vdCBzdXBwb3J0ZWRcbiIpOz4NCj4+ICsJcmV0
dXJuIDA7DQo+PiArfQ0KPg0KPkhpIFNoaW5hcywNCj4NCj5HaXZlbiB0aGF0IHRoZSBvcGVyYXRp
b24gaXMgbm90IHN1cHBvcnRlZCBJIHRoaW5rIGl0IHdvdWxkDQo+YmUgbW9yZSBhcHByb3ByaWF0
ZSB0byByZXR1cm4gLUVPUE5PVFNVUFAuIEFuZCBtb3Jlb3ZlciwgZ2l2ZW4NCj50aGF0IHRoaXMg
aXMgYSBub29wLCBJIHRoaW5rIGl0IHdvdWxkIGJlIHlldCBtb3JlIGFwcHJvcHJpYXRlDQo+bm90
IHRvIGltcGxlbWVudCBpdCBhdCBhbGwgYW5kIGxldCB0aGUgY29yZSB0cmVhdCBpdCBhcyBub3Qg
c3VwcG9ydGVkLg0KPg0KPkxpa2V3aXNlIGZvciBvdGhlciBORE9zIGltcGxlbWVudGVkIGFzIG5v
b3BzIGluIHRoaXMgcGF0Y2guDQo+DQo+Li4uDQoNCkkgdGhpbmsgdGhlIHByb2JsZW0gd2FzIGZv
ciBzb21lIHVzZXJzcGFjZSBwcm9ncmFtcyBhbmQgb3BlcmF0b3JzLCBzb21ldGltZXMgcmV0dXJu
aW5nIC1FT1BOT1RTVVBQIGlzIGEgbm8tZ28uIEkgdGhpbmsgdGhlIGlkZWEgd2FzIGF0IGxlYXN0
IGlmIHRoZSB1c2VyIHNhdyB0aGVzZSBtZXNzYWdlcywgdGhleSB3b3VsZCBrbm93IHRvDQpzZXQg
aXQgaW4gc29tZSBvdGhlciB3YXksIGFuZCBhbHNvIG5vdCBoYXZlIHRoZSBvcGVyYXRvciBzdG9w
IGp1c3QgYmVjYXVzZSBzZXR0aW5nIHRoZXNlIHZhbHVlcyBmYWlsZWQuIFRob3VnaCBJIHVuZGVy
c3RhbmQgdGhhdOKAmXMgY291bnRlci1pbnR1aXRpdmUsIGJ1dCBzb21ldGltZXMgaXQgbGV0cyBv
cGVyYXRvcnMgd29yayBhbmQgZ28gYWhlYWQuIFdoYXQgZG8geW91IHRoaW5rIHNvPw0KDQpUaGFu
a3MgZm9yIHRoZSBjb21tZW50cyENCg==

