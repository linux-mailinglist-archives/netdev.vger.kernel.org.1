Return-Path: <netdev+bounces-28812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 325E6780C50
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 15:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89AF1C215FA
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F01A18AE2;
	Fri, 18 Aug 2023 13:10:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E447ED
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 13:10:42 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02132D4A
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Fec8fEz9P3veXCunaIdf5ifXtayyd5HFK8OlVKnpv6M=; b=Av8+WVAdXQFDk++6kqy26NAt5M
	Qa3EN0fvslLLJJK+XBtx5P6KxI70OlvRw1eh5YDoUuKC19QY+MvQJcyo8EgdVfd2+ur3SLvyqJgrm
	+r++2Peg4b0+mbygDOoF8GHftc2HvSFqsWDvybwqIrBXqj6fNLoLmx/bfomifeIgElRMrsPjL8Jtf
	Cg/8A4Wm5wUGbm6zmIxPwvCll0d19YPa+VWekcMo41tFsUX3g+Gh3uIKiefKYrVyd+00jMF5WL+2O
	MfOvhBBqEx37e1YYXU4AFaLGCTQgv70P0j0zgaLYum1EhEETv7xig1u+qQ70Voa8rBQRklS6U8XiU
	T4dJSivA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54472)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qWzF8-0005cn-1D;
	Fri, 18 Aug 2023 14:10:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qWzF7-0001fJ-FY; Fri, 18 Aug 2023 14:10:21 +0100
Date: Fri, 18 Aug 2023 14:10:21 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <ZN9tvW6cbnjJo/9M@shell.armlinux.org.uk>
References: <20230814145948.u6ul5dgjpl5bnasp@skbuf>
 <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
 <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
 <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
 <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
 <20230817182729.q6rf327t7dfzxiow@skbuf>
 <65657a0e-0b54-4af4-8a38-988b7393a9f5@lunn.ch>
 <20230817191754.vopvjus6gjkojyjz@skbuf>
 <ZN9R00LPUPlkb9sV@shell.armlinux.org.uk>
 <20230818114055.ovuh33cxanwgc63u@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818114055.ovuh33cxanwgc63u@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 02:40:55PM +0300, Vladimir Oltean wrote:
> On Fri, Aug 18, 2023 at 12:11:15PM +0100, Russell King (Oracle) wrote:
> > On Thu, Aug 17, 2023 at 10:17:54PM +0300, Vladimir Oltean wrote:
> > > On Thu, Aug 17, 2023 at 08:52:12PM +0200, Andrew Lunn wrote:
> > > > > Andrew, I'd argue that the MAC-PHY relationship between the DSA master
> > > > > and the CPU port is equally clear as between 2 arbitrary cascade ports.
> > > > > Which is: not clear at all. The RGMII standard does not talk about the
> > > > > existence of a MAC role and a PHY role, to my knowledge.
> > > > 
> > > > The standard does talk about an optional in band status, placed onto
> > > > the RXD pins during the inter packet gap. For that to work, there
> > > > needs to be some notion of MAC and PHY side.
> > > 
> > > Well, opening the RGMII standard, it was quite stupid of myself to say
> > > that. It says that the purpose of RGMII is to interconnect the MAC and
> > > the PHY right from the first phrase.
> > > 
> > > You're also completely right in pointing out that the optional in-band
> > > status is provided by the PHY on RXD[3:0].
> > > 
> > > Actually, MAC-to-MAC is not explicitly supported anywhere in the standard
> > > (RGMII 2.0, 4/1/2002) that I can find. It simply seems to be a case of:
> > > "whatever the PHY is required by the standard to do is specified in such
> > > a way that when another MAC is put in its place (with RX and TX signals
> > > inverted), the protocol still makes sense".
> > > 
> > > But, with that stretching of the standard considered, I'm still not
> > > necessarily seeing which side is the MAC and which side is the PHY in a
> > > MAC-to-MAC scenario.
> > > 
> > > With a bit of imagination, I could actually see 2 back-to-back MAC IPs
> > > which both have logic to provide the optional in-band status (with
> > > hardcoded information) to the link partner's RXD[3:0]. No theory seems
> > > to be broken by this (though I can't point to any real implementation).
> > > 
> > > So a MAC role would be the side that expects the in-band status to be
> > > present on its RXD[3:0], and a PHY role would be the side that provides
> > > it, and being in the MAC role does not preclude being in the PHY role?
> > 
> > ... trying to find an appropriate place in this thread to put this
> > as I would like to post the realtek patch adding the phylink_get_caps
> > method.
> > 
> > So, given the discussion so far, we have two patches to consider.
> > 
> > One patch from Linus which changes one of the users of the Realtek
> > DSA driver to use "rgmii-id" instead of "rgmii". Do we still think
> > that this a correct change given that we seem to be agreeing that
> > the only thing that matters on the DSA end of this is that it's
> > "rgmii" and the delays for the DSA end should be specified using
>   ~~~~~~~
>   I'd say not necessarily specifically "rgmii", but rather "rgmii*"
> 
> > the [tr]x-internal-delay-ps properties?

For a CPU link though, where there is no "phy", does specifying anything
other than "rgmii" make sense? (since there's no "remote" side that
would take a blind bit of notice of it.)

> As long as it is understood that changing "rgmii" to "rgmii-id" is
> expected to be inconsequential (placebo) for a fixed-link, I don't have
> an objection (in principle) to that patch.
> 
> Though, to have more confidence in the validity of the change, I'd need
> the phy-mode of the &gmac0 node from arch/arm/boot/dts/gemini/gemini-dlink-dir-685.dts,
> and I'm not seeing it.

Gemini DT source is hard to follow, because despite there being the
labels, they aren't always used. gmac0 points at
/soc/ethernet@6000000/ethernet-port@0 and finding that in
arch/arm/boot/dts/gemini/gemini-dlink-dir-685.dts gives us:

gmac0 specifies a fixed link with:
	phy-mode = "rgmii";

It would be helpful if the labels were used consistently!

> Looking at its driver (drivers/net/ethernet/cortina/gemini.c), I don't
> see any handling of RGMII delays, and it accepts any RGMII phy-mode.

As discussed previously in this thread with Linus, Gemini apparently
has the capability to add the delays in via the pinctrl layer. In
this case, in the pinctrl-gmii node, everything has the same skew delay
so the Gemini end of the link looks like it has no delays.

On the Realtek DSA end, we don't know how it's strapped. RTL8366 (*not*
RB) has the ability to pinstrap the required delays, and read the
pinstrapping status out of a register. That register address is used
for an entirely different purpose by RTL8366RB, so we can't easily
find out that way.

> So, if neither the Ethernet controller nor the RTL8366RB switch are
> adding RGMII delays, it becomes plausible that there are skews added
> through PCB traces. In that case, the current phy-mode = "rgmii" would
> be the correct choice, and changing that would be invalid. Some more
> documentary work would be needed.

It could also be that RTL8366RB is pinstrapped to add the delays. If
RTL8366RB is pinstrapped for delays on both rx and tx, then that would
be equivalent to a DT description of e.g.:

	phy-mode = "rgmii";
	rx-internal-delay-ps = <2000>;
	tx-internal-delay-ps = <2000>;

on the DSA end, and:

	phy-mode = "rgmii-id";

on the gmac0 end.

I believe the DSA end in this case should be "rgmii" because there are
no delays being added at the CPU side of the connection, and in _this_
case in gemini-dlink-dir-685.dts, it would be incorrect to change the
DSA side from "rgmii".

Whether the delays are added by the switch or by trace routing is
something we can't answer, thus we can't say whether the CPU end should
use "rgmii-id" or "rgmii", nor whether the delay-ps properties should
be added on the DSA side to make a complete "modern" description.

> In any case, I wouldn't rush a change to arch/arm/boot/dts/gemini/gemini-dlink-dir-685.dts,
> and I'm not seeing any dependency between that and your phylink_get_caps
> conversion for the rtl8366rb.

If the DSA side is changed from "rgmii" to "rgmii-id" then only doing:

                __set_bit(PHY_INTERFACE_MODE_RGMII, interfaces);

means that when phylink_create() is called with
PHY_INTERFACE_MODE_RGMII_ID due to Linus' change, the phylink_validate()
in phylink_parse_fixedlink() will continue to fail (as it is today) and
if that bug ever gets fixed, then rtl8366rb.c will break.

This negates the whole point of adding phylink_get_caps() for realtek.

> > The second patch is my patch adding a phylink_get_caps method for
> > Realtek drivers - should that allow all "rgmii" interface types,
> > or do we want to just allow "rgmii" to encourage the use of the
> > [tr]x-internal-delay-ps properties?
> 
> Same opinion as above. As long as it's understood that the RTL8366RB
> MAC, like any other MAC, shouldn't be acting upon the phy-mode when
> adding delays, let's just accept all 4 variants, with future support to
> be added for [rt]x-internal-delay-ps if there turn out to be
> configurable MAC-side delays present.

Yes, I think you're right, because we could have the situation where
the CPU side is adding the delays, and the DSA side is not, which
should be described in DT as:

	phy-mode = "rgmii-id";

on the DSA side, and e.g.:

	phy-mode = "rgmii";
	rx-internal-delay-ps = <2000>;
	tx-internal-delay-ps = <2000>;

on the CPU side. Yes?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

