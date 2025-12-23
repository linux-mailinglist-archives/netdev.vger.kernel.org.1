Return-Path: <netdev+bounces-245831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3955CD8CF9
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D510301E170
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 10:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF733570B5;
	Tue, 23 Dec 2025 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PE/XXLYs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA8C354AD0;
	Tue, 23 Dec 2025 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766485180; cv=none; b=JnlPVeNgj07z+GSRldnS+Z67t+azQuv+Sfvgqd4nWcAb2leSb+wpTX02yjSYIsEhzKJpbqY22THzbOQgR75qEZnDRKJjKxgYtGeuv7BuKDUbU6Yekf+tNyy75mbK1O8kJ1b3QMuqst8dlS+u9vcC8gm47WfYIdRly7oWjGejmU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766485180; c=relaxed/simple;
	bh=KvopV8LBJtS6enE9XDXgeJgIbYjPmINms8lzNZDc+gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIT4udltDoboq6KZ0hfhe/ai/zf41CcT7Z2WAkv3VE/Tc35nhDJiHCBDzFgF+pWn3mAvRY6MVjCssIkuC51GbC2fza7NDTTqijHjRLEHqA2Q7gOd0vdTAIfPDjaoFyifnqd6sggZwbVH1p+/O7TusPpdBgnf7bMEuXxEdxFFLJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PE/XXLYs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=knGXXA+Eth0fPkQZDNRKfY7ur0+pnXQ4eeh/iyv7NyY=; b=PE/XXLYs3eYOHJAJkMmO1pWy7E
	uvefjNbPUdu98gq0WMB61MMmXcwtgJaaUHQRC1qe7sHTvwPSO8VMk+DQO2msGjeJoq6EkaNrKlBdT
	q99wYgRL4rGUUsKGbhlf36BpY2W5Rsr9+Ya6CmClJCviNLr5t7zWMh6vBd5u23CakEeQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vXzUL-000How-3G; Tue, 23 Dec 2025 11:19:33 +0100
Date: Tue, 23 Dec 2025 11:19:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 02/15] net/nebula-matrix: add simple
 probe/remove.
Message-ID: <b39ff7a2-e09d-4b4f-8d69-cb7fb630e716@lunn.ch>
References: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
 <20251223035113.31122-3-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223035113.31122-3-illusion.wang@nebula-matrix.com>

