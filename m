Return-Path: <netdev+bounces-55754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB5D80C227
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 08:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AEF1F20F03
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 07:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB363208A4;
	Mon, 11 Dec 2023 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7iZE7XG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3803DB
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 23:41:36 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9fe0b5b28so52545201fa.1
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 23:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702280495; x=1702885295; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XBwI88SQDIsN0D58/V5UJQ9tH17Zk+4ZYEgPWMkgers=;
        b=N7iZE7XGeG28lSX7wMZPTF9PbcUWk/zsCp4D0GMKQgN2vN3Pmr5XFK5SSPDjJ8XVWa
         TwAgjXT++zpOMQxGeDQXh+1vaG78LLkfjGsDzSs2dt3L175ckn6Q4Osrhupd/x/VUo90
         Iy/yHfAiKiOjCeetyDf8OzD4Xtp0zRyk8zX+4pHf/nkKRNe/ZFxWPFdRMSAcU7+WTCu0
         mbRHjFEt9OjZtc5CxT+WNZbaF5ZfOLB1iD9C6wJcuxzgJIRRymaxiHorGzJoopZM7opo
         O9LRlTSwog/vnL4/5V7DIfTMmzh/xCie/tU02gKJbDTVyc79PZkmXDMkAQyS3XxwMDBi
         viiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702280495; x=1702885295;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBwI88SQDIsN0D58/V5UJQ9tH17Zk+4ZYEgPWMkgers=;
        b=WkflmrFcj95jsm230CfhoCPFszq3q9O3SLIU6yVFRXmsMTH6Exe/1EDeTWAhDzZXW9
         YKDUhgWvt+pxgtJOLVMb66jhfdUyuLl8Osu6F9IMTybQVrJzY/Qlb5vxozHATvZ/vwDu
         bTppvrm4lFxsg0jU+A+wi4Vfz02zQoY4QdlMywwAK6f/fk7c7ldJ1CbzQVs3tgs13XvV
         41wjBGQaOi8KTfb/fjlYMxTFC3z/zviPsKCPrC+I9yCFyIAN8556SNxLko6TZQ+iSTmn
         52mzigbBYrnbsTtRc+apZ1WR9CVY9r3lLJneMeNopxy7MDfs4o2KmL+NJTFQmrqu15hv
         nyRA==
X-Gm-Message-State: AOJu0YyHNQdplKDXiMUG2Abl+by+Qhvg/lyJ3xxWwWZd6nLexJhxS7tT
	+x8L5RiIfSFJ+oMPm9D7p9+tvsJx8z6V17MxTj19mA==
X-Google-Smtp-Source: AGHT+IE0FxwhynDfEFp9dL20PTJb0bQr1nh8nrjq0L9u7H3Ty5QuLeeqsEuf4uAla08tnuXbEcUWRIvjsIwtEm4Gg8E=
X-Received: by 2002:a2e:8ecc:0:b0:2c9:f8e4:1b4a with SMTP id
 e12-20020a2e8ecc000000b002c9f8e41b4amr1623892ljl.82.1702280494899; Sun, 10
 Dec 2023 23:41:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211035243.15774-1-liangchen.linux@gmail.com> <20231211035243.15774-4-liangchen.linux@gmail.com>
In-Reply-To: <20231211035243.15774-4-liangchen.linux@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Dec 2023 09:40:58 +0200
Message-ID: <CAC_iWjKXPnC0Oz_oFi2yKbRVK_Pf_tUbYJn18fbVHj7au9Vhpg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 3/4] skbuff: Add a function to check if a page
 belongs to page_pool
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com, 
	almasrymina@google.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Dec 2023 at 05:53, Liang Chen <liangchen.linux@gmail.com> wrote:
>
> Wrap code for checking if a page is a page_pool page into a
> function for better readability and ease of reuse.
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  net/core/skbuff.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index b157efea5dea..7e26b56cda38 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -890,6 +890,11 @@ static void skb_clone_fraglist(struct sk_buff *skb)
>                 skb_get(list);
>  }
>
> +static bool is_pp_page(struct page *page)
> +{
> +       return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
> +}
> +
>  #if IS_ENABLED(CONFIG_PAGE_POOL)
>  bool napi_pp_put_page(struct page *page, bool napi_safe)
>  {
> @@ -905,7 +910,7 @@ bool napi_pp_put_page(struct page *page, bool napi_safe)
>          * and page_is_pfmemalloc() is checked in __page_pool_put_page()
>          * to avoid recycling the pfmemalloc page.
>          */
> -       if (unlikely((page->pp_magic & ~0x3UL) != PP_SIGNATURE))
> +       if (unlikely(!is_pp_page(page)))
>                 return false;
>
>         pp = page->pp;
> --
> 2.31.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

