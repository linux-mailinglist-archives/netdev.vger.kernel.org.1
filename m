Return-Path: <netdev+bounces-192301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 126D4ABF5CC
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 15:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6306C8C528D
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27FD4CB5B;
	Wed, 21 May 2025 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mp/Hp9Bu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XDDlFXwO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA6D18035;
	Wed, 21 May 2025 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833337; cv=fail; b=GIFDTIF2Qbl+qiqHFThu8u5wFmsleBPdqhCHByyD7bKjISlJ+EBn3hM3WcRdSjJI0a9b8GlFN6veSml2u4u/gV33uAnkRHvUA087C0kTY/YmBEiCV0yBwdfN4T5Vujv5ZQ0ZpLR1CciYPOve+fH0nzw6bPt1S8K1waU3SZmr0WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833337; c=relaxed/simple;
	bh=2l02ZO4dk3Nshg79PQqE07DgklZx7MUHiWN1+aBbLr0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BcJvlX+c67WPOxnZz7HP1KYIuJArfHeRkBjJNLbmVyvSv8DjRwEeJEwtGTIfB0EhkD52X6cqC9U0ZCSauEWEckqmUJM2l88EspdNYN296onvbY5H6YsMvq4nHW8z3ipEUNaRFsHYbtSlExfu7YcPTQiY6NtGGkqHKoQTuAwVtRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mp/Hp9Bu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XDDlFXwO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LDCMIK012389;
	Wed, 21 May 2025 13:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=f8GMh7c7l6i7jRZZJ9yFdypwu4aUJ+Jb7kH4CjQD5OQ=; b=
	mp/Hp9BuJqcuZuqmmc3s4Ut//e4LnfgKFHrYSyYYJcb+pB6FHLgnTuUPtMB+XiFc
	SM/X5g7s1/vxjkcqC3RghrjXgmWCm4z5vwTCdLu2YZvN0aEJv7CHj4ac88n7JN8l
	lcNuX3C/DKRzE1PBBXIcbvYjKwns8yYeUYp9uZL8xJYurqajuhvaiaokJqMV62zD
	tn7qjNtNKjCZkEeVzQxRrEkAun6aUWz1ZE0V2xy57RdiVWoQrtCNasRc68BUbiDr
	kfsf4uDL7YVTe0fOShBTNWi+H52MEa7w3ZPyvIFmOywqXzeTfZcwu3gged1vzlzL
	c3JgHvSgHNINCaIOjKLRQw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sfgpg057-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 13:15:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LC7i5a032143;
	Wed, 21 May 2025 13:15:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwembej5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 13:15:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJV+Pp3kQtyX6ioxbbnGho4cTUMk1LqDmuTWNhFbBebO242KtO8GRASlsVEIEGkVNqheaMHTpSnaUWgPsu2DobrXPjael9FHJBk0F/ZYZ4KugfFHj4oaXKvoKEGJg9of1Z/c/KyOCNWe+63MHEFMvJ4ihct/k7WuAeCUZIYnqyBgqzv2sMR2/9TOiFL0Hb4U/88QQUGrYQ7FbZij8phIg+A98t/FZ772pb/vwXk9kv1AKTO2+Wb7Qj0CPIE6WgcAHaeKWyF1iIXy/boM65eed/sE6GlJEUvUQjDj/HCbQSnhw914OYmW0HIklIEv1/FGnB7O1Kz9hUaWMb4Q6sXNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8GMh7c7l6i7jRZZJ9yFdypwu4aUJ+Jb7kH4CjQD5OQ=;
 b=aFM+ac1p71N6lAiEYH76CJ4CXu4KNJXCYgALviI8yGoaG2EZM9GNcjPVgA3Dzij8UksXxDsiZOprTOWLzO5MjfCeaN3A+36vdcR7ux1T+MxRFg/fSeQx25O+Fg0or1/5QRHEN+U8eEcZ1i9Ih9hOIfQhUm4CWsN/+p2A9+OewOv1dJfCkHqKSpKfrLiPIj8t6wsaTJCxo35hmeYOxq9sknMpT0HDuU+1iEqcTEvVOcTqoPe21hiVrv8/eSsLTQ+xI40c9fu/EJwoDi3IXLTPPr1iixEZ3zl3R1k1hXcdAKLik/AcSkTG6j3gxHa+dIgyhrtr1q6G4Ejqncv+sdinMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8GMh7c7l6i7jRZZJ9yFdypwu4aUJ+Jb7kH4CjQD5OQ=;
 b=XDDlFXwOT55ZkzdX0IOjI7a5LFlZch5FgcEggzdo2gFpIc+X7m4Z9Jja4MSgjPPH2dJsPvV3EbmjuCD4Ja3YYV2qCkhP9vS9XgNh3ZlsrURhNhk80+SkoklaFLz608Ki7bk8fiy8B6pSKMW8Tfxxpk1rZhBkJL5vKyFQMplGGTo=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 13:15:16 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 13:15:15 +0000
