Return-Path: <netdev+bounces-279738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GZRNJMk5ml1sgEAu9opvQ
	(envelope-from <netdev+bounces-279738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:05:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3656542B34F
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7DA2301B06D
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750B53A1685;
	Mon, 20 Apr 2026 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhXNb/Ch"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470E534405B
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690301; cv=none; b=O1R6NkmVe5EkopeeDOaLFz83Wn1nZpup2l14pyQ3m2Bn9CON/k+sSl6zrbbAQtW4+ww/cuMHWMsBiE0FP/p2UPlaqKs95d7/ZmcPcxPyD1YFd0Xx6Ba2bA4UMAfNndleCC4/BRXGezaH9OXowv+61xiRIfEX/kpsPSR8+tO4ghs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690301; c=relaxed/simple;
	bh=fVzxhqZXK6Qwiio7PBsf0pdv4mmkoZ3a6cA74QPhfCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMmACcWGn2oEt5cmRf5zLa2Z0sWzwOwvSZUuJXTp3jx1o60tNkne//dvZNyGYx28qsXWP4u238WNk0cM2BKWs397SpfNXtvGG2GuxRsaM1C/ALmWWzbZmsmRuAz38XVvOkF4gVTDVCFR8zPatevnvceTzAqrNvHFArBPfkgULwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhXNb/Ch; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso35206905e9.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 06:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776690296; x=1777295096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZ7NBcfywwnvJcmvihRMyw1jnkfoOgzM6bLzAxo7IkU=;
        b=dhXNb/CheMNS3lLXgtT/BhxC7hHKtzh3I2GL+EsKPE32HtFTvEaX7b2LzeiVBqMRKg
         tiA93jMdCOOvmUBwc2SVjIhRcj5hcCVeHP+LxZXOczPnjo3uIr7K1i4zmjhBxAxFmdF/
         mjHAuS+sthZAGKD6eNrQht8uefxr4Ry7VkTPHURLo+U+1+Es6bSiiG2uLxFnQ77ZPHE7
         BkQ/fAWyXJG6CYru1bs50hVdsuYgP+xgqF729O6tml7U8ncwYb5JtMzNrqxPogaNH6Sa
         ntLD2anHyahsAzIUvn87qPf5fWrg9liZMg9b381sBbxy/9vAaaSG4/kYSymyi/VSzsbE
         v/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776690296; x=1777295096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZ7NBcfywwnvJcmvihRMyw1jnkfoOgzM6bLzAxo7IkU=;
        b=L9nvAA0eJwBOlDAf9uNHOZFarFL8neRp3qRDJ9Hv3oolpfDUX0uBbzagPu1wG1DJjn
         t+CX/Nwh5iKel9EnCndFoDPWvl8gAebYBsQGWBEBLz7SNP775e1+NFtAkj2yDI2I25lI
         j6z7nIQXzivdiKtONfPjP/aXcXnjIFnclh2Pz4tvqOxNkLMbuIgrF2fYSvUgPo8aRql+
         IA66tQh/fPFTxPmW5ysVKvJbWxuUuvjhg/BlYoz/9dM3IZ6Diz5NbX6r/sN4vsOGcvsE
         IVv3uYdTekJ8QY6Y4GJPXYbTsv1ydK7Rh9P/Ach8fcQOQdlNNxCEnXfK/hvjipfn3VFf
         UEwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yT9CFb72RfdXJSRgjNFuXlA84i2pgr7jftpu9KFwhiGxlz+pcosBTbGF6QxrkRb7m2XAL0+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeFp5izzmGozw2Nkg2auNAoRsFSd1aU2tWPd+NJcfCB7lu5PDr
	hFr86ldEdMMUFxPll9vdazz7kO2y9c2AUW9Uo+DiFysIawtaqqUawno5
X-Gm-Gg: AeBDiet0AwgRMB8b75NXjaAnISdluhHcKRJmZTOoeTHXdCR4okGc26IPgwafFpJJl4P
	quasa0UugUtAqBQ9XCdOY27tKrhfcSMENgaor/6+wUM3UXoM6JgfxM1w1FpXyWLsdsCy6nzs7Ls
	YZy79H80EvskXLOTaVaMIdMbKektehy7ed0I3TAU3IPyCAPS9aYrsnQGdM+YQ90fFEwhvWzwQCp
	CSvPz/ysAGcFC5D2nCur/QzfC1MHfB1Gl0XhSlyKhV+/MfsF/IcxniLw+xaqq2SdNAzjMwN4+VK
	WRVGpgzIjvkXTwwEsZiDRMKNdSXGLbTUszgXA0mex5BiTp/xmPq65HVP3gpmzLoo1DMdOZuD8Os
	5R5vth0k9e6h4BswworDv3LbybncECOmL3vm/xJftwGaJj6o0t8Puli5swVMurX0FxlPdZR+H2H
	M4xug9iivOCluTyZPAzX6UKVbJIqZ9iYc4mlhDeYmzKhcFEoAhB5BWNp6ZvgJRpalonA==
X-Received: by 2002:a05:600c:b96:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48a53390f6cmr9778795e9.9.1776690295193;
        Mon, 20 Apr 2026 06:04:55 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc140c82sm262361005e9.12.2026.04.20.06.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:04:54 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:04:52 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, coreteam@netfilter.org, daniel@iogearbox.net,
	fw@strlen.de, john.fastabend@gmail.com, lkp@intel.com,
	martin.lau@linux.dev, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v4 1/6] net: move netfilter
 nf_reject_fill_skb_dst to core ipv4
