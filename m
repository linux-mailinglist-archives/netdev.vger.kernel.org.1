Return-Path: <netdev+bounces-12402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A77737519
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 21:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3CC281443
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 19:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665D317FE0;
	Tue, 20 Jun 2023 19:31:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F31171AA
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 19:31:54 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222DDEA
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 12:31:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-988689a5f44so357191266b.1
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 12:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1687289511; x=1689881511;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX3Z8paJOYxAa7WXw3jdtQzgBqer/iLoEtcVAeuC3YM=;
        b=Jl/MDnobbTeTKDYQ/+lJLlcthc3VY5MU8/9iNseOXvOSlP8TaSJkfOs9RFWvsEpPmV
         PIB8XKe8wc4GIJq9tCDH4ARtY8MGvwUuDx16rH/pFGHFTOwIpTuFGYAd5yF3fi0gJtKi
         +V0DC7dyMEoL5X+If4EMEJgPPQdxLzPqNzyDxCbt1pMmNqA9doYRiOctH/aEsnyDbiXo
         OlbA8EVTiTARKoos1g5JlrobTzdNEsqj6bFVf084Bv5b/1DErLHTnXWRwevZXRHbJFjx
         Wk9GbM9JvQJ6cot2Xfdd79nkHW7uvyO/nWejiRZ901Cv6L7lDWqnJBPm5cNx+HPak7zR
         Fd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687289511; x=1689881511;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RX3Z8paJOYxAa7WXw3jdtQzgBqer/iLoEtcVAeuC3YM=;
        b=Wb5q/IOhGphyJ4Nid2SJiGz3dFR+BtqOEW2QmtdTxDtdg5m+f2y71ssRkAW8ulovKx
         XJ1VzicWgfDXrDskvzh6Y2erdowWhzNO3PjMOCAjCaiDpQdH6odsNNimZUZK2pVB5hww
         WP/4657qTaN7YamNHaPgHPUVAgAi931pHSf/HoSyfJn39xnc377sv8QFYb8GCYW/mnEy
         ulVnO3lgSR7a7HY4iDRPCSq6irqrGwiVUfeR3oVFhuFzs7cBEhCzIxs1e/7I9tt4dUaY
         FMfkggOGinaQobzdOJQmed5To9Dr2+mRrBLZNfIgWDuqot25xT/+YSbvGmpv1sScHGFB
         t+Mg==
X-Gm-Message-State: AC+VfDy0BdwDs5OaaUp/c39XfJMIfuXiLTI8WyVqLZ1RQQQVZFDjzozu
	s/rnczCklArbInREvBMxvKaEbw==
X-Google-Smtp-Source: ACHHUZ5L+0MF7EzDzCXAsW/Xf2b/HOMK0I74qvEnK5wcOfb194+q25Vk1k4g734zImPPtNZzTN4VxA==
X-Received: by 2002:a17:907:6096:b0:988:9ec1:a8c8 with SMTP id ht22-20020a170907609600b009889ec1a8c8mr7544224ejc.54.1687289511363;
        Tue, 20 Jun 2023 12:31:51 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id o16-20020a1709064f9000b009890ab4efa9sm1874653eju.32.2023.06.20.12.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:31:50 -0700 (PDT)
References: <20230614230128.199724bd@kernel.org>
 <8e9e2908-c0da-49ec-86ef-b20fb3bd71c3@lunn.ch>
 <20230615190252.4e010230@kernel.org>
 <20230616.220220.1985070935510060172.ubuntu@gmail.com>
 <f28d6403-d042-4ffb-9872-044388d0f9d9@lunn.ch>
 <CANiq72mMi=7P9OxSH0+ORYDEyxG3+n5uOv_ooxMJ72YRBRZ+PQ@mail.gmail.com>
 <a4bc8847-c668-4cff-9892-663516cf8127@lunn.ch>
 <48a98d0c-bfd1-68a9-5d1f-65c942b7c0ef@crisal.io>
 <CANiq72=x9kEniX78vA7fLu+6wiwDKEr=BYy+aCMZ5S+eSRFf+A@mail.gmail.com>
User-agent: mu4e 1.10.3; emacs 28.2.50
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Emilio Cobos =?utf-8?Q?=C3=81lvarez?= <emilio@crisal.io>, Andrew Lunn
 <andrew@lunn.ch>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, kuba@kernel.org,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 aliceryhl@google.com
Subject: Re: [PATCH 0/5] Rust abstractions for network device drivers
Date: Tue, 20 Jun 2023 21:12:49 +0200
In-reply-to: <CANiq72=x9kEniX78vA7fLu+6wiwDKEr=BYy+aCMZ5S+eSRFf+A@mail.gmail.com>
Message-ID: <877cryx74x.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Hi All,

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Mon, Jun 19, 2023 at 1:27=E2=80=AFPM Emilio Cobos =C3=81lvarez <emilio=
@crisal.io> wrote:
>>
>> Hi Andrew, Miguel,
>>
>> On 6/16/23 16:43, Andrew Lunn wrote:
>> > I said in another email, i don't want to suggest premature
>> > optimisation, before profiling is done. But in C, these functions are
>> > inline for a reason. We don't want the cost of a subroutine call. We
>> > want the compiler to be able to inline the code, and the optimiser to
>> > be able to see it and generate the best code it can.
>> >
>> > Can the rust compile inline the binding including the FFI call?
>>
>> This is possible, with cross-language LTO, see:
>>
>>    https://blog.llvm.org/2019/09/closing-gap-cross-language-lto-between.=
html
>>
>> There are some requirements that need to happen for that to work
>> (mainly, I believe, that the LLVM version used by rustc and clang agree).
>>
>> But in general it is possible. We use it extensively on Firefox. Of
>> course the requirements of Firefox and the kernel might be different.
>>
>> I think we rely heavily on PGO instrumentation to make the linker inline
>> ffi functions, but there might be other ways of forcing the linker to
>> inline particular calls that bindgen could generate or what not.
>
> Thanks Emilio! It is nice to hear cross-language LTO is working well
> for Firefox.
>
> Andreas took a look at cross-language LTO some weeks ago, if I
> remember correctly (Cc'd).
>
> I am not sure about the latest status on kernel PGO, though.

I hacked it to work a while back for the NVMe and null_blk drivers. You
need to build the C and Rust parts of the kernel with compatible
clang/rustc compilers (same major version I believe), and then pass the
right compiler flags to get rustc and clang to emit llvm bitcode instead
of ELF files with machine code. As far as I recall, some infrastructure
is present in kbuild, but I had to add some bits to make it build.

Also, I had some issues with LLVM not doing the inline properly and I
had to use `llvm-link` on the bitcode of my module to link in the
bitcode of the C code I wanted to inline. Without that step, inlining
did not happen.

I was able to build and execute in qemu like this, but I was not able to
boot on bare metal. I think the LTO breaks something in C land. I did
not investigate that further.

Eventually I paused the work because I did not observe conclusive
speedups in my benchmarks. I plan to resume the work at some point and
do more rigorous benchmarking to see if I can observe a statistically
significant speedup. Not sure when that will happen though.

Best regards,
Andreas


