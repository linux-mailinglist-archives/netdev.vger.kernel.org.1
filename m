Return-Path: <netdev+bounces-172519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE734A551AE
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 17:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1403AB2C2
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 16:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77B7230264;
	Thu,  6 Mar 2025 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y8Hit5g1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yjo9DSZ5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174922D4D9
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279332; cv=fail; b=RrWKibr9aX4Cz/ItWdQ/9q7lxmq/Y/4XFB6cADU+MTEGVk6wyMjjZxPTcVeEVlofy59CyyvbxKNHv/JBIVIXRWpDMpinHsVhH4mmX49BC710pV16oWsMggc5Vu52sTzY/Oov2gUmuP3C1i8fGF6WZVBTnGVDaWR2k7IW3eaglcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279332; c=relaxed/simple;
	bh=LHxl/WUYVRGg6L8sGlF5mdX3hYCS57crzkFE04G3UDo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kw8GnznvSsA4/bv0wqz0F5k+y10p8Y0oSOQ+RyaReLz/uyldgbYLOqeBlReg+yjRJ8uE3LDCkfIHLb8oTZJnyBPT9ve5WEzGixZf4++FRpRvQ/VwISf6QMUATpCwbSychrAOlIuC0w5m7/0xxxsYj86oyUyo7xudJk10QkV33ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y8Hit5g1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yjo9DSZ5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526FiKFt023480;
	Thu, 6 Mar 2025 16:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LHxl/WUYVRGg6L8sGlF5mdX3hYCS57crzkFE04G3UDo=; b=
	Y8Hit5g1D0TAsCmdDuTbhscdQF5MY7yvCql+ikcogrY2650nJ0+iqSiev7/MB6nV
	WHX0euZ4JSIXMhA1p4YVQNv9akt4DyADhkImnWEDUSf2Vui6c1EIRbq0ax4vAle2
	MWhAaNkO8n/etImwH+YCKgKa6REq+dKsKqNx5eWyyI/nVPaJ7bLEIrxPWmfRtlqq
	E1uANyBR+zCXUPSzL0ybCMCMh55fYvfJo75O6NBh5iBPdiwjdbarr/QxOBQkVDef
	M/LRqVLk/s0VFBcO82Fg7hkINtXnCvafgtPJZuiHM4SRhalmjDrB5cEsSWS+NQPt
	eR4qNDZz8XDscFGVBWu5bw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4541r4abut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 16:42:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 526G1nfW039093;
	Thu, 6 Mar 2025 16:42:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpd2bg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 16:42:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMt5LnvPmCo2h8n37yJzgNV1nD1KDnI1fs+/Gz9fX4SIsBylB+NWMszBNJu1EuRk3UlWJ7K9OXpG6d/Oobfzly54YkbytrrXawsdAks+96urdwOCeNodIHHk1qOa6+R+AyiR8HfzkAU4Yu7isxffSvdnPitSOiUvmcTpnFGdOaW5B2gUx1esQjcq+JuY7Dq6WGGKiq60ooa2lxpZdn1yAuzFDnDkQoirPNqK2EK953Ws7F1T/Tt2Vy9Kt56mc0INMzl9LYBSiHDiUI7ZfcLHiyjIctawSos8xWEnikAOD/3gN4g8M2eL7iao/7jB2jCeuzoyNUZro2qy/5oWf5yiTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHxl/WUYVRGg6L8sGlF5mdX3hYCS57crzkFE04G3UDo=;
 b=RpnkT1tmT87os7/thwpKQMqTR8q67YD1slQefag0A2aN2jatEZFnLaR+YRVAJs5p/S2zmx0m8P7yM5TmsZO4J8trGuiNEM+GVe47dnLgtS4dSj05G5dDiJKtOiIUY7KInOlugu9t0mtJsqYnoueR6L+GZEmsPm0mGRCz04S+3TFi5zEFIB4QwJ3kbmNiVWQlzLakPcyWzaqc1xNhTs8dJAhfEo5y28r29FVg0LfQI6Lq7jd0Fp+6M8NdjIGGtJzA2UFjg5MFi4R7bBgwG08exvNyNR+u1quS0B99LgWPNWO1gpjS0iNiUYcGIEi1lDvhWpjmk4QGtOWUDO3d3hKFDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHxl/WUYVRGg6L8sGlF5mdX3hYCS57crzkFE04G3UDo=;
 b=Yjo9DSZ54sM1Hw+MEOlCOUdeUOC4exRgjh2I2XFxG2ecPItOPzRB6e9bDAmOVnIGUv7Pg+3l4Hhx9+vCdmOCvSXWzIAveHNMOMG25f6liY0eaK9Bcy/bEiD3O9HzEcsgggb4iFzCJywKgrYc0TQKcPaeyk9TwazCo0if7Kq+dok=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by PH7PR10MB5721.namprd10.prod.outlook.com (2603:10b6:510:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 16:41:58 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 16:41:58 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 5/6] net/rds: rds_tcp_accept_one ought to not discard
 messages
