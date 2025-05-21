Return-Path: <netdev+bounces-192401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF4BABFC2C
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 19:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248109E4777
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 17:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8973280018;
	Wed, 21 May 2025 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bzy2xD+n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gIA3c6DA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24676289813
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747848086; cv=fail; b=WMRaN2afEG8S0OmkevPGu9vkqUJh6rL03iabwt9Vi8Bu7U5sNaldfDoF+T5uWIa4FeOo2DlVtRBOCn/GrRJ/xNpgB+M4MUOowKlo7RH+5dU4tqtgLjqMkQHyh1KnfOt0Y1L+eZdYjGuxnPxnYAEt9nA+wAKqiJ4i5AGpDQtuBZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747848086; c=relaxed/simple;
	bh=/Fef02iF7CRWM6+EOvMp3PllTuPHPNyJpD5xE9pESMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mGOhEFOru8ZWg+WEQHlxjGxZG8JZxxYqAczX2kijpeNy3KU85Uu07HJv+6Po46eukj2HT5fy+W1D3TPNPbutEGXlx+tYSbsLxQNVjp3DdgaFq8iKhJV0TOw+NJsN6T5bz7mX+ZDvRIIC2uM1rRXV9CCSGN91R2s7kWOx4ngs9pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bzy2xD+n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gIA3c6DA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LH6jZS030755;
	Wed, 21 May 2025 17:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/Fef02iF7CRWM6+EOvMp3PllTuPHPNyJpD5xE9pESMw=; b=
	bzy2xD+nJHL/En9iwgn5hIzfuJB8ZvIRSbaSuCkkS73T4e+x1MitOJqyb7LF5wpp
	LdJrasCj2f2AKzEV0GsXfswqCt4SXeQ7GRxD4DrRQKF2FrBIUBRbyjaoGU6lKbDp
	/nmKKMILzZW4RQbucCie8zT1empJgM84PutQDuvo4OMJk/j/sFglFBcE1LswxVpD
	BzzWhh3j38D026N2fQ4p6IC965S4/818AklQ0urSIvtS+/2v5oVHq2DmElMDSCno
	tdqBM2hd0AroiLd1iEnQ4vqPiu33i4P/EzlrWDm5LVrRUAj+PKcg0vaayMHCA96J
	3EN0H4YaPy5xl9lFAhWPEA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sjxkr174-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 17:21:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LHC0xn020276;
	Wed, 21 May 2025 17:21:13 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rweu575w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 17:21:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwwUn9f/1Mia2w+TMWh/VX+5EsIqn72aizmrQxvgS4L9uiktL8J8+iweIm33SxDlaiF7iGt/dO4lA9QeqieNUUa+vYgaRQS1yrTwHbPzAfPXOqU2ByMx9/50ijeysm3vMQWPfreTnDkN5tVKJmc6/fmhj2N3PHWBiFq8XIX455F7H8gv5P+p42rmh1E2cld//i8bK+xv+w0TIk7lVeuHEgi95N+Nq7dcSf9Dzjy8ZLr8CfvK6G6dPyotwgufwX0W1p3afvunVw6VfnZZeGJFF8+HxC1sbuJkjPP257mDgZREnguYHjEk9l0bNil5UAa30uga7Y5F0b+28QxTxTJvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Fef02iF7CRWM6+EOvMp3PllTuPHPNyJpD5xE9pESMw=;
 b=kZUZHFUHEjHg7bd60489khxEELLSm1FXmJJGncDcfY5DczVIJumN9igeJ6dUZGeCyyVZfXIvhRVXd7IMxqSiYjbUmvwVyKCvgbWImmDNJLBM29P/nwbxzdR19Xv3LQeTM2GaqFmVCTXYJgh4oFujAW3e6/vZ1WITUswzaeLjo70Xnmy+7aJdJ/EaqEU5r8TgELZPLYNCOg3vI+uVAKXpniJ9PNboqApYOg/sh1PVck7mbGYXqc1+uxEX+/md0qeZFmW4q3fOzrarlOnLKXnaG7EqXRo38NwINxcwyuXeGpYc4jg0eQvOBakCi6j3O33aUCvf/M+6mfV79v1+Jih9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Fef02iF7CRWM6+EOvMp3PllTuPHPNyJpD5xE9pESMw=;
 b=gIA3c6DAJldeHJXCTn0R2YfUSVJvbMk2ETE8Zu/2m3RsKdLUPmBcf+OSmWO8FRjJjY8JqCAhkwIHCHgJS9L7snkyCCE3KUIBk45j1UExR4zrgnFWy6Y29egmpqCH5PomF2djgUXCnlAjZhPM2V0iz952jYmqMSHXnSRLA0ePPjA=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 CY8PR10MB7121.namprd10.prod.outlook.com (2603:10b6:930:73::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Wed, 21 May 2025 17:21:07 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df%4]) with mapi id 15.20.8722.031; Wed, 21 May 2025
 17:21:07 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "shankari.ak0208@gmail.com" <shankari.ak0208@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "horms@kernel.org" <horms@kernel.org>,
        "shuah@kernel.org"
	<shuah@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v4] net: rds: Replace strncpy with strscpy in connection
 setup
