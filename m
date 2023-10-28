Return-Path: <netdev+bounces-45000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AF07DA6A5
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 13:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5C51C209F7
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 11:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0A2FBFE;
	Sat, 28 Oct 2023 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0URMuYB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3D4C8E7;
	Sat, 28 Oct 2023 11:07:57 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E335CCE;
	Sat, 28 Oct 2023 04:07:55 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7afd45199so24109677b3.0;
        Sat, 28 Oct 2023 04:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698491275; x=1699096075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUrmyCS9Gl1vseIXUtZD5oh/d1GyMnOWGrpgoACY5GE=;
        b=W0URMuYBsQuNpiPoyglJ4+rrtkN3Q6xoZAgf/K+bQnMNXaXCMJ1EtfpljTYPBBGxVp
         ZDCvkPQMHToinDp8/jO2wYfO3Bl8KFK1H5M8bz9PqoHVtElOtSQYEeT+pjhntGwcKkke
         9f9RwzMOU4ijXMb4J8SNP0a10mDrM8LtMy+bF11uZyyrLbxVBS1ZxRMNTEY3Uo6U9Sta
         qJt4pZhqQSMc+Elwy2tSxJgHSfj+tcuHe3K15th9Z2ldKT4JUNB6vtazox3XPScRmLma
         QIiAEzt98ISXev2lGyVxStkUEMFPB4tr4S2Aag4lCF3Gvs3oi4pfjZ7XiiZRacxM/BX+
         WERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698491275; x=1699096075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUrmyCS9Gl1vseIXUtZD5oh/d1GyMnOWGrpgoACY5GE=;
        b=GWN5xtPvOwsB6iW73FT8ZC6jXDyuk60D41UrPjl1Z8pvnoE926miWj2vwpgeXumhag
         +kU27m6zIrViGZLt4E+T7SNAvI74TZ49sWw4NHQesIyKjBDMXDlNGbeibA4NeQMCn7fj
         W3aO81fVa2JCcXY7NTNVopsv10r09hRKxf7wVFwe8SGZEUSSVg3OfCa+TflyrtXs/r8N
         HMTatRghqrzfaPtkp2R0JpOsg4QJcpY59gbvwCL1bQ0LyGRsEk6I+2eSpzHYWBov0lmx
         XZxsht73+CxnIBqEOi6sE313J/koOTRhNuoYs6auRLIkTL61aGCOLI+QWEgAGywRkkzH
         Ts/Q==
X-Gm-Message-State: AOJu0Yw7y2cOUbo2LeKhXppMkPLUT9+bt4E9veGmNDS/cMT+CVGsd5lW
	pGxNtMhNCrCRJxPlJkBWdmxWypmYpmb3oPeM5LU=
X-Google-Smtp-Source: AGHT+IFDPgJyeHdDo1TeJpzRqNJah/gYwEAhTYquOctFkoi20tci7+aW7yuvtxe0ucKSKaL5hY1Rpg6esbtDpDbmGFM=
X-Received: by 2002:a81:9b16:0:b0:5a7:aa7b:cb9f with SMTP id
 s22-20020a819b16000000b005a7aa7bcb9fmr5486745ywg.14.1698491275096; Sat, 28
 Oct 2023 04:07:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com>
 <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch> <CANiq72mDVQg9dbtbAYLSoxQo4ZTgyKk=e-DCe8itvwgc0=HOZw@mail.gmail.com>
 <20231027072621.03df3ec0@kernel.org> <CANiq72n=ySX08MMMM6NGL9T5nkaXJXnV2ZsoiXjkwDtfDG11Rw@mail.gmail.com>
 <ca9fc28e-f68a-4b80-b21f-08a3edf3903a@lunn.ch>
In-Reply-To: <ca9fc28e-f68a-4b80-b21f-08a3edf3903a@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 28 Oct 2023 13:07:43 +0200
Message-ID: <CANiq72k4MFe2qL5XrweObo-bxT9qPA6+GAF4bSwLzyQJRX-mJw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, benno.lossin@proton.me, 
	wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2023 at 12:55=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> You will probably find different levels of acceptance of 80 to 100 in
> different subsystems. So i'm not sure you will be able to achieve
> consistence.

I would definitely agree if this were C. I happen to maintain
`.clang-format`, and it was an interesting process to approximate a
"common enough" style as the base one.

But for Rust, it is easy, because all the code is new. All Rust files
are formatted the same way, across the entire kernel.

> It should also be noted that 80, or 100, is not a strict limit. Being
> able to grep the kernel for strings is important. So the coding
> standard allows you to go passed this limit in order that you don't
> need to break a string. checkpatch understands this. I don't know if
> your automated tools support such exceptions.

Not breaking string literals is the default behavior of `rustfmt` (and
we use its default behavior).

It is also definitely possible to turn off `rustfmt` locally, i.e. for
particular "items" (e.g. a function, a block, a statement), rather
than lines, which is very convenient.

However, as far as I recall, we have never needed to disable it. I am
sure it will eventually be needed somewhere, but what I am trying to
say is that it works well enough that one can just use it.

Cheers,
Miguel

