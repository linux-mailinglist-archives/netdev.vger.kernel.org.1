Return-Path: <netdev+bounces-28566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 721DA77FD9C
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 20:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48B1281F90
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 18:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBD2174D4;
	Thu, 17 Aug 2023 18:19:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A79614F7B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 18:19:15 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C312D58
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:19:13 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bbac8ec902so1262491fa.1
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692296351; x=1692901151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i5JN6CM62KkeXqzDUh+z5/GPDNZX/lfnvcnAu9bfHyg=;
        b=LCNQlCsUU/x/R2JG/VZgcyPBcfsR6Puw8A47KjAOx47q5WUOfWE9FbQzS9dKTUGkqW
         ItxKuR75dcJXnhMf4WVdrgdiot62uzOPHaRgyyz0wQgY0xklvEPFfqqTO2c9k6oTH4oA
         PBkpsM3+Pl6DpAn3AD+QpQu5bDHgXkOXkTtTUrQhKpd7r9J2P9BUfpBed5CZ548p+zDZ
         hLNtjo/Tm4rrciQRQeGgUI8KYt2oFKRuMqCAN19qpOUF9hgdF0U326k6PnyS/KtV2qa5
         CBL86EE+yVSzjELmRs1zQwEJlI7Ih0sU7UIo2xFPlYdgNW5B5PN5c8ZHES9kMDz7pAAS
         mMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296351; x=1692901151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5JN6CM62KkeXqzDUh+z5/GPDNZX/lfnvcnAu9bfHyg=;
        b=hW5rk3YAQ41iZdqfp2YVaD4rpc7L3dxk2B+RAjXr8WudCzq2W/AcH6h3UuG7EAEJqY
         sgdgR9IUaM4sjKWGwKm97DhqwnHKdeP66bF3IiIq0bB9EHR8WXo+47PbmqbSq0fCTcQf
         ToD0k0vWygG+qkZzX1tsbdkFZWxkMj77wcluyuRgj0lJyj1EU3uM4xwGvBUZQEds3+AI
         eV7mqRfxhtniTxo9WtSh7U6ObNfaMa2WhtanvZSCOxz8oLZ4DABMZ1bnDzZ4hRbkKcKm
         9ahc4e4u1ECpEqFyjdv4XuNG2cKo42eN2MiYme3b4ZhgYFEXXh3IZ4cC3QMQ8Nt9kMNT
         ZGog==
X-Gm-Message-State: AOJu0YyOWZ8eg6+Fl955KU3tcfhAQOj3GkziHdMnjSfvhCE35KkHoyrE
	L+VXx8Ej5406n5N1VwjCRUU=
X-Google-Smtp-Source: AGHT+IHHyW8JoAKuWO/DLwKg+SSiI3TESI9cM9GINnBIs34E2FnR4FFcN5YeFejvsyMvhpvAiYIi3A==
X-Received: by 2002:a2e:9855:0:b0:2b6:ee99:fffc with SMTP id e21-20020a2e9855000000b002b6ee99fffcmr102484ljj.36.1692296350311;
        Thu, 17 Aug 2023 11:19:10 -0700 (PDT)
Received: from skbuf ([188.25.231.206])
        by smtp.gmail.com with ESMTPSA id x5-20020a170906148500b0098e42bef736sm44335ejc.176.2023.08.17.11.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 11:19:10 -0700 (PDT)
Date: Thu, 17 Aug 2023 21:19:07 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <20230817181907.fabk6brhpzrjrqmi@skbuf>
References: <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
 <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
 <20230814145948.u6ul5dgjpl5bnasp@skbuf>
 <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
 <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
 <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
 <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
 <ZNqklHxfH8sYaet7@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNqklHxfH8sYaet7@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 11:03:00PM +0100, Russell King (Oracle) wrote:
