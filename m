Return-Path: <netdev+bounces-116882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFC994BF70
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108F31C25F13
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A80C18EFEB;
	Thu,  8 Aug 2024 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iB42YO84"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4BA18DF6E;
	Thu,  8 Aug 2024 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126313; cv=none; b=Pcq8uMSGsgGAMkOuXP6PQfFdIhJKIikasaS5s5yOUbYjB5T29uofmukHuiqO3HJAh+f3Rqkv4Z+BxTRJH1X7VTlOtnqgOzILbFQsFWkpGjtUuHbX9ScMG5zC17JXQFteowTRvqHapTkew9uuFa2x7ymFgzaoTd6sSq7AyWqaYqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126313; c=relaxed/simple;
	bh=vgXT7m8NH3XZxE/FG7b0Er74vsRoh+dJVgOe3aYqbL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCbzcJP4PIjfBq1AOoAe/I+4pJXm6z1Kv6Ibxe1k3xp+PhhijQ+8s1SdR+dco8e0wAYrGZBgcUkOyUZ3/3dQ/bL085FADt9F4IZRye80NKKMAruMO330BIlFbPmSvAJtAOB3xZBqcTwmd9+dErMtu/BCCAW03292aIlBdGg2XPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iB42YO84; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vmM6B6En+4wgIlMqg7/+TTbOvDNuGuDEOy3rxQ01D1A=; b=iB42YO84SFBbC5y44z3qI9MDTP
	VbI2K0KEbHvDRftgSugK2HxW845rFB9cGe20qmkv0lYaF8bADNtYp7jggUhyaHAePGJAJ60F2pdxr
	FUkF14CUfSC7Z+O9K5LHWhdFmkwEB2sJYLSTQtTBhavhSfEPA4hMmeEw6QYYVyobTtXA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sc3rg-004IGv-6l; Thu, 08 Aug 2024 16:11:40 +0200
Date: Thu, 8 Aug 2024 16:11:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Divya Koppera <Divya.Koppera@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: microchip_t1: Adds support for
 LAN887x phy
Message-ID: <e9fdc9f6-8c89-4c2a-ba38-d927d0a52d78@lunn.ch>
References: <20240808145916.26006-1-Divya.Koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808145916.26006-1-Divya.Koppera@microchip.com>

> +	if (!IS_ENABLED(CONFIG_OF_MDIO)) {
> +		/* Configure default behavior of led to link and activity for any
> +		 * speed
> +		 */
> +		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1,
> +				     LAN887X_COMMON_LED3_LED2,
> +				     LAN887X_COMMON_LED2_MODE_SEL_MASK,
> +				     LAN887X_LED_LINK_ACT_ANY_SPEED);

This is unusual. What has OF_MDIO got to do with LEDs?

Since this is a new driver, you can default the LEDs to anything you
want. You however cannot change the default once merged. Ideally you
will follow up with some patches to add support for controlling the
LEDs via /sys/class/leds.

> +static void lan887x_get_strings(struct phy_device *phydev, u8 *data)
> +{
> +	for (int i = 0; i < ARRAY_SIZE(lan887x_hw_stats); i++) {
> +		strscpy(data + i * ETH_GSTRING_LEN,
> +			lan887x_hw_stats[i].string, ETH_GSTRING_LEN);
> +	}

There has been a general trend of replacing code like this with
ethtool_puts().

	Andrew

