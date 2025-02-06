Return-Path: <netdev+bounces-163475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E51A2A5BD
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 11:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A2F3A56A7
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679F8226899;
	Thu,  6 Feb 2025 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uPg2UyKU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3240022540F;
	Thu,  6 Feb 2025 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738837482; cv=none; b=Qr+qL6v0zMg7XSgT88oVQKzZsw5QMUQ2Cdyg9z0ejVsQ5AEmJ0C0maUYaUI83tGvitV8/wzt5/7tKpruzDiUVpetsxHy6MZxqk8ZwZ2WdWFMzaEnRJZXm9m0r86BXwxuY+wv6dJn508ns3d1e5TYfy8xyrlLP9uA5hwyrzqleDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738837482; c=relaxed/simple;
	bh=V2R7f06XbvyAt5iCH3t8bRwSEWxBPWVf0fxAB9GCG/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQ6DAcPt5xqI+AJU9OamtkZTVT2gQ9vqrHPHFocHZDmugpIcl5NIkevXg1blrHuNu97snjoPS5bTWw9tmTYaF8esUxr2Q8mXdjeaxB1T7rJJ2FzgOsJKOX+uqtTjaM03xCRsZSWZ+PQOAfb18KU5Lrpx+4ijNTuMhDembiQ4Iuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uPg2UyKU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iMI7yWLcG9Uq7pXGUKF4gIfihSrRKWMD0664Ni2nOgU=; b=uPg2UyKU8/3KU2OghvDljf5n2j
	fSct2xXHLfauULT7TJ/1smHjAeaqT68BMIW75Gv9XBsIWkWS9H20GzASOSqCEVg/hg2tqEISYruwG
	/Yo/l8x1v6BGRCMPTiNTaXoxtV4XYGUI986lsw0v0OJLQY3z80ZBY9y14BUQyssBEeoPLvxJPD4RL
	aYJppKdKKpBYX8ls7YbYW7yFWh/Jpgj48u4tqvBMwRTd6eT9NtlYto9b+BifR8Ymzt7ZpYv1gmgzG
	JesVU3E6Mj4Ry+dRF4EAf4KAqF+EwITZ3dDwKN8LvWhua7kVZiYJQi7d8liWu6SNli8gl79NGOeRK
	28sU+naA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57546)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tfz3e-0001jE-1g;
	Thu, 06 Feb 2025 10:24:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tfz3d-0003Lm-0K;
	Thu, 06 Feb 2025 10:24:29 +0000
Date: Thu, 6 Feb 2025 10:24:28 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Byungho An <bh74.an@samsung.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: sxgbe: rework EEE handling to use
 PHY negotiation results
Message-ID: <Z6SN3GSwPsh6m8UI@shell.armlinux.org.uk>
References: <20250206075856.3266068-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206075856.3266068-1-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 06, 2025 at 08:58:56AM +0100, Oleksij Rempel wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> The enabling/disabling of EEE in the MAC should happen as a result of
> auto negotiation. So rework sxgbe_eee_adjust() to take the result of
> negotiation into account.

PLS, at least in stmmac terminology, is "phy link status" and there it
is used with a separate timer which prevents LPI mode being entered
near to the link coming up. Given that the method is called
priv->hw->mac->set_eee_pls, and what was being passed to it was the
link status, I think this is the same thing in this driver.

So, I think repurposing this bit to indicate whether EEE has been
negotiated is not correct.

> sxgbe_set_eee() now just stores LTI timer value. Everything else is
> passed to phylib, so it can correctly setup the PHY.

Not sure why you don't use phydev->eee_cfg.lpi_timer which will be
updated correctly - if phy_ethtool_set_eee() reutrns an error, then
priv->tx_lpi_timer will have been updated yet an error will be
returned to userspace. Sure, have priv->tx_lpi_timer, but update
this on link-up.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

