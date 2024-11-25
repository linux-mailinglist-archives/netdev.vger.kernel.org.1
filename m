Return-Path: <netdev+bounces-147241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB8B9D8925
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 16:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A398B1614CB
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1BF1AF0D5;
	Mon, 25 Nov 2024 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j1rHsJUT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wIeqIAuG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59D1AF0B6;
	Mon, 25 Nov 2024 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548167; cv=fail; b=Z2wgszXw7VWW1HA045/xj5djE0DgNqyIhkq+lEvJykwab4oMdFNRwBU6A2B7Ac98rTSonYCV2FqXBVLg1U0LbSfkzeK06tTCLIidErb47f0fwFQxDzeE3Jv/GdRwhP0v7k9qgMKYh4cukWaLaS1z4pnRZxifLXm0cg36fY8iamE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548167; c=relaxed/simple;
	bh=4Ukr3DaHyP1YsNoCxNMy2AEEjmVXJwTGzjWiqoeZlGc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XrB+PniG24lmHXrQ+Jhvf+Ejj8h1ZB9vI1jInVX65luVIpr8pcn33+DR3K3Oa4Nv1z+OUSG0BnCVFx2/5xdGg09qadWl96QMbxDkk5WmS7oPuHW/0BQfC5w7t2ZgoC1KgaN9v7L3TdtxbSHfIjMllLWyYla/xfPwjY1ooUul5iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j1rHsJUT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wIeqIAuG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP6fdRm006740;
	Mon, 25 Nov 2024 15:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9WDCps5AmaZ2L9wRYM2VTnQFAQEYbglS6nUWUdtAnhQ=; b=
	j1rHsJUTkHCW9TQ3sIYlO7AcHqIcrIBOxB7HZQbC0VuMpO2azeU2sp4s2dhGVE+u
	dQbzsvNKaJlGcrhAX1hSnDK6PKZnvhaJsz9xEKaa/ShMXzjZ/glkFJbvkl5pgfT3
	Mppn/hMx8+e4ymkqmZwL+T3R8reH3twDzXLaguNWiC+mPngVeIDPrmh3P8r7Ij49
	6goLrQcOAApLIXRrSVJS064KgYAHb+HsSO6YwBNpPqtjgp0ukDQwOpvm/LnAeWwp
	P7VA17iPQbaqlk3UGKfIkTLeHrpYjtbCZHaS3poHkD98bK+xfKTpwn2pwTNEYIA8
	HQBbUeJj97sXir2ineKJLw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43384auc06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 15:22:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4APEkp0Q002638;
	Mon, 25 Nov 2024 15:22:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4335g7vkj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 15:22:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBOKuprmDttUAiR7fwhhka6a5k15JGm9L6tEj4LyMkzHH/WFO0VJs2kg2tUppqHsvqzT+mRSm1SUZEFNtCHaFee9wu6w/x+9RZPsopFUoaI1XM0xswsU/yQDGZmWLo8RRuAMMAFj0aY2Roj1y3wJ/jBTu5HheTbdZlUCKm8Joaz8idIoD8fcDlBiUUG9BadrSe0cIG8yg1a9AvcY81tKtx8674+npvWMvEWqpKksrYqGPKofksElBXvOs4yA0qJ6fKd46aA/Z9ICFoiz7dquRDdr8Ky3gqaGnuufKV98n3KiRt12x7jpJwCy8IAA98X6p3PumShXX/rMRhUwwEC0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WDCps5AmaZ2L9wRYM2VTnQFAQEYbglS6nUWUdtAnhQ=;
 b=Z2Sb+LeVfPKf11ORYzPrpJkTvnHzycnyz4VRA8u+wdP/izWjN3Z6+YpgJFsMaoVZKqhAknT52ut+Pgzn2CidZHokZD/VfqDlnVFEo+y6gZGHIXiS4Z2j1GMB5MfJnJ2/+JlwGuvZJ8MwZe7VkBxbJaJF/CeB+SP7/7OJlaBTOGrdisU5XcLUn0DHN64g79C/3yWgr635M4JdFp929H3Q9AuBx+xpdgnZ6DcY7xG3LMEDbDcjgKsTyGzpK3PVup1AUpAxo+L8jUh97u+d0sYuKzxd32gLudBaNW7DzJv+EHyH8gU+Hv4wHcGKD+BLUBAA/N6UNuwUuv6tkpjxHZFtwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WDCps5AmaZ2L9wRYM2VTnQFAQEYbglS6nUWUdtAnhQ=;
 b=wIeqIAuGYiUtLljIf5UGqYwW64g72z/NFP+XpQfz64QiuDAUInm3JnWxN95On+MYzc/kcK5tjYq5U6z3EWFB1vPkO2c2QWz0v3fUpjNdHMkzx0AJ2SOtFMe33xdkIImnUC8mZG+Q3QQLwnciTUzbk0YgHvJn8HJDpWeaGmTOmzM=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH7PR10MB7106.namprd10.prod.outlook.com (2603:10b6:510:268::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 15:22:38 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%5]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 15:22:38 +0000
