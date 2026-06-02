Return-Path: <netdev+bounces-294169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gFfvDCvEHmqCUwAAu9opvQ
	(envelope-from <netdev+bounces-294169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:53:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A3E62DBAE
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:53:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=selector1 header.b=Fa6vedIF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294169-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294169-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6709530056C1
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 11:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406423876CD;
	Tue,  2 Jun 2026 11:47:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB7C3BB668;
	Tue,  2 Jun 2026 11:47:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400837; cv=fail; b=ho8DoLC3p+hdqyrLCikh71qx5j35RfrPVuzwQeKBkrHKYuACPBvBkPL6+AbSP/vI22ZWpZnkuWqM+3OoIJCZ1ahtmuJy5hqEOuqWWA1E3AQsc2Tw/cnav5mkNtIxa0cAo1UbheU/IFaYj6g2GUhCDTJmdVJ0bVChwv9bFW96thg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400837; c=relaxed/simple;
	bh=Nkq28TSQqqP0SC6vfCIGX3hDI2n7bScc/L5xNjx7v1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PGDcDrYzrNVHnK4/Hp+QMJTLQkW6oTchgW+FzqqKqcO7aTbx9+MXO7iQcKLwUOkUPthxeBgcY9skyXayxDqiB5uY2pUhyCp7fnybtLb2LVB5jG44I9OalQeSUdpAPans+Y6ckbPpdaP3YBj+FF7qUXpKCyAT/8d0qUlnLSNCN10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Fa6vedIF; arc=fail smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652ACWAr930009;
	Tue, 2 Jun 2026 04:47:00 -0700
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022136.outbound.protection.outlook.com [40.107.209.136])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ehbxgbk0r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 04:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRRsnYPz1XTRi3n0IvfAo8R0kI0A+Olsg+6BL+wn49P5ALYHHKlOiTeNwFxYJx1rJSEEaOOVuSPljim+S8dLt1+m806mr42kh/bkRgvpbesqxCyQsjid9Xv7ks9yi2+Cjzz52Fnvw/P0rc9pMNgzquy5N+NqIjoatGiPb0ggsAbphH+HCPtnXnMPnGI8j9V+0weCKNujDnfcKOhYhdC2F12NhI9qWl1F6wjrzd84c3pNM1/2EYx5FaRQLkJlr0mGR5xeOO9T2imoJ+9n+qkGVOPSxaxufd1RwBEPeyZG0oqWoVMQVoNW2mTmITESHV0uG3Aj50SDz6zsKX+SmOnjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uNV4gE9qISTyoeCMFGsrOPM8kTukZkjSbqOLwZat4U=;
 b=D8KzatLlAXYrjUNYUkZPZF0LifXG/GX5UxxDCg9cO091bPf3Sy3Wtc8/Gw1RIJEd1CGcMqbQbBZSpxEg2ZMi4NjH1s9TkUud+h0JsLTg0tyT1WptbAMjs0C3ZwPMKqy/xnSHUgI7+Ksp/5zXmwv8QFvo6kA1q8fQoqtt9CmLXXR/3hpW1oRnFZAhQEV+EvSnBWeNxtA9L1mwll14GruK/v4eZa1blaZt009rv6V0s4eNhQ9XporskzN6Ml0qop/8b/V7lerBlPVFUnWJq1Z6cYyByhcwVoKVI6MJd6Ixtb92/oQjZR650Jg7UgOWe2Pg+wWI7+II2+E7iXSFZ/rL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uNV4gE9qISTyoeCMFGsrOPM8kTukZkjSbqOLwZat4U=;
 b=Fa6vedIFHpDzhcR3lbWq+XngpigyGmPdVBh9nba3BQNrNvtGBkrGKbYNDdKJDJ2YfxjNUHjQMyut2rTl1AJn3AGX5VftmyGfvW3//t24TDpXmm9MWDFc0Yr47NOXMur8W9aCapkscYZZPT6Q4XN4DWC6IPimPhRHmu4ZihDi6so=
Received: from SA1PR18MB4600.namprd18.prod.outlook.com (2603:10b6:806:1d3::7)
 by DS4PPF35C8FD259.namprd18.prod.outlook.com (2603:10b6:f:fc00::a94) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.30; Tue, 2 Jun
 2026 11:46:55 +0000