Message-ID: <978c8c91-5c52-4e22-bdb8-5731a35278b1@oracle.com>
Date: Wed, 21 May 2025 18:45:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: phy: add driver for MaxLinear MxL86110
 PHY
To: stefano.radaelli21@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Xu Liang <lxu@maxlinear.com>
References: <20250521113414.567414-1-stefano.radaelli21@gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250521113414.567414-1-stefano.radaelli21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR06CA0042.apcprd06.prod.outlook.com
 (2603:1096:404:2e::30) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CH0PR10MB4858:EE_
X-MS-Office365-Filtering-Correlation-Id: 096c6085-a390-41d4-4de4-08dd98698675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFdNa1NBaTgvR1ZvMGh4ellIbERPWmkyclBvYTlPMlhJaDIramJzd3NBemtD?=
 =?utf-8?B?aCtTeEFBS2hlczRFNklMaWhCVDJmTDZ1TWJnMEI3bWs3cjlRZVlkOGJlRWo3?=
 =?utf-8?B?WGxMeFFoMGlpTkZoTUc5bUpFUW1qZ2E3cE4wblhhT0dobS9xNzRMd3RDMjhX?=
 =?utf-8?B?akNzZkdsMzhCUDlPN3V0dzJuT0R1VTFUaG5iY3ZTOGt1LzNkSW5sb1VjRFRI?=
 =?utf-8?B?engxQktHNXZLNUE0UnVLZ0RIQTZHekozdXBFcWpCSVIwMGhCMFFFQ2s2T3F5?=
 =?utf-8?B?S3dQdkVraU50NEhSQzlnT2Q1bE1YRGd6a0dZbG1ER25Yb0FaOWxmWnAxd3Jo?=
 =?utf-8?B?akEydE1HYVhFUTFTeUpqSys5ZDYxQVFudU9aTGUxajNxUGtUK1VJL3lSNFFE?=
 =?utf-8?B?ZnltNW9RWVY4QjJnbE1iZG1sZG5hUmdBSXRGbis4VDJLMWY3NHYxNmM4MzNz?=
 =?utf-8?B?UkVsWWlGVmlpY0JlcWFOQkI5OVNtZ28wVFl3M25mQWVnMkZTczlNQTZIa2Ey?=
 =?utf-8?B?WHFETW1XL2JxVGxkRDFSNHVMVWs3d1E1TCt5N2xkK2k1azhUbG5haEErd1R1?=
 =?utf-8?B?ZC9XY0N1M2NvU0tlNEhpdnBlbkdMdjE0WjA2Wm5EcUNiaHR5d2NBZ2NYeVRt?=
 =?utf-8?B?ZHNYN0VCakZ5b0ZYWnBxZGJyRmwzdGV0OTNqK1QrdEhIaTUxTGpVR1pva2cy?=
 =?utf-8?B?dzdtTUI4MFVTOVJ1M0hiSHkzZzBuRG5tWTNsb25zVHJWQ1hCNEl4VWVvVldR?=
 =?utf-8?B?OS9TZFMvZFNtMldCR0R1M3dCN1pDYlRaQzlFbGhmck9lcFUwa3E5THFJOG44?=
 =?utf-8?B?YjFvWWUwc0N2c3FUM1l2ZVdyNXVJWjd1WnA2VUNvQllxVGVROFZaaFBYMkpJ?=
 =?utf-8?B?akQvT3dlU0xWbzVnOHFmTWtsY2p5TldSbnNtQWNqOTlFRU5PVjFNNTVBMWw3?=
 =?utf-8?B?blBuK24vTkVPb0JVYzVWZURkTXBPUEN5dU9JajYvQkdXV3F0NXJNNEY1Zm1M?=
 =?utf-8?B?dGJlbCtCc3B4aWh3MHdPN1JRdVBIS2UzWUx1bFhFNnZVQVRrVXROcUdSYkdU?=
 =?utf-8?B?V1NpNytOWWNKVEdhN2FNWEZ3R2gxN3FPVjFydU9NRkM1blBsZlRtMFBYaTBR?=
 =?utf-8?B?bUVqMUkyWVJRTEkrczdORkN0MkszZHgrTitZRHM2Rzh6VG1ra3RaZHBTT0pG?=
 =?utf-8?B?ZDlzVTNiRG1LMFltRjFVcTFuTlljdGJQUDEyMFIyMklISGxhcHBWM3NGZDJk?=
 =?utf-8?B?elFkMFEyNml2S3IrMGJ1MWtFMFJ0S01GNnA3M3BTY2wwU2NDbGN3Tk4xVm9X?=
 =?utf-8?B?aXhVVzFvMWFnbVJHRHlBMXRuNWJ5K2htVTlYSjlYWitBb3kxZjhYYi95cnJw?=
 =?utf-8?B?WlpNaFNZK0s2ck1XZUlUQmpwcEk1NmJyZXFSNjJOM0t5NEZiVXBIb1EyNkNZ?=
 =?utf-8?B?N0YwUHZsUVZCekdkYlRDRkFiTlZzNVBwSHpPS1luSW1nSGhoUjdNZ0t2L1Vj?=
 =?utf-8?B?T2UwSEhTcVpjOVFCKzFPTE5LNnBkMWd3VW91V1hDV2xiZkZhZC9iQnBkSGhD?=
 =?utf-8?B?dXlhWVY0TUlmYVY4R3dTV2NyTnJ2NHEzV2pKc3VVMkx5RllJNTl5OU9tN3F3?=
 =?utf-8?B?eXdKa21URHl2N0crRDlFdFhPY0ZZTXl6c0psOWU1amcxQm9QTlpIYmVBS0lx?=
 =?utf-8?B?SS9XTXNxcXZUS3drQWpKRytxaWxkeUJPVWNIbG11SFhJdzVIc0Q3M3pVaDVw?=
 =?utf-8?B?TEdjQ2pQU1pWY3FTN1FvZ0ZlYUhxeis3a3U3bUp6aHRjUEZRVWVtUUxnaFds?=
 =?utf-8?B?Ykhqd3h5RHhhSkZSU1A3akg4Y1hnWHFaRDJYMDF5UWdWa1BKSnhkd1ZXa1RC?=
 =?utf-8?B?SjMzRWNGdlVRY2ROeng4ZWFvZFlpM1BwN05KbkcvUlZhRmRQdlRUV1k5UmJl?=
 =?utf-8?Q?5ILUeLHJPK8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHpSN0dMNk00dGs4L2x4MVYxc0JWRlpicU9pSVFPd0ZIS1J6N2c1cjJUdGM3?=
 =?utf-8?B?LzU4aHNuUnAvZjZOUTJUV3BVdVhPR05vSkN2TXFtQzgzWk1iVFlVenB5TElM?=
 =?utf-8?B?d3RadHNDWEJOYW8yYUo1OTZXS3hyUjlaRHI2NElUTEJ2SjVUenpiUnRyTmx5?=
 =?utf-8?B?SmQxdjBDNWQwV1lkZzExNldoOTF5TklmSnFJWThVRWlySmFtbDMyTHpSK24w?=
 =?utf-8?B?YWIzdU9HU291WXd1b2hHY1NSNXVVUm9VSGhZaEwrZDNQcmN0NXUybXBSazRN?=
 =?utf-8?B?YUJscHg0Q3YwZHpSQ3RIRDhrUVUvSXl2NnFUa3MxVkpaTjFQR0c2VWttWFEv?=
 =?utf-8?B?RVRaTzdRS0hjMnJWcDlzZ29kZmp1YUdpS1dOVUFibUY3WjRhOHlSaVFXTzAr?=
 =?utf-8?B?Y2Jsa3RhLzBjSitlQTNyMFErYlpFS3JMcGc5SEJQdnk1bUZWVXZHM1hIUjA5?=
 =?utf-8?B?dXFvbkhzRngrZEtpbW1qb28zczdQa1BRZzRKTGNWeFlhRXA1b01OczlGYzg0?=
 =?utf-8?B?aXp2ckY3Nk5ZY0VFUEpkc0dXREdPckNFS2R5U2pOc04vZVJ6dlk4VW5CUXhS?=
 =?utf-8?B?WnhQWWYrSE14dGxnYU5nZnM5NkdNckhGeHlxNUpOZnJESFFKS1hBeTNrY0ZP?=
 =?utf-8?B?RTJXZHZhN0pIbnRkT3NZWWZnQnhTY3ZhVVZNNk5RNGdKcENZOVdUUldhNVM0?=
 =?utf-8?B?c0VtNUdwUkVITll1Sk9LcS9XQ1hyMWdGQ1dIU1FBNDlsVzh1T0xtVUNKN0dS?=
 =?utf-8?B?WEVwMmNpNTlTdFFoaXc0QlhkY3R3SGhKQXY5Tk5DdmpETnFEVi9taW9BL1FK?=
 =?utf-8?B?MnVNbUdCS2VCSUhRb1Vld3RJVDV6aDBKVEZBdXVlSG1rUmRjSldETlBwN3BD?=
 =?utf-8?B?SzJQL1hTdG8yVkxEdUk5dmozV3RYTXpWdGJZVTNFTHhpZlNPNWZkMWd3OHNJ?=
 =?utf-8?B?NXl6MXFvSlU1Sm8yOFZvSmpoWDMySmNYcUVsQURjZElPZGlVOUMvc1VCdXFs?=
 =?utf-8?B?RjZvR3hJNlZhSldtbkhqV3loSFhzejNmOGw2aG15Q2wxR2RiV0dKL0xEOUpa?=
 =?utf-8?B?MkJrMCsvUVBNY1NuYlJyalJ2ckhheTF2ODhkU3MrSDlqY1JTUVFVUDNvWEdz?=
 =?utf-8?B?c0J0SWF3dCtxRWwxYUh5bDlEUTVhRThnV0Y1eXUzTTVKZWFDYlQxNUR3c01L?=
 =?utf-8?B?WHhlY3JiUlp2cHFxbEpOSlcyaWJMZlZXdUE2S2RVV2srRFNzc3kreVZiQ0Vl?=
 =?utf-8?B?YWlTQUlOVTlLRFVQQW4vNzNyV3c5Y1E0RTM3QVNDODVKenZsdkhHNzEzS2dC?=
 =?utf-8?B?MUk1Q01JTjhEZit3MFh3K1g1NldjVm8wVEtHRnkvaGZXbTRHd2JycytxS0hX?=
 =?utf-8?B?ckY4b0d3N0xkVTlETXZvbkVlS0R0eEtSUGcvYUNsMndtNnpYL0J0bHFHMHcr?=
 =?utf-8?B?Y2Q0Wi9OZEc1b1h4d2lmeXhUdVlQMCtYNWlEMnZ2UDBwRklYbG5Sc0ZvQVZR?=
 =?utf-8?B?eVpneHdFdlZXQzhIbTBtYld5OTQ4SXRKS29HaTVDODJHQ0VoVmhVTTRDM0tW?=
 =?utf-8?B?YjlVR040cXZMVGo4WTdkeXRSMCsxMnk2ckpzTTN0NDR5bklUMFljWllpMzVU?=
 =?utf-8?B?bXRjd2l2MUFuL0VIR2xpZXIwaE5hUDdBU21sYVQxd01rUDhyV0JEZUZxakFM?=
 =?utf-8?B?MERKaitnZ05SeHlYZ0Exa25MQ2dWY1Q0cE9jMi9palErRDhyZzZldzFXU0pE?=
 =?utf-8?B?enpzdGxrbVBKVUNxeXZhZURVQ3JMQXdqaVV1dHFMUGtuMytuUXlDWUxiSTBP?=
 =?utf-8?B?T25yNlVYQnRqZXZUdkdPZWV4eHhQR0tYcEdSTnNzc0Q3RzRJMDFkanZzWlpJ?=
 =?utf-8?B?TDhJYVRIbWZKanQ1dW1mQ3VwRERCUnBTRk1KSFU5SEdWQ0xLSWx1R3JCeHNW?=
 =?utf-8?B?QjBvRXN0YWQreXhUeGphc0ozMElmenZNQzBVdEwzWlo0N3M0NExuelEwdFFU?=
 =?utf-8?B?OVFWRk5tYlN5L05yYS9OVmdSa3BNd09tRjBjRkcrYy82ZXZWZWNBRGRMeWVY?=
 =?utf-8?B?WHFwUk1IV0N6cDFyTkxzbjhjNlViN0ZkL2xFMFFTdkRJcnBNSlU4V0h6dklp?=
 =?utf-8?B?bmZ3STFHYVhTSlo0dEl1bmpPYnQzdW9xSzJ0blNZUWk2TlBDUVFwSTlOdE90?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g5lMxXQv4cLobcCEqWSEFnWaICdERurxzWQTRrBSJNwLtLatbUAzq6zeP65ZM8EMalxnlLiRFIWV6OmWEnmYFYASh3whKSjuf37osLmyNpf/e0kj2TiqZ+fj1vy64tccKrkXXFbCozaheiyn5jGy4d9R+s6edQKZSUM17U53v8z588tkjS2r+jknDGK5Rg5LUP4EXgGMwZ5Y4M9QZM64Cj9lZG3hMkzDBOD9x8YIwGYvYi0Snfdk8Im3v75oOLongAPQQLELHze/GB4f+pZsSSBAL17DfwT70oB9W3Mm5SNzcvoLAtSNcKveSSxn1nOl983bE8U3SG2xbwHdzvp73KfjH1v4J1DGbH/iNx8L15RbQ4hlDLnGM841rXLS3SgehrsOY0+4XCoo5iddVfYBbty+foYnnOw+LrCdZ9AulxARBM683LRe7eyhdUuUOBOp2FkKouIqzaTcbaZXrxehI5A8wxmJu/9zi9SqKYgeSnkp4ut3jBoRpwXwnne1d91QcOsSG5jeH1sAXaZsol0zShjxyRZqSpKoiKmcu72BXd2nx+iHsrnocTlcIRA9a4sBDewRbr0XA3VJoOf4/Rz4RErrX9ci7qDvmOQUbiQFId8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 096c6085-a390-41d4-4de4-08dd98698675
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 13:15:15.4188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RXh/iC1z77p8Waw3sR4ibTduNAtRPOEHVPayswBRjhUjZ9TQMhvirdP8pxrM/+84lbfdkiKii3IYQTiGv3tshB59jtyuV8zuvIfnbVMJSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=849
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210128
X-Authority-Analysis: v=2.4 cv=cNbgskeN c=1 sm=1 tr=0 ts=682dd1e7 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=QRGspsFWhk9ftoffpA4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VFb0ECIFQFTDDqpeaAO-QgO12uu0y_hR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEyNyBTYWx0ZWRfX9dwtLHJatxRy 6GYiiV5iTPgeB1AtDHIc3CQuQdrGXF72nZ7W6CyiWQnzNM4zJl8e4o3MG/uRtlhPwl4UzeqqCGj GkQCaLUHmwskUrvOlJQfUJcryOLKmYx283nPTveAe+LYdNZWZQCDgpCf2Do5ANnl5a3k4AFXkK2
 Fk15NpRhHwNr2adOHg9ok8QZza+ZBXzubGHlwN5ogf7bRhhRBaXHLJQm1we96/2N5Vh1xUHxeR8 ZHbNOVAaoOV0zl1HrmNuCpOD/3mf2jDB9Fw2ylo8/f+RZNcXcD3HDSoDjxWGdL7093WQBNBCjRm efFFL7yzJjjHiJptCMyjVTakAQDdamigTirMGYuPN9kJxS003oYyeHE6nQBukGS2OEgFbsMod4x
 0vGt/Zh/GMnUpFfiw0/Yafdb6/PFjjnjobbQnRwXFMzYP33uj6upuReeDcbPtGn0moR/6E6u
