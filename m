Return-Path: <netdev+bounces-38860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 954167BCC83
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 08:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CDC28198C
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 06:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCB35380;
	Sun,  8 Oct 2023 06:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="iFaU5ccu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB394522F
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 06:07:58 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE970C5
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 23:07:56 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59f82ad1e09so43767047b3.0
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 23:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696745276; x=1697350076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fxqx667kBWfkjF2qFi33yc23pvm6KglFMRleGmFUdZk=;
        b=iFaU5ccuxSc52/07eMZt4dwDW0MzOHN1W1ZTojFb4jes+vSTt564qBw6deCx7V4Bxj
         6P2Dzb8nSmlUIc7cGik5pl94DzJLbSMI65iwfTsnLXMujDMiH/BKSUXmnbO8+pYKJuSc
         TS/RUNo2sb26k4+uoG++7F7VlDnmQJ9smaIEC1FeuJUsh4NFQyVtvSjhFV56hva5xOHq
         CI/7R7Rws2Ki203KNKQXjAugZT6p6gLF9EPebueOCva42iiLm6SRMo+IrrC7PfkdJYhg
         xvZxhlFhKsmxJC5Zlk+axt0cwIaWQx8ozDEuLUvVZWttY78KHUoD25lKiyHCXJzNxD+G
         6FHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696745276; x=1697350076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fxqx667kBWfkjF2qFi33yc23pvm6KglFMRleGmFUdZk=;
        b=xA6KWwpwpI23ErBiJGDzVvpUnuuA4BPABaCgDw4Ca4OK5np8RHQCuIqXHvY5onY8B1
         K2Tnf46OatwLYkrXcQBSiOZP4uYcDcjAEn5zKbHhdVUHI58Ns5AoRulAJE3sWrCgYBuY
         HkYd+yy7vWK/unvL0bNR6GW7dUL1N+dJqDzC+AF+LoOnGrt6ylAseFlmW5uaKkCYgiWG
         T9TNLew3HVzmF2MUiRClnpfNTYK1t+xBW3Ccg+pGr5TMbAwQYeiD7FA0Oop2JoLsjIMc
         VjaSVCNP7dsKO4FPoKGFepNvPs27HgN1xrcNjsasQHDl6Pf6EFGfCk0Io7GrEcKb1GrP
         gNAg==
X-Gm-Message-State: AOJu0Yyv7I1chXeshLC5Cv4ZY0S5CSqzhr7LkHQp/ICa64k2MamHucPO
	JlAOp30EYbc+S9MWgQKWS1JTlBRnqXxTzIOhuWAR+w==
X-Google-Smtp-Source: AGHT+IHnZjv1L+yTcIOxYDaalcI/MuZQ9D4pB9+JjwoSVbPY1u0GNT4LSDy25FqIlJV9ve7JzC3c6uZqWTMqhDzfHEQ=
X-Received: by 2002:a0d:f387:0:b0:589:c065:b419 with SMTP id
 c129-20020a0df387000000b00589c065b419mr14486211ywf.34.1696745276185; Sat, 07
 Oct 2023 23:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
 <20231006094911.3305152-2-fujita.tomonori@gmail.com> <CALNs47sdj2onJS3wFUVoONYL_nEgT+PTLTVuMLcmE6W6JgZAXA@mail.gmail.com>
 <7edb5c43-f17b-4352-8c93-ae5bb9a54412@lunn.ch>
In-Reply-To: <7edb5c43-f17b-4352-8c93-ae5bb9a54412@lunn.ch>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 8 Oct 2023 02:07:44 -0400
Message-ID: <CALNs47ujBcwHG+sgeH3m7gvkW6JKWtD0ZS66ujmswLODuExJhg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: core abstractions for network PHY drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
	greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 7, 2023 at 11:13=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > The safety comment here still needs something like
> >
> >     with the exception of fields that are synchronized via the `lock` m=
utex
>
> I'm not sure that really adds much useful information. Which values
> are protected by the lock? More importantly, which are not protected
> by the lock?
>
> As a general rule of thumb, driver writers don't understand
> locking. Yes, there are some which do, but many don't. So the
> workaround to that is make it so they don't need to understand
> locking. All the locking happens in the core.
>
> The exception is suspend and resume, which are called without the
> lock. So if i was to add a comment about locking, i would only put a
> comment on those two.

This doesn't get used by driver implementations, it's only used within
the abstractions here. I think anyone who needs the details can refer
to the C side, I just suggested to note the locking caveat based on
your second comment at
https://lore.kernel.org/rust-for-linux/ec6d8479-f893-4a3f-bf3e-aa0c81c4adad=
@lunn.ch/

Fujita - since this doesn't get exposed, could this be pub(crate)?)

> > Andrew, are there any restrictions about calling phy_init_hw more than
> > once? Or are there certain things that you are not allowed to do until
> > you call that function?
>
> phy_init_hw can be called multiple times. It used by drivers as a work
> around to broken hardware/firmware to get the device back into a good
> state. It is also used during resume, since often the PHY looses its
> settings when suspended.

Great, thank you for the clarification

> > > +    unsafe extern "C" fn read_mmd_callback(
> > > +        phydev: *mut bindings::phy_device,
> > > +        devnum: i32,
> > > +        regnum: u16,
> > > +    ) -> i32 {
> > > +        from_result(|| {
> > > +            // SAFETY: The C API guarantees that `phydev` is valid w=
hile this function is running.
> > > +            let dev =3D unsafe { Device::from_raw(phydev) };
> > > +            let ret =3D T::read_mmd(dev, devnum as u8, regnum)?;
> > > +            Ok(ret.into())
> > > +        })
> > > +    }
> >
> > Since your're reading a bus, it probably doesn't hurt to do a quick
> > check when converting
> >
> >     let devnum_u8 =3D u8::try_from(devnum).(|_| {
> >         warn_once!("devnum {devnum} exceeds u8 limits");
> >         code::EINVAL
> >     })?
>
> I would actually say this is the wrong place to do that. Such checks
> should happen in the core, so it checks all drivers, not just the
> current one Rust driver. Feel free to submit a C patch adding this.
>
>         Andrew

I guess it does that already:
https://elixir.bootlin.com/linux/v6.6-rc4/source/drivers/net/phy/phy-core.c=
#L556

Fujita, I think we started doing comments when we know that
lossy/bitwise `as` casts are correct. Maybe just leave the code as-is
but add

    // CAST: the C side verifies devnum < 32

?