Received: from SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9]) by SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9%6]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 11:46:55 +0000
From: "Sukhdeep Soni [C]" <sukhdeeps@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "horms@kernel.org" <horms@kernel.org>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v3 10/12] net: atlantic: add
 AQC113 PTP hardware ops in hw_atl2
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v3 10/12] net: atlantic: add
 AQC113 PTP hardware ops in hw_atl2
Thread-Index: AQHc6GLHEnuzudqo1Ei4cpzCWKVfK7Ya1S4AgBBh52A=
Date: Tue, 2 Jun 2026 11:46:55 +0000
Message-ID:
 <SA1PR18MB4600CAE146E438EC2059E4B5BA122@SA1PR18MB4600.namprd18.prod.outlook.com>
References: <20260520141046.2151-11-sukhdeeps@marvell.com>
 <20260523012502.1823591-1-kuba@kernel.org>
In-Reply-To: <20260523012502.1823591-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4600:EE_|DS4PPF35C8FD259:EE_
x-ms-office365-filtering-correlation-id: ac3918f6-64a9-439d-3e81-08dec09ca563
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|3023799007|6133799003|11063799006|22082099003|18002099003|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info:
 YcNzKEd6zfSQl/H3pN6ODAyql+JDmXYIqAWGLQ0CE/+wykJU6eZO56afGJIr0hORKZ7xbO/ItM1wrWeDuc/XvHF75vNQn8yDMREUSKsDD3FQRegTfbU2SqolgVdEcS1osAmd/Tqvr7FCe0mw9VimF2GP4ZIZz288OfL3lzb0lF7k9i9YOfirhzvaGgFxjpqBPhNmD9yo80y1GmqNfDrUqsFgXxPzAoPMp8zKdoH2E9eW80bm3zZKoEMGkivRnr5FKl9jTKiQoDNONeCsZcPQ9vF4VuVtFHIAW1qRYgwWNLazb6DnKrE/NDAn5s9L9YC/EzfXpiBsw9/njciSA/tuihfXM4heSN+QqHdq6qNqibC0fmzF8+mBVFV038yTcXWpsAEh366mrIuc3XUXWQbvNFkpcLSQ9YIn/Q64+kX5TNBziCKkHFH0c7v8hbXgFPPUMKUeeBIrc2Nptxdi13u4Q/nisyiVlwwH7k5HIXUjIoNakyeEOr7OZGULTRKgjgqfPayf9O5udRKi9UMC0/KvGhs2YdXV6+gneovT/HHjCYgQiurrUTmTxzJ3ttCxvLUcq1VNssO12bEbP8aWoHu5csYPpyHr8WRxztXLaj5GKessvFOMNBffV831l71HiN+hNkHVaBwbB89P7I0Rvtiad0/LCHiSva6lOhx58oniaRBV06LLYbWeirGPkoHqf56rklvIz9kFMiVFpqMoX9VLQ9VBkqi4Z7+Hh1V9evtIz16Fwp1v5q0psjkx51MV7HTX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4600.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(3023799007)(6133799003)(11063799006)(22082099003)(18002099003)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mk3KJvJyYQdBEgZGM6fBo8BvrK22lAmFPpgZmHEMHB89mWoSOAR715CK0Mhl?=
 =?us-ascii?Q?EbofqeTeTDil8q69TFNmSJ77uF/w0ygPbRByt9XkAyVNVRGI/8iV5f5qEQqj?=
 =?us-ascii?Q?mogJi/giSosqPiYs1lvcnhi5HCLaOmSQSu0YBftPiRtS5p4kZobYHRtruP/R?=
 =?us-ascii?Q?ZZycGKYw2r86GF3RaG3HG1HW5/KzxaSodOodi9y4DgAU7nJ8GaUEWn+spUni?=
 =?us-ascii?Q?mYoDERgic8CN3j+BVT98nH5fYjngNpt0GpON1nh8r0L86OijDHux/XLVtWwS?=
 =?us-ascii?Q?67w/mvoO2tGjUxq75QZhPDy4TPEQuY6hcu/C7CGRHHA2ilYzKOLTGZcE4HVm?=
 =?us-ascii?Q?qurgbMZyVAeu1GXQFYa07W+HKPwjn/4IHNxfouwiAdjPqshdtCWvyao20tF9?=
 =?us-ascii?Q?mNSR1maii9JRv4yZFfByjHBmfe8iJVSP5UEyk+C58I2qwn2BqawHU9oTxKoO?=
 =?us-ascii?Q?lDq/IleY+I/xWyE/DLdYfaSYVYjNGg7CvQoKIwtIhsCMt4sbbor3Vidmw+/N?=
 =?us-ascii?Q?EHI9Ebe7jOuRV80SypTdamuU6rjtEZMu7Jvv4AtzdpL9Yl/HTZI3iDkfzDiZ?=
 =?us-ascii?Q?mo/v51Ui+UBDg79CLHguvAocrwc0s8KrQHURT0hO9v81mBUmaOHBRIjZs+4t?=
 =?us-ascii?Q?R5rF1/Cs7kypOrSuSOEe+KwnGTC/eXxfH+Vbvyhkpw1OxlW5uKT7CNNK+bnL?=
 =?us-ascii?Q?2HYmpqnLJlyhXvusmr/g8dxduuwuhT6awIHceS1sGVGNMDnzWccHhSvnYqo9?=
 =?us-ascii?Q?22jOESRyDWgB3O2+VEE43qEEt8VYseHbRddEZSsr7U+rg72k7Tm+pDYXCqvz?=
 =?us-ascii?Q?XFpf7Pqgx9n+oRIYdEXDmM7WT7Orkxs0kBl4WcdIk5+p4HaFKgn6Q+uOAa5T?=
 =?us-ascii?Q?pqm1LWEFsw9CEbNXQtwiAJ9e1DcyhjnRe2MhyZwFZWV0sq8s5mHSaOyHdfQm?=
 =?us-ascii?Q?h+fN3+IXY6S6EHj76ebvukJyb2FsZsObLghSfPqIU2/xFRO8KRN8fRl5xDTK?=
 =?us-ascii?Q?Zrh0QaUAEMEwS7wPLuMuhL7rOSM8hINPvbyGuxTn0F3oMggvVQVosU/Osrc+?=
 =?us-ascii?Q?ZS0TQQ74pXOKjtvI5VuGNYWLwqSFlxLPiLkGZAonlJbdV3Yn32E6rku0S4d5?=
 =?us-ascii?Q?xQOXGLLT8A5Ly/GGyF285ouR3j30lgxZXZeRe1bqTxCCiRSNe8ULBPqwnBqq?=
 =?us-ascii?Q?QbGeNld5X/22EjI26JxLElhQsAsHnkTYozWimiTB1UtjvE7aoysYQJVet5my?=
 =?us-ascii?Q?HaQxTt0T5ArtdP+YbgGlBSPkU7Mb1V5f8sFSZjlqBP7smhj0nAvKPGU3tFEF?=
 =?us-ascii?Q?yCncut4v+MfhB/S1+5c5xUgF9XNIGpGYYyTGCLhqMzNlgAA3QhyzqpHmWw0m?=
 =?us-ascii?Q?7CP/0BjHenF4xbPziRf7Jyh4kY4ru8g59+bWtiB3aPbxNEYwXONTOarQzCWP?=
 =?us-ascii?Q?2O6uLGAe9zI7CMMR0UndkWPRHTZUNjWIlrIEX7NM3WP6m+gA7KG+h1U5uDBd?=
 =?us-ascii?Q?BGzlh9A/FzuR1s8iPSuxezfmk0CdUfFVn5wH1aqVkFYb4H/mXa32yC18BPAJ?=
 =?us-ascii?Q?0a5jNeQrj4OH/hvMXKQfxPkWdtAY7hhRFWWhSbsrc3poa+Umot4rRYAawfOU?=
 =?us-ascii?Q?dgx1LiMxlruJDxl0/+mK3dZHfasUjtPvsN0cQPirRR+0HeokUpbpidLirHm4?=
 =?us-ascii?Q?NsRaqAJYEi7jVdZ46RxWIFUU78M9mPGWPWTtMWcfgb9Jfu8R?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	qKZJY4Fj+089WTeQpQb/0eTRA+ic6T9NJb992Ui97ovbQe73SeDI6KeadtsGlw0p764kUNwKskRsoumPSNL/6KJBd5Gm1Hv5VpzH68CVw6rgPP2peKfUWiWcemDHjvhjkKy8197l64G8aGj8aYbB8jRP4Ega6ab82oil84SUX0YLqwmRJjIBJ2gs9boYWUw3p6ItZbCokA3E3NvYIwfWObv2a3fPd7oi7n0aZtdBjhR5oAr/GGlj1ikujWQCvosk/gJr7MywayxCSqXVwml9xgoh0GNA/qdJ0Y0P0HmToX7E/VzT7zjsLgsFiPEIf2bPkwUhS3urdWs1BH7dQU0Xeg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4600.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3918f6-64a9-439d-3e81-08dec09ca563
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 11:46:55.4997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TM6tihaHmSTZZ7LY3UJqUn7eJYWp3qB0bcSPFPnoXhjLK0fipCYuX75JZJ+0HH3TynNV0YWzzXbzkkX5i77UiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF35C8FD259
X-Authority-Analysis: v=2.4 cv=V75NF+ni c=1 sm=1 tr=0 ts=6a1ec2b4 cx=c_pps
 a=aZOTJIJ1i17uwAYHC389yQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=8zUzExlI-0qToBm5x8sA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: peETEy2okguMTHBAoZF7FJpwEAzUxISQ
