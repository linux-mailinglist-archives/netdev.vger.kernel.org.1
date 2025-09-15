Return-Path: <netdev+bounces-223238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C184DB587B5
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D0E16719A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 22:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E933C2D47E7;
	Mon, 15 Sep 2025 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JDm70VRr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B62C029E;
	Mon, 15 Sep 2025 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976167; cv=none; b=gbaEAJ/W1+Xc+VJyl8xGXw3n7PFkkRC2eY7JVDtCvQx2VFp/sIDgi/j7AfmvLUg7FLp4eeMiYmtnivnffkDFsiY18CfUPrTuSV4KOB6ZpwMb8HvH3vRa4Uz0Y/MgRwrNu4s04mXlcpTApHt4btnhqCY/r+oiU7Mrx3UrHG20pes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976167; c=relaxed/simple;
	bh=J8x45dODCOGR40LhgL+MfCwNImZSxtFm6oc+Ork33fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ja8550SpXNKS/+bSGPRH2M4rto2bxwZgLEILvkVZfd7N6Jx1j+kQHpfRz9U9ZrKBcMYhE/feun94YayCdeYfLV3jKaYpbXXNkKr2MUequbT5Wm61ET1lnw1ZI/i44IFm2mhraOBXGC5gudA/loaevV/xhXGIHUsEo4SxkjNrr2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JDm70VRr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hbm2WSVmWKgLVc+FUCeHQ169iZOFNw7qHsfdrv2W7jM=; b=JDm70VRrydgYgL06K194KUdz26
	7nJwV5ewahNISz5xKsw+jBMwlf9ud4paxClly8WX4iYudPs7mgWeUoEVqMKK20gZ2rUdQdo0ifguv
	+C4xqhkV3qJ+mh1V1fdh4uEE2qkr2XkjJQczJVMa8BijytoUFEP2zpN6xMSA6wqnMSQKWC/jDRgg7
	z8yI4bQwRiaF5pji1jKL3InGglehRDc9m3uNDZHMk0diX0J88ZoTiwn7W+X4hsLrnQHRBnLWWQH/n
	4aATqcvJyEhHrVsT0/ridycVuVZoYdggX2A7SEPCCLm8qQGddbrGP1T5xis+iItY9fW/2IS1hTZ7s
	/W4gjpdw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59534)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uyHuF-000000002Ay-0s3f;
	Mon, 15 Sep 2025 23:42:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uyHuD-0000000073J-2mVm;
	Mon, 15 Sep 2025 23:42:41 +0100
Date: Mon, 15 Sep 2025 23:42:41 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <aMiWYWKzrFnwyTuz@shell.armlinux.org.uk>
References: <20250913044404.63641-1-mmyangfl@gmail.com>
 <20250913044404.63641-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913044404.63641-4-mmyangfl@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Sep 13, 2025 at 12:44:01PM +0800, David Yang wrote:
> +static int
> +yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
> +		   phy_interface_t interface)
> +{
> +	struct device *dev = to_device(priv);
> +	u32 mask;
> +	u32 ctrl;
> +	int res;
> +
> +	if (!yt921x_port_is_external(port)) {
> +		if (interface != PHY_INTERFACE_MODE_INTERNAL) {
> +			dev_err(dev, "Wrong mode %d on port %d\n",
> +				interface, port);
> +			return -EINVAL;
> +		}
> +		return 0;
> +	}
> +
> +	switch (interface) {
> +	/* SGMII */
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_100BASEX:
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		mask = YT921X_SGMII_CTRL_PORTn(port);
> +		res = yt921x_reg_set_bits(priv, YT921X_SGMII_CTRL, mask);
> +		if (res)
> +			return res;
> +
> +		mask = YT921X_XMII_CTRL_PORTn(port);
> +		res = yt921x_reg_clear_bits(priv, YT921X_XMII_CTRL, mask);
> +		if (res)
> +			return res;
> +
> +		mask = YT921X_SGMII_MODE_M;
> +		switch (interface) {
> +		case PHY_INTERFACE_MODE_SGMII:
> +			ctrl = YT921X_SGMII_MODE_SGMII_PHY;

Does this mean that "SGMII" here means you are sending SGMII
speed/duplex to a host MAC (in other words, immitating a PHY) ?

If yes, then I think we want PHY_INTERFACE_MODE_REVSGMII added.

> +static void
> +yt921x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
> +			     phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct dsa_switch *ds = dp->ds;
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct device *dev = to_device(priv);
> +	int port = dp->index;
> +	int res;

Reverse christmas tree ordering please, and do we need "struct device
*dev..." because ds->dev should be this same device. Maybe:

	struct dsa_port *dp = dsa_phylink_to_port(config);
	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
	int port = dp->index;
	int res;

> +
> +	cancel_delayed_work(&priv->ports[port].mib_read);
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_port_down(priv, port);
> +	mutex_unlock(&priv->reg_lock);
> +
> +	if (res)
> +		dev_err(dev, "Failed to %s port %d: %i\n", "bring down",
> +			port, res);

Then:
		dev_err(dp->ds->dev, ...

Same comment for the other phylink methods.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

