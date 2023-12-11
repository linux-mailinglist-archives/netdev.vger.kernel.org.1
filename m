Return-Path: <netdev+bounces-55696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2816380C019
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 04:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9392B1F21016
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 03:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2E168D5;
	Mon, 11 Dec 2023 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLqVpK9u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1067C121
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 19:38:39 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a00c200782dso528655666b.1
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 19:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702265917; x=1702870717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7O1esqpdTStbI1MKxaKI+ohkzTfVXxZH1J+nUtT3YM=;
        b=hLqVpK9uqZrJN7M0mNqUTmswJrVirpUUh3spj1YGkqszQH3EyXNoTXlg0AGnjj3BzB
         AzLJA5qOBta811SRqL7HGVNkrLTex7VVI+eVGsR+oB0SrRkI2q11kuzHQvoMN6KBDVN2
         f0PbH66R9itPWWxIk0BuSpeTFOOSFgsEFEUUcIEKYv1qZYq8lLilTWGXXv3rCIQ1M8M7
         O4JjAd0oARo+zQlNJzHxJ8ATMcylsiYbZgnfjAtynSZ5wHwNkUGU77wJC7hZl9/gw6jL
         kos7UF8+Co0zPOxRC9+8+jtaK2PSjc/Rq2lTmhS+tEn6CdUvbcES3wLeS7xa8eTbXYe2
         jQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702265917; x=1702870717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7O1esqpdTStbI1MKxaKI+ohkzTfVXxZH1J+nUtT3YM=;
        b=l55CjgbgLOyVKdfXUlEP9SFGy04AM+vxQZag8o/damQvs+bepuI5jRM1Yjyy5r3aAF
         dbXKxwW4/CV3rlI7QkSlpVQLJQIxil4Nrk6U8zR6/SoMq7FT1C+NJA3Zd0nY46YBtTpx
         neNwOArtAjINzxbevDY45J17UECAX47TYzx2Yg4n6p+rvQN+SOPhG+HkoyGVOp3TTFeQ
         6NEb+CDjABKROPyFAisdK/+moBrrYPWd0xWlxUfBWNZ7bCk+XEc1b+BTyJfO3Ujm/6wA
         FSzXy7LYdwkre1JhiDGCc0yga0WrapzpU50pNc0GX77OQFZPQtURva3mPNo64RpPWfo8
         tQyw==
X-Gm-Message-State: AOJu0YxVa9TkR45jDpszd6lAs2o6t6AQWe8Vq0zZ1ymWNqO2SCT/y6MB
	mbS+a25JwG4RiKkNhQFhygAKSCXpFjc0/Xhj1pM=
X-Google-Smtp-Source: AGHT+IFT//uYgxvOcwEL10srNQCEJ9a/EG4Bf14+fDpxBRIKwhcfRtu58/ge/qc+usbqj5PDostnbVBH/JpPeOgrJbE=
X-Received: by 2002:a17:907:720a:b0:a19:d40a:d252 with SMTP id
 dr10-20020a170907720a00b00a19d40ad252mr1435630ejc.286.1702265917002; Sun, 10
 Dec 2023 19:38:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206105419.27952-1-liangchen.linux@gmail.com>
 <20231206105419.27952-5-liangchen.linux@gmail.com> <CAHS8izNQeSwWQ9NwiDUcPoSX1WONG4JYu2rfpqF3+4xkxE=Wyw@mail.gmail.com>
In-Reply-To: <CAHS8izNQeSwWQ9NwiDUcPoSX1WONG4JYu2rfpqF3+4xkxE=Wyw@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Mon, 11 Dec 2023 11:38:24 +0800
Message-ID: <CAKhg4t+LpF=G0DBhbuRYtxKyTrMiR3pSc15sY42kc57iGQfPmw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 4/4] skbuff: Optimization of SKB coalescing
 for page pool
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	linyunsheng@huawei.com, netdev@vger.kernel.org, linux-mm@kvack.org, 
	jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 10:18=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Wed, Dec 6, 2023 at 2:54=E2=80=AFAM Liang Chen <liangchen.linux@gmail.=
