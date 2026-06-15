Return-Path: <netdev+bounces-299602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4vfaEJ5bMGpLSAUAu9opvQ
	(envelope-from <netdev+bounces-299602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:07:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F346689AE7
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:07:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=Rk4RryNS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299602-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299602-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62F8A30015A8
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C373B2FCE;
	Mon, 15 Jun 2026 20:07:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996A229BDBB
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 20:07:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781554073; cv=fail; b=t17fetFOJuYE64BucDAiGOuikqggxgaLpJEDY3lfh80wesqWnUowN7XRl7ptAYqvWVWLnMYnk8+bEStcvWbQBpLeUTR/8a42/Pf0gHCHWbGu7S0K329AHKpDFZTgAZnJ9XF+Cjbc37AxSPzusXvy4/JRLUWE7ZxQDpDVrnP3Hx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781554073; c=relaxed/simple;
	bh=IBjJ5LAa1ngWyHf7AJ9FrUV6zSKDi1izDDeSEmEsAKw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W6+qlNNjgDOD2HrRrAljdDlxf5PBEplZxHnuupUKiIBRtobKhNYt/iIVxPLHXHJ2iLXrGaT5mf/MMRk497zkVHO6HmP4er0lGjY8Lpxeq11AQ1xqNrISEPxK7T/REoZsCHtFaWwTwk7+UUmdCMdyRQRO2r+X7BMS1YfVefizy7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rk4RryNS; arc=fail smtp.client-ip=52.101.52.3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UV4q6DSpc28/OqakNPzon7UGqt35lgbHn7q6CjaoIvi8dLFPWdVA4/uwZBzCYyPznw4p4pd6F3cI9QANTB+OP1+BlNYx5D+f9SlXcFrb3HrnNsMR+9wrbcLm47TN8BtC1JRQvT8tSPSEYhOQDX5EuIbnDUJfzK0N6sPcvoFC0Ld+e/AUsklBdpngrFhluakhkSJgVO83krGnb1RApRhCRyB1SKNqJZO7KpkwW1lCGngA1BjW/ScloomFfk6gYb5ZEA0PtRMXtxZH9eDpKOK4tWhk5Wf3MA1jLDO6bqN7qXRvS7UQu3fgrmHD6JAm6bD847Z8KohS7QCP9k4dnFOaog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIsGvztLlRJpQV6hHjSUOrfDFhlTSstlPAdxMBqk/AU=;
 b=rMg5PMisqSGy0+xYwWXioHqd4aam9LJdWQLXcnkZqiUEVlNBsycz8dqJGRCqrDn428ItVnZpITyBNjTauhOY/gqtaY/b1cH2JzB0pyOMo/bEU21polT40rtdjPzOgndpW95lNfZBQJX1hmrfWIuSO/IcM0rJfDi1Bmxamq2hKVCAAjNoX/pvh+gPfxvO5DNf8rMohnwNPu15omwG++wsIrdtJJ3df16rPTc62wV+79Cf3AdabAASpR16sOU4qZXEP19iAX/vqS3WHZLmbndFwrxqwWAwLctLxQeQ2HSQ/rtK5jB3E+WXwsn4zGsqbx+1RNX/JLaFlZSlWsvpFr2VTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIsGvztLlRJpQV6hHjSUOrfDFhlTSstlPAdxMBqk/AU=;
 b=Rk4RryNStU/JZHJy8Zh0Ut7Hfr+JM4do+MPE1+2BNoDv/UK1X+cOTW+sZnJmVUV3Xj8inopRgKggTzDYfzoWAjaN+puctz36V5NDfaq2dFvsgce6H4e83eA8COI/uF2LlGbSJamuNZqMeWOH/PMHDn/rB+6QTfX15LD6cDpOSNE=
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by DS2PR12MB9568.namprd12.prod.outlook.com (2603:10b6:8:27c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 20:07:42 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 20:07:42 +0000
Message-ID: <e5c3a2f0-4104-4e3b-a85e-a6899f662169@amd.com>
Date: Mon, 15 Jun 2026 13:07:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] pds_core: add host backed memory support for
 firmware
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, eric.joyner@amd.com, nikhil.rao@amd.com
References: <20260614050052.1048328-6-nikhil.rao@amd.com>
 <20260615161929.780699-2-horms@kernel.org>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <20260615161929.780699-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::16) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|DS2PR12MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a306df-d1b8-4586-f0cd-08decb19c205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|4143699003|3023799007|5023799004|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	MHqaWn0jZdiXIQwHdCbXHwE5XYffv4zREHv6xtMcEqOFovy1l7xQQIbG+cxk5RZD3cHwPBx4WWlEMl6Erk8naYbHQm683ng2hJTOFe9o2xLKSar7ocD9GD4tXLT3g6GyGEei6ee4gYRaNzt/5oPR2t4j649NsazS+Rz1ZCImIL1kqHBGFRfKDPjA2d5Y+S7LLirYvKX33cM8uuo2CZG4VmR6xUKLAocufFoTNCvBNZ2G4wpIU3oyfTmih7RCbZ8Cv0DWbXuKh4Ig9gDSuPe7XR91xR5g9JptxIm0kRqaaxA41lYeCwIIaRGlOM+dYTfPM3EzqJNPYMvGQh25z87yzrypfoQQWGl9fRNdXwXZ0uqXkmetR1Vd3UDXEPshzNVXQdtuKlz944PJ4GqoaUrhCtB4T0Gatk9l8VQm4JdrjRb9rT3BioxHSecO3KTEx7s0NU+KQMwwSRgqZVhRBzxZlE7Hk8Q0+dTaU8jqHEdX29vnC0GTapvriIu15y+VG7wn13kBcUIt1kwrbPmuektWHBZypvT+elriisQOeuaDWMIde/xVvDEVQ6IBuw6pNMTp2RFZBxBSj+hJ4g4WQKEEOztSFyyOxgMfc7yWgVu6CcDZ+pjqVecpJL1eh6b6nrx7Aj7maXaQT9zUzi78TtXNCQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(3023799007)(5023799004)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Um5nWkNvek9sMXRmd2hWUVJEOVd0ZTQ0VTJpUm0zdTkyUVB4SUorTkg1SERS?=
 =?utf-8?B?NjFpWGF5N2ZzQjNmaFNmSzdXN0pyYVVVZHpCWE1ubldCZC8zQk54eklQaTRP?=
 =?utf-8?B?cndZeTlmZEhnd3pPRTlUb0t1MGZPMGJ3U2l3eGVSK0pHYk1GZFlLaGZIWXVU?=
 =?utf-8?B?SGlxOGI5bWJaSnBUTTdOZldHYlA5cTJ1NDQ1WDlHQjlJOFNmYlFTblBiRGdV?=
 =?utf-8?B?ZnlWVXJJVnZydmM5VzA3dE9TWndnVHJiWXd2TnlvZXNyYi9aNEZsYzBKZVlI?=
 =?utf-8?B?RWJMUVgxYjRkZUhkTjBneVVPVWx3aCtOenVCQTh3eURYdjdLMnp2L1NzdVlW?=
 =?utf-8?B?WmtBUlQ5NzAwclBmWkM2YWZBNzNVeXg4b1IwNHN3VXZScHAvVU5COEFlU3B3?=
 =?utf-8?B?anBhS3g2UnZSckE0SS96aVdSV0tobmlQZVh1YVl2NXhuOHBQZnh4dnBlYzNX?=
 =?utf-8?B?Y0tqUjZFenlJNjRGbjFKTmdjemFZSVVyQ25yKzZOTEt4VVhTbnNmYW9FTUQy?=
 =?utf-8?B?VHFzaEdST05FT1F6Slp1Ykw0eEFXVlhxNjh5OWRlQXlMSGQyRjZTSVFTVEhN?=
 =?utf-8?B?ZUhxVUdmQVVXOEJxMXdJOTRtenhKZk5PeHFwV2FndnFLL2RneDR3UmF5VEx1?=
 =?utf-8?B?UDFoQ0J6MWUvcmdMZ1dDRmhvTGlvaDdNSU1LYXdxMERRMyt4dlJlT3VFSjhG?=
 =?utf-8?B?elYrU3RPYTlsVkNGa0VNNko5dkVUbFZvcEhadlgrQk1Fc2dwa3Erekc5b1lU?=
 =?utf-8?B?NlVWSFpibGRHdVVRaGtxTklsZnZndmFiWS9nUEMzWXVSWGgxSjduQi9zVEhD?=
 =?utf-8?B?c3c1VHJBaHY2VStvMGVyQnFGRjJ0ZUljNWZEK3JZTHlXVnlKNkhCU0Z0d3U3?=
 =?utf-8?B?U1NyaUFnUDU1NCs2U0hNekRjL1RxRXZkWGNTa3BRRzhQVnQxWFJzVzUzeGJ6?=
 =?utf-8?B?eEtiRnBNUlFxaHZFR1FlTWRDQ01nOHdLbkxtc3ZBUTJsVGQ5VFY3VThjUkRT?=
 =?utf-8?B?YWFoYjRDcDdTeVJOdUtWM3BFN0o3ZStjNEl5TVFnQTZJSlRlRUJRK3V3czRG?=
 =?utf-8?B?UUQrdnEzeWtiZFA1Z3dTTGdqM1NVVkZXWXMxVHZ5OHlORWNEUmVlbTdNU3d6?=
 =?utf-8?B?R3dSWGJaVFFSanZkNnArZWMzZmNjRklSZGJrZ3JoV0xBdWJJNDk4MzdKa2RX?=
 =?utf-8?B?V2RKcWFEVkZURmwvYk9xVnI0cklmSE0vdENINjl2UXNmVnJEM0JaNDdHZ2tV?=
 =?utf-8?B?aTU2MGpXV3F3MEFYUUdhOHRzblQ5My9IVnYyekJVQ3hqME9YTkNuQXVKWjVJ?=
 =?utf-8?B?RnlJMDNQR0pWbzdKS3ZXdVBwYXVIVXVWclJhakoyVVovTkJzQmRBM0xydDNH?=
 =?utf-8?B?d2xLSW9kODVVT1Y1V2tPd1J2dm1kN1N6SVZTZmh5Q28zL0c1VythSlpaaGZL?=
 =?utf-8?B?Q3ZxZUVkY25pRjFTc3JZOHBSdE1GdG15SjlVZ2crV21mcDY5QmFCTm9rMnQ1?=
 =?utf-8?B?UCtERFdYVHB6aGcxZWkzL1J6RTIyTlBlYXVNamI2TldFQUFkdVpWSUdSUHRZ?=
 =?utf-8?B?MHNlQi9FUXBLUnRQN1pVTG9UU29YL2sveXlidUxxVCtXWXZ5Qmp3YWJFNzQ1?=
 =?utf-8?B?NnJSbTcweCs3b1BvMlFLZElJY21TbmhDQ0JuWGJZYmpmTGg4T0Jxb3lPUDhY?=
 =?utf-8?B?RGMvdGZEUVBGS1doMHMzdU51WlV3U2w4QXFuWE5kU2NWQzNtMXp6QjU0M3Fl?=
 =?utf-8?B?cGNEV0s2VXUzTkxTaFVuZE9sMERsWENqUUF6VWdjRXlPSmMzQVBseW40YmM0?=
 =?utf-8?B?aUx4UmtkZEdaL0NzRmozdkhmQUVCbGx4S0RLZnZyMHF0NFJEb1dFUEVUYVcw?=
 =?utf-8?B?cW5IUVF2aUdRZG8rZjJTc0dTOGF3ZDVIQ1Z5aHFFcGlEN011eENQc2NXeVNL?=
 =?utf-8?B?OTdTc3JITWo4UmptQXlkZEpwQ0ZIWHQ1VWhJRmtMMWJxalJpQzVxL3Y0VnJO?=
 =?utf-8?B?Znc2TlFrRUFRSVQ0aWlsTFJxSnBFL3RBOXZNRG9IdlBmaExtQjZNZDJDNUFO?=
 =?utf-8?B?alpUcFBZNjZEdjVGZE5CTDU0UllrTFBNRitiaWxVUW14UWFKRWUreUVRbHRE?=
 =?utf-8?B?U2NuNkwzdE5MMHhpdDFXWFVxMjVUa0VCL05BN0Vxa2VJR0l1RysyMlQ1djB0?=
 =?utf-8?B?SythMUlvNXliM2NkaC9pdVd3WWRTNzFaOTgxZ3dxbUtmUS9XeFBPYnlGUjJj?=
 =?utf-8?B?MHhEYjVGcVFqMDFYdW5sYk4zZ25CQ1dFeENnUTF3RFpjQmFWTWl6cHIraWxu?=
 =?utf-8?B?N29NSTcrNjl2RmZoYTRRRjd6UGxiTE0yL2JISkl5SGRUakpqNkxlUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a306df-d1b8-4586-f0cd-08decb19c205
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 20:07:42.5716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lelyRMI4q8AfltaxQmIRYqfvTbgcTDctEKv2fRMnTKfSgYo7yQUAANVOjc9DENMr2yqqaCBO/oGFV8/6C21y1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9568
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299602-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:dkim,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F346689AE7

