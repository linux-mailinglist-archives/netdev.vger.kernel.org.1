Return-Path: <netdev+bounces-38876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D28A7BCCFE
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 09:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C968B1C208B5
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 07:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC158494;
	Sun,  8 Oct 2023 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="EXadMVdH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C25F46B8
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 07:17:49 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D05B9
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 00:17:48 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d8195078f69so3755886276.3
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 00:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696749467; x=1697354267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feCMf/PVzPML2A1zv9PZFjlJKoK+qWY052JXdX25raM=;
        b=EXadMVdH40YMawSUljAPr6aUlBLpO2F7O14FyK9swFw5LmeuBrDG3kyCzP+B0n7HlA
         mNrWziXQ+cDKirzl7P+nl63ETdCgJDbghnOpk7r0u4ZUGRSqqPaQL/CYukY7MSy4RPD+
         bqKzeWdZYKP0VqhXJ1HwBNrglXzZqJeubYrbcBnS8a/jBV0LcmZIHZqZoBS7MRSl6uGC
         54PdYomDxtAVOBSbR0pWj9TZQPP9DElZQ9ZQ1sfrxrgGg4rMxO7u+WUJXT0/mKqQuE1M
         sCJ4ICYLHZ3V7WKNxL0+zV7A1sWt/0wcuRvl+95OGbNi5zj5SCh7+H1BQ5BMnQAj/6R+
         wynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696749467; x=1697354267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feCMf/PVzPML2A1zv9PZFjlJKoK+qWY052JXdX25raM=;
        b=aS7pCzT/gfplSOXEUmi3OxoDNBj8sFp8z/edKCNM2kQUyofxreMcClgctDCtZxxmOa
         69gjaDRESjGQJ6XUZEeaf5tTD+uUKufO41cOWqkD5nXPAcdfCTNuwiHdQJA5WJ9ofCft
         kWxX4RXVaxMpOEWqLSYEcpsZK4DzCfg+Nc4+3kJjcKpjIe8PAaqeS8lzs4rSSIWU1NAl
         b5HcWJuZrZ9MRJCSiPphXBhE5mTtYqTmH31kuYdg02TauKGoBw8rXQBN+GaWdOlKzXYk
         Dtb0yqEWcpF9vcHhQlnlG+XxQGS8IfLFrxjDdvpJM8B4anO1gmjauhNbTl++hQFUSU1h
         gRUA==
X-Gm-Message-State: AOJu0YxwMUAOkfaOBRSMIosXbS40yZCmL8mMrMbWtWI/VET/rLu56gaU
	2iMJeZlnfWlu2i6IQZSC7+QARNdh70Fpfwr0aAzXYoqQU9O9ndVGnLo=
X-Google-Smtp-Source: AGHT+IGQR8HfLkWryMPezNF2eRyHe53Hle7xrzCABXMv+aI3+anXQBT9sHzxsKDXGxxvuIuwWfkNLmSP+V+aIR3sZOQ=
X-Received: by 2002:a25:d18a:0:b0:d84:b0f8:90e with SMTP id
 i132-20020a25d18a000000b00d84b0f8090emr11749784ybg.5.1696749467521; Sun, 08
 Oct 2023 00:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
 <20231006094911.3305152-4-fujita.tomonori@gmail.com> <CALNs47syMxiZBUwKLk3vKxzmCbX0FS5A37FjwUzZO9Fn-iPaoA@mail.gmail.com>
 <d824a34f-7290-477e-8198-c16164e34861@lunn.ch>
In-Reply-To: <d824a34f-7290-477e-8198-c16164e34861@lunn.ch>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 8 Oct 2023 03:17:35 -0400
Message-ID: <CALNs47sDtbJV9PRB6tU3qDVJtt0701=Cmhh+OuPNPCX3vQGEQg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
	greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 7, 2023 at 11:35=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
> > Looking at this usage, I think `get_link()` should be renamed to just
> > `link()`. `get_link` makes me think that it is performing an action
> > like calling `genphy_update_link`, just `link()` sounds more like a
> > static accessor.
>
> Naming is hard, and i had the exact opposite understanding.
>
> The rust binding seems to impose getter/setters on members of
> phydev. So my opinion was, using get_/set_ makes it clear this is just
> a dumb getter/setter, and nothing more.
>
> > Or maybe it's worth replacing `get_link` with a `get_updated_link`
> > that calls `genphy_update_link` and then returns `link`, the user can
> > store it if they need to reuse it. This seems somewhat less accident
> > prone than someone calling `.link()`/`.get_link()` repeatedly and
> > wondering why their phy isn't coming up.
>
> You have to be very careful with reading the link state. It is latched
> low. Meaning if the link is dropped and then comes back again, the
> first read of the link will tell you it went away, and the second read
> will give you current status. The core expects the driver to read the
> link state only once, when asked what is the state of the link, so it
> gets informed about this short link down events.

Thanks for the clarification, I agree that it makes sense as-is then.

> > In any case, please make the docs clear about what behavior is
> > executed and what the preconditions are, it should be clear what's
> > going to wait for the bus vs. simple field access.
> >
> > > +        if ret as u32 & uapi::BMCR_SPEED100 !=3D 0 {
> > > +            dev.set_speed(100);
> > > +        } else {
> > > +            dev.set_speed(10);
> > > +        }
> >
> > Speed should probably actually be an enum since it has defined values.
> > Something like
> >
> >     #[non_exhaustive]
> >     enum Speed {
> >         Speed10M,
> >         Speed100M,
> >         Speed1000M,
> >         // 2.5G, 5G, 10G, 25G?
> >     }
>
> This beings us back to how do you make use of C #defines. All the
> values defined here are theoretically valid:
>
> https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/ethtool=
.h#L1887
>
> #define SPEED_10                10
> #define SPEED_100               100
> #define SPEED_1000              1000
> #define SPEED_2500              2500
> #define SPEED_5000              5000
> #define SPEED_10000             10000
> #define SPEED_14000             14000
> #define SPEED_20000             20000
> #define SPEED_25000             25000
> #define SPEED_40000             40000
> #define SPEED_50000             50000
> #define SPEED_56000             56000
> #define SPEED_100000            100000
> #define SPEED_200000            200000
> #define SPEED_400000            400000
> #define SPEED_800000            800000
>
> and more speeds keep getting added.
>
> Also, the kAPI actually would allow the value 42, not that any
> hardware i know of actually supports that.

The enum doesn't make sense but maybe we should just generate bindings
for these defines? I suggested that in my reply to Fujita.

- Trevor

