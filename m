Return-Path: <netdev+bounces-200115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD8DAE33F4
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 05:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D441886F64
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 03:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E75D19FA93;
	Mon, 23 Jun 2025 03:29:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9641A23AD;
	Mon, 23 Jun 2025 03:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750649356; cv=none; b=Z7Uno/FEM1ZsS1PxOkN14Kb0Tkwi6QEfJqXfTWpeJyx51HC5A9p2brpWe7r6zG9nWai/9ADIF5cCHmwXP0Ln6yfEX5ANQl1amaX58nHnhLfQIc+UwLwMNHSxUwlW+6yiyTEpQHHSsFo3W2bM2RuEAAy7HDDVf59jC6poo4OUJ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750649356; c=relaxed/simple;
	bh=+rRuBhBzIYUKAbpQE+AXBRiE27nUn5eOiSsOQKj5bZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvGZ6GVtQQatXiPMYCgRxwswJB7V0aA1kq8MU1UVOPidylKa08Nv4eCR4+iSoYj30jd3hVy72XwbVmfUyFmhLXd5R1gJ4A6sryA1tE5kfP/Ycp3S6cUTbVKJcXQ8jV4d3+9DnKcKtjHXndeX0TilXhEKrZItyOyXfGg7yIgdcyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.33.186] (unknown [210.73.43.2])
	by APP-01 (Coremail) with SMTP id qwCowAAn1tTYyVhoj96TCA--.26777S2;
	Mon, 23 Jun 2025 11:28:27 +0800 (CST)
Message-ID: <ebe1a61b-0ba5-455a-b29b-5e1506abe900@iscas.ac.cn>
Date: Mon, 23 Jun 2025 11:28:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/6] net: spacemit: Add K1 Ethernet MAC
To: Andrew Lunn <andrew@lunn.ch>
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
References: <20250618-net-k1-emac-v2-0-94f5f07227a8@iscas.ac.cn>
 <20250618-net-k1-emac-v2-2-94f5f07227a8@iscas.ac.cn>
 <e55d8a16-5e2c-4a46-99fd-8ea485269843@lunn.ch>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <e55d8a16-5e2c-4a46-99fd-8ea485269843@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qwCowAAn1tTYyVhoj96TCA--.26777S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFyrWr1xAw47AFyUJw4rAFb_yoW3KFW5pF
	W8KFWkAF1Utry3ur1FqrWUAFnFvF18Gr409FyFva4Yk3sIkr18Cry8GrW7CayrCr909r4j
	vw4jva43W3Z8KrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr1j6F
	4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUYvJmUUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Andrew,

Thank you for your suggestions.

On 6/19/25 05:17, Andrew Lunn wrote:
>> +/* The sizes (in bytes) of a ethernet packet */
>> +#define ETHERNET_HEADER_SIZE		14
> Please replace with ETH_HLEN
>
>> +#define MINIMUM_ETHERNET_FRAME_SIZE	64 /* Incl. FCS */
> I assume this device supports VLANS? If so, the minimum should
> actually be 68. You can then use ETH_MIN_MTU
>
>> +#define ETHERNET_FCS_SIZE		4
> ETH_FCS_LEN

I will fix usage of these constants in next version.

