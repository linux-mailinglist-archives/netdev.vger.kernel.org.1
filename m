Return-Path: <netdev+bounces-301076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VzLaLDogOWrMnAcAu9opvQ
	(envelope-from <netdev+bounces-301076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:44:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFE16AF32C
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:44:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=JTjktHcY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301076-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301076-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2206730425B9
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B419C35DA7B;
	Mon, 22 Jun 2026 11:42:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792E33002CF
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 11:42:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782128558; cv=fail; b=m81Ie6Wd3gK+66+c5aT5AsCU+mVa9WgtsfPK9A+jmnt6nGKgiwnO3FIEoPdN0KcOSt4+wfvwXbJEELdNxvoY4aBJGv3s/dmEoU782O3yhipwQJCl9H8kQYXYCcoy/h6mWQH8RRbikQ0wc0DWtecM9906AWomUhJZFjJcj7K9fPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782128558; c=relaxed/simple;
	bh=f1X7iozWIKB5TNbc2srYWk7bi6i4/AuUu7UyN3QOkBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fyt0fi92XJ93tQttKnzbwpOpagO1lk8J5KXzTQj8ypS9CfOpltCSxmqITBZeCYKQgOHeprDeoOCEirdXg6r8YKEm2Yrlax2D1kK8eDVavaRKzolan6npiEDO9Ti9f7ufvP2HZGk4jgTee+q2NeD4pp7ervjLSPKbKf61nigkgOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JTjktHcY; arc=fail smtp.client-ip=52.101.201.45
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmDkcyooveQROk/7xXKhYTGkaKI/+ETJCgJzO3aPxfpQkn63Y5QB2mJHBM1nZor3RBRHpaaEG2aKMjG4vDScLi+pY15uFNP/JhHZPst3uIUPXXlhsllJ6Vvq8gU7RUONDkAUz4pEQYsbIcobjoHX8DuyQC/En+Vv/TSD16K8l8CM7qFz4nn3x10R614bolNl9ZIG5Tt9pXqw8Bb7AyHt/zLCS2epRmGsRrQVqXa7hAH9HtvnPYP32R8aqy25ef+m6tL9HPscwtLCn7F2Rcs4meqBVvU6lAxtS3vmlM8lG7Wt2p7KNqtsx4s9LqMFOBoFnLaWCDWqsYrVPk6CB+akOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGzfTDNwyWjG9HpRQvbMNE6TG1cxBLkQYtZht5Wh1L4=;
 b=k5NPU5haxdg5dZ1PlqCDg3wsv+eOKjZz+BN1s+qf1BQCT27vDwa7wl0Irt103Wd/Q1lVTCYYIpNIJGKmxkjF8K1xvj/XxJnG+ymh2ZZPUz3PtuVfxI/TFT4UKkIz6FMqJeC3vYEXz53U0NU8J0Oukg72ZZ6FARZ1fn61+4ht/QAJ4BUA0/YGcIQl7VwiXVxvst6LgoT/n4mlMZeVztZ2klW3a8xl81RzOO3HBhor9BZjSOhVJzGppsqG/1rSxr1gNeN1mToteuqwlNB1FYm5bKPfvoJUYmI8ReoQdhOCnR56KugRwuerdOp3jTMnwOiLelo+rh+bL6kG2Ko2ZY+8cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGzfTDNwyWjG9HpRQvbMNE6TG1cxBLkQYtZht5Wh1L4=;
 b=JTjktHcYJFXeDjR2+/hClAW0ltdwQAEccxL1SsAXR4haBjyic7RCT0rr56+Or9U2p73vz5DdI0Rfzc1QW/4G8tom23C98QRGxETVbrLOIE8+jHDp6I73KkxDxmGf4QRkguOAejcJHlYOWhtn4iOSxO2UwozEwUOkHOT7ZPG3AvLNCK7gEtWNVmxsxci/JCg1xaXc4/Hv7q4X9qkpJ/THaXmO2Yy3GMyQZDndqCYfo2mzVHLX8MtMzyacF/ELoAgCluHE/2x6aDXMKKIrR9ZnEye4bjgdzjmRGnbDPOQB4S8YNVOvtJXVX+rSTPFXqTlY4uNzJch2Wju2dsHqx2pHRw==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 11:42:33 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 11:42:33 +0000
Date: Mon, 22 Jun 2026 14:42:23 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
	stephen@networkplumber.org, brian.haley@hp.com, horms@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, dsahern@kernel.org
Subject: Re: [PATCH net v2 7/7] ipv6: reset position for force_forwarding
 sysctl restart
Message-ID: <20260622114223.GA233619@shredder>
References: <20260620161850.7114-1-fmancera@suse.de>
 <20260620161850.7114-8-fmancera@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620161850.7114-8-fmancera@suse.de>
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ced4ea2-de00-4780-4d93-08ded0535948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5muXisUe4LMdeXt2Hd8tjIKRKJCQqGe95Mask/LcMKQ+GfCPFZluAKtPcJrDPaXGiQ2vqQkFtYQ4Gg0AuZq2euu5TiyLA+L53BqxhXLVLxRvn56+Pgwn51TOcfG69YmhZ95C3MBVJlJPdL+rnt5Alzk+S0VhOPN7gcgR2tNJqVe6r9Yo/UjTYn2gG+Cw/RpfzIeTzSjvzI6xRJT3WeLXARhZ2rIjp+AKEa90kPRVz3YupEwSqiFjun6EKkKSTsvx28SB32wbUYAB+L06PDYcEf4/MENtgE4xF9BHYfrQlQl5xzGT+WQ+S+Wh3xrk5dLTkrrTKOKx6/ls47h90GSnCTtifwPUeoAK8BF6/m7SvUwudSOVXYTjrScnb8H//6Dv7PxvdkjHQg0BlUgoLGYlBdL5cayQzj9dIvMwp0ubVOhYy87/2h0Uaq+yb43fKMux773CzcA5wvF+Ug5bvPHLIXoxERZvmCRObErYGTJexpPBrwfhtCSIFBpO5IfNxGjrg/NvPydszStD9RCAvOYe1YYyPkpkjYdx5gTzVnVTezlXnf8+OkXcs42wEUY2KtNieAgYLKkHzvAXW2+0nVuzBHeSYrR9ovMIePHcYtXi+xgaLmOGco0gj9mVSoNwIcRNL4GuVUGaLgsSK/xeyO8MZJ8ssn7jz0Gm/irV7nNc+Tk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NXyxvt0LlakaX5/waWGqHYhIcNTzcclB3N3EuzYDUBOqH/O3CNXkPxoc8yzN?=
 =?us-ascii?Q?Mp63QQUxBVmwDoHKZ++h2eBbUyZPnlhRQnFO2friF2L4vCON/SaBkEWILCN0?=
 =?us-ascii?Q?ALPBco8c4oV+XP/FWxChLCK1CnTybjS3ZKb8lKhpe3aVwkdly/ZqVHHi865s?=
 =?us-ascii?Q?oh7dmgVxm0C7Vtf5ecp7rH4y0XanHpepqQQr2JEJvDf5Ocb+PdM/d5H7f2nc?=
 =?us-ascii?Q?/WeXHPy2jJvw5nXrH1DMoNVvlS8mnRUR6fW02aVkmyBf2+hFoP7TrsbzLVit?=
 =?us-ascii?Q?O5U4sod5axCALuIAew0dA3nu0SO48UgVZunQD1sdTv4mLbSo6HBWPFrYUee/?=
 =?us-ascii?Q?LJaqjKsCeyqPScodxmyrAmPIwpw4SgnvrlgmatNhlgi7LvZFaFEPVpmg71Ud?=
 =?us-ascii?Q?ssc+1gaXjvRBRv2r8PWXwy+Oi+3GrEIpz04WHeRt4+bsmj++wwE3gllQZadj?=
 =?us-ascii?Q?C5NfbEkGAe8QRIGy4vkdzhkmBpR/JTM//a9wj+oROHPuAxbJlCyec5GIOrIQ?=
 =?us-ascii?Q?SQqoAZI8K+eaNyjFEcEGpm57mcycFffmcnUV7/nSKDSdIhTa+EKa9UnybUCB?=
 =?us-ascii?Q?Bzc9ktGz9HZQPzw9UKhLcCx0DSUosLMyhkX2296omPanGjWPtX5BVSdTmeXj?=
 =?us-ascii?Q?WmtNNs2sxVLAhPk2rpWAPVKoNwq0rg8vSF/ey6Xn5/FQopdWFPUBn8KpLKwh?=
 =?us-ascii?Q?c+F7LaZ1lfCwnPtR0Znjukz4kXfmdmlqa7fbvjZra3Uwl8nIu66LiY21y5gI?=
 =?us-ascii?Q?oe8kiQ0qenPbT1SZLgSrj2i9iMxeg0CwECk8VgO+XCiyXVBMO8x/xSyjKM6w?=
 =?us-ascii?Q?uIPrv7c3HEABz4mRPsxy1thaikLaQqkjjCq+NY1uNqOcrwu7XFfHHadfUMPn?=
 =?us-ascii?Q?k/v0+sMjRfW1Qkru7vw4cHfTNmigu+8nytjB8Jepq2TSpxQckEfAsZ9z8+Mp?=
 =?us-ascii?Q?MUCRY2sFensm3DVwi1j4q0AtQiwb/cWKZeK90AvL2LLtTGF4T80kUIaPyv9N?=
 =?us-ascii?Q?qGTt4K+Ww4sHQD986kLEqG7dOpY9KLtwZcJAWKgRSiz0UaxANwHBC0mMMa34?=
 =?us-ascii?Q?CHEs7MsMnDg/qTZxC3nyjyxZ/RnoQLxN1C6OMrJ1DIDc/MppM/TgrsBF5EU9?=
 =?us-ascii?Q?e94PZpu8YaLD1pSmvErAEYq73r3cSldNNkvxBvA278Vn8/6eVHfDwfQFQ30T?=
 =?us-ascii?Q?brCGDkl9WzU8i2hEoZkXSxkIa6bZ+tbiwmfBA3Lh4C4jszcIrA0gqs1kzihx?=
 =?us-ascii?Q?aBJTGkCx6kTte/Zjs4kqhPrmmtW8WZ/O9FmdZG0BR5GCf8pMAhMBmgHOtRDb?=
 =?us-ascii?Q?8+wELUI0bg/PBmsjrJts3w7Fyc6sv/8LSb7XxanzXYWB/N5YcIu5fGbSqBzA?=
 =?us-ascii?Q?Qjf7u+szh6G1Oj0lexE8NSru7NkPZEgStbrRRdK8P2Z8Zl6evKjUxUrup9Sw?=
 =?us-ascii?Q?DIZhCyjfD9F+3rYlemZMZ33XwCNeJglpvjNv7tBU0KkcZEKf5yYOm02FrLU3?=
 =?us-ascii?Q?bsp/Ms/o1zsiRN7h0Xx7xZneIePM8YTnF+YVUWH17tpLg0RRY1L+KyI+dxUF?=
 =?us-ascii?Q?cuSwZzmbMxNkP46ORBL9oaHRicSgQDJGP0fByegpBcJP+5tn3yxmhgjtICPl?=
 =?us-ascii?Q?EFEPhB5k0VECHJzAUo8+vulhDpBFuXz8HbjTl9kIyCA4EsBe4Z2esb86W0pH?=
 =?us-ascii?Q?jyh1NYThP80JqzmO6sk8zDiddyQhb/xq4M2k0/SkuOMAAGA7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ced4ea2-de00-4780-4d93-08ded0535948
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 11:42:33.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CspWfPELcbuGBUzJZS1urw2ay2p0sUwXCONtuwYmtGWaXyxxYbwWp1+xIAPEBBrf93VN1n7Sjqe9kfu3Quw8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301076-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:nicolas.dichtel@6wind.com,m:stephen@networkplumber.org,m:brian.haley@hp.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AFE16AF32C

On Sat, Jun 20, 2026 at 06:18:50PM +0200, Fernando Fernandez Mancera wrote:
> When handling proxy_ndp, if rtnl_net_trylock() fails, the operation is

s/proxy_ndp/force_forwarding/

> retried but the position pointer was already advanced meaning that the
> restarted sysctl will read from an incorrect offset.
> 
> Fix this by restoring the original position pointer before restarting
> the syscall.
> 
> In addition, remove the redundant position pointer restoration at the
> end of the function.
> 
> Fixes: f24987ef6959 ("ipv6: add `force_forwarding` sysctl to enable per-interface forwarding")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  net/ipv6/addrconf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index cbe681de3818..8c0741e9dfcc 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -6825,8 +6825,10 @@ static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int wri
>  	ret = proc_douintvec_minmax(&tmp_ctl, write, buffer, lenp, ppos);
>  
>  	if (write && old_val != new_val) {
> -		if (!rtnl_net_trylock(net))
> +		if (!rtnl_net_trylock(net)) {
> +			*ppos = pos;
>  			return restart_syscall();
> +		}

Are you sure that this is needed?

AFAICT, the position pointer is only advanced if the return value is
positive. From new_sync_write():

kiocb.ki_pos = (ppos ? *ppos : 0);
[...]
ret = filp->f_op->write_iter(&kiocb, &iter);
[...]
if (ret > 0 && ppos)
        *ppos = kiocb.ki_pos;

And restart_syscall() returns '-ERESTARTNOINTR'.

>  
>  		WRITE_ONCE(*valp, new_val);
>  
> @@ -6851,8 +6853,6 @@ static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int wri
>  		rtnl_net_unlock(net);
>  	}
>  
> -	if (ret)
> -		*ppos = pos;
>  	return ret;
>  }
>  
> -- 
> 2.54.0
> 

