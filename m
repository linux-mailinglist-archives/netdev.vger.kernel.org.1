Return-Path: <netdev+bounces-155328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F91EA01F09
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 06:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E0E1623BA
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 05:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DD91B412B;
	Mon,  6 Jan 2025 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ezbfQQwi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DBA17C;
	Mon,  6 Jan 2025 05:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736143065; cv=fail; b=BZYdYyxfp3fJt31tGVoy9SDzTrwtdlC3jhGAyB9OeTES9g3vxXYPlUYThLD55jQ3/a9CmLVxUzZy9RWa0aEgOxtMk4Es37kQPZDh+sj+Uo5yKhKYf4J4wTxH3kWe7Rsn1cwpVJUsrRz5jI4bLixQEY52RCzHWJxlMKqtY9o+5rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736143065; c=relaxed/simple;
	bh=JHG2MHDCzxOMSLyGYdCS437v33ypmdiymCw0o3LCqmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gp2acLP8/z0GeFHYe1ilh3ux+VkcwuDjosUOLpAhFKY9bpRm//zKYhtHNyL5mutqT1dM4gY3GQuwwN5aWIU5BYe/iGUAG2zqSHX0XIDwEKYSAEQScAlj0uvwf8teDMbB7LNkFSA43fYVUAhD1IHmXmBeifkmVxpMwfMjk1XOszE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ezbfQQwi; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5063UloA028556;
	Sun, 5 Jan 2025 21:57:17 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4407a6867k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Jan 2025 21:57:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYi7d5JxpbYghhpGhYI+/fC4xuwadRKQIS4C4LD05QvNCSx29P3tOFCS6bHvOgjXP6bWOwMLEuSsku3W0+FzI/GaqFhsJ9yvp0BYvAr/qPwoHBSt924igfsAGtaTwEc0g2L4TNdWcrPV3zwmJKG2LtwnjJJafBk4jRRTgMADHdPw+HlepoYc6C1bxqr56O/kz/76K2GnOgKE2V5BRNOh9wZhmcg2y3UKNorkbzL91hgeD2eWjgbyIaaV7fSWs6X4noQf18VAa2j6lnVKJx7Gzz+wW8X42JCPHQFgC4yECc67B6eKVE6sexE16gYCt1tWQiVz7NC1e4lOQBf5+Pt0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHG2MHDCzxOMSLyGYdCS437v33ypmdiymCw0o3LCqmI=;
 b=whHMvNBDiHCXxCEU27K1svW27TwWgNYxg1yXSMlVQCxca1l9eJyGc/tNyAyzyU1Yqbv2fiZPEMqtlsdvfwmm2P+KDps9sMFY5R0EoIj+fV8TGNGOme9314blIsbFtg4EmVHzHNwj4h5kowTOW9eUeGOlBTuVkHAWixW2W4wiOcvzU4QIpmzsmOrQS+aHHGPuflfgHezN7k3AYKipkZjMc0ZL16xogojyyjq3Ktd+BH0jlK6e7ZmUbfQaWK7mktuZ3xUxVEyzefnH6DW8iYRxqSwz/TuTbLFAdIhS+I7T+cCGIsd06XjKi0sVgGq3lfETztAjn8DoSpIelor1mkcrFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHG2MHDCzxOMSLyGYdCS437v33ypmdiymCw0o3LCqmI=;
 b=ezbfQQwiGdw57XhOAWSOWMxsneiaLjqvJAoAQK83OKD1upS05FV4btdlhMBHHFhRugt1f0c+YF7XnhEWH7S3xzfYqh7mvScii1jYCwajsnZ+T0RqpAZ6YFs52J//lnyhFcBGyWiRBcWuwfGkMSdcQgzNPPyKKiwEF3n2wn9QCMc=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by SN7PR18MB3982.namprd18.prod.outlook.com (2603:10b6:806:10c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 05:57:10 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd%4]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 05:57:10 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
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
        "konguyen@redhat.com" <konguyen@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "einstein.xue@synaxg.com"
	<einstein.xue@synaxg.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew
 Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Abhijit
 Ayarekar <aayarekar@marvell.com>,
        Satananda Burla <sburla@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v4 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Thread-Topic: [EXTERNAL] Re: [PATCH net v4 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Thread-Index: AQHbXQiwzwJw1r4OvUao3wqNxDVI6rMG2mqAgAJqK6A=
Date: Mon, 6 Jan 2025 05:57:09 +0000
Message-ID:
 <PH0PR18MB473488467A2026CA30916528C7102@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20250102112246.2494230-1-srasheed@marvell.com>
	<20250102112246.2494230-2-srasheed@marvell.com>
 <20250104090105.185c08df@kernel.org>
In-Reply-To: <20250104090105.185c08df@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|SN7PR18MB3982:EE_
x-ms-office365-filtering-correlation-id: 1be67785-603c-4c6b-5efe-08dd2e16f589
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Skp2T3RMdjV4WVZJcm51aDlsTXJRSVlqd2NmNlNmR0tpZS9sMitzdy9acVdT?=
 =?utf-8?B?YjNNblNieXJ4ZUJEbUZPcDlIZEFLbk5qdmJBTnNsMjg5Qjc3NTBEWFVGVnNi?=
 =?utf-8?B?cittSzVqVmJpZk02YlhIRTJTVE5yVWN5SEJDNjhtdVEveFh4eDRXdWFZbXpP?=
 =?utf-8?B?cmdiZkYxYWlEM3RIOENDU2Q0UmRaU0M0UytxMkRJWTVHdUErdHZFTEhaOWNk?=
 =?utf-8?B?bEdCbDh3YThVVVlpVW1MRWd1YXVkajVKellYWTcxY2pKU3V0ZkowckxuT0JF?=
 =?utf-8?B?Nmw0YzhLY2FEdW5hcTRZM21sQm5JMFI1N21wN1Y5K2d2c2JvYU5DVk1zZndm?=
 =?utf-8?B?WEc2MU9UTU95U1VNV082OTlTTk9SZmkvYXZTWkdNZStHRHdUaDM1b0lNWC9X?=
 =?utf-8?B?Q3ZKN0I5UVlpWXJuZTlET1RzVVVyampUL1VTVERhSWFZVVNqVFVwcFZTRG84?=
 =?utf-8?B?RWtKYVNwSHVObTVYaGRvV0F3VW5rNzV6VEpjNzByaUVLUUVqRWVuNmt3cXBV?=
 =?utf-8?B?UzhBYzBualdBcFBtN1dnbFdJNXA4N1Yzc0l2MHF4eUt0RkpMekFmcWdIQU9M?=
 =?utf-8?B?VU1kVXRKUFJFWjNYN0lhR3ZoYXVremVJK3pFQzc0dWRZOVZEZmZEMTd3bVNY?=
 =?utf-8?B?Y2FTbDdaN001cG9qQUprVlFZbUNka0hCMm1OdnRMY1dQQWJzL0wrV2ovZkVZ?=
 =?utf-8?B?TXk3NUVGeXAyeTdTak02a2R2L3JhSGZXT2hsQmtEMFB6NVd3TTN1T2pEL1Bk?=
 =?utf-8?B?b3YxTnhnVHYrc2xxaDU4TXA3ZXN4c2pVejExaVd3elc3a0ZiQ0xYemkxSmVW?=
 =?utf-8?B?MDhtS1p1WVRaQ0Jtd3MrbUcwcUdaSE8wYVN0K29qQ0RJZG5lT01VK1MybzlK?=
 =?utf-8?B?MElWWE13dFJSRnp6RjlsM2IzL1JpeHZoYXZnNmJxOHpzcWdRZGcxRC8zbGJn?=
 =?utf-8?B?UW5HR0dvdm82ZklRUlp3S2xxUS9wa0IvS2dabmN4V1UyUUcxLzFzR0hJTzlp?=
 =?utf-8?B?eEhpQ2ZMOFJKL2F1dTR4S3BnN1JCVzZpc21ZbU5wOXRsdzBtS2x2YkJkRzU4?=
 =?utf-8?B?eTg2MUk1ZG4yN2djWEN6VkdtKzR1anlHUkswdG1iZ3JzVkRaSVNsWDBOVi9M?=
 =?utf-8?B?a1dGU3RyY0pBRS91R0M1RmtybEt4aUdHdE5ZNzI5WmRZT2l0YzNLWXplYXA5?=
 =?utf-8?B?Mk5zNm03TFkzRFlXUEk5Z2ZQbFBJemd6SEtzT0s3Qk5EYzhzYitoZjZGbVZ0?=
 =?utf-8?B?NWU2SU1BckpoS3I1SzE1azhpYlpKdWp6Z1FuNkdnS2J4ekxMb2l5NnAxRm1Y?=
 =?utf-8?B?S2t6NnNtLzUvWXMzYVJhZnd5eXJ3ZXBsNmJ3L01GdEdnTk1FQlVMQ3BmbWY0?=
 =?utf-8?B?TFhvT21LVHU3ZWJNTXo5MWQ0REFKSG1KbVVpQXhFSlR4Y0I1OGl0WjQ1dFdO?=
 =?utf-8?B?Z2I3UzJtRzRnRW00N2FsMmVBTUlxNzhpQmE0cmhCbTBzelBlRzdRSWRaUFZU?=
 =?utf-8?B?V0xvQmFPcENqdUdlMWoyaUJRTEJXaEdiZkJTRFlSdzhNVGpDT3JGWGNyYTl0?=
 =?utf-8?B?TkxVNG5NWHJXT1BKTW9TSEN1OU9QTnZRR2NUOExOV3p4L1E0NXpiZkZTRUU2?=
 =?utf-8?B?d1p0ZEhPd05uYUVuUTB2ZlBvd0x1YXRHdkZ2NGRwSXo5TDlLdTdYNXhUUWFS?=
 =?utf-8?B?d0p3a0diQzIxRlpJL05kZlZCV1VxZHkyTll5dWtEVkJvOVZKL3lzMGFSbHdL?=
 =?utf-8?B?ckUxbkFoSE8vYjZIS3BndXFWZFJFWEE2QTFnUGp5bVQ0TFRpWGdlUGF3bXlz?=
 =?utf-8?B?a1IvbGh1SjdOQ3lBY1JteFV0a283NXY5dUF6blJEQ0wyNlMvMzlNZnlJQW9X?=
 =?utf-8?B?Y2FiZ1pJNm5NQ09MSVAzR0o4Z2NSbEVicnNxRjY0MFBmLzlyblRyTDJucmpF?=
 =?utf-8?Q?FEeMq+2q4/FJ0HiZpZpqhjgQSqpLhRPs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akhUWjNSa2Q5WW1Ic01MVkM1eHpocHozYmEvOU1hbWQ0UENCZmhrRG1DR1Yz?=
 =?utf-8?B?RjFPRnVGbGo0eHc4ZmZ4a2hLM1R0WGhjWnpnT0QxWjRkd3diT2tmNGE5RCtl?=
 =?utf-8?B?WXdaMWlRbWR4QjFUeTJJRGVBR1dtS1NpM2xLSzl6eWpyamJlc290UjNaaU40?=
 =?utf-8?B?ZnE2VklNNmRKTHhGMjZJNzhXeEt0ZjhzemhIcVVRWVcxMnBVSmI4dUJTTm9p?=
 =?utf-8?B?cldJMGJUWEl6YUp6UUdiWksxMlR0Wk5VRHloUlhmaTljNXZKRjl0TjNxRkhs?=
 =?utf-8?B?TXNSR081WWI1bDUwNVZ3dERzaUFNTEUwSGtjUVVZekM0VjFnQUNhSzk4RGdU?=
 =?utf-8?B?eUlLd0wzcjJsTk42TzgzbGxMMjduOW5lUTlpVzEvZHVlOG1pWmdFQVBGaVFD?=
 =?utf-8?B?TnlFOWozY0taM1lYdDRLL2IzaW56QXZXWG9XRHFNcDEvQmpPQW5NKzI5Kzhm?=
 =?utf-8?B?RHZudnlUK0RNd1VObWpSQi8rT200cXc0QXN5V1E1VXdYQ3Fqb0ZNNWNDUDF1?=
 =?utf-8?B?STh2dEhFd0RZTy9jTEkvcm1GZUk4N1pjOEhOWnpaeEdBb05LTkY2eXE3OHZU?=
 =?utf-8?B?M2hiSGNCZ2RZODR0YnRVdld4UDZXdjJ6Q0VjOVNXdE1oTGtoTEsyelZOZnlE?=
 =?utf-8?B?SkFvc3hvNUhNRXh4eGpKWEZUaDlFQ0JwNEtlMWFoOEFtZ1Zsa2piS0I1NVlu?=
 =?utf-8?B?aEYvUFc4ZUpZdGh6Wk1JdVYvaU04V0l3ZmZXNTBJbVVuaW40OUMwME50Z21o?=
 =?utf-8?B?cmlPQ25udm1OeTNLVWlCeU1rUU9HNXRTeDQ1aEN4UTI0UFRXZ25JRHdpNGVm?=
 =?utf-8?B?L0VrUVhMUExLb3E5aFRtR2l3dGQ2QUs5UEMzT1h3K1NrM1lTM0d5NWEzRzJy?=
 =?utf-8?B?Yy9LVXk5QURRSnVYWmsyNmhuT3V5NzR1Z09oWnRaN2dVeUtESHFpeDc2QlJU?=
 =?utf-8?B?akZlRjJJRlBYOWZmTk5DUStTYXR6OXhheU5VS0dxU2wrZmdWb0Y0ZWM4dTZ4?=
 =?utf-8?B?bG1nSEQwSHdFKzUvZFAxVFRxRUx0YWJhMG1XdVZCWmlSYTBxd0YwNmU4c0tM?=
 =?utf-8?B?Q1VIQjJ2TlMyYmt5SkFheC9FOTVkcWhUU2xFazVLcnFvWXJzVHpiUG54VVRM?=
 =?utf-8?B?UnlCQVZrQzZHcDcwbFYvOHBjYzBVTmxGOHVDaFNvUm5kZEx6bXRhTWdFNWdX?=
 =?utf-8?B?cjBIZVN3YkF5T0UvM2c1NFFOQnZGTDI0eU5Zcjd1bEdxZ3RtMVZ3Uy93Zm41?=
 =?utf-8?B?WXRXRE9nL1psRTYvOXhqY1dYcTFDVUFzSnN0TlN1Yjg4RFI3bGZRLzUxNmVI?=
 =?utf-8?B?T3FicExyNklScWswWVdMRkloalhENXdUQkRNeHpvMWJtbEMvelBFdk05Ti9T?=
 =?utf-8?B?dk5IdDNYTVBFVThmSWFuSWc1U3Q5eHFtOWtpL3k4MzR1SmphRHFpWERaT0g0?=
 =?utf-8?B?RmVUSDJoOWVtOEdqcFZnUUJMSGdFU1pJTE1MdXQ3ajZaZWJoMGx2MDBJMEpH?=
 =?utf-8?B?MWcwSVp2Ulh3L0RFVm1hb0FDY1JlbU9ZcHJ1UlRWL0RJdklPNit5QTQ4U0xq?=
 =?utf-8?B?b2Z0cDJpVlhDdFBkYWtMUmJYTkFyeXo0Y0xINEd0ZXRJaGUxOWhOeXpWWFVu?=
 =?utf-8?B?bGpqUzFMSmpjSGwxVnZBWlBsVXRIM0ZCQzVVcUh4KzFPS2JOeHVYamdPdyt1?=
 =?utf-8?B?RHlQaGpBaGp6TDZHYVhpRkdyV003N0w2M245UC94dTBCUmVqZWMyV24xU25n?=
 =?utf-8?B?TnNLc2RuZDdIZFo4MUlBME1ackxQdHMzM0lQejBLMVR5TnY2OWcwT2ZoM2ZU?=
 =?utf-8?B?TVd3VlQyVXBnSUM0NU93UklwWnFaQmZLc3Rna29xaEg2eFlTWVhuZ29hY3p2?=
 =?utf-8?B?QVpJYUZvZmRCMlp2VWhhZWxYMURYemtGVlNselM0em9sRXJiN3hPNlNuSWRQ?=
 =?utf-8?B?SGNMVnBVNEFLcVU3SzBrZ3VPWDA2cWxOSGJKMGtlQ2JDaS9lL0k4cUpOK1pR?=
 =?utf-8?B?VWJaSmpxYjkxeFg1aUNwWmhPV245RHBGK01NU1Jlc3B0U3JHR2VpR2d4WDFp?=
 =?utf-8?B?ZDNrVEZrOVNkNGt3UzBLa3pEUmo2VFFMS2ZaMExDWU9ERExCZHR1WEp3cjZ2?=
 =?utf-8?Q?njrsDpZieALIcrubPHp65W9PW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be67785-603c-4c6b-5efe-08dd2e16f589
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 05:57:09.9598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/iKfu42ODs+7u/mGhNRawlQyXcX10Xx5EXmklEXkNkKQ25HtHiX85OQZJo51HGSQKdHW6/FIVxNUhM6x96vig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3982
X-Proofpoint-ORIG-GUID: IlMWYEq1llmm-Nca1QcQds4eEwCTVqt7
X-Proofpoint-GUID: IlMWYEq1llmm-Nca1QcQds4eEwCTVqt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

SGkgSmFrdWIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFrdWIg
S2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4NCj4gU2VudDogU2F0dXJkYXksIEphbnVhcnkgNCwg
MjAyNSAxMDozMSBQTQ0KPiBUbzogU2hpbmFzIFJhc2hlZWQgPHNyYXNoZWVkQG1hcnZlbGwuY29t
Pg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgSGFzZWViIEdhbmkNCj4gPGhnYW5pQG1hcnZlbGwuY29tPjsgU2F0aGVzaCBCIEVkYXJh
IDxzZWRhcmFAbWFydmVsbC5jb20+OyBWaW1sZXNoDQo+IEt1bWFyIDx2aW1sZXNoa0BtYXJ2ZWxs
LmNvbT47IHRoYWxsZXJAcmVkaGF0LmNvbTsgd2l6aGFvQHJlZGhhdC5jb207DQo+IGtoZWliQHJl
ZGhhdC5jb207IGtvbmd1eWVuQHJlZGhhdC5jb207IGhvcm1zQGtlcm5lbC5vcmc7DQo+IGVpbnN0
ZWluLnh1ZUBzeW5heGcuY29tOyBWZWVyYXNlbmFyZWRkeSBCdXJydSA8dmJ1cnJ1QG1hcnZlbGwu
Y29tPjsNCj4gQW5kcmV3IEx1bm4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47IERhdmlkIFMuIE1p
bGxlcg0KPiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29v
Z2xlLmNvbT47IFBhb2xvDQo+IEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IEFiaGlqaXQgQXlh
cmVrYXIgPGFheWFyZWthckBtYXJ2ZWxsLmNvbT47DQo+IFNhdGFuYW5kYSBCdXJsYSA8c2J1cmxh
QG1hcnZlbGwuY29tPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggbmV0IHY0IDEv
NF0gb2N0ZW9uX2VwOiBmaXggcmFjZSBjb25kaXRpb25zIGluDQo+IG5kb19nZXRfc3RhdHM2NA0K
PiANCj4gT24gVGh1LCAyIEphbiAyMDI1IDAzOuKAijIyOuKAijQzIC0wODAwIFNoaW5hcyBSYXNo
ZWVkIHdyb3RlOiA+IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxs
L29jdGVvbl9lcC9vY3RlcF9tYWluLuKAimMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2
ZWxsL29jdGVvbl9lcC9vY3RlcF9tYWluLuKAimMgPiBpbmRleA0KPiA1NDk0MzZlZmMyMDQu4oCK
LuKAimE0NTJlZTNiOWE5OCAxMDA2NDQgPiAtLS0NCj4gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
YXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9tYWluLuKAimMNCj4gT24gVGh1LCAyIEphbiAyMDI1IDAz
OjIyOjQzIC0wODAwIFNoaW5hcyBSYXNoZWVkIHdyb3RlOg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9tYWluLmMNCj4gYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9tYWluLmMNCj4gPiBpbmRl
eCA1NDk0MzZlZmMyMDQuLmE0NTJlZTNiOWE5OCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9tYWluLmMNCj4gPiArKysgYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9tYWluLmMNCj4gPiBAQCAt
OTk1LDE2ICs5OTUsMTQgQEAgc3RhdGljIHZvaWQgb2N0ZXBfZ2V0X3N0YXRzNjQoc3RydWN0IG5l
dF9kZXZpY2UNCj4gKm5ldGRldiwNCj4gPiAgCXN0cnVjdCBvY3RlcF9kZXZpY2UgKm9jdCA9IG5l
dGRldl9wcml2KG5ldGRldik7DQo+ID4gIAlpbnQgcTsNCj4gPg0KPiA+IC0JaWYgKG5ldGlmX3J1
bm5pbmcobmV0ZGV2KSkNCj4gPiAtCQlvY3RlcF9jdHJsX25ldF9nZXRfaWZfc3RhdHMob2N0LA0K
PiA+IC0JCQkJCSAgICBPQ1RFUF9DVFJMX05FVF9JTlZBTElEX1ZGSUQsDQo+ID4gLQkJCQkJICAg
ICZvY3QtPmlmYWNlX3J4X3N0YXRzLA0KPiA+IC0JCQkJCSAgICAmb2N0LT5pZmFjZV90eF9zdGF0
cyk7DQo+ID4gLQ0KPiA+ICAJdHhfcGFja2V0cyA9IDA7DQo+ID4gIAl0eF9ieXRlcyA9IDA7DQo+
ID4gIAlyeF9wYWNrZXRzID0gMDsNCj4gPiAgCXJ4X2J5dGVzID0gMDsNCj4gPiArDQo+ID4gKwlp
ZiAoIW5ldGlmX3J1bm5pbmcobmV0ZGV2KSkNCj4gPiArCQlyZXR1cm47DQo+IA0KPiBTbyB3ZSds
bCBwcm92aWRlIG5vIHN0YXRzIHdoZW4gdGhlIGRldmljZSBpcyBkb3duPyBUaGF0J3Mgbm90IGNv
cnJlY3QuDQo+IFRoZSBkcml2ZXIgc2hvdWxkIHNhdmUgdGhlIHN0YXRzIGZyb20gdGhlIGZyZWVk
IHF1ZXVlcyAoc29tZXdoZXJlIGluDQo+IHRoZSBvY3Qgc3RydWN0dXJlKS4gQWxzbyBwbGVhc2Ug
bWVudGlvbiBob3cgdGhpcyBpcyBzeW5jaHJvbml6ZWQNCj4gYWdhaW5zdCBuZXRpZl9ydW5uaW5n
KCkgY2hhbmdpbmcgaXRzIHN0YXRlLCBkZXZpY2UgbWF5IGdldCBjbG9zZWQgd2hpbGUNCj4gd2Un
cmUgcnVubmluZy4uDQoNCkkgQUNLIHRoZSAnc2F2ZSBzdGF0cyBmcm9tIGZyZWVkIHF1ZXVlcyBh
bmQgZW1pdCBvdXQgc3RhdHMgd2hlbiBkZXZpY2UgaXMgZG93bicuDQoNCkFib3V0IHRoZSBzeW5j
aHJvbml6YXRpb24sIHRoZSByZWFzb24gSSBjaGFuZ2VkIHRvIHNpbXBsZSBuZXRpZl9ydW5uaW5n
IGNoZWNrIHdhcyB0byBhdm9pZA0KbG9ja3MgKGFzIHBlciBwcmV2aW91cyBwYXRjaCB2ZXJzaW9u
IGNvbW1lbnRzKS4gUGxlYXNlIGRvIGNvcnJlY3QgbWUgaWYgSSdtIHdyb25nLCBidXQgaXNuJ3Qg
dGhlIGNhc2UNCnlvdSBtZW50aW9uZWQgcHJvdGVjdGVkIGJ5IHRoZSBydG5sX2xvY2sgaGVsZCBi
eSB0aGUgbmV0ZGV2IHN0YWNrIHdoZW4gaXQgY2FsbHMgdGhlIG5kb19vcCA/DQoNCj4gLS0NCj4g
cHctYm90OiBjcg0K

