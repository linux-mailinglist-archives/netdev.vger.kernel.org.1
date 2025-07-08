Return-Path: <netdev+bounces-204882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888E7AFC660
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA39D4A7196
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208C02BE7BB;
	Tue,  8 Jul 2025 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vTdbQHaT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B21220F36;
	Tue,  8 Jul 2025 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965128; cv=none; b=mu8PkkvkeBuSUQkfQ32XY9Q4YFPim+l7GZSDa5tCSEmswHiVd1p6YmYbakxUsMFTAF3U12aZ184f4c2JN0xwzzUJzN9e6NS3fCDzsOj1/Er9vs6zqjzDmk1Nux9dAuzU5r47nNo8MNj7bJPYBb+jHA654iK/PWB5+Aopakd3m7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965128; c=relaxed/simple;
	bh=u3lqUz04bP9xeEjrrJCzmY29EtIjVknuse3jww8xv80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7P6NJhlnEcftwI7bEeVMQLNcPGUo5a01WK0U+4JrT2MjtwivFxL4rBsCtlIhkxiSsTgIl+jGso1uuetlXhTugDWpZt32Uq7BPzNFwDhnbQJS7tbG8AbExyJegJH8FjClr2x0pf+tHTh4VU8UU9aTsDow/wR9nqpFzDcIsnX0OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vTdbQHaT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jo4aOPG5cIjFCy/hgtix7MTqkYd2DiMfnnoaHWQr8tk=; b=vTdbQHaT02wpYGcV+yyGS99BlO
	3Dx+HxtUC5czBelbqY4pmms2xpURX/ciYiegflCU8q0hnihZuvgvKAvXTC22FsAE28RIK9zlq3A77
	Vya9jlGuxn4Ho0yl64s9ucEnu0clqjuI2VjegLXbomtDJaZJDtVvNQziFLwvWaxzaTlJG/wUTYZoL
	hnnUysxgQmy6igwDA4tU9WhgAfi/G8qilBrRRF5vRYKj7x1qm9ANBADrKCnuO06nT6HzmEnyNRiMy
	AZugnwqlcaU3EzZfJ0PF9NHh3k4otpoY1jvN7NCMkaC1inWI5NEwZsmlUA1+/5oDjQqb7TbjZlbhH
	nxpxFpMQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50426)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uZ49t-0006JL-1u;
	Tue, 08 Jul 2025 09:58:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uZ49p-0001UP-0m;
	Tue, 08 Jul 2025 09:58:33 +0100
Date: Tue, 8 Jul 2025 09:58:33 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net] net: phy: Don't register LEDs for genphy
Message-ID: <aGzduaQp3hWA5V-i@shell.armlinux.org.uk>
References: <20250707195803.666097-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707195803.666097-1-sean.anderson@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jul 07, 2025 at 03:58:03PM -0400, Sean Anderson wrote:
> If a PHY has no driver, the genphy driver is probed/removed directly in
> phy_attach/detach. If the PHY's ofnode has an "leds" subnode, then the
> LEDs will be (un)registered when probing/removing the genphy driver.

Maybe checking whether the PHY driver supports LEDs would be more
sensible than checking whether it's one of the genphy drivers?

> This could occur if the leds are for a non-generic driver that isn't
> loaded for whatever reason. Synchronously removing the PHY device in
> phy_detach leads to the following deadlock:
> 
> rtnl_lock()
> ndo_close()
>     ...
>     phy_detach()
>         phy_remove()
>             phy_leds_unregister()
>                 led_classdev_unregister()
>                     led_trigger_set()
>                         netdev_trigger_deactivate()
>                             unregister_netdevice_notifier()
>                                 rtnl_lock()
> 
> There is a corresponding deadlock on the open/register side of things
> (and that one is reported by lockdep), but it requires a race while this
> one is deterministic.

Doesn't this deadlock exist irrespective of whether the genphy driver(s)
are being used, and whether or not the PHY driver supports LEDs?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

