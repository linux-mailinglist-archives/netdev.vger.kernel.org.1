Return-Path: <netdev+bounces-184397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763F5A95379
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 17:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEA316E82D
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 15:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307D21448E3;
	Mon, 21 Apr 2025 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PJXbVlJb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ufmWzqSA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6075CC2ED
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745248598; cv=fail; b=ZHqNttopp/JKi3ChLX7Xa6rNSEEACXgVGak1x3ilp9t1uzPqTcHMWmAtLhq52pAPBQJkAKtMrIII7fP0vJ2p3bn89ap97qkMigeSrJz8f6Xg+lTN5QfagU1PWz0CUjZ9Nd90HCy5wbk+UKXBCtych01dL6DdbF1CD0eMJxiC+Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745248598; c=relaxed/simple;
	bh=wHif3ceHZ/PuXXUWQ5S928yNSjlsChzOU2Nac99PHsg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CkL6/t91nFO9ZYJa8QIqXEs1NWYPq+vrOlWhY2Y2bGcYb6WkiMimTn/iKyzuzYg/cOHPbKyKYM5Nr0IcKqYCUPgjgeEgnQ8jfw0cprn8+iMy+JaBvEqcIcgge3IOAFE36qwW40ot0BVPiLhx4Zx9qZ+Jmubz8hwq3qFuN66uAWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PJXbVlJb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ufmWzqSA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LCAlr2010754;
	Mon, 21 Apr 2025 15:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wHif3ceHZ/PuXXUWQ5S928yNSjlsChzOU2Nac99PHsg=; b=
	PJXbVlJb9U4LI6Y4gY8LDJtjJTMOPImkuZzjsLxk+ULGeNSXejdwqNc8WLE9mMQ/
	0dO3NOQ1ThDcd8ZO5FpOU5Eo/16QVx+fze9zm5cj531mHPKnUwGDwZhvKp6KN6po
	D4yiAQ2S7fqb+IeQL9FUOZhIHrLS+WR6vbCWS6JtDN87qWHkpWpd79c4NmJM8+Wz
	rxat1U8u1XTvTJTq2whFdb6gCqdC6Dd4mCHHmPyGn00VhaCHPpgCkKsT3aab9g3B
	WDaXLCEPjqzuGzX+C8ONsTIN35AbOQShhbMnTNFehRUA78TUmTLGH5rjKJP5Mgoi
	qQuv9IfJx6bueX6TS5kUGQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46428c2pgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 15:16:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53LF05OE033493;
	Mon, 21 Apr 2025 15:16:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 464298560n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 15:16:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eA13GAc+nRXvneJTIqtHsIxOMYU9WSImmLywy2b+2vAUHY64Vmqx2tRJl8KeWuSjnJPAaZzbL6+h5QXUU2/hrPvkahrmStejNt3tE+wX+8COhrF44nhc4YWnwuQtOKYsCr1ju8XB2ex0wGNtVb+8jgdpI5kMqXvcAoei9JvT7QwgHumgdVfUOJ4qYLyAYVvxV75xr3x4MMGU30q6KZJbsCjhkM+HvZ3ome40P0cWlK0WHTZS3Bb7GBdT2e+CzAw8pbNOLylzHtwvoSHVrFvlqD/DRU/vD5bdy/sO7YmP6jtq7daqTgMAeVXj27x1gF0y1MAG9iam4QsQb4DQcv7HoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHif3ceHZ/PuXXUWQ5S928yNSjlsChzOU2Nac99PHsg=;
 b=Dhfqmtdt+DUkUv2ETi4JriTOSmLEXvgZgBgYhUvlIq3SkZluXoqA/QgZEKSPR1RIyEBvyweE2s4Zg8Ad+lAd9TJyd5oeHjd3mlXICZmJtIaSk0WHNFoTEZ5cYukD2qNbFr4m3TGuZRgHFcjKLqksc/S00NmCKR+DTj4m/HacC3jRfREGsv02NoAFar6/MO1GYQNUjy2jaT/JE+MAWpeLFBtD/BLrQio8Ni+PPka0/pXJcg6wkBZYFqmGdidEEXSHC9bi19xjSy37D6IEC92gh+AWtm+Ga7fUHR553Z+oXIrLx7T8DbWhY10pWjrReVee+IvMPrWzk1JvT/cLGPRd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHif3ceHZ/PuXXUWQ5S928yNSjlsChzOU2Nac99PHsg=;
 b=ufmWzqSAmynPvBMuI1J4Xu9m1yes+eCbtT4xAK3bqTirFbuTfglE835Zz/rkNfpgNbkfJ3dnty4saSn+LCwhM7ta8dVy/r0YSkKhhmgv9bj76je8VSTGex/jYKTkXBqkJE/vrepe5zbDkhhHRQSOFdtelppP5SLlEwjRNmaC7Co=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA1PR10MB7596.namprd10.prod.outlook.com (2603:10b6:806:389::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Mon, 21 Apr
 2025 15:16:14 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%3]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 15:16:14 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 7/8] net/rds: rds_tcp_conn_path_shutdown must not
 discard messages
