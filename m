Return-Path: <netdev+bounces-250581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D281D33AD0
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 18:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 032C13028D83
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 17:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F2733B6E1;
	Fri, 16 Jan 2026 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GrdwhO5q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VsKtMBdg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B731EB9F2;
	Fri, 16 Jan 2026 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583197; cv=fail; b=c3Tx1zOp1M0EtGBVVeDgRb/ttBmmWKlkhidHgX5OKzhKm/HfHRbGZVexUwxIt3XMXUdZHHR6+mwg4SozWH1wRX49XB7KTWrJ34dDyhG5KepWoTVDcrd/ERCXaw1M0gETMQ+nNon+B81nKDoi49bZFRMptF98x8/6AfPfhXbuvgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583197; c=relaxed/simple;
	bh=zdZe2Zqt/hH4QELIa0UUOFQ9q6wR7wwiY20CLipCV7w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CaKnPOCxP0+ksULvslGKZ6c89KYtiT0INRbp6xWH46lV8QHbDGopuRewVOAJM1L0532rSwDVUDiD6Si6Fob9zPjirUk8084jDP4iAsf7wBK81Fn7PsIiMaMt0uMpnwMpM3rwRlojzaE3dD0Ab+xyeK1pPCQziw3afHIhcAU9jJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GrdwhO5q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VsKtMBdg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GDvwS91737983;
	Fri, 16 Jan 2026 17:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Vje4b3n6MEbEyg764b2KoBOBlJcPsjtBkadYlXG0mks=; b=
	GrdwhO5qCQMF8uoUrulvUZctOQlVrd+bPwyadrPa0v8hRRXqtDqRu0+0qTMqVmAg
	RTBDmTCWTpvfdCXMHhD59XIqyMUTN9UJsuAg1beH87SuKRCUSrKjd6HiWTObNXh7
	CU/aROOF8MuFzPn9CPfhPxOgwt+ITLD17Sk9Westo02258+lrasVJVHOfwYJyX1I
	LbqMzFrLgJK9K9U5xFKoY1s0Xif6sevWoHnxj3aooZZoE5fTUvelc7fo1gK7yUYK
	B1ZWsc/7qV/ef9zEgZ+JZZHqEXcc+f1ItQ1r1ibbTDQhrZxnttFhFJNsEPL5tcYT
	758k3B4QpOvYCF4oKMy2BA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkntba8nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 17:06:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60GH1H0n029121;
	Fri, 16 Jan 2026 17:06:25 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012023.outbound.protection.outlook.com [40.107.200.23])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7pwspw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 17:06:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRkIESMlq7tHaSIfktlLocRKOfkBsKB/wmhAI9sq9BPrdFJx4M+LmPaVXgK5JZCbBcy/GKVWiDOtC5n1lIUQEvQ7s9YvrwwfKzjxnP5xi87jyVNeO7f5L3+LRP91/lobF+S/h4juM/Iv33LfakABsiJB6FrDmjzAWRuQRlKhhL4kCvFCQPpmDdLHoqnFBO3ssjjdrtDoUMCZJOaN8mqt1LjpnOaoaT/i3N7iUubqDkr3I7hOgMiqAhp8yLTwosNpKNWPTetCHASYMOmB82SMQndBFwLPL8QXpkubnKo7GJuXC6cPXwlWg7lbabBEl2OyWnlDVPG5vFzfd1DS7gyurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vje4b3n6MEbEyg764b2KoBOBlJcPsjtBkadYlXG0mks=;
 b=x6C/6HSoxca56DcPExOP2vPQyp/UrY2bz/YxCLLylqmnuIBFVvJCmB7mwwXDkV8s8lHXk9MWPtWsOaQxVBn8Gul+dEbKWPEapS3km+CZH+SjC/LrfrDWVH7yJabZo0jAe9C0UGLFmUWdGUDYuslUb6hE/SS94m+/0XdfZdguyAx7vOuAacc/5/qI8Q+B48VTMPxuBLsRwGWJjKmcC+WjO8zV4Yj+RpDDpnE5L9x4rkMaW5KyvJU+LGJxp5RhcmAleF2LKQ/S+rhzCLIJyX1B2tdpT13H+aUp1oq9PQiYwF49lYW3LoSZlxajUKG3MnpZztbaW/jKMzWov4VXbmNSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vje4b3n6MEbEyg764b2KoBOBlJcPsjtBkadYlXG0mks=;
 b=VsKtMBdgCbPWt6YCvLT1cmhg1VksVtHPwNdDqp8kALtqwdJmS167xuUsOM5jzw6VIrDkm+YmUfxXSStZAO3/rR63oW+r1T1F5nS6h4+3BumGjCgdTGoRFEb7c5N0AROsktWtbm+ZeMxp9JzFZDOT8jeJ1ROTAk2CscwH0k0oeg0=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM3PPFBBE6F5DB9.namprd10.prod.outlook.com (2603:10b6:f:fc00::c45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.8; Fri, 16 Jan
 2026 17:06:19 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 17:06:19 +0000
Message-ID: <fdbab5d5-63e1-49ef-a5a0-95903a469fd9@oracle.com>
Date: Fri, 16 Jan 2026 22:36:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v4, net-next 2/7] bng_en: Add RX support
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
        vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
        Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
 <20260105072143.19447-3-bhargava.marreddy@broadcom.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20260105072143.19447-3-bhargava.marreddy@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0228.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::9) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM3PPFBBE6F5DB9:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af0384f-6780-4a9a-a72e-08de55219121
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TEg4cDF3WXcxWFA0dUxsYUlqbUJpeWIwQ253YlllQTQyY0h1ckhvTkxFcHlh?=
 =?utf-8?B?cnhZRnRmaDR4WjlxQk5tcWF0dXh3Z05zMmN2MzRBdEFkZ3ZLQ1BreVVmRWY4?=
 =?utf-8?B?NTBiLzhXZnRLMzVUMjZjQ29XZnlFSVN2aHVRSnAyTXd6ZllKN0NjRkNhNWhp?=
 =?utf-8?B?TzNmV3cxRDhiTUdPSHhkRlpaeUo2UUpKT25sWGl3dm55ZjN1bEIzWHAvbkFP?=
 =?utf-8?B?WjRXMmdZd04rMHZGbjIxUHBGYVRMQ0tRcC9vUG44THdDSzNkOU1OOFdaMnE4?=
 =?utf-8?B?dDBzRFg4bmVyRkErWGpPcjYzVjZsOGFldW1oak1HL21iWkFaenNkMWZKYWxX?=
 =?utf-8?B?YXZGSjZzK0dEZjZuSStheWIrbWQvSDEveWxMdmNtek9qT2NRS2VQVDByamlB?=
 =?utf-8?B?MGpBbGhjdmppQUdxcmxoZWpaOFgxbUFtU3h2K215enlac2tTVjdnelJKWUtm?=
 =?utf-8?B?dkFLNUVLdnBPcm9xL1k5VXNtbDJ0MEU5SmJvK2pKVk1YRVlON09sUHFkRjJT?=
 =?utf-8?B?SmlXY2twNmdBNHVYMm5tM1k1dDUwcUlkL1hNVlJSbUVUNnZSNXNjcFlmUUR5?=
 =?utf-8?B?K3BmakczMDhXZ0k0b1lGbWRXTFRvTU1pang1Smxlbm5FZlp6MWZXQ0hVZW8r?=
 =?utf-8?B?NDZNVHJJT3VhaHNhTjJUbUdxVDc3NExaNnZIOU9xRWZ5YTF1dDM2MHZ5ZFBJ?=
 =?utf-8?B?WmFzN1VRQzA5UEdocGpscnhMK2FYdmc0WkFVS0tJR1JENWdya2Rnd0ptSWs0?=
 =?utf-8?B?YnFxd0ZUZEUwdDdmUDBRS3plTmFHNFpKVlhxL3NVU2pSYU5rYUM5YjZEYzh4?=
 =?utf-8?B?em9tdFNJRUh6NkJiU1RKS2RRU1lGbzBVN2VkRnA2ejNDVVA4T1pLTGlGekdy?=
 =?utf-8?B?UU5UVXpOSmZDR0pvbGcybGpHdm9JOVhZNXZZajZVYSsyQ2RUbEIxU3BVYWVS?=
 =?utf-8?B?K3hCZkN4Sm5xOGlXWFY5bk9sQjhWYXJWTjlRSWtXL0Y3SGI4cWg0cnJhSUZU?=
 =?utf-8?B?RG9zQXBUZzZ5bFdXTXNGa2tmemhFTXdoWjRmSXpuZFFsMng0KzgxN0xtN0V1?=
 =?utf-8?B?TW5SbEdiUkg4RDVTZUk2aWs5TTdQbUtBdld5VUNKdzh0Qm5mWkRYRkVzemtp?=
 =?utf-8?B?R3ZRRnlBR0swOHdVUWxwTzZtR0tNU1R5U2pzV20xeXlDUTBaS1lqdWxZcjJ2?=
 =?utf-8?B?S01Nb1BVdXEyMUJhZkw3WmNCem5jV2xXTWp6VWIxd2N2TzFVOHAxUW9EVU9D?=
 =?utf-8?B?dG9FTVd4Tk9BaXVXWGtXaWpKU2FXMDF2bVFwelU1SGlzaHA1NjRvZU9sRm13?=
 =?utf-8?B?VTJIbVhYN1ZHVkxBYldOZVh1YkJNZ1JxTllGUFJTT29sQmRmMEx4dFVNTnVh?=
 =?utf-8?B?V3A3U0NZK2dyTUU4QVU3Z05NWDdDaDdlV3dRc1pqUFM3SUtlck5YNlUrOUNC?=
 =?utf-8?B?VGFBTEdVSHRHaFI5OU1TbE8vemx2MWNPamwxSUt2dnVub0NWNjJVcXMvclh0?=
 =?utf-8?B?Zmh6NzhJak1wQTE3cUFCanlHVEpPVS9mZEN3SkNUREc2c1V4ZHN6U01kek5P?=
 =?utf-8?B?cVhPT3dkWndWbDMvcE5zNFdnellKTGY2QTRFVzM2TnhhTVRDblkyNW5WODkx?=
 =?utf-8?B?QnVQYnpZbC9nU0dOcW9PemhyVnFUTHVzNXVpaGhpRkVzcS9vay9RdXdvakQr?=
 =?utf-8?B?ckRvM2NxNGdGd3RtOXYweU5tWDh6U01sRVEzUW1XY2wxdGlkQWNENHFGbzhv?=
 =?utf-8?B?NjBrb2dwOUxSV01tcTVVdTk3Y2E1WGJMTFE1YkJvNkVnTHVsWDdOQjBFc3FH?=
 =?utf-8?B?ZVdMYzg3QWhPaWIrbXJsSHlUYnRDZTBzaW1YdWhKTlJscmo4ZEp3QW1FZDFI?=
 =?utf-8?B?YlRkMGdDY1RpMUwrOEJCUUMwZ1VtY25qTWJadUNla0ZyZENhZ205TnAzVW1H?=
 =?utf-8?B?QlE2bXRrTmQ3SjlGV3BKNlhmcVl4aWFRK0Vnb2pyMHJBekk5QzYzai8rY1Jv?=
 =?utf-8?B?V1FFSkx4NTl3QVBNa1ZEcGRIb3ZqWDlDcS9WaXVKbXZQOTBkbXFsanVxbVNy?=
 =?utf-8?B?aHNsSWozVWs2QzlPY3Y5RHl2cHd1WE5VT0FRZ3hGbmh5ZFJzNkZDODcrbjd5?=
 =?utf-8?Q?xQMU=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QmZVell4bGRoUVhkT0dtUjBLNkZkV3lseHMyVkZYNWZpSWpERWR4bXdwVzAr?=
 =?utf-8?B?QWtrY09IQURQN1NsZ0Z6dDBnUXh2bldKaVZLd0w4Z0kyTzNsbFRqK0xLODhS?=
 =?utf-8?B?Ly9XVE14aUJsZ3ZGeXRoZDJRNFBLV3AwRDZoM3FnRlNDaURFekUvVDJtYmNY?=
 =?utf-8?B?T3FlbDc5dDg1WlpOR1FQKzFMcGJzOFJjS21RSEFCZ0ZTNjVDU1RYSG5VWk9s?=
 =?utf-8?B?R0MxZC9UdWdmdERnQ3BXbUNXdHlHYjc4Y1ZrK2tiWnJCWEh2eFhIZFNWQ3Za?=
 =?utf-8?B?cUdqU09zMlE0Z2pOZUk4MWR6WGl1WFpzbTJiblRGQ3dESnlFa1BTWlJKOWNN?=
 =?utf-8?B?MHNVS2duSTk0ZUlROWh2OUVYL1BsN3BqMDVGYWlwajFxVkdWMDNBMGJZTXYw?=
 =?utf-8?B?Q3FPVDdMb3NVMkdUY3RiY1NUUE8wRm1DRmhmcXJHZVpWWlZMTk5nYmRGRXRU?=
 =?utf-8?B?RVl3MW5zOVRzVTRrS3Q1Z1hoZFFuOTl2dDlNRWJMMTh6R1p6UVovYlFnaTha?=
 =?utf-8?B?bjVkS3Q3OS8vVUxwZkVPUk10R1pGZVJzT1pNYUFacFhFVUgzOExWT2wxQW5j?=
 =?utf-8?B?UjJOeFVjSXFHZHlCV016SEpWV1dNbkp0MGNzaUdFNHhCRFNYQnFORFBZU3FL?=
 =?utf-8?B?ZFE2SDJvdWQvRldUc3RJVnUxdWJUSUJud3U2MUNIWlc5SzRLTlBDMHBpeC81?=
 =?utf-8?B?MWZIaERxblRTV3Y1eE1RazlpbWpCTXk5Q3JmYWJuMDZlUTZaZlk0cGxTb3k4?=
 =?utf-8?B?NERnWlNoY3BLcDd0c0Mvck1OTENvbmpRNzg5NHJHQTVJVTZ5MWticEk0L3or?=
 =?utf-8?B?WU9yYXNEd1ZJUk9qRUNPRGVqWWxmSzlLeWNMODdMU3o4NitiS1Q0SjVQQWZl?=
 =?utf-8?B?WDFHNnRkNTduK2NjY203dm5NVStzdzJEK1RtK0NIRHI2WisrQUsxcm9qTyt0?=
 =?utf-8?B?TnBVU0NYTDNYUUdmeDhRTVJYWVNzalZ2YmR1MGJxWFB0clArTW11bmdGRnNT?=
 =?utf-8?B?cWpPdjRnempCamU5VFhHY1dZTElWcmk4d1VvV0JhYUMvTmxQTmhSNjF4SFUy?=
 =?utf-8?B?Z2xBUEpYaFdVTENVV0FKYkJmTzN0ZWdIblU5ZFM3UXk0a0lheFpHSmVsekF4?=
 =?utf-8?B?V2xLN3ZuZSsxNytoeTBVSDA0VFZXUEtMc0tJcDBuL2FFR290R3NkNjVocmxZ?=
 =?utf-8?B?Y1N4cWU1MjFJSTFVa2FPOXdQQWQzbzIrTUVIMG1KWFdUKzdzMHpHM0djbHBO?=
 =?utf-8?B?c3IyelNMbEx2UWR5cjNCTmlyZ0pPaDZ1Y3RPVWwvbUJFT1FnTmNwU0p5TlZS?=
 =?utf-8?B?MFpweVRyWUVPd0JOUlZBcFpMN1daMXM3a2trRm1qSFcvQVdtWnhHdGl4UzA2?=
 =?utf-8?B?VkFJdnFidXdBZUIrOFczNm44V2tmaXlZaDZ1eWprc2dIY25zNmRlZWVDak9E?=
 =?utf-8?B?SjN6cHNrb0wwc3JkU3l2VGtnN2hoRnI2d3o5U3N4cnczODdtNHBwdmRBa3JN?=
 =?utf-8?B?VnFsUFVEeC82NS8xQTlBM3FvV2QvNXR5UDdVMTV2VE9qaVV0Lzg1TjE3Yjhy?=
 =?utf-8?B?UExsUXdaZk12YjBqc0NXSFRpRWJhZmxaM3VvcmNtNVZCbGdGTTlRaVJjcjlR?=
 =?utf-8?B?aGxIdVpkT0NLSGJQRGxoYnR1Z25ZYXJJdWRabVduTGdueS9YM1RPRGoxRk4w?=
 =?utf-8?B?QTkxVFJMYllqcGtiUzZIOWRpQlI0b2JWeFVCdWp1aENiVW9ZLzNzSjFUM2NH?=
 =?utf-8?B?aVdnRUNzOEU0dHBscXNiV2tQY0VVVDFSN1BDc2g5d3htc2h4T3QvWTBNTzd6?=
 =?utf-8?B?VSt2WURKOCtXaFhIdkpTN3g3T0RIRms5WmY4WkxsTWY3ZmVwL2c2S2x4MnQ0?=
 =?utf-8?B?QWFGNEc0Qnk2RjNSemhGSnlPQlYyRFd1dlZKVTV6OWhPRUxFUmtNc25DeEVZ?=
 =?utf-8?B?bDdlcXJMTFB0MGtZVzN6akowQlFFOWs0Sm9XNkROcWw4NGo5cmpHTmFkYTdZ?=
 =?utf-8?B?MzB5cDhTaTBjdXpLWCt5dzVuVmZXa1BSY0hQTTg1ZEZJNCtvREgyb2pGVHlh?=
 =?utf-8?B?Vm5oa3djbmwyTnlHS3U0T0NFVjNSaS83Q21ENnJtamMyR2dueVdLTDRreXNV?=
 =?utf-8?B?SkNLNTJqQmhsWnZWYzI4OVNadFA5d2lsVU51SlpjV3R4Z3Y0bkV5aS9ROFAy?=
 =?utf-8?B?MGIyNHNtZEhsQ1NHNzBKdnFmRFlCQXNXVEFNLzhNUm5yMVNiazVQb0laMnl5?=
 =?utf-8?B?OFlVQWtUalpHYTcyckd4dUlUVTB0dzRaYkoyNTZuUDhIZm45THVCTGx2SW85?=
 =?utf-8?B?YmtNNlo4dXhQcVVLN0xuMm83TXZnclMxandoYWhTZTNKU3drS2RXYk45NG5Z?=
 =?utf-8?Q?bTn9eOtbORWcQpDo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R+K0wjxWd8UtgTi6TDxAddJqEw9MxSrXzS7qhIEn4ua/mnVTXXP7WFZeLdBjl2YYnpip1eA/GhJbCdsfmRdbXprpktMBEpcXFWKw8lNupF1bUkOx5ZNV3XpwVj6EtWbcQZU9MU8eS2lsl5igtShS43WXkbI3FLofVj/bYG3iTE/KSaTPLnsY4dGB3eZt+kuSPlBho9es26ud4J3VyA7g561BtwPEaSwd6v6L6PKtmS7Ozh6adjW+yJF6BlA2L64vni1ZXrJbeDAcL7tXO4y9ec4zKlZW0fDh/i8VSDIsSa8Lkjtrraqx/qniHpfByVJQ1LdjrgllYelv490PyjWXOWKMfQUQMIdLYvV4uo/sFE4YNRZsbFeFvdMaukNc8ntFtyPx2jdNyR5L8WOiLYQlZ+xLX6bkhFirvI6y26GlT9ovkDdgIgsNiejZvWyvmEqDO/NCN/88JnQO4kOdcRnaCYU1Qgt14I/mERrRqHubAd85N7nCKXuWRTsFfgf44+H9v24u1zlXc7Kl2jt4GzQK0JYx87hdcwgsPprZKxvVazN1IE6q97cyPL5ft80pdv8kdUFOzUlWcBBq/Xmf1cWBAK8VUN1ZYEgnZnp2Ftb/Y2A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af0384f-6780-4a9a-a72e-08de55219121
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 17:06:19.1774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TiZ3ja5BoLeUtrO+WbmZdxN35XMhSg7/KQnM3yd4KqP85ozRrCug19f0ssRWBnQ8KWTez3OMkCtU2eGrZ2R941h1to1wcCBhPof+7p/BpFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFBBE6F5DB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601160124
X-Proofpoint-GUID: 2YaYi9ZRpIb1iyEn1-BpysktZpUUvo1P
X-Proofpoint-ORIG-GUID: 2YaYi9ZRpIb1iyEn1-BpysktZpUUvo1P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEyNSBTYWx0ZWRfX9l42GRzsbQyu
 s3cR378mL5cfietEdTzR+rPE7LbgrTuGdeiI3bgZtSvOZvXzQ04ReNiw/5hHKl3sMHhcbyVz75F
 J4BaiyBZG1zMbhdP1HddMBsDcSeicrwhJxu6Gay5M60BjSFrz2KA+Rhyu0vrzGud3oMt4rwXy5t
 KpyyFBmLdJ+m70r1IqRSXNOEU5qk9YOXRq0qUt+n1pT7xxRnRg9c3TLcY2qEpZITRP5H+UaDP1c
 hakIj2bHg8FbYRGhdB48ZJ8yPSuOg/aj1eK8SVB7wHLtUR6wYICH5mtKDy1XR7ExuJTj1rZJaR0
 Zfc1u+I+O1UlH+O34ZVjlu/ufjfHOqWwSP3A0VFAFWPdhuxJwXHky50FGbA37zfFhOwDzLvOLP6
 m2OZgNcX6c4nvvtGYi0gtnxDy2gpdDGRUfZ9crCm823rLbjrTXr9VFoPdjU+0lu+2En2yAHQM7Y
 Ycq69SRvyWesy34GpPYumGcRnWu2QWPCy5gICWlw=
