Return-Path: <netdev+bounces-234659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A415FC256DC
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 15:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 522174F49C7
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 14:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC0023FC54;
	Fri, 31 Oct 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="iHIp7Z/q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akamai365.onmicrosoft.com header.i=@akamai365.onmicrosoft.com header.b="HlIdAYr9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28F3C17
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919409; cv=fail; b=PWBAbxOeFynL31kGMDCZNAKBtP7BeFBAWN6ZHJHtR1Xl9gJ9ukL5HkSjsVB7zKYhG3LFp4VyrpqJm+npQWItsaxolrUfH2mvABGVBYN14GLb9vuNhxFB0m2bwgCfCZsxI5HR3zwCaLF1L6y14UUXSdhvu/efQ/NfXUqUP7UL0eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919409; c=relaxed/simple;
	bh=3szzGd9GbzIYaR2UboFxV2Y3fQFcH3vScDAigPWdLqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SLgP0an16zc4jiPvkVHgNzpOe1CBo6jHJkzjxfbtdGSawpwbdXMYOmT2LOyGGQZYQ0dYTBjwDURAgSC/Ni4lUPFd/QJqwg3jw/JIyxlvsZaZxDXhWauKgkFfALGPGeWu9vdpMSGRUzc7W6onezfJdPpzlDEQBdn44U9VgTEu7L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=iHIp7Z/q; dkim=fail (1024-bit key) header.d=akamai365.onmicrosoft.com header.i=@akamai365.onmicrosoft.com header.b=HlIdAYr9 reason="signature verification failed"; arc=fail smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
	by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 59VBSa593732143;
	Fri, 31 Oct 2025 14:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=MlQMtrnZGpaMXOa23s5JA4
	A4gMcamGX7xVkXXIk9Y8M=; b=iHIp7Z/qS+Qo5FjBH3C1WAMjWtsnn+lpkRfI4z
	AZr852IQ3XAax0mIOe6Fq/nsmSDLVP6XGOtIfLbfv8qDSW0Weu3jwQ2a5KGusgUX
	mNjsqoZofvWhxx03Qf2KCuUz1qC3oqtdpN4h9wDQb3ab2iIj6X4qSmRbX9cEB2Vp
	9eWs9ZEg0CK3boILovS6QlAascuOBMevftNWaRp+Vh5zjCyOIRUJ6qDH1e7QEWgb
	W1nA1jtw4Xx6LUc4ssxbgBjgAQ84JfYujienhl5uU9XL+7pTobER0yYFsgszWV6Q
	hhYwTZ/Ed5t9guJq4CpTtY1aU6mTSvbX4LocNpc53sIFMb5A==
Received: from prod-mail-ppoint4 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be forged))
	by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4a4b0uwd5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 14:03:18 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
	by prod-mail-ppoint4.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 59VDbsIE003167;
	Fri, 31 Oct 2025 10:02:18 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.221])
	by prod-mail-ppoint4.akamai.com (PPS) with ESMTPS id 4a4x5tg433-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 10:02:17 -0400