Thread-Topic: [PATCH v2 7/8] net/rds: rds_tcp_conn_path_shutdown must not
 discard messages
Thread-Index: AQHbqwvfJXd/WkqXRkujyEHfqVD/RLOnpUYAgAalRYA=
Date: Mon, 21 Apr 2025 15:16:14 +0000
Message-ID: <34980e572e114106be0880ada026e53d45660233.camel@oracle.com>
References: <20250411180207.450312-1-allison.henderson@oracle.com>
	 <20250411180207.450312-8-allison.henderson@oracle.com>
	 <20250417094708.GD2430521@horms.kernel.org>
In-Reply-To: <20250417094708.GD2430521@horms.kernel.org>
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
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|SA1PR10MB7596:EE_
x-ms-office365-filtering-correlation-id: 08ef609b-b43c-4f82-d663-08dd80e774f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkhpU0lQaW4rTUlZTnFvYThVVnZkL1ZWTjh6NlVRazlRN0s4dmUxWkVoaVpz?=
 =?utf-8?B?VGIvMmg0T2kwNXVFVUtKYjJnYXRLSG0yY0NSU0VhNTF3NGl0VXhWRFRUdHF6?=
 =?utf-8?B?QzJvb3h6dTdKUXNyc1g2VlNkS3F0Ny9uckhLQUlML003cFN3a2NXTFlLM29k?=
 =?utf-8?B?d29KZHc3MDJ3dHNYQ3NPT3VFaDBSK0sxZ1E5YW8vN05obURjOFo5K3dkZS9N?=
 =?utf-8?B?ZkdUN1Y5R0QzMzRrbXZkd3IyZFoxUXVLOXhHRzgzb2MvVFdjSjlUVUdUdmtw?=
 =?utf-8?B?Tkw4ZDVzSEk3K3B5MnNhSHBZakFzYkhoNEp4dW41aEZKaWFsNnJMck5KK1pX?=
 =?utf-8?B?VHNNbGhBdUVreGpJTDJwMFlKc29OMDVYYzRxdmRnUGhqM2kwNjFmTnFrdU9H?=
 =?utf-8?B?TkVGVDBPdzkwbWltNC9lQlNZRnlZV3FsRnZmczZEM1J0OTF3NzR3V3RRakdt?=
 =?utf-8?B?S09tUjk0Ymt1cVcxZEFCL3FiMHZJY0ZEQVdlZjNGbzZ0c1VoY2xSaUFEU242?=
 =?utf-8?B?OExYMlBtOCtETUVncksyM2xkWm5Xd25OaG5uUlM4TlI2dkFwdnkzK3dWU1FV?=
 =?utf-8?B?Q2Z0d2NBdUhrTUhEeDhJUEUweTN4citkUjRvQzZiTGUwcEpXeTdUalJZd3R3?=
 =?utf-8?B?aHNjcVFWVVNLU1JyUXl2YlgvZmQrTlJURVlyeFc1NGZteEROTG5sMkg2SW5B?=
 =?utf-8?B?QVl6ejQ0VCs1TlJGVGNDckNvc1JlUUxmeFhhTDB1OW56OEwwOGhtTGpSOG5n?=
 =?utf-8?B?R3R6MEtMbjJPTG4ydHptY0pCTHZuUU94S05TR1N5TjJWL3Z2dFpKeVFZQmo2?=
 =?utf-8?B?Znlrb1F2N2FzS0pvWi9SMHQyclg0WlNUMUpURTM1Q3k4UExGczdUQ2VIbXNZ?=
 =?utf-8?B?K2hPamhzMnlLa21JTzlweUdSbG96TXhOeWZWVXFRZXNiZjE3YW1yV08xekdY?=
 =?utf-8?B?cWhxM2JiR1VOdUNmWExGNnBicnVBUGFNS2hmZ0RQTTRhQVFCelpBWGFsZzRG?=
 =?utf-8?B?Z3BjQlpQRVdYbDVnVHJPcEVOOFhtclpKaFQ3MXZzVHV3Ky8ybFdnOG5JYkJj?=
 =?utf-8?B?c3RkekEzWmU2cHFNc3FuWnljeDVaWmVlQ3RacXZUMkozT29HejltS2F3c0lm?=
 =?utf-8?B?UFhpRVpMcFNZWGtkSWZpR1BWTUMzRXdtbjJNV2hDTDNSS2R3NXo1QmRWK2Fa?=
 =?utf-8?B?Skl2VlRaSHFJRXBUV1c0N25WWTZtMmZQR21ReHlwbXhINmtJZjFTMWgybVlw?=
 =?utf-8?B?ekpreVd6NlI5N25idTBud0RyK2hVcEpuZnRaNDhHY0g3bXR4L1FFblhHOWRK?=
 =?utf-8?B?RWd2bFFyWFRYUUo3bFZLY3M2OGlYL2lUUmJJQUc4MHhhOU9WTlRXSGVWTHpq?=
 =?utf-8?B?NDVnV2N0SXZ3MjF5WUduL09wLzNHNzlOTWpHdjdodnJHQVF6bFp1SElidUFJ?=
 =?utf-8?B?VERFMmNDdnZYbU82M2JNamh2cGhteWFXMElNY1VvZWh1QTlsQ3RLeE9oak9N?=
 =?utf-8?B?STF4WEd6eFp1TW96RUZkcVJib3RDbkpycGUreGduN1grTTRDUVM3aDNId3pC?=
 =?utf-8?B?cEVXM1BCenVmTGNmTDZEU21nTFJJTmpKUm9PRDBSQSt5bC8zSU5NN1BDN3Vo?=
 =?utf-8?B?b2RBOEJHTTBHNGNTZEplYkJmaHRyWnNVSWVaeWoreTRkR1dWV2NRMlFpdGpr?=
 =?utf-8?B?OE9IaG5NN3JuTVJEQzY1bW1DcHFXWUR5TDhicmFEaDJMN2wxTW5wT2pQeTlh?=
 =?utf-8?B?aUdWM0VBc1VuTXBkSjJTT0thWEh3RUpVdnpEQmhEL0loT0dvVnpiMUdrcnFL?=
 =?utf-8?B?Ulp3N2JyOGxha3ZHalFHVzdHd1VSU3dLcXZ3TlFIdWFjZFhLYUZzUTQ3SjVV?=
 =?utf-8?B?ZVJPb1RaT1NnZVJiVUhkVVZ5U3FyblVyaUx2akgrbnphZnpyVGY0cFFacXJI?=
 =?utf-8?B?UU4rZ1RzMUJxOTBabmlSb2NqdUJXWEZDZW5xRDhnWWZqSUxqN2tXVCtGaVpZ?=
 =?utf-8?B?enFRS3JTUFZRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODI4WisrQWR5UFVBZEx3RE1DNDZOYWtkQ0FvWFNVS2wxOXI3Mzdha3EwMTFk?=
 =?utf-8?B?ZmVBbmhicE53dGNFMVByMW5VOVFQTURHeEREVnJNcHZZV1NhZjRBVXBMWGxy?=
 =?utf-8?B?QlpxNFFzM3lNZTB3SmZkRHNRZDA2Qm1VLzE4c2Zsd2dicDZ0aXFpekxGRzUw?=
 =?utf-8?B?UGY4Y3ZybVpqNlFSNXpaYjBnRnh5ZE16NlRMZ09hTk44dkE5bkFGNXA1UU1a?=
 =?utf-8?B?dVJTZjlxLzVKR003enFIT1BjeEpJUzFYRFkvT3FqaUZCMFR1c05pYms3dmFF?=
 =?utf-8?B?cjBuSEdMRmtXQVdRdkRycFoxTk9WU0dLb1lxUnVIV1dTMEhkM1MwRGZkbGVm?=
 =?utf-8?B?MTA0ZTNkQWwveGZZZ3VsUFRWRmhXSFlVL0EvOXRERXZXWVkyZGZFR3ZudnpV?=
 =?utf-8?B?dURteDhZd3ZGNjV5T3FSQ1plNXFHeHEwcThaVHNoMXJkWFB6ZG5hQ0JRUzVB?=
 =?utf-8?B?UmVVNFp6TU5kbTNIaENDdW94aWNSYlMrdVdZOUYveWFSZEFEbllYWUxBK0ZL?=
 =?utf-8?B?clpYQ08rczBRT0FCL1pOczdiQ015RkRLRGlTOUtoMU5VZmR3b1h4TGUrUzdj?=
 =?utf-8?B?a3cxZHFtSFBHTlJhRUJWeTE2N2gwcWZ0aGg4TTdNOFp1SEZSQVA1dTJsRmxC?=
 =?utf-8?B?QldyNDBjbEVHNFU5UWF0bDdjTVl6Y29aSXpjNm1acHRJSlV4S3ptdUh4ZmZn?=
 =?utf-8?B?VUVMWVlUZkJuVTBWSTZZT3JhVEZGRXNZc1doTTM2OFFqUWJYRnNxN29Rb1M2?=
 =?utf-8?B?TFVhZG8xMWk1K09IWW45aGp4QmNtbzgxK21DMVhhRWwwL1RlUldtdTB3YStT?=
 =?utf-8?B?dWRobzhySSs5MkM4bVlrNlRFT1I1dTloYlozL0RTM0Qxd0t3WEpScHN2d1Bu?=
 =?utf-8?B?U3dpS1AwdWRYMmM4YytqZkRVcnZLL2Z1M3h6TDkwK2xsMUtQNHVQODBMK2dB?=
 =?utf-8?B?Qkw4U2NHQW8yYkZTbEhTWmRtcFhjM0xKSkZVd0FIOHoySmNVUHJKQ29ZWklr?=
 =?utf-8?B?ZW9YenhaK21CMmxiM1hKQ1NEbVV3N1MvN0RQUG5DUTJlMVVTKzBpQmprRUIr?=
 =?utf-8?B?TEgzYVhnVzRJd0hLeVJrNGNhZ01VdStmZmdHSzhyQVNPS1R3d3VNZnFkcFRV?=
 =?utf-8?B?cU0xSitDSE5HakJVU01QVGZpOHlYa3Y3VDZGckJLeCtPKzhyOHBGNTVrZDBQ?=
 =?utf-8?B?Y1ZpdU5ubGcvWGNyLzRvZ0ppQTR5Szh5dXJXWkNydFE5Rysra0NaOUE2cm9n?=
 =?utf-8?B?TTRYaDBNYmpwRk01NWdNTDFVeDB3cEhyUUlFc3E5d0d5SGdzLzBqeWNBZTMw?=
 =?utf-8?B?SHcrU0NsQ21Dc2FheHdJNFk4U2wrZ1Vsc3BvNmN6V1N3MXRZYkV0QXp1bUdo?=
 =?utf-8?B?UXpBNE84QnY2bTBkZ29KT0NPUVR1N1hHTHBsVURTaHpMTkNOTTBDSEpvRTZQ?=
 =?utf-8?B?Ky9pdHRzaklqRDB3VEwzQkhYdEplL0MvZUVDWG55UmRuQzd4QktpQTE2REdp?=
 =?utf-8?B?YUpHK1JpQjkzYjh2YjRWaGtsZjRmemtyNnc4cWRXeGM3Q3ZRNkRrTnhzNjhD?=
 =?utf-8?B?bEFDU0ZpQ1hRTUNtSVJhdzYrWXQ0NEprbmFOdFFKREtEMFNkbVpDRVFUWit1?=
 =?utf-8?B?TTcxVWYxNTF2cHowdUxFcHlaUGhra1JTMDhzeXFsbTlHSHUya0NEQTBucUVm?=
 =?utf-8?B?WjNtanFidzVXQ0RJaGJQYzk0azBPaloybFN5N0ZXTWx1dUZhVm1uRGR6a0RK?=
 =?utf-8?B?Q2hUWktPZHRaYXNEbnk0alVTMEhHMi9DY1lRMXh2bjd5cGY1dkhPbWt2V0ZR?=
 =?utf-8?B?b1RyNHpDdUJDV2hwS1ZwMmZmMFM0UmdiWHJ5ZkVXanNSYmdnWE9WclUyWjRm?=
 =?utf-8?B?SXJ1MEttSlBBdXh4VndHNzJzQjJNeTdYaWZzU0xQN2Rza01ITE9tSFBSRDEx?=
 =?utf-8?B?aFIxTENZQ043b05GbkJIN2NTUlhPa2ZhTnNnR1ZxV21uZ3FLWm5LcmdtdkVy?=
 =?utf-8?B?WnVpdGhvdlQ1bVBlempWRmJTZVhUOEovNDNob0FpU25hYlBFWGNILzZaZnhW?=
 =?utf-8?B?a0NlNmRJTmVzNVQzVS96U0hPRnQ3WmdhdUlCMTJoN3dWei8zZ3IvNUFqUEpx?=
 =?utf-8?B?cDdoUGVhUDFhZWdzc1FSM0lSakMzZDZTY2xGeHo1alJVdWZ3OHVkb2V3TTI5?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <122F3D71FD50294593A88DB14C7B3CD4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7rIe4D1FxzVIXWX64yFHo/QFLmEcfwMNkqZBLjxhSRT/VRIB+RpTE26kyfuL7Lyu7aCsSRu8jBm7NWxRpEzIfA8eLR1Dzl6RUxsRpe2iGx3ZCf5Uz815nTO59G8itVtRSqxysA2EQhvvYY0DpOoLL6/6SL1BSFSEwlGAU3XJpdXya5qcNusKm5IodDpXNHaEy/4MX4/bTQk5w1V3FlqSSB4UlG3bupHAdB/fx78RS+60vvLlcYk2sxdkK7giCD7lyVkuR9yLkJNilabk8ODNqlbnPKl33vxahW8eDUD2/ubgmZwQhU1wAnCpWLasxfOYqz/H2OzM6z9fpk0v+vWY80/h+QFaj107tKNgyIR9q4qq1msj5klnrTdXRNlwTBIo0vJgp/wGkYnSBo+5SZnMBAvJkbNXSkA9yiTZ+i/nIrtC/atI4j1ArEYD0c7W0AQqOuQ6xXr8Kt3fRIHlJnBYzxyGaTSbDBDMcO5umLeBGTm4mq3xIfygoS7uPcTgi+KUVWAFI1btxrM2gaS31KYagrg3rqjvnO6Zb/byM6ML8Dk6dVORE8AQ0Ih04AK1rzH9wpTO5wEvB5o3XnUmj/uvQtLr8aYjpfm7SskmSbmb+bg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ef609b-b43c-4f82-d663-08dd80e774f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 15:16:14.4537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9cVGAXfhmdAt8Jb6LWAHKosEQu3mxcDBOqbMmhBhY5RNBycqXhHiOtdXDpW73nqS2XMwdZvhkvaQXJdWX599pFzRDjkHlZgyA1mWGyjvYf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_07,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504210119