Thread-Topic: [PATCH v4] net: rds: Replace strncpy with strscpy in connection
 setup
Thread-Index: AQHbylAnWKag/qSEfEqrsufb39mT2bPdVNgA
Date: Wed, 21 May 2025 17:21:07 +0000
Message-ID: <f4230bbdccb082ad9dee651ccb51c8426ac0b753.camel@oracle.com>
References: <20250521055417.3091176-1-shankari.ak0208@gmail.com>
	 <20250521125836.3507369-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250521125836.3507369-1-shankari.ak0208@gmail.com>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|CY8PR10MB7121:EE_
x-ms-office365-filtering-correlation-id: e302b652-56f1-4485-bc73-08dd988bdf9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZDJINmx6bFJZV3I4eDJrMkpRQk5VMWUvbDROeUV2VDFEQ2FsakxXbWNGWFN0?=
 =?utf-8?B?OG15N2c2WDNsaCs5ZUdiMjNicTdUbmJIcjlLZEtERERuZnk3SDM4bGNybGpS?=
 =?utf-8?B?bG85eGpVN3dPZHZrK0pnOTdad1ZpR3JPZWgwV1lhcVVsTDNLcHFjckRPNzhs?=
 =?utf-8?B?RStDNDhSWGdYdTRZVHM4OFhZQ0duVm1HRDZKK1JHYW5XRnJzaDJSSjM2VnBa?=
 =?utf-8?B?Uml6QmxFcUNIRHd4L1kxM3FTYnV3SnhNN2ltd1luNjM0MndJdWVUYVFzYld3?=
 =?utf-8?B?UWJmczkzT2VnaStBUkJoZ3ZFZ0s4SkdTdmxhWmtDUDhvRm9EQjA0M3J3LzZC?=
 =?utf-8?B?Nm5tU3VJTGlqNEE1cTZaeURiZWlXSWNZMjRCOEMzQXN2Y3J0UVdpR1J6RWNE?=
 =?utf-8?B?ZVFUNHRSR2ZPckdHMUlMVzJFY0MzSVRXaEZqc296aG1tVEZta0JNdi9MV2RG?=
 =?utf-8?B?N2NNNmR5cHd1S0dvV3krNjlIUHRUYzBmclM5SjNHVkRNNWlkME9EQVpUanJU?=
 =?utf-8?B?aTdSQWs4Y1IyY0ZNNUdqYXcxTUJ6VkNhZk5NeHQ1L2FVYUdvbDdiM3BEUWhL?=
 =?utf-8?B?UlZRMmxyVi9HWWtrMDc3TGNweW56S3NzUHM3Ulh5NkFlUVo0NDhoS2dXcm9w?=
 =?utf-8?B?eERYaUs3dVd0VWtNOGxPR1NuQlVBTXlXY0tqWFRDVDJBM1MrYXZ5c1dMTXhM?=
 =?utf-8?B?OWk0Nk9vTU5wTGc0a3QrVlFacXdWK01UU0RLRTYxSEdBWG80WVkyZGFXVFNt?=
 =?utf-8?B?NTFwWXk3TGJ5bFlyUkpMMVozc1EwVHJkT05GVWZFaGtJMTNpWUZ6emlHUFVZ?=
 =?utf-8?B?MkQvREN2UG5KZ3QwWlFLYTJMcTM0OHg3V0Npaks4OTEwWDhtQUZUNmdlbVl1?=
 =?utf-8?B?Vk9wM291dDhnRENISFcxZEJSbmlUVnM0QzR3VVVna29kemM3bm83V1doVWQr?=
 =?utf-8?B?dFYwQjcxZlZxaTc0QkRqNlIzNWc1R201emVEbzl2T2xMRWQrcnRESVZvYWFV?=
 =?utf-8?B?aHZHaEpyQmlQVWZTQVNaelFxWk40a056NUVNK3RBcFk1S2RmYjJKdkZuYTlN?=
 =?utf-8?B?ZGRZeGJDcHFzRks5a1lSUnIxZ3VxVE9YYk5wTXR0WHp2b1lyUHE3NGdLczVq?=
 =?utf-8?B?TmhLbjNUVTVGQUtMU3N3OWZ4VFhpOURwdVRXbDZGKzdSOURiZWhnbEFkeXZy?=
 =?utf-8?B?S0s5U0xEN1c2clFKY2RjRnlPdTE2L2JpSFY2Ukw0Z3RjRGgxOXJYcGFKc1FY?=
 =?utf-8?B?TW1nOTJQT2QrSGJUMFBXOVVkTE9icmRKUjdOQWlrYUZPUFE0Zm9CSkNTNWYr?=
 =?utf-8?B?OEcwZTVpWlJaQnNYSkIzQi84SUNacFAvWk5FL1BBMzRkS2c5YndIS2trREl0?=
 =?utf-8?B?OWd5RTBUMTV6a2Z6dnBwWEgxZUVwODVGYWJ4NWhTbE5OT0VrZWtjMDIrTFJZ?=
 =?utf-8?B?SDRCNE9BN3dxeVIxYU1sT09VZWh0dHFpcHhiOWVBM2tvV1pTRFNXeitTQnJ2?=
 =?utf-8?B?Y2lDN0ZIblZvcGJ1cHExWVQ5S1hKMkhkQXhkVUowRUtyR2FXeUZGVDMrNWcw?=
 =?utf-8?B?WWlZSjRiUkM5dllPc1FtM2FYVkVCa0Y2VXJtdjY2VHZWeTdEcDNIUjhEQStp?=
 =?utf-8?B?QVJhVU0reFVvdXYwOEdvaThGeGVjTnlJTHJpcG9QQlg3UnBodTJBQ2thazFW?=
 =?utf-8?B?dnBGcmYyMkZnUWQ5SjJsanlDSzUyaVJVSThleGhwU2w3aHlMVzk0NC9iVVg1?=
 =?utf-8?B?ZkE5UFN2UWk5TnNtK1dDZUlLNGVMN05HYnYwQklFUmRWQ1hKYTlMN1pIR1Rp?=
 =?utf-8?B?SFNqcU9NNWs1RDdnR1MvYWVlVjVHQTU1WUx1dUNYYmQ5dU54aFo2cWI5Q1Rq?=
 =?utf-8?B?dGJ2MW52NFFWcU5IT0doRHA4cnRKcmpNQ0lPK1RybUZwU3RHVWZhS0N5eUtP?=
 =?utf-8?Q?Kp1HmGllz5o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3NyV053OEJHUEhOdlNkN3NaQUNNbTZabWw4VEk5MFpTN1JYS2JyTmZFbXZx?=
 =?utf-8?B?V2dQQzZEUWp2d08rZUZDRFhMTHJlNTRrK2VxUlJBaGhHYkdvZUowTStiSS9m?=
 =?utf-8?B?bTJpWEU5YUVKWC85OUJ1Vk5XNHFHSm01UnFyMHN1U1hVeTNIbTl6SGZTZnIr?=
 =?utf-8?B?cjF3SjRYaUVUaEo5Wlo2eXdacUlTbHlmeEJuZWpDM056TzhZY05nUE9UczBx?=
 =?utf-8?B?RSttc3VXOE1tUE9wUWtPNUY2M1NiNXplbjhUS3hDZmp1SGU2TUpxTkFCQm5R?=
 =?utf-8?B?UnNsSVduWVhpTFM0aEN5a2lIeXg1QmNIVEpQQnZwV0VVZDRzUnlxb3RQRjc4?=
 =?utf-8?B?emZGcUU1V3hrYm9VeHJ5VHdXY1VOTUlYaWZOejZrczRSQ0w3cE1PYlQzZVVK?=
 =?utf-8?B?VHNoRjVVTEpzakR5d3hsVHJvc3pnZzRZdkZBU2JBZk9PeWo3cU5FZDFEbmVr?=
 =?utf-8?B?TlFuazZxMmk3Zms1UURoVHNwY3FBRWt0REYydXZtQnpoRDVPUVd0SWJzeU02?=
 =?utf-8?B?UjNhQWFlV1pON1dmTVcwOUh5c0lVeFE1RGJucW1qS1hhVThDcUYyKy8zM1FU?=
 =?utf-8?B?N2tzU1V1OE96QjJGdVdscE9iL3JJdmh5dmp6WWdwYzVwTC9kWDJQTGovVnlM?=
 =?utf-8?B?VzcxTUV1d0x2YnpiQ2FKSGdGaEo5dWNORjk1UTArR3hTZGFMa3lXMlpCcmRv?=
 =?utf-8?B?NmhIbU8zMkR3S0IrSXRQV040ZXpEc3RrSTJaNHUvd1JGSTFsYy96bld4dCtt?=
 =?utf-8?B?TSt2Um9yRklaNnc5dGZyVC9EdWdhU0ZFanMrVFk2WTVMeGlDZGhJL0t6QlNG?=
 =?utf-8?B?OUJmUE9QMmFBT3QyT2lHY3pNN2NnTHZZUVZ0dWsrOThNUTFQYWdoSmNTc204?=
 =?utf-8?B?TzBFak5FS0FUQWV3ZkJuU081VGppb0hVaXZiNTFEenIxRkowcGl2ZWQ5Unhw?=
 =?utf-8?B?eFhadFhjS1pCVTFMWWd4VkhtbHpUQTNCMGRUYjB6VVZZWkp6N2YzYUFxQTlS?=
 =?utf-8?B?WFdIK25tNVNvcnMxeEhjOXBXNXdIakVJN3NNL2F1V0haRENUWUk1VlMxM3pI?=
 =?utf-8?B?bUc1ZmM3R0Z5M1U1TjVxcFVHRmJRb09jaWNaalNJUmVpN1ZFY2FxYzZ4QVNT?=
 =?utf-8?B?M1hwTmt2aVhyWWxHY3pJR0I1UWpKRkxTQ0toZ0RPOHRlOXNvYWpFU05wMERh?=
 =?utf-8?B?aW9vZ0pGSGlDdVo1SjUxdHhOT1JPWDJwSkRjNy9QOElyQXk3YlhRcXJWTUJ3?=
 =?utf-8?B?SFVnU3dCYUpVeWRhMW02RmcycEd3VGFDZktuWUZtTU1LTS9jdUxoZmkydzd0?=
 =?utf-8?B?OGRVaEFzNlpBWXdrK25lYU9XT2dTb2J2bHJtZXFkS1VibWgyQVZjZEJpeDhu?=
 =?utf-8?B?Sm1YUjFKdWJPd1c3bEpWQjVja2JTS0Y4R2ZaQmtjNk1rV0pqbmtpYVRDVDNB?=
 =?utf-8?B?Y2NGSjFTRHlzYVpwMXFSLytIVlRBdDE4SG9iTDMxcmdLUDBzN2Z0a2JQaUZJ?=
 =?utf-8?B?ZGhWT2p0dEZucmpKalIyYzN1WkI5SVBnVVJBcVlRbG80MTd3akowUXAzTkJl?=
 =?utf-8?B?RU1LcGlCRXBFOVd1TUMyOHh0VDY0elF4Y1dYNjdhVDRqanZ1S0JwNGNhSlVU?=
 =?utf-8?B?Nm9hZDFiYWVLWEpEYm5JRWtYdW1mZmpRdytGOHFDWHJGUk9NSng0TkNBWUds?=
 =?utf-8?B?NytxSHhXSmFEQm9NYjdZZkZndHpSUlVWU0tnOVF1Z3BnNVFWTmszWlI2bHd1?=
 =?utf-8?B?L054dS8rYVJkM3RMbW0ybkVyVHdWd3pRZnpaUExYMTB3YW1KRkhHZXpDVU00?=
 =?utf-8?B?R0J0MlBUa05xeXE4MDhMNG5TWUtrTlNjRmVrZVVPSHgyTkRaYjF4UWxPQjRW?=
 =?utf-8?B?ZnZxU2F6VHQ0Si92elk3RnpoNzhFMHdrNnhmaFBEMzJsVHQ1Y3cxa2poVVVD?=
 =?utf-8?B?S3pCVk5lREU1VWhHdmIvc09TaVdXU2FmcUlKc2RsTExNK2V6NzNpWkpEZW5t?=
 =?utf-8?B?eHptajBFcHc5V0RDTHVLL1pRaFlPVEV4Q1d2NkxUd2RMM0FzenU1S1VjSW9s?=
 =?utf-8?B?aVZIdUt5eHdwRHorWm9vLzBVMHRDWDN3T0VtU3pMM0FHdEhWdFRzby9rUzJ1?=
 =?utf-8?B?Z1ZLWU1DclRYSE5WaUZDQnRwdzgyZ2NGbG5iYTdYanlyd1d4ZXpwZ2E3Qko0?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A488D8896EB2DA4BABF66312611CCF63@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kzqi07K4CTC8lOIP+53lh+B8lABe/8KUzqVBr9HOCcB0sUbL8BSa3xto/7zQ0YkwanrtA/oMGz357KN1Z240CuBeAthaFz05/KIykK5A2F+LAMkOLCjUsSUKJc/OhmaYau157H9SdjwInJKESXCn9FTfYfxSmAUywQq+gVFvi+2K5QyLJAKiFiwUHrNDjAkSp/ltoHngTGeZB8quFPAgJcNToG2Uyt9i664xGjkZyK/xMAOb2WDSFlBNom/GHk1Bs9lWat6AeTeNc5TxPPO1IYOFSYkhs5LaNTUADPpA27EbQP9ZrZVxdTGw82hTnRZPZXHXiLssJI5PR2SEaEq+BdpZOsFZ9qtAlcaWX6uix3gXc43ZA7xHUP7/VJqPQ93AmFiymA2TxQ/o8fiy0Le7m7DydFnKc3KTx6ndy4hI1FlO4swvxy5Qw64I0C9Sfpe8jyBZ1agAT1duufJ/nleXjBO0PXuA6AOLml9yz6ESDKmQo0AZuS8ZzYC86OfvqXAuGRGxYINASsl2kJ0u1F+xadBnmzX3e74nr08hHFJVXS4V3pmHtJUsM0jz6745W7X8S+7IrCTF91f9az7xDDCCc9d7f3t8ikg5fQBqPGX4OxU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e302b652-56f1-4485-bc73-08dd988bdf9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 17:21:07.5433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sn6QQvJnLky9uN9aWSfvUHVHqNV0t8yZ6bOVi83XoXMIjQnijKfbcbZWgykox/BM4dQvs5yaWgaqoLy5sm8vv+ef/0KeUBPsI6OJQeiB9Bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_05,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210170
