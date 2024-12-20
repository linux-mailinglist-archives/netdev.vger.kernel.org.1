Return-Path: <netdev+bounces-153708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 314B09F94A6
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 15:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C7B188CB7F
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8843217F45;
	Fri, 20 Dec 2024 14:41:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2527217F39
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705664; cv=none; b=Ch+5VRIVsrjW/zFrF6YI7qeVrz5AL2PE/QMo4tWKIjI0sUq/s+jFCiOKCyqN7i9LEvbgHQsQUhqf3mJ3k48dOarfXpN/D9as1x+uTnpifK30noKhb31JXILM/Ep5kTPOZlsRbJFhgPE8f3+F+WXQj9AaykM+51502b8FoE9yvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705664; c=relaxed/simple;
	bh=CtmTRg53dMIFFVduYKe8ZM2QFm/vYNiOF3sv0OqEh10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkJdn274zoQgmSSknekKkvvrB78MFUhxaGLXWu3eTsT0b2f70n7MLt6qefAzYHqBY5YJXfOuAeJFl/GIXuj/2rH33IezU77O+9n0+5CW8buSdQvgqFm3I5swLffgRIBQuTrfuvcp1b7vsQuD38ojpq0E6DzCGpQPLa9k56HJWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tOeBL-0006PK-HG; Fri, 20 Dec 2024 15:40:47 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tOeBI-004OLa-33;
	Fri, 20 Dec 2024 15:40:45 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tOeBJ-00ATIt-1z;
	Fri, 20 Dec 2024 15:40:45 +0100
Date: Fri, 20 Dec 2024 15:40:45 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
	Tim Harvey <tharvey@gateworks.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: phy: micrel: disable EEE on
 KSZ9477-type PHY
Message-ID: <Z2WB7aOs0m4Kamfl@pengutronix.de>
References: <942da603-ec84-4cb8-b452-22b5d8651ec1@gmail.com>
 <77df52d5-a7b9-4a5c-b004-a785750a1291@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <77df52d5-a7b9-4a5c-b004-a785750a1291@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Dec 20, 2024 at 02:51:32PM +0100, Heiner Kallweit wrote:
> On several supported switches the integrated PHY's have buggy EEE.
> On the GBit-capable ones it's always the same type of PHY with PHY ID
> 0x00221631. So we can simplify the erratum handling by simply clearing
> phydev->supported_eee for this PHY type.
> 
> Note: The KSZ9477 PHY driver also covers e.g. the internal PHY of
>       KSZ9563 (ID: 0x00221637), which is unaffected by the EEE issue.
>       Therefore check for the exact PHY ID.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/micrel.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 3ef508840..ece6d026e 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -1522,6 +1522,12 @@ static int ksz9477_get_features(struct phy_device *phydev)
>  	if (ret)
>  		return ret;
>  
> +	/* See KSZ9477 Errata DS80000754C Module 4 */
> +	if (phydev->phy_id == PHY_ID_KSZ9477) {
> +		linkmode_zero(phydev->supported_eee);
> +		return 0;
> +	}

Hm.. with this change, we won't be able to disable EEE. Zeroed
supported_eee will avoid writing to the EEE advertisement register.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

