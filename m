Return-Path: <netdev+bounces-197935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2BFADA6A5
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 05:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794C83A410B
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 03:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E3A28E594;
	Mon, 16 Jun 2025 03:05:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC882AD00;
	Mon, 16 Jun 2025 03:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750043104; cv=none; b=b8KDaIV+3RCQQUZP2bOvpnxSAORtoNEfuWdq67Vr1NQalj7vDlRNcgdwVgJSnbe5fgVM7jCi9+v65y1FPBditUegHmW1k/F9cHHCgHIWsd5WOa637lZF4Tmq+eBiPnCfjRSQ3JyUGfMJr0OzKPvmYdMn1IS132WQ2blDsKstv3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750043104; c=relaxed/simple;
	bh=QtT/c1m1WQn/tRePHxP4aSrTjgxlsffKC1b2lD0/iLI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=anCw1bXZ5c+7yTzEyKL/jUx9ll3sJZXlX25sDjAAzpKs7hP4j9SmgHuMbSK0YJIHmRt2KL41mh6E1gO/QZmGUaRYWj6qHylPnjdUOVWou3TWElCuPMXIj08j+epE4G8HRJYkYkSQKNG488Ym+xSehrdixm1Xxj9QOsy7Hkvvet0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.33.113] (unknown [210.73.43.2])
	by APP-01 (Coremail) with SMTP id qwCowACH+9nEiU9orVzWBg--.22797S2;
	Mon, 16 Jun 2025 11:04:37 +0800 (CST)
Message-ID: <c60e9579-c261-41e3-ad5a-f96ce6d76820@iscas.ac.cn>
Date: Mon, 16 Jun 2025 11:04:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: Re: [PATCH net-next 2/4] net: spacemit: Add K1 Ethernet MAC
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Russell King
 <linux@armlinux.org.uk>, Vivian Wang <uwu@dram.page>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250613-net-k1-emac-v1-0-cc6f9e510667@iscas.ac.cn>
 <20250613-net-k1-emac-v1-2-cc6f9e510667@iscas.ac.cn>
 <7dfcfb04-8a7f-4884-9c91-413a6fb2a56b@lunn.ch>
Content-Language: en-US
In-Reply-To: <7dfcfb04-8a7f-4884-9c91-413a6fb2a56b@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qwCowACH+9nEiU9orVzWBg--.22797S2
X-Coremail-Antispam: 1UD129KBjvJXoW3tr48Gw1DJw45ur4xKr4kWFg_yoWkXFW3pa
	yDJFZ5GF17ZFy7Wr4qqr4DXr1Ivrn5tF4Ika4Yyan8Xr9Ikr1fCryrKrW2k3s3Cr909F45
	uw1UZFsrWF4DKrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JV
	WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bfzV8UUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Andrew,

Thanks for your review and suggestions.