X-Proofpoint-GUID: Tn02ozMFsQRWkA380q5Dd5TYXwQpiV_G
X-Proofpoint-ORIG-GUID: Tn02ozMFsQRWkA380q5Dd5TYXwQpiV_G
X-Authority-Analysis: v=2.4 cv=HO/DFptv c=1 sm=1 tr=0 ts=682e0b8a b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=13OGfMMA-0FQSIZqxrsA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE3MCBTYWx0ZWRfXzfFLefDFEPV3 vOVkJmHl+K2b86GPgUXegVs4x8f0uQV/5fE79MdG9NfGUhrI6xZC5lo2I1rZCWCZ+dDX6EBh0YY 877PAC5JioQGHEnJybUHw9JbL6ChSsbkCYeoRFTRV/DIxIpoZL640sPP7izGZFoxutklLZzCd7l
 KLrotzr4nCOVqCWMu0QsdK40qku3tHsQSS6OOXg7Ox6C803azKtqjfFeh/XML1Wac/is+G7h43B uZwG5+WdcBHGJap4RQgJyrGzjh9oBxBeiUVP5ivmcosrcj8D8/N/uSleTweCxmGX/iFmKqxJhjF QYise3VARSnQW9ABtuEL9s1dLYA1/g439+GXoMCicxuGupNwf1/XgLR8mX9hskX8YpqKz0mc8id
 8/1KNOvnO83Tx31N0cME79UY4wcK16OQ88Di2i0GY3RgNgSdTDX5nloQOfXYART+1o9EVfpf