Message-ID: <c6975912-4205-4c75-976a-f68dd6dcaf1c@oracle.com>
Date: Mon, 25 Nov 2024 09:22:30 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] vhost: Add the cgroup related function
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20241105072642.898710-1-lulu@redhat.com>
 <20241105072642.898710-4-lulu@redhat.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20241105072642.898710-4-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0057.namprd14.prod.outlook.com
 (2603:10b6:610:56::37) To IA0PR10MB7255.namprd10.prod.outlook.com
 (2603:10b6:208:40c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH7PR10MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: d07d9288-b10d-4369-2ced-08dd0d64fe20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWZMWVpSY3pwZVBBOWxkc3djVXF4cEFtTFJmVDNMSUhXWEM0K0xoTzhlY3pj?=
 =?utf-8?B?QXlBRWp4Zm1NZGJmQW5kWXpQZVR2L0hnVk9semF2UUtOQ0tWNXNPdDVrajd3?=
 =?utf-8?B?aXlOc1pxbmIyVm1FdENOdDdsQm9xMm1LMjBxS1VUWHRmRkwya2ptTVgxNEEy?=
 =?utf-8?B?RXdkOWFxV0VXc2JjRDBVcXgxZmVBNEpxWTFhSk9OR1FJaFp1dmZDZXVIMnpt?=
 =?utf-8?B?dDR1TzhoWTBTVmtFY0VmcUhyODBsUjlXVkI3TTNCWjhCOFZTWW1RNXViSm1p?=
 =?utf-8?B?UDRHMEtUMEZBWXZoZGdqUmorcnB6K2M1clYyd1BDcWpjMk9vRm5oV21wVEQ2?=
 =?utf-8?B?UmxpM2tMTUlZQnFFTUp4SHRxbFRHakVWeDd0QmJSUnNUV1EreThlU0sxRjUw?=
 =?utf-8?B?NWFRZ1RyRkRIWFJOMjViR0N6UnBLNmtDcGdwYU53U3YvVERaNWc2cVJiY1BX?=
 =?utf-8?B?V0NCQnNRRVpwWnF4ekxLVWkvb0krUkkyYXpxRnhOaXYrdHVTT1ZKRTJrdVVp?=
 =?utf-8?B?UjJkSnl2a0xOcVdDaFYzV2s3ZU1Sd1FkNk80ZlFHY005TTBraUhyRG5MeXZH?=
 =?utf-8?B?bnNZeGYxNDNmYWUxMGtZdXJxVy84cm81MkoxRXNxNXVVWXZhampFdGs1SUZs?=
 =?utf-8?B?ZUNhMVpacVFLeWswbUgvaE50KzZlNDlJYktwa2g4UGpDelNpWFZ5Zjh6RHFv?=
 =?utf-8?B?R2pEOSttZVZ5VS9DbGNDeW1yc2VremtNNkdoNkV3NWNsK2NxOEtMa0xkdUZS?=
 =?utf-8?B?TWIzRWRXb1R5WkRZdmNoNTBobnpBaGJaZE5jRUJ6YkpLcTE4a2RGekZZT0Y2?=
 =?utf-8?B?YU9KUUdGSHZHRVBRWSs4THR5dE1kYXduekNCZjE5WkIyeTVXbzFYcUhjYnE4?=
 =?utf-8?B?ekowV3lmYmZMb3NuazMrSHNoUk9JV2ZJNFY3SVFwdlIyV0ZtSGg0TEJLMnFR?=
 =?utf-8?B?VzdMOGM0QnJLK3NCY1A3TDNZMlJ4MWplVmNLcDRzWFpzaGs4d0RWWnpsTGRj?=
 =?utf-8?B?cmNOZE9EVmV5b2ZqWWM1ZUtSNXNvdm1LSkQ2d0xyTlk1U0tmRzE3SFordmlY?=
 =?utf-8?B?aVU5cUJDSGxwRGNXeDdneGFPbVpWZmVjVklSTnlQZTR1Z3VuWEsvbUdoVGEr?=
 =?utf-8?B?SW9vaXRXL1FQak5oMDFzNHlnUXgrbzNxNlVhUmpvMnV6UWRLVlRiQVV5QmJ2?=
 =?utf-8?B?RnRYWkVsWkU3aE5sa2p5MHljQ2p4VzJFWVA2Sk9ybVBnTzNkaE1MK0VzV2hM?=
 =?utf-8?B?bnVQRzc0Z2MzblpWRk1YRFRqM3RnT0phQTZkdm82RFpkRVpuY3MvWVVFZDdI?=
 =?utf-8?B?M0kvb3NWaGo4cXVJYmU5dTF1QmRKOExQeEl6WXFnY2tGamVCcG5kMHdCRnZN?=
 =?utf-8?B?Q2EvczdFSnV1TWU1Ujl5WkpIdldnS3VRcXRRUkZjRVN5dlBuS3piNjJCUmxr?=
 =?utf-8?B?T3cwYlEwMEdPdEUyTkpCUzJpbnFjbEdHYkJOMEg4eC9hOEQ2NGNEMzl0RkhN?=
 =?utf-8?B?d2wwZEZZamQ4VXhsRWpCVFZUV3ZpMzZqenIwelNnWjZCUGVvalhZeU9WRkhp?=
 =?utf-8?B?ODdvTFMzSlJWL1pycG1EWk1oSm9vWU5xbHVoVkZ6dkM3ZEZKU0JjQjRUaVhx?=
 =?utf-8?B?SG4xdU5WbHdzalVwd1JCd0Y2ZHl0bVZyMWRUT2hmd0dCN21HZSsyK3l1M2Vi?=
 =?utf-8?B?OTZHbnZrQ04zZXZwaEdBdGpKdEJsZzJBdUp1djloN3l2SUphU1pCR2xjeU9L?=
 =?utf-8?B?UDdKR2lJZUxIeUNpMGlXTmJNdU4rMDJmNEdaV2x6SWppZk1oN0xwVmVzaVVN?=
 =?utf-8?B?V0NGcjZCWVJIUXNHc05Tdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0IrWUxuMmhoeWhtNG9zYlZXbU9mM2RLNHRtRWt5U3Juais3cHM0emNvNXli?=
 =?utf-8?B?VE5yM3lRSjZwTnRUZEd4MWRqWW8vUHFiU014dkY2NjJaaUhUNzBNWTNxeitm?=
 =?utf-8?B?eFFTdWFpM0I2UUZrRGg2aGlRa01oY1N5N2VRcDlLTitzMzhxcFk1ZUtIUTVk?=
 =?utf-8?B?S1d4Z2JLYU1EL3pkemxjbWZLek1sSGJFUm9IakUzanVvNk51WUc0ZDgxd1cw?=
 =?utf-8?B?WjFNcHJZL2g0aWhsS1hGMWlGRnY0aG1kVDZvQWpGUksycFVJa1RoUUZpRzh5?=
 =?utf-8?B?dStqb1pJeFQ0WG1jdUdaZGtKNlZEZTlKVGFQZjRBdnRTY1Y4andwcFRwZStF?=
 =?utf-8?B?VWV2WTlNcjZJVTJTR2taVDdFRi9CTzBlNDlNVTAyY1htWTZtTE0ybW1uWG1q?=
 =?utf-8?B?SGk2eTdra05DNjlZS1pRNSt1VExzckw2TTZEK2cwV3VxbVFtUXRyc0czbnVw?=
 =?utf-8?B?UkFKK1o2YkdvTVh6Q1ZTaStxbjBmTVZBYWh6RS90bjhBQWVGYzhSeHQxUWFL?=
 =?utf-8?B?cHJMQnhwVk5ncGFLUDlxZ05LZXQ4Q0RzVTAzeWtJb1phcFgyeDIvS1RibjVw?=
 =?utf-8?B?QkQzY2xnWWRuekJkYmpNRGJLMUZ2VFp2OGFCSHNvSnNLdFNWY2dpMWlFTnNl?=
 =?utf-8?B?NHNIa3FoYW01emN1MUxMajdXcnUyamx1V2JUQkRMYURIQ3poSG1HVVU3Tkhw?=
 =?utf-8?B?VDVjTzZIMytnTHkzY05PSkRFYlowMmlhOGpvZUcxcGkvMUd1dzhJc3I1YVlh?=
 =?utf-8?B?OEcxaDdRNUxoQmNhNVY1WTJQT2R4R29meVFOV2VncDZoOE9WN3hTNzRjd2Yr?=
 =?utf-8?B?dlFKRGtHRzJDOW82NlhnS0pZSCt0Q1pmT3dscGV3TU9La2ZvRXdUL05udmY4?=
 =?utf-8?B?VVk0WlhYNHlISTRQY2ZrdFFaMkJaTVYyajgzTEZGbEFnbEVrY05CazlZckZm?=
 =?utf-8?B?R0VaOXJFRFJtVXpLWHlwdWtCcTRLVUJQbCtIM3FEQ3hhZStMZmdTeHl0cXZE?=
 =?utf-8?B?aXExQlZJam5tNUhnb3N0NTJ0WGFnWFVUcy9pUEh0enAzUHB0RlJ1NmllbndT?=
 =?utf-8?B?WDFOb0FQN0UvT0hocDJyOWNLbEpIOUdtd2pVMXJMblB6YTJxZW50REdUZWsx?=
 =?utf-8?B?czgrRFVaRVVIR3lBYlZJSWVOeWVVTEx5V3VkUXhaZVRoV0Jxa3pxT0d5TjdG?=
 =?utf-8?B?bDEzelZoanB5dDJGQnFoa0Z3WVhCZy9nV2hzR2VteEFBSmZTR3BlM0dXNm41?=
 =?utf-8?B?OGgwbFJqb2FvUGdxNndJemU1OVk4UlFQUnpaWThGVW1oSjREeTVGSVBrcFc4?=
 =?utf-8?B?MVYzV2MzYTVnRFZmV0ZkNEF2ZE1OeTNsLzhQN3ZMdE4wMGJ0NG5lMkRsYy9D?=
 =?utf-8?B?N09lNmhjMzg1VmJIL0hVeS9qVmZUalNSMkJvNWpmREFIRUwzQkRKUC9HcDYz?=
 =?utf-8?B?K2M0UlZDK015WXRveXdwNW5GTE9HWDNlQUJWenUvV1o0UWY1ZWRwS1NsbFNU?=
 =?utf-8?B?R2d2ZDllcml2YXFPbXBGZVRQWGR4TWlSL0kwV1gyclYyN1laTENtR0hSQjJT?=
 =?utf-8?B?eEdWSU5tMDNzNDhBVnRMZ2tKU0h4V1BYQ202UmVzTFhhL1ppREZzMHVJS09K?=
 =?utf-8?B?eWhWY0hnc0dycHU3OWh5WUdzb2t4N0hRUjJvUnFPcEYyMGxxLzJVZmZHOTFC?=
 =?utf-8?B?SWw2NFUycDdOLzY4SXJpbkxidjkrcUgwSjRBSEJNR2h6UXNRanJxbHZkQjVj?=
 =?utf-8?B?N2ZVakVZMk1xb0EwT0twR29vcnRCNStGVmZwV0Z6dngyL3JZWXZLVXRqK1Qv?=
 =?utf-8?B?Vm04dUR6WG82RzQ5WlpROXlKS2IzSFhIWW9xRktvWU9NbFR4Qk9qVkRwMFVm?=
 =?utf-8?B?WW52MFBNZ0RFMW12bHN6MUk1aHJPMFFkeVdVcUUvbmJWWnNXU3Z3M3FCcEdJ?=
 =?utf-8?B?a2crK296WG9lSXVOelplRGU1c2F6cUdTcUxGR1ZjMjRIaUpHbVloL3ErTDJa?=
 =?utf-8?B?aFdoa3lMN01FVzB1TjVnVnZIQkZIRzltc2FRbXF3bWtiU3ZjM1NrMVJCOGxF?=
 =?utf-8?B?eUtVU3dCVTkyc3dlRitnSno2WTFtZThlelkvelI0WkpPZEJyenhzNWNuWkls?=
 =?utf-8?B?RUlwdWdnN3dyVXdxZ1pmRlIvV1FzZHRMR2xneCtBVWU2dFZrZzFhZnlKOHY5?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	165VhG9dw9G/ueDZq6BcvdTlWId7lJaogN1D0pFv+Q7L1rKbnULra4kFvt3cTEiajPj1qPHJ0OB895JuT4BY8j48oM7b5rgJxyb20GZdew1lXd+wNWVx4tXHpWWSNy7+RxQSSTYZjM1AqbFEjfLZTy6HWwquZJZchm1V5gNSgoYzjdtKQGdkjiM3Kg214eYLV0dK/HiRBvSMCMEAFJMYNwPGcUhvspTH4G2chtuFD1Sx+T5hYpJMVFJLOyIOcMuNwKUn0Q/WAXnsKFE0ZKTvvF6hzHCLBx5wsvLLThjMmHdLM0Ae46d+s7NQsgkpx9RqOa/ljbL4qW90XWIOlRYUVkSl28X4p5y8T+ofA/aT8f0jiImZ3nojR6huTPtyzIrHnvNVoca+2jNb31hzlRvL4/fsNW5f5lBesmpOZb79a1YjM6H7xl7SjMzBu4DeMQGcIjf+b4Oaq2DzTpKhofvXmFFX/gWUaOyv7nRosZCVak8bAXXzT9VnPqGZT67cg8qluebM6o48MQIxCDHQLlFvU3i8VKZhBmkMcTxlsKIRDeC0rIBfmkCLSFbcXl87thuC3OLTLNnBBOJExpft7TOnkeWwfJ6VNi7tYmYVLc7esNU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07d9288-b10d-4369-2ced-08dd0d64fe20
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7255.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 15:22:37.9930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5OuFw1MBQA8ZKYrZgJXkhTXWstmf6aUya4oqqeFwVvYmMgKYaDc0dAqUn+jIPp6zHVYwltO2AbQg4d6D/Uiz35BY0JTARpd2nU0xfiwG24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-25_10,2024-11-25_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=996
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411250129
X-Proofpoint-ORIG-GUID: Q_FYAQTeXn9CIxzhAKkxpt7mpCwCZ5If
X-Proofpoint-GUID: Q_FYAQTeXn9CIxzhAKkxpt7mpCwCZ5If

On 11/5/24 1:25 AM, Cindy Lu wrote:
> +static int vhost_attach_cgroups(struct vhost_dev *dev)
> +{
> +	struct vhost_worker *worker;
> +	unsigned long i;
> +	int ret;
> +
> +	/*
> +	 * Free the default worker we created and cleanup workers userspace
> +	 * created but couldn't clean up (it forgot or crashed).
> +	 */

I think this comment got added here by accident.

> +
> +	xa_for_each(&dev->worker_xa, i, worker) {
> +		ret = vhost_worker_cgroups_kthread(worker);
> +		if (ret)
> +			return ret;
> +	}
> +	return ret;
> +}
> +
>  /* Caller should have device mutex */
>  bool vhost_dev_has_owner(struct vhost_dev *dev)
>  {


