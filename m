Return-Path: <netdev+bounces-28816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C279780CB5
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 15:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DD41C215FD
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D5B18B07;
	Fri, 18 Aug 2023 13:44:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FB817AC1
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 13:44:25 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950B030F5
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 06:44:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c47ef365cso123678666b.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 06:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692366262; x=1692971062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qNGk7iBvefHQ+A4wocKw0ga+y4CdjtBME57eex7SSrI=;
        b=QfB5N5eaScrdz8PxarIvo2/CXwDHCb5kNeGCq/1bLWsiLnGKeolAHxBSe+mRfHssFv
         0OVS4gXek4tAnMkbF7tb6nvfKZkJRLf2LHzGGCw/1bH+FD3DuX+3zHEkJnD+t1ZSeFfa
         uihUNh87YHUB9HDYrZPbAWpTKdK3l3zLFLrlkFMq1M2D3D+6tRUPCIVUHuPgYgy3Dl5s
         4eonIAU5WYpS3oLEfraAdYyrpXM6VS71cf+OPwAYsNrCc8YFSHLuKtoCj04c8DBnl/c8
         NplsGGsR5sKI/oNbYFpqtXBMGF63Fz/PJp9w1QJnsusqSfxAbBenV0tBGNkfTOJ9GQ/A
         JftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692366262; x=1692971062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNGk7iBvefHQ+A4wocKw0ga+y4CdjtBME57eex7SSrI=;
        b=J5nrXVpmR9ZDWjYd+ArzLGNSa+DPC7IgVYUy7Jkl6sRBSDGN9b4vpAi0JpzSaNHnWX
         L7jS62Qo0yQ05sLwqWqmUy+tDoxIfxwaelQffmrB2sgGT6xxxCnKw1TC9MIibO3Bj2b6
         8v5zAdWgxq85U3utE+uVwiPtYxkOcOJf31GWlhd+a/OiOMCxobl4t4Epxy11NiUdyke1
         Shz+NfBerY+1ePcyyHfY+AsXT6pOmSS0nc9TXho203enkf7vhZ6x4x0/izdycvctaF5j
         e25RBgg77BB5t3hhuatQAu/BZqBzGWcRzzTtvS08ouAeslJlRtD4nZMSjU76fuYbmXZv
         uEDA==
X-Gm-Message-State: AOJu0Yw63OAAz/6Wizq+UM3vH1o9NXFx8pG9I8gwuDG0SHCIKwS2UXWY
	A2r+JXDedjDtyC5fiIsYUWg=
X-Google-Smtp-Source: AGHT+IGsdT/Ycgdgu7q3CnXFOnW6OxJInQL89D22+FZUwJBVvQf8XYG+yWhHRyqWCKthj4E0JAXiGQ==
X-Received: by 2002:a17:906:3145:b0:99c:f966:9ea2 with SMTP id e5-20020a170906314500b0099cf9669ea2mr2037540eje.25.1692366261769;
        Fri, 18 Aug 2023 06:44:21 -0700 (PDT)
Received: from skbuf ([188.25.255.94])
        by smtp.gmail.com with ESMTPSA id sa17-20020a170906edb100b00997d76981e0sm1193354ejb.208.2023.08.18.06.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 06:44:21 -0700 (PDT)
Date: Fri, 18 Aug 2023 16:44:19 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <20230818134419.mcnq7d4aj74yedum@skbuf>
References: <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
 <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
 <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
 <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
 <20230817182729.q6rf327t7dfzxiow@skbuf>
 <65657a0e-0b54-4af4-8a38-988b7393a9f5@lunn.ch>
 <20230817191754.vopvjus6gjkojyjz@skbuf>
 <ZN9R00LPUPlkb9sV@shell.armlinux.org.uk>
 <20230818114055.ovuh33cxanwgc63u@skbuf>
 <CACRpkdYf-VwCUFigjb1ZHJfieXkxqLSwVmG_S-SKJQY1bciCHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYf-VwCUFigjb1ZHJfieXkxqLSwVmG_S-SKJQY1bciCHA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 03:08:52PM +0200, Linus Walleij wrote:
