Return-Path: <netdev+bounces-133473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 296849960C6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB58D287B87
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 07:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C6917BB06;
	Wed,  9 Oct 2024 07:25:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860117E918
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458727; cv=none; b=RpyoeBccoBuRjpcJg5fSausX7gZ1/L7nXZtqKuBjAElYum02Qt/JtXjGyR9Eil4zKikGcTXGZ16vtcIvLXYhIjwYsUNzql+vOgVzGw5eRbVmLp3HtsZGOzzkcl9fDbB/sMZiJ8EW61C05JepSZ/VTHax6gy0sr0mC/SYh9m1HVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458727; c=relaxed/simple;
	bh=Ty5eMVVvVY5MCaKiPLxYbiTFsrUClvu/JT4lPiqjxXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvHeNmjXh2O7oOvFDRcY2XsKRBwa7Owl/uTdwi3qLdE+YzWQozYCm9WMkhIY1E7kgrAntj3TLwGyo/YhDFQItKKJIZBbqhDdTh5biHkjIH9y6TXVAr5vdHdK625f/5BKtyqP6e2h5S9M3C2was4BOZY5nuxWpQb5eldHbFcIK5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1syR4J-0002qF-Ra; Wed, 09 Oct 2024 09:25:11 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1syR4I-000YHt-V7; Wed, 09 Oct 2024 09:25:10 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1syR4I-0022uJ-2j;
	Wed, 09 Oct 2024 09:25:10 +0200
Date: Wed, 9 Oct 2024 09:25:10 +0200
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
Subject: Re: [PATCH net-next 12/12] net: pse-pd: tps23881: Add support for
 PSE events and interrupts
Message-ID: <ZwYv1qunWpqhC9IH@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-12-787054f74ed5@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002-feature_poe_port_prio-v1-12-787054f74ed5@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Kory,

On Wed, Oct 02, 2024 at 06:28:08PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Add support for PSE event reporting through interrupts. Set up the newly
> introduced devm_pse_irq_helper helper to register the interrupt. Events are
> reported for over-current and over-temperature conditions.
> 
> This patch also adds support for an OSS GPIO line to turn off all low
> priority ports in case of an over-current event.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

...
> +static int tps23881_irq_handler(int irq, struct pse_irq_data *pid,
> +				unsigned long *dev_mask)
> +{
> +	struct tps23881_priv *priv = (struct tps23881_priv *)pid->data;
> +	struct i2c_client *client = priv->client;
> +	struct pse_err_state *stat;
> +	int ret, i;
> +	u16 val;
> +
> +	*dev_mask = 0;
> +	for (i = 0; i < TPS23881_MAX_CHANS; i++) {
> +		stat = &pid->states[i];
> +		stat->notifs = 0;
> +		stat->errors = 0;
> +	}
> +
> +	ret = i2c_smbus_read_word_data(client, TPS23881_REG_IT);
> +	if (ret < 0)
> +		return PSE_FAILED_RETRY;
> +
> +	val = (u16)ret;
> +	if (val & TPS23881_REG_IT_SUPF) {
> +		ret = i2c_smbus_read_word_data(client, TPS23881_REG_SUPF_EVENT);
> +		if (ret < 0)
> +			return PSE_FAILED_RETRY;
> +
> +		if (ret & TPS23881_REG_TSD) {
> +			for (i = 0; i < TPS23881_MAX_CHANS; i++) {
> +				stat = &pid->states[i];
> +				*dev_mask |= 1 << i;
> +				stat->notifs = PSE_EVENT_OVER_TEMP;
> +				stat->errors = PSE_ERROR_OVER_TEMP;
> +			}
> +		}
> +	}
> +
> +	if (val & (TPS23881_REG_IT_IFAULT | TPS23881_REG_IT_IFAULT << 8)) {
> +		ret = i2c_smbus_read_word_data(client, TPS23881_REG_FAULT);
> +		if (ret < 0)
> +			return PSE_FAILED_RETRY;
> +
> +		val = (u16)(ret & 0xf0f);
> +
> +		/* Power cut detected, shutdown low priority port */
> +		if (val && priv->oss)
> +			tps23881_turn_off_low_prio(priv);

Sorry, this is policy and even not the best one.
The priority concept is related to the power budget, but this
implementation will shutdown all low prios ports only if some
port/channel has over-current event. It means, in case high prio port
has over-current event, it will be not shut down.
 
I'll propose not to add prio support for this chip right now, it will
need more software infrastructure to handle it nearly in similar way as
it is done by pd692x0.
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

