Return-Path: <netdev+bounces-226733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AA5BA48C2
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEFF623C3F
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F76B23313E;
	Fri, 26 Sep 2025 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NcaG6O/M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xP3gufIO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882FC8287E;
	Fri, 26 Sep 2025 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902806; cv=fail; b=pCqM3mOYjjUVB+IWsqlA1H5+5o49L+NQQTWcUeg7Uhf9l22/4FCFmrE33qztgNXKm6aGN0xp8pxhqc1xOsYRHGEwm5j6mQ9TU2b8WjW5AB8rYtnak6gtu4Cv7jq1mSiXaXerBov55FmqB7ccX6F/mD5tYL0MyeJnw6yqZe9tYAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902806; c=relaxed/simple;
	bh=nLWpSArWKB0MPRUuBWMMoLq4MquGjCBJKQmzg1SnGvE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KUlK/AS0YuKVD2niE4yvjr/9Kuc5TE1OWeYm2fHJHoLxXE6Ji80DxqpkcARgXwEaETuEzO0EtuYudpNkQd6L7aZquqrb+lfPNlERrLvBznhZkFiLEW3PyUS07PBoERWOQmUpQyJXSbNCx8NgImUtrvq6vg+RJKz8K1AHfU42fLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NcaG6O/M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xP3gufIO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QFiDMD021970;
	Fri, 26 Sep 2025 16:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=q1tR2LDcV/xkA/HQ3C+KFuVmXqX+FlTIAuG8j88ugEk=; b=
	NcaG6O/MW71BWypNvJrFAUohHSQGTS34mJi2CnskB1Cn3GGX/xXVguEYkaGcrH5v
	XU0VjPZyuSlkqHIdjVAXxcdS7sukhvxX/Xyy0btnn/T+I2YL9UYjtUCXVyfmM6m2
	e5Xmr235lwM/i/ZM0ZoRUuZRR5047jW/NYINZaJz7xWuavldLe/l0jOMxVvB4xS4
	9F2QtcHFBvZt/O5VB5iHnjn4AdoXXnpweq8HV5NeIK9+xarDMToYeCMuStTZvM4P
	jaOn5YVq3hTyPHabcQzDrsu1xaaa7/km25Vhwy1Fo3dxWQwxR9lID7TNHPJvYTCi
	8lsUFdJWznN2NIEZX9jbvQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49dwr281yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 16:06:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEJfc3036804;
	Fri, 26 Sep 2025 16:06:14 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49dawknp34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 16:06:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I31Ej1V/dE91a8p/+Xx0vnEWfD1++fGvMAUBZLafZJXjB2nnbCvIMNgpy+qRYJ8O1Ea/4gL22WIAl7HVjgUXd3CBnXKlgGi8ZX4Z7MMv6AH1I5UBOuMlsCtDINMvIEqYCqoGZk+3DkHBUC3mfLIxngSJeeJaH2fsmkiGJ5iJKDyg+1WepqOs7PZ4/InPoOCFYHCq60/Sbeh10kmjznhOW8H6hBpZE/jL51lvRuxuCaD7qWUSEkOg23j/BdEEGDfuz5OYPw5gjmGKZa6pUj4eK1IuA3c+mt5FeXhDYCR4W368dAp6J4Z/aIHuUXkdKuYyYM2m/bhG5WMrH+tBTDhXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1tR2LDcV/xkA/HQ3C+KFuVmXqX+FlTIAuG8j88ugEk=;
 b=pfEZSEHU7QuhR5uJmEJ01BlpzpEQ6Eup/NiQ0jAoGl7dPzVJZg+jrpUR+7NWPFh32+5mb+Mi1govaL7ySkIXFkS0I0/cHGi+ZuoeaEyRXVo34Gj89P1U6RZIYOtcJRfBKj7OdfuC5yNiB6W+l3eSmBZJTKRlsU9cEFV9NFoMGpf8hzHXyqpYHqC7cRjIveG+0IRkGr8gi+/PEOeYeZqLjmbqpWKuFL216qV0x5jNwlxoa+0t/3SI3+pEKaYW/HyeUfQDCyGmHW4okwSXiFA3bADWaC2FoCgGa5HR6eFUxeAimyqxLKdL3/DHjXbVEhn6FRXJmAQra8RDO0Awjgk+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1tR2LDcV/xkA/HQ3C+KFuVmXqX+FlTIAuG8j88ugEk=;
 b=xP3gufIOa2YgVsdZY9scKaJgtMEoZclDqDOi8kCi4oP6EgQewPb5mx1HJk4DOhC43kAG56muWbvr9fdcxd737LB93oJgBuGj8SxYLNTgoxYft966Z/TgeJWjBr0q4dnXs7SDXDXArnaCHBmM0zt7Oazu1O92PziXXV9dAI46AmQ=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CH2PR10MB4375.namprd10.prod.outlook.com (2603:10b6:610:7d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 16:06:11 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 16:06:11 +0000
Message-ID: <5c991f20-03fb-4dcc-b1e7-d09123ee44e0@oracle.com>
Date: Fri, 26 Sep 2025 21:36:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH net-next v29 3/3] mctp pcc: Implement MCTP
 over PCC Transport
