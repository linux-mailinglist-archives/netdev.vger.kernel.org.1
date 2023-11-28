Return-Path: <netdev+bounces-51714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D45C7FBD98
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567CB1C212BC
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8267B5C09C;
	Tue, 28 Nov 2023 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rV8oNTA1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CACD182
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:01:46 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bc21821a1so167836e87.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701183704; x=1701788504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hQCoy4LtkEkTXRjj9EtmKiA+EjqPEGxAPokf1/9kBRQ=;
        b=rV8oNTA18q7XVAg2SnowW9cF4TPK9FuWdC0eqgZn/SNLsWAgVgmwlYdMTU8BqTpIzA
         96GsmMSYxkdvzSpSZfz9zNZGBzJIop9XCs1Nz44zGay95NcbVBWM4rEzhUk+Cx3ukZIU
         jd6O73ElAFzpCgaAL33KxbkRieoTksrsz/z3WzdpOgQGy+yrwHfYbyHPj1G23iYsRufi
         LeQrC6sHvXz1BbDIwWYD8R3poS65+JV8KrRPjqZ3gxvSJNsxflmtBo01zLCcOFK9qy8Z
         sbC7F6KCXkKsGN1WeWX6QBqeK/vysA2g+neNaecPoex6btsUXDggrGPCrjr8Ayx98QRF
         toZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183704; x=1701788504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQCoy4LtkEkTXRjj9EtmKiA+EjqPEGxAPokf1/9kBRQ=;
        b=xEbMpy6cAQn2ZZY3f/18Ij4tt6mOkq9VbFWix+77PmHKnXzCfDQ7k34cAfsQPzzM7s
         BgITysjrvwJH8oKc25wM5glfgL/1jwS20sfa+9MmNU1TG5TobdZ4ygHP9Q9/ZR7l5eds
         dsg8tuezamqxLNHzYYHWMVn26aiwgdDQmvakA0RB7wBBX84pPAJepRb3tRZYjUB+7S1A
         uq/icmbdtPZjo4ld1w+tO4c9zY+JGtuWSiPBERZj9xGxALxYTD81uPacuU9dH2Qzseyu
         j4xcybQCsSiRKdD1oXCWYcOkVcKto/m0MOI0Y1K63que8GEcvalw2rODOJTO9rmI4+vW
         Bo4Q==
X-Gm-Message-State: AOJu0YxLIs1x81WqoemcEkfSwa09bnCIVuKCaMAryCQMXb3SZl8WIGpL
	K+TcweGsr9CXu8CVZYQQu/I6tO3GtBPYR1/6Fjrtag==
X-Google-Smtp-Source: AGHT+IGFB/H4LqFjuArCM/mAQ9Ra++1foOTYn1ZTyqoGZsmjC4CVrPdnrjfFrtFPOm4DKvuWo7piyvJFeu0sEpls1IE=
X-Received: by 2002:ac2:4424:0:b0:509:e5a3:ef49 with SMTP id
 w4-20020ac24424000000b00509e5a3ef49mr10577096lfl.18.1701183704118; Tue, 28
 Nov 2023 07:01:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126230740.2148636-1-kuba@kernel.org> <20231126230740.2148636-12-kuba@kernel.org>
In-Reply-To: <20231126230740.2148636-12-kuba@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 Nov 2023 17:01:08 +0200
Message-ID: <CAC_iWjLss9Cd9uQVMnfKXiVT=WN-xYx8odGmksa9ruCn8FixRg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 11/13] net: page_pool: expose page pool stats
 via netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, hawk@kernel.org, dsahern@gmail.com, dtatulea@nvidia.com, 
	willemb@google.com, almasrymina@google.com, shakeelb@google.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Nov 2023 at 01:08, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Dump the stats into netlink. More clever approaches
