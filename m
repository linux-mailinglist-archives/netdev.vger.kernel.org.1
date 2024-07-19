Return-Path: <netdev+bounces-112233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06949378B1
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 15:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204841F216FD
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 13:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9DE12CDAE;
	Fri, 19 Jul 2024 13:46:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B22A8288F
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721396814; cv=none; b=C/AXGXBhrTe7/I6i3idbCApw2uGqp1eOsOdnOkxhmxt66ggsSWRm0h86N7RtzrBoALVH55q+Vyza0GhXTwqgO5k/bubO8CmgM6b7ahbJsvRMK7fx4HiPGkGg0D7wOMdNKO5q8X9LyX79BEqsQv0Xiy18vF6pjH9RXiGM9ij7qUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721396814; c=relaxed/simple;
	bh=fOFY67I+3iOtgqYFZ/fQXxWcNS6x/HjDq33a75TjmLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4hQdj/BjR8I/QJ3mqqt+NKI81Mb4ti0PUPHlbPt+EZu64vxcjC59dMNV5cWcSOQujx4kP9hCb4BnPzmIlIkRrzAn+XMmK3C4/t1URZQqLan71YQWa6SgtyQ7WvUeFocmPt1593kjMEuKnIvPVsLmnHH3NDrwvrZlYUwDr/mZv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sUnwZ-00056A-5e; Fri, 19 Jul 2024 15:46:43 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sUnwY-000hAP-8g; Fri, 19 Jul 2024 15:46:42 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sUnwY-005wFu-0X;
	Fri, 19 Jul 2024 15:46:42 +0200
Date: Fri, 19 Jul 2024 15:46:42 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: vtpieter@gmail.com
Cc: devicetree@vger.kernel.org, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: Re: [PATCH 2/4] net: dsa: microchip: ksz8795: add Wake on LAN support
Message-ID: <ZppuQo9sGdYJWgBQ@pengutronix.de>
References: <20240717193725.469192-1-vtpieter@gmail.com>
 <20240717193725.469192-2-vtpieter@gmail.com>
 <20240717193725.469192-3-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240717193725.469192-3-vtpieter@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Pieter,

If I see it correctly, the only difference between KSZ9477 and KSZ8795
code is the register access. Even bit offsets are identical. I do not
think indirect register access is good justification for duplication
this amount of code.

On Wed, Jul 17, 2024 at 09:37:23PM +0200, vtpieter@gmail.com wrote:
>  
> +static int ksz8_ind_read8(struct ksz_device *dev, u8 table, u16 addr, u8 *val)

Will be good to add comment for this function.

