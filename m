Return-Path: <netdev+bounces-178717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2749A7862D
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 03:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D1416B7EA
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 01:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0F4B674;
	Wed,  2 Apr 2025 01:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KqpEivnD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E+5S7USq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612EA2E3372
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 01:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743557690; cv=fail; b=Foqi4PLWcUVT6QOQiu3edkjFPqBjKCv7zWSaweHHpDAuzPMfRXzSO6GvY+uY0qO6guhlLZAzhljbxNfAo4m4ADiT5tsKmBxEoQyBuHvmPqEw/udREoil2M/zTp3wCJh/NLAUfDE7jsmGIidptrYxHrXDrgPGfWGL9zjY/umVrxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743557690; c=relaxed/simple;
	bh=ixU+9xm4jhYqCll598h4LrQgLAckpdncWCLgtf+jNFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L+J2DBm63agBNWGqCOGYjzjodV38dLzIeTZCNjgKD75RcMCvtGlPyncTkgDhgvG9LCFsSp8UtLOtTASMoSrtoZeefw81LJbl14Zlx7NjifPJ2PoJWLBXVng373nxhYI4Q9cEh8Z82EIKlzKv7RkxWz3+eSxM8cTgOQVZd6wEH0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KqpEivnD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E+5S7USq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531L2H1L003698;
	Wed, 2 Apr 2025 01:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ixU+9xm4jhYqCll598h4LrQgLAckpdncWCLgtf+jNFg=; b=
	KqpEivnD3u1aBdgGzBgLPrBiHbNNqDgPvTJoSsCuywixIgNckGuTTgEKIKsEFH37
	N0ea6e/GzPgsTO3iCMEJicjfqRasd3LOZo05gTg3165nUr3+jt0/sKQWAjI0jUBx
	oPcfowrYxVJBDGnD8sTkJOiktTg13bIfjgbn/RKUQGgQjmCV8SHxURhddM6lj0To
	8GRxBHjKBfxATvdgT/d0JKkBJZnp/eIb1Iwb9Nk4D582leW75lpFEeJTISAy9qjW
	pmvf1rksayBCbX351a4UKR9Uua62MNgy+/6jXIY19cuskKVNACS7kYEIhsXt+nZr
	g77rHdSTbCNE3DGG/7mAzg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7sasfu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Apr 2025 01:34:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53218455010757;
	Wed, 2 Apr 2025 01:34:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45p7ag7jwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Apr 2025 01:34:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5N3vErAwLaT9WX9azwcfGgT1LbHx2eq7YtVWe8N/oaEWQAG6dMTBQP8TmkRYC91u909Pg8tcFtCs0S0ymhoH6brlgvRI1rmI+kWJuFs6pjEpCHobj+s52Gus9PEUe6a6Du2C94sJTW87G5hqFV0dJCIh/tERKhW8AVHSVkyjKi9MZQv4VOMDBRLcD62E1nppED74X5p6VxDySbPEVDgjNaxorygojFTGiVoTVe832btIbn1nsuIi2/afAWh55pmqL2rQjggne2cj6IsWtDtySiDBBuenl4VH5YvYEXxg4MRYu4//Pm/Iw4NYJLmXVAJzALaxe4o19IPhVxIE3UpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixU+9xm4jhYqCll598h4LrQgLAckpdncWCLgtf+jNFg=;
 b=fAmPG5CD6eJsSsIOKS3H9hbA6r2/iKM2V601IyZCzcR6ONNfrTZ8g7UvqfkFmCpKdM0PNn8ZI0XvuP2ImeUNim8GiUBJLEpytvxJfaJLEpzv3dpz/WixzTUJjA8XdaTNVwxcOc3JBw+zVmp3H5d6dvozXoqqIpDrJr6MiLkO1Nvy9E3e4B7WjBcvI+w29Ofyn6lw7DGsRjG6Wz4uBKIvCOaz0sqzu4n5oCVhUQkheVROTvJxr6gTyko2woDMJ5jPo/XZmQLwDAzFbt1jP44awwTJEGwjqPGtxJjxY6YPCalku1SPRIpCGCWmDWJQSuCYctn27btn2y8KSu78Uswlqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixU+9xm4jhYqCll598h4LrQgLAckpdncWCLgtf+jNFg=;
 b=E+5S7USqi9R8Gbnw7/KcdDj6NwuUw6NNdicChdY8uVE+l36JnXgSviyLCTNJGqrBXe+lJgcJBWN9h6SD988A+fEPsAe+WM5JRK+HHFBxvGrTDuyxQ6v9Ij5qQTVNe9Uf72Cdv1UofSuSzodx1m0VSrO359W4O7JMXLWWy0pgyAI=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.36; Wed, 2 Apr
 2025 01:34:41 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.8583.038; Wed, 2 Apr 2025
 01:34:41 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv work
