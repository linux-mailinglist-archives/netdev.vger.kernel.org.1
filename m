Return-Path: <netdev+bounces-173589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC19A59AF6
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC9037A60CB
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5851822FE06;
	Mon, 10 Mar 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5PrUPAdZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7475226556;
	Mon, 10 Mar 2025 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624081; cv=none; b=VJ5MEVDc4L02jhm/eKTho05mJ2oWjizB0g/fGRlbq4o+yvptevqxtfmH2qjg6EdqO36m5KhdU/mo/QJ1CPZGNCTyaM9VtcFTTfMdFuYGBfLshelvnhbNCfVplZw/XVNIoQgckP8fiIIaHDpZhV9BiYorOts9bsutOYhTe2rYhMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624081; c=relaxed/simple;
	bh=3qlhXKRWcV3eDbgJBPXfytE4P/sTp+0fP5PNXEUWHH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCdenjZwkwp1T54Ij4f/SoHSObPDXmi2zjkJwme2LC4+KtBlSgOzSHvyaQ+slOwK0iejuaFZQ7lEC3UeojgoohzDnzQWPENixNSU7tc5j+WL0AkKi2ElKrbjsINYIoiexpCBmMyNLk2AMQpXaYvMPOu3WSV100bpNlHOkfXAmFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5PrUPAdZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ktpR3ofu0Xg2sEQv4mlgk3i+zQITVOBRg8fqEKRaH84=; b=5PrUPAdZ64I2+I9VQxO02vHHw/
	fU5/26eNoa56mb+dSO1MCzZZ2G7++vvWdmw89g4855Ia2USXU3eziSEXjHFt5weGsl/zUZ7TUzUMb
	DhyPuZnFM43P1ykvpn/e7XuWzTktsYZ7JEOrB/c7QrPgDGkC/KsLz0ULPxkpKHK679Ss=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1trfyQ-0044C9-1a; Mon, 10 Mar 2025 17:27:26 +0100
Date: Mon, 10 Mar 2025 17:27:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sander@svanheule.net,
	markus.stockhausen@gmx.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v9] net: mdio: Add RTL9300 MDIO driver
Message-ID: <017c73d1-621b-4c75-85eb-80f0a98fd304@lunn.ch>
References: <20250309232536.19141-1-chris.packham@alliedtelesis.co.nz>
 <Z85A9_Li_4n9vcEG@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z85A9_Li_4n9vcEG@pidgin.makrotopia.org>

> Using "raw" access to the PHY and thereby bypassing the MDIO
> controller's support for hardware-assisted page access is problematic.
> The MDIO controller also polls all PHYs status in hardware and hence
> be aware of the currently selected page.

It would be simplest to just disable this hardware polling.

> https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/realtek/files-6.6/drivers/net/ethernet/rtl838x_eth.c;h=4b79090696e341ed1e432a7ec5c0f7f92776f0e1;hb=HEAD#l1631

The comment says:

1639                                               Having the MAC link settings automatically
1640  * follow the PHY link status also happens to be the only way to control MAC port status
1641  * in a meaningful way, or at least it's the only way we fully understand, as this is
1642  * what every vendor firmware is doing.

Could you expand on this. How does phylink work on this device, where
it expects to the configuring the MAC? How does this work for a C45
PHY which is Chris's use case?

I think we first need to understand the restrictions with the MAC
configuration before we can decided how this should all work.

	Andrew

