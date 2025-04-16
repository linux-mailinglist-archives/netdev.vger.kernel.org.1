Return-Path: <netdev+bounces-183187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D38FA8B501
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A616D4432D0
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC86F233155;
	Wed, 16 Apr 2025 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaUqEwxs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBB82309BD;
	Wed, 16 Apr 2025 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795002; cv=none; b=hcIiYLRyxqWZ0PCL9OVWGolBAltgHY1SX1Rgpqd4NGWyXGtwixUDVP3lKhpuSKWUP6bs+eVU8kI5OVOrMEpjfGWLtw0CAzNa0XIQB2+FDpfRxl/o2xmk1IgEWUKkkHrixN7WGkwqu0vayIlliKyO/fr+45+O+pqgEE/+t1ewmq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795002; c=relaxed/simple;
	bh=hY7p3m5X0OOft3dhhs3uhZGYBnQpfn9DlIDiE50gYNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Srm8CBteIMavxou6y+cJv88fFaCvFeYqSU0rU4g3vLf/rR6F7J/eVTXfv5SW0i4HwWhvBLxhXao2YuK2NOqndDgDAnL2OpE5V/NZ2kpn9eO22eySsSOBjhwLL+8pzZ5Zh/cKKbzjbNZ5o3ja7Z4uq7JBrlbkwbN2wy7NMEw6G0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaUqEwxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DD6C4CEE2;
	Wed, 16 Apr 2025 09:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744795002;
	bh=hY7p3m5X0OOft3dhhs3uhZGYBnQpfn9DlIDiE50gYNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uaUqEwxsykjInJ62sBQ3icULCRHLAodwkEXAyOvS613sBBl8V4XwJieKRR70ZNSRo
	 sORxELLDb1lvsUeUtfYiZkKEe8CY+EAZP06AL9mkCFhE9DoooapeaccHXYZrhHEMsg
	 qb2P6bHCitt0DwDuimqyL9TQ1C2IswUiSQipaUsZSeazpYM7zplz2muGRbtavhGTco
	 GG4r96fbMsyV2Jloo+7nHDHbtlSHGjYxG9WY2DBqz56xjOy/miriXUhr9flsjmRUgv
	 A6JT2MXZ6p8URA+lrTJ1TPTzca+pn4i0Hh2y/Y51506TjfwfJ9kuSRMlICXH6GMTnl
	 L5UALTB4jBGWQ==
Date: Wed, 16 Apr 2025 10:16:32 +0100
From: Simon Horman <horms@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
	tony@atomide.com, richardcochran@gmail.com, glaroque@baylibre.com,
	schnelle@linux.ibm.com, m-karicheri2@ti.com, s.hauer@pengutronix.de,
	rdunlap@infradead.org, diogo.ivo@siemens.com, basharath@couthit.com,
	jacob.e.keller@intel.com, m-malladi@ti.com,
	javier.carrasco.cruz@gmail.com, afd@ti.com, s-anna@ti.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratheesh@ti.com, prajith@ti.com, vigneshr@ti.com, praneeth@ti.com,
	srk@ti.com, rogerq@ti.com, krishna@couthit.com, pmohan@couthit.com,
	mohan@couthit.com
Subject: Re: [PATCH net-next v5 02/11] net: ti: prueth: Adds ICSSM Ethernet
 driver
Message-ID: <20250416091632.GM395307@horms.kernel.org>
References: <20250414113458.1913823-1-parvathi@couthit.com>
 <20250414113458.1913823-3-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414113458.1913823-3-parvathi@couthit.com>

On Mon, Apr 14, 2025 at 05:04:49PM +0530, Parvathi Pudi wrote:
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

...

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c

...

