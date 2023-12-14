Return-Path: <netdev+bounces-57235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF04A8127C2
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 07:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DAB3B20B48
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 06:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763B6CA61;
	Thu, 14 Dec 2023 06:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UVxKT+w0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977BA93
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 22:12:27 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c9f4bb2e5eso107216711fa.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 22:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702534345; x=1703139145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QoMtJ3jc9LwNpjNyh0O2VvaOvQmiL70UQU5xKazHWoo=;
        b=UVxKT+w0FO8ajAQ7zyqX/YMjt5jOmkunzTqc2wzCo/FWZ183AM8HQUJBpzIcUQTU+h
         +8GGj2NI7IbPrDPSAm8kXCQ8gXPOkv1dmXeoR7jfsB9RC9g9xlVEama+N/FCNA4YORav
         y6fDepURMHretwjkhGaLb7n71SOaYvkJSXr0fjbJfezeyRZZKKMZfwBPcbS3Xap13xWx
         kON8/PcvpfRBVg9CCrB0jxDiAYY2nv7umrQtCE7CX7s5ZlJaEY4eu0hgcNyumVS5nT/t
         kNxaJc7JY7jX//c32I4kn/5Ltun3lwGUpPTH1lgBcvHq9miEYGZcm+UrF9FfU/uwBESF
         MLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702534345; x=1703139145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QoMtJ3jc9LwNpjNyh0O2VvaOvQmiL70UQU5xKazHWoo=;
        b=tIeP8WK8c2NvTDMK97r3hjbwenn6kN/Ee23GqYSAmwvauB5nSgxZftoee67H9Xq8ay
         xsmsDslWGgkLZsMa8d4EwqFTHRwwu2qK/3XoLZpgLuMY56lK0jxq50aOb3VCqmHShePo
         e9jR+q/zqyCjRHvjG0Coy6SNdkKWmMbmJPKQp8hQDbMJKvuB+a9Vk6R4kOEZBiWfYD6a
         8ZyYLSMDkO1302TbjTs9VS4MtMxOM0aF4UAD6bnXUF+7++zTJTUVfD7qL8l5N7DNJmDS
         NcYrZGguZ5jUJhH7keJEeeZFWvGNgI+8aodQK9nJMHs16ousmLAYkN6uaoX08XHvuIC7
         X55A==
X-Gm-Message-State: AOJu0YxjHd51NOhTtjbq5Ijj3djk0ayN35DM0qlOU7fHIlEh54tYlZFY
	bHO3KLvbrhvAxCoHdrKma8Hd4/odANXQd3zpUua8bRClYUmbuYp7f6o=
X-Google-Smtp-Source: AGHT+IHHfOj8iCF5VPFr9VjmnsfbVHVZaA2lZst2Zsr9YsfG0dTo8uUZ4LtGHxa8PAWCrALkDyac2fECzljy1/4B0xo=
X-Received: by 2002:a05:651c:1145:b0:2cc:1cc1:586a with SMTP id
 h5-20020a05651c114500b002cc1cc1586amr5175047ljo.19.1702534345503; Wed, 13 Dec
 2023 22:12:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214042833.21316-1-liangchen.linux@gmail.com> <20231214042833.21316-2-liangchen.linux@gmail.com>
In-Reply-To: <20231214042833.21316-2-liangchen.linux@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 14 Dec 2023 08:11:49 +0200
Message-ID: <CAC_iWj+xvjkD27z6xRD2yX30csjaj=yyFFG-1ZoeB4-k2g_0Yw@mail.gmail.com>
Subject: Re: [PATCH net-next v10 2/4] page_pool: halve BIAS_MAX for multiple
 user references of a fragment
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com, 
	almasrymina@google.com, Mina Almasry <almarsymina@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 06:30, Liang Chen <liangchen.linux@gmail.com> wrote:
>
> Up to now, we were only subtracting from the number of used page fragments
> to figure out when a page could be freed or recycled. A following patch
> introduces support for multiple users referencing the same fragment. So
> reduce the initial page fragments value to half to avoid overflowing.
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> Reviewed-by: Mina Almasry <almarsymina@google.com>
> ---
>  net/core/page_pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 106220b1f89c..436f7ffea7b4 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -26,7 +26,7 @@
>  #define DEFER_TIME (msecs_to_jiffies(1000))
>  #define DEFER_WARN_INTERVAL (60 * HZ)
>
> -#define BIAS_MAX       LONG_MAX
> +#define BIAS_MAX       (LONG_MAX >> 1)
>
>  #ifdef CONFIG_PAGE_POOL_STATS
>  /* alloc_stat_inc is intended to be used in softirq context */
> --
> 2.31.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

