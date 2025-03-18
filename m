Return-Path: <netdev+bounces-175828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCFFA67A0F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9556D17DACD
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF7721129C;
	Tue, 18 Mar 2025 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D979XOsE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5791AA1E0;
	Tue, 18 Mar 2025 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316556; cv=none; b=P9JWnlR9NJBl6kySxd2+uFH318E5QhqOLE4W2t0ul8sM0LoWd8etjdqP2+hlKJNFL3yo9HTTR9bPm355cfiZDnFkUqtRNcabxaiB5fKKJF73nEFV2bZsMZclUhB5hKcR7fbUMw5k33NqxpTUsT5ts0WxQztliVw6udKdpn8Ct0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316556; c=relaxed/simple;
	bh=eZU9gYGuN3Y4gKdYcCOvFmY5B3wjVHHeA6U6o4ZvcAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pb+ZEYIRbfZFmiKbTqJMVRRhz+XeWFweRYVtLs8TI+jR0NQDqYRKfYrxQLNMIN01EZUuXpj1Wh+Qjyg9dah2OIU7rPvcw6FC2Zvh6or6aujXthxC9EqxKDsDGMKydUgDehW6lJSThox6zZMkle/5R4emg46HmYSFW84GZ5BviBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D979XOsE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ITTy85Zzyi3/4ZaB57dhDljTFH5GWujdDjTRGU99U4A=; b=D979XOsEwAQyulecUBzvoMooKT
	vaSsD/HtPEquC7Ofb5RVCKj2JHPEpg26xO11ir8/6gkoLLnVygmT+9CaoTPA78xdZA5rND8Xi/8WS
	Csczl+BNuS4eoVV7Z3v9wrkk59pyg7ZVxooWZZlM/XQxTgeYlNbJKNf78V+1xN/UnBVg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tua7l-006HqK-P9; Tue, 18 Mar 2025 17:49:05 +0100
Date: Tue, 18 Mar 2025 17:49:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: Increase phy_name
 size
Message-ID: <481268aa-c8e9-4475-bd5c-8d0f82a6652a@lunn.ch>
References: <20250318161702.2982063-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318161702.2982063-1-andriy.shevchenko@linux.intel.com>

>  struct ax88172a_private {
>  	struct mii_bus *mdio;
>  	struct phy_device *phydev;
> -	char phy_name[20];
> +	char phy_name[MII_BUS_ID_SIZE + 5];

Could you explain the + 5?

https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/davicom/dm9051.c#L1156
https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/freescale/fec_main.c#L2454
https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/xilinx/ll_temac.h#L348

The consensus seems to be + 3.

	Andrew

