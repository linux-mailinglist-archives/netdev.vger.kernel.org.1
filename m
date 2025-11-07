Return-Path: <netdev+bounces-236706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DC5C3F1C9
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 10:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE95188DF0C
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 09:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD9D1E51E0;
	Fri,  7 Nov 2025 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="eNK5y11G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akamai365.onmicrosoft.com header.i=@akamai365.onmicrosoft.com header.b="krdGXEAl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11A2AD04;
	Fri,  7 Nov 2025 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506980; cv=fail; b=cK1g7Y2oFLdj/ZyGzXUgsQEqKl9TgiBnMmK7DwiDIrzU/EbUBZ9ft5xoiUqLv6R8MQwElPAOddj0CnO4/QdWx9oxPH3Ryv2R5lAJyZOCg5qwkdShJnl/uNlWP2RJqKeSZ4B4xs7X/WeGSFfy8Ro5Jd/+4mrzL7No8HHLo793cKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506980; c=relaxed/simple;
	bh=A3bJnHwdvA35rfC93K/+RLcID/IbZ45D5AmpPvVVm4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MXk5yrK3j5js2mJ7VwXkqhby5jRcN3fIT5IAjy3Hu6qpvyprVWloJ8O9krBcQU3/QkeXUqx17n0tr8FDmHepYhJjyF6BaaBoGRCRYLgS5i0eFgV21pHwQtpWFjJQnKSGEZYl19Ru+c5kMb3iiMeh2Kpv+5mPZFY1ofWsnp+RhOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=eNK5y11G; dkim=fail (1024-bit key) header.d=akamai365.onmicrosoft.com header.i=@akamai365.onmicrosoft.com header.b=krdGXEAl reason="signature verification failed"; arc=fail smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A73UpWX1038844;
	Fri, 7 Nov 2025 09:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=Jf9mRPtOBSjILsfYLlmFUG
	+ngrQ9QoM91QmPGMVL6e0=; b=eNK5y11GSz5sgjpPVsxBMPRBAn3UqtR79v1zeX
	7/GOWJ47tM0kXS3zz7ZHNImgmgTa4lcuXsfZCf3K1wcDG50BEbtIRZgksAMwCIjI
	eAV29iNOB4E+EBBJDCHyVrGguHYaAHZke0yAIfnz4B3aHjwU2B7cpnSfmWkH23sg
	STDDFbcxZr7QSfua39Cc3lUzrjMUx/7u4R6AOa1Yt3pmN4lwmMB3KKcw09XquaKQ
	A74kaUEQVVUI+1b/7f1JNdZSPx+Ni81KCQlrbJgDWtW5JVNaHeSKDp07ti8m2ZFD
	stAsgV/DFM+LwYgF3azoRhLr1+cfYHVMHTfZiXXhLsyLpRvg==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4a8qbcmx9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 09:15:58 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 5A78W8AX012867;
	Fri, 7 Nov 2025 04:15:57 -0500
Received: from email.msg.corp.akamai.com ([172.27.91.40])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTPS id 4a8x37kb1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 04:15:57 -0500
Received: from usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) by
 usma1ex-dag5mb1.msg.corp.akamai.com (172.27.91.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 01:15:57 -0800
Received: from usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) by
 usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 04:15:56 -0500
Received: from BN1PR07CU003.outbound.protection.outlook.com (184.51.33.212) by
 usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 04:15:56 -0500
Received: from CH3PR17MB6690.namprd17.prod.outlook.com (2603:10b6:610:133::22)
 by BY1PR17MB6878.namprd17.prod.outlook.com (2603:10b6:a03:52e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Fri, 7 Nov
 2025 09:15:55 +0000
Received: from CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::a7b4:2501:fac5:1df5]) by CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::a7b4:2501:fac5:1df5%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 09:15:55 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: Eric Dumazet <edumazet@google.com>
CC: Jason Wang <jasowang@redhat.com>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tun: use skb_attempt_defer_free in tun_do_read
Thread-Topic: [PATCH] tun: use skb_attempt_defer_free in tun_do_read
Thread-Index: AQHcTzUYbStDQZGpZ02RBRZ7L04vCrTmfCWAgABqGYCAAAg+gIAAAUoA
Date: Fri, 7 Nov 2025 09:15:54 +0000
Message-ID: <7D7750CA-4637-4D4A-970C-CB1260E3ADBC@akamai.com>
References: <20251106155008.879042-1-nhudson@akamai.com>
 <CACGkMEt1xybppvu2W42qWfabbsvRdH=1iycoQBOxJ3-+frFW6Q@mail.gmail.com>
 <5DBF230C-4383-4066-A4FB-56B80B42954E@akamai.com>
 <CANn89iK_v3CWvf7=QakbB3dwvJEOxuVjEn14rjmONaa1rKVWKw@mail.gmail.com>
