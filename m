Return-Path: <netdev+bounces-23337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374D876B9AE
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 18:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DAE1C2102E
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564304DC89;
	Tue,  1 Aug 2023 16:33:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BFC2358A
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 16:33:27 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20301BF8
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 09:33:25 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40a47e8e38dso327921cf.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690907605; x=1691512405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0pm/7mSEFM6SAPSjQtcSWVtcTtB7ZoI4+6ojzh/1PA=;
        b=1Ikx9CWoeNwhRyUBm552J4cz0WHeCemYLNjewa+Jw9iHVHpFZfVOfY3YGio1C6kgaB
         mctfcJEqa2KWhBvBK9vA20uB+b8wqsZTNlyhgQb3z+NZcE/QYSuwxVZIx1ZAFMht/ClM
         PB4choMgnMEd1uUNsfcoLxpUM/lySGZ5vY+e8GPxPxKo6h6G0v6zkaAh7RFEh2lq54+O
         jiJzFL1rW71GaFqJb0rThcjKxa0H7PAnGsAMnFgqJhC0djjIPrxBke4xUJXa2z2PgiVz
         LCTgCHQ2PEu/TiW+7ylOJ/rRFB1YKrNcWt/6x3w7+mAv5QM8r+hzGyd5Mc56ImSXLDho
         14Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690907605; x=1691512405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0pm/7mSEFM6SAPSjQtcSWVtcTtB7ZoI4+6ojzh/1PA=;
        b=M2KAqRRcoigPI+6D2QczaLOmSA8ZzzJGKqW4En5TXhJz+yHHXTKQLncZasfr6MnZS6
         6MbdGr5YOV/uCUQoRTC3Cr+m6vXvbTerGq+ute0bWXYeRMq9VbYKJmYiAjTSKFeIfBTw
         NI6QiWrIA4AbDfvvGl+h39Cijxhd0liz3vkX8qUj8eqL6vnVoRSHuTDjNbAyslSl55mZ
         Pu8OWuFMdP+ikbiJBqHB9kwofEQmK/mCO6WCmmo3PPSC9E867qEP6DDKpIXgCHNdluUg
         m7+ApNlOQn3YO+RJ238s38L8oMER2pPakeD4mHneXYfZqO2u2HV64bQWX246X/CFG0nz
         +QoQ==
X-Gm-Message-State: ABy/qLbTBWSUX7Rr8Juwcuz6QxKuIF9t8xACb7wo0t5Bn/tIymvjkGla
	pFEbfvZSAxrs76GHG4hLnfRb2cCS5Wdh7gdVliYfuw==
X-Google-Smtp-Source: APBJJlFBFBMLV1K+ohpofhSw34qK/PGOlAXVGMjKewOTXtdw3qyfzpJQiu7zf1xEh/iLy5JujiFdddgIAjC1lKS0vlE=
X-Received: by 2002:a05:622a:104d:b0:403:9572:e37f with SMTP id
 f13-20020a05622a104d00b004039572e37fmr701160qte.22.1690907604509; Tue, 01 Aug
 2023 09:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801135455.268935-1-edumazet@google.com> <20230801135455.268935-2-edumazet@google.com>
 <64c9285b927f8_1c2791294e4@willemb.c.googlers.com.notmuch>
In-Reply-To: <64c9285b927f8_1c2791294e4@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Aug 2023 18:33:13 +0200
Message-ID: <CANn89iJwP_Ar57Te0EG2fAjM=JNL+N0mYwnEZDrJME4nhe4WTg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] net: allow alloc_skb_with_frags() to
 allocate bigger packets
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Tahsin Erdogan <trdgn@amazon.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 5:44=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > Refactor alloc_skb_with_frags() to allow bigger packets allocations.
> >
> > Instead of assuming that only order-0 allocations will be attempted,
> > use the caller supplied max order.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Tahsin Erdogan <trdgn@amazon.com>
> > ---
> >  net/core/skbuff.c | 56 +++++++++++++++++++++--------------------------
> >  1 file changed, 25 insertions(+), 31 deletions(-)
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index a298992060e6efdecb87c7ffc8290eafe330583f..0ac70a0144a7c1f4e7824dd=
c19980aee73e4c121 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -6204,7 +6204,7 @@ EXPORT_SYMBOL_GPL(skb_mpls_dec_ttl);
> >   *
> >   * @header_len: size of linear part
> >   * @data_len: needed length in frags
> > - * @max_page_order: max page order desired.
> > + * @order: max page order desired.
> >   * @errcode: pointer to error code if any
> >   * @gfp_mask: allocation mask
> >   *
> > @@ -6212,21 +6212,17 @@ EXPORT_SYMBOL_GPL(skb_mpls_dec_ttl);
> >   */
> >  struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
> >                                    unsigned long data_len,
> > -                                  int max_page_order,
> > +                                  int order,
> >                                    int *errcode,
> >                                    gfp_t gfp_mask)
> >  {
> > -     int npages =3D (data_len + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
> >       unsigned long chunk;
> >       struct sk_buff *skb;
> >       struct page *page;
> > -     int i;
> > +     int nr_frags =3D 0;
> >
> >       *errcode =3D -EMSGSIZE;
> > -     /* Note this test could be relaxed, if we succeed to allocate
> > -      * high order pages...
> > -      */
> > -     if (npages > MAX_SKB_FRAGS)
> > +     if (unlikely(data_len > MAX_SKB_FRAGS * (PAGE_SIZE << order)))
> >               return NULL;
> >
> >       *errcode =3D -ENOBUFS;
> > @@ -6234,34 +6230,32 @@ struct sk_buff *alloc_skb_with_frags(unsigned l=
ong header_len,
> >       if (!skb)
> >               return NULL;
> >
> > -     skb->truesize +=3D npages << PAGE_SHIFT;
> > -
> > -     for (i =3D 0; npages > 0; i++) {
> > -             int order =3D max_page_order;
> > -
> > -             while (order) {
> > -                     if (npages >=3D 1 << order) {
> > -                             page =3D alloc_pages((gfp_mask & ~__GFP_D=
IRECT_RECLAIM) |
> > -                                                __GFP_COMP |
> > -                                                __GFP_NOWARN,
> > -                                                order);
> > -                             if (page)
> > -                                     goto fill_page;
> > -                             /* Do not retry other high order allocati=
ons */
>
> Is this heuristic to only try one type of compound pages and else
> fall back onto regular pages still relevant? I don't know the story
> behind it.

I keep doing high-order attempts without direct reclaim,
they should be fine and we eventually fallback to order-2 pages
if we have plenty of them.

Immediate fallback to order-0 seems pessimistic.

>
> > -                             order =3D 1;
> > -                             max_page_order =3D 0;
> > -                     }
> > +     while (data_len) {
> > +             if (nr_frags =3D=3D MAX_SKB_FRAGS - 1)
> > +                     goto failure;
> > +             while (order && data_len < (PAGE_SIZE << order))
> >                       order--;
>
> Why decrement order on every iteration through the loop, not just when
> alloc_pages fails?

Say we enter the function with initial @data_len =3D=3D 4000, and @order=3D=
=3D3

We do not want to allocate/waste an order-3 page (32768 bytes on x86)
while an order-0 one should be good enough to fit the expected
payload.

Same story if initial data_len =3D 33000:
- We should allocate one order-3 page, and one order-0 one, instead of
two order-3 pages.

