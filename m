Return-Path: <netdev+bounces-287503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KZwNMVHBGrNGgIAu9opvQ
	(envelope-from <netdev+bounces-287503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:43:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCB7530DC0
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 754F730361AA
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E011B3ECBEE;
	Wed, 13 May 2026 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ukfgvV5j"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D803E9C1B
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665409; cv=fail; b=rid1KZf7xtMkJxiU1XksjlZslUx75RAIQF1iJQFMls4j445c98nBMqhmiWBh2X1M1BHitUmjkO9+Lp6k+nGk/xyf+KCbdd8d0TuTZN4NEKx7Nb8eUlHKlJOU5EKxxEovA9XEEcxs7GtcR2ZU+MvZyKpzO0XgtYQ0UziK958gYpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665409; c=relaxed/simple;
	bh=karB60QqZs/1Y1SoNQ4sQbizQypSmvyb+zQ4uKPrX/E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n+gpzL109d2oyxPHsyDkxai4BdoWzD+TNbMRc0y//hLCo67DUEyCFHx64B+ES1ooV11tr/Kj0Y8pQqKQWCCx9ZTJx5jUO7CTaofpP1RIjGhoJpW+zp8CurCQbtSqCISXm5SM1OzgDon9BhQ+MIOTBO8FBl5rc/1MRNo+7towzTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ukfgvV5j; arc=fail smtp.client-ip=40.107.209.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThXX/4mXX7LgX8pwsmq4RYYvmjrQc/xVpWkBFpVttJrKAw4/wI2ckF+keuIRq+kEtj2gfuqZFYtjXpoQo9VcwMtu1PMsrLUfO6nSNEWycXzocUz0xntyS0cOwknSPoYRrAVQchlrWaFogKNVdH5i3MoHicYfBAqL41C2Q9GMyfbCgYv+HRq7QVyeJK5iDfNimyefLIU8t9wfHAgIy44/Lo+fZB5g/i8tt8smtmoo++R5E74vRSuMMdmAx9WVt1HNF8/QZuvqaKTRrTw/8ckmnaTJ2XtwKZPyM/B/SIDEzbLaOZwz3FI+GEP6/Z3oDMe3mjeKbWe4KHx45l35qxtxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg01V6skBObv+f7xgZnWw6XbMZn5PeAGZlANtXCRGZQ=;
 b=lX8BLreJK8kN7MGjbPHoDJmrQ9k8lw4AoEqCQI6GVzRgQndBZPUvSDqGpCVpLVBKdzNqldPJXlD8y3iawtxlauRnRsYFpZmt59eFfglFjyCi3iGqUui0GeL+lQ56pTKGGGQGcpfJxns2HH0NYYGrOYwEA+AXKs3XK3+GWywplgcK3NNHuu59plsoiDUJT0h4DChM2u3IZOYGY4tYELrjLDgRfwuNxX+DQG57qvIgu29wHPlUj6jFOWohyhAT4+VRkt/ymhoAS8b7/ZV9CX1gmMLURWji6/nI8+5Ft+EaT1QbqyhOWJ+xr1nta0Fkx3RWlwAf3NS2ayXozu5bObF7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg01V6skBObv+f7xgZnWw6XbMZn5PeAGZlANtXCRGZQ=;
 b=ukfgvV5j/MW2EH4TNlndz7ckwNotJ0htb38a3thKpyUF+cQlC4QCMN6f8rQYxY1j45axec8OLKkn5BOyW/hHR2DzUY3is/vrW89IKfKOVdWdH+ORXYi9bPmPxNrP0oenSJPl/AMaJKbQY1pJkde9vK0I36u98qsqfIDgQlnlKAt98ntTlgJyx1H+OID+4+VkTgcaSfVQeP23WZLT2MYTey+FnyIsuhBFh4SBjLu7CdwkSvOVLik2/kADwAnHPaI2bzxDhZQ8I0OzqgQVCHO4Vmt2AS0Tu2Ol5MtsDvZ60JDQ8ZSnHkiT6GqIs+AiBGZNsdlldF9+xYAmY6XXAFwQiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by IA4PR12MB9764.namprd12.prod.outlook.com (2603:10b6:208:5d0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 09:43:22 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 09:43:22 +0000
Message-ID: <f356add6-e173-4020-a8af-8cc70aec955d@nvidia.com>
Date: Wed, 13 May 2026 12:43:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] udp: Fix UDP length on last GSO_PARTIAL segment
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
 Willem de Bruijn <willemb@google.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20260513074349.2152146-1-gal@nvidia.com>
 <f75c1cf5-b5ad-47db-952f-faad9f0a33ed@app.fastmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <f75c1cf5-b5ad-47db-952f-faad9f0a33ed@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::10) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|IA4PR12MB9764:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b46e744-0247-4bd4-30ca-08deb0d4122f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	V0KxveELZ4Lb7n1IHQ+mwAxtiVSW9Y11jkxgOdBiDPhhuvhtVcg0urXmAuwDiTNjz2/hpvYZeUz/ijXFCD8D6r6mHvCnhhYaQltt08nEiFL3B+KsfPvv9NyiphbUcHk1WhOtreiuCbBsvFBX3JfBPyQxTDglUsRGYVkTee2KKuRc8HSw0qyRgd7M7+6fMBmCZlbz4F/uln3JmosttFv2MmziUEwRssCmGvF7DYak+6on6/6Lajk6HESefUlx5tEXSRuGQH2KMKsNAuI7yUSEfvIaP3KdWL/V8sPIPRHn0kz6/hMmzS+ywyQfPW6/xFQ4Y/0lAkNyjqlLZrTWQiS8YZ4Cd2GZeaxYr4yEu6xsYnu7skFNvYqIcBTOHbvH+Wm6PTRoRxGimfPRj+yjlcVEXXhHfdnUxkSwuMdE1wDwzA6GWhlAZtA9I1JtY3b/E9Kn3H6pyuKZwqGnDoBK/aGtbTgFqy91jvN9wY/+aHhfov3kkBdb/hfya9vtQl4M363LqWnjZAgyXuG2893p76kUxwrDyoGoqG8NIWfmR21fcOjdfSSsYopRMqy2JqeATEZcHTULqCj7Dckk8878J/KWFFMWsi0Z21iEyTpJEMK6XIwzv7hYyjX32mSVpK++faM7P/Rt7d3sl5URGcOzpf8XkIR9XL7ajVB0Mc3K/T99OMpY1S7FyKQSdm/SZvOIdRnPsMFvKGsbCn7a3SKosVuepg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXNZYmdGQkppa2tHcnZmcDcxeitEQjRLTFg1R0NoT0tkMGwxOUFNdWx5Nkl2?=
 =?utf-8?B?eTFVSzBRcmFUcjQ2em5DNlcvTmVQQ012MXV4dHc3eEcvWGQwNWN2aEVFRXEr?=
 =?utf-8?B?VWRBM3pFeUhKZ0dCTzZldFpOY0dPaURMSUhIVHFyZUhmcHpJMTF6eVhIdEls?=
 =?utf-8?B?VHJtSlUra3orVnVrSzFrWTRhTVRiRnkvRkd0cFVWRUtuNUNvNmhBeGp1OUVV?=
 =?utf-8?B?V3U0MWR4STcrSmlXNm1Ock1lM2ticEpINzhENXJ0MnF1YnRzV0ZicW9rdk9m?=
 =?utf-8?B?aHVnbVFrZkZLZEV0NExnZnZPNTc1SHV5djFtdVRtUktRQTVLSmVJSWpPVEp5?=
 =?utf-8?B?dkpVMGhRMWp4MEppM3Z1WGZvdXVuVEV1SEJveTZ3ZzFkMHpvMG9DOHBmS0ZW?=
 =?utf-8?B?SUp6ODE5TTVlbERNeldoa2ZyMFZwZ1Z4OHZCL2puV0U0dStZdXhUdFZ0cm50?=
 =?utf-8?B?a3M5UEdXVEptcjVmeWVlcm5IOFB6dEUzb3BndDRremJPOGRMbmhwcGZoaW51?=
 =?utf-8?B?THFWZU1PU25CY3piaXRWcnRVTkNXQnY1dGc1WlQ5bnhXTExlRGFvR1pjVk9O?=
 =?utf-8?B?dWJlb2FpODJ1T25YVHBIMk51ckJEaWJQNW9nem81bVBPZTJiMjNLMitVZG54?=
 =?utf-8?B?N1RCWk8ySUUzcldmVzRvMmtVWVhCQlRVUlZ3dDZGVGRVZU0xQy9CbUpuWXMv?=
 =?utf-8?B?bXZER1dxeDZpV3NvZXkrL0IyTFdoZ1ZoSUJaWVVtMnBiem9naHlJRmJqeU1o?=
 =?utf-8?B?U0lqQXM4aUpSNnpzdE13eXBQeWRibGRkc1N5S0dMNnIwMHZCS29kNDVEUlVD?=
 =?utf-8?B?SUQ1T0RnWHI1bkxja2tuR1RoMEs5UTdKSFQxY2J0SVM1a05xYVgwYXQrcVdW?=
 =?utf-8?B?bUVxTWRWazNtQ0EvZ0F0ZEJsalRuWjhHTWhTb0V3Lzk4SEVtSmxQNTRQMTB6?=
 =?utf-8?B?OVhOWlIwZGZiVGpxVmdPNk1QY2pnRnJaSHNOVngxK21vNjJOSEtxb08zelFN?=
 =?utf-8?B?M2lsVTVkUTJOTHBydVgxN0Rad2pyWTFGRDNzREgxVUpialh1OTIxNXU2ZkFv?=
 =?utf-8?B?TnUzdTVBYkpaK08wai9BMHBrTm00RlE4ODNsN1NEWkxHRE43Kysxa2NxZzBo?=
 =?utf-8?B?RTM0ekZOcGFrcjJWR2ZyN2tOT2UvZ0xpWmNJWUZCa1lzVzA0aGZwYktNUi9k?=
 =?utf-8?B?RHZmVG1JWkxIdktaWHpGa1l2L295K2RqeW5MRlU3NTlHZmRmckY5ZjdRM0NV?=
 =?utf-8?B?cU1ZZFVSYTN4akoyQmtKdzVWWlo5WnkrdEs0TmE0UWY3N0g1U1ZuQjZ1cjMv?=
 =?utf-8?B?cldZTDgrcnYrVTl6YVVDdS80R0hCajRaeTRYV1Q1LzRlT2llTE5IVjlNOWdJ?=
 =?utf-8?B?aTVVN0lwSTlueWJxWFN6d0dLOEMwYjUxZVg4NlFlY3ZpZ2VWZ2lVL1BnM0F3?=
 =?utf-8?B?WHB3aFV2MkowSXNjR1pBZkYxUE5vK01GZklKb0loTE01SGxTZGoxM0xJc2c1?=
 =?utf-8?B?aTZQL3hsUERGRnFiTVJobDFQYnBQakIxUWgzS2l6Q1R2OEdDTGhkL2Qyblc0?=
 =?utf-8?B?WkhFVnRIL0JsYUhDMGNoTHFoNTE0Mm1NcnBLWmtpNG9PSW5xTGoyeGdDYlhP?=
 =?utf-8?B?ZEtHSnRGZGhUK0NUYVcva0JvTnFianArd2RWK3ZDWFBIM0o1ZUZzQmp2ZzIv?=
 =?utf-8?B?Z0wyNVZTSEtGdkxjQlFGOWRIMENvd29nbXpTdnZydStSMk9wT01WYVJER2NH?=
 =?utf-8?B?bWhvQU0rdTdQS2FWaFhBWkFUUzE2b0VOYmhqeEw2eWFqQkoxN211UTZVaEFT?=
 =?utf-8?B?SGd0dWduZEtacUZXNTlhUDRCQkIrWGdZL1BhaHVMMDd5cDJwWFhWT1JUaHRk?=
 =?utf-8?B?d25xeEtCOWdzL3Q1VythRVhCTUxSVlRWa3RQclM1and1ZjVidTAycjJZR3hS?=
 =?utf-8?B?UHhNZmNyMXJSOWdudnBLQTFKTlJLUE5lMGtISEsvbE41SDVFZ1lpVTVHUHdN?=
 =?utf-8?B?L1VWNFAvMTVLbzFzY09EUnR1NEI5cG9jTHo0NWZuMmNKY2dES3B4RjV2QmdE?=
 =?utf-8?B?YVd2S0luZUJYSllhS0RrL1BDRzBGQkgzN1Y0NmdWUEYvUERsQ0RCaUZDVjY5?=
 =?utf-8?B?MDB2dkdHWnN6V1VxQlRQSm83L0E5VW1YT2pKNWxoa3RRelJKekROOHE2Mmsy?=
 =?utf-8?B?RFdXYmp0TURURHhxT2k0T2VxOEo1UVBTcXBjelNNVkkvbjJ1cUFNTWhuSWsv?=
 =?utf-8?B?WUdYcFNoSEFVdzRDVHdUamd4bmtCYjVhMUNsVlg4SlhZSEJvRnVsUTEyays1?=
 =?utf-8?Q?V6c1fQTjor53DbrCaT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b46e744-0247-4bd4-30ca-08deb0d4122f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:43:22.0130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cST71QcV33HaVTW9NsQ81BXQefKWKHjMpsXuIyUJGPRErtdHrvtShC0pes7s3COX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9764
