Return-Path: <netdev+bounces-16131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D405974B773
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 21:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5C72817AB
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 19:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEB6174F6;
	Fri,  7 Jul 2023 19:45:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5196223C7
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 19:45:40 +0000 (UTC)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44DA129
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 12:45:38 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7948540a736so860914241.1
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 12:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688759138; x=1691351138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iU2u6jyjsL+K9jRMpPQU8uNMvx+83bRPl0/OY8W41Ck=;
        b=ONUHyKJSr5rwLEbX/VUpM7nu/9iVjO6CRm4RmJbOsqchMYK7CAwJ/TW61GlqN/EJZ6
         B0p/ia6TmDJHlMaEjcjEOLD+XUFAN7vUgtKebnR4Be8bCCbptIP63NEP8W1PRrdmStcx
         1/o6l05JxY7pLXZJo+KMUynOLGPbmke480cqLCeEzuA8As6hd7gLbizWYqeKV10uz3Fj
         jqguCqlfO2y1OdQCvmnAfAw3Li7lFw1/wVFIfnihPoKYtAe/uz+OLoWxJRs4GYPlTQ/q
         hFP8bfrrKj66fCAjlSvYCxVmD6sNuEXeV+DWvh5XwfW4yggNFOHbavpZ7wOjnK9WiltE
         b5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688759138; x=1691351138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU2u6jyjsL+K9jRMpPQU8uNMvx+83bRPl0/OY8W41Ck=;
        b=XAzvTnQ1118Sv8nGQJ5OOkdj90RI3PmCW6btfQZFCF7nBgLRFHBCn0eXuFqHxVX4LJ
         p3eiIt0hZRFU2WKJjIE1qsnPwb0Tn16uvZo5ef1FOqL8ru6NbvIrmoZW8K2srnmLhxIK
         JnaiQKO0kX1yrDqAyfc39aKkPUajyv3Sg1mmf2lpBJwmBfjrlJlHjqGvvZh/tqIQp7LY
         iaHWV6j5/NaIgS+2pQgw6Ii36GSJOnNWUdeBa0DTV4ez5tK3S3IDHtUYo/yVmmoRCNwS
         HXQfCtaFVCkFTFpNmUV6gMcnchUFRbuztfRzRhlowQwrjeIY7fZ3HMAA5qh4K0+R/FsW
         Vviw==
X-Gm-Message-State: ABy/qLY3uKhMI0UBKeiGk3AmYa6PcUi9eaWUCuPjfBw/uo0dkWWefAPK
	UuwXPKGdfcgnZemKhJFWdNjZdW6Il25/1fuptyTtGw==
X-Google-Smtp-Source: APBJJlESBgtVzbJOXeynclCqwvVJo/4AFuM0/HtqVuysmj6VyinZbhYdaNQ5lKrwtTjS48pikdO03dQcoWq4zforvLg=
X-Received: by 2002:a67:f103:0:b0:445:3e5:1f6a with SMTP id
 n3-20020a67f103000000b0044503e51f6amr4857805vsk.34.1688759137551; Fri, 07 Jul
 2023 12:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707183935.997267-1-kuba@kernel.org>
In-Reply-To: <20230707183935.997267-1-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 7 Jul 2023 12:45:26 -0700
Message-ID: <CAHS8izPmQRuBfBB2ddna-RHvorvJs7VtVUqCW80MaxPLUtDHGA@mail.gmail.com>
Subject: Re: [RFC 00/12] net: huge page backed page_pool
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	edumazet@google.com, dsahern@gmail.com, michael.chan@broadcom.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 7, 2023 at 11:39=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Hi!
>
> This is an "early PoC" at best. It seems to work for a basic
> traffic test but there's no uAPI and a lot more general polish
> is needed.
>
> The problem we're seeing is that performance of some older NICs
> degrades quite a bit when IOMMU is used (in non-passthru mode).
> There is a long tail of old NICs deployed, especially in PoPs/
> /on edge. From a conversation I had with Eric a few months
> ago it sounded like others may have similar issues. So I thought
> I'd take a swing at getting page pool to feed drivers huge pages.
> 1G pages require hooking into early init via CMA but it works
> just fine.
>
> I haven't tested this with a real workload, because I'm still
> waiting to get my hands on the right machine. But the experiment
> with bnxt shows a ~90% reduction in IOTLB misses (670k -> 70k).
>

