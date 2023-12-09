Return-Path: <netdev+bounces-55520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8276780B1B0
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 03:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96501C20AB0
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 02:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F738EA2;
	Sat,  9 Dec 2023 02:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3mIHKDDi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3829610EA
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 18:18:54 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d9f879f784so398143a34.2
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 18:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702088333; x=1702693133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id/KWvh/UP+BHFrE7czNVdIKPn8QbB76sCT1pERx/5s=;
        b=3mIHKDDiJtoR5QPqIwrFZ31jBd0D/m8++QKUwRA+IYjlhMc0aI1tGps6W+bfSyaMvF
         ldPhZbV9/O1zlTQEVL0oSZ5WIzf/dfJC0PPqqY9VQqgD73ipdBeYvCijDLNZFxs5Lh93
         Wun2u/5zFYkc/jOg1WUbNvnDAZVQ+dk1/SXp6C7aSejrUFzOE2LE6h6HAjWOmRL9bl0v
         PNOBYJWNNgjMOBeUT1eL4bGAf0idWDhG96uTc+7upQsFhjG5pocJVGzvks4iThBftVtb
         LYHi0gQGnE57HkmhTr9r2/cJV7yAm5j6B2NTAVcHGL/QwyfqCKW/gxT9BRIlevcex5Ah
         0fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702088333; x=1702693133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id/KWvh/UP+BHFrE7czNVdIKPn8QbB76sCT1pERx/5s=;
        b=wkpylkHzHX+tapTbMo3A2nf3zWzqZuq5ha1/pklGGAjdmEvhGGv9sqBohFNXc9soAF
         kLEPNHgkt1VQKSCDWYJ1kD6Kmne5c7qYjH5WJaJ52InyYhL5IDdHGcErJs4jdwdqr6Mi
         QX2WpixSoF/c3zetaFClQEmoJcllHx0NRwL9rqJAPm8mLRZe24DELaMlhTDHksoWSIfw
         tVHbO//oAVesZUFRipb3TN6Lw/ZJiOSlVFRMgkvHpx1N/L7wwtTga4tmVmMBRbXJRP4y
         3tL/gf9Cm/bKap96Jie2+nk6yONP78twOkUA0fe2KJtrLoaK/iDeJy1vCGerJkwZMDAi
         xpMA==
X-Gm-Message-State: AOJu0Yymw9MsjOqHnsEMPLuT0uwgcvqSyxZ6OQeDhSBinC0vdeLbeLr9
	qkUACNE9lAc2/8ZOXQ/XA6N3xuboiZa+h+Qe2/eLVQ==
X-Google-Smtp-Source: AGHT+IHvxyeRFZMW+chidxLYW6a/7/tbucO+MyaJrquIiMPUN+CwoTBoas+OvTSHrt85isxFSjoU/HW7WaYHUwNf9Tk=
X-Received: by 2002:a05:6830:442a:b0:6d9:f440:b0f2 with SMTP id
 q42-20020a056830442a00b006d9f440b0f2mr1293226otv.2.1702088333130; Fri, 08 Dec
 2023 18:18:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206105419.27952-1-liangchen.linux@gmail.com> <20231206105419.27952-5-liangchen.linux@gmail.com>
In-Reply-To: <20231206105419.27952-5-liangchen.linux@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 8 Dec 2023 18:18:42 -0800
Message-ID: <CAHS8izNQeSwWQ9NwiDUcPoSX1WONG4JYu2rfpqF3+4xkxE=Wyw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 4/4] skbuff: Optimization of SKB coalescing
 for page pool
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	linyunsheng@huawei.com, netdev@vger.kernel.org, linux-mm@kvack.org, 
	jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 2:54=E2=80=AFAM Liang Chen <liangchen.linux@gmail.co=
m> wrote:
>
> In order to address the issues encountered with commit 1effe8ca4e34
> ("skbuff: fix coalescing for page_pool fragment recycling"), the
> combination of the following condition was excluded from skb coalescing:
>
> from->pp_recycle =3D 1
> from->cloned =3D 1
> to->pp_recycle =3D 1
>
> However, with page pool environments, the aforementioned combination can
> be quite common(ex. NetworkMananger may lead to the additional
> packet_type being registered, thus the cloning). In scenarios with a
> higher number of small packets, it can significantly affect the success
> rate of coalescing. For example, considering packets of 256 bytes size,
> our comparison of coalescing success rate is as follows:
>
> Without page pool: 70%
> With page pool: 13%
>
> Consequently, this has an impact on performance:
>
> Without page pool: 2.57 Gbits/sec
> With page pool: 2.26 Gbits/sec
>
> Therefore, it seems worthwhile to optimize this scenario and enable
> coalescing of this particular combination. To achieve this, we need to
> ensure the correct increment of the "from" SKB page's page pool
> reference count (pp_ref_count).
>
> Following this optimization, the success rate of coalescing measured in
> our environment has improved as follows:
>
> With page pool: 60%
>
> This success rate is approaching the rate achieved without using page
> pool, and the performance has also been improved:
>
> With page pool: 2.52 Gbits/sec
>
> Below is the performance comparison for small packets before and after
> this optimization. We observe no impact to packets larger than 4K.
>
> packet size     before      after       improved
> (bytes)         (Gbits/sec) (Gbits/sec)
> 128             1.19        1.27        7.13%
> 256             2.26        2.52        11.75%
> 512             4.13        4.81        16.50%
> 1024            6.17        6.73        9.05%
> 2048            14.54       15.47       6.45%
> 4096            25.44       27.87       9.52%
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/net/page_pool/helpers.h |  5 ++++
>  net/core/skbuff.c               | 41 +++++++++++++++++++++++----------
>  2 files changed, 34 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/help=
ers.h
> index 9dc8eaf8a959..268bc9d9ffd3 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -278,6 +278,11 @@ static inline long page_pool_unref_page(struct page =
*page, long nr)
>         return ret;
>  }
>
> +static inline void page_pool_ref_page(struct page *page)
> +{
> +       atomic_long_inc(&page->pp_ref_count);
> +}
> +
>  static inline bool page_pool_is_last_ref(struct page *page)
>  {
>         /* If page_pool_unref_page() returns 0, we were the last user */
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 7e26b56cda38..3c2515a29376 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -947,6 +947,24 @@ static bool skb_pp_recycle(struct sk_buff *skb, void=
 *data, bool napi_safe)
>         return napi_pp_put_page(virt_to_page(data), napi_safe);
>  }
>
> +/**
> + * skb_pp_frag_ref() - Increase fragment reference count of a page
> + * @page:      page of the fragment on which to increase a reference
> + *
> + * Increase fragment reference count (pp_ref_count) on a page, but if it=
 is
> + * not a page pool page, fallback to increase a reference(_refcount) on =
a
> + * normal page.
> + */
> +static void skb_pp_frag_ref(struct page *page)
> +{
> +       struct page *head_page =3D compound_head(page);
> +
> +       if (likely(is_pp_page(head_page)))
> +               page_pool_ref_page(head_page);
> +       else
> +               page_ref_inc(head_page);
> +}
> +

