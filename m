Return-Path: <netdev+bounces-55686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBB080BFE3
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 04:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7CA280C54
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 03:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AE615E8B;
	Mon, 11 Dec 2023 03:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDkB5k+L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC42ED
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 19:31:21 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9efa1ab7fso48473601fa.0
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 19:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702265480; x=1702870280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQSL4X30hGfSGTxRuYdgtKDfvYwjWus1QS3Y5VELUiA=;
        b=NDkB5k+LkF9u3Oa8b/KMMIzsvn+yhxbHdqFmibM+brgHIJNCN8SCLaqv6RPh1GU5FS
         r9lk5Xvf+qK2vpmPSw1/twvmL+LeGFukYkDiLElT644zAXDB1d2s9/IXexr0OcnbMhk0
         D8e6YOSAbd5q8AgcKNOn83gDKLSKPZqnV2YmIEOMwqVG9jtLnM5ytQy2kmH9e7QHzPpi
         yA9iuX2NdhzJ5AyxzPFJF+zEX4CqQ/WG6KXge44ay9RyqdR4PvRxYHa+ZH4DQFwriTYc
         xWnH5un7OU2KqYbCCpZ7f7qJwXtINr17RXulZTcrTOpf14L+fQCru+FWylv64HLY/2kq
         B/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702265480; x=1702870280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQSL4X30hGfSGTxRuYdgtKDfvYwjWus1QS3Y5VELUiA=;
        b=aApiu0mL1+0hGULCYHjGwt54YAQ2EkrOcy+MdXvBBDOPcI3rJYYpGPHrN9vUlOdOK8
         xvpQRVUrtKOxQ6MTr6Lac9ghXV3Myaq+szj+QtDhPXvBwAReQqrttpt/95vBuh4DuvCV
         7dI0llyetCFHZVD3A72fWjw7RTfYNDvF/35oL/aXqJhUq5EeRKlxEZTBUw1TeWRwI9ob
         kl5u7AQEX5ZbjrdHVurpctdeRyMc5JuhjrDrLMUw8bseHF39S8PmtKpqPTNbOw+0gvAC
         vhHAHCIEduum/yqbD4ICwgSJYKkxVq7HeKXJ0eDAbv+EBJl1AJ2Ein8GXKlchaU7MVGn
         Epnw==
X-Gm-Message-State: AOJu0Yxy4WCjGtLJJHNZiXrU0Ey3fqmAwtfGzNqjxsxNbPocutSmxiK0
	sbydxwmEFQgXuexrl21Mj5jA6OsJH8rtEByMB9E=
X-Google-Smtp-Source: AGHT+IE1adiREpDOlI+/gfB18LJB7AaiHcJG2gpFXbiATLuTpugOdaHu3uWiIuOgFyFgQyY/HhAeJsPRdtGCmB+Di+Q=
X-Received: by 2002:a2e:9d51:0:b0:2c9:f658:6a37 with SMTP id
 y17-20020a2e9d51000000b002c9f6586a37mr600097ljj.66.1702265479415; Sun, 10 Dec
 2023 19:31:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206105419.27952-1-liangchen.linux@gmail.com>
 <20231206105419.27952-2-liangchen.linux@gmail.com> <20231208173816.2f32ad0f@kernel.org>
In-Reply-To: <20231208173816.2f32ad0f@kernel.org>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Mon, 11 Dec 2023 11:31:06 +0800
Message-ID: <CAKhg4tKXfos+M=rmu25B=dCmS_uzmBy743BB=6NBZgBMWnHobA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/4] page_pool: transition to reference count
 management after page draining
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 9:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  6 Dec 2023 18:54:16 +0800 Liang Chen wrote:
> > -/* pp_frag_count represents the number of writers who can update the p=
age
> > +/* pp_ref_count represents the number of writers who can update the pa=
ge
> >   * either by updating skb->data or via DMA mappings for the device.
> >   * We can't rely on the page refcnt for that as we don't know who migh=
t be
> >   * holding page references and we can't reliably destroy or sync DMA m=
appings
> >   * of the fragments.
> >   *
> > - * When pp_frag_count reaches 0 we can either recycle the page if the =
page
> > + * pp_ref_count initially corresponds to the number of fragments. Howe=
ver,
> > + * when multiple users start to reference a single fragment, for examp=
le in
> > + * skb_try_coalesce, the pp_ref_count will become greater than the num=
ber of
> > + * fragments.
> > + *
> > + * When pp_ref_count reaches 0 we can either recycle the page if the p=
age
> >   * refcnt is 1 or return it back to the memory allocator and destroy a=
ny
> >   * mappings we have.
> >   */
>
> Sorry to nit pick but I think this whole doc has to be rewritten
> completely. It does state the most important thing which is that
> the caller must have just allocated the page.
>
> How about:
>
> /**
>  * page_pool_fragment_page() - split a fresh page into fragments
>  * @.. fill these in
>  *
>  * pp_ref_count represents the number of outstanding references
>  * to the page, which will be freed using page_pool APIs (rather
>  * than page allocator APIs like put_page()). Such references are
>  * usually held by page_pool-aware objects like skbs marked for
>  * page pool recycling.
>  *
>  * This helper allows the caller to take (set) multiple references
>  * to a freshly allocated page. The page must be freshly allocated
>  * (have a pp_ref_count of 1). This is commonly done by drivers
>  * and "fragment allocators" to save atomic operations - either
>  * when they know upfront how many references they will need; or
>  * to take MAX references and return the unused ones with a single
>  * atomic dec(), instead of performing multiple atomic inc()
>  * operations.
>  */
>
> I think that's more informative at this stage of evolution of
> the  page pool API, when most users aren't experts on internals.
> But feel free to disagree..
>

Thanks for the help! This is certainly better.

> >  static inline void page_pool_fragment_page(struct page *page, long nr)
> >  {
> > -     atomic_long_set(&page->pp_frag_count, nr);
> > +     atomic_long_set(&page->pp_ref_count, nr);
> >  }
>
> The code itself and rest of the patches LGTM, although it would be
> great to get ACKs from pp maintainers..

