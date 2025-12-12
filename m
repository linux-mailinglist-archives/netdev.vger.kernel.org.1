Return-Path: <netdev+bounces-244560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DED8CB9D38
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 21:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9710230213CD
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF69C30FC1F;
	Fri, 12 Dec 2025 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GnROZmtf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0841E5B95;
	Fri, 12 Dec 2025 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765572830; cv=none; b=cLY2QVWBhpUdYgugUQBo9btSUa3JMU3qJM4ovVnfK3nDHioP8bxRd0GJlynVIRixYvFVN7fesNTeRzSsh9BTag5/B/yeMkwFJQ25/EkYe/h26L8S6La53H6IB1GaLfnkE9S6g7SMuVpu2BlS9UEPnQsdMBMVTRT0f2OsMgU+6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765572830; c=relaxed/simple;
	bh=O/q/rl5W1S8fug1pj0oXD/ywT6J93+5vjtfsuoFrJTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAOOQKDQXj8L9d1x+7/D++pijS/Q1Qx2iix5iDdmboZO5wBUYSLGT7kUaWnWTwTgfCUodLKeQzfRAIw8OubKoIyCpJOdsi6uKHpt89z/PLOPtPvA5GWZukt5mnlVt7+FjRkZGsz6PcO/biAoshMm5sG4Z6DfsO5LifN5HUXrnC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GnROZmtf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TBaHMJ56fCa2uYIvKR8exz+obq9clHyxCoBwIqNbV+Y=; b=GnROZmtfaaW91tqnTPGakqEEl6
	DF+rPaEaRPuW1TNQyH7LLHx6ugLELAlqQfzx8Cx2iYYF/tXL1mVuZRmHlxmHWrsYraoZmXYZr1/g9
	RcynIcUbfaH+arie77ZcHgQinb95VkJwwuDdlCb0jed5TunzYxBmO8RTzP3AA5OWEIyI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vUA8r-00GnlC-4s; Fri, 12 Dec 2025 21:53:33 +0100
Date: Fri, 12 Dec 2025 21:53:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next 2/2] net: dsa: mxl-gsw1xx: Support R(G)MII slew
 rate configuration
Message-ID: <ac065711-890a-4541-8366-d1f601c5f5ef@lunn.ch>
References: <20251212204557.2082890-1-alexander.sverdlin@siemens.com>
 <20251212204557.2082890-3-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212204557.2082890-3-alexander.sverdlin@siemens.com>

> +	case GSW1XX_MII_PORT:
> +		if (of_property_read_bool(dp->dn, "maxlinear,mii-slew-rate-slow"))
> +			regmap_set_bits(gsw1xx_priv->shell,
> +					RGMII_SLEW_CFG_DRV_TXD | RGMII_SLEW_CFG_DRV_TXC,
> +					GSW1XX_SHELL_RGMII_SLEW_CFG);

The binding says:

+              Configure R(G)MII TXD/TXC pads' slew rate to "slow" instead
+              of "normal" to reduce radiated emissions.

So you really should set the slew to normal if the property does not
exist.

	Andrew

