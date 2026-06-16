Return-Path: <netdev+bounces-299905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7HdfNVl1MWpbjwUAu9opvQ
	(envelope-from <netdev+bounces-299905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:10:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4C7691C17
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:10:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=kI1WPkwB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299905-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299905-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95F0930DF6EA
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFDA4534B3;
	Tue, 16 Jun 2026 15:58:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023088.outbound.protection.outlook.com [52.101.72.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5811944E025;
	Tue, 16 Jun 2026 15:58:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625529; cv=fail; b=Nul7YngrpUq7xentutE/eccvw3JdrxDptfIDqcBcYHOT+5me+tSBQQNoMHbLn+rdNacElXUdgvnw6D3i0PFZIFr1UzCxt5tdEE5sx+eNe9utaafyWl2kgog6A03iWKtMKJmf0+7Encd4ckmBeJ+NKyRrrWJbF9yD9ydg5z7Y8d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625529; c=relaxed/simple;
	bh=ZHaQ6DJ7lNcJSyQbSRQfChKjUQxeaP2YqVp7rZI0U84=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RDMJ2SoS64M/muLOW5npmGewBHbf+cC2Pt4yRaOe3hG1z+lMUQfMeX05h95dT4RL4yFT2t5At56wkFng/akT+D0qNs//+zNWlhbMEV3Us3Ox36pcingRU8BWL1exRF8ISDrqfW5hZS6cgGuRt7YEIamQQstLkfE73D3T8SWm+KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=kI1WPkwB; arc=fail smtp.client-ip=52.101.72.88
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+IsM+8n/MJgY8UMNNqkq3M6h9gD7Ze5U4rJIj0HtmKTISIC/GxrbEOvQw27HabBifD8wRHvh5y+g6tyuf/S+wgxo5qzfyBJTTwFeSNigFQKpcg5d5LWa7Dz947Qq5NgC+kqU+vpvRUx+aencQILOtBzJEtRsV3zLTxQ4d2FZ7GcgTJeziWTGh7lh3o7DpAG/epSG1ESuASksFh/mcLCnTogGRK6nLITtE/6e1JGeqj0E+iiWh2Fw7Tll/+X3F9hLDq/A+Nlcf2h6RbSCqI/jreHWmNrHnJuPERNShBM+CAkuW+x8Amr5F5V5BaQmtgPFsQ1edWJgobBTpoMlemQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7Y+d4v6F4piTbSWJGsNWnJB6g+gSLYwEXNNkWsCStU=;
 b=bpgRafRFc4dH93nfKmHkK0rgIWwq30ayDNFCJh2mplZkVnJobrm/P7hn//Wy5VvnTtb3k0KvxalOg6dI8Qk6EE7jrsR8vPAP+B+wlQevAidWU1OkeqyLvlcB8EtDq0DUbKNJ+HZtvTbWWOgvqtjR1ZMDdrvqhfawh790pYEk2bKhboN3MgxVbXhUwdY5RWlJSu2+0guma7zRTS2yYPumdjb+2TPFi7iu157KIbQg9uS/v9LYnI3dkIOnfAeYDvXB1hsIxgCUvL7+i4MErZ0aXn44rWFYS8K6GILLYlwC1Df/ofQ5/TTmHdx0sMXv6+LGkOpX5YXvAvIR/V/QC9lL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7Y+d4v6F4piTbSWJGsNWnJB6g+gSLYwEXNNkWsCStU=;
 b=kI1WPkwB4/H6eTA1pFYdfQCSC+9v15ErXJrYriJ4GEhQk/r8GSNv1w7WMtPInh8qJFfIc43zXR39frvax5R9Hv9/kov1XhXdOnubA4j86f9jUjdmHfX8+cNBtXzuF0F9kScOCbmweDLdHdwBOCX6j7YMsmqCQpbLVJFJq+4TYGZYXd6iJjT8ij39xfLxzWaK8SWUzmUDD9BLcADgSoS7ZGbqPZNnFB2GPXbr4nkJmW5rM76/MkUGLyJj0RqIJWJaticplL+hM5teGMUFosS+1uqJeSWiIx0xnYIeugFBjTPckwGYTn10N96gYB3GLklrngbLBb+du3CwJm1U97renw==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by VI0PR08MB10655.eurprd08.prod.outlook.com
 (2603:10a6:800:209::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 15:58:42 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 15:58:42 +0000
Message-ID: <021a6604-289c-4dd8-a0be-33c7812c0105@virtuozzo.com>
Date: Tue, 16 Jun 2026 18:58:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] vhost/vsock: suppress EHOSTUNREACH fast-fail during
 CPR pause
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com,
 stefanha@redhat.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-4-andrey.drobyshev@virtuozzo.com>
 <ajFUk7quPhbI7Te-@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ajFUk7quPhbI7Te-@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|VI0PR08MB10655:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e7b867-59bb-4a84-5dd3-08decbc02353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|23010399003|376014|1800799024|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	O75XKDp6VvFO8mI+j6VuajnBnpG+V3fhA2t7jZQRpht6P2ey+niQswz69EQ+nFLBt4RFY5J7DsxZ1V1sSWcYQu2052erwoZ+uv7oDJxVgvgZ313vLGNV4v9nNLpVhq6saYpb/JFk1QQ2vHsrrGQfQfAmYBNREBKuWYUsNTl8snaoG/NCJ3yVt89l/fmW88MWcDP9mc5BmCp98KMHIshYHBBAE6r9qSoJo4ZctaGzeomymYg83Va1V635OeijlKe3msSf+xxz9zjZTwwVKrFPnSrVR8zqtF5pogUsVnSsdlrYmKjOyTHvFNlcGCrvev2NDwWZwtvv3QLj8O2RwUb6oUrCr12BAP21DYo1T8CM9Vc5DjqFe5K+6SFasbIeDU1WI7RAXZq/ltKO1MZdtufe3GYnMAnqidrlmktn3Isr9cw23shcX4ueF7k3b22g62lDHjepul1oaLaKP22v2s7+NLFapg0Tv1PIS2FB7Ot6haC+rAoCVPF+EQQ9uvwIdudA3Ey/aF8j73r9E1Pjt7Vgla20aAhjYb4hb1BoEDBXYlzQhbnzwkw+xXJ+lst8BsZ/W8B/nIo/lHagzfumtFUDWM4rKK6smjZRFZG5WdQdi9/Q1uAL+7dzhk6DasS2Xy3Op1Jayksu5nOuyWkNw33vaPJu3DRI4JaSRv8XnLXTg99svpSx4gtkhoRiug2+lv1GRBh+PFPnV9hd2ibcgxo6Uw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(376014)(1800799024)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUJxb0FkQUcrZjVnUzlWUmZHVDZMd2xjVGRGejZkTmljaVN2NEdNU2k5ejVw?=
 =?utf-8?B?bHBxcWNjbWRJdDJsV3R4QkIzMXJIWUsrZUJZNGZIUTRHVXlIRWdXSzFOa2JE?=
 =?utf-8?B?dTdrL1FFaHBxVlRUaGt5Ri8vWUUweTdoSURkc3pvb3FBeHFpbnJpOThRU2dP?=
 =?utf-8?B?Qis3VCtySGVYQjkwTXdoSHNkTU5ka1Fob0w1YjhxSjkyVFdXZGVQVm50S3Nh?=
 =?utf-8?B?ZTRMZ2UyZzk1YXIrU3Z5UStiK3BTREE2M2dLUWVhWmNqei9tQUJNUnIxYjBC?=
 =?utf-8?B?Nk8zaG8vMW8rV3d6M0k3V0Q2b0JkVStjQjZVZlJMb2kzRlUyZVYwYXZhT1Zk?=
 =?utf-8?B?T0drbGltVVo3TGNDVG1pTW5JUnJqaGxwWDV1SzF2SHhNNVpJSGorYzVidmQ4?=
 =?utf-8?B?WklTN1l4UmpDWUtBS1VJcVJubHRBUmVMYWh4T0dVekQ5RVBmQmFlZG53QnNT?=
 =?utf-8?B?WU4vTkhYaERDaHkrQUlxTnVVWEVzSk1QdHJ0NS93YjFCLzludVNMUjhRUWlD?=
 =?utf-8?B?YW9YQVVKb3Uvdy9iZktaUWc2VWpQUG1hRERNTTlmcGJmSkczYjRQb3g4Kzhx?=
 =?utf-8?B?SklIblJLQjR1Q0VMU01UWklUek44T1luK3JaSFdVVHlYL05qcG9FeENlVFhK?=
 =?utf-8?B?bjlnNmg4ZmloZ0M4Q1Z0NVhaUVZYY1RObGN4RUs4cENkbGF1YnBVNkVGcXZn?=
 =?utf-8?B?dm4zNFVweWZUSXp6UEJia2s5UjladnAycmhSYUhJeEhGUFg4U3B0Y2dVcDJZ?=
 =?utf-8?B?K2ZlSFlxQldJKzV0R0s1YkFmcWQxWnhnS2tBWldvQzhhSVpTKzdnRHVYQWxK?=
 =?utf-8?B?dTNzcnZVMC93QTdvd3ZuVHFTb05CVEIycEUvR0sydi80WnpaR3FRVnN3Z05B?=
 =?utf-8?B?Y1grQy9ZTStwNE5BZUJTbTdtYUdrdFJSZXNhOUxIUWFSYmJReWlxWmxNVmxk?=
 =?utf-8?B?ZXRsbzdjbmpoRzUzeS8yb2swYTZlMnl1MDUyZDRBQjlkVENwN1h3MVNHUWFI?=
 =?utf-8?B?Q3VDNFF3SmpQeGRNN3NFc1MxVGE3aTZNZkxMRlE5Z3NxMG94bUpFR2c0dHVr?=
 =?utf-8?B?MllUVFFuT2pSNkZTNTg0c2VQRjE1SzJrb3JhSkZ6Mk85bHBIb0RPdHZHeGMv?=
 =?utf-8?B?M0Qwd3VFN2orK2xCS0tYd3h6aUJDZE9QWWNZMHVLeWdaUUM3eFB5SGcxUUlI?=
 =?utf-8?B?a2U4ZkhyQ3hUR0NDdUVKRU5YdFR1ZDlOT01ocEIwZlVZZExXbnJBT2JsR1BF?=
 =?utf-8?B?TG1ZSG9RSnV6dmtiSU0wOEs2dG5GQTg0SlVaTTJzY3RiWWdOVm5TOW9YYXUy?=
 =?utf-8?B?ZzgrQkVycDYvNXRGdVNtM2tqN3JJbHYrWlNBNHk2djBTOCsvbkVCT2xoL3J3?=
 =?utf-8?B?Vm40c2NBN3ZiaDF0OWRkWVpNdzNNOHJabzhVbEp5NHVsSzVGS3BlcGhVWitm?=
 =?utf-8?B?b3VWUjZDMGVjN0t3V0RmSXpwT3NMMW5WWCtPWXlrNThPMDNFZSsvUjJyTWhU?=
 =?utf-8?B?NVNmV0ZDMGtrQzJjZ2VOa3BTYTNqdytOZk9YL2x0Y1lpR2hGVUpIM3JRd1Av?=
 =?utf-8?B?Z3R0NE9OOTBuTnZCcmFBRFJFZ2JpaEUxaDZ5VXZTNktsVG1tOXZjSnoyWk03?=
 =?utf-8?B?OW41WUlVdWZhY001aTJHTC9LQlp3SWFQWk9FR3E0cTBWZFFZU0VKR2dmQmdM?=
 =?utf-8?B?UmtSb1EzUGpzbitVMVJVNVYxZDU1QXJTWlJXWUMwa3lLa2dpM3FyWHNZNC9n?=
 =?utf-8?B?Y2NzSGJkQ1lnZVpmM1o5cXkwcUEzZk1maS9TZ1FiSTFEdEJpaXRMV1RYZ0Ev?=
 =?utf-8?B?SUcrUWl3ZHF2YnhJVjZCWjJkbXRZNjF0SldUZCtSQUZvUjRLdEgzWGFmWG1N?=
 =?utf-8?B?MVdCcXNubDB4WisxRFJCUTEySDUyQTJ0Y0NxUW1YcGpqTDQ3RG9hVllQSnc4?=
 =?utf-8?B?S2JqaU1CWDNpM1U0VThuRDVnMFV5V1puSncxa2d2RkxRMk5Ubi8xQjB4Y213?=
 =?utf-8?B?MHBZWmQyU0hMMnF0dVhMTCtxdzh6ZW15YWNmNXROM2w4TWdUa3VmTzhyRXRp?=
 =?utf-8?B?Z2VlZjBpZ2phUFBzZHBjd3orVUNwcHEzOUdtK21iL2xSa1cwWW5lNi9OS2hC?=
 =?utf-8?B?WW5vWEhwOXpPOFFXcG1aMlhhTEdQTWhXaWhUS3JQNVhCbWJxL1UzS3lSeHNy?=
 =?utf-8?B?a2Nua0tMRk85dEdHdDhneFF0djVzZVV5MktFMjZwUmZLVzBRVnQzS1dJTGs3?=
 =?utf-8?B?aWx6dGs4c3BNQnhXcDU2Y2lJNkFDOGpkUm5mUUNNKzM2MTRzVnBHYmFkTFNL?=
 =?utf-8?B?UmJvU3pWN0tnSTZDYW1LMjlPTW5oejNRR2FiMTN0UHNBQ1hwTmV0cVh1QWlo?=
 =?utf-8?Q?Wks9jx8VaR3RZfqE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e7b867-59bb-4a84-5dd3-08decbc02353
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 15:58:42.1442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1Z/etkQReev4AmKY18dTGJUgSum2aq3VJazU3jsa5oDaIzShn/yRwcFlxZXgObzr2iXY76OhpDsHVGWc58sfIxc5OgfFOTPnJbhSJd5O/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10655
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299905-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:mst@redhat.com,m:stefanha@redhat.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,virtuozzo.com:dkim,virtuozzo.com:mid,virtuozzo.com:from_mime,vger.kernel.org:from_smtp,openvz.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A4C7691C17

On 6/16/26 5:18 PM, Stefano Garzarella wrote:
> On Fri, Jun 12, 2026 at 07:57:17PM +0300, Andrey Drobyshev wrote:
>> From: "Denis V. Lunev" <den@openvz.org>
>>
>> Earlier commit ("ms/vhost/vsock: Refuse the connection immediately when
> 
> Please follow 
> https://docs.kernel.org/process/submitting-patches.html#describe-your-changes 
> on how to refer to a commit.
>

I omitted the hash on purpose as the commit is not yet in the mainline
tree, although our series is based and depends on it, as I mentioned:

https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?id=bb26ed5f3a8b

So it's a different (Michael's) repo and the commit is about to get
merged (but not yet there).  But maybe usual reference style + repo link
would be better.
>> guest isn't ready") added a fast-fail in vhost_transport_send_pkt().  It
>> rejects every host send with -EHOSTUNREACH until the destination calls
>> SET_RUNNING(1).  The fast-fail condition checks whether device's backends
>> are dropped, and if they're, the guest is considered to be not ready.
> 
> Okay, so it's not a regression, I mean without this series that patch is 
> not adding any regression, no?
> 
> If it's the case, I'll change the wording in the cover letter.
>

Agreed.

>>
>> However, there might be other reasons for backends to be nulled.  In
>> particular, when QEMU is performing CPR (checkpoint-restore) migration,
>> device ownership is being RESET and SET again, which leads to backends
>> drop and reattach.  If we end up connecting during this window, an
>> AF_VSOCK client gets -EHOSTUNREACH, which is wrong.
> 
> Please add this change before starting to support VHOST_RESET_OWNER 
> ioctl in vhost-vsock, otherwise we are breaking the bisectability.
>

Agreed.

>>
>> Add a cpr_paused flag set inside vhost_vsock_drop_backends() when the
>> backend was previously live, cleared by vhost_vsock_start(). When set,
>> vhost_transport_send_pkt() queues the skb instead of fast-failing; the
>> existing kick of send_pkt_work in vhost_vsock_start() drains it on
>> resume. A device that has never run keeps cpr_paused == false and the
>> boot-time fast-fail behaviour is preserved.
>>
>> Pair the cpr_paused store with the backend store using an
>> smp_wmb()/smp_rmb() pair so a concurrent sender on a weakly-ordered
>> architecture never observes (NULL backend, !paused):
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> ---
>> drivers/vhost/vsock.c | 22 +++++++++++++++++++---
>> 1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index e629886e5cf8..bcaba36becd7 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -61,6 +61,7 @@ struct vhost_vsock {
>>
>> 	u32 guest_cid;
>> 	bool seqpacket_allow;
>> +	bool cpr_paused;	/* between stop and next start */
>> };
>>
>> static u32 vhost_transport_get_local_cid(void)
>> @@ -311,11 +312,17 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
>> 	 * the mutex would be too expensive in this hot path, and we already have
>> 	 * all the outcomes covered: if the backend becomes NULL right after the check,
>> 	 * vhost_transport_do_send_pkt() will check it under the mutex anyway.
>> +	 *
>> +	 * Don't fast-fail if cpr_paused is set, keep queueing skbs instead.
>> +	 * The kick in vhost_vsock_start() will drain them on resume.
>> 	 */
>> 	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))) {
>> -		rcu_read_unlock();
>> -		kfree_skb(skb);
>> -		return -EHOSTUNREACH;
>> +		smp_rmb();	/* pairs with smp_wmb() in start/drop_backends */
>> +		if (!READ_ONCE(vsock->cpr_paused)) {
> 
> Can we avoid this which is not really readable and maybe add a single 
> variable to control the fast-fail at all?
> 
> I mean replacing both cpr_paused + backend-pointer with a single 
> `started` flag: set it to false at open, true on start via 
> smp_store_release(), back to false on normal stop, and leave it true 
> during CPR pause.
> 
> The reader in send_pkt can do just:
> 
>      if (!smp_load_acquire(&vsock->started))
>          return -EHOSTUNREACH;
> 
> WDYT?
>

I don't think it's gonna work as suggested.  As I understand, the order
during CPR migration is:

1) SET_RUNNING(0)
       -> vhost_vsock_stop()
           -> vhost_vsock_drop_backends()
2) RESET_OWNER
       -> vhost_vsock_drop_backends()
