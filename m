Return-Path: <netdev+bounces-213229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD638B242CE
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9F93A4EF5
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27C42D372D;
	Wed, 13 Aug 2025 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xCbx5NrW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22531A9F9D;
	Wed, 13 Aug 2025 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070333; cv=none; b=S5gqE0yWPrWlSrgjOkaAJp97fZcYKFQZUbcWNu87X6K5C2fJQRIQXAgl/1vsgpLTofD1t4PCvayLFNHAtIqjCNjPoQXCMeiMzseP5NR4uJZlpoZjESHOJX+UoSSidA5vux2lDJay8i0lKfSnMgI9ckPr5wnNFVfDBn3D1d/RjjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070333; c=relaxed/simple;
	bh=8TFiyjjHWMVWe2zrBJdQI8A3FRAdD63TfoAGEDxpS3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+HFn/TMtg763sJeurLKEKs1pr4Q6ogdBAZVjymwySghcLFnxeDpLJtpWHV/eoeJXTsFLCnTr0fhFIK8sJDe0i6xTdcZBYXMra7eN0VVjttSp8hOXvOw3kQPSg5RVgQXq63/Nf9i9NhF0nh3g2Vx63IsD/pJU2zIjq06+dh4UWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xCbx5NrW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UmKojZDZL7ufGtnWdffA9YcqovIedVzdLmmyMSurV1g=; b=xCbx5NrWREMNbDTVfB484QysG7
	FfKBif3UJ2qtkv7dEq9cQOHv1iwt1uNOfIWXZVOzyDYYQhgSxI4jzPGOZDU5svMZsU7Z+8S39aZUa
	JsqDmLRgkpBMug1t8fkyLS211VzVm+LMWMbSVbvD2/KJg3mqSUNiWQQ3/1FWySOYE3Zv+pr8SOX9I
	MKRl6U1rtWIRr6gx9DRjM/o6J9K4kG1iNI+NJJD/32785xdivjDVe6z82+swfPTORX3HPoJMhF2Qb
	nql6XdyPTo8QE8xfQbSShrZKxAwU+atzXIuLM+m2w2j0q40KL+u3GA6bRfyHT84dLf5/9sWHK8YVb
	7JXgPI5A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40108)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1um5xk-0006Bl-3C;
	Wed, 13 Aug 2025 08:31:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1um5xg-0005ZV-1N;
	Wed, 13 Aug 2025 08:31:52 +0100
Date: Wed, 13 Aug 2025 08:31:52 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, o.rempel@pengutronix.de,
	alok.a.tiwari@oracle.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] net: phy: micrel: Introduce
 lanphy_modify_page_reg
Message-ID: <aJw_aMhqa4M9Jy1j@shell.armlinux.org.uk>
References: <20250813063044.421661-1-horatiu.vultur@microchip.com>
 <20250813063044.421661-2-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813063044.421661-2-horatiu.vultur@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 13, 2025 at 08:30:42AM +0200, Horatiu Vultur wrote:
> +static int lanphy_modify_page_reg(struct phy_device *phydev, int page, u16 addr,
> +				  u16 mask, u16 set)
> +{
> +	int ret;
> +
> +	phy_lock_mdio_bus(phydev);
> +	__phy_write(phydev, LAN_EXT_PAGE_ACCESS_CONTROL, page);
> +	__phy_write(phydev, LAN_EXT_PAGE_ACCESS_ADDRESS_DATA, addr);
> +	__phy_write(phydev, LAN_EXT_PAGE_ACCESS_CONTROL,
> +		    (page | LAN_EXT_PAGE_ACCESS_CTRL_EP_FUNC));
> +	ret = __phy_modify_changed(phydev, LAN_EXT_PAGE_ACCESS_ADDRESS_DATA,
> +				   mask, set);
> +	if (ret < 0)
> +		phydev_err(phydev, "Error: __phy_modify_changed has returned error %d\n",
> +			   ret);

Error: is not necessary, we have log levels.

What would be useful is to print the readable version of the error, and
it probably makes sense to do it outside of the bus lock.

> +
> +	phy_unlock_mdio_bus(phydev);

	if (ret < 0)
		phydev_err(phydev, "__phy_modify_changed() failed: %pe\n",
			   ERR_PTR(ret));

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

