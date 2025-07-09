Return-Path: <netdev+bounces-205446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB0DAFEB89
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B24C37BA94B
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BE32DE216;
	Wed,  9 Jul 2025 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dISpLllP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D692DC330;
	Wed,  9 Jul 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070606; cv=none; b=f8CiCJtXOJvLAUq9XkNSaZf7SxBu/YEP68iXtrDnj+ImMA8ifvBI5Frj9++MKJMTOQmagzKznSxpuSe1TlLvJyuyeeC88bUeQRbdkJKZGZdFT0vEMdJ/ktDFexmu8sm1e2fxn9OizzuYTTYJccJ5MyFEgTn1yjcjdbQq0NX95hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070606; c=relaxed/simple;
	bh=klure5nsstlqcFT6BWRXsm2tknAtBuwY0XSGsloT5Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muBtn9rSeDhdZyH5B62KEgUpsNMTfb49weRWdYdOL6JmZDiCKML+MZgi/O9Net7ZOarp5H9D7CglAwtX2OkcZPDS7+CoFKLZv3JVb68tnjL8tmazy/XUHOLN92hZ52VjvbfSnuRSydmwSkPEw48KYg/JRKsNk48Yd/zK+P5nwT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dISpLllP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DUfqPg7SkaJ+zD6QwoOvTLWq5KJnYpZ8Y4V5jgbX8iw=; b=dISpLllP37DNp5wbtJEMBfvkce
	otCDqwOsf+W4Xbo9SOZzB5xhf5KldBetkjZOG6tW3RUr22UrmYqQtMHMNuTrPvBS4d6YQNJC1zj/Q
	+ugfGXQkZKySl3zU14lkgy1+wGrHJTQzRw8IutuUMTwozDlSB7pySBAAzm8bPB+xQUio=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZVb8-000wxz-8J; Wed, 09 Jul 2025 16:16:34 +0200
Date: Wed, 9 Jul 2025 16:16:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yuiko Oshino <yuiko.oshino@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net v1 1/2] net: phy: microchip: Use genphy_soft_reset()
 to purge stale LPA bits
Message-ID: <a3b54e33-30be-4c05-af87-c7833213bd55@lunn.ch>
References: <20250709130753.3994461-1-o.rempel@pengutronix.de>
 <20250709130753.3994461-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709130753.3994461-2-o.rempel@pengutronix.de>

On Wed, Jul 09, 2025 at 03:07:52PM +0200, Oleksij Rempel wrote:
> Enable .soft_reset for the LAN88xx PHY driver by assigning
> genphy_soft_reset() to ensure that the phylib core performs a proper
> soft reset during reconfiguration.
> 
> Previously, the driver left .soft_reset unimplemented, so calls to
> phy_init_hw() (e.g., from lan88xx_link_change_notify()) did not fully
> reset the PHY. As a result, stale contents in the Link Partner Ability
> (LPA) register could persist, causing the PHY to incorrectly report
> that the link partner advertised autonegotiation even when it did not.
> 
> Using genphy_soft_reset() guarantees a clean reset of the PHY and
> corrects the false autoneg reporting in these scenarios.
> 
> Fixes: ccb989e4d1ef ("net: phy: microchip: Reset LAN88xx PHY to ensure clean link state on LAN7800/7850")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