X-Proofpoint-ORIG-GUID: lPKwABvTi3ndZVM6srM9mCQULUG_h3mB
X-Proofpoint-GUID: lPKwABvTi3ndZVM6srM9mCQULUG_h3mB

T24gVGh1LCAyMDI1LTA0LTE3IGF0IDEwOjQ3ICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IE9uIEZyaSwgQXByIDExLCAyMDI1IGF0IDExOjAyOjA2QU0gLTA3MDAsIGFsbGlzb24uaGVuZGVy
c29uQG9yYWNsZS5jb20gd3JvdGU6DQo+IA0KPiAuLi4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL25l
dC9yZHMvdGNwX2xpc3Rlbi5jIGIvbmV0L3Jkcy90Y3BfbGlzdGVuLmMNCj4gPiBpbmRleCAzMDE0
NjIwNGRjNmMuLmE5NTk2NDQwYTQ1NiAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvcmRzL3RjcF9saXN0
ZW4uYw0KPiA+ICsrKyBiL25ldC9yZHMvdGNwX2xpc3Rlbi5jDQo+ID4gQEAgLTI5OSw2ICsyOTks
MjAgQEAgaW50IHJkc190Y3BfYWNjZXB0X29uZShzdHJ1Y3QgcmRzX3RjcF9uZXQgKnJ0bikNCj4g
PiAgCQlyZHNfdGNwX3NldF9jYWxsYmFja3MobmV3X3NvY2ssIGNwKTsNCj4gPiAgCQlyZHNfY29u
bmVjdF9wYXRoX2NvbXBsZXRlKGNwLCBSRFNfQ09OTl9DT05ORUNUSU5HKTsNCj4gPiAgCX0NCj4g
PiArDQo+ID4gKwkvKiBTaW5jZSAicmRzX3RjcF9zZXRfY2FsbGJhY2tzIiBoYXBwZW5zIHRoaXMg
bGF0ZQ0KPiA+ICsJICogdGhlIGNvbm5lY3Rpb24gbWF5IGFscmVhZHkgaGF2ZSBiZWVuIGNsb3Nl
ZCB3aXRob3V0DQo+ID4gKwkgKiAicmRzX3RjcF9zdGF0ZV9jaGFuZ2UiIGRvaW5nIGl0cyBkdWUg
ZGlsbGlnZW5jZS4NCj4gDQo+IG5pdDogZGlsaWdlbmNlDQo+IA0KPiBjaGVja3BhdGNoLnBsIC0t
Y29kZXNwZWxsIGlzIHlvdXIgZnJpZW5kIDopDQoNCkdvdCBpdCwgd2lsbCB1cGRhdGUuICBUaGFu
a3MgZm9yIHRoZSBjYXRjaC4gIDotKQ0KDQpBbGxpc29uDQo+IA0KPiA+ICsJICoNCj4gPiArCSAq
IElmIHRoYXQncyB0aGUgY2FzZSwgd2Ugc2ltcGx5IGRyb3AgdGhlIHBhdGgsDQo+ID4gKwkgKiBr
bm93aW5nIHRoYXQgInJkc190Y3BfY29ubl9wYXRoX3NodXRkb3duIiB3aWxsDQo+ID4gKwkgKiBk
ZXF1ZXVlIHBlbmRpbmcgbWVzc2FnZXMuDQo+ID4gKwkgKi8NCj4gPiArCWlmIChuZXdfc29jay0+
c2stPnNrX3N0YXRlID09IFRDUF9DTE9TRV9XQUlUIHx8DQo+ID4gKwkgICAgbmV3X3NvY2stPnNr
LT5za19zdGF0ZSA9PSBUQ1BfTEFTVF9BQ0sgfHwNCj4gPiArCSAgICBuZXdfc29jay0+c2stPnNr
X3N0YXRlID09IFRDUF9DTE9TRSkNCj4gPiArCQlyZHNfY29ubl9wYXRoX2Ryb3AoY3AsIDApOw0K
PiA+ICsNCj4gPiAgCW5ld19zb2NrID0gTlVMTDsNCj4gPiAgCXJldCA9IDA7DQo+ID4gIAlpZiAo
Y29ubi0+Y19ucGF0aHMgPT0gMCkNCg0K

