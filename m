Return-Path: <netdev+bounces-28403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E53577F57B
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166CF1C21360
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5A5134D5;
	Thu, 17 Aug 2023 11:43:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B03312B72
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:43:47 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A0E1FFF
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 04:43:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so12325011e87.0
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 04:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692272623; x=1692877423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LLeO+5TaiUoPxVlP0JUoWRbfRzZ/YmtwXifoeLeomSw=;
        b=QU/85fM9AOgYUhGKmHWzwxOONrqcjFUwNSMV05dbHeFFgwbensRUW5GbDTPOL1UW+h
         LQ7WCl6ZEIicFUXvoJ139LJP23WWdjZmQRAD5R0C419bjY8mrJFAG1PtfNOusHn+HA1M
         GKS6fQVzA3TsJ1hTX1tjvqvV84zZAu7MQWS7nMBzE777NmatVStX8QXHcfEr0CzsvQHS
         w7NlKLwad7wab55ppkrNaqAV/76LjAY/AkVshJjY0Q7G41gi+K57qQApluCzxI7F8tcs
         oI77h387iC5kkFFGC0c5R+3ZHO46P/cUOh4e5vSPOrl6eX+IePdoHO1zZ5ggHHjMFzJe
         +mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692272623; x=1692877423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLeO+5TaiUoPxVlP0JUoWRbfRzZ/YmtwXifoeLeomSw=;
        b=Vj1eEfZmBB5XnFKR/oI3wzT3YD1q1MVjBlEE+YH4+ybUqAyoq6ZI18KDEhLsinOT77
         43ertF7nupYkt1RyIHIkaW3oak6Z7a1VX0Rb+43ClrViXO8PMwYRBPqE9O+Kul1XaotS
         Qy6Jnpsmh+Ag3il5MdaGV8iUmVcn5bzT4tY8c+SG8ui8pEQcqMfMKRPP5T2OAHEB+yzT
         CbwKPSk4fR7zrTIkTc/fPb84lg5TqPH22FSGgwFV8oN1ps5qjVeXAt/0gftR6EQKulvI
         H4bSjpre/QnrNys3ecs4EubPorhuQxFC9CdHwuiwHGs0I7ZDa/Ni7cfMBQv8uSLfmw8A
         kXPQ==
X-Gm-Message-State: AOJu0YxZzbC0uaIU7jetqPmYfEep4Jz5Sz/zY8tmZKLvab4Q8ezdE5Ol
	YDi8CjEQRZCQJUIm8l9YNkJ9RK3lZh1aCfPlZ/7Fgw==
X-Google-Smtp-Source: AGHT+IEgvPJSYgjV4JyXT4erwkwC00h+Nl59o9Fm0hzlJ68yUqG6GmzKy6oH1Qs90b/uqxnIYfpE5oJjGZWCA7MVYNI=
X-Received: by 2002:ac2:4836:0:b0:4fe:1e74:3f3e with SMTP id
 22-20020ac24836000000b004fe1e743f3emr3473793lft.48.1692272623076; Thu, 17 Aug
 2023 04:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814125643.59334-1-linyunsheng@huawei.com>
 <20230814125643.59334-2-linyunsheng@huawei.com> <CAC_iWjKMLoUu4bctrWtK46mpyhQ7LoKe4Nm2t8jZVMM0L9O2xA@mail.gmail.com>
 <06e89203-9eaf-99eb-99de-e5209819b8b3@huawei.com> <CAC_iWjJ4Pi7Pj9Rm13y4aXBB3RsP9pTsfRf_A-OraXKwaO_xGA@mail.gmail.com>
 <b71d5f5f-0ea1-3a35-8c90-53ef4ae27e79@huawei.com>
In-Reply-To: <b71d5f5f-0ea1-3a35-8c90-53ef4ae27e79@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Aug 2023 14:43:06 +0300
Message-ID: <CAC_iWjJbrwSTT9OT3VjzXkCTdcwShWWaaPJUVC0aG2hR5sbkWg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, 
	Liang Chen <liangchen.linux@gmail.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 17 Aug 2023 at 12:06, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2023/8/17 1:01, Ilias Apalodimas wrote:
