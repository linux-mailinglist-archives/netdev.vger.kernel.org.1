Return-Path: <netdev+bounces-243325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB45FC9D1A5
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 22:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 850064E346D
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 21:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946EC218827;
	Tue,  2 Dec 2025 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="HpfELRLB";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="xOLdNgp0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CACA55;
	Tue,  2 Dec 2025 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764711413; cv=fail; b=CTh3y0VKSIYABr23Y+E6wQDuKI3OOzgqIqyhy8U/UOwsONwQ4M4VvXWfjZhnC7T+H034EdSmVht8kbkQLNT7NP6ij3i/9bA6wuW/FJxW6s+WBFWmW8T1lFakUCP8MnuJG/ZqnyuN80i72Yjoe/RgQP8qQKBShWZdGnskp5E3Vcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764711413; c=relaxed/simple;
	bh=fMIgg6P0UBgV8o8mnk8/4Bsy8909lAcgUn40gyxr2Ss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aydstCKpA1fSHH2eSYO/i4J/jfgQ9gRntm/FWh3qyoKnnAzksdhXoxHdmWz6YE/jOr8Xl2+Yt3YUXg6QSEMFhbJkwLZknWLR5q6Yol9wpXUZbFxyaVDhMTIA9iTOTouxFTuYPMGSILnHCRLL03FWSljnjuzFwv+OXi5F85nB4Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=HpfELRLB; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=xOLdNgp0; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2GI3it3553295;
	Tue, 2 Dec 2025 13:36:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=fMIgg6P0UBgV8o8mnk8/4Bsy8909lAcgUn40gyxr2
	Ss=; b=HpfELRLB0bUS18yEUMyOc9DsigGl0mb4h2W4YZaDb4L9KEqBj+m0EJ9uO
	HY5wkqx2aZ5ZHQHeAsyLIfBvZMQ96SFe5Mq3zJmHw5vtsis9eS/4H/qleCeDZXg2
	9PHoxVKRH9ZR/gVrRQwrDViUt7oLMAiv/J65aAlvDzVFwSg7LGDK899YhQsOAi30
	QonLMKgAZSE2Nwx70KCusNUKRzIkGqnJWPTp18LfTQxhbpRS5VWFxjh11Yp52aCI
	FHMBcIwrXwi377fKbzuz4HDZAKSHKSe4P+oh+8qacYI8l5V+K/HlVp6GcC6gOzOS
	7t9ZJShVVbUY/8/ktIzWDlFT3M3qg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020088.outbound.protection.outlook.com [52.101.56.88])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4as9ram6pk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 13:36:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCqbTDBBH16/rlP+0mC28MEEMbxai2iIZmZjLCz71/F9w4eUV94PT2GiskCli+fNWUAi9F93ZWCZoJMI4jdLim5QSUqvzBbFB+GYm8LTkIZzFniT22SurZUvddpgk05oeBp/HNm4qm/e/iW5XYl9h+ujdGE5ZHO42zTbkqULvj6cuWJxYd9umN2BVsJeuhcQXk+I98viSUW31AI8xm/8Im+0Hr9XDLRPnwaArVrXBGlHEL0NrU/x9WKOOnIeiAcv4uNKvvzy3P+rMpcF1o0z04OQQ2BHbnbvTcnjkTYC6EU0Rp4+ti4OvCh+5HzXa7b6MaYYKaCY0DNdnLC9b7JSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMIgg6P0UBgV8o8mnk8/4Bsy8909lAcgUn40gyxr2Ss=;
 b=MNZCqxnfQDBFrG83WvEQfUhlWXaJPLf0U1eHIBTd+bFhnhVX5EJwUz8XEw20caW7501dcKRqZLRUwdfHw35bcFVOn0p7lNuTvhc1dgwsiAANFPErOu54LqA4dCPjXE2gEFrCW2xdGP/4ZIS+925YhVLjx2GK8g6rzLvNWKLzEhHeevNjY4AMmP4+mkppoww2a4QmWqm3CDto65q4ma+9HummYALWcKYT4g6k2DAvNWKcIw2ssH7iA82dsmRljvPnqSfIwnBM3cHs3IWdj1Ed1BcIsDYL347YjAr2uW8AJlU/MRJXSecs8odpn0p2TsqJHmeAR7cMtqUwndluRf1YuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMIgg6P0UBgV8o8mnk8/4Bsy8909lAcgUn40gyxr2Ss=;
 b=xOLdNgp0slAPthbZPAmdO2g1D2/qOOTaXMLrn/Xc+xSlF6mwbATToDy1kn0cAeTj1aoB1C8sjAR3uLi/oKQBQeW4wMBF42L9YDCVjwAtTCkKe9Sq+WI0JtPXmR0e4RIBSIdWtdCG0FNWqrr4yDr138OV/QMhUhUGYsq6VjNkf7owKYUem/AnXJLvCBt6motU2eMCMalw6LMJcGNLjx0HLIEY33PsvIBMg20Wiqe8J6oUVaK3irc8i8iPh9yIBGV99Xlbs6ergmctRffbFznNdgvPtItld9r4Ow/e3GXQegHxJ1IzIS1zn6wvcFX9EKJAiG5bAUeZhcG8dXPkH4hjWg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by SA2PR02MB7769.namprd02.prod.outlook.com
 (2603:10b6:806:141::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 21:36:38 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 21:36:38 +0000
From: Jon Kohler <jon@nutanix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jason Wang
	<jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/9] tun: correct drop statistics in
 tun_put_user
