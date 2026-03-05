Return-Path: <netdev+bounces-264422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIa3NSaWqWkWAgEAu9opvQ
	(envelope-from <netdev+bounces-264422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:41:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F16213AC7
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34E87304B1FE
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799F53A6F09;
	Thu,  5 Mar 2026 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JGqXuBHH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFB2255F52;
	Thu,  5 Mar 2026 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720898; cv=none; b=GFBboWcrNVW0pdmM4UbRWvmvjQ+X17UBK7uVvqJY1vmkQKLRQTuHpRGJt6SQTlXZ2C++sJ5JtX6EtmDe1z1z/v9CbsM+x9DaU+xhZvVtFQOGonu0cHGU4/d5ojJ8WLzZiFNdF1ICxR/5ZiuNNMDiAiYuo64B0MXRjauytZhtGnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720898; c=relaxed/simple;
	bh=yDGQFixdGwIAuZshTQfOrUx1W3Quwwxo//sKNrAOTJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ry+LKNhfGUX1LqOGkBKBUBimiWMIcV9Ses0ER0omZ59KxBNX2KNffI1ZxsshtcjInfEpObNMAfCbMudMYx2+5s1mM3u8775ikDf1cLgr+3q3fA6AcTTwpO4RnUw/DhfChFxxwz1snMjbPUdks3ANL5s4R7b2YYapzibBtdHppUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JGqXuBHH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZVjWw9aHtjTv3+Y0O4eTVRQ9xNnsxDsQ+ZtOU7v5c/g=; b=JGqXuBHHTNoj8pWkBHya0USRvS
	YkLJFGTuQmt228M+UU6aoyoE2miwBjvaOFIb5z4ZxXRtu5RgW3iql3ge14f3TM+SLavDVec/9mNgB
	/FCHOjeTgYsFyh/sWMoGdYYuE5ZA+42GfLxTVU5tXkvxXmGxF+r7bx+ef3Aj9Y20klYS7ZzcWkwK8
	wQEKK8Dr/qnDIm5iAkUYqtW/tzNOJWQzWP8RSeu2CnPD5W7AxoOTf24m5sq6c9DcGRbU5Q3r/Uj/z
	nEbNIQ+/Tb3bTuTAWX4MRo62iYNH7qp/HJ2Bw5mFQDKLIrs+MIBJAWLcHUClJy0FCs1R9s8kaUiDH
	sdJZ60dA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38684)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vy9gR-00000000865-0aK6;
	Thu, 05 Mar 2026 14:28:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vy9gO-000000000WV-1nV6;
	Thu, 05 Mar 2026 14:28:08 +0000
Date: Thu, 5 Mar 2026 14:28:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Conor Dooley <conor@kernel.org>
Cc: Charles Perry <charles.perry@microchip.com>, netdev@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: macb: fix SGMII with inband aneg
 disabled
Message-ID: <aamS-LPZaOfamwQC@shell.armlinux.org.uk>
References: <20260224202854.112813-1-charles.perry@microchip.com>
 <20260224202854.112813-2-charles.perry@microchip.com>
 <20260304-nebulizer-rounding-40fbc81a2ba1@spud>
 <aahI1y0NO9ax/V8J@bby-cbu-swbuild03.eng.microchip.com>
 <20260304-unvented-crinkle-37f0bfd03541@spud>
 <aaht0/XpUCz+58bz@bby-cbu-swbuild03.eng.microchip.com>
 <20260305-backlit-epilogue-62139ae694a6@spud>
 <aamLf63OfJ5RH69v@bby-cbu-swbuild03.eng.microchip.com>
 <20260305-fantasy-useable-40ca04f0266e@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-fantasy-useable-40ca04f0266e@spud>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Queue-Id: D4F16213AC7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	TAGGED_FROM(0.00)[bounces-264422-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.390];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 02:13:24PM +0000, Conor Dooley wrote:
> On Thu, Mar 05, 2026 at 05:56:15AM -0800, Charles Perry wrote:
> > On Thu, Mar 05, 2026 at 09:42:19AM +0000, Conor Dooley wrote:
> > > On Wed, Mar 04, 2026 at 09:37:23AM -0800, Charles Perry wrote:
> > > > On Wed, Mar 04, 2026 at 04:23:30PM +0000, Conor Dooley wrote:
> > > > 
> > > > Are you able to check register 23, bit 13 of your PHY by any chance? Maybe
> > > > with the mdio/mii commands in U-Boot if you have that.
> > > 
> > > "mii read addr 23" returns 0660 for both PHYs in U-Boot.
> > 
> > Oh, I think you fell into a trap of U-Boot's mii command.
> > 
> > The arguments are always in hex even if you dont prepend "0x".
> 
> Eh no, actually I thought that you meant register 0x23. I'm not used to
> register addresses being given in decimal.
> 
> > What "mii read 8 23" did is most likely read register 0x23, masked with
> > 0x1f because clause 22 has only 32 registers. So it read register 0x3 which
> > is the device identifier 2 register: 0x0660.
> > 
> > The exact command should be "mii read 8 0x17", "mii read 9 0x17".
> 
> Both read back 2004

It would would be good to see the content of 0x1b, specifically bit 13.
The PHY supports AN bypass, and I suspect bit 13 is zero, which means
in combination with bit 13 set in 0x17, the PHY must complete the SGMII
exchange with the MAC.

I suggest something like the following in vitesse.c for this PHY:

#define VSC8662_EXT_CON1		0x17
#define VSC8662_EXT_CON_MAC_AN		BIT(13)

#define VSC8662_MAC_AN			0x1b
#define VSC8662_MAC_AN_BYPASS		BIT(13)

static unsigned int vsc8662_inband_caps(struct phy_device *phydev,
					phy_interface_t interface)
{
	if (interface == PHY_INTERFACE_MODE_SGMII)
		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE |
		       LINK_INBAND_BYPASS;

	return 0;
}

static int vsc8662_config_inband(struct phy_device *phydev, unsigned int modes)
{
	bool changed = false;
	u16 mask;
	int ret;

	mask = VSC8662_EXT_CON_MAC_AN;
	ret = phy_modify_changed(phydev, VSC8662_EXT_CON1, mask,
				 modes & (LINK_INBAND_ENABLE |
				 	  LINK_INBAND_BYPASS) ? mask : 0);
	if (ret > 0)
		changed = true;
	else if (ret < 0)
		return ret;

	mask = VSC8662_MAC_AN_BYPASS;
	ret = phy_modify(phydev, VSC8662_MAC_AN, mask,
			 modes & LINK_INBAND_BYPASS ? mask : 0);
	if (ret < 0)
		return ret;

	return genphy_soft_reset(phydev);
}

and the appropriate initialisers in the phy_driver struct.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

