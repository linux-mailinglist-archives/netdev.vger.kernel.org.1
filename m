Return-Path: <netdev+bounces-143260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A256B9C1BA5
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 11:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48A61C249A9
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 10:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8038F1E47B0;
	Fri,  8 Nov 2024 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="davprMUw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4990E29408;
	Fri,  8 Nov 2024 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063123; cv=none; b=n9n28xWIna6JfKBIAh1lYV3QEimiizHicW4KC/Owwviz5FaKShQHGZGojQ0vkWLBnxPfVDVGEuKtJTO64u6IH4/KcZsRD6Qkur1OOwiaXFnsCMZCynKlZtw8AiF5DUdzyk4/g35eUIo6cFPV1JS+3hpCoHI7M7yz4TpTBlNtuRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063123; c=relaxed/simple;
	bh=+1yrdmo6TvXud8UAPR4pFUoQ6w+MPs/h0Voko9KntfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+JE5//gJu0HZ64HMN5GQ5FYvxsS93aTj9y6b2pXPpnjnCvSOHlxRZhDDoBmeitdzz31ZqAxe1xiKVUfOvCziICaMMriE+PQT2Csqd5xj9XD+/ON21TolYCMRznrY+tDAYlW5ZBOXGLhfzJv/N0Gs4oQJb/5c6eYBZKXEYl64XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=davprMUw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZSxeVaPlRH4R/1jmcFUVY/CzYVAx0pe3ADP7c3aPo+8=; b=davprMUwoZuw9s1xZM2hywGQxR
	icVbkLwClj9aguIEBU9TkSS33HOsACjshGeh4aC9gDW+QMwzd8LArSJGbeH2D/AlZBlRvFYo85/zg
	iw6mu+jZk0Era68MYkpt4cB9kSM5Z2rIyMCB+uKivuGHFBoiUTZoKeujzGJnGdkTMl+voC+O2QQv+
	q3g3OvvHEASdwLMGN0SLWIhAJEV89kOR86jIFH8cp37qNzz3HYnFxFdMa1CEGYEUuOVZX0CK3fzdz
	g+Nzap66O20sc2E/4hWoiJHA+EenRc6hupDPl0B7r7PPVhAJV4s6ThatZndV8sLGfCZrN5c2pVLry
	hMd3oVnQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60982)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t9Maf-0004wK-1a;
	Fri, 08 Nov 2024 10:51:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t9Mab-0002DN-1v;
	Fri, 08 Nov 2024 10:51:41 +0000
Date: Fri, 8 Nov 2024 10:51:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v3 2/3] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <Zy3tPeWCHOH-CMoy@shell.armlinux.org.uk>
References: <20241106122254.13228-1-ansuelsmth@gmail.com>
 <20241106122254.13228-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106122254.13228-3-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 06, 2024 at 01:22:37PM +0100, Christian Marangi wrote:
> +static int an8855_port_enable(struct dsa_switch *ds, int port,
> +			      struct phy_device *phy)
> +{
> +	int ret;
> +
> +	ret = an8855_port_set_status(ds->priv, port, true);
> +	if (ret)
> +		return ret;
> +
> +	if (dsa_is_user_port(ds, port))
> +		phy_support_asym_pause(phy);

This is unnecessary if you've set the phylink capabilities correctly
because phylink_bringup_phy() will setup the PHY accordingly.

> +static u32 en8855_get_phy_flags(struct dsa_switch *ds, int port)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +
> +	/* PHY doesn't need calibration */
> +	if (!priv->phy_require_calib)
> +		return 0;
> +
> +	/* Use BIT(0) to signal calibration needed */
> +	return BIT(0);

This should be a #define somewhere that preferably includes the PHY
name so we have an idea in future which PHY driver is going to be
making use of this random bit.

> +static struct phylink_pcs *
> +an8855_phylink_mac_select_pcs(struct phylink_config *config,
> +			      phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct an8855_priv *priv = dp->ds->priv;
> +
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		return &priv->pcs;
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +static void
> +an8855_phylink_mac_config(struct phylink_config *config, unsigned int mode,
> +			  const struct phylink_link_state *state)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct dsa_switch *ds = dp->ds;
> +	struct an8855_priv *priv;
> +	int port = dp->index;
> +
> +	priv = ds->priv;
> +
> +	switch (port) {
> +	case 0:
> +	case 1:
> +	case 2:
> +	case 3:
> +	case 4:
> +		return;
> +	case 5:
> +		break;
> +	default:
> +		dev_err(ds->dev, "unsupported port: %d", port);
> +		return;
> +	}

	if (port != 5) {
		if (port > 5)
			dev_err(ds->dev, "unsupported port: %d", port);
		return;
	}

is simpler, no?

> +static int an8855_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> +			     phy_interface_t interface,
> +			     const unsigned long *advertising,
> +			     bool permit_pause_to_mac)
> +{
> +	struct an8855_priv *priv = container_of(pcs, struct an8855_priv, pcs);
> +	u32 val;
> +	int ret;
> +
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +		return 0;

This shouldn't happen. First, in an8855_phylink_mac_select_pcs(), you
don't return a PCS in this mode. Second, phylink is highly unlikely to
switch from SGMII/2500baseX to RGMII mode. Third, in commit
486dc391ef43 ("net: phylink: allow mac_select_pcs() to remove a PCS")
will ensure that if phylink does do such a switch, because
an8855_phylink_mac_select_pcs() returns NULL for RGMII, these PCS
functions will never be called for RGMII modes.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

