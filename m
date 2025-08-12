Return-Path: <netdev+bounces-212994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCE1B22C2A
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF0B1AA10DA
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA7123D7C6;
	Tue, 12 Aug 2025 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A+YUMXGO"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FA623D7C3
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013795; cv=none; b=kc1hnP8LLz6CG7THQ7NAAl3CkB5BvD2g4l9SYWAERGq0B0aeltuaSwIhoz6aVe7ygjK85vptOBCWwGwmOk7HWHpqY0z/wn1fCdP2WB2rWEDhihyN1tHE/qEfPg+xVfyBOm+7j8h1u4k3hPuZKB4Bq8BMKvFq+qwEEmyjnnzrF3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013795; c=relaxed/simple;
	bh=r9nRSmpQ0Q1tnVWbPzsdrA0J+YfIItvBLXSSqI5H8xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wi6fGa6RoJQE7tRX5flrNWfIrrndluzn0m/f2EN4qnqJjFTKrH5b1pD9ayt9Eroxoa8Ja1HoNnCElBNwWIiI6r/v67qCKnJimL2LxdvFo8DutylcvvqhADnwWiz4b7rCLElRSAJKgpkVYMHziQ+ucMEmL+GMwuOySovT7p/odNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A+YUMXGO; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <69d797eb-4a17-4d54-a7c0-8409fa8bc066@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755013780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ucz50+HGWOpZtiZEia1PUziWiFKm4k3f8o7eN5YWlBw=;
	b=A+YUMXGO9/ZJ/BvfIFZB/f/+10+t4OQMyamYip6EDn1+sfGFJji3Y8XrgrddrjckeRU/qt
	8cSdHxJNKXFZsSpVegngEZElXogSJJ2W3EH5+aAzR1dkpiAqMAcSJVsOvc02FofPHGTEI7
	e6F8Za4nGCi3v/l+Ovkr5h5yyiXnoUA=
Date: Tue, 12 Aug 2025 16:49:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/5] net: rnpgbe: Add n500/n210 chip support
To: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-3-dong100@mucse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250812093937.882045-3-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


> +struct mucse_dma_info {
> +	void __iomem *dma_base_addr;
> +	void __iomem *dma_ring_addr;
> +	void *back;

it might be better to keep the type of back pointer and give it
a bit more meaningful name ...

> +	u32 dma_version;
> +};
> +
> +struct mucse_eth_info {
> +	void __iomem *eth_base_addr;
> +	void *back;

.. here ...

> +};
> +
> +struct mucse_mac_info {
> +	void __iomem *mac_addr;
> +	void *back;

and here...

> +};
> +
> +struct mucse_mbx_info {
> +	/* fw <--> pf mbx */
> +	u32 fw_pf_shm_base;
> +	u32 pf2fw_mbox_ctrl;
> +	u32 pf2fw_mbox_mask;
> +	u32 fw_pf_mbox_mask;
> +	u32 fw2pf_mbox_vec;
> +};
> +
> +struct mucse_hw {
> +	void *back;

you can also use container_of() as all these structures are embedded and
simple pointer math can give you proper result.

> +	void __iomem *hw_addr;
> +	void __iomem *ring_msix_base;
> +	struct pci_dev *pdev;
> +	enum rnpgbe_hw_type hw_type;
> +	struct mucse_dma_info dma;
> +	struct mucse_eth_info eth;
> +	struct mucse_mac_info mac;
> +	struct mucse_mbx_info mbx;
> +	u32 driver_version;
> +	u16 usecstocount;
> +};
> +
>   struct mucse {
>   	struct net_device *netdev;
>   	struct pci_dev *pdev;
> +	struct mucse_hw hw;
>   	u16 bd_number;
>   };
>   

[...]

> +/**
> + * rnpgbe_add_adapter - Add netdev for this pci_dev
> + * @pdev: PCI device information structure
> + * @info: chip info structure
> + *
> + * rnpgbe_add_adapter initializes a netdev for this pci_dev
> + * structure. Initializes Bar map, private structure, and a
> + * hardware reset occur.
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +static int rnpgbe_add_adapter(struct pci_dev *pdev,
> +			      const struct rnpgbe_info *info)
> +{
> +	struct net_device *netdev;
> +	void __iomem *hw_addr;
> +	static int bd_number;

it's not clear from the patchset why do you need this static variable...

> +	struct mucse *mucse;
> +	struct mucse_hw *hw;
> +	u32 dma_version = 0;
> +	u32 queues;
> +	int err;
> +
> +	queues = info->total_queue_pair_cnts;
> +	netdev = alloc_etherdev_mq(sizeof(struct mucse), queues);
> +	if (!netdev)
> +		return -ENOMEM;
> +
> +	SET_NETDEV_DEV(netdev, &pdev->dev);
> +	mucse = netdev_priv(netdev);
> +	mucse->netdev = netdev;
> +	mucse->pdev = pdev;
> +	mucse->bd_number = bd_number++;

... but this code is racy by design

> +	pci_set_drvdata(pdev, mucse);
> +
> +	hw = &mucse->hw;
> +	hw->back = mucse;
> +	hw->hw_type = info->hw_type;
> +	hw->pdev = pdev;
> +

