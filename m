Return-Path: <netdev+bounces-263823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NTLH9I6qGkTqgAAu9opvQ
	(envelope-from <netdev+bounces-263823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 14:59:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0D4200DD6
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 14:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E3A8303B61A
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 13:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565773B582A;
	Wed,  4 Mar 2026 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KV85pUj4"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013057.outbound.protection.outlook.com [40.93.196.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D413B3C15;
	Wed,  4 Mar 2026 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632502; cv=fail; b=UAEApIUskXy3LenEugW9CkAR1L5veTXBBL1Y4CxHcihrbLwYuaCSSXpQBXwKZc3sKYyULtABkl/Z4CKM92s3TOtYHzYKQ8jNcQMd7Xwao4uIfrI6ZJsomZFJyIc1ukamXVavEuM0Wm1lDhid0LWp4zFlZsVABOwdOcijxrdD/rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632502; c=relaxed/simple;
	bh=dNQWlT2GscCBG6N6hJJpgV3OAIVmgmroogeNaAj7Cik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r5q7D7ClncrVLKUKyVCSgUPzasU9gMGXC+tZQ1alaRAwHkkH9jWGE7uyGRAvqlIj7boNSk35PUq2z5MxNRP65APSOzJ6H+lHbo9EX/rzLoNj/G7C5E0dwkuFC39YuFFIH66gEyJT/FxZg8f6cdnlaGUMJPp3SCSckd5Ck0f1KpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KV85pUj4; arc=fail smtp.client-ip=40.93.196.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYvOPfC3NEBRNkCaUQiNOPb2NhqdIuwHkRK72ZSDHbw4hnCtyOh2yqdPcWa0X/oY6Tbw0GxH9IJ6Ra4ru1Q3TNI/qKCokulKxi5wuR/Zv90XX9ckXXtdHUAaCeMa6qXtlkUphz29bgIbHAiS9zDVscWj5Tx+X83K14tTNze2VkCrQQZuC1iFk9MJlncAXgKqrt8HATiPw540Bebc5VBGCE0IO9fXgIan40Gy5Fb5Z4tREDaC0gj4O9iF6iOX1MKhMsjFEpb9zUsnVxHx6w1U8S7zaUgtUvnWi6azjgqJEyLhk21uvOVhoTnSPSBTtuRqCeJ5A77OQZb/SjKS8MeEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vxT9vDlb5uWXLhj7QymG2+eXPTdBQFKj2pF+k06pnc=;
 b=Rl62Du44IIfGTDHQroOuR+0SaM2X4tkslDfB+YvsG5ccelPKlmMAWsm46sW18EJcpnuW68LrDKouML1t3pjp+hCp1q/hR5eoWKzf2ZYel+gTDOpHwlM/0IjTPXPHuWuBaU0OrV5vgnSyK3IQVINMasXiBGNU6GgQ3NJUxlP1FNkMSA5mykawBf32k1IgEBn4Dfo5QQbig5ACB/xbgJBb3iYi2MskvTq51CKUmST03esDYeBqYtIIW6RGhgtnSpnC38P89B+YJCOSDFHKIGukPZ0RN7RQKyjCVmgoqH5jAo5CdhBQXWjisuco5uSjYpELvpnsmONACMHBUqgQRK/Qaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vxT9vDlb5uWXLhj7QymG2+eXPTdBQFKj2pF+k06pnc=;
 b=KV85pUj4Cg24VV3HmXUvyNDYO7QvAYZF+BMWIiNQh7F/XnM91R2hAer1hYKyoutcODDBefsggirlnI9dG7dN87ARJxU/p5JaCMUDBIssViM7xkYL56LQe1FPAIsBziuHGXcvGbzJxJGFjtiV9QQKfgV7AWH+YBnWRsRs0xdlE7Oc2z9DfH/Opu7KPmkO8xJs+VH+CDdUVbWmBEmGXmdTzYnk4mNfJRZHzaB0hSLzkSsZCPF1nMHRQIp9uGwXnBc2jzm9WgxBfwmoWPIvXoE0ZcLszxZazS0CnoPPkCJ+MBL6bp6GtPNSD3H663OENIOno823H4qRDs4i1M8ymaFZdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 13:54:55 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 13:54:55 +0000
Date: Wed, 4 Mar 2026 15:54:44 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, jiayuan.chen@shopee.com,
	syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v4 1/2] net: ipv6: fix panic when IPv4 route
 references loopback IPv6 nexthop
