Return-Path: <netdev+bounces-107060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE869198E1
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 22:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D66E0B2244D
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 20:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE45192B65;
	Wed, 26 Jun 2024 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEN5zy1G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78B18F47;
	Wed, 26 Jun 2024 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433123; cv=none; b=m4ZcN5hfhwQFnI4x2z5ARCgbvTrb1js40yp3BHVkMB1VwE685rOuy3Uej/jeFLtp+0YTklMxfHM7xWVADvPl52YCNBnu/X3KFP47shfGrSKZJBCfEIJoHCQ3mngEgE7AVcIOgj/u6hENgqDg5j/Rk5YUiPMjrF4CMzz/SLu09i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433123; c=relaxed/simple;
	bh=ITvPR08yphsLqzI9JR2Udd1xbOVY8LrbEzY/pS3TJys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzvTxEemZ6hgRtinx0X6DUrma/PoB9BuSL+8yISNr40+THsOaE1titYzvuCnuRgTYVUtKv7nPSxU+sIIdPpJoiCZmNqNHnmjLMI6fVucPmn5ulOtRaF6j/LtudXIeqKzGSDwmDtfbyY2Bt1lLfuhH9yVm7qK//vaodwZQviIV0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEN5zy1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FBDC32789;
	Wed, 26 Jun 2024 20:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719433122;
	bh=ITvPR08yphsLqzI9JR2Udd1xbOVY8LrbEzY/pS3TJys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mEN5zy1Gu+MgXMv4gGyLBUsRp8RS1X0V4JNwxeyLmiGRav1gNiZbOZpCwV0QJvbpW
	 3lVAfE7GxSyFQ4RXa4kbi9MQLM3HM/7kpBl8cZ4Tw/qK0IuPRCgiY+nXw1KX8/Gv5y
	 UQCG4mQ4DEVcg1QYgUAlhJkk+kxzLZLrIc7x/QbGvulKAmoMfj0Y9wZx32Rw+qnUP4
	 Meb6DqwiBdov8OJ05BAFfaf4LCk46eJ1Ep3kgzkFeKmGZdarVFiX2Gu5x1sQM4OGB4
	 +jXRsHeAXazuvuxKHlS0eLGRuFp9cLt3svD2KtllVawf6fhZB+girUkn2M/SL/LjdQ
	 L+PFb23p89FVg==
Date: Wed, 26 Jun 2024 21:18:35 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, andrew@lunn.ch
Subject: Re: [PATCH v3 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <20240626201835.GD3104@kernel.org>
References: <cover.1719159076.git.lorenzo@kernel.org>
 <89c9c226ddb31d9ff3d31231e8f532a3e983363a.1719159076.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89c9c226ddb31d9ff3d31231e8f532a3e983363a.1719159076.git.lorenzo@kernel.org>

On Sun, Jun 23, 2024 at 06:19:57PM +0200, Lorenzo Bianconi wrote:
> Add airoha_eth driver in order to introduce ethernet support for
> Airoha EN7581 SoC available on EN7581 development board (en7581-evb).
> en7581-evb networking architecture is composed by airoha_eth as mac
> controller (cpu port) and a mt7530 dsa based switch.
> EN7581 mac controller is mainly composed by Frame Engine (FE) and
> QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
> functionalities are supported now) while QDMA is used for DMA operation
> and QOS functionalities between mac layer and the dsa switch (hw QoS is
> not available yet and it will be added in the future).
> Currently only hw lan features are available, hw wan will be added with
> subsequent patches.
> 
> Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Lorenzo,

Some minor nits from my side.

...

> diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c

...

> +#define airoha_fe_rr(eth, offset)		airoha_rr((eth)->fe_regs, (offset))
> +#define airoha_fe_wr(eth, offset, val)		airoha_wr((eth)->fe_regs, (offset), (val))
> +#define airoha_fe_rmw(eth, offset, mask, val)	airoha_rmw((eth)->fe_regs, (offset), (mask), (val))
> +#define airoha_fe_set(eth, offset, val)		airoha_rmw((eth)->fe_regs, (offset), 0, (val))
> +#define airoha_fe_clear(eth, offset, val)	airoha_rmw((eth)->fe_regs, (offset), (val), 0)
> +
> +#define airoha_qdma_rr(eth, offset)		airoha_rr((eth)->qdma_regs, (offset))
> +#define airoha_qdma_wr(eth, offset, val)	airoha_wr((eth)->qdma_regs, (offset), (val))
> +#define airoha_qdma_rmw(eth, offset, mask, val)	airoha_rmw((eth)->qdma_regs, (offset), (mask), (val))
> +#define airoha_qdma_set(eth, offset, val)	airoha_rmw((eth)->qdma_regs, (offset), 0, (val))
> +#define airoha_qdma_clear(eth, offset, val)	airoha_rmw((eth)->qdma_regs, (offset), (val), 0)

nit: Please consider line-wrapping the above so lines are 80 columns wide
     or less, which is still preferred in Networking code.

     Flagged by checkpatch.pl --max-line-length=80

...

