Return-Path: <netdev+bounces-173350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B37A58656
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B493A59FB
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784D91E8325;
	Sun,  9 Mar 2025 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="h56zXtBZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F581A2C0E;
	Sun,  9 Mar 2025 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541832; cv=none; b=twdx88nGkB8eaO45kXtAyk9nMmnfM10cecGWSuTWfAUBaIMuwneqbFHAdoebe7JfVE4KteUa7jOf9u60GAhEridWWMdifgB1kbaEiyh28HQO7ocSwAyXeMeVt/kiEvyd1XVkGdaeY7mjA4upMvD3KnE/TWGgDB9NVzYQfXE1ntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541832; c=relaxed/simple;
	bh=ccScXORVivoZSP6rdG6iLpxmYxO/Yu6lJ51X6AaFL70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXTuuhyXJwLbdq9Lh7DqdRbfCuzG3lr/YgdWNiDCaxjTHB0A/+G03ed8jvQgqMY76mfN3juM56/IkCO6V44ao6toOVMpRs6dwUPgLN+XYZecuKNKtWrd9fUygm/2wPvOhU6WuFnn9R2dUS2f9yls3nRJtJZ7Xr8lyunW7EmRQfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=h56zXtBZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=trOvshMr7ukZzcXJPcSVt8+zNNX8HGE0PTd1EfamR/U=; b=h56zXtBZa/5wXPcpRpkKYh4PlN
	FVBXPhxn29lyqhisMCHoD5k3YImfsyxDvgobDx2h1V4Ze+6Lv8MXixMh3rT1z/1cBUTINv+RRk7I9
	Cauo7SoF8oQDeFRsPKUpMUYj3/gK+F39fXlNRzZAFZ2m+ZmNVo+iJaF3r6XPIQiwpto+Vkoqi+Zsd
	or9oIBPQpNHD7/23FH0GGnT+AvjO2484tCM3FrT3b5Jr4UV4Yoh2W1kiiSa+qbdRCmUgd3r/HML4s
	ZADSv3qpFDmivCUKHVLAe5MXk1YGGXP65LRruV6ch9WwGxnx4l0up2Q7oKv96eihBeKkhlZTwYf5G
	xUAT2z0w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60658)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1trKa6-0001YP-0o;
	Sun, 09 Mar 2025 17:36:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1trKa1-0001cZ-16;
	Sun, 09 Mar 2025 17:36:49 +0000
Date: Sun, 9 Mar 2025 17:36:49 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v12 07/13] net: mdio: regmap: add support for
 multiple valid addr
Message-ID: <Z83RsW1_bzoEWheo@shell.armlinux.org.uk>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
 <20250309172717.9067-8-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309172717.9067-8-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Mar 09, 2025 at 06:26:52PM +0100, Christian Marangi wrote:
> +/* If a non empty valid_addr_mask is passed, PHY address and
> + * read/write register are encoded in the regmap register
> + * by placing the register in the first 16 bits and the PHY address
> + * right after.
> + */
> +#define MDIO_REGMAP_PHY_ADDR		GENMASK(20, 16)
> +#define MDIO_REGMAP_PHY_REG		GENMASK(15, 0)

Clause 45 PHYs have 5 bits of PHY address, then 5 bits of mmd address,
and then 16 bits of register address - significant in that order. Can
we adjust the mask for the PHY address later to add the MMD between
the PHY address and register number?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