Message-ID: <20260304135444.GA1159886@shredder>
References: <20260304113817.294966-1-jiayuan.chen@linux.dev>
 <20260304113817.294966-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304113817.294966-2-jiayuan.chen@linux.dev>
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2fe8bf-eaa0-4126-823e-08de79f59db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	lf2fcFfokwh33BxHNNGK86z5y2WzdYIzazDyZbnymHonKS3sAPqcum69+K2xBmFLdeDZp5G8aOcyie+MrbMZMbmiJ7AyTqeHGpXH4OQ57mIbnb9331ij4zAyV0UTlAS+fWCDzHZm+hz1vBFHxVN88I/x+qXX+bUK7TX/sN1LSm7J/zXQQKkEeNhfWNZkGs5CVV/ZYJjlhVUTmugj/Oc6CNrp0jvcDQX+t8kHoAhuA6g47UZSWTklSog8hzAQTHPG/uHN0hphWRYvytcAkbZXF5Z9fx3AG0UCYCdne0USrKy9+xdAeSYzWkLiILtnZfZF0EvaFOj/1L9J0REZ8aZAT579scRVvQ72Pp7bVOIaTBJ3mnbfbauXMcbiMRBgS80kqQQn3bV+24OorZb2g60V1ruZxRmeUP/vt0Ht9aEHfATWZIhI1gpR/oRKYFnq0GEvVe45UYTqlJaNSvLYh3q0zlS9+RYUDDdQ6BnYf+J8v9C0rbusz/6cXTUlN2Nz1v58oWy/pRpcoMNmIF0TRGot+baHq/cQAuQxG4ZtqsEGB6mmvDUn7DY7sMmUJcHwtCLwjU7eHC8KYeYeUh94y8oQPWeQRsA2gLOgYnP3Vasl17q9L4I20sJwMQ+aA8iI8GnqjWg+kj8R5Sh3Q4mjV7Q9zqXkVy6XyIWRxrLeUsQOZuMjZ+P10aOBuPF1NRH8yd+qOD6OLfZ/nwtIWA03e5KIoTTn+w2/ZFmxmj6HY+yBNcU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pEzqOv7zLpeEfBW4XxcsW7X4/0qO1bmNLdXq7rS/+JgS/VGXFud33UtRWopY?=
 =?us-ascii?Q?qtt1WaUynxD1BJi4EsdkOX9uA2R9sEGhnJr56g1jJPhC6VhtO95JYlvJsXEh?=
 =?us-ascii?Q?fktoc39EnX0iH5X6XMNrJQ02VBtICDUb0oqHWJHwYLv9D8ghV8pJP1wW9yMB?=
 =?us-ascii?Q?qGLOtnrBMx4QR+vcUE43o4BVKR6Wkd1hPivwRKKL8qTykfL9miXhMnMOL8OR?=
 =?us-ascii?Q?IyPl+3lJuiRK8ctEGuohLdrtIhsq3UChgel8imFXTCD36ySfS0NeQStDUiVg?=
 =?us-ascii?Q?DYJz9rQe81YuNIRZ2ARYBfDeL7L1VQIZmPXyV5S7gFKZTc7aqHgsIxRv9l9k?=
 =?us-ascii?Q?W9f++0GlS2958igMkkYHK7eoLMQsK2HmojojFzPZEtSX74Zvzlc00MCTWfKS?=
 =?us-ascii?Q?6lvzwHI9GOyfsOPzHabo1c+Cl7JfBG3BwCLs3FJ7UW5JfIKIhNcDw9F+/gbw?=
 =?us-ascii?Q?GB5tBCe6sLYpIl08B4S4cKuAUJVdhfRM0fmnpYbryvWE9CVZOYdYdYBXTYSs?=
 =?us-ascii?Q?prrUU3kC4iUu4X9b9a6wxo7yee00w8/jccuAXZuQRBMTMOPdYgq8v9wRwQmK?=
 =?us-ascii?Q?2BpKQzWajWyaCsTxYfE01Ards/9sFBilYdIlSXL0N3aPfcS7aCjRLTltX9PC?=
 =?us-ascii?Q?i9iA801BqjvUJtttE3DzRMzqawi81l6qjkc6ksvnUrf3IdFxmUdVMIzoooeW?=
 =?us-ascii?Q?bUxVQvF0T9RGlnJS/6a7+1AQoDgzPlBy+C+oBKtHmvBrzytyl6vPOQA36ipD?=
 =?us-ascii?Q?1m4vAJbVXdIK0+ugHORf+T57rv4EBwqv+Nwe7EWRbuX6P6hGUcUQE+ztBwdI?=
 =?us-ascii?Q?NeZsyJ1xQmy2DhlEZSZtXCXPbU2xclV70ICbnESlyn7g5e46+qNhzhks19AX?=
 =?us-ascii?Q?74y+bpxxMbZhwFQ2Z+Ig4l0VgPXz0bxbHFAKIxLdEvcZE31EHEeSx+wRDOMF?=
 =?us-ascii?Q?KFWDkgEYxJKnU7/rEU23zmUv6r1PfdvY5D6u+wlER+lZb9QLK7aUUjMnJn22?=
 =?us-ascii?Q?M5kqTs1J4SZbJkarIFIR7TfiupKtZiIerQspVFvuZ8TIh37drF5xul9sRVUg?=
 =?us-ascii?Q?QFupituAcxmYvZTlYoEfnKaIIoDqTwAH37ILBIGeFC7t7FL+mgbDhV8IgzE/?=
 =?us-ascii?Q?Dya8BedDLGSGVQq1wGq8zBEleMf6cFcp6rmZ9xOMSeKdAphNbEQuNlKwBanU?=
 =?us-ascii?Q?oAvaqPuZ0o+3qEAd/4zsMkN5IIa7ZhRXqKdRnx6LbWHl901ex2fszUoRHpDo?=
 =?us-ascii?Q?AqTLApmqwnf5WzZMPoDVwR3vKt3yCQGtsXj+Odesi3o29Jeblv9xeuWj5bW7?=
 =?us-ascii?Q?QeKJOTRtSRCDw6Qddg6aeM6f2tEr7GbDR8W023YDTPgxNOq2oJr7CxXAYSWX?=
 =?us-ascii?Q?5fDzZEIVi94uXUmf6Hwkck7pAMrtfczcWWxgzRYC6BI6iVYAR2sl/cVYsUTy?=
 =?us-ascii?Q?NRZK90tWI/r8jB9CySZV+dUhrEEZx5MQ2+hvi1dQFRZO9nlo3NeyRmZSmcHg?=
 =?us-ascii?Q?Py61d/mG6wYCCzvyER4MKdWKcaqkjRsXHeqqcLnKHkwzchjANVQjoDlJdwIt?=
 =?us-ascii?Q?Pgno4/bMgGaRNsXfdSGE0Fn7u1lSNIWTFKj0HBlc+2TDXh3xQ/tzdTsXtiPK?=
 =?us-ascii?Q?SI8O+111gVz6JRlMZDt2VjNaZe6uc2Wh038o4a19V3FvaQMfRFvKpcv1PXem?=
 =?us-ascii?Q?m4XLHj/5LfuTKr3eja6biW9jvE9W06GFwWl6YDq0S0V+2RdgM5CCd4QDoHtP?=
 =?us-ascii?Q?9unf0QcTLw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2fe8bf-eaa0-4126-823e-08de79f59db7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 13:54:55.5133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1VIhZED68DpI2KNPzn59Fc0cCzd6O/00ecjvqy8BiIsQbWvrjpm93Cer+gd2yWoi/F0BuX0t8j1zLmF7ZSLHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978
