Return-Path: <netdev+bounces-30233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCAD78683A
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 09:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801C01C20DCF
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 07:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4171C26;
	Thu, 24 Aug 2023 07:22:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF2C2453C
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:22:08 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251F8E4B
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 00:22:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50087d47d4dso4858675e87.1
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 00:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692861725; x=1693466525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eBIMeG8JEHEHP64A7zBEVP6/KZfa2H6ExYOqyh8ZyYQ=;
        b=WoxPxKPdIQ+sA6Euu0dMxfKxs8KAmEl0bG+VkDo3tEk/pUrwHQfIUei/3kOtWdZgkL
         2EwnbMJgkc3r+gTibTJbSDQrNLpQhbWwUpwazeM4HmosD2DRtyQ81UMYu5btmBrUsBit
         GVeyE8XILvMUr36qsDEjAArAb+BsERazZSYEj9d6sFnaEZJX1cdH9mGWdIh3iWLYUoX9
         pHQsOn93P2SQmZ7ERr2feU8g6MG3sw9r+QTBj3WedtVVpXyUqjsOiOdPFi4+f7BZmdcZ
         2XmPgkrMqP5+15tr0/jY8zgQYB9U41MaLMp+jRXYgkr3EuVqZMGuO/pHmMMvPW0/XXPU
         NQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692861725; x=1693466525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBIMeG8JEHEHP64A7zBEVP6/KZfa2H6ExYOqyh8ZyYQ=;
        b=cCjv7O72W8Ur0kJPbUhTnuo6QPBpg+R32S9Ekho59NtCkz1m9VU69gFQ4R9v3uArFy
         CognzDdl2G+UjrH9UA5Sia59mAvls0N4LZB0TwnioJBVUgTzzcE1I87bP0OqmlYaedXX
         KTMrXTex97dgwvzy9PEfkOuMxIx8VznN0bnBX3wGbCfNaRlVOlus4SSalyxpRT3lJMhb
         8vVw/2CMc2aG/emnOyhGzIedgts2Xx0RVx8pfuMOsHxW4tuCy72HsCVCGXANiLJAxsu8
         pKmW/m87GPTDQkYECfuY3z+V1RXE7T6sEZOMZ1SbFgRzXUtclKTUYIBN3M9ToQCj+hQD
         nJ8w==
X-Gm-Message-State: AOJu0YwnX9S/Lng2i60CIZPhOJyYMwYTyF3yrMICJKY92NP9hO1+yZiX
	YDSZXljfSUA+kkEUAmbxAc8q7wo1rNjGEyoSLDvduA==
X-Google-Smtp-Source: AGHT+IF9Zjdh63h8y3wJsguNe4O6SGyFPf1XDcrCU4oF7dZGpRVUhlbIdBnAOAhcc1UeUbJZTWxXpsbdcfyrrbiALAQ=
X-Received: by 2002:a05:6512:acc:b0:4f8:5e21:a3a9 with SMTP id
 n12-20020a0565120acc00b004f85e21a3a9mr12248975lfu.45.1692861725315; Thu, 24
 Aug 2023 00:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230823094757.gxvCEOBi@linutronix.de> <d34d4c1c-2436-3d4c-268c-b971c9cc473f@kernel.org>
In-Reply-To: <d34d4c1c-2436-3d4c-268c-b971c9cc473f@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 24 Aug 2023 10:21:29 +0300
Message-ID: <CAC_iWjLa9r9gxdquECoTFAvqS1Lfx+XuLyf5-yuyaYC=93AVWg@mail.gmail.com>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[...]

> >
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index 7ff80b80a6f9f..b50e219470a36 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -612,7 +612,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
> >                       page_pool_dma_sync_for_device(pool, page,
> >                                                     dma_sync_size);
> >
> > -             if (allow_direct && in_softirq() &&
> > +             if (allow_direct && in_serving_softirq() &&
>
> This is the "return/free/put" code path, where we have "allow_direct" as
> a protection in the API.  API users are suppose to use
> page_pool_recycle_direct() to indicate this, but as some point we
> allowed APIs to expose 'allow_direct'.
>
> The PP-alloc side is more fragile, and maybe the in_serving_softirq()
> belongs there.
>
> >                   page_pool_recycle_in_cache(page, pool))
> >                       return NULL;
> >
> > because the intention (as I understand it) is to be invoked from within
> > the NAPI callback (while softirq is served) and not if BH is just
> > disabled due to a lock or so.
> >
>
> True, and it used-to-be like this (in_serving_softirq), but as Ilias
> wrote it was changed recently.  This was to support threaded-NAPI (in
> 542bcea4be866b ("net: page_pool: use in_softirq() instead")), which
> I understood was one of your (Sebastian's) use-cases.
>
>
> > It would also make sense to a add WARN_ON_ONCE(!in_serving_softirq()) to
> > page_pool_alloc_pages() to spot usage outside of softirq. But this will
> > trigger in every driver since the same function is used in the open
> > callback to initially setup the HW.
> >
>
> I'm very open to ideas of detecting this.  Since mentioned commit PP is
> open to these kind of miss-uses of the API.
>
> One idea would be to leverage that NAPI napi->list_owner will have been
> set to something else than -1, when this is NAPI context.  Getting hold
> of napi object, could be done via pp->p.napi (but as Jakub wrote this is
> opt-in ATM).

I mentioned this earlier, but can't we add the softirq check in
__page_pool_get_cached()?
In theory, when a driver comes up and allocates pages to fill in its
descriptors it will call page_pool_alloc_pages().  That will go
through the slow allocation path, fill up the caches, and return the
last page.  After that, most of the allocations will be served by
__page_pool_get_cached(), and this is supposed to be running during
the driver Rx routine which runs under NAPI.  So eventually we will
hit that warning.

Thanks
/Ilias

>
> --Jesper

