Return-Path: <netdev+bounces-247871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3050CCFFEE3
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 21:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9099C30640D5
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 19:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BA33016F5;
	Wed,  7 Jan 2026 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRx+N1r0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CEC2D0C82
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767815553; cv=none; b=XBZc2mpaBJMPWXApOPSiOlPWtTWTZeCw3Th/ud2oAqVG8Dk0oZlpsbOy3zoqwbiG+mWJJuHJEH7T3nXpu1AOFXXrLoefRTYqUfFzggJ1sv59msp8JNmHuMGVv7UljHI0P2RpP1QBiIUingCVoTwJil/8JYkVnqbBY6nopSYz8xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767815553; c=relaxed/simple;
	bh=ME633nhesKm5jN5VwCjnblGWeeMNvw4MOrAsn7EWx3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sONGlnOlfJ/slOre9srB6AZeqSLs2MJb0ipLGwhiEOsKJ5jlNxqOH2UsdIZ0bhWDl+lxvqJX8T6bYO70ApYmLJdw/+kLf3/pGCU2hbh3pn7ECfEP9BINqe6qSbCuTkvTopCwulHvd3TK080Eq0eHILk9Dar+DWmbXAODSNfWYEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRx+N1r0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80785C4CEF1;
	Wed,  7 Jan 2026 19:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767815553;
	bh=ME633nhesKm5jN5VwCjnblGWeeMNvw4MOrAsn7EWx3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QRx+N1r0YpLho23+AOIo5rtaev41qq/pI7L9pvYE+v1cFUv82F2a9TVHdsOgculAA
	 85+lzo72rjut6faePbT5lpIA1lB5oCSQ+N2zR/flxBz+uteygq7OjwUyW2o9l4SZB1
	 Kqrg717A2g5/hpvyVauJ7w5PVahuT0UXYjcTt67IBRgcaKQ3B5eFHgGeHOfRsSCgbp
	 hIvxoEWp8SELNtr8GlfT2W2oQ9Onqs6b/oD6t9uUxntv1VixVZRTbN1l7TFrGU/Jt1
	 FD/BYYlD0YZRIeDAA8EYzD3RcCRiowYw3DKDVXAdC1VeL6KJDQhG0KT6o2Ifkg5wFd
	 QuQqoL5ib/6ow==
Date: Wed, 7 Jan 2026 19:52:27 +0000
From: Simon Horman <horms@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Dong Yibo <dong100@mucse.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	MD Danish Anwar <danishanwar@ti.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v18 1/6] eea: introduce PCI framework
Message-ID: <20260107195227.GE345651@kernel.org>
References: <20260105110712.22674-1-xuanzhuo@linux.alibaba.com>
 <20260105110712.22674-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105110712.22674-2-xuanzhuo@linux.alibaba.com>

On Mon, Jan 05, 2026 at 07:07:07PM +0800, Xuan Zhuo wrote:
> Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA).
> 
> This commit implements the EEA PCI probe functionality.
> 
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

...

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c

...

> +static int eea_pci_setup(struct pci_dev *pci_dev, struct eea_pci_device *ep_dev)
> +{
> +	int err, n, ret;
> +
> +	ep_dev->pci_dev = pci_dev;
> +
> +	err = pci_enable_device(pci_dev);
> +	if (err)
> +		return err;
> +
> +	err = pci_request_regions(pci_dev, "EEA");
> +	if (err)
> +		goto err_disable_dev;
> +
> +	pci_set_master(pci_dev);
> +
> +	err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
> +	if (err) {
> +		dev_warn(&pci_dev->dev, "Failed to enable 64-bit DMA.\n");
> +		goto err_release_regions;
> +	}
> +
> +	ep_dev->reg = pci_iomap(pci_dev, 0, 0);
> +	if (!ep_dev->reg) {
> +		dev_err(&pci_dev->dev, "Failed to map pci bar!\n");
> +		err = -ENOMEM;
> +		goto err_release_regions;
> +	}
> +
> +	ep_dev->edev.rx_num = cfg_read32(ep_dev->reg, rx_num_max);
> +	ep_dev->edev.tx_num = cfg_read32(ep_dev->reg, tx_num_max);
> +
> +	/* 2: adminq, error handle*/
> +	n = ep_dev->edev.rx_num + ep_dev->edev.tx_num + 2;
> +	ret = pci_alloc_irq_vectors(ep_dev->pci_dev, n, n, PCI_IRQ_MSIX);
> +	if (ret != n)
> +		goto err_unmap_reg;

Hi,

As n is passed as both the min_vecs and max_vecs argument of
pci_alloc_irq_vectors() I believe that ret will either be n, on success,
or an negative error value error.

And on error I think it would be appropriate for this function
to return that error value, rather than 0 s is currently the case.

Something like this (completely untested!):

	err = pci_alloc_irq_vectors(ep_dev->pci_dev, n, n, PCI_IRQ_MSIX);
	if (err < 0)
		goto err_unmap_reg;

Function return value portion of the above flagged by Smatch.

> +
> +	ep_dev->msix_vec_n = ret;
> +
> +	ep_dev->db_base = ep_dev->reg + EEA_PCI_DB_OFFSET;
> +	ep_dev->edev.db_blk_size = cfg_read32(ep_dev->reg, db_blk_size);
> +
> +	return 0;
> +
> +err_unmap_reg:
> +	pci_iounmap(pci_dev, ep_dev->reg);
> +	ep_dev->reg = NULL;
> +
> +err_release_regions:
> +	pci_release_regions(pci_dev);
> +
> +err_disable_dev:
> +	pci_disable_device(pci_dev);
> +
> +	return err;
> +}

...

-- 
pw-bot: cr

