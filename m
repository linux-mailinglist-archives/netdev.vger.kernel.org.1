Return-Path: <netdev+bounces-259847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DQ8QFIVLmmm3aQMAu9opvQ
	(envelope-from <netdev+bounces-259847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 01:19:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA1016E4EC
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 01:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 471A530156D1
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 00:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6433BB5A;
	Sun, 22 Feb 2026 00:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NpA/wLWG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE963EBF36;
	Sun, 22 Feb 2026 00:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771719552; cv=none; b=CJdHTDpy6QYklPYfaK11w26I1DI5eZE6IGolI6RMAmhXC0xS1u/VyzesQWIoCdQgVZEfn6YjlBuwtNKQDESVG0hkkJCEeDiMV52O4yu7BkyiItYaaOkHUCvyPFgpfC9W4NsdVpdC/0ONAOrn7deY9tCjYuJuP3a1O/OpAfkFuFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771719552; c=relaxed/simple;
	bh=yJ6Il6XAft2V8RmNB3TUs9SoIelbh17ZzslurizSrK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLyYccxn8Wc7uGqLLP+J6DQ0q4HDQtbuDadWTzbZUc9yJnpJsDS+jfuioW15bn/1hHOEgdzs85RM9Nqube8Jc94HpJWTYaBhQZ7DRbW1/laUhOcB1f+Cl17NZzaumzY0kHM7sR7Dsucd7yTkOBLyHcVtXMs7vUubZDj2oc/ZXGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NpA/wLWG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xkDfXaHZGVvfFHyehlHz4qVdLj1AmPO7yOuXxj99pew=; b=NpA/wLWGu8ttBhIv3k9heKIW5S
	fpy4LVBZeWmrWmKSoyh57x1sYn0+043TTa9vsITyL8LCX88JloQlKiQt7p6Ts1hnGRUAcw+Ts83gw
	TVbBwYs6l64emAv9/tEOOeiq7GSYSF0f1d1Ny2rYrlI0sh7o0AR1OujKQ80NLq6n6n2FhWG6Cr5JM
	UdFgMEFWZ+aFv5YbkFQaOekPiABd7m1MiNy0iJEMLvACZYYPVO+vdBNCyDlrHdgzZn+a7Q+KGAMC6
	d8xFpxz5G7BS6YDco/4uMwVIAbpjmkDdusouUwL7VmZo6GjVYOKO0duu25N27EEzqRIL90Ork7SQ7
	2lgEzd8Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58750)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vtxBS-000000002q8-2cdu;
	Sun, 22 Feb 2026 00:18:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vtxBN-000000005nD-0fmX;
	Sun, 22 Feb 2026 00:18:45 +0000
Date: Sun, 22 Feb 2026 00:18:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub =?utf-8?B?VmFuxJtr?= <linuxtardis@gmail.com>
Cc: Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sai Krishna <saikrishnag@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: phy: motorcomm: yt8821: disable MDIO
 broadcast address 0
