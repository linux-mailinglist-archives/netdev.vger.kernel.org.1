Return-Path: <netdev+bounces-212437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C28B20601
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 12:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48067189E2B7
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 10:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25429244665;
	Mon, 11 Aug 2025 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="Y/N3DUhl"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085722253A7;
	Mon, 11 Aug 2025 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909110; cv=none; b=jG8dmKnFkQ6ZszFHctus7xunjva8PojUCjrJZLrUqzlZZf9fYxIaL/uXay9PkScNH2GzgMpxv1qGdoWttlNUP6LY5AOfFfD95nG6qeBJfbsSqvlrpzOPGgnErc+wNG71J10msT2op2eRdpY4pLb0WjmPnwoRPnrQRaFM3ukQZ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909110; c=relaxed/simple;
	bh=EcaXq2R0GxlBS/EertJRszBWBEPmQFQvraY/dqBWUJE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=AmfRgPF+cRGNspmOsw130Av8+fE6ADeNC1JWEAbPVPIdwiUaxVOCayMpjMwVcGQSRpIbQMVC0fZLBzb0TawD3hF7sMFxy/HNIk7xGQpGOj7DKrWXwA1oitwOz6HxFpdjKds5xQinbPhsBa+WE4v0H8QHdAlRV3Cr/Eg86BS33pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=Y/N3DUhl; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bQaUhFl7NKRcJ65QOzQF7ueB8aC+FXUZL/PGoBmsWbI=; b=Y/N3DUhljpZYut4i9ZoXD0EYmT
	W2E++O9nt1EDme/oPLp4S+O2ZRimO7zY1kdD85V2rxNpOXaZpD5vaPDiVqwKn0TYbzz7hV+Rq0Dsg
	toe5ESmWnjIe5GX3YkQP1PHteMDNvNGotdDPN8xEj9dJhPUZyjikZYf58gWmtUjLdL9XIYJfgNn00
	oF+sx4IiKv90cb2NefFPq7FVjbVaPNCAvxvLpCISeKwnoBallnGQhvb3MUktxTkp3Hv0/YhkvbmJz
	eydjmSwZZMyPoALzYdhN/dWDmEaBitPGjqfrg8riKBHMl1jXUdScCvuEVHivmXFEZPszfz+MeaH0s
	ngoHwhDw==;