On 6/13/25 22:32, Andrew Lunn wrote:
>> +static inline void emac_wr(struct emac_priv *priv, u32 reg, u32 val)
>> +{
>> +	writel(val, priv->iobase + reg);
>> +}
>> +
>> +static inline int emac_rd(struct emac_priv *priv, u32 reg)
>> +{
>> +	return readl(priv->iobase + reg);
>> +}
> I only took a very quick look at the code. I'm sure there are more
> issues....
>
> Please do not user inline functions in a .c file. Let the compiler
> decide.
I will remove "inline" in next version.
>> +static void emac_alloc_rx_desc_buffers(struct emac_priv *priv);
>> +static int emac_phy_connect(struct net_device *dev);
>> +static void emac_tx_timeout_task(struct work_struct *work);
> No forward declarations. Move the code around so they are not needed.
I will reorganize in next version.
>> +static int emac_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
>> +{
>> +	int ret = -EOPNOTSUPP;
>> +
>> +	if (!netif_running(ndev))
>> +		return -EINVAL;
>> +
>> +	switch (cmd) {
>> +	case SIOCGMIIPHY:
>> +	case SIOCGMIIREG:
>> +	case SIOCSMIIREG:
> There is no need to test for these values. Just call phy_mii_ioctl()
> and it will only act on IOCTLs it knows.
I will simplify in next version.
>> +		if (!ndev->phydev)
>> +			return -EINVAL;
>> +		ret = phy_mii_ioctl(ndev->phydev, rq, cmd);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +static int emac_up(struct emac_priv *priv)
>> +{
>> +	struct platform_device *pdev = priv->pdev;
>> +	struct net_device *ndev = priv->ndev;
>> +	int ret;
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +	pm_runtime_get_sync(&pdev->dev);
>> +#endif
> You don't need this #ifdef, there is a stub function is PM_SLEEP is
> not enabled.
I will remove "#ifdef" in next version.
>> +
>> +	ret = emac_phy_connect(ndev);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "emac_phy_connect failed\n");
>> +		goto err;
>> +	}
>> +
>> +	emac_init_hw(priv);
>> +
>> +	emac_set_mac_addr(priv, ndev->dev_addr);
>> +	emac_configure_tx(priv);
>> +	emac_configure_rx(priv);
>> +
>> +	emac_alloc_rx_desc_buffers(priv);
>> +
>> +	if (ndev->phydev)
>> +		phy_start(ndev->phydev);
> Is it possible to not have a PHY? emac_phy_connect() seems to return
> an error if it cannot find one.
>
I will remove unnecessary if (ndev->phydev) checks in next version.
>> +static int emac_down(struct emac_priv *priv)
>> +{
>> +	struct platform_device *pdev = priv->pdev;
>> +	struct net_device *ndev = priv->ndev;
>> +
>> +	netif_stop_queue(ndev);
>> +
>> +	if (ndev->phydev) {
>> +		phy_stop(ndev->phydev);
>> +		phy_disconnect(ndev->phydev);
>> +	}
>> +
>> +	priv->link = false;
>> +	priv->duplex = DUPLEX_UNKNOWN;
>> +	priv->speed = SPEED_UNKNOWN;
>> +
>> +	emac_wr(priv, MAC_INTERRUPT_ENABLE, 0x0);
>> +	emac_wr(priv, DMA_INTERRUPT_ENABLE, 0x0);
>> +
>> +	free_irq(priv->irq, ndev);
>> +
>> +	napi_disable(&priv->napi);
>> +
>> +	emac_reset_hw(priv);
>> +	netif_carrier_off(ndev);
> phylib will of done this when phy_stop() is called. Let phylib manage
> the carrier. The only thing you probably need is netif_carrier_off()
> in probe().
I will remove netif_carrier_off here and add to probe.
>> +static int emac_change_mtu(struct net_device *ndev, int mtu)
>> +{
>> +	struct emac_priv *priv = netdev_priv(ndev);
>> +	u32 frame_len;
>> +
>> +	if (netif_running(ndev)) {
>> +		netdev_err(ndev, "must be stopped to change MTU\n");
>> +		return -EBUSY;
>> +	}
>> +
>> +	frame_len = mtu + ETHERNET_HEADER_SIZE + ETHERNET_FCS_SIZE;
>> +
>> +	if (frame_len < MINIMUM_ETHERNET_FRAME_SIZE ||
>> +	    frame_len > EMAC_RX_BUF_4K) {
>> +		netdev_err(ndev, "Invalid MTU setting\n");
>> +		return -EINVAL;
>> +	}
> If you set ndev->mtu_max and ndev->mtu_min, the core will check this
> for you.
>
I will remove this check and use mtu_{min,max} instead.
>> +static void emac_reset(struct emac_priv *priv)
>> +{
>> +	if (!test_and_clear_bit(EMAC_RESET_REQUESTED, &priv->state))
>> +		return;
>> +	if (test_bit(EMAC_DOWN, &priv->state))
>> +		return;
>> +
>> +	netdev_err(priv->ndev, "Reset controller\n");
>> +
>> +	rtnl_lock();
>> +	netif_trans_update(priv->ndev);
>> +	while (test_and_set_bit(EMAC_RESETING, &priv->state))
>> +		usleep_range(1000, 2000);
> Don't do endless loops waiting for the hardware. It may never
> happen. Please use something from iopoll.h
It seems that I had misunderstood the original code here. I will
simplify the logic here in next version.
>> +static int emac_mii_read(struct mii_bus *bus, int phy_addr, int regnum)
>> +{
>> +	struct emac_priv *priv = bus->priv;
>> +	u32 cmd = 0;
>> +	u32 val;
>> +
>> +	cmd |= phy_addr & 0x1F;
>> +	cmd |= (regnum & 0x1F) << 5;
>> +	cmd |= MREGBIT_START_MDIO_TRANS | MREGBIT_MDIO_READ_WRITE;
>> +
>> +	emac_wr(priv, MAC_MDIO_DATA, 0x0);
>> +	emac_wr(priv, MAC_MDIO_CONTROL, cmd);
>> +
>> +	if (readl_poll_timeout(priv->iobase + MAC_MDIO_CONTROL, val,
>> +			       !((val >> 15) & 0x1), 100, 10000))
>> +		return -EBUSY;
> readl_poll_timeout() returns an error code. Don't replace it.
I will fix it next version.
>> +static void emac_adjust_link(struct net_device *dev)
>> +{
>> +	struct emac_priv *priv = netdev_priv(dev);
>> +	struct phy_device *phydev = dev->phydev;
>> +	bool link_changed = false;
>> +	u32 ctrl;
>> +
>> +	if (!phydev)
>> +		return;
> How does that happen?
>
>> +	if (phydev->link) {
>> +		ctrl = emac_rd(priv, MAC_GLOBAL_CONTROL);
>> +
>> +		/* Update duplex and speed from PHY */
>> +
>> +		if (phydev->duplex != priv->duplex) {
>> +			link_changed = true;
>> +
>> +			if (!phydev->duplex)
>> +				ctrl &= ~MREGBIT_FULL_DUPLEX_MODE;
>> +			else
>> +				ctrl |= MREGBIT_FULL_DUPLEX_MODE;
>> +			priv->duplex = phydev->duplex;
>> +		}
>> +
>> +		if (phydev->speed != priv->speed) {
>> +			link_changed = true;
>> +
>> +			ctrl &= ~MREGBIT_SPEED;
>> +
>> +			switch (phydev->speed) {
>> +			case SPEED_1000:
>> +				ctrl |= MREGBIT_SPEED_1000M;
>> +				break;
>> +			case SPEED_100:
>> +				ctrl |= MREGBIT_SPEED_100M;
>> +				break;
>> +			case SPEED_10:
>> +				ctrl |= MREGBIT_SPEED_10M;
>> +				break;
>> +			default:
>> +				netdev_err(dev, "Unknown speed: %d\n",
>> +					   phydev->speed);
>> +				phydev->speed = SPEED_UNKNOWN;
>> +				break;
>> +			}
>> +
>> +			if (phydev->speed != SPEED_UNKNOWN)
>> +				priv->speed = phydev->speed;
>> +		}
>> +
>> +		emac_wr(priv, MAC_GLOBAL_CONTROL, ctrl);
>> +
>> +		if (!priv->link) {
>> +			priv->link = true;
>> +			link_changed = true;
>> +		}
>> +	} else if (priv->link) {
>> +		priv->link = false;
>> +		link_changed = true;
>> +		priv->duplex = DUPLEX_UNKNOWN;
>> +		priv->speed = SPEED_UNKNOWN;
>> +	}
>> +
>> +	if (link_changed)
>> +		phy_print_status(phydev);
> Can this ever be false?
>
I will remove these checks in next version.
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
>> +	if (IS_ERR_OR_NULL(phydev)) {
>> +		dev_err(dev, "Could not attach to PHY\n");
>> +		ret = phydev ? PTR_ERR(phydev) : -ENODEV;
>> +		goto err_node_put;
>> +	}
>> +
>> +	dev_info(dev, "%s: attached to PHY (UID 0x%x) Link = %d\n", ndev->name,
>> +		 phydev->phy_id, phydev->link);
> Don't spam the log. Only output something if something unexpected
> happens, an error etc.
I will remove this in next version.
>> +static int emac_mdio_init(struct emac_priv *priv)
>> +{
>> +	struct device *dev = &priv->pdev->dev;
>> +	struct device_node *mii_np;
>> +	struct mii_bus *mii;
>> +	int ret;
>> +
>> +	mii_np = of_get_child_by_name(dev->of_node, "mdio-bus");
>> +	if (!mii_np) {
>> +		if (of_phy_is_fixed_link(dev->of_node)) {
>> +			if ((of_phy_register_fixed_link(dev->of_node) < 0))
>> +				return -ENODEV;
>> +
>> +			return 0;
>> +		}
>> +
>> +		dev_err(dev, "no %s child node found", "mdio-bus");
> Why is that an error?
I will remove this in the next version.
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!of_device_is_available(mii_np)) {
>> +		ret = -ENODEV;
>> +		goto err_put_node;
>> +	}
>> +
>> +	mii = devm_mdiobus_alloc(dev);
>> +	priv->mii = mii;
>> +
>> +	if (!mii) {
>> +		ret = -ENOMEM;
>> +		goto err_put_node;
>> +	}
>> +	mii->priv = priv;
>> +	mii->name = "emac mii";
>> +	mii->read = emac_mii_read;
>> +	mii->write = emac_mii_write;
>> +	mii->parent = dev;
>> +	mii->phy_mask = 0xffffffff;
>> +	snprintf(mii->id, MII_BUS_ID_SIZE, "%s", priv->pdev->name);
>> +
>> +	ret = devm_of_mdiobus_register(dev, mii, mii_np);
>> +	if (ret) {
>> +		dev_err_probe(dev, ret, "Failed to register mdio bus.\n");
>> +		goto err_put_node;
>> +	}
>> +
>> +	priv->phy = phy_find_first(mii);
>> +	if (!priv->phy) {
>> +		dev_err(dev, "no PHY found\n");
>> +		ret = -ENODEV;
> Please don't use phy_find_first(). Use phy-handle to point to the phy.
>
I will remove this next version.
>> +static void emac_ethtool_get_regs(struct net_device *dev,
>> +				  struct ethtool_regs *regs, void *space)
>> +{
>> +	struct emac_priv *priv = netdev_priv(dev);
>> +	u32 *reg_space = space;
>> +	int i;
>> +
>> +	regs->version = 1;
>> +
>> +	memset(reg_space, 0x0, EMAC_REG_SPACE_SIZE);
> Is that needed?
I will remove in next version.
>> +static int emac_get_link_ksettings(struct net_device *ndev,
>> +				   struct ethtool_link_ksettings *cmd)
>> +{
>> +	if (!ndev->phydev)
>> +		return -ENODEV;
>> +
>> +	phy_ethtool_ksettings_get(ndev->phydev, cmd);
> phy_ethtool_get_link_ksettings().
I will use phy_ethtool_{get,set}_link_ksettings in next version.
>> +	if (priv->tx_delay > EMAC_MAX_DELAY_PS) {
>> +		dev_err(&pdev->dev, "tx-internal-delay-ps delay too large, clamped");
> Please return -EINVAL;
>
>> +		priv->tx_delay = EMAC_MAX_DELAY_PS;
>> +	}
>> +
>> +	if (priv->rx_delay > EMAC_MAX_DELAY_PS) {
>> +		dev_err(&pdev->dev, "rx-internal-delay-ps delay too large, clamped");
> and here. The device tree is broken, and we want the developer to
> notice and fix it. The easiest way to do that is to refuse to load the
> driver.
>
>> +		priv->rx_delay = EMAC_MAX_DELAY_PS;
>> +	}
>> +
>> +	if (priv->tx_delay || priv->rx_delay) {
> Why the if () ?
>
>> +		priv->tx_delay = delay_ps_to_unit(priv->tx_delay);
>> +		priv->rx_delay = delay_ps_to_unit(priv->rx_delay);
>> +
>> +		/* Show rounded result here for convenience */
>> +		dev_info(&pdev->dev,
>> +			 "MAC internal delay: TX: %u ps, RX: %u ps",
>> +			 delay_unit_to_ps(priv->tx_delay),
>> +			 delay_unit_to_ps(priv->rx_delay));
> Please don't. 
I will simplify the checking logic and remove the print in next version.
>> +static void emac_shutdown(struct platform_device *pdev)
>> +{
>> +}

I will get rid of it in next version.

Thanks again for the review.

Regards,
Vivian "dramforever" Wang

> Since it is empty, is it needed?
>
> 	Andrew