....
> +/**
> + * ksz8_handle_wake_reason - Handle wake reason on a specified port.
> + * @dev: The device structure.
> + * @port: The port number.
> + *
> + * This function reads the PME (Power Management Event) status register of a
> + * specified port to determine the wake reason. If there is no wake event, it
> + * returns early. Otherwise, it logs the wake reason which could be due to a
> + * "Magic Packet", "Link Up", or "Energy Detect" event. The PME status register
> + * is then cleared to acknowledge the handling of the wake event; followed by
> + * clearing the global Interrupt Status Register.
> + *
> + * Return: 0 on success, or an error code on failure.
> + */
> +static int ksz8_handle_wake_reason(struct ksz_device *dev, int port)
> +{
> +	u8 pme_status;
> +	int ret;
> +
> +	ret = ksz8_ind_read8(dev, TABLE_PME_PORT(port), REG_IND_PORT_PME_STATUS, &pme_status);
> +	if (ret)
> +		return ret;
> +
> +	if (!pme_status)
> +		return 0;
> +
> +	dev_dbg(dev->dev, "Wake event on port %d due to:%s%s%s\n", port,
> +		pme_status & PME_WOL_MAGICPKT ? " \"Magic Packet\"" : "",
> +		pme_status & PME_WOL_LINKUP ? " \"Link Up\"" : "",
> +		pme_status & PME_WOL_ENERGY ? " \"Energy detect\"" : "");
> +
> +	ret = ksz8_ind_write8(dev, TABLE_PME_PORT(port), REG_IND_PORT_PME_STATUS, pme_status);
> +	if (ret)
> +		return ret;
> +
> +	ksz_read8(dev, REG_INT_STATUS, &pme_status);

Recycling a variable with use case specific name, make the code more
confusing. Use "var" far all or "int_status" for this case.

> +	return ksz_write8(dev, REG_INT_STATUS, pme_status && INT_PME);

"pme_status && INT_PME" will write BIT(0) instead of BIT(4) which should
be written in this case - So, it should be "pme_status & INT_PME".

Instead of ksz_read8(dev, REG_INT_STATUS + ksz_write8, you can use one
ksz_rmw8()

> +}
> +
> +/**
> + * ksz8_get_wol - Get Wake-on-LAN settings for a specified port.
> + * @dev: The device structure.
> + * @port: The port number.
> + * @wol: Pointer to ethtool Wake-on-LAN settings structure.
> + *
> + * This function checks the PME 'wakeup-source' property from the
> + * device tree. If enabled, it sets the supported and active WoL
> + * flags.

This is a bit confusing - this function do not checks devicetree properly.
It only checks if the wakeup_source flag is set. In current code state, it is
set from devicetree properly.

> + */
> +void ksz8_get_wol(struct ksz_device *dev, int port,
> +		  struct ethtool_wolinfo *wol)
> +{
> +	u8 pme_ctrl;
> +	int ret;
> +
> +	if (!dev->wakeup_source)
> +		return;
> +
> +	wol->supported = WAKE_PHY;
> +
> +	/* Check if the current MAC address on this port can be set
> +	 * as global for WAKE_MAGIC support. The result may vary
> +	 * dynamically based on other ports configurations.
> +	 */
> +	if (ksz_is_port_mac_global_usable(dev->ds, port))
> +		wol->supported |= WAKE_MAGIC;
> +
> +	ret = ksz8_ind_read8(dev, TABLE_PME_PORT(port), REG_IND_PORT_PME_CTRL, &pme_ctrl);
> +	if (ret)
> +		return;
> +
> +	if (pme_ctrl & PME_WOL_MAGICPKT)
> +		wol->wolopts |= WAKE_MAGIC;
> +	if (pme_ctrl & (PME_WOL_LINKUP | PME_WOL_ENERGY))
> +		wol->wolopts |= WAKE_PHY;
> +}
> +
> +/**
> + * ksz8_set_wol - Set Wake-on-LAN settings for a specified port.
> + * @dev: The device structure.
> + * @port: The port number.
> + * @wol: Pointer to ethtool Wake-on-LAN settings structure.
> + *
> + * This function configures Wake-on-LAN (WoL) settings for a specified port.
> + * It validates the provided WoL options, checks if PME is enabled via the
> + * switch's device tree property, clears any previous wake reasons,

Same here, the "device tree" related part of comment can bit rot with
time.

> + * and sets the Magic Packet flag in the port's PME control register if
> + * specified.
> + *
> + * Return: 0 on success, or other error codes on failure.
> + */
> +int ksz8_set_wol(struct ksz_device *dev, int port,
> +/**
> + * ksz9477_wol_pre_shutdown - Prepares the switch device for shutdown while

s/ksz9477_wol_pre_shutdown/ksz8_wol_pre_shutdown

> + *                            considering Wake-on-LAN (WoL) settings.
> + * @dev: The switch device structure.
> + * @wol_enabled: Pointer to a boolean which will be set to true if WoL is
> + *               enabled on any port.
> + *
> + * This function prepares the switch device for a safe shutdown while taking
> + * into account the Wake-on-LAN (WoL) settings on the user ports. It updates
> + * the wol_enabled flag accordingly to reflect whether WoL is active on any
> + * port. It also sets the PME output pin enable with the polarity specified
> + * through the device-tree.
> + */
> +void ksz8_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
> +{

> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index b074b4bb0629..61403898c1f4 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -307,6 +307,9 @@ static const struct ksz_dev_ops ksz8_dev_ops = {
>  	.init = ksz8_switch_init,
>  	.exit = ksz8_switch_exit,
>  	.change_mtu = ksz8_change_mtu,
> +	.get_wol = ksz8_get_wol,
> +	.set_wol = ksz8_set_wol,
> +	.wol_pre_shutdown = ksz8_wol_pre_shutdown,

This part will break on KSZ8830 variants. There is no WoL support.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

