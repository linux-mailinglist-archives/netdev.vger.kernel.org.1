Return-Path: <netdev+bounces-28629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1361780039
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA6E1C21520
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8017B1BB57;
	Thu, 17 Aug 2023 21:56:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED85168D1
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:56:28 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925C035A4
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:56:13 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bd3317144fso302772a34.1
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692309373; x=1692914173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G991xsJ0MaYsy7ZznlOsR6Q7hnUWa5OuJRGDstV5zlc=;
        b=mBdcNF9buzxMoOaS7k9e9BJigIwwWDNbiSJaz9Iq43ODU9Jufwefu9irMnEVGifn1T
         jdOrczZIwsUVcpeactMohRFrY+66jZpegAbH8KmmEjQAr3xTam0aEpTK/iYTkLgMWPHq
         QBMiPpk1f8gG51cvnp04uT1b8jNalGHDxZd04NqlQC6leYks/Z953Tucrc5mZF0cyrFW
         j+7pdahaGxA7Oxq1JdzSnimo2docc6Lwi+MAJfsBUaYHb45A6dxvLYARgaTCLfpg/XkT
         Xf/Uo8g1ad880+dboCPfyWfEWbGj8c3yYIuI4siaPbkw+kejthEVIiJqM6b+TPbXwAXw
         COcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692309373; x=1692914173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G991xsJ0MaYsy7ZznlOsR6Q7hnUWa5OuJRGDstV5zlc=;
        b=RbOMDyVyyHiBneSFNIfNoVEqZh3wDxH5Sgaw/S54PRAIHf+kHmka7okbtiFaOw2YJP
         a5iUlj4gdMYHfoxhWybMwEzpN+j31lH/B5GK2ADR02d/E+A+nlQ+Z8t4E9kmxiX1DErl
         jQYLwyreNrsJZiuDetHT1QjNXlmY0/W3KHOLxLJq7dQtmJWDaJVeS0HryEdinCxXQ7kj
         8uqZcUyVjtSSJGw3Sqsgx+xs8F551t2RDdgyZ3cwZi71DCxp7VOhqIbMgPbKjuZ5DbFB
         CDN6i0I0gXFc8jX5lZNW0RBKOLXNII7e3ht18uapD3747FMI6PgwT6qaSSzCTumxcK3A
         fO4w==
X-Gm-Message-State: AOJu0YxYS9bDWFuGDHJJczfJmc/JvfXzPPbH6F5iAzX6EA9uMx4OyGsx
	5BnElL/V+3wawIm0F7OBvwcMZdyNyL1h6/UnODx8rw==
X-Google-Smtp-Source: AGHT+IG/209dW0yUmXupZ7afJCSjfA40L9NxMyag3Y0PHCNaY7lWyER2S5rEwgbA2Ix9+wk5azlYqq8Ngw7d+udkzjA=
X-Received: by 2002:a05:6358:70c:b0:13a:6cb:4d91 with SMTP id
 e12-20020a056358070c00b0013a06cb4d91mr948365rwj.7.1692309372641; Thu, 17 Aug
 2023 14:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816234303.3786178-1-kuba@kernel.org> <20230816234303.3786178-5-kuba@kernel.org>
In-Reply-To: <20230816234303.3786178-5-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 17 Aug 2023 14:56:01 -0700
Message-ID: <CAHS8izOu=DxeRdD7Gdt-N2qvH_Nnwpcem1KkNgjOLeWzHZ_5JQ@mail.gmail.com>
Subject: Re: [RFC net-next 04/13] net: page_pool: id the page pools
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
> To give ourselves the flexibility of creating netlink commands
> and ability to refer to page pool instances in uAPIs create
> IDs for page pools.
>

