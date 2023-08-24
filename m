Return-Path: <netdev+bounces-30234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8C27868C5
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 09:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0681C20DBD
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 07:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DFC1FB4;
	Thu, 24 Aug 2023 07:43:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F3D185E
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:43:14 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1CC1725
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 00:42:59 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so100329331fa.3
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 00:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692862977; x=1693467777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YY+8fBRLwojpVyCmrvtgTeCzpORlcM55pB5n4IHcT44=;
        b=IDI8V7gVT0Kg2DPR1lImQVRMQqcsIzNLXw48Nulkn0oZlQkgMg9Yz19Sxs7oQJhUtC
         mvfWFei9pD8zUK2F+VzxVHoTlafJFnyDXrD0hsKcbA5EZlPn6rq41GLvIW4Bta0XOjNQ
         aOvXa1RxHsQ6KEKJMhYttde4K6sTTw8m6gryQBiBvRr/uQryMy5t2dJODG5O7+3duFUF
         8EKsG4H1LA4B692sAeafgiXipujfdxxOgxfpi7NrRDNj00baTi3LH74kDDZU0V54ARZs
         ntgVE4BvAV0qgMEGE6kiezu0X1Zq3z5+1I6rVbDvCWbn693k+s3AtjxHoazGL3io/i5h
         /RFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692862977; x=1693467777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YY+8fBRLwojpVyCmrvtgTeCzpORlcM55pB5n4IHcT44=;
        b=Rz+v98rLDkgHEUtNM+PfWKIIDsMdvd+zlJKRnrvxLKAazSOsJluOSZDp8sawcASFeD
         xwJpGAOBAwD1wUrDA0ij/gvQQL8WNKcTw1At5xSEgsqvBSU0Wg5jf4vHDF0Ko2AnUZ4J
         bf9KQe1ajGnzucbYbZv2GBBywiNH2jQH4pDfKi0FdE3kbteH7d3484ls0QzQFSOMopf+
         YifiJcXaxadz1QhIa6erSCmsaC7vaQZ78+ZQHYFm6achgM5oDJMMrC1B+jh42IE2Cjoa
         0aONWteOmVvvR2CpGMfOfVkT6cpxpQhg8RUp/wpfc0m+MOzCJTw7bNa5Fjlrxgw5A3KS
         JrjA==
X-Gm-Message-State: AOJu0YxtRTwNkOhkKbgVB6R36vSO40EEWVNrq6IR4R9eODByPdZ4egnn
	PUqLEpCdJ6abNEp62YN9o0eQK2oYMgPlPrCti7A3mg==
X-Google-Smtp-Source: AGHT+IHofkMw9cfeht8i2PqllV6DafyGzH8WmubI34IZp7MgSTDzP7QZicHoiuj6gTWy4thhdEn/rWktqc2oruG5iX0=
X-Received: by 2002:a05:6512:1329:b0:4ff:a02e:a53f with SMTP id
 x41-20020a056512132900b004ffa02ea53fmr10944347lfu.52.1692862977478; Thu, 24
 Aug 2023 00:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230823094757.gxvCEOBi@linutronix.de> <d34d4c1c-2436-3d4c-268c-b971c9cc473f@kernel.org>
 <CAC_iWjLa9r9gxdquECoTFAvqS1Lfx+XuLyf5-yuyaYC=93AVWg@mail.gmail.com>
In-Reply-To: <CAC_iWjLa9r9gxdquECoTFAvqS1Lfx+XuLyf5-yuyaYC=93AVWg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 24 Aug 2023 10:42:21 +0300
Message-ID: <CAC_iWjL6gnfqC685Mv9MwqtOts4kHmLWFFtWSYV3rp82eJ_VEg@mail.gmail.com>
Subject: Re: [BUG] Possible unsafe page_pool usage in octeontx2
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, 
	Ratheesh Kannoth <rkannoth@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Geetha sowjanya <gakula@marvell.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Thomas Gleixner <tglx@linutronix.de>, hariprasad <hkelam@marvell.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Qingfang DENG <qingfang.deng@siflower.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 24 Aug 2023 at 10:21, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> [...]
>
> > >
> > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > index 7ff80b80a6f9f..b50e219470a36 100644
> > > --- a/net/core/page_pool.c
> > > +++ b/net/core/page_pool.c
> > > @@ -612,7 +612,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
> > >                       page_pool_dma_sync_for_device(pool, page,
> > >                                                     dma_sync_size);
> > >
> > > -             if (allow_direct && in_softirq() &&
> > > +             if (allow_direct && in_serving_softirq() &&
> >
> > This is the "return/free/put" code path, where we have "allow_direct" as
> > a protection in the API.  API users are suppose to use
> > page_pool_recycle_direct() to indicate this, but as some point we
> > allowed APIs to expose 'allow_direct'.
> >
> > The PP-alloc side is more fragile, and maybe the in_serving_softirq()
> > belongs there.
> >
> > >                   page_pool_recycle_in_cache(page, pool))
> > >                       return NULL;
> > >
> > > because the intention (as I understand it) is to be invoked from within
> > > the NAPI callback (while softirq is served) and not if BH is just
> > > disabled due to a lock or so.
> > >
> >
> > True, and it used-to-be like this (in_serving_softirq), but as Ilias
> > wrote it was changed recently.  This was to support threaded-NAPI (in
> > 542bcea4be866b ("net: page_pool: use in_softirq() instead")), which
> > I understood was one of your (Sebastian's) use-cases.
> >
> >
> > > It would also make sense to a add WARN_ON_ONCE(!in_serving_softirq()) to
> > > page_pool_alloc_pages() to spot usage outside of softirq. But this will
> > > trigger in every driver since the same function is used in the open
> > > callback to initially setup the HW.
> > >
> >
> > I'm very open to ideas of detecting this.  Since mentioned commit PP is
> > open to these kind of miss-uses of the API.
> >
> > One idea would be to leverage that NAPI napi->list_owner will have been
> > set to something else than -1, when this is NAPI context.  Getting hold
> > of napi object, could be done via pp->p.napi (but as Jakub wrote this is
> > opt-in ATM).
>
> I mentioned this earlier, but can't we add the softirq check in
> __page_pool_get_cached()?
> In theory, when a driver comes up and allocates pages to fill in its
> descriptors it will call page_pool_alloc_pages().  That will go
> through the slow allocation path, fill up the caches, and return the
> last page.  After that, most of the allocations will be served by
> __page_pool_get_cached(), and this is supposed to be running during
> the driver Rx routine which runs under NAPI.  So eventually we will
> hit that warning.

Right... Scratch that, this will still warn on the initial allocation.
The first descriptor will get a page of the slow path, but the rest
will be filled via the caches.


/Ilias
>
> Thanks
> /Ilias
>
> >
> > --Jesper

