Return-Path: <netdev+bounces-144086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8CF9C588C
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C5A1F23463
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2471132103;
	Tue, 12 Nov 2024 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="V/TZbEtq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE75433D9;
	Tue, 12 Nov 2024 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416676; cv=fail; b=eunAN2nrdy86/RbWbQaU68yQJcZCD3cegmJxAX6ZjwB6qioUoR2tAlFWyWW3hjtAv6m6KxLtuj2Z39jB6gHFoocW4kmf165gT4ngXZ8fHA81cxv9auZgjStmAMtPvAloR4iTLKKqF5SL6xPzMm9GXiFB178rv43Dt+y61+GcHMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416676; c=relaxed/simple;
	bh=1MOa5ThBcBoM5mdmgIARMdHXNibCr9zxGhUH2CGvG+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WsvMfq+mdH5/NzgSlOjfnWl+0JFi1nlXzDlp8/gfgj7UKhf0AD7p0a9PwoA/v1++fcgvxboFHqR5dps31OmEfKe661QZNG0L69ZH7HFy5lE/MR/HKEm4gQo2ldQB7oioxO0+O0tpMkrF2h70/j2PihyXaUihxi581I2MqEQPDGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=V/TZbEtq; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC4mC0r020863;
	Tue, 12 Nov 2024 05:04:02 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42t84pn45v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 05:03:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0G9FRk/p5cW4eGponM1PO3I7Kueaz8ZwOZGQRiC/vqNKfmZFlReaHb9zUrdUXfFHsfJe0yzbGa2tpieqqwLbomR4SDbS31AjRNHaW5rNDiR6QRfXwfVrimS/4W+HuUJ3cttVI6ss6DvrWuASyLsAu3tDCeD3EU3PazqbQepZUQL6zHCKnFozpCIt2AhNBHAcjM2oRRJtidl+Teh1FpKzNCCoTKjFsB9nweNDy05t/gCDRXn+1kDCRxBubliJ0dlY5Jc8LwgwNH+D4K+3Y0qvKk1vAE+C0jIMKcUNY+5uCAseJzv8bpEfGciPn3bv4OyUoPOjDpgVvYcbHCCGfN8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MOa5ThBcBoM5mdmgIARMdHXNibCr9zxGhUH2CGvG+k=;
 b=lHl/GLno+J04sr42+hfZpSgAiBFxz+w69K8ZO4kP2mrx9fqeyPM51JcubLSrCmYweY/viz+jiW+czIOwwqqm5w2/9aNo+OTNhedxqW81FOxRPUkbGgfDkjhXKfkyDUAnn4Q2p7Kly5fC+clmx3UhkJ46LDf07+OSGj6KJz8iY+Suk4ksM0288yGK0Bvywl9ZZgZIwAbfAmMeaNw1DQbMvmYuQvplk/huJH55wasJEaJyjZq5VYeVox3RUJ3ozUWzt75mnv24afHnjolS6i0080XYB1IBTEPfNoSbYWBWF5stIEb1cnXJR0EGEoHk6/mZwozRFCcELen2njz9QOYEEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MOa5ThBcBoM5mdmgIARMdHXNibCr9zxGhUH2CGvG+k=;
 b=V/TZbEtq9aFWTD5pZFwpSfVIy/xFfwTjrVptqWUQhHbGamQmouEkc+xJSBV4QTzKHnTZKpwaXUlWYHmfOE1YX1uO8aHO5soPIpsltO3EEjYhzwRZO66k48Y7vxCVNK8PjuFjSkV/5XXZoiUWVsobX4hXA+461uiaFEeOBEXB/Qc=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by BY1PR18MB5328.namprd18.prod.outlook.com (2603:10b6:a03:526::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 13:03:49 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd%3]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 13:03:49 +0000
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
Thread-Index: AQHbMbI9ovCa+Fu9y02Z/3B5ZFyELLKvD78AgAJ/aFCAAZ4GwA==
Date: Tue, 12 Nov 2024 13:03:48 +0000
Message-ID:
 <PH0PR18MB473440FBC843E4A88229A38CC7592@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20241108074543.1123036-1-srasheed@marvell.com>
 <20241108074543.1123036-2-srasheed@marvell.com>
 <bdaa8da4-aa72-43de-8b05-88ed52573a8a@linux.dev>
 <PH0PR18MB4734F7C5CD86F64D9074E395C7582@PH0PR18MB4734.namprd18.prod.outlook.com>
