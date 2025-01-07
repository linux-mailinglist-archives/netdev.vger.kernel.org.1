Return-Path: <netdev+bounces-155745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55914A038F4
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 08:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53C41882EBB
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464C71990D8;
	Tue,  7 Jan 2025 07:43:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75462192598
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736235780; cv=none; b=aeqqdN8dRSNhZ+Uuvz4NW7Ba2Fbl+bBdnxIDzWZo0Te4AUnSttMIPHtVx7LfHcwVdHxhwCSGmDwToRg2UTZM2PX+AVwWaUkd4GvglO2+ZDzd+F5ZwBpplNqZcVLMcaCufaf6VrkSWMHlwh3O9CLTGx91jm/j9QqZ4yWClgsSFdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736235780; c=relaxed/simple;
	bh=KV3ZGTzDNn2UZB61kQKhIxTLlaRqgcTPREFnTjHx+fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdpAAqbvoYrbFzlA7IFOCmqfuiWX9J+YL/oq9eftCiWBNAzDcGotOH2+wnDh7YihaZT8oFRFD9H0P2sN5JYIoTO5suEwtuJBAOWxe5bLDAbdFN8RLPLFYh15wrKArzrFijH2nFALDZs8BMqeJxlZcwPaiSLa4Alb2+XzRcqagls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tV4EN-0006ci-Lq; Tue, 07 Jan 2025 08:42:27 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tV4EL-007Inr-0i;
	Tue, 07 Jan 2025 08:42:26 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tV4EL-009SWi-2q;
	Tue, 07 Jan 2025 08:42:25 +0100
Date: Tue, 7 Jan 2025 08:42:25 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
	Woojung Huh <Woojung.Huh@microchip.com>,
	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
	Tim Harvey <tharvey@gateworks.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: microchip: remove
 MICREL_NO_EEE workaround
Message-ID: <Z3za4bKAJWh3HO9u@pengutronix.de>
References: <79f347c6-ac14-475a-8c93-f1a4efc3e15b@gmail.com>
 <329108a3-12d6-4ce4-9b28-b59f107120ba@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <329108a3-12d6-4ce4-9b28-b59f107120ba@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Jan 06, 2025 at 02:23:36PM +0100, Heiner Kallweit wrote:
> The integrated PHY's on all these switch types have the same PHY ID.
> So we can assume that the issue is related to the PHY type, not the
> switch type. After having disabled EEE for this PHY type, we can remove
> the workaround code here.
> 
> Note: On the fast ethernet models listed here the integrated PHY has
>       PHY ID 0x00221550, which is handled by PHY driver
>       "Micrel KSZ87XX Switch". This PHY driver doesn't handle flag
>       MICREL_NO_EEE, therefore setting the flag for these models
>       results in a no-op.

Yes, it feels like no one is using KSZ87XX switches with the kernel DSA
driver.

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 25 -------------------------
>  include/linux/micrel_phy.h             |  1 -
>  2 files changed, 26 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index e3512e324..4871bb1fc 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -3008,31 +3008,6 @@ static u32 ksz_get_phy_flags(struct dsa_switch *ds, int port)
>  		if (!port)
>  			return MICREL_KSZ8_P1_ERRATA;
>  		break;
> -	case KSZ8567_CHIP_ID:
> -		/* KSZ8567R Errata DS80000752C Module 4 */
> -	case KSZ8765_CHIP_ID:
> -	case KSZ8794_CHIP_ID:
> -	case KSZ8795_CHIP_ID:
> -		/* KSZ879x/KSZ877x/KSZ876x Errata DS80000687C Module 2 */
> -	case KSZ9477_CHIP_ID:
> -		/* KSZ9477S Errata DS80000754A Module 4 */
> -	case KSZ9567_CHIP_ID:
> -		/* KSZ9567S Errata DS80000756A Module 4 */
> -	case KSZ9896_CHIP_ID:
> -		/* KSZ9896C Errata DS80000757A Module 3 */
> -	case KSZ9897_CHIP_ID:
> -	case LAN9646_CHIP_ID:
> -		/* KSZ9897R Errata DS80000758C Module 4 */
> -		/* Energy Efficient Ethernet (EEE) feature select must be manually disabled
> -		 *   The EEE feature is enabled by default, but it is not fully
> -		 *   operational. It must be manually disabled through register
> -		 *   controls. If not disabled, the PHY ports can auto-negotiate
> -		 *   to enable EEE, and this feature can cause link drops when
> -		 *   linked to another device supporting EEE.
> -		 *
> -		 * The same item appears in the errata for all switches above.
> -		 */

I have two problems with current patch set:
- dropped documentation, not all switches are officially broken, so
  keeping it documented is important.
- not all KSZ9xxx based switches are officially broken. All 3 port
  switches are not broken but still match against the KSZ9477 PHY
  driver:
  KSZ8563_CHIP_ID - 0x00221631
  KSZ9563_CHIP_ID - 0x00221631
  KSZ9893_CHIP_ID - 0x00221631

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

