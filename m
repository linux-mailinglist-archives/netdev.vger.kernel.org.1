Return-Path: <netdev+bounces-211913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AF1B1C6F0
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 15:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3329B172580
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C7028C2A4;
	Wed,  6 Aug 2025 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nIY78tin"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A628A1C3;
	Wed,  6 Aug 2025 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754487630; cv=none; b=nDisfZHt1upCjWX1ZE7Fgvy2IifW6Gpqd72+6yXD352Giq98KZROtYQK3nei0ZMs6/sWdYy8ct3LmotRDk+fsQqAZE9wX1eC90Uf5pgH5VlMidCoc/bsrFCStkuR0v2DEZfkqrkIHrmu7nWMu0jxVvMQNFMaK+5WxxvtMsfuWrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754487630; c=relaxed/simple;
	bh=MkNVePKaAtuMX3vdT9s5Vj7A86laGiTevIquJ1MdWuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9eLIgUypG2bd2Z4YtJfvXzJTQss2y7yaYsavX7iZ3BY26mIqHyUqOEejRWp06TdjW+zEyDGDiHHKJhlD1/oZwDhVaZjxLbRlgTJ4SM4ZRuiThvGhmOrGXWZMBmLdguU7hPXUeHz6Gx5LGoK4eM//Q0wN8t74995AlW5IybcTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nIY78tin; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B1F0442B0;
	Wed,  6 Aug 2025 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754487619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzHkT3WE92PmMWc+8Wx1o6wRkysHoH1vVX63z1f0iPs=;
	b=nIY78tin/B4Vu1eXitY5ww0ofms0ki/KV2ni+Q5JH06cIjGkRQ73GpJznI50Tuimhzq4z7
	r2+0O9K6kI5Tx5dGLOPlF9ZYkgl9W6CyS1ALPxAd/TAyEQYkZAqjgGTJV0KGoGzbMTIixE
	sj6Q8UChdTQtC7e3RmsWU4FCjqhUKAVLNbv6r7VAgSBhsLKjIB/QA5Qra60chvts8c3wH9
	PXurlKXWtMnKx1pMW+c3peL9nvEQ/5J3Dbv10R7rfhr53+I05nwUbAJalA68YdC2Ab4HY/
	F3jrMBkqL6aFuVWMSm6viI4+moxXrwntjhenlB4OunXCT7b2OHkTs3Fq7akq/A==
Message-ID: <f979f4ef-53b6-418b-b1d2-1bc733feba9b@bootlin.com>
Date: Wed, 6 Aug 2025 15:40:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 2/5] net: ti: prueth: Adds ICSSM Ethernet
 driver
To: Parvathi Pudi <parvathi@couthit.com>, danishanwar@ti.com,
 rogerq@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, ssantosh@kernel.org,
 richardcochran@gmail.com, s.hauer@pengutronix.de, m-karicheri2@ti.com,
 glaroque@baylibre.com, afd@ti.com, saikrishnag@marvell.com,
 m-malladi@ti.com, jacob.e.keller@intel.com, kory.maincent@bootlin.com,
 diogo.ivo@siemens.com, javier.carrasco.cruz@gmail.com, horms@kernel.org,
 s-anna@ti.com, basharath@couthit.com
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 vadim.fedorenko@linux.dev, pratheesh@ti.com, prajith@ti.com,
 vigneshr@ti.com, praneeth@ti.com, srk@ti.com, rogerq@ti.com,
 krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com
References: <20250724072535.3062604-1-parvathi@couthit.com>
 <20250724072535.3062604-3-parvathi@couthit.com>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20250724072535.3062604-3-parvathi@couthit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegrshhtihgvnhcuvehurhhuthgthhgvthcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeiheeihefgheetkeeiffekgeeigeetheejffejgeegkeffgedugeefkedtfeduteenucffohhmrghinhepthhirdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegtddprhgtphhtthhopehprghrvhgrthhhihestghouhhthhhithdrtghomhdprhgtphhtthhopegurghnihhshhgrnhifrghrsehtihdrtghomhdprhgtphhtthhopehrohhgvghrqheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegur
 ghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Parvathi,

