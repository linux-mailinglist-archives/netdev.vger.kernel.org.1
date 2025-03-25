Return-Path: <netdev+bounces-177346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43814A6FACC
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBA03B2C57
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729042566E9;
	Tue, 25 Mar 2025 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1r9+Iol"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D1254B1B;
	Tue, 25 Mar 2025 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904679; cv=none; b=RHlOJK6mXNLLXzCHyvfHo7F5VEijUFZ06e95i8/YN7co5gP6RlCa56JHlZb26hS+63eiaYSxK++SWVRZuV9N7c7X4H9S2ufUtwJ49Tmh2iLlFLP4i9my06GIg/VlHYA4qWGmexpAYOc4OJAj9s01508C9u53r4IrhAHXRsDPX0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904679; c=relaxed/simple;
	bh=F0z0c6WZj/o0tegCTUsKybVHmRaIhLDfeoY1o6O62+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4VbgodFRp0agdReg/+82NK82Y43h9+S/5GRp+I7Mf1FHVylNPIlsa4O+r69IDjWU3VoyU7pmkNSM38ywdhvdK37O+FRTUXtSOWex5LMq/H5p6Ef0iDfo1rwJBwZaKvVM+ylpHsMfdOJVurdKQVhdOy/1aVXco4ooeT4i4fYWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1r9+Iol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4D5C4CEE9;
	Tue, 25 Mar 2025 12:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742904677;
	bh=F0z0c6WZj/o0tegCTUsKybVHmRaIhLDfeoY1o6O62+I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P1r9+IolbYEIJ7O+E0xKa1EwqwWKZ8U0JzaqWWdgyBXPpJXfOjBN57eeJUGZabxHk
	 XA/4C3VYKncDCAWdJeF3P0WkNiDc6xpaqriRhBvfYHSnvVWq6AqhAQqTLKvxMlnXb4
	 m5m67lkEFEzOa6cNTvk9xEKg/QGsbmAxGXRCnoCdzuBRlr23WkE3WFLJpOMylKW0eG
	 7Tp1/IYeoRy0J/teP3I8zFVHL+aB8hpvtE+FTXMfbXVLJcu8kao3b/Lu/spHgeeb8R
	 t0d1Mh8KNBxfIZd1/bKmAKuu7VvIoB4KMyVsEb1tEsAr35H/quaXDo4ABWJTp7fUkm
	 aHl0SGNvR/Fdg==
Message-ID: <32d93a90-3601-4094-8054-2737a57acbc7@kernel.org>
Date: Tue, 25 Mar 2025 13:11:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] net: mtip: The L2 switch driver for imx287
To: Lukasz Majewski <lukma@denx.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 davem@davemloft.net, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20250325115736.1732721-1-lukma@denx.de>
 <20250325115736.1732721-6-lukma@denx.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250325115736.1732721-6-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2025 12:57, Lukasz Majewski wrote:
> This patch series provides support for More Than IP L2 switch embedded
> in the imx287 SoC.
> 
> This is a two port switch (placed between uDMA[01] and MAC-NET[01]),
> which can be used for offloading the network traffic.
> 
> It can be used interchangeable with current FEC driver - to be more
> specific: one can use either of it, depending on the requirements.
> 
> The biggest difference is the usage of DMA - when FEC is used, separate
> DMAs are available for each ENET-MAC block.
> However, with switch enabled - only the DMA0 is used to send/receive data.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  drivers/net/ethernet/freescale/Kconfig        |    1 +
>  drivers/net/ethernet/freescale/Makefile       |    1 +
>  drivers/net/ethernet/freescale/mtipsw/Kconfig |   10 +
>  .../net/ethernet/freescale/mtipsw/Makefile    |    6 +
>  .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 2108 +++++++++++++++++
>  .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |  784 ++++++
>  .../ethernet/freescale/mtipsw/mtipl2sw_br.c   |  113 +
>  .../ethernet/freescale/mtipsw/mtipl2sw_mgnt.c |  434 ++++
>  8 files changed, 3457 insertions(+)
>  create mode 100644 drivers/net/ethernet/freescale/mtipsw/Kconfig
>  create mode 100644 drivers/net/ethernet/freescale/mtipsw/Makefile
>  create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
>  create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
>  create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
>  create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c
> 
> diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
> index a2d7300925a8..056a11c3a74e 100644
> --- a/drivers/net/ethernet/freescale/Kconfig
> +++ b/drivers/net/ethernet/freescale/Kconfig
> @@ -60,6 +60,7 @@ config FEC_MPC52xx_MDIO
>  
>  source "drivers/net/ethernet/freescale/fs_enet/Kconfig"
>  source "drivers/net/ethernet/freescale/fman/Kconfig"
> +source "drivers/net/ethernet/freescale/mtipsw/Kconfig"
>  
>  config FSL_PQ_MDIO
>  	tristate "Freescale PQ MDIO"
> diff --git a/drivers/net/ethernet/freescale/Makefile b/drivers/net/ethernet/freescale/Makefile
> index de7b31842233..0e6cacb0948a 100644
> --- a/drivers/net/ethernet/freescale/Makefile
> +++ b/drivers/net/ethernet/freescale/Makefile
> @@ -25,3 +25,4 @@ obj-$(CONFIG_FSL_DPAA_ETH) += dpaa/
>  obj-$(CONFIG_FSL_DPAA2_ETH) += dpaa2/
>  
>  obj-y += enetc/
> +obj-y += mtipsw/
> diff --git a/drivers/net/ethernet/freescale/mtipsw/Kconfig b/drivers/net/ethernet/freescale/mtipsw/Kconfig
> new file mode 100644
> index 000000000000..5cc9b758bad4
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/mtipsw/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config FEC_MTIP_L2SW
> +	tristate "MoreThanIP L2 switch support to FEC driver"
> +	depends on OF
> +	depends on NET_SWITCHDEV
> +	depends on BRIDGE
> +	depends on ARCH_MXS || ARCH_MXC

Missing compile test

> +	help
> +		This enables support for the MoreThan IP L2 switch on i.MX
> +		SoCs (e.g. iMX28, vf610).

Wrong indentation. Look at other Kconfig files.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/Makefile b/drivers/net/ethernet/freescale/mtipsw/Makefile
> new file mode 100644
> index 000000000000..e87e06d6870a
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/mtipsw/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the L2 switch from MTIP embedded in NXP SoCs

Drop, obvious.


...

> +
> +static int mtip_parse_of(struct switch_enet_private *fep,
> +			 struct device_node *np)
> +{
> +	struct device_node *port, *p;
> +	unsigned int port_num;
> +	int ret;
> +
> +	p = of_find_node_by_name(np, "ethernet-ports");
> +
> +	for_each_available_child_of_node(p, port) {
> +		if (of_property_read_u32(port, "reg", &port_num))
> +			continue;
> +
> +		fep->n_ports = port_num;
> +		of_get_mac_address(port, &fep->mac[port_num - 1][0]);
> +
> +		ret = of_property_read_string(port, "label",
> +					      &fep->ndev_name[port_num - 1]);
> +		if (ret < 0) {
> +			pr_err("%s: Cannot get ethernet port name (%d)!\n",
> +			       __func__, ret);
> +			goto of_get_err;

Just use scoped loop.

> +		}
> +
> +		ret = of_get_phy_mode(port, &fep->phy_interface[port_num - 1]);
> +		if (ret < 0) {
> +			pr_err("%s: Cannot get PHY mode (%d)!\n", __func__,
> +			       ret);

No, drivers do not use pr_xxx. From where did you get this code?

> +			goto of_get_err;
> +		}
> +
> +		fep->phy_np[port_num - 1] = of_parse_phandle(port,
> +							     "phy-handle", 0);
> +	}
> +
> + of_get_err:
> +	of_node_put(p);
> +
> +	return 0;
> +}
> +
> +static int mtip_sw_learning(void *arg)
> +{
> +	struct switch_enet_private *fep = arg;
> +
> +	while (!kthread_should_stop()) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		/* check learning record valid */
> +		mtip_atable_dynamicms_learn_migration(fep, fep->curr_time,
> +						      NULL, NULL);
> +		schedule_timeout(HZ / 100);
> +	}
> +
> +	return 0;
> +}
> +
> +static void mtip_mii_unregister(struct switch_enet_private *fep)
> +{
> +	mdiobus_unregister(fep->mii_bus);
> +	mdiobus_free(fep->mii_bus);
> +}
> +
> +static const struct fec_devinfo fec_imx28_l2switch_info = {
> +	.quirks = FEC_QUIRK_BUG_CAPTURE | FEC_QUIRK_SINGLE_MDIO,
> +};
> +
> +static struct platform_device_id pdev_id = {
> +	.name = "imx28-l2switch",
> +	.driver_data = (kernel_ulong_t)&fec_imx28_l2switch_info,
> +};
> +
> +static int __init mtip_sw_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct switch_enet_private *fep;
> +	struct fec_devinfo *dev_info;
> +	struct switch_t *fecp;
> +	struct resource *r;
> +	int err, ret;
> +	u32 rev;
> +
> +	pr_info("Ethernet Switch Version %s\n", VERSION);

