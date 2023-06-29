Return-Path: <netdev+bounces-14557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5688A7425D8
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 14:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3F3280E69
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110CF154B0;
	Thu, 29 Jun 2023 12:20:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C4811C96
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 12:20:08 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDAE3586
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 05:20:06 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b69f71a7easo9055681fa.1
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 05:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688041205; x=1690633205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UO3Uphuz7gnwAzYpGp6UOaniOpe+SrLNILI7Ga2lKBQ=;
        b=l+6Bo2hSgo0RndzdYQanAScyBzEm3AWP7ie3aZxjRet9ywQS1kX28fcxNKJS8Dwxjo
         /nWWCsYqsFtyxdlb2+gtBETcMfdl0BYmH8xO8oZQKyMZ21jnrr/Gn2fA79btNd16+360
         4moAVB/KH/DDIXLQ228dcWtR/zaDRYx8PIL2lYyj0Ut33rGfcY+NNfvMMRv198H2E1XZ
         Dy5rgdP8LsMvbzYuQxwQGOD6yxxX9mjnJdPezzDZZB0aQjdicEjEm3IEzz2+/YAYW0ds
         iD9LD3Gus55fZ47NR8K9HgREbjOGFT8PY/8iNoCFGpYrxm/4Qbfq/xhlhaUrztSdPEma
         Lw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688041205; x=1690633205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UO3Uphuz7gnwAzYpGp6UOaniOpe+SrLNILI7Ga2lKBQ=;
        b=E68tLK0kHVo1Nw2I7pjOPVX+1gHwxl9bQBbD+nto4hoUd+IcgEBCGp08lqb9MBjWAe
         WYNiT30pSTMCP+RYO8yHqH+sUEgPUh36eMhERLunA1uINiZCewGCuXJbisk5j1F15smK
         fDgxlhOKxZLWNEfnRGpxK1LxsTiRp2MvDNGILEiRQT/mR8eduRDpDnlTncRSslse+Gkf
         6Pu4Y9YJZvOQDDpwkGVahzUaHqLvRKbS8TajM1YKuG1Xsy7FXHMM/GXGxFbImeuZPUjW
         kuWmD7Pa13C53pXZ9gawF4srQn+5AXSbaW220CEikho5UaJUV4Itui5YioBQpAnhzO1k
         l63Q==
X-Gm-Message-State: ABy/qLZHccm23+/3tDJwo8G9lHktsJOkks/Xfg/9r7l80lQr6V5h3Zd/
	ocJ4pbAAtmqHlL58/URxDFINSj8NxIE0HUL4JH8=
X-Google-Smtp-Source: APBJJlHv4kR/5/3hXj5z1Iq1LdNOIYQv5X0O4jD2O1Fbz0IImQpaG+X5kPfcp3airLDX4zgF4mKmanb10UgTlX/TvV8=
X-Received: by 2002:a2e:9106:0:b0:2b6:cd40:21ad with SMTP id
 m6-20020a2e9106000000b002b6cd4021admr171976ljg.37.1688041204576; Thu, 29 Jun
 2023 05:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628121150.47778-1-liangchen.linux@gmail.com>
 <5b81338a-f784-d73e-170c-d12af38692cb@huawei.com> <CAKhg4tJkprS+dFcpLALP_e1kpHJ-DwabOMFaXxsPx+7O0c-geQ@mail.gmail.com>
In-Reply-To: <CAKhg4tJkprS+dFcpLALP_e1kpHJ-DwabOMFaXxsPx+7O0c-geQ@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Thu, 29 Jun 2023 20:19:52 +0800
Message-ID: <CAKhg4t+RUeoTv_OnD5nMAXWeATqRC+tcyzbnz_jXBQGzd90rpQ@mail.gmail.com>
Subject: Re: [PATCH net-next] skbuff: Optimize SKB coalescing for page pool case
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: ilias.apalodimas@linaro.org, hawk@kernel.org, kuba@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 29, 2023 at 8:17=E2=80=AFPM Liang Chen <liangchen.linux@gmail.c=
om> wrote:
>
> On Thu, Jun 29, 2023 at 2:53=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.=
com> wrote:
> >
> > On 2023/6/28 20:11, Liang Chen wrote:
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
> > > be quite common. In scenarios with a higher number of small packets, =
it
> > > can significantly affect the success rate of coalescing. For example,
> > > when considering packets of 256 bytes size, our comparison of coalesc=
ing
> > > success rate is as follows:
> >
> > As skb_try_coalesce() only allow coaleascing when 'to' skb is not clone=
d.
> >
> > Could you give more detailed about the testing when we have a non-clone=
d
> > 'to' skb and a cloned 'from' skb? As both of them should be belong to t=
he
> > same flow.
> >
> > I had the below patchset trying to do something similar as this patch d=
oes:
> > https://lore.kernel.org/all/20211009093724.10539-5-linyunsheng@huawei.c=
om/
> >
> > It seems this patch is only trying to optimize a specific case for skb
> > coalescing, So if skb coalescing between non-cloned and cloned skb is a
> > common case, then it might worth optimizing.
> >
>
> Sure, Thanks for the information! The testing is just a common iperf
> test as below.
>
> iperf3 -c <server IP> -i 5 -f g -t 0 -l 128
>
> We observed the frequency of each combination of the pp (page pool)
> and clone condition when entering skb_try_coalesce. The results
> motivated us to propose such an optimization, as we noticed that case
> 11 (from pp/clone=3D1/1 and to pp/clone =3D 1/0) occurs quite often.
>
> +-------------+--------------+--------------+--------------+-------------=
-+
> |   from/to   | pp/clone=3D0/0 | pp/clone=3D0/1 | pp/clone=3D1/0 | pp/clo=
ne=3D1/1 |
> +-------------+--------------+--------------+--------------+-------------=
-+
> |pp/clone=3D0/0 | 0            | 1            | 2            | 3         =
   |
