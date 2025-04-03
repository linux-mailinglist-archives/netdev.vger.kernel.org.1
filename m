Return-Path: <netdev+bounces-178942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4577A799A2
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 03:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE62B17208F
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276B113B58A;
	Thu,  3 Apr 2025 01:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mPP2t+tL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Uz5JEc+s"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368322E3366
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743643646; cv=fail; b=P9qxK4XktBV1gIY/G398TJ8WpAsJIyeifw7Ef0fRz262c195sQIuaLkDgwaLuB7ox4/nN4CascUPCEG9LQWBr0dtVEmO0pUOgpZUF6EiaF6qyMu/+9jDyWi+I66/pdl64UsKiMnQR4jsCwnNVA2tkb43/yhijDWKdxzhxAwNUD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743643646; c=relaxed/simple;
	bh=fA7hq3XqzTTYIe2JmxO0we+vqqyQ93jXo0gwvbmU3cU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nvHfJSN3bcG/jA7ir1Vz4214g+BdKf4kNbNLZqDjTZualnE7KmzuE8nXKRw+8G+vRU+VWBXzydr1C26sChbXtSqJUdCjoH8SklnIMDBFr4uTHkCnbE2k6eJVF1HYjK/CviqoXL8veNlC8BXvsr4xXvR2H5sPcL036G5Ti+Swv0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mPP2t+tL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Uz5JEc+s; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532NMoiw020701;
	Thu, 3 Apr 2025 01:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fA7hq3XqzTTYIe2JmxO0we+vqqyQ93jXo0gwvbmU3cU=; b=
	mPP2t+tLDFyXW2gsN34Fb7eF12fwAEL+ca7ytyMCOVIBuVVdfSuXD8v9EtNkTdNm
	P355Weuha1y1qxE8JSofg0FpwdOw6Giakm/h3ghVnzUA1LIIUjfIAkA4yNI3t82f
	9SnBqNKS7V5ACOeiJtdY7zJtp0ZaUfu37ck3mjeDgsg/BeAMw5Tm4JXE3e0ibzsV
	C6o6fDsFzp9soGpoNVvmWuLzXZJIs3+rIplvyolCg59KOc3+LzC5xohYDckT1ID2
	wci85GZ4UKJ7TSxdOQScC/YW7zo/ECZaTalb0Ufs+4RhgZJKF4Bsh+RADot2xU5I
	oEmfg6sgB5v3xSr1qNMOTA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8wcmb14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Apr 2025 01:27:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5330rawA017033;
	Thu, 3 Apr 2025 01:27:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45p7abf0f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Apr 2025 01:27:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfaIxHnkV/4JAvm/6PwQRDfb9DghNkMij85BjqU0dBAfK2BY1oVSHsYWUvcQRK/tZ3m7lXn0P/nI/62Ia5mi93e84DMinSZvEYfBOV8xC9YIWcQGzTatyPE7HlgRMYgK7y1fDTRMhgci4zLoqHzNtvhKkSBjiLwaxFz9M6Dmnn7uHL4zbRpF4U5SYH2KLaih/6UKnHrtCv0I+nLhyeDfx0ZTqERS+3An8r8QGGaJLlw+BNPSxPyhmOAscBHyYpBYkF4SOacUjZ5RyPhrSS8ZrIOb/CXeRHF/338ZktthX1hFmyrA7WVHS+368wATyjAv1LraiT8tOhIpeC8oHUawYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA7hq3XqzTTYIe2JmxO0we+vqqyQ93jXo0gwvbmU3cU=;
 b=u3mfbQkNBwHWpoBrmRDAKUeuxu92pVAIG/ek5Ia25B0uJ3ScncTrGKVfI1yBLv4ukXq6OmuhuVe3fqxkk4hDamPZPBieR0/2fQhCgT7LAzP3AaAdtWh5igb26zj4I+ueT8hVo9ZBnW1nIeJGp/3huFvKJ4hagOmfFPIOiplTUdcuziJ2a/Kq7f+cV7sKTbwyW5vqmnd9h+Ze+Ta0Yjlqj6mhbPGUzNU16OA1lYQtXMFduYiFQqw5TuUWWFypZJyRTJm16DxUTRObmzL4c07uRYr90/n5QV0DOl/bPE40MEIB9LwXdiSt7LOA1YGC0jIqqaS447xjiD4vHSjDx0ueog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA7hq3XqzTTYIe2JmxO0we+vqqyQ93jXo0gwvbmU3cU=;
 b=Uz5JEc+s6TXqw51JyIH5vygUZ/LB9evr8piuzX/1eALNu6FVwgpXeF5qr4sd5RhYCr+0MLobFCZSrwjiqL13XYP99xs7+nSuLPF6Tx1We0iMZI1c939H2p7pbvjjqR3gMQ8cFHKDg1ffVI/x6qQ+3qPUvfdQgIIw4jVd4D+GRxU=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by CH0PR10MB4857.namprd10.prod.outlook.com (2603:10b6:610:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Thu, 3 Apr
 2025 01:27:16 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%6]) with mapi id 15.20.8583.038; Thu, 3 Apr 2025
 01:27:16 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv work