Sorry maybe I'm missing something, but it's a bit curious to me that
this ID is needed. An rx queue can only ever have 1 page-pool
associated with it at a time, right? Could you instead add a pointer
to the page_pool into 'struct netdev_rx_queue', and then page-pool can
be referred to by the netdev id & the rx-queue number? Wouldn't that
make the implementation much simpler? I also believe the userspace
refers to the rx-queue by its index number for the ethtool APIs like
adding flow steering rules, so extending that to here maybe makes
sense.

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/page_pool/types.h |  4 ++++
>  net/core/Makefile             |  2 +-
>  net/core/page_pool.c          | 21 +++++++++++++++-----
>  net/core/page_pool_priv.h     |  9 +++++++++
>  net/core/page_pool_user.c     | 36 +++++++++++++++++++++++++++++++++++
>  5 files changed, 66 insertions(+), 6 deletions(-)
>  create mode 100644 net/core/page_pool_priv.h
>  create mode 100644 net/core/page_pool_user.c
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index 1ac7ce25fbd4..9fadf15dadfa 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -189,6 +189,10 @@ struct page_pool {
>
>         /* Slow/Control-path information follows */
>         struct page_pool_params_slow slow;
> +       /* User-facing fields, protected by page_pools_lock */
> +       struct {
> +               u32 id;
> +       } user;
>  };
>
>  struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
> diff --git a/net/core/Makefile b/net/core/Makefile
> index 731db2eaa610..4ae3d83f67d5 100644
> --- a/net/core/Makefile
> +++ b/net/core/Makefile
> @@ -18,7 +18,7 @@ obj-y              +=3D dev.o dev_addr_lists.o dst.o ne=
tevent.o \
>  obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) +=3D dev_addr_lists_test.o
>
>  obj-y +=3D net-sysfs.o
> -obj-$(CONFIG_PAGE_POOL) +=3D page_pool.o
> +obj-$(CONFIG_PAGE_POOL) +=3D page_pool.o page_pool_user.o
>  obj-$(CONFIG_PROC_FS) +=3D net-procfs.o
>  obj-$(CONFIG_NET_PKTGEN) +=3D pktgen.o
>  obj-$(CONFIG_NETPOLL) +=3D netpoll.o
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 8e71e116224d..de199c356043 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -23,6 +23,8 @@
>
>  #include <trace/events/page_pool.h>
>
> +#include "page_pool_priv.h"
> +
>  #define DEFER_TIME (msecs_to_jiffies(1000))
>  #define DEFER_WARN_INTERVAL (60 * HZ)
>
> @@ -264,13 +266,21 @@ struct page_pool *page_pool_create(const struct pag=
e_pool_params *params)
>                 return ERR_PTR(-ENOMEM);
>
>         err =3D page_pool_init(pool, params);
> -       if (err < 0) {
> -               pr_warn("%s() gave up with errno %d\n", __func__, err);
> -               kfree(pool);
> -               return ERR_PTR(err);
> -       }
> +       if (err < 0)
> +               goto err_free;
> +
> +       err =3D page_pool_list(pool);
> +       if (err)
> +               goto err_uninit;
>
>         return pool;
> +
> +err_uninit:
> +       page_pool_uninit(pool);
> +err_free:
> +       pr_warn("%s() gave up with errno %d\n", __func__, err);
> +       kfree(pool);
> +       return ERR_PTR(err);
>  }
>  EXPORT_SYMBOL(page_pool_create);
>
> @@ -818,6 +828,7 @@ static void page_pool_free(struct page_pool *pool)
>         if (pool->disconnect)
>                 pool->disconnect(pool);
>
> +       page_pool_unlist(pool);
>         page_pool_uninit(pool);
>         kfree(pool);
>  }
> diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
> new file mode 100644
> index 000000000000..6c4e4aeed02a
> --- /dev/null
> +++ b/net/core/page_pool_priv.h
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef __PAGE_POOL_PRIV_H
> +#define __PAGE_POOL_PRIV_H
> +
> +int page_pool_list(struct page_pool *pool);
> +void page_pool_unlist(struct page_pool *pool);
> +
> +#endif
> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> new file mode 100644
> index 000000000000..af4ac38a2de1
> --- /dev/null
> +++ b/net/core/page_pool_user.c
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/mutex.h>
> +#include <linux/xarray.h>
> +#include <net/page_pool/types.h>
> +
> +#include "page_pool_priv.h"
> +
> +static DEFINE_XARRAY_FLAGS(page_pools, XA_FLAGS_ALLOC1);
> +static DEFINE_MUTEX(page_pools_lock);
> +
> +int page_pool_list(struct page_pool *pool)
> +{
> +       static u32 id_alloc_next;
> +       int err;
> +
> +       mutex_lock(&page_pools_lock);
> +       err =3D xa_alloc_cyclic(&page_pools, &pool->user.id, pool, xa_lim=
it_32b,
> +                             &id_alloc_next, GFP_KERNEL);
> +       if (err < 0)
> +               goto err_unlock;
> +
> +       mutex_unlock(&page_pools_lock);
> +       return 0;
> +
> +err_unlock:
> +       mutex_unlock(&page_pools_lock);
> +       return err;
> +}
> +
> +void page_pool_unlist(struct page_pool *pool)
> +{
> +       mutex_lock(&page_pools_lock);
> +       xa_erase(&page_pools, pool->user.id);
> +       mutex_unlock(&page_pools_lock);
> +}
> --
> 2.41.0
>


--=20
Thanks,
Mina