Received: from ustx2ex-dag4mb1.msg.corp.akamai.com (172.27.50.200) by
 ustx2ex-dag5mb4.msg.corp.akamai.com (172.27.50.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 07:02:17 -0700
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag4mb1.msg.corp.akamai.com (172.27.50.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 09:02:17 -0500
Received: from DS2PR08CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 09:02:17 -0500
Received: from CH3PR17MB6690.namprd17.prod.outlook.com (2603:10b6:610:133::22)
 by DS0PR17MB6911.namprd17.prod.outlook.com (2603:10b6:8:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 14:02:15 +0000
Received: from CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::a7b4:2501:fac5:1df5]) by CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::a7b4:2501:fac5:1df5%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 14:02:14 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: Eric Dumazet <edumazet@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: skb_attempt_defer_free and reference counting
Thread-Topic: skb_attempt_defer_free and reference counting
Thread-Index: AQHcSlYbcVQMoiGpUU6mhRGZkvQrRLTcIm6AgAAmxAA=
Date: Fri, 31 Oct 2025 14:02:14 +0000
Message-ID: <6C80F51E-F1AA-4FC8-B278-C73CAE2AA1F4@akamai.com>
References: <E3B93E31-3C03-4DAF-A9ED-69523A82E583@akamai.com>
 <CANn89iJQ_Hx_T7N6LPr2Qt-_O2KZ3GPgWFtywJBvjjTQvGwy2Q@mail.gmail.com>
In-Reply-To: <CANn89iJQ_Hx_T7N6LPr2Qt-_O2KZ3GPgWFtywJBvjjTQvGwy2Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR17MB6690:EE_|DS0PR17MB6911:EE_
x-ms-office365-filtering-correlation-id: e29788bc-ae2b-4ab3-404c-08de18861882
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700021|4053099003;
x-microsoft-antispam-message-info: =?utf-8?B?V3RBL2xVcmNUckNGMVBXakdCeklDZlpNbE9SSFZvYm5jcUFDaHFTaVZscndX?=
 =?utf-8?B?MGhSb2J4MDJNKzFaVUc0SzBBWmZpVmNzWDlzNURQZXpVMHRJSWtOOXl2cDdJ?=
 =?utf-8?B?STZURFdhY2JBMnlqZkpUMkF4djkrSzZJUVRUa1JXNzBla09RY1NUV0ljbzBU?=
 =?utf-8?B?Q2hOSUtrSzJLc3crOS9DL2JOY3QzTEY1VmhldHZEY0Q2eEpMaFRtUHFZWG1Z?=
 =?utf-8?B?WVJNeDRabkxldDNxNkg1cDdnbXl1U1lnK3hQN1NjSnBjL1EvbDgwdnhmZXY2?=
 =?utf-8?B?b0o0SnpXTmh6eVFwLzBGTUh2QzY0U2JKUXBvaTBOMVBFTWtqQ1FpVC9qalJv?=
 =?utf-8?B?cEwwVlpmLzJMQ3JEeXNwQUpjMFhtRHNvYVg5VllvakE4cXdXNDZGS0xqUHRn?=
 =?utf-8?B?NER5ZE9rUGxGQXpoUEowZC90akkrWFc2cTg2c0dlc1lNZUd6UTVZZ3QvQmZ0?=
 =?utf-8?B?M1pqVElDWjh3b1F0bGE5aWFVNGQ3dVBsUVFnQ0JHNEFvOEJVZlFCMXljRUlD?=
 =?utf-8?B?Qm5QaThzV0VId0c2ZElHT29BbTR4ZGZvYWZqVzQvT2I2OGRsMm5SczNacU1O?=
 =?utf-8?B?Um1sRnBjUnpZUHc5RkxvS1owNXZ0bzgzamxKRnBNN3dhYmpvbWhCVnk2ZmRZ?=
 =?utf-8?B?UWwwdmdWNVcrNElMcjJoZkdDNkVPanQ2bVVrZ04zL2JyV2FXeVo1ZnBSZmYz?=
 =?utf-8?B?dzRNOEVpTXhHWEZSZ09TSHMxeWVod3NXOW5UY3ZpNVhEWVlOcWkzL25waXNG?=
 =?utf-8?B?RFBLeElHM1JHM2k3U0pjS3g1Rkg0bDQ5eWFZbUh1V1Ywakt2VlpUTDB4dmVt?=
 =?utf-8?B?YmhNT2l0a2pDcjYralNuMjhleTdBLytpRCtuL2ZBZGdBRE1BeWF5QjNPSW5x?=
 =?utf-8?B?VGNiaU9SVG03elh1TDhRN1FWVVBQc2EzbURNS2x3ZVhhRmF0bUduYjZVeE0y?=
 =?utf-8?B?M3U0cko3MklxQUVBQXR1Nk05eDBrTGk0K0xqcmtDK0J3bDM5SFdCdnFTNGhx?=
 =?utf-8?B?aGcrbkFQcnBUWTNzUnU5WjhOU2hRVHZYcldOak9uTVM1VjRYVXV5cGk2N2Vz?=
 =?utf-8?B?bUZNc3Z6YVlPbEhIc0M5d0Zsb3hucnUvV2xNTWNTSFJBVWZnVTJQQS9kVDhl?=
 =?utf-8?B?QVFpenNQYTZ0R1EwbjJvSVEzbEJqai9DN2tQWnhyWkNxYjVmMHY5WWtJMUNj?=
 =?utf-8?B?cDZ5SFg2cUxmOFNyL3pmcTdnS3M5cWYyQ0cvWGROc3VzSFhrTktLbTNMdHcv?=
 =?utf-8?B?aXNDQ2twcFJsdTBKUFBxeU1ib2lmeXU1dG5uMkpldmJSbk5kamFVUklOakV2?=
 =?utf-8?B?N2g3M0pMcnVJUFljOSs3NG1rK1U0eVF0MUI5S2V1TXhRN2JtRnlKeUNJVWRw?=
 =?utf-8?B?c0dDNXRFb0wyMXNjT2M4QlZtMy9ZOWp2cmE2ZnduNUkrWVhQbEtuREV5d0w1?=
 =?utf-8?B?c2M2SkhTb1BudWlUQVhJL3VmcnNZeERkZVZJTWk0YjY0dTZiOFJScXQzL0Ev?=
 =?utf-8?B?UU92MjhvalhRam9BSDZnSEo0djFhcGNFNTBtVEZzQ1JTY3lvQ0Y3eE01MGV6?=
 =?utf-8?B?NEN5TzFva05CaVcrWHV3YVJpc2tYWmNucWkzZzRjdlJSYjdpS2ZtNVVjam9v?=
 =?utf-8?B?a0dpU0J6R3hEcThDYjdYOTdjVkFvaFk0TFV6bHpJMDcrQXJwdTBBMWZtbTNx?=
 =?utf-8?B?WGZpclpoejVINFJuWk5FVlBJVjRRczk0UDZTeStqZjlDcE9CYWd5ZzlEYlVY?=
 =?utf-8?B?UkJuMWhiRU95UGhhMUYzemRPMTdNWnRPcGJIeVNTbVMzR3VlWGNmcVNDNCtj?=
 =?utf-8?B?SjN4aFplTjNyQ0JvcUdoVzRsWVFId0J1MTljb0VUZ2oxN0VycStUazkvZUYr?=
 =?utf-8?B?ZllrWWVOUFJKT3NyVGREc01zZThNUGdYc21wOGZwdDl6alZDbGRWeVFDNkZi?=
 =?utf-8?B?aDRxc2lORVI3eU5jQ0NUeHZ2MUx4cjgvaE1JK3FUL0I2QVk4NWRtd29KZ2g1?=
 =?utf-8?B?L3JzdmZpZ1hWWTNscUxyRTE0SUtydklqNHE5QTB6TG1mVlNSWmV6UDB1YVJY?=
 =?utf-8?Q?hYMWlA?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR17MB6690.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VCs4V2N3c0llMjVXclJYSWZsV3RGS1FacUwvUGJkRnkzK2dzSXg4bWtBY05O?=
 =?utf-8?B?Q1BhRld1TEZudnJoUHlnR2h0c3VtRERqSStUSGN1UmRkNDVQUXJGQnJaMVdD?=
 =?utf-8?B?ZUQrVFFITy82SEljRXp3QkJHY1Z5WTFKbjEzS3VpY0NHSU5HN1VMbWp2NUFy?=
 =?utf-8?B?QzBNNnBiU2NkdnYrcTFHcThleG5TY1RtL2xPRld1am5vRzdnMGFWblFCSkNk?=
 =?utf-8?B?K3p0VE5jdjBCSkU2bUpmWGl4dmQrODhkMmpuTTlqVm9rNEdpSTNEdUpuZ3N0?=
 =?utf-8?B?aDJWMWJlMVVsb0ozclFaa0FuR1U0SkdPb2txcnhwTTBjSDVZRVFscUM3SEI1?=
 =?utf-8?B?UnJGSEp2TVlISkljNytvNDArYUtFN0ZnT3dVZHZxZWs5Z2krTThSak1sdDJj?=
 =?utf-8?B?aUFiQ1hvaUR1aUZteHhlV3V0NGp1dUorcVRRN1lNNmZhQ0VOODdPZUNSbnZy?=
 =?utf-8?B?Z0ZlZFNNaTZnNllLdWsvVTJ0NGNHTUozUmZobEYxRW94YUxwRWU4NHVzSWtS?=
 =?utf-8?B?OW1Zd3lnK2wvcDhUSFUzZkxmWnk3VW4wRlc2a3JCM1BYdXNSSWZPWlJFVHJZ?=
 =?utf-8?B?Uitic0pEd29RbjhUODk5cTVmY2x0ZzJFQVkrL1pxbFhtaVJjU3NFeHEvZjQr?=
 =?utf-8?B?SWlSVE5BT29vU2dOTzMydzVISkNpbjFTQ2tHRHBJamo3Rk1SK1hVL1RGOU5k?=
 =?utf-8?B?YVBZVWtBenNIakJDcnBCZWlRWEdpSEpBeUh4djRTeHBCVENxcFA0ZGlnWEo4?=
 =?utf-8?B?ZDA3QURoMkRQS3hZdE9XM2FsRVhRRDh5M3hmalRxOGpENnRyQ3M5dHB1NUFG?=
 =?utf-8?B?dUdmMFRMTUpwVnhveVd4dmVZQjlyNXVMYUFsSjRhL25STnROSlpaeWtLQlFX?=
 =?utf-8?B?dTV5OC92b2dNMlJ4ZUpVY3A3TkF1b3YzY2xwZ2RaV25pRXhyOGhmZklnYzNm?=
 =?utf-8?B?NHJJZEZ3NC9HVG55enpuOVJFaldnWSsrVGMvdFV5Q2xtQ1liSG0wZnp2QXNU?=
 =?utf-8?B?SDgzVElRMmh1UVh4bVA2L2RSd0Z5R3M2WXNoV0w4OXJhNWN5d0pxRWY2R1RX?=
 =?utf-8?B?TUNJZEZFVjVaZkZnU1hldG1QMVZjeldMVXpzS2IyNmpxeHNacUN2cU5TWllR?=
 =?utf-8?B?ZkZqZnNkOGxrRnZIZlhubUoxZHh3ZXZpd1k4NXdqWGVxNSs1a3Zzc2w2aHRZ?=
 =?utf-8?B?Q3FNY29DbUtRSWdTY3ZLYnkxWlB3MnBJcTExeHF2MVZQSlRWVHdIVXlrR0JS?=
 =?utf-8?B?UFBOblRuNzBDOEhQTlo5UDcwdnhvM0x3UjIrcExZMWlCdnhGYmF4RGdyWU9O?=
 =?utf-8?B?UVpHSXV3c3p5TTYxQm1RSHB6UURwL3hGNlVkTEswNDhrdStvUU5JcUp6aWEy?=
 =?utf-8?B?RUpEZVlPUm9McUZPNHgwS3YzSmxXQWJsWk9uTzREdU9ONFBHSjNscUN1alRF?=
 =?utf-8?B?WVowMmlLOEJ6dGtpSkxBdm5YV3pNWi80WS8xVWtObndmVm9oVkNYbWdqZ1ZD?=
 =?utf-8?B?Sk4xK3pQalJiOFFweGtOZFNIcVA2MTdYRmZNNW51bHZjRXIySTlnTnJyUnJh?=
 =?utf-8?B?Z0hpRDZSWnN6TzRoc3plWXJyczBJMFp4bFYxL1NtMDMxU2FxU2VKVjlUMWN1?=
 =?utf-8?B?Z0p1OCtualJScWJ4ZngzZHR4ZzZyalN5MVpBL0lmV1lIWGZYc3hYQnhvbW1B?=
 =?utf-8?B?L2Juc2xteWszNmVvQjNHSTYwRWFXSnhuRCtWckc1L3g1aWM0YzhvMzJQUmVy?=
 =?utf-8?B?VEdSdyszMkRUQ2s1MnQwbngzY21EZGRTb2JhV1p1NDRPMklrZnZpYmZ5VWY1?=
 =?utf-8?B?Ujhwdisra1NrVXdRTVZibWFUdjFxR1Ruemp3Q0t1cWh0ZmkzaDQrcXFLb21D?=
 =?utf-8?B?TUo4Yzg2OEx4bjNWYVAyMTdrSERvM0pyYkZ3WURQWDNiaUpOUElEa1hjYWc0?=
 =?utf-8?B?VE5nWFpUczZvMDR2VEZ6Y3dLdzdvU3R0M2ZrVjhUK21uWVVBSm1ZNnBIa24r?=
 =?utf-8?B?S3JsNXRuaXJJNkVLYUNPMjJ5M1dMTEtJQ3VVRnZpZ3dSUmNXaGJpYXFjTjlz?=
 =?utf-8?B?RVdNSXRvNENKajRTeDNOWkpIZGRPR2xWMSsvanFOdlFQUUVoNWVqOXBCdmc3?=
 =?utf-8?B?S2w1MFQ4UGF5QU01TzFobnp5c2ZycG1NazBCZGNwNG9PVUJZdzdPZkdmSFpQ?=
 =?utf-8?B?Qy9RRVJVOWVjTXhIWlBCMHgybko3dU5BVlE1cU15MHdPM2dkSGprcGdneHRK?=
 =?utf-8?B?N3N5QnYyRTJoNVZRTzZwaDhhRG1RPT0=?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jazCLVS9wsfKkA8+1Eb+PaNiawIIm5RPzxyIblQumsE08FURtI14y9JWyQw4DjBi45kOC8VOwJ2d6v0rFQaV6RwI2VmVbUSwXdy/tFiTOTtcj/e8cBsfJxXlbs1ioUuQuZ5Hr/76WYhlWqZRg0HdFJE8pjJ9pPhBg8qHRv7K9z+OJiS2W93sRpJmpxWefGzs2T9YYYkzXZ4uBZwJxdmq9IVy8R2Vnt/sa82yNhnkYSbvU5w3s6VyTaus/Y1MgQCWj2yoPT3rBpFN5sFQSjUjmASbmtUj51w578p7Mg/MfUAHaIFP0u26L0kQWjxfJvKGdpu7ibyQNrxDmfRc97ulzg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqhhiVc8JqL0POtmNL5liygmwwvP3T3mNx2GHcPcI0s=;
 b=wCnLpZD42hsOrAgAkNNsrC6vjnTpbnAkDKJj//hNrUFdbZhwfVdIT11YkIstckuIgXyYIe0Tthtu3HOAGAshoOE3Yk638wOm2Y6YzjL59A10hDEA3eGZjcuK7L7he3jEXnEm9vykuzepyaQn5rQbt3tz/u5ornWgJK/6sGntSqE7Zfdtl6t5Q43JA520rROQs6I/Ftq6apMUORVrIuL96fg8ZnirKTsFu6Ddiymc61LS/IPWXuhusOwS9Q4OJJ1LIxb6KBP5pZlhXkJkYJibDXbwmCngbXMGDOEtrp42n/4r2hxc8l2HAuyUrg0iJfyaq0/wSB6VTRNd06Djm/GLMg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqhhiVc8JqL0POtmNL5liygmwwvP3T3mNx2GHcPcI0s=;
 b=HlIdAYr9x7ilbCp4GgGE4T2uDZWPF03QYvvKZyHuZkIER/YbeCV7D84+80lqm/vUgUOAfQnkvZJfSnYI4vw5fLMox2B2pdV+U6jTkiX2Jd3srcuBJBtUaZ8o9DjV49JMKkjeQzGqtyJ166Gf3M36rqz+kROOYqwFWdOLckez/NQ=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CH3PR17MB6690.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: e29788bc-ae2b-4ab3-404c-08de18861882
x-ms-exchange-crosstenant-originalarrivaltime: 31 Oct 2025 14:02:14.8827 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 0xeMEEe9nWKj0J1ZOmxuv0MWnETkjkE9yl+EX8IzzlPlnLe6EUKXUxCvVzayGRUiUk0T6j0TEGGmAouLUmqhzw==
x-ms-exchange-transport-crosstenantheadersstamped: DS0PR17MB6911
Content-Type: multipart/signed;
	boundary="Apple-Mail=_35D2BBC4-365F-43E2-B3A8-843B5BE2A1CC";
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
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2510310124
X-Authority-Analysis: v=2.4 cv=VMvQXtPX c=1 sm=1 tr=0 ts=6904c1a7 cx=c_pps
 a=NaJOksh5yBwW9//Q5C/Ubg==:117 a=NaJOksh5yBwW9//Q5C/Ubg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=1XWaLZrsAAAA:8 a=X7Ea-ya5AAAA:8
 a=OLvvI8HVPgi9AzCWFmMA:9 a=QEXdDO2ut3YA:10 a=wqFnSJPP-FBafd8uH9cA:9
 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10 a=HhbK4dLum7pmb74im6QT:22
 a=kppHIGQHXtZhPLBrNlmB:22
X-Proofpoint-ORIG-GUID: c0fSB4AqPwIv8VhgIpzpYSuI2kBFXFTV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEyNiBTYWx0ZWRfX+6/85gYMoXIU
 JVlBCn/2WP9ZwcTqbmUmomGvWevd35ySyZ28buI3nhFrpegg2ONyDqu45+TxHXhIWTKxRmt8jt+
 /Mf4QGC9D/uqXNFlea/sTueI3pjDMBwMb3pvYZ9imb9Xhf/zwqCME9uK7so4v6hBdyv4/Nqmwj+
 h3NyQjUyu2fgq6HZBk8eXcZ4XdYmvDnqhoP1fJO9bY8mxtOKcU2r6cTXAnf+ZIp8JVc+9kYmUO3
 xDccmoa7qXX//44wKCeUH88WQAjuulxrqYQT6eMUoPizCafbL8O6Oj/d9FCFw0QT3SwkNiccX0r
 a/rO5fX1uBGq3WgdhL1+pTMpHmlyLewNc4D7uRuv8k8f6weRXKkORM6L1K9+9/nrZLSur7I3MwZ
 UAKyXlqo/r5KA2E+QRhBJAGrmzdxGQ==
X-Proofpoint-GUID: c0fSB4AqPwIv8VhgIpzpYSuI2kBFXFTV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310126

--Apple-Mail=_35D2BBC4-365F-43E2-B3A8-843B5BE2A1CC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 31 Oct 2025, at 11:43, Eric Dumazet <edumazet@google.com> wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is =46rom an External Sender
>  This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
> On Fri, Oct 31, 2025 at 4:04=E2=80=AFAM Hudson, Nick =
<nhudson@akamai.com> wrote:
>>=20
>> Hi,
>>=20
>> I=E2=80=99ve been looking at using skb_attempt_defer_free and had a =
question about the skb reference counting.
>>=20
>> The existing reference release for any skb handed to =
skb_attempt_defer_free is done in skb_defer_free_flush (via =
napi_consume_skb). However, it seems to me that calling =
skb_attempt_defer_free on the same skb to drop the multiple references =
is problematic as, if the defer_list isn=E2=80=99t serviced between the =
calls, the list gets corrupted. That is, the skb can=E2=80=99t appear on =
the list twice.
>>=20
>> Would it be possible to move the reference count drop into =
skb_attempt_defer_free and only add the skb to the list on last =
reference drop?
>=20
> We do not plan using this helper for arbitrary skbs, but ones fully
> owned by TCP and UDP receive paths.

Interesting.=20

This patch has shown to give a performance benefit and I=E2=80=99m =
curious if it problematic in any way.

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index fae1a0ab36bd..59ffac9afdad 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2251,7 +2251,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, =
struct tun_file *tfile,
                if (unlikely(ret < 0))
                        kfree_skb(skb);
                else
-                       consume_skb(skb);
+                       skb_attempt_defer_free(skb);
        }

        return ret;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f220306731da..525b2a2698c6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7167,6 +7167,7 @@ nodefer:  kfree_skb_napi_cache(skb);
        if (unlikely(kick))
                kick_defer_list_purge(sd, cpu);
 }
