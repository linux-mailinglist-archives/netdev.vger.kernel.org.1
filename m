Return-Path: <netdev+bounces-46748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A17CC7E62A6
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 04:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91601C2082C
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 03:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5315C53B8;
	Thu,  9 Nov 2023 03:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0aVp01z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC64953A0
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 03:28:53 +0000 (UTC)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3885C18C
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 19:28:53 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-45d9b477f7bso214295137.1
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 19:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699500532; x=1700105332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ikgb97n5S8QqbuZuVBZI3JBO2aC2Fq2kXIJ4zEykToE=;
        b=a0aVp01zuGp8Ei+uTxVQTSfAcdl/vtmRwl2opZHfvUa6sqnPj8tuUdO2BBc+0x77CR
         fOm/soKG7QzqVZu2Iyyv/TusTc9lDFhHYJIUIivzS60xl3i0F5RPGUDJ77oqz+MaAvjp
         ujjP0ZJchW+4rnTicJUjzlLkdnrgt+W4ddErPJWwUbZW7BsDYe0AEOBO9otrIxhMjAF4
         2eWGg55CvYnIyTavuqhjW3tSwQavEqdmecEJWDAwsUZs5ByFF+KLmR/nVgE1gdQgsNXM
         DHoF+IUYl5qwWaOy9Y7FoogYDDdpj4jsYsLrB4oiRb8I5MyTaROHVWvnmxpuqgP3M3XN
         OH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699500532; x=1700105332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ikgb97n5S8QqbuZuVBZI3JBO2aC2Fq2kXIJ4zEykToE=;
        b=vaOOBJheun3buE15i0weYe//Qk+xvtA+fMim6fLxJB7pyTJROFiz4XucB7aoVVH2C1
         gX9orQ0C7S+kYepvO8ZhtwSqOXLlLUqCy7o2sE0JZ7QbLcZE0oQzjDqDwnyUzrNjzJ9L
         2S7eM/7wcLD279RNPD1CObDcAeMpoK7tuGBACIDPK/Cyc6pQHX4BFZOwMpKs5iKAiYb2
         j91+JJaY3GMva2BWdBcXN6lVkGDBcmAidyJc+u6zkObxgRp/orLUDsqrGSEQKoA464sx
         DaMxSy6nJ4sn8v+TeAojmwEGzW6vCtcEwxoTIFxTbb0Z+mcoiOcrckQn8MNGZWZROUmn
         ewzQ==
X-Gm-Message-State: AOJu0Yy/VekT314GxVqZuRnmvWYOid9Iog1pZRtQyb0RA8fHXRFvdI9c
	87rgPuvDATMcXGlifDy+illV/w5+P3sYBg02R6cpIw==
X-Google-Smtp-Source: AGHT+IFzJrf65ga7sv/OgM+0UhM1c5bSalG++zWTXJpV4FmTMxFMcb3XRTpmkq/IJcWmrLuCpOZl1uJ9oSJsAXsgSGE=
X-Received: by 2002:a67:ef03:0:b0:45f:8ceb:ce13 with SMTP id
 j3-20020a67ef03000000b0045f8cebce13mr3890948vsr.5.1699500530890; Wed, 08 Nov
 2023 19:28:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024160220.3973311-1-kuba@kernel.org> <20231024160220.3973311-6-kuba@kernel.org>
 <CAHS8izOTzLVxQ_rYt1vyhb=tgs2GAtuSZUWkZ183=7J3wEEzjQ@mail.gmail.com> <20231025131740.489fdfcf@kernel.org>
In-Reply-To: <20231025131740.489fdfcf@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 8 Nov 2023 19:28:36 -0800
Message-ID: <CAHS8izP9ifXBuLs=q-tMcD-YC4o5R8gsG7B52LYGowetEaE4aw@mail.gmail.com>
Subject: Re: [PATCH net-next 05/15] net: page_pool: record pools per netdev
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 1:17=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 25 Oct 2023 12:56:44 -0700 Mina Almasry wrote:
> > > +#if IS_ENABLED(CONFIG_PAGE_POOL)
> > > +       /** @page_pools: page pools created for this netdevice */
> > > +       struct hlist_head       page_pools;
> > > +#endif
> >
> > I wonder if this per netdev field is really necessary. Is it not
> > possible to do the same simply looping over the  (global) page_pools
> > xarray? Or is that too silly of an idea. I guess on some systems you
> > may end up with 100s or 1000s of active or orphaned page pools and
> > then globally iterating over the whole page_pools xarray can be really
> > slow..
>
> I think we want the per-netdev hlist either way, on netdev
> unregistration we need to find its pools to clear the pointers.
> At which point we can as well use that to dump the pools.
>
> I don't see a strong reason to use one approach over the other.
> Note that other objects like napi and queues (WIP patches) also walk
> netdevs and dump sub-objects from them.
>

Sorry for the very late reply.

I'm not sure we need a per-netdev hlist either way, seems to me
looping over the global list and filterying by pp->netdev is the
equivalent of looping over the per-netdev hlist, I think.

The reason I was suggesting to only do the global list is because when
the same info is stored in 2 places you may end up with the info going
out of sync. Here, netdev->page_pools needs to match the entries in
each pp->netdev. But, I think your approach is more reasonable as
looping over the global array at all times may be a pain if there are
lots of page_pools on the system. I also can't find any issues with
how you're keeping netdev->page_pools & the page_pools->netdev, so
FWIW:

Reviewed-by: Mina Almasry <almasrymina@google.com>

> > > @@ -48,6 +49,7 @@ struct pp_alloc_cache {
> > >   * @pool_size: size of the ptr_ring
> > >   * @nid:       NUMA node id to allocate from pages from
> > >   * @dev:       device, for DMA pre-mapping purposes
> > > + * @netdev:    netdev this pool will serve (leave as NULL if none or=
 multiple)
> >
> > Is this an existing use case (page_pools that serve null or multiple
> > netdevs), or a future use case? My understanding is that currently
> > page_pools serve at most 1 rx-queue. Spot checking a few drivers that
> > seems to be true.
>
> I think I saw one embedded driver for a switch-like device which has
> queues servicing all ports, and therefore netdevs.
> We'd need some help from people using such devices to figure out what
> the right way to represent them is, and what extra bits of
> functionality they need.
>
> > I'm guessing 1 is _always_ loopback?
>
> AFAIK, yes. I should probably use LOOPBACK_IFINDEX, to make it clearer.



--=20
Thanks,
Mina

