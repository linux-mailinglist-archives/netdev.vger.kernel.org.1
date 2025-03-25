Return-Path: <netdev+bounces-177311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA9BA6EE2A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7B9169C8D
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 10:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCAF1F0E38;
	Tue, 25 Mar 2025 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwv2jgic"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07AA1C5D50;
	Tue, 25 Mar 2025 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899613; cv=none; b=jOdAGbCPTlJ8us7n3aq7HuCvzKNCcz4E5aF413O+E7SS6QjGBsEllaW6d1Gk+aGR2ymlgp9iaV+NvguYB5oaVDUq+Vl6VB0H/MTSO85AE7e2cjoelul0tdrndvp8cqK8HTvZg9KAm6b/eNOQuhyPVHhJwr4Z2gqwaUQH+GVHPBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899613; c=relaxed/simple;
	bh=rqVeZKTsfR1Mw1ipXxcLoywYP3wysPSlC0jiSRkwu8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6CW0uLKRxyropIuMdJRG8iWU+xQt2Ui5tbO1GyOeIMAhhve7nn1h6dYAkNkhlx7u/F6qTxybifobFwzWXdQfsQTnaEzlpH04ib6uKY/wo4gPoaIgDD4OTDEyIpUBmgzDHaQ5woshJXEOS1+ZBr8u5eA647F/SWcmUnvUrycTfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwv2jgic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD19C4CEE4;
	Tue, 25 Mar 2025 10:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742899613;
	bh=rqVeZKTsfR1Mw1ipXxcLoywYP3wysPSlC0jiSRkwu8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bwv2jgicOKrT+0/PuMPF9JVYRWhWGnsPdExi0sLbALZIYWOLLSxskxBDkhsla5GyA
	 EZMfb6D7WzVC2jaW5kDfwAXdNjd0dJ3LOwan4R9/mTR6jnpoOK9604glTKzGVKbedS
	 zfjm6MsenHiUa+rXgA+Wva5BpGOQWSdN8UYH1nd2hR+1MnSb+YtlZYmLAXxdQfkbT1
	 uGyZLOKh2xC3wLlmMOkZLkDAJEQAXwZ7tD1qOKrhL6SU2wlny48gLCy3GFAZ+Y6Jsi
	 ED4DquLSM8QnZIj23rLbtF/0AQNUtkkmmR09IrclOq4rzrKxeUrQj4zx3PcWjlStsa
	 afECIgclpRrwg==
Date: Tue, 25 Mar 2025 03:46:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: Fan Gong <gongfan1@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Lee Trager
 <lee@trager.us>, <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>, Cai Huoqing
 <cai.huoqing@linux.dev>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Suman Ghosh
 <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Joe
 Damato <jdamato@fastly.com>
Subject: Re: [PATCH net-next v09 1/1] hinic3: module initialization and
 tx/rx logic
Message-ID: <20250325034641.65536e13@kernel.org>
In-Reply-To: <60a3c7b146920eee8b15464e0b0d1ea35db0b30e.1742202778.git.gur.stavi@huawei.com>
References: <cover.1742202778.git.gur.stavi@huawei.com>
	<60a3c7b146920eee8b15464e0b0d1ea35db0b30e.1742202778.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 11:40:39 +0200 Gur Stavi wrote:
> +static int hinic3_poll(struct napi_struct *napi, int budget)
> +{
> +	struct hinic3_irq_cfg *irq_cfg =
> +		container_of(napi, struct hinic3_irq_cfg, napi);
> +	struct hinic3_nic_dev *nic_dev;
> +	int tx_pkts, rx_pkts;
> +
> +	nic_dev = netdev_priv(irq_cfg->netdev);
> +	rx_pkts = hinic3_rx_poll(irq_cfg->rxq, budget);
> +
> +	tx_pkts = hinic3_tx_poll(irq_cfg->txq, budget);

You should service Tx first, it frees skbs into a cache which Rx 
can then use, while they are hopefully still cache-warm.

> +	if (tx_pkts >= budget || rx_pkts >= budget)
> +		return budget;
> +
> +	napi_complete(napi);

Please use napi_complete_done().

> +	hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
> +			      HINIC3_MSIX_ENABLE);
> +
> +	return max(tx_pkts, rx_pkts);
> +}

> +static int hinic3_nic_probe(struct auxiliary_device *adev,
> +			    const struct auxiliary_device_id *id)

> +	err = register_netdev(netdev);
> +	if (err)
> +		goto err_register_netdev;
> +
> +	netif_carrier_off(netdev);

You should carrier_off before you register

> +	err = pci_enable_device(pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to enable PCI device\n");
> +		goto err_pci_enable;
> +	}
> +
> +	err = pci_request_regions(pdev, HINIC3_NIC_DRV_NAME);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to request regions\n");
> +		goto err_pci_regions;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (err) {
> +		dev_warn(&pdev->dev, "Couldn't set 64-bit DMA mask\n");
> +		/* try 32 bit DMA mask if 64 bit fails */
> +		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +		if (err) {
> +			dev_err(&pdev->dev, "Failed to set DMA mask\n");
> +			goto err_dma_mask;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_dma_mask:
> +	pci_clear_master(pdev);
> +	pci_release_regions(pdev);
> +
> +err_pci_regions:
> +	pci_disable_device(pdev);
> +
> +err_pci_enable:
> +	pci_set_drvdata(pdev, NULL);
> +	mutex_destroy(&pci_adapter->pdev_mutex);
> +	kfree(pci_adapter);

Please name the error labels after the target, not the source.

Quoting documentation:

  Choose label names which say what the goto does or why the goto exists.  An
  example of a good name could be ``out_free_buffer:`` if the goto frees ``buffer``.

See: https://www.kernel.org/doc/html/next/process/coding-style.html#centralized-exiting-of-functions
-- 
pw-bot: cr

