Return-Path: <netdev+bounces-28811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB300780C47
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 15:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6141F1C21601
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E264D182DB;
	Fri, 18 Aug 2023 13:09:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EFA17AC1
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 13:09:07 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258013AB8
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 06:09:05 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d7225259f52so925627276.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 06:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692364144; x=1692968944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nu/uojNUaOgYUsxfgcCU0pzdQW7Vlmz9A4HxT57pn7w=;
        b=lUZ0TSHsi0ltbF53sxkRQVr8Hkc6i4WCGGUSwKWr59cck8KM4KkrKvzFykIG1WOXu7
         TZOVijnHGqQyCSIpHvFPaS2/U4MMocBl5gKoRbDLOKxzn/McM+pPePJpZE+Oq/Ypt47P
         73MbuNCXQJu0QrQQ2P9NjHegFOMfSmIjQSGcpaD9Z9wr7nV+Qd9hUaP895extUQ1mqZw
         YAZLEKw1UqJdc1ZiwSxFJInUGQRERbu9WbUeUu9/D0BAZexs/v7pNOvUMUgqtQg5uZEL
         Ps/tRCQWhJPzuGDg8Q7LDaGRWlPP5KOdfMAXO+djBcgASBSi02qdZONDc9UCcPYg2MDn
         l0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692364144; x=1692968944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nu/uojNUaOgYUsxfgcCU0pzdQW7Vlmz9A4HxT57pn7w=;
        b=PbuiFZ1ejkJgdJxEr3U4Amuv3fiExqgS6U8+Bui1EMxbV2K4qm6XIwgYS55JApmFD8
         egkeNnUyV2LfPZGSXjhYOX9q3UwNAjl2PVDca4vYYr+8bLrv0veCwK9k8MbZk7ns2No5
         XYXJXdrImuU6D/Lx91/kncQm+ZEq+CxzKdrdtJ/I8n8uc85Ub/Uyar1My9T0JspD2O1X
         +mawfxHhQNIHOwkqw0EpFc4vcEZma6yR+/DJ0flPkM7nQZjVKx+4dV2ujCYrE2XmHM9j
         cJ+0WTZ1TA+HtVcjxI/bU01TvkffvpXBMJrd30ja+xB9K+dl0cDPR2gZvA+Em/9r/7AY
         AcYA==
X-Gm-Message-State: AOJu0Yw/yyxwo9SzT6Ykp9jgubm6ty7wcJvKMcdlOMu1p6PyXRZEtf6h
	DGeJ1NJT5FBTwN9ib9r7CGo+1VM9p9wCEY7miZDq6w==
X-Google-Smtp-Source: AGHT+IFVXLEmBzzJhC4IBdfFhmIBOZBkSupW36CppkWo23nxRP2xASiqTQWvgCn/1R6PeWx7UPrsDRG3r0zc+bj+JaU=
X-Received: by 2002:a25:320e:0:b0:d5d:4bae:6fe0 with SMTP id
 y14-20020a25320e000000b00d5d4bae6fe0mr2576717yby.21.1692364144187; Fri, 18
 Aug 2023 06:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk> <20230814145948.u6ul5dgjpl5bnasp@skbuf>
 <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk> <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
 <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk> <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
 <20230817182729.q6rf327t7dfzxiow@skbuf> <65657a0e-0b54-4af4-8a38-988b7393a9f5@lunn.ch>
 <20230817191754.vopvjus6gjkojyjz@skbuf> <ZN9R00LPUPlkb9sV@shell.armlinux.org.uk>
 <20230818114055.ovuh33cxanwgc63u@skbuf>
In-Reply-To: <20230818114055.ovuh33cxanwgc63u@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 18 Aug 2023 15:08:52 +0200
Message-ID: <CACRpkdYf-VwCUFigjb1ZHJfieXkxqLSwVmG_S-SKJQY1bciCHA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 1:40=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:

> Though, to have more confidence in the validity of the change, I'd need
> the phy-mode of the &gmac0 node from arch/arm/boot/dts/gemini/gemini-dlin=
k-dir-685.dts,
> and I'm not seeing it.

The assignment of the gmac0 label is in the top-level DTSI:

(...)
                ethernet: ethernet@60000000 {
                        compatible =3D "cortina,gemini-ethernet";
(...)
                        gmac0: ethernet-port@0 {
                                compatible =3D "cortina,gemini-ethernet-por=
t";
(...)

Then in the DIR-685 overlay DTS It looks like this:

                ethernet@60000000 {
                        status =3D "okay";

                        ethernet-port@0 {
                                phy-mode =3D "rgmii";
                                fixed-link {
                                        speed =3D <1000>;
                                        full-duplex;
                                        pause;
                                };
                        };
                        ethernet-port@1 {
                                /* Not used in this platform */
                        };
                };

Russell pointed out that this style with overlays of nodes are
confusing. I agree. If I did it today I would use &gmac0 to
configure it. There is a bit of development history here.

> Looking at its driver (drivers/net/ethernet/cortina/gemini.c), I don't
> see any handling of RGMII delays, and it accepts any RGMII phy-mode.

The handling of the delays exist and is done orthogonally, from
the pin controller, which can assign skewing to pins on the chip.

There are also SoCs that will do clock skewing in the external
bus controller, from a driver in drivers/bus such as what
drivers/bus/intel-ixp4xx-eb.c is doing for IXP4xx. So there
are even several different places where clock skewing/transmit
delays can be handled.

For DIR-685 is looks like this:

                                pinctrl-gmii {
                                        mux {
                                                function =3D "gmii";
                                                groups =3D "gmii_gmac0_grp"=
;
                                        };
                                        conf0 {
                                                pins =3D "V8 GMAC0
RXDV", "T10 GMAC1 RXDV",
                                                     "Y7 GMAC0 RXC",
"Y11 GMAC1 RXC",
                                                     "T8 GMAC0 TXEN",
"W11 GMAC1 TXEN",
                                                     "U8 GMAC0 TXC",
"V11 GMAC1 TXC",
                                                     "W8 GMAC0 RXD0",
"V9 GMAC0 RXD1",
                                                     "Y8 GMAC0 RXD2",
"U9 GMAC0 RXD3",
                                                     "T7 GMAC0 TXD0",
"U6 GMAC0 TXD1",
                                                     "V7 GMAC0 TXD2",
"U7 GMAC0 TXD3",
                                                     "Y12 GMAC1 RXD0",
"V12 GMAC1 RXD1",
                                                     "T11 GMAC1 RXD2",
"W12 GMAC1 RXD3",
                                                     "U10 GMAC1 TXD0",
"Y10 GMAC1 TXD1",
                                                     "W10 GMAC1 TXD2",
"T9 GMAC1 TXD3";
                                                skew-delay =3D <7>;
                                        };
                                        /* Set up drive strength on
GMAC0 to 16 mA */
                                        conf1 {
                                                groups =3D "gmii_gmac0_grp"=
;
                                                drive-strength =3D <16>;
                                        };
                                };

So skew-delay of 7 steps, each step is ~0.2ns so all pins have a delay
of 7*0.2 =3D 1.4ns.

> So, if neither the Ethernet controller nor the RTL8366RB switch are
> adding RGMII delays,

Actually the SoC is. When the ethernet is probed, it asks for its
default pin configuration, and it will applied from the device tree
from the above node. It's just that the registers to control them
are not in the ethernet hardware block, but in the pin controller.

> it becomes plausible that there are skews added
> through PCB traces.

In the DIR-685 example I think it is *both* (yeah...) because it
makes no sense that all delays are 1.4ns. I think the PCB
routing influence it *too*.

However the D-Link DNS-313 makes more elaborate use of
these settings:

                                pinctrl-gmii {
                                        mux {
                                                function =3D "gmii";
                                                groups =3D "gmii_gmac0_grp"=
;
                                        };
                                        /*
                                         * In the vendor Linux tree,
these values are set for the C3
                                         * version of the SL3512 ASIC
with the comment "benson suggest"
                                         */
                                        conf0 {
                                                pins =3D "R8 GMAC0
RXDV", "U11 GMAC1 RXDV";
                                                skew-delay =3D <0>;
                                        };
                                        conf1 {
                                                pins =3D "T8 GMAC0 RXC";
                                                skew-delay =3D <10>;
                                        };
                                        conf2 {
                                                pins =3D "T11 GMAC1 RXC";
                                                skew-delay =3D <15>;
                                        };
                                        conf3 {
                                                pins =3D "P8 GMAC0
TXEN", "V11 GMAC1 TXEN";
                                                skew-delay =3D <7>;
                                        };
                                        conf4 {
                                                pins =3D "V7 GMAC0 TXC",
"P10 GMAC1 TXC";
                                                skew-delay =3D <10>;
                                        };
                                        conf5 {
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
                                        conf6 {
                                                pins =3D "U7 GMAC0
TXD0", "T7 GMAC0 TXD1",
                                                       "R7 GMAC0
TXD2", "P7 GMAC0 TXD3";
                                                skew-delay =3D <5>;
                                        };
                                        /* Set up drive strength on
GMAC0 to 16 mA */
                                        conf7 {
                                                groups =3D "gmii_gmac0_grp"=
;
                                                drive-strength =3D <16>;
                                        };
                                };

So there are definitely systems doing this.

> In that case, the current phy-mode =3D "rgmii" would
> be the correct choice, and changing that would be invalid. Some more
> documentary work would be needed.

Does the aboe help or did I make it even more confusing :D

If guess I could imagine the delays being configured directly
from the ethernet driver if that is highly desired. For the IXP4xx
ATA controller (that has similar needs to a network phy) I just
shortcut the whole "this goes into the external memory
controller" and look up the address space for the delay
settings and control these settings directly from the driver.
It's not very encapsulated but sometimes the world out there
is ugly, and the ATA drivers really want to control this
see drivers/ata/pata_ixp4xx_cf.c,
ixp4xx_set_8bit_timing() etc.

To do delay set-up fully from the ethernet controller, for Gemini,
I would just pull this register range out from the pin controller,
remove the pin control stuff in the device tree, and poke it
directly from the ethernet driver. It can be done for sure.
It's just two different ways to skin the cat.

I suppose it fully confirms the view that the phy-mode in
the ethernet controller is 100% placebo though!

Just my =E2=82=AC0.01

Yours,
Linus Walleij