T24gV2VkLCAyMDI1LTA1LTIxIGF0IDE4OjI4ICswNTMwLCBTaGFua2FyaSBBbmFuZCB3cm90ZToN
Cj4gUmVwbGFjZXMgc3RybmNweSgpIHdpdGggc3Ryc2NweV9wYWQoKSBmb3IgY29weWluZyB0aGUg
dHJhbnNwb3J0IGZpZWxkLg0KPiBVbmxpa2Ugc3Ryc2NweSgpLCBzdHJzY3B5X3BhZCgpIGVuc3Vy
ZXMgdGhlIGRlc3RpbmF0aW9uIGJ1ZmZlciBpcyBmdWxseSBwYWRkZWQgd2l0aCBudWxsIGJ5dGVz
LCBhdm9pZGluZyBnYXJiYWdlIGRhdGEuDQo+IFRoaXMgaXMgc2FmZXIgZm9yIHN0cnVjdCBjb3Bp
ZXMgYW5kIGNvbXBhcmlzb25zLiBBcyBzdHJuY3B5KCkgaXMgZGVwcmVjYXRlZCAoc2VlOiBrZXJu
ZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL2RlcHJlY2F0ZWQuaHRtbCNzdHJjcHkpLA0K
PiB0aGlzIGNoYW5nZSBpbXByb3ZlcyBjb3JyZWN0bmVzcyBhbmQgYWRoZXJlcyB0byBrZXJuZWwg
Z3VpZGVsaW5lcyBmb3Igc2FmZSwgYm91bmRlZCBzdHJpbmcgaGFuZGxpbmcuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBTaGFua2FyaSBBbmFuZCA8c2hhbmthcmkuYWswMjA4QGdtYWlsLmNvbT4NCkhp
IFNoYW5rYXJpLA0KDQpUaGFua3MgZm9yIHRoZSBwYXRjaCwgYnV0IGl0IGxvb2tzIGxpa2UgQmFy
aXMgYWxyZWFkeSBzdWJtaXR0ZWQgYSBzaW1pbGFyIHBhdGNoLCBhbmQgSSBiZWxpZXZlIHRoZSB0
d28gYXJndW1lbnQgdmFyaWFudA0KaXMgY29ycmVjdCBmb3IgdGhpcyB1c2UgY2FzZSBzaW5jZSBj
aW5mby0+dHJhbnNwb3J0IGlzIGEgZml4ZWQgc2l6ZWQgYXJyYXkuDQoNClRoYW5rIHlvdSBmb3Ig
eW91ciBwYXRjaCBzdWJtaXNzaW9uIHRob3VnaCENCkFsbGlzb24NCg0KPiAtLS0NCj4gIG5ldC9y
ZHMvY29ubmVjdGlvbi5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9yZHMvY29ubmVjdGlv
bi5jIGIvbmV0L3Jkcy9jb25uZWN0aW9uLmMNCj4gaW5kZXggYzc0OWM1NTI1YjQwLi40Njg5MDYy
ZGI4NGYgMTAwNjQ0DQo+IC0tLSBhL25ldC9yZHMvY29ubmVjdGlvbi5jDQo+ICsrKyBiL25ldC9y
ZHMvY29ubmVjdGlvbi5jDQo+IEBAIC03NDksNyArNzQ5LDcgQEAgc3RhdGljIGludCByZHNfY29u
bl9pbmZvX3Zpc2l0b3Ioc3RydWN0IHJkc19jb25uX3BhdGggKmNwLCB2b2lkICpidWZmZXIpDQo+
ICAJY2luZm8tPmxhZGRyID0gY29ubi0+Y19sYWRkci5zNl9hZGRyMzJbM107DQo+ICAJY2luZm8t
PmZhZGRyID0gY29ubi0+Y19mYWRkci5zNl9hZGRyMzJbM107DQo+ICAJY2luZm8tPnRvcyA9IGNv
bm4tPmNfdG9zOw0KPiAtCXN0cm5jcHkoY2luZm8tPnRyYW5zcG9ydCwgY29ubi0+Y190cmFucy0+
dF9uYW1lLA0KPiArCXN0cnNjcHlfcGFkKGNpbmZvLT50cmFuc3BvcnQsIGNvbm4tPmNfdHJhbnMt
PnRfbmFtZSwNCj4gIAkJc2l6ZW9mKGNpbmZvLT50cmFuc3BvcnQpKTsNCj4gIAljaW5mby0+Zmxh
Z3MgPSAwOw0KPiAgDQo+IEBAIC03NzUsNyArNzc1LDcgQEAgc3RhdGljIGludCByZHM2X2Nvbm5f
aW5mb192aXNpdG9yKHN0cnVjdCByZHNfY29ubl9wYXRoICpjcCwgdm9pZCAqYnVmZmVyKQ0KPiAg
CWNpbmZvNi0+bmV4dF9yeF9zZXEgPSBjcC0+Y3BfbmV4dF9yeF9zZXE7DQo+ICAJY2luZm82LT5s
YWRkciA9IGNvbm4tPmNfbGFkZHI7DQo+ICAJY2luZm82LT5mYWRkciA9IGNvbm4tPmNfZmFkZHI7
DQo+IC0Jc3RybmNweShjaW5mbzYtPnRyYW5zcG9ydCwgY29ubi0+Y190cmFucy0+dF9uYW1lLA0K
PiArCXN0cnNjcHlfcGFkKGNpbmZvNi0+dHJhbnNwb3J0LCBjb25uLT5jX3RyYW5zLT50X25hbWUs
DQo+ICAJCXNpemVvZihjaW5mbzYtPnRyYW5zcG9ydCkpOw0KPiAgCWNpbmZvNi0+ZmxhZ3MgPSAw
Ow0KPiAgDQoNCg==