Thread-Topic: [PATCH 5/6] net/rds: rds_tcp_accept_one ought to not discard
 messages
Thread-Index: AQHbiM/RTgDvu1dJ7E+uwv3Eh6wCe7NdbjcAgAjtgoA=
Date: Thu, 6 Mar 2025 16:41:58 +0000
Message-ID: <b39ede5348f56f90621746aae6cdde0dfe94ff4c.camel@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
		<20250227042638.82553-6-allison.henderson@oracle.com>
	 <20250228162148.3301b20c@kernel.org>
In-Reply-To: <20250228162148.3301b20c@kernel.org>
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
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|PH7PR10MB5721:EE_
x-ms-office365-filtering-correlation-id: ef050501-f78b-480d-84fc-08dd5ccdcfdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dEVwRmthVVNrdktKSG1pekI5K2kzVnZmU3B0ZEluRFpUNHlUbVNLSEJTWWRL?=
 =?utf-8?B?ZUJxczZwS0ZKVU15R1VYRTdpRUJ3Z253UllmMXFHWTNabmhad29oNEJ4Z3Vo?=
 =?utf-8?B?QjlXemg2WHBPUko0S04yMklWR1pyVjk5NHFmT0RxR1hqdFZkK2p4UXJrZG9V?=
 =?utf-8?B?WWpHTVIvWDJFaSs0NWZkTDFyUDUzOVloMTZ6cERSMFBhMlJjQ0RuMWtXZXZJ?=
 =?utf-8?B?czE5azR4b00xa0RBclNRRjJwRlE4TG1tZmVZbFNHaVc3b3U2MWFETm1VYmMw?=
 =?utf-8?B?ODA4VDN2V0ljV2l0Qk5odE1LemVJcVc3SCtIVEZHMDRDQkFFamx6RjI4d0Vo?=
 =?utf-8?B?L1lIOW1zZlZ6VjJrdnR6NWhJY0JtdzYzVnhDSXZnOFRFSVY3WlBjdVk2QmxV?=
 =?utf-8?B?STJNeWlidGx6QThCd1ByZ000NW9qV2V4eVduRHp5NXV1a1poTXZRYWlpZDIx?=
 =?utf-8?B?UUVKVC9SMDJKMXliUEQ4S2RoVEkrUmpxenM1RS9xWXFxb2N1dm42ODV0Tkty?=
 =?utf-8?B?YkpLTHdJWFFPUEY3ZkFsT3NBeTAvSFlaYVpiQUdNNTdFem41UGxpS3lqdWVR?=
 =?utf-8?B?eWlOaURrUFVzbmhXWHZiT0pIejc2TkpmbmgzMWpvYlMwandSTm0vRzJXanFZ?=
 =?utf-8?B?OTI4NUNVaDIrRCtkR0pOQWg3cEk1WVJEdExpbHhsTEpGWG8zanB4T0NvYlU0?=
 =?utf-8?B?OGh2bERsTlZwenpHYWh5bHZGSEI4SncxWnpwS1VzSHJhSG5jSDJtSENvOS9M?=
 =?utf-8?B?NnAvQ0dsdnBKTEFNdEpwVmNKcU5FQ1dNQXNqaWhJYjJ1bnhGbTJydXZNSE5q?=
 =?utf-8?B?V1UrYjBYMlFGTU40bThHekhZcEFVMlh0b3lCaEhTR1Z2Y1ZuKzVJQkN5R0l1?=
 =?utf-8?B?VWNyNVZsWGlVVTZSOTJvemdYS0Z0dGtlV3p0eEhrNlBRaVNqY2JnUGFCRGo3?=
 =?utf-8?B?QmUzbnpiVElPMFlnQlJ4QkNnQVF1MGp4VTVZMWxKbU84Wmg5NDY5bnQwQUpU?=
 =?utf-8?B?ZEZGL1FabUN4YjFJTHVLWE5xNDZCQUxyMzdUemxDNW55ckQrbEVwVEszakdO?=
 =?utf-8?B?QzJxaFY5aVlidW5lRENIM085WHJIQUsxTzJnaXBRNGFCUEVXVzRINXo5TFcr?=
 =?utf-8?B?SkdwdXRZWXRJZXMwaHRRUkxrcllTVUVEbEp0WEVWYlExZFcxNFBJV01HRFlv?=
 =?utf-8?B?cFZmOGdxbk05ZTJjUXdXWXpXekdJeElFY3JDeGV0cnR0bkpOL2dWL3A1NU5B?=
 =?utf-8?B?ZmpVbS9Nb05QanZyVkVSN0FDcElwR0ZTbG9OamlLSkFlakd4b1VFeGpncG5l?=
 =?utf-8?B?aDdJQk1FU3JVQzJFN1lkL2hCSlhTQldReTRzbzQ4NnJmSitOWDJTQjVvb29x?=
 =?utf-8?B?T0JGSVkxM1NMUitMWk9YWEErTmVwaXA0Y2JTdG01VG9kNUFMeHQrVjB1SUFk?=
 =?utf-8?B?VWE3MXR5SldSRzlhamNncHVpeEp2bGhYK09pelo5ejR4bTVVeDhlYklYTDBH?=
 =?utf-8?B?UXFYMktxNjFXcjdiRlNwOE5DSERLQ1MyNjQ2a1l1ZzRPRHI0OC8wbWZDdFRE?=
 =?utf-8?B?cjdSVWJJOFhJcVpFYTF2UlJrR2RhTGRrRS8yQm9zMjF0eTVqSmFvMk1hczRZ?=
 =?utf-8?B?aEl0a1pMWmpYUkZVeE8xQjNrQ2xlNXFGTDhIeStLcjVNWkhNeUJyejBRYXJW?=
 =?utf-8?B?RWtEdnZmSmFpRW50OHd4NmFMWU0wa2I5WVliTzEwN1ZrWVZhL1VlTzR0Uno1?=
 =?utf-8?B?Q3FmLzlxa3VGbG52VWxqclpvZzkxK1RhM1gzYnBVa2FBR3RtQzFyN25LSDE2?=
 =?utf-8?B?Ulk2NForVFYzZjYvd1Y5bVROeHRweVJGM0tMdGNyNzd5V2QyUFJhdjROZmls?=
 =?utf-8?B?WGcxeFpYNHVQdFpaMVlOR3FuK0U3L3hnTWs4Znhwbzg2UFlBSDJNQTYvT016?=
 =?utf-8?Q?7I5sd9P1gP0epQW8UgHVay1lvVRgfkBW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkxrQWFlM0M2QnF4V3ZVMTArZFpaYk1jeDFaalBPZDc1UnFQU3dmL1FUYitG?=
 =?utf-8?B?TGNQVmZpeU1jSFRadWhKVHEvUTdoK0tPM0RsWmlna0Nobk9OWmlFMVJTYVl5?=
 =?utf-8?B?RzZ4Qm1MTEZBMjRuVk45UDRjcEFROTFvK1lVWmJ2NHdNdTJlSjBQaVM5SzBU?=
 =?utf-8?B?cGlLbVg5VklCZUkrRGc4WTlvbVZyMkhIbDN5Y0RUSm1sWUV3Z25PM0NDZXdO?=
 =?utf-8?B?WDhBT280NHl3Z1VwQVBHcDAvbkdpOGJ2ZWkrYVJ4Z2hFR3plN2hLYXNMLzRG?=
 =?utf-8?B?U0RWVWo3c2xOcHpmYWo5N1dXbnhtYlF1cU55SE4xVTFDMFgvZ1FmZEUrUDZT?=
 =?utf-8?B?Tmt2V3F0SjB5SWNaM2RNSzE3N0hDSHFFZi8xb09ESU84SG5zbzNpTmZLc0Nz?=
 =?utf-8?B?WG00c0RkUTQwVWVEeGlYVFZCZXBXWXpQWDNCK3lLVDV2T09SUGZjMVVZVGtS?=
 =?utf-8?B?WS9QZ3FrOW92YUZvSGlHOEJBL2x0RFl3cUVXdU9aYS9UQTQ0cTN0VEcveklj?=
 =?utf-8?B?dEtwbEFLUGkxMmFKUlJGaEFiQmk3NUMwbU1KYXBBMGRZNGhpdFNZQ1pCc0Y1?=
 =?utf-8?B?R0o5OS9qSWNVTkJVNWxhRWIrWUhlYzJYekg4MjlsNWpNa1FYL2Y3c2dUYyta?=
 =?utf-8?B?c0hkT1cxWkFHSnViT25VM0RiVmxQa1h3YzA1Q1lqckFWVmpMTU1xZXF2WWpp?=
 =?utf-8?B?dlhIVUFKMEx2VUROWGFJdGk0d1FiOGV2eDFFU2dXT0ZValhOUzdqSFlsWDVN?=
 =?utf-8?B?OUU0dEtlS1RsMU5VUWFhL1Q1UkNvM0NXYXFKS0JZNjJRbllMNTlxYnNHZ0lB?=
 =?utf-8?B?cEcrSi9mZ0RNN095ektpcWJVdHBlNXFUbmRZbklJZGhDRkswQlJ6WjY0MWlX?=
 =?utf-8?B?VWZUTEtld1U4bHRQcFpHRTFTODgyRmdxS3J3b0RPK2pMOXBucDhPRS9HdlFm?=
 =?utf-8?B?dlQ4SytidE44QlJTSUVDc1VETzdvcHo3emdUZEk3eVJkblNkREhKOWNyL2Ew?=
 =?utf-8?B?L0IvTzUxbW02UUNNTVpZU3FCYnB2U1E0UUVvcUNzZTYybVgvRDczV1FDcjBh?=
 =?utf-8?B?VzhOb0oyZ0xqbXk5eXRuL21QQzNyNUZ2SGJTczhQeU9BRTljeXEzdjkxQ1Zx?=
 =?utf-8?B?WFB0U2srMHVtS2lqWU5zOW5PRyt4NkVRMFd3TVcrZFVTVDdjWFZadmVuOUE5?=
 =?utf-8?B?cGV3Y21JUFlIQ2NTNWRVQm1MTWZ0clBrK0xJMVh6bWhNSU5BOTFEYm5HRXZQ?=
 =?utf-8?B?RGZKR1VTSG51VElwTExZUlRGVEQyNUlqTGhOdXVZcGlqbGJyTGZvVTlQOXZ1?=
 =?utf-8?B?Rkw0SE5ld1c0NWw3M2NkRU0rQm9TdzBnYU5yQlFNS3FucDhlWVhwVGJMemJG?=
 =?utf-8?B?eFlCWnRCNzkrZW8xSTBVTGQwVGN0NGMxNFd2eHY4Tk5JUzBmUDJ4bE5mZ0Rx?=
 =?utf-8?B?cGFaSnFaMkkwR2ZkbUxxcS9ybEdaTFM1c282QVlDbTFOZVVsRFZXNUUyMkRI?=
 =?utf-8?B?QVVxUkMybmlKNmlEdGQ1TUQvUDIzUTYrN2tUYzV1ZGhCRWcxaFZIcUIyWnlX?=
 =?utf-8?B?S0Nxb3pHRFdTUTh1RXNUZ0lsQStJVGFZZDV5Uy81SGdldC9yTG1PVVZQOHVt?=
 =?utf-8?B?enJXTU5nZmZlRGlnQWw1NEFtZE9neExvSmM0aldIamdON2NRTkcxUm9FU2NF?=
 =?utf-8?B?QjEvaVUrOG1MaVlyRmZIS2VJLzRtR0lwYnBRMUh6d2xjOFRwcUIrZFR4MTZh?=
 =?utf-8?B?dXQ5WVdROTU5WVl5STVKM255L1E2UjBzTFNxWmpuY2FldUxrUHFBZWdPWVlw?=
 =?utf-8?B?bWt5OGVJOWgxRnBrL1ZTNHFoMko2MVk1aUMzWHNRdkpXRjUyVUFvUTVkeCs0?=
 =?utf-8?B?aUtxSDNXNnNuc2djQ29sN2dIbXI0NnRuSkxOZ0hCR3hGb0w4eFYrMElNaElV?=
 =?utf-8?B?Q2xMNStnUFh2d0duZXcxS01md3IvMXZYenBnREg4UE9RbW0zSTBYT0lpUGFT?=
 =?utf-8?B?Y2lWVERKVTNKdExjUWdxZ2l4ZGVLYnlXa3pTTjBLOEIxR3MyQVR3UU5RdHJt?=
 =?utf-8?B?UXlJQXBTd2x6ZVhYeW00QU5lVXNLWGQ4cVE0ZGJ2SW5LVlNDejBzZUQzTGs2?=
 =?utf-8?B?VmhiU0Z5Y2dxRk1LMVh1OSs1Kzd6QmhVblUyUFZudUdyVXJ0eGtsT2RORG9l?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25C93EAB57DB8F4082D04C3BC1CE6371@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cqtPrQ3nU/5c6XM0dpGx91lYQWvKkj5YskZvJEJkjb4XqH1/9PwUGbLj5DfKFcDazNGstcjc/j6N464de/RjwqJ0mnbukl9N12bEbgCp+n+m3mfofhfwIzFWhAL4O+Vhcgb/SIXPcNhXkStZDgFW42/bZjZ8pIXIsi1BjeKJDTlBL8dm52/jHtsPuzMbHNWlvoEIo/yOyfcYdR3JXtEM9qOnE3lXJhNebhkni9dUE5HIzoaoYbUTYmu5EoIPtResv+slPh9yyeB7GH2EralIVdgO9k9yMie20OFJLfUBm/zpQ9166+TlA0VOyOpwtpXACwWelDTeZE5pqHY6G3R7G/rJutpKTdPBn4Q5EzW4IS0G/rdyV4G62RO/c98Ke2onKGNzWm8wPqfgILEHSWwY9FkcAcACUstXu+6UknS9QAkgmHBr1n/QzaAy5aXp1VxapnwEqR8l1UAEaJmOqA0X3Sxptg1k05Mtduttdhd6p5uJNUMSQd02jwzNyvkNzdL3OUOfS+pg1pEjwYUoIfkMddnHlwM5kPSf/VhGskMpZQ7ESSqVQaCq9Q0RNOYMdRlGxFwkafXF1yiRjxih/7gYOlofKIhS2LBamh0JL4veFDs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef050501-f78b-480d-84fc-08dd5ccdcfdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 16:41:58.1651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cLpSVdJP6Kixn27rXgJ+Ph/ccRjcQa8FzVtiBdpS2sC2Zo9rDDtM9c5fr7v3N2GwRvjBiuc7mA36RGc/f+XP9HdTwREHJdhFTZlJ454AOLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060127
