Return-Path: <netdev+bounces-174919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915D7A614D4
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 16:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A44C17665B
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8126E202963;
	Fri, 14 Mar 2025 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dxKdV02r"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5CE1C878E;
	Fri, 14 Mar 2025 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966002; cv=none; b=Je0TaCo1H+j1ouoouKohQweOUgIcts1cxoe2/XsBXe8+sQA0wSvwopZurUsYvUDVnswtMiERiHzM8EXNHcSdlsTiew4ZG2WPK1WyWRAImYq4iX7Kx3tpdWfbw6EJ/5Lvd/1Ryi3wlrLIkDhNAXg6CPbaEoT/H3opRMdvZIZMvig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966002; c=relaxed/simple;
	bh=n/ZX5jYth2ykBJT1A/3j+S+zp0ZH2eoj4N17f4Q1vlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cb50t6TS0HJ2J5iS6xYEybjIOgDa8av3BGez6qJ1e8FL454DGUBRUZ4AoA7E2GT9yYiqsuoNkoqYQ2Qe6+YsGXn6E0G9YGVtIWGXXc4xVCIu4WFsUPN3GtiVxphbMbVsQSr6u0MW5Rb23OKQvayqIR7J0DOM0uBKWC4xDnb7J9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dxKdV02r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JLucXbicvVl54mzBcNVonvbBRXxVtH+iL2usTqSk+no=; b=dxKdV02rXHfgVSFw7R4z1vXt5E
	qxRShK8xSLKSLnYm3xgPi1lpr+Y93UkG3VTdNNXaMmGJv1KLDhlcL9NvQzjENK/qSOGa+QIwNIAFD
	BOPUlYdwRJImizJrjZb0ZSgRCxTUdl6BR9aoWdGJHp3+uYB/ydewEuPx7k7p1JXDMGYs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tt6vN-005KYR-62; Fri, 14 Mar 2025 16:26:13 +0100
Date: Fri, 14 Mar 2025 16:26:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	sander@svanheule.net, markus.stockhausen@gmx.de,
	daniel@makrotopia.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v11] net: mdio: Add RTL9300 MDIO driver
Message-ID: <bd1d1cb9-a72b-484b-8cfd-7e91179391d2@lunn.ch>
References: <20250313233811.3280255-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313233811.3280255-1-chris.packham@alliedtelesis.co.nz>

> +static int rtl9300_mdiobus_probe_one(struct device *dev, struct rtl9300_mdio_priv *priv,
> +				     struct fwnode_handle *node)
> +{
> +	struct rtl9300_mdio_chan *chan;
> +	struct fwnode_handle *child;
> +	struct mii_bus *bus;
> +	u32 mdio_bus;
> +	int err;
> +
> +	err = fwnode_property_read_u32(node, "reg", &mdio_bus);
> +	if (err)
> +		return err;
> +
> +	/* The MDIO interfaces are either in GPHY (i.e. clause 22) or 10GPHY
> +	 * mode (i.e. clause 45).

I still need more clarification about this. Is this solely about the
polling? Or does an interface in C22 mode go horribly wrong when asked
to do a C45 bus transaction?

> +	bus->name = "Realtek Switch MDIO Bus";
> +	bus->read = rtl9300_mdio_read_c22;
> +	bus->write = rtl9300_mdio_write_c22;
> +	bus->read_c45 = rtl9300_mdio_read_c45;
> +	bus->write_c45 =  rtl9300_mdio_write_c45;

You are providing C45 bus methods, independent of the interface
mode. So when accessing EEE registers in C45 address space, C45 bus
transactions are going to be used, even on an MDIO interface using C22
mode. Does this work? Can you actually do both C22 and C45 bus
transactions independent of the interface mode?

	Andrew

