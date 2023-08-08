Return-Path: <netdev+bounces-25503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8207774612
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1271C20EA7
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D7A15494;
	Tue,  8 Aug 2023 18:52:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C3213AFA
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:52:44 +0000 (UTC)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA2BFE5C
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:26:34 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-79aa1f24ba2so1583031241.2
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 11:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691519193; x=1692123993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbSuxAH1dmgDI1cFhSw3+FjHgNgeooTpwVKeZW63XUA=;
        b=omX3M6W7HI4CkdKEejiKetClW4YUWnvCPUq8gKc/AoVUAnqTLGguQDDx/Sp7R778JN
         J9TSo32CN6hMaWQKcsB0qNqnAfUmpGbESPtgNucK5ozybmP7dGop+fVUtC7USzhv0x20
         JypPvqhLY7OCKJtBcfnX+96fYG5NsovjpKeVeQyTpMIw8hCNkqz97Nj5+31R97GKArfx
         FvTCBQ21Dt/3FRicqjABaU4W4VS+jqKz5MgCjjWoW7/8fz5NgBnX8wQtxRvChUJ90vs8
         M6mrEFvM5V+hgB099+64rLexf3D68SYLB6togDUSjQ9USqOosVkxu49B4wTl+yHLi33a
         3Kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691519193; x=1692123993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbSuxAH1dmgDI1cFhSw3+FjHgNgeooTpwVKeZW63XUA=;
        b=RQ0gUfEq4s4qoDi51dQzUYGI5aU0bGY5BWCZpfSTJHpwEoVPVyAl2TSnwvYAhuNWXm
         +I2i+/vaau5KyRQ8erSmcFA3hEE3kiVTEXnCtxU8Y6FUH6fh3fvuSFqmwo5rLgTB+Y1z
         Ul9ZAHYasq5uM+++8lkyZgBmEv2HL4GJX5mUuTIbIUPdTpkFvTb3N6XcEwtVYTDWQ3qf
         dcbmW2V6nKOBg4Uy0GEpRn4aMrSpxKnBoM2a6zi3OXml5fhi5d6q+Q0hsua223SGQg0o
         iClkS7L+YVvENSDBBOLeImg1caUwTT6bgIpow4BXMtcDyWNsWyKZR+pNIdJ4/iudjDtM
         ykTQ==
X-Gm-Message-State: AOJu0YzAO/md2pREzeeKCCZt1LotsiUFOVr4rnSRxzOsn0Ysn70ohCuL
	uNNDngRlPBMprTeXLoUuiEZL1xKli85b9zpE5KJtQA==
X-Google-Smtp-Source: AGHT+IG8ilz+lyyZPz/QTN9yYwu4PQ8UFXiUmVfIAYHkY7cO5/Ehx+F7e2EvG0Tpci9f03MzRW/uy/lDk0h8r21yu9I=
X-Received: by 2002:a67:f905:0:b0:443:677e:246e with SMTP id
 t5-20020a67f905000000b00443677e246emr716156vsq.5.1691519193393; Tue, 08 Aug
 2023 11:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230807193102.6374-1-brgl@bgdev.pl> <54421791-75fa-4ed3-8432-e21184556cde@lunn.ch>
 <CAMRc=Mc6COaxM6GExHF2M+=v2TBpz87RciAv=9kHr41HkjQhCg@mail.gmail.com>
 <ZNJChfKPkAuhzDCO@shell.armlinux.org.uk> <CAMRc=MczKgBFvuEanKu=mERYX-6qf7oUO2S4B53sPc+hrkYqxg@mail.gmail.com>
 <65b53003-23cf-40fa-b9d7-f0dbb45a4cb2@lunn.ch> <CAMRc=MecYHi=rPaT44kuX_XMog=uwB9imVZknSjnmTBW+fb5WQ@mail.gmail.com>
 <xfme5pgj4eqlgao3vmyg6vazaqk6qz2wq6kitgujtorouogjty@cklyof3xz2zm> <d021b8ae-a6a3-4697-a683-c9bd45e6c74b@lunn.ch>
In-Reply-To: <d021b8ae-a6a3-4697-a683-c9bd45e6c74b@lunn.ch>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 8 Aug 2023 20:26:22 +0200
Message-ID: <CAMRc=MegMdB0LZNRRrCfqFGZQWMFdBhd8o+_NBxwLk0xS99M_w@mail.gmail.com>
Subject: Re: [PATCH 0/2] net: stmmac: allow sharing MDIO lines
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Halaney <ahalaney@redhat.com>, "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 8, 2023 at 5:15=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I'll make the water muddier (hopefully clearer?). I have access to the
> > board schematic (not SIP/SOM stuff though), but that should help here.
> >
> > MAC0 owns its own MDIO bus (we'll call it MDIO0). It is pinmuxed to
> > gpio8/gpio9 for mdc/mdio. MAC1 owns its own bus (MDIO1) which is
> > pinmuxed to gpio21/22.
> >
> > On MDIO0 there are two SGMII ethernet phys. One is connected to MAC0,
> > one is connected to MAC1.
> >
> > MDIO1 is not connected to anything on the board. So there is only one
> > MDIO master, MAC0 on MDIO0, and it manages the ethernet phy for both
> > MAC0/MAC1.
> >
> > Does that make sense? I don't think from a hardware design standpoint
> > this is violating anything, it isn't a multimaster setup on MDIO.
>
> Thanks for taking a detailed look at the schematics. This is how i
> would expect it to be.
>
> > > > > Good point, but it's worse than that: when MAC0 is unbound, it wi=
ll
> > > > > unregister the MDIO bus and destroy all PHY devices. These are no=
t
> > > > > refcounted so they will literally go from under MAC1. Not sure ho=
w
> > > > > this can be dealt with?
> > > >
> > > > unbinding is not a normal operation. So i would just live with it, =
and
> > > > if root decides to shoot herself in the foot, that is her choice.
> > > >
> > >
> > > I disagree. Unbinding is very much a normal operation.
>
> What do you use it for?
>
> I don't think i've ever manually done it. Maybe as part of a script to
> unbind the FTDI driver from an FTDI device in order to use user space
> tools to program the EEPROM? But that is about it.
>
> I actually expect many unbind operations are broken because it is very
> rarely used.
>

When I say "device unbind", I don't just mean manual unbinding using
sysfs. I mean any code path (rmmod, unplugging the USB, etc.) that
leads to the device being detached from its driver. This is a
perfectly normal situation and should work correctly.

I won't be fixing it for this series but may end up looking into
establishing some kind of device links between MACs and their "remote"
PHYs that would allow to safely unbind them.

Bart

