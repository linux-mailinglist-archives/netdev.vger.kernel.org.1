Return-Path: <netdev+bounces-55704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF0380C05A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 05:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B54280C67
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 04:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BDD1947F;
	Mon, 11 Dec 2023 04:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPB+fB03"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536B0DA
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 20:21:33 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-46603b0de2fso649041137.3
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 20:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702268492; x=1702873292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8/aEGODWLQyR+Ehqt9zVQlYBaFeN9s1x0j4MUOMfuY=;
        b=aPB+fB03P1mjYsUmPh+v1cgP1L+iI3kIry6eKGm6t3MGZ/PcdmAvmT9pTkWmw1ciot
         z9sLY57mJOLOoNHdK9CIeB6pnn9l2EbeBN7VZTkPlk6+tyJTbNyUm3mZ4/ztebF9bwdH
         MOcO76ILsXgQ0Iu6E2gVYalReZJRETqbmckRjemNJXhFT2VV3e0959HXwiZd0fpebgIc
         rjQVX7TYHKsmbj1YQlcb5S0FxMoTmw9kq0oKRup5+tyBZhbOAQvyAL+LT1J0QVzZ6Bl+
         Rw2iGuexqhb2lsWh+RysR4+hP4Lnut7BNkJ3wf3D0McYhWhzgBiElnsZpw3gATYPJuQ2
         H3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702268492; x=1702873292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8/aEGODWLQyR+Ehqt9zVQlYBaFeN9s1x0j4MUOMfuY=;
        b=tWZMXT1Q5/iSKAaeFOIoZxgkAn703F+7fV/tmPpApk21/MPN2Th4IsbG/lUXsRvznL
         abIrwV10zpmcViL4n4qy8v6UWHx+WSAt0lB7yMloOFyEtlA+AAmb489Wlxd5DCGhSsmW
         J2uh/ggrLgcIo+pSNMRE8cGYKtHoMUtpwO87hnHG+/0KLi/qdjTX5Pd3K13BlfGkxfZa
         qIOGjCIr7K7ptVnHVCknblHnDamE3TsWD/K5YcWwdZ7bIdpsfsBOwnzPAWxR3wPVKqkr
         AIyPN6YorQvIcOyQl+KpPIKpvQV+V7P52r5KfmVpefQ72r/PrfP9K4WJ0YoINQJK7Evg
         SBjg==
X-Gm-Message-State: AOJu0Yz2m7JgHtKnH932ibpBwb/RM3MvW2WUNHhzErR1vs+52mIJLwgW
	mziSoUvjEthRbZt8+8f/l0vxW+UiNp298sIIr1PjCg==
X-Google-Smtp-Source: AGHT+IEHw5pq3fytxwBk+eZGmvzRYn/8p+W9cVF0ENu6U7xeRe54oCpUeMlsmrnzh19Jo757GGewV5ZEfwxBhu8cAcE=
X-Received: by 2002:a05:6102:54a1:b0:464:84e4:fa70 with SMTP id
 bk33-20020a05610254a100b0046484e4fa70mr2257691vsb.24.1702268492207; Sun, 10
 Dec 2023 20:21:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206105419.27952-1-liangchen.linux@gmail.com>
 <20231206105419.27952-5-liangchen.linux@gmail.com> <CAHS8izNQeSwWQ9NwiDUcPoSX1WONG4JYu2rfpqF3+4xkxE=Wyw@mail.gmail.com>
 <CAKhg4t+LpF=G0DBhbuRYtxKyTrMiR3pSc15sY42kc57iGQfPmw@mail.gmail.com>
In-Reply-To: <CAKhg4t+LpF=G0DBhbuRYtxKyTrMiR3pSc15sY42kc57iGQfPmw@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 10 Dec 2023 20:21:21 -0800
Message-ID: <CAHS8izPpWZvOSswHP0n-_nBiUMw8Ay2iM4yFE-HZenHv51iBHA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 4/4] skbuff: Optimization of SKB coalescing
 for page pool
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	linyunsheng@huawei.com, netdev@vger.kernel.org, linux-mm@kvack.org, 
	jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 7:38=E2=80=AFPM Liang Chen <liangchen.linux@gmail.c=
