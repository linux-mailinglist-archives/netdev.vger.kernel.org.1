Return-Path: <netdev+bounces-287678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HBHHEypBGqRMgIAu9opvQ
	(envelope-from <netdev+bounces-287678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:39:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F115373CE
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A22C30C336B
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D92744E051;
	Wed, 13 May 2026 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzZgwR1p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BB838D419
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689460; cv=none; b=KGTzdHPtSlMFJ21c8DK5e2uAwvi8EbkVLSf1jYag5gLruaQZwPkTym5R/nqVfG3jC/AWLo16amCO/NAIUAnlDPiwhvwl4q7URyfePj4beWjB0jR1htonrm3xiDdKnDfQOSmE1TBJMAZ+ridOe0uWVmGCP/AFccurLS9u8wiSryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689460; c=relaxed/simple;
	bh=4rJKCJspqyEyAJ79s2PawSv7Lp72/WuzkukusU3qcvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h07vkEvkSmx1LZkhVlw8nkv07TvHooTAZOjTCUyYwl6X4iRk65wKEmco5gh5gKmJiC4K+usF4Vzn0GZ5og1iG0X0XUAQblHbamm4dSe86LlLKudgdv8e5yHZtvGl8ZWq+YyF0WYrd8z20HPRLArclDFg94EbUndaKfUEW38l2Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzZgwR1p; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3665b67ed66so3575091a91.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689458; x=1779294258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3bQqq+hBj99llc4kLWrOzilJKAV0496sOwbZt644TJs=;
        b=mzZgwR1pg7Ti1Uy3gTI8edtCITakKDs8WIY0TVmdv4F/s9U+dcoJaeoYsLE/2V35C0
         RXgrsSoeUfcNKcryDhYe4ArQmA64Dq1hQlXEKwHgxESTL5Fdq8aIuh6z0qsTAa14vezX
         EMGzrwSXepvyTVldBxIZ8BsecZ0Pgfyo/w5FgaZIMPcSmf5FI9/Xl1vWRszI6AzkhzTW
         P/mJb7AFg4oJp0qKqzs5D8zIpdrZhkXq04vOBQliEADuudXFoh2bkWj4My0Sfp39sGo/
         h3NDvkd777G+F1j9OiKZ9cm/ZTXgUCCglVL2GQpOmKr3lzawO96WwCtM1MtfjvdtOSf3
         Z5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689458; x=1779294258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bQqq+hBj99llc4kLWrOzilJKAV0496sOwbZt644TJs=;
        b=aD6LgAZMzQzPTHuTYoawqDFwLe4U9eSz2L3GzI8b/M1bKG0dFIY+x2HfyT3/noi2Wb
         6fUQ2YENMB593dYb7+OmxWeZbbU/vbz/H8lETnmw8lLjJRhKX834V/pmJQwsg27z61cO
         kH/qK5/fM4GWkRNwkoQfxIBeVO+QzmsFVxMllzUcqm1NUpuz/IfwUPDt3XTBvzUm3CmI
         kzNpvl4OIDS9Rb/rmG1ctlPDuYIeKqBD/LjQJZojuNP7wUHjTyBTqbGYlLTGp8isScmT
         m0LNs9qztBKgF+HGY8XTttYuVE7O4OpstdbGyu80XbS0dq1A2yT8hK7oKgzf7AF7SHb1
         Hc0g==
X-Forwarded-Encrypted: i=1; AFNElJ/sHHNSRt4uhR9rP+TnKCNjbnDxxFTKsiRt7lg0zejP7ZG4o0PgW18Gy/RzuzwWi8Dhh9C3600=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP4JMbzoOd8+PP3LIAGM3xGvC9l4klMdHJ/iKLTP1zgjUj+2+y
	rjqZ8pUFufL1JksC86PpC9petczcbIW9ualAp4+arNukuaedczckbA+N
X-Gm-Gg: Acq92OGtaGy6smEjhtzZT8/B4LV1s+vBTzPhnnh7yAt3PDR2qqFivLR6b4BYvsqSd/e
	WSjbuMtcGDkOlwqftVnwlc+Pp0IacLc9ebybynRpUHPH+j3JBMda5C+Dvnw98baP5Xb3dqouUuS
	XQ+jnb/0Y8rSAMUl69XTiyFoh8Ymhymkbh49SlHR6tVagPy4angU0SI1qhm768U9bT4HuE5CJ2P
	8XPFkBJGhgKGpoWJoiy2jC+WdX+kOqd4KgeAv6O0v1xjf6ud1dKBl3orXWLZuSXUkHVuZun53cI
	Evjiw1c9d5Cysj17hG2wONLev3H1mE3sQrxIDff3fztkBvRsT4qy4zLTI1taK409Sry20/ueMz3
	LsxR3k+aOms6ZCiY0GaMuypwfGeLjyr0SrMDfqOHfPkVYsvWj3GgOLZsxsFkptLtF9AHrhAiFCz
	EyKtycstgJ604B3KoI57WKXOgudRSKywTm7DtE7+7RpsI=
X-Received: by 2002:a17:90b:584b:b0:368:3854:3a2e with SMTP id 98e67ed59e1d1-368f3e7b026mr4158467a91.26.1778689457805;
        Wed, 13 May 2026 09:24:17 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368eddf5161sm4949856a91.2.2026.05.13.09.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:24:17 -0700 (PDT)
Date: Thu, 14 May 2026 01:24:13 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, dsahern@kernel.org, vakzz@zellic.io,
	stable@vger.kernel.org, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] net: skbuff: propagate shared-frag marker through
 pskb_copy()
