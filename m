Return-Path: <netdev+bounces-16053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC9074B2D1
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 16:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706D8281731
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 14:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E39AD306;
	Fri,  7 Jul 2023 14:11:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7212CD2F7
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 14:11:36 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376982130
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 07:11:13 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4036bd4fff1so293691cf.0
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 07:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688739064; x=1691331064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdnLTT4JCt90wkeJGmC/HjgQ5m+tscK4nAijns8KOio=;
        b=j0SlKvt2511C5nadhEPon0P7dV+dqSMWNCWBMfR4shNkvOmSRHOQtp3PRBpDJbUtqV
         LErUedAdi942BuNamsG/SkhPsgd66HfeMb4AZWGvNEs27dWQBfWgI7adw4nJlamtGDzz
         wFVjY2SHCoEfr8V6xrag4ooc94OXuachyhFvLkSJ91KaWi182Cv+UZAjDTIkdOzWBxHM
         PG4cgmpK/NFUGQnfwtldbGZ5o27f/R62mHg2kTHiqGrtS0eRwziVnKULTgj2UzobPkoR
         yLvEUAVB6LiBhf3IfzeaAA5k7I5AFHz9e7rqORteXUjcyvlkLQBi1IjdK8tWGHaZb8sY
         cn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688739064; x=1691331064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdnLTT4JCt90wkeJGmC/HjgQ5m+tscK4nAijns8KOio=;
        b=j/hZYJkL1OdsLBTPMzqVo5QQ7m9H6lPVnuw9GwjX9COuU2qxen9wv4kVcKy4M33jLf
         of1abzLn3JtZx93TxbcDNPKAy9fQzEqrG+X8LnQZBHvuUps/TVMUEWZff13YE/rRLt4e
         kdBwA/YOUMJWqiW83R8m+yd9YFvFkYNtGZ8vW+eJwtMR4sdbACTXD2Tj2hOZGJ84qGVL
         oFm43h6FhviDcxI/VtaxAlHo1o4Mu20t8LM1nXKdTS262xk61KHFkAvsep31HnBj7JxF
         NZH7xGPYEm7J+Zz5jhpcGIm4prsnxoIxA7p8XoebizxiOxqXg3/IHGuPtPaEpWnNaES7
         UnJw==
X-Gm-Message-State: ABy/qLbOFLXzBbGnQEh0uGQGJUX8olprb2Wll42D1iMf452NCQ+zpDRu
	kghc0EzTuuoYco2zx7n56Z7jpJ9hVrnsuqvZAKO+VA==
X-Google-Smtp-Source: APBJJlEzbETEhMEwug0SDPlMg0K1xrw4IsUNkxXSdABNKpxfPU/SjTZGjXLumt46GHiuOD+OemnVrOIHODB4PVjUVyM=
X-Received: by 2002:a05:622a:204:b0:3f9:a770:7279 with SMTP id
 b4-20020a05622a020400b003f9a7707279mr158118qtx.9.1688739064424; Fri, 07 Jul
 2023 07:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707101701.2474499-1-william.xuanziyang@huawei.com>
In-Reply-To: <20230707101701.2474499-1-william.xuanziyang@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Jul 2023 16:10:53 +0200
Message-ID: <CANn89i+qfg_PHT7gPfEMwwZcxx-P7bB8ShYrYZM7exvBYHwSQw@mail.gmail.com>
Subject: Re: [PATCH net] ipv6/addrconf: fix a potential refcount underflow for idev
To: Ziyang Xuan <william.xuanziyang@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, hannes@stressinduktion.org, 
	fbl@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 7, 2023 at 12:17=E2=80=AFPM Ziyang Xuan
<william.xuanziyang@huawei.com> wrote:
>
> Now in addrconf_mod_rs_timer(), reference idev depends on whether
> rs_timer is not pending. Then modify rs_timer timeout.
>
> There is a time gap in [1], during which if the pending rs_timer
> becomes not pending. It will miss to hold idev, but the rs_timer
> is activated. Thus rs_timer callback function addrconf_rs_timer()
> will be executed and put idev later without holding idev. A refcount
> underflow issue for idev can be caused by this.
>
>         if (!timer_pending(&idev->rs_timer))
>                 in6_dev_hold(idev);
>                   <--------------[1]
>         mod_timer(&idev->rs_timer, jiffies + when);
>
> Hold idev anyway firstly. Then call mod_timer() for rs_timer, put
> idev if mod_timer() return 1. This modification takes into account
> the case where "when" is 0.
>
> Fixes: b7b1bfce0bb6 ("ipv6: split duplicate address detection and router =
solicitation timer")
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> ---
>  net/ipv6/addrconf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 5479da08ef40..d36e6c5e3081 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -318,9 +318,9 @@ static void addrconf_del_dad_work(struct inet6_ifaddr=
 *ifp)
>  static void addrconf_mod_rs_timer(struct inet6_dev *idev,
>                                   unsigned long when)
>  {
> -       if (!timer_pending(&idev->rs_timer))
> -               in6_dev_hold(idev);
> -       mod_timer(&idev->rs_timer, jiffies + when);
> +       in6_dev_hold(idev);
> +       if (mod_timer(&idev->rs_timer, jiffies + when))
> +               in6_dev_put(idev);
>  }
>


All callers own an implicit or explicit reference to idev, so you can
use the traditional

if (!mod_timer(&idev->rs_timer, jiffies + when))
     in6_dev_hold(idev);