+EXPORT_SYMBOL(skb_attempt_defer_free);

 static void skb_splice_csum_page(struct sk_buff *skb, struct page =
*page,
 =20


>=20
> skb_share_check() must have been called before reaching them.
>=20
> In any case using skb->next could be problematic with shared skb.

OK, so the assumption is skb->users is already 1. Perhaps there is an =
optimisation in skb_defer_free_flush if that is the case?



--Apple-Mail=_35D2BBC4-365F-43E2-B3A8-843B5BE2A1CC
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
oGkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUxMDMxMTQwMjA0
WjAvBgkqhkiG9w0BCQQxIgQgkg85/tZX33kjeYNhjrpMIFBLJZsjeALUZsfjgwhw+54wDQYJKoZI
hvcNAQELBQAEggEAhRutaow8kwcdPI7PsGacwqRXdyEQzJw8v2R+H/iz5l3NeNQui3T0nlKJ+nLa
7GzaaMa9CJAFFRhy9sOXFJBEFiucjDKWODRkIUQYOwOkfsfqfraiH7KLkgn7yjec6ydUocxS/HhD
h+yJ8JUkB6XWmOVlPKEDf4m3fkEzwZy07D7b6SsDvV4a0VV7areJvu4Te8lk0jsC4wMYA8oAzlIM
M4P0plBMCvHfVOkd3AnJ2Vsq+PvaL4gEDT1iItiGWBgCWip1I7OgbME0X9z8hNivGdosFZCntjik
AYI6RO5J8vDI175GyRGJEJGiqEg00gI/lt1LoOmVaG9oB+6kP8+g5gAAAAAAAA==

--Apple-Mail=_35D2BBC4-365F-43E2-B3A8-843B5BE2A1CC--

