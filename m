Return-Path: <netdev+bounces-210285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293D4B12A4D
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 13:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3986F1880FAD
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 11:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEED24500A;
	Sat, 26 Jul 2025 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hOXqw724";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qgk6rTK5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F25245000;
	Sat, 26 Jul 2025 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753530843; cv=fail; b=PYnerF97Sp+jGiUObGM/TiRJ/coRc+YChjEXjrezVBrcI/qyYD/+K0VS/8yODFXkJU72ZFlFKuNyM0GkljAaEFkoKxxaMFW8iHYSx+6N2IRJXUU4jjgUYDiDLZtR0nQj+FgIE3Y3kb6iMuQG2AvCY6Qw8F0WHHBsw6jn6dNCQmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753530843; c=relaxed/simple;
	bh=fN5kXkGYQXgnvQ2z2t8eUQRqMDwN7YCVIxMzgJGdbHg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V9CE6jXzq6xhWqJd4jEEry4H1HVeEOEx2n2WjEEBYBiv05R57f1OWkSpdSEUURhjnmbz/pWVh1Q88h03//dPY8SJ315X4e48kt+gshMEMOSokYcHvUR7W7vpTmZF1vh3eN3RNRfiTwwo6bpOFcfTzAIw5765/KZz0+9OUTCtUVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hOXqw724; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qgk6rTK5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56Q3S8lE012302;
	Sat, 26 Jul 2025 11:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qMiCrjVzBuWcsZrGBX2Xgty5rO0yTGRGGxX+UEiCu4Q=; b=
	hOXqw724gucrAMrwNOu+zqp+KI/8lYp1J6GOyJvoRqe0uSOCcEsD+E7drohzmc6X
	askaNVchN7tqUKCIQsAzVxB+O55gtrKbZbrd9rv/JrDwJUvsPCCLnrCT6GK7mZ+W
	2ysmz8jJxCHXwT13NbDim8xuHsYc53rF1KctxnMKTIviVbrv+LrPUzjJfleigeva
	/A/MdG/sZ64TTQgDh+OQKMW9GA2TAdcYB09tPlxR0AxvEYNJhRp42p9sLvvSamQG
	9dURmfVM/iBhiQIpZVbdjIKJc6lryFxicMIE78uKuNUHRaj0KiJbkB5XD4tnkVop
	gxeaUv/s14p/vydU6oC2hA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4y8jmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Jul 2025 11:53:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56Q9ueN8035155;
	Sat, 26 Jul 2025 11:53:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf78u6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Jul 2025 11:53:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bk1jWxED0jz0emoI6e2teqvtiEh7sMkJSm3a1JzSIuY9Ad61bfkjVZK+dZl//98iLRDuTDmmldXZ76WnHGicXA8WzetueQkQjKYz2+sQ1kW+pIq8bqypEVQmn0kqN5hfMrGMb7gVyfkYFW/1NXnG0kmGwf1vrUiOczyu0RcTWjcgMcmIpl9N5JMXvP1yfMULq7NobAAtW3C/3zMqgtzskkvWRDCPW6/83MXRPwMYWLnSPEeD/WfEfzKgL/tB7QMDjCft/UJtKmUU2RzQ/6gtQEZa145aI/tBFt/YZ2SeH0DujRjFQbhhkGXF38jE4Y/u82gE13w2lHxQ8JbeFDTMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMiCrjVzBuWcsZrGBX2Xgty5rO0yTGRGGxX+UEiCu4Q=;
 b=bbnrtSR9MHZTsRPFlFaOHYtNF4Eq2kml9oUBgtgb3XZuqi/5+s2OlPUgKVgwQuwNRcwcNGo4KxmB5jksh6kMeVxXNlzvkL1XxbxQDnw0M+BVN7ueQ2EFRYpwHlLexJ3ZmYMpTbrr5ggcQ/aF4dVXQRiJk2bBToBfgvS6CGlnAZsuYHYUhz+os5mO03hE4QkmUITks52N7xrFxD5f5kK9bT3AEqqscLedu3zjLmbMnZF3acaJrasghP476OKaMqGRQRbpr9PGauq+7nQC2/cUM1f+jaCzdq9bYz4cwyDlthm5xHktk9b74vYJGI/2jOh83oREo6y9hI614rMZudhcfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMiCrjVzBuWcsZrGBX2Xgty5rO0yTGRGGxX+UEiCu4Q=;
 b=qgk6rTK5o1DGpJAlBgldK0hIrdMKvqH4+a8zMT7KeKfawcgGtreftJsHJO3osaKugFL628fZmlD258CTuhn23D6DHxYjMgMmfZXjgLvQT2yCmthfo3rdeLIs9VrTPcAu4ipO1xfV5fQKWis8Ix8cFRanGYFf21dSuPRtZ1o4m+s=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM6PR10MB4155.namprd10.prod.outlook.com (2603:10b6:5:214::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Sat, 26 Jul
 2025 11:53:28 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.8964.023; Sat, 26 Jul 2025
 11:53:28 +0000
Message-ID: <2c681a15-71b0-4514-b0ce-ce6d28c74971@oracle.com>
Date: Sat, 26 Jul 2025 17:23:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/4] net: phy: micrel: Add support for lan8842
To: Horatiu Vultur <horatiu.vultur@microchip.com>, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, o.rempel@pengutronix.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250724200826.2662658-1-horatiu.vultur@microchip.com>
 <20250724200826.2662658-5-horatiu.vultur@microchip.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250724200826.2662658-5-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM6PR10MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: bd09fc32-3907-4d41-50d0-08ddcc3b0891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MG9DVmFmQmMweC9DUmNoV2djcHA1aGdOZzRVK1FxUExRQVF4QVV0dEVxWDNw?=
 =?utf-8?B?UDcvd1luU0FoSDRiZklPcUN1QWgySk5lT2tsYzlpbUozOXI4ZGdoWGk0VDM4?=
 =?utf-8?B?YllRdXRrZTdhRTRVWjlkcmRUS0VRM2dpRzNWcU9ZakR5RVpMMm03QnZodXJ3?=
 =?utf-8?B?UEo0ODF2MmdzVTdCaldZZWMzNkI2dTVyaG5oYjZ3QnhuMnNxWW0yWVJleUVT?=
 =?utf-8?B?dzRHZnl4UTB6NXJsc29WY3NHZ2JkMmhTa3lBenJZdkVkQ2dCOWgwRHVxdVNY?=
 =?utf-8?B?blN4ejNHL3p4YXl0MVNlSXA4V2hRSkNpTkYvTC9aVExVTTJySGJqWVFyNU5z?=
 =?utf-8?B?RUZNR2cvYWhTZlI5WlJQeUxpK0JBcE1XeDVBbGluZDUydGZiVUNXREpIVisr?=
 =?utf-8?B?MVZ4bTY3ZlNCa1RlVVdlZ0tHZTVjVFFLKy91TTRHRmxKQzc5NEFzVFI4NjZO?=
 =?utf-8?B?SWFUSWtWaXVHalVadnNmYzV4TVR0UmFET1VTMng1MU9iWGU2Ny9qcDZXZmNy?=
 =?utf-8?B?WXVObm1uU2VrazZFdHFWUkVZR1hkZnB5eU9USllVZWJmeGdhUW9ZRms5R2lO?=
 =?utf-8?B?d2hYMzhDTW5rWTRtZ3hvd0J4MHNnUlBrU1FueUJjR1pCZjVWZUhtaFBkcFlD?=
 =?utf-8?B?bUQ0UDRGUm1Ed0FlN2xnMm1BSzFYdWE3YmN1MCsyNWZGWTR5M3kxWmdrSnBI?=
 =?utf-8?B?dm5ScWpYbFUrb2xjYlgyUCttYU14cGZqUVdHQkY4T2Q5MDJlSUx2WjNLUUdS?=
 =?utf-8?B?VHFwRUh3RlV2MGFLbFVCWHVDOG1NbnJMQkRzUzBvS1JxdHRRRUc4UUdNM3ov?=
 =?utf-8?B?WTNwNEVLVmt0NUJCMUhtOEZtbDVCMFQzai9DY0tzai9aV1BQV0NGb0JNcEhP?=
 =?utf-8?B?UnRSeVRaZHlzeE5wLzkrZFl4Z3RBSGZNb2VYMUNWc0tzY25JNXZKd2NVL25Y?=
 =?utf-8?B?UDhWdW5pd0xXdCs1OVdDU2FyTFIraWVRNGtWSGNISm5UdE1TNlNqNkZLMkty?=
 =?utf-8?B?b3dKemU2MWpBQitTRDl1YW5qYytHK3ZZaHlkTzgrSC9HQnJsKzZzL0VCRVJQ?=
 =?utf-8?B?REh0cTE5MngrdkJqRW5rY05KZXVUa3M2bzBKbEIxN2xHWlRiaHlHNUsrM3BB?=
 =?utf-8?B?UG40SThkK2JudWdHN2VYS2RvZFdyRFlsNUJ3Rk9WTE45cVBER2cyVXBWK2hK?=
 =?utf-8?B?VWRDL0VXaEFLeGd5S2RBUlNrSW5USy9yK1JuQVRHdVNqUkR1dmtqVjhqcnI2?=
 =?utf-8?B?U1d5SHp0YTV5bHBFa1cyNm5oQ3lOV0NrRzB1b3hVNXBsNFE0L25PbzdNdk5I?=
 =?utf-8?B?ak5VdWkxQSsxM1Z1ZFhvTmRQNzVLaUtjSWtDcVkvQ0p2aWJWYVRZV2MweENG?=
 =?utf-8?B?Y3ZtbWx2akFEenFIR3QyNTgvcDY5Mm5RN1Z3SkFQQ2pxakc5N0ljR0hVK1Fz?=
 =?utf-8?B?UzYrdVZHT0NrWE1ZaEFRV1k3Y2NUZ0NMZ3FnMHpYSFlsaFdSTnJ1aFFDajM4?=
 =?utf-8?B?TUNWVXk1VVpZdWFUT21KS1ZObEU1NFhlNlJ0cUE5M05uRGMzRWJ6a3JKZkVL?=
 =?utf-8?B?b3dheFEzWVQ5d0x0aHVKWFJDYi9qYm8xUmRJRE84dlFxczl6ZjhYRGpFMWVj?=
 =?utf-8?B?dmJQOU1ucitBbktXc1BXTC9oeTEvd0xaQno4ZGdxOWtWWUFhUFFBTnpod2ZC?=
 =?utf-8?B?ckZCTXNxUTJNOWM1YjBsV3YvVXdwTkdVRTJTQkxTc0VNNU9iR25nelhEREQw?=
 =?utf-8?B?eHF6VEpZUUdjYVl0N2h3eEd2V2Z4cnJyamxwTzJWZDA3Q0oxcnN2MUtyRGYy?=
 =?utf-8?B?WFMyRGxpMnlmc09ZWlE1cnJQU1EwY3pyTXlIUENRNitKeThNTkhKeW91NnlP?=
 =?utf-8?B?UE91dHUrd0U4ZW1lck9WNlNYMXU4NFpJcUh4bzVvZXdhcTRpdFJSNmhZOUgw?=
 =?utf-8?B?dllZMUdzTDcvYUlxWVVSK2JXQWlNOUprQ0svZGdGc1d0VE9GS3lrT0hIVlRj?=
 =?utf-8?B?RnY2ZzRoenJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2xML2NZbVgyVEhja2RVaVUrRkQzNzU5VzJmd2hldHptdjgzSDN2VHloZ3Nv?=
 =?utf-8?B?bm9XaVNGZjRzOFc4ZlBNTnhpZzNIWnoyeDBUcWIzQjlOQ0tOOExpZmJuVjhl?=
 =?utf-8?B?cnVGQzBQRENSRjNJaXVYQXlpRHUzTk5RODkydVhjWGNFY2Fqc1d6bmxxTVFG?=
 =?utf-8?B?N3d0QUkxd0t2TEJTNDQwVnhuemgyelVrVUdUc0tyY3oyOGwrV1lCWWx3VHlW?=
 =?utf-8?B?L2RycXZFYlpRMzkrR29uakgrTXJERTh4bWFDQS9GY3k3QUg4KzczWVFzTjNi?=
 =?utf-8?B?MjFGYXRyRnZEMy83MDBDeDUxTVBvUGhucXU2d0Z0N3hPTnRaTHRwZWZsQ3BF?=
 =?utf-8?B?MjBqNHVvOUFhdm9UZjE1eGxyYVlZWEVPR1ZjWE9DdGduUERwbHplaXIvcWZa?=
 =?utf-8?B?dm5IaysrV3dURlp6S25IQTZxSVdXdzhpR042a00relRodjUzenNmNUMxV2Nh?=
 =?utf-8?B?WUVQaEhGTVBFeCt5alcrcGFwZHdrbVkzMkxRMHNEQXhieS9IKzZBUk9aSlhO?=
 =?utf-8?B?RU5WVVNpSWxQbjFkb01OcW5SWkhrVnY4RGFVMVB5eTd5UzhwS0dNUkh2YzBh?=
 =?utf-8?B?UXUxdG50V3huS1k3QWVjWWNRSFEvOFBWT25tbSt3VkVJbVlhZUVhQm9sUU5U?=
 =?utf-8?B?cFVsdStCQzdjT2ROWHZpaDlHZ1JjR1k3M3ZlRVJrVG1mM0RZeUhCbUg2MjR4?=
 =?utf-8?B?YWFxUGZtYURXTFc1dnRSZkM4cFVNcS95UjhHa3cxRXFiclZ3WmdjVUlwU0RP?=
 =?utf-8?B?MzNRZWJvcHNKTm13K1M3WHltS25JMytabzdCNStGc0hUamg1OU4rcWhHTVR1?=
 =?utf-8?B?dTB4NGp5TlRmM0tEWHBWcm1YQzhzTlpQWFVieU11VTZIOHllalluSWc5aWtT?=
 =?utf-8?B?em9nVmRJUjY2TGhCV09tRmhjOXltazh3TlphTmxjTnNGWWorNUp1bngzTTBs?=
 =?utf-8?B?K3U0L1dpMzJEYStJbFdzN28xQkdycytMbVBId2duYXZiRk5NNjl4dWFpQTJV?=
 =?utf-8?B?dlBDTGIzb3ZadE9hbGFBaVExNkxSRmFRdXFXMDRXckxJN3BoYUJsUkRIalh2?=
 =?utf-8?B?bU5Yek5KcVF1YjBta05DQi9rNGR2SXFVSXlmYW9rOER1aDVTZUNOYyszYVBH?=
 =?utf-8?B?WTFndzRNdjN5TGdMWXhrTkZHS1M4aEQ2blNsYUoyWExVNkdzZjU2Z08rR0Rk?=
 =?utf-8?B?eDVFNVFmZ2NpV1VIOGV6WFJlbUhkY1JyYkFhak9QMXhQUnNBQUcwbGVRbzBz?=
 =?utf-8?B?MmFpS3N5MFFNaWZGMkt5aUp4UkNQZ0w5OUVnMEppNWhQc0s5UnBHc0RqVllK?=
 =?utf-8?B?WmtDNkdCQzFtcG1lemtscldPUmRhclh2N0FxeXJBUzdJeHVFUVllTVliK3FG?=
 =?utf-8?B?akxZaDhOc1ZTVXJJbG9Ya0UzemxzeWQwWjROM0RRMkFDUWNVNzhKWWN2R0Vt?=
 =?utf-8?B?K05STGUwYXFWdUR0TGtiSysrZ3k3TlNaRjA2aWZnSmQ5UGU4ZERmNFpIYTJN?=
 =?utf-8?B?QW1IcFBpaExPbEJPWW9lZnVyRHBXT3JQOWN0Y1dCSUdseWFpaHhKNEZKK0RV?=
 =?utf-8?B?Zkd3eGRKWmtuSWRhUXZTSkVxZEM2cmxFcFM4anlKUXdHQ2VRMGFvMUFQcW5l?=
 =?utf-8?B?YytzRHhUa1FQUEhYekdIV0FqWU93QkxwWDRMazBHUitvWVpMT01VQ29qcnI1?=
 =?utf-8?B?S2x4SFdGYjYxd0g2YnV6c3I3aUFyRWVTN2ltWUVkdi9YQVk4YjFMOXBXY0Rn?=
 =?utf-8?B?T2Ewa2tOaXZtdHpaUzVIMHRJOHo2cXZxbHZqTUJlKzJJK2ZvYS81bGxoUFpX?=
 =?utf-8?B?U3dyYms2R0dKOHdINk1GdUJDNFRYdEhhY2UwTXNYeEZSNkVyRWZGVFNCcmxR?=
 =?utf-8?B?a2JnYXhJd2FXZXhSQmF2TEFCbElYSHpoSWJ3N2hTZnFyNzhxUWxCU0c5WXlB?=
 =?utf-8?B?UHJHenFPSzBWUlpJRzg5NSt1aTBZSS9PQWFEYVpaM3ZJSTBaRGo5S29TcDZs?=
 =?utf-8?B?cGFMVkxFMnVrZnRaaEFJTE1oQysySlQvR1hsb1YwYlppSzlEMTZoYUthUGln?=
 =?utf-8?B?V1RZd2NydjdyamRuS2QrVk1vN1dXZVRZZ3hKeHl5K0lSZXpxaFhjU2VHcklN?=
 =?utf-8?B?R0k2NjNCMThnaWwyTnhva3lTZzZLeVZBeXdZYUVuMjlnam0wN3B2cjJzcGhB?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FVz1/Rc4DImYwmtFD8SlKsWGYPmctv8MXlu04r0H4wpcVGxJ7Q3id3s1eV7z45HpNW3lfem8ihYU2Cd5w5r0mOr2rzukDHmI8OCSgCeK7Ujq3DB8DwCJWflfHooeFsAz6cf4vE+UDAx4zruqqP1IjdtG392adA5629h/2/X8zJMTWL8bHvdNWJpFbHnjmnv35y6dfcLJUp4i9ORCpnqeURsXrCFI+gw6CkHBwzXYiB9pC/pFC8iIJ4qmLxYF99OW2tawzEQzXutZdE0fOCfZzXC5yq1PFqNG1XUWnBubks1UsR4qxQRBbdy2wARPu8wqpvQ8Wh7UaP1v4hYkEpO3cvC4qahLHAqodXUjFHAf5khCWYGSZAdZBkxxMaV1t7eHKrhuWFB/8wz/EaMnsX30G2d0zIrbSrtofP3e+5ISc+bnsvW3WHtrM319BoVTG6HtEaaZY2gEDBQLyhcrRHoKEQb5eIIjEiMzKqs2Eg4gyEskyp9/DdCb2CgkuqU7ZXNydc+r8D5hT6tBBpdIqdcDkmB1jpI5shkFI+435r6YBEd9zZ+p5NGB8/Lazo2zQMIiMWOLe1vbgLth8k17TzAUntDb1BCUX6R1NGyAi15gX3A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd09fc32-3907-4d41-50d0-08ddcc3b0891
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2025 11:53:27.8509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3WZ+JETldXMt4JM2QbCWmzd+py6mZoINSX3apwAHiGyIFW/m7bt3MvXBrR/qLsgvRZJD2ABp2Rd40HOtXch0E5LQyvqnPJVaJqGD7WwAvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-26_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507260103
X-Proofpoint-GUID: pUxuvfhQRMxkYVnsQBZ_6j6JFFi-_rJm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDEwMiBTYWx0ZWRfX717W/o4FCgMr
 5y1tKi9KplftzipCWuPDVs9rqsou9j/xgbwMFdTT65wmQgjyQecMbvbfSCmAStnOJwhPo7nxGrZ
 7nVWGZzmVb3AUb0yQODxQSw2UtsBIj2K38Jyz3CUenQNnCscja/o2ci3ZQ2SQnTX7Jkv5U6OL0u
 hE20tISTzFoRXsl90Ge+pqqhRky6/Hw+i6F21bi+QV26b7kqwedR5x5mk9tjQav1OaTIdwJe8XH
 G9r2cVDZo7ZBii6GGxAto5ZgtGZidX3cxc693ZteS2E+4cjZEH0bCQyaWGANwX0lZ8+zSnru5QX
 dolegNVOt5uSLrQlZAduxxDald1L/i+gk14E99i8BofwBXF9+1thYFHCB+h/ivJly6LDvueCcp5
 +8MLUKbcgNOSmyvYkL1jJ4ccJ0UykEoRnIeJZnT0m9/1dEeCbTHC9BTIQoPDJ0xUCSIic8uz
X-Authority-Analysis: v=2.4 cv=ZMjXmW7b c=1 sm=1 tr=0 ts=6884c1bb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=8u3rQkBCUX-pkkivwdUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pUxuvfhQRMxkYVnsQBZ_6j6JFFi-_rJm



On 7/25/2025 1:38 AM, Horatiu Vultur wrote:
> +static void lan8842_get_phy_stats(struct phy_device *phydev,
> +				  struct ethtool_eth_phy_stats *eth_stats,
> +				  struct ethtool_phy_stats *stats)
> +{
> +	struct lan8842_priv *priv = phydev->priv;
> +
> +	stats->rx_packets = priv->phy_stats.rx_packets;
> +	stats->rx_errors = priv->phy_stats.rx_errors;
> +	stats->tx_packets = priv->phy_stats.tx_packets;
> +	stats->tx_errors = priv->phy_stats.rx_errors;

looks like a copy-paste mistake
stats->tx_errors = priv->phy_stats.tx_errors;

> +}
> +


Thanks,
Alok

