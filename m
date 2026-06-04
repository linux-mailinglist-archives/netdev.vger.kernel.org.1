Return-Path: <netdev+bounces-295162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vz8yB3lSIWp6DQEAu9opvQ
	(envelope-from <netdev+bounces-295162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:24:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F1263EFC9
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:24:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=kszK0d5c;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295162-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295162-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1850C305509C
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6743235A3A4;
	Thu,  4 Jun 2026 10:19:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB3A247280;
	Thu,  4 Jun 2026 10:19:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568372; cv=fail; b=GUZFSOluWmK5igNZkNTx+s4SZXlNaAtgZcKM7sbMTjTHRgWDpLSN8Ky8Aa7zHrG1B4OslL6/v5Hfdw220hdlXCYM9Xe4SHtneEaqZF813Q2WIMLJ2CHq1luT6/FmgtoDbPn3CLejjaKV6CX/edIokB6XsmD1QLdioTdIoXg8WUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568372; c=relaxed/simple;
	bh=zLphbvEGw4CpORBhnZmD4V+qIvOVpkAoIP+Zjy2rVlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IcGbbejmftgHkb5BAaDNDo9XKgBhvz2GqbOtoy+pWQiq3Xw3MD2aqQIZGKfEwrm0IboO6taFfJADXEBC4oW4xCPr0LptElpQNKdZ/uAl0zFMgnB7GDYYGdnc29IydlYxFr38EBLuzfwjgWUtOBFDIQ9cHlYoPPWrxQvyRuSWG3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kszK0d5c; arc=fail smtp.client-ip=52.101.56.14
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6bmpKvlGje6R+LUNd8UItnvOQIkfdNNkCrMN1Kn343n3qf4KcuchCcDmzW3Rzx1LOkq51XPi0346kGjnrYMpQarT/UEEn0LQW4asbqqKP9KVhZBx5yeLHHWPtGNp0/L/K18h7iouokCYXid31WE5/ccFxQZmeggsNjIZVFUxNu5y3zaqgw4SgoebaTqGCCkc6Vzm9uh2lj2FnW0gnTGX6bJyxYZPUQFw00lYgwlVz4rrmdPNFzkE2S5JpK173CtAbWRD2el1B47157GSHf5jmBzSXM0Bh/OtOb8T6E59/X3x9iCxwtq/i10CczYsUDpv9EQK6rN8HrFP48VXlP8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCi7cMMNl99VS2ETK9o566E+yancEEv9QbBCSYK4xAs=;
 b=ho0XTMeePjFFbpONULh6hk4YM8Qolh0OMQjAMEPUIq/fTuzdkP6d62m24MnzMdKlvJ6NhFN86Kme/UwEgl8bOO2sUsYaB8Hmw368QPBCUn6YEee5qY/e6B+4yScJCX1ZUk0c111EObPCs/ua7CKufqXRDWQxlirnjIQW+om6FrRk/84TghTUH/7sRLXrfTny/PZEEm1ePE+AV8dAoy/iHSYmg/wEogejWEGqCinH27b9l4Wsbv6pkQw3box8XQVQmPa0hmE3zVpG4n3E9xlNs2wNNsuGu3ZFhP1AHvCZ46tjiclBl5F26iFsgB358cUmazOzPM4d/ipJjI/6nREhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCi7cMMNl99VS2ETK9o566E+yancEEv9QbBCSYK4xAs=;
 b=kszK0d5ct+pp+Fq8n3yZrUmlaEOQtpFJcLTdeSQLN8+hJJCJ69QCXCYnRFYTqfBcComn/iajJcC2fCl0ix0a1tIyNyR45bChMBk17hwOGbqXlorFBjIN9L8++qTpwmXJkj8LApsIHPv/k9kUAOUtNIMNXzaQEpu/tQfBi8mFu4ooATMi8q5MO95ubqlUPOEijQNu3EEuZ9hkgEcU1oLU6rWtodcnvy6pv8TAJZS4MFsOFjrXyKtaR+gNuY3nxSOFsXUSTb9EwVzlSrCIOzUbSn0BS4gPEhBlYTzL+rS7Vc5Nne1Zo09uxFhim6GdehJenFGZqMe1hp6YwW9MM2SrVQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 4 Jun 2026
 10:19:28 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 10:19:27 +0000
Date: Thu, 4 Jun 2026 13:19:17 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] ipv4: igmp: annotate data-races around
 in_dev->mc_count