3) SET_OWNER
4) SET_RUNNING(1)
       -> vhost_vsock_start
           -> for (...) vhost_vq_set_backend()

(Btw I just noticed backends are already NULL at step 2), but that's
just our CPR case, for any potential RESET_OWNER users it might not be
the case).

So the race windows starts from 1) (not from 2)).  We have no way of
differentiating whether device is actually being stopped for good, or
we're in the middle of CPR.  If we set the flag to false on stop as you
suggested, we'll still hit the -EHOSTUNREACH case eventually, and
avoiding it is the whole purpose of this patch.

The fast-fail with -EHOSTUNREACH relies on the presence of backends.
IIUC the backend will only become set after initial SET_RUNNING(1),
which will only happen once the guest driver writes smth to virtio
config register, QEMU catches it and calls SET_RUNNING(1).  So we have
ordering with the guest's actions here, which is logical.  But for our
issue that means that the only true marker of paused/not paused is the
presence of backends - and that's why the flag is set in
vhost_vsock_drop_backends().

>> +			rcu_read_unlock();
>> +			kfree_skb(skb);
>> +			return -EHOSTUNREACH;
>> +		}
> 
> 
> That said claude here is reporting a potential issue that I think we 
> should consider:
>      After VHOST_RESET_OWNER, the guest CID stays in the hash, so 
>      vhost_transport_send_pkt() can still find the vsock, skip the 
>      fast-fail (cpr_paused=true), and call vhost_vq_work_queue() while 
>      vhost_workers_free() is freeing workers without a synchronize_rcu() 
>      — risking a use-after-free. Also, any send_pkt_work queued between 
>      the last flush and worker teardown gets its VHOST_WORK_QUEUED bit 
>      stuck (the vhost task exits without draining), deadlocking 
>      host→guest traffic after restart.
> 
>      A synchronize_rcu() in vhost_workers_free() between the 
>      rcu_assign_pointer(NULL) loop and the destroy loop would close the 
>      use-after-free, and reinitializing send_pkt_work via 
>      vhost_work_init() after vhost_dev_reset_owner() returns would clear 
>      the stuck QUEUED bit.
> 
> 

