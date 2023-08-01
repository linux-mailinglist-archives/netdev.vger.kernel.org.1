Return-Path: <netdev+bounces-23377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378BB76BBC1
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 19:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196F01C20F3D
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BFB23598;
	Tue,  1 Aug 2023 17:56:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B5722F16
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 17:56:42 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D7F1BF6
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:56:41 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-63cfd68086dso32639746d6.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690912600; x=1691517400;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5cW6jpJRgieq69HBvmKugIojz2p+E1PIS20Prvk8wk=;
        b=YmdOBL1j8PeUJAI/qUq4dBkqFfoFSZNL/e7aNkWDuUyW9CApOzbV+6mxdRhMXGSeZb
         eQAPR+PpozQzetRMhJznG0HtL+yAznrW10zhxWk5gTQCaAtWoQsB0cz44/+LR48Q9j2A
         2Z95M6LyW1HK4lYhnK/jj3RTi4BQN2KTOIJ2k13I9c3BeE9ceOJO4F724c+uLdYZXQtK
         c7ppZJIz5+/zhYultDlSTXezivqqyzotq5sKDndJAT47pT7JLPqodI9YLvgGE4VURtyi
         MH5M+Pj27bnHf2n2GBXeKFRuG2axswEzGNy1HU2qISDL1n5nwM5tmhDdGGdqevLqwXOF
         17dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690912600; x=1691517400;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O5cW6jpJRgieq69HBvmKugIojz2p+E1PIS20Prvk8wk=;
        b=dIwuZy9peKqaOeH3JMC43Lytr9OhCgLBr5Bcv0+TQj+6WY+ONppqfIuCSO03Oz0kZ+
         eTVEE5wHRMMDfZJvtkO+JBnstUd1iVbf3ljxXFTcr6NDOH7tBrxhUoDFQl4WJEKBCQse
         oIyyGkOVplYI1l3O77uQ6+BBSzMZGz2OVpoYdVyMF+Mh//R4ljl3DjE31MqnMyPCTXIM
         /ncDpByzTp6HQCtZ30+RpC9dFz+1W7tiLT3soUhSdt0gAIzDMjbqNtmUXom3taD2VcVG
         U1r7LNJefg/WSOa1X6UsBYFkb4zeBkrCd0+8rBM0h/EZO0crnZQRQePxN1m3LXFLhs8L
         xL8A==
X-Gm-Message-State: ABy/qLZnRrqsaoOgK4BpTiTeSYz2tUP4YDO1QO+8abGW7C+AlTiUYJ6+
	zTRCY+aeRm5ldfmJO+mNCRA=
X-Google-Smtp-Source: APBJJlEUQHgRq/iuHnndnDa61GGuPH1zZEFLYhVjTlbwzRkLqAtDzAgb43N9snhwU+92AEibL2/IMQ==
X-Received: by 2002:a05:6214:5ecc:b0:63c:ef88:f8f2 with SMTP id mn12-20020a0562145ecc00b0063cef88f8f2mr12411150qvb.32.1690912600097;
        Tue, 01 Aug 2023 10:56:40 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id i6-20020a0cab46000000b0063cdcd5699csm4857756qvb.118.2023.08.01.10.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:56:39 -0700 (PDT)
Date: Tue, 01 Aug 2023 13:56:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Tahsin Erdogan <trdgn@amazon.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com
Message-ID: <64c947578a8c7_1c9eb8294e6@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANn89iJwP_Ar57Te0EG2fAjM=JNL+N0mYwnEZDrJME4nhe4WTg@mail.gmail.com>
References: <20230801135455.268935-1-edumazet@google.com>
 <20230801135455.268935-2-edumazet@google.com>
 <64c9285b927f8_1c2791294e4@willemb.c.googlers.com.notmuch>
 <CANn89iJwP_Ar57Te0EG2fAjM=JNL+N0mYwnEZDrJME4nhe4WTg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] net: allow alloc_skb_with_frags() to
 allocate bigger packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eric Dumazet wrote:
> On Tue, Aug 1, 2023 at 5:44=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Eric Dumazet wrote:
> > > Refactor alloc_skb_with_frags() to allow bigger packets allocations=
.
> > >
> > > Instead of assuming that only order-0 allocations will be attempted=
,
> > > use the caller supplied max order.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Cc: Tahsin Erdogan <trdgn@amazon.com>
> > > ---
> > >  net/core/skbuff.c | 56 +++++++++++++++++++++----------------------=
----
> > >  1 file changed, 25 insertions(+), 31 deletions(-)
> > >
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index a298992060e6efdecb87c7ffc8290eafe330583f..0ac70a0144a7c1f4e78=
24ddc19980aee73e4c121 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -6204,7 +6204,7 @@ EXPORT_SYMBOL_GPL(skb_mpls_dec_ttl);
> > >   *
> > >   * @header_len: size of linear part
> > >   * @data_len: needed length in frags
> > > - * @max_page_order: max page order desired.
> > > + * @order: max page order desired.
> > >   * @errcode: pointer to error code if any
> > >   * @gfp_mask: allocation mask
> > >   *
> > > @@ -6212,21 +6212,17 @@ EXPORT_SYMBOL_GPL(skb_mpls_dec_ttl);
> > >   */
> > >  struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
> > >                                    unsigned long data_len,
> > > -                                  int max_page_order,
> > > +                                  int order,
> > >                                    int *errcode,
> > >                                    gfp_t gfp_mask)
> > >  {
> > > -     int npages =3D (data_len + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
> > >       unsigned long chunk;
> > >       struct sk_buff *skb;
> > >       struct page *page;
> > > -     int i;
> > > +     int nr_frags =3D 0;
> > >
> > >       *errcode =3D -EMSGSIZE;
> > > -     /* Note this test could be relaxed, if we succeed to allocate=

> > > -      * high order pages...
> > > -      */
> > > -     if (npages > MAX_SKB_FRAGS)
> > > +     if (unlikely(data_len > MAX_SKB_FRAGS * (PAGE_SIZE << order))=
)
> > >               return NULL;
> > >
> > >       *errcode =3D -ENOBUFS;
> > > @@ -6234,34 +6230,32 @@ struct sk_buff *alloc_skb_with_frags(unsign=
ed long header_len,
> > >       if (!skb)
> > >               return NULL;
> > >
> > > -     skb->truesize +=3D npages << PAGE_SHIFT;
> > > -
> > > -     for (i =3D 0; npages > 0; i++) {
> > > -             int order =3D max_page_order;
> > > -
> > > -             while (order) {
> > > -                     if (npages >=3D 1 << order) {
> > > -                             page =3D alloc_pages((gfp_mask & ~__G=
FP_DIRECT_RECLAIM) |
> > > -                                                __GFP_COMP |
> > > -                                                __GFP_NOWARN,
> > > -                                                order);
> > > -                             if (page)
> > > -                                     goto fill_page;
> > > -                             /* Do not retry other high order allo=
cations */
> >
> > Is this heuristic to only try one type of compound pages and else
> > fall back onto regular pages still relevant? I don't know the story
> > behind it.
> =

> I keep doing high-order attempts without direct reclaim,
> they should be fine and we eventually fallback to order-2 pages
> if we have plenty of them.
> =

> Immediate fallback to order-0 seems pessimistic.
> =

> >
> > > -                             order =3D 1;
> > > -                             max_page_order =3D 0;
> > > -                     }
> > > +     while (data_len) {
> > > +             if (nr_frags =3D=3D MAX_SKB_FRAGS - 1)
> > > +                     goto failure;
> > > +             while (order && data_len < (PAGE_SIZE << order))
> > >                       order--;
> >
> > Why decrement order on every iteration through the loop, not just whe=
n
> > alloc_pages fails?
> =

> Say we enter the function with initial @data_len =3D=3D 4000, and @orde=
r=3D=3D3
> =

> We do not want to allocate/waste an order-3 page (32768 bytes on x86)
> while an order-0 one should be good enough to fit the expected
> payload.
> =

> Same story if initial data_len =3D 33000:
> - We should allocate one order-3 page, and one order-0 one, instead of
> two order-3 pages.

Thanks for the explanation. For @data_len =3D=3D 5000, you would want to
allocate an order-1?




