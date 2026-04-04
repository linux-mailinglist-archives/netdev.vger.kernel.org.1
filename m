Return-Path: <netdev+bounces-275413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GVwlL+OU0Wn+LQcAu9opvQ
	(envelope-from <netdev+bounces-275413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 00:46:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F0C39CC80
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 00:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C23B300B443
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 22:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947672D4813;
	Sat,  4 Apr 2026 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DoptjQVM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA14123D7FF;
	Sat,  4 Apr 2026 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775342816; cv=none; b=J5YS5PlseMLu2szrTFpXVgnAEh8xDot6/D9Tk6DmUpgKmcjQ3YqjfErxA2FjU4TsXtQbA8k+y/tJEYROhHiXbVx9N+74YX/Etoj2Pg/r3OQ1jErDxLBCeSLKxlRIX/4xNG5IjsEOXp+R6t+8R0iNd7tMbEgVPAtbZUjVRlrkkeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775342816; c=relaxed/simple;
	bh=XthQ66ChwnubGamQ8EE+kR1j70dARl03In5Ry7u7NMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGymzz5SWX5s8Chn7spS/0C9t392aoJ1ZJqZiwNTV95zisxnxj1zmb9yqO3bNIz9OgjVAPT5vXaX60gz1YAvJ0JkZN9Q2OKJZ6g9Hyaz+ROT+sUPbfHb5zBtbPfDFaTDAXtVoHoi2I1pavGgwnXXny7bo57f9xsvlL4XrbFEykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DoptjQVM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3SPIZQbt1rjlFuPNyEuBdVz0wZRPdzpx+qnhlehbbaA=; b=DoptjQVMyD8G/R+ZmU0sh7E6vX
	Ejy1IR5glwp6RJ2qenXyC2w3Qrl8pqra+PSlRT+QbZtvM49uukTS/dFZyCd//O5D/FPSm8GdUYug/
	do6TVqhkGyztLCSdYAy6hiN6DIiVJ4XqfaTn7TgNJaxrHvhBrmVg/H3wNFCY8rKL+7U8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w99lK-00Eoki-0E; Sun, 05 Apr 2026 00:46:42 +0200
Date: Sun, 5 Apr 2026 00:46:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Fabio Baltieri <fabio.baltieri@gmail.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] r8169: implement get_module functions for
 rtl8127atf
Message-ID: <368d3f30-b4af-4548-a4b9-f8e4e4f9a4cb@lunn.ch>
References: <20260404201333.2849-1-fabio.baltieri@gmail.com>
 <4f8310c2-07be-452a-84fa-0ec87d985651@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f8310c2-07be-452a-84fa-0ec87d985651@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275413-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: E1F0C39CC80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 11:55:25PM +0200, Heiner Kallweit wrote:
> On 04.04.2026 22:13, Fabio Baltieri wrote:
> > Implement get_module_info and get_module_eeprom for supported devices,
> > right now that's the rtl8127atf.
> > 
> > This enables using ethtool to retrieve the transceiver identification
> > and diagnostic data.
> > 
> > Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
> > ---
> > 
> > Hi,
> > 
> > Realtek released a new out of tree driver for the rtl8127 and it
> > includes some code that exposes the I2C controller connected to the SFP
> > port.
> > 
> > This patch implements get_module_info and get_module_eeprom based on the
> > information found on that driver, it allows ethtool to fetch the SFP
> > module information, which is useful both to identify the module and to
> > track the health of fiber optic transceivers.
> > 
> > The logic for the SFF standard and i2c address selection is borrowed
> > directly from the aquantia/atlantic driver, I don't have a lot of stuff
> > to test it but I was able to trigger all code paths from a fiber optic
> > transceiver and an SFP cable I have available.
> > 
> 
> Hi Fabio, thanks for the patch. Being able to access the SFP I2C bus is an
> important step towards future phylink/SFP support.
> 
> @Russell/@Andrew
> I'm not really familiar with the phylink and sfp code. And I would like to have
> the functionality being implemented here reusable once we do further steps
> towards phylink support in r8169. So how shall the code be modeled, which
> components are needed?
> - Shall the SFP I2C bus be modeled as a struct i2c_adapter?

Yes, that would be best. Call i2c_add_adapter() to add it to the I2C
core. The SFP code in drivers/net/phy can then make use of it.

> - Shall we (partially?) implement a struct sfp, so that functions like
>   sfp_module_eeprom() can be used (implicitly)?
> 
> I assume this patch includes logic which duplicates what is available in
> phylink/sfp already. I'd a appreciate any hints you can provide.

No. phylink etc will end up populating netdev->sfp_bus, and then
get_module_eeprom_by_page() should then just make the module work in
ethtool.

The interesting bit if gluing it all together, without DT. But
txgbe_phy.c should be something you can copy from.

Does the out of tree driver give access to GPIOs connected to the SFP
cage pins? Ideally you want those as well, for loss of signal,
transmitter disable, knowing when a module has been inserted into the
cage, etc.

And you will need a PCS driver.

But first step is probably to work with the existing Base-T devices
and convert the driver to phylink.

    Andrew

---
pw-bot: cr

