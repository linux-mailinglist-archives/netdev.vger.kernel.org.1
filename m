Return-Path: <netdev+bounces-217967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7884EB3AA47
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 20:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7D817354A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15D926C3A6;
	Thu, 28 Aug 2025 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VEeGKuSS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NF8cqzBC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D619262FFF
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756406976; cv=fail; b=CuZkLm9ZZBWoqncltbMRnAAmuzXhv7W9uA03wmFGc/VtogS4o/n2TGQTGoYh6DNIG5GLot/ypI6DKyAHQFRDVqrhiBymBEwJofv7JoXZ0Jbr2NfYw+4UG9i7G4MaYz3FwHDVhJUj86QQSQhVFQfNGYnfkcOZQCV2m0cK+oETdKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756406976; c=relaxed/simple;
	bh=e1hT8K4AIHKLVpXn8dzzx9woufaaSvh8zTMfV6akT00=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kq3Xn/vYx/5REFwLp/WRrXY9tvu0sy1HYZ2a9r12Fu75zWvDAggygQ6CapU7NOhXeUlPJJGIhRax0AzkDVkdyvPA4pGoBGkDtnv3p5FojmDC8Swoi2U35sU0pIkguxsevP1gQL7rSKjDy9vL+E2deOjwhe3ElvIxDg0QblltWlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VEeGKuSS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NF8cqzBC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SHMwai006641;
	Thu, 28 Aug 2025 18:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yVzK/7d+NtnTmzABfVYtrfnERxhiTWt9truSQzFU6PU=; b=
	VEeGKuSSaNTxk2V+36yHuhpAbtifmVFAbkalQHiQjK5HuHUD5nVMbVBno1wTTE8V
	yd465mzuA2kSdaW+q6Zuf4f3iDdDBsYROxLAn2ckZIVKHQB0u9iwIHSK0LhJ5cSH
	od+nLO4fiaDM5fcFKEE+1g1OhHBd4i1ra+bL0Q3DF5CXl/+TNzbQiXdAyRO7QaSc
	LaYwHqnl8uJX8rS7eWOTSuynProWHy45mXtvGE0aLKjWGHCQFsq/EPv9scakioWS
	mEMNibFdBRHQeSXzuRRdwFBstdAw0LuboMskCOf7nMD3dBajEhBlQszU965cUZfH
	uSszPTn5HAxa0FN0DT8Xxw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q42t91jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 18:49:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SHtQ1s027160;
	Thu, 28 Aug 2025 18:49:25 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43c4yf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 18:49:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsfYIbV3w7VuKyjB+uLuor2YAu/SqDLrsnb2dmQQBTExLl+7TbUm/GOUPN4oowptibmGAoqaSnmr4pPz4VyFCi1z+Aa8fk/txX8Lusz2xMNnU0v045niyX42jtWc0xLip6Xctr+kdb+dfnNjPICjIXJRrvH5q2kto1SPSqaWH8JQ8ME1ywrlcH1qVFXIaUHvx155aVFT75hx2FhNuiCj3lymOIB8a3CDvaitTbeevtMSCeqWsE775D3Lkvdc1Kmpl8kXcfi1GDVmW3DgKqcny88CN8xhAL6EmuE+5a6WBN45jtBarhzl3uZtHkK11gC1YAFIZh0YLzRcEF+lIqXbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVzK/7d+NtnTmzABfVYtrfnERxhiTWt9truSQzFU6PU=;
 b=VemjqVPc9xciRYPuvqhiEcABCdaOG+7bK3qOQlOXezsq2m410oc+NEaQ1AOaJdjP1fGke9OjPARTKCMS026ETeeHr7louf4CFfT2N1SIBdQlR83rSikXUgQaUa4sjbYahQiyVPA7mjRN35GWsrDYPym8mKrh1Z0kDovaTmw02YMl/LpXxIm9h69l/3c2Yje/Oc6+7sOD2rBmoqO9xaXW4MaRh0nV9VQmo7Q6ioaN5Zmz00Pi5vlm9RQTca+cYdLpByTAflFUhyocnWXw1r9MWp4ULKbOnuHzT+xsjK8Ja6vVGsOdhsdXUmpw1zq/zhAHmXhHEF6Bp8q8uuq2lPBPog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVzK/7d+NtnTmzABfVYtrfnERxhiTWt9truSQzFU6PU=;
 b=NF8cqzBCRZm2PVEj7DrfJWjdEvceNLbhSnRgz2cahi1aPNm61gQHy3ddUMpEjQqPrVXvm2rrzyzcbxPDoSs+Hp1JsKZseREm+FmfwtQUmHYAP9sCK2Lax+fgXee6bVT7/Go4cCYasS0H3UqMxt27s++zPiO5kUKf8D1cP/Pl/2E=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH3PPFAA02B7A0B.namprd10.prod.outlook.com (2603:10b6:518:1::7bc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 18:49:17 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9073.017; Thu, 28 Aug 2025
 18:49:17 +0000
Message-ID: <3651704d-fdf8-4181-88a3-0c88fea7f66f@oracle.com>
Date: Fri, 29 Aug 2025 00:19:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH net] xirc2ps_cs: fix register access when
 enabling FullDuplex
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
References: <20250827192645.658496-1-alok.a.tiwari@oracle.com>
 <20250828172123.GD31759@horms.kernel.org>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250828172123.GD31759@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0486.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::11) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH3PPFAA02B7A0B:EE_
