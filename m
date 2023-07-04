Return-Path: <netdev+bounces-15276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1205374688A
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 06:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F39280D3F
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 04:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1883F634;
	Tue,  4 Jul 2023 04:54:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF27ED
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 04:54:23 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9071DFA
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 21:54:22 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b699a2fe86so85385261fa.3
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 21:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688446461; x=1691038461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XSavZWH+SR9Y0pv5ixwnMo8WcTRio+BHQaD3Nrkpm4=;
        b=ELoy7bmXrbbwjMaBS/QFpQRQwK5530aR/ApPnLvmQDq4Oiu5+2BCrnFPZxsqcGcjEi
         aXDWwoGUXbRXo8O8+RANVwuhcrkvYMAFficoewGT05BFsLqI89RqBUphMFeb92NEP4yH
         Mqg1azBRXd0u6Skjp8xK0kNnWqsCLJc9C/QTfSM/z0p49QATUAvioqQqiMNue1i81aeb
         jSub5NBoNKceOfNMm8GWz6LROHBossL3+SHC5dlwQltyeXWEmzyenxaEjTSuG+hiYpXI
         l2xHRkXq17aTfa+MZ1Co0GGsflo/K6w6FycNo0k1pWK0iGui34dPIdgx19B81Tgq4Q3n
         16kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688446461; x=1691038461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XSavZWH+SR9Y0pv5ixwnMo8WcTRio+BHQaD3Nrkpm4=;
        b=Blaoof0UHHPX3aogK36LrAJ1kyJMbhWuBXst1395tIWUo1gnVUQQoubEtGNFFID+ef
         KHqea/uP47f/CzMYMt5LMxTgxLtv/3cW7PF9Xu4/GpD+JWLL0/MmpNehvSZZbQ82eYX4
         d5aYU84rAdEUCPFmsxcCuGazr4H8PFTdvFKNWt5/EOrbRJbCmPBQz0E160pHpjfRnnZC
         FpjamP0K9arZfnW4uw4YZcRoP3f6OruNQZsSSnhz+QYo1neMVeH+m6BSpq2nyj5350FD
         hJy3za9AKhBC6s3jv7tPiOgQdxsuipvDo5/FdMEhoYqvUTBi6OnnaMGa528BKEPu17lI
         +OBw==
X-Gm-Message-State: ABy/qLbD1DESrYefmtQuMJd5YpU8AMfTEM90ETE99Ru+3KDZynuQsVnW
	MMSjoynAj13LtB1A57Sv6rW8st1EaRtuJEVfRFU=
X-Google-Smtp-Source: APBJJlHdWOXwQN2qD5TbHUQ1sm3MN9GaRsUsq2nhe8hDluWdNBQoOeyWT1lHfA1UiE/+Sg3b6kZGFWst+P32YWQbQFg=
X-Received: by 2002:a2e:9c14:0:b0:2b6:f009:d1b with SMTP id
 s20-20020a2e9c14000000b002b6f0090d1bmr1432449lji.49.1688446460568; Mon, 03
 Jul 2023 21:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628121150.47778-1-liangchen.linux@gmail.com>
 <20230630160709.45ea4faa@kernel.org> <CAKhg4t+hoOiVWMbBiD7HCu_Z5pSdCsZrev2FMEKhbWvzgHCarw@mail.gmail.com>
 <20230703115326.69f8953b@kernel.org> <8fb342b4-a843-6d67-b72f-19f2da38cfaa@huawei.com>
In-Reply-To: <8fb342b4-a843-6d67-b72f-19f2da38cfaa@huawei.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Tue, 4 Jul 2023 12:54:08 +0800
Message-ID: <CAKhg4tJ+b4cdHeAv0D63sdw9p0kPyfo5LvoW+uxu6Y1WRKFF2Q@mail.gmail.com>
Subject: Re: [PATCH net-next] skbuff: Optimize SKB coalescing for page pool case
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Jakub Kicinski <kuba@kernel.org>, ilias.apalodimas@linaro.org, hawk@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 4, 2023 at 8:50=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2023/7/4 2:53, Jakub Kicinski wrote:
> > On Mon, 3 Jul 2023 17:12:46 +0800 Liang Chen wrote:
> >> As for the "pp" reference, it has the test
> >> page_pool_is_pp_page_frag(head_page) there. So for a non-frag pp page,
> >> it will be a get_page call.
> >
> > You don't understand - you can't put a page from a page pool in two
> > skbs with pp_recycle set, unless the page is frag'ed.
>
> Agreed. I think we should disallow skb coaleasing for non-frag pp page
> instead of calling get_page(), as there is data race when calling
> page_pool_return_skb_page() concurrently for the same non-frag pp page.
>
> Even with my patchset, it may break the arch with
> PAGE_POOL_DMA_USE_PP_FRAG_COUNT being true.
>

Yeah, that's my fault. I thought __page_pool_put_page handles this
elevated refcnt, but overlooked that the second skb release would
enter page_pool_return_skb_page again, not directly calling put_page.

Disallowing skb coalescing for non-frag pp pages sounds good; we will
handle this problem on v2 after Yunsheng's changes are finalized.

> > .
> >

