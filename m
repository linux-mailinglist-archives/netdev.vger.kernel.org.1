Return-Path: <netdev+bounces-44249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191937D74F0
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6F51C20DD1
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 19:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150B131A9B;
	Wed, 25 Oct 2023 19:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K5PZBIMu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55DD31A7D
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 19:57:04 +0000 (UTC)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445611B3
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:56:59 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-457c4e4a392so89539137.0
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698263818; x=1698868618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlI7mF1qIzu88+yI51tRT9claq1BoGr1P0hBr6IutEI=;
        b=K5PZBIMuMhDNVte3ahOxpTY5NgpvaRYRIRy6nFmreQHHCG3f11FvQkDMVH76r5dtZM
         bGV/+6Rddz+Zu9t86gZzvcFWgJ6KwY0Cax+slVkZ+dO5G8W3eY7Mxx/EfC7cYhlm+W2G
         VjAOvZskkRnpKZ4kX7gi3kpkJcbKerf9Kd9J5PL9i8veysEwfAKKPcCbF015D1wy5KXx
         6wk8PMwbmbQvY5gHpxIAzXK8cdaebIqpohP0FnXO2KrMpxn4qh+OhsSciOBzey/8Mrpg
         jvARi7HthLJTNkVRXaMVgwckjcGnjOIGMKq0P5ASv/Ema4Xx4TG0uHSrgeJpYO3PqCMn
         5ADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698263818; x=1698868618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlI7mF1qIzu88+yI51tRT9claq1BoGr1P0hBr6IutEI=;
        b=PFsm8NCN913aUX9o3JuD063AccKJYJEWpzvx7xOuR5qW3uN4Q+T+6UsBUQaeNpvLFy
         35T4Bi5TzJYc6AJGyLnxNN73ZC88PgHH2QuH01RWD0Zn46+oylRsnbFgKKqe3zdlDp7W
         g6eYINpyyNuX2UunUvVTtkhlk6nI76LDEEcnzpnyQ/43vc/BXPnkL4AiJwEHe0dfcRhv
         YMP9LAy3RbIVXNjXNET/lOWQ/Q52/Wtd7ZCH5dPKcmTFvnWVH12ihVvsdCNjcGpeogoN
         UvsU6B+vhYk3f9c/cGB9YGSBCfBT0eI6wKFTUANWazpmkGUIgeHaEDjFfjvQqW/m8+te
         4Mag==
X-Gm-Message-State: AOJu0Yz54eAIVzP8RTvareD9XPuxqUFXvJnVfuatJpGi9sgmOTMIzxdS
	fX8PEWYVVg4E2qSGYqk9E8eMPrlsofvbN8ZV6PjTXQ==
X-Google-Smtp-Source: AGHT+IF3vh1rLl6TqNxTb+YZrBt0xuH/H//jblr8+HVwOWndU5rJBuQuXNcYYxyo3lzxPQrFHRHkwUVGxvC6uimgB6E=
X-Received: by 2002:a67:e15c:0:b0:457:c933:a228 with SMTP id
 o28-20020a67e15c000000b00457c933a228mr11594516vsl.26.1698263817634; Wed, 25
 Oct 2023 12:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024160220.3973311-1-kuba@kernel.org> <20231024160220.3973311-6-kuba@kernel.org>
