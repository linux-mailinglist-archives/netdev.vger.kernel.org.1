Return-Path: <netdev+bounces-259409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHJ1Jcy8lmkylQIAu9opvQ
	(envelope-from <netdev+bounces-259409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 08:33:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E737815CB91
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 08:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4B3830142A6
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 07:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163EC334C26;
	Thu, 19 Feb 2026 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7ZHmPpY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4157327BEC;
	Thu, 19 Feb 2026 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771486351; cv=none; b=Q3TsLboY21kBrLJPWwbt3Hqyr8ShVK3IOgQn19H/Fblrbb8UVTq/e0D8WGQ4JH71s61S7nGgusx5PCH8+pdGV4uLMbzLlP5VaG0pbL5cUfa235PHMnwA22bfOJ69sfze/WtZgFRHHGttSJVEPxqiupNIYlB5AQy6XyTq6RMYbDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771486351; c=relaxed/simple;
	bh=QHuicrIuW/GCTffBscyXXztNNcQhJHgarQPZ4uFz4lQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f2sXQGF2xl4zZuKQgf2uQN3wOKoiPY/aU2KHvNrnlbuBZJWu92xZtsYMX+c9hW9FbSQJipDiUEl4ze3tupOwzJ5+q6N1u46C4A2vxsIivGqrDYcZeW3tz7lGrd/rvZEHJmzk9q7F5R1VEaFVn8Db5vBiV9FXLN4QEzVHF9yno2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7ZHmPpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C00C2BC86;
	Thu, 19 Feb 2026 07:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771486350;
	bh=QHuicrIuW/GCTffBscyXXztNNcQhJHgarQPZ4uFz4lQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a7ZHmPpY0avBywa7SVxhFJOXK6WWJEi4L7yqFnFbQdc/MYSbt/DDRZho5Betq+jDP
	 ObAionamUqtj03n+ItpVQbS1U8cP5GT2EFbo8P5FFAynzXG7KeOdYA4OSMX7GlYTxc
	 +J1mBSTwCSOtJDakhhPGknIWcmG1SnXxX0tIoTznS6xQiwsgaktlpd9UMyE4SiaHu6
	 eDS3iCFmz0TrT9vaQ9vnQCQ6JIR7aQdwMdaew+v7TmE3rtINHDzb2DqSJOR218f7Cx
	 Z98aprsBS7uqfxsXNhcWBYPA1LwBbIcvSZgAcko/aRHfNPAn1cJh8DuUmmUwlcH0We
	 +uryggRaB9atw==
Message-ID: <8dde3889-e51d-4e20-926b-7cdbdef3ddf7@kernel.org>
Date: Thu, 19 Feb 2026 08:32:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/8] net: xilinx: tsn: Introduce TSN core driver
 skeleton
To: Srinivas Neeli <srinivas.neeli@amd.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, michal.simek@amd.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, git@amd.com
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
 <20260219054911.2017362-3-srinivas.neeli@amd.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260219054911.2017362-3-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259409-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[amd.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: E737815CB91
X-Rspamd-Action: no action

On 19/02/2026 06:49, Srinivas Neeli wrote:
> Introduce the initial skeleton for the AMD/Xilinx Time Sensitive
> Networking (TSN) Ethernet IP driver. Adds the Kconfig entry
> (CONFIG_XILINX_TSN), updates the Xilinx Ethernet Makefile,
> and provides the base source file focused on device tree
> parsing and clock acquisition.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---
>  drivers/net/ethernet/xilinx/Kconfig           |   1 +
>  drivers/net/ethernet/xilinx/Makefile          |   1 +
>  drivers/net/ethernet/xilinx/tsn/Kconfig       |  14 ++
>  drivers/net/ethernet/xilinx/tsn/Makefile      |   2 +
>  drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h  |  60 +++++
>  .../net/ethernet/xilinx/tsn/xilinx_tsn_main.c | 218 ++++++++++++++++++
>  6 files changed, 296 insertions(+)
>  create mode 100644 drivers/net/ethernet/xilinx/tsn/Kconfig
>  create mode 100644 drivers/net/ethernet/xilinx/tsn/Makefile
>  create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
>  create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
> 
> diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
> index 7502214cc7d5..c6d704c8d3d4 100644
> --- a/drivers/net/ethernet/xilinx/Kconfig
> +++ b/drivers/net/ethernet/xilinx/Kconfig
> @@ -41,4 +41,5 @@ config XILINX_LL_TEMAC
>  	  This driver supports the Xilinx 10/100/1000 LocalLink TEMAC
>  	  core used in Xilinx Spartan and Virtex FPGAs
>  
> +source "drivers/net/ethernet/xilinx/tsn/Kconfig"
>  endif # NET_VENDOR_XILINX
> diff --git a/drivers/net/ethernet/xilinx/Makefile b/drivers/net/ethernet/xilinx/Makefile
> index 7d7dc1771423..66dab012650b 100644
> --- a/drivers/net/ethernet/xilinx/Makefile
> +++ b/drivers/net/ethernet/xilinx/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_XILINX_LL_TEMAC) += ll_temac.o
>  obj-$(CONFIG_XILINX_EMACLITE) += xilinx_emaclite.o
>  xilinx_emac-objs := xilinx_axienet_main.o xilinx_axienet_mdio.o
>  obj-$(CONFIG_XILINX_AXI_EMAC) += xilinx_emac.o
> +obj-$(CONFIG_XILINX_TSN) += tsn/
> diff --git a/drivers/net/ethernet/xilinx/tsn/Kconfig b/drivers/net/ethernet/xilinx/tsn/Kconfig
> new file mode 100644
> index 000000000000..53734842700b
> --- /dev/null
> +++ b/drivers/net/ethernet/xilinx/tsn/Kconfig
> @@ -0,0 +1,14 @@
> +config XILINX_TSN
> +	tristate "Xilinx TSN Ethernet driver"
> +	depends on OF && HAS_IOMEM