X-Rspamd-Queue-Id: 0D0D4200DD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263823-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,334190e097a98a1b81bb];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,appspotmail.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 07:38:13PM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> When a standalone IPv6 nexthop object is created with a loopback device
> (e.g., "ip -6 nexthop add id 100 dev lo"), fib6_nh_init() misclassifies
> it as a reject route. This is because nexthop objects have no destination
> prefix (fc_dst=::), causing fib6_is_reject() to match any loopback
> nexthop. The reject path skips fib_nh_common_init(), leaving
> nhc_pcpu_rth_output unallocated. If an IPv4 route later references this
> nexthop, __mkroute_output() dereferences NULL nhc_pcpu_rth_output and
> panics.
> 
> Simplify the check in fib6_nh_init() to only match explicit reject
> routes (RTF_REJECT) instead of using fib6_is_reject(). The loopback
> promotion heuristic in fib6_is_reject() is handled separately by
> ip6_route_info_create_nh(). After this change, the three cases behave
> as follows:
> 
> 1. Explicit reject route ("ip -6 route add unreachable 2001:db8::/64"):
>    RTF_REJECT is set, enters reject path, skips fib_nh_common_init().
>    No behavior change.
> 
> 2. Implicit loopback reject route ("ip -6 route add 2001:db8::/32 dev lo"):
>    RTF_REJECT is not set, takes normal path, fib_nh_common_init() is
>    called. ip6_route_info_create_nh() still promotes it to reject
>    afterward. nhc_pcpu_rth_output is allocated but unused, which is
>    harmless.
> 
> 3. Standalone nexthop object ("ip -6 nexthop add id 100 dev lo"):
>    RTF_REJECT is not set, takes normal path, fib_nh_common_init() is
>    called. nhc_pcpu_rth_output is properly allocated, fixing the crash
>    when IPv4 routes reference this nexthop.
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Fixes: 493ced1ac47c ("ipv4: Allow routes to use nexthop objects")
> Reported-by: syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/698f8482.a70a0220.2c38d7.00ca.GAE@google.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