com> wrote:
> >
> > In order to address the issues encountered with commit 1effe8ca4e34
> > ("skbuff: fix coalescing for page_pool fragment recycling"), the
> > combination of the following condition was excluded from skb coalescing=
:
> >
> > from->pp_recycle =3D 1
> > from->cloned =3D 1
> > to->pp_recycle =3D 1
> >
> > However, with page pool environments, the aforementioned combination ca=
n
> > be quite common(ex. NetworkMananger may lead to the additional
> > packet_type being registered, thus the cloning). In scenarios with a
> > higher number of small packets, it can significantly affect the success
> > rate of coalescing. For example, considering packets of 256 bytes size,
> > our comparison of coalescing success rate is as follows:
> >
> > Without page pool: 70%
> > With page pool: 13%
> >
> > Consequently, this has an impact on performance:
> >
> > Without page pool: 2.57 Gbits/sec
> > With page pool: 2.26 Gbits/sec
> >
> > Therefore, it seems worthwhile to optimize this scenario and enable
> > coalescing of this particular combination. To achieve this, we need to
> > ensure the correct increment of the "from" SKB page's page pool
> > reference count (pp_ref_count).
> >
> > Following this optimization, the success rate of coalescing measured in
> > our environment has improved as follows:
> >
> > With page pool: 60%
> >
> > This success rate is approaching the rate achieved without using page
> > pool, and the performance has also been improved:
> >
> > With page pool: 2.52 Gbits/sec
> >
> > Below is the performance comparison for small packets before and after
> > this optimization. We observe no impact to packets larger than 4K.
> >
> > packet size     before      after       improved
> > (bytes)         (Gbits/sec) (Gbits/sec)
> > 128             1.19        1.27        7.13%
> > 256             2.26        2.52        11.75%
> > 512             4.13        4.81        16.50%
> > 1024            6.17        6.73        9.05%
> > 2048            14.54       15.47       6.45%
> > 4096            25.44       27.87       9.52%
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> > Suggested-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  include/net/page_pool/helpers.h |  5 ++++
> >  net/core/skbuff.c               | 41 +++++++++++++++++++++++----------
> >  2 files changed, 34 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/he=
lpers.h
> > index 9dc8eaf8a959..268bc9d9ffd3 100644
> > --- a/include/net/page_pool/helpers.h
> > +++ b/include/net/page_pool/helpers.h
> > @@ -278,6 +278,11 @@ static inline long page_pool_unref_page(struct pag=
e *page, long nr)
> >         return ret;
> >  }
> >
> > +static inline void page_pool_ref_page(struct page *page)
> > +{
> > +       atomic_long_inc(&page->pp_ref_count);
> > +}
> > +
> >  static inline bool page_pool_is_last_ref(struct page *page)
> >  {
> >         /* If page_pool_unref_page() returns 0, we were the last user *=
/
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 7e26b56cda38..3c2515a29376 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -947,6 +947,24 @@ static bool skb_pp_recycle(struct sk_buff *skb, vo=
id *data, bool napi_safe)
> >         return napi_pp_put_page(virt_to_page(data), napi_safe);
> >  }
> >
> > +/**
> > + * skb_pp_frag_ref() - Increase fragment reference count of a page
> > + * @page:      page of the fragment on which to increase a reference
> > + *
> > + * Increase fragment reference count (pp_ref_count) on a page, but if =
it is
> > + * not a page pool page, fallback to increase a reference(_refcount) o=
n a
> > + * normal page.
> > + */
> > +static void skb_pp_frag_ref(struct page *page)
> > +{
> > +       struct page *head_page =3D compound_head(page);
> > +
> > +       if (likely(is_pp_page(head_page)))
> > +               page_pool_ref_page(head_page);
> > +       else
> > +               page_ref_inc(head_page);
> > +}
> > +
>
> I am confused by this, why add a new helper instead of modifying the
> existing helper, skb_frag_ref()?
>
> My mental model is that if the net stack wants to acquire a reference
> on a frag, it calls skb_frag_ref(), and if it wants to drop a
> reference on a frag, it should call skb_frag_unref(). Internally
> skb_frag_ref/unref() can do all sorts of checking to decide whether to
> increment page->refcount or page->pp_ref_count. I can't wrap my head
> around the introduction of skb_pp_frag_ref(), but no equivalent
> skb_pp_frag_unref().
>
> But even if skb_pp_frag_unref() was added, when should the net stack
> use skb_frag_ref/unref, and when should the stack use
> skb_pp_ref/unref? The docs currently describe what the function does,
> but when a program unfamiliar with the page pool should use it.
>
> >  static void skb_kfree_head(void *head, unsigned int end_offset)
> >  {
> >         if (end_offset =3D=3D SKB_SMALL_HEAD_HEADROOM)
> > @@ -5769,17 +5787,12 @@ bool skb_try_coalesce(struct sk_buff *to, struc=
t sk_buff *from,
> >                 return false;
> >
> >         /* In general, avoid mixing page_pool and non-page_pool allocat=
ed
> > -        * pages within the same SKB. Additionally avoid dealing with c=
lones
> > -        * with page_pool pages, in case the SKB is using page_pool fra=
gment
> > -        * references (page_pool_alloc_frag()). Since we only take full=
 page
> > -        * references for cloned SKBs at the moment that would result i=
n
> > -        * inconsistent reference counts.
> > -        * In theory we could take full references if @from is cloned a=
nd
> > -        * !@to->pp_recycle but its tricky (due to potential race with
> > -        * the clone disappearing) and rare, so not worth dealing with.
> > +        * pages within the same SKB. In theory we could take full
> > +        * references if @from is cloned and !@to->pp_recycle but its
> > +        * tricky (due to potential race with the clone disappearing) a=
nd
> > +        * rare, so not worth dealing with.
> >          */
> > -       if (to->pp_recycle !=3D from->pp_recycle ||
> > -           (from->pp_recycle && skb_cloned(from)))
> > +       if (to->pp_recycle !=3D from->pp_recycle)
> >                 return false;
> >
> >         if (len <=3D skb_tailroom(to)) {
> > @@ -5836,8 +5849,12 @@ bool skb_try_coalesce(struct sk_buff *to, struct=
 sk_buff *from,
> >         /* if the skb is not cloned this does nothing
> >          * since we set nr_frags to 0.
> >          */
> > -       for (i =3D 0; i < from_shinfo->nr_frags; i++)
> > -               __skb_frag_ref(&from_shinfo->frags[i]);
> > +       if (from->pp_recycle)
> > +               for (i =3D 0; i < from_shinfo->nr_frags; i++)
> > +                       skb_pp_frag_ref(skb_frag_page(&from_shinfo->fra=
gs[i]));
> > +       else
> > +               for (i =3D 0; i < from_shinfo->nr_frags; i++)
> > +                       __skb_frag_ref(&from_shinfo->frags[i]);
>
> You added a check here to use skb_pp_frag_ref() instead of
> skb_frag_ref() here, but it's not clear to me why other callsites of
> skb_frag_ref() don't need to be modified in the same way after your
> patch.
>
> After your patch:
>
> skb_frag_ref() will always increment page->_refcount
> skb_frag_unref() will either decrement page->_refcount or decrement
> page->pp_ref_count (depending on the value of skb->pp_recycle).
> skb_pp_frag_ref() will either increment page->_refcount or increment
> page->pp_ref_count (depending on the value of is_pp_page(), not
> skb->pp_recycle).
> skb_pp_frag_unref() doesn't exist.
>
> Is this not confusing? Can we streamline things:
>
> skb_frag_ref() increments page->pp_ref_count for skb->pp_recycle,
> page->_refcount otherwise.
> skb_frag_unref() decrement page->pp_ref_count for skb->pp_recycle,
> page->_refcount otherwise.
>
> Or am I missing something that causes us to require this asymmetric
> reference counting?
>

This idea was previously implemented, as shown here:
https://lore.kernel.org/all/20211009093724.10539-5-linyunsheng@huawei.com/.
But implementing this would result in some unnecessary overhead, since
currently, 'skb_try_coalesce' is the only place where the page pool
reference count for skb frag might be increased. I would prefer to
move the logic to '__skb_frag_ref' when such a need becomes more
common. Thanks!

> >
> >         to->truesize +=3D delta;
> >         to->len +=3D len;
> > --
> > 2.31.1
> >
> >
>
>
> --
> Thanks,
> Mina

