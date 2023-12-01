Return-Path: <netdev+bounces-52881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1A680084C
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 11:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C9F1B21136
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 10:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623E014275;
	Fri,  1 Dec 2023 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wxuYFJJ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778E8F1
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 02:35:28 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9c39b7923so25713151fa.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 02:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701426927; x=1702031727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LYWWJmccuk3pmnu+6VAt2vzSATSgd9B73Hxs2lwVQqw=;
        b=wxuYFJJ01aaZcVKg5V8o1Ka515HyKsN6pznKVgFCbxnTHdQ5a+BJLJVadBLsXCIk9l
         gwxrUP823sHv/bOadCCqNToVINWTIFENvIJC4tlrKd9byNvMA7beZwiNDEZyiGe1Bo9w
         RF43KHhk1mia4hNSSLMK9M5H0+UNJxCg5O3M6vlux+H3nzW3bzZ6UbiHZS9wfPDOQSJF
         oHOOEfIDgjqZN0uKJ9CLt+e5Y3bj7m39RGOwWtznMyuR/FArMjEZzELylwbvf+3eqAY4
         QU1Lp1FcbAm+V8mu8Bvhu5dAe7orIYHmpzS2p7Gj5zW8fz3JCGeRUHWwC7yYiPPVWpXD
         I/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701426927; x=1702031727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYWWJmccuk3pmnu+6VAt2vzSATSgd9B73Hxs2lwVQqw=;
        b=wb8UtHWhiHbRXQG6MBLSydHJTBNseZiFsewgGX2TQcXVbagUeupT6S4jenE3pxoAn8
         eq5NJ+U0m0t7zYZHZIP/yY3y11KN26LYM6OfsQVRuUBxqETw1q1IsoyQEYadFewmMxIA
         WudVGg2jL7ZG+G4OCQ/eTi+IMYM3b+I/FFUyIjffTgVOKYAQaWaB/TGDYHVwdocHaigt
         S4+CwJCOIK+a5lyvh9YV7OQrCFGP/IX+D+B8kT/o8WKuzLpZqU+rojrxmU4aOWoQ+lD3
         KyOD2EzdoBg0gFWlqDWiG9x0LDf7wIshxEmb8lbz3yhtjuLv1Z3LAl/8Y3BCVtz9NZ1e
         dWXw==
X-Gm-Message-State: AOJu0YzB7dMkQW4GPlQxOaj+wIfySRD/pygE/VoOnL5qRdS49siWjqhH
	Zfjidksd9zz8O3wE1Pb48/zC+h4cXyD4zc6stC35vQ==
X-Google-Smtp-Source: AGHT+IF1SwSHApiul0brKGkeM/rT+9In35ZMqPnEuzPqvKgKCwtxBY9cwHSgRoM+AkCTdsM9i1XD/EuSkZ+VQHXSYkg=
X-Received: by 2002:a2e:87d9:0:b0:2c9:d862:c64b with SMTP id
 v25-20020a2e87d9000000b002c9d862c64bmr603662ljj.56.1701426926712; Fri, 01 Dec
 2023 02:35:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130115611.6632-1-liangchen.linux@gmail.com> <20231130115611.6632-5-liangchen.linux@gmail.com>
In-Reply-To: <20231130115611.6632-5-liangchen.linux@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 1 Dec 2023 12:34:50 +0200
Message-ID: <CAC_iWj+ku5Mk99ezVdC4HhNWK=Ea83Ps-qaQq=_-fzVoWZ8sYQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/4] skbuff: Optimization of SKB coalescing
 for page pool
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"

HI Liang,

[...]

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
> +       if (likely(skb_frag_is_pp_page(head_page)))
> +               page_pool_ref_page(head_page);
> +       else
> +               page_ref_inc(head_page);

I think I've mentioned this in the past, but I think shoehorning page
pool awareness in the skbuff is not the direction we want to go. Up to
now, we've tried hard to make that as seamless as possible.
The code looks correct, but I'd prefer people with a better
understanding of the core network stack to comment on this.

[...]

Thanks
/Ilias

