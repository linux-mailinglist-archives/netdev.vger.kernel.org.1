Return-Path: <netdev+bounces-203693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B37D5AF6C59
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786BA4E72DA
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EE42BDC2F;
	Thu,  3 Jul 2025 07:58:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B185B29B8D3;
	Thu,  3 Jul 2025 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751529510; cv=none; b=OVDxYaekLS/T6VevD6Egc/HXxCXDFTG6jq+vpZ6JZMCMhGNDfRt7DjBqC1QSFH821jahELgONN85B7NgdXRUc1LiFRaC6NpG2a/GbeLT2P0qsN6+TVJfuhyroVXkGDx4Fr1VyfD1fTkjGu8fYg31xrQQU1eXv/mZxeYLdn4DcpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751529510; c=relaxed/simple;
	bh=xl9lrgJbw/eHsSEGyjSH+vpOnXH6veOcuAkE5UmNbKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvQRnqz9fNPidHZWHFpExIXLQOfutRdwlDB5BAtDcBegyLSTKxzArm3bmSEuS6NavcOndFUb+RmD9C9ZUrQgLh3v2dwfqqT3msML4P+42dFvG7VFyzvrTyhBl7YZP0oReHZ0ZGyV9ItzB2FW0N6WcDaOpX0oI/EOXExDvG82QbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.33.13] (unknown [210.73.43.2])
	by APP-01 (Coremail) with SMTP id qwCowABHc6cMOGZoYsmpAA--.34529S2;
	Thu, 03 Jul 2025 15:58:04 +0800 (CST)
Message-ID: <cdf502cd-1ed1-427c-9de0-743315568118@iscas.ac.cn>
Date: Thu, 3 Jul 2025 15:58:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/5] net: spacemit: Add K1 Ethernet MAC
To: Simon Horman <horms@kernel.org>
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
 <20250703071949.GJ41770@horms.kernel.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250703071949.GJ41770@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qwCowABHc6cMOGZoYsmpAA--.34529S2
X-Coremail-Antispam: 1UD129KBjvAXoWfGw1UWr4kCF4DKFWUXw13Jwb_yoW8JryfWo
	Z3Jrs2gF1fJFy7Cr18K34rtr1Yvw1Uur1UAay5A3Z3Wa4ay3WUuF45Ww45Aan8GF43JFWU
	WF9rJa4jyFs2yr15n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY97k0a2IF6w4kM7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0
	x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
	1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0
	I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07bVzVnUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Simon,

Thanks for the suggestions.

