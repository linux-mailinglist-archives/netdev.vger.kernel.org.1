Return-Path: <netdev+bounces-297896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XY5/B1wcKmrCiwMAu9opvQ
	(envelope-from <netdev+bounces-297896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:24:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEED66DD13
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:24:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=lxJmUiMF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297896-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297896-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A348B301947C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EF4304BCB;
	Thu, 11 Jun 2026 02:24:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3766C2FD681
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:24:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781144659; cv=pass; b=QAGfkktzkoStCN3+Kt8Y4ywO0RFsTv3qNWQkOQHUuI+LHKF8gmxOJpGXQ+9bQJXIULXZTpPTh/oxgWTewOcQqxaMuoApnh8Uh2Xu3nVyM7FRWn7xtu+bzFxNgs7So2mWX5TkjTxO7hYTuOfsTznme9Chte/XBJWXv3l0pjcisFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781144659; c=relaxed/simple;
	bh=HFuA9XjGPSoO0vDqba9U3w0/WoqIFHP7dSHWuV0v9bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIK/nrlJ/7ESiUjnNwRHbRIhXVnhwqj4PcdP54O8tQv1F2LdlGrWVAmQVM3mjZkO6FRBTDypLuQ6YEZ8XMoHA7a25oaPAi+Qf4rswnYMCrqBgQgxlRQvASun2P8necgnJWYvD+4DV8NmIX6xmGD2WytRo1yKkvcpQ9Syr3kEdxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=lxJmUiMF; arc=pass smtp.client-ip=209.85.215.175
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c85c531d4a9so3014104a12.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781144656; cv=none;
        d=google.com; s=arc-20240605;
        b=a+DAye7hBZUEsZNY6kchD0qNfqgsfyngoGPL8sG6nQjAtom0Tz7KHxU8Rm2JWbpLsN
         a83QJctA4e6ruXC9iqFHCd38CO6hIE6heQlsQyVNFmSNHUXF51rM7s7VcOVx/WtU3RRp
         hPANjrUqGtIvZQ/zKWb/uYnWfxHsYwS3jiJl0jsoH3geZJiEl3JffWciUmqTUIb9Nx4y
         xBvkLL+Rwp6TGgGKluP3hW8tSZVg7RWz1ZUTwIBgut2CJBpdbOKZrE+fsZNqfyM6syQP
         dRZ0m5zZDmzPmd6VCG/jiDZ0mcSMkvbGlMcqguF9olTSuSIM0Dn1VaUI4MYVhcHI7jHa
         udZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NdBrEBlpAfFK5nSacNcDPGDMq8EZhUqxapMEX5SFjbw=;
        fh=U3/xbcMxzIpcODjaL5JrXjqFGdZbPFlOMCNsXSHMZQY=;
        b=QTC1Cf+5/4wIRId0QYpIpXtYdYhRh1ba4M2kQ5hUtyDhq62mvFjO1fAFAXB0ltVvDT
         S+H7vgVOxQyKJ280zCn6T27PnBCasvUdfCN+1k+Z5aukuOoQMKtFheo54CraSA9IG8m6
         V9WBX7aJ0lfgY5sutFLMq53neiTghvH+RpAVpKKyb0eiugEsF1v+qnEDO5KLShmagqrr
         1fAwdS9SEE3zSxauaNd+WEkwn68dbGbTWupppQK4B8BFKk+n3ZOJkm8RCu2mU/mIS8/N
         it0vKTwCWlxUPjJbxXFs/9I1AAVJGH34px7aUy1y+rRv+fdB4g6+WtbpAmQ3EbEPuZ5m
         T+vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781144656; x=1781749456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdBrEBlpAfFK5nSacNcDPGDMq8EZhUqxapMEX5SFjbw=;
        b=lxJmUiMFNKXtL641PBTjCIIdvELHhZu9bpHbp5WWuLA5kgcoKx63WXbBeL42tv2+RV
         18aDRdLXuSYC2xK6MGtwTVzgfwwgflxuh0d9Kn2VkORdWYpvuEk+JQcd+1JbxgcywIvd
         MydiUeQ/lTQ9tVIPcZSOG6143zAWeQ/MIuTXQ6yKGCfvqubQ0rZgy0CSw+CY0mnQ4MNI
         f3cESCqWb9oER9e5Et92V5IH5np33cOqHRjZ/VsphUJscT1Mbo0C3D+ptG5HB1zZqO1/
         Y/rbhV0HX+6VtAuVvSqOiBr65PaRhcMw7tZSKJNCzoRfh1WfuCAGulR5t9E8RIP47ZTA
         7wAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781144656; x=1781749456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NdBrEBlpAfFK5nSacNcDPGDMq8EZhUqxapMEX5SFjbw=;
        b=eWx48dYh7Kvi0DKq8SkO8YOk0aY60Bcx7yga1rEPjpgzOY4fQvhzdWCBCoWr06xdkJ
         vPqjkOTpQbGdohrMCmqn6J0Ok/D+BS70fKWGgvCc1VKSZ+SeoeBe6GKujqSfiHnwV8LN
         6KvpHMbfSBDUPxhWMqYF7oFo9bgBBCed3dsdA5yie6JyRPF8QIsJNr9yfGZ174E3iiat
         e4C/I4F8TacUttyl2IZBojRhYxpKfnAgSni01uIWeEpuuV9m5za5NWqmYbYpzUIs/bOb
         4URQCcJeIWsdT63NvNGIdoORDpsSNCsAlK3Bcsgfu6nt7aU4MC4Q4MSIl5LyH/TvtXaF
         kwDw==
X-Forwarded-Encrypted: i=1; AFNElJ+lyG/QKcdnPwyCwyyDXYw4++R1nnu5lNhShi25h4L8W6fEKdzFI7aCDPCrkF8HA/ZC9gNybso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK31M5f2LSy9bOB7X4TNg1rkm7QHEEC8hNyzvHIwEZIOjDPHvT
	S2LrMPPzr0XhYtx6eK5Mqxk5oisxPIoiYSXXgMYstlt+Swmqd8F4OZxDfaLNipNoZuPZb3SbYwv
	uHQA0KisJl8tdnQ+4IHSJ7yL49uskdlKv35VeEFck
X-Gm-Gg: Acq92OFCbCh3ojJeeqc44Rc18PKhaVfcBbKN06OPFxehyojPWHXSsOW6I6aYxh+nSaG
	mhbVh7XrQsQvEiE884nLPjlMcj91RYwIYVsyQg7msOpW9rci2xyVtaE3oS1Jmy+INxQq7nzRMY8
	rc/zv3w7gyk//XzU13Tw9Ur2Hr8jLVQ0vefWLqMJmnNC9rdPLnOVNiYc6PhU2vaB5DxP0S+IOwP
	T0SKAvHi+RFQl4xm1yX+mxMJSdnBQiUzew+Hdw6QKM/4AgpZw6JEWLtIOaHB9OTsASDwij5H5uO
	i/G9jpBbqld5DhbdHQ==
X-Received: by 2002:a05:6a20:9151:b0:3b4:9027:712 with SMTP id
 adf61e73a8af0-3b5e323684amr594770637.20.1781144656567; Wed, 10 Jun 2026
 19:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610232936.1176094-1-xmei5@asu.edu> <20260610232936.1176094-2-xmei5@asu.edu>
 <1781144329.8069873-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1781144329.8069873-2-xuanzhuo@linux.alibaba.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 10 Jun 2026 19:24:03 -0700
X-Gm-Features: AVVi8Cff_FTIcsVHrr9aJqW72B1wQaebfIj61Efw6O15tCwyDyH1oC3aMziYxOA
Message-ID: <CAPpSM+RApuYf3-ui15E+01fWEzUzfh6mgijQyT_+KjusMVxMfw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] virtio-net: harden page_to_skb() big-packet
 frag loop
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	minhquangbui99@gmail.com, bestswngs@gmail.com, mst@redhat.com, 
	jasowang@redhat.com, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297896-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:xuanzhuo@linux.alibaba.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:minhquangbui99@gmail.com,m:bestswngs@gmail.com,m:mst@redhat.com,m:jasowang@redhat.com,m:eperezma@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FEED66DD13

