Return-Path: <netdev+bounces-305935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kmkQFzOPTmqmPQIAu9opvQ
	(envelope-from <netdev+bounces-305935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:56:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A8072958A
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:56:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=e9B5222m;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305935-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305935-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6629302BBD3
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5711A9F82;
	Wed,  8 Jul 2026 17:56:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011055.outbound.protection.outlook.com [40.93.194.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6567037C0FF
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 17:55:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533360; cv=fail; b=lcPUPw3ih2k/u6dbI8yzBnKzW5UWtrbIllmK4XGB2VBapujf6yJSFyMxvfDb4kmLN4FHT7B6yCUo2anFvsbDq4QgRzNYDzaawoFUNJAQ7wVhjc/9KwcTdgXrwAnMpmGmS94YYFDwkaHM5ze5VoZ2mnKnPCSHfKJg23MN0/ngTlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533360; c=relaxed/simple;
	bh=m01qZ8VtzWTb3HcWgoY2mtZFDiHwk5ECxhzUHE99N6U=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UNSaMPr5szHSsjrtfEBydmoPa+3wX7f6EMIsg1Q58bJSmYfqsZLKDctjGx1EFVdX0J3BV2FqDYBKUhQc1EA442fwG52+eMSeLZlyP1s0iLti+FKsXlz5QrttWg8Nzvp3Wpv1ucI4BgfrytV+21IXvlpYipsoV9uWu/clV1TBW8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e9B5222m; arc=fail smtp.client-ip=40.93.194.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tw7xrORKJDag3VjrWS+37HLsLeoAibMVPqe6Hu4ejtXPULhPWvDuXT5yYMeg9p7O0RiOFWb3rd31GXKYeHMfojseAeVdBZ/oMbf31hldxnDXQdHE6BBC6VLjw/gWCZJ41cTrU6ia/Z1cc0/ZvjfwBLUfGbxErZVEeoTiwHhSRlzDnJVbxLn+dzMipIdD/Ai4WlIc2wqf99wTq5UYZajPAM2wsND1qzWO7/5ma7PQaVpbQwMR2d+otBkIdenDU8xGPgi4S+hf7V04zt/3YKaePHENWLZQDNuLkrHui03/0LwHwYQA5iUuMK7P+FMVQ6Xf27eSSTdMYJ7vBTb26v692A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qowFN3w07Y9hODyYe/j8AwC1BFlAf/Yc2XTO7qJXYHg=;
 b=nLEuhjaUQQYPsBgDb1EKl95C6Yustr4yHpHaEs1srL2rHJDA039J+psiBs/28YRe2R0M+tCihfAVGdVWRbxWsUQO30rEUgixIpsFY9C10J2kUYNhPgmY/AjNiMCyhC2CbkVN8fJiWtMwd4SqOfQr8cS6CruYV4ZIAP33oNz4xkg8lkdtUxG13hrxFYetvdwAXUJPcfD60Vm0xeXPvNxdSGngFTaq8IjVVRWzqYcHsg+8hGC34nE9SGlKChB5N35cuzE7Sf8Xk5rWi3dO7u9y2jh6YEnOXOOiWLj8mgug4ydXY7eoOK3a2xtyhZsGwjBwvPFWO1W5mQKwPGx1VrWvbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qowFN3w07Y9hODyYe/j8AwC1BFlAf/Yc2XTO7qJXYHg=;
 b=e9B5222mrS/+2F0Y4eVecvxKMTXxsWSeVF3c148A4fcl6CEiJZ71ZZYJUFgk3atiRh5D3SNTwshx3khbmS5kSm0PUW+5Mm11hfAgSpz7asCxyBY2CE/Zqwz1CW+9jCrcF9qqqx+fTpZQNdCwoWsupGMp9cGFfzvATOa3GBAEEXc=
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 17:55:51 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%4]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 17:55:51 +0000
Message-ID: <bd8b3e07-223e-4dab-957f-d3513d0f27c0@amd.com>
Date: Wed, 8 Jul 2026 10:55:48 -0700
User-Agent: Mozilla Thunderbird
From: "Rao, Nikhil" <nikhirao@amd.com>
Subject: Re: [PATCH net-next v6 4/6] pds_core: add PLDM component info display
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, nikhil.rao@amd.com
References: <20260629230200.82092-5-nikhil.rao@amd.com>
 <20260702091115.93857-1-pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260702091115.93857-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::17) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 08fd4c28-5e0b-48fa-d5bd-08dedd1a25fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|5023799004|11063799006|4143699003|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	o3X/hkj7TUluvCetlg/QMxTC0nZryXrTqRycWEQM8KyTpwRjmKB562VbtYn9U33hxwMJ5i4qeXVbRACvkZekzVNsrlrnYSerr9TVj1tVczZkjdFvFiLpaFnitWPpYK5Lvs1dknYIMwCsH4c+Y8Vhe4aR3HIz90OT2QVZr6SpnDj/fOLZkmL7bT0VLuTayDgq2X8zm2X4WLxD3GmgbU6xQqhqi/mVew5N45Z9rkh1jvoHD8/Hdo1TThLfeAVX4vU72UG3vYgnQiE57075EB2CkNCf2NrtXadTZiPFL3B8+OmvZwzNQPhBT1YmK0GJXA6sf5LNh1iNV0e/Jqe1OhnS2PE0YYH/pmpw1Op/V+3M/2nJg5jmR9M7OdZr5l3nIFZxoRvPaGiPUQHFyiqgnsnP6mCvx61OIji9Y1nQ6e+ETBQSlYCWUu1qe9o43+fepWGzO4fVsnYoYFiyXLl+BkuiOnFmO48S/kNMCNzG8NiYcMp0E4/MRMaTLFqhdu+BSKTqQpGih+swxAt8fwyAHpScBbGDnaVJU62qxn7e2S1WCznrEuwbunwZAHHXpRKyWm8Nuxlz+M00bq+lPKbf7akyhvOHMC+QcnS/CuJT/E1+KQkfT+A7h3hUwXTxwt4+EijK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(5023799004)(11063799006)(4143699003)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkZHdlNBM3ZDeWkxSWFJT2VpRUVNZHN4L3NhQ0owT0F3WWxaNGFKSFFwYUVl?=
 =?utf-8?B?ZWd5RjRaMmtzWStxMzZ5YnlnSnpseWQxR04zMzkreGRZNFdBd0UrOTJlL3RM?=
 =?utf-8?B?c244bVN3SDRBUEx6U3lPSWNaV3d3VTRRYWpZdFlxSXV6QnZoLzdLUXArcTQ5?=
 =?utf-8?B?UVFORDdTQm0zQy9MU1JadUNQdUFucUtKcDZnL0FHVWlxV3VNOEdGQzNGVUMx?=
 =?utf-8?B?RXVGODMrWUs3VGtKRHk4c1dhbG9ZVkxFL1IyV0E1bWF0d1Y3ZzJDZDcxWi84?=
 =?utf-8?B?ZWFya0M3cDFXNkNhZm5wRVBxemYydFZMdXYzWDlSNkxoVUx5OHJpUGNHYjBv?=
 =?utf-8?B?bGEzemc4dmZUQzFxY09HY1ppNjNYdGpoWGFhb2dpQ1NDZG1lZXcxSWpVUHFO?=
 =?utf-8?B?aGV4MzViWmg0bG5iNi82MUJoS3NPNkFGbmpWVTZTZTIxN2ZOajQ0Z0pBOWM3?=
 =?utf-8?B?Z2pBejljdnFzMDQ1OEtYVzkwelVzY2RITE43OU5CUW5FYWdiaGZFcXZVZ3RT?=
 =?utf-8?B?MFJPMVE3Q2VaVzVnT0pDb3lPemh0bDU2bGlZTWNUS3EzaXl5ZVdXeEhJRWQx?=
 =?utf-8?B?VzFmU1hVUUxINGcyWFdPOUhnL1VBTklBWUJPemlhMy9xT3Q3Qis0Z2tuMlQx?=
 =?utf-8?B?eStKUHJHeElqMTlhbUhYMVUxeG1VMXd4ZDFzNmM3eUp5RDVscDFETEpNOEtK?=
 =?utf-8?B?S2ZOaDg0bEVkTlByeG15Zk5aUjZHWjNqSGVIUWZiaStzMUpjWUNxeGkxTVV4?=
 =?utf-8?B?YnY0WXRKRHl4SjJZeEhzTGxlUHZYS3MrSFBxWThnTlR0WnpsaEZrRkpxZVJ5?=
 =?utf-8?B?dzJPNjBBRCt6bUFGK2IzR3dzUEVsSFRvc0VhZTFwYzd6WFp5K3RQaDVpYlR0?=
 =?utf-8?B?aXNURXp4WnpUT0tMY3paRThlK1hkNEdYMFJzRjFPQzNpK2JnOHRySVU1YVBY?=
 =?utf-8?B?THlob090WDlPaVBPZUNMZVNCanJVMmkvczZaaE1YcnR4RmVjVFVxZFovUDFC?=
 =?utf-8?B?Z3NESXVaSUNtdTNWNjRteVAvVlhpQm1BdkpLc0ZUd3JobDAvWWVISG0xOU5v?=
 =?utf-8?B?S1BVcE5vdTlNRkIwdndZR3hOODVXamtVSDNpbTRXS1plTUxwa3pBR0VpUHpN?=
 =?utf-8?B?OG5IWWpNNFZiWGNXV0h6SU9YamtoTzV5WSs4MUZTMFNuWDJCN1pvV3JkZlRk?=
 =?utf-8?B?NnZ6QS9XOW82ZGN6aTl6ZjJCQnhGQllOTzJoR0VRaW9JbFV1aEc1d3d3aXUw?=
 =?utf-8?B?bUFYbGlsQ3NpWVBJZ2RMZTlQZTdFQWNzMWJoMCthclBpUlRCT3doZ0hqT2tw?=
 =?utf-8?B?R3QvUG9JLytRaWVFTXQwOHNUcmpCQ3ErNFkyQU5UaHNVaGkwbWpobDlqUm03?=
 =?utf-8?B?aVdpWkRyalVaVTdncmE4QW90Ym9jdnk0Y1c1U281ei9JOVZRSVc2aHRzeFAy?=
 =?utf-8?B?U0k2NG9xejhvbXVicHhjcS9uMDRIZ3p4Q3V2ZHJiNkoreHVyQkFuV3RwUkFB?=
 =?utf-8?B?MDMyd09Cc290MnlsNk9yRmNtYkt3a0ZBalQ5SWpmSEtGT0Faa1U2MjdtZ0xW?=
 =?utf-8?B?UW53RWQwUC9MTUwrZEVhbWl3bEsyanVhdld5QXk4cGl3VXNYYWR3ZjNSN3lF?=
 =?utf-8?B?dWc3WVUxaDRLOXhRTWFhenFueUp0Z0g1TXA1ZWtlTVNTR0poM2VtWVhkKzR3?=
 =?utf-8?B?SHN3MWZvMHZtMVFjZWFFTWQxTFNoWFBwTURiRzBnNmhidXUwZExyNFRreDFR?=
 =?utf-8?B?UHcvMVVBa01xNklqWGJ5SVFlSklpMTN0SE0xZCtsQ3VuNElzRFY4SlBtUERq?=
 =?utf-8?B?MEhLbURlWFJpK1JPM3hzUW5FK3ZvdWxGWWhjSFlzK3RmeThaNThtM3ZRZG95?=
 =?utf-8?B?Y1F0cm5JRXpWN1RTdHYxdmkwYVE4WnRZSnd2bVl6Tjg1UjdZNm5TOUZaMWtI?=
 =?utf-8?B?eDVpYmsrd2JDaTcxSDRDUE9KSDFUeWczT3diVlNzMGJTamY0QnhlOGZaS05z?=
 =?utf-8?B?dVY3RkZLRkFBU1V3cVNlem56N3VLeG5OWEpka2hjbkxwQ24rbWdzcmlrR1dy?=
 =?utf-8?B?TjNkY0hGY1J0MjJvaDFlSFdoc2kzbEFFL1FOckx4UXAzQkViOEtTS2s0b0U4?=
 =?utf-8?B?ZlVTOW1sTEFVRkY3TVVmbGVnQXg0Vy8wRHVENWlTWFh1U2drZjR1UEFqU3Q3?=
 =?utf-8?B?RXVaYU91cWxVdDhWbE1raW96eHNUNlB3d3J2dzZPLy9aV01xV3RhYUJOTVlP?=
 =?utf-8?B?dWhURm5qaGVqT2hWeUkvMUc0dGRkaDdBbHJrY1lRNTlXZWFNbGZQa2ZjZzJv?=
 =?utf-8?B?Q2txL0t6VStZVkRuV2JIT004R2d5UXBya1ltTjRpQWtzN1NVT2xaQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fd4c28-5e0b-48fa-d5bd-08dedd1a25fd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 17:55:51.0942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y24mjF1+vhwmWqIHksG5A8bs/wJODUP4vSQEDat8rbmlkrGHqEim06woa1886LQCIanwvdvoQwSzDiolP8X8gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305935-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:jacob.e.keller@intel.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:from_mime,amd.com:dkim,amd.com:mid,linux.dev:url,fw.gold:url,bootloader.gold:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2A8072958A

