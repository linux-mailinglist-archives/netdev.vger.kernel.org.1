Return-Path: <netdev+bounces-27519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C8C77C35E
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 00:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441D1281284
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 22:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089DE100CE;
	Mon, 14 Aug 2023 22:21:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE396DF47
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 22:21:33 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E07F18B
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 15:21:32 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d678b44d1f3so4427282276.0
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 15:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692051691; x=1692656491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1xaUQI2fxozmkGVocHLZICmPCuoU6o/UqfLTnqyztE=;
        b=KYrUw81rSfN4N/IgsfQvP8W/gIRdhfmptGgPNcLI1VCRWES761nt14rFnLtFVVGH4F
         aJJwCEdclRs1QhlWDHbj9hjpuSzd+psviCN6QhOo3HJdeE5+PgoBEPWqbP/fLKiSLQlh
         zX+goPiVj0cjymGhkyWJzLKsa+fXl7L82zUiERc0ERvM0cTQwonq94DWiBWt32yhHYje
         QjiG5eBk3Fuc9zgLkC6rsDtviuKDo3j+X3b6wXdK1H2Dmrd82nMV+dUJjv4WrA+xV0Mn
         U4AH4w5uT29awx5MhUv2ubVhmuQaPQhY0lH8yazEc1C4GHVtNdDIT4lKHdpdbsPSZwVz
         B9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692051691; x=1692656491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1xaUQI2fxozmkGVocHLZICmPCuoU6o/UqfLTnqyztE=;
        b=D9ZpDeg6DHIyRUZ5B9Q7r3WEO6tuGDqnmv38OcRs1Hht1ZfdInckbKtxDKt//nnbWA
         wIqCuXJkGEiiFZSvHJb2J/s1Ls6bcn0ynqBqz+38QseUVX3TIHmi8ZRTmOOyj30VN9cd
         cdieHQ8voPtURrsaEDF3JmTIUoDWEvOcbRSpu7mKA3LXQEdvXYo8P5KltKeV8gzVvMoD
         vSXlT58WXUOwO5UfhahhTHuJyPXXCnAhJB/gXgAg+ncSX3aElAY/GkuDajWTqF0FYAqp
         4jAn0GsYi+i2JabY9H2YSIopqJ1EUzc96AxVQXSuacivpt26gUmwzZSQeFk0Fug1ggXz
         TjLQ==
X-Gm-Message-State: AOJu0YyXj4EeYuNbz1Jj3+E9a+BL+taD7cNuz/xqnY8Gx2gMUe7sSKQs
	u+zlsWRav/utNJ+YTmV/AiyVJfFoPOUDeb0JZWR1ZA==
X-Google-Smtp-Source: AGHT+IExJ6fBl4MMh1Y3D/xRU1oKKR8UFjWH6xs6gYKMLDoKnHbsawlMWmfF7qyy/g8CCaLz6zAhKnWOoDPDWAb6Xio=
X-Received: by 2002:a25:ac9b:0:b0:d4a:499d:a881 with SMTP id
 x27-20020a25ac9b000000b00d4a499da881mr385767ybi.9.1692051691393; Mon, 14 Aug
 2023 15:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk> <20230808123901.3jrqsx7pe357hwkh@skbuf>
 <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk> <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk> <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk> <20230814145948.u6ul5dgjpl5bnasp@skbuf>
 <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk> <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
 <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
In-Reply-To: <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Aug 2023 00:21:19 +0200
Message-ID: <CACRpkdbZwfG2E8egObGkgTu2uL8auS5z2yzb0OH-UdAsnbrzHg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 6:27=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:

