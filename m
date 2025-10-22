Return-Path: <netdev+bounces-231708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 085C2BFCF55
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BBD5188D806
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88D8221F00;
	Wed, 22 Oct 2025 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnBG/HLx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E13821D5BC;
	Wed, 22 Oct 2025 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147950; cv=none; b=YDmNW8iTk4aUBElt6b/dPgf8oEKAKdWvk9zlSaFyGx3kuxVSFxjpzZF4KLcmAQhoeF81IeIs20SUwkJWHI2RYvIVpxNvwauYxxL136qMvsX1sM97JmAz/i1rN/sQGoclRQao+IUNYrUlYSaSELL3hcDoUOtQJ1B1HVzCQ7Bf7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147950; c=relaxed/simple;
	bh=n/aPoNdQ21y4oZH7+SOnFwRgtsp0E1SRcb2RGzXobT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENGTDkpa9kIj/GtG+C1EMAZprkI3vpVNbSF0nhwQPR66EVo3DoqwCiZjPZONCY83jgAzDSM+FQecfbFNOoenbHzNKu+tuh49s3RBmhwMjT7m61SvJgmGKcYa8Eonj71WxlG3sSp+aoKrI8+hCLV0KFyVeQKRaB/67ovC0u1v4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnBG/HLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A03C4CEE7;
	Wed, 22 Oct 2025 15:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761147948;
	bh=n/aPoNdQ21y4oZH7+SOnFwRgtsp0E1SRcb2RGzXobT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PnBG/HLxnp6OcHuQQ1ZU4ewu7ZJ9b2U19vQsoHAXaGoHjp6318QMBWVXhDMj/eI3B
	 L/IB0AcgbRdGkPnGYyDyJkgLWUVIyQ1lKl+v9T6oli5GzPcKAHV/vKowVbAtnhfReo
	 QYSqfCOZOxu4FqfbSDj6w4wDMsRW1KD8SlyPJTXIaeb+Oh6HEWryIwyFA4ENZIRpy0
	 nJuOUBZr1PGzHht5v9w5bzje/eoqa5lBKAfQ5SA/LcnmSmXeB0dHttu2qr1ZBNYLSw
	 d4Ap60ccVA1Vx9M3L6HjeRg8azju3RxowKVlreSs9mtWg4kBqqYSquRoyqb0LFloTQ
	 ontLbGDny9ukg==
Date: Wed, 22 Oct 2025 16:45:43 +0100
From: Simon Horman <horms@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 2/2] net: airoha: add phylink support for GDM1
Message-ID: <aPj8J5ntvDGLPYaY@horms.kernel.org>
References: <20251021193315.2192359-1-ansuelsmth@gmail.com>
 <20251021193315.2192359-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021193315.2192359-3-ansuelsmth@gmail.com>

On Tue, Oct 21, 2025 at 09:33:12PM +0200, Christian Marangi wrote:

...

> +static int airoha_setup_phylink(struct net_device *netdev)
> +{
> +	struct airoha_gdm_port *port = netdev_priv(netdev);
> +	struct device *dev = &netdev->dev;
> +	phy_interface_t phy_mode;

Hi Christian,

phy_interface_t is an enum and thus may in practice be unsigned...

> +	struct phylink *phylink;
> +
> +	phy_mode = device_get_phy_mode(dev);
> +	if (phy_mode < 0) {

... if so, this condition will always be false.

I suspect the correct approach here is to change the type of phy_mode to int.

Flagged by Smatch.

> +		dev_err(dev, "incorrect phy-mode\n");
> +		return phy_mode;
> +	}
> +
> +	port->phylink_config.dev = dev;
> +	port->phylink_config.type = PHYLINK_NETDEV;
> +	port->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +						MAC_10000FD;
> +
> +	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +		  port->phylink_config.supported_interfaces);
> +
> +	phylink = phylink_create(&port->phylink_config, dev_fwnode(dev),
> +				 phy_mode, &airoha_phylink_ops);
> +	if (IS_ERR(phylink))
> +		return PTR_ERR(phylink);
> +
> +	port->phylink = phylink;
> +
> +	return 0;
> +}
> +
>  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
>  				 struct device_node *np, int index)
>  {

...

-- 
pw-bot: cr