On 7/2/2026 2:11 AM, Paolo Abeni wrote:
> From: AI Reviewer <ai@example.com>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> pds_core: add PLDM component info display
> 
> This change adds detailed PLDM component info to devlink info on
> identity v2 devices, introduces a pdsc_fw_components_invalidate()
> helper used during firmware recovery and after firmware update, and
> maps PDS_CORE_FW_TYPE_MAIN to the generic "fw" name in the PLDM
> flash path.
> 
>> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
>> index 38a2446571af..4d9ab8b74ec6 100644
>> --- a/drivers/net/ethernet/amd/pds_core/core.c
>> +++ b/drivers/net/ethernet/amd/pds_core/core.c
>> @@ -580,6 +580,8 @@ void pdsc_fw_up(struct pdsc *pdsc)
>>                return;
>>        }
>>
>> +     pdsc_fw_components_invalidate(pdsc);
>> +
>>        err = pdsc_setup(pdsc, PDSC_SETUP_RECOVERY);
>>        if (err)
>>                goto err_out;
> 
> [Medium]
> Can concurrent access to pdsc->fw_components race here?
> pdsc_fw_up() runs from pdsc_health_thread (workqueue, holding only
> pdsc->config_lock) and from pdsc_reset_done (PCI reset handler, holding
> neither), so pdsc_fw_components_invalidate() writes num_components = 0
> without the devlink instance lock.
> 
> Meanwhile, pdsc_dl_component_info_get() reads pdsc->fw_components from
> the devlink info_get callback under only the devlink lock, never
> config_lock. The two domains do not exclude each other.
> 
> In pdsc_dl_component_info_get():
> 
>          if (!pdsc->fw_components.num_components) {
>                  err = pdsc_get_component_info(pdsc);
>                  if (err || !pdsc->fw_components.num_components)
>                          return pdsc_dl_report_fw_ver(req,
>                                                      pdsc->dev_info.fw_version);
>          }
> 
>          list_info = &pdsc->fw_components;
>          num_components = min_t(u16, list_info->num_components,
>                                 le16_to_cpu(pdsc->dev_ident.max_fw_slots));
> 
> The reader can observe num_components > 0 on the first load, then
> re-read it inside min_t() and observe 0 after pdsc_fw_up() invalidates
> the cache, producing zero iterations and no fallback. Conversely, a
> stale non-zero count could be iterated over info[] entries describing
> the previous firmware.
> 
> No READ_ONCE/WRITE_ONCE or memory barriers are used. Would a lock or
> RCU be a better fit here?
Will fix in v7 using READ_ONCE/WRITE_ONCE pairing for num_components.
> 
>> diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
>> index 3b763ee1715e..bd234c3c50b2 100644
>> --- a/drivers/net/ethernet/amd/pds_core/devlink.c
>> +++ b/drivers/net/ethernet/amd/pds_core/devlink.c
>> @@ -93,14 +93,110 @@ int pdsc_dl_flash_update(struct devlink *dl,
>>        return pdsc_firmware_update(pdsc, params, extack);
>>   }
>>
>> +static int pdsc_dl_report_component(struct devlink_info_req *req,
>> +                                 struct pds_core_fw_component_info *info)
>> +{
>> +     enum devlink_info_version_type ver_type;
>> +     u16 flags = le16_to_cpu(info->flags);
>> +     char *ver = info->version;
>> +     const char *name;
>> +     char buf[32];
>> +
>> +     /* Main firmware is reported as generic "fw" */
>> +     if (info->component_type == PDS_CORE_FW_TYPE_MAIN) {
>> +             if (info->slot_id == PDS_CORE_FW_SLOT_GOLD)
>> +                     snprintf(buf, sizeof(buf), "fw.gold");
>> +             else
>> +                     snprintf(buf, sizeof(buf), "fw");
>> +     } else {
>> +             name = pdsc_fw_type_to_name(info->component_type);
>> +             if (!name)
>> +                     return 0;
>> +
>> +             if (info->slot_id == PDS_CORE_FW_SLOT_GOLD)
>> +                     snprintf(buf, sizeof(buf), "fw.%s.gold", name);
>> +             else
>> +                     snprintf(buf, sizeof(buf), "fw.%s", name);
>> +     }
> 
> [Medium]
> For PDS_CORE_FW_TYPE_MAIN, only PDS_CORE_FW_SLOT_GOLD is special-cased.
> PDS_CORE_FW_SLOT_INVALID, PDS_CORE_FW_SLOT_A, and PDS_CORE_FW_SLOT_B all
> end up emitting the bare name "fw".
> 
> The legacy v1 path used distinct names fw.mainfwa and fw.mainfwb for
> these two slots, and devlink_info_version_*_put() does not deduplicate
> names. If firmware reports two MAIN components (which the v1
> pds_core_fw_list_info already exposed as A/B), will userspace see two
> entries both named "fw" with no way to distinguish them?
Both slots emit "fw" but are distinguished by version type: one is 
reported as "running", the other as "stored" if there's a pending 
update. If no pending update, the active slot is reported as both 
"running" and "stored".

V1 and V2 use different naming conventions - this is expected.

> 
> [Medium]
> Are the new component names documented anywhere? The driver introduces
> fw.bootloader, fw.cpld, fw.secure, fw.fpga, fw.suc, fw.suc.bootloader,
> fw.uboot, plus a .gold variant of each, and fw.gold.
> 
> Documentation/networking/devlink/devlink-info.rst says:
> 
>    It is expected that drivers use the following generic names ... As
>    last resort, if a component is truly unique, using driver-specific
>    names is allowed, but these should be documented in the driver-specific
>    file.
> 
> Of those names only fw and fw.bootloader correspond to documented
> generic suffixes; the rest appear to be driver-invented, and there is
> no Documentation/networking/devlink/pds_core.rst introduced by this
> patch. 
Accepted. Will move devlink documentation to 
Documentation/networking/devlink/pds_core.rst in a follow-up patch per 
devlink-info.rst requirements.

>The .gold suffix in particular is not part of the generic
> vocabulary (different copies of the same component are normally handled
> via bundle_id or by reporting the same name under both running and
> stored). 
We do report the same name under both running and stored for main 
firmware (fw appears in both sections). The .gold suffix is for recovery 
firmware, which is a different component - not another copy of the same 
firmware.

> Composite names like fw.suc.bootloader.gold do not have any
> documented dot-separation semantics either.
The .gold suffix is documented as indicating recovery firmware. 
Composite names like fw.suc.bootloader use dots to separate hierarchical 
components (SUC's bootloader).

> 
>> +
>> +     ver_type = DEVLINK_INFO_VERSION_TYPE_NONE;
>> +     if (flags & PDS_CORE_FW_COMPONENT_INFO_F_UPDATE_BY_NAME)
>> +             ver_type = DEVLINK_INFO_VERSION_TYPE_COMPONENT;
>> +
>> +     if (flags & PDS_CORE_FW_COMPONENT_INFO_F_FIXED) {
>> +             int err;
>> +
>> +             err = devlink_info_version_fixed_put(req, buf, ver);
>> +             if (err)
>> +                     return err;
>> +     }
>> +
>> +     if (flags & PDS_CORE_FW_COMPONENT_INFO_F_RUNNING) {
>> +             int err;
>> +
>> +             err = devlink_info_version_running_put_ext(req, buf,
>> +                                                        ver, ver_type);
>> +             if (err)
>> +                     return err;
>> +     }
>> +
>> +     if (flags & PDS_CORE_FW_COMPONENT_INFO_F_STARTUP) {
>> +             int err;
>> +
>> +             err = devlink_info_version_stored_put_ext(req, buf,
>> +                                                       ver, ver_type);
>> +             if (err)
>> +                     return err;
>> +     }
>> +
>> +     return 0;
>> +}
> 
> [Medium]
> Is the generic running "fw" entry still guaranteed on the v2 path?
> It is produced only as a side effect of pdsc_dl_report_component()
> seeing component_type == PDS_CORE_FW_TYPE_MAIN with
> PDS_CORE_FW_COMPONENT_INFO_F_RUNNING set.
> 
> The v1 path always called:
> 
>          devlink_info_version_running_put(req,
>                                           DEVLINK_INFO_VERSION_GENERIC_FW,
>                                           pdsc->dev_info.fw_version);
> 
> unconditionally. If firmware reports MAIN only with F_STARTUP/F_FIXED
> (no F_RUNNING), or reports no MAIN component at all, does the user
> silently lose the generic running fw version that monitoring tools rely
> on to identify the active firmware?
No, Firmware always reports F_RUNNING for the currently running slot.

> 
>> +
>> +static int pdsc_dl_report_fw_ver(struct devlink_info_req *req, char *fw_ver)
>> +{
>> +     return devlink_info_version_running_put(req,
>> +                                             DEVLINK_INFO_VERSION_GENERIC_FW,
>> +                                             fw_ver);
>> +}
>> +
>> +static int pdsc_dl_component_info_get(struct devlink *dl,
>> +                                   struct devlink_info_req *req,
>> +                                   struct netlink_ext_ack *extack)
>> +{
>> +     struct pds_core_component_list_info *list_info;
>> +     struct pdsc *pdsc = devlink_priv(dl);
>> +     u8 num_components;
>> +     int err;
>> +     int i;
>> +
>> +     if (!pdsc->fw_components.num_components) {
>> +             err = pdsc_get_component_info(pdsc);
>> +             if (err || !pdsc->fw_components.num_components)
>> +                     return pdsc_dl_report_fw_ver(req,
>> +                                                 pdsc->dev_info.fw_version);
>> +     }
> 
> [High]
> Can devlink info polling accumulate deferred DMA buffers when the
> firmware is hung?
> 
> pdsc_dl_component_info_get() is reachable from any devlink dev info
> request. On -EAGAIN or -ETIMEDOUT, pdsc_get_component_info() calls
> pdsc_deferred_dma_add() and returns the error without setting
> pdsc->fw_components.num_components:
> 
>          err = pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout * 2);
>          if (err == -ETIMEDOUT || err == -EAGAIN) {
>                  pdsc_deferred_dma_add(pdsc, deferred, dma_addr, list_info,
>                                        PDS_PAGE_SIZE, DMA_FROM_DEVICE);
>                  return err;
>          }
> 
> The cached count therefore stays 0, so the next devlink info request
> re-enters the same path and queues another PDS_PAGE_SIZE allocation
> plus DMA mapping. The deferred list is only drained by
> pdsc_deferred_dma_free() in __pdsc_devcmd_locked() on a non-EAGAIN
> return.
> 
> Before this patch, pdsc_get_component_info() was reachable only from
> the privileged flash path. Is it intentional that any monitoring agent
> polling devlink dev info while firmware is wedged can grow the deferred
> DMA list unbounded?
If firmware is hung, health_work triggers recovery. Deferred buffers are 
cleaned up in pdsc_teardown() during recovery. Each buffer is ~4KB, and 
repeated polling during a hang accumulates minimal memory before 
recovery kicks in and cleans up.

> 
> [Medium]
> On the v2 branch, the function falls back to a single
> pdsc_dl_report_fw_ver() call whenever pdsc_get_component_info() returns
> an error or num_components is still 0 (which also happens when the
> firmware reports comp.get_component_info.ver == 0 and the function
> returns 0).
> 
> Before this patch, pdsc_dl_info_get() unconditionally invoked
> PDS_CORE_FW_GET_LIST and emitted fw.goldfw, fw.mainfwa, fw.mainfwb.
> On v2 devices that branch is unreachable, since pdsc_dl_fw_list_info_get()
> is only called from pdsc_dl_info_get_v1().
> 
> For transitional firmware that advertises identity v2 but does not yet
> support PLDM/GET_COMPONENT_INFO, would calling pdsc_dl_fw_list_info_get()
> as a v2 fallback preserve the previous four-version output rather than
> silently collapsing it to one?
V2 firmware always supports GET_COMPONENT_INFO. There is no transitional 
v2 firmware without this support

> 
>> +
>> +     list_info = &pdsc->fw_components;
>> +     num_components = min_t(u16, list_info->num_components,
>> +                            le16_to_cpu(pdsc->dev_ident.max_fw_slots));
>> +     for (i = 0; i < num_components; i++) {
>> +             err = pdsc_dl_report_component(req, &list_info->info[i]);
>> +             if (err)
>> +                     return err;
>> +     }
>> +
>> +     return 0;
>> +}
> 
> [Medium]
> What happens if dev_ident.max_fw_slots is 0? pdsc_get_component_info()
> populates pdsc->fw_components.num_components from the firmware list
> (bounded by PDS_CORE_FW_COMPONENT_LIST_LEN), but the loop bound clamps
> that against the separate max_fw_slots identity field:
> 
>          num_components = min_t(u16, list_info->num_components,
>                                 le16_to_cpu(pdsc->dev_ident.max_fw_slots));
> 
> If firmware advertises identity v2 but reports max_fw_slots == 0, the
> earlier !pdsc->fw_components.num_components check does not fire (the
> count is non-zero), min_t() yields 0, the loop body is skipped, and
> pdsc_dl_info_get() proceeds straight to ASIC ID/REV/serial. Would
> adding a fallback to pdsc_dl_report_fw_ver() in this case avoid
> emitting devlink info with no fw entry at all?
"max_fw_slots" is the component count from firmware identity.A v2 device 
reporting max_fw_slots == 0 would be invalid firmware configuration

