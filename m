Return-Path: <netdev+bounces-56686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D24B88107D3
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 02:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F142821AC
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E69A5E;
	Wed, 13 Dec 2023 01:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1N5sklu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63767AF
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 17:49:46 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1e2ded3d9fso767006566b.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 17:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702432185; x=1703036985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Dp7XSpsxzOVeUljUsll9zHj7vC0qxh0to2u+ut6gGQ=;
        b=k1N5skluDfWrLVIueRqpqsiyYrD6hV+OFhfDHBjbTy64UgmhgQzBmIES2SOE7Dsjkd
         Bwcj7WxypMQkaiQg+MtzQxdyczIfwLs0o4BEhkMa9F8wYyyKyg3XYb2OiqKQB8jTDCea
         IN5ORh3D0hOw27WCrQwwIeXz442NVpto8e05MIguSbcOyyKE/movxXKNeeFbjQiXn2dX
         ePiLNpTY1ts1s6OEd+Mov75qhr+bVx60MkPbVkD0+8PxwvK7i556d/YadRfHOBUcsksT
         wqthrfHukkXbrjET6j5UywcheSXtKHJsM9Syz7OC+EehtgOC0WTMUWE83Uqr/JqZ7juH
         vkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702432185; x=1703036985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Dp7XSpsxzOVeUljUsll9zHj7vC0qxh0to2u+ut6gGQ=;
        b=DusuXDliJ5/DSWDjvOa6g2GsRxKeYRFiiLXmKV0kxnMVWf73hPFlYU2G8tf9chWqK3
         EfOaE3xjTm3I0Yd3E1PRJWWrBc/52p58KJ+Arj6cHXI+PZi4Lzqi0IyyXHMlc6IN0rJl
         wyjmpLMLgIPgGokbQlLE5QyCqd/x/DaIUBGWyXCvYp2WKE+a9xzvZ32qdGcOYBUMLTNk
         VFC2Q2oK/DoE2MPDACxq44cUDYIuYTRzREceC2MR+64bWuyMck6MJaoRR12sR2pvWWZ0
         Dmbjgnqzequ8n7852I6Sz3ZbEoLNNXYIMoogczMbT1cr/JUixxcz2h/O8uSjdworGF5o
         22Qg==
X-Gm-Message-State: AOJu0YxL7NvTeEyKD3P9LlWSOU0XUSt1pv9V5UU76Wc7zsjZ3Y/u73av
	7CSuhFIz4byApBIWuayprXs+jgnc1XywP81yl9iDJg==
X-Google-Smtp-Source: AGHT+IE/VYpq5pvmEgd37RPrAwycVczGDtBum4RYx++cbQb3nApf1q/8jfeKyKbjAvGvRf5ib8GJ29kZBhsqp+RH20c=
X-Received: by 2002:a17:906:cb9b:b0:a19:a19b:78d6 with SMTP id
 mf27-20020a170906cb9b00b00a19a19b78d6mr3018061ejb.153.1702432184670; Tue, 12
 Dec 2023 17:49:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212044614.42733-1-liangchen.linux@gmail.com> <20231212044614.42733-5-liangchen.linux@gmail.com>
In-Reply-To: <20231212044614.42733-5-liangchen.linux@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Dec 2023 17:49:33 -0800
Message-ID: <CAHS8izPW8dugsbUmXbt8WOFaOLvAaNtW2SwxizVtk4tNm-hFJw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 4/4] skbuff: Optimization of SKB coalescing
 for page pool
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	linyunsheng@huawei.com, netdev@vger.kernel.org, linux-mm@kvack.org, 
	jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 8:47=E2=80=AFPM Liang Chen <liangchen.linux@gmail.c=
om> wrote:
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
>  net/core/skbuff.c               | 43 ++++++++++++++++++++++++---------
>  2 files changed, 36 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/help=
ers.h
> index d0c5e7e6857a..0dc8fab43bef 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -281,6 +281,11 @@ static inline long page_pool_unref_page(struct page =
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
> index 7e26b56cda38..783a04733109 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -947,6 +947,26 @@ static bool skb_pp_recycle(struct sk_buff *skb, void=
 *data, bool napi_safe)
>         return napi_pp_put_page(virt_to_page(data), napi_safe);
>  }
>
> +/**
> + * skb_pp_frag_ref() - Increase fragment reference count of a page
> + * @page:      page of the fragment on which to increase a reference
> + *
> + * Increase the fragment reference count (pp_ref_count) of a page. This =
is
> + * intended to gain a fragment reference only for page pool aware skbs,
> + * i.e. when skb->pp_recycle is true, and not for fragments in a
> + * non-pp-recycling skb. It has a fallback to increase a reference on a
> + * normal page, as page pool aware skbs may also have normal page fragme=
nts.
> + */
> +static void skb_pp_frag_ref(struct page *page)
> +{
> +       struct page *head_page =3D compound_head(page);
> +

Feel free to not delay this patch series further based on this
comment/question, but...

I'm a bit confused about the need for compound_head() here, but
skb_frag_ref() doesn't first obtain the compound_head(). Is there a
page_pool specific reason why skb_frag_ref() can get_page() directly
but this helper needs to grab the compound_head() first?

> +       if (likely(is_pp_page(head_page)))
> +               page_pool_ref_page(head_page);
> +       else
> +               page_ref_inc(head_page);

Any reason why not get_page() here?

> +}
> +
>  static void skb_kfree_head(void *head, unsigned int end_offset)
>  {
>         if (end_offset =3D=3D SKB_SMALL_HEAD_HEADROOM)
> @@ -5769,17 +5789,12 @@ bool skb_try_coalesce(struct sk_buff *to, struct =
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
> @@ -5836,8 +5851,12 @@ bool skb_try_coalesce(struct sk_buff *to, struct s=
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
>
>         to->truesize +=3D delta;
>         to->len +=3D len;
> --
> 2.31.1
>


--=20
Thanks,
Mina

