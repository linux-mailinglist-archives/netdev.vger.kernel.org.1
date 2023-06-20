Return-Path: <netdev+bounces-12373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57911737387
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 20:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC1E1C20CC2
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DD717722;
	Tue, 20 Jun 2023 18:10:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D482AB23
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 18:10:17 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F565198;
	Tue, 20 Jun 2023 11:10:11 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so7328201276.1;
        Tue, 20 Jun 2023 11:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687284610; x=1689876610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inJZvDJyUb8Nu+i51qS/woZOXldqIjlxsmu5xQEs1PM=;
        b=NN85jh8lM/sSSUZTpV4/5XkaVqfbrHOO4DjFzIWYTJbEAV07mfck3isazdpWFERd77
         TxJmQIjYTI0ddz2YBLEtZkPFX+ZbBeWp+r4TNuXLBffWI0hJpgNEvFMTi797Pkv+KNrf
         NhvXqAl3tj6VUGd8DOFepcC0Z7WjJSFxuUDuf4DWkQY+oZHEPoz6xAFp8iCcPLOQT7pv
         0+s03+iVzf41ZII2JDfvbh97EDoFl3usFfLwXzrTOPIzN4bTF9GgGraanC/hpGseItCT
         k8dXe5ftcWcUNP1rpGzFjz9tI46v6znHr51lsWulLut5lbW38VJNcWFOpQ4rW6Dq0dRi
         oiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687284610; x=1689876610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inJZvDJyUb8Nu+i51qS/woZOXldqIjlxsmu5xQEs1PM=;
        b=OG2QOw4TVeDqhVALt0orY4sfciAvbiJhLaAH8cxXwj252AcjYdcr3axvLo+PTZ9HYu
         vKs1C01ivsam7mp5unSqy+Zshynnf/bT+Qgl1H2GjnMBA44phyKwct9IlX9gh3uAPwRD
         xcJRoVDFmJUuIWL1h0XfA6HX7tmbl/qcXhNRx0wptJgVpIneQzUo/lWgdtQXMvBev3Ft
         erxtozn5KJI+Pl/oVY7WrYc9e4oAwSLyUrmhS/icT/HfNRftsls1d0NJehlm9xAjnnaV
         6XT1Hk62rbV3uXxDOGNEF+E4m2Lq6eqsS/9/m6Px2zHm9xghjrU27K/DGv3HUJLUsTAm
         YEIg==
X-Gm-Message-State: AC+VfDzO/ri1kpn5xK2BMQKY8AxStjv+fkfCn8X9rNYq3Tao+/OBzMrH
	JAZlsuLMCTc9QLpgKe2S1tbzVYJ1il++pxPP87w=
X-Google-Smtp-Source: ACHHUZ6JtjsqjxGzSV8GiYl5NPwNkvAIWZ42oWcq6fe37zGuUxY4XKn0ycCT6zp9nJ2dJCfIamt5g4Gm9cu9GdTbUDo=
X-Received: by 2002:a25:468b:0:b0:be5:521c:b3f1 with SMTP id
 t133-20020a25468b000000b00be5521cb3f1mr10754571yba.2.1687284609939; Tue, 20
 Jun 2023 11:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230614230128.199724bd@kernel.org> <8e9e2908-c0da-49ec-86ef-b20fb3bd71c3@lunn.ch>
 <20230615190252.4e010230@kernel.org> <20230616.220220.1985070935510060172.ubuntu@gmail.com>
 <f28d6403-d042-4ffb-9872-044388d0f9d9@lunn.ch> <CANiq72mMi=7P9OxSH0+ORYDEyxG3+n5uOv_ooxMJ72YRBRZ+PQ@mail.gmail.com>
 <a4bc8847-c668-4cff-9892-663516cf8127@lunn.ch> <48a98d0c-bfd1-68a9-5d1f-65c942b7c0ef@crisal.io>
In-Reply-To: <48a98d0c-bfd1-68a9-5d1f-65c942b7c0ef@crisal.io>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 20 Jun 2023 20:09:58 +0200
Message-ID: <CANiq72=x9kEniX78vA7fLu+6wiwDKEr=BYy+aCMZ5S+eSRFf+A@mail.gmail.com>
Subject: Re: [PATCH 0/5] Rust abstractions for network device drivers
To: =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <emilio@crisal.io>, 
	Andreas Hindborg <nmi@metaspace.dk>
Cc: Andrew Lunn <andrew@lunn.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>, kuba@kernel.org, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 19, 2023 at 1:27=E2=80=AFPM Emilio Cobos =C3=81lvarez <emilio@c=
risal.io> wrote:
>
> Hi Andrew, Miguel,
>
> On 6/16/23 16:43, Andrew Lunn wrote:
> > I said in another email, i don't want to suggest premature
> > optimisation, before profiling is done. But in C, these functions are
> > inline for a reason. We don't want the cost of a subroutine call. We
> > want the compiler to be able to inline the code, and the optimiser to
> > be able to see it and generate the best code it can.
> >
> > Can the rust compile inline the binding including the FFI call?
>
> This is possible, with cross-language LTO, see:
>
>    https://blog.llvm.org/2019/09/closing-gap-cross-language-lto-between.h=
tml
>
> There are some requirements that need to happen for that to work
> (mainly, I believe, that the LLVM version used by rustc and clang agree).
>
> But in general it is possible. We use it extensively on Firefox. Of
> course the requirements of Firefox and the kernel might be different.
>
> I think we rely heavily on PGO instrumentation to make the linker inline
> ffi functions, but there might be other ways of forcing the linker to
> inline particular calls that bindgen could generate or what not.

Thanks Emilio! It is nice to hear cross-language LTO is working well
for Firefox.

Andreas took a look at cross-language LTO some weeks ago, if I
remember correctly (Cc'd).

I am not sure about the latest status on kernel PGO, though.

Cheers,
Miguel