Received: from [122.175.9.182] (port=22540 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1ulPYO-00000007eiE-26TH;
	Mon, 11 Aug 2025 06:14:57 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 1083617819EB;
	Mon, 11 Aug 2025 15:44:49 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id DF3251783F55;
	Mon, 11 Aug 2025 15:44:48 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2fe2ytI-SiST; Mon, 11 Aug 2025 15:44:48 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 846CA17820EC;
	Mon, 11 Aug 2025 15:44:48 +0530 (IST)
Date: Mon, 11 Aug 2025 15:44:48 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	robh <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, 
	conor+dt <conor+dt@kernel.org>, ssantosh <ssantosh@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	s hauer <s.hauer@pengutronix.de>, m-karicheri2 <m-karicheri2@ti.com>, 
	glaroque <glaroque@baylibre.com>, afd <afd@ti.com>, 
	saikrishnag <saikrishnag@marvell.com>, m-malladi <m-malladi@ti.com>, 
	jacob e keller <jacob.e.keller@intel.com>, 
	kory maincent <kory.maincent@bootlin.com>, 
	diogo ivo <diogo.ivo@siemens.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	horms <horms@kernel.org>, s-anna <s-anna@ti.com>, 
	basharath <basharath@couthit.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <202602590.150020.1754907288322.JavaMail.zimbra@couthit.local>
In-Reply-To: <f979f4ef-53b6-418b-b1d2-1bc733feba9b@bootlin.com>
References: <20250724072535.3062604-1-parvathi@couthit.com> <20250724072535.3062604-3-parvathi@couthit.com> <f979f4ef-53b6-418b-b1d2-1bc733feba9b@bootlin.com>
Subject: Re: [PATCH net-next v12 2/5] net: ti: prueth: Adds ICSSM Ethernet
 driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC138 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds ICSSM Ethernet driver
Thread-Index: Nwg1kw+pfvzN5Ss884cmC7NYeBr6bQ==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.couthit.com: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,
 
> On 7/24/25 9:23 AM, Parvathi Pudi wrote:
>> From: Roger Quadros <rogerq@ti.com>
>> 
>> Updates Kernel configuration to enable PRUETH driver and its dependencies
>> along with makefile changes to add the new PRUETH driver.
>> 
>> Changes includes init and deinit of ICSSM PRU Ethernet driver including
>> net dev registration and firmware loading for DUAL-MAC mode running on
>> PRU-ICSS2 instance.
>> 
>> Changes also includes link handling, PRU booting, default firmware loading
>> and PRU stopping using existing remoteproc driver APIs.
>> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
>> ---
>>   drivers/net/ethernet/ti/Kconfig              |  12 +
>>   drivers/net/ethernet/ti/Makefile             |   3 +
>>   drivers/net/ethernet/ti/icssm/icssm_prueth.c | 610 +++++++++++++++++++
>>   drivers/net/ethernet/ti/icssm/icssm_prueth.h | 100 +++
>>   4 files changed, 725 insertions(+)
>>   create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth.c
>>   create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth.h
>> 
>> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
>> index a07c910c497a..ab20f22524cb 100644
>> --- a/drivers/net/ethernet/ti/Kconfig
>> +++ b/drivers/net/ethernet/ti/Kconfig
>> @@ -229,4 +229,16 @@ config TI_ICSS_IEP
>>   	  To compile this driver as a module, choose M here. The module
>>   	  will be called icss_iep.
>>   
>> +config TI_PRUETH
>> +	tristate "TI PRU Ethernet EMAC driver"
>> +	depends on PRU_REMOTEPROC
>> +	depends on NET_SWITCHDEV
>> +	select TI_ICSS_IEP
>> +	imply PTP_1588_CLOCK
>> +	help
>> +	  Some TI SoCs has Programmable Realtime Units (PRUs) cores which can
>> +	  support Single or Dual Ethernet ports with help of firmware code running
>> +	  on PRU cores. This driver supports remoteproc based communication to
>> +	  PRU firmware to expose ethernet interface to Linux.
>> +
>>   endif # NET_VENDOR_TI
>> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
>> index cbcf44806924..93c0a4d0e33a 100644
>> --- a/drivers/net/ethernet/ti/Makefile
>> +++ b/drivers/net/ethernet/ti/Makefile
>> @@ -3,6 +3,9 @@
>>   # Makefile for the TI network device drivers.
>>   #
>>   
>> +obj-$(CONFIG_TI_PRUETH) += icssm-prueth.o
>> +icssm-prueth-y := icssm/icssm_prueth.o
>> +
>>   obj-$(CONFIG_TI_CPSW) += cpsw-common.o
>>   obj-$(CONFIG_TI_DAVINCI_EMAC) += cpsw-common.o
>>   obj-$(CONFIG_TI_CPSW_SWITCHDEV) += cpsw-common.o
>> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> new file mode 100644
>> index 000000000000..375fd636684d
>> --- /dev/null
>> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> @@ -0,0 +1,610 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/* Texas Instruments ICSSM Ethernet Driver
>> + *
>> + * Copyright (C) 2018-2022 Texas Instruments Incorporated - https://www.ti.com/
>> + *
>> + */
>> +
>> +#include <linux/etherdevice.h>
>> +#include <linux/genalloc.h>
>> +#include <linux/if_bridge.h>
>> +#include <linux/if_hsr.h>
>> +#include <linux/if_vlan.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/net_tstamp.h>
>> +#include <linux/of.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_mdio.h>
>> +#include <linux/of_net.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/phy.h>
>> +#include <linux/remoteproc/pruss.h>
>> +#include <linux/ptp_classify.h>
>> +#include <linux/regmap.h>
>> +#include <linux/remoteproc.h>
>> +#include <net/pkt_cls.h>
>> +
>> +#include "icssm_prueth.h"
>> +
>> +/* called back by PHY layer if there is change in link state of hw port*/
>> +static void icssm_emac_adjust_link(struct net_device *ndev)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct phy_device *phydev = emac->phydev;
>> +	bool new_state = false;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&emac->lock, flags);
>> +
>> +	if (phydev->link) {
>> +		/* check the mode of operation */
>> +		if (phydev->duplex != emac->duplex) {
>> +			new_state = true;
>> +			emac->duplex = phydev->duplex;
>> +		}
>> +		if (phydev->speed != emac->speed) {
>> +			new_state = true;
>> +			emac->speed = phydev->speed;
>> +		}
>> +		if (!emac->link) {
>> +			new_state = true;
>> +			emac->link = 1;
>> +		}
>> +	} else if (emac->link) {
>> +		new_state = true;
>> +		emac->link = 0;
>> +	}
>> +
>> +	if (new_state)
>> +		phy_print_status(phydev);
>> +
>> +	if (emac->link) {
>> +	       /* reactivate the transmit queue if it is stopped */
>> +		if (netif_running(ndev) && netif_queue_stopped(ndev))
>> +			netif_wake_queue(ndev);
>> +	} else {
>> +		if (!netif_queue_stopped(ndev))
>> +			netif_stop_queue(ndev);
>> +	}
>> +
>> +	spin_unlock_irqrestore(&emac->lock, flags);
>> +}
>> +
>> +static int icssm_emac_set_boot_pru(struct prueth_emac *emac,
>> +				   struct net_device *ndev)
>> +{
>> +	const struct prueth_firmware *pru_firmwares;
>> +	struct prueth *prueth = emac->prueth;
>> +	const char *fw_name;
>> +	int ret;
>> +
>> +	pru_firmwares = &prueth->fw_data->fw_pru[emac->port_id - 1];
>> +	fw_name = pru_firmwares->fw_name[prueth->eth_type];
>> +	if (!fw_name) {
>> +		netdev_err(ndev, "eth_type %d not supported\n",
>> +			   prueth->eth_type);
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = rproc_set_firmware(emac->pru, fw_name);
>> +	if (ret) {
>> +		netdev_err(ndev, "failed to set PRU0 firmware %s: %d\n",
>> +			   fw_name, ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = rproc_boot(emac->pru);
>> +	if (ret) {
>> +		netdev_err(ndev, "failed to boot PRU0: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * icssm_emac_ndo_open - EMAC device open
>> + * @ndev: network adapter device
>> + *
>> + * Called when system wants to start the interface.
>> + *
>> + * Return: 0 for a successful open, or appropriate error code
>> + */
>> +static int icssm_emac_ndo_open(struct net_device *ndev)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	int ret;
>> +
>> +	ret = icssm_emac_set_boot_pru(emac, ndev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* start PHY */
>> +	phy_start(emac->phydev);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * icssm_emac_ndo_stop - EMAC device stop
>> + * @ndev: network adapter device
>> + *
>> + * Called when system wants to stop or down the interface.
>> + *
>> + * Return: Always 0 (Success)
>> + */
>> +static int icssm_emac_ndo_stop(struct net_device *ndev)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +
>> +	/* stop PHY */
>> +	phy_stop(emac->phydev);
>> +
>> +	rproc_shutdown(emac->pru);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct net_device_ops emac_netdev_ops = {
>> +	.ndo_open = icssm_emac_ndo_open,
>> +	.ndo_stop = icssm_emac_ndo_stop,
>> +};
>> +
>> +/* get emac_port corresponding to eth_node name */
>> +static int icssm_prueth_node_port(struct device_node *eth_node)
>> +{
>> +	u32 port_id;
>> +	int ret;
>> +
>> +	ret = of_property_read_u32(eth_node, "reg", &port_id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (port_id == 0)
>> +		return PRUETH_PORT_MII0;
>> +	else if (port_id == 1)
>> +		return PRUETH_PORT_MII1;
>> +	else
>> +		return PRUETH_PORT_INVALID;
>> +}
>> +
>> +/* get MAC instance corresponding to eth_node name */
>> +static int icssm_prueth_node_mac(struct device_node *eth_node)
>> +{
>> +	u32 port_id;
>> +	int ret;
>> +
>> +	ret = of_property_read_u32(eth_node, "reg", &port_id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (port_id == 0)
>> +		return PRUETH_MAC0;
>> +	else if (port_id == 1)
>> +		return PRUETH_MAC1;
>> +	else
>> +		return PRUETH_MAC_INVALID;
>> +}
>> +
>> +static int icssm_prueth_netdev_init(struct prueth *prueth,
>> +				    struct device_node *eth_node)
>> +{
>> +	struct prueth_emac *emac;
>> +	struct net_device *ndev;
>> +	enum prueth_port port;
>> +	enum prueth_mac mac;
>> +	int ret;
>> +
>> +	port = icssm_prueth_node_port(eth_node);
>> +	if (port == PRUETH_PORT_INVALID)
>> +		return -EINVAL;
>> +
>> +	mac = icssm_prueth_node_mac(eth_node);
>> +	if (mac == PRUETH_MAC_INVALID)
>> +		return -EINVAL;
>> +
>> +	ndev = devm_alloc_etherdev(prueth->dev, sizeof(*emac));
>> +	if (!ndev)
>> +		return -ENOMEM;
>> +
>> +	SET_NETDEV_DEV(ndev, prueth->dev);
>> +	emac = netdev_priv(ndev);
>> +	prueth->emac[mac] = emac;
>> +	emac->prueth = prueth;
>> +	emac->ndev = ndev;
>> +	emac->port_id = port;
>> +
>> +	/* by default eth_type is EMAC */
>> +	switch (port) {
>> +	case PRUETH_PORT_MII0:
>> +		emac->pru = prueth->pru0;
>> +		break;
>> +	case PRUETH_PORT_MII1:
>> +		emac->pru = prueth->pru1;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	/* get mac address from DT and set private and netdev addr */
>> +	ret = of_get_ethdev_address(eth_node, ndev);
>> +	if (!is_valid_ether_addr(ndev->dev_addr)) {
>> +		eth_hw_addr_random(ndev);
>> +		dev_warn(prueth->dev, "port %d: using random MAC addr: %pM\n",
>> +			 port, ndev->dev_addr);
>> +	}
>> +	ether_addr_copy(emac->mac_addr, ndev->dev_addr);
>> +
>> +	/* connect PHY */
>> +	emac->phydev = of_phy_get_and_connect(ndev, eth_node,
>> +					      icssm_emac_adjust_link);
>> +	if (!emac->phydev) {
>> +		dev_dbg(prueth->dev, "PHY connection failed\n");
>> +		ret = -EPROBE_DEFER;
>> +		goto free;
>> +	}
>> +
>> +	/* remove unsupported modes */
>> +	phy_remove_link_mode(emac->phydev, ETHTOOL_LINK_MODE_10baseT_Full_BIT);
>> +
>> +	phy_remove_link_mode(emac->phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
>> +	phy_remove_link_mode(emac->phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
>> +
>> +	phy_remove_link_mode(emac->phydev, ETHTOOL_LINK_MODE_Pause_BIT);
>> +	phy_remove_link_mode(emac->phydev, ETHTOOL_LINK_MODE_Asym_Pause_BIT);
>> +
>> +	ndev->netdev_ops = &emac_netdev_ops;
>> +
> 
> I think ndev->dev.of_node should be set to eth_node here.
> 
> If ndev->dev.of_node isn't set, of_find_net_device_by_node() won't find
> the iccsm_prueth ports and their of_node won't be available in sysfs
> (which, in my case, leads to issues during the probe of a switch
> connected to them)
> 

We will add the below line in icssm_prueth_netdev_init() function to
resolve the issue.

ndev->dev.of_node = eth_node;

We will add it in the next version.


Thanks and Regards,
Parvathi.