> like dumping the stats per-CPU for each CPU individually
> to see where the packets get consumed can be implemented
> in the future.
>
> A trimmed example from a real (but recently booted system):
>
> $ ./cli.py --no-schema --spec netlink/specs/netdev.yaml \
>            --dump page-pool-stats-get
> [{'info': {'id': 19, 'ifindex': 2},
>   'alloc-empty': 48,
>   'alloc-fast': 3024,
>   'alloc-refill': 0,
>   'alloc-slow': 48,
>   'alloc-slow-high-order': 0,
>   'alloc-waive': 0,
>   'recycle-cache-full': 0,
>   'recycle-cached': 0,
>   'recycle-released-refcnt': 0,
>   'recycle-ring': 0,
>   'recycle-ring-full': 0},
>  {'info': {'id': 18, 'ifindex': 2},
>   'alloc-empty': 66,
>   'alloc-fast': 11811,
>   'alloc-refill': 35,
>   'alloc-slow': 66,
>   'alloc-slow-high-order': 0,
>   'alloc-waive': 0,
>   'recycle-cache-full': 1145,
>   'recycle-cached': 6541,
>   'recycle-released-refcnt': 0,
>   'recycle-ring': 1275,
>   'recycle-ring-full': 0},
>  {'info': {'id': 17, 'ifindex': 2},
>   'alloc-empty': 73,
>   'alloc-fast': 62099,
>   'alloc-refill': 413,
> ...
>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml |  78 ++++++++++++++++++
>  Documentation/networking/page_pool.rst  |  10 ++-
>  include/net/page_pool/helpers.h         |   8 +-
>  include/uapi/linux/netdev.h             |  19 +++++
>  net/core/netdev-genl-gen.c              |  32 ++++++++
>  net/core/netdev-genl-gen.h              |   7 ++
>  net/core/page_pool.c                    |   2 +-
>  net/core/page_pool_user.c               | 103 ++++++++++++++++++++++++
>  8 files changed, 250 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index b5f715cf9e06..20f75b7d3240 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -139,6 +139,59 @@ name: netdev
>            "re-attached", they are just waiting to disappear.
>            Attribute is absent if Page Pool has not been detached, and
>            can still be used to allocate new memory.
> +  -
> +    name: page-pool-info
> +    subset-of: page-pool
> +    attributes:
> +      -
> +        name: id
> +      -
> +        name: ifindex
> +  -
> +    name: page-pool-stats
> +    doc: |
> +      Page pool statistics, see docs for struct page_pool_stats
> +      for information about individual statistics.
> +    attributes:
> +      -
> +        name: info
> +        doc: Page pool identifying information.
> +        type: nest
> +        nested-attributes: page-pool-info
> +      -
> +        name: alloc-fast
> +        type: uint
> +        value: 8 # reserve some attr ids in case we need more metadata later
> +      -
> +        name: alloc-slow
> +        type: uint
> +      -
> +        name: alloc-slow-high-order
> +        type: uint
> +      -
> +        name: alloc-empty
> +        type: uint
> +      -
> +        name: alloc-refill
> +        type: uint
> +      -
> +        name: alloc-waive
> +        type: uint
> +      -
> +        name: recycle-cached
> +        type: uint
> +      -
> +        name: recycle-cache-full
> +        type: uint
> +      -
> +        name: recycle-ring
> +        type: uint
> +      -
> +        name: recycle-ring-full
> +        type: uint
> +      -
> +        name: recycle-released-refcnt
> +        type: uint
>
>  operations:
>    list:
> @@ -212,6 +265,31 @@ name: netdev
>        notify: page-pool-get
>        mcgrp: page-pool
>        config-cond: page-pool
> +    -
> +      name: page-pool-stats-get
> +      doc: Get page pool statistics.
> +      attribute-set: page-pool-stats
> +      do:
> +        request:
> +          attributes:
> +            - info
> +        reply: &pp-stats-reply
> +          attributes:
> +            - info
> +            - alloc-fast
> +            - alloc-slow
> +            - alloc-slow-high-order
> +            - alloc-empty
> +            - alloc-refill
> +            - alloc-waive
> +            - recycle-cached
> +            - recycle-cache-full
> +            - recycle-ring
> +            - recycle-ring-full
> +            - recycle-released-refcnt
> +      dump:
> +        reply: *pp-stats-reply
> +      config-cond: page-pool-stats
>
>  mcast-groups:
>    list:
> diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
> index 60993cb56b32..9d958128a57c 100644
> --- a/Documentation/networking/page_pool.rst
> +++ b/Documentation/networking/page_pool.rst
> @@ -41,6 +41,11 @@ Architecture overview
>                            |   Fast cache    |     |  ptr-ring cache  |
>                            +-----------------+     +------------------+
>
> +Monitoring
> +==========
> +Information about page pools on the system can be accessed via the netdev
> +genetlink family (see Documentation/netlink/specs/netdev.yaml).
> +
>  API interface
>  =============
>  The number of pools created **must** match the number of hardware queues
> @@ -107,8 +112,9 @@ page_pool_get_stats() and structures described below are available.
>  It takes a  pointer to a ``struct page_pool`` and a pointer to a struct
>  page_pool_stats allocated by the caller.
>
> -The API will fill in the provided struct page_pool_stats with
> -statistics about the page_pool.
> +Older drivers expose page pool statistics via ethtool or debugfs.
> +The same statistics are accessible via the netlink netdev family
> +in a driver-independent fashion.
>
>  .. kernel-doc:: include/net/page_pool/types.h
>     :identifiers: struct page_pool_recycle_stats
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 4ebd544ae977..7dc65774cde5 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -55,16 +55,12 @@
>  #include <net/page_pool/types.h>
>
>  #ifdef CONFIG_PAGE_POOL_STATS
> +/* Deprecated driver-facing API, use netlink instead */
>  int page_pool_ethtool_stats_get_count(void);
>  u8 *page_pool_ethtool_stats_get_strings(u8 *data);
>  u64 *page_pool_ethtool_stats_get(u64 *data, void *stats);
>
> -/*
> - * Drivers that wish to harvest page pool stats and report them to users
> - * (perhaps via ethtool, debugfs, or another mechanism) can allocate a
> - * struct page_pool_stats call page_pool_get_stats to get stats for the specified pool.
> - */
> -bool page_pool_get_stats(struct page_pool *pool,
> +bool page_pool_get_stats(const struct page_pool *pool,
>                          struct page_pool_stats *stats);
>  #else
>  static inline int page_pool_ethtool_stats_get_count(void)
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index 756410274120..2b37233e00c0 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -76,6 +76,24 @@ enum {
>         NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
>  };
>
> +enum {
> +       NETDEV_A_PAGE_POOL_STATS_INFO = 1,
> +       NETDEV_A_PAGE_POOL_STATS_ALLOC_FAST = 8,
> +       NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW,
> +       NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW_HIGH_ORDER,
> +       NETDEV_A_PAGE_POOL_STATS_ALLOC_EMPTY,
> +       NETDEV_A_PAGE_POOL_STATS_ALLOC_REFILL,
> +       NETDEV_A_PAGE_POOL_STATS_ALLOC_WAIVE,
> +       NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHED,
> +       NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHE_FULL,
> +       NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING,
> +       NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING_FULL,
> +       NETDEV_A_PAGE_POOL_STATS_RECYCLE_RELEASED_REFCNT,
> +
> +       __NETDEV_A_PAGE_POOL_STATS_MAX,
> +       NETDEV_A_PAGE_POOL_STATS_MAX = (__NETDEV_A_PAGE_POOL_STATS_MAX - 1)
> +};
> +
>  enum {
>         NETDEV_CMD_DEV_GET = 1,
>         NETDEV_CMD_DEV_ADD_NTF,
> @@ -85,6 +103,7 @@ enum {
>         NETDEV_CMD_PAGE_POOL_ADD_NTF,
>         NETDEV_CMD_PAGE_POOL_DEL_NTF,
>         NETDEV_CMD_PAGE_POOL_CHANGE_NTF,
> +       NETDEV_CMD_PAGE_POOL_STATS_GET,
>
>         __NETDEV_CMD_MAX,
>         NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> index 47fb5e1b6369..dccd8c3a141e 100644
> --- a/net/core/netdev-genl-gen.c
> +++ b/net/core/netdev-genl-gen.c
> @@ -16,6 +16,17 @@ static const struct netlink_range_validation netdev_a_page_pool_id_range = {
>         .max    = 4294967295ULL,
>  };
>
> +static const struct netlink_range_validation netdev_a_page_pool_ifindex_range = {
> +       .min    = 1ULL,
> +       .max    = 2147483647ULL,
> +};
> +
> +/* Common nested types */
> +const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1] = {
> +       [NETDEV_A_PAGE_POOL_ID] = NLA_POLICY_FULL_RANGE(NLA_UINT, &netdev_a_page_pool_id_range),
> +       [NETDEV_A_PAGE_POOL_IFINDEX] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_page_pool_ifindex_range),
> +};
> +
>  /* NETDEV_CMD_DEV_GET - do */
>  static const struct nla_policy netdev_dev_get_nl_policy[NETDEV_A_DEV_IFINDEX + 1] = {
>         [NETDEV_A_DEV_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
> @@ -28,6 +39,13 @@ static const struct nla_policy netdev_page_pool_get_nl_policy[NETDEV_A_PAGE_POOL
>  };
>  #endif /* CONFIG_PAGE_POOL */
>
> +/* NETDEV_CMD_PAGE_POOL_STATS_GET - do */
> +#ifdef CONFIG_PAGE_POOL_STATS
> +static const struct nla_policy netdev_page_pool_stats_get_nl_policy[NETDEV_A_PAGE_POOL_STATS_INFO + 1] = {
> +       [NETDEV_A_PAGE_POOL_STATS_INFO] = NLA_POLICY_NESTED(netdev_page_pool_info_nl_policy),
> +};
> +#endif /* CONFIG_PAGE_POOL_STATS */
> +
>  /* Ops table for netdev */
>  static const struct genl_split_ops netdev_nl_ops[] = {
>         {
> @@ -56,6 +74,20 @@ static const struct genl_split_ops netdev_nl_ops[] = {
>                 .flags  = GENL_CMD_CAP_DUMP,
>         },
>  #endif /* CONFIG_PAGE_POOL */
> +#ifdef CONFIG_PAGE_POOL_STATS
> +       {
> +               .cmd            = NETDEV_CMD_PAGE_POOL_STATS_GET,
> +               .doit           = netdev_nl_page_pool_stats_get_doit,
> +               .policy         = netdev_page_pool_stats_get_nl_policy,
> +               .maxattr        = NETDEV_A_PAGE_POOL_STATS_INFO,
> +               .flags          = GENL_CMD_CAP_DO,
> +       },
> +       {
> +               .cmd    = NETDEV_CMD_PAGE_POOL_STATS_GET,
> +               .dumpit = netdev_nl_page_pool_stats_get_dumpit,
> +               .flags  = GENL_CMD_CAP_DUMP,
> +       },
> +#endif /* CONFIG_PAGE_POOL_STATS */
>  };
>
>  static const struct genl_multicast_group netdev_nl_mcgrps[] = {
> diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
> index 738097847100..649e4b46eccf 100644
> --- a/net/core/netdev-genl-gen.h
> +++ b/net/core/netdev-genl-gen.h
> @@ -11,11 +11,18 @@
>
>  #include <uapi/linux/netdev.h>
>
> +/* Common nested types */
> +extern const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1];
> +
>  int netdev_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info);
>  int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
>  int netdev_nl_page_pool_get_doit(struct sk_buff *skb, struct genl_info *info);
>  int netdev_nl_page_pool_get_dumpit(struct sk_buff *skb,
>                                    struct netlink_callback *cb);
> +int netdev_nl_page_pool_stats_get_doit(struct sk_buff *skb,
> +                                      struct genl_info *info);
> +int netdev_nl_page_pool_stats_get_dumpit(struct sk_buff *skb,
> +                                        struct netlink_callback *cb);
>
>  enum {
>         NETDEV_NLGRP_MGMT,
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index a821fb5fe054..3d0938a60646 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -71,7 +71,7 @@ static const char pp_stats[][ETH_GSTRING_LEN] = {
>   * is passed to this API which is filled in. The caller can then report
>   * those stats to the user (perhaps via ethtool, debugfs, etc.).
>   */
> -bool page_pool_get_stats(struct page_pool *pool,
> +bool page_pool_get_stats(const struct page_pool *pool,
>                          struct page_pool_stats *stats)
>  {
>         int cpu = 0;
> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> index bd5ca94f683f..1426434a7e15 100644
> --- a/net/core/page_pool_user.c
> +++ b/net/core/page_pool_user.c
> @@ -5,6 +5,7 @@
>  #include <linux/xarray.h>
>  #include <net/net_debug.h>
>  #include <net/page_pool/types.h>
> +#include <net/page_pool/helpers.h>
>  #include <net/sock.h>
>
>  #include "page_pool_priv.h"
> @@ -106,6 +107,108 @@ netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
>         return err;
>  }
>
> +static int
> +page_pool_nl_stats_fill(struct sk_buff *rsp, const struct page_pool *pool,
> +                       const struct genl_info *info)
> +{
> +#ifdef CONFIG_PAGE_POOL_STATS
> +       struct page_pool_stats stats = {};
> +       struct nlattr *nest;
> +       void *hdr;
> +
> +       if (!page_pool_get_stats(pool, &stats))
> +               return 0;
> +
> +       hdr = genlmsg_iput(rsp, info);
> +       if (!hdr)
> +               return -EMSGSIZE;
> +
> +       nest = nla_nest_start(rsp, NETDEV_A_PAGE_POOL_STATS_INFO);
> +
> +       if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_ID, pool->user.id) ||
> +           (pool->slow.netdev->ifindex != LOOPBACK_IFINDEX &&
> +            nla_put_u32(rsp, NETDEV_A_PAGE_POOL_IFINDEX,
> +                        pool->slow.netdev->ifindex)))
> +               goto err_cancel_nest;
> +
> +       nla_nest_end(rsp, nest);
> +
> +       if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_FAST,
> +                        stats.alloc_stats.fast) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW,
> +                        stats.alloc_stats.slow) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW_HIGH_ORDER,
> +                        stats.alloc_stats.slow_high_order) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_EMPTY,
> +                        stats.alloc_stats.empty) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_REFILL,
> +                        stats.alloc_stats.refill) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_WAIVE,
> +                        stats.alloc_stats.waive) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHED,
> +                        stats.recycle_stats.cached) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHE_FULL,
> +                        stats.recycle_stats.cache_full) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING,
> +                        stats.recycle_stats.ring) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING_FULL,
> +                        stats.recycle_stats.ring_full) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_RELEASED_REFCNT,
> +                        stats.recycle_stats.released_refcnt))
> +               goto err_cancel_msg;
> +
> +       genlmsg_end(rsp, hdr);
> +
> +       return 0;
> +err_cancel_nest:
> +       nla_nest_cancel(rsp, nest);
> +err_cancel_msg:
> +       genlmsg_cancel(rsp, hdr);
> +       return -EMSGSIZE;
> +#else
> +       GENL_SET_ERR_MSG(info, "kernel built without CONFIG_PAGE_POOL_STATS");
> +       return -EOPNOTSUPP;
> +#endif
> +}
> +
> +int netdev_nl_page_pool_stats_get_doit(struct sk_buff *skb,
> +                                      struct genl_info *info)
> +{
> +       struct nlattr *tb[ARRAY_SIZE(netdev_page_pool_info_nl_policy)];
> +       struct nlattr *nest;
> +       int err;
> +       u32 id;
> +
> +       if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_PAGE_POOL_STATS_INFO))
> +               return -EINVAL;
> +
> +       nest = info->attrs[NETDEV_A_PAGE_POOL_STATS_INFO];
> +       err = nla_parse_nested(tb, ARRAY_SIZE(tb) - 1, nest,
> +                              netdev_page_pool_info_nl_policy,
> +                              info->extack);
> +       if (err)
> +               return err;
> +
> +       if (NL_REQ_ATTR_CHECK(info->extack, nest, tb, NETDEV_A_PAGE_POOL_ID))
> +               return -EINVAL;
> +       if (tb[NETDEV_A_PAGE_POOL_IFINDEX]) {
> +               NL_SET_ERR_MSG_ATTR(info->extack,
> +                                   tb[NETDEV_A_PAGE_POOL_IFINDEX],
> +                                   "selecting by ifindex not supported");
> +               return -EINVAL;
> +       }
> +
> +       id = nla_get_uint(tb[NETDEV_A_PAGE_POOL_ID]);
> +
> +       return netdev_nl_page_pool_get_do(info, id, page_pool_nl_stats_fill);
> +}
> +
> +int netdev_nl_page_pool_stats_get_dumpit(struct sk_buff *skb,
> +                                        struct netlink_callback *cb)
> +{
> +       return netdev_nl_page_pool_get_dump(skb, cb, page_pool_nl_stats_fill);
> +}
> +
>  static int
>  page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
>                   const struct genl_info *info)
> --
> 2.42.0
>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

