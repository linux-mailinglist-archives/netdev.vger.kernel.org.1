Return-Path: <netdev+bounces-174099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDD7A5D79E
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 08:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1120E17AABB
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 07:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8287F22CBFA;
	Wed, 12 Mar 2025 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eKCnitpl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GwC1ntwd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32C322B8A2
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765827; cv=fail; b=ZsniN5XAYTXVvZgVnEuEyKsitD4eJhw6pS0R+7gc23LN4SHJrMitm37jkuGJ8esL0TBkseQzJhoJMwNg0zyS0GTYQ5tMd/kx6rhZ7X3PsAoBJ6e/o5gdzMuN2CEOX4aTQ4P/OXVYhaCMUscxTKA2EqP0QAtEFVI1bUgqAGhhTBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765827; c=relaxed/simple;
	bh=VWWf/CkzLkXMG8ta6/HdBpWqU3cqSkfvrVY7YJ5aZoU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Or30eZuN87I2+XvAitRateUyQex29i3Oxwby/Yfvx8pCDUsxqRuz5EvQAEJ+Zi4ibRJAxxuSWmek8Z6Dg1klWycriHTMTtPWQaICoLs+zkt7F5gL7FCQI5jU4cALYRZMXkqWtFAgkV8z/3eBnUSEEP6yBv5kEsr8kAW52NuCi68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eKCnitpl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GwC1ntwd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C1hpn0027978;
	Wed, 12 Mar 2025 07:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VWWf/CkzLkXMG8ta6/HdBpWqU3cqSkfvrVY7YJ5aZoU=; b=
	eKCnitpleWTKyYdlbIyAgIg+fbRS7exuxBtRo7jwg8BzA876DgIbsvihMjgLR/HN
	sTOgVkHCX5wCZgaVORUjLAlO9EP8EU5Eyezz6cpIz6uMSQQ2Z7DFA1kA0VqSNUQg
	KdOGxGT2mBi0+bdmWgSY0fgbAuy+S2lmKWTNuqRLS/TLXZnRKiYBxo4Ov69i9Ap9
	j+G3rrQPU8GYOQIEO/N/6U8H7VRwGOGpJkVN0TNEe3tV+oE3MTVb6Wi3RShgAF6n
	qJHm2s1V/Xb6bKq2CQmNVW3Sf8XTZ4lX8KGbYHQA7GkRSKDsvVbeY9gxNbc80hup
	5N1ZThDcjcHQ76Y5PfCbeQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4ds2bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 07:50:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52C6sp3x012230;
	Wed, 12 Mar 2025 07:50:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn0x5jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 07:50:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwOvy6VIWAzbOESB6clTvICl+k+PHP/IuTkOxxDj+MAH57miRb6ddf82tGG/eRf5CMMI5psKBDgsywRSq6qOznIZJJ53UEP06dSM89a1S50UD8uiVHLJF6dMGM2xf8W8fiE1QyE2VtquRUWxmmwVTQt7K9OkqphkdeYIagQAiA/IxXGfiRACD7hlSMqkxaQGo+Dqo+edNF9OCV4y+agDsXxig8HrEuovDHfUmjQFta8+bCnsoY3Pr4eyY2xCd/JW9XrV8sdwsTlgavPNPVnEzzDn/MjpmEwaAvkZ6vJtjF7q4hHvmOdp7EOc29IcRx+qkXGAW6B3E24ubRTFG/iYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWWf/CkzLkXMG8ta6/HdBpWqU3cqSkfvrVY7YJ5aZoU=;
 b=h82KTjUB8Qi2s/rjQMmz8C1MnaM2h2FdBWWHhCMWrkzesme1lVFu7fBcH1AIodtD56KsTQkZW/H31b0gIrD9im9jXjG6NFykL08VvM8a4GEDX3gHIOsKNd/TWVBwMzVEZdVRZSr1qmkktLnixp79lSBHYbD04o2hmbE2f6+Ps5mLLfiKYwgix+dPjQaGvCs+FzMOAeQMSx02mLDzTwV30XVz3Lxj9AxJNBeB6z0xKLdZI7nFRe9z6iHGMosMj5Og8dCccEkhmj/s3/nAgWFCbmwwIrLI3Tx0HKOow/6OeM4iYlR4WhnJHIKkFPTsQQyf6JRnuz19J/HMiVOdV1l7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWWf/CkzLkXMG8ta6/HdBpWqU3cqSkfvrVY7YJ5aZoU=;
 b=GwC1ntwdLDZmSABaI54YsL0skTngR+kR+nS+h8l5/NkzqXOons6DjSAfX7qdRHVeHOiNOy6yUvldV0MirWZUW0UHmacisNUdcsqYTfpaldaxTCEWOB7yETMUx14rM9UyFf8AnZ0NRKP+ywKj6P75qdp+qVMv+swu7dysPyTdrmA=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by DM4PR10MB6910.namprd10.prod.outlook.com (2603:10b6:8:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 07:50:12 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 07:50:11 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv work
Thread-Topic: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv
 work
Thread-Index:
 AQHbiM/MqlxGuKFhJ0mhR9ncavILwbNdbXkAgAZOyACAAAGMAIACndEAgAAbDYCAAbbOAIAAa2qAgAacQIA=
Date: Wed, 12 Mar 2025 07:50:11 +0000
Message-ID: <3b02c34d2a15b4529b384ab91b27e5be0f941130.camel@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
	 <20250227042638.82553-2-allison.henderson@oracle.com>
	 <20250228161908.3d7c997c@kernel.org>
	 <b3f771fbc3cb987cd2bd476b845fdd1f901c7730.camel@oracle.com>
	 <20250304164412.24f4f23a@kernel.org>
	 <ba0b69633769cd45fccf5715b9be9d869bc802ae.camel@oracle.com>
	 <20250306101823.416efa9d@kernel.org>
	 <01576402efe6a5a76d895eca367aa01e7f169d3d.camel@oracle.com>
	 <20250307185323.74b80549@kernel.org>
In-Reply-To: <20250307185323.74b80549@kernel.org>
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
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|DM4PR10MB6910:EE_
x-ms-office365-filtering-correlation-id: 90d79912-22f2-4c45-2851-08dd613a84b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bHF3aVorM1dxeDBjV2F6Q2JrUHFXN2FGZkQzYW1uK2VWcmM5UU50aUhPdFVR?=
 =?utf-8?B?U0lXMFM3bGVvdkNuVUVNcXNsYlhDZUF2OUhHUENrYkxDQ0c5MjN1cXJPV2F2?=
 =?utf-8?B?K1pJZWFicFNucnpmUnlBSGhieVlxdmlQbWV6YTZmcXQ1cnBYbjdJZ2tCNjlC?=
 =?utf-8?B?UlIxM0lSbmo2WWxaeEJnOHgvM3BHa3Q1UUVFQU4rcWNhcGtTL0Fhc2NIUkhW?=
 =?utf-8?B?Qm1vVXBWOHpoL3h4VkpXazlMajRaSlo3QzNleG1QYk15WWJuWDVuTlJEN3B3?=
 =?utf-8?B?RXBLbitMSDYwaVkrWVFSd1ZNOTI1VVZ5K3ZNYVgwQk9Qem1vODM5SHpRL285?=
 =?utf-8?B?ODFOWlJPaXlmSkpteHJicWRjVnVjcnVuYUhHZDFwNjZUeGtEaEN3N2hJTTNy?=
 =?utf-8?B?KzNqUDRFWHY4bCsyU2cvSE9Sb05wODgvVTBNbEZHOFhNKzl5UTRocDVJdFUx?=
 =?utf-8?B?Tk43NmJHM1lJMkhNZVgyemFrZDNrRGRjT0RKaGFVVUUvOU9DUGNzdWxSQ3hx?=
 =?utf-8?B?MzdIMFNESytrZWFvaTB1VkZsQ2FhWmdpKzNEUzVFQjJLalgxQm5McHIzVnlL?=
 =?utf-8?B?SVJVYXVqTStpK1FFOW1ueVZJWnNrczJGdVRXWG90R2hrVGVaKzVSZE5qZnZX?=
 =?utf-8?B?QlRHNitocGNPNUlaZTM0MjVUYUpQUWJWWWkrL3cvQXl0THhvcjF5aitaWlp4?=
 =?utf-8?B?NTYwZEs4Qlh4elJ3UDhLalF4N3ZQa0piaXFiQ01OR24vdFhSb0pkK0tUZWFV?=
 =?utf-8?B?ZkpQWDdSclk0aDNqdThoSTBUMlJYVlNtWTYrb2RkbmhZcmVjaG8yU2NvSUpG?=
 =?utf-8?B?WGRwV0tqOXhaUXdnN2xoUkRxcDkxL0tZTmF1Q0UxTzdFcVU4cTZQdFgrb21x?=
 =?utf-8?B?L3ovM1cwN2pDOWVuT0dCUEVPeG9ZM3FpSzNzb1JUQVFaSGhkWE9WTkJRREhj?=
 =?utf-8?B?TmJnWk5yUU1XV0tmb0REV1JrM0U1MEE2TXRCUlVCZi9TaWpzbU44WnV4aWR5?=
 =?utf-8?B?aVY1SUc4ZTlzdjV2dWlHWTh2dGZSVXJvMWFUREdEK2lXQWl5ZnVkaFhGZHlm?=
 =?utf-8?B?dGE5UWNRNENCQWRiY2RjMkNwNmxCWjNoZEFhZWRwcWtDSG9kY1BMaHpwNHM3?=
 =?utf-8?B?a0ZVWUh0RTRNYWJJUDlpT1ZUM1BWWGVWcTdWTUwzMi9tVFdJRUsvYXhvTzFi?=
 =?utf-8?B?YjBhbDg3eGNEVWllSlBVT3R4UjBEK2syZVhSVWNaQi9nQTVSSzZKTFhVSzBh?=
 =?utf-8?B?WEJ0cFNwK2NHbjR2akpsWE5IWDlsL2wxOHVOaFNrMzJhNmI0NFp4NUNmVlI2?=
 =?utf-8?B?TUV4V1lrMXZSenZ6SkF4dFF3Z01rckVLUE9QV1Q2N3BVQlRjd3RXbCtsakxo?=
 =?utf-8?B?THNwdVdzajR1aGdXRVRQZkNkN2hIRnFMNW1JTzc1eDBEa2xOSjRLdmxGWUlT?=
 =?utf-8?B?Z2JrbFhZVmFjQjdrR3YxZUVpejFJL3o4Z0lEbDlJQ3lWbWcvQ0M3NCtUaXph?=
 =?utf-8?B?ZmJFQktEUU5BNVNJZ25uVUZIQU9qZmRNdk1JemVtTnRjcjdRUC9FTHRPYWdp?=
 =?utf-8?B?blB4Wm1wbXAzenZSRVBSMHZZSjRtRHhDOTRHZUdESzRHZEpNSWxvQldqSEQz?=
 =?utf-8?B?am15eE5TM254ajRpa3ZwbE8yUGY3ZThIOGRzRWFza2laZzlkRmlxbU5EMk5T?=
 =?utf-8?B?RUxWNFppU0swQ0J5MllSY2dFbGNISzMxYkhocGpXRUtTcE5FY3NTM3haajRJ?=
 =?utf-8?B?NVJCdWFhWmVjemxjTWtHS3l0K0xzeGd2aFd3VGVTNjNkZy9qL3FSYUdxRElD?=
 =?utf-8?B?L3Q4cDJsZGN2Vy9UYUFvMkJlWm5KK1NuUUl3VlhkYTE5UUhIS0JBR0lrVzll?=
 =?utf-8?B?dFVkVC9QeHR4TUcyVzIxcVlpSi9pNVYrYThkaWw3TFNoZ25ham5ENmF2b3pE?=
 =?utf-8?Q?/JAT3nhb/U+DtNIbvYW7ks36ZBRvjroY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MXQrUEx0UEJTbTNSV0JBaE5WcFdGZEUzMDJ0MzRiTENmczhuYW51Q1JiSDNF?=
 =?utf-8?B?YWpMZTBIb0ExY3Z4S244Qk9iT0MxVlYycHZPanVDRFJJcm5FSm5FK0RIWWNL?=
 =?utf-8?B?THBPZktLWS9LV3lDQ083ZnVUeTBia1pBbCtJOTdPZmYzN3d4OVVTTzFNTGpE?=
 =?utf-8?B?Yy9lUGNhVEhWMXQwbDNSc085UktXVFQ4VjdraEhKbnhVV292SkYxeFp6WnIv?=
 =?utf-8?B?VDZhL1o5VlRta0FXSTdrY092aFJ3UUczWDBFaVZERncvdXgyemFaenNUKzlX?=
 =?utf-8?B?dVdsbW1uc0NKZHRpbDFBNzJKZE0yMzA2UTV3aFRrMFJTekg1R21abEpCSlFT?=
 =?utf-8?B?VnkxU1cyeTFFaThHUWJYbzRGMVpPMDVSMFVQdVJSQXNkbXAvc2dSQS9na2Jh?=
 =?utf-8?B?NjBPeTJ2akQ0T3lBcW1jUnNYNHlRYlc3cE9JZThHcGxaaWZ5Y1Faa1V0TGFG?=
 =?utf-8?B?UEZkUTMyemR3K3N3VlRtVFJpd3lRR1A2RS9kLzM5VlEzQVdvZUE2ckRjZ00x?=
 =?utf-8?B?T3MxQXYyY3hDdXVyVExqd2VxWnhFWVlKa2NNYUZyOHVWbWNTQStWUWw5dDZl?=
 =?utf-8?B?QkwxcUgrOXhIbXRWa05HRnZJNEdHOE1EQ2VFNUw2c3RJaHJxcUQ0aWpJVk8x?=
 =?utf-8?B?bVBrRmJVbS8zRFhWYmtjSlF5TExaK2hocUY0WU1SaGtwaDRGRENaay9QSkRM?=
 =?utf-8?B?cE05YXlhQWFJRFVrWWVpcXZDSS9RMXZSWVlHTlNNSDhrN0hsNlAwZktxdXc0?=
 =?utf-8?B?SFFCOTVFZG52SEdnNFQraThnVEVJbTNjb2g5eCtOUk50SXdCV2VEQVV5VmJK?=
 =?utf-8?B?NjAwbjZLUUNaTk9VNEc3ZUpxTWcza3hvSGtUV1hyVlBkQjZzWTl2ZFM0c201?=
 =?utf-8?B?aFhaUEVhcVg0MjJFRG41RDlBMlBURDRIUEZldlRaZmh5bDEyS1lERERYZUpp?=
 =?utf-8?B?dFFkYVRzdDFEKzJTR1F2alMwamgyZW91VlBPR0x1NVliK24xdCtXelh1MTB5?=
 =?utf-8?B?YTdsSzQ5MVBhSGl1UUZLalBLMWJJSzJ6TUNKdEhWM2x1cmQ0a25jSCtMVm1D?=
 =?utf-8?B?bEszdTF5Ui9yejBYTkRLb0I1cnorYW9RZXJ4dnpnMm83b1hCb3FadnhVY3NK?=
 =?utf-8?B?NG5veVk1MlFlL1I5M1lUMUVrYTZibEt2eGgveGZtR2EyaktyWlBwNDRHZWR6?=
 =?utf-8?B?d0Q4UGxVcjI0MGw1T2JTeDlxLzBWbVBLNjVibzhjVTdXckQzWHFXRWRNUExw?=
 =?utf-8?B?RDA0czRrTDdjSGZvZGtxdDZDbndQdWlyNzFUSkZsdld6REhqSngwN0Jubnkv?=
 =?utf-8?B?dkFHYm04UnptTlljVVl0S3ZCdHFKUk9ZRHJOaUg1bHN4RlM5NldFZDRrOHR3?=
 =?utf-8?B?dEYwS0NhTHZQRHgvTEh0UDNoY2ljSm9ucEU5N21oSDlTU01EVmRjMTRaWjR4?=
 =?utf-8?B?YVRoZFZPbXFrSVpQTkE3blRRZ1lvV2pWTk9ZUytGL2lUM1pwOVRuUUlsdXJI?=
 =?utf-8?B?RXgvN2ZNUEwyZFdtWkJwYWY0OTFQREpGaHI4SWtFK2JHTkFnWjBGb0lqUi9z?=
 =?utf-8?B?M2JkYkZaUTBKck9CRTJmN25GYm80SmowSzh2cVJ0dkpneHpHYkJXcXQ4cVJO?=
 =?utf-8?B?QVpzZUYwVG9KUEZ6c0hlMW1qZHJSSGxZUDBEZUMvbHN4MGwrbU9YOUtST2Yr?=
 =?utf-8?B?UFRYZml5SXA1UWphb2dYTDlNb0Fqa1p6RmQxSTVOMzhxSmhybU5BS2JFL3Zp?=
 =?utf-8?B?M0VrMkVIVmc3dStFRkZmRHVQZWtzKzVKWENQa3NTMVFrbVRrdS9TZ283Z0ZT?=
 =?utf-8?B?ZkNHZ0tqbTNRSldvN3NTdVVLcXdMaCtqVjV0N3VWTnhSaEJiTTNmUXN3VWdx?=
 =?utf-8?B?cDNXR29zalRIVHFXdXJRQzFCdkt5K3BySjgySVh5T1hPSnNNc0Mvalk2Rm5m?=
 =?utf-8?B?bDViQ0NMalhremdQMmpTUHJsZ2ozSEFTSnpoWWxRU01uM0w1dTljT0IzaTR3?=
 =?utf-8?B?RFR6bXZRb3Q1dDhtY0VwZnp2VUdIKyt3akd4RWRvQmxWODBNMjFjNmcwWHA0?=
 =?utf-8?B?bGdwTytKNWxwa2o3RlZHNTdWSUR6eEltQ0ZRWGYrQmdtVENQVGNFZTU3dGpL?=
 =?utf-8?B?N3VscUptekNqTHRMRGlZNjJ2MmxGR1M5dFV1NWM2L1h2YVBXRGlwNVBFMlNk?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37FBACE304E82442A9BB4EDAD45B84B9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7ftoPGFSVNzNkzUqBpyFdHWjvCq3cKyEdlucXYrGEsWgFqVA2Veas2nxvjZOARGKsVG7Z3o4CF6XEImyOc+H8wANryS96BqZsrRABqA5Ycwc1vlHkTvSt6t9G/WLjtA9HMKP49JMsdU8EiCCeoC/UT+b7lN3CQUaLNmE4jJN0EiRGHqyyS0sw5wn4LAXL5dk/dV5mun5bWGARcOLau2pKjHk1i11FIjMxFXntZI6zqQjkxHzqUwHR9ZlCGh9rmn7RrPZtXC5Q8Mfa4dBUkIf8iOGuGL62dE5XxvKpunPJJB5cXx2uGunOGQXYW/fu/tDzgKw4cG/kYwiypi8MdUYRZyoJQos1VZAgM5xDgLMa8/eYnCBb9gGaLxRyIo6npt4ujnCLu0X7SlQ02bSHBBlYfexg2cIZO9vhSmA4S5d1wfejse8krX5FnX+3X89EFJwcghdzGBteNbWifi/PaKZ10OC1uz/4SaVfxx7A9IKyMElMA4CXGbmQS+JZs3O3YbhuTjSIo+ABdC67RwEpzMMNr/tHcK++GEoIwaWTajAXGk0s3KXtz+bkkfhUqwXP8BBZFS+D8TvQnLWk+gPgqmW1VdRq7iAYrmSW92lMU+6BcA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d79912-22f2-4c45-2851-08dd613a84b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 07:50:11.8828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UOHr36BloHyTs9mHnli0T8PtpbZF1wfjPpmSEOyL8KszIVU5FOQnwCWSCNIH8CvF8JvnVQtxMFwPT0GadtlIKKKpu9ijtaK1VTUMBtsuawU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=833 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503120051
X-Proofpoint-GUID: RZAoeF_Bt1u7-CgQYaLqObq21GWxHzao
X-Proofpoint-ORIG-GUID: RZAoeF_Bt1u7-CgQYaLqObq21GWxHzao

T24gRnJpLCAyMDI1LTAzLTA3IGF0IDE4OjUzIC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gRnJpLCA3IE1hciAyMDI1IDIwOjI4OjU3ICswMDAwIEFsbGlzb24gSGVuZGVyc29uIHdy
b3RlOg0KPiA+ID4gTGV0J3MgYmUgcHJlY2lzZSwgY2FuIHlvdSBnaXZlIGFuIGV4YW1wbGUgb2Yg
MiBleGVjdXRpb24gdGhyZWFkcw0KPiA+ID4gYW5kIG1lbW9yeSBhY2Nlc3NlcyB3aGljaCBoYXZl
IHRvIGJlIG9yZGVyZWQuICANCj4gPiANCj4gPiBIaSBKYWt1YiwNCj4gPiANCj4gPiBJIGp1c3Qg
cmVhbGl6ZWQgbXkgbGFzdCByZXNwb25zZSByZWZlcnJlZCB0byBiaXRzIGFuZCBmdW5jdGlvbnMg
aW4gdGhlIG5leHQgcGF0Y2ggaW5zdGVhZCB0aGlzIG9mIG9uZS4gIEFwb2xvZ2llcyBmb3INCj4g
PiB0aGUgY29uZnVzaW9uISAgRm9yIHRoaXMgdGhyZWFkIGV4YW1wbGUgdGhvdWdoLCBJIHRoaW5r
IGEgcGFpciBvZiB0aHJlYWRzIGluIHJkc19zZW5kX3dvcmtlciBhbmQgcmRzX3NlbmRtc2cgd291
bGQgYmUgYQ0KPiA+IGdvb2QgZXhhbXBsZT8gIEhvdyBhYm91dCB0aGlzOg0KPiA+IA0KPiA+IFRo
cmVhZCBBOg0KPiA+ICAgQ2FsbHMgcmRzX3NlbmRfd29ya2VyKCkNCj4gPiAgICAgY2FsbHMgcmRz
X2NsZWFyX3F1ZXVlZF9zZW5kX3dvcmtfYml0KCkNCj4gPiAgICAgICBjbGVhcnMgUkRTX1NFTkRf
V09SS19RVUVVRUQgaW4gY3AtPmNwX2ZsYWdzDQo+ID4gICAgIGNhbGxzIHJkc19zZW5kX3htaXQo
KQ0KPiA+ICAgICBjYWxscyBjb25kX3Jlc2NoZWQoKQ0KPiA+IA0KPiA+IFRocmVhZCBCOg0KPiA+
ICAgIENhbGxzIHJkc19zZW5kbXNnKCkNCj4gPiAgICBDYWxscyByZHNfc2VuZF94bWl0DQo+ID4g
ICAgQ2FsbHMgcmRzX2NvbmRfcXVldWVfc2VuZF93b3JrIA0KPiA+ICAgICAgIGNoZWNrcyBhbmQg
c2V0cyBSRFNfU0VORF9XT1JLX1FVRVVFRCBpbiBjcC0+Y3BfZmxhZ3MNCj4gDQo+IFdlIG5lZWQg
YXQgbGVhc3QgdHdvIG1lbW9yeSBsb2NhdGlvbnMgaWYgd2Ugd2FudCB0byB0YWxrIGFib3V0IG9y
ZGVyaW5nLg0KPiBJbiB5b3VyIGV4YW1wbGUgd2UgaGF2ZSBjcF9mbGFncywgYnV0IHRoZSByZXN0
IGlzIGNvZGUuDQo+IFdoYXQncyB0aGUgc2Vjb25kIG1lbW9yeSBsb2NhdGlvbi4NCj4gVGFrZSBh
IGxvb2sgYXQgZTU5MmI1MTEwYjNlOTM5MyBmb3IgYW4gZXhhbXBsZSBvZiBhIGdvb2Qgc2lkZSBi
eSBzaWRlDQo+IHRocmVhZCBleGVjdXRpb24uLiBsaXN0aW5nKD8pOg0KPiANCj4gICAgIFRocmVh
ZDEgKG9hX3RjNl9zdGFydF94bWl0KSAgICAgVGhyZWFkMiAob2FfdGM2X3NwaV90aHJlYWRfaGFu
ZGxlcikNCj4gICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAgICAgLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAgIC0gaWYgd2FpdGluZ190eF9za2IgaXMgTlVM
TA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtIGlmIG9uZ29pbmdfdHhf
c2tiIGlzIE5VTEwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLSBvbmdv
aW5nX3R4X3NrYiA9IHdhaXRpbmdfdHhfc2tiDQo+ICAgICAtIHdhaXRpbmdfdHhfc2tiID0gc2ti
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gd2FpdGluZ190eF9za2Ig
PSBOVUxMDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLg0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtIG9uZ29pbmdfdHhfc2tiID0gTlVMTA0K
PiAgICAgLSBpZiB3YWl0aW5nX3R4X3NrYiBpcyBOVUxMDQo+ICAgICAtIHdhaXRpbmdfdHhfc2ti
ID0gc2tiDQo+IA0KPiANCj4gVGhpcyBtYWtlcyBpdCBwcmV0dHkgY2xlYXIgd2hhdCBmaWVsZHMg
YXJlIGF0IHBsYXkgYW5kIGhvdyB0aGUgcmFjZQ0KPiBoYXBwZW5zLg0KSGkgSmFrdWIsDQoNCkkg
c3VwcG9zZSB0aGUgc2Vjb25kIGFkZHJlc3Mgd291bGQgaGF2ZSB0byBiZSB0aGUgcXVldWUgaXRz
ZWxmIHdvdWxkbid0IGl0PyAgV2UgaGF2ZSBhIGZsYWcgdGhhdCdzIG1lYW50IHRvIGF2b2lkDQp0
aHJlYWRzIHJhY2luZyB0byBhY2Nlc3MgYSBxdWV1ZSwgc28gaXQgd291bGQgbWFrZSBzZW5zZSB0
aGF0IHRoZSBhZGRyZXNzZXMgb2YgaW50ZXJlc3Qgd291bGQgYmUgdGhlIGZsYWcgYW5kIHRoZSBx
dWV1ZS4NCldoaWNoIGlzIGNwLT5jcF9zZW5kX3cgaW4gdGhlIHNlbmQgZXhhbXBsZS4gIFNvIGlm
IHdlIGFkanVzdGVkIG91ciBleGFtcGxlIHRvIGluY2x1ZGUgdGhlIHF1ZXVlIGFjY2VzcywgdGhl
biBpdCB3b3VsZA0KbG9vayBsaWtlIHRoaXM6IA0KDQpUaHJlYWQgQToJCQkJCVRocmVhZCBCOg0K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0JCS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQoJCQkJCQlDYWxscyByZHNfc2VuZG1zZygpDQoJCQkJCQkgICBDYWxs
cyByZHNfc2VuZF94bWl0KCkNCgkJCQkJCSAgICAgIENhbGxzIHJkc19jb25kX3F1ZXVlX3NlbmRf
d29yaygpICAgDQpDYWxscyByZHNfc2VuZF93b3JrZXIoKQkJCQkJDQogIGNhbGxzIHJkc19jbGVh
cl9xdWV1ZWRfc2VuZF93b3JrX2JpdCgpCQkgICANCiAgICBjbGVhcnMgUkRTX1NFTkRfV09SS19R
VUVVRUQgaW4gY3AtPmNwX2ZsYWdzCQkNCiAgICAgIAkJCQkJCSAgICAgICAgIGNoZWNrcyBSRFNf
U0VORF9XT1JLX1FVRVVFRCBpbiBjcC0+Y3BfZmxhZ3MNCiAgICAgIAkJCQkJCSAgICAgICAgIGJ1
dCBzZWVzIHN0YWxlIHZhbHVlDQogICAgICAJCQkJCQkgICAgICAgICBTa2lwcyBxdWV1aW5nIG9u
IGNwLT5jcF9zZW5kX3cgd2hlbiBpdCBzaG91bGQgbm90DQogICAgQ2FsbHMgcmRzX3NlbmRfeG1p
dCgpDQogICAgICAgQ2FsbHMgcmRzX2NvbmRfcXVldWVfc2VuZF93b3JrKCkNCiAgICAgICAgICBx
dWV1ZXMgd29yayBvbiBjcC0+Y3Bfc2VuZF93DQoNCkFuZCB0aGVuIGlmIHdlIGhhdmUgdGhlIGJh
cnJpZXJzLCB0aGVuIHRoZSBleGFtcGxlIHdvdWxkIGxvb2sgbGlrZSB0aGlzOg0KDQpUaHJlYWQg
QToJCQkJCVRocmVhZCBCOg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0JCS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoJCQkJCQlDYWxscyByZHNfc2VuZG1z
ZygpDQoJCQkJCQkgICBDYWxscyByZHNfc2VuZF94bWl0KCkNCgkJCQkJCSAgICAgIENhbGxzIHJk
c19jb25kX3F1ZXVlX3NlbmRfd29yaygpICAgDQpDYWxscyByZHNfc2VuZF93b3JrZXIoKQkJCQkJ
DQogIGNhbGxzIHJkc19jbGVhcl9xdWV1ZWRfc2VuZF93b3JrX2JpdCgpCQkgICANCiAgICBjbGVh
cnMgUkRTX1NFTkRfV09SS19RVUVVRUQgaW4gY3AtPmNwX2ZsYWdzCQkNCiAgICAgIAkJCQkJCSAg
ICAgICAgIGNoZWNrcyBSRFNfU0VORF9XT1JLX1FVRVVFRCBpbiBjcC0+Y3BfZmxhZ3MNCiAgICAg
IAkJCQkJCSAgICAgICAgIFF1ZXVlcyB3b3JrIG9uIG9uIGNwLT5jcF9zZW5kX3cNCiAgICBDYWxs
cyByZHNfc2VuZF94bWl0KCkNCiAgICAgICBDYWxscyByZHNfY29uZF9xdWV1ZV9zZW5kX3dvcmso
KQ0KICAgICAgICAgIHNraXBzIHF1ZXVlaW5nIHdvcmsgb24gY3AtPmNwX3NlbmRfdw0KDQpJIHRo
aW5rIHRoZSBiYXJyaWVycyBhbHNvIG1ha2Ugc3VyZSB0aHJlYWQgQSdzIGNhbGwgdG8gcmRzX3Nl
bmRfeG1pdCgpIGhhcHBlbnMgYWZ0ZXIgdGhlIGNsZWFyX2JpdCgpIHRvby4gIE90aGVyd2lzZSBp
dA0KbWF5IGJlIHBvc3NpYmxlIHRoYXQgaXQgaXMgcmVvcmRlcmVkLCBhbmQgdGhlbiB3ZSBnZXQg
YW5vdGhlciBtaXNzZWQgd29yayBpdGVtIHRoZXJlIHRvby4gIEkgaG9wZSB0aGlzIGhlbHBzIHNv
bWU/ICBMZXQNCm1lIGtub3cgaWYgdGhhdCBtYWtlcyBzZW5zZSBvciBpZiB5b3UgdGhpbmsgdGhl
cmUncyBhIGJldHRlciB3YXkgaXQgY291bGQgYmUgbWFuYWdlZC4gIFRoYW5rIHlvdSENCg0KQWxs
aXNvbg0K

