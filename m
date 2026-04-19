Return-Path: <netdev+bounces-279591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MW3HV7n5GkNbwEAu9opvQ
	(envelope-from <netdev+bounces-279591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 16:31:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC474245EF
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 16:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BCA93003BEC
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 14:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BE037BE6C;
	Sun, 19 Apr 2026 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ff8Qxi3R"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013029.outbound.protection.outlook.com [40.93.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D240DFC4
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776609111; cv=fail; b=bUg5xnKhpkl9qAjkeAR2/cSbdROlqGoah0s0Tp7VglQjMiKwlJtc+tz+sSukw4MGdXURjITKQdz59Fnf7HU4TuM7qgr0rTlB8eUUgRD054Dl9PkPZfy8PsTQmEVE2qOXnmIPijT4MWJ5nrFC0eVyxl5D7cTs3tasFJ5Xo5bEsuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776609111; c=relaxed/simple;
	bh=jybmz7OKSYBUbuUplNsxeLblgj5pDWrElehcNeH6GQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ENUFrpq14Yku9i5hsYSY8Vh67T2UH/v0y5TqkpxYx/GD/0kXVhOzlpM3PNOw9+PBvqJKFCGuK4tbo1QtmAKxhg9RbvUAYhEe0yaMF5+YIIPHmhQxNTzaqp29SQqz+mLFcpkBJwULYDsICUD55rX1DSZoGjlTmuC4hYnjtfz+FmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ff8Qxi3R; arc=fail smtp.client-ip=40.93.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCQND3ZueNzOJU4BucV+BeSK7L5MKvcali3L+eUZg1DzAx0gHGVyv3JMHGHa1EfnxhdjOXqgBestQ4FsM487gQW0KvXnAW8MqN0yifinqYxOwlShLeLuTPSIP10T58EM91XJlRpOP5KvS6p9COQ+CC8r3jQjHr9E3FI60iXMsMDt7MBzQEhsFhueD2/LHjWts7pzZA9WmxfActTGkQLcft88qVsaeny4EErG4bL76HXCy2NO4Dw/n/nGH7octTbq3asp+ds15n46jPSpERoQJ0jUHAwMbelODQr3seXMmU+Acy5ehsrh3VHXGsDLAJZpwPiw7B3dtl3i31TTg/hQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jybmz7OKSYBUbuUplNsxeLblgj5pDWrElehcNeH6GQw=;
 b=MR6TKA7MkUtImtpuKsLc2f4rx+zrGopw/Vq+j0QGPWAz4RWpKMWkj1Z8WqcQnHQ7pmnN7gLovzPMaODcp8PpxuTKgHZicgMhTpKjexTH/2zG4Oh/Id055F8y1et5pizl2iY5Og5S09kUcec1bJifgY29L6xTdbDlUQ5nHRcWqlBAvwC+rw+0NkIjLcx0iItqps7oX474brHaKSzURTRysDKDHvLi4KQvqv65cojgXKQGnbIAXew6Jy2mSmz3PmDOIxf8Ahus3AM3itAS1Vgq6BG1NwYmFG2p+yFSmAhpMcFXTBhFtaFRQkUdvvqHRYWr6cz79GhtwYCNelSp2oFCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jybmz7OKSYBUbuUplNsxeLblgj5pDWrElehcNeH6GQw=;
 b=Ff8Qxi3R2yFNL30GHZ/kE/aFI/EZTYOfdh7ckpRAwz+TmKVwUKi8sn2lZ4vGJCAk7cd8efkwfNUsw4cSF6FEJub65mrLRW7ept9dDBqnCaBMKNdilkN/NjVwiz0jAvAA5jmvhOGjhscqTz7KzJfmwctBlCna1ADAIVhm3Fv0A1jVyTOI5taL+8UKC3dS6MuFUZY17wk2W1PomeaJyTZSRPCK2NeodVYt4BgcSPrLReT6DQHvW+Rjjytagkffl2Blp9POnZOWgal2YdJOpjjTnjCIigz1JnnFIvX2IMK8s8u25KXDjGuyLdil2VF1NjUwG1fdTElnxIi1zjCRHT0ENA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Sun, 19 Apr
 2026 14:31:47 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9846.007; Sun, 19 Apr 2026
 14:31:47 +0000
Date: Sun, 19 Apr 2026 17:31:37 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Justin Iurman <justin.iurman@gmail.com>, daniel@iogearbox.net
Cc: kuba@kernel.org, edumazet@google.com, dsahern@kernel.org,
	tom@herbertland.com, willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: Apply max_dst_opts_cnt to
 ip6_tnl_parse_tlv_enc_lim
Message-ID: <20260419143137.GA885197@shredder>
References: <20260418121538.706095-1-daniel@iogearbox.net>
 <7c715640-5c20-4226-9c31-d2c5eef551db@gmail.com>
 <d8d60970-6f73-4b9d-8808-76f4f8023100@iogearbox.net>
 <8fdf517b-6217-4df6-8adf-0c79ce8d3be8@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fdf517b-6217-4df6-8adf-0c79ce8d3be8@gmail.com>
X-ClientProxiedBy: FR2P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 324940b3-ed1a-468a-768d-08de9e2062e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	C3UIbUxghS07+mzvbnEmXHVL+xAIlwmfWPjKrYWGZB/NNSvalF+Uj9FwNDEAWo70R3g6MHJXtGbhRzWRoDLZtLxnpsDITcS4jXv+5L6bv6Ct6yQPrcjv3o2e04/xjJF1upVdv2jYyjO5l1pA6gxem7B0uMH0XkNJmkcm0K8irUuBMsauUbjJ1Gl/rVnkcmE2gYYhBEyUpSzUuypOB1/QaYlkbej0SxYCEm6O5xwzSV4XR/OgHy6gbErLPyS2bGt9HzWJzA/5fi1uAA5y7T/rEUQx6Y540WmK0Ef/a3SdUXw1O4FN1LTlatRa2NJWL+SjZg+wjA94CRz2FY4niOQrstk4L41n1hwzTWxfqYZhlqv0jh+Ww+wsKd3GpZGMJO1WeuY/745rwO8jMvJe3Kvnyl5aKdchWX274N0DjWbwlPmNh60KP4zX0Yik1ZnsOQdKwYitoziOKwwdCdu2UJYb/nF1V7gL/9Y7isQyNvP/CHxyfENpbVB5gqr0UsD6H7Br0koeNv5PBu5GflNWcfOLmyq3tHJ2TWmpC5Af0+SZ3gLKEusm7J2poPWrObJFHtAJ2Jh2EyXOyucqMd51to5j08XvyPreDbLla6rmTkFVC/7mjJMdbtzgJpyaPz4MET6tX7rbWcU1Y2RWl9X1Hc4cadMeFRrAkDJcb+JdxlEgdUpnfDNK0CKOJuwnYmMp3pdFIuNu1IvI5UuzfdIW47LYvmRnZMDxbQWXn84ZE7+FjA4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1I2X11D+3raqd772PSoSMcmpaAKrq0DWmSBvd4rF/E5sF9RnmGhX0FZt3bVH?=
 =?us-ascii?Q?+cwAVxotDe2sRqqtQl+kSW2S9bRO+GY3W3qrtdmmaocvPFFW0lGDXQ0RjZsX?=
 =?us-ascii?Q?jmzlpMqI91tIHEc7upYMHXj0MR571o3SM2g54wPa1HKyxd3O4YyRlfCqYBtB?=
 =?us-ascii?Q?k46iUtoX0EXmU14xLSNhQ1DeHXMl891hp2NjsKCuNNXQFtlYMHY2Pek4+F2Q?=
 =?us-ascii?Q?fCgByuO+giWSC21dcIxcfb5QSXKVnt9bE0fYhGirb+DY7NKvT1WZqpsn/+AM?=
 =?us-ascii?Q?At7+SmME97LzRnKburr0ZndOzwOy6Dm+FLFrqp2vbEvilZUk3sAIJv7QKEXw?=
 =?us-ascii?Q?8M829dgq4xkZIUuhNwk7qTDt4W2880ICkJ69h6ea6eKUsVAP/bDQdENKPWLf?=
 =?us-ascii?Q?hwNORzZFv2jlFTWmuC5yibGSt5OFW0W9nt2sNu2uNgFnXOHZpXRknwPUxj+3?=
 =?us-ascii?Q?tTNOBqVM6nnXPr22IxwfxKNU49qh2pJ9fxasWoXqnMc+tDc5fL7cRNNeF9WO?=
 =?us-ascii?Q?TDFwgxo7WHMtiAYlPeznEwat4yLeVCDQ4ILk6F3XSxEjrSUZP23Bn/NMtFFu?=
 =?us-ascii?Q?Hu9Wl/7IFmtvSNJnofbhb7b0XBAWm3CnMX9L4KClzaStcJusdsVgrr6OZwmO?=
 =?us-ascii?Q?/WU5mob8Nne3X3u3hZIxvKhg3926tDWznb1IHw6AIP0NLzVkbbGMZLCTnJWb?=
 =?us-ascii?Q?KQxHnyULvIgZ7bbkDNMEAXp4n2CAWLUBq67iIKkQbl4U7pvZz7/NA6C0JNEp?=
 =?us-ascii?Q?B1rZ/HDF5SUZtkt1YvL4lo+/3+qAor0W51dvLExW5AVP+mXB3dB6p4GD/qE8?=
 =?us-ascii?Q?zin53hfbJHnFkhP9yOrWw31yXhwuDIL58ZnzK0G+e+3bmvCtxPgG2W8fry27?=
 =?us-ascii?Q?Jk3Kp1xMz3ex5bdg23QFz859GnwxqtDbfuWH4G9ZpoHoHPgNlqzas7iU3PnK?=
 =?us-ascii?Q?JdwE84lWtpdBKyInINT26G8uvoOce8wiTmNd+99vpRiEmIs+g7zC+F4pdjrf?=
 =?us-ascii?Q?x5bxtdrPIGZB8fQQQIKrGsHUK4xIQyYObZp2jmadbAooZeMIgfSQBrXUCTUA?=
 =?us-ascii?Q?r8YiSKZll22oFNXvy+MLguhGEVHVnvnNiR2vi5Bv1GLrV9VAb/fUK/cc+Ao7?=
 =?us-ascii?Q?iQDvJTV87c0Zpmk7+bsTtupqlpNjsn0FTtOAK+VzBrD1a+rhNc87k+beMiL5?=
 =?us-ascii?Q?Z3wo5cgydGo+WoNUGKqGIy967yquDDagu76/gBpsEeQNs1W3kvz9RD6UaJ3o?=
 =?us-ascii?Q?rgPNPeSmuduG+h2U/Vwv2FxF5I5kH05X6MUQmNCLhjvd4WWl/tYmsDlpNom6?=
 =?us-ascii?Q?zvEJ83VTVwsCblQYMfOjLE8IqxK7/yCdqN73AJyb+B4yH3N61p/if6UQy+pH?=
 =?us-ascii?Q?XqEJVU5TjZ5w/NgLIqVnlAG4Mbh7qu9mmJaeIkh5eXD9seu8dKpUTF+hG3cc?=
 =?us-ascii?Q?dipiZHPz0fmM7D37pwxqEzu6qjlSaN8sT6qFdRU9uCKSYOf6kU7wWJHhqHb9?=
 =?us-ascii?Q?oabKGAPVeXFASQOMIqSO/qAISMlZDdWE+4KtpJrCm7b9gZ3oz9zW1EcvSBql?=
 =?us-ascii?Q?9SwbfID31KuxTd/WTUdlGtv0/bdni8EaDU3OeKhizMbaqv+ttIM2IHaAcw+f?=
 =?us-ascii?Q?rqNVJvSe1m2Ci+zVCqy6Qg8qq+1OmVncipC0jUOtkMCSZhSP+Nnq44brWonO?=
 =?us-ascii?Q?P36BGE4SD9G7VKQlIJU8jZT4/A2mo3yJRcMr2T4J5lnKt++z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324940b3-ed1a-468a-768d-08de9e2062e3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2026 14:31:47.0020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K62hWr9zn7OJrXvVY/wRJwF//H/2fCXFR1d0yGfKO4xeJ4ZvKn503Z7/iUFFaFg/SfbwmGl0WFR4RmYVG2+ZbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279591-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,iogearbox.net];
	FREEMAIL_CC(0.00)[kernel.org,google.com,herbertland.com,gmail.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 5FC474245EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 12:37:35AM +0200, Justin Iurman wrote:
> Nope. But if it happens, users would be confused as max_dst_opts_cnt would
> not have the same meaning in two different code paths. OTOH, I agree that
> such situation would look suspicious. I guess it's fine to keep your patch
> as is and to not over-complicate things unnecessarily.

I agree that it's weird to reuse max_dst_opts_cnt here:

1. The meaning is different from the Rx path.

2. We only enforce max_dst_opts_cnt, but not max_dst_opts_len.

3. The default is derived from the initial netns, unlike in the Rx path.

Given the above and that:

1. We believe that 8 options until the tunnel encapsulation limit option
is liberal enough.

2. We don't want to over-complicate things.

Can we go with an hard coded 8 and see if anyone complains? In the
unlikely case that someone complains we can at least gain some insight
into how this option is actually used with tunnels.

