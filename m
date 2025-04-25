Return-Path: <netdev+bounces-185999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83053A9CAC0
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 15:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C2C9E7250
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 13:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C022528E9;
	Fri, 25 Apr 2025 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OGErfmzI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD2253959;
	Fri, 25 Apr 2025 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745588499; cv=none; b=LiDDWbwdQ3JRjFXu90x9jG8P0SllZk8AMmoIGoqYvaoyMNmEMrNF/jjgyg+qhdzfnntYlwfxgioANjdhM5quAtGJBPvcNpjdPoHknjmeykziStrKYD7EbZtr0DdvrtQXBGeBdFvnAaMmo+JlB+lWKYTRvbOfN69qf37plx24Gcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745588499; c=relaxed/simple;
	bh=ht1mxQm7StaZU9VX6o//f8+jOvr5gP96YjgbK0dBp/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrXrHTzuWElgAjOpP1I/UC46F7GvPOsqcTjx55XYD92+tFGVGQXOezyLItPfQc4UaTlhAJd8CMnflPdKa52wOMH8HYVw0+ha7BN44pnRHfY79krGjLVfLXsA7q0tEx1Ggb3lCPYWnK8pAPY6uak7OnqP3LKkd6NCClmcfE3YhBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OGErfmzI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nRYrpKd6NySdJ2yUT1itgw7/LCNnkROzjeOrY6QNoEc=; b=OGErfmzIlFOM94/BmBnIpeJ2U2
	MpoVnGsJPncM2LE5+f2Ss7y8QWhGvbhD0WWYAAQcZK3hUPxjpy1cG5J3P+s/fEqxqzLbCiTG5LUYY
	PaH0qndepwxpMiYUqLqv56h3NSdY2aw8RHF+dKkR5FUg2CfEOLKRFLCxvA8Q9LQY7hxvLngByI95l
	nIUFNHGlv1ATBvg8g8I9ktCVsQhSlzFRjpebh0yvgYzsZy7ak+vJa8YoxAA1xl8eyFxsVeGoUaOoE
	1MOUnZmnx++63fIe2uSfXxkZL/vQbNuSZENFL6sXUyBwCVNG1FckM3IDYR/TM7ZrFBqQgnEdWBINW
	914nt+bA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49774)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u8JIz-0000RZ-0q;
	Fri, 25 Apr 2025 14:41:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u8JIv-0002Ak-1y;
	Fri, 25 Apr 2025 14:41:21 +0100
Date: Fri, 25 Apr 2025 14:41:21 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v2 1/1] net: dsa: microchip: Remove ineffective
 checks from ksz_set_mac_eee()
Message-ID: <aAuRAadDStfwfS1U@shell.armlinux.org.uk>
References: <20250425110845.482652-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425110845.482652-1-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 25, 2025 at 01:08:45PM +0200, Oleksij Rempel wrote:
> KSZ switches handle EEE internally via PHY advertisement and do not
> support MAC-level configuration. The ksz_set_mac_eee() handler previously
> rejected Tx LPI disable and timer changes, but provided no real control.

Err what?

ksz does not set phylink_config->eee_enabled_default, so the default
state in phylink is eee_enabled = false, tx_lpi_enabled = false. It
doesn't set the default LPI timer, so tx_lpi_timer = 0.

As the driver does not implement the ability to change the LPI timer
enable nor the timer value, this seemed reasonable as the values are
not reported (being reported as zeros) and thus prevents modification
thereof.

Why do you want to allow people to change parameters that have no
effect?

> These checks now interfere with userspace attempts to disable EEE and no
> longer reflect the actual hardware behavior. Replace the logic with a
> no-op.

They don't.

ethtool --set-eee eee off

will work, because GEEE will return tx_lpi_enabled = 0 tx_lpi_timer = 0,
and when it attempts to set, it will be validated that these haven't
been changed.

This has been the behaviour of the driver for some time. Why do we want
now to allow userspace to change parameters that don't have any effect?

Did I waste my time doing a careful conversion of DSA drivers to phylink
managed EEE, trying to ensure that there was no change of behaviour. I'm
feeling like I shouldn't have bothered because that careful work is now
being undone by a patch stream that seems not to understand the code...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