To: Adam Young <admiyo@os.amperecomputing.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Huisong Li <lihuisong@huawei.com>
References: <20250925190027.147405-1-admiyo@os.amperecomputing.com>
 <20250925190027.147405-4-admiyo@os.amperecomputing.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250925190027.147405-4-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0096.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::36) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CH2PR10MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc635ae-a06d-4a8e-98a1-08ddfd169c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2dxbk5PS3hHUkNMS0FpeXZjUlVSbnBOZTNhbnphVmFTN0N1UktKQVFWZ3JK?=
 =?utf-8?B?T1NTaHBhQzZraXpiMUZWd0ZPa2JQOXJyZDdpK2hiKzRpQytzMXBZeHhTUlJq?=
 =?utf-8?B?anlxKzJPaU1uOTZ0Vk4zSjR4WG44K0Z5UlNjQWtlc2xQbnBkb0FWR2pLY1hM?=
 =?utf-8?B?T2FZNnBsUmdua1dZbGNwZUtDV3J0Z0UwdEY0bHRNVXRwQ3hnTVBFYTVpZnFz?=
 =?utf-8?B?ZGtPZEF4NGtpaXltbGxPVFVRbi9IOGIvWDFRTTV6VFBQOTJBUkpEL2RsMlJD?=
 =?utf-8?B?RmxqOHVYZHMzdTlJQUtRNGw2SGNObDRTZG1tenRtaXYzV0dFdzFmTmFjTGY0?=
 =?utf-8?B?c2gyWWRjYmErTWIyQ3JCMUE3WTk5d0w3S0dMbFdJUWx5WmF6aXZXZWVzT1hy?=
 =?utf-8?B?N1U4KzZxLytUUHE1Z2JqV3V2R2dvbStORVFTdmFHSmE2bTZNTXZPcjlKdnEv?=
 =?utf-8?B?TjVGUklLbGM0NmNXMzlrVVEyUytqRXg3UzlaWkl1dmdCb2s5VTcwOWJQSTBu?=
 =?utf-8?B?N0M5VXAwaDFHOEZSZFBkVG1EaHNYMm03YWxpbld2NDFLdG1KR0E0SGcrRkxP?=
 =?utf-8?B?WjdXZnVwV09oVHUzZVkxNmZjUDJaS1pXOE9wYUc2aS9sOUgzeVF0N3NXWGd4?=
 =?utf-8?B?UXk5N1RoVkhsd1RwSFU3VEZLSGVvRU9XRXppTGM1RDB5ZkZuTkE1cWFrMGlQ?=
 =?utf-8?B?aVdVZ1pEUnEzMzJZYzVJc01NejRWSVdDVHZKc3J1NUIxZkVuSWFhenJ0cmNX?=
 =?utf-8?B?SWpYZVFYOUxIMXBPb0RiSlE4eVpBQ3VGeG1Lemh5VEQ2OWpQOGhOV2czQzND?=
 =?utf-8?B?NEFIMXdOZko1bk96TmdFb2lOaW1GUk5BV2RtRkJSaHFUT1pxaXRWTm5tWXRj?=
 =?utf-8?B?OFRMMkYzV01melFMQTYwcnY4eXVCNTl4eWErLytEajhRVDJacXpDTmVFMjBE?=
 =?utf-8?B?dUxubWp6ZXNIT3pDaS9TbzhGU1pRK1FJU1JwUFFkaVRqSFluK2NTbWZ6QmhJ?=
 =?utf-8?B?MitwZnI1QlBkZ1RLR2dwOW53ckw2QTh5RWJ2Q0lEVU0zVTZyL1l1S0N5cmdy?=
 =?utf-8?B?QzF1WHJvZ0JoNVpmVWVPMnREN3FtRURZOXZXYk9mMTB5VkdITlRIYkhUM2lW?=
 =?utf-8?B?OEluV1R4TzdEOEN2RmZTYlQ0N0NjWlRIbGQ1bmRRVkx4Z0ZWTXd0T2F4RmE3?=
 =?utf-8?B?bzVSNW95ellDOHpKczlQcGRPUGxqWUdYK0JyMUpyN1M0TWdUYmFMNlUrdnp3?=
 =?utf-8?B?OXRmckVacUhaWEpnaTFkc3k4TFNTUWIzWHcwWStvOFNkOGxyQXhSVWZRSnFo?=
 =?utf-8?B?VmhGVlNORkJPN05IRDlJRkw5SU9rWHQ0WDNVREZBRlBkNDZkOGkrOFJwZTBp?=
 =?utf-8?B?a0R1K2daem9wV2ZYWitOMWVSS3UzUDdWUm5hUHNpOXBLdUlCV0xGWGlXdEh0?=
 =?utf-8?B?SjRIRXdBclR3cHY0aDlNaXo1Z0hOMFFaTS9ENm93c0hsUko5aHA4eXdUS0dN?=
 =?utf-8?B?Qk1CWmYxRWVsRzE0Q3FuK01hVHlsUlIrM3puMk5RTnMvRlhmdUFoS1J3NlVv?=
 =?utf-8?B?QnpMOWNOM3FxYXA0WkdRTktwSDJyWkVkOG5ablVOQ0JGbnJVYm1TTmwrWjRv?=
 =?utf-8?B?NWFVcWl1T2xzaEVtU3IxSmI3RGpVR3VkZUhZSzdJVFVrcHFGa1hPRUt1STFm?=
 =?utf-8?B?bzZXcVlMM3ZoSlh6QWloQW5YWWFrdmFPM0tqMm4rM3lrd25idjZqQkxjclJW?=
 =?utf-8?B?OUJYcld3a0tKNXpMQk1FL2EyUEdWMlBmVVVmZEt3Q1ZVdzNiMUNNVldLTFBq?=
 =?utf-8?B?OVZUK242OGptbzdpRGpPSSt4SkttV1hPZ0RwelRlN0JudjQrQUhIMU5uc3pO?=
 =?utf-8?B?YWxhbVloSGdyRTJmMGhRUXAwV3RXVzRoakNoWnNLR3JEZjFjdmRZNzFWNlla?=
 =?utf-8?Q?6Pj+IdbYtVGVk15Lz6FiXYiOJVQkN0t/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmtsbjdUSENoSzR1R2x0cDZOSno4M2FaREVIMUViVG1GbXlvRVdQUkI5VGI0?=
 =?utf-8?B?M292dTN6RjMxZkxVUmh6cVd1TXBBZ1ZEc0ZLTUxGTWNRRFl2cWw3NkhWdFo3?=
 =?utf-8?B?b1ZXdVh4WjlhT3ljdDBNQTh3M29ybmhJQWx3MkdtZ0dyVi9MSjhWRlpWSXRJ?=
 =?utf-8?B?WXJYc1ZsWUtsTzBOSG9DWlZzS284enBmZTJsZjZZbHJUcGZhWXFwcURsRll4?=
 =?utf-8?B?TDZ5QnlPSk1tYWJOR2tlL3R2di94N0hsMVJaTGJDM05BY09VQ2MrZGFmQXBG?=
 =?utf-8?B?ZzN5TWFDYm8xVFYxT1hDMEtwOGxFN0djT3pJVUc2ZVdBRWZHT2RNYnJKTDRN?=
 =?utf-8?B?a0l3SEFsbDFpcWhZbERyam03aWNtMytRM0tIRnZldmF6NDgzVk1rVVRyT3Rq?=
 =?utf-8?B?a0o2dlRySVM3a3MrQ2JqOHZyNXpFWU4yL2VUTUg1WUUxNzBCZm1OMCtrcTFn?=
 =?utf-8?B?NTNRSXkwdGR5ZkFuTUREY0E5bWQyS2tuOUM3OHA3Ni8yTC9VdkVhbWhoVm00?=
 =?utf-8?B?TWlCUXlBVUJNYWVZSk5sdXBDbGJkRFFaVDN5UHlaSU42elptVjZWN2R2elBZ?=
 =?utf-8?B?OEdsN05DM2xLb1RQNi9CZHVYNGtFYmVCSGFzZDNmbjUvck9hQVNiYXQ2TG9L?=
 =?utf-8?B?SmJibUN2R1FESnN1Q3N2SE5PSW5vUzFnV21BaktLWllYdTRJS0NhRGw5MUdK?=
 =?utf-8?B?QmlpTHZNVXdmYUNseW1TR2w3ZHJvM2l6azkxN0hzTVg2V3Mwb01pdHlqa01R?=
 =?utf-8?B?U2RJdnFsS3RxTEk4LzJlWk9lbk5vWjVvdE5UekFYbG9YMklnaWZvNittcDN4?=
 =?utf-8?B?anIyakQvcm9hL2JkVHVUcURjY0RKNWxtbWFRcWJNSG1Ud0xLelZlb3dmaXpp?=
 =?utf-8?B?QWswK3JFdjkxNUZZYXRjOGR0SGZxbnpZVHRlWXg3ZURGWVR0cTBXM0Q2N3B1?=
 =?utf-8?B?R295OEJTd00xRE00T1BMVVZJQVo0ak9WVWpVWk81S0ErMXJ1UzY0UmpXVHIw?=
 =?utf-8?B?alRGNnJFL3JKc1BiTjdCRWt1SlB4czkxVjBQenNYQkVHSUxUVFF1NC82WFRX?=
 =?utf-8?B?MjBRMXcycHl1K1NkcUdvRGtmdDQ4aDdud2ZYY0psUWxOY2haQlluaU5zNHp2?=
 =?utf-8?B?QzJiNExHODFucjI0THV4djdqYXFoQWNkNUNoS3VTOUdsSWlPSmJ5SlRtN3pn?=
 =?utf-8?B?NXJqcjlQOC9EVW9qOXBRWlZVMlRmaTJFczVreGtLZURvUmp3NkgvM0RyQXdo?=
 =?utf-8?B?WmNLTjFjOFlIb1VwL2FEb3YyYjFQdElhNlcrUnd0dXEyNWdYekhMeENiaUZM?=
 =?utf-8?B?aDVWMHBnaXlIV1JxOHBtT2kzekxQZUNkSm9jZlNjOFdQR2pFU3BlKzZubGhs?=
 =?utf-8?B?cEJxTmFPKzBua0x5NjJzbFk1cGt0d0dlY21icGN2MEMzNE5mT0lnUUhUS1VW?=
 =?utf-8?B?NVkyYVUxWUlVZ0dWTVp0MldEaUkyU0dxS2lFVzBEbklZL1AyQW5QQWxhcWdy?=
 =?utf-8?B?QlZhRWhETGE5TXRHd04wSzdlQmdaSkVPQWJlSjlzSnlRYy9kcGFPRStwd2l2?=
 =?utf-8?B?ZGdIRTJ6U1U1dE9XaytIM0VOSktQN0VSNGx5bzhDbHJ4SlN4UnI0ZGlpcmdG?=
 =?utf-8?B?MWNVellpVUN4dzlHb2JuaEhoN0g2NWZaT2RwWFEwczdVZ1B2cVZnSmx4dFo4?=
 =?utf-8?B?dnM0WnY2SERKRFBKaERMSzhwYVZJcVpMc2EyN1l3VnUvclhzU3g1UEsrK1Zy?=
 =?utf-8?B?ZFh0QU9yS2xmUFZnK1pabzRTREV1bElWZzlvK3dWd3ZqdjhsbDFFdzFwT1RT?=
 =?utf-8?B?MGhRbWJSMHFDZm8wTE1SNU5MT1pXSWZ1RHIwelVVbmVqcStqVExIblQwVkNk?=
 =?utf-8?B?cmY0dTVJeXg5TjdZMlRNVlFudlhTcWFyUk1zVlNON0N0SDZWUVJnWFArSGZz?=
 =?utf-8?B?Qi9sLzFaaVZ5eTRyYWF6VEQ3bk1LR3dka0M0aGRpMmM3VGpXaFdxSkFGMS9Y?=
 =?utf-8?B?bGl4N24zZitxSXBHMkJlMU56OHpoQ1hlcmwrRmszWG0zYmx3OTdCSS9Sbkoy?=
 =?utf-8?B?Y1lrTk50aDVKUC9YRkRjNFcrY01pVnppT2t2YUtRSkxNbEZaMkJYRWl2UG1G?=
 =?utf-8?B?VUZ1cHBjWjRYTGxrM0ExeVFHcDkzMGdFeWwveWFpQm5KZjdSMWs5akxwYXEx?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q1IMebuJhZhoTH5Apgai53aT/hdV+4t7r3wYppTR0W2uGG5snb+5aaB/uOsDoY1gMy0SzLuAUYA0SmHcsFihIdgF9zf9D8SeY/3cB52BmvGNFhcG7w71an95hcc7xJCNBpwULKW981dMS2X1SALkR1frH8wyWLhfI8E54OFW0Y+gtcau7xub4nJAWg0IBSZ5mpSY70P39ScMOC1jRx8C+JMVekVUjglQtLAaM/soqVOKU4+7Rn+SOcdEZNJPZeR4VT4W6YchqL+UguvZqIseupr4lLQe8FOo1QBw75p2mgNRqcKn74G1Qwr9J0jlJ7OXaWs8K45UnTH+mJHZqNt+p0dDQdzklL4xQBo06AJGWoNcWpQ8esX3ebznOgDojHIXLEUHwUHAIdPALlgvyiAh4lK6XJoRCzTNNFpyyr9XMBaogNdhid7qsPf8WYay5I982Fqmo2IuenXlFeNC0n+yvZ7VgN8HOHEEdj/vOjjzgb+LORJfMaDRSxpdbS63dglAlrO1RbwcYejoRuj6GEIkHFnqcajq4CJQkeb4sjpDISbZB6Tq59hRt1B234SYs0ByjSCjITpZvbeZ53FgD5o/MufJfl0CoQdXpWs5go1Pj9Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc635ae-a06d-4a8e-98a1-08ddfd169c8b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 16:06:11.6122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsjMRqOcJjF4lEcJQC8ohHR0RLOXMVzYlT0WK83N4PeDCc3sRC5+jylEQLbYCHUHH2mLSAhBcN70z05r4Aq55PHlYK9GjS9S3xt8eg7ctzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4375
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_05,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2509260147
X-Proofpoint-GUID: 3RgSwoZ38tFU0clE3vzsn11JKVj4jdBx
X-Proofpoint-ORIG-GUID: 3RgSwoZ38tFU0clE3vzsn11JKVj4jdBx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDE0NCBTYWx0ZWRfX6nd+6i0HoeJ6
 syvKXPD7q2hn1Gq8tTduWvLMEF3DOLlrK3UfxJzpG6/iT9FIsInckqdcEhExlE6UpdGliG7kYBp
 eqSvBZL7Sfp6PjuDhXipIY3I2gSCrmpW3VVdvFm8aFDXtxBFQK1BrlJ6zcKG4TqCYjcsiD8iuaC
 cw0R1HEdAlnPNIeUc18g1WMYYhK4x+CP0opLbtyrUgQ29u1p4uMqvpdjaNJfEFm2HhkiYC4rmSv
 NC5D8I5jvaNw2e+L4W4JMch/byD7k186psnjoN6K3QfL+6fbez2oSDJikkt2gokZxuVg+6pW/eA
 LJNEYJR0e15j5jeyIg0Fnf0SJFqje57uiKKOYoutYqw7OvDkQgqG/nGVXzc7oRyZPoI0M1UQNet
 ZjdiGZBbNY//8GXFIFztqTwHQUWbJQ==
X-Authority-Analysis: v=2.4 cv=I/Nohdgg c=1 sm=1 tr=0 ts=68d6b9f7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=NSpAZvObGHdBfyWVJc4A:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10



On 9/26/2025 12:30 AM, Adam Young wrote:
> +static int initialize_MTU(struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
> +	struct mctp_pcc_mailbox *outbox;
> +	int mctp_pcc_mtu;
> +
> +	outbox = &mctp_pcc_ndev->outbox;
> +	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
> +	mctp_pcc_mtu = outbox->chan->shmem_size - sizeof(struct pcc_header);

de-reference outbox->chan->shmem_size before checking IS_ERR(outbox->chan)

> +	if (IS_ERR(outbox->chan))
> +		return PTR_ERR(outbox->chan);
> +
> +	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
> +
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +	ndev->mtu = MCTP_MIN_MTU;
> +	ndev->max_mtu = mctp_pcc_mtu;
> +	ndev->min_mtu = MCTP_MIN_MTU;
> +
> +	return 0;
> +}


Thanks,
Alok

