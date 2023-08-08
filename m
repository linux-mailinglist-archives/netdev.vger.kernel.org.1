Return-Path: <netdev+bounces-25369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB324773CE3
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186351C20EAE
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F90B13FFF;
	Tue,  8 Aug 2023 15:56:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E8333E1
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:56:04 +0000 (UTC)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D249190
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:55:47 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-348ccbf27eeso24462285ab.0
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691510121; x=1692114921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgs4Fm92pOwgiTtgi3t0TURwZ645hXw810Qm9YB3fW0=;
        b=1hsy8o58UxsUIQ3JqXj8nnGSuI5CQ/6WzEjxf4ZIOzOgrr6EaOA7cpZ3GvUui5EnFT
         KndhVctqzgmunFGhBtNTa1/NtNvofo3ruKivQ+T7FuAba0MJ5O5Y5mUO4krW3lVSIq4c
         OX56N60aQg6DYwr2jPN8JTwK0SPh7WZF79MR7HYBRxs6mMPAbwx8JdWY/MkUJcudQfuN
         urG1dfzGi3SMcnG+XO3X0SmHlKEd0b+ZnZSIXhkayX735qNtCJF4XAdcKSW0CNOdc82z
         YQjn29BdK5SRBg8O6KeDIxQ4v8DW5EBdaTyhtopIRe4PQgR3y16SnAfkfjqk1ERwnFuV
         KK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510121; x=1692114921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgs4Fm92pOwgiTtgi3t0TURwZ645hXw810Qm9YB3fW0=;
        b=jJcQ629j8Ala1RuHlS2juqsutoUiuf57r+ueBmBLrQ3CpdwwhzootX01NuxKmvV56F
         71CfSEkyDi/CYs0+BXxhknxA9bpC/GRmiYMD28ZrbhL3TEE5mdlnkprLmCbbOODipd64
         uRcUVVnprWTsW8lokKKg+RyOAZeboo5YB3z1oiOGs5dwBk6o7sCKOuM0zm4mzJAfEmhB
         gXiArkvlMJt8Q9WZ/nMcjAXuXsQrUonUtqMfIzuD03eNHfJW7rowb52E0fyRzuhuTKyN
         WOZwZ5VqEB8WZMTmcm7CWpcPEwmRqi4XzPkBjpqlJ6GreZEJ4R+m7UAieHFnYIqWKPZN
         HzNA==
X-Gm-Message-State: AOJu0Yw6RCjoV+KuocOgY2RX9kzDbPGa3HHOpdBCPWEh+qw7MwcCREHV
	NBMvtplTgMMagYDZsTZ7gJcfaFsP8eNx187jUXR3qyeNne/odSsv3ZI=
X-Google-Smtp-Source: AGHT+IEUOZn+oWGOzEe6eb18PD1LJbJH+AEz15hO43+Evd9T1seVx+elc0H04Xz8tIq6S3q/dujX/7mkZrhXRTgW+JU=
X-Received: by 2002:a05:6358:c19:b0:139:e3a4:7095 with SMTP id
 f25-20020a0563580c1900b00139e3a47095mr14782675rwj.7.1691503762572; Tue, 08
 Aug 2023 07:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230807193102.6374-1-brgl@bgdev.pl> <54421791-75fa-4ed3-8432-e21184556cde@lunn.ch>
 <CAMRc=Mc6COaxM6GExHF2M+=v2TBpz87RciAv=9kHr41HkjQhCg@mail.gmail.com> <ZNJChfKPkAuhzDCO@shell.armlinux.org.uk>
In-Reply-To: <ZNJChfKPkAuhzDCO@shell.armlinux.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 8 Aug 2023 16:09:11 +0200
Message-ID: <CAMRc=MczKgBFvuEanKu=mERYX-6qf7oUO2S4B53sPc+hrkYqxg@mail.gmail.com>
Subject: Re: [PATCH 0/2] net: stmmac: allow sharing MDIO lines
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 8, 2023 at 3:26=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Aug 08, 2023 at 10:13:09AM +0200, Bartosz Golaszewski wrote:
> > Ok so upon some further investigation, the actual culprit is in stmmac
> > platform code - it always tries to register an MDIO bus - independent
> > of whether there is an actual mdio child node - unless the MAC is
> > marked explicitly as having a fixed-link.
> >
> > When I fixed that, MAC1's probe is correctly deferred until MAC0 has
> > created the MDIO bus.
> >
> > Even so, isn't it useful to actually reference the shared MDIO bus in s=
ome way?
> >
> > If the schematics look something like this:
> >
> > --------           -------
> > | MAC0 |--MDIO-----| PHY |
> > -------- |     |   -------
> >          |     |
> > -------- |     |   -------
> > | MAC1 |--     ----| PHY |
> > --------           -------
> >
> > Then it would make sense to model it on the device tree?
>
> So I think what you're saying is that MAC0 and MAC1's have MDIO bus
> masters, and the hardware designer decided to tie both together to
> a single set of clock and data lines, which then go to two PHYs.

The schematics I have are not very clear on that, but now that you
mention this, it's most likely the case.

>
> In that case, I would strongly advise only registering one MDIO bus,
> and avoid registering the second one - thereby preventing any issues
> caused by both MDIO bus masters trying to talk at the same time.
>

I sent a patch for that earlier today.

> The PHYs should be populated in firmware on just one of the buses.
>
> You will also need to ensure that whatever registers the bus does
> make sure that the clocks necessary for communicating on the bus
> are under control of the MDIO bus code and not the ethernet MAC
> code. We've run into problems in the past where this has not been
> the case, and it means - taking your example above - that when MAC1
> wants to talk to its PHY, if MAC0 isn't alive it can't.

Good point, but it's worse than that: when MAC0 is unbound, it will
unregister the MDIO bus and destroy all PHY devices. These are not
refcounted so they will literally go from under MAC1. Not sure how
this can be dealt with?

>
> So just be aware of the clocking situation and make sure that your
> MDIO bus code is managing the clocks necessary for the MDIO bus
> master to work.

Doesn't seem like stmmac is ready for it as it is now so this is going
to be fun...

Bartosz

>
> In regard to sharing of the MDIO bus signals between two bus
> masters, I do not believe that is permissible - there's no
> collision detection in hardware like there is on I=E6=B6=8E. So
> having two MDIO bus masters talking at the same time would
> end up corrupting the MDC (clock) and MDIO (data) signals if
> both were active at the same time.
>

