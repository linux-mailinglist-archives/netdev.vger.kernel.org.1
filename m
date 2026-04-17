Return-Path: <netdev+bounces-279210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mILKBuac4WkQvgAAu9opvQ
	(envelope-from <netdev+bounces-279210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:37:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6896A416432
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B694C301159F
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4618225CC57;
	Fri, 17 Apr 2026 02:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fx/dBmA8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233551F4C8E;
	Fri, 17 Apr 2026 02:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776393236; cv=none; b=dbT77nTIuIBUbDWqLmfRXjvNXIVl/9gALg+VOX1F+tLarwuTvJ4P+NH6JQYPv3gpWTCjxb6f/OEfuzK984U3ZI5AkYl+HQzbemN52xNbSESliJJ4hNw8WrY9uvLDRIaC7QifWbm30LSkVodedtI6p7CYsZVzsXGA7CfDcVBhtY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776393236; c=relaxed/simple;
	bh=NgDhMuhX+mduYsCUeTgLc0RFuzavsU++uXXhXLkXtKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8ICcjdXSIhgigvh92N49yaXqjeyHZOQjX9k16ez7G6CR2mbYJV/wB5FbeffjESkAb7FTZIpC/3+HhUuKGZvn3UBl2pdt4qt3tdIuysj7Mif1W2/CFfd/fghScjsoV3ewl6myfHjZUoAki/wsqCkIxah2Jrb7FYHQcusWQB3YMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fx/dBmA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293BFC2BCAF;
	Fri, 17 Apr 2026 02:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776393235;
	bh=NgDhMuhX+mduYsCUeTgLc0RFuzavsU++uXXhXLkXtKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fx/dBmA8GbEACOx2h3FEQmRKMLAejM7NVX9nNzqB7v8X/ecYSS0lgeL3EOiir0OkB
	 4uJK01y4cAimd5jEaTgGNFlWz/bdjkrhtay7/G5w3+A8EZsbviPu650p9TYAKvK/V1
	 uhTmJMzQz92/fJcr2IieuU+l2fpEZCAjOwfMRF4UME4wl8KsAmcd9R3XlUgZvcrXD/
	 PK72l/5oc7EjMy3iKqGDx2dfhk3n3SDzAOk4Wc4ekKn50Tuebs/YFC8Qm1BrVFvsKP
	 8S3ofrSRrYMkyMvT47fiXzsNjkS54CrjRm1zbsc5tSgH0sizN8Gxbz2u4g4V8ePeBX
	 IDRGBAONT3lhw==
Date: Thu, 16 Apr 2026 19:33:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ido Schimmel <idosch@idosch.org>
Subject: Re: [PATCH] net: ipv4: igmp: add sysctl option to ignore inbound
 llm_reports
Message-ID: <20260416193354.0e57bd6f@kernel.org>
In-Reply-To: <20260415-v7-0-topic-igmp-llm-drop-v1-1-1367bfbb898e@pengutronix.de>
References: <20260415-v7-0-topic-igmp-llm-drop-v1-1-1367bfbb898e@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279210-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email,inr.ac.ru:email]
X-Rspamd-Queue-Id: 6896A416432
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 15 Apr 2026 12:26:13 +0200 Steffen Trumtrar wrote:
> Add a new sysctl option 'igmp_link_local_mcast_reports_drop' that allows
> dropping inbound IGMP reports for link-local multicast groups in the
> 224.0.0.X range. This can be used to prevent the local system from
> processing IGMP reports for link local multicast groups and therefore
> let the kernel still send the own outbound IGMP reports.

+Ido to CC

I'm not sure what is reasonable here and what should be a firewall rule.
Either way:

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for
v7.1, and therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes
only.

Please repost when net-next reopens after Apr 27th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

