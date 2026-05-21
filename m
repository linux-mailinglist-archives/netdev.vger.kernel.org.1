Return-Path: <netdev+bounces-290483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGe3EHkfD2p2GAYAu9opvQ
	(envelope-from <netdev+bounces-290483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:06:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B36D55A7E96
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5A2232F946F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E617C3E5A0B;
	Thu, 21 May 2026 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B3R/VDvG"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199B3E5ECF
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372436; cv=none; b=t4fEAdlVo/s49MdhsQPpjYKSFmQnljPDwpKGOH9hT75psPsbo+V/PzOqSjADrqnnO0iLJMZbrIGm4mgpWGTyhQJsU9N20YEwJgamNqXePvMUw8DjHnnrhmwXc9SrLI7kWHzzzTIAWN+BVAFs5xTgJDqKX/dKttcP32m51i1MtMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372436; c=relaxed/simple;
	bh=3wcma+CYANg6pRxfXPDCkFSD2scL1M4CzqEWqkmAytA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AX/DSIeiCSZdXMbNNTd5CVdp0PdB52J8/bIYtEsSQlsDVCGxjXSAWzhCo0E8wsls3g2gJxbj9NJtqop2CoAKG/mS0GG5gv3ceCvPd53UHM4UXf9l36O8X0cSMusIoGbFqwjyAz0PiB9jhgYH73jekHuP41q+WgWR+Bs/2qPRUT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B3R/VDvG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 66DD71A364F;
	Thu, 21 May 2026 14:07:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 22B3A60495;
	Thu, 21 May 2026 14:07:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F661107E8BA9;
	Thu, 21 May 2026 16:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779372430; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=YY5/UthRyy4kFw/w3iv+VtM6z32YZ3PoyOhxwTW4sYQ=;
	b=B3R/VDvGPSoIhK3GydoxNc2xvNYDNtCuER/ObYepv5o8sTNuqhVSj52qZXauj4j3amlWox
	S1L5/W/UPpxXeffHFxIMBD6WZCbqaUZvjkGbZa4vstNF6CPx2T6dppsTCstzjpZrmYCDgK
	dMfSPpgkOBzEp1hE7pZIdV6iP+c4+VkdM1Tk+JqgM4k3wHLCr1+OaF+TKUCv9SJ/3Y1mJ6
	LljLNv42TjtHzAR2Xq4TTdvgB7VPrBZLqi088yLr6EZHpp0BJD7/J8q9I2LyczELpqhsoD
	OUPjuSt1UxiRE8wkRXgx/n2Ea973U9+c6JH5DO3yDU209VTbJorCkjBk0nsDrQ==
Message-ID: <e67882fc-5321-4fba-adb9-c1acae55ca3e@bootlin.com>
Date: Thu, 21 May 2026 16:07:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] net: dsa: mxl862xx: move phylink stubs to
 mxl862xx-phylink.c
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <cover.1779330653.git.daniel@makrotopia.org>
 <8e31ea20fa8a7650176ce4c9c1603ee34571eeb5.1779330653.git.daniel@makrotopia.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <8e31ea20fa8a7650176ce4c9c1603ee34571eeb5.1779330653.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290483-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,phrozen.org:email,makrotopia.org:email]
X-Rspamd-Queue-Id: B36D55A7E96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Daniel,

