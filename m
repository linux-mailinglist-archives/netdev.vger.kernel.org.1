Return-Path: <netdev+bounces-290611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC75GvNuD2oDMQYAu9opvQ
	(envelope-from <netdev+bounces-290611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:45:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE865ABDFA
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3483303D2E1
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7545941C2E0;
	Thu, 21 May 2026 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bM+2N3R8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B34266B9;
	Thu, 21 May 2026 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779396288; cv=none; b=ceHzkL0sojAwHeikVQelXUZC6XRGzEgBe8XhvqUJLJu8sGxHKzuwtA3Znk0B/v3UDxbAOE4shyTJchqE4/QZQz5EMp068l9dk04yYtUqAYy28vzafd1cg0QLtrduGdG4++VnwdQTJkZY4Wm7IDBWdAEwELXeOu5ORdiHtzC9h1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779396288; c=relaxed/simple;
	bh=OlA5x7v3w4cesApMCgG/SXOdF5y72CuHKhGf8Cxh1/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mngz43cqc1DydkF+3iEVhTOSfG+uQKQzNHBnQZuc8OmBArS4yDn8jnfgj2YvjqLcxQi2sXXi9QPyvmr2W8394BjsvEuxVUXnrUP3SjbjK1OjZpr5fo+xNLuufuBacQ9lmmjVqioNbD5IDPbCOi1sNxwre8ynSxyJu4isPUJTqfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bM+2N3R8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aJ8iU6IMKNulzrgZmLI9lV1Gd7xew07/roTL2C/UaAE=; b=bM+2N3R8HohZ5RVxcx+Kkjbzqf
	SincKPPCviHqfwCF0XLdBaGj02NcZENqmnVqslvyN5KHbtQd/9rOEdT81nRl9P/pmZwzGm+WTrp2C
	EQD2YA762buJiFhuVnKG5cYRq2iZAyX+Kb0BUbQ6r2tBasl0krBRjF/JminNLQribS0c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wQAFm-0045Ri-BX; Thu, 21 May 2026 22:44:26 +0200
Date: Thu, 21 May 2026 22:44:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Regus, Ciprian" <Ciprian.Regus@analog.com>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 3/5] net: phy: Add support for the ADIN1140 PHY
Message-ID: <7beea86d-ddf7-4fcc-aaba-3ce897a438f6@lunn.ch>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
 <20260503-adin1140-driver-v1-3-dd043cdd88f0@analog.com>
 <2cfa6680-503a-4c4a-91bc-5f9a4331967d@lunn.ch>
 <1d7f5247b07f44f2a30cfed8f7d3cd6d@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d7f5247b07f44f2a30cfed8f7d3cd6d@analog.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290611-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BCE865ABDFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 08:24:41PM +0000, Regus, Ciprian wrote:
> 
> > > +static int adin1140_phy_read_mmd(struct phy_device *phydev, int
> > devnum,
> > > +				 u16 regnum)
> > > +{
> > > +	struct mii_bus *bus = phydev->mdio.bus;
> > > +	int addr = phydev->mdio.addr;
> > > +
> > > +	return __mdiobus_c45_read(bus, addr, devnum, regnum);
> > > +}
> > > +
> > > +static int adin1140_phy_write_mmd(struct phy_device *phydev, int
> > devnum,
> > > +				  u16 regnum, u16 val)
> > > +{
> > > +	struct mii_bus *bus = phydev->mdio.bus;
> > > +	int addr = phydev->mdio.addr;
> > > +
> > > +	return __mdiobus_c45_write(bus, addr, devnum, regnum, val);
> > > +}
> > 
> > Why do these exist?
> >
> 
> The PHY is always probed over C22. Unless read_mmd()/write_mmd() are defined,
> phylib will default to indirect accesses to MMD devices. The 0xD and 0xE PHY registers
> are not implemented, so those transfers won't have any effect.

In oa_tc6_mdiobus_register() there is the comment:

       /* OPEN Alliance 10BASE-T1x compliance MAC-PHYs will have both C22 and
         * C45 registers space. If the PHY is discovered via C22 bus protocol it
         * assumes it uses C22 protocol and always uses C22 registers indirect
         * access to access C45 registers. This is because, we don't have a
         * clean separation between C22/C45 register space and C22/C45 MDIO bus
         * protocols. Resulting, PHY C45 registers direct access can't be used
         * which can save multiple SPI bus access. To support this feature, PHY
         * drivers can set .read_mmd/.write_mmd in the PHY driver to call
         * .read_c45/.write_c45. Ex: drivers/net/phy/microchip_t1s.c
         */

which is what you are doing.

If this was a DT driven device, you would add:

compatible = "ethernet-phy-ieee802.3-c45";

which would result in the device being probed via C45, and is_c45
would be set true.

Maybe we need to improve the situation here. We know C45 is
implemented, it is part of the standard. So maybe we need to set
is_c45?

In oa_tc6_phy_init() we already have:

tc6->phydev->is_internal = true;

what happens if we add

tc6->phydev->is_c45 = true; ?

Maybe this was discussed already once, when oa_tc6.c? I don't
remember.

	Andrew

