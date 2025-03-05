Return-Path: <netdev+bounces-171867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E0AA4F2D4
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09DDA3AA932
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE5ED530;
	Wed,  5 Mar 2025 00:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EdB0Y7uI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IfNuc+xR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3384D3594C
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 00:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135136; cv=fail; b=Ozku293LlreGK6UUOKgBktdqvVRA9/2nLAtjSUwOCUYj7iGVIby+Fp2JScwTBGol5HM8Q3ekXtBNAvgFief0zT09UsyRsf/LfuUaYbwaVk2kq0gr8KAnaxsdEtBYA57zGznfpIM5h1OmmaS5MN1Oeb5B0JUiic5RqXJdsaJaB4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135136; c=relaxed/simple;
	bh=LmOJbHjhtJWbzydlXsEeh9eo0pYO0PLfhribJsliNlc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hiKtbvY1UDMXAOV6F8qDyDat2YQOOqJXLVnqOYVQTL6YreD6gNL2+fmXkgHuceNBmXZznlyhkh3KRJypZ3Yi/wF24aIPWRSCW22FshCiiOGG46lsDAWlsX5hCJZF1Ao4tqlwy7fCDfHs2BoIj54+4qmPbBwpieqtlZnr33x0W1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EdB0Y7uI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IfNuc+xR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524NtfaU003247;
	Wed, 5 Mar 2025 00:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LmOJbHjhtJWbzydlXsEeh9eo0pYO0PLfhribJsliNlc=; b=
	EdB0Y7uIJppUHkGSjHfiTR+/T8SJsipYQTUaipOIX1XuPdTxo61mZtNj0ua0HfbM
	umaD7m1iMsCwc3jJ5UpEzaydNwu0abg9pvnzJcbCHQWhRGl4WyylKgv86IKDeYYF
	QfCBuuy5iDhgc1wXCqe/VZ0MY5cM4UUrQgO368vsN62eOaCTIQxrqko0N9O4028e
	NIJhc4+bzABpRsab2poKpV5izo2ZJyoIZEpips7rU7bIsAczNRxofRZTA/bpB3nv
	RtvxDHIp7d7IBEMdHw8jAOkw0KevZAZDAQkD6DI/HgwIRx+CiHFN6TzZ66S9ZEZ/
	reGAon4a0ik6TdoI/UO23g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub76ea5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 00:38:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 524Mqs6p015687;
	Wed, 5 Mar 2025 00:38:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpawrrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 00:38:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gt0Ue4fcZDlkqj2FcRnvgFDm6KbkRln6cUXMIfN0aLu0tglMjiWuv0QRQDmBLow8PuA0K/dN6JgVrJmrTUCfOQ9ZKREwhjCyxY/ORiXxDZGTrjxAfaaHtQkL9WSR/0A1lRdCHbiJoIPWRRQPsdhMHQJnGsJuYc88bB+hu52lIpNuBtrS311Yud75c6zwWjfV9pEzzb2ub6pDo/tNqjCTWdn7LIuEajwRnONESFpUO0cP59p7+JB/3XoapGTB77+Wvl0gMSeSdikqElZg3gyhNgPT8bsGduEs6knaFjkSt4/vkOEzwhHbyX+UChVrK18y6U2On+OGOLQx7nv3pq/Omw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmOJbHjhtJWbzydlXsEeh9eo0pYO0PLfhribJsliNlc=;
 b=twMV6b/i6xpoRniM6XMcQXABQn5QxKHnT5At1/5iDRM7BxtRc2dGMipe5Io2VE6fgsUMcjjIkm3XI5soIkpem/m+u1MpRIDX0E/jz0B3McAHUuuRGmTkjMuoJTg3fzPg+Ik6QDh/aGKCBeNEUaCD8y6q4vSR7m7driz6ovOAIvSKo2mQydyz4W/ulIj1LPWWPjm6viX2yzdsFuvDm6rMips1hMx13eCuTGK/txFdwsbDKOIO7m/ZxLvTxKu6qibtWIWaVFlKgyMK2ud4oHLbi5/NMl/pnnUoFLyBbes34kA7qOhvim/nZ7o0oxWLePb/IBmJS9GD0TTAMRDQ9Xh4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmOJbHjhtJWbzydlXsEeh9eo0pYO0PLfhribJsliNlc=;
 b=IfNuc+xRecrMihv+aSF2XMzWlSBWGkjnRwxpyGmjiStqdm/XACmUhLR2GqpVlh6LpTV+Zuz3e+YFursmNvDLqonjDOR3U0Q9/j3FZMhTk4xCuUIlg755A226qy+FI8gr2JTNR7SKlk2XW/zXbS2DTtGOLc1bXFGf2w/J+/XKcm8=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by CH0PR10MB5036.namprd10.prod.outlook.com (2603:10b6:610:dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 00:38:48 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%4]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 00:38:48 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 4/6] net/rds: No shortcut out of RDS_CONN_ERROR
