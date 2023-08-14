Return-Path: <netdev+bounces-27516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D467577C330
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 00:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F8F1C20BC8
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 22:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576BA100BC;
	Mon, 14 Aug 2023 22:03:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA9DDB7
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 22:03:17 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FA0114
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 15:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y6ZwHZXk+e+ZMIiDZymmj+h+cU68RdsR+MQBfdPS21U=; b=gb2BWhYxd1rxdk8Qe8eYSP/+eH
	Qm8z3MwLuaOMc4eE0XnyMQ5w5wpj3cVgoQ2iRPAqeswGvTf3y3Tt9S7D+w+LqMDSIuMd4w+cuncxK
	jIxmgAfSYLYBwLk5OHNj3WQqhq1XwlYpo+Vrn1pTFwdVS1o2y4SLzNkQRysOV39gsrREEf4O8dSxy
	dkslOYiR8e6IzUEnq/3dlXXGBYqErtFmoA1fI5F+0Eb/PlRJySBKU4zNXTXBSYhW0pSg6EI1CJDZD
	SRo2xEMSQk6MANSCmbm7ZQM6boATiASfx4WMTRE19neiC/SfelmqDY/NbeyKDbjywNFcJa9JzNaRp
	sUdTGtyg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59260)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qVfeP-0000rC-2u;
	Mon, 14 Aug 2023 23:03:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qVfeO-0006Jh-6p; Mon, 14 Aug 2023 23:03:00 +0100
Date: Mon, 14 Aug 2023 23:03:00 +0100
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
Message-ID: <ZNqklHxfH8sYaet7@shell.armlinux.org.uk>
References: <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk>
 <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
 <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
 <20230814145948.u6ul5dgjpl5bnasp@skbuf>
 <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
 <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
 <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
 <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 07:05:19PM +0200, Andrew Lunn wrote:
> > > So a narrow definition seems reasonable at the moment, to raise a red
> > > warning flag if somebody does try to use rgmii-id which is not
> > > actually implemented in the driver. And that user then gets to sort
> > > out the problem.
> > 
> > I think Vladimir will be having a party, because that's now two of us
> > who've made the mistake of infering that "phy-mode" changes the
> > configuration at the end that has that specified (I can hear the
> > baloons being inflated!)
> > 
> > Of course it shouldn't, as per our documentation on RGMII delays in
> > Documentation/networking/phy.rst that was added by Florian back in
> > November 2016.
> 
> It might not be documented, but there are a couple of DSA drivers
> which do react on this property and set their RGMII delays based on
> this for their CPU port. mv88e6xxx is one of them, and it also does so
> for DSA ports.

mv88e6xxx does indeed configure the RGMII delays:

mv88e6xxx_port_set_rgmii_delay() does the delay configuration in the
MAC_CTL register for each port, using the interface mode passed to it.

This is called by mv88e6xxx_port_config_interface() which in turn is
called by mv88e6xxx_port_setup_mac() and mv88e6xxx_mac_config().

This will be using the interface mode set in the switch port's
configuration, rather than the interface mode that is in the CPU
MAC node to which it is connected. This is different.

Essentially, when an ethernet driver connects to a PHY:

   MAC <---------------------------------> PHY
    v					    v
dt-mac-node {				dt-phy-node {
  phy-mode = "rgmii-foo";		  /* contains no phy-mode */
};					};

parses phy mode
configures for RGMII mode
ignores RGMII delays associated
 with phy-mode
applies any delays configured
 by rx-internal-delay-ps and
 tx-internal-delay-ps properties
calls phy_attach(..., mode);
phylib sets phy_dev->interface
					PHY driver uses phy_dev->interface
					 to configure RGMII delays

So, in this case, the dt-mac-node phy-mode property determines the
delays at the PHY.

In the DSA case:

   MAC <---------------------------------> DSA
    v					    v
dt-mac-node {				dt-dsa-node {
  phy-mode = "rgmii-foo";		  phy-mode = "rgmii-bar";
  fixed-link {				  fixed-link {
   ...					   ...
  };					  };
};					};

parses phy mode				parses phy mode
configures for RGMII mode		configures for RGMII mode
ignores RGMII delays associated		configures RGMII delays
 with phy-mode				 associated with its own phy-mode
applies any delays configured
 by rx-internal-delay-ps and
 tx-internal-delay-ps properties
sets up fixed link			sets up fixed link

This is a different behaviour from the phylib setup above... but
let me explain why it is, because it now looks very weird.

Before phylink, we actually had this model for DSA switches:

Host MAC <----------------------------> Fixed-PHY
      v					    v
dt-mac-node {				No DT node
  phy-mode = "rgmii-foo";
  fixed-link {
   ...
  };
};

parses phy mode
configures for RGMII mode
ignores RGMII delays associated
 with phy-mode
applies any delays configured
 by rx-internal-delay-ps and
 tx-internal-delay-ps properties
calls phy_attach(..., mode);
phylib sets phy_dev->interface
					Generic PHY driver ignores
					phy_dev->interface

Then we have the DSA side:

   DSA <------------------------------> Fixed-PHY
    v					    v
dt-dsa-node {				No DT node
  phy-mode = "rgmii-foo";
  fixed-link {
   ...
  };
};

parses phy mode
configures for RGMII mode
configures RGMII delays associated
 with phy-mode
calls phy_attach(..., mode);
phylib sets phy_dev->interface
					Generic PHY driver ignores
					phy_dev->interface

... and it is as if, magically, those two fixed-PHYs talk to each
other. So, the model looks very much still like the phylib model
above - each MAC has a PHY that it talks to and passes the RGMII
interface mode to. The difference is, that PHY is a software
emulation of a PHY operating in a fixed mode.

