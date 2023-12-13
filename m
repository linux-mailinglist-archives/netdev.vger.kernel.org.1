Return-Path: <netdev+bounces-56693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDA6810866
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 03:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1122F1C20D7E
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 02:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B582665C;
	Wed, 13 Dec 2023 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nRvmgQIW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D5D98
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 18:49:53 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54f5469c211so6377283a12.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 18:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702435792; x=1703040592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hx3MGS0vh0t0JSEKl4JpxxRT2HR4aiOSN7E9sUnPJsU=;
        b=nRvmgQIWjas9b95worPEqPwauyXIwD+2FaHh37nnecQ6RGIjP9cX9uikwTuXVg0Uat
         PyehvK8Li7LYwGt6pwD4/Dt/TiaW+kebwWwf6HMH0BdTKGarOsLOgFWpKBDiwGYNey4s
         /daxDmytTOw0Oh9pWRqA3cINaSJaPBY1ORmHYN32PZEuBnc8IuZJqEgmQg1UKuR/fRSI
         uTlt9IE8XXUjmGCq+5dUvcWHYaF3UYwA4CUUQeZALNsuvjDRpKmIqfcsW2+irYz8X9+9
         ywf+icC5zmlbqC+mEikAi5qQJTd1CycyJCRt7dm1wWY4EEqsH5kfjC3npl0z8WoNCq2d
         mOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702435792; x=1703040592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hx3MGS0vh0t0JSEKl4JpxxRT2HR4aiOSN7E9sUnPJsU=;
        b=PDyYXd8YHRfWm45e/Cfyvd5tx7hFctzMb8UxnF8oL3y6gVTxTXQ29hCsHthUWqboH3
         CSl78I7I7x3cbwt2tSqSGfwGQ6+q5oDj+3d9FRnPwJRsY4UFM2nN9v9vs0NIM3hj3KiI
         Z/vPAV29HHB5W8SkJBYPLLhJgAG9D5UJI4NiKf1AuMCkEKo+XeogOtq3ZG2M5UzvO0HP
         6Nv2WrTxulftZnB81e2M1jkxrXIe2/G4f9rOSLYwsLN/Q1GTdRNysmMx0mLg7UJSqpel
         jAeM6AKhOa4eXIe6v6WRtxsCdzLboB+BkCNB2GyfUizTciKAcmDHTPvrkEGtjcXRYJPj
         WXwQ==
X-Gm-Message-State: AOJu0YwhLcWCSPotIzczWOrtCnaTqRJB3zhblFxuyDRbTeCxSvnASr+m
	6SXBg6tT8QcwxR/HP3bunmVSqv1hnYJTxtcRNxiSPg==
X-Google-Smtp-Source: AGHT+IGe3jEGYSGhaaFpyZ5DbH0V4pQ4kWfFiVOeEr6q2XFMv4n1SIL+/2Go2YLnoKl5LEaDe5iEkB9Kkdwf84tvtPg=
X-Received: by 2002:a17:906:ceda:b0:a1d:ddfc:1cda with SMTP id
 si26-20020a170906ceda00b00a1dddfc1cdamr3643955ejb.93.1702435792229; Tue, 12
 Dec 2023 18:49:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212044614.42733-1-liangchen.linux@gmail.com>
 <20231212044614.42733-5-liangchen.linux@gmail.com> <CAHS8izPW8dugsbUmXbt8WOFaOLvAaNtW2SwxizVtk4tNm-hFJw@mail.gmail.com>
 <CAKhg4tKRQrvAUSz0jHi82TreO9EmxJPttxO-39CBz=7RwhC0Mw@mail.gmail.com>
In-Reply-To: <CAKhg4tKRQrvAUSz0jHi82TreO9EmxJPttxO-39CBz=7RwhC0Mw@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Dec 2023 18:49:40 -0800
Message-ID: <CAHS8izNFhZ4ZSR+UhTG99Y43LzmxkvkdOvRnYuGtxt0jehwHCA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 4/4] skbuff: Optimization of SKB coalescing
 for page pool
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	linyunsheng@huawei.com, netdev@vger.kernel.org, linux-mm@kvack.org, 
	jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 6:37=E2=80=AFPM Liang Chen <liangchen.linux@gmail.c=
