Return-Path: <netdev+bounces-248013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6341DD02146
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 11:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 618DA318A2F7
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 09:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950C73FB553;
	Thu,  8 Jan 2026 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QF7QqUWO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HjH5L/8P"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D523EDD71;
	Thu,  8 Jan 2026 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863385; cv=fail; b=NXJk2ZRD6mI1x7feYGa6GbucTpkLF/qqL6e6zxMtnrBIydih/GlJRYA1iUIsl5aI9W95H0IvIg1+3j/UH2OxJX1XhrmW2vTFReojJyBN6mSnr8FZgKM4bSlvS0+CJmS8VT12+PSe//gIu0dJkCM4Rg3yBbGNIwy37DimV/zMGtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863385; c=relaxed/simple;
	bh=c8ac9sPSsYaQ3Q52ryvLKBh5UUiabzWTXXVJNEU1e+U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fY7Mcetw/2RAbYLKWDDk46z+DN5aToqv/UkcjnawJfBN4Ij1pl9+E34R+WLSozPjkoIKSWyKN/makuJZvCNRR7paGyzkbGclLO/tUkX1CuA6lEAeaKdY73Uw+bqe5wvIIX0XP9tbA3jXlVzCOWzHevUpf4gA3OvChof7ZRVb7g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QF7QqUWO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HjH5L/8P; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60871mbJ3780729;
	Thu, 8 Jan 2026 09:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=33CpTtCyOnevwZPVFukSnPN36PERadK2a3P1NZA6OWo=; b=
	QF7QqUWOHcVTuAgMojBWmrFtYKUs+fFsGkpPW4TsU8qk1Msq3dGoiKulgAkJwNpq
	A6vlCfTO7uSme6DHh5+/6BdreBqoSWN3+yMmHjKAhLOSx33jqyBlyRHYjys+PjmD
	EwIMoK20rneRsTxFPqWCs3zsuu9MwCa46BOZ/O2BwjD/deUEhvJQm+myrGtSE/Bx
	v1/q5s4LijCpbV2m044eCjRYw0cvZvxymG7dQaB+JEw+uMwtcjLYThVbc6ZoAlTu
	RlBs+PCRNdews1GOyMppI4zOa6MY+nY+d19tY4chpMONI3R+rSXys4chVaEQ5h04
	lAX6FnLVFc3u8SuzQathTg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bj7tr03qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 09:09:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60891Ajp026417;
	Thu, 8 Jan 2026 09:09:20 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjn4j4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 09:09:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHsVpGspG+6WnoCjjo4WGeRJ2zFE7EkC2oHoxWAYOkYHRz2NhRgFKEipCA7Mv3rXmuorUzb3SM3+hDtINo4dt+6R2lUA0p2hH8ma9ExYRNFbCBcLX0G+MPQn5bSp889V0cpKrJAa0aizfPTEnHXc/Fh2nDD/JbWu7bY1F4ebJdijlPeFIpZodYo1Fp0t8A6D0aPBq0SHNPw1NdDC8wGYLyAd+UkQ/5VnAWM/dXnzjm7VCdTQnE/6pABAVpj7ZiyewxPQqZKhZl7NM1uzP5cIqdE/406+VcqV8nM92IKdOzAjpkKbr4O3NsXR3lVg1/rxXvSZdzrU3kkZh7iqfG0MKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33CpTtCyOnevwZPVFukSnPN36PERadK2a3P1NZA6OWo=;
 b=f5jXD5IbKVqv88zwPtFwCdcbDB380OROVF74J/nLdA+mCobfjWVJTeYNydtSbEeHWZQakxP1zhPi80d/aSUeEx3TPS2K4HBSXUGPnzenOZSVXaeBx7zkaYFsvk8IVqVQMEph99+X4FmM+hCxlaLr/HWRrGymm91KqSIZ1Y+OrzfVm0Y8RTKDhcaywQUqofk8S0y6d3qbEUQLM/8mQpmdkf9AmdnfmWQ7Bng+WLDc34h4tXxW0gIeQmvOwtyi07I7363czkjUKQ+rvwJQI33tUtBZMEbcQxPciK22btTo5kpqXxQ0TFvgzoHEu8c0hYCcFzOemHCfhap6Ay3Izvl4gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33CpTtCyOnevwZPVFukSnPN36PERadK2a3P1NZA6OWo=;
 b=HjH5L/8P4jglZYpRnvg0oMMhnYuP+1yLCAJE+YrNNcA8pi+1GuTN/L+twnvdLlUfCvBtyT/8+CuoJhryRkGKieLOG05s44LVFXobR6njGRxeGudi0UTnSPaU4FCT+vbLQ7xnWWsoNKwf+M6eO6gp3yxM8LFjLwt9JZjAhm4cBUw=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by BY5PR10MB4291.namprd10.prod.outlook.com (2603:10b6:a03:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:09:17 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:09:17 +0000
Message-ID: <f8d9d910-e2bf-42cf-b15a-b6624c0bda56@oracle.com>
Date: Thu, 8 Jan 2026 14:39:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 09/10] octeontx2: switch: Flow offload support
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch
Cc: sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
References: <20260107132408.3904352-1-rkannoth@marvell.com>
 <20260107132408.3904352-10-rkannoth@marvell.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20260107132408.3904352-10-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0476.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::13) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|BY5PR10MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd70268-835e-4045-78d9-08de4e9599dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWJBd3dCb3J5YVlHdTJ2UWovYU1uZHF3WENCbDN5SXZ6MjVma3REZ1pNb0VI?=
 =?utf-8?B?QU9SeXFtNGxXbjVNeFRLZDZlRGZBU0MrWlpRUFEyYWxZcWZGU3hxbkI2aUZ4?=
 =?utf-8?B?L0tURWtlQU9QQmE4alQ3NlJJYUZiV1FLYkoyR0pjVEdUMGUwY09Sejl4MVNi?=
 =?utf-8?B?U3BXREg5NUUzbW1Nb1g1MktRZmFXelQxbVJabFloYjlVY08vK2tZcW93aUUw?=
 =?utf-8?B?RVRqQzVieGR1akhEWi9wN0VuM1ZvbWl0SVBBMmxraWpUMzdSRzE3OStoVG9o?=
 =?utf-8?B?R1p4OFM2ODFqSE9tajcwVTVmdk9VYVFNSW9abFpGR3NBQnJZamUxT1FyVlNw?=
 =?utf-8?B?QUM4NGxwVFBDR3QyWGVQbm5yWnpkd1lyMVpibnpwUWZTN2lQL0NiWXNUSldK?=
 =?utf-8?B?SXZrcVZJT1dTT216d0RQYmFOVzMyTCtWYVNYYzBpN0lMOXNoanQ2a29UM1VB?=
 =?utf-8?B?YUNaSm1GRHFYb3ZNWndBTFMxb3huSEM2UjBpaW5ZTVVhK0FaWGgybzZTL1k4?=
 =?utf-8?B?NUU3ZFp5TmZHUUlSdDgzS2ltQkx5TUFycGJHS083QXNYMjZyV2hNM3crckZm?=
 =?utf-8?B?czRrRnVqa09RMytYc3ZFNTV0alhsaFBXbHZHNWVPNXpsVkMrbXlNcUxoNE5l?=
 =?utf-8?B?ZXYrR1k5dGJqa0kxZk1EQTJMK2VYNFBaWENhWThVaStUTHVPdVA1bkM5T29W?=
 =?utf-8?B?dHo3VWppaUpjc2xNSlM2R1lwZU4zMDBMSUxmNit5R1Fra25aMXRxcDZEWGFC?=
 =?utf-8?B?TUt5dEFtVVNCbG91YW1YcFZHMDZMK3g3U1pqSFF4YWs2KzQzb2tadWJBWStR?=
 =?utf-8?B?MUZqM1JnKzh6Y25PNUppUi9BK1FUWnY1ZWpUR1RHZnR2MWNsQTlCcnkwWkt1?=
 =?utf-8?B?b2ptbDJhREE2ZlEwMi91R09HaE9pcno4aWd5YUVOS0lRT1oyUjNVMndzb3lI?=
 =?utf-8?B?ZTVXY25LVXZuTGhUU2UrQW5jbE9lYlBXUkpiN0cwa29xWnp5RFlzamhRcUFF?=
 =?utf-8?B?SjR3YUZCRkZoUWhCdVkwOWF1Z1A3bFJqYkhPNmQ1Tlc2Y0JUT3V4M2JLMXha?=
 =?utf-8?B?SlFUQmhOcFMwUFkyREQ3cnFCdERReTkzSTZMRzY4UTcxM2RWVDhncnVvTjR5?=
 =?utf-8?B?NEE1eXRoUGJSNXZVWTJweUlXYmtUdVJsbXN3a2lOd25DSGdoYmtzRWhjRUhi?=
 =?utf-8?B?aGh0ME1kbXhJVzNMVENEcEtSeDJveVFSY1Q2Y2pFTXZMY1dDcXFDMUIzdFZV?=
 =?utf-8?B?MXpJc003RHRBZExOU3dQczdMQ3E0OHFrR3Q3Mk1uRlFLNWRWc09FUUZ4Y0hS?=
 =?utf-8?B?QlIvZUx5MXVhOEJUOUNTRFlHZldiRTdZNklMNkgzZjRVdEZpZGlmU2R1N3lL?=
 =?utf-8?B?ZWdVSW1qMlBkMDFLVlVDdGxRVW9zQkhwYXR1S2RHR3dWZG1CWG02OFZmREtv?=
 =?utf-8?B?bFZzeEwreXFhR1lUc3hnS2Vac1ZhbGIxNUo4NmZTb2dUdGZiR3krc1VFZ1ZP?=
 =?utf-8?B?bWhRVVFlUC9pb1plRXA3UEp0T09aSWEvcnhsaVpoZUlNQjUwVnJYWjYzMXJT?=
 =?utf-8?B?TWVEZzRrS1d1WFd6bXVDejVnS0MzNHZQbVFZeHNKS1F2dWVNMUU5WUhRNm44?=
 =?utf-8?B?eVJORVFaZ3RIYjVJdEtMQVAyUjVhSm1LL2JteElLWk1MWWZwclpDODVSNkpZ?=
 =?utf-8?B?UnlnY2ZBbEM3OWlMTkU3S3NlZVNyVkZGTGkvblVlVmxDaVFYekc5ZGJSUmh1?=
 =?utf-8?B?RWNHN1pUMHVmZzRQNnBDUk9tQlZ0ZEpNUWIxcmlEOXl6c3hqVjdQcTdmem1a?=
 =?utf-8?B?cW5ZS3JpS2VUVGVDTGZWTlBaM1FzUTlWR0t5bXJhWWFyM2dxRGR6b3RBaWtB?=
 =?utf-8?B?UGRNRzZsVE5aN1Z0dTJ5NDJqckZHSXhzcjB3bGsrazVnajNiZjlyRCt5eGs1?=
 =?utf-8?Q?+HNeODyjhDfevSxtzDuK6Vr+KLPeBwWX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkRFMVlIbVR1QVRRcHhKVFIzVE4vdzkxbTZ3SEpLZEFWMER6VHN6WElyZ3ox?=
 =?utf-8?B?NHQzNXdGWDZBRVVlT2ZZNUVsSkNuUzhqbG55RnNMejFlZFpEWEJkVGUyMWFt?=
 =?utf-8?B?ZC94Skx1VEJNTmd5YWVLZmVyNVRXVjU3Zm92WWErNUIzRUZZc1pBLzdWRjhD?=
 =?utf-8?B?UVVRQ2g3OHdQTjlrT3MrdEl1NnYwV2V6SlZuY3BWeVpENXFyekI4QWN4TDdy?=
 =?utf-8?B?d3B2dmhNMWdaV085d3NocWxxOFFYd0NxSjZrclBFVk8xN0V5OVNjU2xiYUFN?=
 =?utf-8?B?WEQvSXNvWW14Njh0RHRuVEdTSTNzbGxEbUl3MWJNNTZFNXZvQ3lnWlB3RXZ2?=
 =?utf-8?B?dUpFU3J6RWdlRzF6RmFZVUc1VGlFTjI4YTJ6NW1TaG9QamhzTkh0d01wRVBB?=
 =?utf-8?B?cUw2U1c2OW52MjFjNWRlSWUvOUtTOTA5ZU1NWmM5a2dkeE5LRUt3amViYklY?=
 =?utf-8?B?NDZRYVkwYXJTMGJ6WGM2TzB5UG9XU25zblBpVTZERldvZ3A0Z1VNOWMwVmdE?=
 =?utf-8?B?RWQyYnBPb3lwUGh0T1RyODVhVUhyUmtXTVJHSG1LK2pLWTJqSHRMQTRST25n?=
 =?utf-8?B?U1lrTy9kOHR4RmhQaGR0Uk85VkU4YVNNOVRVSFcycmE2WmtRTURiZzF0NUZm?=
 =?utf-8?B?VHZRRUt5UlRvYk8wZ21wdm9xWjFoMWxFWjd3Ym5uS09GSXNEcGNIdTlOeU5I?=
 =?utf-8?B?V0J0RHdXQklxbVJxUGwxSW8xSTJnWWRRTlBMemM5YldscUVHdVlYcEZaYi9i?=
 =?utf-8?B?TW12UklJWCs2OElnQzAzelo5bXdZcUNCemdHUU1vZ0lITzlDdThGbktJdnNu?=
 =?utf-8?B?cEZNQ0FIT3FLWmh2TTEzejdsKzJzMFkxSlphNVVsTy8vd2pVVDVRRWFKd1po?=
 =?utf-8?B?dXF0Um9LdEViRGxtbG5oamNnYU0reWZnbU5ZMEphN2IxZzBobXZQMDNxR2Vj?=
 =?utf-8?B?NlhLa1J0UFBzeiszWm03Y1dXY08wV1F1SEZyTkxVZW5veFYzVkFzZG0rSmtP?=
 =?utf-8?B?ZThSTU1yay9kcVFBMmpMYlJYb1B5UVg4bEpXRGNkbFFodk00WjNnTnJxV2Qz?=
 =?utf-8?B?V29hLzFCZW8yN0MrekJVUURVTDBkL1hIR2xGRUxkbnljM0dBN2FsYWhTN29N?=
 =?utf-8?B?V20rYnBqSEdKTnNXMy9aNzFhVWUxTWdqRTgvYmp2OCtEMmtlNVM4Mzh4c1JE?=
 =?utf-8?B?dm1ESXJ3WnhJMmVHL2RPNS8wc3NGai85RFVVSnRkUTVUT2NFeEdsYXVmam5D?=
 =?utf-8?B?bFVpRzErVTE5ZTZyRTNXTHp1by9BbWNPd3BITXNMUG9uSDR3Q1M2NWh6cXRp?=
 =?utf-8?B?azVESXpJNkhEZk95dTNSRXNjMGthbmQ4WS9TK2orRUdoaGF2MHUwa21NSTJL?=
 =?utf-8?B?aTlXRzVXdXY4WHkyWTVvNzR1b1JubXRUSkV6TU5xL0JrcHM5NG5WVE5aaU8r?=
 =?utf-8?B?WU51V3lWUzA2UjNrSnVJNXFkbEpQTm9UVHVOZEtTNVlMWXBUZDg0UFFZbDJx?=
 =?utf-8?B?VzRxTElFeHlRcmZPK0hCeTIydEhYcmJkSEZGdG9tMlZOa013WTVMc1ZOOTBi?=
 =?utf-8?B?RkdvZ1VHeXlFU0p1RVlBbEN3NW5VWW1VOVY3bHY4aDdTNkR0cGh0Z0xxSnpP?=
 =?utf-8?B?Q25HekIwMzBSeGJscjBDbXduUk1lTEo1TEdYbS94RmZmazR6T0JEQ1lLQkxR?=
 =?utf-8?B?bHV4OG5rVW11WXkzZTZheVFOTWRXMmltRFFQU29XNE85RGQ0aVVBUVZacEJY?=
 =?utf-8?B?MnNtZHpzSkZRejdNcEhhdVZ0NmlPd1ZodXJVWGtMQXIrUTVta1I4L2RMbFhw?=
 =?utf-8?B?dFJzV2FwUUpXSFY5bjdEUDJhd3dCeWY2N2kwdkdIVVlZZ0dxSDcvUmlZQW9C?=
 =?utf-8?B?dm1FOTZ2amZpa1RjOWEzQXhxbTY3VkRVU0tqdzJ5VVplbm9qZk9zZ3NTekly?=
 =?utf-8?B?S0ZVSEZLOUwvNlkxSktrOEdncFJFYXZ5VTJYTitIdXAyVmdHK0k1WjlSeTZK?=
 =?utf-8?B?ZVpDemVjSVpHa1Q3QkVEM0RHZEZjK3hmbVo1TkNCQytxQzVWYW1kTE5yMFBH?=
 =?utf-8?B?WGlMcUcxT2xWVHl0TFZwZCtMaGoxekJ1Tk5jYmhUZHorczF5ZXFZTFhsaGov?=
 =?utf-8?B?cjVuNHp3VXNGT2pURUtiR1NkMlhvSFNvK2VGUk11UnN2Y0RQNFUwMlNteUpE?=
 =?utf-8?B?NXFLSHplOTllNUxQMWVDSDJ4bG52VVU2RUovS2RJY0J1LzRVTHcxZVJGZjMw?=
 =?utf-8?B?Sm1hRlg5T2xKUmk3K1B0bnpORGhTSS9XVVk1T3hvZTc2ZSsxaGU4ZEFISFhR?=
 =?utf-8?B?aWVpQVFrekRkNWJPR0F4QjhBdWZxTmdqdFA3REZsYStEZGdWNmwzeTB5dlZO?=
 =?utf-8?Q?8ua9plg0myMGw/Wg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S7r2hJxGrV8vjiqPXoCsi6/ai/K36vGmUQlwk0kWFGRGZGSIPQFItVZfOWlmmSeYc+I+86qZQoq1rh/OyH8iGDJvZDEqYJZIvR02b7fQiZhUSymaee1nu+4GJZ9oA1GcAn5V1hpMfsqEWpRXyb/eB9C/MAutT8kEhp9ghd0o1rWoPCV3n9AytR/EK/r+pmX8eAhBNMOjSQu2rgMrqL1zZi1N7LHS1dLTEZr0dMp3jBkA0B0tg8QkS4SVS0mO/Ery1IPs5FtMwbp72DVy+xFC3xFLZ7d8WF3CdzFcFzk6VaCU3sKSIBC9RZMf6UnrHNx85AJK1HNKUz4PrYCJN35K2dSLFMiRBPmJiJmRyIQtrJa9KSWz63GCMhze8favOORcC0PCk2BgVWnOAQNDMjNDTK3PnrdtQ0eStJMN5QEZbeuElQ9D0vQXLEEwre6m0rZprxj0GhlmfxtvHzxmMcNcsrWdxwIzyClkzZUgHGA0ktZ5FnmNDtJD2JAzUmc72B6cIwoXPMfEkzG/KxRUPINltG/vWX4LCyuOdyIY41s0W9MLRfJ6OkoJsZhpDKFFaKtp0VF8Sh4qYhQgnsFj3jN9Z8ygELnvFZwZUPid2ggMj5g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd70268-835e-4045-78d9-08de4e9599dc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:09:17.4030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5twAf/P0l4vU1chljht0wDMZqgBJgGRC//5dYlGqUof8VEzn6KEIjwEmCurbQ421L+yo/DmNDk+j7KMip5FRow0puEcXkRp+XeQIHnr/1Zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601080061
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2MSBTYWx0ZWRfX7sTlfdiU3cb2
 Nfz3Ocd1f0eX/cRGAHia0/v/Gxw5h6qHpnAH+J+nFuHORLQMT4mBx+9wmzdcwR0ny8AuURnRa6K
 v1RT81Euj79p5l6ivWtMC62qISDXWZIqPhQGimv14Wy+XqWhrxkj6EmbfNdox6UvSBOHenz4PMt
 RclB/BxnJCC3j11tc27cs8g76zIJuTZgNqCPseVip0LEfuuq8N1TzMxt/h48lM153rQUwinvWUt
 KpHG1xcmn43bvPSswtyisUx+KuY/OrtpqjoLPFQbjS+zzSiOxqAdEawjbWAkST6DwMVS1/7psQx
 MqBrQU0UhQH7AUUpfYIK/ANYwA6qa16CF/5rE9zgMDc/ht0PXugGt+lMChZ6kPjpIz2GQ6/AtBQ
 8rw9P6+5idiuVRK2alVji3Gp9qcDNyLeTrtM6nKkUko07KysPzEvIVY3saE3Rd+DoDXtm6me4Ob
 tjJstHpNCFxD5PpGHMFxnqwjjlEnSnzvml4Rbq9c=
