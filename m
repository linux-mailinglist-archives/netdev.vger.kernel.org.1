Return-Path: <netdev+bounces-20691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C8D760A5E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 08:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F011C20E2A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 06:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5085920FC;
	Tue, 25 Jul 2023 06:34:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE51C37
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 06:33:59 +0000 (UTC)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3099A19F
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 23:33:58 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-4812e36d989so1941199e0c.0
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 23:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690266837; x=1690871637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJiABalTnNOwXnyvNkpYhcHXJylF/mDcXUtdtHNtQlo=;
        b=JjF/ChxWctx9l8TcaLzR4eZEiVmL72rdmCOFZibFWPV4KCsyp6+cGWGodIneYy2KFs
         xoZZyVZO9GABg5KJSdBoYeF1jUZwb9A6R7L0CQEVsRa8qqI3DCiuJiOn2fqjJEHOw2/x
         Gk9VPr3jzNGr/1qNA/jY0xJ12cieeEqtAqeMjPGzOdvJ+3r4AFZLFOQ8FpKeANyMuvBQ
         8OkD32Gy3U7Cyt9r18Q1Gq44W2yt3ELo2ALPQpq5p1iUNZ9O0Gh6cgmyYSTRGrZYuuG2
         RSo/4vREQerONmfi48BU6SMu4kF5lv3JoHX01L1mGtPsA5RnSrgjiuubhFClGG/SZeGj
         R4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690266837; x=1690871637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJiABalTnNOwXnyvNkpYhcHXJylF/mDcXUtdtHNtQlo=;
        b=aw8ijmmonZDDoQspJf/N9iguAv3Hn1L6h2vjWLy7sR3ENvjK+GvHk0XeSbSpl3sQ4R
         6SkxyWbqLNnV8ixa1FIf7cOH1I7gnxBpkpxYUalIhLevXS7usG+Y+KQ2NuCmkH6r4OOz
         sUKyJaapmz8y+/HffYcGfL5/dTK+V1l+FfqxMUs/CRlcvGQhtu9pxqJWxwMygzSmEpfF
         j4vG2QLV6cDjVaua8Espb9qfMYiUPIizoeXo6IcgL3kYFgPLe98+Uef9iS9vFnYgzbFA
         /C7hqDaNegXfrfQJOSMduypYaSnosCdwIj21dwo6dIUdeteKLz1miVd/SnBRt+smGvOr
         oJSg==
X-Gm-Message-State: ABy/qLasnRi4pvHyE+dbQk2Z7BM7ed4RaWkh7ay7u1yv2NMPJfTD/19h
	Cf5rvQaUuO9M8r9oiLi0jFdgEHb5XhCyq/vEkfD7gL+Cwi5ct3Me
X-Google-Smtp-Source: APBJJlHqSKuH1SYFf6eixLBXB80dstDot3RlrsqXOAEQuvJWyuFv15EeCvek9py5YvflvvEmbZzEDsw99utxeCV7bk4=
X-Received: by 2002:a1f:4388:0:b0:486:3e4a:8adb with SMTP id
 q130-20020a1f4388000000b004863e4a8adbmr141413vka.6.1690266837163; Mon, 24 Jul
 2023 23:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuifLivwhCh33kedtpU=6zUpTQ_uSkESyzdRKYp8WbTFQ@mail.gmail.com>
 <ZJLzsWsIPD57pDgc@FVFF77S0Q05N> <ZJQXdFxoBNUdutYx@FVFF77S0Q05N>
 <CA+G9fYtAutjL3KpZsQyJuk4WqS=Ydi2iyVb5jdecZ-SOuzKCmA@mail.gmail.com>
 <CANk7y0h+oXNhUzTFQ_Wy-iySRdBi0ezu1Y_hOBtAxmK5AG4dgA@mail.gmail.com> <CANk7y0gi4o+4U6c9QmnDCJDRXNM_98or_4tO-dHOEwZ4fj3gkw@mail.gmail.com>
