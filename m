Return-Path: <netdev+bounces-117464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA35994E0A4
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 11:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224021C20E34
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 09:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4522C1A5;
	Sun, 11 Aug 2024 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hgwmgS1e"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E5E2C181;
	Sun, 11 Aug 2024 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723368126; cv=none; b=RgdizhkRVyNjKRZi0WtNO0mXZpkFNXCbXHyEyCQeFwHg234pGNPz+B3dAskZmJt0jv9BYr8iMzCPsnEuQI1LCE2YgVsMvaHr8KuqIkzP+arYXaDpOISOgYPDst+A/fqDxOkpvFDDpyE3LkAqQOiXDarWyLuNSVLaKzmTYlJp990=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723368126; c=relaxed/simple;
	bh=mCXxfb/Q2cP9YWcyvn1Ulh2h6OB4Wm1NDDaTQ0uKdEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VumOhkyHEK6bdAbjHfzajy9L76BKLNc/jSC24uGYDxRqFa+Tlg1CzPOe85xd018Ca70L8faaRUtuTWCSXHc0P/jwpzg062vtng2q41Xu817hWYUAGZ2IEOJC4XLUpyHlRAJoqezv0bIaelh2ge54S65xO7CaYbyLeZZj+StOfHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hgwmgS1e; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k0pYg++oOJhJgzgPtuk5bbLwQataKDqN3jQf2XgdyXw=; b=hgwmgS1e/6pvGQA0dClJlQzoMK
	CAQ4ojL0LtXP+w8lSxEiL2DIP4Vorz4kiBjnLsw2rX/IHhuElws/V99ubt1GF8Eb5L8+r/cZnKekN
	/mwR5wfPbaSoS7wPgKx+axTWRCewI683mSHhOMxf6XksNY6I0kSLmrWXzzn8ZfVbSqmp8gS1d609J
	c/y2QeuKHu2wwQV0RgQgjfBsuEp9DA8gMRM04iL518JKJKFIsSrg/X08WgldtIBH425OIXNKx4EvW
	IJ2aZqnlX9kevTgsey78cFhypqqjpP1GaCHimLh5CqCvNuNxTTX+dkQAVT7xfPV23Eb97qxVeNl6u
	VeiGO1yg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40012)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sd4lh-0000je-1I;
	Sun, 11 Aug 2024 10:21:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sd4lk-0007sY-Ns; Sun, 11 Aug 2024 10:21:44 +0100
Date: Sun, 11 Aug 2024 10:21:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/3] phy: Add Open Alliance helpers for the
 PHY framework
Message-ID: <ZriCqClUc/Yd0uMK@shell.armlinux.org.uk>
References: <20240811052005.1013512-1-o.rempel@pengutronix.de>
 <20240811052005.1013512-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811052005.1013512-2-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Aug 11, 2024 at 07:20:04AM +0200, Oleksij Rempel wrote:
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index 202ed7f450da6..e93dfec881c5d 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_MDIO_DEVRES)	+= mdio_devres.o
>  libphy-$(CONFIG_SWPHY)		+= swphy.o
>  libphy-$(CONFIG_LED_TRIGGER_PHY)	+= phy_led_triggers.o
>  
> +obj-$(CONFIG_OPEN_ALLIANCE_HELPERS) += open_alliance_helpers.o

I was thinking more
libphy-$(CONFIG_OPEN_ALLIANCE_HELPERS) += open_alliance_helpers.o

rather than a potentially separate module.

If it is going to end up a separate module, then it needs its own
MODULE_LICENSE, MODULE_DESCRIPTION, etc.

*** please note that I probably will only be occasionally responsive
*** for an unknown period of time due to recent eye surgery making
*** reading quite difficult.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

