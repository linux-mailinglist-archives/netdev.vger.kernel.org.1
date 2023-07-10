Return-Path: <netdev+bounces-16548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B188374DC8B
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 19:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1AE1C20B49
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 17:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8621426B;
	Mon, 10 Jul 2023 17:32:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B814267
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 17:32:07 +0000 (UTC)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DD5B7
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 10:32:05 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-443746c638eso1307006137.2
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 10:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689010324; x=1691602324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8riEtGipjhQ642ttfyt1rVFepShBRiIDBJTv+VyG4+M=;
        b=e5quYpejRWBED2qx8j5z54IdQwOMtbDjUzAc5b0hfeOTPydbXYzn3B6lhnRqZVepAM
         8aBUwcQ7/uqoBA5FrP5k/aPVx6mRFZ5TIEgWsdoBVVeCLcRAR/m9+ndBSqy8K5Cr0KZL
         svD2I3P4uV0xIpTm0egl2SPPrlzD1ltvYu1/Wk8EJfyogDMywLR7XEkkXyKFHpTv3yDW
         cZFfMC9QxA0eBbNdsMiMev2d3K3QaqN3uat+XeY8yOX5S6/xj7H3IyUb0tO0CXmEqGKv
         SxzpQh9LfBPGjwNN6Nmm49rY3FGQrcHo8Je0oI20Gpzu47qpbMOBKXCwB2vf1eXcey5Q
         NrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689010324; x=1691602324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8riEtGipjhQ642ttfyt1rVFepShBRiIDBJTv+VyG4+M=;
        b=SRGUEV5F5qNdF1dyGUKV9tsiyWw8TwDlY2FcpuD3LoD9WJXl+9JwzT+FuDGW75iPJ8
         CIxyYuxMY+jqAzdjHcqRC7xTTBxE+kmCKpmPxyYUE7MDFaqGQN+7sE5WZBY2m+4A/pb0
         qH/Dwx7i5dhLW8uKgwq1YxbzsrnfU5LCqRKZKmOyn5jnPcZ9rj2vhsu5dT1BRu9abrmS
         Oyp5WGPeZ3NgMXZ517CQtra+z68H3BjBYnJUGbPidmi8ZknKie7Y1Qy25RSbWqb7XxM/
         cNuBVpEMH3YPspLIQ6rvqsxBEZ/VkCBUki+Rzq0GqpJxv12DXXywC9Rv8jpsWBDWohvC
         7/aA==
X-Gm-Message-State: ABy/qLbySlNx+eGeHrhM5yoRJTI5yIn/sHaZUIYDP9O/TkkVEqe++LPG
	5q5QQDP0xrGa3sOM+YbhsOdSRQZid6Q744KNem6RIw==
X-Google-Smtp-Source: APBJJlE4nnABwVJQMsXHJPE4PUXPX2CdrRdaOtp3AlUHxs33MsoXIbCpHSrqgS8nXCsssbis/afLtnQcawNuZwsY8LY=
X-Received: by 2002:a67:fd09:0:b0:443:791d:b238 with SMTP id
 f9-20020a67fd09000000b00443791db238mr5639788vsr.9.1689010324553; Mon, 10 Jul
 2023 10:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707183935.997267-1-kuba@kernel.org> <CAHS8izPmQRuBfBB2ddna-RHvorvJs7VtVUqCW80MaxPLUtDHGA@mail.gmail.com>
 <20230707154503.57cc834e@kernel.org>
