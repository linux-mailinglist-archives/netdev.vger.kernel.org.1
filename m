Return-Path: <netdev+bounces-291952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKIRD5cYFmr2hQcAu9opvQ
	(envelope-from <netdev+bounces-291952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:03:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA5E5DD0FA
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B8D93012C70
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A813C37B4;
	Tue, 26 May 2026 22:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fM/XkBt3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C923B47EF
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 22:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832933; cv=none; b=Pi3t96cCUUd0OvbhcF0teZ8IUpc2x2MtujQeHc1AjoTk8Xo9SjUpCB4AMELaQbKyE/Fg8TBU2B5Kj7ojq4s8oV00J8G3ei+gw5wyLykhw/OcN+1OJw8B05+nxNyIp/7D6J7aidImiupfv3VX5R3lRd2TkLfySRGH0tLgsB7JONM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832933; c=relaxed/simple;
	bh=2gZSsUwgvpEuu68Nln92VStnzIRxNN9p/M65k1xVsnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQ9ociKdjL75iJhsgokL8UzpU2p8wlOq2uLyHeCqE9Zvj8/lErtrn8m+JJ5TbAEGnxgL3xX6Lwear8DhKgHXsNDZkCiaXvjAdt/17NTgDGiaCEXF6+G0MFarAbkVOnQiRHkrEvmdNJSEE96GtyIx45juxQk/cfou6NwOIt3MIIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fM/XkBt3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so116042955e9.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779832928; x=1780437728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JONhVJIHBrqEc2wK9dNkb6aggYmrKKMETySXPUvxh4I=;
        b=fM/XkBt3Fon6de/767QzGbY0ucEMKH2u/mfsF7vF6Yw5esO4k2Jz/VRPzPCIt4FQuP
         SRX5nTAHowngJ6rdkmEjOi9iWWc1Rxo9Bo3R/FPoCNq48uwzNA+yzgB8+ZY5J/XAEaW2
         3NlvYyk6U+VacjDM+CVylFYEz1jMAgseQIgoIwjWMlWTYhZPwWcsMBTERfoe5gFUisMQ
         OvgGaRdPxxDPEMQ3ioGPTMxz7AXqBSJFjIkctIzAUERdAB4UTfrhyeBil+//N7OEJTvI
         fbForjLWnvdCcly4sqLhrTj6wZjNyLb89O68AjxznQTXSgRlYRXacGff6noHK5B+qIDG
         DECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779832928; x=1780437728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JONhVJIHBrqEc2wK9dNkb6aggYmrKKMETySXPUvxh4I=;
        b=ZPtKf/xxZqWKzY8eW574nDuccbpjjIjIRyIVw3OcAeA62KYm/1T/MUPWKMmp8hOUMP
         KZQxyfPQryA1AS4DTMIE8HG8HFV3Z6R3WJdFl7rfA3wPpvXm6B/T15apW6PWAijp+lg5
         kUWXCRHUR4a9aOm+7ir6JTeWAqVh8BtoP2LaNCQcA2vm4MDmkMnoz+puE6GOKDxiYZaA
         Loe4hkKDP8F85gxOwgH/pWI+OJ3ehPBXxQKweIpIqa15XmNxlBs7prvWyIy4Z27/m6Zj
         qvw5MOCVkyAKQ9uoj5IpW60jgwuv0aPZDMdq8gSbonA/G7SJPR7vP63O80de0mAvHuLr
         q2OA==
X-Forwarded-Encrypted: i=1; AFNElJ8+y367b6nKwMI1y0HrGjTsLNHQFEbJBMClXBhUeFK1FcMsfhAzHe0tj/Pr+WkTPiNwVT+SkDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMa/6UYUg3cpTYfl0giglOKHv96dhUMiXsTSVcpg4ZOvypUt2e
	96jK6PmiDyyQ7I3+cRGLKMkVhMPovslnBXLZl6ycC/tAwG5rFsFIJZix
X-Gm-Gg: Acq92OFOVlqm/v6lYUjNfqy/0yMZp9SYC8sz62aewJ9uxd3wqNSIKN4Vzpt3NfUeZnj
	NHmttoItpJ+5gZWt/yKltKFP4lVDbdYNWgTCw7iE+rzBhsXcJ7QqSqlsNBDUlPxvIW2C9oqH801
	mERdvvWf2JlaQbA6YeWFykYHW/DXvHHE391DB7I13hniCZR/vUORQoaQIGrncjOg8hXGrPLgZI7
	2v+BLzdrRnXQFxCqXI1ufUTO66CQV3nXNB2g1HC86YP1uOsz9iKYe3iLnh1X7v9BIxM2DmECRvy
	8W3UoJ9T5KIM4maQt+riGPJVHi/QzFXy5u5VXdc3e6lNbEunqzdXNH4iAs2rCML09KvNNxGxbwa
	ehXJvVct+m+p50NHNcHsrD+IniIs5EDfsKN0eKNy2tGbyiLfmnIH/1qOcLTCCq9obo7Fa2nL8qs
	wpS/FXXLAd5Zs/gYhX9H0er6Lp9YenDcwyGbYOTG0=
X-Received: by 2002:a05:600c:a49:b0:490:6889:202 with SMTP id 5b1f17b1804b1-4906889026emr157273705e9.29.1779832927993;
        Tue, 26 May 2026 15:02:07 -0700 (PDT)
Received: from gmail.com ([2a01:e0a:488:3510:15a1:dbd2:86bb:c4e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490452765f5sm367234965e9.5.2026.05.26.15.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 15:02:06 -0700 (PDT)
Date: Wed, 27 May 2026 00:02:00 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
	yonghong.song@linux.dev, jordan@jrife.io, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, martin.lau@kernel.org,
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v7 2/7] net: move netfilter
 nf_reject6_fill_skb_dst to core ipv6
Message-ID: <ahYYWIitPa7zlnSK@gmail.com>
References: <20260526153708.279717-3-mahe.tardy@gmail.com>
 <44848566ea55c9974065bd2aad211662a7b319452ecbc6e2f6cc942cb5b4e8d6@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44848566ea55c9974065bd2aad211662a7b319452ecbc6e2f6cc942cb5b4e8d6@mail.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,iogearbox.net,gmail.com,kernel.org,jrife.io,google.com,redhat.com,meta.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-291952-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3EA5E5DD0FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 04:20:14PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
> > index 09ffe0f13ce7..eb5a60d3babe 100644
> > --- a/include/net/ip6_route.h
> > +++ b/include/net/ip6_route.h
> > @@ -100,6 +100,8 @@ static inline struct dst_entry *ip6_route_output(struct net *net,
> >  	return ip6_route_output_flags(net, sk, fl6, 0);
> >  }
> >
> > +int ip6_route_reply_fill_dst(struct sk_buff *skb);
> > +
> >  /* Only conditionally release dst if flags indicates
> >   * !RT6_LOOKUP_F_DST_NOREF or dst is in uncached_list.
> >   */
> 
> [ ... ]
> 
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index b106e5fef9cb..e72065aa5f5a 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -2725,6 +2725,24 @@ struct dst_entry *ip6_route_output_flags(struct net *net,
> >  }
> >  EXPORT_SYMBOL_GPL(ip6_route_output_flags);
> >
> > +int ip6_route_reply_fill_dst(struct sk_buff *skb)
> > +{
> > +	struct dst_entry *result;
> > +	struct flowi6 fl = {
> > +		.daddr = ipv6_hdr(skb)->saddr
> > +	};
> 
> Could ipv6_hdr(skb)->saddr read out-of-bounds memory if the IPv6 header
> spans paged fragments?
> 
> Since this function is exported as EXPORT_SYMBOL_GPL for use by BPF kfuncs,
> it might be called on packets where the header isn't guaranteed to be in
> the linear data area. If there are no linearization checks like
> pskb_may_pull() before accessing ipv6_hdr(), this could read out-of-bounds
> memory or cause a page fault when processing undersized or fragmented
> packets supplied by BPF programs.
> 
> The v6 cover letter mentions "call pskb_network_may_pull on the cloned
> pkt", but this linearization check is not present in this function.
> 
> While the netfilter caller (nf_send_unreach6) may ensure the header is
> linearized, the exported function itself doesn't validate this condition.
> 
> Reference: https://lore.kernel.org/bpf/1637d7e04ac3c65239ef77709175697bff287250913d1da68e8d4072e0ff34e1@mail.kernel.org/

This is the same remark as on IPv4 on which I already responded, I don't
think that's an actual issue.

> 
> > +	int err;
> > +
> > +	result = ip6_route_output(dev_net(skb->dev), NULL, &fl);
> 
> Can skb->dev be NULL in contexts where this function will be used?
> 
> Since this function is exported as EXPORT_SYMBOL_GPL for use by BPF
> kfuncs, it might be called from program types where the device reference
> is not retained, such as socket filters or tc ingress before device
> assignment. If skb->dev is NULL in these contexts, dev_net(skb->dev)
> would cause a NULL pointer dereference.
> 
> While the netfilter caller (nf_send_unreach6) checks and sets skb->dev
> to loopback_dev if NULL, the exported function itself does not have this
> protection.
> 
> Reference: https://lore.kernel.org/bpf/20260421111321.94393C2BCB0@smtp.kernel.org/

Dito.

> 
> > +	err = result->error;
> > +	if (err)
> > +		dst_release(result);
> > +	else
> > +		skb_dst_set(skb, result);
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(ip6_route_reply_fill_dst);
> > +
> >  struct dst_entry *ip6_blackhole_route(struct net *net, struct dst_entry *dst_orig)
> >  {
> >  	struct rt6_info *rt, *ort = dst_rt6_info(dst_orig);
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26459248718