>> +static int emac_tx_mem_map(struct emac_priv *priv, struct sk_buff *skb,
>> +			   u32 max_tx_len, u32 frag_num)
>> +{
>> +	struct emac_desc tx_desc, *tx_desc_addr;
>> +	u32 skb_linear_len = skb_headlen(skb);
>> +	struct emac_tx_desc_buffer *tx_buf;
>> +	u32 len, i, f, first, buf_idx = 0;
>> +	struct emac_desc_ring *tx_ring;
>> +	phys_addr_t addr;
>> +
>> +	tx_ring = &priv->tx_ring;
>> +
>> +	i = tx_ring->head;
>> +	first = i;
>> +
>> +	if (++i == tx_ring->total_cnt)
>> +		i = 0;
>> +
>> +	/* If the data is fragmented */
>> +	for (f = 0; f < frag_num; f++) {
>> +		const skb_frag_t *frag = &skb_shinfo(skb)->frags[f];
>> +
>> +		len = skb_frag_size(frag);
>> +
>> +		buf_idx = (f + 1) % 2;
>> +
>> +		/* First frag fill into second buffer of first descriptor */
>> +		if (f == 0) {
>> +			tx_buf = &tx_ring->tx_desc_buf[first];
>> +			tx_desc_addr = &((struct emac_desc *)
>> +						 tx_ring->desc_addr)[first];
>> +			memset(&tx_desc, 0, sizeof(tx_desc));
>> +		} else {
>> +			/*
>> +			 * From second frags to more frags,
>> +			 * we only get new descriptor when frag num is odd.
>> +			 */
>> +			if (!buf_idx) {
>> +				tx_buf = &tx_ring->tx_desc_buf[i];
>> +				tx_desc_addr = &((struct emac_desc *)
>> +							 tx_ring->desc_addr)[i];
>> +				memset(&tx_desc, 0, sizeof(tx_desc));
>> +			}
>> +		}
>> +		tx_buf->buf[buf_idx].dma_len = len;
>> +
>> +		addr = skb_frag_dma_map(&priv->pdev->dev, frag, 0,
>> +					skb_frag_size(frag), DMA_TO_DEVICE);
>> +
>> +		if (dma_mapping_error(&priv->pdev->dev, addr)) {
>> +			netdev_err(priv->ndev, "fail to map dma page: %d\n", f);
>> +			goto dma_map_err;
>> +		}
>> +		tx_buf->buf[buf_idx].dma_addr = addr;
>> +
>> +		tx_buf->buf[buf_idx].map_as_page = true;
>> +
>> +		/* Every desc has two buffers for packet */
>> +		if (buf_idx) {
>> +			tx_desc.buffer_addr_2 = addr;
>> +			tx_desc.desc1 |= make_buf_size_2(len);
>> +		} else {
>> +			tx_desc.buffer_addr_1 = addr;
>> +			tx_desc.desc1 = make_buf_size_1(len);
>> +
>> +			if (++i == tx_ring->total_cnt) {
>> +				tx_desc.desc1 |= TX_DESC_1_END_RING;
>> +				i = 0;
>> +			}
>> +		}
>> +
>> +		if (f == 0) {
>> +			*tx_desc_addr = tx_desc;
>> +			continue;
>> +		}
>> +
>> +		if (f == frag_num - 1) {
>> +			tx_desc.desc1 |= TX_DESC_1_LAST_SEGMENT;
>> +			tx_buf->skb = skb;
>> +			if (emac_tx_should_interrupt(priv, frag_num + 1))
>> +				tx_desc.desc1 |=
>> +					TX_DESC_1_INTERRUPT_ON_COMPLETION;
>> +		}
>> +
>> +		*tx_desc_addr = tx_desc;
>> +		dma_wmb();
>> +		WRITE_ONCE(tx_desc_addr->desc0, tx_desc.desc0 | TX_DESC_0_OWN);
>> +	}
>> +
>> +	/* fill out first descriptor for skb linear data */
>> +	tx_buf = &tx_ring->tx_desc_buf[first];
>> +
>> +	tx_buf->buf[0].dma_len = skb_linear_len;
>> +
>> +	addr = dma_map_single(&priv->pdev->dev, skb->data, skb_linear_len,
>> +			      DMA_TO_DEVICE);
>> +	if (dma_mapping_error(&priv->pdev->dev, addr)) {
>> +		netdev_err(priv->ndev, "dma_map_single failed\n");
>> +		goto dma_map_err;
>> +	}
>> +
>> +	tx_buf->buf[0].dma_addr = addr;
>> +
>> +	tx_buf->buf[0].buff_addr = skb->data;
>> +	tx_buf->buf[0].map_as_page = false;
>> +
>> +	/* Fill TX descriptor */
>> +	tx_desc_addr = &((struct emac_desc *)tx_ring->desc_addr)[first];
>> +
>> +	tx_desc = *tx_desc_addr;
>> +
>> +	tx_desc.buffer_addr_1 = addr;
>> +	tx_desc.desc1 |= make_buf_size_1(skb_linear_len);
>> +	tx_desc.desc1 |= TX_DESC_1_FIRST_SEGMENT;
>> +
>> +	/* If last desc for ring, set end ring flag */
>> +	if (first == tx_ring->total_cnt - 1)
>> +		tx_desc.desc1 |= TX_DESC_1_END_RING;
>> +
>> +	/*
>> +	 * If frag_num is more than 1, data need another desc, so current
>> +	 * descriptor isn't last piece of packet data.
>> +	 */
>> +	tx_desc.desc1 |= frag_num > 1 ? 0 : TX_DESC_1_LAST_SEGMENT;
>> +
>> +	if (frag_num <= 1 && emac_tx_should_interrupt(priv, 1))
>> +		tx_desc.desc1 |= TX_DESC_1_INTERRUPT_ON_COMPLETION;
>> +
>> +	/* Only last descriptor has skb pointer */
>> +	if (tx_desc.desc1 & TX_DESC_1_LAST_SEGMENT)
>> +		tx_buf->skb = skb;
>> +
>> +	*tx_desc_addr = tx_desc;
>> +	dma_wmb();
>> +	WRITE_ONCE(tx_desc_addr->desc0, tx_desc.desc0 | TX_DESC_0_OWN);
>> +
>> +	emac_dma_start_transmit(priv);
>> +
>> +	tx_ring->head = i;
>> +
>> +	return 0;
>> +
>> +dma_map_err:
>> +	dev_kfree_skb_any(skb);
>> +	priv->ndev->stats.tx_dropped++;
>> +	return 0;
>> +}
> This is a rather large function. Can parts of it be pulled out into
> helpers? The Coding style document says:
>
>   Functions should be short and sweet, and do just one thing. They
>   should fit on one or two screenfuls of text (the ISO/ANSI screen
>   size is 80x24, as we all know), and do one thing and do that well.
I will reorganize this function in next version.
>> +static int emac_mdio_init(struct emac_priv *priv)
>> +{
>> +	struct device *dev = &priv->pdev->dev;
>> +	struct device_node *mii_np;
>> +	struct mii_bus *mii;
>> +	int ret;
>> +
>> +	mii_np = of_get_available_child_by_name(dev->of_node, "mdio-bus");
>> +	if (!mii_np) {
>> +		if (of_phy_is_fixed_link(dev->of_node)) {
>> +			if ((of_phy_register_fixed_link(dev->of_node) < 0))
>> +				return -ENODEV;
>> +
>> +			return 0;
>> +		}
>> +
>> +		dev_info(dev, "No mdio-bus child node found");
>> +		return 0;
>> +	}
> An mdio-bus node is normally optional. You can pass NULL to
> devm_of_mdiobus_register() and it will do the correct thing, register
> the bus, and scan it for devices.
>
> An MDIO bus and fixed link are also not mutually exclusive. When the
> MAC is connected to an Ethernet switch, you often see an fixed-link,
> and have an MDIO bus, with the switches management interface being
> MDIO.

I understand now. I will fix the handling of fixed-link and mdio-bus in
the next version.

>> +static int emac_ethtool_get_regs_len(struct net_device *dev)
>> +{
>> +	return EMAC_REG_SPACE_SIZE;
>> +}
>> +
>> +static void emac_ethtool_get_regs(struct net_device *dev,
>> +				  struct ethtool_regs *regs, void *space)
>> +{
>> +	struct emac_priv *priv = netdev_priv(dev);
>> +	u32 *reg_space = space;
>> +	int i;
>> +
>> +	regs->version = 1;
>> +
>> +	for (i = 0; i < EMAC_DMA_REG_CNT; i++)
>> +		reg_space[i] = emac_rd(priv, DMA_CONFIGURATION + i * 4);
>> +
>> +	for (i = 0; i < EMAC_MAC_REG_CNT; i++)
>> +		reg_space[i + EMAC_DMA_REG_CNT] =
>> +			emac_rd(priv, MAC_GLOBAL_CONTROL + i * 4);
>> +}
> Given this implementation, it would be more readable, and less future
> extension error prone, if emac_ethtool_get_regs_len() returned
>
> EMAC_DMA_REG_CNT + EMAC_MAC_REG_CNT
I will simplify this next version.
>> +static int emac_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
>> +{
>> +	if (!netif_running(ndev))
>> +		return -EINVAL;
>> +
>> +	return phy_mii_ioctl(ndev->phydev, rq, cmd);
>> +}
> phy_do_ioctl_running().
I will simplify in next version.
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
> The documentation for of_phy_connect() says:
>
>  * If successful, returns a pointer to the phy_device with the embedded
>  * struct device refcount incremented by one, or NULL on failure. The
>  * refcount must be dropped by calling phy_disconnect() or phy_detach().
>
> An error code is not possible. So you can simply this.
> 	

I will simplify this in next version.

Thanks,
Vivian "dramforever" Wang


