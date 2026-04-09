Return-Path: <netdev+bounces-277039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKurNZ/A12mdSQgAu9opvQ
	(envelope-from <netdev+bounces-277039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:07:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1CA3CC663
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31DC43009F20
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803D73BFE3C;
	Thu,  9 Apr 2026 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFEJvn/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD413CE499
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747172; cv=none; b=WnztVFVBUKLK4cklDLS98V9maKQQNAEPCliVL8XOweBU0ZYoBKM+bifTQAb+gMUPYY0h+qrx52zsPNt/vS5AXvxqXrG+2vQtcu4nN/PtSDeEAU4jWz78GSRiyaKm3LgQwo2RSnx6iVdSAuMX2+v1rQE2w/+179SnVmlE2vHc0NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747172; c=relaxed/simple;
	bh=iduZko/88iujLyFvTRXcgG+QUimtLLRipU7l8Yq24Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8D8aK58LGLSMWZlmslpCl7LCDJE9Cxll8v7thAfHn9Q3gzhfh+YeZt4xLRPFUXfZPICYKofKF6vnJVawJmcHWNKQNpLUmeAGbqQrFLSjfODQRoJDSVK1emXVqO2IiXs4a3Q0csnIyxwmqz2JLGj0mwtnox9/xMT+EbnO2TJnqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFEJvn/E; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82748257f5fso563595b3a.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 08:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775747170; x=1776351970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JNkav/yhWdJLbDPIInjuFZXY0iHAcSm7PTNNRKiplfk=;
        b=aFEJvn/EEpt+JVsqt2JniGJgVgE3MgGuKMeDYK0/zVYJlgudOoSmY/SIKefkld9Log
         Jn3+mggIq4vvF1F0wjZ/k8Z35CGkD9S+ajQMAzVxsteGVB5N2Hz8EH2FHqcC44K6XnT3
         0u9e1IOz2kFDhjOpgoIUJPkV9CvkO2QpuUzlytupwQcQnj5upmOYCCUxPd474dimNwWo
         sM1uUx93KCLZAPYeo4Nm5bTMTXw9o6LqSvZa5Q4GaxbFNGeZh30RWDhWg0A4E4/0mpYQ
         bOIT3AJDOeo5gILw+HnF1QVymyCv4AhHnK0JIBmACgUidFuXV44Q1gYbJy+WT/GeFhci
         xs6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775747170; x=1776351970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNkav/yhWdJLbDPIInjuFZXY0iHAcSm7PTNNRKiplfk=;
        b=UGpKbJJCcHA266kggitvf6i9/nVOWJfs/BFcX9AQ84SZj6NjJsGNjfI5ESPXgB9nb5
         iPJ9X6RgPYrO89qcZhx7STkJjpyD0hZd1SXGZNDiM39PkKzseYHa898DJOuoTopYFSve
         zX0Ri7MBcUlwf5Lc7DFvt0zfy9HHwrdvxeyUwvJY2E87Cigv9AR/iLobGOsnx308jD/2
         tx/quc0IiuVvShPos+OppulQ7rPeV7/eNn/0ADLYY43kKWLlCi0N5XZoSpma/E7XCnG1
         +x/Hu09zL4Lh21DoyJz7+A9q/heoN0kTRXWmo1I+VWsDE4ckfOnuCnYpitwoVRAGYyEp
         rfPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQjyvqWIFY32rF08d4BfdRv1dF9IY1XM25Mu/ZbVhO3GBe0PAxGyq57vrVYjaC9T1CSvqEHOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKlt0RN5zodP6V+TTxSqowGjaTbFGW2i+B0+tCcD3V6PWFxosP
	A3br5eWV2r2vzKTpm8uoxmR4bprn6epkOz+rVTLP9ma0yaahIsgRkvOR
X-Gm-Gg: AeBDiesMwXfYD4UkchvMIfNpRRnoMmrpZqf0Wmd5gAGkYOQFYg/Y45ZdrFCZrGRChoo
	SA/KJO+6rCQD2CAPfgI9JcH+xZfGl41j5APSAsL/XHgMwaLTmA9LxewTFyjSvhJrA/jwRK3K0dn
	fbHgoaZyuhD0iWJPZ0zSV7eyeMuX+X684NRAHhNd0Y0rRL1hN7kjOHACfxrckvv9hXVBL7h8TuH
	X1TEBlYU/Ly2ITNxwN1GIGEN7PkUm4+/ywSYKelCbyM4awPElgksGOLZQZcsGarASK3REZ9FgaR
	xWrv0otxTILOS1FexhYK2lCX77rqWXScbVZtA54bGvxUblWrpNQaG/12SiLwF9rkZJ2Bzgt3JfA
	gu+6Prj3tztFcM6PzBdxZexQAEzY2K66MR1AsnmhquLA55v2iGDH8c4Rqp0e95YQCnc4mRV0nNW
	FiY3C1rQY/3OqSVihc/kWSlJX3NJoBaRK/ErpL/0x8SNEX+5gQR2n1Cg9tkFi7
X-Received: by 2002:aa7:8892:0:b0:829:6f7d:3086 with SMTP id d2e1a72fcca58-82dd8aba240mr3203326b3a.11.1775747170163;
        Thu, 09 Apr 2026 08:06:10 -0700 (PDT)
Received: from SLSGDTSWING002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6ba2fsm24779155b3a.45.2026.04.09.08.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:06:09 -0700 (PDT)
Date: Thu, 9 Apr 2026 23:06:05 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Phil Sutter <phil@nwl.cc>, Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH v2] netfilter: nft_fwd_netdev: use recursion counter in
 neigh egress path