Thread-Topic: [PATCH net-next v2 3/9] tun: correct drop statistics in
 tun_put_user
Thread-Index: AQHcXkBHgxbxcUh05ki00EQys3zq4LUI/hgAgAWaF4CAAFIegIAAAKEA
Date: Tue, 2 Dec 2025 21:36:38 +0000
Message-ID: <558F933A-390E-408F-9D19-D1524B822778@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
 <20251125200041.1565663-4-jon@nutanix.com>
 <willemdebruijn.kernel.1c90f25a9b9a9@gmail.com>
 <F48BA9F9-7E15-49B3-896A-5AE367DAD060@nutanix.com>
 <willemdebruijn.kernel.42db6f47db6d@gmail.com>
In-Reply-To: <willemdebruijn.kernel.42db6f47db6d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|SA2PR02MB7769:EE_
x-ms-office365-filtering-correlation-id: 623f4ff3-e7a0-4766-b723-08de31eae011
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZS9kRmZIdnZxaDRwcUFLajVMdEM2SFBtallJTUVoTitleDVRWXpVdU1tRlFo?=
 =?utf-8?B?Q3FlRGt1aVNWZDROaFhsSXpZKy82cTJlRVJBWlRvSStKYkY2MnFNU3lCTkdi?=
 =?utf-8?B?WGhUcTJFUmpwTTlNOGtTcUhlZ2hRbGJtOEx6SXlKb2cxOU1saktjTXJoaVQy?=
 =?utf-8?B?Q0RzRFZzazhVUG50bzZOcGpVVndTT2FTZHNnNjJDYXBzSUNnNTVZNHVVUk1t?=
 =?utf-8?B?Zlg5b3pkQzd2cGdxVWY4U2NKaU5kbGNSNU1aZTM2UGx4RXgwRkhkYnpUZ1A2?=
 =?utf-8?B?WWVMRzh2TmtKT2J3bU8vbE95bWlLUzh1UHVNRlRxRU56ZEcySUtZUDBTVkZK?=
 =?utf-8?B?M0NHQ1pLVzVCS3R4am1qSm1BcGtvV1RmUUZxTDd0VEQ1YmxyNitZM04rQkJK?=
 =?utf-8?B?TWowQnZNQlphUVNSWlZOdXVwVDkrcGZaMHBLYldUUWtIQVZKL3V3clU5WmhC?=
 =?utf-8?B?bW4rRTVJa2Ztd2pjQjdYOCtMSGxEbTRjc3VWZjdHWnh2bVhHYThxUlBMdSt0?=
 =?utf-8?B?clo3ejlKdlowb09KSFkxeXcydFdVWjFTU0cwais3NHlpcTB1VFpPR1ZkMmRQ?=
 =?utf-8?B?WWVQZGpMdFhTOFkrS3V5WFptTXJHM0JOT1VGcW93U0tFSUc5NVoxTTJETUE2?=
 =?utf-8?B?U1RUQVpkeGhFVHRUN3RFaW05UFdSenFYblQydWk4NkVnVjE5ZmdzelNITWd5?=
 =?utf-8?B?NU84aGNObm9iNGxySjIzakpmd0V0UWRuS29lZjRoOE5iY1RjK1J2RmNYMGFk?=
 =?utf-8?B?aTlpMVc4aWhrM2cxZnpxU3dvNzY3ajZhK0I0YUx3SjJscVJoaFdIWFAycnZ1?=
 =?utf-8?B?TlVMcGdTdmZEeks0NEpJQlU2V2FndGEwTTI2K2JwQjk5OXFMKzczb1NuQ2FM?=
 =?utf-8?B?QUVQU21wM0pLaGR5b1pQaGtKS0k0aU9xRU9iWXBKZEV5QzRTc0dMTDJCZ293?=
 =?utf-8?B?dmpTRUdGSUhrM1JGS1dRQnB1Tm9LN2o3SHVsMlE3R3EwajE1UXJPUDE0Snlr?=
 =?utf-8?B?RGpmTW1UK2hUQzVGYWhUL2FKM0t1VEgxRnJrckU0Uktsd2VqYllzeUk3WUJp?=
 =?utf-8?B?TE9kSUhJOG1lcVVoWURiL2FMQVBWQ3NubUVBYVZma3hXRmFocGRNcmV4OXV2?=
 =?utf-8?B?aktCcjVlanBCdjd6cnB3R0RxUGNwOFB0TDNldFdnRXVqcXp2LzM4L1pvenhX?=
 =?utf-8?B?bGE4azFsTnB1TGh1eTBHeFcxTi95dkVienRxL2VJNDJVYmZYTXdubEJjYStF?=
 =?utf-8?B?dTg1UCtXL0s5Sm9DUWtOSjJYZmNzbG5OK3BxSjQ0V1d5ZTQzelBpRzBBNGx1?=
 =?utf-8?B?UGtVNmZxTWlFT2tsNnJucDVKOHJYcXpmR2liR1QvTis5RUtkZFhodU9PeFVH?=
 =?utf-8?B?Y25hMzY2Wi9Wc2puOVJUM2c3RU9zQkZQQU1BdXIrbm0ra3k3MFRzcmlmbm8z?=
 =?utf-8?B?M0swblN2L1M1S3Nwd2NWWXRwNVpVNHpqMjZSdDllajhNVUVQM29Fa0ZpSWc0?=
 =?utf-8?B?NXhKckpUMkdNRHhmNnhrUkNiUk5URDN0Y0JDVDZkaURPWmNwQXQyMXhUQVJ5?=
 =?utf-8?B?c1lwMUt4Lys5VW16Nlk5MGVEekVFeWFnUUxSTjVYbXBLS0NaTXJzUHFCSktm?=
 =?utf-8?B?YmZFSlJYTENIV1dXNmxXUzI2UnpwWXhKeFpzMWlnVS93dU5jSVBEYTE3ZWZI?=
 =?utf-8?B?aTdRaENCS0IwbzVsazlwZFErbUUyNFFNUXlVQUVjb1F5YnRIMkhPbEdoblJo?=
 =?utf-8?B?MFBEb2FQdVhCalg0SVlDK1RZMVV2NXJtMnRMMkYva1ZCclJSWTVZZldabER0?=
 =?utf-8?B?cEtoMHhYVHRPYnBvRjJtRmxwc05wVVg2d0s0T2l0RmlwVFZIdWRyanIrZUV2?=
 =?utf-8?B?dVg4TkJ0TlR4RWpEdGduYVEvbkNScTJqS1lzZ3dLYlh5dkM3M2ZJdDdKa3Fz?=
 =?utf-8?B?d1NqeW5Gbyt5SFlQT3V1dUFtUlJUUTZoWTllUHFXNkZlSW1hMUJxci9VbjZ1?=
 =?utf-8?B?eDZJZkFaZVQ3dG5Pc2ErU3VVSFhoT2ZXZ2N0N3ptVGtEWXVoakF5bHdaKzFU?=
 =?utf-8?Q?EJ4+S8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnBxdTNhaWliV0I1SHlrZEZCUHZEZWNDUUU0TXZ3UXlHc2hVNlJOVE9zLzZx?=
 =?utf-8?B?Zk1YcTV1WGR5Q2VMaU9GeUxEcXYrZVBHR3VTTzlqd0tBVWZ1RGcwVnYyc25N?=
 =?utf-8?B?cUJ3UUp5TSsxK3dnaDU4ek1EUWY2SE5RaFJycy9odjVNbkE3WW5ab3JjcEll?=
 =?utf-8?B?aTNwSDMrRlBOalYwdExMSEZWS1hwOXJTT3liby9Vb3RiK2IxUlA5bVhDcDd4?=
 =?utf-8?B?Z21adzZ0RmxhREo2WTJucE1sMzlFSVNramdCNnVNK3Z6cXJWbU9BcVZYdnNx?=
 =?utf-8?B?RTJPVUJmMlQ0cjNQTUlzbFdNNDN3ZEFWcTI2dUNZQlNrcGxTMDFTcStJU2tt?=
 =?utf-8?B?b3FZWWFNZjdIeHE0QjFkdDRuRTdIQjF2b2l4NGtINlR2TEpJZ1FoL1lKK0sz?=
 =?utf-8?B?NnpTUGtqSG9zOGVwbmQvbisvVERETHlpUmhDbkdEQWd6UEx5cVp4ZnR3bldl?=
 =?utf-8?B?bE56Q0J1NzZ5OVF6RG1LcVVkeUtmdDdKa0hXUnF1M1QrdVo4di9xcTd6RFFr?=
 =?utf-8?B?ang2MUlINXRQbFhXUkJCZ21XYm5FMEVzaSs4MFRDb1BmTlVZNFc5UlBFYkQ0?=
 =?utf-8?B?a3RrWWZ0NmhPY0UwRHNidzdLbkFnZkVCYTJmZXdSb2ZQeVM5bGptU292RDhG?=
 =?utf-8?B?bkFxa3ZBd201aE1lSTNCa3RGcTg4T2JuazRqOCtmY3hhcXZJeDVkNzRnQmRJ?=
 =?utf-8?B?OHRJUndJN0lpYVA3aDU0WXN1aTJ4cGgzcUwzdVg5UFJzNXluNkkxSnJlbVJF?=
 =?utf-8?B?U21OMENUa0NYSWJUeWUyLzRzMEpSaHF6RkpXVUpDMCtuMzhWTE10ZGVXQ3Nj?=
 =?utf-8?B?SGtDRUpnTGZwSkJQZzdUYnZuQ3RnT0g0dzFZRW9ZY040a2FjRlp1OFpwc0ll?=
 =?utf-8?B?ODgwb2NKdHVSU01lajB1emVkWlVCUzhLRVgvclNNbGc5THVHMlFNU2UySUFj?=
 =?utf-8?B?V2NubFJyRDRNT0Vxei9MZXhQdVUvQVcwSWZjNzVnN2dabEw3VU9pbklKV0Ur?=
 =?utf-8?B?Yzk5dDJuRjYyT1U4UkZBTklNN3ZleGVzYjdiY3d2Y0wwc2FETnFHclNNUHB5?=
 =?utf-8?B?R1VwOHRTK0NZS0FVNytYMm1GZDhONXZiU1NKdzRzWXNIMnhvb2FmYm4yMys4?=
 =?utf-8?B?ZlNhVmVlVU5EQjVrMFpxSjZKbXdFV3JxM2Rnck93VG54OW5JWWZvczV0UHJU?=
 =?utf-8?B?ZmluU21BVmlsNjVnUTZtZ1YyZWIyOVQzZjI2ME5VSHJveHNvVFpXYVo1WHFl?=
 =?utf-8?B?SEdRWExOVklaWWF0NFd5b1lLRHhPbU5lVUpKU3VKV2g1R2RvRHJ4VXJBSjQ0?=
 =?utf-8?B?bzM1V0NHeW10RGRtMTVlS1lWdVMyd3o5TWwrNXpYV1VUZ3Y0TWJrdkhDK29I?=
 =?utf-8?B?czltQWs1Y1RkcGlCTmxSQWFVdTBwYkxkNWpHL2FrQkVadnpRS290Z2pHNGIx?=
 =?utf-8?B?aFZZc0I5VVZJZUZSUFhad1BldDNZR1VWTUJkZktrMkpReHEwd1JqODMyTng1?=
 =?utf-8?B?QmhyTEtBemJwU1JPcUZJZThmMTJyQjd0b29SZ29jUGFEaFBvNVZGaVBqRFVG?=
 =?utf-8?B?S0U2YTVMWkRIai9jb0JYOWNpSmd5N0hhMjcyUkdJT0pNd2t6TXZQMG5jY3Z4?=
 =?utf-8?B?SVdtWGhCcU5lcWdVUXJueEY5dStKVDY1OWVmdjlKRDVxaE5qQnpyVFhKcU5r?=
 =?utf-8?B?V3luc25vNjA2TktjMEY2SGJ6UEMvNGhBaWIyOWdHWm9DK01lbUQ4UEZvOGV0?=
 =?utf-8?B?Sk50YUxhaGpXaHUyRHk5ck41a2VEb0d1ZlFVSkthRWc4aDZRVXhBMVh1RnFB?=
 =?utf-8?B?YTJMTGN0aFhoMy9FZ1hSSGk4NEVyVlMxUzNyTzAzS2Zoa2J2MVByNjRpZXNF?=
 =?utf-8?B?c3ZrWUhHZGl6a1grcTFRVGs5WXVGOFFoY21MZ2E3VUYwYUJnc29naS9sdGRj?=
 =?utf-8?B?bnplNlVJa0lMdUtjYnNEb3JNS0J6SHJlMjJwQXFXUFZQdFpUK0pKWTJyZWJr?=
 =?utf-8?B?K25VcTFVZDNLNkoxbzcwdThHcnFnNCs2Vm9YeVBQUlF4SFBxS2l4MG1zdTZU?=
 =?utf-8?B?cUt1Z2E5V3VWakEwUGllc3p3YjlPR1Azdlo4Zlp2VGVOcEx6Q0I2SXh5UVlK?=
 =?utf-8?B?UzVzRFVYTlo1ZDQvMjZ1WWxBZ3ZOTk8rd0s3TkRxZXdkYXlVbGZmSk16ZFA1?=
 =?utf-8?B?K0tGUy93eDVpYjE4TVFWbk0rT3p1WUZZVnNUR2xqcG9NUTcxdGRaZHZjWHh5?=
 =?utf-8?B?YTZlaG1UM2JHeDRtSERybk04aVdBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE222711318FFF4CB71FF11C56096A15@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623f4ff3-e7a0-4766-b723-08de31eae011
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 21:36:38.4174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CteZn6n/Vnwhmm2YONjPhPOmjRaiWTLmDzHwTjeU9POWp764bWsYot304EbHTfnCi4qGtcrUNMbW3Utvx+WcsbmnfvJqjcVj1vKGnj1qtnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7769
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDE3MCBTYWx0ZWRfXwKbrGBf5RjQP
 K47M4txqBRWkGaxW6Fe0L63jUwUg/yrAMpyvSPz8CZgCSLblw9wAUtm2JJZ8OwH+eO17oXeSQY2
 bUkkvfcIwngneth5WxZj0hqS0FeoKwAC+jSwgfoav5YwzI3VPqHgVWtch9OgWRUYDaIUZyOG1uY
 e8Fex5WkvJBjrKzhDbB6fVsSVyJOeEsfPedeCD++RNinCnV7BdsPz6BapIfkbqoBzEB6zR3v+yg
 mGZ1EhrjbPBDXjHvsaeiCSpYusbgSb5vT4CzJ5Dje5iWkWRZE0eTCOmVLHZK71979zWD708TBan
 /watj3Cr8Ov9+kxFafgYaDuBz5EMW8i7ckM/+sQ3g==
