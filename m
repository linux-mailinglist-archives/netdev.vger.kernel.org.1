Return-Path: <netdev+bounces-18110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C58D754E60
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 12:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF4B1C2093A
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 10:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0441763AD;
	Sun, 16 Jul 2023 10:55:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED495EA1
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 10:55:32 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92403E6B
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 03:55:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fb8574a3a1so5441759e87.1
        for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 03:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689504929; x=1692096929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRj53D+WEUxtTgjHcIaXf65gwyPY5iEFP7btFKZGgIc=;
        b=4pHEL2Xx5puQ4s3Dkya4+HhyaxO5Tyv6Wd6IYWZhc+1YQ7yrMmWyQCtlgIusCUtQUL
         0R+qP/XqfIt5dE/xpd9CNLjO1MzxhAWkqDB0/tMmoSBbDsxDKIqHVDmyZMOeebF47xWc
         7rUm4vh5mcqQ8LlxxflJknwLp/4tgh0X2QYAQbnKP0BvXfXdHety4EBJZvC3+EXoVwJs
         /n2s7f6ayjaIU4fbvntRGnye/ztsP20/VgtYLbqjN2FeYOgnn2ZZkp+eDRBB2C4c0wuN
         cy1irghnE7YTUe7H1a+HSkbNHPGNxDP3JoyvArPc4lBjAw+tx15WbZNsLFEb48gUUDhn
         rDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689504929; x=1692096929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRj53D+WEUxtTgjHcIaXf65gwyPY5iEFP7btFKZGgIc=;
        b=F9zZZNypStPLmTJe4lp8hsaFjaYnDjbztQQBgVb1j4XuGfOWRNbDjsSwwi3s1DjTe+
         F2fwUh7A1rdV5gihDNO5omzFKkCYMPgC3I0KcG1V8lEU1SEF1tijtrRiamHPMwW789dU
         +I96SwH7tDtPH/sRzOAd3e6RH9R5iGyJF0vKnTnnWDSzGLnDuNyJYRBb2ZwjXk8yETA8
         RG+AEphTUIigoblb2pI2fLckUYfWTCjh0Pmvx2y/PZWEOuq8awgvPhf1mrB5jhsl3D52
         oI4PCDxnZLxXYGJhh6gAY1d3cS3ARlMBSuNMOEWvSxwebVQfvWzpQRdgsjylIL7arBFx
         1UKg==
X-Gm-Message-State: ABy/qLbwHCtNLKKM+ev7te6AwrLpB+K60Bv+1oO9gdGSc3cUfgyMR40r
	9ru74q18njPa/NiLjL8s7LTXfgyr1/8unvmEfRZgsA==
X-Google-Smtp-Source: APBJJlEtKjyj1HRwslkInMcIb9BW4D5pjbaZP9j2e2vxft1FXh+0BE1rn9hvBIYPbbIfCZzWwNvBs+A0GGFQ2QgjC8Q=
X-Received: by 2002:a05:6512:3995:b0:4fb:c881:be5b with SMTP id
 j21-20020a056512399500b004fbc881be5bmr6793976lfu.2.1689504928722; Sun, 16 Jul
 2023 03:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713202123.231445-1-alex@shruggie.ro> <20230713202123.231445-2-alex@shruggie.ro>
 <20230714172444.GA4003281-robh@kernel.org>
In-Reply-To: <20230714172444.GA4003281-robh@kernel.org>
From: Alexandru Ardelean <alex@shruggie.ro>
Date: Sun, 16 Jul 2023 13:55:17 +0300
Message-ID: <CAH3L5Qoj+sue=QnR2Lp12x3Hz2t2BNnarZHJiqxL3Gtf6M=bsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: net: phy: vsc8531: document
 'vsc8531,clkout-freq-mhz' property
To: Rob Herring <robh@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, olteanv@gmail.com, marius.muresan@mxt.ro
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 8:24=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Jul 13, 2023 at 11:21:23PM +0300, Alexandru Ardelean wrote:
> > For VSC8351 and similar PHYs, a new property was added to generate a cl=
ock
> > signal on the CLKOUT pin.
>
> Sorry, didn't think about it on v1, but I would imagine other vendors'
> PHYs have similar functionality. We should have something common. We
> have the clock binding for clocks already, so we should consider if
> that should be used here. It may look like an overkill for what you
> need, but things always start out that way. What if you want to turn the
> clock on and off as well?

So, there's the adin.c PHY driver which has a similar functionality
with the adin_config_clk_out().
Something in the micrel.c PHY driver (with
micrel,rmii-reference-clock-select-25-mhz); hopefully I did not
misread the code about that one.
And the at803x.c PHY driver has a 'qca,clk-out-frequency' property too.

Now with the mscc.c driver, there is a common-ality that could use a framew=
ork.

@Rob are you suggesting something like registering a clock provider
(somewhere in the PHY framework) and let the PHY drivers use it?
Usually, these clock signals (once enabled on startup), don't get
turned off; but I've worked mostly on reference designs; somewhere
down the line some people get different requirements.
These clocks get connected back to the MAC (usually), and are usually
like a "fixed-clock" driver.
In our case, turning off the clock would be needed if the PHY
negotiates a non-gigabit link; i.e 100 or 10 Mbps; in that case, the
CLKOUT signal is not needed and it can be turned off.

Maybe start out with a hook in 'struct phy_driver'?
Like "int (*config_clk_out)(struct phy_device *dev);" or something?
And underneath, this delegates to the CLK framework?

I'd let Andrew (or someone in netdev) have a final feedback here.

I can (probably) try to allocate some time to do this change based on
the MSCC driver in the next weeks, if there's a consensus.

Thanks
Alex

>
> > This change documents the change in the device-tree bindings doc.
>
> That's obvious.
>
> >
> > Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> > ---
> >
> > Changelog v1 -> v2:
> > * https://lore.kernel.org/netdev/20230706081554.1616839-2-alex@shruggie=
.ro/
> > * changed property name 'vsc8531,clkout-freq-mhz' -> 'mscc,clkout-freq-=
mhz'
> >   as requested by Rob
> > * added 'net-next' tag as requested by Andrew
> >
> >  Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt=
 b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > index 0a3647fe331b..085d0e8a834e 100644
> > --- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > +++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > @@ -31,6 +31,10 @@ Optional properties:
> >                         VSC8531_LINK_100_ACTIVITY (2),
> >                         VSC8531_LINK_ACTIVITY (0) and
> >                         VSC8531_DUPLEX_COLLISION (8).
> > +- mscc,clkout-freq-mhz       : For VSC8531 and similar PHYs, this will=
 output
> > +                       a clock signal on the CLKOUT pin of the chip.
> > +                       The supported values are 25, 50 & 125 Mhz.
> > +                       Default value is no clock signal on the CLKOUT =
pin.
> >  - load-save-gpios    : GPIO used for the load/save operation of the PT=
P
> >                         hardware clock (PHC).
> >
> > @@ -69,5 +73,6 @@ Example:
> >                  vsc8531,edge-slowdown        =3D <7>;
> >                  vsc8531,led-0-mode   =3D <VSC8531_LINK_1000_ACTIVITY>;
> >                  vsc8531,led-1-mode   =3D <VSC8531_LINK_100_ACTIVITY>;
> > +                mscc,clkout-freq-mhz =3D <50>;
> >               load-save-gpios         =3D <&gpio 10 GPIO_ACTIVE_HIGH>;
> >          };
> > --
> > 2.41.0
> >

