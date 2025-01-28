Return-Path: <netdev+bounces-161313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5838A20A9E
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FE43A72A2
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 12:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406621A2387;
	Tue, 28 Jan 2025 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CBi3yE+T"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A152019DFA2;
	Tue, 28 Jan 2025 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738067616; cv=none; b=A0bQJw4a7EBTQ/ssqZtHYkpTMfNReaYyPNqVwMLryDPb7RMo2fvJPTmmyCIInGKBNA+fHAW/+qzZA/Q28nBCzm4hf9rn4jEC6D50nS4gXMINHBT5E6Dj2Mhm1zZurXX2m43y7vtuL9xXg2R5Z0RovQpCQ9xeKC7JjTTUzIulYJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738067616; c=relaxed/simple;
	bh=qMeUU3sSL4SVn+oVrL0CcuG0N2ChPrOpvQvNJXolO+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/t6T/6udzdbwHMr01hE1DQcOg4cjNOFB+8UL49hohorsLEHe2e3SohfbEwPknbhkq6jCeCuTRMwUW1KHGtVY+0V0OdqdWVjawn+HeDLuK9Y59nljwnOliT4MOM7iIpQ6DjrwNh9gnw3rZigKZvV7C3DarwSCzU4C3QzJlAJ/QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CBi3yE+T; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g7QLWVDf437Tg27DIsju93ZP8mngm2jpjU11niyx3JU=; b=CBi3yE+TRgUO3xCSLhUb1ta1uO
	EZ1OBbu8w80LD4weytB9uDYvv94u3CYXuQfQQ0eFB2wvMVWWF4+/MxeggjR3DGePtied8Nv6CZRBm
	9/ftqk9WwY8a3rneMV+6iVopRX8tPNLtIUZs3wZViFWeZGcHxmxuiXpniM7sKKcfAyWQdyvLoVBlf
	VI50SSWHYDjDtwhkIhhTlCwPcIs0kuJ8LJe1JP9ZBsaj/RN7RUOZdtkmjflsutLS4izdY+Lc2Afwk
	Lq59NqlNowf/T79Qll1aSVc4EL6CU73uN6ZZcobbFxS8J31/fm2FgaRT/Cyj4u7Nc0o4fuvERwpON
	ByUKtcvg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53084)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tckmJ-00077h-2a;
	Tue, 28 Jan 2025 12:33:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tckmF-0002dN-2f;
	Tue, 28 Jan 2025 12:33:11 +0000
Date: Tue, 28 Jan 2025 12:33:11 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Tristram.Ha@microchip.com, Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
References: <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250128102128.z3pwym6kdgz4yjw4@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 28, 2025 at 12:21:28PM +0200, Vladimir Oltean wrote:
> On Tue, Jan 28, 2025 at 09:24:45AM +0000, Russell King (Oracle) wrote:
> > On Mon, Jan 27, 2025 at 07:32:25PM -0800, Tristram.Ha@microchip.com wrote:
> > > For 1000BaseX mode setting neg_mode to false works, but that does not
> > > work for SGMII mode.  Setting 0x18 value in register 0x1f8001 allows
> > > 1000BaseX mode to work with auto-negotiation enabled.
> > 
> > I'm not sure (a) exactly what the above paragraph is trying to tell me,
> > and (b) why setting the AN control register to 0x18, which should only
> > affect SGMII, has an effect on 1000BASE-X.
> > 
> > Note that a config word formatted for SGMII can result in a link with
> > 1000BASE-X to come up, but it is not correct. So, I highly recommend you
> > check the config word sent by the XPCS to the other end of the link.
> > Bit 0 of that will tell you whether it is SGMII-formatted or 802.3z
> > formatted.
> 
> I, too, am concerned about the sentence "setting neg_mode to false works".
> If this is talking about the only neg_mode field that is a boolean, aka
> struct phylink_pcs :: neg_mode, then setting it to false is not
> something driver customizable, it should be true for API compliance,
> and all that remains false in current kernel trees will eventually get
> converted to true, AFAIU. If 1000BaseX works by setting xpcs->pcs.neg_mode
> to false and not modifying anything else, it should be purely a
> coincidence that it "works", since that makes the driver comparisons
> with PHYLINK_PCS_NEG_* constants meaningless.
> 
> > According to the KSZ9477 data, the physid is 0x7996ced0 (which is the
> > DW value according to the xpcs header file). We also read the PMA ID
> > (xpcs->info.pma). Can this be used to identify the KSZ9477 without
> > introducing quirks?
> 
> If nothing else works, and it turns out that different IP integrations
> report the same value in ID registers but need different handling, then
> in principle the hack approach is also on the table. SJA1105, whose
> hardware reads zeroes for the ID registers, reports a fake and unique ID
> for the XPCS to identify it, because it, like the KSZ9477 driver, is in
> control of the MDIO read operations and can selectively manipulate their
> result.

Further review of the KS9477 documentation finds this:

5.5.9 SGMII AUTO-NEGOTIATION CONTROL REGISTER

"After making changes to this register, the changes don’t take effect
until SGMII Auto-Negotiation Advertisement Register is written."

In xpcs_config_aneg_c37_sgmii() we have:

        ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL, mask, val);
        if (ret < 0)
                return ret;

However, MII_ADVERTISE in MDIO_MMD_VEND2 is not written by this
function. If the documentation is correct, then this has no effect
on KS9477, and could be part of the problem.

I notice the SJA1105 doesn't make any similar statement, so I wonder
what the original Synopsys documentation says about the AN control
register.

Note that xpcs_config_aneg_c37_1000basex() does also write this
register, but it is followed by a write to the MII_ADVERTISE
register.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