om> wrote:
>
> On Wed, Dec 13, 2023 at 9:49=E2=80=AFAM Mina Almasry <almasrymina@google.=
com> wrote:
> >
> > On Mon, Dec 11, 2023 at 8:47=E2=80=AFPM Liang Chen <liangchen.linux@gma=
il.com> wrote:
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
> > >  net/core/skbuff.c               | 43 ++++++++++++++++++++++++-------=
--
> > >  2 files changed, 36 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/=
helpers.h
> > > index d0c5e7e6857a..0dc8fab43bef 100644
> > > --- a/include/net/page_pool/helpers.h
> > > +++ b/include/net/page_pool/helpers.h
> > > @@ -281,6 +281,11 @@ static inline long page_pool_unref_page(struct p=
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
> > > index 7e26b56cda38..783a04733109 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -947,6 +947,26 @@ static bool skb_pp_recycle(struct sk_buff *skb, =
void *data, bool napi_safe)
> > >         return napi_pp_put_page(virt_to_page(data), napi_safe);
> > >  }
> > >
> > > +/**
> > > + * skb_pp_frag_ref() - Increase fragment reference count of a page
> > > + * @page:      page of the fragment on which to increase a reference
> > > + *
> > > + * Increase the fragment reference count (pp_ref_count) of a page. T=
his is
> > > + * intended to gain a fragment reference only for page pool aware sk=
bs,
> > > + * i.e. when skb->pp_recycle is true, and not for fragments in a
> > > + * non-pp-recycling skb. It has a fallback to increase a reference o=
n a
> > > + * normal page, as page pool aware skbs may also have normal page fr=
agments.
> > > + */
> > > +static void skb_pp_frag_ref(struct page *page)
> > > +{
> > > +       struct page *head_page =3D compound_head(page);
> > > +
> >
> > Feel free to not delay this patch series further based on this
> > comment/question, but...
> >
> > I'm a bit confused about the need for compound_head() here, but
> > skb_frag_ref() doesn't first obtain the compound_head(). Is there a
> > page_pool specific reason why skb_frag_ref() can get_page() directly
> > but this helper needs to grab the compound_head() first?
> >
>
> get_page includes the call to compound_head, so skb_frag_ref
> indirectly calls compound_head as well.
>
> > > +       if (likely(is_pp_page(head_page)))
> > > +               page_pool_ref_page(head_page);
> > > +       else
> > > +               page_ref_inc(head_page);
> >
> > Any reason why not get_page() here?
> >
>
> head_page is a head page because of the compound_head call above. This
> was actually a comment received from a previous iteration:)
>

I see, thanks.

Reviewed-by: Mina Almasry <almasrymina@google.com>

Noob question: do we actually support someone passing a compound_page
to skb_frag_fill_page_desc()? Anyone know of any driver that does
this? I kinda like the direction this patch was going instead:

https://patchwork.kernel.org/project/netdevbpf/patch/20231113130041.58124-5=
-linyunsheng@huawei.com/

Where we explicitly exclude compound pages from skbs... This is for
convenience for devmem TCP, where I don't support compound pages, but
that is more my problem than yours. This patch is fine.

> > > +}
> > > +
> > >  static void skb_kfree_head(void *head, unsigned int end_offset)
> > >  {
> > >         if (end_offset =3D=3D SKB_SMALL_HEAD_HEADROOM)
> > > @@ -5769,17 +5789,12 @@ bool skb_try_coalesce(struct sk_buff *to, str=
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
> > > @@ -5836,8 +5851,12 @@ bool skb_try_coalesce(struct sk_buff *to, stru=
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
> > >
> > >         to->truesize +=3D delta;
> > >         to->len +=3D len;
> > > --
> > > 2.31.1
> > >
> >
> >
> > --
> > Thanks,
> > Mina



--=20
Thanks,
Mina

