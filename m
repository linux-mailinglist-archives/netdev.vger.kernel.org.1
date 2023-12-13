Return-Path: <netdev+bounces-56687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF158107D9
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 02:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BCE281644
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A94A5E;
	Wed, 13 Dec 2023 01:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tv9cev7S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D66CBE
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 17:51:04 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54f5469c211so6345317a12.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 17:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702432263; x=1703037063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVTd+wP+FI3iBMvI4P15hw8Ct9Bf0aO9fRFezq4rPu4=;
        b=Tv9cev7S9Fuu/wmfGJ9ttFnm06c0eWMGvtLq9k4rMjX1O5khLOoSXnrhUJhLHFzcDT
         Pw/I1nROwkwr4jliN5s/MpZngJIUjz+LWwyNvtkLO0LJ9VQyzjuFX9YBW2HoYwN8tzst
         zLDsM+8NemvQdnJCRB1mv6i3usMO+P8NsFzLV5+CC/85FCueO1LklpiqsKUj2yDUrRE5
         oJL8ovkkwU1WLIc7y3gDjE79w3ocxTcykYTH8l9TH9pTmDJMXe7PaIp9bJU6UhyDyCG3
         wydaUerRNDK+ReojbsxD/kvVrfJpFY+VRZR6IqVzXHoGPWkVRyVsHOmGtXTA/cL6SJTf
         C18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702432263; x=1703037063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVTd+wP+FI3iBMvI4P15hw8Ct9Bf0aO9fRFezq4rPu4=;
        b=obNb0rDqvJ+cXc6uxZ4CZ03rVh6eiI3lX43BFZ4KFXCXAAeM1AJQ58IYiu+UWRJLu9
         jAz7uRzKTWpRXNQsxoHZ6OGXO5E7qC6/qRZDzRgvjUPfAIXesSaR4lKdooSoiGPtb0zc
         TP3j7YHWwRpFiP45n3IuehFp5evjmIWFLd21fuk5s/yh4DR9b12EQENoNlhTaDfv20K9
         MF4ycgExsx0JH/tjROQYAySHKgKwSsRB6t8lrXTSATKvp7hR4TA4YDa3nQVLSdnn3OTr
         2WR1sselM5OqHyurNzChRaVGxRy/QzORjHzgfRG91IBOoobPl7nErgEU3zVCELBeGrQ0
         WFxg==
X-Gm-Message-State: AOJu0YzA2neG/Gx3huy+R+nKT3ojzDAd5SuuUBr69GmUrWC8mGMIN4CW
	lDdTHfJKIn0i+xwFdA1F7rChVzuX+YmJK1gRW5i0lg==
X-Google-Smtp-Source: AGHT+IEN+Uc+XpoJwj0S1c7u40M8URzpVc7rJ5edSvTUAtl+/7HDPUMDIk3KFXTM4rg+eqk/Gqh9a8Lx8xlysqXEfTI=
X-Received: by 2002:a17:906:a8b:b0:9bd:9bfe:e40b with SMTP id
 y11-20020a1709060a8b00b009bd9bfee40bmr3933345ejf.75.1702432262757; Tue, 12
 Dec 2023 17:51:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212044614.42733-1-liangchen.linux@gmail.com> <20231212044614.42733-4-liangchen.linux@gmail.com>
In-Reply-To: <20231212044614.42733-4-liangchen.linux@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Dec 2023 17:50:51 -0800
Message-ID: <CAHS8izOk79ajSuZ=-Ca1br12H39vG6YXnHJnd5p6CDCFJz1vTg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/4] skbuff: Add a function to check if a page
 belongs to page_pool
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
> Wrap code for checking if a page is a page_pool page into a
> function for better readability and ease of reuse.
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Only 1 nit, feel free to ignore since especially if Jakub wants to
merge the patch asap.

Reviewed-by: Mina Almasry <almasrymina@google.com>

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
> +       return (page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE;
> +}
> +
>  #if IS_ENABLED(CONFIG_PAGE_POOL)
>  bool napi_pp_put_page(struct page *page, bool napi_safe)
>  {
> @@ -905,7 +910,7 @@ bool napi_pp_put_page(struct page *page, bool napi_sa=
fe)
>          * and page_is_pfmemalloc() is checked in __page_pool_put_page()
>          * to avoid recycling the pfmemalloc page.
>          */
> -       if (unlikely((page->pp_magic & ~0x3UL) !=3D PP_SIGNATURE))
> +       if (unlikely(!is_pp_page(page)))

Nit: I think the unlikely here is unnecessary anyway, and can be
removed (if without else is already unlikely).

>                 return false;
>
>         pp =3D page->pp;
> --
> 2.31.1
>
>


--=20
Thanks,
Mina

