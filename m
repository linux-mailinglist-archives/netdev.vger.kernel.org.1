Return-Path: <netdev+bounces-230911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE85BF1A69
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 15:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FEEE4F68FA
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DFE30214F;
	Mon, 20 Oct 2025 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4s8JzE4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C229246768
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967972; cv=none; b=s+7uMejEFXvjRyJIbL5L0ROP2tmaNk2LsrnimfUq1R6CnXO8RTP06NtPc6offzeyAcA5i1+4iKms8n4Nf7euLeA+LaFwr8JFINFHE2rXEn8rCHFfSgmTv8t+ONNfgtQGD/dn/NMZdDLi5cYAgHekbWA5ER71yIRk0XKJoMc80HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967972; c=relaxed/simple;
	bh=KtOvr2CT2ZJfd+Wdd1NhPf0C0AhFoUXbwiHFwdYHSkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBzTAPBgHUToMr+VXVCScewOtrBDmzfi8YeiWAqjOXFONXjhb2Br5fpUIw2/W1pZ7RdmyHLaNPz3QWQN09/kOsYeLkEibl6pu3XnZXPt1cTVXQ5nj6Ac+s3p/DYzmIzBEnK6uX5rTqGKK6pVA1aCaeXZJ+rHcwTFD1P5NytM9Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4s8JzE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4AFC113D0;
	Mon, 20 Oct 2025 13:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760967971;
	bh=KtOvr2CT2ZJfd+Wdd1NhPf0C0AhFoUXbwiHFwdYHSkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4s8JzE4+w9MiKIIMzTbYJec56T4vfL+sBHbkRo0o1iACbS9wjydWznV7ooaim84T
	 AKDL0vLzOM8yb/W4hRv/4WjZeCAr0JofCsF5mRHU4zjF4I/l0bJNjE2kVjtl8XtS1n
	 3c7YLb1hTKZWlKyGRfN1OyyZOkWF2vHmKUfwjPu0oxZJAo6+VicMbOt1NAWBgsvWBp
	 ZLp5eXyYy4Cx+XQAm3JO2PY9EPYAMNzOh8OxVj/UBSIGpUHtbFi0aHaZNm9ZmqdJjY
	 HrtmtrZHWkgXtfIcv63PhDcSgN2qIXNK5DYiKAjxRzN4RZjgMSNUHtBKtI5lj0PdNC
	 /7dkyBEb9Ks3g==
Date: Mon, 20 Oct 2025 14:46:07 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 net-next] net: stmmac: mdio: use phy_find_first to
 simplify stmmac_mdio_register
Message-ID: <aPY9H0zTwhCWTmXK@horms.kernel.org>
References: <20ca4962-9588-40b8-b021-fb349a92e9e5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20ca4962-9588-40b8-b021-fb349a92e9e5@gmail.com>

On Sat, Oct 18, 2025 at 08:48:07PM +0200, Heiner Kallweit wrote:

...

> @@ -668,41 +669,31 @@ int stmmac_mdio_register(struct net_device *ndev)

...

> +	phydev = phy_find_first(new_bus);
> +	if (!phydev || phydev->mdio.addr > max_addr) {

Hi Heiner,

Depending on logic earlier in this function max_addr may be PHY_MAX_ADDR (32).

>  		dev_warn(dev, "No PHY found\n");
>  		err = -ENODEV;
>  		goto no_phy_found;
>  	}
>  
> +	/*
> +	 * If an IRQ was provided to be assigned after
> +	 * the bus probe, do it here.
> +	 */
> +	if (!mdio_bus_data->irqs && mdio_bus_data->probed_phy_irq > 0) {
> +		new_bus->irq[phydev->mdio.addr] = mdio_bus_data->probed_phy_irq;

And new_bus->irq is an array with PHY_MAX_ADDR elements.

So if phydev->mdio.addr and max_addr are both PHY_MAX_ADDR,
then the if condition above my first comment will not be met,
and it seems that the access would irq[] may overflow.

Perhaps this can't occur. But It does seem worth bringing to your attention.

Flagged by Smatch.

> +		phydev->irq = mdio_bus_data->probed_phy_irq;
> +	}
> +
> +	/*
> +	 * If we're going to bind the MAC to this PHY bus, and no PHY number
> +	 * was provided to the MAC, use the one probed here.
> +	 */
> +	if (priv->plat->phy_addr == -1)
> +		priv->plat->phy_addr = phydev->mdio.addr;
> +
> +	phy_attached_info(phydev);
> +
>  bus_register_done:
>  	priv->mii = new_bus;

...

