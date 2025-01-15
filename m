Return-Path: <netdev+bounces-158561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3906AA127EB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8E9188BACA
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E164146D40;
	Wed, 15 Jan 2025 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZqNIYZc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7969F24A7C4
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956497; cv=none; b=uT0G5SQ8TGEfLrYtyDeaAoyxBxTAozDORVEmHkQKUmOZ5IZN3LWbHH9g843PlAVVa+7ntVxiJFhU+XV3Jad6NzeTQE8jE0AEIiuYhRpn+bUE+TZ2YBbMmTA3o+iGefyt9LeY1BPd86CXYkPQ/HbMtndfpsJwlXs2S6YQmmA+AOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956497; c=relaxed/simple;
	bh=hEtlioN6X7ERl4nlGh0NmlPefyzDMuNdQpg1m5c6TYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjPrvwkmfQG+QenbWZ91X4H9cAh3Fd+RrhZc+9UP1OZePe8Qp1D5+cELN9czkw3D40vHKNoG+jQpCKktOcsqOGOkQRVqi1tYbomOomIhqJgRtBoBgbmqswbXv+8moJBKtJFn9uL5Ctt7q004R0hD1eg6PR8NY7OXZyxqj4DTZRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZqNIYZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72B5C4CED1;
	Wed, 15 Jan 2025 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736956497;
	bh=hEtlioN6X7ERl4nlGh0NmlPefyzDMuNdQpg1m5c6TYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZqNIYZcHo3QDhaZ+q1m07apetc5IUqBpYfiTdz9VJhJpxJme3Y0jBB7RdXFw1Ao2
	 tZCMmJE/4Sf71U1bFLQSrL868/gkl30Uzghj09tx7k4G9N4l/UJ0YYYSeJgKItmYuA
	 4bIhQlDnZMNuznUZGJBEuDPM5PSVbTsIdkdetcEFOTK4mLkdYcXH7Rl3FV1cDwjqdO
	 byWfbQOiH8N9iSZyORr5ECfdziakZcSHz1IRdECV9zmaUUDVKOFXoIlJPe1mW+xxeU
	 xZ5IKXDVNAcEVS5t5hqPmiKRttEe0UYyX5g+1esZlnX8ie1JCj0A7qarMY5drivuU7
	 7bKxVXym5PIDQ==
Date: Wed, 15 Jan 2025 15:54:52 +0000
From: Simon Horman <horms@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com
Subject: Re: [PATCH v3 01/14] net-next/yunsilicon: Add xsc driver basic
 framework
Message-ID: <20250115155452.GP5497@kernel.org>
References: <20250115102242.3541496-1-tianx@yunsilicon.com>
 <20250115102242.3541496-2-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115102242.3541496-2-tianx@yunsilicon.com>

On Wed, Jan 15, 2025 at 06:22:44PM +0800, Xin Tian wrote:
> Add yunsilicon xsc driver basic framework, including xsc_pci driver
> and xsc_eth driver
> 
> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Xin Tian <tianx@yunsilicon.com>

...

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h

...

> +struct xsc_dev_resource {
> +	struct mutex alloc_mutex;	/* protect buffer alocation according to numa node */

nit: allocation

...

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c

...

> +static int xsc_pci_init(struct xsc_core_device *xdev, const struct pci_device_id *id)
> +{
> +	struct pci_dev *pdev = xdev->pdev;
> +	void __iomem *bar_base;
> +	int bar_num = 0;
> +	int err;
> +
> +	xdev->numa_node = dev_to_node(&pdev->dev);
> +
> +	err = xsc_pci_enable_device(xdev);
> +	if (err) {
> +		pci_err(pdev, "failed to enable PCI device: err=%d\n", err);
> +		goto err_ret;
> +	}
> +
> +	err = pci_request_region(pdev, bar_num, KBUILD_MODNAME);
> +	if (err) {
> +		pci_err(pdev, "failed to request %s pci_region=%d: err=%d\n",
> +			KBUILD_MODNAME, bar_num, err);
> +		goto err_disable;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	err = set_dma_caps(pdev);
> +	if (err) {
> +		pci_err(pdev, "failed to set DMA capabilities mask: err=%d\n", err);
> +		goto err_clr_master;
> +	}
> +
> +	bar_base = pci_ioremap_bar(pdev, bar_num);
> +	if (!bar_base) {
> +		pci_err(pdev, "failed to ioremap %s bar%d\n", KBUILD_MODNAME, bar_num);

Should err, which will be the return value of the function,
be set to a negative error value here? As is, the function will
return 0.

> +		goto err_clr_master;
> +	}
> +
> +	err = pci_save_state(pdev);
> +	if (err) {
> +		pci_err(pdev, "pci_save_state failed: err=%d\n", err);
> +		goto err_io_unmap;
> +	}
> +
> +	xdev->bar_num = bar_num;
> +	xdev->bar = bar_base;
> +
> +	return 0;
> +
> +err_io_unmap:
> +	pci_iounmap(pdev, bar_base);
> +err_clr_master:
> +	pci_clear_master(pdev);
> +	pci_release_region(pdev, bar_num);
> +err_disable:
> +	xsc_pci_disable_device(xdev);
> +err_ret:
> +	return err;
> +}

...

