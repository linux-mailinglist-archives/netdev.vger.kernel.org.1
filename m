Return-Path: <netdev+bounces-264488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEYzEZe4qWlEDAEAu9opvQ
	(envelope-from <netdev+bounces-264488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:08:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 59998215DE9
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2101A3010768
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 17:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3397619DF62;
	Thu,  5 Mar 2026 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xorf6xqy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFDF3DFC82
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730503; cv=none; b=jeQSGp6ukZNvIrehHj/RhCsTFwVg0wd5WyS2aB3CZpRd1YGjSNVSbB2iPETe3dn357PfnqERfznB7pPSOmzF9g6KguE7mCx1YABHC8ZdLvje1rC2Tl8NPE6MrG8S8e0d2KDjZBWrbRHNEWhVuldhd1sIfBR3UicaG4eVsvtUm0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730503; c=relaxed/simple;
	bh=kjeVjeRwXeGFVkUrVv/LkTvYdN2U0CODM2NGAPyvKTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YP+pkgxeLCceGKWVKdwmPp8OR42DOn/xkVY/8ouYA22oK8x4NBmgkCUoaRAWYXJCWeJq02bKUpU785yAhVi2qkUgu0fpfcXFL0mzI8aFxPYoQEssoMXrXZ0+7yvsTkmzcNn0zPmYzD1XnAt+lbpcSml8IC3TASgilVG/pWWnUmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xorf6xqy; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82748095963so4318408b3a.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 09:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772730501; x=1773335301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QLViSdk5aS+N5/R156GzEYrFhdlvCCHhERFbqQ2qqPA=;
        b=Xorf6xqy1kV74lz9pIwEJRIwAlCRJpNj+eRJ1/IOhHjQG/lqmUKMwIZWQX3eSimdQ1
         SbU0gQOS4jSedAFUTPk66J8PYwIif3vQMRQtIMMJGi47BjIXcWoxGg8/2ydXIiKOTqeE
         Ozz66MK2UznlFn9W2Wbm+sSZTCUu9ZpZZynGxt3zh4NavDSjjdDJCbqvnz9i4ev+ZfVY
         4QlB2cYZc0sCHuxJ7HdiXGAl2Bq82YduPFkq2On+uCU0lfUsS4WQYrHvlqZ7R9jkh260
         80/ajmqgTybb+p+QUaF/FV5bIZ6TWtGRLRvmBPuElcPn0x2iPlaAZDNxQzmRdl6eTK4P
         NGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730501; x=1773335301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLViSdk5aS+N5/R156GzEYrFhdlvCCHhERFbqQ2qqPA=;
        b=kVtWkSgygLLEjsrR6bXCED25WUG5A3o+1jb+qHUGxa7lIuH1HlSUermLCTS6KSu6oK
         Ei5w/gCdpyXgwJapzT11igjSC8JX12OcqmIaNZcr3AQbOy7YJELZuSg/Sv2YiXoxyq8D
         o1z7L/eD4jLpg35LxYgQ4CwXQGlPQXLyCJn22ltmlgCsHAzk+QlEOF25eU3ls7271Tub
         6qrX5bocWpxCsvexhnlsz6UMaX8RyLp+oAXkuKAMf2WDYW/R+v4PYK9RwElZvMwEyqaY
         ximBxogDBgBv6TkGq2Aa7ESJxGzG6PVREtQ2ZU1q8uH0eXbuM9Q2MYEJRSaabWRhevJo
         ALpA==
X-Forwarded-Encrypted: i=1; AJvYcCU5IxjpaweJTvWvQmwjaGyt7/ZVCcrFaG2ZF1bqbpstzyW0+L7ZsNa+6zTYKIYRb29hkWjVt30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXu15f7PG/uMN+dOy7ugsjyzyKawf2p5dufOk6GOiKHYOfwYbr
	F5E4gVG7RAqrzXZJ5Mm0mUjyEvMc/cseZtGrllnNOeb2YdN2f+TsZYsS
X-Gm-Gg: ATEYQzwW+cW0VXFwvD8PjMo6Fp4zExA0IqE2Uor7h+sRH9lTcgTFmETpXnpZaarOGIH
	lt7BfDVomOdkD+H1ORJ4Sllp2XYhMBfl57kdcWZI0q4QxWA+64dyzcUewFpFQV2b7bPn6qQveG2
	82Rr6dx8vhDSiadPs91fXKqTfRlvFo/g31psd7AiS0B/RDEFuyW3bSW7BznqEP1qiHLDgPCjrV+
	WEbnL0isrJXBkEbN0hwcULrJVCdu5P0o63cgXFxy91Lp3GG2SRJ48UbVcDhPR9SDRwaQC81HbGL
	Yqns9vY29mHiNj1CKHjEpvC57m9Sbi6pplsjU/e0K3ymVJcvsM1ypzbyKdgxd5jQ+mowO0IduqZ
	V6eWHeUqP6jJKTsAFRsJjALn3jJRnJt5Q/kTxL5CcX6WYOtzi0ZWlESXurNmCl4XkhqxyGEWMJJ
	E68qhSB16Ou8TzTS2Tch41gp5xexGrXhTqGZPFLsumD0Z30wNmkQwxHkkCYsQ=
X-Received: by 2002:a05:6a00:1782:b0:829:8b1f:a3e1 with SMTP id d2e1a72fcca58-8298b1fabd3mr2212916b3a.63.1772730500879;
        Thu, 05 Mar 2026 09:08:20 -0800 (PST)
Received: from SLSGDTSWING002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d87e78sm26075521b3a.17.2026.03.05.09.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 09:08:20 -0800 (PST)
Date: Fri, 6 Mar 2026 01:08:16 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: security@kernel.org, edumazet@google.com, davem@davemloft.net,
	kuba@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xmei5@asu.edu
Subject: Re: [PATCH net v2] net: add xmit recursion limit to tunnel drivers
Message-ID: <aam4gAw4D782kDsE@SLSGDTSWING002>
References: <20260303164326.1803916-2-bestswngs@gmail.com>
 <a8a81818-459f-4c09-8448-31a191f7b2bb@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8a81818-459f-4c09-8448-31a191f7b2bb@redhat.com>
X-Rspamd-Queue-Id: 59998215DE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264488-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 26-03-05 15:34, Paolo Abeni wrote:
> On 3/3/26 5:43 PM, bestswngs@gmail.com wrote:
> > From: Weiming Shi <bestswngs@gmail.com>
> > 
> > __dev_queue_xmit() has two transmit code paths depending on whether the
> > device has a qdisc attached:
> > 
> >  1. Qdisc path (q->enqueue): calls __dev_xmit_skb()
> >  2. No-qdisc path: calls dev_hard_start_xmit() directly
> > 
> > Commit 745e20f1b626 ("net: add a recursion limit in xmit path") added
> > recursion protection to the no-qdisc path via dev_xmit_recursion()
> > check and dev_xmit_recursion_inc()/dec() tracking. However, the qdisc
> > path performs no recursion depth checking at all.
> > 
> > This allows unbounded recursion through qdisc-attached devices. For
> > example, a bond interface in broadcast mode with gretap slaves whose
> > remote endpoints route back through the bond creates an infinite
> > transmit loop that exhausts the kernel stack:
> > 
> >  BUG: KASAN: stack-out-of-bounds in blake2s.constprop.0+0xe7/0x160
> >  Write of size 32 at addr ffff88810033fed0 by task kworker/0:1/11
> >  Workqueue: mld mld_ifc_work
> >  Call Trace:
> >   <TASK>
> >   __build_flow_key.constprop.0 (net/ipv4/route.c:515)
> >   ip_rt_update_pmtu (net/ipv4/route.c:1073)
> >   iptunnel_xmit (net/ipv4/ip_tunnel_core.c:84)
> >   ip_tunnel_xmit (net/ipv4/ip_tunnel.c:847)
> >   gre_tap_xmit (net/ipv4/ip_gre.c:779)
> >   dev_hard_start_xmit (net/core/dev.c:3887)
> >   sch_direct_xmit (net/sched/sch_generic.c:347)
> >   __dev_queue_xmit (net/core/dev.c:4802)
> >   bond_dev_queue_xmit (drivers/net/bonding/bond_main.c:312)
> >   bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5279)
> >   bond_start_xmit (drivers/net/bonding/bond_main.c:5530)
> >   dev_hard_start_xmit (net/core/dev.c:3887)
> >   __dev_queue_xmit (net/core/dev.c:4841)
> >   ip_finish_output2 (net/ipv4/ip_output.c:237)
> >   ip_output (net/ipv4/ip_output.c:438)
> >   iptunnel_xmit (net/ipv4/ip_tunnel_core.c:86)
> >   gre_tap_xmit (net/ipv4/ip_gre.c:779)
> >   dev_hard_start_xmit (net/core/dev.c:3887)
> >   sch_direct_xmit (net/sched/sch_generic.c:347)
> >   __dev_queue_xmit (net/core/dev.c:4802)
> >   bond_dev_queue_xmit (drivers/net/bonding/bond_main.c:312)
> >   bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5279)
> >   bond_start_xmit (drivers/net/bonding/bond_main.c:5530)
> >   dev_hard_start_xmit (net/core/dev.c:3887)
> >   __dev_queue_xmit (net/core/dev.c:4841)
> >   ip_finish_output2 (net/ipv4/ip_output.c:237)
> >   ip_output (net/ipv4/ip_output.c:438)
> >   iptunnel_xmit (net/ipv4/ip_tunnel_core.c:86)
> >   ip_tunnel_xmit (net/ipv4/ip_tunnel.c:847)
> >   gre_tap_xmit (net/ipv4/ip_gre.c:779)
> >   dev_hard_start_xmit (net/core/dev.c:3887)
> >   sch_direct_xmit (net/sched/sch_generic.c:347)
> >   __dev_queue_xmit (net/core/dev.c:4802)
> >   bond_dev_queue_xmit (drivers/net/bonding/bond_main.c:312)
> >   bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5279)
> >   bond_start_xmit (drivers/net/bonding/bond_main.c:5530)
> >   dev_hard_start_xmit (net/core/dev.c:3887)
> >   __dev_queue_xmit (net/core/dev.c:4841)
> >   mld_sendpack
> >   mld_ifc_work
> >   process_one_work
> >   worker_thread
> >   </TASK>
> > 
> > Rather than adding an expensive recursion check to the common qdisc
> > fast path, add recursion detection directly in tunnel drivers where
> > route lookups can create these loops, as suggested by Eric Dumazet.
> > 
> > Use a lower limit (IP_TUNNEL_RECURSION_LIMIT=4) than XMIT_RECURSION_LIMIT
> > (8) because each tunnel recursion level involves route lookups and full
> > IP output processing, consuming significantly more stack per level.
> > 
> > Move dev_xmit_recursion helpers from the private net/core/dev.h header
> > to the public include/linux/netdevice.h so tunnel drivers can use them.
> > 
> > Fixes: 745e20f1b626 ("net: add a recursion limit in xmit path")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> > v2:
> >   - Move recursion check from qdisc path to tunnel drivers (Eric Dumazet)
> >   - Add IPv6 tunnel (ip6_tunnel) coverage
> >   - Use lower recursion limit (4) for tunnel-specific stack consumption
> > 
> >  include/linux/netdevice.h | 32 ++++++++++++++++++++++++++++++++
> >  include/net/ip_tunnels.h  |  7 +++++++
> >  net/core/dev.h            | 34 ----------------------------------
> >  net/ipv4/ip_tunnel.c      | 10 ++++++++++
> >  net/ipv6/ip6_tunnel.c     | 10 ++++++++++
> >  5 files changed, 59 insertions(+), 34 deletions(-)
> > 
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index d4e6e00bb90a..1a4d2542dbab 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -3576,17 +3576,49 @@ struct page_pool_bh {
> >  };
> >  DECLARE_PER_CPU(struct page_pool_bh, system_page_pool);
> >  
> > +#define XMIT_RECURSION_LIMIT	8
> > +
> >  #ifndef CONFIG_PREEMPT_RT
> >  static inline int dev_recursion_level(void)
> >  {
> >  	return this_cpu_read(softnet_data.xmit.recursion);
> >  }
> > +
> > +static inline bool dev_xmit_recursion(void)
> > +{
> > +	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
> > +			XMIT_RECURSION_LIMIT);
> > +}
> > +
> > +static inline void dev_xmit_recursion_inc(void)
> > +{
> > +	__this_cpu_inc(softnet_data.xmit.recursion);
> > +}
> > +
> > +static inline void dev_xmit_recursion_dec(void)
> > +{
> > +	__this_cpu_dec(softnet_data.xmit.recursion);
> > +}
> >  #else
> >  static inline int dev_recursion_level(void)
> >  {
> >  	return current->net_xmit.recursion;
> >  }
> >  
> > +static inline bool dev_xmit_recursion(void)
> > +{
> > +	return unlikely(current->net_xmit.recursion > XMIT_RECURSION_LIMIT);
> > +}
> > +
> > +static inline void dev_xmit_recursion_inc(void)
> > +{
> > +	current->net_xmit.recursion++;
> > +}
> > +
> > +static inline void dev_xmit_recursion_dec(void)
> > +{
> > +	current->net_xmit.recursion--;
> > +}
> >  #endif
> >  
> >  void __netif_schedule(struct Qdisc *q);
> > diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> > index 4021e6a73e32..80662f812080 100644
> > --- a/include/net/ip_tunnels.h
> > +++ b/include/net/ip_tunnels.h
> > @@ -27,6 +27,13 @@
> >  #include <net/ip6_route.h>
> >  #endif
> >  
> > +/* Recursion limit for tunnel xmit to detect routing loops.
> > + * Unlike XMIT_RECURSION_LIMIT (8) used in the no-qdisc path, tunnel
> > + * recursion involves route lookups and full IP output, consuming much
> > + * more stack per level, so a lower limit is needed.
> > + */
> > +#define IP_TUNNEL_RECURSION_LIMIT	4
> > +
> >  /* Keep error state on tunnel for 30 sec */
> >  #define IPTUNNEL_ERR_TIMEO	(30*HZ)
> >  
> > diff --git a/net/core/dev.h b/net/core/dev.h
> > index 98793a738f43..ec974b3c42d9 100644
> > --- a/net/core/dev.h
> > +++ b/net/core/dev.h
> > @@ -366,40 +366,6 @@ static inline void napi_assert_will_not_race(const struct napi_struct *napi)
> >  
> >  void kick_defer_list_purge(unsigned int cpu);
> >  
> > -#define XMIT_RECURSION_LIMIT	8
> > -
> > -#ifndef CONFIG_PREEMPT_RT
> > -static inline bool dev_xmit_recursion(void)
> > -{
> > -	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
> > -			XMIT_RECURSION_LIMIT);
> > -}
> > -
> > -static inline void dev_xmit_recursion_inc(void)
> > -{
> > -	__this_cpu_inc(softnet_data.xmit.recursion);
> > -}
> > -
> > -static inline void dev_xmit_recursion_dec(void)
> > -{
> > -	__this_cpu_dec(softnet_data.xmit.recursion);
> > -}
> > -#else
> > -static inline bool dev_xmit_recursion(void)
> > -{
> > -	return unlikely(current->net_xmit.recursion > XMIT_RECURSION_LIMIT);
> > -}
> > -
> > -static inline void dev_xmit_recursion_inc(void)
> > -{
> > -	current->net_xmit.recursion++;
> > -}
> > -
> > -static inline void dev_xmit_recursion_dec(void)
> > -{
> > -	current->net_xmit.recursion--;
> > -}
> > -#endif
> >  
> >  int dev_set_hwtstamp_phylib(struct net_device *dev,
> >  			    struct kernel_hwtstamp_config *cfg,
> > diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> > index 50d0f5fe4e4c..39822e845a06 100644
> > --- a/net/ipv4/ip_tunnel.c
> > +++ b/net/ipv4/ip_tunnel.c
> > @@ -683,6 +683,14 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
> >  	__be32 dst;
> >  	__be16 df;
> >  
> > +	if (dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT) {
> > +		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
> > +				     dev->name);
> > +		DEV_STATS_INC(dev, tx_errors);
> > +		kfree_skb(skb);
> > +		return;
> > +	}
> > +
> >  	inner_iph = (const struct iphdr *)skb_inner_network_header(skb);
> >  	connected = (tunnel->parms.iph.daddr != 0);
> >  	payload_protocol = skb_protocol(skb, true);
> > @@ -842,8 +850,10 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
> >  
> >  	ip_tunnel_adj_headroom(dev, max_headroom);
> >  
> > +	dev_xmit_recursion_inc();
> >  	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
> >  		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
> 
> I think this check should go in iptunnel_xmit(), or UDP tunnels will
> remain unprotected.
> 
> Same thing for the IPv6 case.
> 
> > +	dev_xmit_recursion_dec();
> >  	return;
> >  
> >  #if IS_ENABLED(CONFIG_IPV6)
> > diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> > index 4c29aa94e86e..55bedd5cd656 100644
> > --- a/net/ipv6/ip6_tunnel.c
> > +++ b/net/ipv6/ip6_tunnel.c
> > @@ -1101,6 +1101,14 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
> >  	u8 hop_limit;
> >  	int err = -1;
> >  
> > +	if (dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT) {
> > +		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
> > +				     dev->name);
> > +		DEV_STATS_INC(dev, tx_errors);
> > +		kfree_skb(skb);
> > +		return -1;
> 
> I think an standard error code is expected here. Possibly -ELOOP?
> 
> /P
> 
Hi Paolo,

Thanks for the review.
I agree that moving the check into iptunnel_xmit() / ip6tunnel_xmit()
is better, as it also covers UDP tunnels. Will do in v3.

Thanks,
Weiming Shi

