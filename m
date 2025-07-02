Return-Path: <netdev+bounces-203212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C187AF0C53
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD3EC7AF309
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7FA223DF0;
	Wed,  2 Jul 2025 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hPoPhMew"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFF7201261;
	Wed,  2 Jul 2025 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751440643; cv=none; b=C/KvEqxpiowv/l6N+KLEy/xziDK95KKsn3DChtyPl2BXNMTnbcqUHwAyux/g2gcoFJGH3ggTH1PVL4RbAe5U9cVXuAdsuBaW1TAY+9PhZi2ujYmx3KW/89gB/cO4tYWkqq4zJZp53SCoQiyHeYmDwU+sWnFNM0qPHUsfs/Pru+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751440643; c=relaxed/simple;
	bh=LSExucKZe0mtwwHTf3y56VWlUEakHL74/OJzWDFLcJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Di9+sxzxpuFHd6eNlK/eSR5VKI8Byj3cKyPWEszu2XXkKHIEzZs3tp4JcalCcO4ST5YK701zasRON/ZknOQEVjOX0ofsSPqEoGcZ8WoqGG5lac9SHlGyi9ocEHj3J9Kc7T7PtHAQ70AbmavgZuygKsrCVLoBkCDNUvQSSnVw/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hPoPhMew; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A85F841DF1;
	Wed,  2 Jul 2025 07:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751440633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SFgR9s1yj+x64xIhs3vXUk9wLToSRANqG6/nyrw1DA=;
	b=hPoPhMewJQweoHwYO4sqNASE9CzWou7I3Wgj6uAz6MZuXpv/hlIppiL7o4PqMX936lWsgX
	5QO2qBBwFrLWUnIgrk5xvC9XzoI7xYf8SCWrz+3OngrB9NDfmvTC+Z8hyaMTSkY9LxkFOe
	HMSRWCKAlbKrGIHaF1JC5VYaLe6Ik2CyTK2ujSpunLoGZPtytBJE1ws/ISdh7efmKEwhRA
	zMxDYBhuGg70deDJmG+fSC8aV4oRU00idfkloFns4XOqP53SKJAEnX8LZvBd55cAaaN1j4
	V+9sQkl2g5hJX6QU9ysJ8rX/rugg04aR64O18mJLe7girCTTDnpXq98WKJ5Z5g==
Date: Wed, 2 Jul 2025 09:17:08 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Vivian Wang <uwu@dram.page>, Lukas Bulwahn
 <lukas.bulwahn@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/5] net: spacemit: Add K1 Ethernet MAC
Message-ID: <20250702091708.7d459213@fedora.home>
In-Reply-To: <20250702-net-k1-emac-v3-2-882dc55404f3@iscas.ac.cn>
References: <20250702-net-k1-emac-v3-0-882dc55404f3@iscas.ac.cn>
	<20250702-net-k1-emac-v3-2-882dc55404f3@iscas.ac.cn>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgfejgeegheeitefgleehgeejiedvheefudelhfeijedutdeihfeijeetgfegfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtohepfigrnhhgrhhuihhkrghnghesihhstggrshdrrggtrdgtnhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpt
 hhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Vivian,

On Wed, 02 Jul 2025 14:01:41 +0800
Vivian Wang <wangruikang@iscas.ac.cn> wrote:

> The Ethernet MACs found on SpacemiT K1 appears to be a custom design
> that only superficially resembles some other embedded MACs. SpacemiT
> refers to them as "EMAC", so let's just call the driver "k1_emac".
> 
> This driver is based on "k1x-emac" in the same directory in the vendor's
> tree [1]. Some debugging tunables have been fixed to vendor-recommended
> defaults, and PTP support is not included yet.
> 
> [1]: https://github.com/spacemit-com/linux-k1x
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

I have a handful of tiny comments, the rest looks fine by me !

> +static int emac_phy_connect(struct net_device *ndev)
> +{
> +	struct emac_priv *priv = netdev_priv(ndev);
> +	struct device *dev = &priv->pdev->dev;
> +	struct phy_device *phydev;
> +	struct device_node *np;
> +	int ret;
> +
> +	ret = of_get_phy_mode(dev->of_node, &priv->phy_interface);
> +	if (ret) {
> +		dev_err(dev, "No phy-mode found");
> +		return ret;
> +	}
> +
> +	np = of_parse_phandle(dev->of_node, "phy-handle", 0);
> +	if (!np && of_phy_is_fixed_link(dev->of_node))
> +		np = of_node_get(dev->of_node);
> +
> +	if (!np) {
> +		dev_err(dev, "No PHY specified");
> +		return -ENODEV;
> +	}
> +
> +	ret = emac_phy_interface_config(priv);
> +	if (ret)
> +		goto err_node_put;
> +
> +	phydev = of_phy_connect(ndev, np, &emac_adjust_link, 0,
> +				priv->phy_interface);
> +	if (!phydev) {
> +		dev_err(dev, "Could not attach to PHY\n");
> +		ret = -ENODEV;
> +		goto err_node_put;
> +	}
> +
> +	phydev->mac_managed_pm = true;
> +
> +	ndev->phydev = phydev;

of_phy_connect() eventually calls phy_attach_direct(), which sets
ndev->phydev, so you don't need to do it here :)

> +
> +	emac_update_delay_line(priv);
> +
> +err_node_put:
> +	of_node_put(np);
> +	return ret;
> +}