> |pp/clone=3D0/1 | 4            | 5            | 6            | 7         =
   |
> |pp/clone=3D1/0 | 8            | 9            | 10           | 11        =
   |
> |pp/clone=3D1/1 | 12           | 13           | 14           | 15        =
   |
> |+------------+--------------+--------------+--------------+-------------=
-+
>
>
> packet size 128:
> total : 152903
> 0 : 0            (0%)
> 1 : 0            (0%)
> 2 : 0            (0%)
> 3 : 0            (0%)
> 4 : 0            (0%)
> 5 : 0            (0%)
> 6 : 0            (0%)
> 7 : 0            (0%)
> 8 : 0            (0%)
> 9 : 0            (0%)
> 10 : 20681       (13%)
> 11 : 90136       (58%)
> 12 : 0           (0%)
> 13 : 0           (0%)
> 14 : 0           (0%)
> 15 : 42086       (27%)
>
> Thanks,
> Liang
>
>
> >
> > >
> > > Without page pool: 70%
> > > With page pool: 13%
> > >
> >
> > ...
> >
> > > diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> > > index 126f9e294389..05e5d8ead63b 100644
> > > --- a/include/net/page_pool.h
> > > +++ b/include/net/page_pool.h
> > > @@ -399,4 +399,25 @@ static inline void page_pool_nid_changed(struct =
page_pool *pool, int new_nid)
> > >               page_pool_update_nid(pool, new_nid);
> > >  }
> > >
> > > +static inline bool page_pool_is_pp_page(struct page *page)
> > > +{
> > > +     return (page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE;
> > > +}
> > > +
> > > +static inline bool page_pool_is_pp_page_frag(struct page *page)> +{
> > > +     return !!(page->pp->p.flags & PP_FLAG_PAGE_FRAG);
> > > +}
> > > +
> > > +static inline void page_pool_page_ref(struct page *page)
> > > +{
> > > +     struct page *head_page =3D compound_head(page);
> >
> > It seems we could avoid adding head_page here:
> > page =3D compound_head(page);
> >

Sure.

> > > +
> > > +     if (page_pool_is_pp_page(head_page) &&
> > > +                     page_pool_is_pp_page_frag(head_page))
> > > +             atomic_long_inc(&head_page->pp_frag_count);
> > > +     else
> > > +             get_page(head_page);
> >
> > page_ref_inc() should be enough here instead of get_page()
> > as compound_head() have been called.
> >

Yeah, it will be changed to page_ref_inc on v2.

> > > +}
> > > +
> > >  #endif /* _NET_PAGE_POOL_H */
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index 6c5915efbc17..9806b091f0f6 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -5666,8 +5666,7 @@ bool skb_try_coalesce(struct sk_buff *to, struc=
t sk_buff *from,
> > >        * !@to->pp_recycle but its tricky (due to potential race with
> > >        * the clone disappearing) and rare, so not worth dealing with.
> > >        */
> > > -     if (to->pp_recycle !=3D from->pp_recycle ||
> > > -         (from->pp_recycle && skb_cloned(from)))
> > > +     if (to->pp_recycle !=3D from->pp_recycle)
> > >               return false;
> > >
> > >       if (len <=3D skb_tailroom(to)) {
> > > @@ -5724,8 +5723,12 @@ bool skb_try_coalesce(struct sk_buff *to, stru=
ct sk_buff *from,
> > >       /* if the skb is not cloned this does nothing
> > >        * since we set nr_frags to 0.
> > >        */
> > > -     for (i =3D 0; i < from_shinfo->nr_frags; i++)
> > > -             __skb_frag_ref(&from_shinfo->frags[i]);
> > > +     if (from->pp_recycle)
> > > +             for (i =3D 0; i < from_shinfo->nr_frags; i++)
> > > +                     page_pool_page_ref(skb_frag_page(&from_shinfo->=
frags[i]));
> > > +     else
> > > +             for (i =3D 0; i < from_shinfo->nr_frags; i++)
> > > +                     __skb_frag_ref(&from_shinfo->frags[i]);
> > >
> > >       to->truesize +=3D delta;
> > >       to->len +=3D len;
> > >

