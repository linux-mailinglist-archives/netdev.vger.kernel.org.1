Return-Path: <netdev+bounces-203216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E33DAF0CCE
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1A71C21C54
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EA822DF9E;
	Wed,  2 Jul 2025 07:42:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA201DF977;
	Wed,  2 Jul 2025 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751442126; cv=none; b=Jr4reNUNYXtb3TWgM2/ePcOq4q4gzJc0X/MAfesNnbXrDnZtEfP1uonNcazW24GIlSfPAZmBJ38+BtQ3Cl7vi8h9oxQUxFXLjdjXiIlOAh9HQLyg7R8aHlh85MRCiZSmDocuGvuiGR4Wv44fnbp/Ca5q/bylNqwzRg7jDJ4hVMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751442126; c=relaxed/simple;
	bh=h5XObXmGPhWIsFNdl0j4c/OXIDA4oaPIHx3BFw437GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ypz0bYUTW4oQrQDYOkICni46UDK3/jsCnkbB0lPMWpOgFumrxXVGZa8jRsNJihaxLcQt/hFkJapp43sJ64E8dfCMrkzN11XHtQnsnimBuYmZKbn6PgMKF9BbZha3yiUgbNRW0xJ+QYJFjiQUBSYRbyctV/AOKrtleZg/SuP5+gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.33.13] (unknown [210.73.43.2])
	by APP-03 (Coremail) with SMTP id rQCowAAXrn+f4mRooUF4AA--.33051S2;
	Wed, 02 Jul 2025 15:41:20 +0800 (CST)
Message-ID: <5f02539a-2541-4705-b1a3-c1095416463e@iscas.ac.cn>
Date: Wed, 2 Jul 2025 15:41:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/5] net: spacemit: Add K1 Ethernet MAC
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Vivian Wang <uwu@dram.page>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250702-net-k1-emac-v3-0-882dc55404f3@iscas.ac.cn>
 <20250702-net-k1-emac-v3-2-882dc55404f3@iscas.ac.cn>
 <20250702091708.7d459213@fedora.home>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250702091708.7d459213@fedora.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowAAXrn+f4mRooUF4AA--.33051S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw18ZF47GFWUAFy8KF13twb_yoW7Cw13pa
	95GFWftF18Zr1xWr42vr4DJr92vw1ktF10kryYyay8u3sIyr1fJFy8KrWUCas5AFyqvrW5
	Zw4UXFnrua1kWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvCb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr1j6F
	4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IUY4pBDUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Maxime,

Thanks for your suggestions.

