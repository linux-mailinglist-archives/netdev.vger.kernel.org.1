Return-Path: <netdev+bounces-292912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH3gGyTjGGo0oggAu9opvQ
	(envelope-from <netdev+bounces-292912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:51:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A025FBC6B
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B03030731C0
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40E51DE8BB;
	Fri, 29 May 2026 00:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BXoHHZR8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DDD79CD;
	Fri, 29 May 2026 00:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780015904; cv=none; b=fNSLEvcIUy1g/R9oBcm9JL9mH24L51y0uKFrAXDLSrKIMhHOBDEEeEe9jD3rzfQKqDXZoMIiDAzWxNZkskqTGP+5+MVC02izzVoKpUQsfP1F8sPNjfyVXhAmr0n6/PczHypP0Z6eE8X88hisXgOqRlLXyGZ91MSTUt54QIFt6Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780015904; c=relaxed/simple;
	bh=pqGznRDDc3omJ40yALvmqPIEbnUdvvyzX1TVjROK0FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgQNuA/R8fZB2Lm8/PiirxfCLS0IjrAAY7xCbXUPbQoEYSoLLvYepbleuaoCRsLouZ+dLaw+mtvpvZZ/ZErOYh/TJoIuBcRHWOHk2BmhI6RQBE6vA424SEuQdYz05M1pkKYMvsp8RwB4fzqCf750DD6K3mSVjN2zwEiQxal1EWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BXoHHZR8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+DX002j6ba3TvwnVATaqftlAgb2V/+wJtHCukoyYYic=; b=BXoHHZR8GZpRDIvWXyftKf2mee
	UB59tCgi/7FHpO/ZaiQRO1deCTTJ4ypBOw9r/1cQVPIGjQC6eYJ517NsjDrbAj5K1t194ezqUjNJD
	ixCJECitdp3HLwceryznbQlRI3usOgXVvbL4Dr9dpw9yV38KYnDjUXhU7hXppVjoLL78=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSlRh-004zFF-IJ; Fri, 29 May 2026 02:51:29 +0200
Date: Fri, 29 May 2026 02:51:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, freddy_gu@realsil.com.cn,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v1 1/2] net: phy: realtek: add support for
 RTL8261
Message-ID: <048a1319-f3c6-487f-901b-f303c7d40a1b@lunn.ch>
References: <20260528075226.1054-1-javen_xu@realsil.com.cn>
 <20260528075226.1054-2-javen_xu@realsil.com.cn>
 <d37ead5b1f9549d4903138cc4f70ffd0@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d37ead5b1f9549d4903138cc4f70ffd0@tipi-net.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292912-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[realsil.com.cn,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,makrotopia.org,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C8A025FBC6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > +static int rtl8261x_config_master_slave(struct phy_device *phydev)
> > +{
> > +	u16 val;
> > +	/*
> > +	 * Configure bits 15:14 of MMD 7.0x0020
> > +	 *
> > +	 * Bit 15 (Enable) | Bit 14 (Value) | Mode
> > +	 * ----------------|----------------|-------------
> > +	 *       0         |       0        | Auto (disabled)
> > +	 *       1         |       0        | Force Slave
> > +	 *       1         |       1        | Force Master
> > +	 */
> > +	switch (phydev->master_slave_set) {
> > +	case MASTER_SLAVE_CFG_MASTER_FORCE:
> > +		val = RTL8261X_MS_MASTER;
> > +		break;
> > +	case MASTER_SLAVE_CFG_SLAVE_FORCE:
> > +		val = RTL8261X_MS_SLAVE;
> > +		break;
> > +	case MASTER_SLAVE_CFG_UNKNOWN:
> > +	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
> > +	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
> > +	default:
> > +		val = RTL8261X_MS_AUTO;
> > +		break;
> > +	}
> > +
> > +	return phy_modify_mmd(phydev, MDIO_MMD_AN, RTL8261X_MULTIG_CTRL,
> > +			      RTL8261X_MASTER_SLAVE_MASK, val);
> > +}
> 
> RTL8261X_MULTIG_CTRL is a IEEE-defined register, so it can use
> MDIO_AN_10GBT_CTRL instead.
> Also the define for RTL8261X_MULTIG_CTRL can be dropped.
> 
> While at it I would suggest to add MDIO_AN_10GBT_CTRL_MS_ENABLE (bit 15) and
> MDIO_AN_10GBT_CTRL_MS_VALUE (bit 14) to include/uapi/linux/mdio.h and also
> make use of it.
> RTL8261X_MS_AUTO would become

If this is all just standard 802.3, the function should be added to
phy-c45.c, so it can be used by any PHY driver.

	Andrew

