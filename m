Return-Path: <netdev+bounces-179720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33B3A7E5F8
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D613B2C24
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052A2206F38;
	Mon,  7 Apr 2025 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nEiH33Tr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J+UCGsZL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17489206F33;
	Mon,  7 Apr 2025 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041839; cv=fail; b=ZxcEKQzXeZdkwYFE89IfPRqrl15PZguIHGjx2sQ/UxvFZ0wlPIe53AClWdNUgcU7CzHsjd3LL+9meSPv3TRsUMuzZM62xrWAWfI6nx58YTwzZQjKoS79t2Ek2Vf8YG8YUp1+efeKyncVtUL7ns55AxWcVvcZyiL9ljJO1LeD328=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041839; c=relaxed/simple;
	bh=7XT6DVFBv6lVzgFxdVeZ0HL2QbkI2jQtSN+vLgwgE+s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rbmV/IIqglQpIsu2Pq4zMgidMVYDceryXU7n6u/6PnW3Zy7sHpSgvExp0m/m2FSNDQkMKDFOZKDZ3kYASGY0w6Mi537aJZCmacsbxazkBXJpka7NntcgFcHny5XPMsqVi2LRLuY/MYeju2tHnn9ivsUGqifotpArGEdoY6ABV2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nEiH33Tr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J+UCGsZL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537Fu32U026007;
	Mon, 7 Apr 2025 16:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MRN3KkTRy5GTIfCrWLk7L6dAblYsR/xvN9VhHStL8uM=; b=
	nEiH33TrO7yPj8x+jXCdn5k8cm+rwMI+WdGKr+kFXGupLFEjqHe9qBrGZQN9yDFz
	p1AaI1TORNAAnA/jj5sO5WxTvzN6wJCHpmF0o8q2OzAiGjSn0kU4LW8QxOjbWaAC
	j9Z9QaDd52bYjnTfFL9OspXH7dtpm/rEwNqu4MPv4hyYM09DzdmZerg3GqmLSHmG
	+3QMRxKBHP5E3otSpc8q393tItwX23d4O+OI7nkM467i1Hx6SccjJS37hsjhf1wy
	8CGDGXEHm88z/FFuSKloZk6g21nnRGSHtDZrIZpcfzz1lVoqJ2MFLTyzp7x7vPR7
	a8hwcA7lOf/FiAfxX0Joag==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tv4styh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 16:03:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 537FITTg016286;
	Mon, 7 Apr 2025 16:03:51 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty80jfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 16:03:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaHU7BbuZHcWYhbS5R5LrJ/5YTdMwhm+Wi3KM2HTwjwQYngMlKAN0hvvL2FkkUr1LrQEFV7Fy6fGLnTP9xPcN83prJZQ3WYy+SiZ30++2E1YikCe3Vd7+xDs9LwwSilTuciBRfB7SUTF2mrR7lsGy3uCwkaiJ3jD9v0dLEpFM4Gx3XD+jZ1GVYSZw/i1CgpILe+auAmVJJCAJ9MY7M10VJXE90FqrpB5eE3WmX52bOSRezgESbYlYRKHTZAvnYf4WeiWh/66+ErReHVZTbxBt3rLGwFcryqKY4Vz+rZcarlqcF/VikZxuQFjuF5ofSK7vlGoWFw9FsmTydqULWPnFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRN3KkTRy5GTIfCrWLk7L6dAblYsR/xvN9VhHStL8uM=;
 b=obdUTHFHllnFkGBEh7RFiCmPOEnqlf6iWUuhCDtxnmohi1ViMRAa0FICvdGACJhqdPzh9ilqX/FWZ9dlHhNMp+VQn1fuCGH9vh5vG6DIHMUOPvJKeXlW0SEl8mSjSoNA/Kwq8qBRReeFC8XVTfpytsK7LipZ7hmjbUR52oMxS6RANOzo9tdCIfwjS3UZKf4GWTkQIWg3rmWTAyycv8Khsq24i2yOGVj9K9Hw9TtACvoLOpUy8JcoONQPIRDCjelH+Ma+FZg3wjK69vW4xhWOv1R/MRgUzwOuNXTFwn9dVUm5bizbnd9CqNbdobc2wdBlk8CFMZ+5d9dL5yP1uOdm9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRN3KkTRy5GTIfCrWLk7L6dAblYsR/xvN9VhHStL8uM=;
 b=J+UCGsZLgXMc1G661PRs1xgNLQ5OCAx+NBEQ2edIBglGhrEDwd4Deq//A1+DNw95c1UD5a3S4tBwy3NuVPWgy4cts7FeN3Myp8UTsH5x2M10a4mJ00Wk7enMh/lYTWXS1BRwkHqYrqBY3DZcJAO+jix1CbnO76GT9ZOBTDTTu4k=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 16:03:49 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%5]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 16:03:49 +0000
