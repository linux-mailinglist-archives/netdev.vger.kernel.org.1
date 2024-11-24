Return-Path: <netdev+bounces-146943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02AD9D6D45
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 10:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F04B211EB
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 09:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583C918871D;
	Sun, 24 Nov 2024 09:39:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EF71632C7
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732441179; cv=none; b=FyiUfTVtgQvFUwBGJMWzW68m8i8aIsRyXM6BHWUUL/VGorz05u+/7YCNVG3O7DGtA6AJyWDNIb91SH0+YWQB5lMEmuUfSz4rQ428J29cwHRNWoLeuW4013xYgAcaHmsUnaJNvLJXGso9PwyQ0JFdT+Ej7f1OVxSq5s2LVvZVjxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732441179; c=relaxed/simple;
	bh=8kxRd7XhCltL01GOni+S70qJmZTEC+JyuGErQY6dkYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdkM5f0gXDKJpcfWBQTZg28+bMt+B8qmIfYQvfjLHEKoDp1dM6iof1smYBf6bZ3hMETiVgVzflf7gy22RoznV6zfEWPTaJwDOavsF+a5G7n7BGoTgHdTEityY9WPhYzF9msf1HMqvfvma2i5QILYw9WgPw+aK0JsUrUHtmold5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tF95P-0005dS-Jh; Sun, 24 Nov 2024 10:39:23 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tF95O-002NBz-2H;
	Sun, 24 Nov 2024 10:39:22 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tF95O-00CgPK-1q;
	Sun, 24 Nov 2024 10:39:22 +0100
Date: Sun, 24 Nov 2024 10:39:22 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v3 15/27] regulator: core: Resolve supply
 using of_node from regulator_config
Message-ID: <Z0L0SuaRysRxbtNM@pengutronix.de>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
 <20241121-feature_poe_port_prio-v3-15-83299fa6967c@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241121-feature_poe_port_prio-v3-15-83299fa6967c@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Nov 21, 2024 at 03:42:41PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Previously, the regulator core resolved its supply only from the parent
> device or its children, ignoring the of_node specified in the
> regulator_config structure.
> This behavior causes issues in scenarios where multiple regulator devices
> are registered for components described as children of a controller, each
> with their own specific regulator supply.
> 
> For instance, in a PSE controller with multiple PIs (Power Interfaces),
> each PI may have a distinct regulator supply. However, the regulator core
> would incorrectly use the PSE controller node or its first child to look up
> the regulator supply, rather than the node specified by the
> regulator_config->of_node for the PI.
> 
> This update modifies the behavior to prioritize the of_node in
> regulator_config for resolving the supply. This ensures correct resolution
> of the power supply for each device. If no supply is found in the provided
> of_node, the core falls back to searching within the parent device as
> before.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> It is weird that it wasn't seen before, maybe there was not any case
> were it can't find the supply_name from the parent device.
> 
> Changes in v3:
> - New patch
> ---
>  drivers/regulator/core.c | 42 ++++++++++++++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 2948a7eca734..b49f751893b9 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -1936,6 +1936,20 @@ static struct regulator_dev *regulator_lookup_by_name(const char *name)
>  	return dev ? dev_to_rdev(dev) : NULL;
>  }
>  
> +static struct regulator_dev *regulator_dt_lookup(struct device *dev,
> +						 const char *supply)
> +{
> +	struct regulator_dev *r = NULL;
> +
> +	if (dev && dev->of_node) {
> +		r = of_regulator_dev_lookup(dev, supply);
> +		if (PTR_ERR(r) == -ENODEV)
> +			r = NULL;
> +	}
> +
> +	return r;
> +}
...
>  static int regulator_resolve_supply(struct regulator_dev *rdev)
>  {
> -	struct regulator_dev *r;
>  	struct device *dev = rdev->dev.parent;
> +	struct regulator_dev *r = NULL;
>  	struct ww_acquire_ctx ww_ctx;
>  	int ret = 0;
>  
> @@ -2015,7 +2022,18 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
>  	if (rdev->supply)
>  		return 0;
>  
> -	r = regulator_dev_lookup(dev, rdev->supply_name);
> +	/* first do a dt based lookup on the node described in the virtual
> +	 * device.
> +	 */
> +	if (rdev->dev.of_node)

regulator_dt_lookup() is already doing dev.of_node check, this one can
be removed.

> +		r = regulator_dt_lookup(&rdev->dev, rdev->supply_name);
> +
> +	/* If regulator not found use usual search path in the parent
> +	 * device.
> +	 */
> +	if (!r)
> +		r = regulator_dev_lookup(dev, rdev->supply_name);
> +
>  	if (IS_ERR(r)) {
>  		ret = PTR_ERR(r);
>  

With remove dev.of_node check:
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