Message-ID: <aeYkdKm7B4NQ3BDo@gmail.com>
References: <20260420105816.72168-2-mahe.tardy@gmail.com>
 <c0aa7f264055f44ac4c93aa4718473e89ed13b8bb11de3179ed40d2f88a99257@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0aa7f264055f44ac4c93aa4718473e89ed13b8bb11de3179ed40d2f88a99257@mail.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,netfilter.org,iogearbox.net,strlen.de,intel.com,linux.dev,lists.linux.dev,meta.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-279738-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3656542B34F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 11:36:12AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/net/route.h b/include/net/route.h
> > index f90106f383c5..ec2466fd0bec 100644
> > --- a/include/net/route.h
> > +++ b/include/net/route.h
> > @@ -173,6 +173,7 @@ struct rtable *ip_route_output_flow(struct net *, struct flowi4 *flp,
> >  				    const struct sock *sk);
> >  struct dst_entry *ipv4_blackhole_route(struct net *net,
> >  				       struct dst_entry *dst_orig);
> > +int ip_route_reply_fetch_dst(struct sk_buff *skb);
> >
> >  static inline struct rtable *ip_route_output_key(struct net *net, struct flowi4 *flp)
> >  {
> 
> [ ... ]
> 
> > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > index bc1296f0ea69..7091ef936073 100644
> > --- a/net/ipv4/route.c
> > +++ b/net/ipv4/route.c
> > @@ -2945,6 +2945,21 @@ struct rtable *ip_route_output_flow(struct net *net, struct flowi4 *flp4,
> >  }
> >  EXPORT_SYMBOL_GPL(ip_route_output_flow);
> >
> > +int ip_route_reply_fetch_dst(struct sk_buff *skb)
> > +{
> > +	struct rtable *rt;
> > +	struct flowi4 fl4 = {
> > +		.daddr = ip_hdr(skb)->saddr
> > +	};
> > +
> > +	rt = ip_route_output_key(dev_net(skb->dev), &fl4);
> > +	if (IS_ERR(rt))
> > +		return PTR_ERR(rt);
> > +	skb_dst_set(skb, &rt->dst);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(ip_route_reply_fetch_dst);
> 
> Is ip_route_reply_fetch_dst() actually needed before calling icmp_send()?
> 
> Martin KaFai Lau raised this question in v3 of the patch series and
> noted that icmpv6_send() does its own route lookup and doesn't use
> skb_dst() of the original skb. He also pointed out that at
> cgroup/egress, skb->_skb_refdst should already be set.
> 
> Looking at icmpv6_send(), the fl6.{daddr,saddr} are filled and passed
> to icmpv6_route_lookup, which performs the reverse/invert route lookup.
> The function doesn't appear to use skb_dst() of the original skb.
> 
> Since this patch moves ip_route_reply_fetch_dst() from netfilter to
> core specifically for the BPF kfunc, can you clarify why this routing
> step is necessary? Does the kfunc not work without
> ip[6]_route_reply_fetch_dst()?
> 
> Reference: https://lore.kernel.org/bpf/df4b0996-3e88-4ea4-983b-82866455a6fc@linux.dev/

Yes I replied to this in the cover letter, let me quote it:

Initially, this kfunc was added only to cgroup_skb programs, Alexei
suggested not creating its own kfunc set and adding it to the more
global bpf_kfunc_set_skb. Now that recursion is handled and I realized,
thanks to Martin, that fetching the dst route might be only useful in
situation in which the packet was not yet routed, I decided to extend
the kfunc to more program types and route the packet only if needed.

So in short, if we decide to go back to cgroup_skb only, we can remove
this, if we expand to other program types like we do, it still makes
sense to do it.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24663313503