X-Authority-Analysis: v=2.4 cv=V7xwEOni c=1 sm=1 tr=0 ts=692f5be8 cx=c_pps
 a=L9EM/DfziDI657cBDvRRFA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=64Cc0HZtAAAA:8 a=PYRao4-VxDwm58GuEMMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zu8riiiqOl2R6C7lAbY1i7_S6B3g7u-v
X-Proofpoint-GUID: zu8riiiqOl2R6C7lAbY1i7_S6B3g7u-v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gRGVjIDIsIDIwMjUsIGF0IDQ6MzTigK9QTSwgV2lsbGVtIGRlIEJydWlqbiA8d2ls
bGVtZGVicnVpam4ua2VybmVsQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwN
Cj4gIENBVVRJT046IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IEpv
biBLb2hsZXIgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIE5vdiAyOCwgMjAyNSwgYXQgMTA6MDfi
gK9QTSwgV2lsbGVtIGRlIEJydWlqbiA8d2lsbGVtZGVicnVpam4ua2VybmVsQGdtYWlsLmNvbT4g
d3JvdGU6DQo+Pj4gDQo+Pj4gSm9uIEtvaGxlciB3cm90ZToNCj4+Pj4gRm9sZCBrZnJlZV9za2Ig
YW5kIGNvbnN1bWVfc2tiIGZvciB0dW5fcHV0X3VzZXIgaW50byB0dW5fcHV0X3VzZXIgYW5kDQo+
Pj4+IHJld29yayBrZnJlZV9za2IgdG8gdGFrZSBhIGRyb3AgcmVhc29uLiBBZGQgZHJvcCByZWFz
b24gdG8gYWxsIGRyb3ANCj4+Pj4gc2l0ZXMgYW5kIGVuc3VyZSB0aGF0IGFsbCBmYWlsaW5nIHBh
dGhzIHByb3Blcmx5IGluY3JlbWVudCBkcm9wDQo+Pj4+IGNvdW50ZXIuDQo+Pj4+IA0KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBKb24gS29obGVyIDxqb25AbnV0YW5peC5jb20+DQo+Pj4+IC0tLQ0KPj4+
PiBkcml2ZXJzL25ldC90dW4uYyB8IDUxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tDQo+Pj4+IDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCAx
NyBkZWxldGlvbnMoLSkNCj4+Pj4gDQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC90dW4u
YyBiL2RyaXZlcnMvbmV0L3R1bi5jDQo+Pj4+IGluZGV4IDY4YWQ0NmFiMDRhNC4uZTBmNWUxZmU0
YmQwIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL25ldC90dW4uYw0KPj4+PiArKysgYi9kcml2
ZXJzL25ldC90dW4uYw0KPj4+PiBAQCAtMjAzNSw2ICsyMDM1LDcgQEAgc3RhdGljIHNzaXplX3Qg
dHVuX3B1dF91c2VyKHN0cnVjdCB0dW5fc3RydWN0ICp0dW4sDQo+Pj4+ICAgIHN0cnVjdCBza19i
dWZmICpza2IsDQo+Pj4+ICAgIHN0cnVjdCBpb3ZfaXRlciAqaXRlcikNCj4+Pj4gew0KPj4+PiAr
IGVudW0gc2tiX2Ryb3BfcmVhc29uIGRyb3BfcmVhc29uID0gU0tCX0RST1BfUkVBU09OX05PVF9T
UEVDSUZJRUQ7DQo+Pj4+IHN0cnVjdCB0dW5fcGkgcGkgPSB7IDAsIHNrYi0+cHJvdG9jb2wgfTsN
Cj4+Pj4gc3NpemVfdCB0b3RhbDsNCj4+Pj4gaW50IHZsYW5fb2Zmc2V0ID0gMDsNCj4+Pj4gQEAg
LTIwNTEsOCArMjA1MiwxMSBAQCBzdGF0aWMgc3NpemVfdCB0dW5fcHV0X3VzZXIoc3RydWN0IHR1
bl9zdHJ1Y3QgKnR1biwNCj4+Pj4gdG90YWwgPSBza2ItPmxlbiArIHZsYW5faGxlbiArIHZuZXRf
aGRyX3N6Ow0KPj4+PiANCj4+Pj4gaWYgKCEodHVuLT5mbGFncyAmIElGRl9OT19QSSkpIHsNCj4+
Pj4gLSBpZiAoaW92X2l0ZXJfY291bnQoaXRlcikgPCBzaXplb2YocGkpKQ0KPj4+PiAtIHJldHVy
biAtRUlOVkFMOw0KPj4+PiArIGlmIChpb3ZfaXRlcl9jb3VudChpdGVyKSA8IHNpemVvZihwaSkp
IHsNCj4+Pj4gKyByZXQgPSAtRUlOVkFMOw0KPj4+PiArIGRyb3BfcmVhc29uID0gU0tCX0RST1Bf
UkVBU09OX1BLVF9UT09fU01BTEw7DQo+Pj4gDQo+Pj4gUEkgY291bnRzIGFzIFNLQl9EUk9QX1JF
QVNPTl9ERVZfSERSPw0KPj4gDQo+PiBBcmUgeW91IHNheWluZyBJIHNob3VsZCBjaGFuZ2UgdGhp
cyB1c2UgY2FzZSB0byBERVZfSERSPw0KPj4gDQo+PiBUaGlzIG9uZSBzZWVtZWQgbGlrZSBhIHBy
ZXR0eSBzdHJhaWdodCBmb3J3YXJkIOKAnEl04oCZcyB0b28gc21hbGzigJ0gY2FzZSwNCj4+IG5v
PyBPciBhbSBJIG1pc3JlYWRpbmcgaW50byB3aGF0IHlvdeKAmXJlIHNheWluZyBoZXJlPw0KPj4g
DQo+PiBIYXBweSB0byB0YWtlIGEgc3VnZ2VzdGlvbiBpZiBJ4oCZdmUgZ290IHRoZSBkcm9wIHJl
YXNvbiB3aXJlZA0KPj4gd3JvbmcgKG9yIGlmIHdlIG5lZWQgdG8gY29vayB1cCBhIGJyYW5kIG5l
dyBkcm9wIHJlYXNvbiBmb3IgYW55IG9mDQo+PiB0aGVzZSkNCj4gDQo+IEkgYWdyZWUgdGhhdCBp
dCdzIGEgY2xlYXIgY2FzZSBvZiB0aGUgYnVmZmVyIGJlaW5nIHRvbyBzbWFsbC4gQnV0IEkNCj4g
Y29uc2lkZXIgUEkgbm90IHBhcnQgb2YgdGhlIHBhY2tldCBpdHNlbGYsIGJ1dCBiYWQgZGV2aWNl
IGhlYWRlcnMuDQo+IEl0J3MgYm9yZGVybGluZSBuaXRwaWNraW5nLiBXaXRoIHRoYXQgY29udGV4
dCwgcGljayB3aGljaCB5b3Ugc2VlIGZpdHMNCj4gYmVzdC4NCg0KWWVhIHRoYXRzIGEgZmFpciBu
dWFuY2UuIEnigJlsbCBjaGV3IG9uIGl0IGZvciB0aGUgbmV4dCBnby1hcm91bmQNCg0KSm9u

