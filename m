Return-Path: <netdev+bounces-37620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D69807B65B6
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 87A3028165B
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ED4FC1F;
	Tue,  3 Oct 2023 09:40:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1F72906
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 09:40:54 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97782A1
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 02:40:51 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5056ca2b6d1so806069e87.1
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 02:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696326049; x=1696930849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6GYoLfhpjKn+Ov/B91dyx3sCIeGji5aj/3JFe9K4TQ8=;
        b=MwXx3CX/2Khx0PyMJNbeEIAG4LSuDyUFvPIPs5X39OsfSs+8bsfV0XLjEZE9pH8/me
         VYyp+AWWy4PxZ0UJuuX3STY/6NzTyncn6JamIs09AieqmCDZYMTRv9E6SiaxT4JLjP21
         PWcLkKpO07qqAENxQtCTicpkqyzqpzaxJL5fTvecms+r95G1LNLs5XlhZn1SshCJP4bJ
         PYrKJD9aP3wZYAL6USlpsfDeUiz2lXbAWdg+W/i4WbJcgjx3mDf9pVSRMW0DEfKPLCTR
         ZBkI8tLgdxE5TL5nV3zfCLeHldMdJ34KOK/fWNp1qTKb7MqpHeCCanKFRiydecfDBZos
         Vxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696326049; x=1696930849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GYoLfhpjKn+Ov/B91dyx3sCIeGji5aj/3JFe9K4TQ8=;
        b=dfUcN6rPgYqEFXwOOHkKx+aanx4Q8pvOU/uWpkJPAtWfWIXquo6bIwprnhL/wy/wgK
         hluj7ytwVBwRtR5f5LaZ0h75FxDIOJH6m+7LNB+5bKgSHJOqvECFksxcMMlIQFeB7OVz
         OUN/hJSyx9K7nuHBFVrwKwpGgzOcW78/HOKCw9x3F3j8Er53qY6K1qQZDAWrsLvv7Qgj
         f40QcIceqpTR00kgirVE227cT8bnNOJqaF02cUbVapKfrLHD4vQcj68pbnB43RCxljwN
         Ba0s7+F0RkTkk6UAdMjzoj4KzGgPEy2rhwfV38XtWyYA1COPtyKjkMqAijMSp9lKLWbE
         jeMQ==
X-Gm-Message-State: AOJu0YyyCsD8XAbYckq4EKrS+i/7jzjLi8u1M+LcNJp63IWTbgEcc73E
	gfjOv0aztNZEZE5iGPX36xsMYaK0DgXjuVUIt7deWQ==
X-Google-Smtp-Source: AGHT+IFVyhekx4L71P1JPgGuvXrNSgm3tOdnKfCtOCBbpMtiRW1FJxuAE6TseQq+oIs+ZMNtbFTAdDqEYrMsAKVXtYo=
X-Received: by 2002:a05:6512:3d04:b0:500:7aba:4d07 with SMTP id
 d4-20020a0565123d0400b005007aba4d07mr2044702lfv.22.1696326049577; Tue, 03 Oct
 2023 02:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922091138.18014-1-linyunsheng@huawei.com>
 <20230922091138.18014-2-linyunsheng@huawei.com> <b70b44bec789b60a99c18e43f6270f9c48e3d704.camel@redhat.com>
In-Reply-To: <b70b44bec789b60a99c18e43f6270f9c48e3d704.camel@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 3 Oct 2023 12:40:13 +0300
Message-ID: <CAC_iWjL8jjZWSMdbZ=LqWKVKLR_3ZYzrBv8RwG+AgMqZWQEyaA@mail.gmail.com>
Subject: Re: [PATCH net-next v10 1/6] page_pool: fragment API support for
 32-bit arch with 64-bit DMA
To: Paolo Abeni <pabeni@redhat.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, 
	Liang Chen <liangchen.linux@gmail.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Guillaume Tucker <guillaume.tucker@collabora.com>, Matthew Wilcox <willy@infradead.org>, 
	Linux-MM <linux-mm@kvack.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Paolo

On Tue, 3 Oct 2023 at 10:46, Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Fri, 2023-09-22 at 17:11 +0800, Yunsheng Lin wrote:
> > Currently page_pool_alloc_frag() is not supported in 32-bit
> > arch with 64-bit DMA because of the overlap issue between
> > pp_frag_count and dma_addr_upper in 'struct page' for those
> > arches, which seems to be quite common, see [1], which means
> > driver may need to handle it when using fragment API.
> >
> > It is assumed that the combination of the above arch with an
> > address space >16TB does not exist, as all those arches have
> > 64b equivalent, it seems logical to use the 64b version for a
> > system with a large address space. It is also assumed that dma
> > address is page aligned when we are dma mapping a page aligned
> > buffer, see [2].
> >
> > That means we're storing 12 bits of 0 at the lower end for a
> > dma address, we can reuse those bits for the above arches to
> > support 32b+12b, which is 16TB of memory.
> >
> > If we make a wrong assumption, a warning is emitted so that
> > user can report to us.
> >
> > 1. https://lore.kernel.org/all/20211117075652.58299-1-linyunsheng@huawei.com/
> > 2. https://lore.kernel.org/all/20230818145145.4b357c89@kernel.org/
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> > CC: Lorenzo Bianconi <lorenzo@kernel.org>
> > CC: Alexander Duyck <alexander.duyck@gmail.com>
> > CC: Liang Chen <liangchen.linux@gmail.com>
> > CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> > CC: Guillaume Tucker <guillaume.tucker@collabora.com>
> > CC: Matthew Wilcox <willy@infradead.org>
> > CC: Linux-MM <linux-mm@kvack.org>
> > ---
> >  include/linux/mm_types.h        | 13 +------------
> >  include/net/page_pool/helpers.h | 20 ++++++++++++++------
> >  net/core/page_pool.c            | 14 +++++++++-----
> >  3 files changed, 24 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 36c5b43999e6..74b49c4c7a52 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -125,18 +125,7 @@ struct page {
> >                       struct page_pool *pp;
> >                       unsigned long _pp_mapping_pad;
> >                       unsigned long dma_addr;
> > -                     union {
> > -                             /**
> > -                              * dma_addr_upper: might require a 64-bit
> > -                              * value on 32-bit architectures.
> > -                              */
> > -                             unsigned long dma_addr_upper;
> > -                             /**
> > -                              * For frag page support, not supported in
> > -                              * 32-bit architectures with 64-bit DMA.
> > -                              */
> > -                             atomic_long_t pp_frag_count;
> > -                     };
> > +                     atomic_long_t pp_frag_count;
> >               };
> >               struct {        /* Tail pages of compound page */
> >                       unsigned long compound_head;    /* Bit zero is set */
>
> As noted by Jesper, since this is touching the super-critcal struct
> page, an explicit ack from the mm people is required.
>
> @Matthew: could you please have a look?
>
> I think it would be nice also an explicit ack from Jesper and/or Ilias.

I am trying! Unfortunately, it's this time of the year when I have to
travel a lot.  I'll be back in 15 days from now and I will be able to
have a look

Thanks and sorry for the delay
/Ilias

>
> Cheers,
>
> Paolo
>

