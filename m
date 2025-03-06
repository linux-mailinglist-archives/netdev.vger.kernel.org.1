Return-Path: <netdev+bounces-172518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813ECA5519D
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 17:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD4A18996CA
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 16:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C052C211A19;
	Thu,  6 Mar 2025 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cPkKpgJB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BeS7llYi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FFC19992C
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279310; cv=fail; b=nlU69Id1d4UapjYdseNXS7DFqBn8/2h+TG3zJB5xopFK3/9vyiB8Qjo1VFA9RdE/p5WX2G1fXRbDGdnTxqa0jtYZOVWv7RK5x8uY0j7E8Y7KFZC85SnPEjScSfcgEkte2X/DJ5ftyafhCeprbck9rAeqZya1QTtHEujh36J0LDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279310; c=relaxed/simple;
	bh=h20xXAc4OAuZzzZbUKUDOhhsChYiKOnVNlWCeA6mItc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SIFFpOLdJGoUP2QYbspdrpj7RR1YgphVjsyHLl9n4p5X389r407X8E2UJ0vgJr3LhgO3EEypaWkh7hemBOMO3t3g+oAIt/8imn8A1h0nkbCPsSROkiO+2RH23yRdnGbRPYSaFC6Ro/DBIx/WXgkndUYDiQSsjY7f27ctn22Z1Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cPkKpgJB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BeS7llYi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526Fi5HJ003836;
	Thu, 6 Mar 2025 16:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=h20xXAc4OAuZzzZbUKUDOhhsChYiKOnVNlWCeA6mItc=; b=
	cPkKpgJBihwyc8x+liHiOWTtdWWNlADja8z9zHPUhf9D7Cch07CiydAczsQti+cN
	NQeLiQM/L46rF1RcBtrtZyntt7cpStUIl14XAe+Dvu+jrgFSQDdvOp4jWjs8RvlN
	nZ4LvsCAOOVMr3G5WHzaPpGY5wwjOuco0Z7U3ATSgR0b7UF8QT46Th4inIzssVjq
	GQijfRLy0Iz8Ca565xqa86n4ONw85Vw2LSGoj64z6xQy21Vk52odZ0Kmhw4KnEBh
	ylxKZVTVAJBO4//U2/rFAlhZv0kw8j+DHqGYZsjPXHjIgV07IiNP/Sd496/sl/JI
	HlyP668qGbCfmOJmEbHxcQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uaw2g65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 16:41:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 526FdORk010929;
	Thu, 6 Mar 2025 16:41:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpdyf42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 16:41:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACV6WUHDSOij04E3r8cb7I0m3+174DU6brKqdJo5kvzaiIHCR7eR8Dv2rfG983GNbErttyEnWZBZ9AVovHSwA7uDmfSHFYgoBbY20jFTUotAD7N6m+0A8SUmHC0xQi4FcPltBNODmWyZfEr/9S1oMttBXugB2raG4qZU8GYaFZ0PdKwxUlbibWM4hOC6LqNtIIHQgDcHW9NKQndqMsFZ66hQmj1KByDbEXI0wTXKxQ3YMkU+f+ZoU8onvA7uIJ5zs6zysWuSukFXEDEReaaWTEQAny7f3PSi1n2opizygHM6XJI10LzIPhfrutvKlYM9zAzhSHLFIPF5Or6wt+ovoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h20xXAc4OAuZzzZbUKUDOhhsChYiKOnVNlWCeA6mItc=;
 b=jjxxNnuCk6wWL7prmcKAAcAfXWoTqV1wxL09aTsABkPWsWPctMO3ru/Oas7rw95z0XXwIvoXFfN3QG2mYtyiwzFu2YEq67jxU3YqwboEFs8NJhJeQ/4N3ToDaCMIt3pvQhheHKxWPPSQe14vJBaX/WjBsUKtgkiTsxuzV19YIV7Y63kDh1zudLfrw6rD0pWvzEZXJdz5SmbA2I+p28xXPPJ5VG2ahihg8+YgwlR5dR2nBLkyW7haOlLGpdiDoBGRX+EYFDZPCSiUmWKQTnNW1h1OAIhpBm/UZS/cvTQoV55QMgm81A8bme8iS+j0RkolgGY45VCtKbZ5HE2G16YCog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h20xXAc4OAuZzzZbUKUDOhhsChYiKOnVNlWCeA6mItc=;
 b=BeS7llYigH/LHZRDlxUcfCewf37n0lyopqD8YRt8udY13m4F9LAijKkRy3KacwvzFIgXC1X0j3CHJjdqkt7mETj+lk5QpxYdmG2UWRdTPXakDy1lR1O1ELXeRO/Vl+rf2jko32r++wB4INEq6Oru112c186ORldP5tdyqhVKTkI=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by PH7PR10MB5721.namprd10.prod.outlook.com (2603:10b6:510:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 16:41:35 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 16:41:35 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv work
Thread-Topic: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv
 work
Thread-Index: AQHbiM/MqlxGuKFhJ0mhR9ncavILwbNdbXkAgAZOyACAAAGMAIACndEA
Date: Thu, 6 Mar 2025 16:41:35 +0000
Message-ID: <ba0b69633769cd45fccf5715b9be9d869bc802ae.camel@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
	 <20250227042638.82553-2-allison.henderson@oracle.com>
	 <20250228161908.3d7c997c@kernel.org>
	 <b3f771fbc3cb987cd2bd476b845fdd1f901c7730.camel@oracle.com>
	 <20250304164412.24f4f23a@kernel.org>
In-Reply-To: <20250304164412.24f4f23a@kernel.org>
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
x-ms-office365-filtering-correlation-id: c4c06ee6-8876-4c2a-ace9-08dd5ccdc252
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHNZWGJsdnRFSW55dDFuaTFBb25jQ0hnLzJCcnpueWVKMlNBR0l6S2IySFhh?=
 =?utf-8?B?VE9VRjc2WStyNHhoajhXUnNNL0RmRkFyNk5wVmdiZnZmclRrejVGTkI2bEhZ?=
 =?utf-8?B?NTBucGFwZUFCeWVQOXcwcUg0NnNlamN2bTRxOTllTUswTERQS2tySFQ2ZEY0?=
 =?utf-8?B?b3pBZzVHRG1qNkhTTHVsaUMrYVpJSW5QTlZWdWowSUExZnZKUmE1NXVxYndJ?=
 =?utf-8?B?aXRHWTNxb095U1FPZWVUZ2FpU2poaVQ4dnFHZStxUnYrNTdxQ1VDOXlTa0Jr?=
 =?utf-8?B?QUgwdEMzc0w2MXFqN2lLNFcxZTFqT0tWajJEcGVDZGtHQmxQcU9BWGR4dHJV?=
 =?utf-8?B?TEY5eHNtcmcxUDZqVEVUNE5aVThvZGZ1aWNPM0YyRVFyYjhEVWRYbllieVdE?=
 =?utf-8?B?YTBDS2ZzUWpRN1RJWEpJN3JwdjBlcEQ2bFZlNlB4cU5pN0RxNklZVDlGcFJM?=
 =?utf-8?B?aUo3eVlIRW96TC9adU5tVk11VlJGQVNMcktnOTBORG9OMzZoSnY5RzBYcUpO?=
 =?utf-8?B?QUVUU2JwTW10QWQwOUpZQ1RMeXdScVZIRlZBRVVsODNQc2t5Z0tMWUJEMWE1?=
 =?utf-8?B?eXExSEpVUWZlK3cwd0hzelJhN2tFVzJmeEpxaXg5aUFMazVtUDBscDJiajkx?=
 =?utf-8?B?WXQ1RkFVRXpid2NzSGJBclJEdU5pdWZPTk50QVduL1RuaFpsZmVSOG00cklS?=
 =?utf-8?B?WGN2R0svYW9tSEtLejd0K2hBT1lIYldsS1UxY3N6ZktjSnR3ZXA1M0lrdUVT?=
 =?utf-8?B?QWFBYTNPdStGSytlbTBMbXpkWitLU1RQaUsyLzdWWnlxdnFwUUo3V09aWHJ6?=
 =?utf-8?B?ODM5b3ZsRDZBQ0VKMldLL0dnMkZDMHMxc21ZK3owMlF6SDFLci9rc1djWjk1?=
 =?utf-8?B?dDBYWnBBSVZWemcwSDF4dUNtSmU0S0F6bzBaWllGK1NEaVBZeWJGRmFpRWs3?=
 =?utf-8?B?aDByUnhLOUQrMnA4cGtXTHN4UW8vd2pGRmVXcnlJR3dibjl1SjhaN25SQ2R4?=
 =?utf-8?B?cURQNVB6M1pvM2pmTGFvQkd2V2RoeFpJamVTaHVRanZXRVIvZGQzTGlEWG9u?=
 =?utf-8?B?WHZLZHl6d0FqU3lPK2c5M1ZvMmFvZ250M0kweFBGU2YwSU9SOVFTbWZ1TkNz?=
 =?utf-8?B?cGFMNmZ5NStlZ01Jak05am54U0daMXpuUmFZdzNtMXZRL2F1UWgycHlkZ2k4?=
 =?utf-8?B?ZktJRzl4N1pxWHBvVDFLWmtHL1Z4OGZpN0JQSFJYSDQyemFMYUxkRlgyR3gv?=
 =?utf-8?B?NU5qMGc5QWRmZG9ZUU0yV1ViLytUR1F6bVVyOEdsdDhBUEpRb1BVdDUvM0l6?=
 =?utf-8?B?MHBFaDNjVjVjNWpwK1RsMnE5YUZ3cmQzN25Ua3hlUEJDb1hvaCtvNDVqSmg0?=
 =?utf-8?B?OTFsOFc1VmVNR3BibFRnQUU5TUllcUE4N3ZmY3MvMzE3Z08xYklCNUQvbWpF?=
 =?utf-8?B?dlV1TDcxeUZseGR6aHJIOWFGckRUSHNZZW45UnpqSUVmcG9wZDZJYWR4aWlq?=
 =?utf-8?B?aE4vSWhpZVlSamhwY3EvcW04WWF0UGRrN3hPUGk1Mi90b2FsTnF4L1F2d3Nh?=
 =?utf-8?B?VlJsNWVWNktJNlV4M3V0c081RlFhOXFVOERlVXl6b0V5b2ZNVUtrZ0g5d0hH?=
 =?utf-8?B?VC82bzFPcXIraExYMWk1dlN1MHlwZXlNRFNKYTlZeSs1ZExyWXpyWm4zeWpy?=
 =?utf-8?B?M0dzajlDVG8zOGhlemthTUdSSGJOamx0SSsvL0xDaWczQUJOQ05iTDN1cW5U?=
 =?utf-8?B?MzFMTit3VDhTNGFkZDlsNUt0RHJFMXpUdVFaRS9OSlNGd2hIMWVOTzd6eGU5?=
 =?utf-8?B?VUEzVUl4a2RSUjVKWGx3dlJqL0NsWmlZSXloaGVPUlkwTU5pcURHWkNwNzcw?=
 =?utf-8?B?Wk1iYWlYQTBvMk1UbWY3NkhBZzNXRUtoOGxUajAxbmowUWFMMWp6MWQySnp4?=
 =?utf-8?Q?2Thz0GagFsbSwEUUm7wt1cGx/H9RkV65?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c05DSm5mbVdrTjVBa2lvd2MzK2Q5YjZtemZPanhhcElUSWY1dU82VFBoRkF6?=
 =?utf-8?B?WFBETzNESDlwM3FjTXZPWkhuSU1neHI3K29NRWtoVDJhRnJIYWF1d1ppbWxC?=
 =?utf-8?B?SDA1YXJDSlRqZjI1RlRnWGQvM3pzbFNncGFYSFNkVUVjQ1FGOGpERVlPdEdQ?=
 =?utf-8?B?MGs1NHVDcXRIQ3BCT1JURjE5V2I5ZWZ5SXUvNTVwWFA4clQvNGs2U0dwanZV?=
 =?utf-8?B?aTNuZnZzblZGUGJXbEdBOU1DQkF3dFlZd2cwZGoxS28zcERRQXhzbjIrYzNC?=
 =?utf-8?B?bWFDNGFydW5sbENlbHUyUEVnQjVTa04wWVdnNS82VGJvbm45L3NUQ2doR3lF?=
 =?utf-8?B?YVQ5dEk5T253azE3UWE3Umxja3RTeVdGVm56WFk4YnlxSWt3T2xkbnlsczRM?=
 =?utf-8?B?Z29RL3JtUTRkZ3VrdXBLOVFKSmpibjM5OGI4b2M3dlJJaGxsUnZ5dDBuSW03?=
 =?utf-8?B?eExlc0xBV0tqZjdCYkorV0dhV3ZLeGNkbEw2YStHdHA1bDdpdmF5a3U1K3Qy?=
 =?utf-8?B?VGRYNVBaa3FYS3hRNlp4dkZBU3FjVGoxRjNiUlZnbEF6MUtzOG8wSk5ETFY1?=
 =?utf-8?B?OGl0OHBjSHVTQVBVY0tBSVVvektyeDc5UFpPL1ZqaStKY0IwaGVRK2Y2L3Jw?=
 =?utf-8?B?M3luK1pGdXVpVUc3cnNIajFhYTFUcjdsQWQxOStuSHJ2aE5IL0syWEFLUUxQ?=
 =?utf-8?B?cUZsVE5WVFFOekREaEc3dGVhOFJUL1VxcVRnc2g1RDhZOU1nQ3ZqcHFJbXZj?=
 =?utf-8?B?VEZjV21OaGdnQStadG1la0pZWDAzT0lGTTNJbUszcEN6VE8vK2lrU1ZPcVpL?=
 =?utf-8?B?cGtGVkV3N2hBRi9kWCtaUXg5M2RoZFp5bzJ6MHZmMmU2dnpNVmpBZk85bm0v?=
 =?utf-8?B?NmIrODNnd0k2UzhvcVRWV1N4RVhMby9KV0RwMjArdUZNS0psN0VWUmVPVnhE?=
 =?utf-8?B?VWQwZGE1Y1I4dlhRM0ZwT2VYNHNVQlNMUnVTdnExWDBNdXYzVWdVdU44N2pS?=
 =?utf-8?B?cHc2bUNSRjZLR1JGZkEzZnp4MXB5TjhIZ0M1WUZpcnlNSldQTjNRWHQzakFX?=
 =?utf-8?B?Rlg1NFZQRC9OOW1VcEQ4V1h2TVpGRFp6T2g4Ni9YOHNSbk11WjQ5OUU3NlYz?=
 =?utf-8?B?TzI4UXdlbWF5UWRreThyb1c3ZmhMdGorNzdpbUdpSW42K2hpL2hIZWxXZ2JK?=
 =?utf-8?B?eEtjdlpmNEl0NUdWcitPN2hGcXBReHpYbkhYNitsTzFOa09CNjQwckRPdExP?=
 =?utf-8?B?UjRMYVpTSDRQd0Q1OWl1WHVEczlEb2Yzell3a01aVGljWWxjUHNzcGNYOVRJ?=
 =?utf-8?B?bmYzWE9BVEdsVXJ2Nm9nUUljdmJqb20rRVpUZW8rTHEzSmhIL0xoYTd0cjN4?=
 =?utf-8?B?ZnVnY1JuLzdVb0NwTWY3Z2xFQnZjL3NTTzE3RFEyQ3hCTUwvRTRrTEFtZDIr?=
 =?utf-8?B?cHJYYmJCU01BYlVjZ3V3a0pGTGV6a21RUytwR0s2dUhlUGFiMFFXMzg1eWZG?=
 =?utf-8?B?R1hGS1B4UWZpRUd1ZWhjRXA4SysyVnBuY1ZiRXVLY1hpNU8xOGJOLzRBNFV6?=
 =?utf-8?B?UW1YaUx3YSt4Q21YUlYyNGE3WEkrWmlWbEVIRTQ5eFA5ZkZtdExYY3lvMlU0?=
 =?utf-8?B?TUZsdFVuMzQ2anJaelNJRU5pSzhyeXhvZ254akFiSHdFakF3bWhXRVBGRFNQ?=
 =?utf-8?B?aXp1Q01IS2RlYmFuaXNvVGpXbnRCcG5HQVE3UE1vNEgxVTBRd253aVA0Mnho?=
 =?utf-8?B?WUdJaTZVOGVkekUyYVNFdU51Zk84M3NPUG4xWW1BZTZPbDVzRHo5bEJuUXRW?=
 =?utf-8?B?ZmpwK21NVkJ1WW5DbWhibzhvNWZWSWo5OHhKY21adzFNYkJrSENXY0JnQVZr?=
 =?utf-8?B?UEppc3V4T1Y0WGxyUGFaSzdUZlJGaUFCZVRELzNqVGhvYjdoT2VWSU9JQ2ti?=
 =?utf-8?B?bVV5di8yTXZBNTVoSkV4a05oWWZVL29WcGYxdGlLcDJXTFNoS2JVVVNzdzMy?=
 =?utf-8?B?aXNVZU1TM2dZenZJSlVyblNBSGV0OFVlcDl2dDhLUlBQbGpYVlpGaFprbFhG?=
 =?utf-8?B?UGN6S2xDUEduSjdRK0UvOG9qR05TWFVIbXJteER1Ynl6bVRMSTY0Y2NRbnpj?=
 =?utf-8?B?NVltTGh1MFpJZE9ucUprUGFXbE5rVkY5YXFydVArbGJzYmp0YXRKVTVmZG41?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29353B88A633E8459C8092BD3D93ECEA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Dx/3VroQZGuehHIzcakXTSZipVFK/Iep44SZJN7hjeH3J4bjxv7Z+rWpS6h1GFxtCmq11ZVcn+kZV6UTg64gWZ1++2pWeeVwuK1nRx/dg+Ufv0uqMTPp8CKXiVPucr1U7luSPSehYq/izS748Iqo0pnS1YOfYJXsjJCm2hx61iSyIB7xFPjB2poxaQUrYMXjrFik0YHIC2+nHMfgj/TFQN0tNp0aHL5w+QsXkeMNPPpJz700UFBBYzhXA4buun1jW/ABurUR2nDkRW4137Cxm27lC9ywupDwhAICnkw/CnJjb+JsyrBJrCIi1f41KotRj7zjuzFocKQr5seIn9xYRdytio73Nz5PJoqTuezTiW3EBF3xaFFzekGIhmSVcSKSput1UE30r5BiYbgMxbhLOKn3lGIwwrC8F/wp4IJS14it17IqXruORbIAPTr+VlSHUyoFa9RWPd1rJcSYTUPodaCq2F1QxTvjWTgYZXXcar/F5O7O7qogWL/aYzr9mfmPLR96TsTgg5lOteMradEdB8MoAsGNl+Osem7bKHs/pSfOph115QNSl7SftM+Ss/IIub4JoS07rlBo3ADZhSVvuKoPQWkXfKil3iilf6icP60=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c06ee6-8876-4c2a-ace9-08dd5ccdc252
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 16:41:35.4128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7AMIOjv6iY8z2EF744+tYW72gb8fXI8mB4tnfk8smYkbJOrHrtW3FtffJRRljE9i6Y9o3bynhyAk61pMKmjlSGxgJSlu1WeMaDSeFzchWDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060127
X-Proofpoint-GUID: 1pEAPZB6gE8Mtcrkqpb0tlEyC0NHswDX
X-Proofpoint-ORIG-GUID: 1pEAPZB6gE8Mtcrkqpb0tlEyC0NHswDX

T24gVHVlLCAyMDI1LTAzLTA0IGF0IDE2OjQ0IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gV2VkLCA1IE1hciAyMDI1IDAwOjM4OjQxICswMDAwIEFsbGlzb24gSGVuZGVyc29uIHdy
b3RlOg0KPiA+ID4gSSdtIGd1ZXNzaW5nIHRoZSBjb21tZW50cyB3ZXJlIGFkZGVkIGJlY2F1c2Ug
Y2hlY2twYXRjaCBhc2tlZCBmb3IgdGhlbS4NCj4gPiA+IFRoZSBjb21tZW50cyBhcmUgc3VwcG9z
ZWQgdG8gaW5kaWNhdGUgd2hhdCB0aGlzIGJhcnJpZXIgcGFpcnMgd2l0aC4NCj4gPiA+IEkgZG9u
J3Qgc2VlIHRoZSBwdXJwb3NlIG9mIHRoZXNlIGJhcnJpZXJzLCBwbGVhc2UgZG9jdW1lbnQuLiAg
DQo+ID4gDQo+ID4gSGkgSmFrb2IsDQo+ID4gDQo+ID4gSSB0aGluayB0aGUgY29tbWVudHMgbWVh
bnQgdG8gcmVmZXIgdG8gdGhlIGltcGxpY2l0IG1lbW9yeSBiYXJyaWVyIGluDQo+ID4gInRlc3Rf
YW5kX3NldF9iaXQiLiAgSXQgbG9va3MgbGlrZSBpdCBoYXMgYXNzZW1ibHkgY29kZSB0byBzZXQg
dGhlDQo+ID4gYmFycmllciBpZiBDT05GSUdfU01QIGlzIHNldC4gIEhvdyBhYm91dCB3ZSBjaGFu
Z2UgdGhlIGNvbW1lbnRzIHRvOg0KPiA+ICJwYWlycyB3aXRoIGltcGxpY2l0IG1lbW9yeSBiYXJy
aWVyIGluIHRlc3RfYW5kX3NldF9iaXQoKSIgPyAgTGV0IG1lDQo+ID4ga25vdyB3aGF0IHlvdSB0
aGluay4NCj4gDQo+IE9rYXksIGJ1dCB3aGF0IGlzIHRoZSBwdXJwb3NlLiBUaGUgY29tbWl0IG1l
c3NhZ2UgZG9lcyBub3QgZXhwbGFpbiANCj4gYXQgYWxsIHdoeSB0aGVzZSBiYXJyaWVycyBhcmUg
bmVlZGVkLg0KDQpIaSBKYWt1YiwNCg0KSSB0aGluayBpdCdzIHRvIG1ha2Ugc3VyZSB0aGUgY2xl
YXJpbmcgb2YgdGhlIGJpdCBpcyB0aGUgbGFzdCBvcGVyYXRpb24gZG9uZSBmb3IgdGhlIGNhbGxp
bmcgZnVuY3Rpb24sIGluIHRoaXMgY2FzZQ0KcmRzX3F1ZXVlX3JlY29ubmVjdC4gIFRoZSBwdXJw
b3NlIG9mIHRoZSBiYXJyaWVyIGluIHRlc3RfYW5kX3NldCBpcyB0byBtYWtlIHN1cmUgdGhlIGJp
dCBpcyBjaGVja2VkIGJlZm9yZSBwcm9jZWVkaW5nIHRvDQphbnkgZnVydGhlciBvcGVyYXRpb25z
IChpbiBvdXIgY2FzZSBxdWV1aW5nIHJlY29ubmVjdCBpdGVtcykuICBTbyBpdCB3b3VsZCBtYWtl
IHNlbnNlIHRoYXQgdGhlIGNsZWFyaW5nIG9mIHRoZSBiaXQNCnNob3VsZCBoYXBwZW4gb25seSBh
ZnRlciB3ZSBhcmUgZG9uZSB3aXRoIGFsbCBzdWNoIG9wZXJhdGlvbnMuICBJIGZvdW5kIHNvbWUg
ZG9jdW1lbnRhdGlvbiBmb3Igc21wX21iX18qX2F0b21pYyBpbg0KRG9jdW1lbnRhdGlvbi9tZW1v
cnktYmFycmllcnMudHh0IHRoYXQgbWVudGlvbnMgdGhlc2UgZnVuY3Rpb25zIGFyZSB1c2VkIGZv
ciBhdG9taWMgUk1XIGJpdG9wIGZ1bmN0aW9ucyBsaWtlIGNsZWFyX2JpdA0KYW5kIHNldF9iaXQs
IHNpbmNlIHRoZXkgZG8gbm90IGltcGx5IGEgbWVtb3J5IGJhcnJpZXIgdGhlbXNlbHZlcy4gIFBl
cmhhcHMgdGhlIG9yaWdpbmFsIGNvbW1lbnQgbWVhbnQgdG8gcmVmZXJlbmNlIHRoYXQNCnRvby4N
Cg0KSSBob3BlIHRoYXQgaGVscHM/ICBJZiBzbywgbWF5YmUgd2UgY2FuIGV4cGFuZCB0aGUgY29t
bWVudCBmdXJ0aGVyIHRvIHNvbWV0aGluZyBsaWtlOg0KLyoNCiAqIHBhaXJzIHdpdGggaW1wbGlj
aXQgbWVtb3J5IGJhcnJpZXIgaW4gY2FsbHMgdG8gdGVzdF9hbmRfc2V0X2JpdCB3aXRoIFJEU19S
RUNPTk5FQ1RfUEVORElORw0KICogVXNlZCB0byBlbnN1cmUgdGhlIGJpdCBpcyBvbiBvbmx5IHdo
aWxlIHJlY29ubmVjdCBvcGVyYXRpb25zIGFyZSBpbiBwcm9ncmVzcw0KICovDQogDQogTGV0IG1l
IGtub3cgd2hhdCB5b3UgdGhpbmssIG9yIHRoYXQncyB0b28gbXVjaCBvciB0b28gbGl0dGxlIGRl
dGFpbC4NCiANCiBUaGFua3MhDQogQWxsaXNvbg0KIA0K