Drivers use dev, not pr. Anyway drop. Drivers do not have versions and
should be silent on success.

> +
> +	fep = kzalloc(sizeof(*fep), GFP_KERNEL);

Why not devm? See last comment here (at the end).

> +	if (!fep)
> +		return -ENOMEM;
> +
> +	pdev->id_entry = &pdev_id;
> +
> +	dev_info = (struct fec_devinfo *)pdev->id_entry->driver_data;
> +	if (dev_info)
> +		fep->quirks = dev_info->quirks;
> +
> +	fep->pdev = pdev;
> +	platform_set_drvdata(pdev, fep);
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	fep->enet_addr = devm_ioremap_resource(&pdev->dev, r);

Use proper wrapper.

> +	if (IS_ERR(fep->enet_addr)) {
> +		ret = PTR_ERR(fep->enet_addr);
> +		goto failed_ioremap;
> +	}
> +
> +	fep->irq = platform_get_irq(pdev, 0);
> +
> +	ret = mtip_parse_of(fep, np);
> +	if (ret < 0) {
> +		pr_err("%s: OF parse error (%d)!\n", __func__, ret);
> +		goto failed_parse_of;
> +	}
> +
> +	/* Create an Ethernet device instance.
> +	 * The switch lookup address memory starts 0x800FC000
> +	 */
> +	fep->hwp_enet = fep->enet_addr;
> +	fecp = (struct switch_t *)(fep->enet_addr + ENET_SWI_PHYS_ADDR_OFFSET);
> +
> +	fep->hwp = fecp;
> +	fep->hwentry = (struct mtip_addr_table_t *)
> +		((unsigned long)fecp + MCF_ESW_LOOKUP_MEM_OFFSET);
> +
> +	rev = readl(&fecp->ESW_REVISION);
> +	pr_info("Ethernet Switch HW rev 0x%x:0x%x\n",
> +		MCF_MTIP_REVISION_CUSTOMER_REVISION(rev),
> +		MCF_MTIP_REVISION_CORE_REVISION(rev));

Drop

> +
> +	fep->reg_phy = devm_regulator_get(&pdev->dev, "phy");
> +	if (!IS_ERR(fep->reg_phy)) {
> +		ret = regulator_enable(fep->reg_phy);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"Failed to enable phy regulator: %d\n", ret);
> +			goto failed_regulator;
> +		}
> +	} else {
> +		if (PTR_ERR(fep->reg_phy) == -EPROBE_DEFER) {
> +			ret = -EPROBE_DEFER;
> +			goto failed_regulator;
> +		}
> +		fep->reg_phy = NULL;

I don't understand this code. Do you want to re-implement get_optional?
But why?

> +	}
> +
> +	fep->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> +	if (IS_ERR(fep->clk_ipg))
> +		fep->clk_ipg = NULL;

Why?