X-Proofpoint-ORIG-GUID: VFb0ECIFQFTDDqpeaAO-QgO12uu0y_hR



On 21-05-2025 17:04, stefano.radaelli21@gmail.com wrote:
> +/**
> + * mxl86110_enable_led_activity_blink - Enable LEDs activity blink on PHY
> + * @phydev: Pointer to the PHY device structure
> + *
> + * Configure all PHY LEDs to blink on traffic activity regardless of their
> + * ON or OFF state. This behavior allows each LED to serve as a pure activity
> + * indicator, independently of its use as a link status indicator.
> + *

"regardless of whether they are ON or OFF"

> + * By default, each LED blinks only when it is also in the ON state.
> + * This function modifies the appropriate registers (LABx fields)
> + * to enable blinking even when the LEDs are OFF, to allow the LED to be used
> + * as a traffic indicator without requiring it to also serve
> + * as a link status LED.
> + *
> + * Note: Any further LED customization can be performed via the
> + * /sys/class/led interface; the functions led_hw_is_supported,

/sys/class/led -> /sys/class/leds (it is leds in sysfs)

> + * led_hw_control_get, and led_hw_control_set are used
> + * to support this mechanism.
> + *
> + * This function assumes the caller already holds the MDIO bus lock
> + * or otherwise has exclusive access to the PHY.
> + *
> + * Return: 0 on success or a negative errno code on failure.
> + */
> +static int mxl86110_enable_led_activity_blink(struct phy_device *phydev)
> +{
> +	int i, ret = 0;
> +
> +	for (i = 0; i < MXL86110_MAX_LEDS; i++) {
> +		ret = __mxl86110_modify_extended_reg(phydev,
> +						     MXL86110_LED0_CFG_REG + i,
> +						     0,
> +						     MXL86110_LEDX_CFG_BLINK);
> +		if (ret < 0)
> +			break;
> +	}
> +
> +	return ret;
> +};

remove ;


Thanks,
Alok