Message-ID: <aZpLZMK-FTmQI53o@shell.armlinux.org.uk>
References: <d3bb9c36-5a0e-4339-901d-2dd21bdba395@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3bb9c36-5a0e-4339-901d-2dd21bdba395@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,vger.kernel.org];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259847-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.978];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 9EA1016E4EC
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 12:46:53AM +0100, Jakub Vaněk wrote:
> The YT8821 PHY responds on two MDIO addresses by default: the address
> selected by its strapping pins and the broadcast address 0.
> 
> On platforms where another PHY is hardwired to respond only on address 0
> (e.g. the internal Gigabit PHY in the MediaTek MT7981B SoC), this can lead
> to MDIO bus conflicts. The YT8821 may incorrectly respond to transactions
> intended for the other PHY, leaving it in an inconsistent state. The
> following issues were observed on a Cudy M3000 router:
> 
> - Achieving just 100 Mbps speeds on gigabit links. Dmesg would show
>   messages like
> 
>     [ 133.997177] YT8821 2.5Gbps PHY mdio-bus:01: Downshift occurred from negotiated speed 1Gbps to actual speed 100Mbps, check cabling!
>     [ 134.009400] mtk_soc_eth 15100000.ethernet eth0: Link is Up - 100Mbps/Full - flow control off
> 
> - Having the PHY report that the link is up, yet no data would flow.
> - The YT8821 would be affected by an "ip link set dev eth1 down"
>   command aimed at the other PHY.
> 
> Avoid this conflict by disabling the broadcast address 0 early in
> the PHY configuration process. The .probe callback is called early
> enough to stop the issues from occurring. The .config_init callback
> re-establishes the workaround after the PHY undergoes a hardware
> reset.
> 
> This change makes the YT8821 work reliably on the Cudy M3000 router
> when running the current OpenWrt main branch with a small device tree
> patch.
> 
> Link: https://github.com/openwrt/openwrt/pull/21584
> Fixes: b671105b88c3 ("net: phy: Add driver for Motorcomm yt8821 2.5G ethernet phy")
> Signed-off-by: Jakub Vaněk <linuxtardis@gmail.com>
> ---
>  drivers/net/phy/motorcomm.c | 48 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 42d46b5758fc..bcb60d0bcab5 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -227,6 +227,9 @@
>  #define YT8521_LED_100_ON_EN			BIT(5)
>  #define YT8521_LED_10_ON_EN			BIT(4)
>  
> +#define YTPHY_MDIO_ADDRESS_CONTROL_REG		0xA005
> +#define YTPHY_MACR_EN_PHY_ADDR_0		BIT(6)
> +
>  #define YTPHY_MISC_CONFIG_REG			0xA006
>  #define YTPHY_MCR_FIBER_SPEED_MASK		BIT(0)
>  #define YTPHY_MCR_FIBER_1000BX			(0x1 << 0)
> @@ -2760,6 +2763,30 @@ static int yt8821_soft_reset(struct phy_device *phydev)
>  					  YT8521_CCR_SW_RST, 0);
>  }
>  
> +/**
> + * yt8821_disable_mdio_address_zero() - disable MDIO broadcast address 0
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * The YT8821 responds on two MDIO addresses by default:
> + *  - the address selected by its strapping pins
> + *  - the broadcast address 0
> + *
> + * Some other PHYs (e.g. the MT7981B internal Gigabit PHY) are hardwired to
> + * respond only on MDIO address 0. If the YT8821 also listens on address 0,
> + * it may incorrectly react to transactions intended for those PHYs.
> + *
> + * Disabling address 0 on the YT8821 early avoids such MDIO bus conflicts.
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8821_disable_mdio_address_zero(struct phy_device *phydev)
> +{
> +	return ytphy_modify_ext(phydev,
> +				YTPHY_MDIO_ADDRESS_CONTROL_REG,
> +				YTPHY_MACR_EN_PHY_ADDR_0,
> +				0);
> +}
> +
>  /**
>   * yt8821_config_init() - phy initializatioin
>   * @phydev: a pointer to a &struct phy_device
> @@ -2795,6 +2822,10 @@ static int yt8821_config_init(struct phy_device *phydev)
>  		phydev->rate_matching = RATE_MATCH_PAUSE;
>  	}
>  
> +	ret = yt8821_disable_mdio_address_zero(phydev);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = yt8821_serdes_init(phydev);
>  	if (ret < 0)
>  		return ret;
> @@ -2812,6 +2843,22 @@ static int yt8821_config_init(struct phy_device *phydev)
>  	return yt8821_soft_reset(phydev);
>  }
>  
> +/**
> + * yt8821_probe() - early PHY initialization
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8821_probe(struct phy_device *phydev)
> +{
> +	/*
> +	 * Disable the MDIO broadcast address (0) as early as possible.
> +	 * This prevents the YT8821 from responding to transactions
> +	 * intended for a different PHY that is fixed at address 0.
> +	 */
> +	return yt8821_disable_mdio_address_zero(phydev);

This is too late (chicken and egg problem exists) - phylib will already
have scanned the bus, and found a PHY at address 0 (whether it read the
IDs correctly because of the conflict is a separate matter. If there's
a conflict between two devices, the PHY IDs read will be a mess.)

However, if this PHY is the only PHY on the bus, and some driver uses
phy_find_first(), it will find the PHY at address 0, but it won't
respond anymore.

Failing the probe for address 0 doesn't solve the problem either - there
will still be a struct phy_device created for address 0, and if this
driver doesn't bind to it, the generic PHY driver will be bound manually
by phylib.

I can't see a simple way to handle this in the kernel. So, I'm going
to say this instead: boot loaders / board firmware need to sort this
mess out and program this PHY not to respond at address 0.

To put it another way, this isn't a problem to be solved in the kernel.
It's a board design/firmware issue, and that's where it needs to be
solved.

One of the responsibilities of board firmware is to ensure that the
devices on the board are configured sensibly for the operating system.
What you've said above, where two PHYs conflict on address zero is
a failure to configure the devices on the board sensibly.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

