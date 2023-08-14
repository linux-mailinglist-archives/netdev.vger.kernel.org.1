Return-Path: <netdev+bounces-27403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E068077BD5B
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118D41C209E9
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 15:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160C4C2EA;
	Mon, 14 Aug 2023 15:46:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA89C139
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 15:46:37 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174D510CE
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FgEDjXeG6Bx1eIClysGUqD21mmR4qygWHf6uVaATfTI=; b=Q7NrGmkY7WGoPRbRUE3FWp/VBR
	AgCHHqXG5/MBWOIRh37RGdVIKC9YdMEj1mitxOZHnTrjLBc6sD3w/aS0QK+BQO+L1VxX/OSE1K3Oh
	0MbktW87ffLH55EUeVFXFRvMEudZcWa99JtBRm1/vesvt4ERRA5tVbgGIMNOWFcoXA/M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qVZlt-0044Ga-PR; Mon, 14 Aug 2023 17:46:21 +0200
Date: Mon, 14 Aug 2023 17:46:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
References: <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <20230808123901.3jrqsx7pe357hwkh@skbuf>
 <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk>
 <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
 <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
 <20230814145948.u6ul5dgjpl5bnasp@skbuf>
 <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > > +		__set_bit(PHY_INTERFACE_MODE_RGMII, interfaces);
> > 
> > also, I guess that this should allow all 4 variants of RGMII.
> 
> I'm not sure - looking at what's available, the RTL8366 datasheet (not
> RB) says that there's pinstrapping for the RGMII delays. It also suggests
> that there may be a register that can be modified for this, but the driver
> doesn't appear to touch it - in fact, it does nothing with the interface
> mode. Moreover, the only in-kernel DT for this has:
> 
>                         rtl8366rb_cpu_port: port@5 {
>                                 reg = <5>;
>                                 label = "cpu";
>                                 ethernet = <&gmac0>;
>                                 phy-mode = "rgmii";
>                                 fixed-link {
>                                         speed = <1000>;
>                                         full-duplex;
>                                         pause;
>                                 };
>                         };
> 
> Whether that can be changed in the RB version of the device or not, I
> don't know, so whether it makes sense to allow the other RGMII modes,
> again, I don't know.
> 
> Annoyingly, gmac0 doesn't exist in this file, it's defined in
> gemini.dtsi, which this file references through a heirarchy of nodes
> (makes it very much less readable), but it points at:
> 
> / {
> ...
>         soc {
> ...
>                 ethernet@60000000 {
> ...
>                         ethernet-port@0 {
>                                 phy-mode = "rgmii";
>                                 fixed-link {
>                                         speed = <1000>;
>                                         full-duplex;
>                                         pause;
>                                 };
>                         };
> 
> So that also uses "rgmii".
> 
> I'm tempted not to allow the others as the driver doesn't make any
> adjustments, and we only apparently have the one user.

RGMII on both ends is unlikely to work, so probably one is
wrong. Probably the switch has strapping to set it to rgmii-id, but we
don't actually know that. And i guess we have no ability to find out
the truth?

So a narrow definition seems reasonable at the moment, to raise a red
warning flag if somebody does try to use rgmii-id which is not
actually implemented in the driver. And that user then gets to sort
out the problem.

	 Andrew