> +static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
> +				   struct net_device *dev)
> +{
> +	struct skb_shared_info *sinfo = skb_shinfo(skb);
> +	struct airoha_eth *eth = netdev_priv(dev);
> +	int i, qid = skb_get_queue_mapping(skb);
> +	u32 nr_frags, msg0 = 0, msg1;
> +	u32 len = skb_headlen(skb);
> +	struct netdev_queue *txq;
> +	struct airoha_queue *q;
> +	void *data = skb->data;
> +	u16 index;
> +
> +	if (skb->ip_summed == CHECKSUM_PARTIAL)
> +		msg0 |= FIELD_PREP(QDMA_ETH_TXMSG_TCO_MASK, 1) |
> +			FIELD_PREP(QDMA_ETH_TXMSG_UCO_MASK, 1) |
> +			FIELD_PREP(QDMA_ETH_TXMSG_ICO_MASK, 1);
> +
> +	/* TSO: fill MSS info in tcp checksum field */
> +	if (skb_is_gso(skb)) {
> +		if (skb_cow_head(skb, 0))
> +			goto error;
> +
> +		if (sinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
> +			tcp_hdr(skb)->check = cpu_to_be16(sinfo->gso_size);

Probably we could do better with an appropriate helper - perhaps
there is one I couldn't find one - but I think you need a cast here
to keep Sparse happy.

Something like this (completely untested!):

			tcp_hdr(skb)->check =
				(__force __sum16)cpu_to_be16(sinfo->gso_size);

...

> +static int airoha_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct net_device *dev;
> +	struct airoha_eth *eth;
> +	int err;
> +
> +	dev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(*eth),
> +				      AIROHA_NUM_TX_RING, AIROHA_NUM_RX_RING);
> +	if (!dev) {
> +		dev_err(&pdev->dev, "alloc_etherdev failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	eth = netdev_priv(dev);
> +	eth->net_dev = dev;
> +
> +	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	if (err) {
> +		dev_err(&pdev->dev, "failed configuring DMA mask\n");
> +		return err;
> +	}
> +
> +	eth->fe_regs = devm_platform_ioremap_resource_byname(pdev, "fe");
> +	if (IS_ERR(eth->fe_regs))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(eth->fe_regs),
> +				     "failed to iomap fe regs\n");
> +
> +	eth->qdma_regs = devm_platform_ioremap_resource_byname(pdev, "qdma0");
> +	if (IS_ERR(eth->qdma_regs))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(eth->qdma_regs),
> +				     "failed to iomap qdma regs\n");
> +
> +	eth->rsts[0].id = "fe";
> +	eth->rsts[1].id = "pdma";
> +	eth->rsts[2].id = "qdma";
> +	err = devm_reset_control_bulk_get_exclusive(&pdev->dev,
> +						    ARRAY_SIZE(eth->rsts),
> +						    eth->rsts);
> +	if (err) {
> +		dev_err(&pdev->dev, "failed to get bulk reset lines\n");
> +		return err;
> +	}
> +
> +	eth->xsi_rsts[0].id = "xsi-mac";
> +	eth->xsi_rsts[1].id = "hsi0-mac";
> +	eth->xsi_rsts[2].id = "hsi1-mac";
> +	eth->xsi_rsts[3].id = "hsi-mac";
> +	eth->xsi_rsts[4].id = "xfp-mac";
> +	err = devm_reset_control_bulk_get_exclusive(&pdev->dev,
> +						    ARRAY_SIZE(eth->xsi_rsts),
> +						    eth->xsi_rsts);
> +	if (err) {
> +		dev_err(&pdev->dev, "failed to get bulk xsi reset lines\n");
> +		return err;
> +	}
> +
> +	spin_lock_init(&eth->irq_lock);
> +	eth->irq = platform_get_irq(pdev, 0);
> +	if (eth->irq < 0) {
> +		dev_err(&pdev->dev, "failed reading irq line\n");

Coccinelle says:

.../airoha_eth.c:1698:2-9: line 1698 is redundant because platform_get_irq() already prints an error

...

> +const struct of_device_id of_airoha_match[] = {
> +	{ .compatible = "airoha,en7581-eth" },
> +	{ /* sentinel */ }
> +};

of_airoha_match appears to only be used in this file.
If so, it should be static.

Flagged by Sparse.

> +
> +static struct platform_driver airoha_driver = {
> +	.probe = airoha_probe,
> +	.remove_new = airoha_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = of_airoha_match,
> +	},
> +};
> +module_platform_driver(airoha_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
> +MODULE_DESCRIPTION("Ethernet driver for Airoha SoC");

> diff --git a/drivers/net/ethernet/mediatek/airoha_eth.h b/drivers/net/ethernet/mediatek/airoha_eth.h
> new file mode 100644
> index 000000000000..f7b984be4d60
> --- /dev/null
> +++ b/drivers/net/ethernet/mediatek/airoha_eth.h
> @@ -0,0 +1,793 @@
> +// SPDX-License-Identifier: GPL-2.0

The correct SPDX header comment style for .h (but not .c) files is /* ...  */

https://docs.kernel.org/6.9/process/license-rules.html#license-identifier-syntax

Flagged by checkpatch

...