Thanks for the review. I agree with that as I replied at the end of
v1. If we obsolete 2/2 but keep 1/2, is it okay to just leave it as
is?

Xiang

On Wed, Jun 10, 2026 at 7:19=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 10 Jun 2026 16:29:36 -0700, Xiang Mei <xmei5@asu.edu> wrote:
> > This is a robustness hardening patch. The slow-path frag loop in
> > page_to_skb() walks the page chain via page->private until the
> > device-reported len is consumed, implicitly trusting that len fits the
> > chain. It does not stop when the chain is exhausted (page becomes NULL
> > at the tail), nor when nr_frags reaches the end of the static
> > skb_shinfo()->frags[MAX_SKB_FRAGS] array.
> >
> > Both bounds are needed: the chain length is big_packets_num_skbfrags + =
1
> > pages, which for an MTU-driven configuration can be well below
> > MAX_SKB_FRAGS, so neither guard implies the other.
> >
> > Make the loop self-defending so it no longer relies on the caller havin=
g
> > validated len: stop once the chain is exhausted, and never index past
> > MAX_SKB_FRAGS. No functional change for well-formed input.
>
> At this point, we are assuming that len represents the correct packet len=
gth. If
> there is a bug in the validation, it can be fixed, just like in your prev=
ious
> patch. Indeed, not checking nr_frags is also based on the overall design.
> However, I do not recommend adding this kind of enhancement. If we follow
> this logic, we would end up adding similar code in many other places, whi=
ch
> doesn't make much sense.
>
> Thanks.
>
> >
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> > v2: robustness patch
> >
> >  drivers/net/virtio_net.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index afe73eda1491..518c22fa1b68 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -906,8 +906,11 @@ static struct sk_buff *page_to_skb(struct virtnet_=
info *vi,
> >       }
> >
> >       BUG_ON(offset >=3D PAGE_SIZE);
> > -     while (len) {
> > +     while (len && page) {
> >               unsigned int frag_size =3D min((unsigned)PAGE_SIZE - offs=
et, len);
> > +
> > +             if (unlikely(skb_shinfo(skb)->nr_frags >=3D MAX_SKB_FRAGS=
))
> > +                     break;
> >               skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, off=
set,
> >                               frag_size, truesize);
> >               len -=3D frag_size;
> > --
> > 2.43.0
> >

