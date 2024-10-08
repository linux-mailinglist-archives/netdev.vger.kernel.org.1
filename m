Return-Path: <netdev+bounces-133192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFED995461
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6F86B2525C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B7C1E0DBD;
	Tue,  8 Oct 2024 16:26:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372781E0B99
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404809; cv=none; b=kycFTAXuT5H8l3vFb6bMHF4ly4d5WLCO+feeRmgGx4M079MrOlbkccykiN0j/GQ25MloP863fKBiokYroXpUmuI/a6/ATVOm6fJ6cUge0mVRbcAp8oT+2vuG8FztZTG3zSRv5Szm5jlBp/0GzhXaWbWwwnWulWUGS9MYyaVdsHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404809; c=relaxed/simple;
	bh=16jmV6QrV7ugvLP+a5JbgEoIuyzmF2r5BsIMwyFMCnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9m+gzG5gSpMFC+YuOAIFQ8yIQNnb5y3SxxIdq37n9KX0xr8pQNYwZM+Fu4yMFwJ43U9U58zanZBzYS77b4gN7GQf3h68M3M8O6ZE0Ez3LoJJxXc9/B627H1qQNSp8QdGH6AcL94kEYcNbAw9HjaxW+d2DvPQkeLxTGbqHuVu74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1syD2i-0000MN-2d; Tue, 08 Oct 2024 18:26:36 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1syD2g-000PKD-3O; Tue, 08 Oct 2024 18:26:34 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1syD2f-000RzO-3D;
	Tue, 08 Oct 2024 18:26:34 +0200
Date: Tue, 8 Oct 2024 18:26:33 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 09/12] net: pse-pd: tps23881: Add support for
 PSE PI priority feature
Message-ID: <ZwVdOQGzbglxtq5H@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-9-787054f74ed5@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002-feature_poe_port_prio-v1-9-787054f74ed5@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Oct 02, 2024 at 06:28:05PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> This patch extends the PSE callbacks by adding support for the newly
> introduced pi_set_prio() callback, enabling the configuration of PSE PI
> priorities. The current port priority is now also included in the status
> information returned to users.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  drivers/net/pse-pd/tps23881.c | 57 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)

....
> 
>  static const char fw_parity_name[] = "ti/tps23881/tps23881-parity-14.bin";
> @@ -1106,6 +1162,7 @@ static int tps23881_i2c_probe(struct i2c_client *client)
>  	priv->pcdev.dev = dev;
>  	priv->pcdev.types = ETHTOOL_PSE_C33;
>  	priv->pcdev.nr_lines = TPS23881_MAX_CHANS;
> +	priv->pcdev.pis_prio_max = 1;

This controller supports 1 bit and 3 bit prios, it will be good to know
why 1 bit mode is used.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