In-Reply-To: <20231024160220.3973311-6-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 25 Oct 2023 12:56:44 -0700
Message-ID: <CAHS8izOTzLVxQ_rYt1vyhb=tgs2GAtuSZUWkZ183=7J3wEEzjQ@mail.gmail.com>
Subject: Re: [PATCH net-next 05/15] net: page_pool: record pools per netdev
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 9:02=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Link the page pools with netdevs. This needs to be netns compatible
> so we have two options. Either we record the pools per netns and
> have to worry about moving them as the netdev gets moved.
> Or we record them directly on the netdev so they move with the netdev
> without any extra work.
>
> Implement the latter option. Since pools may outlast netdev we need
> a place to store orphans. In time honored tradition use loopback
> for this purpose.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v1: fix race between page pool and netdev disappearing (Simon)
> ---
>  include/linux/list.h          | 20 ++++++++
>  include/linux/netdevice.h     |  4 ++
>  include/linux/poison.h        |  2 +
>  include/net/page_pool/types.h |  4 ++
>  net/core/page_pool_user.c     | 90 +++++++++++++++++++++++++++++++++++
>  5 files changed, 120 insertions(+)
>
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 164b4d0e9d2a..3d8884472164 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -1111,6 +1111,26 @@ static inline void hlist_move_list(struct hlist_he=
ad *old,
>         old->first =3D NULL;
>  }
>
> +/**
> + * hlist_splice_init() - move all entries from one list to another
> + * @from: hlist_head from which entries will be moved
> + * @last: last entry on the @from list
> + * @to:   hlist_head to which entries will be moved
> + *
> + * @to can be empty, @from must contain at least @last.
> + */
> +static inline void hlist_splice_init(struct hlist_head *from,
> +                                    struct hlist_node *last,
> +                                    struct hlist_head *to)
> +{
> +       if (to->first)
> +               to->first->pprev =3D &last->next;
> +       last->next =3D to->first;
> +       to->first =3D from->first;
> +       from->first->pprev =3D &to->first;
> +       from->first =3D NULL;
> +}
> +
>  #define hlist_entry(ptr, type, member) container_of(ptr,type,member)
>
>  #define hlist_for_each(pos, head) \
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index b8bf669212cc..224ee4680a31 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2431,6 +2431,10 @@ struct net_device {
>  #if IS_ENABLED(CONFIG_DPLL)
>         struct dpll_pin         *dpll_pin;
>  #endif
> +#if IS_ENABLED(CONFIG_PAGE_POOL)
> +       /** @page_pools: page pools created for this netdevice */
> +       struct hlist_head       page_pools;
> +#endif

I wonder if this per netdev field is really necessary. Is it not
possible to do the same simply looping over the  (global) page_pools
xarray? Or is that too silly of an idea. I guess on some systems you
may end up with 100s or 1000s of active or orphaned page pools and
then globally iterating over the whole page_pools xarray can be really
slow..

>  };
>  #define to_net_dev(d) container_of(d, struct net_device, dev)
>
> diff --git a/include/linux/poison.h b/include/linux/poison.h
> index 851a855d3868..27a7dad17eef 100644
> --- a/include/linux/poison.h
> +++ b/include/linux/poison.h
> @@ -83,6 +83,8 @@
>
>  /********** net/core/skbuff.c **********/
>  #define SKB_LIST_POISON_NEXT   ((void *)(0x800 + POISON_POINTER_DELTA))
> +/********** net/ **********/
> +#define NET_PTR_POISON         ((void *)(0x801 + POISON_POINTER_DELTA))
>
>  /********** kernel/bpf/ **********/
>  #define BPF_PTR_POISON ((void *)(0xeB9FUL + POISON_POINTER_DELTA))
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index c19f0df3bf0b..b258a571201e 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -5,6 +5,7 @@
>
>  #include <linux/dma-direction.h>
>  #include <linux/ptr_ring.h>
> +#include <linux/types.h>
>
>  #define PP_FLAG_DMA_MAP                BIT(0) /* Should page_pool do the=
 DMA
