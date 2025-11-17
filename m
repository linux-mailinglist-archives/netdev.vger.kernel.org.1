Return-Path: <netdev+bounces-239222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB86C65FDA
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 20:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 9C7E229652
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 19:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649E43126B3;
	Mon, 17 Nov 2025 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bKUUkUxp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD29309F09;
	Mon, 17 Nov 2025 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763408280; cv=none; b=May2N1R/bEppeo+jTotXe73kaF+6UvkQhDdcvPoALV8HX2MXOA41yQMwuYQfM9ssGuXPo+ttNC3MQzoTfpnih0rTazg0B+whvMqCn4ghDiFx3Bm/gEx1BapnlNiaPy9bnvYuCLgqtsXYhnmXrlS3+RTkexOy2YMvI8zGRvq1Bn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763408280; c=relaxed/simple;
	bh=BL6kQAxMiMA7Yro/dmHN9DlWSpOewGHyvVsJZYWLQ8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0h1iwm+MqUc7QZh2R9n5hecv4TK+QgsaHAcgOhQVGumvalPapEdZ2WfbIBt5B7ExOtmh9WHjKlW0u5QbNnRMtnSsMit1XNoi0+FNnEgeXSkYPsffRJ3P9ykD2Gdm3/+DQPMkBrzfhQ3cujXarI2RrHXCOSq4TrO2oi3pO8xxMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bKUUkUxp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aLkH5EkqMFLrYkdoNe8fL9zWn0q42zqbxvQwbRLzdGE=; b=bKUUkUxpKAVE0Iau4lH7xH9i0F
	n/qZXVcCgQM7UX0chIQxz72Izx66+8PYeCpSOYNM91rcs/72bC48R/wfzKwfmj2qCGHD10fE0X3e2
	XUZTtZFQB529WnXPPaSwQFqWFVRd5c5G7+R0p6Z1T3U0NzAt5cv4FrJvsB/Nph0kZPbo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vL52j-00EH4o-6n; Mon, 17 Nov 2025 20:37:41 +0100
Date: Mon, 17 Nov 2025 20:37:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r8169: add support for RTL8127ATF
Message-ID: <c6beb0d4-f65e-4181-80e6-212b0a938a15@lunn.ch>
References: <20251117191657.4106-1-fabio.baltieri@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117191657.4106-1-fabio.baltieri@gmail.com>

> +	if (tp->fiber_mode) {
> +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
> +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_10baseT_Full_BIT);
> +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
> +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_100baseT_Full_BIT);
> +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
> +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_5000baseT_Full_BIT);

An SFP module can support baseT modes, if the SFP module has a PHY
inside it. But it could also be it is a fibre module with a laser and
so uses 100baseFX, 1000baseX, 2500BaseX, etc.

To do this properly, you need to be able to read the SFP EERPOMs
content, to know what sort of SFP module you have plugged in. Then you
can list the correct modes.

	Andrew