> > On Wed, 16 Aug 2023 at 15:49, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> >>
> >> On 2023/8/16 19:26, Ilias Apalodimas wrote:
> >>> Hi Yunsheng
> >>>
> >>> On Mon, 14 Aug 2023 at 15:59, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> >>>>
> >>>> Currently page_pool_alloc_frag() is not supported in 32-bit
> >>>> arch with 64-bit DMA because of the overlap issue between
> >>>> pp_frag_count and dma_addr_upper in 'struct page' for those
> >>>> arches, which seems to be quite common, see [1], which means
> >>>> driver may need to handle it when using frag API.
> >>>
> >>> That wasn't so common. IIRC it was a single TI platform that was breaking?
> >>
> >> I am not so sure about that as grepping 'ARM_LPAE' has a long
> >> list for that.
> >
> > Shouldn't we be grepping for CONFIG_ARCH_DMA_ADDR_T_64BIT and
> > PHYS_ADDR_T_64BIT to find the affected platforms?  Why LPAE?
>
>
> I used the key in the  original report:
>
> https://www.spinics.net/lists/netdev/msg779890.html
>
> >> Please see the bisection report below about a boot failure on
> >> rk3288-rock2-square which is pointing to this patch.  The issue
> >> appears to only happen with CONFIG_ARM_LPAE=y.
>
> grepping the 'CONFIG_PHYS_ADDR_T_64BIT' seems to be more common?
> https://elixir.free-electrons.com/linux/v6.4-rc6/K/ident/CONFIG_PHYS_ADDR_T_64BIT
>

Yes, grepping around a bit uncovered this arch/arm/mm/Kconfig, which
enables PHYS_ADDR_T_64BIT if ARM_LPAE is enabled.  Then
ARCH_DMA_ADDR_T_64BIT
is also enabled from kernel/dma/Kconfig.  But that doesn't mean
grepping for any of those uncovers all the problematic platforms,
there are more than Arm platforms.  The ones that will actually fail
are
- ARCH_DMA_ADDR_T_64BIT is enabled and it's a 32bit architecture
- You have a network driver for that platform that uses page pool.

The combination of these shouldn't be that common.  The only one that
comes to mind is the stmmac driver, which the report was for.

> >
> >>
> >>>
> >>>>
> >>>> In order to simplify the driver's work when using frag API
> >>>> this patch allows page_pool_alloc_frag() to call
> >>>> page_pool_alloc_pages() to return pages for those arches.
> >>>
> >>> Do we have any use cases of people needing this?  Those architectures
> >>> should be long dead and although we have to support them in the
> >>> kernel,  I don't personally see the advantage of adjusting the API to
> >>> do that.  Right now we have a very clear separation between allocating
> >>> pages or fragments.   Why should we hide a page allocation under a
> >>> frag allocation?  A driver writer can simply allocate pages for those
> >>> boards.  Am I the only one not seeing a clean win here?
> >>
> >> It is also a part of removing the per page_pool PP_FLAG_PAGE_FRAG flag
> >> in this patchset.
> >
> > Yes, that happens *because* of this patchset.  I am not against the
> > change.  In fact, I'll have a closer look tomorrow.  I am just trying
> > to figure out if we really need it.  When the recycling patches were
> > introduced into page pool we had a very specific reason.  Due to the
> > XDP verifier we *had* to allocate a packet per page.  That was
>
> Did you mean a xdp frame containing a frag page can not be passed to the
> xdp core?
> What is exact reason why the XDP verifier need a packet per page?
> Is there a code block that you can point me to?

It's been a while since I looked at this, but doesn't __xdp_return()
still sync the entire page if the mem type comes from page_pool?

>
> I wonder if it is still the case for now, as bnxt and mlx5 seems to be
> supporting frag page and xdp now.

I only looked at bnxt, but that doesnt seem to be entirely true.  That
code still allocates pages if an XDP prog is installed.  The only case
where it allocates fragments is if the kernel is compiled with 65k
pages, but the hardware doesnt support that (check for
BNXT_RX_PAGE_SHIFT)


Thanks
/Ilias
>
> > expensive so we added the recycling capabilities to compensate and get
> > some performance back. Eventually we added page fragments and had a
> > very clear separation on the API.
> >
> > Regards
> > /Ilias
> >>
> >>>
> >>> Thanks
> >>> /Ilias
> >>>
> > .
> >