>                                         * map/unmap
> @@ -48,6 +49,7 @@ struct pp_alloc_cache {
>   * @pool_size: size of the ptr_ring
>   * @nid:       NUMA node id to allocate from pages from
>   * @dev:       device, for DMA pre-mapping purposes
> + * @netdev:    netdev this pool will serve (leave as NULL if none or mul=
tiple)

Is this an existing use case (page_pools that serve null or multiple
netdevs), or a future use case? My understanding is that currently
page_pools serve at most 1 rx-queue. Spot checking a few drivers that
seems to be true.

>   * @napi:      NAPI which is the sole consumer of pages, otherwise NULL
>   * @dma_dir:   DMA mapping direction
>   * @max_len:   max DMA sync memory size for PP_FLAG_DMA_SYNC_DEV
> @@ -66,6 +68,7 @@ struct page_pool_params {
>                 unsigned int    offset;
>         );
>         struct_group_tagged(page_pool_params_slow, slow,
> +               struct net_device *netdev;
>  /* private: used by test code only */
>                 void (*init_callback)(struct page *page, void *arg);
>                 void *init_arg;
> @@ -189,6 +192,7 @@ struct page_pool {
>         struct page_pool_params_slow slow;
>         /* User-facing fields, protected by page_pools_lock */
>         struct {
> +               struct hlist_node list;
>                 u32 id;
>         } user;
>  };
> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> index 630d1eeecf2a..7cd6f416b87a 100644
> --- a/net/core/page_pool_user.c
> +++ b/net/core/page_pool_user.c
> @@ -1,14 +1,31 @@
>  // SPDX-License-Identifier: GPL-2.0
>
>  #include <linux/mutex.h>
> +#include <linux/netdevice.h>
>  #include <linux/xarray.h>
> +#include <net/net_debug.h>
>  #include <net/page_pool/types.h>
>
>  #include "page_pool_priv.h"
>
>  static DEFINE_XARRAY_FLAGS(page_pools, XA_FLAGS_ALLOC1);
> +/* Protects: page_pools, netdevice->page_pools, pool->slow.netdev, pool-=
>user.
> + * Ordering: inside rtnl_lock
> + */
>  static DEFINE_MUTEX(page_pools_lock);
>
> +/* Page pools are only reachable from user space (via netlink) if they a=
re
> + * linked to a netdev at creation time. Following page pool "visibility"
> + * states are possible:
> + *  - normal
> + *    - user.list: linked to real netdev, netdev: real netdev
> + *  - orphaned - real netdev has disappeared
> + *    - user.list: linked to lo, netdev: lo
> + *  - invisible - either (a) created without netdev linking, (b) unliste=
d due
> + *      to error, or (c) the entire namespace which owned this pool disa=
ppeared
> + *    - user.list: unhashed, netdev: unknown
> + */
> +
>  int page_pool_list(struct page_pool *pool)
>  {
>         static u32 id_alloc_next;
> @@ -20,6 +37,10 @@ int page_pool_list(struct page_pool *pool)
>         if (err < 0)
>                 goto err_unlock;
>
> +       if (pool->slow.netdev)
> +               hlist_add_head(&pool->user.list,
> +                              &pool->slow.netdev->page_pools);
> +
>         mutex_unlock(&page_pools_lock);
>         return 0;
>
> @@ -32,5 +53,74 @@ void page_pool_unlist(struct page_pool *pool)
>  {
>         mutex_lock(&page_pools_lock);
>         xa_erase(&page_pools, pool->user.id);
> +       hlist_del(&pool->user.list);
>         mutex_unlock(&page_pools_lock);
>  }
> +
> +static void page_pool_unreg_netdev_wipe(struct net_device *netdev)
> +{
> +       struct page_pool *pool;
> +       struct hlist_node *n;
> +
> +       mutex_lock(&page_pools_lock);
> +       hlist_for_each_entry_safe(pool, n, &netdev->page_pools, user.list=
) {
> +               hlist_del_init(&pool->user.list);
> +               pool->slow.netdev =3D NET_PTR_POISON;
> +       }
> +       mutex_unlock(&page_pools_lock);
> +}
> +
> +static void page_pool_unreg_netdev(struct net_device *netdev)
> +{
> +       struct page_pool *pool, *last;
> +       struct net_device *lo;
> +
> +       lo =3D __dev_get_by_index(dev_net(netdev), 1);
> +       if (!lo) {
> +               netdev_err_once(netdev,
> +                               "can't get lo to store orphan page pools\=
n");
> +               page_pool_unreg_netdev_wipe(netdev);
> +               return;
> +       }
> +
> +       mutex_lock(&page_pools_lock);
> +       last =3D NULL;
> +       hlist_for_each_entry(pool, &netdev->page_pools, user.list) {
> +               pool->slow.netdev =3D lo;
> +               last =3D pool;
> +       }
> +       if (last)
> +               hlist_splice_init(&netdev->page_pools, &last->user.list,
> +                                 &lo->page_pools);
> +       mutex_unlock(&page_pools_lock);
> +}
> +
> +static int
> +page_pool_netdevice_event(struct notifier_block *nb,
> +                         unsigned long event, void *ptr)
> +{
> +       struct net_device *netdev =3D netdev_notifier_info_to_dev(ptr);
> +
> +       if (event !=3D NETDEV_UNREGISTER)
> +               return NOTIFY_DONE;
> +
> +       if (hlist_empty(&netdev->page_pools))
> +               return NOTIFY_OK;
> +
> +       if (netdev->ifindex !=3D 1)

I'm guessing 1 is _always_ loopback?

> +               page_pool_unreg_netdev(netdev);
> +       else
> +               page_pool_unreg_netdev_wipe(netdev);
> +       return NOTIFY_OK;
> +}
> +
> +static struct notifier_block page_pool_netdevice_nb =3D {
> +       .notifier_call =3D page_pool_netdevice_event,
> +};
> +
> +static int __init page_pool_user_init(void)
> +{
> +       return register_netdevice_notifier(&page_pool_netdevice_nb);
> +}
> +
> +subsys_initcall(page_pool_user_init);
> --
> 2.41.0
>


--
Thanks,
Mina