X-Authority-Analysis: v=2.4 cv=fIc0HJae c=1 sm=1 tr=0 ts=696a7011 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Q-fNiiVtAAAA:8 a=11BdiQb_Ps529eML7zwA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12109



On 1/5/2026 12:51 PM, Bhargava Marreddy wrote:
> Add support to receive packet using NAPI, build and deliver the skb
> to stack. With help of meta data available in completions, fill the
> appropriate information in skb.
> 
> Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> ---
>   drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
>   .../net/ethernet/broadcom/bnge/bnge_hw_def.h  | 198 ++++++
>   .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 113 +++-
>   .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  60 +-
>   .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 573 ++++++++++++++++++
>   .../net/ethernet/broadcom/bnge/bnge_txrx.h    |  90 +++
>   6 files changed, 1016 insertions(+), 21 deletions(-)
>   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
>   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
>   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
> 
> +
> +static int __bnge_poll_work(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
> +			    int budget)
> +{
> +	struct bnge_napi *bnapi = cpr->bnapi;
> +	u32 raw_cons = cpr->cp_raw_cons;
> +	struct tx_cmp *txcmp;
> +	int rx_pkts = 0;
> +	u8 event = 0;
> +	u32 cons;
> +
> +	cpr->has_more_work = 0;
> +	cpr->had_work_done = 1;
> +	while (1) {
> +		u8 cmp_type;
> +		int rc;
> +
> +		cons = RING_CMP(bn, raw_cons);
> +		txcmp = &cpr->desc_ring[CP_RING(cons)][CP_IDX(cons)];
> +
> +		if (!TX_CMP_VALID(bn, txcmp, raw_cons))
> +			break;
> +
> +		/* The valid test of the entry must be done first before
> +		 * reading any further.
> +		 */
> +		dma_rmb();
> +		cmp_type = TX_CMP_TYPE(txcmp);
> +		if (cmp_type == CMP_TYPE_TX_L2_CMP ||
> +		    cmp_type == CMP_TYPE_TX_L2_COAL_CMP) {
> +			/*
> +			 * Tx Compl Processng

typo -> Processng

> +			 */
> +		} else if (cmp_type >= CMP_TYPE_RX_L2_CMP &&
> +			   cmp_type <= CMP_TYPE_RX_L2_TPA_START_V3_CMP) {
> +			if (likely(budget))
> +				rc = bnge_rx_pkt(bn, cpr, &raw_cons, &event);
> +			else
> +				rc = bnge_force_rx_discard(bn, cpr, &raw_cons,
> +							   &event);
> +			if (likely(rc >= 0))
> +				rx_pkts += rc;
> +			/* Increment rx_pkts when rc is -ENOMEM to count towards
> +			 * the NAPI budget.  Otherwise, we may potentially loop
> +			 * here forever if we consistently cannot allocate
> +			 * buffers.
> +			 */
> +			else if (rc == -ENOMEM && budget)
> +				rx_pkts++;
> +			else if (rc == -EBUSY)	/* partial completion */
> +				break;
> +		}
> +
> +		raw_cons = NEXT_RAW_CMP(raw_cons);
> +
> +		if (rx_pkts && rx_pkts == budget) {
> +			cpr->has_more_work = 1;
> +			break;
> +		}
> +	}
> +
> +	cpr->cp_raw_cons = raw_cons;
> +	bnapi->events |= event;
> +	return rx_pkts;
> +}
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
> new file mode 100644
> index 000000000000..b13081b0eb79
> --- /dev/null
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2025 Broadcom */
> +
> +#ifndef _BNGE_TXRX_H_
> +#define _BNGE_TXRX_H_
> +
> +#include <linux/bnxt/hsi.h>
> +#include "bnge_netdev.h"
> +
> +#define BNGE_MIN_PKT_SIZE	52
> +
> +#define TX_OPAQUE_IDX_MASK	0x0000ffff
> +#define TX_OPAQUE_BDS_MASK	0x00ff0000
> +#define TX_OPAQUE_BDS_SHIFT	16
> +#define TX_OPAQUE_RING_MASK	0xff000000
> +#define TX_OPAQUE_RING_SHIFT	24
> +
> +#define SET_TX_OPAQUE(bn, txr, idx, bds)				\
> +	(((txr)->tx_napi_idx << TX_OPAQUE_RING_SHIFT) |			\
> +	 ((bds) << TX_OPAQUE_BDS_SHIFT) | ((idx) & (bn)->tx_ring_mask))
> +
> +#define TX_OPAQUE_IDX(opq)	((opq) & TX_OPAQUE_IDX_MASK)
> +#define TX_OPAQUE_RING(opq)	(((opq) & TX_OPAQUE_RING_MASK) >>	\
> +				 TX_OPAQUE_RING_SHIFT)
> +#define TX_OPAQUE_BDS(opq)	(((opq) & TX_OPAQUE_BDS_MASK) >>	\
> +				 TX_OPAQUE_BDS_SHIFT)
> +#define TX_OPAQUE_PROD(bn, opq)	((TX_OPAQUE_IDX(opq) + TX_OPAQUE_BDS(opq)) &\
> +				 (bn)->tx_ring_mask)
> +
> +/* Minimum TX BDs for a TX packet with MAX_SKB_FRAGS + 1.  We need one extra
> + * BD because the first TX BD is always a long BD.
> + */
> +#define BNGE_MIN_TX_DESC_CNT		(MAX_SKB_FRAGS + 2)
> +
> +#define RX_RING(bn, x)	(((x) & (bn)->rx_ring_mask) >> (BNGE_PAGE_SHIFT - 4))
> +#define RX_AGG_RING(bn, x)	(((x) & (bn)->rx_agg_ring_mask) >>	\
> +				 (BNGE_PAGE_SHIFT - 4))
> +#define RX_IDX(x)	((x) & (RX_DESC_CNT - 1))
> +
> +#define TX_RING(bn, x)	(((x) & (bn)->tx_ring_mask) >> (BNGE_PAGE_SHIFT - 4))
> +#define TX_IDX(x)	((x) & (TX_DESC_CNT - 1))
> +
> +#define CP_RING(x)	(((x) & ~(CP_DESC_CNT - 1)) >> (BNGE_PAGE_SHIFT - 4))
> +#define CP_IDX(x)	((x) & (CP_DESC_CNT - 1))
> +
> +#define TX_CMP_VALID(bn, txcmp, raw_cons)				\
> +	(!!((txcmp)->tx_cmp_errors_v & cpu_to_le32(TX_CMP_V)) ==	\
> +	 !((raw_cons) & (bn)->cp_bit))
> +
> +#define RX_CMP_VALID(rxcmp1, raw_cons)					\
> +	(!!((rxcmp1)->rx_cmp_cfa_code_errors_v2 & cpu_to_le32(RX_CMP_V)) ==\
> +	 !((raw_cons) & (bn)->cp_bit))

bn is not defined in macro

> +
> +#define RX_AGG_CMP_VALID(bn, agg, raw_cons)			\
> +	(!!((agg)->rx_agg_cmp_v & cpu_to_le32(RX_AGG_CMP_V)) ==	\
> +	 !((raw_cons) & (bn)->cp_bit))
> +
> +#define NQ_CMP_VALID(bn, nqcmp, raw_cons)				\
> +	(!!((nqcmp)->v & cpu_to_le32(NQ_CN_V)) == !((raw_cons) & (bn)->cp_bit))
> +
> +#define TX_CMP_TYPE(txcmp)					\
> +	(le32_to_cpu((txcmp)->tx_cmp_flags_type) & CMP_TYPE)
> +

Thanks,
Alok

