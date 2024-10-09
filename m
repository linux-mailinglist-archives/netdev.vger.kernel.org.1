Return-Path: <netdev+bounces-133442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8CB995EC2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 07:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D1C1F25814
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 05:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1B41552F6;
	Wed,  9 Oct 2024 05:02:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB9B12B17C
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 05:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728450171; cv=none; b=Buo/RC7CgXPjsZAAGsoetlKdWNOxog6D0JJHyQerKh2PivCorBClU3FAnF7wtEuGXopffPlZhGU8mN6RrGzQV/PfzRVvWIZ8dzvwnJ0Fh9/aBIAAxII1/ZiWElch1cMx96tNDnf264BLv/dbvM3MIAPUxBaSfRZPDagz2ZVrg88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728450171; c=relaxed/simple;
	bh=3zu6HelztqsSJpcutStF7/py3ojK0Oc7zj4c4ZU/ixc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evlfx3ux59sRTWr7xLCWcMGCpCHLOQx4iyGRa4buNl7ZQQp+cVRxWeD86IW+mL+y5dm5A6Epj1GucvBYkp9Rw9njw4qplS+JRjjIqksx83cnQaLUU93WIiX9jsQ9HRL2xD6rgFDNi7x3RT5/NMY4HT0UO1UgWu0HFJL7U/FSmf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1syOqO-0002A8-7t; Wed, 09 Oct 2024 07:02:40 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1syOqM-000Wlx-AB; Wed, 09 Oct 2024 07:02:38 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1syOqM-002180-0h;
	Wed, 09 Oct 2024 07:02:38 +0200
Date: Wed, 9 Oct 2024 07:02:38 +0200
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
Subject: Re: [PATCH net-next 04/12] net: pse-pd: tps23881: Add support for
 power limit and measurement features
Message-ID: <ZwYOboTdMppaZVmX@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-4-787054f74ed5@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002-feature_poe_port_prio-v1-4-787054f74ed5@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Oct 02, 2024 at 06:28:00PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Expand PSE callbacks to support the newly introduced
> pi_get/set_current_limit() and pi_get_voltage() functions. These callbacks
> allow for power limit configuration in the TPS23881 controller.
> 
> Additionally, the patch includes the detected class, the current power
> delivered and the power limit ranges in the status returned, providing more
> comprehensive PoE status reporting.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

> +static int tps23881_pi_get_class(struct tps23881_priv *priv, int id)
> +{
....
> +	if (chan < 4)
> +		class = ret >> 4;
> +	else
> +		class = ret >> 12;

....
> +tps23881_pi_set_2p_pw_limit(struct tps23881_priv *priv, u8 chan, u8 pol)
> +{
....
> +	reg = TPS23881_REG_2PAIR_POL1 + (chan % 4);
> +	ret = i2c_smbus_read_word_data(client, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (chan < 4)
> +		val = (ret & 0xff00) | pol;
> +	else
> +		val = (ret & 0xff) | (pol << 8);

This is a common pattern in this driver, we read and write two registers
in one run and then calculate bit offset for the channel, can you please
move it in to separate function. This can be done in a separate patch if
you like.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