In-Reply-To:
 <PH0PR18MB4734F7C5CD86F64D9074E395C7582@PH0PR18MB4734.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|BY1PR18MB5328:EE_
x-ms-office365-filtering-correlation-id: 498b3334-dd8d-47f4-fc57-08dd031a72f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T3Ivd0pDczhyc2ZGbXZqWEVTVTU4eFFYUm55WnNXaW1LYlBXTUp1QzNhNXc1?=
 =?utf-8?B?QUxucXp1WjY4M3ZVU3NFVjJDRkNJZForYkhqZUkzVU4wWXF0SXRRVG92U1R3?=
 =?utf-8?B?VkR3Wk5TZlVvdGV6dnJ3dWRJRWFMSnRBNENVazNzb1gyK0lUMERucUt6bC9W?=
 =?utf-8?B?QzI2a0tLd3pnY3R3aG40TkFYYi9VVDhEeUtRUlc4bnRjbXVjSDUvRHBaeVNC?=
 =?utf-8?B?RGpYZUhxb25wRmtXamhuTkprM0ZmbDR1U3Z3NklIWXIreUlEcU9keFY2QWs0?=
 =?utf-8?B?VFJnb2tPYlNqTWgwbUF1UUVZdlNYVkc0ZW1WMGlYR2lvWHJ1azIvRmxKMXdV?=
 =?utf-8?B?NHBqbmpFbURhR1R5LzRmRXBhb3lTdWFsZmRLMHRnaHVTSUZ1Y1JZOGV2YUVp?=
 =?utf-8?B?eGJPdy9tQXRCWjg3WHlrQS9wM2s4aStXQmttNHNkM1hPZGM1a202U3ZuUC9p?=
 =?utf-8?B?MllFcVJSMnRYUjFZM3hpWVVITk5Id1FlNTJaSVJtZHBuZUV0b1p2ODRJZ204?=
 =?utf-8?B?UWVFNWpLWnRpRi9id1JkSnptUUFkYVRGNmM4U2JkaW9PY2JCVXBZbWxQSjRN?=
 =?utf-8?B?bXhTZU9mWnJibDloNHljMFdDVWtjODJMQ1pGN0VWVXJBUXIrSHI0MUx0ZzFH?=
 =?utf-8?B?WVIvTGYxbktkVjNMdU1RNEJwVVZIc0pZSUE1MWs3d0J5LzB1cEQ2d3FPQ0tI?=
 =?utf-8?B?bk5DWk00YzJtRmdFZjBsY3hyVUxFYWNpbnlwVTFIZStxL3o0dHJaaVdaNTlT?=
 =?utf-8?B?SFhLb1JYYXFxeEx4MkRMVTZxakJXUXk1UHBTQTlZVXlMeTdXTThBSXRPUDRq?=
 =?utf-8?B?Sy81T1hFUU9UTVJBWlh2TkhodS83TzJwckp2SUgrQnVXenlaMm9sWllGZ0RC?=
 =?utf-8?B?aGZ2UE1FaVVLdG5keGQvT0piZENKaWt1VmtYbnA2dDByanZsbThObmkwUjFa?=
 =?utf-8?B?VmdVVHlLYjltOThaR25aVmUzNVd3elZHTElsc1dJNEc5UExNQndhVklkd2FV?=
 =?utf-8?B?dTlka0lLV3FSQk5yNVU3RW1KRFlVbkxwajVsQXZ1ZytMVEVoTk0zanhnZjBB?=
 =?utf-8?B?aG9qVzlmSEp3bmpQQTdOTzJQc2lreXhKL0YxWnVOVmRYbkZIZGE1ajBMbWJH?=
 =?utf-8?B?RVBaTXJiNFI5ZGFtVHpZYWR1OS93L0pURk40Z0tOaFJCUW5sNmQzZTI0UExq?=
 =?utf-8?B?SGVZcGpCRTRIdjR4Znp6dkdpdVE5RWQwV1VVT1FpS1RaaFEyUmdkZWhzSm1w?=
 =?utf-8?B?YXNuMzZLTmpXcVVQWlJGN2w1b24yWHhsL2crTHFKTjZtaTFpVjBpdHFlZm9D?=
 =?utf-8?B?RGZmZjZKWlpVSXg2UkNEOGZLT3pCWjJSWDd3dnBzYWgrQ1g3NGRoZnVtVUl5?=
 =?utf-8?B?UkU0SzRoZ2E4em1RN1plWUtZcC9ZR1A1QW1QemVtQTRYaWR5VXdIZWw3Zi9p?=
 =?utf-8?B?ZTQvckFDMXlSQ2xBZ3hCcFFGVGMvWHVlekI3TDlScTk3WHhvTVpTa0xVU29t?=
 =?utf-8?B?RXk1SSs0VUJuYjA4anY1aDltTCtMTGNoaTJZTFZjWnl1Z2NGYnVJTnpYNU1i?=
 =?utf-8?B?akp2NmdXSWp0bzZXY2k5VFJwaUhyYTdYNWRaOHN6aUUvSGE5U29KSGhLY2pE?=
 =?utf-8?B?MWNjMlh6eW1KalhrNGZKb3k5QXFJckYxZmJLQ0FzQkhqSUh3eWpudGdjekFH?=
 =?utf-8?B?ZjRYNkZXaTYrMGNPVDRPY0JJUjJ2UmhaL3VTcG5OZjJYR2FEcStLYTd1NWh5?=
 =?utf-8?B?ZFZYR2V6MTBaTUtHaTVXQ3Y0d2F2MzU0VS9LTklNTWhPMnRyalBOV3BUdnA0?=
 =?utf-8?B?VUxvOFh5RFpIdTA0ZnF0eE1BSk5GL3dMQW1nQUlDanZZS2Z4NlJPRGF5UGlF?=
 =?utf-8?Q?L5/JXaoMuIk/O?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlZld2FjVEVzSmJidWQ4TWlqa1NGRWliN29TaTl0MWh3TzJKcnVKd3hYdVJB?=
 =?utf-8?B?b1NrL2d4TSt0WGV3c2lYNWdwN3J5Yk8xRzBmeXgyS1g2enlzN282eURJdXp2?=
 =?utf-8?B?dHd6VXU1T1dNZ1g1N0tqRS94bURNbnkwVkQ1OVR6cWF2SHR2Y3VmK2NnVTFH?=
 =?utf-8?B?NXh3RVNOQWhMdHZhQVJhZFdoa2owNkVleEVOc2kvUldPNlRWQldoUXNTdUVG?=
 =?utf-8?B?SWEzSHdoUzk0MG44VXN4eGFQZjZhSU91Z0paWmNaSElXQlJ6WnZmZVk2UDBP?=
 =?utf-8?B?ZGRNUkp6bzl0aXExTXoxaW03U3VQbjJIcW1lN3k1TmNYcTV4clhnSW04US9k?=
 =?utf-8?B?MGhEZURBYkdyYUZEOFBtcU9ISHVubkZiMEdTUHZqejA0N3IzVjAva29FNVZH?=
 =?utf-8?B?Y2FUWVVDTW8rWlZQUk56alNwZzl2YUpIOE1KNk1FU3VwZmtxb2VTNlBvZSts?=
 =?utf-8?B?VE93SXhnZUEvQ3ZkMitkUng0WitHUElmZ2h6VURVYUY2Q1BKTDlVZ1Z1LytW?=
 =?utf-8?B?WlUyM0ZMK3cvcGhVM3ZDUXBwR25qSjQ5MUtmYS82NXA1M2M5MzE4dmZPRkpu?=
 =?utf-8?B?NjVXd2d5WUV0dnFqVUZMenNJWGtrN2I3WkNGU011UEFja0xuWUsvYU9QTERw?=
 =?utf-8?B?VWh2L1p2b3FTUG02eTIvNDNnNnUzWWlNL2pCdjREUzRjOXduaGNNcThaTVVY?=
 =?utf-8?B?TjJFZ3VtWU1ORHBoMk5uRE4wYzQ0MUZiclRpeFJoNDBaN1F2Ti81M0lyb05Q?=
 =?utf-8?B?VnIxSzlmQVlMTmRQRm1OSzRFME5pRTZGQTI2cXRGYmU1cnhDd091OURrUU9T?=
 =?utf-8?B?R2FwV0I3T2ZrKy9zWEd3ZXhkanp5Qkx6ZCsyQVpzanRQNVZTS0FxRGM1R3Ix?=
 =?utf-8?B?UU5ESkxCUUdwYTN6OFFVNzJxQ1FTazA1L015Y1NFT3BnVDc4VzUxRGdZclFw?=
 =?utf-8?B?d0x6Y2JmRVFqVHRBYk9sUGJRY0lYSEFHSEJFVUd5RjlFa3U5QVRtMDVJbC9M?=
 =?utf-8?B?Wm83QWY0WEEzZURrS2YveXlvaFZvTjc5S0Exa3U4V2p0ZG1iZzhhMlQyWTJy?=
 =?utf-8?B?UlB0aWtGT2RKSytncTNraTQ5SE1PRXNEZS9vNEo0ZFZpWGU2NDBJbE5kWnFR?=
 =?utf-8?B?bi92Yk9BSlJnbWRydEs0cEVaWjRoN3kxaWlSWEJ6bWRNTHFWcEwyQlFIVnlp?=
 =?utf-8?B?NlJJbUQrdUlIUWxrSUpBVllYVlVFbWswRXZqK0RieEFYS3JFQktjT3cvUklO?=
 =?utf-8?B?OVlLTnlhRGk1RTA1alFQdFVwNFdQVGtWSkdWSXZaSG50ejBRM001aWNLajl0?=
 =?utf-8?B?TVVWOVpkVmdkOHFoYUwyQmZVOXBhSEdTUzdIUFZGa2FZUWx0L1ZWY0hTczJt?=
 =?utf-8?B?TmdmdkQrTjlBQWZpb3h0YUlvU0RXWmtkT2xEdUhLQWpHMUpwZXRmenRFRVcw?=
 =?utf-8?B?MGlpWmUrUkd1bVp5MW5ndXBQTDVBUld5UElVb1IrWFRYVHpNMW1NTW5IbEJy?=
 =?utf-8?B?RG5vdlhXM0pIbGdTd1RMT0JNYyswWHBPT0x4MSt1a3lWQVhPREZ4VWRoN29I?=
 =?utf-8?B?SlF1clpWUXpWVnVNQTU0RUxQUElGMmxxeWZ3NzJDZkNYSGdic3FESDhXdjlK?=
 =?utf-8?B?UXhEOCtPVlRWcWxXRnpZTmNJdExhL0drTUk2RC9OVUpZcGVZUWQ1VWZNK0pr?=
 =?utf-8?B?R3hBYU1uNVVWK0huMmZmbWttZk1iVkgvVFZsNzFZdjE1WFhYdS9zUzEzaHhM?=
 =?utf-8?B?RTRlMFVIUmljVHczRDQyRzFyYXRSOGlyUkNRMXVYVWtDRG0vWm5BaWsrWEQ0?=
 =?utf-8?B?ZEkrZ3pObUV4Z004ZWdQdnhNd2w4NlRpYUJQdE1mYVhuSWdBMWI3QWtERUFV?=
 =?utf-8?B?YVRlUnVNdnJCVlIrNDBvRDRtNGdQUzBKYndUaS9MMGZSNGlCZkEyNTE0WUtp?=
 =?utf-8?B?ZFBRc1RydzNSMjlNelkxcmNwMkdoU0x5bG8zOVZCWS8zVkZHdkRzMS9nOWY3?=
 =?utf-8?B?bHhFbzVYZVpvNGNLZ2hzeGNlZlFleWZ1TXJVdlVaL284ZUdkZHptUEFyKzBh?=
 =?utf-8?B?VXhWUkVmazExMjA4WnNyR2VUVGd6NGxYOFU5RU5ZZlJOalpBYytkQzgyeEFw?=
 =?utf-8?Q?Bh+jg5X57CdmoggJ3nMWk4/aK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 498b3334-dd8d-47f4-fc57-08dd031a72f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 13:03:48.8967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AARoZ/jJZm5Q4mFgOAT8XWrOnmLiEMTF8B8kdjdlU2Pza2yXHumrb5jBtmG85QLIRvw4rCqRzf2Sb6ss1Sheew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5328