> +/* debug masks - set these bits in adapter->debug_mask to control output */
> +enum nbl_debug_mask {
> +	/* BIT0~BIT30 use to define adapter debug_mask */
> +	NBL_DEBUG_MAIN			= 0x00000001,
> +	NBL_DEBUG_COMMON		= 0x00000002,
> +	NBL_DEBUG_DEBUGFS		= 0x00000004,
> +	NBL_DEBUG_HW			= 0x00000008,
> +	NBL_DEBUG_FLOW			= 0x00000010,
> +	NBL_DEBUG_RESOURCE		= 0x00000020,
> +	NBL_DEBUG_QUEUE			= 0x00000040,
> +	NBL_DEBUG_INTR			= 0x00000080,
> +	NBL_DEBUG_ADMINQ		= 0x00000100,
> +	NBL_DEBUG_DEVLINK		= 0x00000200,
> +	NBL_DEBUG_ACCEL			= 0x00000400,
> +	NBL_DEBUG_MBX			= 0x00000800,
> +	NBL_DEBUG_ST			= 0x00001000,
> +	NBL_DEBUG_VSI			= 0x00002000,
> +	NBL_DEBUG_CUSTOMIZED_P4		= 0x00004000,
> +
> +	/* BIT31 use to distinguish netif debug level or adapter debug_mask */
> +	NBL_DEBUG_USER			= 0x80000000,
> +
> +	/* Means turn on all adapter debug_mask */
> +	NBL_DEBUG_ALL			= 0xFFFFFFFF
> +};
> +
> +#define nbl_err(common, lvl, fmt, ...)						\
> +do {										\
> +	typeof(common) _common = (common);					\
> +	if (((lvl) & NBL_COMMON_TO_DEBUG_LVL(_common)))				\
> +		dev_err(NBL_COMMON_TO_DEV(_common), fmt, ##__VA_ARGS__);	\
> +} while (0)

Please try to make use of msg_level, netif_msg_init() etc.

> +#define NBL_OK 0
> +#define NBL_CONTINUE 1
> +#define NBL_FAIL -1

You don't use these in this patch, so i cannot see how they are
actually used. But generally, you should use error codes, not -1.

Also, please only add things in a patch which are used by the
patch. Otherwise it makes it hard to review.

> +struct nbl_adapter *nbl_core_init(struct pci_dev *pdev, struct nbl_init_param *param)
> +{
> +	struct nbl_adapter *adapter;
> +	struct nbl_common_info *common;
> +	struct nbl_product_base_ops *product_base_ops;
> +
> +	if (!pdev)
> +		return NULL;
> +
> +	adapter = devm_kzalloc(&pdev->dev, sizeof(struct nbl_adapter), GFP_KERNEL);
> +	if (!adapter)
> +		return NULL;
> +
> +	adapter->pdev = pdev;
> +	common = NBL_ADAPTER_TO_COMMON(adapter);
> +
> +	NBL_COMMON_TO_PDEV(common) = pdev;
> +	NBL_COMMON_TO_DEV(common) = &pdev->dev;
> +	NBL_COMMON_TO_DMA_DEV(common) = &pdev->dev;
> +	NBL_COMMON_TO_DEBUG_LVL(common) |= NBL_DEBUG_ALL;
> +	NBL_COMMON_TO_VF_CAP(common) = param->caps.is_vf;
> +	NBL_COMMON_TO_OCP_CAP(common) = param->caps.is_ocp;
> +	NBL_COMMON_TO_PCI_USING_DAC(common) = param->pci_using_dac;
> +	NBL_COMMON_TO_PCI_FUNC_ID(common) = PCI_FUNC(pdev->devfn);

Macros like this are generally not used on the left side.

> +void nbl_core_remove(struct nbl_adapter *adapter)
> +{
> +	struct device *dev;
> +
> +	struct nbl_product_base_ops *product_base_ops;
> +
> +	if (!adapter)
> +		return;

How can that happen? If you are writing defensive code, it suggests
you don't actually understand how the driver and the kernel works.

>  static int nbl_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *id)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct nbl_adapter *adapter = NULL;
> +	struct nbl_init_param param = {{0}};
> +	int err;
> +
> +	dev_info(dev, "nbl probe\n");

deb_debug(), or not at all.

>  
> +	err = pci_enable_device(pdev);
> +	if (err)
> +		return err;
> +
> +	param.pci_using_dac = true;
> +	nbl_get_func_param(pdev, id->driver_data, &param);
> +
> +	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (err) {
> +		dev_info(dev, "Configure DMA 64 bit mask failed, err = %d\n", err);
> +		param.pci_using_dac = false;
> +		err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +		if (err) {
> +			dev_err(dev, "Configure DMA 32 bit mask failed, err = %d\n", err);
> +			goto configure_dma_err;
> +		}
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	pci_save_state(pdev);
> +
> +	adapter = nbl_core_init(pdev, &param);
> +	if (!adapter) {
> +		dev_err(dev, "Nbl adapter init fail\n");
> +		err = -EAGAIN;

EAGAIN is an odd code for a probe failure.

>  static void nbl_remove(struct pci_dev *pdev)
>  {
> +	struct nbl_adapter *adapter = pci_get_drvdata(pdev);
> +
> +	dev_info(&pdev->dev, "nbl remove\n");

All these dev_info() messages suggests you have not fully debugged
your driver, even the basics of probe and remove! Production quality
code should not need these.

	Andrew