Yes, this looks real indeed.  Though I couldn't hit the UAF issue while
testing host->guest transfer under KASAN.

>> 	}
>>
>> 	if (virtio_vsock_skb_reply(skb))
>> @@ -640,6 +647,9 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
>> 		mutex_unlock(&vq->mutex);
>> 	}
>>
>> +	smp_wmb();	/* pairs with smp_rmb() in send_pkt */
>> +	WRITE_ONCE(vsock->cpr_paused, false);
>> +
>> 	/* Some packets may have been queued before the device was started,
>> 	 * let's kick the send worker to send them.
>> 	 */
>> @@ -671,6 +681,11 @@ static void vhost_vsock_drop_backends(struct vhost_vsock *vsock)
>>
>> 	lockdep_assert_held(&vsock->dev.mutex);
>>
>> +	if (vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])) {
>> +		WRITE_ONCE(vsock->cpr_paused, true);
>> +		smp_wmb();	/* pairs with smp_rmb() in send_pkt */
>> +	}
> 
> Why here and not in vhost_vsock_reset_owner()?
> 
> Also having this here will set it to true also with 
> VHOST_VSOCK_SET_RUNNING(0), is that right?
>

That was added here precisely to cover the vhost_vsock_stop() case (see
above).

> Thanks,
> Stefano
> 
>> +
>> 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>> 		vq = &vsock->vqs[i];
>>
>> @@ -728,6 +743,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>>
>> 	vsock->guest_cid = 0; /* no CID assigned yet */
>> 	vsock->seqpacket_allow = false;
>> +	vsock->cpr_paused = false;
>>
>> 	atomic_set(&vsock->queued_replies, 0);
>>
>> -- 
>> 2.47.1
>>
> 