On 7/2/25 15:17, Maxime Chevallier wrote:
> Hello Vivian,
>
> On Wed, 02 Jul 2025 14:01:41 +0800
> Vivian Wang <wangruikang@iscas.ac.cn> wrote:
>
>> The Ethernet MACs found on SpacemiT K1 appears to be a custom design
>> that only superficially resembles some other embedded MACs. SpacemiT
>> refers to them as "EMAC", so let's just call the driver "k1_emac".
>>
>> This driver is based on "k1x-emac" in the same directory in the vendor's
>> tree [1]. Some debugging tunables have been fixed to vendor-recommended
>> defaults, and PTP support is not included yet.
>>
>> [1]: https://github.com/spacemit-com/linux-k1x
>>
>> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> I have a handful of tiny comments, the rest looks fine by me !
>
>> +static int emac_phy_connect(struct net_device *ndev)
>> +{
>> +	struct emac_priv *priv = netdev_priv(ndev);
>> +	struct device *dev = &priv->pdev->dev;
>> +	struct phy_device *phydev;
>> +	struct device_node *np;
>> +	int ret;
>> +
>> +	ret = of_get_phy_mode(dev->of_node, &priv->phy_interface);
>> +	if (ret) {
>> +		dev_err(dev, "No phy-mode found");
>> +		return ret;
>> +	}
>> +
>> +	np = of_parse_phandle(dev->of_node, "phy-handle", 0);
>> +	if (!np && of_phy_is_fixed_link(dev->of_node))
>> +		np = of_node_get(dev->of_node);
>> +
>> +	if (!np) {
>> +		dev_err(dev, "No PHY specified");
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = emac_phy_interface_config(priv);
>> +	if (ret)
>> +		goto err_node_put;
>> +
>> +	phydev = of_phy_connect(ndev, np, &emac_adjust_link, 0,
>> +				priv->phy_interface);
>> +	if (!phydev) {
>> +		dev_err(dev, "Could not attach to PHY\n");
>> +		ret = -ENODEV;
>> +		goto err_node_put;
>> +	}
>> +
>> +	phydev->mac_managed_pm = true;
>> +
>> +	ndev->phydev = phydev;
> of_phy_connect() eventually calls phy_attach_direct(), which sets
> ndev->phydev, so you don't need to do it here :)

I will remove it next version.

>> +
>> +	emac_update_delay_line(priv);
>> +
>> +err_node_put:
>> +	of_node_put(np);
>> +	return ret;
>> +}
> [ ... ]
>
>> +static int emac_down(struct emac_priv *priv)
>> +{
>> +	struct platform_device *pdev = priv->pdev;
>> +	struct net_device *ndev = priv->ndev;
>> +
>> +	netif_stop_queue(ndev);
>> +
>> +	phy_stop(ndev->phydev);
> phy_disconnect() will call phy_stop() for you, you can remove it.

Thanks, I will simplify handling of this.

>> +	phy_disconnect(ndev->phydev);
>> +
>> +	emac_wr(priv, MAC_INTERRUPT_ENABLE, 0x0);
>> +	emac_wr(priv, DMA_INTERRUPT_ENABLE, 0x0);
>> +
>> +	free_irq(priv->irq, ndev);
>> +
>> +	napi_disable(&priv->napi);
>> +
>> +	emac_reset_hw(priv);
>> +
>> +	pm_runtime_put_sync(&pdev->dev);
>> +	return 0;
>> +}
>> +
> [ ... ]
>
>> +static int emac_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct reset_control *reset;
>> +	struct net_device *ndev;
>> +	struct emac_priv *priv;
>> +	int ret;
>> +
>> +	ndev = devm_alloc_etherdev(dev, sizeof(struct emac_priv));
>> +	if (!ndev)
>> +		return -ENOMEM;
>> +
>> +	ndev->hw_features = NETIF_F_SG;
>> +	ndev->features |= ndev->hw_features;
>> +
>> +	ndev->min_mtu = ETH_MIN_MTU;
> This should already be the default value when using
> devm_alloc_etherdev()

I will remove next version.

>> +	ndev->max_mtu = EMAC_RX_BUF_4K - (ETH_HLEN + ETH_FCS_LEN);
>> +
>> +	priv = netdev_priv(ndev);
>> +	priv->ndev = ndev;
>> +	priv->pdev = pdev;
>> +	platform_set_drvdata(pdev, priv);
>> +	priv->hw_stats = devm_kzalloc(dev, sizeof(*priv->hw_stats), GFP_KERNEL);
>> +	if (!priv->hw_stats) {
>> +		dev_err(dev, "Failed to allocate memory for stats\n");
>> +		ret = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	ret = emac_config_dt(pdev, priv);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Configuration failed\n");
>> +		goto err;
>> +	}
>> +
>> +	ndev->watchdog_timeo = 5 * HZ;
>> +	ndev->base_addr = (unsigned long)priv->iobase;
>> +	ndev->irq = priv->irq;
>> +
>> +	ndev->ethtool_ops = &emac_ethtool_ops;
>> +	ndev->netdev_ops = &emac_netdev_ops;
>> +
>> +	devm_pm_runtime_enable(&pdev->dev);
>> +
>> +	priv->bus_clk = devm_clk_get_enabled(&pdev->dev, NULL);
>> +	if (IS_ERR(priv->bus_clk)) {
>> +		ret = dev_err_probe(dev, PTR_ERR(priv->bus_clk),
>> +				    "Failed to get clock\n");
>> +		goto err;
>> +	}
>> +
>> +	reset = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev,
>> +								     NULL);
>> +	if (IS_ERR(reset)) {
>> +		ret = dev_err_probe(dev, PTR_ERR(reset),
>> +				    "Failed to get reset\n");
>> +		goto err;
>> +	}
>> +
>> +	emac_sw_init(priv);
>> +
>> +	if (of_phy_is_fixed_link(dev->of_node)) {
>> +		ret = of_phy_register_fixed_link(dev->of_node);
>> +		if (ret) {
>> +			dev_err_probe(dev, ret,
>> +				      "Failed to register fixed-link");
>> +			goto err_timer_delete;
>> +		}
> It looks like you're missing the calls to:
>
>   of_phy_deregister_fixed_link()
>
> in the error path here as well as in the .remove() function.

It seems I had misunderstood the use of of_phy_register_fixed_link, I
will fix this next version.

Thanks,
Vivian "dramforever" Wang

>> +	}
>> +
>> +	ret = emac_mdio_init(priv);
>> +	if (ret)
>> +		goto err_timer_delete;
>> +
>> +	SET_NETDEV_DEV(ndev, &pdev->dev);
>> +
>> +	ret = devm_register_netdev(dev, ndev);
>> +	if (ret) {
>> +		dev_err(dev, "devm_register_netdev failed\n");
>> +		goto err_timer_delete;
>> +	}
>> +
>> +	netif_napi_add(ndev, &priv->napi, emac_rx_poll);
>> +	netif_carrier_off(ndev);
>> +
>> +	return 0;
>> +
>> +err_timer_delete:
>> +	timer_delete_sync(&priv->txtimer);
>> +err:
>> +	return ret;
>> +}
> Maxime