X-Proofpoint-GUID: peETEy2okguMTHBAoZF7FJpwEAzUxISQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExMiBTYWx0ZWRfX879/91zEmALj
 i/YlpzhRIpKZOVC1I3BEHxOAiaSbHi01/2wo/YC06YoKc2sagp02NV/wgjYlQCgU9aB9I5Hr06B
 a9pQ5IYDG9Hdmm3JA6xrbIWQYEfyqOvbLx94aZ+Ih6GwEzxUI4DTrgIGJdXrr0Ha2UMFWKUq6v9
 CB/oaQQ/2bGHCdPQmWE2Kl5nEfftSQ2Axee9Hij9FLL23dWlwEZsCSOGkT4pe66BPfB9htNvsqq
 OxlB1k1pctig/vsVaXPzt3QT9SqG13wczP9eeGeC6LpQzZ82MPcrgrNaW+HgxlU2j1JDGIpe9Cx
 u0pDIQBnragr9nYG1tJruVJ29vdNR82MYw3+VFPgpgJ1q2gI3klRrZpldb3TYM3X56fmlbgUGhb
 /WXkYL86dcstY2RcxBIz6SExRzv1n+uUeyTDO//rp3Jn9U8MFOJ0G7ilf6XGWlfPbMOIp/cPT/2
 nCOgl54ig8bNGa/e+Ng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-294169-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR18MB4600.namprd18.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,marvell.com:from_mime,marvell.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87A3E62DBAE

