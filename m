Return-Path: <netdev+bounces-12597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3E6738407
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 14:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCED42812E1
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 12:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5F713AEA;
	Wed, 21 Jun 2023 12:43:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5C9DF4A
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 12:43:41 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9DC10EC
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 05:43:39 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b45a71c9caso77746991fa.3
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 05:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1687351417; x=1689943417;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlKwTeB6ZfvZFGLWekOVXHxcsZgp+JV+UnjBu+4n12g=;
        b=hP8A3Py73CRxLUy0DP7XMrbfM+x3/ZDw39B691itR0Cer8wmF0qA1rHR+uvjOAkocB
         8YJ+xZXilohI2CxttTqxYe1nS3fbF0xLab2i2oNL22jE80BnaOVqF96FVYywCQ3iE0/9
         PencHmYvN5WVl2Lg8CPkAUn/lxzEd1IK8+XU3hGrrWbxmzIc2j0kkcwr1KqdQeiuSQnD
         vfFyZ6GNdt8OwTfOtmeqLKTGBiy80hdVdHto+y9iBeL2tQYM/aSTeNuw1rmI+gZOvxTt
         62x9vuPVqEnK9vF9B/z1n054KhmYprxadPQIrVrRSqMrilFP6mKv3eCSNGX9XlTdLhvI
         y//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687351417; x=1689943417;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wlKwTeB6ZfvZFGLWekOVXHxcsZgp+JV+UnjBu+4n12g=;
        b=HPGIsb/iV5FSM4S4IF4/Y75Uc5RvM1hd2kewnQxhlE1FtLjFpFhj+G5SK4KSZjsuYj
         sHx0wCuFlN6q23TmrnIamCXLgZyvtr3TejztmDKPUgjdF2sDXHBvG2w25Wmp5a+Vrozr
         oR/UQQ2AdBkE5sWAps1tLvTCK5eYm6x/oQFI8WqqfzcECEwFJ2Jc/D76PkJ5FezquRKz
         FuCeHbRu+SCi4CYRBKkt75XDeatGw3+MWsn7/UL0qrvenX/b/+pd2EaeBTqCtL2l2UcM
         YCTOg7A8jebz+QoEo5mZPWh05ZPJMJcmmwVx8wHPB0W3W5nWMKhVUUMPw1M3dIPbyIb8
         EQHQ==
X-Gm-Message-State: AC+VfDxdwAEy+hvalsYLammyL91JxAfFzPrrocrxzPqzfHzUI3Cs1uWh
	Sq9TtWzpeD5BBXXBb9Yx43ZrZQ==
X-Google-Smtp-Source: ACHHUZ7WDcGETB3GB2f0Z+zeHRv2ZxfpNZ/9s163BITfFesWndduVSDxH1rkp+zqRUlpDR8itw35AQ==
X-Received: by 2002:a2e:9e44:0:b0:2b3:4cff:60ce with SMTP id g4-20020a2e9e44000000b002b34cff60cemr8788816ljk.0.1687351417150;
        Wed, 21 Jun 2023 05:43:37 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id v13-20020a2e7a0d000000b002ad92dff470sm871465ljc.134.2023.06.21.05.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 05:43:36 -0700 (PDT)
References: <20230614230128.199724bd@kernel.org>
 <8e9e2908-c0da-49ec-86ef-b20fb3bd71c3@lunn.ch>
 <20230615190252.4e010230@kernel.org>
 <20230616.220220.1985070935510060172.ubuntu@gmail.com>
 <f28d6403-d042-4ffb-9872-044388d0f9d9@lunn.ch>
 <CANiq72mMi=7P9OxSH0+ORYDEyxG3+n5uOv_ooxMJ72YRBRZ+PQ@mail.gmail.com>
User-agent: mu4e 1.10.3; emacs 28.2.50
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, kuba@kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, aliceryhl@google.com
Subject: Re: [PATCH 0/5] Rust abstractions for network device drivers
Date: Wed, 21 Jun 2023 14:30:01 +0200
In-reply-to: <CANiq72mMi=7P9OxSH0+ORYDEyxG3+n5uOv_ooxMJ72YRBRZ+PQ@mail.gmail.com>
Message-ID: <87352lx9xm.fsf@metaspace.dk>
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Fri, Jun 16, 2023 at 3:14=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrot=
e:
>>
>> I think this is something you need to get addressed at a language
>> level very soon. Lots of netdev API calls will be to macros. The API
>> to manipulate skbs is pretty much always used on the hot path, so i
>> expect that it will have a large number of macros. It is unclear to me
>> how well it will scale if you need to warp them all?
>>
>> ~/linux/include/linux$ grep inline skbuff.h  | wc
>>     349    2487   23010
>>
>> Do you really want to write 300+ wrappers?
>
> It would be very nice if at least `bindgen` (or even the Rust
> compiler... :) could cover many of these one-liners. We have discussed
> and asked for this in the past, and messages like this reinforce the
> need/request for this clearly, so thanks for this.
>
> Since `bindgen` 0.64.0 earlier this year [1] there is an experimental
> feature for this (`--wrap-static-fns`), so that is nice -- though we
> need to see how well it works. We are upgrading `bindgen` to the
> latest version after the merge window, so we can play with this soon.
>
> In particular, given:
>
>     static inline int foo(int a, int b) {
>         return a + b;
>     }
>
> It generates a C file with e.g.:
>
>     #include "a.h"
>
>     // Static wrappers
>
>     int foo__extern(int a, int b) { return foo(a, b); }
>
> And then in the usual Rust bindings:
>
>     extern "C" {
>         #[link_name =3D "foo__extern"]
>         pub fn foo(a: ::std::os::raw::c_int, b: ::std::os::raw::c_int)
> -> ::std::os::raw::c_int;
>     }

This is nice! It would be awesome if we could have something similar for
macros. I am not sure if it is possible though. For the null_block
demonstrator I had to move some C macros to Rust, for instance to
implement iterators of bvec [1]. In the particular case of
`bvec_iter_bvec()` it is not possible to wrap the macro in a function
because the macro operates on a value, not a reference. We would have to
pass an argument by value to the wrapping function in order to invoke
the macro on this stack local variable, and then return the value again.
Not really efficient.

[1] https://lore.kernel.org/rust-for-linux/20230503090708.2524310-5-nmi@met=
aspace.dk/

