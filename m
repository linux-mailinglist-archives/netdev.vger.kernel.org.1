Return-Path: <netdev+bounces-119260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609F3954FFE
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181B6283426
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486021C0DD2;
	Fri, 16 Aug 2024 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mCb3tYAP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h59jtI/o"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1FB1C2304
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829331; cv=fail; b=Q/vrmqJUk0HqaLnfZ7/t+Spd8NRpzZxYERm5LPl+TQE6bNE3ewFifJU8oJypE3AvFqt82iXSPDHHq+abTHji5VQHOWLKJuwRHkyAul10gpIZjW0O03L7P8WkQJVla/GgMH1CIvcFCfwyscysAv76nLhLRW3Skf8fsGCOeSWnsOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829331; c=relaxed/simple;
	bh=s2PXyXrfIScqIWJ24OfIwhxbuefmnUCcsTScYSbDE9o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L+Bjbfqjhyy0RsMqalh6DOAsWJDDw3V28VmKgb7K+0KjLPj9y/5IclIhsVe3rCMuPW1u/BIXOYdxjLUd/y5eEf59B6BwkD42oN29Sot988HIodm62mFTOk+i4DF21zbxnNd23YMD/adsobqF1fcBuxMuHHgoj8tdoKCA2vGWsqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mCb3tYAP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h59jtI/o; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GFiSkD014807;
	Fri, 16 Aug 2024 17:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=xQsC/ShocI5s16Hwlfzk15wYWll1Z7LWj06SihNfP+8=; b=
	mCb3tYAPhm1cVhaG9XqHOsyosct+DM5U4vJmGV1oKOpmLhRrWg0G5mF0kFQnogEH
	YDH5EviPzF3cHWcG3q7hqjU+KoY+6vWJqI3qvoLydN/7p+fCs5DmOatKfp1KKqsA
	CTSnXDzjWh/wwXXHkxgwr4q7jUhHTbjgyp2MGr1Rtz84vXK24xzi6c+S4GZMFx5R
	t/3s07McEJ0TXxXjyQk/UuKQ2DvsRFvxxG6u7Qfl6GffJoj4dD/lrU9sRYGFosnh
	ajyFNBzovpm6pZ4MneHidhKEV9oC7AE+QLqcm9FLPINPSj5u0r9GS31DA9D0AzQS
	ho/AvH/LU5pWxHmW4gS3iQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy0356cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 17:28:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47GGVsBP017662;
	Fri, 16 Aug 2024 17:28:46 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxndr77n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 17:28:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaLhCOJfmFPFJNRBs5/IKSnCAj7l01d5z1unC1kous0NB6CXJMarklzw8LxY1xdfjt3EXqGot1vU3jOJQot5oa3suWvAnzT7ucoPkKbrVfVMEpWxybaD56rlk2jPw82/vKkqjKY/41Jx9cpr0CGSqIK426hh51g63u0NQBaY1jWDqRcF3aE5CH9w9zs3Epcv3XOxaHUyBUUCD1//3MKwismjt6oSziJlaeU555OmQJOjqeyhLlp4TDnAmkWPCZnYuBMd8yL/7mhcisGec1q/XDOj0KnYg1E3wdgYEG5GWCNAn4K8LA5U7qgKbxbeK9w+pDUZbAwObRoJHfByvbr2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQsC/ShocI5s16Hwlfzk15wYWll1Z7LWj06SihNfP+8=;
 b=y1T/vfG6VOED08/MGtGhU8n9OhmYHJLQA/zb9fnxO45O6pdclNsd0fcJmkG56GoXTjeJUejA2OBlGgUSIIc4SQeXluqr/pgUE1TYx57UBmxRUCqXxdDzutw8G9OFZis1fb+zpyiHP7JbpJUHbea0xYjJ5A4UCT9MKIa7wJ3a/wObL8LrsSrI7O5lk27U2PAuUU3xow8Kh3JFnmp+2hLyQ32IRsr3uboVEgKBmLLvd2fiqXrsS95Ee/+lab75/QIgaX4aQlLvYqOZXvpsyfkIGiJnH5tFGZxzyApEkfz4bIpuxtT9wweEQhsNiedoP3qtwgStylqnc7Yc+Jzi4a6Weg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQsC/ShocI5s16Hwlfzk15wYWll1Z7LWj06SihNfP+8=;
 b=h59jtI/oNKDIul3iddahV/zkWOtao1r6wl7clPmZ4Sg611g1oQc24wBenLGiiPVbSt2bYzEX4pMFbzHJEnZdHEq36Mv5nM9XU2YAQApvm2452+2wja3xZBc1j/UzPeeohBFEKke8jGSH0Qax9n2hEz6UbGUdNjFnLzCoazyy95I=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by CY5PR10MB6214.namprd10.prod.outlook.com (2603:10b6:930:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Fri, 16 Aug
 2024 17:28:43 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%7]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 17:28:43 +0000
