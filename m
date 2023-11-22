Return-Path: <netdev+bounces-50004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51D87F43D0
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48AEBB20F35
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC3E5102F;
	Wed, 22 Nov 2023 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zdtMr4Tx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCBF10CF
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 02:27:35 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so12526a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 02:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700648854; x=1701253654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wv1QyDWWIEjdTKRb3ZIKkf1DaycBR7f3XxKb4/Rnig=;
        b=zdtMr4TxdaPeALuT0og8MMAHX/o6AmftwrecH28McP/gD5IiwnlHXiosOmO+1LRYH5
         oYW9XHnyqLXWfpmjP+9CZ024tmWNJJKhsBa6zNFh5h355jyGV3++gnljZ/sEemS+Ty0n
         6fhNtHVrwfB6icAwYr5+QF0MkXmYGkOkhgvx2t+2cVmqavAofhXbFUpKxYXqreCN2Sxk
         aTfegptpJ8LL+9evYw/vdZiGestjDNL/yU0ZXoWYg3YQl9bn87PT4DSr9SZj8+9DvbE/
         q3WCzGaIjPrDi3yla6YERiJTJBlHJV0hrU3IqJr+OenvOjraV47OFRoviO+RRMpVFtDb
         0B9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700648854; x=1701253654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wv1QyDWWIEjdTKRb3ZIKkf1DaycBR7f3XxKb4/Rnig=;
        b=rewL/3zFHlo3Fcu+CkkZbp9Y/KKZWJooc3vj4QYHSVT8GDwotHr9fvC+au1c07NqzD
         BirmbA6Xuof0/JPAky51KWvkZEhk6bffTNBhJ5UuR1cFdGlbYnGi13RxkwikwtycXeCT
         FAE6DcZnjT4mjKGyFdeICaQDFcATLe4EbgNdCvc4wWDiGCzRIm7NHxWFMAbwChonW2Tk
         giGdRldSyJ3/HsZUkdgmRH43+zsUTgHLK6pOHRpHmtfw08eZjGL0N5kVa5/oQqJNmKWi
         0xVppCeWjkHMtg92qg8NoUTOlnUrTTKVzGOx60nOUfmQhu8XTWEjPU1XNOw0dLHYlIUL
         DUrg==
X-Gm-Message-State: AOJu0YxSzpvgF1xZoWJ7xTU6itJsPaMtl0ybZ/VR8ofKT3r01qQewUi9
	cg+jWmp8hvIwtoLVFdpxLEA5FuPJ/Xvn9wDLPSCcFA==
X-Google-Smtp-Source: AGHT+IH4CV8WtPk+ALaIUshllkFaeyHx0ukNXRkVbBi8EEaozjwxZet35OPMScQDZcXd94yiwn8/l5FKftNJwQ6S7So=
X-Received: by 2002:a05:6402:2911:b0:542:d737:dc7e with SMTP id
 ee17-20020a056402291100b00542d737dc7emr120744edb.0.1700648853692; Wed, 22 Nov
 2023 02:27:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122034420.1158898-1-kuba@kernel.org> <20231122034420.1158898-12-kuba@kernel.org>
In-Reply-To: <20231122034420.1158898-12-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Nov 2023 11:27:22 +0100
Message-ID: <CANn89i+4-OP8dvmikt3-=HVou+=z00ijF6JoKDM=krQcGW2p8Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 11/13] net: page_pool: expose page pool stats
 via netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
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
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netl=
ink/specs/netdev.yaml
> index 695e0e4e0d8b..77d991738a17 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -137,6 +137,59 @@ name: netdev
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
> +        value: 8 # reserve some attr ids in case we need more metadata l=
ater
> +      -
> +        name: alloc-slow
> +        type: uint





Same remark than before, all these fields are u64

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
> @@ -210,6 +263,31 @@ name: netdev
>        notify: page-pool-get
>        mcgrp: page-pool
>        config-cond: page-pool
> +
> +       if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_FAST,
> +                        stats.alloc_stats.fast) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW,
> +                        stats.alloc_stats.slow) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW_HIGH_OR=
DER,
> +                        stats.alloc_stats.slow_high_order) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_EMPTY,
> +                        stats.alloc_stats.empty) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_REFILL,
> +                        stats.alloc_stats.refill) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_WAIVE,
> +                        stats.alloc_stats.waive) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHED,
> +                        stats.recycle_stats.cached) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHE_FULL=
,
> +                        stats.recycle_stats.cache_full) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING,
> +                        stats.recycle_stats.ring) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING_FULL,
> +                        stats.recycle_stats.ring_full) ||
> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_RELEASED_R=
EFCNT,
> +                        stats.recycle_stats.released_refcnt))
> +               goto err_cancel_msg;

Therefore, we should use nla_put_u64_64bit() ?