X-Proofpoint-ORIG-GUID: T2Qa12UswqbQbgdhhGHmmb7vTH5Ywh4W
X-Proofpoint-GUID: T2Qa12UswqbQbgdhhGHmmb7vTH5Ywh4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

SGkgVmFkaW0sDQoNClJlcGx5aW5nIHRvIHRoZSBWMiBwYXRjaCBjb21tZW50czoNCg0KT24gMDcv
MTEvMjAyNCAxMzoyOCwgU2hpbmFzIFJhc2hlZWQgd3JvdGU6DQo+PiBGcm9tOiBWaW1sZXNoIEt1
bWFyIDx2aW1sZXNoa0BtYXJ2ZWxsLmNvbT4NCj4+IA0KPj4gQWRkIHJlcXVpcmVkIGNoZWNrcyB0
byBhdm9pZCBkb3VibGUgZnJlZS4gQ3Jhc2hlcyB3ZXJlDQo+PiBvYnNlcnZlZCBkdWUgdG8gdGhl
IHNhbWUgb24gcmVzZXQgc2NlbmFyaW9zDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IFZpbWxlc2gg
S3VtYXIgPHZpbWxlc2hrQG1hcnZlbGwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogU2hpbmFzIFJh
c2hlZWQgPHNyYXNoZWVkQG1hcnZlbGwuY29tPg0KPj4gLS0tDQo+PiBWMjoNCj4+ICAgIC0gTm8g
Y2hhbmdlcw0KPj4gDQo+PiBWMTogaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3Yy
L3VybD91PWh0dHBzLTNBX19sb3JlLmtlcm5lbC5vcmdfYWxsXzIwMjQxMTAxMTAzNDE2LjEwNjQ5
MzAtMkQyLTJEc3Jhc2hlZWQtNDBtYXJ2ZWxsLmNvbV8mZD1Ed0lDYVEmYz1uS2pXZWMyYjZSMG1P
eVBhejd4dGZRJnI9MU94TEQ0eS1veHJsZ1ExcmpYZ1d0bUx6MXBuYURqRDk2c0RxLWNLVXdLNCZt
PXFjS2RJTTF6c2JCRDRURkFzYTE5eUp6S05rVGxGTHJEZk00ZmZTbFRpdFNXRWxxWnFnZEZxb2RB
TGNMODNpV0Imcz1NX2twSkI3TEw3SnFJQmstTUJYb25DeWZfQldnM2Zjd0h1TWM4RlFwdW4wJmU9
DQo+PiANCj4+ICAgLi4uL2V0aGVybmV0L21hcnZlbGwvb2N0ZW9uX2VwL29jdGVwX21haW4uYyAg
IHwgMzkgKysrKysrKysrKystLS0tLS0tLQ0KPj4gICAuLi4vbmV0L2V0aGVybmV0L21hcnZlbGwv
b2N0ZW9uX2VwL29jdGVwX3R4LmMgfCAgMiArDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5z
ZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9tYWluLmMgYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9tYWluLmMNCj4+IGluZGV4IDU0OTQz
NmVmYzIwNC4uZmY3MmI3OTZiZDI1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWFydmVsbC9vY3Rlb25fZXAvb2N0ZXBfbWFpbi5jDQo+PiArKysgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9tYXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9tYWluLmMNCj4+QEAgLTE1NCw5ICsxNTQs
MTEgQEAgc3RhdGljIGludCBvY3RlcF9lbmFibGVfbXNpeF9yYW5nZShzdHJ1Y3Qgb2N0ZXBfZGV2
aWNlICpvY3QpDQo+PiAgKi8NCj4+ICAgc3RhdGljIHZvaWQgb2N0ZXBfZGlzYWJsZV9tc2l4KHN0
cnVjdCBvY3RlcF9kZXZpY2UgKm9jdCkNCj4+ICAgew0KPj4gLQlwY2lfZGlzYWJsZV9tc2l4KG9j
dC0+cGRldik7DQo+PiAtCWtmcmVlKG9jdC0+bXNpeF9lbnRyaWVzKTsNCj4+IC0Jb2N0LT5tc2l4
X2VudHJpZXMgPSBOVUxMOw0KPj4gKwlpZiAob2N0LT5tc2l4X2VudHJpZXMpIHsNCj4+ICsJCXBj
aV9kaXNhYmxlX21zaXgob2N0LT5wZGV2KTsNCj4+ICsJCWtmcmVlKG9jdC0+bXNpeF9lbnRyaWVz
KTsNCj4+ICsJCW9jdC0+bXNpeF9lbnRyaWVzID0gTlVMTDsNCj4+ICsJfQ0KPj4gICAJZGV2X2lu
Zm8oJm9jdC0+cGRldi0+ZGV2LCAiRGlzYWJsZWQgTVNJLVhcbiIpOw0KPg0KPkhvdyBjYW4gdGhp
cyBmdW5jdGlvbiBjcmFzaD8gcGNpX2Rpc2FibGVfbXNpeCgpIHdpbGwgaGF2ZSBjaGVja3MgZm9y
DQo+YWxyZWFkeSBkaXNhYmxlZCBtc2l4LCBrZnJlZSBjYW4gcHJvcGVybHkgZGVhbCB3aXRoIE5V
TEwgcG9pbnRlci4NCj5EbyB5b3UgaGF2ZSBzdGFjayB0cmFjZSBvZiB0aGUgY3Jhc2ggaGVyZT8N
Cj4NCg0KSSB0aGluayB5b3UncmUgcmlnaHQuIFRoaXMgd29uJ3QgcGVyaGFwcyBiZSB0aGUgYWN0
dWFsIHBhcnQgb2YgdGhlIGNvZGUgImZpeGluZyINCnRoZSBjcmFzaCwgYW5kIG1pZ2h0IGp1c3Qg
YXMgYSBwcm90ZWN0aW9uLiBJIHNoYWxsIHJlbW92ZSB0aGlzLg0KDQo+PiAgfQ0KPj4gICANCj4+
IEBAIC00OTYsMTYgKzQ5OCwxOCBAQCBzdGF0aWMgdm9pZCBvY3RlcF9mcmVlX2lycXMoc3RydWN0
IG9jdGVwX2RldmljZSAqb2N0KQ0KPj4gIHsNCj4+ICAgCWludCBpOw0KPj4gICANCj4+IC0JLyog
Rmlyc3QgZmV3IE1TSS1YIGludGVycnVwdHMgYXJlIG5vbiBxdWV1ZSBpbnRlcnJ1cHRzOyBmcmVl
IHRoZW0gKi8NCj4+IC0JZm9yIChpID0gMDsgaSA8IENGR19HRVRfTk9OX0lPUV9NU0lYKG9jdC0+
Y29uZik7IGkrKykNCj4+IC0JCWZyZWVfaXJxKG9jdC0+bXNpeF9lbnRyaWVzW2ldLnZlY3Rvciwg
b2N0KTsNCj4+IC0Ja2ZyZWUob2N0LT5ub25faW9xX2lycV9uYW1lcyk7DQo+PiAtDQo+PiAtCS8q
IEZyZWUgSVJRcyBmb3IgSW5wdXQvT3V0cHV0IChUeC9SeCkgcXVldWVzICovDQo+PiAtCWZvciAo
aSA9IENGR19HRVRfTk9OX0lPUV9NU0lYKG9jdC0+Y29uZik7IGkgPCBvY3QtPm51bV9pcnFzOyBp
KyspIHsNCj4+IC0JCWlycV9zZXRfYWZmaW5pdHlfaGludChvY3QtPm1zaXhfZW50cmllc1tpXS52
ZWN0b3IsIE5VTEwpOw0KPj4gLQkJZnJlZV9pcnEob2N0LT5tc2l4X2VudHJpZXNbaV0udmVjdG9y
LA0KPj4gLQkJCSBvY3QtPmlvcV92ZWN0b3JbaSAtIENGR19HRVRfTk9OX0lPUV9NU0lYKG9jdC0+
Y29uZildKTsNCj4+ICsJaWYgKG9jdC0+bXNpeF9lbnRyaWVzKSB7DQo+PiArCQkvKiBGaXJzdCBm
ZXcgTVNJLVggaW50ZXJydXB0cyBhcmUgbm9uIHF1ZXVlIGludGVycnVwdHM7IGZyZWUgdGhlbSAq
Lw0KPj4gKwkJZm9yIChpID0gMDsgaSA8IENGR19HRVRfTk9OX0lPUV9NU0lYKG9jdC0+Y29uZik7
IGkrKykNCj4+ICsJCQlmcmVlX2lycShvY3QtPm1zaXhfZW50cmllc1tpXS52ZWN0b3IsIG9jdCk7
DQo+PiArCQlrZnJlZShvY3QtPm5vbl9pb3FfaXJxX25hbWVzKTsNCj4+ICsNCj4+ICsJCS8qIEZy
ZWUgSVJRcyBmb3IgSW5wdXQvT3V0cHV0IChUeC9SeCkgcXVldWVzICovDQo+PiArCQlmb3IgKGkg
PSBDRkdfR0VUX05PTl9JT1FfTVNJWChvY3QtPmNvbmYpOyBpIDwgb2N0LT5udW1faXJxczsgaSsr
KSB7DQo+PiArCQkJaXJxX3NldF9hZmZpbml0eV9oaW50KG9jdC0+bXNpeF9lbnRyaWVzW2ldLnZl
Y3RvciwgTlVMTCk7DQo+PiArCQkJZnJlZV9pcnEob2N0LT5tc2l4X2VudHJpZXNbaV0udmVjdG9y
LA0KPj4gKwkJCQkgb2N0LT5pb3FfdmVjdG9yW2kgLSBDRkdfR0VUX05PTl9JT1FfTVNJWChvY3Qt
PmNvbmYpXSk7DQo+PiArCQl9DQo+PiAgIAl9DQo+PiAgIAluZXRkZXZfaW5mbyhvY3QtPm5ldGRl
diwgIklSUXMgZnJlZWRcbiIpOw0KPj4gICB9DQo+DQo+SGF2ZSB5b3UgY29uc2lkZXJlZCBmYXN0
IHJldHVybiBvcHRpb24/IGxpa2UNCj4NCj5pZiAoIW9jdGVwX2Rpc2FibGVfbXNpeCkNCj4JcmV0
dXJuOw0KPg0KPkl0IHdpbGwgbWFrZSBsZXNzIGludGVuZGF0aW9uIGFuZCBsZXNzIGNoYW5nZXMg
aW4gTG9DIGJ1dCB3aWxsIHByZXN1bWUNCj50aGUgc2FtZSBiZWhhdmlvci4NCj4NCg0KRG8geW91
IG1lYW4gdGhpczoNCmlmICghb2N0LT5tc2l4X2VudHJpZXMpDQoJcmV0dXJuOw0KCQ0KSSdsbCBt
YWtlIHRoYXQgY2hhbmdlIGFzIHdlbGwuDQoNClRoYW5rcyENClNoaW5hcw0K