Thread-Topic: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv
 work
Thread-Index:
 AQHbiM/MqlxGuKFhJ0mhR9ncavILwbNdbXkAgAZOyACAAAGMAIACndEAgAAbDYCAAbbOAIAAa2qAgAacQICAFpVwgIAKApmA
Date: Wed, 2 Apr 2025 01:34:40 +0000
Message-ID: <7f47bb1a98a1d7cb026cf14b4da3fe761d33d46c.camel@oracle.com>
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
In-Reply-To: <20250326094245.094cef0d@kernel.org>
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
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|DM4PR10MB6229:EE_
x-ms-office365-filtering-correlation-id: 24af2370-f726-438a-45f2-08dd718689ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U01IN2Noa29jNWZXZHM1b3pmdmsyelQvOTd2NmZZYzVNMFl2M1RqR1FRazJt?=
 =?utf-8?B?QWplTnZ6VzVSUDZ2Vm1OblkzZFVrV05SbmN6TGQ2b3NwRVFKVk9QQWtKNWFF?=
 =?utf-8?B?UVUvYUZSY0w5U0p0YUt2RitvM1RseENUS2ZLQXk2TE8zckZsazB3WGhaVmxu?=
 =?utf-8?B?VXNEMytDcWIreGRWZ2I4NEtxWVdFMHkwSmI4Y2F6dWJhWi9WUE5BME5vMGxy?=
 =?utf-8?B?ejZZc3VLakk1WHpkRWhJRDhKdW94eTFWbGxDanBDM0VWOS9PUlJpcHFreWcw?=
 =?utf-8?B?OXhuOU9KYkhuOEczVm1GWHhPOTN1TUp1R2dldlllNzViZFVYQytxWDJVbUpa?=
 =?utf-8?B?NXVxRDU2Q2pFQ0VWL1BYdkZQNmJPMUpCck1jS3JHTDRPTWwvNGVYcUh2Y1Nu?=
 =?utf-8?B?Vkh4ajJ4V2dCRS8zV2VQMFY2SGQzOHhOZXZmeWNjTEw1ZFk5alArMUxjVElY?=
 =?utf-8?B?MzloNmVGUGJaRUJOZkpHL2hlWjAyMUswQ2pPNFZRODlKN0QrT0FqUkpzYmJp?=
 =?utf-8?B?cjNGSC9qZDhJS1pUNnQwSUNqTWpGYWtlb3FGbEliOUw4MWp5b2Z5dWx1MGtj?=
 =?utf-8?B?SmVmaVJvK29CbjBSZGRaRnhqbzg4aTF2NlZUd0hPYjd0aE9acGtMQjNQbi9j?=
 =?utf-8?B?bXQrYU5vWVpidndxWEJnQkw1L2xLWDd6QnNxMGdxYk1mc3pVZkg1NVJKdXdy?=
 =?utf-8?B?MmpIb2xoN2krN2dKT3RkTFE5VGpNYU9oQWtoNi92V3R1RExFMUZ2RVNOa3F6?=
 =?utf-8?B?TkRJOW42cXREVEJhTHdST09YaE9HajRQSWkyM3FxTFJPdUdSNUU0WmZhVStP?=
 =?utf-8?B?aGN3OUsxTm9URmNZSGJ6bDhMWXp4dzRramFyTWZvTHc2UklCSCtZSmdWdGMx?=
 =?utf-8?B?SU5sSWRNRzdRajc4Rm5pMTJXVG1SS2M2RGVwUXhIQkszNncxbjc1eE10amh5?=
 =?utf-8?B?aHhCcDN6THdzRG9iVmh2cWdzWXhDQXpITHFkci9ZSmxYRHdDSkVCNDR3LzlG?=
 =?utf-8?B?MXNNWHgyVmxEYXZVYWVHNjU1ZEdsbHRPb3VobFZROTdsY3dGUXg5Vm5qb0Y5?=
 =?utf-8?B?NU5yNHBHMERJbm1KZ1VKOUJwOFFDNXpuT1BlVUhtSHpDVWYwZm5LZGZDeDA3?=
 =?utf-8?B?alpnS0wyTGtKaDJQa1lrc05tWTRHTlBwQ2hLeEo5N2NvUmlmWDluWStpWFhG?=
 =?utf-8?B?MUJhZjVzRjVpb1IxdGtaN0RyaElGSFJwZmNTdmVYS1NjM0dCK1N1bWdzY0NR?=
 =?utf-8?B?eEJtV0gwVk9SbG5oNnVQblJmS2RhSkRVekw1ZmJhTTVMeWw4TDg0Y1RXMnZP?=
 =?utf-8?B?RlBvRmJ4ZUFmdHJ4YytibWdFV3pwVVRFRzlUb1djbWdKZ3A0L0FNQmMzWlFm?=
 =?utf-8?B?OHlYTWJCbi9HakJRZnJZNzBxbVk0S0JzY0RhRVMxRE9ZUm02L0pwMWJhci90?=
 =?utf-8?B?VGFlcXVRUU96Mmh5ZlN1eGYraGFuZFpCUnFxMVlaZzNxekgwcDNQWmFRaHoz?=
 =?utf-8?B?Zk4zWUFWNlBPMUZqSFoxa1BybDlyay83VHQ4TDRMczdLRTI2WEtjWVlvV1NM?=
 =?utf-8?B?Y3F4Q3RKSW9Cd25SMS9nWXNjWnAyQXNqM0psNHlxYUVyMEFUbUM1U05QVzVM?=
 =?utf-8?B?Q2VQUkJRSm9tc2VxV3l5aW9Da0F1M2dsTmF6MWxRY3dQK3hzTTJJTGdzUEQx?=
 =?utf-8?B?MWpBRWZwV2U1RVZZQitWaG05RzJldU5ZWHdmNk1OemF1MTdBMFp5TC85NHRQ?=
 =?utf-8?B?QTlYNWhxQVZ5YjNWNkZWQ2NJL1ZleWkyZU9BRytSZHp3SkVBM1h1QWJCbElj?=
 =?utf-8?B?K2NDRG1XVDJBTkswcTZmV3dkY2pjK1JPcDRrZHNVOXBjRlVGYnpLcnpUVzIr?=
 =?utf-8?B?Y3ZHT0lka1dNcWdCenkzNGJKYUE3Yk1uVzJ0Yk12Sll1RWpiQUdabGs5bmNt?=
 =?utf-8?Q?iEFelY6mCWpbDJiSWf024s9DDRDwoA9K?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzdWcmRwYTV1TlZ2UDhnUFJXcmY0c2d0NGRaZ0dsQ1VjbWU5TFMvdHBZdTAy?=
 =?utf-8?B?dit0bWxKYUhDRk95RkZJS0gyU2hYcVdINE1FMVlWRDR5d1RRMm9rTmFCS21u?=
 =?utf-8?B?OStOQk53eFpCWXVnQlFnek1oR3J2cDd0TXZhVldyRkxDVCs5QnR4Z1JEU1do?=
 =?utf-8?B?NS9rN0NRdTA1VzdsT3BhRjZVbVVsQkRHclV2NGszUXJ2UjYwR203cHdOZkVX?=
 =?utf-8?B?VHBwc3FPTlJ0RUZpc09NL1VPK0FIcjhhUHgwcVZBSThRMnVrVUJkbHVrRE9R?=
 =?utf-8?B?NkdZKzJVWHVETllaR00zYllnSkpwYTBPVDlZNXdwR1R1RVZIZ2FWZVQrQjlV?=
 =?utf-8?B?K2pwTk53Tm1UVWh2bXVVWXhqOVN4SnBFMEF3REFVM28vYjNEK2ZpU1FmVDFH?=
 =?utf-8?B?dXJCbGtiSFdLMXY3Q3k5NjdUb0Rob0s2bG9Jdi83d2VycmdPWDRsVjU4MVhO?=
 =?utf-8?B?bTJJNjY5d0xPeXFLdUNWYy94U2dkZzJLMm81ekd0RWVBQ3JDYVpxamRTS2d5?=
 =?utf-8?B?MmxZaGRaWS9Kc2QvSTRnakQ3WWx6UVUzdXhlSTU0MDlGY1ZSNm9aVnQ1RUtT?=
 =?utf-8?B?dGtTRHdKc3VOcFZzYzJFZDJNMHhVUFdWS2VrOEw5eERoeklMVzNGb2xha01C?=
 =?utf-8?B?UE90SHFQZjRzbFl0b0gxOWJKOEhZeWNyRjY5NmhBWTJZZmVNNnVsWk10OXRR?=
 =?utf-8?B?aDFRUGZIZHhvQTZoaFRjUWp2Y24rSFl2WDR2QjdkcTdsRjA3ai9sZGFDN0F3?=
 =?utf-8?B?b3ZIMFF6WmVrd0RHekkxZFA5YmQwcHcyRGRDSS9ZK0FWOXVnYmFXaEZOVVRC?=
 =?utf-8?B?UUVqb3NudXlYcEZIVDNTOXpLK2dHM2lpYTBiRnUvVVUrWVd4bEtva3pFVDlX?=
 =?utf-8?B?akFrM0MvUkdPbGh5VFJuWStQY0dMMlE0ZEtuK0g3aWl6Qmd1c1pFOCtraWF4?=
 =?utf-8?B?b01Hby9LVVVob2NjY0pzOU1OZllESGVwSXlnK0xLZGhqajc2Z3AzTExia3lo?=
 =?utf-8?B?R3BPSDhNZDlaVEZ3T0ZzaHhNTXFLcjhpV1hYZ21pdnNPei9QbmZJNVVGeS8y?=
 =?utf-8?B?NEgyZXYzWUJyUFZiWHNxSFZaT3Z2aW9McUNKNlJPdUVQQWhrMmxMSWZ0eFJD?=
 =?utf-8?B?T1E1NmdvaFNidTQyS1hjVGZIVGdlNjZwNEVuWm5zbGt6Tks4Y01qL1F2akUr?=
 =?utf-8?B?b3ZseGxNa3NlOTBCeWo1QXhIclhzc3Jya0xyZS9TMEp6SFVMWEpRc3ZSM2dS?=
 =?utf-8?B?b0gyTUJwNXBKbXBCVnFXU2RxdWZQbTBjNk52cExZRWhTaStJM1kzSlY5TWVV?=
 =?utf-8?B?N3JlVldzYTJqeTY5dnN3SDJwUmNIem5OU2U2UXRTbnM5Y1VYd3gvYXZ4M3ZV?=
 =?utf-8?B?VDdkSGczK1ZSV210QTZPWVZMVXV1bWp5SUVscU5HSW05UTlkMWZJQXNmN2VB?=
 =?utf-8?B?dEd4a2JaanJpSjFzcVhvQ0NsbUkzbUdoU212NDdjZmZsdXlhMzUvRE9jZkVX?=
 =?utf-8?B?Yk0xWXpyU0k4QTJ5SldZL1FuRzd6bjA2aXJWdnpwNVB3d01qcUtHN1pKczQ4?=
 =?utf-8?B?TkFrQk52bnNOYUZFc1cvajU1TVI0RmE3MDAvS2Z2YlJabU9kTmZ6dDF5NEwr?=
 =?utf-8?B?dkhIaDdZcHJ3R3BtdGFUL1FjV0RBbzh5WEdSMFhQYjZWNEx5eTRXK2t1VUNR?=
 =?utf-8?B?OEorWEJ4VzhtOFRWSXRLb2xVMzAvUXp1ZkR3Qkw1eUVCUkN5aUNoVWdabkRY?=
 =?utf-8?B?NWJkUGd5WEdudlJHLzZ3a3BnLzl3YS9pcE9ZN3V1cUhoNi8wMWNrTGtNNkwv?=
 =?utf-8?B?RWxia1pqSm5XQzBhTVZrR0k3bWhyeVFVMHJ2bnozU0NkQUpsZmIxd01PNnJx?=
 =?utf-8?B?OTlHZjRBU0M5dDI5WlBiVnhCQVFTY01ZeTBCUTJTWm1HZVphM0tFdTRKTkps?=
 =?utf-8?B?VHhGMFJrNkRYL2dIaE8rUHFOMVU2cndyNy9YOVIwTTcwM29pVU1yR0dSWFR1?=
 =?utf-8?B?TFpvSEdMZlJMZnRJQ01Kb20xZjBWM3doSENLR3pxRkt1VFpXSC9aTzdlTkVN?=
 =?utf-8?B?T3F4aDNMMStEblc2MG9wZGtQRmZSQjZLcjFDMWJKS3N3RTZvQmNvMEpFQm5m?=
 =?utf-8?B?WlJiRUlOZzBpeW1hZzR1N0Rkdkt4NjB2SGRVZnpBcUYxVFRmWFErMnlIQXN1?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D20FA4A0A5B6E24B8F38185168F7C11E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GCzRU1pCWG3/o5nkyilN3J5kW+tMlT/C21KzdSSy+LfhFupJb9sc7uMZZtKOdwnjKzG9A7aZd2FWVQhOo0cRI8xvp0MHV5GFpoabU07N+0nvGaOwc1mPZBEpEVh1mYhlZFafvKPpYsPncp7AGwt6p0OxOxbsJJwctmNZWPUIi4rZn5BkWBGF+yD9akDVNxaAKek6fee/fD94rEVitf/tmUwfCQ8v+P17JY2o1Uc+6i0QPGhtVwbYp5F7yoBYQX7zo5igoEoQZWO6h59n7lvnRsxF+c9GY8tupugtEJYxgd8K8TUnR8zjpvSaJQIYIBJ9z7uYZaH/nuza3QcW/xrR90XxX+9c/jxgWr+iEiSFa19/iQnjGL7rFEksasIw5csAwJ7dDU8T6L3uLIOMojh60Iy7KLFC4zaiQ75D/tNv5nfZ/CuXDIK+5SSItazvDWEjU0TZYTRXxpKkv05nYN6/f5EhiDoXu09S36NsEff8kGwvd6YiWiwObGZ3Bzf1G28M19/MwbvjO1at6vPn6xjtD/kHWaOxJAYon1tAEsh7xd0rGJXztVoolc1nUivuFLFGvQwFgAXCKJqcNnjmkFVda6cFN4clVkgwSGpP05cJTDE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24af2370-f726-438a-45f2-08dd718689ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 01:34:41.0083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zsjzulj/kpJlnpS4O6Bh/rQw4Cynv3BSPHlxDB8LI4pCIKXY8CngE0ooGgg2EK6wmq9nl97bFbrdd2pi1tR2rusXrpwDR8su/SUCUSOEGzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_01,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=776
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504020009
X-Proofpoint-GUID: ICdP_Z6sV524fDZMW59j6veywIzvuk3B
X-Proofpoint-ORIG-GUID: ICdP_Z6sV524fDZMW59j6veywIzvuk3B