On 5/21/26 04:40, Daniel Golle wrote:
> Move the phylink MAC operations and get_caps callback from mxl862xx.c
> into a dedicated mxl862xx-phylink.c file. This prepares for the SerDes
> PCS implementation which adds substantial phylink/PCS code -- keeping
> it in a separate file avoids function-position churn in the main
> driver file.
> 
> No functional change.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> v2: no changes
> 
>   drivers/net/dsa/mxl862xx/Makefile           |  2 +-
>   drivers/net/dsa/mxl862xx/mxl862xx-phylink.c | 51 +++++++++++++++++++++
>   drivers/net/dsa/mxl862xx/mxl862xx-phylink.h | 14 ++++++
>   drivers/net/dsa/mxl862xx/mxl862xx.c         | 38 +--------------
>   4 files changed, 67 insertions(+), 38 deletions(-)
>   create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
>   create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-phylink.h
> 
> diff --git a/drivers/net/dsa/mxl862xx/Makefile b/drivers/net/dsa/mxl862xx/Makefile
> index d23dd3cd511d..a7be0e6669df 100644
> --- a/drivers/net/dsa/mxl862xx/Makefile
> +++ b/drivers/net/dsa/mxl862xx/Makefile
> @@ -1,3 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_NET_DSA_MXL862) += mxl862xx_dsa.o
> -mxl862xx_dsa-y := mxl862xx.o mxl862xx-host.o
> +mxl862xx_dsa-y := mxl862xx.o mxl862xx-host.o mxl862xx-phylink.o
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
> new file mode 100644
> index 000000000000..f17c429d1f1d
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Phylink and PCS support for MaxLinear MxL862xx switch family
> + *
> + * Copyright (C) 2024 MaxLinear Inc.
> + * Copyright (C) 2025 John Crispin <john@phrozen.org>
> + * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
> + */
> +
> +#include <linux/phylink.h>
> +#include <net/dsa.h>
> +
> +#include "mxl862xx.h"
> +#include "mxl862xx-phylink.h"
> +
> +void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
> +			       struct phylink_config *config)
> +{
> +	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_10 |
> +				   MAC_100 | MAC_1000 | MAC_2500FD;
> +
> +	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +		  config->supported_interfaces);
> +}
> +
> +static void mxl862xx_phylink_mac_config(struct phylink_config *config,
> +					unsigned int mode,
> +					const struct phylink_link_state *state)
> +{
> +}
> +
> +static void mxl862xx_phylink_mac_link_down(struct phylink_config *config,
> +					   unsigned int mode,
> +					   phy_interface_t interface)
> +{
> +}
> +
> +static void mxl862xx_phylink_mac_link_up(struct phylink_config *config,
> +					 struct phy_device *phydev,
> +					 unsigned int mode,
> +					 phy_interface_t interface,
> +					 int speed, int duplex,
> +					 bool tx_pause, bool rx_pause)
> +{
> +}
> +
> +const struct phylink_mac_ops mxl862xx_phylink_mac_ops = {
> +	.mac_config = mxl862xx_phylink_mac_config,
> +	.mac_link_down = mxl862xx_phylink_mac_link_down,
> +	.mac_link_up = mxl862xx_phylink_mac_link_up,
> +};
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.h b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.h
> new file mode 100644
> index 000000000000..c3d5215bdf60
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef __MXL862XX_PHYLINK_H
> +#define __MXL862XX_PHYLINK_H
> +
> +#include <linux/phylink.h>
> +
> +#include "mxl862xx.h"
> +
> +extern const struct phylink_mac_ops mxl862xx_phylink_mac_ops;
> +void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
> +			       struct phylink_config *config);
> +
> +#endif /* __MXL862XX_PHYLINK_H */
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index 2f22adedfbf6..a193f3c07d35 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
> @@ -22,6 +22,7 @@
>   #include "mxl862xx-api.h"
>   #include "mxl862xx-cmd.h"
>   #include "mxl862xx-host.h"
> +#include "mxl862xx-phylink.h"
>   
>   #define MXL862XX_API_WRITE(dev, cmd, data) \
>   	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), false, false)
> @@ -1424,16 +1425,6 @@ static void mxl862xx_port_teardown(struct dsa_switch *ds, int port)
>   	priv->ports[port].setup_done = false;
>   }
>   
> -static void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
> -				      struct phylink_config *config)
> -{
> -	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_10 |
> -				   MAC_100 | MAC_1000 | MAC_2500FD;
> -
> -	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> -		  config->supported_interfaces);
> -}
> -
>   static int mxl862xx_get_fid(struct dsa_switch *ds, struct dsa_db db)
>   {
>   	struct mxl862xx_priv *priv = ds->priv;
> @@ -2099,33 +2090,6 @@ static const struct dsa_switch_ops mxl862xx_switch_ops = {
>   	.get_stats64 = mxl862xx_get_stats64,
>   };
>   
> -static void mxl862xx_phylink_mac_config(struct phylink_config *config,
> -					unsigned int mode,
> -					const struct phylink_link_state *state)
> -{
> -}
> -
> -static void mxl862xx_phylink_mac_link_down(struct phylink_config *config,
> -					   unsigned int mode,
> -					   phy_interface_t interface)
> -{
> -}
> -
> -static void mxl862xx_phylink_mac_link_up(struct phylink_config *config,
> -					 struct phy_device *phydev,
> -					 unsigned int mode,
> -					 phy_interface_t interface,
> -					 int speed, int duplex,
> -					 bool tx_pause, bool rx_pause)
> -{
> -}
> -
> -static const struct phylink_mac_ops mxl862xx_phylink_mac_ops = {
> -	.mac_config = mxl862xx_phylink_mac_config,
> -	.mac_link_down = mxl862xx_phylink_mac_link_down,
> -	.mac_link_up = mxl862xx_phylink_mac_link_up,
> -};
> -
>   static int mxl862xx_probe(struct mdio_device *mdiodev)
>   {
>   	struct device *dev = &mdiodev->dev;