No ARCH_XILINX?

> +	select PHYLIB
> +	select NET_DEVLINK
> +	select NET_DEV_STATS
> +	help
> +	  This driver supports the Xilinx Time-Sensitive Networking (TSN)
> +	  Ethernet IP, which includes multiple Ethernet MACs, a TSN switch,
> +	  and an endpoint block. It provides support for scheduling,
> +	  traffic shaping, and time synchronization to meet real-time
> +	  requirements of industrial Ethernet applications.
> +


...


> +
> +/*
> + * Helper to parse TX queue config subnode referenced by
> + * xlnx,tsn-tx-config. This version enumerates child nodes in order and
> + * assigns DMA channels sequentially (queue0 == first child, etc.)
> + */
> +static int tsn_parse_tx_queue_config(struct device *dev, struct tsn_priv *common,
> +				     struct device_node *txcfg_np)
> +{
> +	struct device_node *qnode;
> +	unsigned int queue = 0;
> +	int ret = 0;
> +
> +	for_each_available_child_of_node(txcfg_np, qnode) {
> +		u32 chan;
> +
> +		if (queue >= common->num_tx_queues) {
> +			dev_err(dev, "tx-config: extra child nodes beyond %u ignored\n",
> +				common->num_tx_queues);
> +			of_node_put(qnode);

Use scoped loop.

> +			return -EINVAL;
> +		}
> +
> +		ret = of_property_read_u32(qnode, "xlnx,dma-channel-num", &chan);
> +		if (ret) {
> +			dev_err(dev, "tx-config: Q%u missing xlnx,dma-channel-num\n", queue);
> +			of_node_put(qnode);
> +			return ret;
> +		}
> +
> +		if (chan > TSN_DMA_MAX_TX_CH) {
> +			dev_err(dev, "tx-config: Q%u channel %u exceeds max %lu\n",
> +				queue, chan, TSN_DMA_MAX_TX_CH);
> +			of_node_put(qnode);
> +			return -EINVAL;
> +		}
> +		common->tx_dma_chan_map[queue++] = chan;
> +	}
> +
> +	if (queue != common->num_tx_queues) {
> +		dev_err(dev, "tx-config: described %u queues but expected %u\n",
> +			queue, common->num_tx_queues);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * tsn_parse_device_tree - Parse device tree configuration for TSN device
> + * @pdev: Platform device pointer
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int tsn_parse_device_tree(struct platform_device *pdev)
> +{
> +	struct tsn_priv *common = platform_get_drvdata(pdev);
> +	struct device_node *txcfg_np = NULL;
> +	struct device *dev = &pdev->dev;
> +	int i, ret;
> +
> +	/* Read number of priorities */
> +	ret = of_property_read_u32(dev->of_node, "xlnx,num-priorities", &common->num_priorities);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get xlnx,num-priorities\n");
> +
> +	if (common->num_priorities < TSN_MIN_PRIORITIES ||
> +	    common->num_priorities > TSN_MAX_PRIORITIES)
> +		return dev_err_probe(dev, -EINVAL, "Invalid xlnx,num-priorities (%u)\n",
> +				     common->num_priorities);
> +
> +	/* Count TX and RX queues from dma-names property */
> +	ret = of_property_count_strings(dev->of_node, "dma-names");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get dma-names\n");
> +
> +	common->num_tx_queues = 0;
> +	common->num_rx_queues = 0;
> +
> +	for (i = 0; i < ret; i++) {
> +		const char *dma_name;
> +
> +		if (of_property_read_string_index(dev->of_node, "dma-names", i, &dma_name))
> +			continue;
> +
> +		if (strncmp(dma_name, "tx_chan", 7) == 0)
> +			common->num_tx_queues++;
> +		else if (strncmp(dma_name, "rx_chan", 7) == 0)
> +			common->num_rx_queues++;
> +	}
> +
> +	if (!common->num_tx_queues || common->num_tx_queues > TSN_MAX_TX_QUEUE)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid TX queue count (%u, max %u)\n",
> +				     common->num_tx_queues, TSN_MAX_TX_QUEUE);
> +
> +	if (!common->num_rx_queues)
> +		return dev_err_probe(dev, -EINVAL, "No RX DMA channels found\n");
> +
> +	/* Setup clock IDs */
> +	for (i = 0; i < TSN_NUM_CLOCKS; i++)
> +		common->clks[i].id = tsn_clk_names[i];
> +
> +	/* Get all clocks */
> +	ret = devm_clk_bulk_get(dev, TSN_NUM_CLOCKS, common->clks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get clocks\n");
> +
> +	/* Enable clocks */
> +	ret = clk_bulk_prepare_enable(TSN_NUM_CLOCKS, common->clks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable clocks\n");
> +
> +	for (i = 0; i < TSN_MAX_TX_QUEUE; i++)
> +		common->tx_dma_chan_map[i] = TSN_DMA_CH_INVALID;
> +
> +	txcfg_np = of_parse_phandle(dev->of_node, "xlnx,tsn-tx-config", 0);
> +	if (txcfg_np) {
> +		ret = tsn_parse_tx_queue_config(dev, common, txcfg_np);
> +		of_node_put(txcfg_np);
> +		if (ret)
> +			goto err_disable_clks;
> +	}
> +
> +	return 0;
> +
> +err_disable_clks:
> +	clk_bulk_disable_unprepare(TSN_NUM_CLOCKS, common->clks);
> +	return ret;
> +}
> +
> +/**
> + * tsn_ip_probe - Probe TSN IP core device

Nooo...


> + * @pdev: Platform device pointer
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int tsn_ip_probe(struct platform_device *pdev)
> +{
> +	struct tsn_priv *common;
> +	int ret;
> +
> +	common = devm_kzalloc(&pdev->dev, sizeof(*common), GFP_KERNEL);
> +	if (!common)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, common);
> +	common->pdev = pdev;
> +	common->dev = &pdev->dev;
> +
> +	/* Initialize synchronization primitives */
> +	spin_lock_init(&common->tx_lock);
> +	spin_lock_init(&common->rx_lock);
> +	mutex_init(&common->mdio_lock);
> +
> +	common->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!common->res)
> +		return -ENODEV;
> +	common->regs_start = common->res->start;
> +	common->regs = devm_ioremap_resource(&pdev->dev, common->res);
> +	if (IS_ERR(common->regs))
> +		return PTR_ERR(common->regs);
> +
> +	ret = tsn_parse_device_tree(pdev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/**
> + * tsn_ip_remove - Remove TSN IP core device
> + * @pdev: Platform device pointer

Pointless comment. Can it be anything else than what you wrote? Why are
you adding comments to standard boilerplate calls?

> + */
> +static void tsn_ip_remove(struct platform_device *pdev)
> +{
> +	struct tsn_priv *common = platform_get_drvdata(pdev);
> +
> +	clk_bulk_disable_unprepare(TSN_NUM_CLOCKS, common->clks);
> +}
> +
> +static const struct of_device_id tsn_of_match[] = {
> +	{ .compatible = "xlnx,tsn-endpoint-ethernet-mac-3.0", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, tsn_of_match);
> +
> +static struct platform_driver tsn_driver = {
> +	.probe = tsn_ip_probe,
> +	.remove = tsn_ip_remove,
> +	.driver = {
> +		.name = "xilinx-tsn",
> +		.of_match_table = tsn_of_match,
> +	},
> +};
> +module_platform_driver(tsn_driver);
> +
> +MODULE_AUTHOR("Neeli Srinivas <srinivas.neeli@amd.com>");
> +MODULE_DESCRIPTION("Time Sensitive Networking (TSN) Ethernet MAC driver");
> +MODULE_LICENSE("GPL");


Best regards,
Krzysztof

