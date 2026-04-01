Return-Path: <netdev+bounces-273959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOZEBwHQzGlFWwYAu9opvQ
	(envelope-from <netdev+bounces-273959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:57:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3FC376613
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 891523003BE1
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC5937DEB0;
	Wed,  1 Apr 2026 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Nh+rKhKR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42137E2E9
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029429; cv=none; b=QjiY3fEitFvYwV2026TzcywogpHxgQSOAQ8LlWk+g87t4Pv8DV56OlYbpdZYRagQhJ16hotdYexN7Kcv1eYgFl0OXncXrq+5jtX6Smoh2ZA6hQOVlWOI90A6xZuaWN5BIspyVUGr8BabQHJfePRnFFwuL4giTS+KX3o4xqZp9XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029429; c=relaxed/simple;
	bh=MGQjG9RG2L1BRwtJNuMG4DkE6vZDy5uaXGG6rrK/Dyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HS7QwX62ISkOcUHRpaa63tDD9u4FfrfFrOaS3gEOrf8xiJEI9ZT62ZafaP9lr7xiqTIRgdE/DvsJ1nF6RnUPT2g/923xaa6sz4bCiM8dvwLCYTCYsFbO0qLPWjbUkuBdNOMU3VUrgUtQpqyS9gZSpEjOW+m2fRxUTiWouNj9WkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Nh+rKhKR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/65kwVupnIGgGUwuTAfYyqPqn9Wa3MzMWivYlBM/6rY=; b=Nh+rKhKRfyJbFl7uiiVnfO+MMd
	L+/aay38GK+K+bqZNkf00koAZ7e4+fnMLOwGuqCzrGw4S8wa/sHPRu1TOUU6APywSeEvKTq0SnkGH
	ou3hFB6Mw58sasiQ+6XmwZhqXMB3wPItW+DnMPxc1ndX+eORW0g/4ASgrgOIS/Wd5Ua4YL0snHIR+
	9QHwwMLO8SevjEtNz9zp0k9frHsYgGgiNbpuzYlwogVOhFh/f9DwfGEBoc/9H6ZLhEWM/5HUlyjgl
	cTdDiL6cz4fe+E2amatXwmrR5kKmnuIXWOv2VDxdiq8Tnc5UPzr61zOSDimOvoHldaQD4vK6MbXf7
	UBdWHPOg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46488)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7qEo-000000002lS-0kjR;
	Wed, 01 Apr 2026 08:43:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7qEi-000000004d6-1RDO;
	Wed, 01 Apr 2026 08:43:36 +0100
Date: Wed, 1 Apr 2026 08:43:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Subject: Re: RFC: phylink: disable PHY autonomous EEE when MAC manages LPI
Message-ID: <aczMqBNesQH-tHx0@shell.armlinux.org.uk>
References: <d86c53213a6328b701b8aabbde5d1c83@tipi-net.de>
 <04ff15af-26be-4278-bc2a-889e7802d271@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ff15af-26be-4278-bc2a-889e7802d271@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	TAGGED_FROM(0.00)[bounces-273959-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.479];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,shell.armlinux.org.uk:mid,armlinux.org.uk:url]
X-Rspamd-Queue-Id: EE3FC376613
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 12:56:08AM +0200, Andrew Lunn wrote:
> On Tue, Mar 31, 2026 at 11:27:20PM +0200, Nicolai Buchwitz wrote:
> > Hi
> > 
> > Some PHYs (e.g. Broadcom BCM54xx "AutogrEEEn") manage EEE LPI
> > autonomously without forwarding LPI signaling to the MAC. This works
> > fine when the MAC doesn't support EEE, but conflicts with MACs that
> > implement their own LPI control via phylink's mac_enable_tx_lpi /
> > mac_disable_tx_lpi.
> > 
> > When the MAC has lpi_capabilities set, the PHY should use Native EEE
> > mode so the MAC can control LPI entry/exit and observe RX LPI
> > transitions.
> > 
> > I'm thinking of a flag on phy_device (similar to mac_managed_pm) that
> > phylink sets when the MAC has lpi_capabilities, and that PHY drivers
> > check in config_init to disable their autonomous EEE mode:
> > 
> >   /* set by phylink when MAC manages LPI */
> >   phydev->mac_managed_lpi = true;
> > 
> >   /* in bcm54xx_config_init: */
> >   if (phydev->mac_managed_lpi)
> >       bcm_phy_modify_exp(phydev, MII_BUF_CNTL0,
> >                          AUTOGREEEN_EN, 0);
> > 
> > This came up while adding EEE support to the Cadence macb driver (used
> > on Raspberry Pi 5 with a BCM54210PE PHY). The PHY's AutogrEEEn mode
> > prevented the MAC from tracking LPI state. As a workaround, the
> > Raspberry Pi tree currently carries a downstream patch that
> > unconditionally disables AutogrEEEn for all BCM54xx PHYs, since both
> > genet and macb now support EEE properly. That's obviously not suitable
> > for upstream where other MACs paired with BCM54xx may not have LPI
> > support.
> > 
> > Does this seem like a reasonable approach, or is there a better way to
> > handle PHY autonomous EEE within phylink?
> 
> You should also think about it from the other direction. What happens
> with the MAC does not indicate it supports EEE, but the PHY has
> autonomous EEE. At some point in the future we are going to want the
> PHY drivers to export API calls so that phylink/phylib can implement
> ethtool set_eee and get_eee using this autonomous EEE.

Indeed - this needs to first be solved in phylib so that non-phylink
drivers can work before adding support to phylink.

> Maybe it makes more sense for Broadcom BCM54xx etc, to implement a
> .set_eee() call which only accepts eee_enable == False, and when
> called so, disables autonomous EEE. .get_eee() can similarly return
> that EEE is disabled. When phylink sees the MAC implements EEE it can
> calll into the PHY driver to turn off autonomous EEE. And we have a
> path to later add support for turning on and fully configuring
> autonomous EEE.

I think the current phylink_ethtool_[sg]et_eee() may eventually need
tweaking - for the case where the MAC eee ops are populated but the
MAC support is disabled for some reason - e.g. the instance doesn't
support EEE but the driver does for other instances.

However, I don't think we can re-use phy_ethtool_set_eee() for this -
even with MAC based EEE, we still call through to phylib's
phy_ethtool_set_eee() which would change the on-PHY EEE support in
ways we wouldn't want. This call remains necessary because of the
requirement to configure the EEE advertisement which happens at phylib
level.

I think we need a separate phylib interface which disables PHY-based
EEE.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