On 7/3/25 15:19, Simon Horman wrote:
> On Wed, Jul 02, 2025 at 02:01:41PM +0800, Vivian Wang wrote:
>
> ...
>
>> diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
> ...
>
>> +static int emac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>> +{
>> +	struct emac_priv *priv = netdev_priv(ndev);
>> +	int nfrags = skb_shinfo(skb)->nr_frags;
>> +	struct device *dev = &priv->pdev->dev;
>> +
>> +	if (unlikely(emac_tx_avail(priv) < nfrags + 1)) {
>> +		if (!netif_queue_stopped(ndev)) {
>> +			netif_stop_queue(ndev);
>> +			dev_err_ratelimited(dev, "TX ring full, stop TX queue\n");
>> +		}
>> +		return NETDEV_TX_BUSY;
>> +	}
>> +
>> +	emac_tx_mem_map(priv, skb);
>> +
>> +	ndev->stats.tx_packets++;
>> +	ndev->stats.tx_bytes += skb->len;
>> +
>> +	/* Make sure there is space in the ring for the next TX. */
>> +	if (unlikely(emac_tx_avail(priv) <= MAX_SKB_FRAGS + 2))
>> +		netif_stop_queue(ndev);
>> +
>> +	return NETDEV_TX_OK;
>> +}
>> +
>> +static u32 emac_tx_read_stat_cnt(struct emac_priv *priv, u8 cnt)
>> +{
>> +	u32 val, tmp;
>> +	int ret;
>> +
>> +	val = 0x8000 | cnt;
>> +	emac_wr(priv, MAC_TX_STATCTR_CONTROL, val);
>> +	val = emac_rd(priv, MAC_TX_STATCTR_CONTROL);
>> +
>> +	ret = readl_poll_timeout_atomic(priv->iobase + MAC_TX_STATCTR_CONTROL,
>> +					val, !(val & 0x8000), 100, 10000);
>> +
>> +	if (ret) {
>> +		netdev_err(priv->ndev, "read TX stat timeout\n");
>> +		return ret;
>> +	}
>> +
>> +	tmp = emac_rd(priv, MAC_TX_STATCTR_DATA_HIGH);
>> +	val = tmp << 16;
>> +	tmp = emac_rd(priv, MAC_TX_STATCTR_DATA_LOW);
>> +	val |= tmp;
>> +
>> +	return val;
>> +}
>> +
>> +static u32 emac_rx_read_stat_cnt(struct emac_priv *priv, u8 cnt)
>> +{
>> +	u32 val, tmp;
>> +	int ret;
>> +
>> +	val = 0x8000 | cnt;
>> +	emac_wr(priv, MAC_RX_STATCTR_CONTROL, val);
>> +	val = emac_rd(priv, MAC_RX_STATCTR_CONTROL);
>> +
>> +	ret = readl_poll_timeout_atomic(priv->iobase + MAC_RX_STATCTR_CONTROL,
>> +					val, !(val & 0x8000), 100, 10000);
>> +
>> +	if (ret) {
>> +		netdev_err(priv->ndev, "read RX stat timeout\n");
>> +		return ret;
>> +	}
>> +
>> +	tmp = emac_rd(priv, MAC_RX_STATCTR_DATA_HIGH);
>> +	val = tmp << 16;
>> +	tmp = emac_rd(priv, MAC_RX_STATCTR_DATA_LOW);
>> +	val |= tmp;
>> +
>> +	return val;
>> +}
>> +
>> +static int emac_set_mac_address(struct net_device *ndev, void *addr)
>> +{
>> +	struct emac_priv *priv = netdev_priv(ndev);
>> +	int ret = eth_mac_addr(ndev, addr);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* If running, set now; if not running it will be set in emac_up. */
>> +	if (netif_running(ndev))
>> +		emac_set_mac_addr(priv, ndev->dev_addr);
>> +
>> +	return 0;
>> +}
>> +
>> +static void emac_mac_multicast_filter_clear(struct emac_priv *priv)
>> +{
>> +	emac_wr(priv, MAC_MULTICAST_HASH_TABLE1, 0x0);
>> +	emac_wr(priv, MAC_MULTICAST_HASH_TABLE2, 0x0);
>> +	emac_wr(priv, MAC_MULTICAST_HASH_TABLE3, 0x0);
>> +	emac_wr(priv, MAC_MULTICAST_HASH_TABLE4, 0x0);
>> +}
>> +
>> +/* Configure Multicast and Promiscuous modes */
>> +static void emac_rx_mode_set(struct net_device *ndev)
>> +{
>> +	struct emac_priv *priv = netdev_priv(ndev);
>> +	u32 crc32, bit, reg, hash, val;
>> +	struct netdev_hw_addr *ha;
>> +	u32 mc_filter[4] = { 0 };
>> +
>> +	val = emac_rd(priv, MAC_ADDRESS_CONTROL);
>> +
>> +	val &= ~MREGBIT_PROMISCUOUS_MODE;
>> +
>> +	if (ndev->flags & IFF_PROMISC) {
>> +		/* Enable promisc mode */
>> +		val |= MREGBIT_PROMISCUOUS_MODE;
>> +	} else if ((ndev->flags & IFF_ALLMULTI) ||
>> +		   (netdev_mc_count(ndev) > HASH_TABLE_SIZE)) {
>> +		/* Accept all multicast frames by setting every bit */
>> +		emac_wr(priv, MAC_MULTICAST_HASH_TABLE1, 0xffff);
>> +		emac_wr(priv, MAC_MULTICAST_HASH_TABLE2, 0xffff);
>> +		emac_wr(priv, MAC_MULTICAST_HASH_TABLE3, 0xffff);
>> +		emac_wr(priv, MAC_MULTICAST_HASH_TABLE4, 0xffff);
>> +	} else if (!netdev_mc_empty(ndev)) {
>> +		emac_mac_multicast_filter_clear(priv);
>> +		netdev_for_each_mc_addr(ha, ndev) {
>> +			/* Calculate the CRC of the MAC address */
>> +			crc32 = ether_crc(ETH_ALEN, ha->addr);
>> +
>> +			/*
>> +			 * The hash table is an array of 4 16-bit registers. It
>> +			 * is treated like an array of 64 bits (bits[hash]). Use
>> +			 * the upper 6 bits of the above CRC as the hash value.
>> +			 */
>> +			hash = (crc32 >> 26) & 0x3F;
>> +			reg = hash / 16;
>> +			bit = hash % 16;
>> +			mc_filter[reg] |= BIT(bit);
>> +		}
>> +		emac_wr(priv, MAC_MULTICAST_HASH_TABLE1, mc_filter[0]);
>> +		emac_wr(priv, MAC_MULTICAST_HASH_TABLE2, mc_filter[1]);
>> +		emac_wr(priv, MAC_MULTICAST_HASH_TABLE3, mc_filter[2]);
>> +		emac_wr(priv, MAC_MULTICAST_HASH_TABLE4, mc_filter[3]);
>> +	}
>> +
>> +	emac_wr(priv, MAC_ADDRESS_CONTROL, val);
>> +}
>> +
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
>> +	frame_len = mtu + ETH_HLEN + ETH_FCS_LEN;
>> +
>> +	if (frame_len <= EMAC_DEFAULT_BUFSIZE)
>> +		priv->dma_buf_sz = EMAC_DEFAULT_BUFSIZE;
>> +	else if (frame_len <= EMAC_RX_BUF_2K)
>> +		priv->dma_buf_sz = EMAC_RX_BUF_2K;
>> +	else
>> +		priv->dma_buf_sz = EMAC_RX_BUF_4K;
>> +
>> +	ndev->mtu = mtu;
>> +
>> +	return 0;
>> +}
>> +
>> +static void emac_tx_timeout(struct net_device *ndev, unsigned int txqueue)
>> +{
>> +	struct emac_priv *priv = netdev_priv(ndev);
>> +
>> +	schedule_work(&priv->tx_timeout_task);
>> +}
>> +
>> +static int emac_mii_read(struct mii_bus *bus, int phy_addr, int regnum)
>> +{
>> +	struct emac_priv *priv = bus->priv;
>> +	u32 cmd = 0, val;
>> +	int ret;
>> +
>> +	cmd |= phy_addr & 0x1F;
>> +	cmd |= (regnum & 0x1F) << 5;
>> +	cmd |= MREGBIT_START_MDIO_TRANS | MREGBIT_MDIO_READ_WRITE;
>> +
>> +	emac_wr(priv, MAC_MDIO_DATA, 0x0);
>> +	emac_wr(priv, MAC_MDIO_CONTROL, cmd);
>> +
>> +	ret = readl_poll_timeout(priv->iobase + MAC_MDIO_CONTROL, val,
>> +				 !((val >> 15) & 0x1), 100, 10000);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	val = emac_rd(priv, MAC_MDIO_DATA);
>> +	return val;
>> +}
>> +
>> +static int emac_mii_write(struct mii_bus *bus, int phy_addr, int regnum,
>> +			  u16 value)
>> +{
>> +	struct emac_priv *priv = bus->priv;
>> +	u32 cmd = 0, val;
>> +	int ret;
>> +
>> +	emac_wr(priv, MAC_MDIO_DATA, value);
>> +
>> +	cmd |= phy_addr & 0x1F;
>> +	cmd |= (regnum & 0x1F) << 5;
>> +	cmd |= MREGBIT_START_MDIO_TRANS;
>> +
>> +	emac_wr(priv, MAC_MDIO_CONTROL, cmd);
>> +
>> +	ret = readl_poll_timeout(priv->iobase + MAC_MDIO_CONTROL, val,
>> +				 !((val >> 15) & 0x1), 100, 10000);
>> +
>> +	return ret;
>> +}
>> +
>> +static int emac_mdio_init(struct emac_priv *priv)
>> +{
>> +	struct device *dev = &priv->pdev->dev;
>> +	struct device_node *mii_np;
>> +	struct mii_bus *mii;
>> +	int ret;
>> +
>> +	mii = devm_mdiobus_alloc(dev);
>> +	if (!mii)
>> +		return -ENOMEM;
>> +
>> +	mii->priv = priv;
>> +	mii->name = "k1_emac_mii";
>> +	mii->read = emac_mii_read;
>> +	mii->write = emac_mii_write;
>> +	mii->parent = dev;
>> +	mii->phy_mask = 0xffffffff;
>> +	snprintf(mii->id, MII_BUS_ID_SIZE, "%s", priv->pdev->name);
>> +
>> +	mii_np = of_get_available_child_by_name(dev->of_node, "mdio-bus");
>> +
>> +	ret = devm_of_mdiobus_register(dev, mii, mii_np);
>> +	if (ret)
>> +		dev_err_probe(dev, ret, "Failed to register mdio bus\n");
>> +
>> +	of_node_put(mii_np);
>> +	return ret;
>> +}
>> +
>> +static void emac_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>> +{
>> +	int i;
>> +
>> +	switch (stringset) {
>> +	case ETH_SS_STATS:
>> +		for (i = 0; i < ARRAY_SIZE(emac_ethtool_stats); i++) {
>> +			memcpy(data, emac_ethtool_stats[i].str,
>> +			       ETH_GSTRING_LEN);
>> +			data += ETH_GSTRING_LEN;
>> +		}
>> +		break;
>> +	}
>> +}
>> +
>> +static int emac_get_sset_count(struct net_device *dev, int sset)
>> +{
>> +	switch (sset) {
>> +	case ETH_SS_STATS:
>> +		return ARRAY_SIZE(emac_ethtool_stats);
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
>> +
>> +static void emac_stats_update(struct emac_priv *priv)
>> +{
>> +	struct emac_hw_stats *hwstats = priv->hw_stats;
>> +	u32 *stats = (u32 *)hwstats;
>> +	int i;
>> +
>> +	for (i = 0; i < EMAC_TX_STATS_NUM; i++)
>> +		stats[i] = emac_tx_read_stat_cnt(priv, i);
>> +
>> +	for (i = 0; i < EMAC_RX_STATS_NUM; i++)
>> +		stats[i + EMAC_TX_STATS_NUM] = emac_rx_read_stat_cnt(priv, i);
>> +}
>> +
>> +static void emac_get_ethtool_stats(struct net_device *dev,
>> +				   struct ethtool_stats *stats, u64 *data)
>> +{
>> +	struct emac_priv *priv = netdev_priv(dev);
>> +	struct emac_hw_stats *hwstats;
>> +	unsigned long flags;
>> +	u32 *data_src;
>> +	u64 *data_dst;
>> +	int i;
>> +
>> +	hwstats = priv->hw_stats;
>> +
>> +	if (netif_running(dev) && netif_device_present(dev)) {
>> +		if (spin_trylock_irqsave(&priv->stats_lock, flags)) {
>> +			emac_stats_update(priv);
>> +			spin_unlock_irqrestore(&priv->stats_lock, flags);
>> +		}
>> +	}
>> +
>> +	data_dst = data;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(emac_ethtool_stats); i++) {
>> +		data_src = (u32 *)hwstats + emac_ethtool_stats[i].offset;
>> +		*data_dst++ = (u64)(*data_src);
>> +	}
>> +}
>> +
>> +static int emac_ethtool_get_regs_len(struct net_device *dev)
>> +{
>> +	return (EMAC_DMA_REG_CNT + EMAC_MAC_REG_CNT) * sizeof(u32);
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
>> +
>> +static void emac_get_drvinfo(struct net_device *dev,
>> +			     struct ethtool_drvinfo *info)
>> +{
>> +	strscpy(info->driver, DRIVER_NAME, sizeof(info->driver));
>> +	info->n_stats = ARRAY_SIZE(emac_ethtool_stats);
>> +}
>> +
>> +static void emac_tx_timeout_task(struct work_struct *work)
>> +{
>> +	struct net_device *ndev;
>> +	struct emac_priv *priv;
>> +
>> +	priv = container_of(work, struct emac_priv, tx_timeout_task);
>> +	ndev = priv->ndev;
>> +
>> +	rtnl_lock();
>> +
>> +	/* No need to reset if already down */
>> +	if (!netif_running(ndev)) {
>> +		rtnl_unlock();
>> +		return;
>> +	}
>> +
>> +	netdev_err(ndev, "MAC reset due to TX timeout\n");
>> +
>> +	netif_trans_update(ndev); /* prevent tx timeout */
>> +	dev_close(ndev);
>> +	dev_open(ndev, NULL);
>> +
>> +	rtnl_unlock();
>> +}
>> +
>> +static void emac_sw_init(struct emac_priv *priv)
>> +{
>> +	priv->dma_buf_sz = EMAC_DEFAULT_BUFSIZE;
>> +
>> +	priv->tx_ring.total_cnt = DEFAULT_TX_RING_NUM;
>> +	priv->rx_ring.total_cnt = DEFAULT_RX_RING_NUM;
>> +
>> +	spin_lock_init(&priv->stats_lock);
>> +
>> +	INIT_WORK(&priv->tx_timeout_task, emac_tx_timeout_task);
>> +
>> +	priv->tx_coal_frames = EMAC_TX_FRAMES;
>> +	priv->tx_coal_timeout = EMAC_TX_COAL_TIMEOUT;
>> +
>> +	timer_setup(&priv->txtimer, emac_tx_coal_timer, 0);
>> +}
>> +
> ...
>
>> +static irqreturn_t emac_interrupt_handler(int irq, void *dev_id)
>> +{
>> +	struct net_device *ndev = (struct net_device *)dev_id;
>> +	struct emac_priv *priv = netdev_priv(ndev);
>> +	bool should_schedule = false;
>> +	u32 status;
>> +	u32 clr = 0;
> nit: Reverse xmas tree - longest line to shortest - for
>      these local variable declarations please.
>
>      Edward Cree's tool can be helpful here:
>      https://github.com/ecree-solarflare/xmastree/commits/master/
>
> ...
>
Thanks for the script. I was indeed doing reverse xmas tree manually.

I will fix next version.

>> +static const struct net_device_ops emac_netdev_ops = {
>> +	.ndo_open               = emac_open,
>> +	.ndo_stop               = emac_close,
>> +	.ndo_start_xmit         = emac_start_xmit,
> I think that of emac_start_xmit should return netdev_tx_t rather than int
> to match the type of the .ndo_start_xmit member of this structure.
>
> Flagged by Clang 20.1.7 [-Wincompatible-function-pointer-types-strict]

I will fix the type next version.

Regards,
Vivian "dramforever" Wang

>> +	.ndo_set_mac_address    = emac_set_mac_address,
>> +	.ndo_eth_ioctl          = phy_do_ioctl_running,
>> +	.ndo_change_mtu         = emac_change_mtu,
>> +	.ndo_tx_timeout         = emac_tx_timeout,
>> +	.ndo_set_rx_mode        = emac_rx_mode_set,
>> +};
> ...


