Return-Path: <netdev+bounces-20639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D46760500
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 04:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ABD8281704
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 02:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ADA15C2;
	Tue, 25 Jul 2023 02:03:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B5015A0
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 02:03:05 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF311725
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 19:03:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso7420175e87.2
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 19:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690250583; x=1690855383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jXcFWAgGAflI6kUVxjxEkNlmkyw4QSOaHS8DdvHCGs=;
        b=i6MjFuhFxFhGZJwQwP043dtGCjxRHgIEtvjyb0w8NbNVKbPO5tYR2SvZsTjrM7xKQY
         uwlM3l7pukdL6uCb6XRsllO6IebZCLte/l8pDPgmtQ2ACENK1qSiBWTZ5Ni6IB2VKzg6
         TEWEJfepNUaHfo0fne2LApN/I4DMQzHMh9uCX+E6hSlQR3ECko9/XSzKccvOKVriyiOp
         yrXmkHrM0RuSBCKEm7dm1DON1/81SEFry/wQBwHQfoziXCtDnxJzYyLQt9eJPXseq5g7
         QEaqlrCB07OxftOHUQOjvYKfrZWUqNTbcolz9PPOjdKexlaTIkI70y3MyZReEsFXqPrj
         0xpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690250583; x=1690855383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jXcFWAgGAflI6kUVxjxEkNlmkyw4QSOaHS8DdvHCGs=;
        b=Di5JWDBbhRXU54lylTA+oQ6mJ6DHQ0Eb2gDDikt9jPB21lo5X12a+D2B/gBO8B1JwG
         rT/gtYfv7+aR+HUmlBINueFOiWxVGa01SHa/zZcPFXQPaOUEVQiCjJmcVgrYpzX6vMXY
         N2s89pR8+qNj749XrTfOuUnTvAkjeLSyaPnm91MTJzwDaJcWr4oo2fDb+txkFGqxEWXW
         /1mKOtsEP7uS4hD1Z1Cf+MN9pFOeHMKlYUujsJZmT+2t0oyZSJGposAPNzh9mdqLGddu
         N3ddFNgFlfd+gnbiBoq1RTyru9gw8YSL3ZknIm/3zlk0o1ikLnX6q1gyiv7SQL0jV+ns
         QGPw==
X-Gm-Message-State: ABy/qLYmcsfIBXOE97PVeP9AtX2HhBb7tvE6sBC+clnY/fexmOOrrdfS
	EA1BvPRjsZUU5KQ+LxmYHjiGpVe1Q0guLT5VmjU=
X-Google-Smtp-Source: APBJJlHClHq8ILDWSvrqrA1ckSZ+wKew32udmYxuo/aAKLTXnHoMwBTe+CBPrB1qhEWorO4SE4k1Jm4AqxW26x0JcWo=
X-Received: by 2002:a2e:3818:0:b0:2b6:ee99:fffc with SMTP id
 f24-20020a2e3818000000b002b6ee99fffcmr6985224lja.36.1690250582501; Mon, 24
 Jul 2023 19:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689215889.git.chenfeiyang@loongson.cn> <be1874e517f4f4cc50906f18689a0add3594c2e0.1689215889.git.chenfeiyang@loongson.cn>
 <9e0b3466-10e1-4267-ab9b-d9f8149b6b6b@lunn.ch> <CACWXhKkX-syR01opOky=t-b8C3nhV5f_WNfCQ-kOE+4o0xh4tA@mail.gmail.com>
 <3cff46b0-5621-4881-8e70-362bb7a70ed1@lunn.ch> <CACWXhKk23muXROj6OrmeFna88ViJHA_7QpQZoWiFgzEPb4pLWQ@mail.gmail.com>
 <9568c4ad-e10f-4b76-8766-ec621f788c40@lunn.ch> <CACWXhKkoJHT8HNb-h_1PJTT1rE-TQxByd98qS0Zka5yg2_WsXw@mail.gmail.com>
 <24d49ab1-c2e4-4878-a4f6-8d1f405f2407@lunn.ch>
In-Reply-To: <24d49ab1-c2e4-4878-a4f6-8d1f405f2407@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Tue, 25 Jul 2023 10:02:50 +0800
Message-ID: <CACWXhKmwjXb_71hmGfKh7NCC3iAhFTB1uEVhY0qq8kz24o3TYg@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] net: phy: Add driver for Loongson PHY
To: Andrew Lunn <andrew@lunn.ch>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, chenhuacai@loongson.cn, 
	linux@armlinux.org.uk, dongbiao@loongson.cn, 
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 5:04=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Hi, Andrew,
> >
> > Sorry, I currently don't have an exact timeline for when the OUI will
> > be available. The next hardware version will address these bugs, so
> > we won't be going with this driver.
>
> Not having an OUI breaks the standard. So i was actually thinking you
> should trap the reads to the ID registers in the MDIO bus driver and
> return valid values. Some Marvell Ethernet switch integrated PHYs have
> a valid OUI, and no device part. We trap those and insert valid
> values. So there is some president for doing this. Doing this would
> also allow you to avoid the PHY driver poking around the MAC drivers
> PCI bus.
>
> > > So i would suggest .get_features() indicates normal 10/100/1000
> > > operation. Have your .config_aneg function which is used for both
> > > auto-neg and forced configuration check for phydev->autoneg =3D=3D
> > > AUTONEG_DISABLE and phydev->speed =3D=3D SPEED_1000 and return
> > > -EOPNOTSUPP. Otherwise call genphy_config_aneg().
> > >
> >
> > Well, can I return -EINVAL in the .set_link_ksettings callback?
>
> If the PHY is broken, the PHY should do it. If the MAC is broken, the
> MAC should do it. We have clean separation here, even when the
> hardware is integrated.
>

Hi, Andrew,

I get it. To be honest, I'm not familiar with the hardware, so I asked
the colleague who designed this chip. The real problem is the same as I
described in Patch 10 - the Ethernet controller doesn't work well with
the PHY. If the controller works properly, we can force 1000. Are there
any methods to work around this problem in the MAC driver?

> > Considering that our next hardware version will have the OUI
> > allocated and these bugs fixed, I won't submit this driver in
> > the next patch version. I believe we can just use the generic
> > PHY for now.
>
> The problem with the generic driver is you cannot have workarounds in
> it. You don't want to put PHY workarounds in the MAC driver.
>

Sure, we should not put PHY workarounds in the MAC driver and vice
versa.

This PHY driver was designed to solve two problems at first:
1. We cannot force 1000.
2. We cannot use half duplex.

Now, we are sure that the MAC is broken, not the PHY, so I think we
can solve these problems in the MAC driver.

Thanks,
Feiyang

>     Andrew
>

