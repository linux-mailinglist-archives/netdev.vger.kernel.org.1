Return-Path: <netdev+bounces-147238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258649D889F
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 16:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9AFF2845FB
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 15:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85340199EA2;
	Mon, 25 Nov 2024 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BeJtOgrB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qP3bpRFn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AEA17BB35;
	Mon, 25 Nov 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546823; cv=fail; b=WofPWUgeGdl9cH/wCL3IliQ2UizK9e4hXOK0LDwE1KhxH9KgwfQiS76pJydhG+Nyr7STel+wI1OswJWQC2W9JwxWWOyttUu2NOKV6Ze/h+mlrp9CfVVZZoanBJ12j5qg1t+edpKvlUlYfnN72Oum8ZdOnW9ettItYHEnArlN6oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546823; c=relaxed/simple;
	bh=GRdHrDAn6d3uxZHeWwsZtwq4hDnfBcSpokA+oiMzwQ8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nHjC4vNnZXgKE45n2aJbpYNaSmDrPOVzfUWB0qX/72N6XOj0ZQyibtfVw47j8q8Rkdi1OH+rXmlSzPTz+rYH0WwS3OqETrgAoVoXBLIPUF2gODIOa9DBiv2VSIB283RLRy5bJ0s41brsWNXxiRNwBqKDBo/bAdKb0GZACSJaXiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BeJtOgrB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qP3bpRFn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP6fgCA008494;
	Mon, 25 Nov 2024 15:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1FpwPZBVixGb4h/DgGANszrNfiO9XzXM8LLCEy1l8ZY=; b=
	BeJtOgrBMuo1zOhEAd/f2WXHfp9YVCMTitzq26usdsYrB9acjF+Y3reaPgwyP9ns
	QgF3t2FS5OrGv6Hfnw3ThU/LLMvciib4pjl3KXKHbi8zY10boS+OgDldq+9wxxU3
	6t+/VQuj4mm9wGbMvKaaURpTYldIVS/busRgH9L53f2NNpwrUXieesFtNvQAWmvV
	XOnRM3FFg5hFBAbamP5Ve4BrmkuY8xnFgJQUyONZGGxE8muPEuq+0M1IIx0iLX/d
	ATa2mvGugT9mGsZV4nSAEvKX4mLOy4hmeh/7NPuyNnWgonl/9HD9Yb6ratmK8RuI
	5lyiuoaRRdZvXthUEEk3gQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43382kb9m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 15:00:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4APE65Np023673;
	Mon, 25 Nov 2024 15:00:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335g7ma8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 15:00:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzR8XU/QE81SrI1/Tw88WjO7azESsHXsHsLd5FXr8BHmuenVwRsaxEQH9b5oxCQt8vrmNZ1WOP9X1EbOZ2L0wBE33j9D83JJypOfiDZEfMeLvgcQNTCSQxauOuW3iIQQd8s15cwDKNbZou30eDthnCzSOB4PvY19j54hQ69x1/216k8Z8Ni2iuDtoq/1Xshhw/05ztMN4CrXzIGRZnIX38/geDUTnJI8mMGyRn774iAFfS+r//ZfFUraqiDJPjTSlwyQGMGT7/ytrCbLMOEiU2Ie3EanFniltVwwAUeveuY4r/QPXWhpT+zepXEaDWhDFG/fFW2GBEJ/fYvwcw0DTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FpwPZBVixGb4h/DgGANszrNfiO9XzXM8LLCEy1l8ZY=;
 b=N7U7mBHZ3vuAIKXY7x21iynHRb0CGCbAeZYec+Pf0I1s8tMLoQehR+tWT/e6eY7bYCtVsHMH9cFl/slE5dHpHU6wSNLznqG4EGg9vLFNUw0lT0p44KMWXfkYHVl7SqlMh4jf5+h1DZCQ1qLXifXF/l+akU4bWYlRzihjb/vy+DcB2VlTFdgFzFrktb77U/Xnpw7fsL15u4Y4gXXR0tu5/TbHHU0SV3YW6VM0IMDwWPCty3OEBNnxv3K8w7gRikRlwLzDycgvX9McQ7iub6Kjbl/xcvPHuSeECIjpdlQ+LZY42++jY6lg9K/39mBoAK5+HcVbwYiXYECFt+RrtQEOaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FpwPZBVixGb4h/DgGANszrNfiO9XzXM8LLCEy1l8ZY=;
 b=qP3bpRFn8mkrQNzFElz25wez/gY0rWF/ejUQ1Eif0DAbOTvR5bTS5qkjgXPq6/gKXEYVpsgSgTZ9l8e7f7ykS+PZwacLLC/LkjyXtxp7gsEmV0RC7XRAgA7g5X0d0FlNgFUwgakV4Sq6lQJnZywofdhIlfAddfjYlonaBfVOKHE=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CO1PR10MB4675.namprd10.prod.outlook.com (2603:10b6:303:93::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 15:00:09 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%5]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 15:00:09 +0000