om> wrote:
>
> On Sat, Dec 9, 2023 at 10:18=E2=80=AFAM Mina Almasry <almasrymina@google.=
com> wrote:
> >
> > On Wed, Dec 6, 2023 at 2:54=E2=80=AFAM Liang Chen <liangchen.linux@gmai=
l.com> wrote:
> > >
> > > In order to address the issues encountered with commit 1effe8ca4e34
> > > ("skbuff: fix coalescing for page_pool fragment recycling"), the
> > > combination of the following condition was excluded from skb coalesci=
ng:
> > >
> > > from->pp_recycle =3D 1
> > > from->cloned =3D 1
> > > to->pp_recycle =3D 1
> > >
> > > However, with page pool environments, the aforementioned combination =
can
> > > be quite common(ex. NetworkMananger may lead to the additional
> > > packet_type being registered, thus the cloning). In scenarios with a
> > > higher number of small packets, it can significantly affect the succe=
ss
> > > rate of coalescing. For example, considering packets of 256 bytes siz=
e,
> > > our comparison of coalescing success rate is as follows:
> > >
> > > Without page pool: 70%
> > > With page pool: 13%
> > >
> > > Consequently, this has an impact on performance:
> > >
> > > Without page pool: 2.57 Gbits/sec
> > > With page pool: 2.26 Gbits/sec
> > >
> > > Therefore, it seems worthwhile to optimize this scenario and enable
> > > coalescing of this particular combination. To achieve this, we need t=
o
> > > ensure the correct increment of the "from" SKB page's page pool
> > > reference count (pp_ref_count).
> > >
> > > Following this optimization, the success rate of coalescing measured =
in
> > > our environment has improved as follows:
> > >
> > > With page pool: 60%
> > >
> > > This success rate is approaching the rate achieved without using page
> > > pool, and the performance has also been improved:
> > >
> > > With page pool: 2.52 Gbits/sec
> > >
> > > Below is the performance comparison for small packets before and afte=
r
> > > this optimization. We observe no impact to packets larger than 4K.
> > >
> > > packet size     before      after       improved
> > > (bytes)         (Gbits/sec) (Gbits/sec)
> > > 128             1.19        1.27        7.13%
> > > 256             2.26        2.52        11.75%
> > > 512             4.13        4.81        16.50%
> > > 1024            6.17        6.73        9.05%
> > > 2048            14.54       15.47       6.45%
> > > 4096            25.44       27.87       9.52%
> > >
> > > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > > Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> > > Suggested-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  include/net/page_pool/helpers.h |  5 ++++
> > >  net/core/skbuff.c               | 41 +++++++++++++++++++++++--------=
--
> > >  2 files changed, 34 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/=
helpers.h
> > > index 9dc8eaf8a959..268bc9d9ffd3 100644
> > > --- a/include/net/page_pool/helpers.h
> > > +++ b/include/net/page_pool/helpers.h
> > > @@ -278,6 +278,11 @@ static inline long page_pool_unref_page(struct p=
age *page, long nr)
> > >         return ret;
> > >  }
> > >
> > > +static inline void page_pool_ref_page(struct page *page)
> > > +{
> > > +       atomic_long_inc(&page->pp_ref_count);
> > > +}
> > > +
> > >  static inline bool page_pool_is_last_ref(struct page *page)
> > >  {
> > >         /* If page_pool_unref_page() returns 0, we were the last user=
 */
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index 7e26b56cda38..3c2515a29376 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -947,6 +947,24 @@ static bool skb_pp_recycle(struct sk_buff *skb, =
void *data, bool napi_safe)
> > >         return napi_pp_put_page(virt_to_page(data), napi_safe);
> > >  }
> > >
> > > +/**
> > > + * skb_pp_frag_ref() - Increase fragment reference count of a page
> > > + * @page:      page of the fragment on which to increase a reference
> > > + *
> > > + * Increase fragment reference count (pp_ref_count) on a page, but i=
f it is
> > > + * not a page pool page, fallback to increase a reference(_refcount)=
 on a
> > > + * normal page.
> > > + */
> > > +static void skb_pp_frag_ref(struct page *page)
> > > +{
> > > +       struct page *head_page =3D compound_head(page);
> > > +
> > > +       if (likely(is_pp_page(head_page)))
> > > +               page_pool_ref_page(head_page);
> > > +       else
> > > +               page_ref_inc(head_page);
> > > +}
> > > +
> >
> > I am confused by this, why add a new helper instead of modifying the
> > existing helper, skb_frag_ref()?
> >
> > My mental model is that if the net stack wants to acquire a reference
> > on a frag, it calls skb_frag_ref(), and if it wants to drop a
> > reference on a frag, it should call skb_frag_unref(). Internally
> > skb_frag_ref/unref() can do all sorts of checking to decide whether to
> > increment page->refcount or page->pp_ref_count. I can't wrap my head
> > around the introduction of skb_pp_frag_ref(), but no equivalent
> > skb_pp_frag_unref().
> >
> > But even if skb_pp_frag_unref() was added, when should the net stack
> > use skb_frag_ref/unref, and when should the stack use
> > skb_pp_ref/unref? The docs currently describe what the function does,
> > but when a program unfamiliar with the page pool should use it.
> >
> > >  static void skb_kfree_head(void *head, unsigned int end_offset)
> > >  {
> > >         if (end_offset =3D=3D SKB_SMALL_HEAD_HEADROOM)
> > > @@ -5769,17 +5787,12 @@ bool skb_try_coalesce(struct sk_buff *to, str=
uct sk_buff *from,
> > >                 return false;
> > >
> > >         /* In general, avoid mixing page_pool and non-page_pool alloc=
ated
> > > -        * pages within the same SKB. Additionally avoid dealing with=
 clones
> > > -        * with page_pool pages, in case the SKB is using page_pool f=
ragment
> > > -        * references (page_pool_alloc_frag()). Since we only take fu=
ll page
> > > -        * references for cloned SKBs at the moment that would result=
 in
> > > -        * inconsistent reference counts.
> > > -        * In theory we could take full references if @from is cloned=
 and
> > > -        * !@to->pp_recycle but its tricky (due to potential race wit=
h
> > > -        * the clone disappearing) and rare, so not worth dealing wit=
h.
> > > +        * pages within the same SKB. In theory we could take full
> > > +        * references if @from is cloned and !@to->pp_recycle but its
> > > +        * tricky (due to potential race with the clone disappearing)=
 and
> > > +        * rare, so not worth dealing with.
> > >          */
> > > -       if (to->pp_recycle !=3D from->pp_recycle ||
> > > -           (from->pp_recycle && skb_cloned(from)))
> > > +       if (to->pp_recycle !=3D from->pp_recycle)
> > >                 return false;
> > >
> > >         if (len <=3D skb_tailroom(to)) {
> > > @@ -5836,8 +5849,12 @@ bool skb_try_coalesce(struct sk_buff *to, stru=
ct sk_buff *from,
> > >         /* if the skb is not cloned this does nothing
> > >          * since we set nr_frags to 0.
> > >          */
> > > -       for (i =3D 0; i < from_shinfo->nr_frags; i++)
> > > -               __skb_frag_ref(&from_shinfo->frags[i]);
> > > +       if (from->pp_recycle)
> > > +               for (i =3D 0; i < from_shinfo->nr_frags; i++)
> > > +                       skb_pp_frag_ref(skb_frag_page(&from_shinfo->f=
rags[i]));
> > > +       else
> > > +               for (i =3D 0; i < from_shinfo->nr_frags; i++)
> > > +                       __skb_frag_ref(&from_shinfo->frags[i]);
> >
> > You added a check here to use skb_pp_frag_ref() instead of
> > skb_frag_ref() here, but it's not clear to me why other callsites of
> > skb_frag_ref() don't need to be modified in the same way after your
> > patch.
> >
> > After your patch:
> >
> > skb_frag_ref() will always increment page->_refcount
> > skb_frag_unref() will either decrement page->_refcount or decrement
> > page->pp_ref_count (depending on the value of skb->pp_recycle).
> > skb_pp_frag_ref() will either increment page->_refcount or increment
> > page->pp_ref_count (depending on the value of is_pp_page(), not
> > skb->pp_recycle).
> > skb_pp_frag_unref() doesn't exist.
> >
> > Is this not confusing? Can we streamline things:
> >
> > skb_frag_ref() increments page->pp_ref_count for skb->pp_recycle,
> > page->_refcount otherwise.
> > skb_frag_unref() decrement page->pp_ref_count for skb->pp_recycle,
> > page->_refcount otherwise.
> >
> > Or am I missing something that causes us to require this asymmetric
> > reference counting?
> >
>
> This idea was previously implemented, as shown here:
> https://lore.kernel.org/all/20211009093724.10539-5-linyunsheng@huawei.com=
/.
> But implementing this would result in some unnecessary overhead, since
> currently, 'skb_try_coalesce' is the only place where the page pool
> reference count for skb frag might be increased. I would prefer to
> move the logic to '__skb_frag_ref' when such a need becomes more
> common. Thanks!
>

Is it possible/desirable to add a comment to skb_frag_ref() that it
should not be used with skb->pp_recycle? At least I was tripped by
this, but maybe it's considered obvious somehow.

But I feel like this maybe needs to be fixed. Why does the page_pool
need a separate page->pp_ref_count? Why not use page->_refcount like
the rest of the code? Is there a history here behind this decision
that you can point me to? It seems to me that
incrementing/decrementing page->pp_ref_count may be equivalent to
doing the same on page->_refcount.

> > >
> > >         to->truesize +=3D delta;
> > >         to->len +=3D len;
> > > --
> > > 2.31.1
> > >
> > >
> >
> >
> > --
> > Thanks,
> > Mina



--=20
Thanks,
Mina