> So, to summarise...
> 
> A host MAC connected to a phylib PHY, the host MAC's phy-mode property
> defines the RGMII delays at device on other end of the RGMII bus - which
> is the phylib PHY.
> 
> A host MAC connected to a DSA switch, the host MAC's phy-mode property
> is irrelevant as far as RGMII delays are concerned, they have no
> effect on the device on the end of the RGMII bus.
> 
> A DSA MAC, the DSA MAC's phy-mode property is used to configure the
> RGMII delays on the *local* end of the RGMII bus.
> 
> This is what happens with the mv88e6xxx driver, whether intentional or
> not. In the case of a DSA to host MAC link, there is no attempt by DSA
> to delve into the host MAC's DT to retrieve the phy-mode property
> there.
> 
> 
> The big problem with RGMII delays has been this in the documentation:
> 
> "The PHY library offers different types of PHY_INTERFACE_MODE_RGMII*
> values to let the PHY driver and optionally the MAC driver, implement
> the required delay. The values of phy_interface_t must be understood
> from the perspective of the PHY device itself, leading to the
> following:"
> 
> Note "and optionally the MAC driver". Well, no, there is nothing
> optional about this if one wants consistency of implementation - and
> I'll explain why in a moment, but first lets see what is expected of
> the PHY itself for each of these RGMII modes:
> 
> "* PHY_INTERFACE_MODE_RGMII: the PHY is not responsible for inserting any
>    internal delay by itself, it assumes that either the Ethernet MAC (if
>    capable) or the PCB traces insert the correct 1.5-2ns delay
> 
>  * PHY_INTERFACE_MODE_RGMII_TXID: the PHY should insert an internal delay
>    for the transmit data lines (TXD[3:0]) processed by the PHY device
> 
>  * PHY_INTERFACE_MODE_RGMII_RXID: the PHY should insert an internal delay
>    for the receive data lines (RXD[3:0]) processed by the PHY device
> 
>  * PHY_INTERFACE_MODE_RGMII_ID: the PHY should insert internal delays for
>    both transmit AND receive data lines from/to the PHY device"
> 
> This is quite clear where the delay is inserted - by the *PHY* device.
> The above pre-dates my involvement in PHYLIB, and comes from a commit
> by Florian in November 2016, yet I seem to be often attributed with it.
> 
> Now, going back to that "optionally the MAC driver". Consider if we
> have, say, a PHY driver that is using host MAC M1 that has decided not
> to implement the delays (hey, they're optional!) Using
> PHY_INTERFACE_MODE_RGMII_TXID, to satisfy the above, the PHY is
> expected to insert the required delay for the transmit data lines.
> 
> Now lets say that the very same PHY driver uses host MAC M2, but that
> MAC driver has decided to implement these delays (hey, they're
> optional!) Using again PHY_INTERFACE_MODE_RGMII_TXID, the MAC driver
> decided to add delay to the transmit path. The PHY, however, also
> sees PHY_INTERFACE_MODE_RGMII_TXID and adds its own delay to the
> transmit data lines as it always has done. Now we have a double delay.
> 
> So, that "and optionally the MAC driver" is what has historically led
> to problems with the various RGMII modes, with new implementations
> popping up and finding that host MAC M2 that's been in use for years
> with PHY device P1 (that hasn't implemented RGMII delays because the
> MAC driver did) now doesn't work with PHY device P2 (which does
> implement RGMII delays) that has also been in use for years.
> 
> It's because that "optionally" stuff at the MAC end has led people
> down the path of _sometimes_ implementing RGMII delays at the MAC
> end of the link, and other times implementing RGMII delays at the
> PHY end of the link according to the phy-mode specification at the
> host MAC.
> 
> It seems to me that since we had this understanding that RGMII delays
> are applied at the PHY end of the link for RGMII, we have had
> significantly less "my RGMII doesn't work" stuff. That's not really
> my doing - that's Florian's, by writing the specification for the
> what is expected of the PHY device for each of the RGMII phy
> interface modes back in November 2016. My only part in it was only
> later ensuring that everyone was singing off the same hymm sheet with
> what had already been decided - so we didn't get different reviewers
> telling people different things that were also different from what
> had been documented.
> 
> ... and with that consistency, we now appear to have way less issues
> with RGMII - or at least that is my impression in terms of the emails
> I see as one of the co-phylib maintainers (thus I get the emails!)
> 
> At the end of the day, what is important for inter-operability between
> PHYs and MACs is that *both* implement the RGMII delays in a consistent
> manner, so if PHYs are to insert delays and MACs not, then all PHY
> drivers need to insert delays and all MACs must not.
> 
> We had been heading to a situation where some MACs did, other MACs
> didn't, some PHY drivers did, some PHY drivers didn't...
> 
> Anyway, this seems to have turned into a very long email... wasn't
> supposed to be, but I suspect if I didn't cover everything, there
> would be a very long email thread instead... well, there probably
> will be picking this apart and disagreeing with bits of it...

Russell, I agree with your analysis that the MAC side's required
interpretation of the phy-mode is underspecified.

What has worked for me was the addition of the "rx-internal-delay-ps"
and "tx-internal-delay-ps" properties in the MAC OF node. When those are
present, I believe that the behavior of the MAC side is fully specified.

Today, the sja1105, qca8k and ksz DSA drivers check for the presence of
these 2 properties, and if found, they will use them, otherwise they
will fall back to the old school of thought - if fixed-link, apply the
delays ourselves.

In addition, rtl8365mb has only the new behavior. It does not have the
old-school logic at all.

There exists a direct migration path between one school of thought and
the other, which preserves functionality for existing device trees, just
prints a warning if rx-internal-delay-ps and tx-internal-delay-ps are
missing on fixed-link ports.

Do you believe that there is value in converting the mv88e6xxx driver
(and gradually, more and more other drivers) to work with the
fully-specified DT bindings?

