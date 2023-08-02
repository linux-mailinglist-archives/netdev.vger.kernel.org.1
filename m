Return-Path: <netdev+bounces-23668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D2676D0F6
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914AD281E42
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEAC8495;
	Wed,  2 Aug 2023 15:05:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DBD6FD0
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:05:05 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452DE3A92
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:04:39 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bbbbb77b38so41799045ad.3
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690988678; x=1691593478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mv7ajk0lc72KppDI6RojwIcZx3JbV1jZKxr8chS9cWo=;
        b=b6YdJ2CWPhbof5060Jt9AjT4Uc92rWZt858i5J3j5oBefaHl4aOCL7iXAk6VOyKbm4
         5TxoU3naLfIqGpUNUmm6rCeCaeL9hanbxyk7/U22ThIsCnTZGDv2Tti8qKoBPUOPCJzb
         vMS8sjbg5D1BB+WsdQHtXDiXydoMzG0tl9EKKrPBkneFL1FDafm5MgtPjeeLVxcWb8s8
         IN3l52SUPPnRy8whr1MIniPFVZuSEyzR43vKkHNbEh2VPUfUQfqPJQjxFKAoR5ovjJRo
         LSa+OgyodashWqNT7A8UhRGyBl9VP72XnG8Vh4S76oLFwBlHkcy76T8Id5LKfTsI7SWs
         KOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690988678; x=1691593478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mv7ajk0lc72KppDI6RojwIcZx3JbV1jZKxr8chS9cWo=;
        b=U+RDIbV6CBLl/8/+DDIF7yBOui2e17Kgj5Dpz8aMzhJ1Fk89oTXkD2TLGTA/XkC62n
         8f7Om4p5XsMqcEBUCJ7kNcFdGpAaTmcQ2a2aZpCRykLV8NHjVWtUxKr3NA07Mhz0IVhk
         UHeRERD/qq8k5RjqIjsd8uzLh0699uRjbVEvlXcw4mBUr6cIBaRlTpZGSJLpewrgghtN
         2i71ukS1bFKC3VlCuXI/nWVZtTrJJybpKMs0+ZNmGGe0ig42uQ2hi/ryGbQy56Bbc/xf
         Bsw74Togxg2yQLmafaUaJ3YssC8CX/eLTUgQ/wgnVn6GEv0/wUeGps64J45hB0rHOmnq
         Irug==
X-Gm-Message-State: ABy/qLac0QkKpv57F0PVdlkZYs2QY5dfRjhO/LXNoPQjs89hcCxyxKZx
	XNTFkGfsxgl3AAIGF/UltjFseWrn0CbkwTEBESg=
X-Google-Smtp-Source: APBJJlHY74xgrBMCegx2XDlov6ylfGPP2a7HzmfVwbTipaSDooWwXrQszdVDtPKs9MCRr+CLsuDEpqsrSUwYRn/Jr6s=
X-Received: by 2002:a17:903:244f:b0:1bc:844:5831 with SMTP id
 l15-20020a170903244f00b001bc08445831mr10392478pls.57.1690988677934; Wed, 02
 Aug 2023 08:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230802145736.gp4bbudizpk7elk3@skbuf>
In-Reply-To: <20230802145736.gp4bbudizpk7elk3@skbuf>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 2 Aug 2023 08:04:01 -0700
Message-ID: <CAKgT0UcDXUFDzVjOj4EkVRoz=zdro+hQx877dvhACMwVnjAagw@mail.gmail.com>
Subject: Re: netif_set_xps_queue() before register_netdev(): correct from an
 API perspective?
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 2, 2023 at 7:57=E2=80=AFAM Vladimir Oltean <vladimir.oltean@nxp=
.com> wrote:
>
> Hi,
>
> When drivers/net/ethernet/freescale/dpaa2/ fails to probe (including -EPR=
OBE_DEFER),
> I see lots of these:
>
> $ cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff042845fbdac0 (size 64):
>   comm "kworker/u16:1", pid 56, jiffies 4294893690 (age 859.844s)
>   hex dump (first 32 bytes):
>     01 00 00 00 14 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 06 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffc754095a7dfc>] slab_post_alloc_hook+0xa4/0x330
>     [<ffffc754095a654c>] __kmem_cache_alloc_node+0x23c/0x308
>     [<ffffc7540952fec0>] __kmalloc_node+0xc0/0x240
>     [<ffffc7540a976934>] __netif_set_xps_queue+0x32c/0xa78
>     [<ffffc7540a9771e4>] netif_set_xps_queue+0x44/0x70
>     [<ffffc7540a1c3540>] update_xps+0xb0/0x158
>     [<ffffc7540a1c0290>] dpaa2_eth_probe+0xd10/0x1368
>     [<ffffc75409b1677c>] fsl_mc_driver_probe+0x2c/0x80
>     [<ffffc75409eb764c>] really_probe+0x13c/0x2f8
>     [<ffffc75409eb666c>] __driver_probe_device+0xac/0x140
>     [<ffffc75409eb7340>] driver_probe_device+0x48/0x218
>     [<ffffc75409eb71d8>] __device_attach_driver+0x128/0x158
>     [<ffffc75409eb33e4>] bus_for_each_drv+0x12c/0x160
>     [<ffffc75409eb63f4>] __device_attach+0xcc/0x1a0
>     [<ffffc75409eb64e8>] device_initial_probe+0x20/0x38
>     [<ffffc75409eb3620>] bus_probe_device+0xa0/0x118
>
> I see that netif_set_xps_queue() allocates dev->xps_maps[], which is
> eventually freed by reset_xps_maps() <- ... <- netif_reset_xps_queues_gt(=
)
> from a number of call sites, including from unregister_netdevice_many_not=
ify().
>
> This is nice, but dpaa2 (above) and emulex/benet/be_main.c call
> netif_set_xps_queue() prior to registering the net device. So no
> deregistration event will take place.
>
> How is the memory supposed to be freed in this case?

We really shouldn't be calling it before the netdev is registered.

That said though the easiest way to clean it up would probably be to
call netdev_reset_tc in case of a failure.