Message-ID: <agSlrWML0Quu_GVG@v4bel>
References: <agRfuVOeMI5pbHhY@v4bel>
 <811b31f3373526d1ff60160c2f32ddb359e54c31.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <811b31f3373526d1ff60160c2f32ddb359e54c31.camel@decadent.org.uk>
X-Rspamd-Queue-Id: 72F115373CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287678-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,secunet.com,gondor.apana.org.au,zellic.io,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,zellic.io:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 06:21:45PM +0200, Ben Hutchings wrote:
> On Wed, 2026-05-13 at 20:25 +0900, Hyunwoo Kim wrote:
> > __pskb_copy_fclone() shallow-copies the source's frag descriptors and
> > bumps each page's refcount via skb_frag_ref(), then defers the rest
> > of the shinfo metadata to skb_copy_header().  That helper only carries
> > over gso_{size,segs,type} and never touches skb_shinfo()->flags, so
> > the destination skb keeps a reference to the same externally-owned or
> > page-cache-backed pages while reporting skb_has_shared_frag() as
> > false.
> >
> > The mismatch is harmful in any in-place writer that uses
> > skb_has_shared_frag() to decide whether shared pages must be detoured
> > through skb_cow_data().  ESP input is one such writer (esp4.c,
> > esp6.c), and a single nft 'dup to <local>' rule -- or any other
> > nf_dup_ipv4() / xt_TEE caller -- is enough to land a pskb_copy()'d
> > skb in esp_input() with the marker stripped, letting an unprivileged
> > user write into the page cache of a root-owned read-only file via
> > authencesn-ESN stray writes.
> > 
> > Set SKBFL_SHARED_FRAG on the destination whenever frag descriptors
> > were actually moved from the source.  skb_copy() and skb_copy_expand()
> > share skb_copy_header() too but linearize all paged data into freshly
> > allocated head storage and emerge with nr_frags == 0, so
> > skb_has_shared_frag() returns false on its own; they need no change.
> 
> What about skb_shift()?  It seems like that should also propagate this
> flag.  But I could be missing some reason why it's not necessary.

That is one of the things I am testing.


Best regards,
Hyunwoo Kim

> 
> Ben.
> 
> > Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> > Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> > Reported-by: William Bowling <vakzz@zellic.io>
> > Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  net/core/skbuff.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 7dad68e3b518..15bdec53e8d9 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -2248,6 +2248,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
> >  			skb_frag_ref(skb, i);
> >  		}
> >  		skb_shinfo(n)->nr_frags = i;
> > +		skb_shinfo(n)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
> >  	}
> >  
> >  	if (skb_has_frag_list(skb)) {
> > @@ -6200,6 +6201,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
> >  	       from_shinfo->frags,
> >  	       from_shinfo->nr_frags * sizeof(skb_frag_t));
> >  	to_shinfo->nr_frags += from_shinfo->nr_frags;
> > +	if (from_shinfo->nr_frags)
> > +		to_shinfo->flags |= from_shinfo->flags & SKBFL_SHARED_FRAG;
> >  
> >  	if (!skb_cloned(from))
> >  		from_shinfo->nr_frags = 0;
> 
> -- 
> Ben Hutchings
> Tomorrow will be cancelled due to lack of interest.



