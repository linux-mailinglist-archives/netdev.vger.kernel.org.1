Return-Path: <netdev+bounces-27415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF92E77BDE7
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 18:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929B41C20A0B
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 16:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A62AC8E1;
	Mon, 14 Aug 2023 16:27:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0762BC15C
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 16:27:58 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3632127
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nZ0WwUTA5BnmpLYNV0W6qmBxFJKWtgZfoC6GeoWx4lY=; b=dDruq6yuUGfQY85/UQHBJpZPJt
	NyvM70bty7d5j8IJECHvQwKmFJrpU4XT7BCQbdcKqI8W7wKoyDB9pWYw0Qp73go3TSKUbszYi+VOj
	jVrWcnZd5RbXjtMqNWUcyzhpYn6Sxyf0zN3SFMlobQO6O75idBXGYhRk8yIr2u1pyAO6m8pxuL9pI
	JrkdRwE1N7CDCDoMDIEMdgZfKve0lAVcqZK4tUmL/Oy2duekHISzOEqDd/MGwtBd4Z/3nj8B/b4uP
	SmQXb5k8/qFnglstf7ssEo01psYVqivKTV4kf5VFzUNkEvDqEqvvC6eG+56Y44ZkyzGA/lVBvuzhQ
	6VFTVOxA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36974)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qVaQ0-0000bo-10;
	Mon, 14 Aug 2023 17:27:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qVaPz-00066W-0F; Mon, 14 Aug 2023 17:27:47 +0100
Date: Mon, 14 Aug 2023 17:27:46 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
References: <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <20230808123901.3jrqsx7pe357hwkh@skbuf>
 <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk>
 <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
 <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
 <20230814145948.u6ul5dgjpl5bnasp@skbuf>
 <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
 <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 05:46:21PM +0200, Andrew Lunn wrote:
> > > > +		__set_bit(PHY_INTERFACE_MODE_RGMII, interfaces);
> > > 
> > > also, I guess that this should allow all 4 variants of RGMII.
> > 
> > I'm not sure - looking at what's available, the RTL8366 datasheet (not
> > RB) says that there's pinstrapping for the RGMII delays. It also suggests
> > that there may be a register that can be modified for this, but the driver
> > doesn't appear to touch it - in fact, it does nothing with the interface
> > mode. Moreover, the only in-kernel DT for this has:
> > 
> >                         rtl8366rb_cpu_port: port@5 {
> >                                 reg = <5>;
> >                                 label = "cpu";
> >                                 ethernet = <&gmac0>;
> >                                 phy-mode = "rgmii";
> >                                 fixed-link {
> >                                         speed = <1000>;
> >                                         full-duplex;
> >                                         pause;
> >                                 };
> >                         };
> > 
> > Whether that can be changed in the RB version of the device or not, I
> > don't know, so whether it makes sense to allow the other RGMII modes,
> > again, I don't know.
> > 
> > Annoyingly, gmac0 doesn't exist in this file, it's defined in
> > gemini.dtsi, which this file references through a heirarchy of nodes
> > (makes it very much less readable), but it points at:
> > 
> > / {
> > ...
> >         soc {
> > ...
> >                 ethernet@60000000 {
> > ...
> >                         ethernet-port@0 {
> >                                 phy-mode = "rgmii";
> >                                 fixed-link {
> >                                         speed = <1000>;
> >                                         full-duplex;
> >                                         pause;
> >                                 };
> >                         };
> > 
> > So that also uses "rgmii".
> > 
> > I'm tempted not to allow the others as the driver doesn't make any
> > adjustments, and we only apparently have the one user.
> 
> RGMII on both ends is unlikely to work, so probably one is
> wrong. Probably the switch has strapping to set it to rgmii-id, but we
> don't actually know that. And i guess we have no ability to find out
> the truth?

"rgmii" on both ends _can_ work - from our own documentation:

* PHY_INTERFACE_MODE_RGMII: the PHY is not responsible for inserting any
  internal delay by itself, it assumes that either the Ethernet MAC (if capable)
  or the PCB traces insert the correct 1.5-2ns delay
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

So, if the board is correctly laid out to include this delay, then RGMII
on both ends can work.

Next, we have no ability to find anything out - we have no hardware.
LinusW does, but I have no idea whether Linus can read the state of the
pin strapping. I can see from the RTL8366 info I found that there is
a register that the delay settings can be read from, but this is not
the RTL8366, it's RTL8366RB, which Linus already pointed out is
revision B and is different. So, I would defer to Linus for anything on
this, and without input from Linus, all we have to go on is what we
have in the kernel sources.

> So a narrow definition seems reasonable at the moment, to raise a red
> warning flag if somebody does try to use rgmii-id which is not
> actually implemented in the driver. And that user then gets to sort
> out the problem.

I think Vladimir will be having a party, because that's now two of us
who've made the mistake of infering that "phy-mode" changes the
configuration at the end that has that specified (I can hear the
baloons being inflated!)

Of course it shouldn't, as per our documentation on RGMII delays in
Documentation/networking/phy.rst that was added by Florian back in
November 2016.

That said, with DSA, we don't currently have a way for the MAC to
instruct the DSA switch what delay it should be using as unlike PHYLIB,
the MAC doesn't bind to the DSA switch in the same way (there's no
dsa_connect() or dsa_attach() call that MACs call which would pass
the phy interface mode to the DSA side.)

However, a DSA switch CPU node does have an "ethernet" property
which points at the CPU-side node, and a DSA switch _could_ read
that setting and use it to configure the RGMII delays in the same
way that PHYs would do - but no one does that.

This brings up the obvious question: does anyone deal with the RGMII
delays with DSA switches in software, or is it all done by hardware
pin strapping, hardware defaults, and/or a correctly laid out PCB?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

