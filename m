Return-Path: <netdev+bounces-227005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6458BA6DC3
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 11:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7F727A1B86
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 09:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434592D877F;
	Sun, 28 Sep 2025 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="S66go+d7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08A42D062F;
	Sun, 28 Sep 2025 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759051954; cv=none; b=Hf5I2F1O13wExh7vpPHN7YhYlCDb4XxphU3D4ztkaBYYL8HapCDVOFXHcOxYwjfCR4ZE13oC++ethW1GLUjIZJ2ct0RObcZcawJHyZ1vy6zyvjMU+nL2tkvCVAiG/uNg89ohKJx56wiL6LMRiuO+jiN7EGnWUcbvk/HCheWoB3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759051954; c=relaxed/simple;
	bh=SKwtz4qWqhPcESQg87ojaWvLmwrEotTfIBGcnSoeTbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRJ9yXHIgoMdMJnoXnKwho6oG1gGeDXiAPaYiCLXRL7yHoWuKi+KFzCjtrXDFlRSToJsEuf+agCLttdbwbmwKGcx+6FsQ9R2QJh8yu4ZfjUJ17bf/LF47V0ZEzo0/YxctAwhuqGqLZuZEiq5zj2ODLkjb5+k+oxPNBokcX0AdtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=S66go+d7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W4obhf2MMc+kaVAeVoHPf3nhTo/bKPGOyQwVk/dKIYA=; b=S66go+d73VUiXXPjRKdmdmphgX
	fJSp4bLxi+AG0GdEXOovkaskpY4ph3IFxoWPlkw5KBlq8BCDaujWApl2reNhtFcjbYdO8NWLTAu/V
	4jlVxRjWuwXjBlWuN3blTKJRXUGJbIfujGydt2dCgCZIEqmEkDAd9oVT2mOQqCO7ldr59MR2+/rov
	sr5t7sQXGdcwWelHGX0LbcInHhXBZQG2QvKhdOThbQMeHV3+YdBNo41m0p+mCXk2XnC/CvR06IZBL
	hFHJHJHKFipbKSUM63/MTC3uqDEN9slMfDkAUlhX2C3f/dSobUTyU4JBwRkEJg+QyoR0+8N3pw81V
	7G/ljcAg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60784)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v2nlZ-000000005RS-1C6u;
	Sun, 28 Sep 2025 10:32:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v2nlU-000000002Si-1OQ2;
	Sun, 28 Sep 2025 10:32:20 +0100
Date: Sun, 28 Sep 2025 10:32:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>
Subject: Re: [PATCH RFC net-next 3/6] net: phylink: add phylink managed MAC
 Wake-on-Lan support
Message-ID: <aNkApFc9wsnabXFW@shell.armlinux.org.uk>
References: <aNj4HY_mk4JDsD_D@shell.armlinux.org.uk>
 <E1v2nFI-00000007jXV-1BYa@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1v2nFI-00000007jXV-1BYa@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Sep 28, 2025 at 09:59:04AM +0100, Russell King (Oracle) wrote:
> Add core phylink Wake-on-Lan support.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/phylink.c | 77 +++++++++++++++++++++++++++++++++++++--
>  include/linux/phylink.h   | 26 +++++++++++++
>  2 files changed, 99 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 9d7799ea1c17..9a3783e719bc 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -93,6 +93,9 @@ struct phylink {
>  	u8 sfp_port;
>  
>  	struct eee_config eee_cfg;
> +
> +	u32 wolopts_mac;
> +	u8 wol_sopass[SOPASS_MAX];
>  };
>  
>  #define phylink_printk(level, pl, fmt, ...) \
> @@ -2575,11 +2578,17 @@ EXPORT_SYMBOL_GPL(phylink_rx_clk_stop_unblock);
>   *   can also bring down the link between the MAC and PHY.
>   * - If Wake-on-Lan is active, but being handled by the MAC, the MAC
>   *   still needs to receive packets, so we can not bring the link down.
> + *
> + * Note: when phylink managed Wake-on-Lan is in use, @mac_wol is ignored.
> + * (struct phylink_mac_ops.mac_set_wol populated.)
>   */
>  void phylink_suspend(struct phylink *pl, bool mac_wol)
>  {
>  	ASSERT_RTNL();
>  
> +	if (phylink_mac_supports_wol(pl))
> +		mac_wol = !!pl->wolopts_mac;
> +
>  	if (mac_wol && (!pl->netdev || pl->netdev->ethtool->wol_enabled)) {
>  		/* Wake-on-Lan enabled, MAC handling */
>  		mutex_lock(&pl->state_mutex);
> @@ -2673,6 +2682,17 @@ void phylink_resume(struct phylink *pl)
>  }
>  EXPORT_SYMBOL_GPL(phylink_resume);
>  
> +static bool phylink_mac_supports_wol(struct phylink *pl)
> +{
> +	return !!pl->mac_ops->mac_wol_set;
> +}
> +
> +static bool phylink_phy_supports_wol(struct phylink *pl,
> +				     struct phy_device *phydev)
> +{
> +	return phydev && (pl->config->wol_phy_legacy || phy_can_wakeup(phydev));
> +}
> +

Yes, these need to be earlier.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

