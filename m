Return-Path: <netdev+bounces-237881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA784C511A6
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5449234C181
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DB62F5A05;
	Wed, 12 Nov 2025 08:28:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45308272801
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936086; cv=none; b=dUIOpUaHcP4rjcCu9NP0vHSYIYhaq49oBxDLFnrwH3eMGIrOZPjg2A7miULyGJJT+gGL2NDrxIDglYbLln+70KQhFzhucP1uiW+91uY/4JwIOMV8DRw9IlXMGILmj5o5ntlNWoEFqO+zpcMK7wHH7YHJsGQC//1/wBTYBC5LsEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936086; c=relaxed/simple;
	bh=hEKDfoHAz3HWg9OEPKFxHDA9Sp8BHYLJvQrKnjMLZ64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSPkZefGj8Vm5lyLDvi9oqoqV3nni8ibk5KvDenRb14bfYv9s/d/45rEDLooOStUWj52ezPTTXqzE1ruDVYI9oplU0u52wdOUuiUbd31bCFCMQKb2kXunznqHwQKbLTUa5Odx/EtHgYxuRs7EucoI0LLsL744UcQdX3h19Q/ZT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vJ6Cr-0008J0-WD; Wed, 12 Nov 2025 09:27:58 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vJ6Cr-0003BZ-1m;
	Wed, 12 Nov 2025 09:27:57 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vJ6Cr-00GPqH-1Q;
	Wed, 12 Nov 2025 09:27:57 +0100
Date: Wed, 12 Nov 2025 09:27:57 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/2] net: phy: TI PHYs use
 phy_get_features_no_eee()
Message-ID: <aRRFDUewyw9x7teC@pengutronix.de>
References: <aRMgLmIU1XqLZq4i@shell.armlinux.org.uk>
 <E1vImhv-0000000DrQi-49UR@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E1vImhv-0000000DrQi-49UR@rmk-PC.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Nov 11, 2025 at 11:38:43AM +0000, Russell King (Oracle) wrote:
> As TI Gigabit PHYs do not support EEE, use the newly introduced
> phy_get_features_no_eee() to read the features but mark EEE as
> disabled.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/dp83822.c   | 3 +++
>  drivers/net/phy/dp83867.c   | 1 +
>  drivers/net/phy/dp83869.c   | 1 +
>  drivers/net/phy/dp83tc811.c | 1 +
>  4 files changed, 6 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
> index 33db21251f2e..20caf9a5faa7 100644
> --- a/drivers/net/phy/dp83822.c
> +++ b/drivers/net/phy/dp83822.c
> @@ -1160,6 +1160,7 @@ static int dp83822_led_hw_control_get(struct phy_device *phydev, u8 index,
>  		.name		= (_name),			\
>  		/* PHY_BASIC_FEATURES */			\
>  		.probe          = dp83822_probe,		\
> +		.get_features	= phy_get_features_no_eee,	\
>  		.soft_reset	= dp83822_phy_reset,		\
>  		.config_init	= dp83822_config_init,		\
>  		.read_status	= dp83822_read_status,		\
> @@ -1180,6 +1181,7 @@ static int dp83822_led_hw_control_get(struct phy_device *phydev, u8 index,
>  		.name		= (_name),			\
>  		/* PHY_BASIC_FEATURES */			\
>  		.probe          = dp8382x_probe,		\
> +		.get_features	= phy_get_features_no_eee,	\
>  		.soft_reset	= dp83822_phy_reset,		\
>  		.config_init	= dp83825_config_init,		\
>  		.get_wol = dp83822_get_wol,			\
> @@ -1196,6 +1198,7 @@ static int dp83822_led_hw_control_get(struct phy_device *phydev, u8 index,
>  		.name		= (_name),			\
>  		/* PHY_BASIC_FEATURES */			\
>  		.probe          = dp83826_probe,		\
> +		.get_features	= phy_get_features_no_eee,	\
>  		.soft_reset	= dp83822_phy_reset,		\
>  		.config_init	= dp83826_config_init,		\
>  		.get_wol = dp83822_get_wol,			\

The DP83822/25/26 are all 100 Mbit variants. They all officially claim
EEE support. Maybe it is too early to give up here?

> diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
> index 36a0c1b7f59c..da055ff861be 100644
> --- a/drivers/net/phy/dp83867.c
> +++ b/drivers/net/phy/dp83867.c
> @@ -1124,6 +1124,7 @@ static struct phy_driver dp83867_driver[] = {
>  		/* PHY_GBIT_FEATURES */
>  
>  		.probe          = dp83867_probe,
> +		.get_features	= phy_get_features_no_eee,
>  		.config_init	= dp83867_config_init,
>  		.soft_reset	= dp83867_phy_reset,

ACK

> diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
> index 1f381d7b13ff..4400654b0f72 100644
> --- a/drivers/net/phy/dp83869.c
> +++ b/drivers/net/phy/dp83869.c
> @@ -906,6 +906,7 @@ static int dp83869_phy_reset(struct phy_device *phydev)
>  	PHY_ID_MATCH_MODEL(_id),				\
>  	.name		= (_name),				\
>  	.probe          = dp83869_probe,			\
> +	.get_features	= phy_get_features_no_eee,		\
>  	.config_init	= dp83869_config_init,			\
>  	.soft_reset	= dp83869_phy_reset,			\
>  	.config_intr	= dp83869_config_intr,			\

ACK

> diff --git a/drivers/net/phy/dp83tc811.c b/drivers/net/phy/dp83tc811.c
> index e480c2a07450..92c5f3cfee9e 100644
> --- a/drivers/net/phy/dp83tc811.c
> +++ b/drivers/net/phy/dp83tc811.c
> @@ -390,6 +390,7 @@ static struct phy_driver dp83811_driver[] = {
>  		.phy_id_mask = 0xfffffff0,
>  		.name = "TI DP83TC811",
>  		/* PHY_BASIC_FEATURES */
> +		.get_features = phy_get_features_no_eee,
>  		.config_init = dp83811_config_init,
>  		.config_aneg = dp83811_config_aneg,
>  		.soft_reset = dp83811_phy_reset,

Not sure about this one. It is 100BaseT1 without autoneg support.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