In-Reply-To: <CANk7y0gi4o+4U6c9QmnDCJDRXNM_98or_4tO-dHOEwZ4fj3gkw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 25 Jul 2023 12:03:45 +0530
Message-ID: <CA+G9fYvjJgLyEHymByjE8y4OhWfTWbUmQOn0oT2FZoL3T4orVw@mail.gmail.com>
Subject: Re: next: Rpi4: Unexpected kernel BRK exception at EL1
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, 
	Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Puranjay,

On Mon, 3 Jul 2023 at 15:07, Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> Hi Naresh,
>
> On Mon, Jun 26, 2023 at 11:04=E2=80=AFAM Puranjay Mohan <puranjay12@gmail=
.com> wrote:
> >
> > Hi Naresh,
> >
> > On Thu, Jun 22, 2023 at 2:35=E2=80=AFPM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > >
> > > Hi Mark,
> > >
> > > On Thu, 22 Jun 2023 at 15:12, Mark Rutland <mark.rutland@arm.com> wro=
te:
> > > >
> > > > On Wed, Jun 21, 2023 at 01:57:21PM +0100, Mark Rutland wrote:
> > > > > On Wed, Jun 21, 2023 at 06:06:51PM +0530, Naresh Kamboju wrote:
> > > > > > Following boot warnings and crashes noticed on arm64 Rpi4 devic=
e running
> > > > > > Linux next-20230621 kernel.
> > > > > >
> > > > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > > >
> > > > > > boot log:
> > > > > >
> > > > > > [   22.331748] Kernel text patching generated an invalid instru=
ction
> > > > > > at 0xffff8000835d6580!
> > > > > > [   22.340579] Unexpected kernel BRK exception at EL1
> > > > > > [   22.346141] Internal error: BRK handler: 00000000f2000100 [#=
1] PREEMPT SMP
> > > > >
> > > > > This indicates execution of AARCH64_BREAK_FAULT.
> > > > >
> > > > > That could be from dodgy arguments to aarch64_insn_gen_*(), or el=
sewhere, and
> > > > > given this is in the networking code I suspect this'll be related=
 to BPF.
> > > > >
> > > > > Looking at next-20230621 I see commit:
> > > > >
> > > > >   49703aa2adfaff28 ("bpf, arm64: use bpf_jit_binary_pack_alloc")
> > > > >
> > > > > ... which changed the way BPF allocates memory, and has code that=
 pads memory
> > > > > with a bunch of AARCH64_BREAK_FAULT, so it looks like that *might=
* be related.
> > > >
> > > > For the benefit of those just looknig at this thread, there has bee=
n some
> > > > discussion in the original thread for this commit. Summary and link=
s below.
> > > >
> > > > We identified a potential issue with missing cache maintenance:
> > > >
> > > >   https://lore.kernel.org/linux-arm-kernel/ZJMXqTffB22LSOkd@FVFF77S=
0Q05N/
> > > >
> > > > Puranjay verified that was causing the problem seen here:
> > > >
> > > >   https://lore.kernel.org/linux-arm-kernel/CANk7y0h5ucxmMz4K8sGx7qo=
gFyx6PRxYxmFtwTRO7=3D0Y=3DB4ugw@mail.gmail.com/
> > > >
> > > > Alexei has dropped this commit for now:
> > > >
> > > >   https://lore.kernel.org/linux-arm-kernel/CAADnVQJqDOMABEx8JuU6r_D=
ehyf=3DSkDfRNChx1oNfqPoo7pSrw@mail.gmail.com/
> > >
> > > Thanks for the detailed information.
> > > I am happy to test any proposed fix patches.
> >
> > I have sent the v4 of the patch series:
> > https://lore.kernel.org/bpf/20230626085811.3192402-1-puranjay12@gmail.c=
om/T/#t
> > This works on my raspberry pi 4 setup. If possible can you test this
> > on the similar setup where it was failing earlier?
>
> I think my previous email was missed.
> Can you test the V4 series in the same setup?

I have tested V4 series and reported issues got fixed.

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Thank you !

> This is still not applied to the bpf-next tree.
>
> Thanks,
> Puranjay.

- Naresh

