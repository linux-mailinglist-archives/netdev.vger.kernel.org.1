Return-Path: <netdev+bounces-13059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DF873A104
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A892819AD
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862161C760;
	Thu, 22 Jun 2023 12:35:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B63AAA0
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:35:56 +0000 (UTC)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536E51BC1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:35:53 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-47147ebb849so1945388e0c.3
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687437352; x=1690029352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BwL1XXFpB7Juc23gGcrmpmP3rd5YyIO3kgOAyPIlzcM=;
        b=CqGj2E1L8WAGd6HSmOq2ffig5DVss6jWELqzntl3GKlXUEYm5evoPvavsg0cZPdyUG
         uVYi/gfibC8xVIb/UDtPwlUBdDgsGbxguuycXjG2YxnCEy6H8kcNelG4AmVpMpuckiFA
         eyEowBgxCKXjLiR8L0kyDyIwgAAsE6ldsvwGIJ3f6rUlNWz3fc1ZPRn8DOTpQsHvf9U3
         rCVWH3iloZlCntq1nkRIF3PZgXJe73H9ULOZzTrIaIObG/zpStYEiw4JdcsdNwNBIaPh
         qAF5aEyVo3tt/zl56/6m0CiD/OPH7Vi4QYEnxzx/YEwhml9wARWBRGCZwE5R0GDgcGQY
         E3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687437352; x=1690029352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwL1XXFpB7Juc23gGcrmpmP3rd5YyIO3kgOAyPIlzcM=;
        b=boCM+ghypY2JxI4ZF+hPzwJD7HRU9C4puXrVBVg0IagZbOO3eoI6BbyF+6h06LyNRL
         gEcOrfQSqMl+spIXw9WlNBTUnQyPoDiLTp0jP+h0/VMUZIQi1vQSoSDsNSeVFnJ1lPnc
         tMzUksqZHZoy+NiyO+kKwbQvRgTuONXiHI83AbZze2VesHZEuPsGVsdsGtuXEjOCtMCz
         eN7BmPXcMDTUt9NUJHnasO7cxd9L0XJeb337xDcGqW35K7hS+br6NOjVoBI1LRe9MoN9
         WzIMZ5vDb9Q3f8IWMxwcb1GQL8B/I3Th3DtEQ01EAZoFruQWE3D8cLm9adoRyd+W6L+F
         FLyA==
X-Gm-Message-State: AC+VfDyMxRdLzwumRGog0XKNhkgtzpHQInwEwRR2qUBnmavMsKiNEyfQ
	QzzGywukFR44wZEk8I0T/abfmKQmT08CunqGtGpigQ==
X-Google-Smtp-Source: ACHHUZ4bpL2T9bnI4qregSI95k/VcQbvtJLdxgrvfNu5HuW8eTOaNzhJ0fgEC/46fMtfm/dxsGD0owYkxtdDBTEbKLI=
X-Received: by 2002:a1f:e201:0:b0:471:4ceb:675f with SMTP id
 z1-20020a1fe201000000b004714ceb675fmr5066318vkg.9.1687437352169; Thu, 22 Jun
 2023 05:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuifLivwhCh33kedtpU=6zUpTQ_uSkESyzdRKYp8WbTFQ@mail.gmail.com>
 <ZJLzsWsIPD57pDgc@FVFF77S0Q05N> <ZJQXdFxoBNUdutYx@FVFF77S0Q05N>
In-Reply-To: <ZJQXdFxoBNUdutYx@FVFF77S0Q05N>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 22 Jun 2023 18:05:40 +0530
Message-ID: <CA+G9fYtAutjL3KpZsQyJuk4WqS=Ydi2iyVb5jdecZ-SOuzKCmA@mail.gmail.com>
Subject: Re: next: Rpi4: Unexpected kernel BRK exception at EL1
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, 
	Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Puranjay Mohan <puranjay12@gmail.com>, Song Liu <song@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Mark,

On Thu, 22 Jun 2023 at 15:12, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Jun 21, 2023 at 01:57:21PM +0100, Mark Rutland wrote:
> > On Wed, Jun 21, 2023 at 06:06:51PM +0530, Naresh Kamboju wrote:
> > > Following boot warnings and crashes noticed on arm64 Rpi4 device running
> > > Linux next-20230621 kernel.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > boot log:
> > >
> > > [   22.331748] Kernel text patching generated an invalid instruction
> > > at 0xffff8000835d6580!
> > > [   22.340579] Unexpected kernel BRK exception at EL1
> > > [   22.346141] Internal error: BRK handler: 00000000f2000100 [#1] PREEMPT SMP
> >
> > This indicates execution of AARCH64_BREAK_FAULT.
> >
> > That could be from dodgy arguments to aarch64_insn_gen_*(), or elsewhere, and
> > given this is in the networking code I suspect this'll be related to BPF.
> >
> > Looking at next-20230621 I see commit:
> >
> >   49703aa2adfaff28 ("bpf, arm64: use bpf_jit_binary_pack_alloc")
> >
> > ... which changed the way BPF allocates memory, and has code that pads memory
> > with a bunch of AARCH64_BREAK_FAULT, so it looks like that *might* be related.
>
> For the benefit of those just looknig at this thread, there has been some
> discussion in the original thread for this commit. Summary and links below.
>
> We identified a potential issue with missing cache maintenance:
>
>   https://lore.kernel.org/linux-arm-kernel/ZJMXqTffB22LSOkd@FVFF77S0Q05N/
>
> Puranjay verified that was causing the problem seen here:
>
>   https://lore.kernel.org/linux-arm-kernel/CANk7y0h5ucxmMz4K8sGx7qogFyx6PRxYxmFtwTRO7=0Y=B4ugw@mail.gmail.com/
>
> Alexei has dropped this commit for now:
>
>   https://lore.kernel.org/linux-arm-kernel/CAADnVQJqDOMABEx8JuU6r_Dehyf=SkDfRNChx1oNfqPoo7pSrw@mail.gmail.com/

Thanks for the detailed information.
I am happy to test any proposed fix patches.


>
> Thanks,
> Mark.

- Naresh