X-Proofpoint-ORIG-GUID: HWWeUgSEjjUrJrHMGJN42nk-B7Xreizn
X-Proofpoint-GUID: HWWeUgSEjjUrJrHMGJN42nk-B7Xreizn

T24gRnJpLCAyMDI1LTAyLTI4IGF0IDE2OjIxIC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gV2VkLCAyNiBGZWIgMjAyNSAyMToyNjozNyAtMDcwMCBhbGxpc29uLmhlbmRlcnNvbkBv
cmFjbGUuY29tIHdyb3RlOg0KPiA+IGRpZmYgLS1naXQgYS9uZXQvcmRzL3Jkcy5oIGIvbmV0L3Jk
cy9yZHMuaA0KPiA+IGluZGV4IDg1YjQ3Y2U1MjI2Ni4uNDIyZDVlMjY0MTBlIDEwMDY0NA0KPiA+
IC0tLSBhL25ldC9yZHMvcmRzLmgNCj4gPiArKysgYi9uZXQvcmRzL3Jkcy5oDQo+ID4gQEAgLTU0
OCw2ICs1NDgsNyBAQCBzdHJ1Y3QgcmRzX3RyYW5zcG9ydCB7DQo+ID4gIAkJCSAgIF9fdTMyIHNj
b3BlX2lkKTsNCj4gPiAgCWludCAoKmNvbm5fYWxsb2MpKHN0cnVjdCByZHNfY29ubmVjdGlvbiAq
Y29ubiwgZ2ZwX3QgZ2ZwKTsNCj4gPiAgCXZvaWQgKCpjb25uX2ZyZWUpKHZvaWQgKmRhdGEpOw0K
PiA+ICsJdm9pZCAoKmNvbm5fc2xvdHNfYXZhaWxhYmxlKShzdHJ1Y3QgcmRzX2Nvbm5lY3Rpb24g
KmNvbm4pOw0KPiA+ICAJaW50ICgqY29ubl9wYXRoX2Nvbm5lY3QpKHN0cnVjdCByZHNfY29ubl9w
YXRoICpjcCk7DQo+ID4gIAl2b2lkICgqY29ubl9wYXRoX3NodXRkb3duKShzdHJ1Y3QgcmRzX2Nv
bm5fcGF0aCAqY29ubik7DQo+ID4gIAl2b2lkICgqeG1pdF9wYXRoX3ByZXBhcmUpKHN0cnVjdCBy
ZHNfY29ubl9wYXRoICpjcCk7DQo+IA0KPiBUaGlzIHN0cnVjdCBoYXMgYSBrZG9jLCB5b3UgbmVl
ZCB0byBkb2N1bWVudCB0aGUgbmV3IG1lbWJlci4NCj4gT3IgbWFrZSB0aGUgY29tbWVudCBub3Qg
YSBrZG9jLCBpZiBmdWxsIGRvY3VtZW50YXRpb24gaXNuJ3QgbmVjZXNzYXJ5Lg0KDQpIaSBKYWt1
YiwNCg0KU3VyZSwgaG93IGFib3V0IEkgYnJlYWsgdGhlIGtkb2MgaW50byBjb21tZW50cyBmb3Ig
dGhlaXIgcmVzcGVjdGl2ZSBtZW1iZXJzIGFuZCBhZGQgdGhlbiBhIGNvbW1lbnQgZm9yIHRoZSBu
ZXcgZnVuY3Rpb24NCnBvaW50ZXIuICBIb3cgZG9lcyB0aGUgYmVsb3cgbmV3IGNvbW1lbnQgc291
bmQ6DQoNCi8qDQogKiBjb25uX3Nsb3RzX2F2YWlsYWJsZSBpcyBpbnZva2VkIHdoZW4gYSBwcmV2
aW91c2x5IHVuYXZhaWxhYmxlIGNvbm5lY3Rpb24gc2xvdA0KICogYmVjb21lcyBhdmFpbGFibGUg
YWdhaW4uIHJkc190Y3BfYWNjZXB0X29uZV9wYXRoIG1heSByZXR1cm4gLUVOT0JVRlMgaWYgaXQg
DQogKiBjYW5ub3QgZmluZCBhbiBhdmFpbGFibGUgc2xvdCwgYW5kIHRoZW4gc3Rhc2hlcyB0aGUg
bmV3IHNvY2tldCBpbg0KICogInJkc190Y3BfYWNjZXB0ZWRfc29jayIuIFRoaXMgZnVuY3Rpb24g
cmUtaXNzdWVzIGByZHNfdGNwX2FjY2VwdF9vbmVfcGF0aGAsDQogKiB3aGljaCBwaWNrcyB1cCB0
aGUgc3Rhc2hlZCBzb2NrZXQgYW5kIGNvbnRpbnVpbmcgd2hlcmUgaXQgbGVmdCB3aXRoICItRU5P
QlVGUyINCiAqIGxhc3QgdGltZS4gIFRoaXMgZW5zdXJlcyBtZXNzYWdlcyByZWNlaXZlZCBvbiB0
aGUgbmV3IHNvY2tldCBhcmUgbm90IGRpc2NhcmRlZA0KICogd2hlbiBubyBjb25uZWN0aW9uIHBh
dGggd2FzIGF2YWlsYWJsZSBhdCB0aGUgdGltZS4NCiAqLw0KDQpMZXQgbWUga25vdyB3aGF0IHlv
dSB0aGluay4gIFRoYW5rcyENCkFsbGlzb24NCg0K

