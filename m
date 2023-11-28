Return-Path: <netdev+bounces-51713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00547FBD93
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BDE31F20F60
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6B35C08A;
	Tue, 28 Nov 2023 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKUqiqVf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8F41B6
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:00:55 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bb92811c0so823021e87.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701183654; x=1701788454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NES6nd5g/lVeRhs37j0n+GOXRQ0KHQMXVM1KwO/XjHg=;
        b=WKUqiqVfakoegHgFsoXi0sOunkZYHXpt4E17rwfIsQpBtjHq6av9hUUGQHrNt/42cr
         onSOHoZJ1OLEUr2VisOXXnPNH1vS2myO8sePSRA1WpskfVeS9dhVyxq2jL38VHBpOo/m
         oCDBwVb9nKp2KECYLhWukZndN4P9riNHZ6ZS53UciNQBL0M0pz5kdE7LPlDjFsMmiqQn
         G+rQNqlgcLVL3G07A3j+WyY0ud4y8iZHoVQhdqnn6F9FjvdG/UUXdD2ay/pbzemRxfAC
         QF9THt+/ZK7e558NA6n20YPr+zjf8w/vi1kkgIvOCYEvrSh+sTSHjsuxC45MEBAy6Pgv
         uQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183654; x=1701788454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NES6nd5g/lVeRhs37j0n+GOXRQ0KHQMXVM1KwO/XjHg=;
        b=D9KKjY07wyFmobKIKfKQj7JxrMav86NeDLrzySFgDC7QfAJ8gmL82EkampER/Vam7K
         09HcRPhVjGie/LQPIrSoFz0RXcbL1wbIZFwcUovw64ozeuiVTLChiG7qq8au9qAicwR+
         2ll3NM5Uv/wi9Dw6kNmtLWN76+uG4UPLfd9Kj5+d+By5YHaIvnHl4OgQ9MiFKbbS7RXj
         pLlVuSAYVF4P7SNzCaTK/pj8F9c2ASQu2pww65Hu6DnfjdNTCX6mKC6r2GJp7jjS+l6C
         DcvqvlB+TCxlk8o6vEnD+Ns+W2VCDYlgvy62DuSmQb1GWtIuyMCJswEyFey6XxXBF6L2
         3iSg==
X-Gm-Message-State: AOJu0YwS9fOxIOo0cSZdbaPMsoye0oRHcnC9FUGCa4uH5oxTtMITBILV
	RzG0lUmIqRh6H801W70EOkanlwKi1CPtp/kEMropvQ==
X-Google-Smtp-Source: AGHT+IGAJieP/jGmAoJqjMjjuvMALoAs04eBmRkT7EJ7La+c2umfR0ix+rjmIvPSFMFIFSfgUi+PS3cbJV8nbhogmS0=
X-Received: by 2002:a05:6512:1090:b0:50a:a79a:b32f with SMTP id
 j16-20020a056512109000b0050aa79ab32fmr5427495lfg.0.1701183653830; Tue, 28 Nov
 2023 07:00:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126230740.2148636-1-kuba@kernel.org> <20231126230740.2148636-13-kuba@kernel.org>
In-Reply-To: <20231126230740.2148636-13-kuba@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 Nov 2023 17:00:17 +0200
Message-ID: <CAC_iWj+v_fwArpEt0OdUgV=+ZPiYY=vWz0n7YVcsnciBQUYu-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 12/13] net: page_pool: mute the periodic
 warning for visible page pools
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, hawk@kernel.org, dsahern@gmail.com, dtatulea@nvidia.com, 
	willemb@google.com, almasrymina@google.com, shakeelb@google.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Nov 2023 at 01:08, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Mute the periodic "stalled pool shutdown" warning if the page pool
> is visible to user space. Rolling out a driver using page pools
> to just a few hundred hosts at Meta surfaces applications which
> fail to reap their broken sockets. Obviously it's best if the
> applications are fixed, but we don't generally print warnings
> for application resource leaks. Admins can now depend on the
> netlink interface for getting page pool info to detect buggy
> apps.
>
> While at it throw in the ID of the pool into the message,
> in rare cases (pools from destroyed netns) this will make
> finding the pool with a debugger easier.
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/page_pool.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 3d0938a60646..c2e7c9a6efbe 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -897,18 +897,21 @@ static void page_pool_release_retry(struct work_struct *wq)
>  {
>         struct delayed_work *dwq = to_delayed_work(wq);
>         struct page_pool *pool = container_of(dwq, typeof(*pool), release_dw);
> +       void *netdev;
>         int inflight;
>
>         inflight = page_pool_release(pool);
>         if (!inflight)
>                 return;
>
> -       /* Periodic warning */
> -       if (time_after_eq(jiffies, pool->defer_warn)) {
> +       /* Periodic warning for page pools the user can't see */
> +       netdev = READ_ONCE(pool->slow.netdev);
> +       if (time_after_eq(jiffies, pool->defer_warn) &&
> +           (!netdev || netdev == NET_PTR_POISON)) {
>                 int sec = (s32)((u32)jiffies - (u32)pool->defer_start) / HZ;
>
> -               pr_warn("%s() stalled pool shutdown %d inflight %d sec\n",
> -                       __func__, inflight, sec);
> +               pr_warn("%s() stalled pool shutdown: id %u, %d inflight %d sec\n",
> +                       __func__, pool->user.id, inflight, sec);
>                 pool->defer_warn = jiffies + DEFER_WARN_INTERVAL;
>         }
>
> --
> 2.42.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