I am confused by this, why add a new helper instead of modifying the
existing helper, skb_frag_ref()?

My mental model is that if the net stack wants to acquire a reference
on a frag, it calls skb_frag_ref(), and if it wants to drop a
reference on a frag, it should call skb_frag_unref(). Internally
skb_frag_ref/unref() can do all sorts of checking to decide whether to
increment page->refcount or page->pp_ref_count. I can't wrap my head
around the introduction of skb_pp_frag_ref(), but no equivalent
skb_pp_frag_unref().

But even if skb_pp_frag_unref() was added, when should the net stack
use skb_frag_ref/unref, and when should the stack use
skb_pp_ref/unref? The docs currently describe what the function does,
but when a program unfamiliar with the page pool should use it.

>  static void skb_kfree_head(void *head, unsigned int end_offset)
>  {
>         if (end_offset =3D=3D SKB_SMALL_HEAD_HEADROOM)
> @@ -5769,17 +5787,12 @@ bool skb_try_coalesce(struct sk_buff *to, struct =
sk_buff *from,
>                 return false;
>
>         /* In general, avoid mixing page_pool and non-page_pool allocated
> -        * pages within the same SKB. Additionally avoid dealing with clo=
nes
> -        * with page_pool pages, in case the SKB is using page_pool fragm=
ent
> -        * references (page_pool_alloc_frag()). Since we only take full p=
age
> -        * references for cloned SKBs at the moment that would result in
> -        * inconsistent reference counts.
> -        * In theory we could take full references if @from is cloned and
> -        * !@to->pp_recycle but its tricky (due to potential race with
> -        * the clone disappearing) and rare, so not worth dealing with.
> +        * pages within the same SKB. In theory we could take full
> +        * references if @from is cloned and !@to->pp_recycle but its
> +        * tricky (due to potential race with the clone disappearing) and
> +        * rare, so not worth dealing with.
>          */
> -       if (to->pp_recycle !=3D from->pp_recycle ||
> -           (from->pp_recycle && skb_cloned(from)))
> +       if (to->pp_recycle !=3D from->pp_recycle)
>                 return false;
>
>         if (len <=3D skb_tailroom(to)) {
> @@ -5836,8 +5849,12 @@ bool skb_try_coalesce(struct sk_buff *to, struct s=
k_buff *from,
>         /* if the skb is not cloned this does nothing
>          * since we set nr_frags to 0.
>          */
> -       for (i =3D 0; i < from_shinfo->nr_frags; i++)
> -               __skb_frag_ref(&from_shinfo->frags[i]);
> +       if (from->pp_recycle)
> +               for (i =3D 0; i < from_shinfo->nr_frags; i++)
> +                       skb_pp_frag_ref(skb_frag_page(&from_shinfo->frags=
[i]));
> +       else
> +               for (i =3D 0; i < from_shinfo->nr_frags; i++)
> +                       __skb_frag_ref(&from_shinfo->frags[i]);

You added a check here to use skb_pp_frag_ref() instead of
skb_frag_ref() here, but it's not clear to me why other callsites of
skb_frag_ref() don't need to be modified in the same way after your
patch.

After your patch:

skb_frag_ref() will always increment page->_refcount
skb_frag_unref() will either decrement page->_refcount or decrement
page->pp_ref_count (depending on the value of skb->pp_recycle).
skb_pp_frag_ref() will either increment page->_refcount or increment
page->pp_ref_count (depending on the value of is_pp_page(), not
skb->pp_recycle).
skb_pp_frag_unref() doesn't exist.

Is this not confusing? Can we streamline things:

skb_frag_ref() increments page->pp_ref_count for skb->pp_recycle,
page->_refcount otherwise.
skb_frag_unref() decrement page->pp_ref_count for skb->pp_recycle,
page->_refcount otherwise.

Or am I missing something that causes us to require this asymmetric
reference counting?

>
>         to->truesize +=3D delta;
>         to->len +=3D len;
> --
> 2.31.1
>
>


--=20
Thanks,
Mina