Message-ID: <adfAXBbb3P616LX-@SLSGDTSWING002>
References: <20260409104911.722698-2-bestswngs@gmail.com>
 <adeIF7ZsJsZsgwQy@chamomile>
 <adeLtBMyR3KZInDW@chamomile>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adeLtBMyR3KZInDW@chamomile>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277039-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F1CA3CC663
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-04-09 13:21, Pablo Neira Ayuso wrote:
> On Thu, Apr 09, 2026 at 01:06:03PM +0200, Pablo Neira Ayuso wrote:
> > On Thu, Apr 09, 2026 at 06:49:12PM +0800, Weiming Shi wrote:
> > > nft_fwd_neigh can be used in egress chains (NF_NETDEV_EGRESS). When the
> > > forwarding rule targets the same device or two devices forward to each
> > > other, neigh_xmit() triggers dev_queue_xmit() which re-enters
> > > nf_hook_egress(), causing infinite recursion and stack overflow.
> > > 
> > > Move the nf_get_nf_dup_skb_recursion() accessor and NF_RECURSION_LIMIT
> > > to the shared header nf_dup_netdev.h as a static inline, so that
> > > nft_fwd_netdev can use the recursion counter directly without exported
> > > function call overhead. Guard neigh_xmit() with the same recursion
> > > limit already used in nf_do_netdev_egress().
> > > 
> > > Fixes: f87b9464d152 ("netfilter: nft_fwd_netdev: Support egress hook")
> > 
> > I would just restrict this "feature", I don't see a point in allowing
> > this from egress?
> 
> Hm, actually this can be combined with if0 device, fixing it makes sense.
> 
> > > Reported-by: Xiang Mei <xmei5@asu.edu>
> > > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > > ---
> > >  include/net/netfilter/nf_dup_netdev.h | 13 +++++++++++++
> > >  net/netfilter/nf_dup_netdev.c         | 16 ----------------
> > >  net/netfilter/nft_fwd_netdev.c        |  7 +++++++
> > >  3 files changed, 20 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/include/net/netfilter/nf_dup_netdev.h b/include/net/netfilter/nf_dup_netdev.h
> > > index b175d271aec9..609bcf422a9b 100644
> > > --- a/include/net/netfilter/nf_dup_netdev.h
> > > +++ b/include/net/netfilter/nf_dup_netdev.h
> > > @@ -3,10 +3,23 @@
> > >  #define _NF_DUP_NETDEV_H_
> > >  
> > >  #include <net/netfilter/nf_tables.h>
> > > +#include <linux/netdevice.h>
> > > +#include <linux/sched.h>
> > >  
> > >  void nf_dup_netdev_egress(const struct nft_pktinfo *pkt, int oif);
> > >  void nf_fwd_netdev_egress(const struct nft_pktinfo *pkt, int oif);
> > >  
> > > +#define NF_RECURSION_LIMIT	2
> > > +
> > > +static inline u8 *nf_get_nf_dup_skb_recursion(void)
> > > +{
> > > +#ifndef CONFIG_PREEMPT_RT
> > > +	return this_cpu_ptr(&softnet_data.xmit.nf_dup_skb_recursion);
> > > +#else
> > > +	return &current->net_xmit.nf_dup_skb_recursion;
> > > +#endif
> > > +}
> > > +
> > >  struct nft_offload_ctx;
> > >  struct nft_flow_rule;
> > >  
> > > diff --git a/net/netfilter/nf_dup_netdev.c b/net/netfilter/nf_dup_netdev.c
> > > index fab8b9011098..a958a1b0c5be 100644
> > > --- a/net/netfilter/nf_dup_netdev.c
> > > +++ b/net/netfilter/nf_dup_netdev.c
> > > @@ -13,22 +13,6 @@
> > >  #include <net/netfilter/nf_tables_offload.h>
> > >  #include <net/netfilter/nf_dup_netdev.h>
> > >  
> > > -#define NF_RECURSION_LIMIT	2
> > > -
> > > -#ifndef CONFIG_PREEMPT_RT
> > > -static u8 *nf_get_nf_dup_skb_recursion(void)
> > > -{
> > > -	return this_cpu_ptr(&softnet_data.xmit.nf_dup_skb_recursion);
> > > -}
> > > -#else
> > > -
> > > -static u8 *nf_get_nf_dup_skb_recursion(void)
> > > -{
> > > -	return &current->net_xmit.nf_dup_skb_recursion;
> > > -}
> > > -
> > > -#endif
> > > -
> > >  static void nf_do_netdev_egress(struct sk_buff *skb, struct net_device *dev,
> > >  				enum nf_dev_hooks hook)
> > >  {
> > > diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
> > > index 152a9fb4d23a..492bb599a499 100644
> > > --- a/net/netfilter/nft_fwd_netdev.c
> > > +++ b/net/netfilter/nft_fwd_netdev.c
> > > @@ -141,13 +141,20 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
> > >  		goto out;
> > >  	}
> > >  
> > > +	if (*nf_get_nf_dup_skb_recursion() > NF_RECURSION_LIMIT) {
> > > +		verdict = NF_DROP;
> > > +		goto out;
> > > +	}
> > > +
> > >  	dev = dev_get_by_index_rcu(nft_net(pkt), oif);
> > >  	if (dev == NULL)
> > >  		return;
> > >  
> > >  	skb->dev = dev;
> > >  	skb_clear_tstamp(skb);
> > > +	(*nf_get_nf_dup_skb_recursion())++;
> > >  	neigh_xmit(neigh_table, dev, addr, skb);
> > > +	(*nf_get_nf_dup_skb_recursion())--;
> > >  out:
> > >  	regs->verdict.code = verdict;
> > >  }
> > > -- 
> > > 2.43.0
> > > 
> > > 

Thanks Pablo. So shall I keep v2 as is, or is there anything else you'd 
like me to change?

