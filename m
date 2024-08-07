Return-Path: <netdev+bounces-116487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41FB94A8F9
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE89280DC2
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307C61EA0BB;
	Wed,  7 Aug 2024 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISe/qzpw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CF31E7A4A;
	Wed,  7 Aug 2024 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038516; cv=none; b=PIJ7bOJDPE13PABGHyuTtpwzEZSX7gphtUmSlP10LMnE6+fOoJ+kuosQEWGJWC//6f5RuAwjahBS2SM/Tg5C4IOUQSzirCtmQkm+Stq9tkKScBAKAiGKQzIM0es8Q7q6J9zduc6+dfkglc7B4kHXJq/nHhJYH2WEDb8mczMvrtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038516; c=relaxed/simple;
	bh=aMPbIJZAXpO86db7TbZfZ8QZVpXYAc9qcpr6hYKyHmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbTYAXt5OD90yfaStaMjD9bWW8RkTg3wjhBzq0OLWalLgzKq83GY7wRN4ZCd8UctsBr4TOM8b3L0UFCVyMXj726S2979WYL6G3qIB8fPyTBMF4pf4hESnNvP1Fqd619koPdIvu9Mx1avcwUr2vsZeiMO4AyvbLn7R3u5wwXu9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISe/qzpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DB2C32781;
	Wed,  7 Aug 2024 13:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723038515;
	bh=aMPbIJZAXpO86db7TbZfZ8QZVpXYAc9qcpr6hYKyHmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISe/qzpwh7izfl2WTHT5hdIhqNJhwnNsD/MW+3m1Bb1f0LgRrhX4lD3L0V+6FDjty
	 iwg1WP6IGNT/zrsFIZzl+5BLtryYCA3uVByu3qH9PIJTn8x8xuy2WE7f9UM0IgGOJZ
	 VxX5dQmLfjmntNMDocVx9MwThWxIK8oNhPhSVIQYG6Qmr8oTeqncS1rET4XGPeuAVN
	 Ty4PbFjHd7Vd1wMYQ4LyHkhT58UnE7ay10OfVOYPpwaq6wwX2vogIOsMRyOr9oQ0Lu
	 uPGczt5V/W4lblHaF+R+PX6HlCHnV0uNDDsA9uvU5TAPg8T35vRwiunqTJL7e/kj/T
	 S4ZzkRgaoJN9g==
Date: Wed, 7 Aug 2024 14:48:31 +0100
From: Simon Horman <horms@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, eperezma@redhat.com,
	Kyle Xu <zhenbing.xu@corigine.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, oss-drivers@corigine.com
Subject: Re: [RFC net-next 3/3] drivers/vdpa: add NFP devices vDPA driver
Message-ID: <20240807134831.GB2991391@kernel.org>
References: <20240802095931.24376-1-louis.peens@corigine.com>
 <20240802095931.24376-4-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240802095931.24376-4-louis.peens@corigine.com>

On Fri, Aug 02, 2024 at 11:59:31AM +0200, Louis Peens wrote:
> From: Kyle Xu <zhenbing.xu@corigine.com>
> 
> Add a new kernel module ‘nfp_vdpa’ for the NFP vDPA networking driver.
> 
> The vDPA driver initializes the necessary resources on the VF and the
> data path will be offloaded. It also implements the ‘vdpa_config_ops’
> and the corresponding callback interfaces according to the requirement
> of kernel vDPA framework.
> 
> Signed-off-by: Kyle Xu <zhenbing.xu@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>

...

> diff --git a/drivers/vdpa/netronome/nfp_vdpa_main.c b/drivers/vdpa/netronome/nfp_vdpa_main.c

...

> +static int nfp_vdpa_map_resources(struct nfp_vdpa_net *ndev,
> +				  struct pci_dev *pdev,
> +				  const struct nfp_dev_info *dev_info)
> +{
> +	unsigned int bar_off, bar_sz, tx_bar_sz, rx_bar_sz;
> +	unsigned int max_tx_rings, max_rx_rings, txq, rxq;
> +	u64 tx_bar_off, rx_bar_off;
> +	resource_size_t map_addr;
> +	void __iomem  *tx_bar;
> +	void __iomem  *rx_bar;

Hi Kyle and Louis,

A minor nit from my side: rx_bar is set but otherwise unused in this function.

> +	int err;
> +
> +	/* Map CTRL BAR */
> +	ndev->ctrl_bar = ioremap(pci_resource_start(pdev, NFP_NET_CTRL_BAR),
> +				 NFP_NET_CFG_BAR_SZ);
> +	if (!ndev->ctrl_bar)
> +		return -EIO;
> +
> +	/* Find out how many rings are supported */
> +	max_tx_rings = readl(ndev->ctrl_bar + NFP_NET_CFG_MAX_TXRINGS);
> +	max_rx_rings = readl(ndev->ctrl_bar + NFP_NET_CFG_MAX_RXRINGS);
> +	/* Currently, only one ring is supported */
> +	if (max_tx_rings != NFP_VDPA_QUEUE_RING_MAX || max_rx_rings != NFP_VDPA_QUEUE_RING_MAX) {
> +		err = -EINVAL;
> +		goto ctrl_bar_unmap;
> +	}
> +
> +	/* Map Q0_BAR as a single overlapping BAR mapping */
> +	tx_bar_sz = NFP_QCP_QUEUE_ADDR_SZ * max_tx_rings * NFP_VDPA_QUEUE_SPACE_STRIDE;
> +	rx_bar_sz = NFP_QCP_QUEUE_ADDR_SZ * max_rx_rings * NFP_VDPA_QUEUE_SPACE_STRIDE;
> +
> +	txq = readl(ndev->ctrl_bar + NFP_NET_CFG_START_TXQ);
> +	tx_bar_off = nfp_qcp_queue_offset(dev_info, txq);
> +	rxq = readl(ndev->ctrl_bar + NFP_NET_CFG_START_RXQ);
> +	rx_bar_off = nfp_qcp_queue_offset(dev_info, rxq);
> +
> +	bar_off = min(tx_bar_off, rx_bar_off);
> +	bar_sz = max(tx_bar_off + tx_bar_sz, rx_bar_off + rx_bar_sz);
> +	bar_sz -= bar_off;
> +
> +	map_addr = pci_resource_start(pdev, NFP_NET_Q0_BAR) + bar_off;
> +	ndev->q_bar = ioremap(map_addr, bar_sz);
> +	if (!ndev->q_bar) {
> +		err = -EIO;
> +		goto ctrl_bar_unmap;
> +	}
> +
> +	tx_bar = ndev->q_bar + (tx_bar_off - bar_off);
> +	rx_bar = ndev->q_bar + (rx_bar_off - bar_off);
> +
> +	/* TX queues */
> +	ndev->vring[txq].kick_addr = ndev->ctrl_bar + NFP_VDPA_NOTIFY_AREA_BASE
> +				     + txq * NFP_VDPA_QUEUE_NOTIFY_OFFSET;
> +	/* RX queues */
> +	ndev->vring[rxq].kick_addr = ndev->ctrl_bar + NFP_VDPA_NOTIFY_AREA_BASE
> +				     + rxq * NFP_VDPA_QUEUE_NOTIFY_OFFSET;
> +	/* Stash the re-configuration queue away. First odd queue in TX Bar */
> +	ndev->qcp_cfg = tx_bar + NFP_QCP_QUEUE_ADDR_SZ;
> +
> +	return 0;
> +
> +ctrl_bar_unmap:
> +	iounmap(ndev->ctrl_bar);
> +	return err;
> +}

...

