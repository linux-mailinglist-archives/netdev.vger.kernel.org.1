Return-Path: <netdev+bounces-271140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKOzHWC1wmlilAQAu9opvQ
	(envelope-from <netdev+bounces-271140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:01:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D77318862
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29FE9304AC47
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A63129ACC6;
	Tue, 24 Mar 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0zYawFEG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F529321445
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367405; cv=none; b=cLYzDdTl87ZwtATeBzuKw/bdKWv9eVOnovtxUZ/X+03ct6nCduvoYyFwlVclgE9p00JxVyI84jJy9UxppE1YLSTvJ4UHjlj75+DpjHncC/a/HmCOYkh3v95Yqa/WM2wjpd31gxFtmWYOW9nmN3y1Go0onEf5xEd9cM7cOGRnEEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367405; c=relaxed/simple;
	bh=u3uBXs6rew673hS8QjZk75dW8hk23AyK/uwKvDUuFG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQrxA+N5IkCkTfY3B48kYTOlhXkv8X8xZQ7acpXVUK1ARtY/P6SDRzaxRpLi/z9ALIvTcBTO8qOx1ARayWhdjdDT6pSVkpgqYIZWjMGUMckm6gVjvOdJqhvNKdkGPFu/RVZZjRkB+G7gzOvk6fIxWrTcBCM5NvQnfPB4FZYUAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0zYawFEG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5OIx7qtkX0Y/a+3JqOgO8rsh5CkLcodagqGo7km/m68=; b=0zYawFEGMft13BNErFUlxWyors
	ABwumiqcCj8yGr9m4ozWD3TRkQyjcmDK9h0dkUe1k8z4VGzZAKvYuYr9Ll+55Z2LIrC7S99kSa9/T
	qXnrrQPhCWmaTYm8R65wP/AoLvrJ6taFY/RKBxKMq8FE0/wC9mbaUCVfX7iAdlBAcINWllFUNp1H8
	UBafEAbsbEX+jhAK2XivJmUp0/jbJ8ygCB3ZPLj0KppC2I33ZFVqQ/y7hQatD1cBC2+OzOT8b8W8u
	LENXgbsUKFjbGpcKw2/1RkN+G7KA/7r9c+hklJG0p7HbWadha0Ig58moo+WFr0Iu12H10EtyaJRQv
	6tDgS33w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53102)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w5411-000000002HG-3BMP;
	Tue, 24 Mar 2026 15:49:59 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w540z-000000005BM-3UGS;
	Tue, 24 Mar 2026 15:49:57 +0000
Date: Tue, 24 Mar 2026 15:49:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Wagner <wagner.daniel.t@gmail.com>
Cc: netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next] net: phy: bcm84881: add BCM84891/BCM84892
 support
