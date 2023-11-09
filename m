Return-Path: <netdev+bounces-46766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA687E64F8
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 09:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708E21C208ED
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 08:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6687B10780;
	Thu,  9 Nov 2023 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gF+F5FIo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D71078C
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 08:12:26 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597F42D4F
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 00:12:25 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso6933361fa.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 00:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699517543; x=1700122343; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fM3Oq3397BLHIwz7mWQIogkat/eFZMzgGCTfhk2qn+A=;
        b=gF+F5FIoq9O3VxPFZRZ18cGY08DIzxgqY/uG7j+TvcIppfgu5QvHCNH4SwKc/0q2ft
         P9agJ50a3OWNzJacSb+PXuVEk7I9c0B4hvK14u+9kfFWy8r66VT7LBDgNhheNnFKBsAu
         7LP+hN17Quw4Qi8tnbAcnSnBbcnOs/Mmk4O6V9SUUqsJ0vg07b/amhFhgsyLXeyLU3aM
         6qUq0ZpfyrMCFQD5BTq0x8PPJfgl0uokr1DTG87Aotp+Fo5ui/vgbyvgKzuQ9DRPUmM7
         Eao8+hlStWHICWwzhbSxG9YumNPe5q/yEP0Fgoo8WEwhrMw/DAei+SSJxjoijGo/XdfL
         pkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699517543; x=1700122343;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fM3Oq3397BLHIwz7mWQIogkat/eFZMzgGCTfhk2qn+A=;
        b=Y5zXD48nrdQGtMr4D8ZfnfG0GYRjZ2UpFxPIMXkjR+UJxgDkB4nd4LzP1Urjb387o9
         UBx6sRIxXRblkwNZWqnjw7dBtzNCkqBk7NxYKcNsGl3RdVlwsFnbAqb2+sBk25jq39lb
         6nTzRJqw21yuJfn6bgvC00Ph68/kW/F9Ffx28PJhgFhVSIZem627Nxg3DwSeIHtoiF3D
         75gqdluw+wP6Z6BOGvCq3okgb1d+L2OZ8Q54cKTtwUlMzmm8sE/P0nsJY2EwknB5KeJO
         3164/snSccPc/GnNXWXLofr8kj2KTqc6XOAU+ntfDvZtaDKaKj9wM+0X/Z8fLWBT4b0a
         gROQ==
X-Gm-Message-State: AOJu0YwT2o5SWrLr2OQLsVXMsTkLSEQpBt2QX3XW7TCHHo56hFtNjzwo
	XayAArRoerBSDlk9SEoVtRIM7qhEi4kobJp9EajGFZJgaZ2XSuGi
X-Google-Smtp-Source: AGHT+IGzfhdkSTR9vBrfxXosiP8TXTg15B6sFYA4BvQj+rj8MpijhuUKuQOqnEVGqmfbbh6MDti++o7v6jO67T+BfJk=
X-Received: by 2002:a2e:9e88:0:b0:2c5:582:fd8e with SMTP id
 f8-20020a2e9e88000000b002c50582fd8emr3618843ljk.21.1699517543550; Thu, 09 Nov
 2023 00:12:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024160220.3973311-1-kuba@kernel.org>
In-Reply-To: <20231024160220.3973311-1-kuba@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 Nov 2023 10:11:47 +0200
Message-ID: <CAC_iWjKi0V6wUmutmpjYyjZGkwXef4bxQwcx6o5rytT+-Pj5Eg@mail.gmail.com>
Subject: Re: [PATCH net-next 00/15] net: page_pool: add netlink-based introspection
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Tue, 24 Oct 2023 at 19:02, Jakub Kicinski <kuba@kernel.org> wrote:
>
> This is a new revision of the RFC posted in August:
> https://lore.kernel.org/all/20230816234303.3786178-1-kuba@kernel.org/
> There's been a handful of fixes and tweaks but the overall
> architecture is unchanged.
>
> As a reminder the RFC was posted as the first step towards
> an API which could configure the page pools (GET API as a stepping
> stone for a SET API to come later). I wasn't sure whether we should
> commit to the GET API before the SET takes shape, hence the large
> delay between versions.
>
> Unfortunately, real deployment experience made this series much more
> urgent. We recently started to deploy newer kernels / drivers
> at Meta, making significant use of page pools for the first time.