T24gV2VkLCAyMDI1LTAzLTI2IGF0IDA5OjQyIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gV2VkLCAxMiBNYXIgMjAyNSAwNzo1MDoxMSArMDAwMCBBbGxpc29uIEhlbmRlcnNvbiB3
cm90ZToNCj4gPiBUaHJlYWQgQToJCQkJCVRocmVhZCBCOg0KPiA+IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCQktLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiA+IAkJCQkJCUNhbGxzIHJkc19zZW5kbXNnKCkNCj4gPiAJCQkJCQkgICBDYWxscyByZHNfc2Vu
ZF94bWl0KCkNCj4gPiAJCQkJCQkgICAgICBDYWxscyByZHNfY29uZF9xdWV1ZV9zZW5kX3dvcmso
KSAgIA0KPiA+IENhbGxzIHJkc19zZW5kX3dvcmtlcigpCQkJCQkNCj4gPiAgIGNhbGxzIHJkc19j
bGVhcl9xdWV1ZWRfc2VuZF93b3JrX2JpdCgpCQkgICANCj4gPiAgICAgY2xlYXJzIFJEU19TRU5E
X1dPUktfUVVFVUVEIGluIGNwLT5jcF9mbGFncwkJDQo+ID4gICAgICAgCQkJCQkJICAgICAgICAg
Y2hlY2tzIFJEU19TRU5EX1dPUktfUVVFVUVEIGluIGNwLT5jcF9mbGFncw0KPiANCj4gQnV0IGlm
IHRoZSB0d28gdGhyZWFkcyBydW4gaW4gcGFyYWxsZWwgd2hhdCBwcmV2ZW50cyB0aGlzIGNoZWNr
IA0KPiB0byBoYXBwZW4gZnVsbHkgYmVmb3JlIHRoZSBwcmV2aW91cyBsaW5lIG9uIHRoZSAiVGhy
ZWFkIEEiIHNpZGU/DQo+IA0KPiBQbGVhc2UgdGFrZSBhIGxvb2sgYXQgbmV0aWZfdHhxX3RyeV9z
dG9wKCkgZm9yIGFuIGV4YW1wbGUgb2YgDQo+IGEgbWVtb3J5LWJhcnJpZXIgYmFzZWQgYWxnby4N
Cj4gDQo+ID4gICAgICAgCQkJCQkJICAgICAgICAgUXVldWVzIHdvcmsgb24gb24gY3AtPmNwX3Nl
bmRfdw0KPiA+ICAgICBDYWxscyByZHNfc2VuZF94bWl0KCkNCj4gPiAgICAgICAgQ2FsbHMgcmRz
X2NvbmRfcXVldWVfc2VuZF93b3JrKCkNCj4gPiAgICAgICAgICAgc2tpcHMgcXVldWVpbmcgd29y
ayBvbiBjcC0+Y3Bfc2VuZF93DQoNCkhpIEpha3ViLA0KDQpJIGhhZCBhIGxvb2sgYXQgdGhlIGV4
YW1wbGUsIGhvdyBhYm91dCB3ZSBtb3ZlIHRoZSBiYXJyaWVycyBmcm9tIHJkc19jbGVhcl9xdWV1
ZWRfc2VuZF93b3JrX2JpdCBpbnRvDQpyZHNfY29uZF9xdWV1ZV9zZW5kX3dvcms/ICBUaGVuIHdl
IGhhdmUgc29tZXRoaW5nIGxpa2UgdGhpczoNCg0Kc3RhdGljIGlubGluZSB2b2lkIHJkc19jb25k
X3F1ZXVlX3NlbmRfd29yayhzdHJ1Y3QgcmRzX2Nvbm5fcGF0aCAqY3AsIHVuc2lnbmVkIGxvbmcg
ZGVsYXkpDQp7DQoJLyogRW5zdXJlIHByaW9yIGNsZWFyX2JpdCBvcGVyYXRpb25zIGZvciBSRFNf
U0VORF9XT1JLX1FVRVVFRCBhcmUgb2JzZXJ2ZWQgICovDQoJc21wX21iX19iZWZvcmVfYXRvbWlj
KCk7DQoNCiAgICAgICAgaWYgKCF0ZXN0X2FuZF9zZXRfYml0KFJEU19TRU5EX1dPUktfUVVFVUVE
LCAmY3AtPmNwX2ZsYWdzKSkNCiAgICAgICAgICAgICAgICBxdWV1ZV9kZWxheWVkX3dvcmsocmRz
X3dxLCAmY3AtPmNwX3NlbmRfdywgZGVsYXkpOw0KDQoJLyogRW5zdXJlIHRoZSBSRFNfU0VORF9X
T1JLX1FVRVVFRCBiaXQgaXMgb2JzZXJ2ZWQgYmVmb3JlIHByb2NlZWRpbmcgKi8NCglzbXBfbWJf
X2FmdGVyX2F0b21pYygpOw0KfQ0KDQpJIHRoaW5rIHRoYXQncyBtb3JlIGxpa2Ugd2hhdHMgaW4g
dGhlIGV4YW1wbGUsIGFuZCBpbiBsaW5lIHdpdGggd2hhdCB0aGlzIHBhdGNoIGlzIHRyeWluZyB0
byBkby4gIExldCBtZSBrbm93IHdoYXQgeW91DQp0aGluay4NCg0KVGhhbmsgeW91IGZvciB0aGUg
cmV2aWV3cyENCkFsbGlzb24NCg==