Message-ID: <07256914-a5c7-4aee-9880-6066c7dcceb0@oracle.com>
Date: Fri, 16 Aug 2024 10:28:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] af_unix: Add OOB support
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: netdev@vger.kernel.org
References: <44c91443-3ac0-4e67-8a56-57ae9e21d7db@stanley.mountain>
 <6c3c2b2e-4fd4-498c-8347-1a82b0b770a6@oracle.com>
 <883c86d2-49b0-4d5e-a360-286865890180@stanley.mountain>
Content-Language: en-US
From: Rao Shoaib <rao.shoaib@oracle.com>
In-Reply-To: <883c86d2-49b0-4d5e-a360-286865890180@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0008.namprd22.prod.outlook.com
 (2603:10b6:208:238::13) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|CY5PR10MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: bee67e91-2784-42f6-0d49-08dcbe18e09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MExiUkkwa1FhRmUrYmVPeUVtdU1hSVVPUkN4L1JOWnRxVmVoMlVWdGtaUnEx?=
 =?utf-8?B?cFYydStOSVRhQWQrTG5UeWZZT0wvNGJRaVZMdEQyUFYwMFJPSlJFcGNZZDl4?=
 =?utf-8?B?VjgzdUtkL2JzSnl0SHYyOE1FdFJMQnl4RGF4T01pV1JERlpxdzFiNVd4N3ZQ?=
 =?utf-8?B?UVhVK0FKSHM2dmxyNXVPYzhJSkM5YmRKeU9Pcmc2WXdBM2xpMEliZXNpVENQ?=
 =?utf-8?B?UXdvUTRyS01ydlpNRkkrMWtGaTFBenBNTmNUV3N6cXp4OXlnMDFIK01qRTZZ?=
 =?utf-8?B?Yzc0c3ZzU3I0OHdLVUJtdDN2bTN1Z0RjRzl4RHZ2SWJSa2paZzkrbnpIY0Yy?=
 =?utf-8?B?LzU1dUtiRmhjK1k1Z0N5Q0cvanRlYUdGSU1rNnE5NlZEL3ozMHdwSjJuamp3?=
 =?utf-8?B?WWRxWGcvUHZ5Y3FDSDlic003dWFnRjJzMFRxVjR5TkdHUUpLUG1DbHVmbzFm?=
 =?utf-8?B?OWJjS3lpeGlwZW8zNnhTMlBDN09ycGN4ZW4weGM2dGdIU1BsZ01wUHJWa1Mr?=
 =?utf-8?B?UWRjdmJwUmpkZGR0Y2ZRNmUyUVM2K3FxcW9aZ2NmMlUwWWFJb2hOOEtOUTd3?=
 =?utf-8?B?T1pIZnpzRmN6TExob2tGTEpIS2IvZnpmcEk3ZjJVTG9VQW9lblhpY0pFS3g1?=
 =?utf-8?B?M0R2UXFLM0s5akdRU1d6bXBTeFhuVXpLeEdMczAvNHFMdmtES0NtQ1l1M3l1?=
 =?utf-8?B?b1Y0bW1tU3laWm41L3JCcEt5UCtZaDJrU3hlSGp4eDRXUkhxT2tPRFRTZ1Vk?=
 =?utf-8?B?UldtRlE0M1hyS25CZG1pUkQzWE1ZRk9YN3ViM0FNMEp4M2p0SXZ3UGdvaDVN?=
 =?utf-8?B?QnNjbWlGc0p2NDEzTVNRSllaaUNGdHNGS3NreTUxaGJJY3JkOFNtVDlEZExM?=
 =?utf-8?B?MWtNYjJoOFl6OFhYVTNmWVpGTjJaeHNubGppR2pIRTgwVEczVVROMGc0YUwr?=
 =?utf-8?B?Qi9oVThFUjhnNGt2cmU3OWpvem1qaVdwb3lpQXdWUGZaZTJnVmhHOWYreVZD?=
 =?utf-8?B?UmFTbmFOZWhjYmFQWkpSSEtGSERUYldmOW9oQ1lrUVN0THBXWTFTWFA1c25n?=
 =?utf-8?B?a3N6NTlSczFVWllTZ2FyVHNGb3dqTmU1b09GbDBzdkl0ZndYN2VPZ3VtTEky?=
 =?utf-8?B?S3Z6VWJJOTkraVVsZ3NlclUwcUxUNmpwRFdERnhaMm52eXV2SXhmSWw5anpv?=
 =?utf-8?B?eXdvQ0tvQStReWx3TWdDQUYvcmdVL1VCZGdESEFNSHBLc2QwOTlabm1SREpR?=
 =?utf-8?B?TkFJUXp6V0ZseTNldnNOWlhQc2dyZ3dsb01zSFpUQjZQVzVIVEVmMEYvTVpR?=
 =?utf-8?B?R1FUR1NJUXE5RWh2eHNWMXAvcU4wTi9jMTVXR2ZoZk5oY3J2eHgrZnFrTFFO?=
 =?utf-8?B?TzdXNjd1UGZlUDg2TjhPM0o4RU1kaWN3a0wzWklkczFZeG8zVm5UanJrN0N6?=
 =?utf-8?B?ajJSSDM5dXh2M1hHMVNTa0p4SXpOcFJ3bkN3dkU0STc5Z1RqZW56clZXdm9m?=
 =?utf-8?B?TWlYTmJSVnd2eUR2eFpDTzYvNUtvZzNXVnF5WnkrL25USnZhWFhheDVGVmV1?=
 =?utf-8?B?NUZmTFdRSEtMc29iSWlvaTZYUFZFeHJzZi9CQVRsU0FOQy82Y0pOK20xOVNr?=
 =?utf-8?B?VHBjeHdFdWRGOFUzdFZJOGtES2dZZnBYMjJrNm5SOGRsS2NseGdBZm1Vb2Uz?=
 =?utf-8?B?ZWhiY0hDa2tnTVo0NkxybWpESUlSOWh3bVpyVHQwV2xIaXRhTkMrMVFobHhh?=
 =?utf-8?B?T3ZLZ0hRRkFZYWlUaEE5M1MrcWUrejB6cUdUdnhOWkNaQ3RiMjRkNm92aEFo?=
 =?utf-8?B?cWVycmFwZmx5K3FJSW5Idz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWoza1hqWWdLTjNkcjdMMXV0MlZneHZmbkY2OGZRSDdjdjlBNWZuR0xBS3Y4?=
 =?utf-8?B?R0ZOMEhubHR3ZWNKVTlzeUczMVVuQXJMTkNtMFdVU3o1NnRXOEFCUTBWVER4?=
 =?utf-8?B?RDNqeG10RGpoRnYxTEVLUTZldjlZUWFOcGZLR2lpc0JESSs2dXFPdHN5dWo4?=
 =?utf-8?B?VjBRaUVmWUdad2wwSVJ3MWJ0RnJNaHFwVnFHcFJTcDA1R1VWRndyZnQrYzRo?=
 =?utf-8?B?dytoZTBDNGkvOGJucTJYUG9KSGhaOVJVSEtmL3V6L0xrYklyL0ZkNStKMXJ3?=
 =?utf-8?B?RlZKUTh1dFNTditta3hvTVlEVWYwNkVVVVROMlF0N2xzR1V1cVJsRzdWR0xL?=
 =?utf-8?B?OG5vY2hYQUd3d2VQVVNEdG16ZHdhTTY3eXR3dWw0RWE5VGMraVFLVENXVzhO?=
 =?utf-8?B?TC9rd3JLVjdkRWJxS25nWW1meUhPelRmZjd2blZWRkNDL0pJV3hUL1FPMUlM?=
 =?utf-8?B?ckU3UnVwcTdVVGo4Z0ZYVTZha1drS1hHSVArZVIrMDczM1V6UXFBenlkL2dK?=
 =?utf-8?B?QkhIaW5qTUhvb1BBK0ZKNWdtZ1dxeGYzMi9GcEtJYXY2RytqdStNY3QxenZu?=
 =?utf-8?B?Zmo5OCtDWEtWY2lHZjR1ZEMwTGczQWR6dTNrNEFmSWRiWmE1cGpVVWpvR0Fs?=
 =?utf-8?B?N0dFNXErQy9NZDVJZUlidTB4WnJNWSt5YUtGK1BhckxxVGJ1bE40NFpBQWEz?=
 =?utf-8?B?c2VpdVpSQWNlOXdRUXgwY1pIeEI4cUhvb3lNeVh2aldsb3lTZjV2bWVKV1pv?=
 =?utf-8?B?akVpTGNXb2s3dGxFWXJydEtSQTByN2p2UjhHZkpXUk5HdWN1ellzeGZ0QWR6?=
 =?utf-8?B?VW81M0lxTmI0NU9yRHNycU4xbENxTWZXZXdueFZpbnBKYjN3QmNXbnpudXQx?=
 =?utf-8?B?ZnZuRDErREZ6VzFqYVpXcEsrVVdNZU5XWmpCYm55a1RUMm5WRTVwcDZnWjdD?=
 =?utf-8?B?b2MwNHpBb3ZOSTlhTld0ZVlyWUc0SzlQUGFBaVFHNkx2U0F1dk5qWDh3MnlR?=
 =?utf-8?B?dXBqcDk2RGpJblZBNTJrSWVPT1hDd3c4aGFyOUtjMnNSSHpDQU1DVE1Hd0pR?=
 =?utf-8?B?b0hnbGlPazdKWDJXK1lHaXJQV1BucDlpNHhKOVBLelRMMkVHaldZeDFIM2R1?=
 =?utf-8?B?ZVdKdmRJLzZ3MS9LdzJuNkZwMUNvdUR1c1JNN0ZTWHgyMmErdXZTZ3lpZWpQ?=
 =?utf-8?B?V2VwSFp6SElvSmZ4OVB1Q2dtbGVoaVFLRE5LL3paL0ZxNS9QRVZ4cWJKQytW?=
 =?utf-8?B?eTVzZy9IQkhzbXR0VGtpVVhaQWlzdllheVhvL1pYcWpKSDFiN1FRa3RXVUR2?=
 =?utf-8?B?cEhnRXI4QzZCbkw3SG5VOGdwRzFNYUlrL3NwanJLVjV4cmJaamdENFRubmFy?=
 =?utf-8?B?SExrMXZtcnRZNVE4Q1pCZEFjaWZMS2lRMWtzNWFtODhrU1ZpaW41VEg1elJa?=
 =?utf-8?B?RXY3TG9yc2x4RFFBVlZNOWtRSFQ4djlRbnJRMmNKTDRubzNVeHJiSDVzdHM2?=
 =?utf-8?B?SHp6N3NJUEdxQVJvWlNGK0FpbXZxZDQ5N2doOWozTUgxQkZjNDlJbDZ1ajJG?=
 =?utf-8?B?bk1uK0kxWmJHVFc0ZEF0aE1jUFFudDZ3bW9tVFAydkE3Y2lsR1U3bEwzUmdJ?=
 =?utf-8?B?TXpVckZoeG1hRERudGZtSVhybTlNTnlKZW9ILzZPUEF4b1BDRUR1Mk91QVpy?=
 =?utf-8?B?dDRWc1VKMkZDeDFrN01SUUpCazgwME5IbzNkSTArdVRBUWFXa3NHVEZLc0dp?=
 =?utf-8?B?SHpIc0NhVE5CSEc4VmFRUzMxNHBhbGdwNW9LeERha1ZHQllMTUxlYWI5Uys4?=
 =?utf-8?B?SmE0c1hwVi8wS2xWNHZFQ3lrbDdLb0wxSjZYVU5Yb2NMdUZuM0xCbzlrZDBr?=
 =?utf-8?B?TFhXMHhlVDN3WFZaK0l4MGtQdTh2UkxNN0l1T1FDQ3JBMERPeGt3NTVyYVN3?=
 =?utf-8?B?eVZQMlZEeGtPejVwLzhXYU9EaDNjVTkzL3lTYlBkeWVUN2pJbWZxUmhHRGkv?=
 =?utf-8?B?TjlMY05MRVNRajZRRHJsWjVHT1dWMkRoZUc1SW9BQytLQTJ6SjNldVo4VjBw?=
 =?utf-8?B?REQzd0Y4SGpWL0IrMnpTWHoreGllUmk0MVJ3THE5TEF4d3dQUVA5eE9PNGlm?=
 =?utf-8?Q?BjHalZQ/is/Zx0kYSO3Vm1uNe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DFv040ZG4uImfdr0nqDw1+47n7oT15w6RQxwhxdiVQW/lByus8Eys0d4MCeAvBOyYKySqB1FhVHay3DwWkf2ATqKVTxhC9HXHYDhcdMMYWVdMIgHz21VZbgpT+ZdQiqakAkzU9yZFIfvZLu27Ta2FfjNM+xeHk4jxFABofNo1uHBmzaRw8UmOrCcSOOEpJ35OVNRNvVBJ+p/0v+lULVf1d+Kv3jVhOIlEi/bW6DLS+c45TdSBvQi5p3r507YFufi0WQ7ZVW0fhm8tjxzbYAwnuffAp4zVH1TnWpQuvx95bGIRLZ6BmOlxwU1IjQnB+rTooMYtkeOVJ7P54nK+KT6LLS/SzYs/dS1oHBaBILW51KwhmtyCmFuvpNNGu8bpIHaYy8y6tF2+5/P1uGTk5F1oy0ZVC2/tr0GLqZeTagTAyRmhE+YQe3S+UaFq1XmGIzfIAxLsoMXdXS2acZqftOjNap57uR0pDXXqXJQ7gDInGUaV7T5XXxzcAwj76IKQeLaVKGWBnBIIDfb6FI2A6JQbolI1GCYrh3vsKvt4qGb6aV4HijtDu2JQYdwdaI55F00fgulTATd+oQ/V17GuzfDUG4v4fXPQ0Yzm2jJ2gw3oGQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee67e91-2784-42f6-0d49-08dcbe18e09b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 17:28:43.7741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewS/siZ5FEArXv380bx24rY4MaqPNGsuiSnfFMKoCFAllTiTeRVsXGsMiq692vEaOYUXcWWT0jPbMsdgE7VsYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_12,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408160123