Thread-Topic: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv
 work
Thread-Index:
 AQHbiM/MqlxGuKFhJ0mhR9ncavILwbNdbXkAgAZOyACAAAGMAIACndEAgAAbDYCAAbbOAIAAa2qAgAacQICAFpVwgIAKApmAgAD2/YCAAJlHgA==
Date: Thu, 3 Apr 2025 01:27:15 +0000
Message-ID: <d9736cb80ce91c0c947b4a975f8a4843fa6e16c4.camel@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
	 <20250227042638.82553-2-allison.henderson@oracle.com>
	 <20250228161908.3d7c997c@kernel.org>
	 <b3f771fbc3cb987cd2bd476b845fdd1f901c7730.camel@oracle.com>
	 <20250304164412.24f4f23a@kernel.org>
	 <ba0b69633769cd45fccf5715b9be9d869bc802ae.camel@oracle.com>
	 <20250306101823.416efa9d@kernel.org>
	 <01576402efe6a5a76d895eca367aa01e7f169d3d.camel@oracle.com>
	 <20250307185323.74b80549@kernel.org>
	 <3b02c34d2a15b4529b384ab91b27e5be0f941130.camel@oracle.com>
	 <20250326094245.094cef0d@kernel.org>
	 <7f47bb1a98a1d7cb026cf14b4da3fe761d33d46c.camel@oracle.com>
	 <20250402091839.0a70f23d@kernel.org>
