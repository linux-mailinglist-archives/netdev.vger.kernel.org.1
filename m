Return-Path: <netdev+bounces-297982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ixROOp5iKmo3ogMAu9opvQ
	(envelope-from <netdev+bounces-297982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:24:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAC566F5AB
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:24:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=jhBijYC5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297982-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297982-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08E2D3004DBD
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0323B14D2;
	Thu, 11 Jun 2026 07:24:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A53A3451C6;
	Thu, 11 Jun 2026 07:23:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162640; cv=fail; b=jpdHO78oJ3wcdSZR0R7LGbF9bWsp9ZKfshsTcujNFEfLIJ5WEhN2epsd/7IdfVYfm1ib0pG6mA9kGXl+s2lLJqd5W2hoI+TfbnsBaaM5Utd7yaOmWuDE8wje0YbCdQ9cjoLi4Rxw3iw4aRGocxejRVwEaavFwqAUZP29ajF9Xe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162640; c=relaxed/simple;
	bh=SvtjaAsXVRifJGVNEOEhVMe7OeVv2tfvgkXUW0e3ZMI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mk7up5LMvKYnPgfUMlV766LzjuGL3dfzK3UukqNEZw4Fm5KXgmMCMismmHLMM91yWK2FWqi7MH3SgSm9RNEZPWJZ1QxosFhhhmeRb8oRnRUCYP5/j3NjjtQYr34X8/Si3/VW24HgXCvHlsaFI8LQDA7Uyu454z+P+MGiQm8CkQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=jhBijYC5; arc=fail smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B4708C3057385;
	Thu, 11 Jun 2026 00:23:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=cZhdwl4xNQJsZSmiw5JHL0CozW4tM1pfnS/XiSaOZQA=; b=
	jhBijYC55Krlee25CfOVsN68dbxS8To6RNjGK94ZfR1nKCPj08zTK/A+EYCpz9xV
	GCI2KsrIltvmnZQceG/0KicHbqNnA/JM2JfgY7Yjk4A+3GAryLt8DkoLRNAHCBsb
	p6PbSuLfUlyBJKetutZVfQ4KpgeqvfKFSclAOxozibsBy3PHH+YmZznbZbapVaIV
	8G7IvptAdB3YXW6cxKnVnL4j/slWE1UoIaMfC2eQWJVcZhU0eFVRXGe58zxiukEc
	b/lX/ZFCxGFP/czxWaVs8+eJzOshH0mxr05yVXvdJLaZKNoTzHTD7HYUtESA0mXp
	nag7OqOBYm8oExyYXentRQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eqe7agmym-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 00:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uj/5shC1h6rHVnuXkoe5oOBSQeV0MSHifRJWI5I4sT0kTOxKeNhuIx0S3NMc5Eq6+4e3zXUaAECGlPVg5KHkGHpMjxByje2wHZ/++c2ECAn/Bgdlj42g+lyT5DS23Ffijz7HzsybC/VECwA+Y4Cp5425lYrilnKPGbhC+yhtP9ctvPTUbPvS5sv9HqDJc7FR/1i8wnCsos8dHAXa4b1KoDRKaHxidTQFiaFz16kGuHwuaGN3vr9wH2CV+4f1VNovvyoTpTuwrNwW543cYWidChIY4Gh9/JOhhtKqT5ePsaMKrAges7N9eCx0D3aG/3jSK8bNjuT3aVT6d1bvGqQ+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZhdwl4xNQJsZSmiw5JHL0CozW4tM1pfnS/XiSaOZQA=;
 b=KWIFNcLL2bXPzi5YkDWkydRwXJLWAu0jBNSJ19eZThq6W3RAY8rO0rl6cHXgW1iRWQayuds7DXtff2eF4Gk+L7EzG04ENp6eKEzgi4NgtqtUaK5dJuzkT+Ki/jsLJQTOf3/HmZ/bdUsgsuk073W2RsVCcgI7KvjXX9w8lwrBbKEi9viC0EsFDSpP0oUku58QaY5y5OnJhtiOdSOY6tErKGYmptaACwcSwIltNn1AwhmM4xfsmSZ+mCwEm5EB0hJIpwOVvPg4q34z2WVQuGKTihyuodhamb0sv8f2ngzu24jprixUfQBL7g3MYlOVSlBY0bW1WsLUWi60YizUn4VZuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by IA0PR11MB7814.namprd11.prod.outlook.com (2603:10b6:208:408::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 07:23:18 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 07:23:18 +0000
Message-ID: <9515b103-7d78-4d24-bd05-005b2fbce0d1@windriver.com>
Date: Thu, 11 Jun 2026 15:23:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mvneta_bm: add suspend/resume to prevent crash after
 resume
To: Andrew Lunn <andrew@lunn.ch>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260611020935.1933865-1-yun.zhou@windriver.com>
 <922113c3-7fd0-4f15-9fa0-7e9a540409dd@lunn.ch>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <922113c3-7fd0-4f15-9fa0-7e9a540409dd@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0344.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::16) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|IA0PR11MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: b13c048f-784b-4956-4ff7-08dec78a4f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	jSgeIHYEM153p/ODOdz+Fz5m2h1YEx96UzhilqgQWAT+gxdCceG9FplFts+xnpaiixBWIHC3/tCoOFr3s6QXOTfHgACu8qLFadd5CMqnp8tq6u8L6+LUSxdVxdUUpg/JFJmU4pPELyEMhQMoSjrg0Yvt2NIQ4Mxqpyo3+1dwwT2dUzjo5jmxfCix1aIaqeEXqWPXzIJ4D2azcMV7/8JLJ0F1YFjlBdsbjB3hoxTFE0nSl3jnN76isFNWf7Onl1rwCOgJHBaPH16Pb2XkxVFZNp/85TQxPvvU5gB4gSiNb2o+Dmoto6LFfj82/SzDWl66uU02N44y8k2yv5vzoRVWNVxLJvYMXxMk4W/w3yhLqfAlAoUKHrIln64HywHXm+8MOHGOJ42kqPHjfM5qlUu0XFtGNaLPoDuUjbr8d9R9ezHaT7sLG/+P5QtsnzMj9UXx9o3U9dTVna676tQcj9j0z9AyjIfrn8QWCxsaW9+V2JUOKoJxMTF/6CuiyT5bK6O3QWyJsf6A7TmqI3b4Lo/QO+qRluO2ofNcNnI8PmC9GDXEK5Rqztom/d11Nk4qdAuzMLRgCUoUZfXRfFG/fC4845U/z9jj8j89A+ILIVms1NKoDPUUjd5ls01ZNh7/kj6PshEDbd/qmEqxQoR+XEzbe5+uH1GtcT6JzN4qKMFg3uEx4wAbASFdIA7lPxDCA3NO0qMqgftzqTvj/ueoPYWhVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjRTZnExUldSVkZFeGU3dk1jV0F5akc4cTJkcTJtUHBoMk9NdHpvNDZURVBw?=
 =?utf-8?B?R2hYRmhyQXlMaDI1eDZiQWVmSjZUbWF0VncvTlN6TTY2SnlUaEp3b2NVcjJz?=
 =?utf-8?B?UmdEUCtZaU53ZXVoUHNtOXFETkxkVzRiN1FwbnhtVFF2YzYwVUEvZlEvWTZq?=
 =?utf-8?B?Y0tVZWRBZHZuV2pDTGVlTzRmRmRDZjRLQ2dGV3dRa0xEKzZHTm9zMFhrS01v?=
 =?utf-8?B?T3NTVDdxQ0pSc2d5QUdPRVFvenJQVXZ2UmZkVUN6alRUWHVqTVRldzQwVkxp?=
 =?utf-8?B?RWRCbTFvajEzb2kzUFB6ZjA5eHdtSGZWQm9IditIMmFGZzVseXlRb0ZlQUtE?=
 =?utf-8?B?WUV2YmdXQXR4d01lMlpHUmR0a1YxZmVOL0tPa0R6WWFKazFHYUxwMXlkSUtQ?=
 =?utf-8?B?NUY4WmphYU1NZ0M2dXlGa1lNVnR0Mjl4RWdIUVZJNDdDazVXUDdHTUNqWllm?=
 =?utf-8?B?aWlDMUNkNEd4bllRYXlRL1NHcGVwcDI0NjRyeGVzV1ZEWDlLRSt4cDVUTVYv?=
 =?utf-8?B?dDdtRGc5NHlGc0F0YXZWSUcyaFppNmxNQ0E2RGEyNkxFR1ZnWlI1a0h6WmZ4?=
 =?utf-8?B?T2R3eUZiSk1Xb0V6aUVzWjVvbEt1akJURG13QmllVndEMjE2bWlaTG9Ib0ZS?=
 =?utf-8?B?dkEzSGg0WmVEclRkYVdtc0JaNVI1enk3dmxzVHplZldxSDdpS1gwZDJnSEV2?=
 =?utf-8?B?MnEveVkySjBCZ3NnWHYzRzY1NWdFM1RrVFB1NzRsTlNzTlVWa3dXbHpodCto?=
 =?utf-8?B?U2JjaGlQUEVWdGRBREdHTU15cHRla0VIQUI0RUFxL0pUUm5yYUZjdDB2UGlw?=
 =?utf-8?B?bEQxM2tzRU91dU9CWlhQUTNraGM0WkVDQkFHcFU4TCtGdE53eU4rVUhweE05?=
 =?utf-8?B?N1p4bkxqSmErY1hodEpyNGNNRE1VeURYMHVpbElxY0xvQWk0MU4wSEc2cnJO?=
 =?utf-8?B?Z2h1UTNmRHA3U1ovbjQvVUlNdnVkYnZpdWoxVnhZYUgyQnBybWtJeFZYeWtz?=
 =?utf-8?B?RkNFbkp0S3Z1U3RmeldiY084RXM0ZFBnWkFkT3lyVVo5ZkZ1MW00N0hqeXpk?=
 =?utf-8?B?d3RkVUpLd1pncHRVbmZFeDdJVklLYW9pNyt1ZEdUQ0dHMGsyQlBWVFdoTWEz?=
 =?utf-8?B?bnJsc3BCa3ZkUDVzUlNFZjFMSkMwTTE4WmM2QXJEa2cvVG5NckJVd0hxZm0v?=
 =?utf-8?B?Nll4M0VLNTFjM1hzV25mSzBvbkFUaVdlMWZHZXFUbFFvckRJMWRlYUdWZmFy?=
 =?utf-8?B?T2dKZ2IySzMwVTFmUlNVUEpPNGZ0R0srTVYyYmNtcERucWVZeFZpelZob0l3?=
 =?utf-8?B?TnZZS3hiMERrU0hpS2JTZjAwSzlZWHM2bXkyNEZSQUxrZ0ZlRmx3d3o5ZXpM?=
 =?utf-8?B?c3RJU1RiYUplOVJKc29UaFVmRVo2YmV1WnUvTTM0cUVpVmg5dm85anFPZU9V?=
 =?utf-8?B?Vm9ONEZKMGZpaWpHOFdSekpqTmxOU2NtWjU3NTRGVm91QXlUNWhjRU01YmF1?=
 =?utf-8?B?Q3c4Y1NPZWpZaVRtbXlnSlZJZ1BDWGxKWFRMbWZ5K0pXQTI5TzJzdURpUCtq?=
 =?utf-8?B?UkdBclhsT0NRblVIdnRjNzFQdXVDZ3kzN0VSYm84R0NpbTBDVlVUNnN6WGpv?=
 =?utf-8?B?azk2YklnMllaTG0zcDJKSHl3K2gxWVJuSWMvVVoyT29CdmRZcENuRWZudnY0?=
 =?utf-8?B?V3QzejV5Ti9VekhQWDNDRnh4Z3JGT1FZWkp3eUVTeVBoV3FYWDluTlBPb0tY?=
 =?utf-8?B?SzRUOGFJQ3JKNnNSSUEwSFhlWDFpWDh2dnl6Q3IzVmJaU0wyazkwRkZleXJV?=
 =?utf-8?B?aEpObFNkMkZZNXBwNkJWbFJkTmk0OFZiMUQrL2xoeDZUalpqZjVZTUVvbXZT?=
 =?utf-8?B?NjUxNDUzVXhuVXRxQnhYQ3VsMHY0VjVGWjdJa2ZQQTEvTUZOZzNDR3k3NlJV?=
 =?utf-8?B?VXpZRThsVU9rZWNxeElRUHlGbU9PUDkyOHNUdyt6SGM3L3krOTZ4ai9Fa0p5?=
 =?utf-8?B?N01RK291V095Z2diZldoTFEyak5Ha3NNTHpNK1dZR1U3d0lVRHpMOWEyM3lI?=
 =?utf-8?B?Q2ZOOTl0QXM0U0ZvQmdCcWNDMk14bjVlenFMejRyTGxsSDg2RWFqeHNrN2Yr?=
 =?utf-8?B?dXpNb3dEZXlMSUZTKzl0TnBTU25ZMy83SGtCQUJlQ2FjN2NYOHJJR1NCVW9O?=
 =?utf-8?B?MzFOdmZWUGdUK29jaXJYcUZndXZCd2J6UVZxQy8yVEh4NEN0RVdqMlR2ZVBq?=
 =?utf-8?B?T3ZmTFpZY0JacTBuc2xicDhTaS9oNERNV2dlWXFHZFMrVUxMMitsYnIyTTF5?=
 =?utf-8?B?M3Rldzkvdm00YkFpVXJmOFppby9LbU9ZVzRYckc3dG5lajJjZkRadz09?=
X-Exchange-RoutingPolicyChecked:
	n+cqlHE8WF/1U8JmWOvqyv4Y+N+4Ixl4JZc8fdGdyHU0NM0kuD3cGj2bXuyp6Uxu8Z/NNSuRnJRHalMqxOJ+1pOS0B3Wwq3ByOx59mOsyQOwwqxWBfIXZhxJ9D1ieK8U8M1Vtpavh0o6ePOoWhsQ0GpGPSZrzx39kTvOYeXEBAVKkEOidUzc6fVzqwUT8Tp4gYQe7Sh91nlM8rk0du2jkevaFlDk3ANlTbLxUP5YPSVnK84mbkpp1sdCEGRUWKxBjKmNmedD09bGimP+UJFG+zMO/eAulitQ80fe2GHnafDLbsrfRJEXZMm55qW2NzulYQUlxMHJapTIHKy4frZAyA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13c048f-784b-4956-4ff7-08dec78a4f41
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 07:23:18.5092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kpu85EmEZxqAZna7PYi4L6pnCnyjHdXICij/zupSo+5MnCR0FmuSJ+ewHjaYQq2Nmbjs9SgfB91+ShY8eq4wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7814
X-Proofpoint-ORIG-GUID: rWQs4gXMqG7MhRyAyck2bQNNTLSYSkTf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA3MSBTYWx0ZWRfX9kHD2TUps7HB
 J4Ln/UVNDNFmoXp50YQVBYKODwz3i/vtIAAJUPY66hbDpJm0MoYlB6RoJzCG2nFVssW5zfhQeqo
 lzziNAwvbzyJZRu0KFQg7zeY9SwgRqkGzwi4Ov96CsjyV0gg+N2BONNc4knUmcIuK2DPhT+CMyG
 IOFvH6A30bh97xooDiwVfUGotjCuvJQKSe1tcvQnIyAhkytWoalgldLb22hVY0YevoaiEq1O2vX
 FjzzcVXMwmMuI1BjGtfcVAJ9v8EASBPJyUWA84Z//Bmw+LcifcH2aOiXuUoA0PJqiIkOeQg/xiX
 u6IrtXLQbepH9p9n+U38vdbsuuv2XsIm1x0zpkBFxH6wfhGKYHtk5YH+brSJWlWn1FrK+KsxSeh
 KosuplxUEoR//V28NPmbUKwQ13wqNsQ3iU/Sh9Z7R2J4s6BLj7G0KN1/OiIXt6YVpRXmWt18o77
 BgzYBR3bImfBF0fN90A==
X-Proofpoint-GUID: rWQs4gXMqG7MhRyAyck2bQNNTLSYSkTf
X-Authority-Analysis: v=2.4 cv=P+cKQCAu c=1 sm=1 tr=0 ts=6a2a626d cx=c_pps
 a=NVF+LlzI6OJHpaJcpVMg1w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=VwQbUJbxAAAA:8 a=X5u80UryFcd0JUwpOTMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA3MSBTYWx0ZWRfXxu3+XyxPpG9B
 CSZp4bB3gl58HOpSkpcgG4IeADr+mYPDwdzysaNgUCq0NSftumK4TTufwUqyB6INRbEupUDtcnZ
 lctK5/1G4M0ZaB1saFLt59SO8IWNChqt6Dr0018yFDlf+miO6RPZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110071
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297982-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marcinswojtas@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFAC566F5AB



On 6/11/26 14:03, Andrew Lunn wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Thu, Jun 11, 2026 at 10:09:35AM +0800, Yun Zhou wrote:
>> The mvneta driver uses the hardware Buffer Manager (BM) for RX buffer
>> allocation. During suspend, mvneta disables its clock, causing BM to
>> lose all buffer address state. On resume, mvneta_bm_port_init() re-
>> attaches the BM pool to the NIC, but BM hardware returns stale/garbage
>> buffer addresses. When NAPI poll processes these buffers, DMA cache
>> sync hits an invalid virtual address causing a kernel panic:
> Has this never worked, or has something changed recently which broke
> it?
>
>          Andrew
It should have never worked before, because the mvneta_bm module
does not have PM related support.On the Marvel Armada XP
development board, if try to put the system to STR while there is
network packet transmission, and then wake it up, after a period
of time (a few minutes or an hour), the crash mentioned in the patch
will appear.

By the way, there is more than one issue on this platform that causes
STR to not work, like this:
https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git/commit/?h=gpio/for-current&id=b9ad50d7505ebd48282ec3630258dc820fc85c81
I guess that the vendor may not have verified STR.

BR,
Yun