Thanks for CCing me Jakub. I'm working on a proposal for device memory
TCP, and I recently migrated it to be on top of your pp-provider idea
and I think I can share my test results as well. I had my code working
on top of your slightly older API I found here a few days ago:
https://github.com/kuba-moo/linux/tree/pp-providers

On top of the old API I had something with all my functionality tests
passing and performance benchmarking hitting ~96.5% line rate (with
all data going straight to the device - GPU - memory, which is the
point of the proposal). Of course, when you look at the code you may
not like the approach and I may need to try something else, which is
perfectly fine, but my current implementation is pp-provider based.

I'll look into rebasing my changes on top of this RFC and retesting,
but I should share my RFC either way sometime next week maybe. I took
a quick look at the changes you made here, and I don't think you
changed anything that would break my use case.

> In terms of the missing parts - uAPI is definitely needed.
> The rough plan would be to add memory config via the netdev
> genl family. Should fit nicely there. Have the config stored
> in struct netdevice. When page pool is created get to the netdev
> and automatically select the provider without the driver even
> knowing.

I guess I misunderstood the intent behind the original patches. I
thought you wanted the user to tell the driver what memory provider to
use, and the driver to recreate the page pool with that provider. What
you're saying here sounds much better, and less changes to the driver.

>  Two problems with that are - 1) if the driver follows
> the recommended flow of allocating new queues before freeing
> old ones we will have page pools created before the old ones
> are gone, which means we'd need to reserve 2x the number of
> 1G pages; 2) there's no callback to the driver to say "I did
> something behind your back, don't worry about it, but recreate
> your queues, please" so the change will not take effect until
> some unrelated change like installing XDP. Which may be fine
> in practice but is a bit odd.
>

I have the same problem with device memory TCP. I solved it in a
similar way, doing something else in the driver that triggers
gve_close() & gve_open(). I wonder if the cleanest way to do this is
calling ethtool_ops->reset() or something like that? That was my idea
at least. I haven't tested it, but from reading the code it should do
a gve_close() + gve_open() like I want.

> Then we get into hand-wavy stuff like - if we can link page
> pools to netdevs, we should also be able to export the page pool
> stats via the netdev family instead doing it the ethtool -S.. ekhm..
> "way". And if we start storing configs behind driver's back why
> don't we also store other params, like ring size and queue count...
> A lot of potential improvements as we iron out a new API...
>
> Live tree: https://github.com/kuba-moo/linux/tree/pp-providers
>
> Jakub Kicinski (12):
>   net: hack together some page sharing
>   net: create a 1G-huge-page-backed allocator
>   net: page_pool: hide page_pool_release_page()
>   net: page_pool: merge page_pool_release_page() with
>     page_pool_return_page()
>   net: page_pool: factor out releasing DMA from releasing the page
>   net: page_pool: create hooks for custom page providers
>   net: page_pool: add huge page backed memory providers
>   eth: bnxt: let the page pool manage the DMA mapping
>   eth: bnxt: use the page pool for data pages
>   eth: bnxt: make sure we make for recycle skbs before freeing them
>   eth: bnxt: wrap coherent allocations into helpers
>   eth: bnxt: hack in the use of MEP
>
>  Documentation/networking/page_pool.rst        |  10 +-
>  arch/x86/kernel/setup.c                       |   6 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 154 +++--
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   5 +
>  drivers/net/ethernet/engleder/tsnep_main.c    |   2 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |   4 +-
>  include/net/dcalloc.h                         |  28 +
>  include/net/page_pool.h                       |  36 +-
>  net/core/Makefile                             |   2 +-
>  net/core/dcalloc.c                            | 615 +++++++++++++++++
>  net/core/dcalloc.h                            |  96 +++
>  net/core/page_pool.c                          | 625 +++++++++++++++++-
>  12 files changed, 1478 insertions(+), 105 deletions(-)
>  create mode 100644 include/net/dcalloc.h
>  create mode 100644 net/core/dcalloc.c
>  create mode 100644 net/core/dcalloc.h
>
> --
> 2.41.0
>


--=20
Thanks,
Mina