In-Reply-To: <20250402091839.0a70f23d@kernel.org>
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
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|CH0PR10MB4857:EE_
x-ms-office365-filtering-correlation-id: a6b9c749-6387-4457-eab0-08dd724eab29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?THFlejkzc21iazJBaTM0WXBNTjN0VjAyT01FbFFPY0JkZmxzUDAyeTdBNFJH?=
 =?utf-8?B?RVRXRzA0MHFpWFJWcTJKTEtKZUlXNEVCcEtzQXlWd2RlWGxPb08vcU9FUzUw?=
 =?utf-8?B?Q2RkVVdQT3QyYXMrL2NEcGNERElScVpoRFRYcmJhRU5EaXZEVFZXTWg5a0dK?=
 =?utf-8?B?b09Rd0UyWjY4aWhHaEs3c1ZKMFQ5UGxHU29ETW15TllwaTVXbW1UL1ZqWHl5?=
 =?utf-8?B?UjEzVk1kZzVCQVh1cXg3VzNlNkRua0hsWmJ0ZUU5Z3AvYjNDQk9pRVc5TDhJ?=
 =?utf-8?B?UVgrY3dXenR3cCtZVk55bmpSRnNTdVRrZEFOamwwcTZGMXZZZU1nWXFMNVZ1?=
 =?utf-8?B?Uk1oak5VNDE1d0c4bnltYXlKWFNwbVovbFJ4QUhFOGhWTXp3Um1yb3pSWmtj?=
 =?utf-8?B?a2NJbE52bDZCbFE1emJvMDdON1R0Y3pZWlhjRm5JZVRsbTNKK3pXaDhxNTN1?=
 =?utf-8?B?dm5hNVhlTWpLdUhNQVhYWTQxbzhiQ3hvT3RINHNHY2loUDhxM3dXc0ZpekxZ?=
 =?utf-8?B?cGZhVVY4cjJLaWF4TElIS3hLYWFSRldTWmpLWFVsY3NDcVZ6UlRIVUx1c1k3?=
 =?utf-8?B?UWEyZXVQalRCN29kUWpnbHlaT1RPODU0VzBuNFFjY01YRUo5UjJzQmg1OHdV?=
 =?utf-8?B?N0Nwck53bUJ5VGduQlVGUXl1T3A5bkdWUmpWYjRIaFRZOHliT1kvSGNGa0ho?=
 =?utf-8?B?WFdoanoxQWtOYklPeHpXMlFIWHZTdzFtUVRXRXhZb1M3RHIrN0dCait4cVIw?=
 =?utf-8?B?RmdqMmtPT2VRQzJhdXNwTUpmNkFSV3hQbWx5dDZxYkpxOHVzVWx4cU5jRXMr?=
 =?utf-8?B?UHZ2bmpqdmt0NEN5UnpwOUd3VTRqbW90a1A2dnUremZ2elBmcFgyMDhIbWhC?=
 =?utf-8?B?L2tYUDVjT1lNZEFmdTJqd3NmM1VPWjJUYmYrdW9sYnhBNzZrWGhsVG1iZFdW?=
 =?utf-8?B?cy9heUZFSzQ2QjB0bEs0eCtQZlJ1V0REeFlaZU1GNUxlaWZ1aXdpbWR1bDZk?=
 =?utf-8?B?K2FSek5LRzhYVUQyQlhFNGl0VEtTOGIxZ044M0plRjZORXU0NjAyTHA4eXVC?=
 =?utf-8?B?QnBNY3dnR2p1Nmg0alMyTUZPMk5LVFBzV3BxS1BaTnFKZURaRlZXWVR5NzMv?=
 =?utf-8?B?Vm1xRUdOWDhoVi9ZaEk1MGJrRm9OcThsNDRNdGxQdDRXd2ZXY0MrVjhiZjdt?=
 =?utf-8?B?M0JqUnhuS0cxckVsWGQ5bXNmVVV1bWFyTGE4U1Z4Q2MrYTFSMkhuZWx0aEpx?=
 =?utf-8?B?a0FWbWtOcStQL0cyYmxoSC82YnVienpSc0psWVdFZEw4LzdVcHdNYXhYWVZU?=
 =?utf-8?B?bkFjTHpyVW85d3g4Q3NWOTFVcWwyQjdMSU43NGxpMUtWWk1MSktDbmsveEMx?=
 =?utf-8?B?WFJLVnphK20vQ3o0WlBPK09GR3luQlQ5cEFFUzdvVWQvMDVwTjU2dGRPcGlW?=
 =?utf-8?B?a2c0cnVBRDRLOXpyRzEzWEo5R0NhQnU3eUZIeWlFV21yay9WeThGdXBzY0pS?=
 =?utf-8?B?dlRqQkcwT01VdXZjMktDemNHV3MvcW9qTWZFMGFXWTdRSXVmWVlLKzBrUnM3?=
 =?utf-8?B?MG1oTGdmcFNJaUZKNE4xOGxYTUlCcEYwQzF5c0VEbjh4ZWV2VTdWQ3V3M245?=
 =?utf-8?B?TzNnNUxMR1Y5dklDelhUY2xyclJHdkcvN0JkOVV6S1BXdVg1UXpsQ05HeHBP?=
 =?utf-8?B?bC9MNnNKL2RJMFQ3UndNcTE1RkYzNUdRM3NSay9SVmFwUzl3WUdmRUkzZDZq?=
 =?utf-8?B?RzdESlVzdVJuTnJOM0F0MVRvdGk3OWtwOExvZ3FjQ0VxVzF3R2ZMcEprZjNT?=
 =?utf-8?B?MWNUME1TcEtoRmY3ci9EVVZvaFUzd2Vzd2tycDQzakU2ZllBWkJPcGpGWm5X?=
 =?utf-8?B?QnBBODVGaG8welJGbFk0WlhObjN3K1lieExXd0oycmpHcXNOaS9LTGdrd0x2?=
 =?utf-8?Q?umtyx/6BYAtspziIAWxUMMh34kGA9QCz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUtrWG1rejkvcDVRYVpiZThFWTdlS2FydFA0ZldFQXRXY05raFVwa3ZOZXFz?=
 =?utf-8?B?WlhSUGJxbjJRVUZHc014ZUd5QVNxWTcxV1c2c3hSVnkzbnlsZnNVa3hOdWxF?=
 =?utf-8?B?VVZ4bDF5YnRkMnNIcmI0Q2t2cUN1ckxJb0lGSDBHaERnZS9LTk5nZ25RWWJo?=
 =?utf-8?B?ZEVQMUU0STIreVNNVXNZcUg1MkkrSVcxWHJMNkpvYkVlaGh6NGZDbFJqUTRJ?=
 =?utf-8?B?VU5NTWJ4a1BlWWY0SHFNK25adG9jN2FIK2RZeGFmQUdEdkZLT0xKcDNTU0VS?=
 =?utf-8?B?WHdQNFZaSHpNd3ZDdVlVVy9UZDN6U0l1ZjQrb2hrTkZWSjhpb29vM0JEc1FG?=
 =?utf-8?B?c1QzMXRzYkZod2pWbzFJTXpqM1NhTmY2WHFHMUxiSEJKY3Y4RmFhMTFxc1l3?=
 =?utf-8?B?WC9uclM3NzRnSXhOa1F1TFppTjViaDMzb1lxVTZqWmg3b0s3S09zK2VBYlQ0?=
 =?utf-8?B?MkZIQUlhZlI5SVRRWGg0N3RTa0JuR0JTUDVPNXRBZ2JmV29JUjlYZ0ZNZjlh?=
 =?utf-8?B?amhxZ0YxSThHNDduTVZGQTJaa1d6dFpHSHpEWnR6NGhuMHJReEVXd2V6SGtl?=
 =?utf-8?B?TEp5TmdHL1llS2Z6enRaMko4QmN6cnZZRjEyYnRiSUExZGwxRFB2U3JOQjFF?=
 =?utf-8?B?Ym1WeE1DckVMWEFMM25yUUlkSXpHVk1DU2pCZk1NcGxrbmNFQXhCOVBhTnoz?=
 =?utf-8?B?TUJ4VUdxNURPQmpKM015TFFPdStGUm1jaFVSbnpiWFRGc2x1ZnZ5R0Nxc1ds?=
 =?utf-8?B?WXoyOGNzcEtZSlk1ZGVzcGZPNHZIclFEM0xFRWJMVGZFWXpzMDVLSEw2U1lt?=
 =?utf-8?B?Rmw1a2t3SDRHY1M3OUpPbDVWSmNyZDR1bVlEMFZLRG1jMlo4dUpBQ3BpV1ZV?=
 =?utf-8?B?ZU5tWmZxaTV2dkJ0M3JYRHdlbnJIRnJBTDY4RmFVeHlHNCsvV3NFZm14MGtC?=
 =?utf-8?B?UmlWZkExREg1eVF2SFJSSW1naTF5VlNlZUJVWUdCc0NhR2VZby85cnUyblR1?=
 =?utf-8?B?cDJhOTA1eTVNY1VUR1oxOFZMN0NDaXJmbFk5ZWdRZ3pwaUdrb3c0ZFJYNUp3?=
 =?utf-8?B?SE15b2I3Z043ZCt4YjF0TU5aRm83bno1TWFLUGVvOW9qL04veFErZU1iOVha?=
 =?utf-8?B?V0tGK2xvcGZFWk1nVkJrb2JwN0J0WVJrVjdZQk05UFZIWTN2SmdGdHZiMW1h?=
 =?utf-8?B?THFpZmVGOUZPZ0pRRUR1S1JhVTBFYWJhR3NtZWZCQWIxQWpZeWVoRm44Ky9z?=
 =?utf-8?B?OUx0Q2FIaTVnTEJhUmlCR044SlBudGNRZHlJMU5LbWZVdTZwNDRlS2wxTTQ4?=
 =?utf-8?B?UHE4Y1o1VWtMbk12Szh4R2ZxMFV0MmprU0tGVXVJZ3p0LzlrMjByWVg3cUVN?=
 =?utf-8?B?NWY0SVVJelJOMkdVZVdpejRjaDBsMFptTVNYUm1jK2pHUXduT0lITlh3N2Z3?=
 =?utf-8?B?bW9iNVJaYzU5QnU4WERQLzlZYUhLYlYra3NKOG92Q0pEOXFaMnptdE5TYUdq?=
 =?utf-8?B?U3M4cnlhaFBkdlljYjlUblFqenlFa2FyNUU1TDliaFZGOXRwUmdDOTRsV29r?=
 =?utf-8?B?YjhqTmJMODNNMW5iMmt1WW84NysycUxvT2VwZFdNSHRiMFBENnNkSU9RTXdJ?=
 =?utf-8?B?Y2F1OUZyVmQzR1F4ZW1ZSkxGajZtUXpzVHViMXV3QnZqcHJBZlpCUUNjdFRP?=
 =?utf-8?B?TWpWeThpVUJNR1JhYW52TkxMVnAvMnd4M2hZQ0FhM05NTS9US2kxRWZCYkFt?=
 =?utf-8?B?QXo2RE5DWU5qS1VOQ3N2S05jRjZ4VkhrZ3RUYnJvKzM3enJxaU9TLzNleVJK?=
 =?utf-8?B?UUszd2k2U3hucDBXcnJCKzhUZ2lVVW1VTE5aakhlNnpTUzVSS1dnaHN6YUhp?=
 =?utf-8?B?Z2o2S1FHTEJ6WEFkcjQ3NStvczNHZVBnRVk5ajkwT3BTZGh4VlJ6RlNnRk5w?=
 =?utf-8?B?SUliUTZMQk9HOHJ5U0piSjM2MXk4eE1nanZnbWp2SnJrWGJzWkcwcUl2U3FI?=
 =?utf-8?B?TU02TjF6MmtJb1l2V3lCMytURVlTQUZOM0lnb2J4T0JNWWpHU0grVGlrVmVt?=
 =?utf-8?B?dTZpeGluZVpLczNUemxVN2lHQmRIMXA5SHlNakdsb3V2UG5qTm0rZWlhS0lB?=
 =?utf-8?B?WHFTb1VJRk1mYWdvakJlWEo5dlRIaGg2OEtaZFoxTDhlSGlpT3puTU5tR3BX?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74EF6D5D3ADC2F42909F50D534B5855D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F4KG1yFiyF4CWQIAH3i4/WMReC6ONRcajBhl8FeahAcEqHkUD9ctr0/pl6LVCA5uCuFXrNXG2m5l2WIgKqU5uKsFrG3N7F8AcdQRFZLappjGIcA9kGQkoPLVqiYCZ9s2WlWFOhvfudB6rkcEt9T07fS7lwGWi1x9jeZ38nR/rJutZiis1OdY6tyb53tRKqYeOuNLntlgMJ8+jWPEIRGsWpZd5T1WV7x/J0SsFcumjoFt1SsQmxOriXce+95yH1TM9i8dKp+xxk4oa7ckd2dAG/cEMWwJ6Q9rpPxDYpkxfZOFTMteFHRg9Pjz3lgde/xD9hoU2JtfQ0FPTzF8VewKYPpvYzJjgWS0gMy9Zpvx9DN+tAj1Yi8C6/lVltELcQSpt09HU4n+wnwAahFgx/JPbpOJKAq8U6iNK1UxofycwQt+K/clHisFxvxaSxwan4phRiPjt9Ti8iilRv5u34SkGiq3QTBSLXs9lEftz+CtQDhBfy7qXXaP4VD8a/Z+qQkz7bfphFvGnaUBSH7sXbwWE+TbNNSG+6NKLZPWlbKYK7ZLi4Zp3whHgO6BNEgzm+pReqiw7prOVidobEuaZU9Z/bjLo5L4PaqfGyDEuVRlLpk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b9c749-6387-4457-eab0-08dd724eab29
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 01:27:16.0615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LjdX3rQI0Pi1kaVFkJT/P4KUoTfYjjRu1hnd3w9qaggyzBdM62lXG2OQQF300GXoYpMCWrwKqQeMgnJvYQvqso6RDG52MQIMsw6XVLsiyRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4857
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_12,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxlogscore=836 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504030004
X-Proofpoint-GUID: sxCnzngBARPGdZNMbzf5VhRbEMiP3xif
X-Proofpoint-ORIG-GUID: sxCnzngBARPGdZNMbzf5VhRbEMiP3xif