On 6/15/2026 9:19 AM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at:https://sashiko.dev
> ---
> pds_core: add host backed memory support for firmware
> 
> This commit adds support for host-backed DMA memory to provide additional
> memory for firmware control plane components on newer AMD/Pensando cards.
> 
>> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
>> index 705cab7b07273..d1695ca95440c 100644
>> --- a/drivers/net/ethernet/amd/pds_core/core.c
>> +++ b/drivers/net/ethernet/amd/pds_core/core.c
> [ ... ]
> 
>> @@ -658,3 +660,161 @@ void pdsc_health_thread(struct work_struct *work)
>>   out_unlock:
>>        mutex_unlock(&pdsc->config_lock);
>>   }
>> +
>> +static void pdsc_host_mem_del_one(struct pdsc *pdsc, u16 tag, u8 reason)
>> +{
>> +     union pds_core_dev_comp comp = {};
>> +     union pds_core_dev_cmd cmd = {
>> +             .host_mem.opcode = PDS_CORE_CMD_HOST_MEM,
>> +             .host_mem.oper = PDS_CORE_HOST_MEM_DEL,
>> +             .host_mem.tag = cpu_to_le16(tag),
>> +             .host_mem.reason = reason,
>> +     };
> [ ... ]
> 
>> +     hm->pa = dma_map_page(pdsc->dev, hm->pg, 0, hm->size,
>> +                           DMA_BIDIRECTIONAL);
>> +     if (dma_mapping_error(pdsc->dev, hm->pa)) {
>> +             dev_err(pdsc->dev, "dma map failed for tag %d size %d\n",
>> +                     hm->tag, hm->size);
>> +             __free_pages(hm->pg, hm->order);
>> +             hm->pg = NULL;
>> +             err = -EIO;
>> +             goto err_del;
>> +     }
>> +
>> +     /* Track this allocation so pdsc_host_mem_free() can clean it up */
>> +     pdsc->num_host_mem_reqs++;
>> +
>> +     memset(&cmd, 0, sizeof(cmd));
>> +     memset(&comp, 0, sizeof(comp));
>> +     cmd.host_mem.opcode = PDS_CORE_CMD_HOST_MEM;
>> +     cmd.host_mem.oper = PDS_CORE_HOST_MEM_ADD;
>> +     cmd.host_mem.tag = cpu_to_le16(hm->tag);
>> +     cmd.host_mem.size = cpu_to_le32(hm->size);
>> +     cmd.host_mem.buf_pa = cpu_to_le64(hm->pa);
>> +
>> +     dev_dbg(pdsc->dev, "Sending devcmd for mem add tag %d size %d pa %pad\n",
>> +             hm->tag, hm->size, &hm->pa);
>> +     err = pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
>> +     if (err || comp.status != PDS_RC_SUCCESS) {
>> +             dev_err(pdsc->dev, "mem add failed err %d status %d for tag %d\n",
>> +                     err, comp.status, hm->tag);
>> +             err = err ? err : -EIO;
>> +             goto err_del;
>> +     }
>> +     dev_dbg(pdsc->dev, "mem add completed for tag %d\n", hm->tag);
>> +
>> +     return 0;
>> +
>> +err_del:
>> +     /* After MEM_QUERY succeeds, firmware expects MEM_ADD or MEM_DEL */
>> +     pdsc_host_mem_del_one(pdsc, hm->tag, PDS_RC_ENOMEM);
>> +     return err;
> [Severity: Medium]
> Does this leave the failed memory allocation mapped and wasted for the
> lifetime of the driver?
> 
> Because pdsc->num_host_mem_reqs is incremented before sending the MEM_ADD
> command, jumping to the err_del label here skips the DMA unmap and page free
> steps. The failed request is tracked and will eventually be cleaned up by
> pdsc_host_mem_free() during device teardown.
> 
> However, the caller pdsc_start() ignores the failure, so the driver operates
> normally while potentially tying up to 4MB of DMA-mapped memory until unload
> or reset.

This is intentional. In the timeout case, firmware could still be
accessing the memory (slow response, not actual failure). Freeing
immediately could cause firmware to DMA into freed memory. The memory
is freed at teardown regardless of MEM_ADD result.

> 
>> +}
> [ ... ]
> 
>> +void pdsc_host_mem_free(struct pdsc *pdsc)
>> +{
>> +     int i;
>> +
>> +     if (!pdsc->host_mem_reqs)
>> +             return;
>> +
>> +     for (i = 0; i < pdsc->num_host_mem_reqs; i++) {
>> +             dma_unmap_page(pdsc->dev, pdsc->host_mem_reqs[i].pa,
>> +                            pdsc->host_mem_reqs[i].size,
>> +                            DMA_BIDIRECTIONAL);
>> +             __free_pages(pdsc->host_mem_reqs[i].pg,
>> +                          pdsc->host_mem_reqs[i].order);
>> +     }
> [Severity: Critical]
> Is there a missing notification to the firmware that this memory is being
> unmapped?
> 
> This loop unmaps the DMA regions and frees the pages, but it doesn't send a
> PDS_CORE_HOST_MEM_DEL command. >
> For physical functions, pdsc_devcmd_reset() runs before this during
> teardown, which might clear hardware state. However, virtual functions
> explicitly bypass the reset in pdsc_teardown():
> 
> pdsc_teardown() {
>      if (!pdsc->pdev->is_virtfn)
>          pdsc_devcmd_reset(pdsc);
>      ...
> 
> If a virtual function uses host memory, skipping the MEM_DEL command means
> the firmware could be completely unaware the buffers were returned to the
> OS. Could this lead to the device performing DMA into freed memory and
> causing memory corruption or IOMMU faults?
> 
>> +
>> +     kfree(pdsc->host_mem_reqs);
>> +     pdsc->host_mem_reqs = NULL;
>> +     pdsc->num_host_mem_reqs = 0;
>> +}

For PFs: pdsc_devcmd_reset() runs before pdsc_host_mem_free() in 
teardown. The reset clears all firmware state including host memory 
state, so individual MEM_DEL commands are not needed.

For VFs: They never allocate host memory. VF init path (pdsc_init_vf())
doesn't call pdsc_setup() or pdsc_start(). pdsc_host_mem_add() is only
called from pdsc_start() in pdsc_init_pf().

Thanks,
Nikhil

