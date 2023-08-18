Return-Path: <netdev+bounces-28781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09519780ACE
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74F91C215EB
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 11:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE99C182BC;
	Fri, 18 Aug 2023 11:11:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A39A52
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:11:26 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD1B3590
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 04:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0nNwWEfvZIOxhh0n0nw2SdRJpRud1bAtrAauFjf/Mgg=; b=gi/HltImQlSBHIPm2hR9oYVMnK
	/hiQCqeGi93RMKcv9z4XXKJQRNCQ9BZL+3ECc9YAyrFNPP/LjXSNhYGA1H24kYl8fQ7giarJ0MKoD
	NDQcqe4QctHGF2UIcP0u6WCoDA8Dat6CORvw+51FHHhhOwQsifd10Lxh2uDv+6ZCHjeNb+rM1PQxo
	DW1EoXXaNjqNKz6ZvJ5875toSTfxpluGdYvOW6Drr/oKGSIaUMPk8yy+6ypwDtuzfj4unG0jLQfni
	MIJ1C2Q7gCvaoGr2yma+FXRBgtt5uQdDoK9D+Fa97cLX7eH5altOv3ChfWfaJo/2BLSCi2Z1M4bs5
	qlfUa1bw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59772)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qWxNs-0005Vo-1x;
	Fri, 18 Aug 2023 12:11:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qWxNr-0001aU-7s; Fri, 18 Aug 2023 12:11:15 +0100
Date: Fri, 18 Aug 2023 12:11:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <ZN9R00LPUPlkb9sV@shell.armlinux.org.uk>
References: <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
 <20230814145948.u6ul5dgjpl5bnasp@skbuf>
 <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
 <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
 <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
 <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
 <20230817182729.q6rf327t7dfzxiow@skbuf>
 <65657a0e-0b54-4af4-8a38-988b7393a9f5@lunn.ch>
 <20230817191754.vopvjus6gjkojyjz@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817191754.vopvjus6gjkojyjz@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 10:17:54PM +0300, Vladimir Oltean wrote:
> On Thu, Aug 17, 2023 at 08:52:12PM +0200, Andrew Lunn wrote:
> > > Andrew, I'd argue that the MAC-PHY relationship between the DSA master
> > > and the CPU port is equally clear as between 2 arbitrary cascade ports.
> > > Which is: not clear at all. The RGMII standard does not talk about the
> > > existence of a MAC role and a PHY role, to my knowledge.
> > 
> > The standard does talk about an optional in band status, placed onto
> > the RXD pins during the inter packet gap. For that to work, there
> > needs to be some notion of MAC and PHY side.
> 
> Well, opening the RGMII standard, it was quite stupid of myself to say
> that. It says that the purpose of RGMII is to interconnect the MAC and
> the PHY right from the first phrase.
> 
> You're also completely right in pointing out that the optional in-band
> status is provided by the PHY on RXD[3:0].
> 
> Actually, MAC-to-MAC is not explicitly supported anywhere in the standard
> (RGMII 2.0, 4/1/2002) that I can find. It simply seems to be a case of:
> "whatever the PHY is required by the standard to do is specified in such
> a way that when another MAC is put in its place (with RX and TX signals
> inverted), the protocol still makes sense".
> 
> But, with that stretching of the standard considered, I'm still not
> necessarily seeing which side is the MAC and which side is the PHY in a
> MAC-to-MAC scenario.
> 
> With a bit of imagination, I could actually see 2 back-to-back MAC IPs
> which both have logic to provide the optional in-band status (with
> hardcoded information) to the link partner's RXD[3:0]. No theory seems
> to be broken by this (though I can't point to any real implementation).
> 
> So a MAC role would be the side that expects the in-band status to be
> present on its RXD[3:0], and a PHY role would be the side that provides
> it, and being in the MAC role does not preclude being in the PHY role?

... trying to find an appropriate place in this thread to put this
as I would like to post the realtek patch adding the phylink_get_caps
method.

So, given the discussion so far, we have two patches to consider.

One patch from Linus which changes one of the users of the Realtek
DSA driver to use "rgmii-id" instead of "rgmii". Do we still think
that this a correct change given that we seem to be agreeing that
the only thing that matters on the DSA end of this is that it's
"rgmii" and the delays for the DSA end should be specified using
the [tr]x-internal-delay-ps properties?

The second patch is my patch adding a phylink_get_caps method for
Realtek drivers - should that allow all "rgmii" interface types,
or do we want to just allow "rgmii" to encourage the use of the
[tr]x-internal-delay-ps properties?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