Message-ID: <8c87752e-bffe-4cc0-b838-cb6486b6261d@oracle.com>
Date: Mon, 7 Apr 2025 11:03:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/8] vhost: Reintroduce kthread mode support in vhost
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-6-lulu@redhat.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20250328100359.1306072-6-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:1ca::17) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d68a0c-a7a5-474b-29e0-08dd75edc8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjNPd3hhZ1FrQWlXMUNYQkRLTm1HOW0xM1NGS0k0d0tTSEt4M2VzTWx4VlF4?=
 =?utf-8?B?eVI5cW5qNlNIL05JZnBRSDdaVHFwRlNTb2pFOS9FSGZFQ2tIVnpWR2ovdytq?=
 =?utf-8?B?bUtrQjRqNDA5VDY4ZDFnYnRGeUZrbENVYjhhRXFtNEVhRVV4cXF5TjVydG15?=
 =?utf-8?B?aEpKMmQzRlBmZUVOTEt6MnllUjBwVDJ4SHlydEkxVGg4VWhEZFFvSE8xU1hY?=
 =?utf-8?B?RWZadi9CRTRrZ1dkYlhSYmlqUCtzTzV4aGVvY05FRmtmVUVOQW5RZDZpYWYw?=
 =?utf-8?B?M1dqWVAvWnU1WDh6V21SZ3paTU5BU2p0S3ZURS84KytHVHBtUERXNUVLY0hG?=
 =?utf-8?B?YmhCblllT1hET3UrU2FST3l6SkhibXFqUDNuM2RVNDVaNkttdE5maW1yWk53?=
 =?utf-8?B?UnBFMTZ2Z2haTCtkbURKS0NrdW1PbU9sNEZyTEEzdS9lVkkyLzdiYk1CaWtr?=
 =?utf-8?B?RlJ4MkZmaWR6OVVaTWJsUkhtQ2dpbFhVUzl2MW9TbVZXU3NUcHIrWTIzTGlr?=
 =?utf-8?B?a1V0dG45cHdxZ2hQOHBPYnBJdlhmUHZGa3FJQ09uT203Qy9DSzhYK1lYZzNn?=
 =?utf-8?B?ZzU2UVdwd1YvUVhXYnBHbVZVNXJUSjFUdjRvM3JLaUwxT1ZuZFFSdnlCczNi?=
 =?utf-8?B?bldGMW5VZzZLNERNcmFXZVhFQ3N4Q0R4U05WdW1WVzBXaU1RSlg0UGc4Z3p5?=
 =?utf-8?B?KzZxUEM2eE9kSmtmUDV1Sk0zblBPNndvMklNWmFNbVJ1KytVbVdranVaU25v?=
 =?utf-8?B?N2NCTTNTMUhKVWwvZ2RLR2U1enJJbGp1aDRFV2taMC85UG0wK04xMnVtZ0g0?=
 =?utf-8?B?S052YXJMb2R6T09BWGg2SUZZVEhlWVUzeHh3aFFmbVRMYXdjNkZiUEhyTkRw?=
 =?utf-8?B?M0Q4eWVUclNxRm1MVFErS0lpY0ZtYUp4TmZoS1lSOE5nUnlPSGJ3SnNOdHAw?=
 =?utf-8?B?ZXZDaXdlc0JCdENDSVZreWthbzJmOHQrWnUzTlZuRW1qYTV6bGsyNm96NUZS?=
 =?utf-8?B?ZHl6dUNHdU43RVF5YWx6T2o3UlJOcHVEVTU5UjU1Z2YrNmZoWXdaenZ2VElw?=
 =?utf-8?B?a0N3V1haS2FsZ2g2U2RUV2xEbkNDcWlxY2FLVVA2a0pCRUI0c2dLdmtSajFK?=
 =?utf-8?B?UDg2ZmQ0dElxV0tEUVI2OUV3ZGR6ZzNnemR4bFRqaHRGYW1KU1JXMWpvQjRG?=
 =?utf-8?B?NzRHVEQ4d29BZXE4RWhsc0lhZFVEanFvMy9PODFqajR6TW9YN3pudGpLQnM5?=
 =?utf-8?B?RENnTDJRMGdCYVNRWDgrNHdWdzVOQytkaGlNRExNOVpla1c5L3F1VWhuZ28y?=
 =?utf-8?B?WENPNlc3QkFGajQrNmRuSnhsQTNiZjhpY21hUjc1b1BhUzllSEw1blVQYXhp?=
 =?utf-8?B?RUluOSsyb25mUGY1SWpxYWh2ZXljWGdlYWdrR2NwbC9BMkZSVGUrVkF5QzlP?=
 =?utf-8?B?Qm1SOGFzR3hBbGpjTUNnK2djUTlpQkxITTU3ZXI3ZmthZHVVT2VlckZoYmhX?=
 =?utf-8?B?dDY2QVlPWHJpaDlwTUxranRhZ1NiZWE3NFIrUkZGNHpJaWFRUkJ2UWl0Z0tq?=
 =?utf-8?B?cWRtVW5GaXRsTEJ5M1JlNGlDSllFNWZhcTFpWnUzZ1F3amRlQWJQMVQ4ckw2?=
 =?utf-8?B?RlBnZjI0MUU0dnJEMHBUcmdFMldUS2RhYmpCdFVXejJuQkg4UVB5Y0ovZnhW?=
 =?utf-8?B?ZW1iVVdsV0VKcUxrZFFSZnZLVGlKYU5rTUhWVUJES1RHaC9LNkdCWGhtbUxZ?=
 =?utf-8?B?amtRTDJZelFoS2lkb0xvYUYzM1JrL2xYL2Vka3B3UUJSczdkZCsrckNCS0dq?=
 =?utf-8?B?ZGtRbXBPc0JPWWxSUnJuTDJjbllYUVNFaGRsZTREU2k5U0ZYQkt3YUczRU1j?=
 =?utf-8?Q?CB08ROsSvgBqY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTNyMGEybTZnNzU1Q0lmMnJDYnNFTXlxTXphbXgydXNqL3hVQlorL3JQMDhF?=
 =?utf-8?B?VEtsRjV6UCtONkJkeHFrQWFlQ1p3QnlTb2ZqYWIrV2liay9WQmJoRXdNMU0r?=
 =?utf-8?B?Z1V2YzVsMUNpSWlvWWwwQmlWZFVhb0NwdWJUNldSbnJMMHYyQjlKTzRONk9J?=
 =?utf-8?B?V0htaEZ1UE4zSW5qVDNVRDdqcWwyZUpCMWFqT25CSnNvWEhFUW44K2l3R0U2?=
 =?utf-8?B?NS9aSDF4OG9scWlhbzcrbk0wcTFWTmxuN2d3R1k2VzM3cjREOXAxZjdBMUlt?=
 =?utf-8?B?MW1NOVRoS21kV3hQakxLNEZJQm05T3FkYmtjQWdmYnRlN3BZRG8zcXlwQVR3?=
 =?utf-8?B?Z1hnZnNuVm1XSzRRaG05VytUZHhQUEZETnhSaGplTzYvRHF1ODVCRzdxczBX?=
 =?utf-8?B?TmJiWDdBOXpEMnJING14eTFlQXhkRzYzT05rQWpmd0ZOd2k3TC9pYjJaSHhK?=
 =?utf-8?B?d3JYRE1BVWNGay9xKy9yWDN4YzBWNmIxUjM3enNqYnN5L1BSZnpVY0svRlFj?=
 =?utf-8?B?SFJqZm5IVCt6N0ptL0E1aDBmVVZ5VldwMUhIb3V5WHA3bWZqZU9hWEZFUkQz?=
 =?utf-8?B?OGlhZWhNcEhaUnl0V1VLYmVEdGtQd3EyNlNqeU8wdnNGYmFvOGp1WUVsdTBn?=
 =?utf-8?B?dDhXeHg3RHBZNHJLcko4MDVIb0JMN1NXYTQ5SFZQSGZabHZEbTkybys2ZHYz?=
 =?utf-8?B?aW9WVmV1OXN6aTc5QnBOQU1JaklSR0V0Sk8zTWlkRmJtNnAvTXpYZkw3dXhD?=
 =?utf-8?B?aFJxTktMcytqalZxNHI1Qy83MEloOVZvOHNTTEl0RldaYkhxOGgwd1NVOHR1?=
 =?utf-8?B?R05qOXdMWDZRZEVrWE5WNTVna3FMQ1JxcVhCQXB1VmcxYnl5cG5yMVRHS1or?=
 =?utf-8?B?eU4vQXZNSUpSZzFLaE9CSXZ1TmVNb2graVhQWm9FQ2ZScGhHUmFnN3BzR0xx?=
 =?utf-8?B?SUdZRjR2TVBjSEVGMGV3ZHJTb3IwSUlJV2ZjVWVqNkllUXZsMDcwdnZhRlJu?=
 =?utf-8?B?WHBZdkJwQ3QyMjl3R05mU1JqS1VVdGJkNzYxcTBxc045N3hUUGN1QW5BSlY2?=
 =?utf-8?B?K3FIbWhYODZxR3RpTnFDQXphTW03YzVyMGdJYXhpTWtFa2M1SGJpNzVLMEpi?=
 =?utf-8?B?WThnWUdETUNURDlTa2dPaUIyb3dFeHRLQ29Eblk5Z1ZyNVNmeWkrV1pHU05h?=
 =?utf-8?B?NVZwR1M4eVExaUJ6WUVNWk5tT2RGbko0d1JDMGR5MU12ZUZIZmFoMGJTMmsy?=
 =?utf-8?B?U3RKUmc3ZWVwMXBFajMxWEVrckMyVmUyMUJMdTZhVm1HenZFUG12TFZGTEZK?=
 =?utf-8?B?OEMyS2YwclVvb3cvdHAwcUEzTlRSZ012d1FTZzhIYmhKMGNCSGV4MjRqdWx5?=
 =?utf-8?B?QzVhN2VkTG42UGZqbzVWeDErVFZoWnBKL2VxbDlKYnNscHg5bE5pd1d5UXpq?=
 =?utf-8?B?V2w2WTNVREw3RXExeUpyMUl1WXF3c3NUSTRZZThOOS9ycXRyKzJHWWV0N2ht?=
 =?utf-8?B?VzFPejgzN1VlZ1c3UmdLbWo0Qnl1NHdaTW13VmFhbUlML2VUb0l2ZzBYRjQ4?=
 =?utf-8?B?MTQ2SEI3V3ZvelNzcnZrQnFpRlRNZUFycXRMY24vTWhGMlAxdzBKb2E2MmY1?=
 =?utf-8?B?Zk16dmpIT0VYbFRISHVvazFNdGhKUGI0Q1hVYStMUkREY0E5RUlrWUhNNEs5?=
 =?utf-8?B?Tkx6ZWR6cHBLWEtCOVNOYXlxeVp5U2p0ODNxeUhwM0VqTVgxOHlDckI0SjV3?=
 =?utf-8?B?RFFCR3d2enQvVzhyYmdlTzVRUDd3OVJ0SnM1dFBjTWtINmoxa2gwdWxYMGdx?=
 =?utf-8?B?TmJabFZzSTIxaUEvdmIrTGxSWnZVMUh4d0hoaVlrdm44MGJkR3ZvbGZ5aUV4?=
 =?utf-8?B?UGVGcmJHK3c4SzNjcFBxUy9RbnN3cFlSMVNRSEd3VWh0OFV5c2dSbHBnQjA5?=
 =?utf-8?B?VGpobHhjV0ZNSFFUNWt4L2JBTnBwdFNNZHpla1lNQ2twWHRJWGQyMWM3WStW?=
 =?utf-8?B?YVVZbmt3L1c1ajg0bjdYYWhWSU15Uk9JR2hpVlNUeFhvS3k5cUViQVZ6cGRP?=
 =?utf-8?B?NHp6YjNwdVNGL01qaS9Mbmo5N0dRV3dkVkt3T3dwb0U5TGROaWhISklDNEVj?=
 =?utf-8?B?RkxDWFJDb0ZSbTBqZWVLSllkcGlFTnR2Rzdmdnl1c2V3QUVUUjFDN0NJQzlz?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ulr50KtaE/XBtYkQ3p2St55GTMMEp7sADwOGnuUv6F92fVsNq03sJrTBgiPdskh9DXRQI7wwd9qRr/uWw5N1iBVnbPV77n3/zlpBWFx4fqVsKFMrqqY87J//tsp9WfEu5Q+9zfQYla8YIE3KWlD+JipTNXMP2oXZzq91yCxSX/NecvE3tqZcT+3YDwkftVXzN2ZaCkMFCNOIVGNg69+lvEkMqUr5xkLxw6SvpYJoATqOSQ6qDM5maN4q6fmIf9Juqn6Xn4UU7cxDyhWcbWdZiKFlu0lqFPnmypTdGWC6qPaBFGZxvr/2p0w4T3LZVBKM9GsE3EQFhmcf6qv3ff6Xurnv6oP6/owPWHE2RGYX4rlJQZ6nBbTefdvW1yppl+udzcOV83n2qyKOxyyRk+vDpALyJhuG0eFIB4amX14T4HyGbjbChnp43RYh+DT5u632x7qxKojg5TOy+a1e/PW/GgOPBW3peJJpH7ywkftOUVSK04tZfoSMKmJR3XXs3M24RJqZRsE6Jt2RBYfsWlzwI3U24SjdjD6JMcVcnoK0q+BkBaPPbWpUdBQCALG79z519T6WrKV/f2KN71PVCK6HIoZBGY0WYlPa1g3WXJqqvO8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d68a0c-a7a5-474b-29e0-08dd75edc8da
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 16:03:49.5706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yRng1czrmv258hPF/CXFFhXgyztyr/0fxGoY6vg6bSQ4ebUgf49v+28UJ/x4I00+5z0f5oIa1xnkZf+hZOy+tX2BhqnftW8/CaCyE0JCvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504070112
X-Proofpoint-ORIG-GUID: BJGfGCAZ_lV3C0QLfJbctikUt2woeiYE
X-Proofpoint-GUID: BJGfGCAZ_lV3C0QLfJbctikUt2woeiYE

On 3/28/25 5:02 AM, Cindy Lu wrote:
> +static int vhost_kthread_worker_create(struct vhost_worker *worker,
> +				       struct vhost_dev *dev, const char *name)
> +{
> +	struct task_struct *task;
> +	u32 id;
> +	int ret;
> +
> +	task = kthread_create(vhost_run_work_kthread_list, worker, "%s", name);
> +	if (IS_ERR(task))
> +		return PTR_ERR(task);
> +
> +	worker->kthread_task = task;
> +	wake_up_process(task);
> +	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
> +	if (ret < 0)
> +		goto stop_worker;
> +
> +	ret = vhost_attach_task_to_cgroups(worker);
> +	if (ret)

If you go to stop_worker here, it will leave the worker in the xa above. I
think you need another goto to unwind that.

> +		goto stop_worker;
> +
> +	worker->id = id;
> +	return 0;
> +
> +stop_worker:
> +	vhost_kthread_do_stop(worker);
> +	return ret;
> +}
> +

