Return-Path: <netdev+bounces-115761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209B2947B78
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 14:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85351F23A3C
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0564D15A865;
	Mon,  5 Aug 2024 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYw9jc+1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D412915ADB4;
	Mon,  5 Aug 2024 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862668; cv=none; b=APb6ryPpb1TvC9hy3KnSEkH39KiwAV6D+Qx7bj5JwZPsfjpKHJDU0pRBHqfHe7Ece9GzZgejrZF6LRuYPmx3ia8wxMnjoV3e6STjR8e8nulIRtOLBnE+UndD8H34OwEnMjwJnZvhV3JKuG8mDOR9MU6GGoPzB/E3OhbtuLTHdUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862668; c=relaxed/simple;
	bh=iC4pzO+/1NuCikTQwHyLFa0Apbh96dheX7ILPdb7Psc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EROvyeWjPC34RDF4E2AxqZHqPgWCzYZhGUcM43PcEI2D7WDJBwRwUIngeiNoEAkWxZCcuTnM/p+xEGHKynB65ZY2g1MtPemxv31cb/H058o7x2ALokj4vkbN1qogQehNQI+SWY8j1oOL2OWqtsJ8kP3AIQPoG1ZHj0ML1sndbAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYw9jc+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AA8C32782;
	Mon,  5 Aug 2024 12:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722862668;
	bh=iC4pzO+/1NuCikTQwHyLFa0Apbh96dheX7ILPdb7Psc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYw9jc+1P/pKkLh5tKU09pNGCjWmakf91grraZ8wxGY+hH2yrpP4Iv3YrU+r9IwxK
	 5IYi3VBXBtYeEfs56tlL1zVb6uRcPonKc+v6/30wo3SbZ0Fdw0ZtAumDqy4zLBmmIu
	 /NrB/+k1btIzTQWXJT0MbtQv0cnby0Qkj3XPEdQEdNCaFrZ6uj4qelFkbMf4pWCQyU
	 +Mh/mIpvQX37xs7JQNbCqjvWqFaLV1KIi8f/qCepKT5PcfNQZe3ZFsgzJvFU9jbPA0
	 HkBPaRZFxZ1HbF4r5PYDKVS4KvmZN8ho8Qt26fBwkAOL5d4EYHq3MWX6dQMdOGgZiX
	 8K+fKyTlJ543A==
Date: Mon, 5 Aug 2024 13:57:43 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 04/10] net: hibmcge: Add interrupt supported
 in this module
Message-ID: <20240805125743.GB2633937@kernel.org>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731094245.1967834-5-shaojijie@huawei.com>

On Wed, Jul 31, 2024 at 05:42:39PM +0800, Jijie Shao wrote:
> The driver supports four interrupts: TX interrupt, RX interrupt,
> mdio interrupt, and error interrupt.
> 
> Actually, the driver does not use the mdio interrupt.
> Therefore, the driver does not request the mdio interrupt.
> 
> The error interrupt distinguishes different error information
> by using different masks. To distinguish different errors,
> the statistics count is added for each error.
> 
> To ensure the consistency of the code process, masks are added for the
> TX interrupt and RX interrupt.
> 
> This patch implements interrupt request and free, and provides a
> unified entry for the interrupt handler function. However,
> the specific interrupt handler function of each interrupt
> is not implemented currently.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

...

> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c

...

> +int hbg_irq_init(struct hbg_priv *priv)
> +{
> +	struct hbg_vector *vectors = &priv->vectors;
> +	struct hbg_irq *irq;
> +	int ret;
> +	int i;
> +
> +	ret = pci_alloc_irq_vectors(priv->pdev, HBG_VECTOR_NUM, HBG_VECTOR_NUM,
> +				    PCI_IRQ_MSI);
> +	if (ret < 0) {
> +		dev_err(&priv->pdev->dev,
> +			"failed to allocate MSI vectors, vectors = %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (ret != HBG_VECTOR_NUM) {
> +		dev_err(&priv->pdev->dev,
> +			"requested %u MSI, but allocated %d MSI\n",
> +			HBG_VECTOR_NUM, ret);
> +		ret = -EINVAL;
> +		goto free_vectors;
> +	}
> +
> +	vectors->irqs = devm_kcalloc(&priv->pdev->dev, HBG_VECTOR_NUM,
> +				     sizeof(struct hbg_irq), GFP_KERNEL);
> +	if (!vectors->irqs) {
> +		ret = -ENOMEM;
> +		goto free_vectors;
> +	}
> +
> +	/* mdio irq not request */
> +	vectors->irq_count = HBG_VECTOR_NUM - 1;
> +	for (i = 0; i < vectors->irq_count; i++) {
> +		irq = &vectors->irqs[i];
> +		snprintf(irq->name, sizeof(irq->name) - 1, "%s-%s-%s",
> +			 HBG_DEV_NAME, pci_name(priv->pdev), irq_names_map[i]);
> +
> +		irq->id = pci_irq_vector(priv->pdev, i);
> +		irq_set_status_flags(irq->id, IRQ_NOAUTOEN);

I think that you <linux/irq.h> needs to be included.
Else allmodconfig builds - on x86_64 but curiously not ARM64 - fail.

  CC      drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.o
drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c: In function 'hbg_irq_init':
drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c:150:17: error: implicit declaration of function 'irq_set_status_flags' [-Wimplicit-function-declaration]
  150 |                 irq_set_status_flags(irq->id, IRQ_NOAUTOEN);
      |                 ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c:150:47: error: 'IRQ_NOAUTOEN' undeclared (first use in this function); did you mean 'IRQF_NO_AUTOEN'?
  150 |                 irq_set_status_flags(irq->id, IRQ_NOAUTOEN);
      |                                               ^~~~~~~~~~~~
      |                                               IRQF_NO_AUTOEN

...

