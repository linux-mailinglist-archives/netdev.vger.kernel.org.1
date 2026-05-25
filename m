Return-Path: <netdev+bounces-291356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODe+DoBrFGoTNQcAu9opvQ
	(envelope-from <netdev+bounces-291356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:32:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF0F5CC4EF
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21C7F301C598
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253C62F1FD7;
	Mon, 25 May 2026 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV5+PAUW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E362C0F75
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723110; cv=none; b=olikCOydOCUyuLtj3mez44fo/96dOOqGRWgsTZK6s/tdxBFOKcYdRv62bW5iNwvbMeD0TJBU4IAtgKFnDR//GG12/mAtj1Lqu2UYx8NACJ3Sru8aaerg2ESZPfLSafWMlO/XNQOnfkNiQhXBjwkkcdgD+wzmfErHuCuB5Bs2IbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723110; c=relaxed/simple;
	bh=IChBbuQNn9xX8Rj06bX10eOuHAjlJ7tHSYSJUuxq3Pc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HojQhD37Ibjw/jKr/hcP5Rvp0nSstDmfeCxVUDCuf5hE0TB4Ninacx4katQDqH165kw5QInelo0OlsYPKMg34tw1Xqo2dGMHzFPqJK8GFTy/ZIiWuDAMtouOR3trfetjBrPRPZeOXPRvBFTxEA8AoDwdjselh9ltry1p+Y9Zq8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV5+PAUW; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7c2fa14795aso75160917b3.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 08:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779723105; x=1780327905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN5aVsXK5EO2I4OcW6386EyMGfUSQ4BgyCyYxg8IgRQ=;
        b=TV5+PAUWFrRZYCmLoE5AQnZ9SncCN1X4oiTa1dtcV/Ep143F7rreW6+71ql4c4xxMY
         H0kAJBuNAXjlGBuSzz7qw+Vi+SQH/NwqfzhxsugigGK4fx07VIZnS9rFKA5pOCkI9G2D
         W2recfSbLFpiSdb7zmNTFyVWUKsz5VueWyFtXjrLGBpgMx2wZ6cN/owhWoLNppOO1bn4
         DkZI3ulj8xB1ZEdxu7i2x+Q5xFfpwtRnAE1ac2kCQ1fZA8p1kQvdHRkwqPmzkOBy1b/Y
         Wy6h1vF7D4ItvrV2g1T1ZKJ1dQ1PfBSY96zFK+DZFFHd21HJbOIj5+0Vh/mCr7GIEe09
         eP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779723105; x=1780327905;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pN5aVsXK5EO2I4OcW6386EyMGfUSQ4BgyCyYxg8IgRQ=;
        b=VeElaPOXEfiP8Bov4WzcRhSHKKjypU94u6XPyWZqAF+q/REucgCeEAEIru+A3DsYuW
         Ztk6gbMFplI/iRyaTCzkvgYXEPFb8Ttu50ZA9kWJxvhfrtE8awKeD9qIMcV5dbd9mlkW
         gcL+zYIpQbC/ewj2Vpxv1I81XUDb9wEpdCaj86x5vWZMXiz4QYAQd2/txCKGTGOOK98c
         hKoZKQQumKxHoyVZjumqwRnReqXITcd4s6hi/lRVB0CRGW3685NIDazPR8Hm4GJLmga7
         Bv9wBY/q0hHA4qMzKVuzw9KZOE3NwWEBlWmibF9hFniAg+zzcu+Bs1052MOEzjldmSP4
         cIPg==
X-Forwarded-Encrypted: i=1; AFNElJ843KwlOSo7qqWOC4h2yfFtliQx37K3GpqU8zf+B5+8gdGTZegNRVj/ATXceGYi9eJjPI4+XFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZbLxkkSmuUSBB+R4E0vc7fJ8+azJIupEdBMt3HPU3tc/aGNsc
	8mDh6McOcPD22xril7abkF0DNPpw2OXOasbvCHOrsBhCyYnp8X/fB0K4
X-Gm-Gg: Acq92OFxIlsWhTnUeQKaOVVu1Ew3h9fusyyC8tVsOaVeUyxWVoHMkeADGyiJr64JFID
	8fl3Uyo3D0nkTGXLlLTECTnPo3CUzyyCkRTNe5OWC5GJjRRQ3vz2e/ZaFndGKE1ZBNTWSbh6Vjl
	woCe04Hely4Wjc7mKYvpGWPpPG9rv3lHLcpEvS539wX2fq+P97Bjb5GMZJfCGh3JWf59KHUcd3W
	J3e1eEdduwubJhBcw4uE9/1Le8iLHJ+AH0FsROc/vg/MI/b50QUEAZoWlze2HVR5OCptR715KOE
	xa+KWDGibyoLRscmTB3LcvRqKf4ZpzR1XEGYFt+0lqKDqGY1asz4XvHGL/JOCCJFlaRzHSlsA3E
	/clVGw7MxZytkUw1EgVS9lTji7jnJCiWh66pp/pHbF64sF1wL2Fd8VvHZAyNkty78Exv5Am3IPD
	dAPibrwgfvp5LHHdCCPJrw2K1z63Q79Ur8eyp/r1l74IP588FzjqRI8xg/RxkRUEwBwTF/IsL9Q
	r9UBms=
X-Received: by 2002:a05:690c:4b92:b0:7bf:3b0:27f0 with SMTP id 00721157ae682-7d3388853bfmr156965947b3.19.1779723105037;
        Mon, 25 May 2026 08:31:45 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d389d176c3sm47904417b3.17.2026.05.25.08.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:31:44 -0700 (PDT)
Date: Mon, 25 May 2026 11:31:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 lazyming <minhnguyen.080505@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 w@1wt.eu, 
 security@kernel.org, 
 linux-kernel@vger.kernel.org, 
 lazyming <minhnguyen.080505@gmail.com>, 
 stable@vger.kernel.org, 
 asml.silence@gmail.com, 
 achender@kernel.org, 
 mst@redhat.com, 
 jasowang@redhat.com
Message-ID: <willemdebruijn.kernel.9bf2a08cffd8@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1ddcb33fec832@gmail.com>
References: <20260521121628.309924-1-minhnguyen.080505@gmail.com>
 <willemdebruijn.kernel.10f46164d2a79@gmail.com>
 <willemdebruijn.kernel.27d7990b24613@gmail.com>
 <willemdebruijn.kernel.1ddcb33fec832@gmail.com>
Subject: Re: [PATCH net] net: skbuff: fix missing zerocopy reference in
 pskb_carve helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291356-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,1wt.eu,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.361];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BAF0F5CC4EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Willem de Bruijn wrote:
> Willem de Bruijn wrote:
> > Willem de Bruijn wrote:
> > > lazyming wrote:
> > > > pskb_carve_inside_header() and pskb_carve_inside_nonlinear() both copy
> > > > the old skb_shared_info header into a new buffer via memcpy(), which
> > > > includes the destructor_arg pointer (uarg) for MSG_ZEROCOPY skbs.
> > > 
> > > These functions are not supposed to maintain zerocopy frags.
> > > 
> > > Both call skb_orphan_frags.
> > > 
> > > I think what may need to happen is to invert the order of that call
> > > and the memcpy. Current code:
> > > 
> > >         memcpy((struct skb_shared_info *)(data + size),
> > >                skb_shinfo(skb), offsetof(struct skb_shared_info, frags[0]));
> > >         if (skb_orphan_frags(skb, gfp_mask)) {
> > >                 skb_kfree_head(data);
> > >                 return -ENOMEM;
> > >         }
> > 
> > Never mind. This actually corresponds to the first Sashiko report you
> > mentioned: if zerocopy skbs are converted, then the memcpy prior to
> > that call will have stale state.
> > 
> > For skbs where skb_orphan_frags does not do a deep copy, we do need to
> > take this extra reference.
> > 
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> Not sure the potential preexisting issue is reachable.
> 
> Vhost-net and other zerocopy that predates MSG_ZEROCOPY does not
> refcount ubuf_info. Instead it calls skb_copy_ubufs on skb_clone.
> 
> So if such an skb reaches pskb_expand_head, it should be guaranteed to
> not be a clone. Same for the carve methods added later.
> 
> But, the commit that added zerocopy, commit a6686f2f382b
> ("skbuff: skb supports zero-copy buffers"), included this 
> pksb_expand_head call to skb_copy_ubufs from the start. That implies
> that was expected to be reachable. I just don't see how yet.
> 
> If it is reachable, then all that is needed is to clear shinfo->flags.
> Or more neatly,
> 
>     skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;

Also, I'm not the expert on more recent managed frags
(SKBFL_MANAGED_FRAG_REFS).

That calls skb_zcopy_downgrade_managed in pskb_expand_head, but not in
the two other functions with memcpy before skb_copy_ubufs:
pskb_carve_inside_header and pskb_carve_inside_nonlinear.

I assume because those shorten the skb, so no risk of getting mixed
mode refcounted and non-refcounted frags?

In general zerocopy can be split in refcounted and non-refcounted.

Refcounted zerocopy will not downgrade in these cases, so will not
modify shinfo->flags after memcpy.

Non-refcounted should always get converted to copy in skb_clone,
so will not enter the skb_cloned() branch here.

If in doubt maybe warrants a rare WARN_ON_ONCE patch.

