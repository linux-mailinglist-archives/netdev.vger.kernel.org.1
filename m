Return-Path: <netdev+bounces-13894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FCA73DAC6
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 11:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7261C20356
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 09:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0835D63CE;
	Mon, 26 Jun 2023 09:05:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D846BD
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:05:04 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4FB297E;
	Mon, 26 Jun 2023 02:05:01 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b5c231c23aso23618271fa.0;
        Mon, 26 Jun 2023 02:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687770300; x=1690362300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CU/NM81Ebj1GKHm4Cv2oRZR+V4v1s5qM9KflRxjnHHk=;
        b=pU9LqCNabfMbko4C2PyFqG+qzOZANgWkRMEM/wCeO+WMUOinTbiakGZyJlp2fjr/oV
         DSYxEzVDZ6CeZ1q26+Bv2cTfMm6w0NT+c4FEMwGMz+1nffR820P3z4javqdB7MDTRRPA
         TemXIcFkrc/aBjSpaBqZm6KLkunD8li1az5YK72FbuJxBBf5LvKJWPIRq+oSA0s2O63B
         TTYXbRYinloBMQo7Pa99mngUFLsfp9NZJCZg8mwRNWam73MGC5Y0Br9pddcipfm0ddP8
         ToTHNjBY7wbRdNXeTSL0RFyW/4pYg8R/S0OlWkqlHhvaiYEsW2ynk3qEVyqYiiDdPBqa
         FtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687770300; x=1690362300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CU/NM81Ebj1GKHm4Cv2oRZR+V4v1s5qM9KflRxjnHHk=;
        b=ZfV5jgFOl2dxhCgee3vbm+N16lfzaxAg8lILjhE3tXqUQ2OwmobLjTj9M+QAXus02L
         TrNTsFhdR0LF9HatbGgBKfwHCcaH8E0+q/cf5mjohLiRb/7CNPLCECkiNZXQWuFC9ppS
         MzCkne+5rjiFGCsXiiwzuPPyzHjRVrOhT1L5sGFRrC8az5TLXNl719tfKhMHZAAVjPiw
         YNsmLyNav7acD0ne8BrZm5In/wQyNVF2NtMBTQQw/btzM+q/p60c4GCX0EhSmdRSIcvC
         CZds7fBEYAxCHgJghkAJUgyf6HLHcCW/1+qJW4C9e0qk7/7ahq1Jc5E1nlzjAQeeM5Km
         e1Mg==
X-Gm-Message-State: AC+VfDyl4hjFsBr1z105c9E27iaOq1j8i4C5Xh7CuiJXVVthEyPW+gh/
	wMvDl4x4UCJ2cdbj/ZNuQ//ovF4oGH8iMpqeEus=
X-Google-Smtp-Source: ACHHUZ4x9odGESirdVtgYCt4CiCflQFpaYrOo6pD6R7e93AFIUM6uOAt0oM2UCCiVwuCqJLMJRy3RNdMBAmp97yt0/4=
X-Received: by 2002:a2e:9f04:0:b0:2b6:9859:d96c with SMTP id
 u4-20020a2e9f04000000b002b69859d96cmr2089755ljk.51.1687770299501; Mon, 26 Jun
 2023 02:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuifLivwhCh33kedtpU=6zUpTQ_uSkESyzdRKYp8WbTFQ@mail.gmail.com>
 <ZJLzsWsIPD57pDgc@FVFF77S0Q05N> <ZJQXdFxoBNUdutYx@FVFF77S0Q05N> <CA+G9fYtAutjL3KpZsQyJuk4WqS=Ydi2iyVb5jdecZ-SOuzKCmA@mail.gmail.com>
In-Reply-To: <CA+G9fYtAutjL3KpZsQyJuk4WqS=Ydi2iyVb5jdecZ-SOuzKCmA@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 26 Jun 2023 11:04:48 +0200
Message-ID: <CANk7y0h+oXNhUzTFQ_Wy-iySRdBi0ezu1Y_hOBtAxmK5AG4dgA@mail.gmail.com>
Subject: Re: next: Rpi4: Unexpected kernel BRK exception at EL1
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, 
	Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Naresh,

On Thu, Jun 22, 2023 at 2:35=E2=80=AFPM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Hi Mark,
>
> On Thu, 22 Jun 2023 at 15:12, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Wed, Jun 21, 2023 at 01:57:21PM +0100, Mark Rutland wrote:
> > > On Wed, Jun 21, 2023 at 06:06:51PM +0530, Naresh Kamboju wrote:
> > > > Following boot warnings and crashes noticed on arm64 Rpi4 device ru=
nning
> > > > Linux next-20230621 kernel.
> > > >
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > >
> > > > boot log:
> > > >
> > > > [   22.331748] Kernel text patching generated an invalid instructio=
n
> > > > at 0xffff8000835d6580!
> > > > [   22.340579] Unexpected kernel BRK exception at EL1
> > > > [   22.346141] Internal error: BRK handler: 00000000f2000100 [#1] P=
REEMPT SMP
> > >
> > > This indicates execution of AARCH64_BREAK_FAULT.
> > >
> > > That could be from dodgy arguments to aarch64_insn_gen_*(), or elsewh=
ere, and
> > > given this is in the networking code I suspect this'll be related to =
BPF.
> > >
> > > Looking at next-20230621 I see commit:
> > >
> > >   49703aa2adfaff28 ("bpf, arm64: use bpf_jit_binary_pack_alloc")
> > >
> > > ... which changed the way BPF allocates memory, and has code that pad=
s memory
> > > with a bunch of AARCH64_BREAK_FAULT, so it looks like that *might* be=
 related.
> >
> > For the benefit of those just looknig at this thread, there has been so=
me
> > discussion in the original thread for this commit. Summary and links be=
low.
> >
> > We identified a potential issue with missing cache maintenance:
> >
> >   https://lore.kernel.org/linux-arm-kernel/ZJMXqTffB22LSOkd@FVFF77S0Q05=
N/
> >
> > Puranjay verified that was causing the problem seen here:
> >
> >   https://lore.kernel.org/linux-arm-kernel/CANk7y0h5ucxmMz4K8sGx7qogFyx=
6PRxYxmFtwTRO7=3D0Y=3DB4ugw@mail.gmail.com/
> >
> > Alexei has dropped this commit for now:
> >
> >   https://lore.kernel.org/linux-arm-kernel/CAADnVQJqDOMABEx8JuU6r_Dehyf=
=3DSkDfRNChx1oNfqPoo7pSrw@mail.gmail.com/
>
> Thanks for the detailed information.
> I am happy to test any proposed fix patches.

I have sent the v4 of the patch series:
https://lore.kernel.org/bpf/20230626085811.3192402-1-puranjay12@gmail.com/T=
/#t
This works on my raspberry pi 4 setup. If possible can you test this
on the similar setup where it was failing earlier?

>
>
> >
> > Thanks,
> > Mark.
>
> - Naresh


Thanks,
Puranjay

