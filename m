Return-Path: <netdev+bounces-50555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 690847F6180
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC7A3B21479
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD05033079;
	Thu, 23 Nov 2023 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZF4ph6+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDA6D4A
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 06:30:48 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548d67d30bbso1430484a12.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 06:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700749846; x=1701354646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI29TqTKej4lf3cUYmz69Bg9cqaGxciaGgk9rREOFK0=;
        b=LZF4ph6+kiwazHdDzzFV50+I/n+3Wg64iEq6hGQ7y+oqcddGePeb9EGJpcj6P2BlzC
         wuIygbT5Kb5/J5XhotcFGoqLyzJMGumJ47mx4h43lrpTbgEdl57bCRFI9ajnABy7t6cs
         Q26PLEiFCDPo+B4RA2Iq4aZ/x8Ty1lFy8JgzExsK9qso/KrIKRHvBPvG4Jg3gzXUnRG0
         Pt+qjUE5nv5hGZ5huZDJoygx7eDZW0dx+/pSsrBSYvkJMLMC+i0oweSJVQ0Y+ORh0bII
         Y1Fbed38jbgXu4fhDw+20RhEqfJbNF4eSdaZcjc8UttnKlm9nGOxhG1AHSOsUWve7HFN
         xYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700749846; x=1701354646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GI29TqTKej4lf3cUYmz69Bg9cqaGxciaGgk9rREOFK0=;
        b=kHTb2v1WAVqmsXc3WbE1Pg7+Ktay9YS7dxD7quv3YBwZbhbOZepNDCvs5c33zlQhmL
         s3NTWl+E5NQK9dk8xNb9H/H8PKg2l285RDemJR21/82mblwER84wueMb69yYxeVlzt1K
         tj+3yzmxy2jCFsD+6KsSSHAE5Za7oiAPfZFjHskhmtxQdKO8vg5A+PR1O89Xexb1Dwvr
         knsYcI9BqPABS8XZKh9QUo2T39/dC7/iBHGNPJcezC5MDqiehMWm2xeeyN6XuIjarhg6
         Qe32vEBpHuph+c24fz2Dqze5lwfN8jNMIY2G7h5iOc8IgOpB8+vXiTeBRJHTtct5QDSM
         CxpA==
X-Gm-Message-State: AOJu0YzCUCBlLhukaE8sUqKCd0AnUe62+a3VMDZl6fiJn9gWYDfXBl1j
	qDoPC3j5FS7+QBqjuSFgrjk7zf6UCl23K1Fhya0=
X-Google-Smtp-Source: AGHT+IFcIlU0S4fkluh8TUF6nmbd3M6B/7WfiZsJ5hhTPxeHU3IzIM4DT/7XbJe865AelliKu3TAAfTzqXqvuFaIlHs=
X-Received: by 2002:a17:906:f46:b0:a02:b538:172a with SMTP id
 h6-20020a1709060f4600b00a02b538172amr3734159ejj.56.1700749846231; Thu, 23 Nov
 2023 06:30:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123022516.6757-1-liangchen.linux@gmail.com> <2198afb3-4eaf-f41b-d58d-a7585f308c8c@huawei.com>
In-Reply-To: <2198afb3-4eaf-f41b-d58d-a7585f308c8c@huawei.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Thu, 23 Nov 2023 22:30:33 +0800
Message-ID: <CAKhg4t+cR=S38_6bYEt=N+Hqp9PV0oxkiMpe9X2y=t9iiqr0OQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] page_pool: Rename pp_frag_count to pp_ref_count
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	netdev@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 2:18=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/11/23 10:25, Liang Chen wrote:
> > To support multiple users referencing the same fragment, pp_frag_count =
is
> > renamed to pp_ref_count to better reflect its actual meaning based on t=
he
> > suggestion from [1].
>
> The renaming looks good to me, some minor nit.
>
> It is good to add a cover-letter using 'git format-patch --cover-letter'
> to explain the overall background or modifications this patchset make whe=
n
> there is more than one patch.
>