[ ... ]

> +static int emac_down(struct emac_priv *priv)
> +{
> +	struct platform_device *pdev = priv->pdev;
> +	struct net_device *ndev = priv->ndev;
> +
> +	netif_stop_queue(ndev);
> +
> +	phy_stop(ndev->phydev);

phy_disconnect() will call phy_stop() for you, you can remove it.

> +	phy_disconnect(ndev->phydev);
> +
> +	emac_wr(priv, MAC_INTERRUPT_ENABLE, 0x0);
> +	emac_wr(priv, DMA_INTERRUPT_ENABLE, 0x0);
> +
> +	free_irq(priv->irq, ndev);
> +
> +	napi_disable(&priv->napi);
> +
> +	emac_reset_hw(priv);
> +
> +	pm_runtime_put_sync(&pdev->dev);
> +	return 0;
> +}
> +

[ ... ]

> +static int emac_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct reset_control *reset;
> +	struct net_device *ndev;
> +	struct emac_priv *priv;
> +	int ret;
> +
> +	ndev = devm_alloc_etherdev(dev, sizeof(struct emac_priv));
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	ndev->hw_features = NETIF_F_SG;
> +	ndev->features |= ndev->hw_features;
> +
> +	ndev->min_mtu = ETH_MIN_MTU;

This should already be the default value when using
devm_alloc_etherdev()

> +	ndev->max_mtu = EMAC_RX_BUF_4K - (ETH_HLEN + ETH_FCS_LEN);
> +
> +	priv = netdev_priv(ndev);
> +	priv->ndev = ndev;
> +	priv->pdev = pdev;
> +	platform_set_drvdata(pdev, priv);
> +	priv->hw_stats = devm_kzalloc(dev, sizeof(*priv->hw_stats), GFP_KERNEL);
> +	if (!priv->hw_stats) {
> +		dev_err(dev, "Failed to allocate memory for stats\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	ret = emac_config_dt(pdev, priv);
> +	if (ret < 0) {
> +		dev_err(dev, "Configuration failed\n");
> +		goto err;
> +	}
> +
> +	ndev->watchdog_timeo = 5 * HZ;
> +	ndev->base_addr = (unsigned long)priv->iobase;
> +	ndev->irq = priv->irq;
> +
> +	ndev->ethtool_ops = &emac_ethtool_ops;
> +	ndev->netdev_ops = &emac_netdev_ops;
> +
> +	devm_pm_runtime_enable(&pdev->dev);
> +
> +	priv->bus_clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(priv->bus_clk)) {
> +		ret = dev_err_probe(dev, PTR_ERR(priv->bus_clk),
> +				    "Failed to get clock\n");
> +		goto err;
> +	}
> +
> +	reset = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev,
> +								     NULL);
> +	if (IS_ERR(reset)) {
> +		ret = dev_err_probe(dev, PTR_ERR(reset),
> +				    "Failed to get reset\n");
> +		goto err;
> +	}
> +
> +	emac_sw_init(priv);
> +
> +	if (of_phy_is_fixed_link(dev->of_node)) {
> +		ret = of_phy_register_fixed_link(dev->of_node);
> +		if (ret) {
> +			dev_err_probe(dev, ret,
> +				      "Failed to register fixed-link");
> +			goto err_timer_delete;
> +		}

It looks like you're missing the calls to:

  of_phy_deregister_fixed_link()

in the error path here as well as in the .remove() function.

> +	}
> +
> +	ret = emac_mdio_init(priv);
> +	if (ret)
> +		goto err_timer_delete;
> +
> +	SET_NETDEV_DEV(ndev, &pdev->dev);
> +
> +	ret = devm_register_netdev(dev, ndev);
> +	if (ret) {
> +		dev_err(dev, "devm_register_netdev failed\n");
> +		goto err_timer_delete;
> +	}
> +
> +	netif_napi_add(ndev, &priv->napi, emac_rx_poll);
> +	netif_carrier_off(ndev);
> +
> +	return 0;
> +
> +err_timer_delete:
> +	timer_delete_sync(&priv->txtimer);
> +err:
> +	return ret;
> +}

Maxime

