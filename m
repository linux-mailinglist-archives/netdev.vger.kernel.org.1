Return-Path: <netdev+bounces-28600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E16277FFB5
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4A62821DC
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1265F1ADD6;
	Thu, 17 Aug 2023 21:21:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065221643A
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:21:40 +0000 (UTC)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CF511F
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:21:38 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-44768034962so67262137.3
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692307297; x=1692912097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qa7FyL9qerk/cVdltyZQ9/Kbq02jG9d2fNHJrFfx0iU=;
        b=B2UbvlGjsyCy8TmCAGNsCiGZxq1ZO1EFUIXAA6AtJBAhmvvZ2nURyaBaUTsBE7HOPJ
         HFbjLp88Ry0a2B77cBpXTiuYIcMhd+XgToYyIIpBnJ6XU397K++0lNgn8NpnWqSdCh2j
         NaDdpqJKpMI6/kC4N6IVOyekkFf1GiytGABcUApevm6LhN2VcTCkj3IacEARFTkMtJEy
         PO3WR9JX8KOHtRXL0/5rd9YYbMjXO7Q0GqIy2vZ8eb32wXR8ZaL1EaVhqwNd0q9Fu84k
         DNYVws6LwslQr4V0QjYhpuMyEqYw6K/dsy2sLBsTX+++LeuxcvIBTKZHS2CxFi734wPS
         XRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692307297; x=1692912097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qa7FyL9qerk/cVdltyZQ9/Kbq02jG9d2fNHJrFfx0iU=;
        b=W+WSMmKPp/6bE8VKvbuotMn8uJiBKt/vF5D5Aw0ou/UWlu8Je4pL+oG/js+8LymC5T
         Hc+wQiW9Wc6R9SpoB3f+l59z26Ar/1PJ/knQlWz9ZWWmFNjwDRpd7RMaBGI3Dp50WHDN
         0eh8UtfiBIfWiE36L86lGMZ3dkx+MUYGUAc9OkQYm9uT0/AZpC8/jc62LwWeG3Mbj8w5
         sbW7/fiWT9xJCWZ2C0njmDE6ZqaExctK9C2GYABqnPK0s1vi7BKG6apNHsMNOcInJ9rS
         Gzq+9BP+f/oBNDd22we9FU//joI3Dep0ykZzbsleTpRE9IvQ46K71yecfHe8rdSCY/P5
         R5og==
X-Gm-Message-State: AOJu0YzPCTLEv7z9AyTepfDJqiRhWIt9P9at5/irtSEHzLrlJX7BvLMd
	FQUJXvvI1RiTxwxRqYPpCbNPqbyVQOMgQAhv8tvwpQ==
X-Google-Smtp-Source: AGHT+IHMmt5YOiqnqyJmgt5GbSkZO+e3pdXkomzdFiTH8EnbCo6hui0lmA+5wOS6OjWLeJyjtrELJJgJAn2Vg0Kjra0=
X-Received: by 2002:a05:6102:523:b0:443:621e:d138 with SMTP id
 m3-20020a056102052300b00443621ed138mr1086192vsa.5.1692307297429; Thu, 17 Aug
 2023 14:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816234303.3786178-1-kuba@kernel.org>
In-Reply-To: <20230816234303.3786178-1-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 17 Aug 2023 14:21:26 -0700
Message-ID: <CAHS8izPB=x1ZYhan-sjuA8ofbHmxbHJrSbtvN3z3zfziBMmMdA@mail.gmail.com>
Subject: Re: [RFC net-next 00/13] net: page_pool: add netlink-based introspection
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	aleksander.lobakin@intel.com, linyunsheng@huawei.com, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
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
> As the page pool functionality grows we will be increasingly
> constrained by the lack of any uAPI. This series is a first
> step towards such a uAPI, it creates a way for users to query
> information about page pools and associated statistics.
>
> I'm purposefully exposing only the information which I'd
> find useful when monitoring production workloads.
>
> For the SET part (which to be clear isn't addressed by this
> series at all) I think we'll need to turn to something more
> along the lines of "netdev-level policy". Instead of configuring
> page pools, which are somewhat ephemeral, and hard to change
> at runtime, we should set the "expected page pool parameters"
> at the netdev level, and have the driver consult those when
> instantiating pools. My ramblings from yesterday about Queue API
> may make this more or less clear...
> https://lore.kernel.org/all/20230815171638.4c057dcd@kernel.org/
>

The patches themselves look good to me, and I'll provide Reviewed-by
for the ones I feel I understand well enough to review, but I'm a bit
unsure about exposing specifically page_pool stats to the user. Isn't
it better to expose rx-queue stats (slightly more generic) to the
user? In my mind, the advantages:

- we could implement better SET apis that allocate, delete, or
reconfigure rx-queues. APIs that allocate or delete page-pool make
less sense semantically maybe? The page-pool doesn't decide to
instantiate itself.

- The api can be extended for non-page-pool stats (per rx-queue
dropped packets maybe, or something like that).

- The api maybe can be extended to non-page-pool drivers. The driver
may be able to implement their own function to provide equivalent
stats (although this one may not be that important).

- rx-queue GET API fits in nicely with what you described yesterday
[1]. At the moment I'm a bit unsure because the SET api you described
yesterday sounded per-rx-queue to me. But the GET api here is
per-page-pool based. Maybe the distinction doesn't matter? Maybe
you're thinking they're unrelated APIs?

[1] https://lore.kernel.org/all/20230815171638.4c057dcd@kernel.org/

> Jakub Kicinski (13):
>   net: page_pool: split the page_pool_params into fast and slow
>   net: page_pool: avoid touching slow on the fastpath
>   net: page_pool: factor out uninit
>   net: page_pool: id the page pools
>   net: page_pool: record pools per netdev
>   net: page_pool: stash the NAPI ID for easier access
>   eth: link netdev to pp
>   net: page_pool: add nlspec for basic access to page pools
>   net: page_pool: implement GET in the netlink API
>   net: page_pool: add netlink notifications for state changes
>   net: page_pool: report when page pool was destroyed
>   net: page_pool: expose page pool stats via netlink
>   tools: netdev: regen after page pool changes
>
>  Documentation/netlink/specs/netdev.yaml       | 158 +++++++
>  Documentation/networking/page_pool.rst        |   5 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   1 +
>  .../net/ethernet/mellanox/mlx5/core/en_main.c |   1 +
>  drivers/net/ethernet/microsoft/mana/mana_en.c |   1 +
>  include/linux/list.h                          |  20 +
>  include/linux/netdevice.h                     |   4 +
>  include/net/page_pool/helpers.h               |   8 +-
>  include/net/page_pool/types.h                 |  43 +-
>  include/uapi/linux/netdev.h                   |  37 ++
>  net/core/Makefile                             |   2 +-
>  net/core/netdev-genl-gen.c                    |  41 ++
>  net/core/netdev-genl-gen.h                    |  11 +
>  net/core/page_pool.c                          |  56 ++-
>  net/core/page_pool_priv.h                     |  12 +
>  net/core/page_pool_user.c                     | 409 +++++++++++++++++
>  tools/include/uapi/linux/netdev.h             |  37 ++
>  tools/net/ynl/generated/netdev-user.c         | 415 ++++++++++++++++++
>  tools/net/ynl/generated/netdev-user.h         | 169 +++++++
>  19 files changed, 1391 insertions(+), 39 deletions(-)
>  create mode 100644 net/core/page_pool_priv.h
>  create mode 100644 net/core/page_pool_user.c
>
> --
> 2.41.0
>


--=20
Thanks,
Mina

