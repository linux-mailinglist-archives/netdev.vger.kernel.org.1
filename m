Return-Path: <netdev+bounces-28626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA8077FFF7
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBB81C21536
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B041B7EF;
	Thu, 17 Aug 2023 21:31:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F3E1ADDD
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:31:59 +0000 (UTC)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1744FE55
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:31:58 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7a006828e99so104544241.0
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692307917; x=1692912717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t40cZD0TAIwb+6nf1Dze5V0nzRLjUoxxNtnoaFU9AFY=;
        b=ooKPUYfc3cW54GtEtBGJvCN6AqLoJGirhoVLZvr+8DY5w3/ewtXNZWWlScx1Eucu+D
         ADDGT8DC8ZtU5ydzoyKeM/+aQg2F2Plpf8riV90IBvhEEDzSIIr2JmhLb+ywV2c/WRig
         3OH6i6Dm6OilVYLirQqtZc4ib7WWRFDucHJKXyhYnaG1Gh4gCDG4VPHQ9vX/v/57jPYQ
         JzAQY/KDOXBVdm0HtoqXmq9atjPMI2rI5c4m3slKwGF4okgCS69nC5q6yV7XD59E2UxE
         G62lixV6TzgHR9NhvUEaF5FWR0/yME5XpWYer4wnIm1JeHyqD2YtQJyjN90+vqnbI8AI
         lQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692307917; x=1692912717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t40cZD0TAIwb+6nf1Dze5V0nzRLjUoxxNtnoaFU9AFY=;
        b=RILsB4STyhiomavoGilHXk4h4FJSLswZDMZg69BSu0qPZOoy6tFRTqD6uP2upN+QLR
         /Yo0WdvxdFOGqjhGnpQFGHgNKTPC5uXobV1SAr8DCXimT/qZ+omsNABVDLh35PRL+bBp
         9OwwVEEiQAOpzRi+zta9M+oAyq+tJ4Toi75r8lMCD3PU5wkdjoyYeoWnANfiZm8DqG+v
         YipgT8WNdE//IJ7cfaH+QuX0mX7csxAHEK7GQSmksA2cwr96fmTS1jVBsYUPNEFhCn3V
         JqpA54XqftLtwk/dg+ggkUVhUFA9nmt6pRm1g6E+dEBTi6PADkjhCCVzQd8O+0b5+Bzd
         LvlA==
X-Gm-Message-State: AOJu0YxuVbdUlyOmmD48Qog4IKxO8SXC9Bg7SCwKrFndYEjnliv8TbRA
	hsHw05BUiF8HeoKrQ+yuFVo+TNYbNooVNJoS9jezU7+BChdpukt8dcAymQ==
X-Google-Smtp-Source: AGHT+IFNU0r5289npvJmG5hbYsET9muWM/61SUFawopVUg47cYvPhIMgikrEsuqEHqbAojwn4H24gRbmaR2G07M3a6A=
X-Received: by 2002:a05:6102:3644:b0:44a:cd5a:fb8f with SMTP id
 s4-20020a056102364400b0044acd5afb8fmr1244605vsu.29.1692307917079; Thu, 17 Aug
 2023 14:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816234303.3786178-1-kuba@kernel.org> <20230816234303.3786178-3-kuba@kernel.org>
In-Reply-To: <20230816234303.3786178-3-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 17 Aug 2023 14:31:46 -0700
Message-ID: <CAHS8izO-OYz5RR1uk0E7oG+0kfr6PmkeJ5QTD7JrcmKcN2K4nQ@mail.gmail.com>
Subject: Re: [RFC net-next 02/13] net: page_pool: avoid touching slow on the fastpath
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	aleksander.lobakin@intel.com, linyunsheng@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 4:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> To fully benefit from previous commit add one byte of state
> in the first cache line recording if we need to look at
> the slow part.
>
> The packing isn't all that impressive right now, we create
> a 7B hole. I'm expecting Olek's rework will reshuffle this,
> anyway.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/page_pool/types.h | 2 ++
>  net/core/page_pool.c          | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index 1c16b95de62f..1ac7ce25fbd4 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -127,6 +127,8 @@ struct page_pool_stats {
>  struct page_pool {
>         struct page_pool_params_fast p;
>
> +       bool has_init_callback;
> +

Nit: I wonder if it's slightly more appropriate for this to be
has_slow, given how I understand the intent of usage, but it doesn't
really matter. Either way,:

Reviewed-by: Mina Almasry <almasrymina@google.com>

>         long frag_users;
>         struct page *frag_page;
>         unsigned int frag_offset;
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index ffe7782d7fc0..2c14445a353a 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -216,6 +216,8 @@ static int page_pool_init(struct page_pool *pool,
>             pool->p.flags & PP_FLAG_PAGE_FRAG)
>                 return -EINVAL;
>
> +       pool->has_init_callback =3D !!pool->slow.init_callback;
> +
>  #ifdef CONFIG_PAGE_POOL_STATS
>         pool->recycle_stats =3D alloc_percpu(struct page_pool_recycle_sta=
ts);
>         if (!pool->recycle_stats)
> @@ -373,7 +375,7 @@ static void page_pool_set_pp_info(struct page_pool *p=
ool,
>  {
>         page->pp =3D pool;
>         page->pp_magic |=3D PP_SIGNATURE;
> -       if (pool->slow.init_callback)
> +       if (pool->has_init_callback)
>                 pool->slow.init_callback(page, pool->slow.init_arg);
>  }
>
> --
> 2.41.0
>


--=20
Thanks,
Mina