On 7/24/25 9:23 AM, Parvathi Pudi wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> Updates Kernel configuration to enable PRUETH driver and its dependencies
> along with makefile changes to add the new PRUETH driver.
> 
> Changes includes init and deinit of ICSSM PRU Ethernet driver including
> net dev registration and firmware loading for DUAL-MAC mode running on
> PRU-ICSS2 instance.
> 
> Changes also includes link handling, PRU booting, default firmware loading
> and PRU stopping using existing remoteproc driver APIs.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
> ---
>   drivers/net/ethernet/ti/Kconfig              |  12 +
>   drivers/net/ethernet/ti/Makefile             |   3 +
>   drivers/net/ethernet/ti/icssm/icssm_prueth.c | 610 +++++++++++++++++++
>   drivers/net/ethernet/ti/icssm/icssm_prueth.h | 100 +++
>   4 files changed, 725 insertions(+)
>   create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth.c
>   create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth.h
> 
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index a07c910c497a..ab20f22524cb 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -229,4 +229,16 @@ config TI_ICSS_IEP
>   	  To compile this driver as a module, choose M here. The module
>   	  will be called icss_iep.
>   
> +config TI_PRUETH
> +	tristate "TI PRU Ethernet EMAC driver"
> +	depends on PRU_REMOTEPROC
> +	depends on NET_SWITCHDEV
> +	select TI_ICSS_IEP
> +	imply PTP_1588_CLOCK
> +	help
> +	  Some TI SoCs has Programmable Realtime Units (PRUs) cores which can
> +	  support Single or Dual Ethernet ports with help of firmware code running
> +	  on PRU cores. This driver supports remoteproc based communication to
> +	  PRU firmware to expose ethernet interface to Linux.
> +
>   endif # NET_VENDOR_TI
> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
> index cbcf44806924..93c0a4d0e33a 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -3,6 +3,9 @@
>   # Makefile for the TI network device drivers.
>   #
>   
> +obj-$(CONFIG_TI_PRUETH) += icssm-prueth.o
> +icssm-prueth-y := icssm/icssm_prueth.o
> +
>   obj-$(CONFIG_TI_CPSW) += cpsw-common.o
>   obj-$(CONFIG_TI_DAVINCI_EMAC) += cpsw-common.o
>   obj-$(CONFIG_TI_CPSW_SWITCHDEV) += cpsw-common.o
> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> new file mode 100644
> index 000000000000..375fd636684d
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> @@ -0,0 +1,610 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Texas Instruments ICSSM Ethernet Driver
> + *
> + * Copyright (C) 2018-2022 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + */
> +
> +#include <linux/etherdevice.h>
> +#include <linux/genalloc.h>
> +#include <linux/if_bridge.h>
> +#include <linux/if_hsr.h>
> +#include <linux/if_vlan.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/net_tstamp.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_mdio.h>
> +#include <linux/of_net.h>
> +#include <linux/platform_device.h>
> +#include <linux/phy.h>
> +#include <linux/remoteproc/pruss.h>
> +#include <linux/ptp_classify.h>
> +#include <linux/regmap.h>
> +#include <linux/remoteproc.h>
> +#include <net/pkt_cls.h>
> +
> +#include "icssm_prueth.h"
> +
> +/* called back by PHY layer if there is change in link state of hw port*/
> +static void icssm_emac_adjust_link(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct phy_device *phydev = emac->phydev;
> +	bool new_state = false;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&emac->lock, flags);
> +
> +	if (phydev->link) {
> +		/* check the mode of operation */
> +		if (phydev->duplex != emac->duplex) {
> +			new_state = true;
> +			emac->duplex = phydev->duplex;
> +		}
> +		if (phydev->speed != emac->speed) {
> +			new_state = true;
> +			emac->speed = phydev->speed;
> +		}
> +		if (!emac->link) {
> +			new_state = true;
> +			emac->link = 1;
> +		}
> +	} else if (emac->link) {
> +		new_state = true;
> +		emac->link = 0;
> +	}
> +
> +	if (new_state)
> +		phy_print_status(phydev);
> +
> +	if (emac->link) {
> +	       /* reactivate the transmit queue if it is stopped */
> +		if (netif_running(ndev) && netif_queue_stopped(ndev))
> +			netif_wake_queue(ndev);
> +	} else {
> +		if (!netif_queue_stopped(ndev))
> +			netif_stop_queue(ndev);
> +	}
> +
> +	spin_unlock_irqrestore(&emac->lock, flags);
> +}
> +
> +static int icssm_emac_set_boot_pru(struct prueth_emac *emac,
> +				   struct net_device *ndev)
> +{
> +	const struct prueth_firmware *pru_firmwares;
> +	struct prueth *prueth = emac->prueth;
> +	const char *fw_name;
> +	int ret;
> +
> +	pru_firmwares = &prueth->fw_data->fw_pru[emac->port_id - 1];
> +	fw_name = pru_firmwares->fw_name[prueth->eth_type];
> +	if (!fw_name) {
> +		netdev_err(ndev, "eth_type %d not supported\n",
> +			   prueth->eth_type);
> +		return -ENODEV;
> +	}
> +
> +	ret = rproc_set_firmware(emac->pru, fw_name);
> +	if (ret) {
> +		netdev_err(ndev, "failed to set PRU0 firmware %s: %d\n",
> +			   fw_name, ret);
> +		return ret;
> +	}
> +
> +	ret = rproc_boot(emac->pru);
> +	if (ret) {
> +		netdev_err(ndev, "failed to boot PRU0: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * icssm_emac_ndo_open - EMAC device open
> + * @ndev: network adapter device
> + *
> + * Called when system wants to start the interface.
> + *
> + * Return: 0 for a successful open, or appropriate error code
> + */
> +static int icssm_emac_ndo_open(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	int ret;
> +
> +	ret = icssm_emac_set_boot_pru(emac, ndev);
> +	if (ret)
> +		return ret;
> +
> +	/* start PHY */
> +	phy_start(emac->phydev);
> +
> +	return 0;
> +}
> +
> +/**
> + * icssm_emac_ndo_stop - EMAC device stop
> + * @ndev: network adapter device
> + *
> + * Called when system wants to stop or down the interface.
> + *
> + * Return: Always 0 (Success)
> + */
> +static int icssm_emac_ndo_stop(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +
> +	/* stop PHY */
> +	phy_stop(emac->phydev);
> +
> +	rproc_shutdown(emac->pru);
> +
> +	return 0;
> +}
> +
> +static const struct net_device_ops emac_netdev_ops = {
> +	.ndo_open = icssm_emac_ndo_open,
> +	.ndo_stop = icssm_emac_ndo_stop,
> +};
> +
> +/* get emac_port corresponding to eth_node name */
> +static int icssm_prueth_node_port(struct device_node *eth_node)
> +{
> +	u32 port_id;
> +	int ret;
> +
> +	ret = of_property_read_u32(eth_node, "reg", &port_id);
> +	if (ret)
> +		return ret;
> +
> +	if (port_id == 0)
> +		return PRUETH_PORT_MII0;
> +	else if (port_id == 1)
> +		return PRUETH_PORT_MII1;
> +	else
> +		return PRUETH_PORT_INVALID;
> +}
> +
> +/* get MAC instance corresponding to eth_node name */
> +static int icssm_prueth_node_mac(struct device_node *eth_node)
> +{
> +	u32 port_id;
> +	int ret;
> +
> +	ret = of_property_read_u32(eth_node, "reg", &port_id);
> +	if (ret)
> +		return ret;
> +
> +	if (port_id == 0)
> +		return PRUETH_MAC0;
> +	else if (port_id == 1)
> +		return PRUETH_MAC1;
> +	else
> +		return PRUETH_MAC_INVALID;
> +}
> +
> +static int icssm_prueth_netdev_init(struct prueth *prueth,
> +				    struct device_node *eth_node)
> +{
> +	struct prueth_emac *emac;
> +	struct net_device *ndev;
> +	enum prueth_port port;
> +	enum prueth_mac mac;
> +	int ret;
> +
> +	port = icssm_prueth_node_port(eth_node);
> +	if (port == PRUETH_PORT_INVALID)
> +		return -EINVAL;
> +
> +	mac = icssm_prueth_node_mac(eth_node);
> +	if (mac == PRUETH_MAC_INVALID)
> +		return -EINVAL;
> +
> +	ndev = devm_alloc_etherdev(prueth->dev, sizeof(*emac));
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	SET_NETDEV_DEV(ndev, prueth->dev);
> +	emac = netdev_priv(ndev);
> +	prueth->emac[mac] = emac;
> +	emac->prueth = prueth;
> +	emac->ndev = ndev;
> +	emac->port_id = port;
> +
> +	/* by default eth_type is EMAC */
> +	switch (port) {
> +	case PRUETH_PORT_MII0:
> +		emac->pru = prueth->pru0;
> +		break;
> +	case PRUETH_PORT_MII1:
> +		emac->pru = prueth->pru1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	/* get mac address from DT and set private and netdev addr */
> +	ret = of_get_ethdev_address(eth_node, ndev);
> +	if (!is_valid_ether_addr(ndev->dev_addr)) {
> +		eth_hw_addr_random(ndev);
> +		dev_warn(prueth->dev, "port %d: using random MAC addr: %pM\n",
> +			 port, ndev->dev_addr);
> +	}
> +	ether_addr_copy(emac->mac_addr, ndev->dev_addr);
> +
> +	/* connect PHY */
> +	emac->phydev = of_phy_get_and_connect(ndev, eth_node,
> +					      icssm_emac_adjust_link);
> +	if (!emac->phydev) {
> +		dev_dbg(prueth->dev, "PHY connection failed\n");
> +		ret = -EPROBE_DEFER;
> +		goto free;
> +	}
> +
> +	/* remove unsupported modes */
> +	phy_remove_link_mode(emac->phydev, ETHTOOL_LINK_MODE_10baseT_Full_BIT);
> +
> +	phy_remove_link_mode(emac->phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
> +	phy_remove_link_mode(emac->phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
> +
> +	phy_remove_link_mode(emac->phydev, ETHTOOL_LINK_MODE_Pause_BIT);
> +	phy_remove_link_mode(emac->phydev, ETHTOOL_LINK_MODE_Asym_Pause_BIT);
> +
> +	ndev->netdev_ops = &emac_netdev_ops;
> +

I think ndev->dev.of_node should be set to eth_node here.

If ndev->dev.of_node isn't set, of_find_net_device_by_node() won't find 
the iccsm_prueth ports and their of_node won't be available in sysfs 
(which, in my case, leads to issues during the probe of a switch 
connected to them)


Kind regards,
Bastien

