Return-Path: <netdev+bounces-288469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLFeD2ySB2pU9AIAu9opvQ
	(envelope-from <netdev+bounces-288469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:38:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E0C5583B3
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49C653014672
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CB23ECBC2;
	Fri, 15 May 2026 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcjvZuKz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256CA3EB7FB
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880993; cv=none; b=qhg6LGxODCPxSU8MOU1pt56hEv/ekVzeoSZSNoRmM7pNkTPa4q9DIWWZgy6Yv2UH3Cg5AM8jZYYipHl7H3PnrzzWmVDf8L0cl3OdSyM0f9AWGFrgEl+fqHuULQV99x5NpkxaS9SQK1QsiJSWmKA8vRxf37kYFxgtdArtd7aeUek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880993; c=relaxed/simple;
	bh=hlAOhLGh58Gy3zan6ewmiQ7pq8blPJAAQ8CMHzesHaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3+BMRvhNxIu0cgJRkkF01dvwCIg8axUYd2fuHETrQr5HThDCMulzKj5A6aLtcrUFAUTsZQIUgLmaNKjj2Mv4AKE64+bGLMZbnXs5phu91PPfzyWqUao2utv/2ctdzUNrdps5n3S7Pn9De2uKrAeBimcpJwAlBg3nwV2/R/c3Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcjvZuKz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bd9c3b550aso2547785ad.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 14:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778880991; x=1779485791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tl3ISS/q5ODJOgUNvJqQup6LUHmvQRG/4621LRENO2M=;
        b=IcjvZuKzQQ7GlGStkVKGcO8VaZv5Y1gqGewN/waRGok2q3hQ7vfohyRhZigSwTw3F1
         PMImTmq00PceeC+zt/TLEFUQWiCZpQOjlrz395hXRU+66mlCToG5LzO6swuOdhhT2bKV
         vlqRgttZ2qJydgmjynhgP5aNBsvgTYQjF62FCZzVrsCJ7MwD/Iy3IadrUARnhiOIQQqy
         qUjcXYmlC74ibpN90tVCF7ZIT9iU+7T0HshnLD/EvwAH7CXVPE8UAtWdUboanKhjDqPL
         +xbSRI3B5kUXgF4Dj/OZYMAvnEqOOh/Z0rq4YAr0dF/N7cb4L35X2VhucX9gwAdB+c+v
         WgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778880991; x=1779485791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tl3ISS/q5ODJOgUNvJqQup6LUHmvQRG/4621LRENO2M=;
        b=LJqcPbBV3YW4tLEhqPkJgcg5flC2JQUocypWXHc4Nbhus+zPjASm+PmIL/O63s0VoZ
         uxvXoebJeKeNXtjp5vuEK+kJ8AtBq3sGTWn/7AgFPJGlRe+g3WRRJC8KwLsAb01DKSIg
         Gp4GXqMDh2zLlou7nOwB+9TLjrSCWtnarGlZ5bdKxDuxP6POyMXwd0+T0IIX6y+CSlaC
         rEyTDAEHLLlnKZr6O1jDaYh9RGSF/xH2KlN9akCqVC9IK1l9Ap1RShEtPOYM2kDygQUH
         Pr59TlMi5gTAUrK2MRV1pfiAHKdhx/wvAnL1o+cEYxHbSXn6UWhY2AfvF88TOWYm0A9b
         w5/g==
X-Forwarded-Encrypted: i=1; AFNElJ8CqolH0N1J/sKFagvQLfZXXoC6bFEliGplFYps9Dfve/ObfUYGjX+bM06fRFhlrFk+vESSElQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw25QpZ5Hm2n4RvAHR1/VlQwmadm0NHGyntzWbVZT7Mn9TBxzzj
	11MADwWNyz5O2VgPZUJ1rptQPmPAf11XFhOHdNkiWZxiaD8dvqqf04Fr
X-Gm-Gg: Acq92OFq7zHPAPXrcmpiEF2NzLIrcp4Nvbi0NZpeJcGXdGwLXZQelOQN6Ekeqh4NVRc
	Z8AlwU0/Jl6avwMyesV4LJHEjZkcg+2ftziEYs09e9yyDwXpr+aXyr9bG/oanAi6Ije3i50xtI5
	Pl1yIrKJfoIkWDNcZBgHqMMLRSuK9g3Ark1CTrV7esMwikHpGjseesSlOgRnuYA6GKBCBCUd7TD
	MJ9JWs+SGRsnvum11PFfLfeKTUWoRcLCcrO/vx+1FYU/VLPyApH5FYL0z68ZvtSC/rinSbpM87Y
	dQg9SX9kmZ2FzoIzyHxrWb6msHF+hj3+DwseXwdxKZewO8blLAf/MbQirSS49Pr2FhlgXAMX+mH
	niyh22pzjZBGnIF3UGbtUAvxBaP3BUX9AuPf6ZghFnPiJSOAR2Rry1T9ZfWsvhJVbNgERgGDPDf
	2Hfnw5zrITf+JuemohbsxvGGosxgZVNZGIrX3s8tXM16M=
X-Received: by 2002:a17:902:fa0c:b0:2bc:dca9:f0ef with SMTP id d9443c01a7336-2bd7e8cbbc5mr40307095ad.36.1778880991168;
        Fri, 15 May 2026 14:36:31 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fae5sm70746195ad.6.2026.05.15.14.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:36:30 -0700 (PDT)
Date: Sat, 16 May 2026 06:36:26 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Aaron Esau <aaron1esau@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, sultan@kerneltoast.com,
	sd@queasysnail.net, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, dsahern@kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, imv4bel@gmail.com
Subject: Re: [PATCH net v4] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <ageR2qzTRtpH8JGY@v4bel>
References: <aga1VyHpHaUhnGZa@v4bel>
 <20260515164121.2608076-1-aaron1esau@gmail.com>
 <ageAmZcEMu4Yjyyl@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ageAmZcEMu4Yjyyl@v4bel>
X-Rspamd-Queue-Id: A8E0C5583B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288469-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,kerneltoast.com,queasysnail.net,secunet.com,gondor.apana.org.au,vger.kernel.org,linuxfoundation.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, May 16, 2026 at 05:22:49AM +0900, Hyunwoo Kim wrote:
> On Fri, May 15, 2026 at 11:41:21AM -0500, Aaron Esau wrote:
> > skb_segment() propagates SKBFL_SHARED_FRAG from head_skb only.  When
> > segments pull frags from frag_list members, the flag is never
> > propagated from those members into the segment skb.
> > 
> > There are two miss sites:
> > 
> > 1. Line ~4986: a new nskb propagates only from head_skb, but frag_skb
> >    may already point to a list_skb carried over from the previous
> >    segment's iteration (i, nfrags, frag_skb persist across the outer
> >    do/while).
> > 
> > 2. When the inner loop exhausts head_skb frags and switches to a
> >    list_skb (line ~4999-5002), frag_skb is updated but its
> >    SKBFL_SHARED_FRAG is not propagated into nskb.
> > 
> > Your v4 GRO fix means head_skb will normally carry the flag, so
> > skb_segment() picks it up indirectly.  But skb_segment() itself should
> > propagate from frag_list members directly --- otherwise any non-GRO
> > frag_list producer re-exposes the gap.
> > 
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -4986,7 +4986,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
> >  
> > -		skb_shinfo(nskb)->flags |= skb_shinfo(head_skb)->flags &
> > -					   SKBFL_SHARED_FRAG;
> > +		skb_shinfo(nskb)->flags |= (skb_shinfo(head_skb)->flags |
> > +					    skb_shinfo(frag_skb)->flags) &
> > +					   SKBFL_SHARED_FRAG;
> >  
> >  		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
> > @@ -5000,6 +5001,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
> >  				frag = skb_shinfo(list_skb)->frags;
> >  				frag_skb = list_skb;
> >  
> > +				skb_shinfo(nskb)->flags |= skb_shinfo(frag_skb)->flags & SKBFL_SHARED_FRAG;
> > +
> >  				if (!skb_headlen(list_skb)) {
> >  					BUG_ON(!nfrags);
> >  				} else {
> > 
> > Site 1 covers segments that start mid-list_skb (frag_skb carried from
> > the previous segment).  Site 2 covers segments that switch from
> > head_skb frags to list_skb frags mid-construction.
> > 
> > Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> 
> If I understand correctly, triggering this in practice requires both
> an skb with SHARED_FRAG asymmetry and that skb reaching skb_segment()
> with GSO set, is that right? Looking at mainline, I couldn't find any
> code path that produces such a combination.
> 
> Do you happen to have a reproducer or a concrete trigger call path?
> If so, please share, I'd appreciate it.
> 
> Anyway, since I consider this one of the "relatively" more concerning
> items among the "potential issues", I'll wait a bit longer for
> additional reviews and then include it in v5.
> 
> As a heads-up, after this one, I don't plan to fold further "potential"
> fixes into this patch. This patch is intended as an urgent fix for an 
> actually triggerable issue, and the remaining potential issues are
> more likely to be addressed together as a separate batch later:
> 
> https://lore.kernel.org/all/20260514163802.1d49d7cb@kernel.org/
> 
> Thanks for the review.
> 
> Best regards,
> Hyunwoo Kim

Ah, I see. you've released another exploit publicly.

https://github.com/v12-security/pocs/tree/main/fragnesia-5db89c99566fc

It looks like the exploit doesn't work because the GRO propagation
in the already-published v4 patch prevents the SHARED_FRAG asymmetry
from being created in the first place.

In any case, v5 will be submitted shortly.