The other difference is that the DSA MAC configures its RGMII delays
from its *own* phy-mode, which is completely different from what
happens with a host MAC which doesn't - because in November 2016,
it was decided (and documented) that the PHY interface mode specifies
the delays to be used *at* *the* *phy* and not the *mac* side of the
link.

So now, when one looks at the phylink setup, where those fixed-PHYs
have essentially been eliminated, it now looks very weird in
comparison - because it leads one to believe that the DSA switch
RGMII interface has taken the place of a proper PHY, and that leads
up to the conclusion that "but if phylib sets the PHY delays
according to the host MAC's phy-mode property, why isn't DSA doing
the same!" The answer to that is... established history.

The host MAC phy-mode property still has zero effect what so ever on
the RGMII delay settings at the host MAC end of the link - and can be
*any* of the four RGMII interface types. It really doesn't matter.

The DSA MAC phy-mode property, at least in the case of mv88e6xxx,
configures the RGMII delays at the DSA switch MAC end of the link.


So, to summarise...

A host MAC connected to a phylib PHY, the host MAC's phy-mode property
defines the RGMII delays at device on other end of the RGMII bus - which
is the phylib PHY.

A host MAC connected to a DSA switch, the host MAC's phy-mode property
is irrelevant as far as RGMII delays are concerned, they have no
effect on the device on the end of the RGMII bus.

A DSA MAC, the DSA MAC's phy-mode property is used to configure the
RGMII delays on the *local* end of the RGMII bus.

This is what happens with the mv88e6xxx driver, whether intentional or
not. In the case of a DSA to host MAC link, there is no attempt by DSA
to delve into the host MAC's DT to retrieve the phy-mode property
there.


The big problem with RGMII delays has been this in the documentation:

"The PHY library offers different types of PHY_INTERFACE_MODE_RGMII*
values to let the PHY driver and optionally the MAC driver, implement
the required delay. The values of phy_interface_t must be understood
from the perspective of the PHY device itself, leading to the
following:"

Note "and optionally the MAC driver". Well, no, there is nothing
optional about this if one wants consistency of implementation - and
I'll explain why in a moment, but first lets see what is expected of
the PHY itself for each of these RGMII modes:

"* PHY_INTERFACE_MODE_RGMII: the PHY is not responsible for inserting any
   internal delay by itself, it assumes that either the Ethernet MAC (if
   capable) or the PCB traces insert the correct 1.5-2ns delay

 * PHY_INTERFACE_MODE_RGMII_TXID: the PHY should insert an internal delay
   for the transmit data lines (TXD[3:0]) processed by the PHY device

 * PHY_INTERFACE_MODE_RGMII_RXID: the PHY should insert an internal delay
   for the receive data lines (RXD[3:0]) processed by the PHY device

 * PHY_INTERFACE_MODE_RGMII_ID: the PHY should insert internal delays for
   both transmit AND receive data lines from/to the PHY device"

This is quite clear where the delay is inserted - by the *PHY* device.
The above pre-dates my involvement in PHYLIB, and comes from a commit
by Florian in November 2016, yet I seem to be often attributed with it.

Now, going back to that "optionally the MAC driver". Consider if we
have, say, a PHY driver that is using host MAC M1 that has decided not
to implement the delays (hey, they're optional!) Using
PHY_INTERFACE_MODE_RGMII_TXID, to satisfy the above, the PHY is
expected to insert the required delay for the transmit data lines.

Now lets say that the very same PHY driver uses host MAC M2, but that
MAC driver has decided to implement these delays (hey, they're
optional!) Using again PHY_INTERFACE_MODE_RGMII_TXID, the MAC driver
decided to add delay to the transmit path. The PHY, however, also
sees PHY_INTERFACE_MODE_RGMII_TXID and adds its own delay to the
transmit data lines as it always has done. Now we have a double delay.

So, that "and optionally the MAC driver" is what has historically led
to problems with the various RGMII modes, with new implementations
popping up and finding that host MAC M2 that's been in use for years
with PHY device P1 (that hasn't implemented RGMII delays because the
MAC driver did) now doesn't work with PHY device P2 (which does
implement RGMII delays) that has also been in use for years.

It's because that "optionally" stuff at the MAC end has led people
down the path of _sometimes_ implementing RGMII delays at the MAC
end of the link, and other times implementing RGMII delays at the
PHY end of the link according to the phy-mode specification at the
host MAC.

It seems to me that since we had this understanding that RGMII delays
are applied at the PHY end of the link for RGMII, we have had
significantly less "my RGMII doesn't work" stuff. That's not really
my doing - that's Florian's, by writing the specification for the
what is expected of the PHY device for each of the RGMII phy
interface modes back in November 2016. My only part in it was only
later ensuring that everyone was singing off the same hymm sheet with
what had already been decided - so we didn't get different reviewers
telling people different things that were also different from what
had been documented.

... and with that consistency, we now appear to have way less issues
with RGMII - or at least that is my impression in terms of the emails
I see as one of the co-phylib maintainers (thus I get the emails!)

At the end of the day, what is important for inter-operability between
PHYs and MACs is that *both* implement the RGMII delays in a consistent
manner, so if PHYs are to insert delays and MACs not, then all PHY
drivers need to insert delays and all MACs must not.

We had been heading to a situation where some MACs did, other MACs
didn't, some PHY drivers did, some PHY drivers didn't...

Anyway, this seems to have turned into a very long email... wasn't
supposed to be, but I suspect if I didn't cover everything, there
would be a very long email thread instead... well, there probably
will be picking this apart and disagreeing with bits of it...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