X-Rspamd-Queue-Id: 6DCB7530DC0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287503-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[fastmail.im,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 13/05/2026 12:17, Alice Mikityanska wrote:
> On Wed, May 13, 2026, at 09:43, Gal Pressman wrote:
>> Following the cited commit, __udp_gso_segment() writes single MSS length
>> in the UDP header.
>> The cited patch doesn't account for the fact that the last segment could
>> be a GSO skb by itself. This could happen when the size of the packet is
>> a multiple of MSS, hence the first segment is also the last one (there
>> is no need for a remainder skb).
>>
>> When the post-loop segment is a GSO skb, assign the single MSS length in
>> the UDP header.
>>
>> Fixes: b10b446ce7ad ("udp: gso: Use single MSS length in UDP header for 
>> GSO_PARTIAL")
>> Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> Closes: 
>> https://lore.kernel.org/all/6c3fb15e-711d-4b8d-b152-e03d9b05293f@linux.dev/
>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Signed-off-by: Gal Pressman <gal@nvidia.com>
>> ---
>>  net/ipv4/udp_offload.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
>> index a0813d425b71..71df45f9488a 100644
>> --- a/net/ipv4/udp_offload.c
>> +++ b/net/ipv4/udp_offload.c
>> @@ -604,7 +604,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>>  		       seg->data_len);
>>  	check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
>>
>> -	uh->len = newlen;
>> +	uh->len = skb_is_gso(seg) ? msslen : newlen;
>>  	uh->check = check;
> 
> This is going to have the same checksum bug as your first commit, which
> I'm fixing in [1]. You should use the right value of either msslen or
> newlen when modifying check a couple of lines above.

I tend to agree that the checksum seems to have the wrong value, the
reason I chose not to change it is because my work only moved the UDP
length assignment from the drivers to the stack.

The "wrong" checksum value was used regardless of my change, and I
prefer not to change it as part of this work.

> 
> That said, maybe you can base your patch on top of my checksum fix? For
> the last packet, it will then be:
> 
> if (!skb_is_gso(seg))
>         newlen = /* the new value */;
> /* keep newlen as is otherwise: my newlen is your msslen */
> check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
> uh->len = newlen;
> uh->check = check;
> 
> [1]: https://lore.kernel.org/netdev/20260512165648.386518-3-alice.kernel@fastmail.im/

As I mentioned in the other thread, this fix goes to net, I can't take
your patch.

