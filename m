Return-Path: <netdev+bounces-271475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELquEzSrw2nAtAQAu9opvQ
	(envelope-from <netdev+bounces-271475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:30:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C4D3223EA
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29E7130962C0
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7D52E11D2;
	Wed, 25 Mar 2026 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI8+6Z5Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A42299948
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430647; cv=pass; b=cYYWpeOw4O3bS+2SOvFSfKFknpaiSHBC6pP1cwL9naxgRwyxY5crQ3A5Dfb5aNpknWcbsbhiqde0GHtNhOUb9z1cjNJqbLdRmvquZHBVzBvPRy9xD9kU6eK6PFjgqAnMuC2FuBCIkwZ0aneVlu9UFYmBmW5iaZkJt9tCi6fKCI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430647; c=relaxed/simple;
	bh=R1G41AsoFcUAg6XT8eqNYC1r2EYVoXh3wrjgrusNrYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z68iAoUUag0AIw1O5RF3uoSa7JYR1GObMnwlPb3fbrTNOpIlp1Ts14LnYdNbpH89kumeh+HPk2VNMI/0KOxaQZkBZD96qX/wAP0bWzdQMrti+7CoqxkVy0AggMxOjniEz+wLUxcDzrA6UoIrq/vxwg6V+nXqPmxQO2wRlrvEz8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI8+6Z5Y; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so4370836fac.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 02:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774430645; cv=none;
        d=google.com; s=arc-20240605;
        b=KnxKaZQiat/Td052+bjBAUUtQDTnoQnjrj5f0ew/mZIXbW6XBJ0IeO4MZGMQXuH9YQ
         VjoPrDm9uezc8N2T3e+YYOsc0s5/enn9zsa+R6D3SSa3sD4sLxfbRY7CTh0muy1jxg2v
         dUqrD1vszv+GjmzLEKsdjuckxAqzjTxjMwiOHMOhcp2vXEqhbggwNzWCvZT8URf11XAg
         djksInsPAwtgOv7hL3yE3QAQHzvjTCpL4AfSerZdEhgn8Y8NYnWM5P67sy7Fmg9VZnfV
         aKrtUkKHjARWLMbOViSThPXyRQNHI7SwLKvDTnDcdWYHOYWPInRWWuMYDqy9zUcMqnmR
         GBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=G4HDiy5Y/tui9CfmQxHqWB1kQIX5OPGBr+uKZ5pSqyA=;
        fh=OLXnd4XHH2immN4UhwwgT7pe1Ugc+bh2CgFfNPBVT64=;
        b=N/C2cQ2pbZ3UKveBjpEtnG/vQeVdReAaU8TPPYDaSGHw6wioe5pgY8EJRNxzSsoVTv
         4Dkhapk+0Cf2msOEzZWx3YphvFkRrqnLi4wfTmqY2vpOqJd0pG1JFh5egESPbYlXXmM3
         2PixxgYt2XD6OgsJ6xm8xptqZJop4C7pCvqQoRTIdl3yRrYupIgdSKicQwvywbUjCFAb
         7V8IwzE04qJC3V8sRvBag5wbycmUT1GrdCRpcMSgeFkKEy9WXEf+UPY+eAhxGMIwJ5IX
         Yz7A+kKaPaBg9vElWcqbd5D9uredswuBW3fPS5seztdc1ReymrvIWUnljZ2calJMkNf8
         TBoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774430645; x=1775035445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G4HDiy5Y/tui9CfmQxHqWB1kQIX5OPGBr+uKZ5pSqyA=;
        b=PI8+6Z5YWcMOMAkvcuKXQXgOvMwHdxWh6/SD8kqPz+eRf08K5wgE6xm+TYZg5y6V8j
         NFt8ZZHtbypj/KfvJnjoisLn0lBslXcRNRMOAoRVT9HEk1XpkbVm9kIvtdBoKmFaXTs4
         uCYVhCXJJ9N0c5Ai38rbW2KU6om5SEpx4JGBAdVp9bpa3vAtCgEi4BbJgKlIbEMfjTNa
         RfszjyyzS1Fo7LrwR2p6ZO2NL7b2fktOm8jy/GPGAitGMnBdtC1Ubj0rTvWmoh2yyTrU
         pQWrID3EbY0DFpCb+4i31NxcDFcble8dn0Gt2+mZOyOAqrlBFd/9d/8weeb06Le922Yf
         o6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774430645; x=1775035445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4HDiy5Y/tui9CfmQxHqWB1kQIX5OPGBr+uKZ5pSqyA=;
        b=oEGuiODneMYAT1Z9ANBBF71/PqoZuCdOWlL7A6jQhAlXbcEx4S3ACfeEMl8WeSb2mY
         E+EFAEjSuUh9jP/OZ8nX5Dpkr1zUHTeMg71uvh+/wK3QJCHfC0ZEEsUCgEypGsyb/OOr
         pHc8ZaxHJ9qEMm1LO8Z1VCB1rS+OqRXIvUMVdhtkIq6YYPOuuZ23R+LBvO9ilmKwkO49
         QFviafCbDjdCE8de2StoSYjPxHGUUbBBovq77Fe62wwNp97HlyAbIQ4fEvvIGTtqxl3/
         Aq6kgZMaDA6aqhE6FQrl1O0mqLOqP5ROJ1TsSK4PCE7TwZFPJr3Wp9HVQy0u+LVvbRtv
         xdJg==
X-Forwarded-Encrypted: i=1; AJvYcCVNJhK+E2kHpCMYIuKJCSO4NdR4U2VsQ1zbbY3lAMk/vzL5JgaU+e+ZV5T8xhkhPwbEleNW3aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ+gZ92MpiLtuPGWn8C4x7W+nuhhAzo08Uv+LFrjlUv1XMeyYt
	tD0XPOWdh1UvRcL278C5Z7wY9D+9Pc3UPR/7iHEeqn+b7HE9xhA3CPv4OrdjGpjk4kkQNiL0Olf
	XabtmlkT9m+bD5i7w8coJslS/ED0dOkY=
X-Gm-Gg: ATEYQzz+TRCij+DE7QG8aeXmU1tmmA+FMvZzlQwkzZaRTm/T6Q4m+PKOmt3+7Qn7nM3
	1uqatiW/7w1L29455GmJpny1YdeLuOskPKvb6V84qmIOWR9ImKR214du0Kc9ZjQ4B/e/b0DkvUO
	Yg00mOdfF15KGyCTEIAmq6BH99CnwN2SKjoNhgD3DeqgtBF6zg2SwXNNAv6d35t/k/zOJoZHoO2
	HmeC9Vd/Lc0aR8EuyOfmHTAMjYA4ZODNL9LSmmNDK2EGDDcqB66CoiEv3FwKwrKTVVqacLwCIco
	u2bsSZv+JDRHZaKnxKam24Wc4+i8Vc53u7L3UA==
X-Received: by 2002:a05:6871:80d:b0:417:3fe7:3c4d with SMTP id
 586e51a60fabf-41ca70d870amr1618910fac.38.1774430644816; Wed, 25 Mar 2026
 02:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324211402.342474-1-devnexen@gmail.com> <39c8e4ff-240f-4bb4-b4d6-cb8aea930c53@ti.com>
In-Reply-To: <39c8e4ff-240f-4bb4-b4d6-cb8aea930c53@ti.com>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 25 Mar 2026 09:23:53 +0000
X-Gm-Features: AaiRm53MO6zxzwA5BKzNlckEHiAGYs9x01Mv0uG12Z0IuhHf_XxPJXxsfx6wv88
Message-ID: <CA+XhMqyaKs-JfcLYTb1=rcQW-CiRqDVasUv7LJP0vs29wTMbNA@mail.gmail.com>
Subject: Re: [PATCH] net: ti: icssg-prueth: fix missing data copy and wrong
 recycle in ZC RX dispatch
To: Meghana Malladi <m-malladi@ti.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271475-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52C4D3223EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Wed, 25 Mar 2026 at 09:14, Meghana Malladi <m-malladi@ti.com> wrote:
>
> Hi David,
>
> On 3/25/26 02:44, David Carlier wrote:
> > emac_dispatch_skb_zc() allocates a new skb via napi_alloc_skb() but
> > never copies the packet data from the XDP buffer into it. The skb is
> > passed up the stack containing uninitialized heap memory instead of
> > the actual received packet, leaking kernel heap contents to userspace.
> >
> > Add the missing memcpy from xdp->data into the skb data area.
> >
> > Additionally, remove the skb_mark_for_recycle() call since the skb is
> > backed by the NAPI page frag allocator, not page_pool. Marking a
> > non-page_pool skb for recycle causes the free path to return pages to
> > a page_pool that does not own them, corrupting page_pool state.
> >
> > The non-ZC path (emac_rx_packet) does not have these issues because it
> > uses napi_build_skb() to wrap the existing page_pool page directly,
> > requiring no copy, and correctly marks for recycle since the page comes
> > from page_pool_dev_alloc_pages().
> >
>
> Thanks for the patch. I wonder how were you able to catch this bug?

By code review, comparing emac_dispatch_skb_zc() with the non-ZC path
emac_rx_packet() and noticing the ZC path allocates a separate skb but
never copies data into it.

>
> > Fixes: 7a64bb388df3 ("net: ti: icssg-prueth: Add AF_XDP zero copy for RX")
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >   drivers/net/ethernet/ti/icssg/icssg_common.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> > index fd4e7622f123..9638a03bebb4 100644
> > --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> > +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> > @@ -902,6 +902,7 @@ static void emac_dispatch_skb_zc(struct prueth_emac *emac, struct xdp_buff *xdp,
> >
> >       skb_reserve(skb, headroom);
> >       skb_put(skb, pkt_len);
> > +     memcpy(skb->data, xdp->data, pkt_len);
>
> Why not use skb_copy_to_linear_data() ?

Ah, that is a good suggestion, did not know it.

>
> >       skb->dev = ndev;
> >
> >       /* RX HW timestamp */
> > @@ -912,7 +913,6 @@ static void emac_dispatch_skb_zc(struct prueth_emac *emac, struct xdp_buff *xdp,
> >               skb->offload_fwd_mark = emac->offload_fwd_mark;
> >       skb->protocol = eth_type_trans(skb, ndev);
> >
> > -     skb_mark_for_recycle(skb);
> >       napi_gro_receive(&emac->napi_rx, skb);
> >       ndev->stats.rx_bytes += pkt_len;
> >       ndev->stats.rx_packets++;
>