>> +
>>   static char *fw_slotnames[] = {
>>        "fw.goldfw",
>>        "fw.mainfwa",
>>        "fw.mainfwb",
>>   };
>>
>> -int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
>> -                  struct netlink_ext_ack *extack)
>> +static int pdsc_dl_fw_list_info_get(struct devlink *dl,
>> +                                 struct devlink_info_req *req,
>> +                                 struct netlink_ext_ack *extack)
>>   {
> 
> [ ... ]
> 
>> @@ -134,12 +230,41 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
>>                        return err;
>>        }
>>
>> -     err = devlink_info_version_running_put(req,
>> -                                            DEVLINK_INFO_VERSION_GENERIC_FW,
>> -                                            pdsc->dev_info.fw_version);
>> +     return 0;
>> +}
>> +
>> +static int pdsc_dl_info_get_v1(struct devlink *dl,
>> +                            struct devlink_info_req *req,
>> +                            struct netlink_ext_ack *extack)
>> +{
>> +     struct pdsc *pdsc = devlink_priv(dl);
>> +     int err;
>> +
>> +     err = pdsc_dl_fw_list_info_get(dl, req, extack);
>>        if (err)
>>                return err;
>>
>> +     /* Version 1: report fw from dev_info (running only) */
>> +     return pdsc_dl_report_fw_ver(req, pdsc->dev_info.fw_version);
>> +}
>> +
>> +int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
>> +                  struct netlink_ext_ack *extack)
>> +{
>> +     struct pdsc *pdsc = devlink_priv(dl);
>> +     char buf[32];
>> +     int err;
>> +
>> +     if (pdsc->dev_ident.version >= PDS_CORE_IDENTITY_VERSION_2) {
>> +             err = pdsc_dl_component_info_get(dl, req, extack);
>> +             if (err)
>> +                     return err;
>> +     } else {
>> +             err = pdsc_dl_info_get_v1(dl, req, extack);
>> +             if (err)
>> +                     return err;
>> +     }
>> +
> 
> [Medium]
> Is the devlink-info naming change across the identity-version boundary
> intentional, and is it captured in the commit message or a Documentation
> update?
Yes, the naming change is intentional. This is documented in the "Info 
versions (PLDM)" section of pds_core.rst, which lists all the V2 
component names separately from the legacy V1 names.

> Before this patch every device emitted stored slot names from
> fw_slotnames[] (fw.goldfw, fw.mainfwa, fw.mainfwb) via the unconditional
> PDS_CORE_FW_GET_LIST devcmd. After this patch, devices that advertise
> identity >= PDS_CORE_IDENTITY_VERSION_2 take the
> pdsc_dl_component_info_get() branch and emit a different set of names
> (fw, fw.gold, fw.bootloader, fw.uboot, fw.cpld, ...), with no alias for
> the old names.
> 
> A firmware-only upgrade can therefore silently rename the user-visible
> stored entries. Should the commit message call out this UAPI rename,
> and should the legacy names remain emitted as aliases for compatibility
> with existing fleet tooling that parses devlink dev info output?
V1 named specific physical slots (fw.mainfwa, fw.mainfwb). V2 uses a 
single fw name that appears in either the running: or stored: section. 
The concepts don't map 1:1, emitting legacy names as aliases doesn't 
make sense. Fleet tooling that upgrades firmware to PLDM-capable version 
should expect the new format.

Nikhil

