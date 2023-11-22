Return-Path: <netdev+bounces-50001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BF47F439E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B06F2816F8
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9C351020;
	Wed, 22 Nov 2023 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PU25IUMN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704B710CA
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 02:21:24 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so12408a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 02:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700648483; x=1701253283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3S4IUo03NQM4q0Z/xFammLBTqW5STPxiyfl/nQVTRk=;
        b=PU25IUMNlH2J1UnofKlR73bQeaYCu5j39yOt8WBdQN5s5aOzUypgmJmKmJLqsAU69T
         DhvwT+inCQSS4dtYYiFQRfqzKk+QWGgBfZp7s0A9z1r74ng6evZ3VssqzEB/t6fBmLjF
         AaNEyD28RtC/8MO1fkrmUlzgB6TmJjwO2A2B37wOiF9wvaqJgR8qhc/ASBHbYmD8eHMG
         gLGs8OcLFWAWVnQCNiQy4NpY8wTuD2P1gQH0DedzNuf7+dJVZe7Qg9UfbpnWX3bNOlXY
         TJ7j9AqOciZvUDcnKWp1K15aRWQhsjJEcUuMe5LK8UeO0eYAAvSx2YBQ5ox/hu65+ums
         hEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700648483; x=1701253283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3S4IUo03NQM4q0Z/xFammLBTqW5STPxiyfl/nQVTRk=;
        b=BnBeXF70yBcjIGJtXHzxj7lMnC36kjFhvlwwmHO9CZv9ZK0xofcrsLkWRA9jywhyPt
         a9aw4PCcjf7nxgznihqvPCuY36PpyKxu5WSJ+hlL77tc7QHBGCXuVVADgcMYvE+9YnKg
         iJMAR9gOQLa8UreeuY2sLlehFBQQHSoYiVGlFmOXizbQJMutfLM3OKxDk0PDRvF5p2Bx
         mbPloOWaidWm2MV5O7F/OmrV/GQl0BthwBQigRoYY5Gj8MQJQWfn7kqenjguutoj6apv
         CNpJ8U8RezKZVOEmX1/kNTg/MAxaKM/1mlyoXdP9sr3NDg7barI9Yo9DVhoiaHh+aWQh
         Qhcg==
X-Gm-Message-State: AOJu0YzN9XNBXBeb900D2rSHlBeBQJE4lxveJVjNayQyHukX3BzSfqHj
	mP17SVlWl8ALhdXUQ6pr2GistQrQjWNeVabiHZyNBA==
X-Google-Smtp-Source: AGHT+IGpdYMUQTKDGny0BsvursLR5GWD05ccctJSS91xPWdkKw0OS9Rm8sqIBgb860biowEQbw7SGsbiTebuQM0W/ko=
X-Received: by 2002:a05:6402:d67:b0:548:c1b1:96b2 with SMTP id
 ec39-20020a0564020d6700b00548c1b196b2mr111065edb.6.1700648482586; Wed, 22 Nov
 2023 02:21:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122034420.1158898-1-kuba@kernel.org> <20231122034420.1158898-11-kuba@kernel.org>
In-Reply-To: <20231122034420.1158898-11-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Nov 2023 11:21:11 +0100
Message-ID: <CANn89iK2BjePynZsM7pPMNc9jWJY716k_YT=bZ9wKE5aUhuZ-A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 10/13] net: page_pool: report when page pool
 was destroyed
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Report when page pool was destroyed. Together with the inflight
> / memory use reporting this can serve as a replacement for the
> warning about leaked page pools we currently print to dmesg.
>
> Example output for a fake leaked page pool using some hacks
> in netdevsim (one "live" pool, and one "leaked" on the same dev):
>
> $ ./cli.py --no-schema --spec netlink/specs/netdev.yaml \
>            --dump page-pool-get
> [{'id': 2, 'ifindex': 3},
>  {'id': 1, 'ifindex': 3, 'destroyed': 133, 'inflight': 1}]
>
> Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml | 13 +++++++++++++
>  include/net/page_pool/types.h           |  1 +
>  include/uapi/linux/netdev.h             |  1 +
>  net/core/page_pool.c                    |  1 +
>  net/core/page_pool_priv.h               |  1 +
>  net/core/page_pool_user.c               | 12 ++++++++++++
>  6 files changed, 29 insertions(+)
>
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netl=
ink/specs/netdev.yaml
> index 85209e19dca9..695e0e4e0d8b 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -125,6 +125,18 @@ name: netdev
>          type: uint
>          doc: |
>            Amount of memory held by inflight pages.
> +      -
> +        name: detach-time
> +        type: uint
> +        doc: |
> +          Seconds in CLOCK_BOOTTIME of when Page Pool was detached by
> +          the driver. Once detached Page Pool can no longer be used to
> +          allocate memory.
> +          Page Pools wait for all the memory allocated from them to be f=
reed
> +          before truly disappearing. "Detached" Page Pools cannot be
> +          "re-attached", they are just waiting to disappear.
> +          Attribute is absent if Page Pool has not been detached, and
> +          can still be used to allocate new memory.
>
>  operations:
>    list:
> @@ -176,6 +188,7 @@ name: netdev
>              - napi-id
>              - inflight
>              - inflight-mem
> +            - detach-time
>        dump:
>          reply: *pp-reply
>        config-cond: page-pool
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index 7e47d7bb2c1e..ac286ea8ce2d 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -193,6 +193,7 @@ struct page_pool {
>         /* User-facing fields, protected by page_pools_lock */
>         struct {
>                 struct hlist_node list;
> +               u64 detach_time;
>                 u32 napi_id;
>                 u32 id;
>         } user;
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index 26ae5bdd3187..756410274120 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -70,6 +70,7 @@ enum {
>         NETDEV_A_PAGE_POOL_NAPI_ID,
>         NETDEV_A_PAGE_POOL_INFLIGHT,
>         NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
> +       NETDEV_A_PAGE_POOL_DETACH_TIME,
>
>         __NETDEV_A_PAGE_POOL_MAX,
>         NETDEV_A_PAGE_POOL_MAX =3D (__NETDEV_A_PAGE_POOL_MAX - 1)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 566390759294..a821fb5fe054 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -953,6 +953,7 @@ void page_pool_destroy(struct page_pool *pool)
>         if (!page_pool_release(pool))
>                 return;
>
> +       page_pool_detached(pool);
>         pool->defer_start =3D jiffies;
>         pool->defer_warn  =3D jiffies + DEFER_WARN_INTERVAL;
>
> diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
> index 72fb21ea1ddc..90665d40f1eb 100644
> --- a/net/core/page_pool_priv.h
> +++ b/net/core/page_pool_priv.h
> @@ -6,6 +6,7 @@
>  s32 page_pool_inflight(const struct page_pool *pool, bool strict);
>
>  int page_pool_list(struct page_pool *pool);
> +void page_pool_detached(struct page_pool *pool);
>  void page_pool_unlist(struct page_pool *pool);
>
>  #endif
> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> index d889b347f8f4..f28ad2179f53 100644
> --- a/net/core/page_pool_user.c
> +++ b/net/core/page_pool_user.c
> @@ -134,6 +134,10 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct =
page_pool *pool,
>             nla_put_uint(rsp, NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
>                          inflight * refsz))
>                 goto err_cancel;
> +       if (pool->user.detach_time &&
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_DETACH_TIME,

You need nla_put_u64_64bit() here

Reviewed-by: Eric Dumazet <edumazet@google.com>