X-Proofpoint-GUID: hO_wMwozlkGl9-Op_L-EBTYHxw-L8Lgs
X-Proofpoint-ORIG-GUID: hO_wMwozlkGl9-Op_L-EBTYHxw-L8Lgs



On 8/16/24 10:10, Dan Carpenter wrote:
> On Fri, Aug 16, 2024 at 09:50:56AM -0700, Rao Shoaib wrote:
>>
>>
>> On 8/16/24 07:22, Dan Carpenter wrote:
>>> Hello Rao Shoaib,
>>>
>>> Commit 314001f0bf92 ("af_unix: Add OOB support") from Aug 1, 2021
>>> (linux-next), leads to the following Smatch static checker warning:
>>>
>>> 	net/unix/af_unix.c:2718 manage_oob()
>>> 	warn: 'skb' was already freed. (line 2699)
>>>
>>> net/unix/af_unix.c
>>>     2665 static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>>>     2666                                   int flags, int copied)
>>>     2667 {
>>>     2668         struct unix_sock *u = unix_sk(sk);
>>>     2669 
>>>     2670         if (!unix_skb_len(skb)) {
>>>     2671                 struct sk_buff *unlinked_skb = NULL;
>>>     2672 
>>>     2673                 spin_lock(&sk->sk_receive_queue.lock);
>>>     2674 
>>>     2675                 if (copied && (!u->oob_skb || skb == u->oob_skb)) {
>>>     2676                         skb = NULL;
>>>     2677                 } else if (flags & MSG_PEEK) {
>>>     2678                         skb = skb_peek_next(skb, &sk->sk_receive_queue);
>>>     2679                 } else {
>>>     2680                         unlinked_skb = skb;
>>>     2681                         skb = skb_peek_next(skb, &sk->sk_receive_queue);
>>>     2682                         __skb_unlink(unlinked_skb, &sk->sk_receive_queue);
>>>     2683                 }
>>>     2684 
>>>     2685                 spin_unlock(&sk->sk_receive_queue.lock);
>>>     2686 
>>>     2687                 consume_skb(unlinked_skb);
>>>     2688         } else {
>>>     2689                 struct sk_buff *unlinked_skb = NULL;
>>>     2690 
>>>     2691                 spin_lock(&sk->sk_receive_queue.lock);
>>>     2692 
>>>     2693                 if (skb == u->oob_skb) {
>>>     2694                         if (copied) {
>>>     2695                                 skb = NULL;
>>>     2696                         } else if (!(flags & MSG_PEEK)) {
>>>     2697                                 if (sock_flag(sk, SOCK_URGINLINE)) {
>>>     2698                                         WRITE_ONCE(u->oob_skb, NULL);
>>>     2699                                         consume_skb(skb);
>>>
>>> Why are we returning this freed skb?  It feels like we should return NULL.
>>
>> Hi Dan,
>>
>> manage_oob is called from the following code segment
>>
>> #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>>                 if (skb) {
>>                         skb = manage_oob(skb, sk, flags, copied);
>>                         if (!skb && copied) {
>>                                 unix_state_unlock(sk);
>>                                 break;
>>                         }
>>                 }
>> #endif
>>
>> So skb can not be NULL when manage_oob is called. The code that you
>> pointed out may free the skb (if the refcnts were incorrect) but skb
>> would not be NULL. It seems to me that the checker is incorrect or maybe
>> there is a way that skb maybe NULL and I am just not seeing it.
>>
>> If you can explain to me how skb can be NULL, I will be happy to fix the
>> issue.
>>
> 
> No, I was suggesting maybe we *should* return NULL.  The question is why are we
> returning a freed skb pointer?
> 
> regards,
> dan carpenter

We are not returning a freed skb pointer. The refcnt's protect the skb
from being freed. Now if somehow the refcnts are wrong and the skb gets
freed, that is a different issue and is a bug.

Regards,

Shoaib

> 
> 
>> Thanks for reporting.
>>
>> Shoaib
>>  		
>>>
>>>     2700                                 } else {
>>>     2701                                         __skb_unlink(skb, &sk->sk_receive_queue);
>>>     2702                                         WRITE_ONCE(u->oob_skb, NULL);
>>>     2703                                         unlinked_skb = skb;
>>>     2704                                         skb = skb_peek(&sk->sk_receive_queue);
>>>     2705                                 }
>>>     2706                         } else if (!sock_flag(sk, SOCK_URGINLINE)) {
>>>     2707                                 skb = skb_peek_next(skb, &sk->sk_receive_queue);
>>>     2708                         }
>>>     2709                 }
>>>     2710 
>>>     2711                 spin_unlock(&sk->sk_receive_queue.lock);
>>>     2712 
>>>     2713                 if (unlinked_skb) {
>>>     2714                         WARN_ON_ONCE(skb_unref(unlinked_skb));
>>>     2715                         kfree_skb(unlinked_skb);
>>>     2716                 }
>>>     2717         }
>>> --> 2718         return skb;
>>>                         ^^^
>>>
>>>     2719 }
>>>
>>> regards,
>>> dan carpenter

