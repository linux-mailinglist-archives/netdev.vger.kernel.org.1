Return-Path: <netdev+bounces-233653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0C2C16DB1
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 22:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5837A5036E4
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D8A2045B7;
	Tue, 28 Oct 2025 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UkoXnVjP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884DE20C490
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685353; cv=none; b=mYg96eataEZjRVS/fWLl0uwYIy2oqv2WVvWbpETCjvRU8xplI3xRwZRNpxjaeKHLxJy9WqrRsqCcDObpUhT7gBC8JvKnl1VC7I1AGBDpzEIL9cdpMgymtw6wOBJolU7EmDcdG2vPb6JWwq2hFhUgvYg9La6LerItsVjQmBv4C5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685353; c=relaxed/simple;
	bh=+iFR80ysEeRKHtD1GmJmCFbNjoDAvu5Qx8ONv4hvb+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHcWdMC19G1AnemITThL9FmgnPv41TSRysQmGct+N0Uj9su2rIU086fpZnEwtuoCUFCCFyE1HEh6Cg3J7wwcSYR9yV1Lfa4chCZ7g62mNtuchGl7ZuxG+0Y+gKx2lqxev1DVYZm0knvhvPS+WPTySnwoyt0HZmOUjNyJ94SfMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UkoXnVjP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ertbOXw8BIni8C9fJUgLlnJHdYomyEImgQ4O0mNCxRo=; b=UkoXnVjPMVM9mtzMpRQrIgjR7F
	FhTw/8JGK54NN4sM+P+mxhCihmaBL5wl6k7GykDlvNn58O5V5Y3o+jynlnvHLySBrk6eCEt0ydRA1
	kmBSy8dKgidQml9ylkghv/om0h1AsGVEWUVb5rgfpFj5cSvt5oF2Q2BksH9ujF/l3d3Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDqpn-00CKdS-T5; Tue, 28 Oct 2025 22:02:27 +0100
Date: Tue, 28 Oct 2025 22:02:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	pabeni@redhat.com, davem@davemloft.net
Subject: Re: [net-next PATCH 8/8] fbnic: Add phydev representing PMD to
 phylink setup
Message-ID: <6ca8f12d-9413-400d-bfc4-9a6c4a2d8896@lunn.ch>
References: <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
 <176133848870.2245037.4413688703874426341.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176133848870.2245037.4413688703874426341.stgit@ahduyck-xeon-server.home.arpa>

> +/**
> + * fbnic_phylink_connect - Connect phylink structure to IRQ, PHY, and enable it
> + * @fbn: FBNIC Netdev private data struct phylink device attached to
> + *
> + * This function connects the phylink structure to the PHY and IRQ and then
> + * enables it to resuem operations. With this function completed the PHY will

resume

> + * be able to obtain link and notify the netdev of its current state.
> + **/
> +int fbnic_phylink_connect(struct fbnic_net *fbn)
> +{
> +	struct fbnic_dev *fbd = fbn->fbd;
> +	struct phy_device *phydev;
> +	int err;
> +
> +	phydev = phy_find_first(fbd->mii_bus);

phy_find_first() is generally used when you have no idea what address
the PHY is using. It can cause future surprises when additional
devices appear on the bus.

In this case, you know what address the device is on the bus, so
mdiobus_get_phy() would be better.

> +	if (!phydev) {
> +		dev_err(fbd->dev, "No PHY found\n");
> +		return -ENODEV;
> +	}
> +
> +	/* We don't need to poll, the MAC will notify us of events */
> +	phydev->irq = PHY_MAC_INTERRUPT;
> +
> +	phy_attached_info(phydev);
> +
> +	err = phylink_connect_phy(fbn->phylink, phydev);
> +	if (err) {
> +		dev_err(fbd->dev, "Error connecting phy, err: %d\n", err);
> +		return err;
> +	}
> +
> +	err = fbnic_mac_request_irq(fbd);
> +	if (err) {
> +		phylink_disconnect_phy(fbn->phylink);
> +		dev_err(fbd->dev, "Error requesting MAC IRQ, err: %d", err);
> +		return err;
> +	}
> +
> +	phylink_resume(fbn->phylink);

When was is suspended?

	Andrew