>  Documentation/networking/ip-sysctl.rst                       | 12 ++++++++++++
>  .../networking/net_cachelines/netns_ipv4_sysctl.rst          |  1 +
>  include/net/netns/ipv4.h                                     |  1 +
>  net/ipv4/af_inet.c                                           |  1 +
>  net/ipv4/igmp.c                                              |  2 ++
>  net/ipv4/sysctl_net_ipv4.c                                   |  7 +++++++
>  6 files changed, 24 insertions(+)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 6921d8594b849..2da4cd6ac7202 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -2306,6 +2306,18 @@ igmp_link_local_mcast_reports - BOOLEAN
>  
>  	Default TRUE
>  
> +igmp_link_local_mcast_reports_drop - BOOLEAN
> +	Drop inbound IGMP reports for link local multicast groups in
> +	the 224.0.0.X range. When enabled, IGMP membership reports for
> +	link local multicast addresses are silently dropped without
> +	processing.
> +	When the kernel gets inbound IGMP reports it stops sending own
> +	IGMP reports. With allowing to drop and process the inbound reports,
> +	the kernel will not stop sending the own reports, even when IGMP
> +	reports from other hosts are seen on the network.
> +
> +	Default FALSE
> +
>  Alexey Kuznetsov.
>  kuznet@ms2.inr.ac.ru
>  
> diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
> index beaf1880a19bf..703afe2ba063b 100644
> --- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
> +++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
> @@ -140,6 +140,7 @@ int                             sysctl_udp_rmem_min
>  u8                              sysctl_fib_notify_on_flag_change
>  u8                              sysctl_udp_l3mdev_accept
>  u8                              sysctl_igmp_llm_reports
> +u8                              sysctl_igmp_llm_reports_drop
>  int                             sysctl_igmp_max_memberships
>  int                             sysctl_igmp_max_msf
>  int                             sysctl_igmp_qrv
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index 8e971c7bf1646..1453f825ffd4d 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -258,6 +258,7 @@ struct netns_ipv4 {
>  	u8 sysctl_igmp_llm_reports;
>  	int sysctl_igmp_max_memberships;
>  	int sysctl_igmp_max_msf;
> +	u8 sysctl_igmp_llm_reports_drop;
>  	int sysctl_igmp_qrv;
>  
>  	struct ping_group_range ping_group_range;
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index c7731e300a442..b8f96a5d8afdc 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1825,6 +1825,7 @@ static __net_init int inet_init_net(struct net *net)
>  	net->ipv4.sysctl_igmp_max_msf = 10;
>  	/* IGMP reports for link-local multicast groups are enabled by default */
>  	net->ipv4.sysctl_igmp_llm_reports = 1;
> +	net->ipv4.sysctl_igmp_llm_reports_drop = 0;
>  	net->ipv4.sysctl_igmp_qrv = 2;
>  
>  	net->ipv4.sysctl_fib_notify_on_flag_change = 0;
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index a674fb44ec25b..3a4932e4108bd 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -931,6 +931,8 @@ static bool igmp_heard_report(struct in_device *in_dev, __be32 group)
>  	if (ipv4_is_local_multicast(group) &&
>  	    !READ_ONCE(net->ipv4.sysctl_igmp_llm_reports))
>  		return false;
> +	if (READ_ONCE(net->ipv4.sysctl_igmp_llm_reports_drop))
> +		return true;
>  
>  	rcu_read_lock();
>  	for_each_pmc_rcu(in_dev, im) {
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 5654cc9c8a0b9..24dde84d289e4 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -948,6 +948,13 @@ static struct ctl_table ipv4_net_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dou8vec_minmax,
>  	},
> +	{
> +		.procname	= "igmp_link_local_mcast_reports_drop",
> +		.data		= &init_net.ipv4.sysctl_igmp_llm_reports_drop,
> +		.maxlen		= sizeof(u8),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dou8vec_minmax,
> +	},
>  	{
>  		.procname	= "igmp_max_memberships",
>  		.data		= &init_net.ipv4.sysctl_igmp_max_memberships,
> 
> ---
> base-commit: 028ef9c96e96197026887c0f092424679298aae8
> change-id: 20260415-v7-0-topic-igmp-llm-drop-e4c13dbf17cc
> 
> Best regards,
> --  
> Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
-- 
pw-bot: defer
pv-bot: closed