> On Fri, Aug 18, 2023 at 1:40 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> 
> > Though, to have more confidence in the validity of the change, I'd need
> > the phy-mode of the &gmac0 node from arch/arm/boot/dts/gemini/gemini-dlink-dir-685.dts,
> > and I'm not seeing it.
> 
> The assignment of the gmac0 label is in the top-level DTSI:
> 
> (...)
>                 ethernet: ethernet@60000000 {
>                         compatible = "cortina,gemini-ethernet";
> (...)
>                         gmac0: ethernet-port@0 {
>                                 compatible = "cortina,gemini-ethernet-port";
> (...)
> 
> Then in the DIR-685 overlay DTS It looks like this:
> 
>                 ethernet@60000000 {
>                         status = "okay";
> 
>                         ethernet-port@0 {
>                                 phy-mode = "rgmii";
>                                 fixed-link {
>                                         speed = <1000>;
>                                         full-duplex;
>                                         pause;
>                                 };
>                         };
>                         ethernet-port@1 {
>                                 /* Not used in this platform */
>                         };
>                 };
> 
> Russell pointed out that this style with overlays of nodes are
> confusing. I agree. If I did it today I would use &gmac0 to
> configure it. There is a bit of development history here.

Yikes. I totally missed that.

> > Looking at its driver (drivers/net/ethernet/cortina/gemini.c), I don't
> > see any handling of RGMII delays, and it accepts any RGMII phy-mode.
> 
> The handling of the delays exist and is done orthogonally, from
> the pin controller, which can assign skewing to pins on the chip.
> 
> There are also SoCs that will do clock skewing in the external
> bus controller, from a driver in drivers/bus such as what
> drivers/bus/intel-ixp4xx-eb.c is doing for IXP4xx. So there
> are even several different places where clock skewing/transmit
> delays can be handled.
> 
> For DIR-685 is looks like this:
> 
>                                 pinctrl-gmii {
>                                         mux {
>                                                 function = "gmii";
>                                                 groups = "gmii_gmac0_grp";
>                                         };
>                                         conf0 {
>                                                 pins = "V8 GMAC0 RXDV", "T10 GMAC1 RXDV",
>                                                      "Y7 GMAC0 RXC", "Y11 GMAC1 RXC",
>                                                      "T8 GMAC0 TXEN", "W11 GMAC1 TXEN",
>                                                      "U8 GMAC0 TXC", "V11 GMAC1 TXC",
>                                                      "W8 GMAC0 RXD0", "V9 GMAC0 RXD1",
>                                                      "Y8 GMAC0 RXD2", "U9 GMAC0 RXD3",
>                                                      "T7 GMAC0 TXD0", "U6 GMAC0 TXD1",
>                                                      "V7 GMAC0 TXD2", "U7 GMAC0 TXD3",
>                                                      "Y12 GMAC1 RXD0", "V12 GMAC1 RXD1",
>                                                      "T11 GMAC1 RXD2", "W12 GMAC1 RXD3",
>                                                      "U10 GMAC1 TXD0", "Y10 GMAC1 TXD1",
>                                                      "W10 GMAC1 TXD2", "T9 GMAC1 TXD3";
>                                                 skew-delay = <7>;
>                                         };
>                                         /* Set up drive strength on GMAC0 to 16 mA */
>                                         conf1 {
>                                                 groups = "gmii_gmac0_grp";
>                                                 drive-strength = <16>;
>                                         };
>                                 };
> 
> So skew-delay of 7 steps, each step is ~0.2ns so all pins have a delay
> of 7*0.2 = 1.4ns.

Ohhhh, I saw the pinctrl-gmii explanation before, but I didn't understand it.
I get it now. Sorry.

> 
> > So, if neither the Ethernet controller nor the RTL8366RB switch are
> > adding RGMII delays,
> 
> Actually the SoC is. When the ethernet is probed, it asks for its
> default pin configuration, and it will applied from the device tree
> from the above node. It's just that the registers to control them
> are not in the ethernet hardware block, but in the pin controller.
> > it becomes plausible that there are skews added
> > through PCB traces.
> 
> In the DIR-685 example I think it is *both* (yeah...) because it
> makes no sense that all delays are 1.4ns. I think the PCB
> routing influence it *too*.

I think that as long as the delays aren't added by the other end
("PHY"), then phy-mode = "rgmii" would be the adequate mode to describe
this (even if it only has an informative purpose).

The delays, even if added by the local system, are added externally to
the MAC block (given its current bindings). Similar in that regard to
PCB delays. Which makes the device tree basically correct/consistent in
that particular aspect.

> However the D-Link DNS-313 makes more elaborate use of
> these settings:
> 
>                                 pinctrl-gmii {
>                                         mux {
>                                                 function = "gmii";
>                                                 groups = "gmii_gmac0_grp";
>                                         };
>                                         /*
>                                          * In the vendor Linux tree, these values are set for the C3
>                                          * version of the SL3512 ASIC with the comment "benson suggest"
>                                          */
>                                         conf0 {
>                                                 pins = "R8 GMAC0 RXDV", "U11 GMAC1 RXDV";
>                                                 skew-delay = <0>;
>                                         };
>                                         conf1 {
>                                                 pins = "T8 GMAC0 RXC";
>                                                 skew-delay = <10>;
>                                         };
>                                         conf2 {
>                                                 pins = "T11 GMAC1 RXC";
>                                                 skew-delay = <15>;
>                                         };
>                                         conf3 {
>                                                 pins = "P8 GMAC0 TXEN", "V11 GMAC1 TXEN";
>                                                 skew-delay = <7>;
>                                         };
>                                         conf4 {
>                                                 pins = "V7 GMAC0 TXC", "P10 GMAC1 TXC";
>                                                 skew-delay = <10>;
>                                         };
>                                         conf5 {
>                                                 /* The data lines all have default skew */
>                                                 pins = "U8 GMAC0 RXD0", "V8 GMAC0 RXD1",
>                                                        "P9 GMAC0 RXD2", "R9 GMAC0 RXD3",
>                                                        "R11 GMAC1 RXD0", "P11 GMAC1 RXD1",
>                                                        "V12 GMAC1 RXD2", "U12 GMAC1 RXD3",
>                                                        "R10 GMAC1 TXD0", "T10 GMAC1 TXD1",
>                                                        "U10 GMAC1 TXD2", "V10 GMAC1 TXD3";
>                                                 skew-delay = <7>;
>                                         };
>                                         conf6 {
>                                                 pins = "U7 GMAC0 TXD0", "T7 GMAC0 TXD1",
>                                                        "R7 GMAC0 TXD2", "P7 GMAC0 TXD3";
>                                                 skew-delay = <5>;
>                                         };
>                                         /* Set up drive strength on GMAC0 to 16 mA */
>                                         conf7 {
>                                                 groups = "gmii_gmac0_grp";
>                                                 drive-strength = <16>;
>                                         };
>                                 };
> 
> So there are definitely systems doing this.
> 
> > In that case, the current phy-mode = "rgmii" would
> > be the correct choice, and changing that would be invalid. Some more
> > documentary work would be needed.
> 
> Does the above help or did I make it even more confusing :D

It helped a lot, thank you for clarifying.

> If guess I could imagine the delays being configured directly
> from the ethernet driver if that is highly desired. For the IXP4xx
> ATA controller (that has similar needs to a network phy) I just
> shortcut the whole "this goes into the external memory
> controller" and look up the address space for the delay
> settings and control these settings directly from the driver.
> It's not very encapsulated but sometimes the world out there
> is ugly, and the ATA drivers really want to control this
> see drivers/ata/pata_ixp4xx_cf.c,
> ixp4xx_set_8bit_timing() etc.
> 
> To do delay set-up fully from the ethernet controller, for Gemini,
> I would just pull this register range out from the pin controller,
> remove the pin control stuff in the device tree, and poke it
> directly from the ethernet driver. It can be done for sure.
> It's just two different ways to skin the cat.

I'm not sure that making changes there would become necessary.

> I suppose it fully confirms the view that the phy-mode in
> the ethernet controller is 100% placebo though!

Which is what it should be, IMO.