> > >                 ethernet@60000000 {
> > > ...
> > >                         ethernet-port@0 {
> > >                                 phy-mode =3D "rgmii";
> > >                                 fixed-link {
> > >                                         speed =3D <1000>;
> > >                                         full-duplex;
> > >                                         pause;
> > >                                 };
> > >                         };
> > >
> > > So that also uses "rgmii".
> > >
> > > I'm tempted not to allow the others as the driver doesn't make any
> > > adjustments, and we only apparently have the one user.
> >
> > RGMII on both ends is unlikely to work, so probably one is
> > wrong. Probably the switch has strapping to set it to rgmii-id, but we
> > don't actually know that. And i guess we have no ability to find out
> > the truth?
>
> "rgmii" on both ends _can_ work - from our own documentation:
>
> * PHY_INTERFACE_MODE_RGMII: the PHY is not responsible for inserting any
>   internal delay by itself, it assumes that either the Ethernet MAC (if c=
apable)
>   or the PCB traces insert the correct 1.5-2ns delay
>      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> So, if the board is correctly laid out to include this delay, then RGMII
> on both ends can work.
>
> Next, we have no ability to find anything out - we have no hardware.
> LinusW does, but I have no idea whether Linus can read the state of the
> pin strapping. I can see from the RTL8366 info I found that there is
> a register that the delay settings can be read from, but this is not
> the RTL8366, it's RTL8366RB, which Linus already pointed out is
> revision B and is different. So, I would defer to Linus for anything on
> this, and without input from Linus, all we have to go on is what we
> have in the kernel sources.

I looked at the delays a bit, on the Gemini I think it is set up
from the pin control system, for example we have this in
arch/arm/boot/dts/gemini/gemini-sl93512r.dts:

                                pinctrl-gmii {
                                        mux {
                                                function =3D "gmii";
                                                groups =3D
"gmii_gmac0_grp", "gmii_gmac1_grp";
                                        };
                                        /* Control pad skew comes from
sl_switch.c in the vendor code */
                                        conf0 {
                                                pins =3D "P10 GMAC1 TXC";
                                                skew-delay =3D <5>;
                                        };
                                        conf1 {
                                                pins =3D "V11 GMAC1 TXEN";
                                                skew-delay =3D <7>;
                                        };
                                        conf2 {
                                                pins =3D "T11 GMAC1 RXC";
                                                skew-delay =3D <8>;
                                        };
                                        conf3 {
                                                pins =3D "U11 GMAC1 RXDV";
                                                skew-delay =3D <7>;
                                        };
                                        conf4 {
                                                pins =3D "V7 GMAC0 TXC";
                                                skew-delay =3D <10>;
                                        };
                                        conf5 {
                                                pins =3D "P8 GMAC0 TXEN";
                                                skew-delay =3D <7>; /* 5
at another place? */
                                        };
                                        conf6 {
                                                pins =3D "T8 GMAC0 RXC";
                                                skew-delay =3D <15>;
                                        };
                                        conf7 {
                                                pins =3D "R8 GMAC0 RXDV";
                                                skew-delay =3D <0>;
                                        };
                                        conf8 {
                                                /* The data lines all
have default skew */
                                                pins =3D "U8 GMAC0
RXD0", "V8 GMAC0 RXD1",
                                                       "P9 GMAC0
RXD2", "R9 GMAC0 RXD3",
                                                       "R11 GMAC1
RXD0", "P11 GMAC1 RXD1",
                                                       "V12 GMAC1
RXD2", "U12 GMAC1 RXD3",
                                                       "R10 GMAC1
TXD0", "T10 GMAC1 TXD1",
                                                       "U10 GMAC1
TXD2", "V10 GMAC1 TXD3";
                                                skew-delay =3D <7>;
                                        };
                                        /* Appears in sl351x_gmac.c in
the vendor code */
                                        conf9 {
                                                pins =3D "U7 GMAC0
TXD0", "T7 GMAC0 TXD1",
                                                       "R7 GMAC0
TXD2", "P7 GMAC0 TXD3";
                                                skew-delay =3D <5>;
                                        };
                                };
                        };

For the DIR-685 this is set to the default value of 7 for all skews.

I haven't found any registers dealing with delays in RTL8366RB.
I might need to look closer (vendor mess...)

I think the PCB can have been engineered to match this since clearly
other PCBs contain elaborate values per line. Here is a picture
of the DIR-685 PCB:
https://www.redeszone.net/app/uploads-redeszone.net/d-link_dir-685_analisis=
_15-1024x755.jpg
the swirly lines to the right are toward the memory indicating that
the engineer is consciously designing delays on this board.

Yours,
Linus Walleij

