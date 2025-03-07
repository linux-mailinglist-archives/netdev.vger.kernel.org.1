Return-Path: <netdev+bounces-173098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78A8A572EE
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 21:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40D61738F9
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FAF256C9B;
	Fri,  7 Mar 2025 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GnMBlqGO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C5hSnHZ4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239E256C7B
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741379348; cv=fail; b=S2VEK0Y6J49Bh/ymn6PB3AqenjbSaZcpKkDC+b47Swn29thE03qtFknqYqmhXoBvf3EIr9k2w+GSOx7LwveqCRo5D+Fu8ZJx3rkbrZ3vLQg0sr17I9yEqARBOKW93YEN2vPkbbz5wbXUOHsGOtglMApJu7vtj+cZf1IOY0MHpso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741379348; c=relaxed/simple;
	bh=6TAM6n3t7Y6fGhV0zLOCjM/TZbuUj5Q2MF664YcnGfA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GrNJYSYHZXkNJ2QU9UTPHj44An3oapOzQl/tk7YSSS1GC28bTy2ni0Zx9TZBT1G8nHipeoo0xIjeNzrIP2zhKDclUO7CxVuJGJGwItnAYAfYWsadZNAny9maupMJonhmAjqyYiBUK6997qsfJdE3Di7myZinOYXcaEQP8/TPz1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GnMBlqGO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C5hSnHZ4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527JtidQ016970;
	Fri, 7 Mar 2025 20:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6TAM6n3t7Y6fGhV0zLOCjM/TZbuUj5Q2MF664YcnGfA=; b=
	GnMBlqGOzcJJlggmjEbr7xEKX0k0ptqIRP0yND0+QCr0OVZawGEgXct7d6FLi7kJ
	NRNMU87r41OME2YvfPuOOxBU+ioTQ81e861bcv6N0g3QJytk6OMsb33zZtJmxQIs
	wl44UxyF4dGnLJIiamQ7ke4SpLGKUAdO4gS1L9T8NrSt8lyTA+LDVnfMF0zuCLcy
	3+28eAD4nj5ZqjOi9w1RteUxtD9+pGv3egde5NcTMla/Z7NzOlBCoc7iVugO6Vr/
	ZZ2Y4UM5nnq02m5n0WrtXCS2ITo/2RGbevkEGFgmijMgJaIVnfhDsYa3airD53aA
	0V2ZbmcmAlxkXfIB0oio7A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hn174-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 20:29:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527J0vPf015711;
	Fri, 7 Mar 2025 20:29:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpf2h7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 20:29:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBU4WcW1fcosBT7j/+rxqx9D4NPp61DK8no8j41hgd/TvJOIhgSleJOHbmjWg3RnbQ97ub9/iO2ztxakPzVQAVN8p5B6oM/VnRU1RdNi8YlsMMpw3JJF/xsP0xbrQ6wzGpLxDc7jObsz8/lP3Mz6Kcjui8DhBHaIeTQPhOyiKVwvSQOrvqhtUr5OWpTD7vctXuMRnOy0E2uPi7rYKcoExiSSRLFPr4DV7UHCwDZeXNGdLbwuj8A8Ql7/o2dBkCIsSIUGN9VrOjWRWpQEpk2L3bL0sx9LMv4dOaRvGg2IE4a1qHJboAukK5ACgZ+zRKM6fkyqy6E9twgJ8AkUQkJEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TAM6n3t7Y6fGhV0zLOCjM/TZbuUj5Q2MF664YcnGfA=;
 b=O/x67iwiK0AnkoHQVH0P0q/40OpnmhO2ka9+yyG88iCli1iyvpJluTJtK+Zn9W6X0ttYg/3tdd7TAUpsv6EraQ6SrWlzGtE3BU8y/JOJnGgJhtfyG+I3plecSQP7cnu1Ft9phDmvI0d5TuGGFz6qFokw5zMqLoelx2HvHINukM4w2M+WQzEJ/gqC8gK7eY8F9pperbqljG1I9mfKqT14bx+StPmzxmVH6EFTMuo870KXY1085Mu1mix03QkkPiFegwOl9fA65Js6KtLC9CLrkgZU22ldWKdeU5uCSjmd6Y7XbhvgOkPcnZY7ZhWekiCICS42nQGioSNtrYY+qbNObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TAM6n3t7Y6fGhV0zLOCjM/TZbuUj5Q2MF664YcnGfA=;
 b=C5hSnHZ4mhG8Myp7wbmy8YNUx53fqBuSGzfYMmgGs6D+MPEffN+NQlXT4mQXcEHGfXkm4/bj8uJVKjUXSIunX0AeZZKHrEfRvEKEwhV6JRSA46NTsKJzPGTjfRvGArJFm402t58S6l/O3jeGi6+Je1EAvnzM9jKinhdN90ZyCSo=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by BY5PR10MB4180.namprd10.prod.outlook.com (2603:10b6:a03:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 20:28:58 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 20:28:58 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv work
Thread-Topic: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv
 work
Thread-Index:
 AQHbiM/MqlxGuKFhJ0mhR9ncavILwbNdbXkAgAZOyACAAAGMAIACndEAgAAbDYCAAbbOAA==
Date: Fri, 7 Mar 2025 20:28:57 +0000
Message-ID: <01576402efe6a5a76d895eca367aa01e7f169d3d.camel@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
	 <20250227042638.82553-2-allison.henderson@oracle.com>
	 <20250228161908.3d7c997c@kernel.org>
	 <b3f771fbc3cb987cd2bd476b845fdd1f901c7730.camel@oracle.com>
	 <20250304164412.24f4f23a@kernel.org>
	 <ba0b69633769cd45fccf5715b9be9d869bc802ae.camel@oracle.com>
	 <20250306101823.416efa9d@kernel.org>
In-Reply-To: <20250306101823.416efa9d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
autocrypt: addr=allison.henderson@oracle.com; prefer-encrypt=mutual;
 keydata=mQGNBGMrSUYBDADDX1fFY5pimVrKxscCUjLNV6CzjMQ/LS7sN2gzkSBgYKblSsCpzcbO/
 qa0m77Dkf7CRSYJcJHm+euPWh7a9M/XLHe8JDksGkfOfvGAc5kkQJP+JHUlblt4hYSnNmiBgBOO3l
 O6vwjWfv99bw8t9BkK1H7WwedHr0zI0B1kFoKZCqZ/xs+ZLPFTss9xSCUGPJ6Io6Yrv1b7xxwZAw0
 bw9AA1JMt6NS2mudWRAE4ycGHEsQ3orKie+CGUWNv5b9cJVYAsuo5rlgoOU1eHYzU+h1k7GsX3Xv8
 HgLNKfDj7FCIwymKeir6vBQ9/Mkm2PNmaLX/JKe5vwqoMRCh+rbbIqAs8QHzQPsuAvBVvVUaUn2XD
 /d42XjNEDRFPCqgVE9VTh2p1Ge9ovQFc/zpytAoif9Y3QGtErhdjzwGhmZqbAXu1EHc9hzrHhUF8D
 I5Y4v3i5pKjV0hvpUe0OzIvHcLzLOROjCHMA89z95q1hcxJ7LnBd8wbhwN39r114P4PQiixAUAEQE
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHOBBMB
 CgA4AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAme1o
 KoACgkQyD6kYDBH6bO6PQv/S0JX125/DVO+mI3GXj00Bsbb5XD+tPUwo7qtMfSg5X80mG6GKao9hL
 ZP22dNlYdQJidNRoVew3pYLKLFcsm1qbiLHBbNVSynGaJuLDbC5sqfsGDmSBrLznefRW+XcKfyvCC
 sG2/fomT4Dnc+8n2XkDYN40ptOTy5/HyVHZzC9aocoXKVGegPwhnz70la3oZfzCKR3tY2Pt368xyx
 jbUOCHx41RHNGBKDyqmzcOKKxK2y8S69k1X+Cx/z+647qaTgEZjGCNvVfQj+DpIef/w6x+y3DoACY
 CfI3lEyFKX6yOy/enjqRXnqz7IXXjVJrLlDvIAApEm0yT25dTIjOegvr0H6y3wJqz10jbjmIKkHRX
 oltd2lIXs2VL419qFAgYIItuBFQ3XpKKMvnO45Nbey1zXF8upDw0s9r9rNDykG7Am2LDUi7CQtKeq
 p9Hjoueq8wWOsPDIzZ5LeRanH/UNYEzYt+MilFukg9btNGoxDCo9rwipAHMx6VGgNER6bVDER
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|BY5PR10MB4180:EE_
x-ms-office365-filtering-correlation-id: 2b6c1772-b60c-4f06-9495-08dd5db6b063
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YUFGRU81Rmd5eGo2ZnQ4RU4xbHk0cUlNc3BxTUY4VXYvVFowVjFXVXFGZzM4?=
 =?utf-8?B?eE5vR2VNNWtkdzZ1S3gxUlNWNU5LV1pkN1BtNGNPSFVZc2QwUW5kNk9HdEFU?=
 =?utf-8?B?RzhkZWZXcm1Vdk5LQUhxZC8zS1l2WmJYYTZXNjdTU25Zd091ei9RMmYvWndW?=
 =?utf-8?B?bEgzTzRYMVNibWZvUUNJTHVOYnV1ajFRQzk1VTZ6NUFPRmhpR0JtWHNML1l0?=
 =?utf-8?B?bnA3UTVyTTFndUZJWC9XeFlRbjdOb0pvR2FEWmNObWJWT3VkWVRMUEFuUURB?=
 =?utf-8?B?UExtRm5iRlJRR0RVZ2s0TUdiVmxSSGQzZ2ZRQkNXNG4yWWUyZzAvYjFMV2xr?=
 =?utf-8?B?NUczNzJvK2tpS25iVEl0WkIwRlVLRXRuVUtJOXM5ZEorc3BhNlJzNTRYZGRl?=
 =?utf-8?B?bnNFaFRJbWxuVzI5UFFvUWhsREt2WnNrOGQ5aWlLT0F4QkE1blJNQnV4Z2Jr?=
 =?utf-8?B?SEd1T3k1SlJ1QjEzNW9zNkkybExlK2JwZGVsTGtwN1BkK2RZU2NEYUdISXNx?=
 =?utf-8?B?NFJoSE50Y1NNLzdGcldXWXdCWXFHY3pmczF0QnZIa2dRbXI2SHc5U3JxeWtM?=
 =?utf-8?B?aUU0a2xlNlo2dUxTVVlTRzczSkJWbmRhb3M4N1FLOGhkb2dhT3FEV3poZldX?=
 =?utf-8?B?aG0zSFIvNGl2SnRycGZXK3pLWUxoZ2VYWlBsNFVlZDZjRStKU1JKd2JOd3FR?=
 =?utf-8?B?NnZkQjNoZXJPZHoyYkY4NEs1U0pRUFZES2xES3VYTkNCQ29CekJzQ2VXZlE2?=
 =?utf-8?B?K1BwZmV5R0JwMjJMdS9Ucit0ek9nZzZxb2wrZmpWeUI5akpUSEpiWkFNdHFZ?=
 =?utf-8?B?U3R6cC8xYzdKa2twUHhhM202cnlkbkhtOFpacGhpR3JEZlNYcHJiN3hsUWo1?=
 =?utf-8?B?NkxtYzltSlRlUmFGY1pjUHlPSHdMUkNWenJvaEZZU3NZZnI3c1d0dUx2aElE?=
 =?utf-8?B?aXJaU25pMW5rNkF1a3ZzNWUycFZUdDI1U1Qvd3p5ZkFxeW5VcURlc1h5b3hL?=
 =?utf-8?B?RExtZjdVVTVhM0huM1ZYZTh5SFNIWUc3WEExM3ZYQjl3SWZMYlBjeHlaRUJu?=
 =?utf-8?B?Y21lcjRQZ3BTSFZtLzREWVB3azIya2RFL2RncmhWbzFWM204aTBQN1R6MWNx?=
 =?utf-8?B?K2oxYUdoWHBKRjU3b0xIeVovS0lMa3VOVDJCYVg5K24zMG1PSnFkOERxajJ3?=
 =?utf-8?B?VXQwVWpzQ2JCY2NyQlBCNVIreXBIL3BUT2pyaWNibDJWMkM2L2UxZXNhZmpn?=
 =?utf-8?B?NkFhUkgrcjBwYnpoTDVZeGgxcGN5dldqNXNRSkFGdE5sNTJJajAzNnVZRnEv?=
 =?utf-8?B?SzFIdkgwZ3FES3haZmJKNEsrbXdoQVY0MHVGTUFhc2lVQUJOcjlFZTRieVlo?=
 =?utf-8?B?UzRHbEZXOTdBRk9xaHlSVjJWbjEvZ1NlMFk4TzE3TURpTWtxQno1cTBYbFJQ?=
 =?utf-8?B?YUJpVnUrMmdZQU5wa2JsMXQxMk1CNC9VakNPVkxoZ1VoeWZSTlBqc1ZoYXhp?=
 =?utf-8?B?MzREUHVRanlCbHJPcGJpOFJwTUh1V2E4V3A0WE1jak1QTS9RVktpQmRIQURi?=
 =?utf-8?B?aXBGTlZYd0NJdmJJanRHTTdsMTExTGRvR05BeE01WGxhQTRSQkJJVTgyYksx?=
 =?utf-8?B?K1VPMVhxNG1iQjZYV3k4ZXpzajh6M3Aya0owV3hFVndvRUFCNWROcXJlOTRu?=
 =?utf-8?B?NHNGcm5KdE93bnJSTDJxeC8wMmY2OGp3SWgzTVlDNHdwWTVIdHFUSmVkcExM?=
 =?utf-8?B?dTRHalcwVEc1WVQxWmxmZktyUExaNzF4N2JOdTZtOHVmellXVXBKOVR3a1No?=
 =?utf-8?B?dWdJOGZBN0FZRzROdkpSTzYvUnZFZDlYMVo0V1BuNllPTGd1NHJELzVVMUly?=
 =?utf-8?B?RlBic3ZqOHVyVysrMVJYTHRsMG5jdjhNTTgzWWl1K085dVFIT0EzVk84WDdn?=
 =?utf-8?Q?gCN6PuUrMC8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUhEWjQwUVI0akpuRHg3MHBrRHZsdGZNNXJVWHdEbGw1ZzBDZU9rSU1CVG9j?=
 =?utf-8?B?ZlRocmloRTloVWNpbSsyaEE4WnpLeUtSbEVwL0drN3J1Ri94dzJHV1hudmha?=
 =?utf-8?B?V0ErZzhmN1ZOS2tKVHA4QmcwN0ZPckYvMW5CQ29ZMkxqZWVLOGdTbXJLeW1s?=
 =?utf-8?B?TzlQbmxUT0tFcm03ODMrbEdkREp1ZTBKRXlNQmFCUXRyaGtQRzd3OTZzWmFQ?=
 =?utf-8?B?UXgwQVprNTg1RjFzZmNwYVlzd1NZaVYwZDZkNnpHaDV2SnlKaUdsT0pQNU5q?=
 =?utf-8?B?MjQzRzlZcmxtai9SbkFvMDFzSzFaQjN6WGJ5dTlQTEoycXNwMDRXV1B1ZDR5?=
 =?utf-8?B?OC9GdlZabkVpc0h4M21TOURCN1l2ZnVBenBQRzZIY3BzL3lEanV4RkRVY1kr?=
 =?utf-8?B?TTRpZ2EydDh5Q2pjdVZGcDB3M1BRRDVqVkVySWRKR094RUZzT01IWTRIU0t5?=
 =?utf-8?B?bmNoSlFqRGJISThEZ2h1UFlsYVZQQUFFTTNnb3ZFQXE4MGtNVGxrYnNlc1dK?=
 =?utf-8?B?VGpiMjhSMXpXeHV0QnpDYk1SUlNJRHZtREorRzBrSFVaQzZ2U0xMZnhENmEv?=
 =?utf-8?B?RE94Ny84TDZocGVFMm1UaDdPQWFUMjhwM0kxN0dKdUY5K0szd2dLZEJ1Q3hU?=
 =?utf-8?B?ckpYOXdYdXJNYU5reU5NTGx6T0tjLzNNeFYyc3BwbU50RVZVak1oVmtydTFX?=
 =?utf-8?B?Uy9RTVk5ZDdiRGRBaVpWMUwyYUJPQWIyN3QrRGg0VUROWElVc3hIVUJ5WXUv?=
 =?utf-8?B?SDhjZUZJSkh2eVFuWXJ5SVF4UXJTYjF6OG5LbFJCMHNacXFrcWR6RTJ6UHlN?=
 =?utf-8?B?M2hRTElvZXUrUGc2MFVOQ0xUcXUwR25RMzhvSzQxR2ZhOURHMUxvdjQ4OXhC?=
 =?utf-8?B?a2syT1RHVXhWRC9Wd2hMUXNJT2RVd3J1azdkU3FXVEpCTTlHbkdMM3BuNm4r?=
 =?utf-8?B?YWlQSERVS1A4OWZRL0tkOUZHcFRBZHZIWGtBQU5tRlBjTkRJNVFCVWR6OTBX?=
 =?utf-8?B?T3UxeGFZWXBCYzFBclBFcEQ1cjJtMmFSc2VTQTZvanZPZ3IzNU1MT0c3NXdX?=
 =?utf-8?B?OGNaZExUeVU5YXNjWVhEeXRsZEcvRmhPRWJ6Z1J5clI5NzNiaG04dTlDZ294?=
 =?utf-8?B?TEl0TmsvWndLVEQ5bVJYWmhDeUNSUXl1Ynh0dlVWVzFFRFBOS0FOUTBBZ3RF?=
 =?utf-8?B?U0M1UFEwL09aYllXVUxlcTNpYllEMVV1d3pFc2ZINjQwYWI2RFQwQ3JNVnFD?=
 =?utf-8?B?ZTUwVnFRK29PdXF0RUk1Szh2T0FMcXBSOSs5ZlNVL2srMVlXUktQMnNlRzhE?=
 =?utf-8?B?bGhKcjgwanQwN3BCZUxxM1hES2l0eDFCbG1qVEM5NFF6ZnJmNHhCUzdSUHUr?=
 =?utf-8?B?ZUxVNXcrclRHc3lac1VidFhWVHVpOUFmVDJWanRnSEs2LzF2Mlk0R3JMWWhk?=
 =?utf-8?B?SzN5dXgxQVRDMXMreVJ0OE1LZjRScUNrRXpXTHp1MVRzTWxqYWVNVFZWR2h5?=
 =?utf-8?B?SGlzR01HVVdJZnVWQkpzZk51NzhOSm01Zm5SK0E5R1hMalNMWUZGNjU2K05S?=
 =?utf-8?B?R2lOTUtGeHJ4NW1SMUdNa2g1WEwwRWk1Q1N3TGlYM0R4aHhKRTNwT1FWb1Nk?=
 =?utf-8?B?dlY5RTNhWEJjdkZhSzIvRTV4aVpObkh6QXFZT0dCZitvbC84MXl0T2dMeGNT?=
 =?utf-8?B?alBkQTdVRXorRGtxZHo4RkNOelptZzFockVjSWExK0FNKzdnRHhKTWNVUHN2?=
 =?utf-8?B?Ri9USXl6eWc4UTBJM0JpM2x0MTgydlU5MmNIOXdwUkJDc2owMzkwZjVHRWRy?=
 =?utf-8?B?UkhRWklrcHZMbWdtY2x2cU10L3Bjbis4QUVNc0JmWGlqeVVOM3IwbG8valJZ?=
 =?utf-8?B?ejRlSTlUWUZCM1BPRHprRktTRjRhMXNOWVpWUWRaakppOGQxVXpqV2wyaFlY?=
 =?utf-8?B?SmNJVEMwVDhqaFpjSy8rSEZwOGozZWd3b2dUMkdBWXdTRVZhKytjd3F1U2R0?=
 =?utf-8?B?NTBpb2NCUnhRWU9wT3YwM3FUa0xtZ0QxeHJTdjFqdEVHSGNiZGptK3FrRU0v?=
 =?utf-8?B?b1k4VEZMY2xhUUo5LzVUY094V3ZNWm8xVm4xU1dZU0dJUVUwb0p2S2s3RExz?=
 =?utf-8?B?UThJcWw3NTZSU1RlRy82clV0ZERjazdDUENKUlJ4L04xdWtBVDl1cmhJWTdY?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEAAEDCFA11DC34091FA5EF6C26307D2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9Wprwxco1iQO0HM5uMKMtURR6BYBR7qDjJco5PwqKjmeviviSEYN3X8LWeMFyp34+wVK4xx/POwNuAdGC+ooFC9LjVwBf0693gsAgmgcgsNUWb74EiS8BNOLxsTXXV5KW3DsYlMhUhA19ONP54cdBOHQe0yQW8KmkXk7uTDkaKn2V2tFh4exQHUSIDZr3yCkrhVA4IdeQCLMNPlNScNlIBU20s3S/aOqpmxJHieg2bc8DWyQhIhdUpUt1V9p/iUmLf+t11MlZUcErpImnJxvCBiAngLabin+1KOiSgCQlGkKI5zIUcL7VeA8wEKQa8vFCNtEJO6DMUdQtwE3DVeI5bBHVJ/OhUiTwknNtZmgslG/Gm0LAcqYsvirdckqFMvap5vbQHx/gGVIPdcfywx06Itlnqnj1pmWkpTycNMjD7yj0QGIUt4xufroYGz09f13DoLmWNS+2xJsFqViuAJZ1/ydNHh0wp4DL+y6fwCfBdOfJFc4k0u2+FzUh1r0WUtrUziqDKcn2is86QFRYENZv3zrxGLD8Te0OeZRdag6iCCjjGw8kk/6JStqM+T7MC98NZS4cT7SJ8LpzxGTo94VJYq4ISA0tVc0+yw7DSmEkpE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6c1772-b60c-4f06-9495-08dd5db6b063
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 20:28:57.8123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Kd54Nv+GWV6MnH5bX8fbmF9vVQJwtHt7LhP/xdW6eJyQNe4xgdp5Nvq8Gs4dylHdJXwyIKxQikk4Xnu0npk1O0cwriaJfgNxWrCnpcfE6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_07,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070154
X-Proofpoint-GUID: ujRmSzEFDfBI53MfE-9N-41AfX3gZ5Tz
X-Proofpoint-ORIG-GUID: ujRmSzEFDfBI53MfE-9N-41AfX3gZ5Tz

T24gVGh1LCAyMDI1LTAzLTA2IGF0IDEwOjE4IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVGh1LCA2IE1hciAyMDI1IDE2OjQxOjM1ICswMDAwIEFsbGlzb24gSGVuZGVyc29uIHdy
b3RlOg0KPiA+IEkgdGhpbmsgaXQncyB0byBtYWtlIHN1cmUgdGhlIGNsZWFyaW5nIG9mIHRoZSBi
aXQgaXMgdGhlIGxhc3QNCj4gPiBvcGVyYXRpb24gZG9uZSBmb3IgdGhlIGNhbGxpbmcgZnVuY3Rp
b24sIGluIHRoaXMgY2FzZQ0KPiA+IHJkc19xdWV1ZV9yZWNvbm5lY3QuICBUaGUgcHVycG9zZSBv
ZiB0aGUgYmFycmllciBpbiB0ZXN0X2FuZF9zZXQgaXMNCj4gPiB0byBtYWtlIHN1cmUgdGhlIGJp
dCBpcyBjaGVja2VkIGJlZm9yZSBwcm9jZWVkaW5nIHRvIGFueSBmdXJ0aGVyDQo+ID4gb3BlcmF0
aW9ucyAoaW4gb3VyIGNhc2UgcXVldWluZyByZWNvbm5lY3QgaXRlbXMpLg0KPiANCj4gTGV0J3Mg
YmUgcHJlY2lzZSwgY2FuIHlvdSBnaXZlIGFuIGV4YW1wbGUgb2YgMiBleGVjdXRpb24gdGhyZWFk
cw0KPiBhbmQgbWVtb3J5IGFjY2Vzc2VzIHdoaWNoIGhhdmUgdG8gYmUgb3JkZXJlZC4NCg0KSGkg
SmFrdWIsDQoNCkkganVzdCByZWFsaXplZCBteSBsYXN0IHJlc3BvbnNlIHJlZmVycmVkIHRvIGJp
dHMgYW5kIGZ1bmN0aW9ucyBpbiB0aGUgbmV4dCBwYXRjaCBpbnN0ZWFkIHRoaXMgb2Ygb25lLiAg
QXBvbG9naWVzIGZvcg0KdGhlIGNvbmZ1c2lvbiEgIEZvciB0aGlzIHRocmVhZCBleGFtcGxlIHRo
b3VnaCwgSSB0aGluayBhIHBhaXIgb2YgdGhyZWFkcyBpbiByZHNfc2VuZF93b3JrZXIgYW5kIHJk
c19zZW5kbXNnIHdvdWxkIGJlIGENCmdvb2QgZXhhbXBsZT8gIEhvdyBhYm91dCB0aGlzOg0KDQpU
aHJlYWQgQToNCiAgQ2FsbHMgcmRzX3NlbmRfd29ya2VyKCkNCiAgICBjYWxscyByZHNfY2xlYXJf
cXVldWVkX3NlbmRfd29ya19iaXQoKQ0KICAgICAgY2xlYXJzIFJEU19TRU5EX1dPUktfUVVFVUVE
IGluIGNwLT5jcF9mbGFncw0KICAgIGNhbGxzIHJkc19zZW5kX3htaXQoKQ0KICAgIGNhbGxzIGNv
bmRfcmVzY2hlZCgpDQoNClRocmVhZCBCOg0KICAgQ2FsbHMgcmRzX3NlbmRtc2coKQ0KICAgQ2Fs
bHMgcmRzX3NlbmRfeG1pdA0KICAgQ2FsbHMgcmRzX2NvbmRfcXVldWVfc2VuZF93b3JrIA0KICAg
ICAgY2hlY2tzIGFuZCBzZXRzIFJEU19TRU5EX1dPUktfUVVFVUVEIGluIGNwLT5jcF9mbGFncw0K
DQoNClNvIGluIHRoaXMgZXhhbXBsZSB0aGUgbWVtb3J5IGJhcnJpZXJzIGVuc3VyZSB0aGF0IHRo
ZSBjbGVhcmluZyBvZiB0aGUgYml0IGlzIHByb3Blcmx5IHNlZW4gYnkgdGhyZWFkIEIuICBXaXRo
b3V0IHRoZXNlDQptZW1vcnkgYmFycmllcnMgaW4gcmRzX2NsZWFyX3F1ZXVlZF9zZW5kX3dvcmtf
Yml0KCksIHJkc19jb25kX3F1ZXVlX3NlbmRfd29yaygpIGNvdWxkIHNlZSBzdGFsZSB2YWx1ZXMg
aW4gY3AtPmNwX2ZsYWdzDQphbmQgaW5jb3JyZWN0bHkgYXNzdW1lIHRoYXQgdGhlIHdvcmsgaXMg
c3RpbGwgcXVldWVkLCBsZWFkaW5nIHRvIHBvdGVudGlhbCBtaXNzZWQgd29yayBwcm9jZXNzaW5n
Lg0KDQpJIGhvcGUgdGhhdCBoZWxwcyBzb21lPyAgTGV0IG1lIGtub3cgaWYgc28vbm90IG9yIGlm
IHRoZXJlIGlzIGFueXRoaW5nIGVsc2UgdGhhdCB3b3VsZCBoZWxwIGNsYXJpZnkuICBJZiBpdCBo
ZWxwcyBhdA0KYWxsLCBJIHRoaW5rIHRoZXJlJ3MgYSBzaW1pbGFyIHVzZSBjYXNlIGluIGNvbW1p
dCA5MzA5M2VhMWYwNTksIHRob3VnaCBpdCdzIHRoZSBvdGhlciB3YXkgYXJvdW5kIHdpdGggdGhl
IGJhcnJpZXJzDQphcm91bmQgdGhlIHNldF9iaXQsIGFuZCB0aGUgaW1wbGljaXQgYmFycmllcnMg
aW4gdGhlIHRlc3RfYW5kX2NsZWFyX2JpdCgpLiAgQW5kIEkgdGhpbmsgb24gQ1BVcyB3aXRoIHN0
cm9uZ2x5IG9yZGVyZWQNCm1lbW9yeSwgdGhlIGJhcnJpZXJzIGRvIG5vdCBleHBhbmQgdG8gYW55
dGhpbmcgaW4gdGhhdCBjYXNlLg0KDQpMZXQgbWUga25vdyBpZiB0aGlzIGhlbHBzIQ0KVGhhbmsg
eW91IQ0KDQpBbGxpc29uDQo=