Message-ID: <acKypS845fm_GB0o@shell.armlinux.org.uk>
References: <20260324152503.1522071-2-wagner.daniel.t@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324152503.1522071-2-wagner.daniel.t@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271140-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,lunn.ch,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	NEURAL_SPAM(0.00)[0.031];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78D77318862
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 03:25:04PM +0000, Daniel Wagner wrote:
> +static bool bcm84881_is_bcm8489x(struct phy_device *phydev)
> +{
> +	/* For C45 PHYs, phydev->phy_id is 0; match via the driver entry's
> +	 * declared ID, which is what phy_bus_match() used to bind us.
> +	 */
> +	u32 id = phydev->drv->phy_id;
> +
> +	return (id & 0xfffffff0) == 0x35905080 ||
> +	       (id & 0xfffffff0) == 0x359050a0;

With the .phy_id's fixed (dropping the revision field) you can simply
test phydev->drv->phy_id here. Alternatively, consider using
phy_id_compare_model().

> +}
> +
>  static void bcm84881_fill_possible_interfaces(struct phy_device *phydev)
>  {
>  	unsigned long *possible = phydev->possible_interfaces;
> @@ -42,10 +57,22 @@ static int bcm84881_config_init(struct phy_device *phydev)
>  {
>  	bcm84881_fill_possible_interfaces(phydev);
>  
> +	if (bcm84881_is_bcm8489x(phydev)) {
> +		__set_bit(PHY_INTERFACE_MODE_USXGMII,
> +			  phydev->possible_interfaces);
> +		/* Bootloader may have left the speed LED on, and
> +		 * link_change_notify won't fire for ports with no cable.
> +		 * Clear both color bits (green ignores the gate register).
> +		 */
> +		phy_clear_bits_mmd(phydev, MDIO_MMD_PMAPMD,
> +				   BCM8489X_LED_COLOR, 0x0012);
> +	}
> +
>  	switch (phydev->interface) {
>  	case PHY_INTERFACE_MODE_SGMII:
>  	case PHY_INTERFACE_MODE_2500BASEX:
>  	case PHY_INTERFACE_MODE_10GBASER:
> +	case PHY_INTERFACE_MODE_USXGMII:

This also allows USXGMII for BCM84881, which it doesn't support. This is
wrong. Does the bcm8489x support these other modes? If not, this is more
wrong - it should be a separate function - bcm8489x_config_init().

>  		break;
>  	default:
>  		return -ENODEV;
> @@ -96,6 +123,17 @@ static int bcm84881_config_aneg(struct phy_device *phydev)
>  	if (ret)
>  		return ret;
>  
> +	/* BCM84891/92 firmware has been observed setting MDIO_CTRL1_LPOWER
> +	 * autonomously (e.g. during SerDes reconfiguration). Clear it so AN
> +	 * can proceed.
> +	 */
> +	if (bcm84881_is_bcm8489x(phydev)) {
> +		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1,
> +					 MDIO_CTRL1_LPOWER);
> +		if (ret < 0)
> +			return ret;
> +	}
> +

This function only gets called when the PHY is being started, resumed,
or when the user changes the advertisement. If firmware switches to low
power when e.g. the results of the media negotiation change, then this
isn't the correct place to do this. When exactly does firmware set the
PHY to low power mode?

>  	/* We don't support manual MDI control */
>  	phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
>  
> @@ -201,6 +239,15 @@ static int bcm84881_read_status(struct phy_device *phydev)
>  		return 0;
>  	}
>  
> +	/* For BCM84891/92 in USXGMII mode, the host-side register 0x4011
> +	 * reports 10GBASER (the USXGMII SerDes line rate) regardless of the
> +	 * negotiated copper speed. Skip it; phy_resolve_aneg_linkmode()
> +	 * above already set the correct speed from standard AN resolution.
> +	 */

Is the PHY really using 10GBASE-R or is it using USXGMII. The two are
different. They don't just define the SerDes rate, but the protocol
that operates over it. 10GBASE-R has no inband signalling whereas
USXGMII does and supports symbol replication for slower speeds.

If the PHY is actually using 10GBASE-R, but with rate adaption (so
converting between the media speed and 10GBASE-R which only runs at 10G
rate) then you need more in this driver (see rate adaption stuff.)

If the PHY is really using USXGMII, where it will do symbol replication,
for the slower speeds over the 10G host-side link then the rate
adaption stuff is unnecessary.

Is there a code in the 0x4011 register which indicates if it uses
USXGMII as opposed to 10GBASE-R ? Please clarify.

> +	if (bcm84881_is_bcm8489x(phydev) &&
> +	    phydev->interface == PHY_INTERFACE_MODE_USXGMII)
> +		return genphy_c45_read_mdix(phydev);
> +
>  	/* Set the host link mode - we set the phy interface mode and
>  	 * the speed according to this register so that downshift works.
>  	 * We leave the duplex setting as per the resolution from the
> @@ -235,6 +282,26 @@ static int bcm84881_read_status(struct phy_device *phydev)
>  	return genphy_c45_read_mdix(phydev);
>  }
>  
> +/* BCM8489x speed LED control.
> + * Dev1:a83b bit 1 (0x0002) = green, bit 4 (0x0010) = amber.
> + * Dev1:a82f = 0x0020 gates amber on; green ignores the gate.
> + * Writes are best-effort (LED is cosmetic; this callback is void).
> + */
> +static void bcm84881_link_change_notify(struct phy_device *phydev)

While the driver is called bcm84881, I'd prefer if we didn't name
functions with the same prefix when they have nothing to do with the
bcm84881 PHY. bcm8489x_link_change_notify() would be more suitable.

> +{
> +	if (phydev->link) {
> +		/* 10G = green, else amber; matches vendor firmware */
> +		u16 color = (phydev->speed == SPEED_10000) ? 0x0002 : 0x0010;
> +
> +		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, BCM8489X_LED_GATE, 0x0020);
> +		phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, BCM8489X_LED_COLOR,
> +			       0x0012, color);
> +	} else {
> +		phy_clear_bits_mmd(phydev, MDIO_MMD_PMAPMD,
> +				   BCM8489X_LED_COLOR, 0x0012);
> +	}

... however, this is not how we support LEDs. Please look at the PHY
LEDs support using the generic LEDs support.

> +}
> +
>  /* The Broadcom BCM84881 in the Methode DM7052 is unable to provide a SGMII
>   * or 802.3z control word, so inband will not work.
>   */
> @@ -257,6 +324,32 @@ static struct phy_driver bcm84881_drivers[] = {
>  		.aneg_done	= bcm84881_aneg_done,
>  		.read_status	= bcm84881_read_status,
>  	},
> +	{
> +		.phy_id		= 0x35905081,
> +		.phy_id_mask	= 0xfffffff0,

Why set the revision in .phy_id when you mask it off? Please use
PHY_ID_MATCH_MODEL().

> +		.name		= "Broadcom BCM84891",
> +		.inband_caps	= bcm84881_inband_caps,
> +		.config_init	= bcm84881_config_init,
> +		.probe		= bcm84881_probe,
> +		.get_features	= bcm84881_get_features,
> +		.config_aneg	= bcm84881_config_aneg,
> +		.aneg_done	= bcm84881_aneg_done,
> +		.read_status	= bcm84881_read_status,
> +		.link_change_notify = bcm84881_link_change_notify,
> +	},
> +	{
> +		.phy_id		= 0x359050a1,
> +		.phy_id_mask	= 0xfffffff0,

Same here.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