Thread-Topic: [PATCH 4/6] net/rds: No shortcut out of RDS_CONN_ERROR
Thread-Index: AQHbiM/Qplw0Ka8JQ0C2/iHleYhDVbNdbbQAgAZOlYA=
Date: Wed, 5 Mar 2025 00:38:48 +0000
Message-ID: <5c74b4452cff9402c2ce905ae45e678363bdd737.camel@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
	 <20250227042638.82553-5-allison.henderson@oracle.com>
	 <20250228161958.74a4ead3@kernel.org>
In-Reply-To: <20250228161958.74a4ead3@kernel.org>
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
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|CH0PR10MB5036:EE_
x-ms-office365-filtering-correlation-id: da93b4ef-356f-42f0-0641-08dd5b7e182a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bUV6TVVlSGRybWo2Wmx1cTQwaUNYQi9yUVF2MjB0bFJTTEZEZ1FZZmp4R3M5?=
 =?utf-8?B?Sk9NWlFqV0ZZS0RSMG1iODdSdytITE5pMFRQU25FYmVTdFZja25GKzNUK2hO?=
 =?utf-8?B?K2x3aWlQWm8xWkZ2WC9MS1BvMXV1U0hwRE5XOHJZU2V3Q0w0cE1ReTh2RmJ1?=
 =?utf-8?B?eHVxVXZ1QzFtMmZsa1dRNDVsTVJLc1ZyeFAyU01XeHQzMFNlVnMrQ0ZoTUlu?=
 =?utf-8?B?N29pbHVxeHY4Y3ZwUzNsZ3BRMjhnR1JPS3dqZDZWUk5YWW4xRzlWTVgzTmJj?=
 =?utf-8?B?VE5jTUxTcUJjSmdkL1pNWk9PZ0pGWnF3YVB1RW8vdG10SnFtSWNWbHdEa3VZ?=
 =?utf-8?B?VUNBRnJIVDUvV2dUMW5CdiswR0wxc3lzY2ZWRnN2SHVtaExmK2V3RnNmSDJa?=
 =?utf-8?B?aTRoVC9jdnd5bDYwM280TkY2VVRPeUdQRS9BU2syR0doV01XUVF4TW82S3h3?=
 =?utf-8?B?dFRDUVZKenZNUkptMEpQc0RxZDNUYS9LMXZlNzA0ZUlOKzFkVDRxS0FjVFU0?=
 =?utf-8?B?OG5YQWRyYkRwaDZBbW0xYWVLdy9KOVVsT2tiRW1VRDBhUWdFenRYeTV1VGww?=
 =?utf-8?B?UC9XcVlsSHZvQTRIQjBzNjdJNmFQblc4UThPSnh4QktGVjl1NFdsSTc1aHBm?=
 =?utf-8?B?VTI2VFBzTkdiTnJEVHZkNXlrZGpyUzZtWFl4SUpxQ2NIVW13bnN4eWFISHJD?=
 =?utf-8?B?eUthc3ptRm5SQm4yL1dKVzQ3N2FhY3htbHJHNndxeDZLMC9JTDNxS3IxVnVt?=
 =?utf-8?B?WE40M3h5dWxETzJQUTlXR1ptTSt6MUlwQzhOT1pvY0VOQnB5cnIyQlpnWGVR?=
 =?utf-8?B?bnl6S2dUSmZRRTNxMzZFVmh6ZU9xZ2tRdnBpNVFTazUwN2RhamNXVCtnUnFp?=
 =?utf-8?B?cTRvakZ0Q1JTYTZGVEdQcWtwaWN2WU1NUWdydUpIVW9TNStRbzJYTjcvNU53?=
 =?utf-8?B?RDV5VmZiZU0xcEl1U2wwZWczSkN0UDVPVUhpZlBVb3ZMaGZDVnBCdDZsd0lv?=
 =?utf-8?B?dEdkRnpobEZyMU92ckpoWWh4ZTNUZHF5WmZwOHNWSlg1bC82TDYwQ3VyQ2Q1?=
 =?utf-8?B?ZHFVRzUrcnBPcUN3b0F1TDhaMzdCZ1pZYWF3UTJpN1FyUitRYTR4OHJMUk56?=
 =?utf-8?B?VGtNM2lwQTZkcEp1VFBNNkdQUzd6V2pUSXdDblR3QTN6NmZaKzUyV29hb29v?=
 =?utf-8?B?eVZ1NXVweVFINUdrTDNxb2RRYTBoa3RLcitxMU1KVndHZTI5cnV6TUhsUjNh?=
 =?utf-8?B?THd1L0ZOR2JtVHh3dlFNS0ZTSzlIeEZXMGtvTXp1YmhlZklJZTgybXZCWTBK?=
 =?utf-8?B?OU5jRUZIWmllbWttcS9HTE9PQkFpV2lIdy8xeFhJT25OdXVqSzQrR0xWY3dq?=
 =?utf-8?B?cjZYMHFQMC9KT3dyT0V1T2NaYVFQMnBqRVp6VE42U2hkWFA5SkVvYnN2dFVT?=
 =?utf-8?B?U0ZPazVkcVo3TFprR253UkhSVUpXWGlFeGU1b1JRR1pYemw1TTdhWWh4cVZF?=
 =?utf-8?B?VVRiam1xc1doR2xOSTI3ak1BeksrbkZOUzBLaTVFUnlLaGU0UmVrc2Q3ejdG?=
 =?utf-8?B?WGN0NHlKa0JPbkczd1FoQTdqckwzTHJmNUNDV3V0OTJzTEpVZzRVL2lRakI2?=
 =?utf-8?B?YXBmRUtjMi9rZ3pSUWZtSldUWnBvMFJzcUVmQVZwaFg1YzJvck5ySWVRRi9h?=
 =?utf-8?B?QWJnT054bHZ3QWtOQW9GVDNVK3NCV29iWXp5cENmMTBVMlp5M2l6dEJBSzRl?=
 =?utf-8?B?ckNBd05xMzdLeFFFRktWY0pvNklDZnlBZ0lkQlFiTzV4N1lvT1JiaFRzUmt5?=
 =?utf-8?B?cDRCYitOQmxyMlNSalFoZllwMVJoSUlOR2tSclhxZkFQVDNqUmwrWElyM2hJ?=
 =?utf-8?B?dTliVjFqN1dpTzg0eVVOMDNXUnRRbHBwNUpTS2tZMDRHYkcxdmZxaFc1dXd1?=
 =?utf-8?Q?fLor1n+egGZvtKSWzFkGhVJPukycev+S?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlI4RHhORjZmZ25za3puQzZpeXhCVDNqVFFLaUM1UXFQMGJUeGR6amh4azQ1?=
 =?utf-8?B?c0MvOVUzczdFYUJ2SXpoV1R2L1p0bnNJWlJjVi9GaThNelA5TXBDMHMrTVU1?=
 =?utf-8?B?YUJIcEtqb0ZXSzRHbGo3V1krMFcwd09HQkdJdWxCaU5rbEN1K2REKyswNjhV?=
 =?utf-8?B?NUk4YUE0UWFqSEJ1OS9KTnhJdWdDL1dkSnZkRGZlUitaUU5iSGF5aWZyb25G?=
 =?utf-8?B?UHFHdnZoZHJmVWUvVnlUcHVhMDlEV2s4RnZjcmYyZFBLQTV3MTdaVERBOHhy?=
 =?utf-8?B?VmZsWkJLdTFkNmNZSXkwVXlMVndOQXo0ZHc0OHVYY0E5ZXoxbzFDMHlQOU5s?=
 =?utf-8?B?Zm1ZbWxwWXpKY1lTS0RCbCtJK1ZQV0QvWHZ4NkpkOFVTaXpGNEorMzZvN3dw?=
 =?utf-8?B?SEhFMFVQM0UvOUhZTjEzMUUyRlBwOTh0TU1KQURkeFFIOWJldnlQK2pjM25s?=
 =?utf-8?B?ekdVYUZLRkYvWVRHUzZ5ZzhSQlQ3UTg1Z2xpOTZrbFVXSGlVNjA2Q0tLVmdC?=
 =?utf-8?B?ZlZJdHFzZGF1YnNHa09pbGFoUkNTdEowMXBydGd5OFJiRlI1N1V4bC9RVFVH?=
 =?utf-8?B?RlJlT0R2OExzOHZnd1dJQjhxQ20zbm1SWTI1WU1ORDVaZ3d5aVdkanFMUWNq?=
 =?utf-8?B?NVFxMDZhZUVCRlMrVWxMcy9IRm01TlB3TGZzWEdUSGovWnBlYXoyVTNPZWh6?=
 =?utf-8?B?U2pUSmdJT1JtUHdwUjFWb3lraGNxMlJPSlpvUkk5QjRqeTRxSmFjNXd0dXA0?=
 =?utf-8?B?enY3TnVOVEdYTEREQ2lVVEllOFovMEszZ1hQZEkwMWJ3YU53cnNFVVZMQldW?=
 =?utf-8?B?UjhuU1ZoQ0hmdzdKYXhjclBVWFhsZUFIMDg4K1JybEo2bEJZMEJDcFhsSWxo?=
 =?utf-8?B?VEQ1TEJTemYyYlhvaGkvMk9VY3N5MWZXbUdONklzNUpmWmVrd0ZJN0xiWDJZ?=
 =?utf-8?B?MWhaLzZMSWZ2VHZnL3VyblpDZmRvWmptZzRUWnZJU1BoTW9ROTdQbytGVWxM?=
 =?utf-8?B?RTBrR0V0Q0s1b1hlMWZ2emFMNE5zZE9MQmF3OWlON1pLUDkrc01oS2tWTkcv?=
 =?utf-8?B?VTFYVFEwRjFvTE5YbWdGY2ltbFpmNCt1Y1k5eno4LysvNlFHb3ZqdjgxcWow?=
 =?utf-8?B?YUJlUlZCUTBUVG5lZFpENzVwWTFxOXZXK0M2MkY0NmJUZjZhUHRjOTlrQ3ZR?=
 =?utf-8?B?VEFwMC9kZklodkw2WGdRS3BIekVGL2MvY2lNa0p0YWlSbjlNT1RpeU1yTXRJ?=
 =?utf-8?B?V3QxdXZmbnhpcy9LZjNMa2d5b2FZbDFvb2J6WWZUVjJ0MFB1NGlINGZtMnhr?=
 =?utf-8?B?b1BWK2kzQTBYZmFnWnJyQ0lQdFlSY0dPVGVIdlRabWd1dERjMG41dHgzU1Jl?=
 =?utf-8?B?MU84bERCWlVZaHJZZ2tvdGhlanVJNlRIYkhZUGZCNStXTHY0S2pXY1A0Z3RY?=
 =?utf-8?B?aENOSzc3N2FkdHFXNzdzaW16SDFHeTV5Vll0ZmhrSXhjTGRFSU8wMGNtamZ3?=
 =?utf-8?B?RG12QmNVcXl0SHFTb1NYakR6dXJFS1NnY1ZJaTI1VldaWHFkcXVMQ1JrVW9t?=
 =?utf-8?B?U1dCaUNtTENRallwMzBJSTNzbEVhaWgyb1JKNXloRE1lVnZLbVBKRjZCU2xS?=
 =?utf-8?B?MU0zVVVybmhqbGZhWFlHOVJwVmZKRklFNnV6TEVTU0lINndkMmpSQ2pHc0Uz?=
 =?utf-8?B?RTBjRmpDSWpieUZhbnQ3N1R5cUFvLzVKaWM2UHRSRFhQak45clg0WmN3elBS?=
 =?utf-8?B?R1haZjFSbkRxMUJWOWF6R3o4bE85bSt1QW12RjYzNlBUTU0xQnlzallDa0lF?=
 =?utf-8?B?RVFSNjcvOSszekgxaDl3S3p1Z0JUcjdhUXhLUk5nRHRQeThaZjRuRVVQcnN1?=
 =?utf-8?B?eXpZZjVuWEx2aHdSWE1UdlBZbHhqRDd1NnlNUDNXK09FTHZHeG5DNXVPRnRj?=
 =?utf-8?B?eTdFR2tocW9KSFozN0RhRU9vd1dmejlZZXR1YURPWTEzcldLUnh6SGhaWmdP?=
 =?utf-8?B?RmVzdU1HNVpsaCtYWlJENEZjcG8zTXpnYkdiazIvTm1XNEpiMUJRNHVTUUdM?=
 =?utf-8?B?SVcxR0hwREZkNkZzMHVwc0pCcjRQNWpYNEJCN1hKMU9xNTVsd2dSajZSYzFv?=
 =?utf-8?B?d2c3YzA4cEJjVU1INFJPYXRVRG5QVWQ4TDh4K1RMNFpzVllsS1RpekllTnB6?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A752F9BBA08B364B88DA842D511FCE25@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5cWpBVgdVQHP4AcTctB0TJOYni3c6hhrrZwQdK2tlmAIxSSYoo1pN8V05SwW6pTeKhQjl+qOVTp682GW/43Y4qc1jqeMkYYPcEwykAqMJK8VszCyIq6O09ZmnvqD9WQhWAKUxPb8Gg6gAJb/nNgc0w364FAr3z+AO3NqDgxC3g+AKuOvKNXsAeoLWrmsuM7wEeQ409eOg8EKrKsA8fhoPIBFBWIOGJGIC3AZfUHXifm/5vL3RxgNdDxei+CAypxgikIqeUC3V9T+5YAnUY5QRujw/Odin0xIigjWSrZbam3uDriKvxy5zuq+OdjQUAUCtMBSJc4CQh4BbJsuftxM/n/W4syLXHdWrGz6h/7dUAEY/eLPfuO6e+S6lJNCR/4scVVSGgN1nWuT66WQtHskK0F7jhqsp6NSB59kQ0Z01iz2IIUfwHRY05Tye9iF1/Wkn+4GG4cAseAxKHrictrunXQ+Iv3UY5JfrP6gzWM7ayVAYH4GCIC0Bsr/686quDzaOH93ch7OEM35G2UV73DlKPkWML4CN0R9KiIxjY1JXp48ZIAJhIJD9UoGhzB4fCi/iUpvTFs/u2fukdNj4hCbUPd9sngIk9EFST5jLxburDw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da93b4ef-356f-42f0-0641-08dd5b7e182a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 00:38:48.5366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1oMvKrIExSD2+3N73+W2raghsikHk0vsgRUp+NBkmItqaxEUEK1qH+iXInLbWIXaGbjV72iyf8Z4kZfwLP3XZFJzleMYEnHkRinrpQ4lP2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_09,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050002