In-Reply-To: <CANn89iK_v3CWvf7=QakbB3dwvJEOxuVjEn14rjmONaa1rKVWKw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR17MB6690:EE_|BY1PR17MB6878:EE_
x-ms-office365-filtering-correlation-id: 54b22def-cbef-4182-f4e6-08de1dde4151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|4053099003|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VkZ5QUQvWGF6ZDQyUjNrcld0UlV0WFlLdVJxSi9nSDB6bWR3RVF2QkYvS2sz?=
 =?utf-8?B?TTVBL3FUVmEraTMyUzE0WkMxbFBRWXpzUm9Ld3FzNWhFU1RkM2RrQThUaFhM?=
 =?utf-8?B?MWVzdklQL3gzemRoZlZna1JCK1JOQjYxOTNzZE9BeThvK2phUFRnams4YTl5?=
 =?utf-8?B?OXd2VTU5Ymx2MmdqNXBuZzFaOGVKbnZZYjBCRkZtbGF6ZGk4Vit1cGRzVnNY?=
 =?utf-8?B?WUVSeEFIWnZmaGQ5cmJjS0pEWUl3MDJkWHVSVUp6WVJaVkdGRjdpZ1FsNmtX?=
 =?utf-8?B?K2k3VXhzM2hzS01zbkZJNEJRSDZpOFlQUU5EcjIwZ1I1bU1zSXNVcFZNYTlx?=
 =?utf-8?B?Mzh3d1k2Y2d6MDJVWTBoS1h6MGFoNHdUVEk5SUJFWHN2WGZjVnFRSGtTSmtO?=
 =?utf-8?B?WE1LbEg3S0pqNFQ0NTlUd3pxa0FkY1RnOTVXbTBIRi82Q09WbEd1N0N2NUpa?=
 =?utf-8?B?RTBHSHA1QkRaUFZxVmZiNVNDV0t0ZDdaVDJCV0NyK0poV2IxNWpicUtEcmNF?=
 =?utf-8?B?YnI2MWhpaDU5OHdiNEFIM0FORG01T0dZa1FDYW16akhYTGkxbmZjZDlTb1FI?=
 =?utf-8?B?elhSSkhFZUZsRmpEa2FvdURRL1hyY2lNQmp4bEdSTHkzMFp4UXJkTUtSTDhJ?=
 =?utf-8?B?OUxickszYzRlbGVpa3F6UzNrNEN6S1JaSGNBUUNVNVZNZDZ1NTVCSHJISUN5?=
 =?utf-8?B?QS9YaGdVYlZiZElBb0ZnSGVRbkRIU0VRWEhCMWxqemxaSE5sbDVpS2QxQXIx?=
 =?utf-8?B?SnF3ampsWlMwWm5FOVV5YWJNZ1NRWmhjTFRXTjJwaTdVOU11S2MrWllWMGt3?=
 =?utf-8?B?MElLd3lIb0tsME1HZnpzS2JVTy85RElJdmNoMi9WekVhVDM4eHZCMitEZGhI?=
 =?utf-8?B?U2drNktsaE9kTWV4cCs3V1RyV01pdk5UN3d0dW9jaitFWlBDdFdpclR4YVZm?=
 =?utf-8?B?THI3Q0JVWWV1SGZZd0srQ01xUnF1VEpoaEs4ekpwdGVPcFhYcGhsVlpsME5C?=
 =?utf-8?B?VnVMRDdPVm1Ia2x5UjBmbVQvMGxVOU1zLzh5cjBhRlIzRXlLcEtldnhsaTh3?=
 =?utf-8?B?Y0pDYkhaNEZtTFJMM0ZUZzh3bU9mNU90a1pnS1RvSlpSWnJvYUZBcjdnNDBU?=
 =?utf-8?B?a2E0UlBBUEZPS1Z6MmEvRm9UTHArZURWWmtOUFlFeVI1dVFqQnJ5ZWN1andC?=
 =?utf-8?B?NmJFUXFtdVVpREpTcDJ4Z3hGaXpNMUtJTnR4bzNhcTZjc285NWN1TmhMWEtz?=
 =?utf-8?B?aEFzUWk3d2Jlek04bE56c0hvUTJFZWo1SFA4b1BDdWpqeWx0VGZWdytjeHpu?=
 =?utf-8?B?OGRlRVg1eDlSYXE4dlhmVHJBQUJQYUxaZFUzdEZLVklJYUVhWWFMQnZuMmxw?=
 =?utf-8?B?YlIvS2pyMnhFa3IxYndTSzBMeDIrdFJiSDl5eHJrN2xCSHI1UEM4dHBNWmpQ?=
 =?utf-8?B?NE92NzdIYTkyWk9QYkRrVXhNWnQ0aWxVd0ZjZUpvV2l6ODByVS90Njh2NDM0?=
 =?utf-8?B?QVN3emN4cHYxZDRUMk1kUzJpQlcxbXVjVnRwbnJKdSs3aG1Bc0VVTWhHME1P?=
 =?utf-8?B?bHZLaWY5SlV6aXZSYlNSTWd2azJjcy9nMUZyYkNuVGZjclpLTVA1V3l0ZHBR?=
 =?utf-8?B?K1N0R0pXWWZSV0pDcnBLS2lzaFpZSEhRWUNLalB1NVZYaFBEYUd0MjYvNVYw?=
 =?utf-8?B?eXpkMmEwZDhRT2Z0ZFhGcG0vTWlVdlhrRTExZFIwSEp2ZWQ0dXBqYlloZEdy?=
 =?utf-8?B?bjcvVmQ4cjN1eDljR3FUa2tjb3Y1b0RYY05kR3NoVi9KUVEvbEJYUG8rTzRX?=
 =?utf-8?B?aXJIMExQY0h2cVY1U245YXkzL3RFeFN3SDVLWFdFVldua3EwMEY5RlhEdG04?=
 =?utf-8?B?dWszeGJDS0pYTStBUm1qTTZQSkg5cVNwc1owZmNlSVhEaElPdnFpTE13eGFE?=
 =?utf-8?B?enRmNmNZODRGb242L2w2amZBd1lOcW9mNjY1TVQ2aXhqL2JYZjUrTU43L1ln?=
 =?utf-8?B?SmJoNm94Um5JR3dUNXFPNGpBa1p4dG5IL0d1S3hJRHMvaERzTFFjdFhkUHhp?=
 =?utf-8?Q?iLDp3T?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR17MB6690.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(4053099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3JvM3hMaXFPRUZWWWJiN0V2cmtnYTY4TzFNMmRORENlaTNMbWRKUWphWmxn?=
 =?utf-8?B?NEJXd3JiMFhmZ3dBWnM0d0djSVRmQ0daZ0FHcEltRzZaVEpYNEhFendTU1hm?=
 =?utf-8?B?YitGc3lxVzVGQURjVm1oVUVTNkFJYVZ4aE91SkFRME9KdW9iYXJoZ0Q0em9R?=
 =?utf-8?B?bXhzSXBlNG1hWWpoNlc2VmFvMDVicThIQklXRzJwNXY1QWhxVUplRVVpTUoz?=
 =?utf-8?B?aitQSFlRU0p1eUNiL0x5VUk4K0lFUXlyYXdWdUhSNDdQVytuYnZkcXM1WU9O?=
 =?utf-8?B?SGVyV2hpcDI0SGlyQTRlc29kb1BaY3RKckpOVXAwQk9taktqaUpqaG8vcjh3?=
 =?utf-8?B?cklIZDN2bHVRZXZFWUxrTEcwQTBLb3JMUnJVaHdkMFBYZUd2cXpwRlZ6d0ZP?=
 =?utf-8?B?amFXVmpFbVl5M2h2TWlyVW92WHRURnM4N3hDZ1F5cXl2Y2pVTks3VjVoZTJ2?=
 =?utf-8?B?RjJrK29HVHFDb1BycHpmVndBV0VTT3RhUDNHMElCZGRHNVRjQ21rdG1ydGcr?=
 =?utf-8?B?emR5Rk1HUGV5YW5HM3lTbHFIZDhRM0Y4Q0tFSXc5b2xiMFlmd2xDMldMUDNr?=
 =?utf-8?B?S1d4SUx1bDBZaGNWMWV6MGpHZUR6TndidjNvVDVaZ2tZeTFMZEZMb2ZQUDk2?=
 =?utf-8?B?TFFDQlNQdnZPNG9NUGllNHJ4OVFsU3pTQUhRWnhSV2JHb3lCNmNwbU9wcUVJ?=
 =?utf-8?B?OTU5bCtyZ0RzWTZpaW1LRk1tczcyMy9MTE04VTlUT2FuNDgrRU1hVHlDdUZa?=
 =?utf-8?B?NjZJWXlDaGc5RnM4NmVhMzE5dDRENFRZRnkwTjhxS1pQaUk3ZVdqdy92WSs2?=
 =?utf-8?B?Tmhqc2hXK3hJS21YbnUwMHVTOFBKYmNDQTl5VDdTa0V2Ui9qYmFVcGR2NXMz?=
 =?utf-8?B?SCtETjBPdDI4L0JQbzRnU0hmQkFrN2o4Qlo5MVBCSFhFUHVXUlhnZHNZZ0xE?=
 =?utf-8?B?U3N0OVNKN2wzVFVKSDh2b3NvTHZFaHJwcGc0RmwwSDdnblNwVnZMKzBwSWtu?=
 =?utf-8?B?M2hMOU9MZ0xuRU9qanZLcTA3MnM2SUZ5NFhMSGROQ21ITlBjbzFkSzc4akwz?=
 =?utf-8?B?YWM2aHRVeHdLTGtWWXBEZS92eTVoVWE1MmRzZjNqZEFvZ25xTGNXanVWeUFR?=
 =?utf-8?B?Q0l2UjlCc3p5WXgvRzlMVHVuT0ZGaWhGS0M5THBUZ1Rad3B1dkxkeFpFYXcr?=
 =?utf-8?B?cmZlalVCUTNFMjJjcjdFVjhHd0J5b00wMWcxY1VmSGM0ckpDSkJIWHVvcXRC?=
 =?utf-8?B?K1A2Q1lmbCswaFhTNG92TFArVnJGYWJva3NxeTQ0UitJZ2Z3Zi9KeTBJY3Fv?=
 =?utf-8?B?R1lUUWZUMysveWg2a0F0ZXVZNkpQRlpqSkQwSFJoVjNqZ09CaGNXOEJ6MHRm?=
 =?utf-8?B?eEZZbW05U3lhN3pQTzJWcUlVcVVSdGtxMEpvUEZPRVcwYURXQzJqaWxPNldm?=
 =?utf-8?B?b3hBQldjaVRqR2xZUGFqekp1ZzdHdlNER0Y4NG1OVHVzWGU0b3h0MTdLdzh4?=
 =?utf-8?B?dVJVcHBuOXF4UnFYd2Jlb1JkL3pxT1ZVOUx5ZllYbytvYzk5RzR6cE11VEQ3?=
 =?utf-8?B?SHZrSGUzRmxhUVZsQmpFdy9GS2ZDRHhjUHZFS1hvM3pTZFVaM01hVEYzUjB5?=
 =?utf-8?B?UzJkSTExRzdWL1k0aWdqbDNlbHVjRnNSVVcxSE1McU9yWXNrM1NEV2VFQWo3?=
 =?utf-8?B?VDF6MUtVZ3F4TkdPWnF5cExjVmF1bWZ3cTJsTkFMU2IreGlyMXRuODlIb1JW?=
 =?utf-8?B?Q1AxSlh1My9jdTlLK2NwamFRWlIzWXU5YlJNY3dzM3hpeFNmNVd2c09hQVF6?=
 =?utf-8?B?cE80a2tGMm1DUTJ3d3FOS0dUL3gwNy9RMkUzaDRhclpvOVphYWVTZmxVNGZ2?=
 =?utf-8?B?Rit5ME1MWlZNOGkza1FPSUpTNWdzSEJPdlNmV3lXQXo2Y2ZyQU1peExYV2Jx?=
 =?utf-8?B?Y1F3ekFlVHZaWlZsSVY5WG9uYndkTEJNZVRRSm9FWlJJUk9LZWZlQzltempR?=
 =?utf-8?B?dUJMWUR4d1orZFFmdTlZekU1R1hhZlBWU25ZZVllb0lndmFCZ2M5REl2eW1P?=
 =?utf-8?B?UDhsNmx4Vms2YTl6RGJkYmpaUUlXUTVHaStyajRSTmVVTkF0c2dTZWZZTXhK?=
 =?utf-8?B?S3RmNjYrd29HSHVHaXd0QklYK1A3RGpNNDN5WHNsRndPOUJjWFpHYVl4TElU?=
 =?utf-8?B?Qk5WOG42WUtQWlBzSDJlS3Fvb0tiZFVyNnBXTjY2M0haWHNsY1ZNcUgvRXds?=
 =?utf-8?B?dWs3cGZGbDlFRGxXTnp5WDFwSHB3PT0=?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rX13KygtnWsQEp0fJFRS/j6lIfRQh8D9gNE2mtdd83q8caa22nah6ORDOA94RT1CKsreCUaUL3jrZjmrePd/SIqBbHQQ+xj5GhMFQw9HoHcXdUoguu9PWIdABVYIhp306pjN/ClBTJ9mKpNQQKGPE/4jHfopLZRcrxEv4rBC86gCj2Wvein34l1atTrSiLu7lIz64FdNokTp7he7GbI0hXQvIHTur7hqpkOHRES+jZc8D1P573AWvyFMxZUCvEjulfbBOTbwNFMLkUGAHHarSGk/mkAvDpkgjTrvcxvh5NEi9yXGmMUDfsULqWY2a4+txOdww0sO91rE5AmyvPC4+A==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JHuHeslCIWKGGkxuQfwNwAoGgqUaxQMPlBiaLZrURE=;
 b=QXuDipbWOM7NVU6xx033X2ad9JefFL5UgnQIIBYLtCt4sy+KIb5IH6woUdFYl6TvQXAUK0307jdlmL2dGWuqzivBK8l28UF8zAE+jFid3kFaQHfZiGHOLmSPcmQIBO5z13wNkn7nkLRO6+pPiqyIseqUFcerYiIvKW//p/4Y2O6v10+VYdIrvBCZL7aXsN9jSjkI0CS34uMlzojP5EiuiHQmSQu3prRdCTOoGilSVpSP3e9z9ZtwKH/pNIAKGujzSsuVXZkMIbbCLz1qQ0UF/4YYXsyczOLm/VHLh3TxuiKyD7YgJmqlQYWsZo5KeZtnwPxbUw8hkZI2nkBh/Fx5hg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JHuHeslCIWKGGkxuQfwNwAoGgqUaxQMPlBiaLZrURE=;
 b=krdGXEAlzc9e+/nf9zNWJngG0jNAJXVuw2fu6eiIvRx8NvBzoqiTeyF+SKcTlV2CtQMl8k+YF6KCJ+poYF5sxZIvM1fyK7gKsVY5nBACksQzp5g4CaKeZ6OVR4P4x3VWQYfzR5AdyD5Es+LFM6NcOQy4P108K1jKePbic/r6wsU=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CH3PR17MB6690.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 54b22def-cbef-4182-f4e6-08de1dde4151
x-ms-exchange-crosstenant-originalarrivaltime: 07 Nov 2025 09:15:54.8414 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: JHEGLDzx+XWsCB3j4deXLL9OdbeJtasfnJBWUer6cPZvZeNEwPv2fBTB9hFF/GgR0IJaIVOOVLHcLayh4/zR6Q==
x-ms-exchange-transport-crosstenantheadersstamped: BY1PR17MB6878
Content-Type: multipart/signed;
	boundary="Apple-Mail=_C8D1C178-5991-43EE-A484-465306492CEC";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070072
X-Proofpoint-ORIG-GUID: CL5QqVxZ0SkGLnAlCcRNdhJsUddrElNQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA3MyBTYWx0ZWRfX5dBlrml/fAne
 j3MU/HqqzZKMwcFgXT63TebnroG9dbixKE017wqV8ooWFU+Qrvymw6WBmsVJtBErAKZNzjz1lqC
 ydX/rT2Ndvfwd4KfKQ9RwEHadXjTzuI2UyINWpNjqwM7fyxuzvCDBbmfDOTh7V8gpAJXZG5WfZq
 eJqeZpcKDoNA3fG5BHu1LNmsQIdSH3+yErq1pmU5jpb3B/BVorhV+U/zrWal+DDTlKSiAEBJWH5
 7UDn0pn0iPMrWWZmctKnFE22C10iIxZDWL+xz5xRbWt/sySKvARLfhqsCnLd5c517btGL6Qj8zh
 xpzsZSTy+fAeNZcDubrdBZp+lcDmr0VJGEVhXhI2h6xJ902/MENe7zy81xrQKKiF/1Az4rRHOTG
 slM6VTMhsOMHwRcHsCGDZVenRBIQ2Q==
X-Authority-Analysis: v=2.4 cv=LK5rgZW9 c=1 sm=1 tr=0 ts=690db8cf cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=1XWaLZrsAAAA:8 a=X7Ea-ya5AAAA:8
 a=20KFwNOVAAAA:8 a=wBwr8VKIJaTxnhfyMUEA:9 a=QEXdDO2ut3YA:10
 a=wqFnSJPP-FBafd8uH9cA:9 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=kppHIGQHXtZhPLBrNlmB:22
X-Proofpoint-GUID: CL5QqVxZ0SkGLnAlCcRNdhJsUddrElNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070073

--Apple-Mail=_C8D1C178-5991-43EE-A484-465306492CEC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 7 Nov 2025, at 09:11, Eric Dumazet <edumazet@google.com> wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is =46rom an External Sender
>  This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
> On Fri, Nov 7, 2025 at 12:41=E2=80=AFAM Hudson, Nick =
<nhudson@akamai.com> wrote:
>>=20
>>=20
>>=20
>>> On 7 Nov 2025, at 02:21, Jason Wang <jasowang@redhat.com> wrote:
>>>=20
>>> =
!-------------------------------------------------------------------|
>>> This Message Is =46rom an External Sender
>>> This message came from outside your organization.
>>> =
|-------------------------------------------------------------------!
>>>=20
>>> On Thu, Nov 6, 2025 at 11:51=E2=80=AFPM Nick Hudson =
<nhudson@akamai.com> wrote:
>>>>=20
>>>> On a 640 CPU system running virtio-net VMs with the vhost-net =
driver, and
>>>> multiqueue (64) tap devices testing has shown contention on the =
zone lock
>>>> of the page allocator.
>>>>=20
>>>> A 'perf record -F99 -g sleep 5' of the CPUs where the vhost worker =
threads run shows
>>>>=20
>>>>   # perf report -i perf.data.vhost --stdio --sort overhead  =
--no-children | head -22
>>>>   ...
>>>>   #
>>>>      100.00%
>>>>               |
>>>>               |--9.47%--queued_spin_lock_slowpath
>>>>               |          |
>>>>               |           --9.37%--_raw_spin_lock_irqsave
>>>>               |                     |
>>>>               |                     |--5.00%--__rmqueue_pcplist
>>>>               |                     |          =
get_page_from_freelist
>>>>               |                     |          __alloc_pages_noprof
>>>>               |                     |          |
>>>>               |                     |          =
|--3.34%--napi_alloc_skb
>>>>   #
>>>>=20
>>>> That is, for Rx packets
>>>> - ksoftirqd threads pinned 1:1 to CPUs do SKB allocation.
>>>> - vhost-net threads float across CPUs do SKB free.
>>>>=20
>>>> One method to avoid this contention is to free SKB allocations on =
the same
>>>> CPU as they were allocated on. This allows freed pages to be placed =
on the
>>>> per-cpu page (PCP) lists so that any new allocations can be taken =
directly
>>>> from the PCP list rather than having to request new pages from the =
page
>>>> allocator (and taking the zone lock).
>>>>=20
>>>> Fortunately, previous work has provided all the infrastructure to =
do this
>>>> via the skb_attempt_defer_free call which this change uses instead =
of
>>>> consume_skb in tun_do_read.
>>>>=20
>>>> Testing done with a 6.12 based kernel and the patch ported forward.
>>>>=20
>>>> Server is Dual Socket AMD SP5 - 2x AMD SP5 9845 (Turin) with 2 VMs
>>>> Load generator: iPerf2 x 1200 clients MSS=3D400
>>>>=20
>>>> Before:
>>>> Maximum traffic rate: 55Gbps
>>>>=20
>>>> After:
>>>> Maximum traffic rate 110Gbps
>>>> ---
>>>> drivers/net/tun.c | 2 +-
>>>> net/core/skbuff.c | 2 ++
>>>> 2 files changed, 3 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>>>> index 8192740357a0..388f3ffc6657 100644
>>>> --- a/drivers/net/tun.c
>>>> +++ b/drivers/net/tun.c
>>>> @@ -2185,7 +2185,7 @@ static ssize_t tun_do_read(struct tun_struct =
*tun, struct tun_file *tfile,
>>>>               if (unlikely(ret < 0))
>>>>                       kfree_skb(skb);
>>>>               else
>>>> -                       consume_skb(skb);
>>>> +                       skb_attempt_defer_free(skb);
>>>>       }
>>>>=20
>>>>       return ret;
>>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>>>> index 6be01454f262..89217c43c639 100644
>>>> --- a/net/core/skbuff.c
>>>> +++ b/net/core/skbuff.c
>>>> @@ -7201,6 +7201,7 @@ nodefer:  kfree_skb_napi_cache(skb);
>>>>       DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
>>>>       DEBUG_NET_WARN_ON_ONCE(skb->destructor);
>>>>       DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
>>>> +       DEBUG_NET_WARN_ON_ONCE(skb_shared(skb));
>>>=20
>>> I may miss something but it looks there's no guarantee that the =
packet
>>> sent to TAP is not shared.
>>=20
>> Yes, I did wonder.
>>=20
>> How about something like
>>=20
>> /**
>> * consume_skb_attempt_defer - free an skbuff
>> * @skb: buffer to free
>> *
>> * Drop a ref to the buffer and attempt to defer free it if the usage =
count
>> * has hit zero.
>> */
>> void consume_skb_attempt_defer(struct sk_buff *skb)
>> {
>> if (!skb_unref(skb))
>> return;
>>=20
>> trace_consume_skb(skb, __builtin_return_address(0));
>>=20
>> skb_attempt_defer_free(skb);
>> }
>> EXPORT_SYMBOL(consume_skb_attempt_defer);
>>=20
>> and an inline version for the !CONFIG_TRACEPOINTS case
>=20
> I will take care of the changes, have you seen my recent series ?

Great, thanks. I did see your series and will evaluate the improvement =
in our test setup.

>=20
>=20
> I think you are missing a few points=E2=80=A6.

Sure, still learning.



--Apple-Mail=_C8D1C178-5991-43EE-A484-465306492CEC
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCdAw
ggShMIIESKADAgECAhMxAAAAIa0XYPGypwcKAAAAAAAhMAoGCCqGSM49BAMCMD8xITAfBgNVBAoT
GEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEaMBgGA1UEAxMRQWthbWFpQ29ycFJvb3QtRzEwHhcN
MjQxMTIxMTgzNzUyWhcNMzQxMTIxMTg0NzUyWjA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9n
aWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcD
QgAEjkdeMHsSTytADJ7eJ+O+5mpBfm9hVC6Cg9Wf+ER8HXid3E68IHjcCTNFSiezqYclAnIalS1I
cl6hRFZiacQkd6OCAyQwggMgMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFOa0
4dX2BYnqjkbEVEwLgf7BQJ7ZMB0GA1UdDgQWBBS2N+ieDVUAjPmykf1ahsljEXmtXDCBrwYDVR0g
BIGnMIGkMIGhBgsqAwSPTgEJCQgBATCBkTBYBggrBgEFBQcCAjBMHkoAQQBrAGEAbQBhAGkAIABD
AGUAcgB0AGkAZgBpAGMAYQB0AGUAIABQAHIAYQBjAHQAaQBjAGUAIABTAHQAYQB0AGUAbQBlAG4A
dDA1BggrBgEFBQcCARYpaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNQUy5wZGYw
bAYDVR0lBGUwYwYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMEBgor
BgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAwkGCSsGAQQBgjcVBQYKKwYBBAGCNxQCATAZBgkr
BgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNV
HSMEGDAWgBStAYfq3FmusRM5lU0PV6Akhot7vTCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2Fr
YW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNvcnBSb290LUcxLmNybIY8aHR0cDovL2FrYW1haWNy
bC5kZncwMS5jb3JwLmFrYW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3JsMIHIBggrBgEFBQcB
AQSBuzCBuDA9BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNv
cnBSb290LUcxLmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFr
YW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFp
b2NzcC5ha2FtYWkuY29tL29jc3AwCgYIKoZIzj0EAwIDRwAwRAIgaUoJ7eBk/qNcBVTJW5NC4NsO
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFJzCCBMyg
AwIBAgITFwALNmsig7+wwzUCkAABAAs2azAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI1MDgyMDEwNDUz
N1oXDTI3MDgyMDEwNDUzN1owUDEZMBcGA1UECxMQTWFjQm9vayBQcm8tM1lMOTEQMA4GA1UEAxMH
bmh1ZHNvbjEhMB8GCSqGSIb3DQEJARYSbmh1ZHNvbkBha2FtYWkuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAw+xt0nZCcrD8rAKNpeal0GTIwS1cfPfIQXZHKRSOrSlcW9LIeOG4
E9u4ABGfGw+zChN5wtTeySgvvxE1SIwW13aoAscxyAPaS0VuEJGA6lUVsA2o+y/VD7q9pKIZj7X2
OxHykVWBjXBpRcR9XFZ5PV2N60Z2UBlwSdbiVp0KBXzreWMBXnHKkjCSdnbVuvOj3ESrN706h3ff
5Ce7grWg7UWARnS/Jck1QAEDqIHLSxJ3FhgbJZBt6Bqgp28EqkP+dQxzp//vnUDIwxBzpSICAMsk
d9I0nsdVvHV0evJSjqDgLF9gw7/4jjjQGW/ugHBytYSBEjDFuB0HOat0va8SjQIDAQABo4ICzDCC
AsgwCwYDVR0PBAQDAgeAMCkGA1UdJQQiMCAGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNwoD
BDAdBgNVHQ4EFgQUWgue6rVjEAcBSPcAqJXWGxAZi9gwRgYDVR0RBD8wPaAnBgorBgEEAYI3FAID
oBkMF25odWRzb25AY29ycC5ha2FtYWkuY29tgRJuaHVkc29uQGFrYW1haS5jb20wHwYDVR0jBBgw
FoAUtjfong1VAIz5spH9WobJYxF5rVwwgYAGA1UdHwR5MHcwdaBzoHGGMWh0dHA6Ly9ha2FtYWlj
cmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRDQSgxKS5jcmyGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3
MDEuY29ycC5ha2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEpLmNybDCByAYIKwYBBQUHAQEEgbsw
gbgwPQYIKwYBBQUHMAKGMWh0dHA6Ly9ha2FtYWljcmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRD
QSgxKS5jcnQwSAYIKwYBBQUHMAKGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3MDEuY29ycC5ha2FtYWku
Y29tL0FrYW1haUNsaWVudENBKDEpLmNydDAtBggrBgEFBQcwAYYhaHR0cDovL2FrYW1haW9jc3Au
YWthbWFpLmNvbS9vY3NwMDsGCSsGAQQBgjcVBwQuMCwGJCsGAQQBgjcVCILO5TqHuNQtgYWLB6Lj
IYbSD4FJhaXDEJrVfwIBZAIBUzA1BgkrBgEEAYI3FQoEKDAmMAoGCCsGAQUFBwMCMAoGCCsGAQUF
BwMEMAwGCisGAQQBgjcKAwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgICAIAwDgYIKoZI
hvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMAoGCCqGSM49BAMCA0kAMEYCIQDg4lvtCdYN
NSoA7BrmrnhzqPrsFhQejDMGHCeY7ECV5AIhAOV93F+CcxakPdapxskTdtiTYz7dbj7AVto5kQkB
66NEMYIB6TCCAeUCAQEwUzA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9naWVzIEluYy4xFzAV
BgNVBAMTDkFrYW1haUNsaWVudENBAhMXAAs2ayKDv7DDNQKQAAEACzZrMA0GCWCGSAFlAwQCAQUA
oGkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUxMTA3MDkxNTQ0
WjAvBgkqhkiG9w0BCQQxIgQgLg2/AHQTsGtZaMY90ThtHi7CTQBnW87u0VZQ2iCjmFIwDQYJKoZI
hvcNAQELBQAEggEAWgFCMIdyEAA0f36tQXVZ4MFcM3dySgInPUFh5tzGFA2wiBgXmGstlbdTLMI7
t32y+E7iTB/rCC23J4MOoW1qVvz1d0QWJFQv+kgfwsSHLIuGMjtIquYzzMD8wrAUI2YoLPpuW7iH
BAcarjVeEeIIc+fOqf6k1BYtRaU7FjkmMsGIWt+8draVp/27kkePbR1Aw27j+Hk1ywljIQ/J0O9j
gPG+SL/7limb192d6eHuBpOmsxyUkp+V3UQpUypk3aRVaS3GsiVjT4O+p8E7OHYm4Aiz/wy+/uhS
fYvdVaf0exG0JSfNJBUEMDZmYh/w+VJNhFYKnqW9UUBKZnk+soXGGQAAAAAAAA==

--Apple-Mail=_C8D1C178-5991-43EE-A484-465306492CEC--