In-Reply-To: <20230707154503.57cc834e@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 10 Jul 2023 10:31:53 -0700
Message-ID: <CAHS8izOdqajoPbzPHE-_e1BF+xpVgUphwknPSEqcHDJDcYtKng@mail.gmail.com>
Subject: Re: [RFC 00/12] net: huge page backed page_pool
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	edumazet@google.com, dsahern@gmail.com, michael.chan@broadcom.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 7, 2023 at 3:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 7 Jul 2023 12:45:26 -0700 Mina Almasry wrote:
> > > This is an "early PoC" at best. It seems to work for a basic
> > > traffic test but there's no uAPI and a lot more general polish
> > > is needed.
> > >
> > > The problem we're seeing is that performance of some older NICs
> > > degrades quite a bit when IOMMU is used (in non-passthru mode).
> > > There is a long tail of old NICs deployed, especially in PoPs/
> > > /on edge. From a conversation I had with Eric a few months
> > > ago it sounded like others may have similar issues. So I thought
> > > I'd take a swing at getting page pool to feed drivers huge pages.
> > > 1G pages require hooking into early init via CMA but it works
> > > just fine.
> > >
> > > I haven't tested this with a real workload, because I'm still
> > > waiting to get my hands on the right machine. But the experiment
> > > with bnxt shows a ~90% reduction in IOTLB misses (670k -> 70k).
> >
> > Thanks for CCing me Jakub. I'm working on a proposal for device memory
> > TCP, and I recently migrated it to be on top of your pp-provider idea
> > and I think I can share my test results as well. I had my code working
> > on top of your slightly older API I found here a few days ago:
> > https://github.com/kuba-moo/linux/tree/pp-providers
> >
> > On top of the old API I had something with all my functionality tests
> > passing and performance benchmarking hitting ~96.5% line rate (with
> > all data going straight to the device - GPU - memory, which is the
> > point of the proposal). Of course, when you look at the code you may
> > not like the approach and I may need to try something else, which is
> > perfectly fine, but my current implementation is pp-provider based.
> >
> > I'll look into rebasing my changes on top of this RFC and retesting,
> > but I should share my RFC either way sometime next week maybe. I took
> > a quick look at the changes you made here, and I don't think you
> > changed anything that would break my use case.
>
> Oh, sorry I didn't realize you were working on top of my changes
> already. Yes, the memory provider API should not have changed much.
> I mostly reshuffled the MEP code to have both a coherent and
> non-coherent buddy allocator since then.
>

No worries at all. I don't mind rebasing to new versions (and finding
out if they work for me).

> > > In terms of the missing parts - uAPI is definitely needed.
> > > The rough plan would be to add memory config via the netdev
> > > genl family. Should fit nicely there. Have the config stored
> > > in struct netdevice. When page pool is created get to the netdev
> > > and automatically select the provider without the driver even
> > > knowing.
> >
> > I guess I misunderstood the intent behind the original patches. I
> > thought you wanted the user to tell the driver what memory provider to
> > use, and the driver to recreate the page pool with that provider. What
> > you're saying here sounds much better, and less changes to the driver.
> >
> > >  Two problems with that are - 1) if the driver follows
> > > the recommended flow of allocating new queues before freeing
> > > old ones we will have page pools created before the old ones
> > > are gone, which means we'd need to reserve 2x the number of
> > > 1G pages; 2) there's no callback to the driver to say "I did
> > > something behind your back, don't worry about it, but recreate
> > > your queues, please" so the change will not take effect until
> > > some unrelated change like installing XDP. Which may be fine
> > > in practice but is a bit odd.
> >
> > I have the same problem with device memory TCP. I solved it in a
> > similar way, doing something else in the driver that triggers
> > gve_close() & gve_open(). I wonder if the cleanest way to do this is
> > calling ethtool_ops->reset() or something like that? That was my idea
> > at least. I haven't tested it, but from reading the code it should do
> > a gve_close() + gve_open() like I want.
>
> The prevailing wisdom so far was that close() + open() is not a good
> idea. Some NICs will require large contiguous allocations for rings
> and context memory and there's no guarantee that open() will succeed
> in prod when memory is fragmented. So you may end up with a close()d
> NIC and a failure to open(), and the machine dropping off the net.
>
> But if we don't close() before we open() and the memory provider is
> single consumer we'll have problem #1 :(
>
> BTW are you planning to use individual queues in prod? I anticipated
> that for ZC we'll need to tie multiple queues into an RSS context,
> and then configure at the level of an RSS context.

Our configuration:

- We designate a number of RX queues as devmem TCP queues.
- We designate the rest as regular TCP queues.
- We use RSS to steer all incoming traffic to the regular TCP queues.
- We use flow steering to steer specific TCP flows to the devmem TCP queues=
.

--=20
Thanks,
Mina