> +
> +	fep->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
> +	if (IS_ERR(fep->clk_ahb))
> +		fep->clk_ahb = NULL;
> +
> +	fep->clk_enet_out = devm_clk_get(&pdev->dev, "enet_out");
> +	if (IS_ERR(fep->clk_enet_out))
> +		fep->clk_enet_out = NULL;
> +
> +	ret = clk_prepare_enable(fep->clk_ipg);
> +	if (ret) {
> +		pr_err("%s: clock ipg cannot be enabled\n", __func__);
> +		goto failed_clk_ipg;
> +	}
> +
> +	ret = clk_prepare_enable(fep->clk_ahb);
> +	if (ret) {
> +		pr_err("%s: clock ahb cannot be enabled\n", __func__);
> +		goto failed_clk_ahb;
> +	}
> +
> +	ret = clk_prepare_enable(fep->clk_enet_out);
> +	if (ret)
> +		pr_err("%s: clock clk_enet_out cannot be enabled\n", __func__);
> +
> +	spin_lock_init(&fep->learn_lock);
> +
> +	ret = mtip_reset_phy(pdev);
> +	if (ret < 0) {
> +		pr_err("%s: GPIO PHY RST error (%d)!\n", __func__, ret);
> +		goto get_phy_mode_err;
> +	}
> +
> +	ret = request_irq(fep->irq, mtip_interrupt, 0, "mtip_l2sw", fep);
> +	if (ret) {
> +		pr_err("MTIP_L2: Could not alloc IRQ(%d)!\n", fep->irq);
> +		goto request_irq_err;
> +	}
> +
> +	spin_lock_init(&fep->hw_lock);
> +	spin_lock_init(&fep->mii_lock);
> +
> +	ret = mtip_register_notifiers(fep);
> +	if (ret)
> +		goto clean_unregister_netdev;
> +
> +	ret = mtip_ndev_init(fep);
> +	if (ret) {
> +		pr_err("%s: Failed to create virtual ndev (%d)\n",
> +		       __func__, ret);
> +		goto mtip_ndev_init_err;
> +	}
> +
> +	err = mtip_switch_dma_init(fep);
> +	if (err) {
> +		pr_err("%s: ethernet switch init fail (%d)!\n", __func__, err);
> +		goto mtip_switch_dma_init_err;
> +	}
> +
> +	err = mtip_mii_init(fep, pdev);
> +	if (err)
> +		pr_err("%s: Cannot init phy bus (%d)!\n", __func__, err);
> +
> +	/* setup timer for learning aging function */
> +	timer_setup(&fep->timer_aging, mtip_aging_timer, 0);
> +	mod_timer(&fep->timer_aging,
> +		  jiffies + msecs_to_jiffies(LEARNING_AGING_INTERVAL));
> +
> +	fep->task = kthread_run(mtip_sw_learning, fep, "mtip_l2sw_learning");
> +	if (IS_ERR(fep->task)) {
> +		ret = PTR_ERR(fep->task);
> +		pr_err("%s: learning kthread_run error (%d)!\n", __func__, ret);
> +		goto fail_task_learning;
> +	}
> +
> +	/* setup MII interface for external switch ports*/
> +	mtip_enet_init(fep, 1);
> +	mtip_enet_init(fep, 2);
> +
> +	return 0;
> +
> + fail_task_learning:
> +	mtip_mii_unregister(fep);
> +	del_timer(&fep->timer_aging);
> + mtip_switch_dma_init_err:
> +	mtip_ndev_cleanup(fep);
> + mtip_ndev_init_err:
> +	mtip_unregister_notifiers(fep);
> + clean_unregister_netdev:
> +	free_irq(fep->irq, NULL);
> + request_irq_err:
> +	platform_set_drvdata(pdev, NULL);
> + get_phy_mode_err:
> +	if (fep->clk_enet_out)
> +		clk_disable_unprepare(fep->clk_enet_out);
> +	clk_disable_unprepare(fep->clk_ahb);
> + failed_clk_ahb:
> +	clk_disable_unprepare(fep->clk_ipg);
> + failed_clk_ipg:
> +	if (fep->reg_phy) {
> +		regulator_disable(fep->reg_phy);
> +		devm_regulator_put(fep->reg_phy);
> +	}
> + failed_regulator:
> + failed_parse_of:
> +	devm_ioremap_release(&pdev->dev, r);
> + failed_ioremap:
> +	kfree(fep);
> +	return err;
> +}
> +
> +static void mtip_sw_remove(struct platform_device *pdev)
> +{
> +	struct switch_enet_private *fep = platform_get_drvdata(pdev);
> +
> +	mtip_unregister_notifiers(fep);
> +	mtip_ndev_cleanup(fep);
> +
> +	mtip_mii_remove(fep);
> +
> +	kthread_stop(fep->task);
> +	del_timer(&fep->timer_aging);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	kfree(fep);
> +}
> +
> +static const struct of_device_id mtipl2_of_match[] = {
> +	{ .compatible = "fsl,imx287-mtip-switch", },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver mtipl2plat_driver = {
> +	.probe          = mtip_sw_probe,
> +	.remove         = mtip_sw_remove,
> +	.driver         = {
> +		.name   = "mtipl2sw",
> +		.owner  = THIS_MODULE,

Oh no, please do not send us 10-12 year old code. This is long, looong
time gone. If you copied this pattern, then for sure you copied all
other issues we fixed during last 10 years, so basically you ask us to
re-review the same code we already fixed.

Best regards,
Krzysztof