Message-ID: <20260604101917.GB771160@shredder>
References: <20260531030705.3754389-1-yuyanghuang@google.com>
 <20260531030705.3754389-2-yuyanghuang@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531030705.3754389-2-yuyanghuang@google.com>
X-ClientProxiedBy: FR4P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 49696138-efe4-47ea-5792-08dec222c228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	K/7HHLDzO6L5kVfPEoqolnsDXGP+W4DNXxrjydeyCzOmKjO3se2d5cJY6PPeQzprNTjcS1ZHHEv6SEfRWM4fIKb7LsWjqF/Wi0QFO0J9VmM+URv4K0mC8maCT0doBkI6MTCJ36RpvwiorGVffrmjGHFZkxhQ79NC70/O2D4vUCs55jsQYF2pXfaq/HN7JWJ1fyNEg7vx6Cqsb13KDwsx6j8m5iqQG7WVGt/x9oJOdPjRpYpeO7FjGlvvOxDd1bVMFZRkkMLgGBhHYE+j60r+7Sf5Rr7VNnqEsrniYktvTmPFr1qCbJ4BJspJEOu3Wuw3S6BRIZUZBF4K+/2Vba1WYiCKxO1LUYkxBXWtXpJNZLIUS0VkfNhoNR8zTM0+tX8YUQEfvkOwZGo6J5FgUBAj8eI5fMRvZeOBTZu+DDeeLLdF0dfIs7qby8AUiyeSVAfLwWwgOFXjHcq6oZtqQ8bNmZUMbTEYecurKQBI9RSk89T7mHBmQsZx8C09+QK4QT/xIb6SK46cPJdCPjGQqoZju0a+wlAwDU2PMSx+jdDglZrO+eBImSN9bbupKhnCpZxbrJaA7mfvzGv6ardh6Eqb65qx0JOucUJRZlyUlk/2/5p1nqNY7yAOk2V+9Wb2O3gngNAo1zVNC3lcRnqMMhPyeYSa64dB2F/4BPkReIT68/wxd0uKy2TsEEnj0SsHrXqh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mdahBzgFG0IX6sG9YoZflL1zkuXgxfv/18IRu1ApU9LI8YleBRIGCB0kQO9G?=
 =?us-ascii?Q?XZpLoh1TgfhTQFZTtK9K3AFzpq5t4A3BGMcEQBBgyw+Slbii/4662DEfGmyr?=
 =?us-ascii?Q?TrDAbz3DGIn+ydWXMhn8ZUhDozHKXfpgkAWEVk+4eZ4GButQz1N/vWPF6fHY?=
 =?us-ascii?Q?JaGQLTerfiXGVA2fu5MJB7vuqyH20IytlC15jyvfI/rlZv+bEqBSxW22lEjx?=
 =?us-ascii?Q?+EMJ37PyOOdYv5arw0r1QZLgh759ep5regBArVtaOlzbKIDn+Qw2VwiL2JoY?=
 =?us-ascii?Q?CO9Tl649jkwetjF6t5xKLDpIAzWvfIqrIAxnyOnsEX7Py7z5Yh0p3COL6HFo?=
 =?us-ascii?Q?Ye6zyaGxQC0dakKUtQh8g+RgYe7vT1rq4UIKXVBLYCLA/cjXScFN2w6UU4Rl?=
 =?us-ascii?Q?IN2TEoGJUvi/c5WQf2/+eTqHssa1Dcb3d1kHw4y5aD4v4ahy2eVwgO+2eonE?=
 =?us-ascii?Q?91UWixwHas64UsHffJeJpOUDp1JuYBkg3NHHlI3qwuqtCw6YWouE0d3rLkqZ?=
 =?us-ascii?Q?7Gp4o5UkKx3p2BTr26Cj8U+EifIDRL1v20bp1HR6ThD8VIbbSbmvZ2vbmUST?=
 =?us-ascii?Q?C2XT9aCJADhaeBpuRtUtNYNcI7X68Dur+DINWY1BBQU5kgBViTeddXeIf4nT?=
 =?us-ascii?Q?dStG6EeS2CVAWtfrRnED0U5m8y3h1GyQLPvOCskv4HoSCaLWHcmBp/LvhmrJ?=
 =?us-ascii?Q?GZBxqL8JtRQAw761RYjf4jIuz5YAXNv9zHtRK2ZuwT8jwCiF8iTGXlWhkHNU?=
 =?us-ascii?Q?0UtjoeX4gxDOVWxm6A/hTOSWACCUSZ4PcXU3/8V13DsefEpY31FHI54+1Ahc?=
 =?us-ascii?Q?1XNtEmyqrfpBxV+V51s7wlIcLgUXNqcJsmJqCEpPt3Xu7VP6dJaUpGswzpzm?=
 =?us-ascii?Q?rfkRlOdFn1vvup23oFqiyIkz3Zyx1CI+Lmyhar230YGjsKqFu+VqY+ambUrx?=
 =?us-ascii?Q?gKdOWVOp9BysF+yAmHiqbWxIfnswBA0R5jgN0YNHegwi8+l7+2rJBegH+7oV?=
 =?us-ascii?Q?NqhsAF32FgmqzoktaYVxSQcDzZokX08KzMt3BnzTOkCOJ33AjBYtjHL6OQow?=
 =?us-ascii?Q?BG+iH0Q45nIsUraCc99F/zgzasfKkyLqAIHNeNFGJ6EAtS6jlBTlW8omxu5c?=
 =?us-ascii?Q?sQZxZ/UMP1fDHFnZ6Oi2H5oqOKfHUgLPY1NmR8/Xffcn5ErbOKEVp6wbjKkb?=
 =?us-ascii?Q?lIVD1pzvYGE4smOzgxGzcjWHGXevAk6Sc/BTrC2LZ2OzO7RURPsmsOU4N49o?=
 =?us-ascii?Q?5e/oDrwvLYK/xm+dvBKt+tHqM6dHi811MvRqT/QVmZ6vSh3MQJaOIFbT0x0x?=
 =?us-ascii?Q?nWAFDeULWf3bivvbllagh8STtKdDh8Y1zGii/54KQfECR3x+IhTIg+4djV4t?=
 =?us-ascii?Q?lGERRanx7Ub8dFsJfDdu2PK6EZoTCwOaefq0pU91WrYJIc1Z00TYs448c82E?=
 =?us-ascii?Q?gxJ1sS5xNLZTkUoMb2KNC+nslOxC+S0Ju+8hfq+6xoNWoRUSCr8vxYz1NsIV?=
 =?us-ascii?Q?N6OXXh3sn+J1oeHxr40o0BA1c9kwbGyKAkULb8RqbxXql01m9LK4pdI1hYqb?=
 =?us-ascii?Q?ehSNflYJvXIC5MJ6s18GxegBs0nzr0PJowr7oTFAvEHOAoUgrfoNq99VY60z?=
 =?us-ascii?Q?UM3AItR5nXDu6WmH462Z9o3V6dAnqLnqqOXXD6VfPPbdNnR23kzWpPn2WQet?=
 =?us-ascii?Q?sL1xHKmDbDDNyqunM3SVnAcQbwPt5SbXbF1DVTIrfcCF4zJzJK+C52bKubP6?=
 =?us-ascii?Q?WZwql34W1g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49696138-efe4-47ea-5792-08dec222c228
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:19:27.7051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8fnXfy/ssonE32mioU8t4v/XW85tv4RM8OHHWj7Z2erpQgtGr0VleW5jUBDJTMK0edmbzhkXxRUsrFQuBKiQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295162-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65F1263EFC9

On Sun, May 31, 2026 at 11:07:03AM +0800, Yuyang Huang wrote:
> /proc/net/igmp walks the multicast list for IPv4 interfaces locklessly
> under RCU and prints state->in_dev->mc_count. Concurrently, device
> init/destruction and multicast join/leave paths update the count
> under the RTNL lock. Fix this intentional lockless snapshot by
> annotating the read with READ_ONCE() and the updates with WRITE_ONCE().
> 
> Fixes: 1d7138de878d ("igmp: RCU conversion of in_dev->mc_list")

Pending Paolo's approval, please drop the Fixes tag given the patch is
targeted at net-next.

> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>

Code looks fine:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