T24gV2VkLCAyMDI1LTA0LTAyIGF0IDA5OjE4IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gV2VkLCAyIEFwciAyMDI1IDAxOjM0OjQwICswMDAwIEFsbGlzb24gSGVuZGVyc29uIHdy
b3RlOg0KPiA+IEkgaGFkIGEgbG9vayBhdCB0aGUgZXhhbXBsZSwgaG93IGFib3V0IHdlIG1vdmUg
dGhlIGJhcnJpZXJzIGZyb20NCj4gPiByZHNfY2xlYXJfcXVldWVkX3NlbmRfd29ya19iaXQgaW50
byByZHNfY29uZF9xdWV1ZV9zZW5kX3dvcms/ICBUaGVuDQo+ID4gd2UgaGF2ZSBzb21ldGhpbmcg
bGlrZSB0aGlzOg0KPiA+IA0KPiA+IHN0YXRpYyBpbmxpbmUgdm9pZCByZHNfY29uZF9xdWV1ZV9z
ZW5kX3dvcmsoc3RydWN0IHJkc19jb25uX3BhdGggKmNwLA0KPiA+IHVuc2lnbmVkIGxvbmcgZGVs
YXkpIHsNCj4gPiAJLyogRW5zdXJlIHByaW9yIGNsZWFyX2JpdCBvcGVyYXRpb25zIGZvciBSRFNf
U0VORF9XT1JLX1FVRVVFRCBhcmUgb2JzZXJ2ZWQgICovIHNtcF9tYl9fYmVmb3JlX2F0b21pYygp
Ow0KPiA+IA0KPiA+ICAgICAgICAgaWYgKCF0ZXN0X2FuZF9zZXRfYml0KFJEU19TRU5EX1dPUktf
UVVFVUVELCAmY3AtPmNwX2ZsYWdzKSkNCj4gPiAgICAgICAgICAgICAgICAgcXVldWVfZGVsYXll
ZF93b3JrKHJkc193cSwgJmNwLT5jcF9zZW5kX3csIGRlbGF5KTsNCj4gPiANCj4gPiAJLyogRW5z
dXJlIHRoZSBSRFNfU0VORF9XT1JLX1FVRVVFRCBiaXQgaXMgb2JzZXJ2ZWQgYmVmb3JlIHByb2Nl
ZWRpbmcgKi8gc21wX21iX19hZnRlcl9hdG9taWMoKTsNCj4gPiB9DQo+ID4gDQo+ID4gSSB0aGlu
ayB0aGF0J3MgbW9yZSBsaWtlIHdoYXRzIGluIHRoZSBleGFtcGxlLCBhbmQgaW4gbGluZSB3aXRo
IHdoYXQNCj4gPiB0aGlzIHBhdGNoIGlzIHRyeWluZyB0byBkby4gIExldCBtZSBrbm93IHdoYXQg
eW91IHRoaW5rLg0KPiANCj4gU29ycnksIHRoaXMgc3RpbGwgZmVlbHMgbGlrZSBhIGNhcmdvIGN1
bHQgdG8gbWUuDQo+IExldCdzIGdldCBhIGNsZWFyIGV4cGxhbmF0aW9uIG9mIHdoYXQgdGhlIGJh
cnJpZXJzIG9yZGVyIA0KPiBvciBqdXN0IHNraXAgdGhlIHBhdGNoLg0KPiANClN1cmUsIEknbSBv
dXQgb2YgdG93biB0b21vcnJvdyB0aHJvdWdoIE1vbmRheSwgYnV0IEknbGwgc2VlIHdoYXQgSSBj
YW4gZG8gd2hlbiBJIGdldCBiYWNrIFR1ZXMuICBJJ20gd29ya2luZyBvbiBzb21lDQpvdGhlciBm
aXhlcyBJJ2QgbGlrZSB0byBhZGQgdG8gdGhlIHNldCwgYnV0IHRoZXkgbmVlZCB0aGUgcGVyZm9y
bWFuY2UgYXNzaXN0IHRvIG5vdCB0aW1lIG91dCBpbiB0aGUgc2VsZnRlc3RzLCBzbyBJJ2xsDQpo
YXZlIHRvIGZpbmQgc29tZXRoaW5nIGVsc2UuDQoNCkFsbGlzb24NCg==