X-MS-Office365-Filtering-Correlation-Id: 5574fa72-f5b7-4051-8672-08dde6639740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0JkVll0TEdBUmxvaEN4RVh1NkFCcDJTdjBidkhCZE03aHdqOWl6TGJOSG5E?=
 =?utf-8?B?blJVUGo3QzhIOTBmbEhJUlFxVkxFbEo5QjNVV0E0NWJKb3RCS0lqRnE2WVk3?=
 =?utf-8?B?M2VVaVlaNE4zeHJjR0lpUzQrTDFFRjA0YWIrTkxnT25hS3pvekxRMUEyTlhx?=
 =?utf-8?B?UjhpNkYveWlZUE5ycnUvVFBISHltZEVDcm5ReDZYeDdXQ3pmSlcyNDFnWHoy?=
 =?utf-8?B?NzFOUzVKRGZrTTM4YWRRZWdOQ1lHMnNlRVd4dTBMUlFqMlZwUEFMRHFvejZF?=
 =?utf-8?B?d1lSRUVqbnJjVGlDTmtjdFZuL3B1c3c4RG8wUk52K2ZHd2xmZ1kvVERDU1ln?=
 =?utf-8?B?RnpBZmMydHZuS0o4SEZEMlV4MkI5TUwzbytSeTlhMDR4WkJDSkJEUkIyZWN0?=
 =?utf-8?B?T0ZQY0VpVlNEcjFNTWY4Vnhpa3VNa3lGRWVvMGpCcFdpdFkxUkVVYU91eGlO?=
 =?utf-8?B?UHJqYlZ5djQwd3o5OUpnRW9VRndjaFNaWDNtcHBxNnhZQjBpTm92emRXdnk1?=
 =?utf-8?B?NGozcTVxcGZEUXU0R1F1YWtOTkM4K0xZcWRFU3dqVVhRWnBWYWNRNGE4eFVZ?=
 =?utf-8?B?WEVjdFZidk8xeWNPRlNhSzRnTmMxVDBCQ1NuUVVZMjJBVVA1cWxCZWRpVkhr?=
 =?utf-8?B?Z1lLUDZpeUxxRWMvQjhTRnVJYy92TkEydVVtMktYWi9wT3pvTE5MN2pjQjE4?=
 =?utf-8?B?d0hEQXhtOWNQTDdOQTZyTFlWcjFrZk9GbG9JWUpGTmNsdW1qd1lVMDQxb3ho?=
 =?utf-8?B?OVRZR3BMVEkrSncvQmFQTjFOeUx4OFBKamdIM1FFUWZIYUdmeFN5OXVnRTlv?=
 =?utf-8?B?Mk1lRGEwVGFsbWJUU1NVVHl2MnZzY3NXcStwU1FvSjMzYjlIWHhOTk9XbnR2?=
 =?utf-8?B?eHMrKyt5R1RqZCtkbWoxdDJ5cFBvUUhsM1dCL0xpc0J3UW1jNHorR04xV1hP?=
 =?utf-8?B?ZXdZNm1XUjAwcXk4SmtycHVzNVBWVXJJR3Y0Ky8yVlZqeGR3STNmTVhRV3JG?=
 =?utf-8?B?bHoxcWVnTm05ZisvRFZnTVV6a3ZJTXpIYmxjbGtkM3NVck9OWThYejlRUmtm?=
 =?utf-8?B?aW9mVzM5Ty9oQk5idXNNOVVaZnRpNDY0THF1UEsxVXdoV0liTjdzUmgxck50?=
 =?utf-8?B?VVBBTmFtTVhTWmxibFJtTndTN1J6emRUUFl0SGJjOUhTWXJWMkxTVTEzeWtI?=
 =?utf-8?B?ZWZReUtTZi9TVHlENXlSME45M3pNTTRlbjZLNU1tTTdBY01pVURkWnQrZlZh?=
 =?utf-8?B?RmRISUFQN3BjOTg4dWtSVHh5Q09YNTFZbkovS3NtV0JTTWNEcVlwbWZwYy95?=
 =?utf-8?B?aVZJUElINXhaWG1Td1kxVmVmc0REL2dxRGd0bnJmcWVrVWhrbEIyU25XWHBv?=
 =?utf-8?B?Y01xb1RxWWF3Ymdsbm5GUmJYam1QSHd1Q3BJR2RaWWk3ak5RcWgybU03WjNw?=
 =?utf-8?B?eEpUWDZIYkQwb3dMRjR3Wk9EeHRoSFN1bEVhYjJKK211cnpwWUpaUFNGc29P?=
 =?utf-8?B?ZWdWaW5OL0RQSjY5WFFPY05vOUpUSFFiRlUrb1AxTDkrck15N1cwN2lpaXZn?=
 =?utf-8?B?VEVFVzhvYzFJcTFMYjdDWXoyWVFlaUlGYkdRRm1JQ1VrYThQSG9WTFk2bkg0?=
 =?utf-8?B?cWJzTTlPazk4OThWUkd1aXpac1JDQi80M1hPQ0FZQURWQXJvamttVWQ5bmgw?=
 =?utf-8?B?UkRJeGIxaGJKeFJYVTgwbDJ6aGE1WWxKQnI1S0w1eU0vRmJmbkxZRUU1a1FT?=
 =?utf-8?B?cUpyTXBSTlg2MWxycDk0THQxK0N2OThHd2lHMUxVOWtxMDB4Qm5jNzBnVkZr?=
 =?utf-8?B?YWxLSTgrUjZWN2NJdXVmN0NiNEhCUmx1OCtNZzRVbXFzN0toV28vaTRmU25N?=
 =?utf-8?B?eC9kdFF0ZFo2U2htM2FMaGs2ZDRPRS9FNW9rc0F1TTdXUUd1YjNtblFqNllB?=
 =?utf-8?Q?e+r+wYOWDgM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW1makNwK2FGd1BpMXZSTCtYenRscmZxYjloWXduRm9HSlpDOVIwZnpRbjB3?=
 =?utf-8?B?M25OUFNQdjlKdzdBZWVVMFZ2OEJyUFUwRVI3SDdCTVkyTEV4SVh6YURPWUF1?=
 =?utf-8?B?TTBUVVNMZnlpK1I2TVdaZGs0QUorMk54OXdDTEladCtvWGkzS3VDZzM0WXYw?=
 =?utf-8?B?dW9na3JDaExabzFEaWRQbjZDdTV1UkVyaW1GbVhGbVRxUDJGSy9IRzVmSUlW?=
 =?utf-8?B?T3FqRkdEcWlFRHJ5UzVGV2xuYmxndG5LeW1BRmVZYndadDlqRzBaMU1ieGh2?=
 =?utf-8?B?VGRMYnhhM3huUTFKRjY2VG4rMGhEVkFpS3VGU0hCMEwxOSs1V1RnMHlMbG12?=
 =?utf-8?B?VkdidFZhKzBOOFJralJ2cUVrVUZ1eFBmVDFTNDZ4RUZiaDJHZTZENm9mUVJF?=
 =?utf-8?B?d1Y2Uyt0M2pTWGt2RWtNQ2lxV2IyaHJOaHA0NWpSZW53T3owU3R3VVdJLzg1?=
 =?utf-8?B?bVJuSUtiLzRjWG0zMERQK1RGRGtoT3QzeGVKY1BDOTYvWFlRcXlnZ2VoTDlD?=
 =?utf-8?B?di8yOTdSMStxaTkvcFZ6ZW5IcW1maDlYN3luMmtHTTE3ZkhtOEZSa3pqdXV5?=
 =?utf-8?B?TzIyazNha2FnbGpGYnc2Z21GVllGR01FY0Z3VUhxeERFVUVuVjhLVVJzVlY1?=
 =?utf-8?B?WmYzUDYxMUlmZkZVTkxiSUUwbWVKSXlZdlRSRGtZNDVwc1R1U0w1cGM5SlhF?=
 =?utf-8?B?UUN1ZFgxLzZpbWNQbUxYUTRHVG4yU3RiRVBkK3RhQjIrUWdPYVpGQm5aVk5Z?=
 =?utf-8?B?ZWtMTGZNWTJVTXNxd21sZWx0cjY5MWdhampDNmEyOVEwVmZGOUxZck80VmJr?=
 =?utf-8?B?M1lmeVhKRU81dTJVeldBTkYydjM0OXZKQnF4N3BDdFIwRDVCLzlWUzhkbUw5?=
 =?utf-8?B?MVYyVkdBLzFvaHVZejJJZXR1OWZmQU9TQUhFTE1wM0tYdDQxTTRZb0RMM1U5?=
 =?utf-8?B?a2FqWDk2M3pFQXBOWUJRcjZ1azZKdmJqZUcwYkkwSVhHUzBkdUVpcW91R1Uw?=
 =?utf-8?B?ZUxkUUdlWEFudE1jY0dvUmRCV1ZDRysyc3VDRlNoWVVLaG4rcjk0dTQ5WlBS?=
 =?utf-8?B?L3hOZHJUWDg1eEY0cW1HNXh6bmMzYURGQXgyOTRhOFhwVHRJcTBHR0RldkYy?=
 =?utf-8?B?dHVHK3BkenEwUzNISlNXc1JVQmtXajBKTEpEcElOV2tiMytnU1RiV0NuYjE2?=
 =?utf-8?B?cGtRN0FlNEttcWRQWWpzL1JJLzJTenRaTHBtNVNGR000UVRuOGc5YTk2UWxH?=
 =?utf-8?B?ZGFxZFJSV2QxamR3d0dIUm1tN3oySGwxcjVERC96UXoxWmhXbjRLdk9zR2pV?=
 =?utf-8?B?N3BGc2grcytUMldZUUtob0NFL0tPaFM0SWVyakR1NGVwRTRFd05zbTZLY2VG?=
 =?utf-8?B?K0pnQ3VtbTVDZGI2UDdYZUxsNHNjTlNDWTE0QzFiQ3NlWk1LUCtwZ0prb0RD?=
 =?utf-8?B?MmFGbkdNeWc4WDZPdVFIRkpoYUYyZXo0OUxVbUNIbFY4RXE0RmVzUXVlbDd3?=
 =?utf-8?B?Qkh1NVh0UlJsQ3FEZUswcjhtNS80d0VLVVlNdjZORWdybm5MbWZvM3daNWti?=
 =?utf-8?B?TE5nLzl0NklhRTZobmU2SER2SktUK2NtOE1mNlJ5SWExQ09qd0NKOWYwTTA4?=
 =?utf-8?B?OGlJRURaT0NLTzZwWFNsZmhXSElaUkppa3lBdnJVRVNRaXQwM1p3ZVpMWlZK?=
 =?utf-8?B?ZXZMODVVSXNIZkRIbFJJYkY1Ti9kaTQ0MWQ5a3VTUmFTYW1nUzFEcEM0dTJJ?=
 =?utf-8?B?RDhNdE5nbFdZWXhWUXdmWjNSNHN3UWpGbFpnQ3R5SWVBL3VBOXF0VEU4MkZY?=
 =?utf-8?B?NzVqWVA5VTBvYUY4d2x4UXpIM3gvSzBSUzNUcC9mb1NqVy83OGs2N0VqdDcx?=
 =?utf-8?B?MWhjS2RrdVM2ZGVCT0ZoQ0NBd0ttN1cyQ2ZseGJ2OE1pc0krTW9qbTJYam54?=
 =?utf-8?B?M3NmYnNzdm43UTZnaWVHeHBoSXBzYzlRRXpjemRtSDhpU3VsVG5pRWtNbXBq?=
 =?utf-8?B?MDZrM3VxcE1BNE9DZEg4MXBsUndMLytQNkFvYm9DSnkva1hIZnlRRU83NkZF?=
 =?utf-8?B?TXdQWXV6MnA3L1ZBQzkyVHp6REdrZzY3RFpWQzJ2RXIwRkV1OUtmcTg2RklN?=
 =?utf-8?B?Vjh3Sjdzb3dwT1ZUQkJBclg2R1NPZSt4Wk1wa0FkVTF0cWlPM1J5NEhsUm5D?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KYmXjIAVQvL2Z/4oAqRuuKJqB3/bLgEyV5EGrNYETBt/ExngwaRHCzurG8T7xHBKKABMAvK2eMBSvKNsD8usF7ZLL8QPOycC20WUSLfW0En2u2rIqyFzwth0ATsNvUp2JGHbatqgHS9PDTOb/s73lssvxsvlclyZTF9szdJm01p3nrbEFLPIWA+PyJ2sWF+ueymdz+a2pEytVwivulrsYrMQoDscJn7Rh+viqWBF7gMUiIy1MIVKEGzO/BTPZD02bYWmH2gqAxlwQkp7E9x71kQn5jigaBScUSwbu2V0PFgbYaPWE4+IMgrKWAMK/WqLS2xNRqBFGnpAHyVpLscJpq5xT51WwU3/T25PxlykhCqYBMR4bYU1JlCHTL4M23F/1CB/TAT/DifHFZkDpGcPCM9+bULgMEQMnCMMcWFQb1NCDVkhNr9B0Ej+Bk0y8fHhuZx2dNPodcsD9Gei8iMh/osw2Wmm9/YnxwLDAShsCzPFOrui8GREhqRUkekoh6fwgP659f8eQUpfcsLWaiPltDFHzgdTTgiGtXjWp7wMFN9QPD52zbBdd/eQfAsfjHbVjcsg/RCkfWCwVI2QqvifpbsBQUTGyfVhOkmoRtNs/9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5574fa72-f5b7-4051-8672-08dde6639740
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 18:49:17.3318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RaAjLNT649LDul/iiWd+0ocecp8MGxf4yB5cTc+5R9L26FeyiXotqjqvgy0u0Jc+1fqbWOS65TASAgf65Fcj37BinOWvE7xYS2VevoAuuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAA02B7A0B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=921 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508280158
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMyBTYWx0ZWRfX5d1ciC36av4L
 P51GVN+uyO3bBxPWG9FxS4GgZEleDAoV6Jx5x7zuMBQvYedrxZw7wHQFdOk6qG+bDe+na03E/vq
 r42aAyPZ3HRLuEsEu/jtpMMerUCnxcia9mBVLE03IN53HliATOFz/kC+e3SQuuGWfzAeNxPVvms
 IS9D54OpRAX0E9DO9+O6VMAnK6KerXZk4x9n1G/wQ67JPG1gqXP9WgizvyeCsgAwWMz7DvHxOba
 FVSsD3EH4vRSh/CjOg23Ygub+Wwfq/aLAF3E7vUVHl8SHHE2jaM/qm1wW6qHF+34yhpyuhFFJIg
 oOqUsGNGWqP858TRPyO5S8FcjaJQZDifg9eKUKnoUPfHqEoey9DGaloXfNka8AThoPls5zVrVSz
 AVaEzZ/n
X-Proofpoint-ORIG-GUID: PCXemIegYoEtGtDDqIz9t4nLzZfIs4Ko
X-Authority-Analysis: v=2.4 cv=RqfFLDmK c=1 sm=1 tr=0 ts=68b0a4b6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=5EAoqYhKi6LYFJwB0fEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PCXemIegYoEtGtDDqIz9t4nLzZfIs4Ko



On 8/28/2025 10:51 PM, Simon Horman wrote:
> Interesting.
> 
> It seems that XIRCREG1_ECR is 14, and FullDuplex is 0x4.
> And 14 | 0x4 = 14. So the right register is read. But
> clearly the bit isn't set as intended when the register is written
> (unless, somehow it's already set in the value read from the register).
> 
> So I guess this never worked as intended.
> But I guess so long as the code exists it should
> do what it intended to do.
> 
> Reviewed-by: Simon Horman<horms@kernel.org>

Thanks, Simon. your analysis is spot on.
It seems this never worked as intended.

Thanks for the review.

Thanks
Alok