On May 22, 2026 Jakub Kicinski wrote:

> net: atlantic: add AQC113 PTP hardware ops in hw_atl2
>
> This commit adds the hardware-layer PTP implementation for AQC113 (Antigu=
a).
> It includes TSG clock programming, RX/TX timestamping mechanisms, and PPS
> output generation via the TSG pulse generator.
>
> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/d=
rivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> index 39d84576ca519..d6a97a1ec5c65 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
[ ... ]
> @@ -888,6 +924,151 @@ static struct aq_stats_s *hw_atl2_utils_get_hw_stat=
s(struct aq_hw_s *self)
[ ... ]
> +static u64 hw_atl2_hw_ring_tx_ptp_get_ts(struct aq_ring_s *ring)
> +{
> +	struct hw_atl2_txts_s *txts;
> +	u32 ctrl;
> +
> +	txts =3D (struct hw_atl2_txts_s *)&ring->dx_ring[ring->sw_head *
> +						HW_ATL2_TXD_SIZE];
> +	/* DD + TS_VALID */
> +	ctrl =3D READ_ONCE(txts->ctrl);
> +	if ((ctrl & HW_ATL2_TXTS_DD) && (ctrl & HW_ATL2_TXTS_TS_VALID)) {
>
> [Severity: High]
> Will this fail to recognize valid TX timestamps on big-endian architectur=
es?
>
> The struct hw_atl2_txts_s is a hardware DMA structure, and the ctrl field
> is defined as a native u32. When reading it via READ_ONCE(txts->ctrl) on =
a
> big-endian system, the little-endian word is loaded into the CPU register
> natively without byte-swapping, so ctrl & HW_ATL2_TXTS_DD will test the
> wrong bit.
>
> Should this field be defined as __le32 and accessed with le32_to_cpu()
> instead?

Correct - this is addressed in v4: ctrl is declared as __le32 in
hw_atl2_txts_s and accessed with le32_to_cpu(READ_ONCE(txts->ctrl))
in the code, so bit positions are correct on big-endian architectures.

> +		dma_rmb();
> +		return le64_to_cpu(txts->ts);
> +	}
> +
> +	return 0;
> +}
[ ... ]
> +static int hw_atl2_adj_sys_clock(struct aq_hw_s *self, s64 delta)
> +{
> +	s8 clk_sel =3D READ_ONCE(self->clk_select);
> +
> +	if (clk_sel < 0)
> +		return -ENODEV;
> +	if (delta >=3D 0)
> +		hw_atl2_tsg_clock_add(self, clk_sel, (u64)delta);
> +	else
> +		hw_atl2_tsg_clock_sub(self, clk_sel, (u64)(-delta));
> +
> +	return 0;
> +}
> +
> +static int hw_atl2_adj_clock_freq(struct aq_hw_s *self, s32 ppb)
> +{
> +	u32 freq =3D AQ2_HW_PTP_COUNTER_HZ;
> +	u64 divisor =3D 0, base_ns;
> +	u32 nsi_frac =3D 0, nsi;
> +	u32 nsi_rem;
> +	s8 clk_sel;
> +
> +	base_ns =3D div_u64((u64)((s64)ppb + NSEC_PER_SEC) * NSEC_PER_SEC, freq=
);
> +	nsi =3D (u32)div_u64_rem(base_ns, NSEC_PER_SEC, &nsi_rem);
> +	if (nsi_rem !=3D 0) {
> +		divisor =3D div_u64(mul_u32_u32(NSEC_PER_SEC, NSEC_PER_SEC),
> +				  nsi_rem);
> +		nsi_frac =3D (u32)div64_u64(AQ_FRAC_PER_NS * NSEC_PER_SEC,
> +					  divisor);
> +	}
> +
> +	clk_sel =3D READ_ONCE(self->clk_select);
> +	if (clk_sel < 0)
> +		return -ENODEV;
> +	hw_atl2_tsg_clock_increment_set(self, clk_sel, nsi, nsi_frac);
>
> [Severity: High]
> Could these two clock adjustment functions race when writing to the hardw=
are
> command registers?
>
> The core PTP operations execute adjfine holding
> mutex_lock(&aq_nic->fwreq_mutex) and execute adjtime holding
> spin_lock_irqsave(&aq_ptp->ptp_lock). Since hw_atl2_adj_sys_clock()
> and hw_atl2_adj_clock_freq() are protected by different locks, can
> concurrent calls from userspace interleave writes to the same
> CLOCK_MODIF_CTRL hardware register and corrupt the PTP hardware clock sta=
te?

The locking asymmetry between adjtime (ptp_lock) and adjfine (fwreq_mutex)
is pre-existing in aq_ptp.c and applies to both A1 and A2 hardware paths. U=
nifying
them under a single lock would require refactoring the entire aq_ptp.c lock=
ing model,
which is outside the scope of this series. This can be addressed as a follo=
w-up cleanup.

> +
> +	return 0;
> +}
> [ ... ]
> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils=
.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h
> index c84955bc14ae4..ee7f444f6d07d 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h
> @@ -8,6 +8,16 @@
> =20
>  #include "aq_hw.h"
> =20
> +/* Hardware tx launch time descriptor */
> +struct hw_atl2_txts_s {
> +	__le64 ts;
> +	u32 ctrl;
>
> [Severity: High]
> Does this ctrl field need to be __le32? Since this is a hardware DMA
> structure, declaring it as a native u32 causes endianness issues when rea=
d
> on big-endian systems, as mentioned in the hw_atl2_hw_ring_tx_ptp_get_ts(=
)
> function above.

ctrl will be declared as __le32 in the code, consistent with
the __le64 ts field above it. This will be addressed together with the
le32_to_cpu(READ_ONCE(txts->ctrl)) fix in hw_atl2_hw_ring_tx_ptp_get_ts().

> +	u32 reserved;
> +};


