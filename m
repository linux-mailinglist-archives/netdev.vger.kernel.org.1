Return-Path: <netdev+bounces-238946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF9FC618F4
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 18:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 126A94E47F9
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 17:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776CD2F0C6D;
	Sun, 16 Nov 2025 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="afeQBXIe"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF1E207A3A
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763312913; cv=none; b=aGBux1Ur6XaVT9m1JsQnqHZ+7NEhMuDrdOgcyk5LHgu5s4NabEcIirNsBplu3HbyrTtCbYt8rkbzx8tCVnkwsFNSHqMfaokSvOH4gXcqJB3krlPf6EJmhVlBXGzkRwFa0KumZVlLvS3SNO9tZejLzKJfQetOiNXlBNOICFkhiL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763312913; c=relaxed/simple;
	bh=IH4Wd4wwBj4XVtZAszRTJdc4LKSeWQqsPHNwO71S5Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofBHkXnyYvlXjjEJei/hOVAftkNuptWJdQkfRxi6DNpFTn4DEz0axdnVmuShw8TSJPs9JvQU5Yq4soc0cLNLsWqQvRPmCypV6KnjSmT6BFfV8cOStXGR7LIz5tGlzjiDIdmf+V9lSllOg7HNcjBTxNAwMalFOpwTp0XZ0yu8/Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=afeQBXIe; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RtD681wK2A+vgOBzQr53VV8dMi9WiMUCj8nWm+68CZA=; b=afeQBXIe543kMvYOZToB+Dhg1l
	aRw9GXzAy6V4fsYkcNZzUbz9Uec1058AxSIK7NW48QoQ3Fjc6YVDA3hPP+tkFK3X6fcHr3QwawrwX
	H6ATv++Peb+L9CA72zPdM0xGyrE3s8hHo+dIvOMZjp8wOv4j3vYmLgvS7f/M5Y+BtayFAUF5yXL/P
	cZrOgVQR2DfuWqa2grN5Upqrh3L6nj7bKp38/Vt040WMQGCOb1A/lkWK34wvwEzxLroFLxcGdv8xG
	HEWpftLuVfbOo3Gigtwf5IteDx3GueyZ9DYVTK0r4NnfEun+vM/X7rfBsHkqCWKflH3zb9AmwfKN7
	8qHwuQjA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57846)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vKgEk-0000000011M-0CUn;
	Sun, 16 Nov 2025 17:08:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vKgEh-000000000eO-3Rzh;
	Sun, 16 Nov 2025 17:08:23 +0000
Date: Sun, 16 Nov 2025 17:08:23 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Fabio Estevam <festevam@gmail.com>
Cc: kuba@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	manfred.schlaegl@ginzinger.com, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, f.fainelli@gmail.com
Subject: Re: [PATCH net] net: phy: smsc: Skip soft reset when a hardware
 reset GPIO is provided
Message-ID: <aRoFB3MunCS-_Qvl@shell.armlinux.org.uk>
References: <20251116154824.3799310-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116154824.3799310-1-festevam@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Nov 16, 2025 at 12:48:24PM -0300, Fabio Estevam wrote:
> On platforms using the LAN8720 in RMII mode, issuing a soft reset through
> genphy_soft_reset() can temporarily disrupt the PHY output clock (REF_CLK).
> 
> Boards that source ENET_REF_CLK from the LAN8720 are therefore sensitive
> to PHY soft resets, as the MAC receives an unstable or missing RMII clock
> during the transition.
> 
> When a "reset-gpios" property is present, the MDIO core already performs a
> hardware reset using this GPIO before calling the driver's ->reset() hook.
> Issuing an additional soft reset in smsc_phy_reset() is redundant and may
> result in RX CRC/frame errors, packet loss, and general link instability at
> 100 Mbps.
> 
> Change smsc_phy_reset() so that:
> 
> - If reset-gpios is present: rely solely on the hardware reset and skip
> the soft reset.
> - If reset-gpios is absent: fall back to genphy_soft_reset(), preserving
> the existing behavior.
> 
> The soft reset to remove the PHY from power down is kept, as this is
> a requirement mentioned in the LAN8720 datasheet.
> 
> This fixes packet loss observed on i.MX6 platforms using LAN8720 without
> breaking boards that rely on the existing soft reset path.
> 
> Fixes: fc0f7e3317c5 ("net: phy: smsc: reintroduced unconditional soft reset")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/net/phy/smsc.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
> index 48487149c225..3840b658a996 100644
> --- a/drivers/net/phy/smsc.c
> +++ b/drivers/net/phy/smsc.c
> @@ -54,6 +54,7 @@ struct smsc_phy_priv {
>  	unsigned int edpd_mode_set_by_user:1;
>  	unsigned int edpd_max_wait_ms;
>  	bool wol_arp;
> +	bool reset_gpio;
>  };
>  
>  static int smsc_phy_ack_interrupt(struct phy_device *phydev)
> @@ -136,6 +137,7 @@ EXPORT_SYMBOL_GPL(smsc_phy_config_init);
>  
>  static int smsc_phy_reset(struct phy_device *phydev)
>  {
> +	struct smsc_phy_priv *priv = phydev->priv;
>  	int rc = phy_read(phydev, MII_LAN83C185_SPECIAL_MODES);
>  	if (rc < 0)
>  		return rc;
> @@ -147,9 +149,17 @@ static int smsc_phy_reset(struct phy_device *phydev)
>  		/* set "all capable" mode */
>  		rc |= MII_LAN83C185_MODE_ALL;
>  		phy_write(phydev, MII_LAN83C185_SPECIAL_MODES, rc);
> +		/* reset the phy */

This would be a more useful comment here:

		/* The LAN7820 datasheet states that a soft reset causes
		 * the PHY to reconfigure according to the MODE bits in
		 * MII_LAN83C185_SPECIAL_MODES. Thus, a soft reset is
		 * necessary for the above write to take effect.
		 */

Please also insert a blank line prior to the comment to make the code
more readable.

> +		return genphy_soft_reset(phydev);
>  	}
>  
> -	/* reset the phy */
> +	/* If the reset-gpios property exists, hardware reset will be
> +	 * performed by the MDIO core, so do NOT issue a soft reset here.
> +	 */
> +	if (priv->reset_gpio)
> +		return 0;

Have you tried adding a 1ms delay before the soft reset, in case the
hard reset hasn't completed?

As Andrew's feedback states to the thread that we were discussing it
(and now we have a forked discussion which is far from ideal) we
still don't know "why" the PHY is failing, and without knowing why,
we don't know whether someone else will run into the same issue and
end up patching the kernel in a different way (e.g. the network
driver.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