X-Proofpoint-GUID: eI1LjkAUfdc3IPkRjf87SAhgrBmigLE5
X-Authority-Analysis: v=2.4 cv=LN1rgZW9 c=1 sm=1 tr=0 ts=695f7441 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=dNOg_KuK-vnI_EEGt8cA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12110
X-Proofpoint-ORIG-GUID: eI1LjkAUfdc3IPkRjf87SAhgrBmigLE5



On 1/7/2026 6:54 PM, Ratheesh Kannoth wrote:
> +	err = sw_fl_get_route(&res, dst);
> +	if (err) {
> +		pr_err("%s:%d Failed to find route to dst %pI4\n",
> +		       __func__, __LINE__, &dst);
> +		goto done;
> +	}
> +
> +	if (res.fi->fib_type != RTN_UNICAST) {
> +		pr_err("%s:%d Not unicast  route to dst %pi4\n",

%pi4 -> %pI4

> +		       __func__, __LINE__, &dst);
> +		err = -EFAULT;
> +		goto done;
> +	}
> +
> +	fib_nhc = fib_info_nhc(res.fi, 0);
> +	if (!fib_nhc) {
> +		err = -EINVAL;
> +		pr_err("%s:%d Could not get fib_nhc for %pI4\n",
> +		       __func__, __LINE__, &dst);
> +		goto done;
> +	}


Thanks,
Alok