That's nice and scary at the same time!

> We immediately run into page pool leaks both real and false positive
> warnings. As Eric pointed out/predicted there's no guarantee that
> applications will read / close their sockets so a page pool page
> may be stuck in a socket (but not leaked) forever. This happens
> a lot in our fleet. Most of these are obviously due to application
> bugs but we should not be printing kernel warnings due to minor
> application resource leaks.

Fair enough, I guess you mean 'continuous warnings'?

>
> Conversely the page pool memory may get leaked at runtime, and
> we have no way to detect / track that, unless someone reconfigures
> the NIC and destroys the page pools which leaked the pages.
>
> The solution presented here is to expose the memory use of page
> pools via netlink. This allows for continuous monitoring of memory
> used by page pools, regardless if they were destroyed or not.
> Sample in patch 15 can print the memory use and recycling
> efficiency:
>
> $ ./page-pool
>     eth0[2]     page pools: 10 (zombies: 0)
>                 refs: 41984 bytes: 171966464 (refs: 0 bytes: 0)
>                 recycling: 90.3% (alloc: 656:397681 recycle: 89652:270201)
>

That's reasonable, and the recycling rate is pretty impressive.  Any
idea how that translated to enhancements overall? mem/cpu pressure etc

Thanks
/Ilias

> The main change compared to the RFC is that the API now exposes
> outstanding references and byte counts even for "live" page pools.
> The warning is no longer printed if page pool is accessible via netlink.
>
> Jakub Kicinski (15):
>   net: page_pool: split the page_pool_params into fast and slow
>   net: page_pool: avoid touching slow on the fastpath
>   net: page_pool: factor out uninit
>   net: page_pool: id the page pools
>   net: page_pool: record pools per netdev
>   net: page_pool: stash the NAPI ID for easier access
>   eth: link netdev to page_pools in drivers
>   net: page_pool: add nlspec for basic access to page pools
>   net: page_pool: implement GET in the netlink API
>   net: page_pool: add netlink notifications for state changes
>   net: page_pool: report amount of memory held by page pools
>   net: page_pool: report when page pool was destroyed
>   net: page_pool: expose page pool stats via netlink
>   net: page_pool: mute the periodic warning for visible page pools
>   tools: ynl: add sample for getting page-pool information
>
>  Documentation/netlink/specs/netdev.yaml       | 161 +++++++
>  Documentation/networking/page_pool.rst        |  10 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   1 +
>  .../net/ethernet/mellanox/mlx5/core/en_main.c |   1 +
>  drivers/net/ethernet/microsoft/mana/mana_en.c |   1 +
>  include/linux/list.h                          |  20 +
>  include/linux/netdevice.h                     |   4 +
>  include/linux/poison.h                        |   2 +
>  include/net/page_pool/helpers.h               |   8 +-
>  include/net/page_pool/types.h                 |  43 +-
>  include/uapi/linux/netdev.h                   |  36 ++
>  net/core/Makefile                             |   2 +-
>  net/core/netdev-genl-gen.c                    |  52 +++
>  net/core/netdev-genl-gen.h                    |  11 +
>  net/core/page_pool.c                          |  78 ++--
>  net/core/page_pool_priv.h                     |  12 +
>  net/core/page_pool_user.c                     | 414 +++++++++++++++++
>  tools/include/uapi/linux/netdev.h             |  36 ++
>  tools/net/ynl/generated/netdev-user.c         | 419 ++++++++++++++++++
>  tools/net/ynl/generated/netdev-user.h         | 171 +++++++
>  tools/net/ynl/lib/ynl.h                       |   2 +-
>  tools/net/ynl/samples/.gitignore              |   1 +
>  tools/net/ynl/samples/Makefile                |   2 +-
>  tools/net/ynl/samples/page-pool.c             | 147 ++++++
>  24 files changed, 1586 insertions(+), 48 deletions(-)
>  create mode 100644 net/core/page_pool_priv.h
>  create mode 100644 net/core/page_pool_user.c
>  create mode 100644 tools/net/ynl/samples/page-pool.c
>
> --
> 2.41.0
>