Thanks for the suggestion. A cover-letter will be provided for the next ver=
sion.
> >
> > [1]
> > http://lore.kernel.org/netdev/f71d9448-70c8-8793-dc9a-0eb48a570300@huaw=
ei.com
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >  include/linux/mm_types.h        |  2 +-
> >  include/net/page_pool/helpers.h | 31 ++++++++++++++++++-------------
> >  2 files changed, 19 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 957ce38768b2..64e4572ef06d 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -125,7 +125,7 @@ struct page {
> >                       struct page_pool *pp;
> >                       unsigned long _pp_mapping_pad;
> >                       unsigned long dma_addr;
> > -                     atomic_long_t pp_frag_count;
> > +                     atomic_long_t pp_ref_count;
>
> It seems that we may have 4 bytes available for 64 bit arch if we change
> the 'atomic_long_t' to 'refcount_t':)
>
> >               };
> >               struct {        /* Tail pages of compound page */
> >                       unsigned long compound_head;    /* Bit zero is se=
t */
> > diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/he=
lpers.h
> > index 4ebd544ae977..a6dc9412c9ae 100644
> > --- a/include/net/page_pool/helpers.h
> > +++ b/include/net/page_pool/helpers.h
> > @@ -29,7 +29,7 @@
> >   * page allocated from page pool. Page splitting enables memory saving=
 and thus
> >   * avoids TLB/cache miss for data access, but there also is some cost =
to
> >   * implement page splitting, mainly some cache line dirtying/bouncing =
for
> > - * 'struct page' and atomic operation for page->pp_frag_count.
> > + * 'struct page' and atomic operation for page->pp_ref_count.
> >   *
> >   * The API keeps track of in-flight pages, in order to let API users k=
now when
> >   * it is safe to free a page_pool object, the API users must call
> > @@ -214,61 +214,66 @@ inline enum dma_data_direction page_pool_get_dma_=
dir(struct page_pool *pool)
> >       return pool->p.dma_dir;
> >  }
> >
> > -/* pp_frag_count represents the number of writers who can update the p=
age
> > +/* pp_ref_count represents the number of writers who can update the pa=
ge
> >   * either by updating skb->data or via DMA mappings for the device.
> >   * We can't rely on the page refcnt for that as we don't know who migh=
t be
> >   * holding page references and we can't reliably destroy or sync DMA m=
appings
> >   * of the fragments.
> >   *
> > - * When pp_frag_count reaches 0 we can either recycle the page if the =
page
> > + * pp_ref_count initially corresponds to the number of fragments. Howe=
ver,
> > + * when multiple users start to reference a single fragment, for examp=
le in
> > + * skb_try_coalesce, the pp_ref_count will become greater than the num=
ber of
> > + * fragments.
> > + *
> > + * When pp_ref_count reaches 0 we can either recycle the page if the p=
age
> >   * refcnt is 1 or return it back to the memory allocator and destroy a=
ny
> >   * mappings we have.
> >   */
> >  static inline void page_pool_fragment_page(struct page *page, long nr)
> >  {
> > -     atomic_long_set(&page->pp_frag_count, nr);
> > +     atomic_long_set(&page->pp_ref_count, nr);
> >  }
> >
> >  static inline long page_pool_defrag_page(struct page *page, long nr)
> >  {
> >       long ret;
> >
> > -     /* If nr =3D=3D pp_frag_count then we have cleared all remaining
> > +     /* If nr =3D=3D pp_ref_count then we have cleared all remaining
> >        * references to the page:
> >        * 1. 'n =3D=3D 1': no need to actually overwrite it.
> >        * 2. 'n !=3D 1': overwrite it with one, which is the rare case
> > -      *              for pp_frag_count draining.
> > +      *              for pp_ref_count draining.
> >        *
> >        * The main advantage to doing this is that not only we avoid a a=
tomic
> >        * update, as an atomic_read is generally a much cheaper operatio=
n than
> >        * an atomic update, especially when dealing with a page that may=
 be
> > -      * partitioned into only 2 or 3 pieces; but also unify the pp_fra=
g_count
> > +      * partitioned into only 2 or 3 pieces; but also unify the pp_ref=
_count
>
> Maybe "referenced by only 2 or 3 users" is more appropriate now?
>

Sure.
> >        * handling by ensuring all pages have partitioned into only 1 pi=
ece
> >        * initially, and only overwrite it when the page is partitioned =
into
> >        * more than one piece.
> >        */
> > -     if (atomic_long_read(&page->pp_frag_count) =3D=3D nr) {
> > +     if (atomic_long_read(&page->pp_ref_count) =3D=3D nr) {
> >               /* As we have ensured nr is always one for constant case =
using
> >                * the BUILD_BUG_ON(), only need to handle the non-consta=
nt case
> > -              * here for pp_frag_count draining, which is a rare case.
> > +              * here for pp_ref_count draining, which is a rare case.
> >                */
> >               BUILD_BUG_ON(__builtin_constant_p(nr) && nr !=3D 1);
> >               if (!__builtin_constant_p(nr))
> > -                     atomic_long_set(&page->pp_frag_count, 1);
> > +                     atomic_long_set(&page->pp_ref_count, 1);
> >
> >               return 0;
> >       }
> >
> > -     ret =3D atomic_long_sub_return(nr, &page->pp_frag_count);
> > +     ret =3D atomic_long_sub_return(nr, &page->pp_ref_count);
> >       WARN_ON(ret < 0);
> >
> > -     /* We are the last user here too, reset pp_frag_count back to 1 t=
o
> > +     /* We are the last user here too, reset pp_ref_count back to 1 to
> >        * ensure all pages have been partitioned into 1 piece initially,
> >        * this should be the rare case when the last two fragment users =
call
> >        * page_pool_defrag_page() currently.
>
> Do we need to rename the page_pool_defrag_page() and page_pool_is_last_fr=
ag()
> too?
>

Yeah, I think so. Once a pp page is drained, its management shifts to
being primarily governed by pp_ref_count, and there's no longer a need
to consider fragmenting. will be done in the next iteration.
> >        */
> >       if (unlikely(!ret))
> > -             atomic_long_set(&page->pp_frag_count, 1);
> > +             atomic_long_set(&page->pp_ref_count, 1);
> >
> >       return ret;
> >  }
> >

