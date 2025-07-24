Return-Path: <netdev+bounces-209877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E81ECB1127B
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 22:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00AC189FC89
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 20:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C5F2E7F09;
	Thu, 24 Jul 2025 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sHG06OKO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C970A2EACE9;
	Thu, 24 Jul 2025 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753389683; cv=none; b=LFyMrZ5TR0XJzoPoBbVdtZAKWwGrJmWOtqInLUROWp3BFGrZ6fCDd5M9JYCDNmSETE7/YywnLJW20ZMVrMQWpT4Cm5CxMCChWjd8pLqqXymgXLdPS65sHu5KrZl+HBIznWn4jHB7QlUgs5KF/AxJg64hy0HeZwoXy6BlNvSKEnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753389683; c=relaxed/simple;
	bh=002hO+Ofh1fDKb1Hi0cYPd6jdDlDU3XkH4nuV6x7roc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7afcbybrAvjsOsszbXjk2wlNb5clIO4cbsU2IOyt6q1k+VWGpRBzzVx6g/LTU9vjXukkXtfZ0tepnFdl4j1iHs0Uv9Dqyg8CKNQVmoXbygz/izrD6cuy8RaV3/FzNzle4N8ilQyxHWL0THDwPoMHM1TuWfG6EwvVntpbbQVtsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sHG06OKO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ntE9lN9yf0GZvuBsbVseh5wx5kkbw8cfr+B19cWzWeY=; b=sHG06OKOfBsVyrEmU+Nsng+Quv
	tBmcGwy/9dlkLAnE0OLR+WG/P3fE2N+u18IJXmlJXKTVGMCa6TbzjMSSIKin9tH92vLe5AE4xmjDO
	3Z12V8AiRQXSb+PFCSbLb8LXAtj4kFi2KT/VLnTb6qiEvRLdwpt39HReFhFHUzOJ98ERZ6k9Mck6U
	0drCIiu0ib3uW5gDi1t24+PXbv7Wl1dXpGmaz3kSqi1BmeG2ML8Caw+D+Llf1qumZc2zQLJx/OZv4
	Ee7TFKrN0jqvFPpvSno38IHoLncr1ujJJ3/UYkBeRWc5c9Gh2di9oFKUGPzzHL2h/1Im8/LiV8zQY
	/s5QxXgw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50006)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uf2kZ-0003pM-0T;
	Thu, 24 Jul 2025 21:41:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uf2kW-00013W-0o;
	Thu, 24 Jul 2025 21:41:08 +0100
Date: Thu, 24 Jul 2025 21:41:08 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, o.rempel@pengutronix.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net: phy: micrel: Introduce
 lanphy_modify_page_reg
Message-ID: <aIKaZNI3fo85vw1_@shell.armlinux.org.uk>
References: <20250724200826.2662658-1-horatiu.vultur@microchip.com>
 <20250724200826.2662658-3-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724200826.2662658-3-horatiu.vultur@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 24, 2025 at 10:08:24PM +0200, Horatiu Vultur wrote:
> +static int lanphy_modify_page_reg(struct phy_device *phydev, int page, u16 addr,
> +				  u16 mask, u16 set)
> +{
> +	int new, ret;
> +
> +	ret = lanphy_read_page_reg(phydev, page, addr);
> +	if (ret < 0)
> +		return ret;
> +
> +	new = (ret & ~mask) | set;
> +	if (new == ret)
> +		return 0;
> +
> +	ret = lanphy_write_page_reg(phydev, page, addr, new);

Please implement this more safely. Another user could jump in between
the read and the write and change this same register.

	phy_lock_mdio_bus(phydev);
	__phy_write(phydev, LAN_EXT_PAGE_ACCESS_CONTROL, page);
	__phy_write(phydev, LAN_EXT_PAGE_ACCESS_ADDRESS_DATA, addr);
	__phy_write(phydev, LAN_EXT_PAGE_ACCESS_CONTROL,
		    (page | LAN_EXT_PAGE_ACCESS_CTRL_EP_FUNC));
	ret = __phy_modify_changed(phydev, LAN_EXT_PAGE_ACCESS_ADDRESS_DATA,
				   mask, set);
	if (ret < 0)
		phydev_err(phydev, "Error: phy_modify has returned error %d\n", 
			   ret);

unlock:
	phy_unlock_mdio_bus(phydev);

	return ret;

is all that it'll take (assuming the control/address register doesn't
need to be rewritten.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

