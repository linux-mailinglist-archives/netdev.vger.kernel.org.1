Return-Path: <netdev+bounces-285784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPjqMzTT/Wl2jgAAu9opvQ
	(envelope-from <netdev+bounces-285784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:12:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC984F629B
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE40C30610F7
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A22386423;
	Fri,  8 May 2026 12:06:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95474396579
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241961; cv=none; b=hBdrfY8faNI4X/2DKjqAmruKA273AokpLGbqCVi9/EBhug9nZIhdvv8a9yGgrabLl1ljbRh6yh5DzH4VM4gd7d7Ckwwm5tQ17tasWmh8VEFDWRrvEysoUXgy3YgFrUPAJa/ffiIkE0bP+GAUBr5n0BJrpAcCByrA3BCl6VPouYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241961; c=relaxed/simple;
	bh=QrzftYXLbL0+cECZHM3j2ypBnDUXn5l81w1rdX3gvkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaCnbcHPdEXJ0g1M5mHWLDO27abgjsSXLfHdbELFWaf+bSwKsCUHQRWxy+N5nsT2JP1/mXlxaoYGnJFGNLoLaRN8Ghljzs+s5iXpRxSwRi5LshGS2HY6EWlwyj9rVB7zfgTjF82yU752KjGerYLvwVJ3YYuoQAqK1FA4cJf1yyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wLJxW-0002wm-Kb; Fri, 08 May 2026 14:05:34 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wLJxT-00152w-1g;
	Fri, 08 May 2026 14:05:31 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wLJxT-00000008Cd1-3VEK;
	Fri, 08 May 2026 14:05:31 +0200
Date: Fri, 8 May 2026 14:05:31 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Robert Marko <robert.marko@sartura.hr>
Cc: kory.maincent@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Subject: Re: [PATCH net-next 2/2] net: pse-pd: pd692x0: support disabling
 disable ports GPIO
Message-ID: <af3RiyMRM56b3DJM@pengutronix.de>
References: <20260507104720.262641-1-robert.marko@sartura.hr>
 <20260507104720.262641-2-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507104720.262641-2-robert.marko@sartura.hr>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Queue-Id: 2DC984F629B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-285784-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.969];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sartura.hr:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 12:46:55PM +0200, Robert Marko wrote:
> Microchip PSE controllers have a dedicated disable ports input that like it
> name says disables PoE on all ports.
> 
> So lets support parsing that GPIO and using the GPIO flags to set it to
> output high by default and enable PoE on all ports during probe.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/net/pse-pd/pd692x0.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
> index 44cf9f97be67..670656abd16f 100644
> --- a/drivers/net/pse-pd/pd692x0.c
> +++ b/drivers/net/pse-pd/pd692x0.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/firmware.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -1781,6 +1782,7 @@ static int pd692x0_i2c_probe(struct i2c_client *client)
>  	static const char * const regulators[] = { "vdd", "vdda" };
>  	struct pd692x0_msg msg, buf = {0}, zero = {0};
>  	struct device *dev = &client->dev;
> +	struct gpio_desc *disable_ports;
>  	struct pd692x0_msg_ver ver;
>  	struct pd692x0_priv *priv;
>  	struct fw_upload *fwl;
> @@ -1808,6 +1810,11 @@ static int pd692x0_i2c_probe(struct i2c_client *client)
>  	priv->client = client;
>  	i2c_set_clientdata(client, priv);
>  
> +	disable_ports = devm_gpiod_get_optional(dev, "disable-ports", GPIOD_OUT_HIGH);

I guess this signal is active low. Since gpio framework operates with
logical values, more natural would be here to use GPIOD_OUT_LOW to
signal that disable-ports mode is disabled. And in the devicetree use
GPIO_ACTIVE_LOW.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

