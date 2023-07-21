Return-Path: <netdev+bounces-19712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB2575BCD1
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 05:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B3628211E
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 03:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71922639;
	Fri, 21 Jul 2023 03:31:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF15A34
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 03:31:24 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE7D1726
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 20:31:22 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9338e4695so22220701fa.2
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 20:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689910281; x=1690515081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbOON96upa6k53R9l08Y+2UTTKiBbgr6Ap/sJhxCabE=;
        b=SWUTt4VJV+ShgNIPyX+c4nnJaITbU1PRgbtQp66ortlICeR0M5oQz/Xd7GCGwZsZah
         syfBSjvf8Pg/qWq846DspxIQRMVympJP+LEXNtaWu+oaRgjCL4C2gAT2XWJoz6TZuR6M
         z8/m4Mfea274qp8PH1V7k1VvAmY92bl5+1hVk5sYWK+QUJXtkiLUQJASQ5pe8slfSlwL
         D12PTGYOZZyPml8TUcYL1Nhf1+AlE2XkzwUSY/RFAIyxWGbnXiUYcYD31lx8wYxT5Jo0
         GS/0tt1Bg2RwRnhGPZInJZk8Ui4sbe3EYjscauaeuYITkgMynIkuVcXhH0Bslje43zlE
         4p1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689910281; x=1690515081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbOON96upa6k53R9l08Y+2UTTKiBbgr6Ap/sJhxCabE=;
        b=YN2Wr6vAiw6ALN2xmpNsjKI3Z1MoXNlLOhHem9UoJ0j4Gi27ulaC6VoXFUWldbBnXN
         09YoPcDxesmFxKoQmY7T/PQ34cYh4uoslO1k3ZF03vR4HjdhlmBPcAmJ6mh/XGAzRrLO
         MCajU4qipBxCrf+lpvgaaDJ6CVTmRZvHC+nLDQE1TkJR0sH9hAUHxcaQZ/f/xzGR6WQE
         A/tcu70PsVLoq1l5vIrUT5BMhzEV+SckFlTpFuRhWscsvG2UzxjIPWVnc3p95uXnfi3s
         kGsuTMOuUrMi/DiQGcfPwNkwei1DrsGsm0KYbBusq3wHsg5eZDXGAG/OOToeKl4p7G5+
         3CVA==
X-Gm-Message-State: ABy/qLYbwYThbM+akG+pucQ+cBV3qUNIRvuO0bRNa1bRXX1XkHq+93Dn
	ofX/6qW37AS/0L0aeckXfhUQYQvxmbUy4zqVZRc=
X-Google-Smtp-Source: APBJJlFdN6vOP4o9SsarreD7XEo5cbC8/gcapL/yEfoErw7pb580B0aAKYuToxCr/XqiAAwx1KCyZFjvxdUr6Oj9pyk=
X-Received: by 2002:a2e:9dc4:0:b0:2b6:cca1:975f with SMTP id
 x4-20020a2e9dc4000000b002b6cca1975fmr555990ljj.13.1689910280373; Thu, 20 Jul
 2023 20:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689215889.git.chenfeiyang@loongson.cn> <be1874e517f4f4cc50906f18689a0add3594c2e0.1689215889.git.chenfeiyang@loongson.cn>
 <9e0b3466-10e1-4267-ab9b-d9f8149b6b6b@lunn.ch> <CACWXhKkX-syR01opOky=t-b8C3nhV5f_WNfCQ-kOE+4o0xh4tA@mail.gmail.com>
 <3cff46b0-5621-4881-8e70-362bb7a70ed1@lunn.ch> <CACWXhKk23muXROj6OrmeFna88ViJHA_7QpQZoWiFgzEPb4pLWQ@mail.gmail.com>
 <9568c4ad-e10f-4b76-8766-ec621f788c40@lunn.ch>
In-Reply-To: <9568c4ad-e10f-4b76-8766-ec621f788c40@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Fri, 21 Jul 2023 11:31:08 +0800
Message-ID: <CACWXhKkoJHT8HNb-h_1PJTT1rE-TQxByd98qS0Zka5yg2_WsXw@mail.gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 8:22=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > > > +#define PHY_ID_LS7A2000              0x00061ce0
> > > > >
> > > > > What is Loongson OUI?
> > > > >
> > > >
> > > > Currently, we do not have an OUI for Loongson, but we are in the
> > > > process of applying for one.
> > >
> > > Is the value 0x00061ce0 baked into the silicon? Or can it be changed
> > > once you have an OUI?
> > >
> >
> > Hi, Andrew,
> >
> > The value is baked into the silicon.
>
> O.K. Thanks. Do you have an idea how long it will take to get an OUI?
>
> Does the PCI ID uniquely identify the MAC+PHY combination?
>

Hi, Andrew,

Sorry, I currently don't have an exact timeline for when the OUI will
be available. The next hardware version will address these bugs, so
we won't be going with this driver.

> > > > The PHY itself supports half-duplex, but there are issues with the
> > > > controller used in the 7A2000 chip. Moreover, the controller only
> > > > supports auto-negotiation for gigabit speeds.
> > >
> > > So you can force 10/100/1000, but auto neg only succeeds for 1G?
> > >
> > > Are the LP autoneg values available for genphy_read_lpa() to read? If
> > > the LP values are available, maybe the PHY driver can resolve the
> > > autoneg for 10 an 100.
> > >
> >
> > I apologize for the confusion caused by my previous description. To
> > clarify, the PHY supports auto-negotiation and non-auto-negotiation
> > for 10/100, but non-auto-negotiation for 1000 does not work correctly.
>
> So you can force 10/100, but auto-neg 10/100/1000.
>
> So i would suggest .get_features() indicates normal 10/100/1000
> operation. Have your .config_aneg function which is used for both
> auto-neg and forced configuration check for phydev->autoneg =3D=3D
> AUTONEG_DISABLE and phydev->speed =3D=3D SPEED_1000 and return
> -EOPNOTSUPP. Otherwise call genphy_config_aneg().
>

Well, can I return -EINVAL in the .set_link_ksettings callback?
Considering that our next hardware version will have the OUI
allocated and these bugs fixed, I won't submit this driver in
the next patch version. I believe we can just use the generic
PHY for now.

> > > So what does genphy_read_abilities() return?
> > >
> > > Nobody else going to use PHY_LOONGSON_FEATURES, so i would prefer not
> > > to add it to the core. If your PHY is designed correctly,
> > > genphy_read_abilities() should determine what the PHY can do from its
> > > registers. If the registers are wrong, it is better to add a
> > > .get_features function.
> > >
> >
> > genphy_read_abilities() returns 0, and it seems to be working fine.
> > The registers are incorrect, so I will use the .get_features function
> > to clear some of the half-duplex bits.
>
> You said above that the PHY supports half duplex, the MAC has problems
> with half duplex. So it should be the MAC which indicates it does not
> unsupported half duplex link modes.
>
> So you need to modify phylink_config.mac_capabilities before
> phylink_create() is called. There is already
>
>         /* Half-Duplex can only work with single queue */
>         if (priv->plat->tx_queues_to_use > 1)
>                 priv->phylink_config.mac_capabilities &=3D
>                         ~(MAC_10HD | MAC_100HD | MAC_1000HD);
>
> so you just need to add a quirk for your broken hardware.
>

OK.

Thanks,
Feiyang

>         Andrew
>

