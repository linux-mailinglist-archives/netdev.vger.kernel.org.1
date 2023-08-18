Return-Path: <netdev+bounces-28815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0128C780C86
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 15:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36B91C215DA
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1E318AFD;
	Fri, 18 Aug 2023 13:29:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419EC182A2
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 13:29:54 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782C2E74
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 06:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NNQoT5g0L2HOaufbqC8G3BZASzIhxJ7jxYAEjRR02HU=; b=CZkZ/Xk6dOK+NcoIlcymSQjrC2
	fbtCy713b+vtnhaETBf/3cbvD3oLxVKYHtJDZtYs3x8wsz7RQ1WsYYWLKGNI+DOdAfFZ+FUKK2y2Z
	fynqFq08rh4sL3ZFjDIXNXQ4LFaHUzm0xVGOk1wYKRLiVJEqajvlJ3L5x4l97tsJe1mgzdHujASY+
	YgJkthLVy5iJlJghSePVb/ES1Ui6FQUZKkfyEn1XJt+/PEXE7bdwvqC1X1LDBazQxoMh9dWBxy5/7
	qSfHn0XuGGYSz7NQEl8RJ4kQcBFLVmfLT6ycs2cNEZzQ5zomVFoxYIClDAlpvrNaOM7v3gDRoNhfw
	SKUwhDzw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58914)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qWzXs-0005db-39;
	Fri, 18 Aug 2023 14:29:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qWzXs-0001fd-AU; Fri, 18 Aug 2023 14:29:44 +0100
Date: Fri, 18 Aug 2023 14:29:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <ZN9ySD2ewIgLTtlm@shell.armlinux.org.uk>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYf-VwCUFigjb1ZHJfieXkxqLSwVmG_S-SKJQY1bciCHA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 03:08:52PM +0200, Linus Walleij wrote:
> For DIR-685 is looks like this:
> 
>                                 pinctrl-gmii {
>                                         mux {
>                                                 function = "gmii";
>                                                 groups = "gmii_gmac0_grp";
>                                         };
>                                         conf0 {
>                                                 pins = "V8 GMAC0
> RXDV", "T10 GMAC1 RXDV",
>                                                      "Y7 GMAC0 RXC",
> "Y11 GMAC1 RXC",
>                                                      "T8 GMAC0 TXEN",
> "W11 GMAC1 TXEN",
>                                                      "U8 GMAC0 TXC",
> "V11 GMAC1 TXC",
>                                                      "W8 GMAC0 RXD0",
> "V9 GMAC0 RXD1",
>                                                      "Y8 GMAC0 RXD2",
> "U9 GMAC0 RXD3",
>                                                      "T7 GMAC0 TXD0",
> "U6 GMAC0 TXD1",
>                                                      "V7 GMAC0 TXD2",
> "U7 GMAC0 TXD3",
>                                                      "Y12 GMAC1 RXD0",
> "V12 GMAC1 RXD1",
>                                                      "T11 GMAC1 RXD2",
> "W12 GMAC1 RXD3",
>                                                      "U10 GMAC1 TXD0",
> "Y10 GMAC1 TXD1",
>                                                      "W10 GMAC1 TXD2",
> "T9 GMAC1 TXD3";
>                                                 skew-delay = <7>;
>                                         };
>                                         /* Set up drive strength on
> GMAC0 to 16 mA */
>                                         conf1 {
>                                                 groups = "gmii_gmac0_grp";
>                                                 drive-strength = <16>;
>                                         };
>                                 };
> 
> So skew-delay of 7 steps, each step is ~0.2ns so all pins have a delay
> of 7*0.2 = 1.4ns.

If I read this correctly, then isn't this 1.4ns delay added not only
to the RXD and TXD signals, but also RXC and TXC - meaning that although
there is a delay, the effect is that (e.g.) the relative delay between
TXC and TXD is zero?

> In the DIR-685 example I think it is *both* (yeah...) because it
> makes no sense that all delays are 1.4ns. I think the PCB
> routing influence it *too*.
> 
> However the D-Link DNS-313 makes more elaborate use of
> these settings:
> 
>                                 pinctrl-gmii {
>                                         mux {
>                                                 function = "gmii";
>                                                 groups = "gmii_gmac0_grp";
>                                         };
>                                         /*
>                                          * In the vendor Linux tree,
> these values are set for the C3
>                                          * version of the SL3512 ASIC
> with the comment "benson suggest"
>                                          */
>                                         conf0 {
>                                                 pins = "R8 GMAC0
> RXDV", "U11 GMAC1 RXDV";
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
>                                                 pins = "P8 GMAC0
> TXEN", "V11 GMAC1 TXEN";
>                                                 skew-delay = <7>;
>                                         };
>                                         conf4 {
>                                                 pins = "V7 GMAC0 TXC",
> "P10 GMAC1 TXC";
>                                                 skew-delay = <10>;
>                                         };
>                                         conf5 {
>                                                 /* The data lines all
> have default skew */
>                                                 pins = "U8 GMAC0
> RXD0", "V8 GMAC0 RXD1",
>                                                        "P9 GMAC0
> RXD2", "R9 GMAC0 RXD3",
>                                                        "R11 GMAC1
> RXD0", "P11 GMAC1 RXD1",
>                                                        "V12 GMAC1
> RXD2", "U12 GMAC1 RXD3",
>                                                        "R10 GMAC1
> TXD0", "T10 GMAC1 TXD1",
>                                                        "U10 GMAC1
> TXD2", "V10 GMAC1 TXD3";
>                                                 skew-delay = <7>;
>                                         };
>                                         conf6 {
>                                                 pins = "U7 GMAC0
> TXD0", "T7 GMAC0 TXD1",
>                                                        "R7 GMAC0
> TXD2", "P7 GMAC0 TXD3";
>                                                 skew-delay = <5>;
>                                         };
>                                         /* Set up drive strength on
> GMAC0 to 16 mA */
>                                         conf7 {
>                                                 groups = "gmii_gmac0_grp";
>                                                 drive-strength = <16>;
>                                         };
>                                 };
> 
> So there are definitely systems doing this.

So here, the skews are:
- GMAC0 RXD skewed by 7 = 1.4ns, and GMAC0 RXC by 10, making 2ns.
	Relative skew = 0.6ns.

- GMAC0 TXD by 5 = 1.0ns, and GMAC0 TXD by 10, making 2ns.
	Relative skew = 1ns.

I think this suggests there's additional skew by the PCB traces to make
up to the required 1.5 to 2ns skew required by RGMII.

> > In that case, the current phy-mode = "rgmii" would
> > be the correct choice, and changing that would be invalid. Some more
> > documentary work would be needed.
> 
> Does the aboe help or did I make it even more confusing :D

As far as I'm concerned, I think I have an overall picture of what is
going on here - it's whether anyone else agrees with that!

Going back to the 685, the skews for the datalines and clocks are:

	gmac0                          rtl8366rb
	pinctrl ----- pcb traces ----- pinstrapped
RXC	1.4ns         unknown          unknown
RXD*	1.4ns         unknown          unknown
TXC	1.4ns         unknown          unknown
TXD*	1.4ns         unknown          unknown

In the case of 313:

	gmac0                          PHY
	pinctrl ----- pcb traces ----- phy0
RXC	2.0ns         unknown          0ns	(PHY 0ns due to using
RXD*	1.4ns         unknown          0ns	 phy-mode = "rgmii" on)
TXC	2.0ns         unknown          0ns	 gmac0's node.)
TXD*	1.0ns         unknown          0ns


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