Message-ID: <3864ae3b-d6cd-4227-b4bb-56e014c71667@oracle.com>
Date: Mon, 25 Nov 2024 09:00:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] vhost_scsi: Add check for inherit_owner status
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20241105072642.898710-1-lulu@redhat.com>
 <20241105072642.898710-9-lulu@redhat.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20241105072642.898710-9-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::29) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CO1PR10MB4675:EE_
X-MS-Office365-Filtering-Correlation-Id: 98401deb-0eb3-4007-fe6d-08dd0d61dabd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlMvTmZXamFqaVUwcUxzcjZjV0FUWHVCUVhzYXJnZGhuNFFaL3JIZ2lWS0dn?=
 =?utf-8?B?bld2UEV6OUljcXRyekN2VXVMMzBiVTdCZkdSbFB5eVh0ZU1zN1VUb1JJMXdO?=
 =?utf-8?B?eVlvTDQrV2h0LzFnbkZ6UGNIdVc1ekNnYnlyM2p2aWswVTV6S01SZVZ1Rjkw?=
 =?utf-8?B?WEJRdmJwWnZTWisvN3ArVEtueVFqdnFVNDEyYld6OUs1cVhQNnRLYmczQ1Ir?=
 =?utf-8?B?REIwcEpuOFVRdjJwVzJ3dHF2Zyt6dEZ6ZUhQSVlVbWtRemxZN1BLdjV3KzBv?=
 =?utf-8?B?T1lCWVNhL3NHMzQ5aGE0TFZtSVROeEhKcFdZNko5d1dQbHdwMEhOUE44U0xT?=
 =?utf-8?B?TFRyeVA5MmFrbVlBZWF0OWp0Mi9JWFdsSCtvTlBjd2VZdjBWUktPMmtldUM5?=
 =?utf-8?B?YnhpVmdiYVhONWlvSjE3UXNYS2Ztc2tnazM0ZEtSTTNlRTNCSmZ2VEgyTEpy?=
 =?utf-8?B?VW0yeUZaMW9IbWkySUhnUkdKeXhjWkpzTXM4bnJITkwzK1o4MVlFYUs4dWRF?=
 =?utf-8?B?UnVnR2pDMmJMaloxRTd4SUhNZHpHSlZMblNudEJQNDFQdGhQRzZhSlBSZlFI?=
 =?utf-8?B?SmUxVG10Qkx2ZFQ5N0dRYXRDS1VtWDR1MkFpcmRqZkZVR0JFUTdTRFRyRjd0?=
 =?utf-8?B?VXIzVGNleWNGYUc5UWtHekJEOS9Ra2pTRkxINzl6NTVXNmdTYkpyYzFqL1Yv?=
 =?utf-8?B?OUptL0sxemRBMDIyOFNQankxWGg5a3B0RkNlczh1WFRZSFVXZmxUV29sN3Aw?=
 =?utf-8?B?TlUzeFdvdHFoVUdVckNIa29PcEhjQzZ3bllTdjNEemFTSzFoQytmSUN6eDdK?=
 =?utf-8?B?ejdjaFUwSlVhY2MzTzhyZDZ0K1lSQmZWT1ZJWWlXNU16Z3pTNVhlOTk0ejFW?=
 =?utf-8?B?TFNjOGRDcGdGaEdKbGJGQ2NwL0dPUzA5NFR1MUpvWlJXZ3dkelhodThPc0VV?=
 =?utf-8?B?cXNNUDVnVk1pQ0RWTGRSUzVqSTZ2RFdraUdRekJoUHVtQTk2VlR0ejRLV2Ex?=
 =?utf-8?B?RnRUM3RSRGhWY2o2bFdZQ1Uya25rUUhGdWphVFFMaktJT0Y5cXVlNXhEZ2Uy?=
 =?utf-8?B?ekprQWNVSjFwdEhFL1BOSkdUKythMlJEUFBuMUNMRWM5RUE1Yy9JVzhPNUNs?=
 =?utf-8?B?bXZvdzdBOEg5WkFOcEtzcnZwbTRiOFlDMDFsazI4L0pXak1rbmJpN29qWjVH?=
 =?utf-8?B?YlBOeFU1MnlXajNSdS9sVUxRNXkzMWJGTWg0NmNMUW1UNkpEWU1Qc0ExVndI?=
 =?utf-8?B?K1Rqb2t2LzZQYWg4RUw1SldDVUI4dWI5UmI5TVhlcm40T0k1VHR4dWZrQ3BT?=
 =?utf-8?B?NG5tczVISDFtVjVJNUtRY1BuckptV3VYQnlZbUZacmI4NFhzL0JJTGYvNEw5?=
 =?utf-8?B?amhNdnFFdzQzVmw2bCtCc2lIR2w0aXFWcXgwYks3MVFHVVllVmdJSERhNHdt?=
 =?utf-8?B?aFhjbTllM3ZaQzRMYlNwVm9YSHhIM0ZQWm1IbWlVRnRldHV5OElwWXFvRzJB?=
 =?utf-8?B?MTZvSHdEdXpBZ2xEamppM1lGbUhXMlBCcXlURkxRRlRFNTcybDlnVkJzT2JV?=
 =?utf-8?B?UnVQWTdSOElrNjRqMGxBdklwUzFUOFRHYjVpN2U0dERFb1V6allJdUcvSklU?=
 =?utf-8?B?UEdhRXdHNGRVcE5mSHYzY0tVL3JXS3lwVzBlbWsxbXV4TjFlYzdZNzM3U21G?=
 =?utf-8?B?VVB5ZndDOWRreDdUci8wTWhzSThvUkh0Nm00SXFIOW1WOXVncXdtTy9CeXEx?=
 =?utf-8?B?UXlWVUN5T25vQjZNK09kb1hYemhLcm42V1JXQ0N0aHc5YVhlVHFMQU95enM3?=
 =?utf-8?B?ZWIvZWF6K0Q0djBOVk9pdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEdhektvK0UvTkJhSWdOdStJVU1SSFZCYUVpcUY2TFNSS3EvN01hcDQ0TjdV?=
 =?utf-8?B?V3l4OUo2dmpEZTY0eTRlYk00OFhEc1BMTGpwREExU2xVL0J1elZETkNSWDlz?=
 =?utf-8?B?clJISFZTRkF6RU9Mb25xY04wd3JhRHhLRkdTNXUyT2JDMFhzK1dVQ2UvVytR?=
 =?utf-8?B?a1ErcEI3UWJIci9wU0xmSW91eDRuU3B5cmErbmNOUEpacUc4OHlRdHE4aHBn?=
 =?utf-8?B?cnpxelZ3R0FzZWd4ZVJYUWlvem1hY0gvOUZMQWRwNmdoWmJNL2tTZlJURENJ?=
 =?utf-8?B?eDhjRlhpM1JQT2hTUFY5eFAxdjIzUjBZZTc1Snc3T1dqMUdsT1NSUGhYbC8w?=
 =?utf-8?B?bURESkpoWTNiT2w1SHJvVVFQZEh3VHRPL0hrL1hDUTkzNFNqTDY0cGRSMk4v?=
 =?utf-8?B?Nmc0VUpwM3I3RzVCNklNVUo3WW1MVWZjQnBGdVM2elpwZko2TWs0VVRvMmc0?=
 =?utf-8?B?RGdIODFWTG8yUFgzclFVTVBRWkxwMjB4bXltWWEvckQ4OHdTc00xc29VT21q?=
 =?utf-8?B?RGlibGNEVVRvOHFDOVgraFdzOHB2bVJhUGt2dDgwVCtabUt1SGxKOVc2UW9h?=
 =?utf-8?B?MHYxaXFLSkg4eXBOKzl5WDhRd1lkYnZuMEQ5R3pMaGNwY1BWSERzK0NmdVow?=
 =?utf-8?B?MUYrYjV5N2NteDcvS096TnFPVlZaSXplbEJEQjhsQUVSQm53aDRNZGNLc1Yy?=
 =?utf-8?B?UXlCRzQrcUNkMWw5Wmx3TkdobzhMRjdZYkNRTlBFNDVHYTFlNGkrdW01NE5C?=
 =?utf-8?B?M1pZN2ZLdzJwYzJ2b2J4WGhDMkhwbWJnNnpSRkNaT0NWTzFsSkZhNGd3b2Zy?=
 =?utf-8?B?TE0wMjZFNGtkUENMUWpITDJrbC9rTmtraThYMEdJSmI0akRZZWxDNE12Sk1k?=
 =?utf-8?B?NHg2OEhxRVJqVEVSNVFsY1NYdE9xRGVTYlZJN00vWE9wMzR4d2ZYVjZQdzJy?=
 =?utf-8?B?REZPQW9kbTMrVXI0RHZUd1ZadjZEZFdvRjNLVlVFdVc4dGx1VnNuaVBQZloz?=
 =?utf-8?B?Z1ZHamcvK1phdUJkVmlPVk93Q3FuUktwL3h4aFRSU2RRNVBxaWtkNy9TbGc4?=
 =?utf-8?B?aDQ4K0QrbUtoZ2wwcDRPbFd4Q1BXZitLS21BVzhXY2hNeHNac3RrYlUxZEFN?=
 =?utf-8?B?Mm9JR2NxaTFEMWFBakFha0hvcHI2a2p6RzR4Y01hRkZKSTZTUnNtUDRQcWJj?=
 =?utf-8?B?RUdma0duVmwwUTdzSjJMQklyWXZ3em1EcXJMTG9BK0Q0Mzk1aHBiUmdHckdv?=
 =?utf-8?B?VVFPZGM3OUcrckZ5ZTFXVVRSV1hwQkZQNXRaSzl3cVd3VG9MMHhvaHJoeDU1?=
 =?utf-8?B?b2NwWlFOdHRHRDl0akxMYUFDVXZjVHNTTmRwUStxQ0xud2RNUjVNN1JBaGRO?=
 =?utf-8?B?b3FDM1lSNzFkOENzQ1BzSEFTV29mRnNTOG1oLzhHdFBmTFFvSnMwc0NScjVr?=
 =?utf-8?B?cUJGcElKVEEydUFQYU5iS3BLOGM0RGlZbVZnY1VOekZOc24rUHJSaE5TSlhO?=
 =?utf-8?B?YmNFSHl4a2RpMXRTakJGY1c2OU84NWFMVHlLZExTaUR3bk5ad1VHRUZNOXJP?=
 =?utf-8?B?ZkNjVUxEU2NLeXQydm1zc1NoSWtJZVBtRlZWdlhxV3lrMzl6SGM3V3B2Qm12?=
 =?utf-8?B?V2dXK2Y5bVA2MGsxZmtsS09YZ1N3MVlJWmRJTnczSjRYT3RjQXZ1VGd0Uk5z?=
 =?utf-8?B?TWpJcGZHc0orOGY3UWllOHJsOERvTklMRGpwR0VVYWlYZ2UxTTFoMC9GRXRW?=
 =?utf-8?B?ZUFJTDJaVUk1ZXE5QnAvY0gyTE9mQ0JhZ3RYQjIvZXljakFvTCtyMTlXZWJx?=
 =?utf-8?B?NkZRU3BnRDNXM2wwczROcE9nTEdzU1did1Uya0lwWDVwU1E4WWpPL3Juc2VC?=
 =?utf-8?B?dkxwNERmcHJ2UlBkdS8wQ1B4UlFJVllDUmIxa2xVSVJmbXlsSW16RVZNSG5t?=
 =?utf-8?B?NEU3ZDNMN1cwemM4aGlaQnRiYmxDbUIrRDN0THA0TkI5T0tUdGZqWXMvcFZB?=
 =?utf-8?B?VFBaSGR4MENrY0d1VW5jZnR1YU9WRFFiMld2c25XZEtHdjNGME0xVkkyMVll?=
 =?utf-8?B?TUR2OWN4SXVoODIzc1RTTnEyUFZ0RFZaajROdzc4cVlhM0FHMllLK21SR0Vu?=
 =?utf-8?B?YUx3ZGptbGpNQXpENUVhR09DNVRIZ0trZ3ArZmZCM0VEWGZFWEhqZHFTU2lJ?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pmxrlnsoZBMlHkvoimUGOOs+6VT/5TOf9OcV5M51C/sFz6/LXwurUmAsOmqe/KDjdZQwpH+Y4m7OvscU8S6I2RZG/sP90iujAA/cm51D/7uUX3Vk8e27wLPIpTnNOje9XwXmCqaQArN2JZ+WdeMNfJg3k4x59GWUq/KaZvjhTMWjdX4+RXF5VSRmsA1Khxw2dmYxJNUTqW7IP3Ox6ffXUS+6tH6BF/qOeJ/r96A+vNlXz7sSMIWEXpxlDh+trSgOIUaMdZZPrBEN6a064QITYdH+Pwz2JBWPWNYiVxmKYfs2QT9XJvU4fukNZy0Uka6W4IIcEZP9TftN/04lN1Of9HxZXGKfIm4ojNDPCFrdZGo0fPHGam6QfBHUIycChKvuAZUQnKkmXDUVq2kwmt6Q/cUOAiwVnxgHkOb4PKGkj4MGX3HHxZDir8SLzALSDBf5BqpWEJpMw97pl2X/aFJZ/W7k+I4Lo7uorIS30HiVzQpdRMaZs+iMuvZDBXO7Wd69ZnJnuDYjNEFb1T6x14f1a4f8AgYbJxH3krhXBwpdYcSzcvcfP6q7+U9t/uFP2hpDucfk0ssI9It9eAjXEnWqXjKrFef2Ewjn9YYG0an/23Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98401deb-0eb3-4007-fe6d-08dd0d61dabd
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 15:00:09.1271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivim9ElcYrzg/FjfSgvhky+7KfQ44x8XQvxLl3ox/OGHAMQ8faU6ex+sBZksvYt1IuQmsOYiyuQu8Z7ozSuPzxx4OdJ9Wsv/o9ypMXS7laA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-25_09,2024-11-25_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411250127
X-Proofpoint-ORIG-GUID: jYyexbwp1iFSC3YiKLMtx3k8dfcB_q47
X-Proofpoint-GUID: jYyexbwp1iFSC3YiKLMtx3k8dfcB_q47

