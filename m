Return-Path: <netdev+bounces-55756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC17A80C258
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 08:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569DD1F20EE8
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 07:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B83D208C9;
	Mon, 11 Dec 2023 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GdJpzvJ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1946F4
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 23:47:32 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9f099cf3aso60896301fa.1
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 23:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702280851; x=1702885651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IfPiMvnAYgF5F1rGe24c0+/9ss5EX07OpQuxPZvZeO8=;
        b=GdJpzvJ6bss/2s44drgpgl4RkT8MJqT7oEHxjDNdlDh1tp4VPVjWQpHZiaCsbjIaIA
         DprgzwWTYOZ2L/b2y+HXMQ6eYDQjza+B+pM95NfTYlda2UjJAHYC/ZM4gHvdZR1F9NrZ
         /BqUJQzRu0DwpsZ5lbFLCdw6BUCpLBxQzsfLTaP6bMSCblBo+FR56MoA+Oqox2YKWFoK
         3POWmlQldawe4+2U8ZMZ5zDqUUPYMfe9hoL8cldwGHVWRG5CVcTKeT58UirON1RAcjO3
         YoUV2YI4wmWcZUNB9qddaJwAxR6G6RrvkqBkZ+e0jWDbQgxhmRHncGPit2xmy7KOjP7z
         2/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702280851; x=1702885651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfPiMvnAYgF5F1rGe24c0+/9ss5EX07OpQuxPZvZeO8=;
        b=i4gL7UpNVi0JNoVzRvY04dGaFmZRyEkoOfOcDsfOJWWcTGPrrPfq/k6l78jtG+4GPy
         seQBm0PEKdLsdYNDXiiZ21VWR06KQomxyaJnL62Wef4Lifl6cj+NeYjrbyd+IDAUv/rd
         S/UPRQwB4gQiDHQyCjF0K9Pn/Xl33tEzorsFnuMTUp75h39NB3Fxe4ueIRUu461dJc2s
         8EjMpSUlSRM8otEYkfUPW56z4REJQB2jBOcRX12sNuahPYy76cArzoN/kiliRn65uWiq
         GTqxMb+sS8y7yCPbnqbdRDYRFf7zXVwXKrxhLmxD8zFkHFXlBuYEzs2jSZPaYlSopD3v
         LdAg==
X-Gm-Message-State: AOJu0Yx9SaeG4Cg14nQwZTS6QNPOcO/DlRUThylljfML8pxjHdrnFl6d
	rmr0oZ2rr7ZcjfoHa7G/u249xuxBCthhDsQIdmDrQg==
X-Google-Smtp-Source: AGHT+IFpzmZKaLlTVxosn15d+6B50NWZg8obUK6SdFhtB5RUiAGxPPRVNxEnJrqqe0a+Q9rxMcRbHovCoCaNWexheKI=
X-Received: by 2002:a2e:954b:0:b0:2ca:3073:1a4b with SMTP id
 t11-20020a2e954b000000b002ca30731a4bmr1771180ljh.73.1702280851156; Sun, 10
 Dec 2023 23:47:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211035243.15774-1-liangchen.linux@gmail.com> <20231211035243.15774-5-liangchen.linux@gmail.com>
In-Reply-To: <20231211035243.15774-5-liangchen.linux@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Dec 2023 09:46:55 +0200
Message-ID: <CAC_iWjJX3ixPevJAVpszx7nVMb99EtmEeeQcoqxd0GWocK0zkw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 4/4] skbuff: Optimization of SKB coalescing
 for page pool
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com, 
	almasrymina@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Liang,

On Mon, 11 Dec 2023 at 05:53, Liang Chen <liangchen.linux@gmail.com> wrote:
>
> In order to address the issues encountered with commit 1effe8ca4e34
> ("skbuff: fix coalescing for page_pool fragment recycling"), the
> combination of the following condition was excluded from skb coalescing:
>
> from->pp_recycle = 1
> from->cloned = 1
> to->pp_recycle = 1
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

As I said in the past the patch look correct. I don't like the fact
that more pp internals creep into the default network stack, but
perhaps this is fine with the bigger adoption?
Jakub any thoughts/objections?

Thanks
/Ilias
> ---
>  include/net/page_pool/helpers.h |  5 ++++
>  net/core/skbuff.c               | 41 +++++++++++++++++++++++----------
>  2 files changed, 34 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index d0c5e7e6857a..0dc8fab43bef 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -281,6 +281,11 @@ static inline long page_pool_unref_page(struct page *page, long nr)
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
> @@ -947,6 +947,24 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data, bool napi_safe)
>         return napi_pp_put_page(virt_to_page(data), napi_safe);
>  }
>
> +/**
> + * skb_pp_frag_ref() - Increase fragment reference count of a page
> + * @page:      page of the fragment on which to increase a reference
> + *
> + * Increase fragment reference count (pp_ref_count) on a page, but if it is
> + * not a page pool page, fallback to increase a reference(_refcount) on a
> + * normal page.
> + */
> +static void skb_pp_frag_ref(struct page *page)
> +{
> +       struct page *head_page = compound_head(page);
> +
> +       if (likely(is_pp_page(head_page)))
> +               page_pool_ref_page(head_page);
> +       else
> +               page_ref_inc(head_page);
> +}
> +
>  static void skb_kfree_head(void *head, unsigned int end_offset)
>  {
>         if (end_offset == SKB_SMALL_HEAD_HEADROOM)
> @@ -5769,17 +5787,12 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
>                 return false;
>
>         /* In general, avoid mixing page_pool and non-page_pool allocated
> -        * pages within the same SKB. Additionally avoid dealing with clones
> -        * with page_pool pages, in case the SKB is using page_pool fragment
> -        * references (page_pool_alloc_frag()). Since we only take full page
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
> -       if (to->pp_recycle != from->pp_recycle ||
> -           (from->pp_recycle && skb_cloned(from)))
> +       if (to->pp_recycle != from->pp_recycle)
>                 return false;
>
>         if (len <= skb_tailroom(to)) {
> @@ -5836,8 +5849,12 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
>         /* if the skb is not cloned this does nothing
>          * since we set nr_frags to 0.
>          */
> -       for (i = 0; i < from_shinfo->nr_frags; i++)
> -               __skb_frag_ref(&from_shinfo->frags[i]);
> +       if (from->pp_recycle)
> +               for (i = 0; i < from_shinfo->nr_frags; i++)
> +                       skb_pp_frag_ref(skb_frag_page(&from_shinfo->frags[i]));
> +       else
> +               for (i = 0; i < from_shinfo->nr_frags; i++)
> +                       __skb_frag_ref(&from_shinfo->frags[i]);
>
>         to->truesize += delta;
>         to->len += len;
> --
> 2.31.1
>