> +static int icssm_prueth_probe(struct platform_device *pdev)
> +{
> +	struct device_node *eth0_node = NULL, *eth1_node = NULL;
> +	struct device_node *eth_node, *eth_ports_node;
> +	enum pruss_pru_id pruss_id0, pruss_id1;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np;
> +	struct prueth *prueth;
> +	int i, ret;
> +
> +	np = dev->of_node;
> +	if (!np)
> +		return -ENODEV; /* we don't support non DT */
> +
> +	prueth = devm_kzalloc(dev, sizeof(*prueth), GFP_KERNEL);
> +	if (!prueth)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, prueth);
> +	prueth->dev = dev;
> +	prueth->fw_data = device_get_match_data(dev);
> +
> +	eth_ports_node = of_get_child_by_name(np, "ethernet-ports");
> +	if (!eth_ports_node)
> +		return -ENOENT;
> +
> +	for_each_child_of_node(eth_ports_node, eth_node) {
> +		u32 reg;
> +
> +		if (strcmp(eth_node->name, "ethernet-port"))
> +			continue;
> +		ret = of_property_read_u32(eth_node, "reg", &reg);
> +		if (ret < 0) {
> +			dev_err(dev, "%pOF error reading port_id %d\n",
> +				eth_node, ret);
> +		}
> +
> +		of_node_get(eth_node);

Hi Roger, Parvathi, all,

I feel that I'm missing something obvious here.
But I have some questions about the reference to eth_node
taken on the line above.

> +
> +		if (reg == 0) {
> +			eth0_node = eth_node;

If, while iterating through the for loop above, we reach this point more
than once, then will the reference to the previously node assigned to
eth0_node be leaked?

> +			if (!of_device_is_available(eth0_node)) {
> +				of_node_put(eth0_node);
> +				eth0_node = NULL;
> +			}
> +		} else if (reg == 1) {
> +			eth1_node = eth_node;

Likewise here for eth1_node.

> +			if (!of_device_is_available(eth1_node)) {
> +				of_node_put(eth1_node);
> +				eth1_node = NULL;
> +			}
> +		} else {
> +			dev_err(dev, "port reg should be 0 or 1\n");

And, perhaps more to the point, is the reference to eth_node leaked if
we reach this line?

> +		}
> +	}
> +
> +	of_node_put(eth_ports_node);
> +
> +	/* At least one node must be present and available else we fail */
> +	if (!eth0_node && !eth1_node) {
> +		dev_err(dev, "neither port0 nor port1 node available\n");
> +		return -ENODEV;
> +	}
> +
> +	if (eth0_node == eth1_node) {

Given the if / else if condition in the for loop above,
I'm not sure this can ever occur.

> +		dev_err(dev, "port0 and port1 can't have same reg\n");
> +		of_node_put(eth0_node);
> +		return -ENODEV;
> +	}
> +
> +	prueth->eth_node[PRUETH_MAC0] = eth0_node;
> +	prueth->eth_node[PRUETH_MAC1] = eth1_node;
> +
> +	if (eth0_node) {
> +		prueth->pru0 = pru_rproc_get(np, 0, &pruss_id0);
> +		if (IS_ERR(prueth->pru0)) {
> +			ret = PTR_ERR(prueth->pru0);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "unable to get PRU0: %d\n", ret);
> +			goto put_pru;
> +		}
> +	}
> +
> +	if (eth1_node) {
> +		prueth->pru1 = pru_rproc_get(np, 1, &pruss_id1);
> +		if (IS_ERR(prueth->pru1)) {
> +			ret = PTR_ERR(prueth->pru1);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "unable to get PRU1: %d\n", ret);
> +			goto put_pru;
> +		}
> +	}
> +
> +	/* setup netdev interfaces */
> +	if (eth0_node) {
> +		ret = icssm_prueth_netdev_init(prueth, eth0_node);
> +		if (ret) {
> +			if (ret != -EPROBE_DEFER) {
> +				dev_err(dev, "netdev init %s failed: %d\n",
> +					eth0_node->name, ret);
> +			}
> +			goto put_pru;
> +		}
> +	}
> +
> +	if (eth1_node) {
> +		ret = icssm_prueth_netdev_init(prueth, eth1_node);
> +		if (ret) {
> +			if (ret != -EPROBE_DEFER) {
> +				dev_err(dev, "netdev init %s failed: %d\n",
> +					eth1_node->name, ret);
> +			}
> +			goto netdev_exit;
> +		}
> +	}
> +
> +	/* register the network devices */
> +	if (eth0_node) {
> +		ret = register_netdev(prueth->emac[PRUETH_MAC0]->ndev);
> +		if (ret) {
> +			dev_err(dev, "can't register netdev for port MII0");
> +			goto netdev_exit;
> +		}
> +
> +		prueth->registered_netdevs[PRUETH_MAC0] =
> +			prueth->emac[PRUETH_MAC0]->ndev;
> +	}
> +
> +	if (eth1_node) {
> +		ret = register_netdev(prueth->emac[PRUETH_MAC1]->ndev);
> +		if (ret) {
> +			dev_err(dev, "can't register netdev for port MII1");
> +			goto netdev_unregister;
> +		}
> +
> +		prueth->registered_netdevs[PRUETH_MAC1] =
> +			prueth->emac[PRUETH_MAC1]->ndev;
> +	}
> +
> +	if (eth1_node)
> +		of_node_put(eth1_node);
> +	if (eth0_node)
> +		of_node_put(eth0_node);
> +	return 0;
> +
> +netdev_unregister:
> +	for (i = 0; i < PRUETH_NUM_MACS; i++) {
> +		if (!prueth->registered_netdevs[i])
> +			continue;
> +		unregister_netdev(prueth->registered_netdevs[i]);
> +	}
> +
> +netdev_exit:
> +	for (i = 0; i < PRUETH_NUM_MACS; i++) {
> +		eth_node = prueth->eth_node[i];
> +		if (!eth_node)
> +			continue;
> +
> +		icssm_prueth_netdev_exit(prueth, eth_node);
> +	}
> +
> +put_pru:
> +	if (eth1_node) {
> +		if (prueth->pru1)
> +			pru_rproc_put(prueth->pru1);
> +		of_node_put(eth1_node);
> +	}
> +
> +	if (eth0_node) {
> +		if (prueth->pru0)
> +			pru_rproc_put(prueth->pru0);
> +		of_node_put(eth0_node);
> +	}
> +
> +	return ret;
> +}
> +
> +static void icssm_prueth_remove(struct platform_device *pdev)
> +{
> +	struct prueth *prueth = platform_get_drvdata(pdev);
> +	struct device_node *eth_node;
> +	int i;
> +
> +	for (i = 0; i < PRUETH_NUM_MACS; i++) {
> +		if (!prueth->registered_netdevs[i])
> +			continue;
> +		unregister_netdev(prueth->registered_netdevs[i]);
> +	}
> +
> +	for (i = 0; i < PRUETH_NUM_MACS; i++) {
> +		eth_node = prueth->eth_node[i];
> +		if (!eth_node)
> +			continue;
> +
> +		icssm_prueth_netdev_exit(prueth, eth_node);
> +		of_node_put(eth_node);
> +	}
> +
> +	pruss_put(prueth->pruss);
> +
> +	if (prueth->eth_node[PRUETH_MAC0])
> +		pru_rproc_put(prueth->pru0);
> +	if (prueth->eth_node[PRUETH_MAC1])
> +		pru_rproc_put(prueth->pru1);
> +}

...