On 11/5/24 1:25 AM, Cindy Lu wrote:
> The vhost_scsi VHOST_NEW_WORKER requires the inherit_owner
> setting to be true. So we need to implement a check for this.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/scsi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 006ffacf1c56..05290298b5ab 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -2083,6 +2083,11 @@ vhost_scsi_ioctl(struct file *f,
>  			return -EFAULT;
>  		return vhost_scsi_set_features(vs, features);
>  	case VHOST_NEW_WORKER:
> +		/*vhost-scsi VHOST_NEW_WORKER requires inherit_owner to be true*/

The above comment is not really needed since we know it's
required from the check being added.

If you want to add a comment, I think it should describe why we
require it as that's not obvious from just looking at the check.

So maybe a more useful comment would be:

/*
 * vhost_tasks will account for worker threads under the parent's
 * NPROC value but kthreads do not. To avoid userspace overflowing
 * the system with worker threads inherit_owner must be true.
 */

> +		if (vs->dev.inherit_owner != true)

This check and the comment would apply to all vhost drivers so it
should go in vhost_worker_ioctl's VHOST_NEW_WORKER handling.


> +			return -EFAULT;
> +
> +		fallthrough;
>  	case VHOST_FREE_WORKER:
>  	case VHOST_ATTACH_VRING_WORKER:
>  	case VHOST_GET_VRING_WORKER:


