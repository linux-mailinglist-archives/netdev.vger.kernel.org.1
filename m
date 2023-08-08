Return-Path: <netdev+bounces-25528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A4F774729
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5DC21C20F5E
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC4118049;
	Tue,  8 Aug 2023 19:06:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBFA1802F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:06:31 +0000 (UTC)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585FF59DC2
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:51:13 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-447684c4283so2092463137.2
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 11:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691520672; x=1692125472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7dpQqp3igR4lqKwjP6w0osFBZ3PZiFfViS04CWVCyo=;
        b=Dae7k/MTdvWO8tc8PGMalRBZD7+LodSwirAQ0ikfwqi2jzx1bUTwlYQqX8bEyFnghK
         yfSOiT23O+GAkmFXdGmZ0Z6jDMErp3R7PJKSwguXcGUsoFXTFUC9kGw8ONL6j2BYDNtw
         /Ss9VZ3UW2K6FC8fYBnbFwkKhf44tqzracC0wrwL9MadR15RmrnkdO23W4mO6hnI29uh
         VAKd17wxMUWrQ622YtVvLVgIyUz88kFFW6GZYwTFCbHApZIbg8AOR4KB151RZi07b5Xf
         y6ATNEYRIvfFevZN83CTpsymKBcjlQWGJh0fqijT0XcSpvYGtPgxWhX5GnK8aSv0jfIo
         pMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691520672; x=1692125472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7dpQqp3igR4lqKwjP6w0osFBZ3PZiFfViS04CWVCyo=;
        b=glEGrB6f2K91NbYugT90cSnRwNZS9y4c6VnqvobqlFHxD+U783C7Y1Sq3e9CHWuBxY
         FGowwVrUIwlr8FkeQmCo9LRQLvKYROVfbeVympRmmvEeLvfg4VRn97dikd2YWVZeC2Fg
         DQDWmEy3suxvvjJS3jI5RaaT0k56oKXW0taT55AXil8sZW+AHFeHZLZ0Z0P+HXz/AHZi
         Hn20RxSEOVyi7FXOZEMLgEbByQha+q+E19lm6t8OHRrwcnl+YfX3JTBM+ygqytPUVmx1
         vAV6tEpwQT2D1A6O95EQNLKiM0rINljtb22Bg04t6WKBrP6seaU5PYSmyhdnip34NYJA
         xsRw==
X-Gm-Message-State: AOJu0YwWWSFVNUgwe7NVMQHzWp/Eu3TQAFaVwYh7ymrO6SFi3w+zize8
	OS3a7pOUjZnZkZTR0xAehZ3b6nk6Uc0F72ChlSFl5A==
X-Google-Smtp-Source: AGHT+IEo9vua2y2D8pNsCaUFO3D6FDvMRdlptQj5UA2pUH1+fSZOWabaRNMUZxr1m1TOnki80MoL1YQq6NhTaYYzsMA=
X-Received: by 2002:a67:d085:0:b0:447:4b52:5c8 with SMTP id
 s5-20020a67d085000000b004474b5205c8mr798787vsi.26.1691520672390; Tue, 08 Aug
 2023 11:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230808120254.11653-1-brgl@bgdev.pl> <82cd26a3-e63d-4251-9d43-d1d7443b9cce@lunn.ch>
In-Reply-To: <82cd26a3-e63d-4251-9d43-d1d7443b9cce@lunn.ch>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 8 Aug 2023 20:51:01 +0200
Message-ID: <CAMRc=MfDtCj0ML-FQH8-Cm23YupOnmScBqKDrLExqSjqeHhOSg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: don't create the MDIO bus if
 there's no mdio node on DT
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Andrew Halaney <ahalaney@redhat.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 8, 2023 at 8:46=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Aug 08, 2023 at 02:02:54PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The stmmac_dt_phy() function that parses the device-tree node of the MA=
C
> > and allocates the MDIO and PHY resources misses one use-case: when the
> > MAC doesn't have a fixed link but also doesn't define its own mdio bus
> > on the device tree and instead shares the MDIO lines with a different
> > MAC with its PHY phandle reaching over into a different node.
>
> It does not share the MDIO lines. The other MDIO bus master happens to
> have two PHYs and there are no PHYs on this MDIO bus, so no point
> instantiating it.

Yes, I sent it before we established that thanks to Andrew's input.

>
> >  static int stmmac_dt_phy(struct plat_stmmacenet_data *plat,
> >                        struct device_node *np, struct device *dev)
> >  {
> > -     bool mdio =3D !of_phy_is_fixed_link(np);
> >       static const struct of_device_id need_mdio_ids[] =3D {
> >               { .compatible =3D "snps,dwc-qos-ethernet-4.10" },
> >               {},
> >       };
> >
> > +     if (of_phy_is_fixed_link(np))
> > +             return 0;
> > +
>
>                 /**
>                  * If snps,dwmac-mdio is passed from DT, always register
>                  * the MDIO
>                  */
>                 for_each_child_of_node(np, plat->mdio_node) {
>                         if (of_device_is_compatible(plat->mdio_node,
>                                                     "snps,dwmac-mdio"))
>                                 break;
>                 }
>
> The comment suggests it should always be registered. This MAC might
> have a fixed-phy, but that does not mean there is not an Ethernet
> switch on the bus, or a PHY for some other MAC etc. MDIO busses
> masters should be considered fully independent devices.
>
> https://elixir.bootlin.com/linux/v6.5-rc5/source/arch/arm/boot/dts/nxp/vf=
/vf610-zii-ssmb-dtu.dts
>
> &fec1 {
>         phy-mode =3D "rmii";
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_fec1>;
>         status =3D "okay";
>
>         fixed-link {
>                 speed =3D <100>;
>                 full-duplex;
>         };
>
>         mdio1: mdio {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>                 clock-frequency =3D <12500000>;
>                 suppress-preamble;
>                 status =3D "okay";
>
>                 switch0: switch0@0 {
>                         compatible =3D "marvell,mv88e6190";
>                         pinctrl-0 =3D <&pinctrl_gpio_switch0>;
>                         pinctrl-names =3D "default";
>                         reg =3D <0>;
>                         eeprom-length =3D <65536>;
>                         interrupt-parent =3D <&gpio3>;
>                         interrupts =3D <2 IRQ_TYPE_LEVEL_LOW>;
>                         interrupt-controller;
>                         #interrupt-cells =3D <2>;
>
> Both a fixed link, and something on the MDIO bus....
>
>      Andrew

Makes sense, we can drop all my stmmac patches from today, I need to
rethink it in detail.

Bart

