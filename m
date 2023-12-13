Return-Path: <netdev+bounces-56692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FC681084E
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 03:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC9F1F219EB
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 02:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3548C65C;
	Wed, 13 Dec 2023 02:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjnqKfYh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D37A1
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 18:37:39 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54cdef4c913so14832616a12.1
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 18:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702435058; x=1703039858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A14z2BQuBzcsxgDQdrPuAIDBK54w9JgVZHDzxlaumNU=;
        b=UjnqKfYhwigSmW2yq+Zuo0pXiSLqFyR1nhmnp/QXe9zaa4qiem/t7xJ6rbVlsWKfnu
         E9c0zWYg5At4A/nFKVTcqWejTbL8oW9FGcKoqeym8J+rKJRbV/LGLK8XDwG9Rci+KrFS
         yT04T7Fh1/4gA1sAy/H80kXOCN5/gEvIRBaCtt8crqcxWVMbnvhr+WnV+DyvUtR8uWpB
         GAvXdEM7+BEo8JKnydiCmDJfQIX24Tw46qxawC7n1V4HeGMTLwlepTkjkCe07VAhGcUI
         iXdLqsQDsClrdLFVMfLVuwZgABLWf0DAK02w41WDL3AH36L+X6H8OBHv9dUDrCIbhUBu
         oJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702435058; x=1703039858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A14z2BQuBzcsxgDQdrPuAIDBK54w9JgVZHDzxlaumNU=;
        b=kmrWBiYXNJIhyc/vobqxMq/eIXaH9jUEBJHZ4ukQGu74RBQYFRlaC/G1hf9NimMfVM
         1EHuYA71zf6diQtmaMZgcS0LUtkR3693R4G4uSkPqf3I/WMTpG0puH+dM9fwWbAQJ11T
         QVtCLXGUUqCyRl14DGJa4yUUnLl7nBDjFMTfSS3zOG5hj8czExcgCSmnnrTB2S8UkN3o
         FfZ6RNeBnl/iAsnF35GsrpWLAmQDI38TuUi76VBnDDO7Bc251SuIVfJEbXJWa+Bu88Wo
         NNg4/M4b2zIYWvfOqu/h47VsOEhtQaKox9ntQh+yo2v36LEYUfiPa7IDPQ3p3rvLFflV
         Vauw==
X-Gm-Message-State: AOJu0YylWTAXOmhWuycSDuWbVDuRnuhL9neLMMUNM09Duv9gapjAwbbU
	uSmSJc3ZSiv/LDlwHFGAOxusTNV+AnzcAEiP3Lc=
X-Google-Smtp-Source: AGHT+IGF1an9AwucqEP027ea1hA05dr37UFlp5GCRvjhSoVc62xh2wmLr7qx4/RwaknBIf6ue9pphT4TjxuFDuJapX4=
X-Received: by 2002:a17:907:270f:b0:a1e:a558:748c with SMTP id
 w15-20020a170907270f00b00a1ea558748cmr7552297ejk.18.1702435057895; Tue, 12
 Dec 2023 18:37:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212044614.42733-1-liangchen.linux@gmail.com>
 <20231212044614.42733-5-liangchen.linux@gmail.com> <CAHS8izPW8dugsbUmXbt8WOFaOLvAaNtW2SwxizVtk4tNm-hFJw@mail.gmail.com>
In-Reply-To: <CAHS8izPW8dugsbUmXbt8WOFaOLvAaNtW2SwxizVtk4tNm-hFJw@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 13 Dec 2023 10:37:24 +0800
Message-ID: <CAKhg4tKRQrvAUSz0jHi82TreO9EmxJPttxO-39CBz=7RwhC0Mw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 4/4] skbuff: Optimization of SKB coalescing
 for page pool
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	linyunsheng@huawei.com, netdev@vger.kernel.org, linux-mm@kvack.org, 
	jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 9:49=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Mon, Dec 11, 2023 at 8:47=E2=80=AFPM Liang Chen <liangchen.linux@gmail=
.com> wrote:
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
> >  net/core/skbuff.c               | 43 ++++++++++++++++++++++++---------
> >  2 files changed, 36 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/he=
lpers.h
> > index d0c5e7e6857a..0dc8fab43bef 100644
> > --- a/include/net/page_pool/helpers.h
> > +++ b/include/net/page_pool/helpers.h
> > @@ -281,6 +281,11 @@ static inline long page_pool_unref_page(struct pag=
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
> > index 7e26b56cda38..783a04733109 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -947,6 +947,26 @@ static bool skb_pp_recycle(struct sk_buff *skb, vo=
id *data, bool napi_safe)
> >         return napi_pp_put_page(virt_to_page(data), napi_safe);
> >  }
> >
> > +/**
> > + * skb_pp_frag_ref() - Increase fragment reference count of a page
> > + * @page:      page of the fragment on which to increase a reference
> > + *
> > + * Increase the fragment reference count (pp_ref_count) of a page. Thi=
s is
> > + * intended to gain a fragment reference only for page pool aware skbs=
,
> > + * i.e. when skb->pp_recycle is true, and not for fragments in a
> > + * non-pp-recycling skb. It has a fallback to increase a reference on =
a
> > + * normal page, as page pool aware skbs may also have normal page frag=
ments.
> > + */
> > +static void skb_pp_frag_ref(struct page *page)
> > +{
> > +       struct page *head_page =3D compound_head(page);
> > +
>
> Feel free to not delay this patch series further based on this
> comment/question, but...
>
> I'm a bit confused about the need for compound_head() here, but
> skb_frag_ref() doesn't first obtain the compound_head(). Is there a
> page_pool specific reason why skb_frag_ref() can get_page() directly
> but this helper needs to grab the compound_head() first?
>

get_page includes the call to compound_head, so skb_frag_ref
indirectly calls compound_head as well.

> > +       if (likely(is_pp_page(head_page)))
> > +               page_pool_ref_page(head_page);
> > +       else
> > +               page_ref_inc(head_page);
>
> Any reason why not get_page() here?
>

head_page is a head page because of the compound_head call above. This
was actually a comment received from a previous iteration:)

> > +}
> > +
> >  static void skb_kfree_head(void *head, unsigned int end_offset)
> >  {
> >         if (end_offset =3D=3D SKB_SMALL_HEAD_HEADROOM)
> > @@ -5769,17 +5789,12 @@ bool skb_try_coalesce(struct sk_buff *to, struc=
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
> > @@ -5836,8 +5851,12 @@ bool skb_try_coalesce(struct sk_buff *to, struct=
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
> >
> >         to->truesize +=3D delta;
> >         to->len +=3D len;
> > --
> > 2.31.1
> >
>
>
> --
> Thanks,
> Mina

