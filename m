Return-Path: <netdev+bounces-287880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHSGOSaYBWp2YwIAu9opvQ
	(envelope-from <netdev+bounces-287880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:38:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EEC53FE87
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 596253027D97
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78D43A5E76;
	Thu, 14 May 2026 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvCy5jGB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A1737AA9F
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751521; cv=none; b=V+RBZaFsVIIUNsRQb75sGdp2SbVraI/kWvIeZLX8re5x8SIjP/59OaNtbL4hTVvdNvvplkoWAUwNjSlirhTMpw1MH6IQV8kg9m8LDjawynooxLLluu7IO/3id1sWH84Vkyep8V5K5mxnRLMXwN4Xp6kA3l9sXhJM8EBSfNCxQJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751521; c=relaxed/simple;
	bh=wyQryMAcqgKBmpH59WF4pkW+5nGBprWHuGbAgn7gqQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GM4o1TcVrFQAGI+zcPs+619gh8CN4NLFgyEbcKY4yEEBIf7aaY5mLpChjxmFydwRGygge6lZEgpQXNJGuyOw81lSPgnUWMKpsqxPvp4EHfmIZMqHfHxmFEUPwHShBGs4IFbClQ48EZrgUG45k7L4ZSKhBNPeBsW8/Xef2tXaew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvCy5jGB; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c80167f5716so3452799a12.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 02:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778751520; x=1779356320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cjTEfY1YCfQns58oCl7WBrAFJdM70zfUdAnzlrIHCvU=;
        b=DvCy5jGBA2eYzTSPwwU8JkxilbOuazjVBJeV4Zeatv8VVeKiCDeizZh1ZnEV6AI3HO
         3ud+Oj9bLskVy7hPsx8qgufVX/lTOHAAITjLEVbMD4iarpvo+M3ags3IWzwkvHNjKmYG
         h5lhnTCOHRLS+17/uOZmwPwG0xnXAkmCZ/8AsDFPcgyGpCCZ8DcZ4gBLqyLeBkQfEJpJ
         7T5BSdTpqJ5AWYH47cQMz5rmjVPQgMyH6SX65UFIc0qnMrtEoR9dkWvpgtjH/T8yp8az
         RukrZmGUQmp8ykgUauzk9VwWmwjDPh0b/iZTjuQblVMCcCllOI/dsyp4qOJsoRL0pZqv
         OggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778751520; x=1779356320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjTEfY1YCfQns58oCl7WBrAFJdM70zfUdAnzlrIHCvU=;
        b=SJKotCQuRDwylOgPBZ21wJrvmomPNELF8OSNwMo4f5vLcolHzdqn5KYdK6BjitjBSI
         SKQDoMphSZPtAUOM6QdKNqctBG5ss0vUGfZgwCxe5OidWzxEhG1uQHQQuERrxN5J9JMY
         Sb+1/3i/oIgDdvup2JQM1z7w9DzNweatSUB83639xoVtFdI3K6WdRuunArXH+urce6OF
         1iN87SO384SAhqGbefmAI3CzRsfsoJGz60evM3iaXwf7vM/yGYc90VrXMTu4NUJ9GVgA
         fgaW9ZTdbyWSBCR0YuXtiEEvsVE+o/tlfhFzhLhEYNzNSF/BD+F+fA7T02PiZYNERBhw
         8y9g==
X-Forwarded-Encrypted: i=1; AFNElJ/aOA0sg+tPZPvtHUUn/P/KU9l+o1Hfu9AKNyUSIgEw/rq7XtmT5tzK2nqBNcwdK6R4aEnvLFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5gllk+SZT6vmRmmJNx4NrvGR6DyiuQnzJ4yalAUOrcHbjIx1F
	q959mRlcfQQW4wEhbOmn+B2VOI89S/l/88yh273wk8hjFqjTluQe0bDD
X-Gm-Gg: Acq92OHvDrfTvW7rvZdXxfqVjstz77HD6eJ75Sl7GjaoXXlZHNsn3V4yXWZsI0jegOf
	FitaQTbIGZwa6VxCDjgehRdo813LN9gTN1SC0VX1iogwE9rHMqyYnvL/zfRJKArHk6r7OnDmHM3
	bhkb1D7pIJLIvBK7wc/9+EFIOrHep6PDpWtHQ8IJ/aA0jHR+jwMXuR22AIy8JpOtWPkAtkS29V+
	3bbY8jCWYEgVuMVw738i3Ym9WeGZqDFX9cap36jp1WQfsWjLtpfrWOJclj399xuNk2DguB9cPpd
	ujuF/pV8Kqv/uo6ECwO/IZqnKmlvxRID4pwa4B/ue3RUvxD2nSVwvYhLL5m5OnBJeqA/7aQ/4Uf
	1rCOBVy3THOQK/kv6XIXmx4gmNfWVefiFOstB2tI5kipdZjheBixRuluONH/tnLAtME66h3VdIC
	PAmhVEle++G6tnnjlIr+ihrnvOvU362BxfNCT3yXPiF6E=
X-Received: by 2002:a05:6a21:3299:b0:398:79a8:5bf4 with SMTP id adf61e73a8af0-3af8197717amr8098006637.37.1778751519422;
        Thu, 14 May 2026 02:38:39 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb0ff4easm1715464a12.18.2026.05.14.02.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:38:38 -0700 (PDT)
Date: Thu, 14 May 2026 18:38:34 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, steffen.klassert@secunet.com, netdev@vger.kernel.org,
	stable@vger.kernel.org, mhal@rbox.co, davem@davemloft.net,
	horms@kernel.org, edumazet@google.com, kerneljasonxing@gmail.com,
	herbert@gondor.apana.org.au, vakzz@zellic.io, kuniyu@google.com,
	jiayuan.chen@linux.dev, ben@decadent.org.uk, dsahern@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>, imv4bel@gmail.com
Subject: Re: [PATCH net v2] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <agWYGuJ__OtpgjnB@v4bel>
References: <agToIEDI4TaTNLRb@v4bel>
 <92ec6190-0255-4b7c-9524-254cb37476ab@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92ec6190-0255-4b7c-9524-254cb37476ab@redhat.com>
X-Rspamd-Queue-Id: 56EEC53FE87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287880-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,secunet.com,vger.kernel.org,rbox.co,davemloft.net,google.com,gmail.com,gondor.apana.org.au,zellic.io,linux.dev,decadent.org.uk,queasysnail.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 10:04:29AM +0200, Paolo Abeni wrote:
> On 5/13/26 11:07 PM, Hyunwoo Kim wrote:
> > Three frag-transfer helpers (__pskb_copy_fclone(), skb_try_coalesce(),
> > and skb_shift()) fail to propagate the SKBFL_SHARED_FRAG bit in
> > skb_shinfo()->flags when moving frags from source to destination.
> > __pskb_copy_fclone() defers the rest of the shinfo metadata to
> > skb_copy_header() after copying frag descriptors, but that helper
> > only carries over gso_{size,segs,type} and never touches
> > skb_shinfo()->flags; skb_try_coalesce() and skb_shift() move frag
> > descriptors directly and leave flags untouched.  As a result, the
> > destination skb keeps a reference to the same externally-owned or
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
> > 
> > Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> > Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> 
> WRT the 2nd fixes tag, I *think* f4c50a4034e6 would need
> additionally/instead a follow-up similar to the one mentioned by Jakub here:
> 
> https://lore.kernel.org/all/20260510084520.476745b5@kernel.org/

Agreed. tracing SKBFL_SHARED_FRAG propagation paths one by one is
not a robust direction for the fix. Even minor logic changes elsewhere
could cause the issue to resurface.

As a follow-up,	eliminating the in-place handling in esp_input -- accepting 
the performance trade-off -- seems necessary. That was actually the
direction of my initial proposal:

https://lore.kernel.org/all/afLDKSvAvMwGh7Fy@v4bel/


Best regards,
Hyunwoo Kim

