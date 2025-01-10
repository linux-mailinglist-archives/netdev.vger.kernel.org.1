Return-Path: <netdev+bounces-157232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0E1A098FC
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 18:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119A816B600
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 17:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2938F212B15;
	Fri, 10 Jan 2025 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zz5N9mNS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73043205E16;
	Fri, 10 Jan 2025 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736531794; cv=none; b=CU+pmRwO/qJwqaVrmUq43612Q3La9W0gxQ9qFdtEg9vlLjiXH+m1vKsZpox7frSVXjS9+4bdzTslEiBDJ3T3G9lOuvrfKbkHu3/ojbxgSbhYUJg2gJDFs20mQDf5CP367MJC6n+JOs42TWKY9lgDOaUcJZ2FwJV7b1G1teb6U6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736531794; c=relaxed/simple;
	bh=DUbpD/fe1fzj3l8O5fdIW3x+VLqqDCPHIjf5/Ma+P9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byvCZMMVm5rqbaiBON9o7lUp3YWh+PJxfaOEBX3zXj+OCQ4pL7ozLklaBdSNQBS3lceE64cN5RFx+VzqWDgQuC7x+D3w49baw4sZ8Hoda2VMrQkLSNqI5WI3LHupva/fv0GJb229/uYhEMm4eK3s8Pw4RJzl5MxacV1cMf4iZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zz5N9mNS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ki5u+x3R93XBYSeGA0hQJwfgtpIuFLE/aegA6enbsGk=; b=zz5N9mNSfZjZRjeSOOxi76sY9R
	kvGR85XxxIsUwQPDEKQp23Hd9oGNFdsQ/hd+iTbiHIlbDjuIeLzKkd+jCQhUIegDV0hMaIwOcpOtt
	LXTNt7lBcMja9ApgQlshOoMocU5sTP6SO3NbA8y1yFpqEp+uRL1OmKPjvzN2u+FsL56k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tWJFA-003JJw-JC; Fri, 10 Jan 2025 18:56:24 +0100
Date: Fri, 10 Jan 2025 18:56:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: Add support for PHY LEDs on
 88q2xxx
Message-ID: <78af361a-8935-47aa-9114-3cf5c1b8f7dc@lunn.ch>
References: <20250110-marvell-88q2xxx-leds-v1-1-22e7734941c2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110-marvell-88q2xxx-leds-v1-1-22e7734941c2@gmail.com>

> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL			32790
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK		GENMASK(7, 4)
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK	GENMASK(3, 0)
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK		0x0 /* Link established */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_RX_TX	0x1 /* Link established, blink for rx or tx activity */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX		0x4 /* Receive or Transmit activity */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX		0x5 /* Transmit activity */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1	0x7 /* 1000BT1 link established */

Are 2, 3 and 6 defined? It might be nice to include them just for
documentation.

	Andrew