X-Proofpoint-GUID: qbDZlW_un2vQx-nMlp3jXn4itAIjGumx
X-Proofpoint-ORIG-GUID: qbDZlW_un2vQx-nMlp3jXn4itAIjGumx

T24gRnJpLCAyMDI1LTAyLTI4IGF0IDE2OjE5IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gV2VkLCAyNiBGZWIgMjAyNSAyMToyNjozNiAtMDcwMCBhbGxpc29uLmhlbmRlcnNvbkBv
cmFjbGUuY29tIHdyb3RlOg0KPiA+IEZpeGVzOiAgKCJSRFM6IFRDUDogZml4IHJhY2Ugd2luZG93
cyBpbiBzZW5kLXBhdGggcXVpZXNjZW5jZSBieSByZHNfdGNwX2FjY2VwdF9vbmUoKSIpDQo+IA0K
PiBUaGlzIEZpeGVzIHRhZyBpcyBtaXNzaW5nIGEgaGFzaCBvZiB0aGUgY29tbWl0DQoNClN1cmUs
IEkgdGhpbmsgdGhlIGNvcnJlY3QgaGFzIGlzIDljNzk0NDBlMmM1ZS4gIFdpbGwgdXBkYXRlLg0K
DQpUaGFua3MhDQpBbGxpc29uDQo=

