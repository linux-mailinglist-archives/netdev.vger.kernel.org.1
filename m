Return-Path: <netdev+bounces-212987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E45ACB22BD3
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EAEA1A28071
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D302F5493;
	Tue, 12 Aug 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eXfRhsSN"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBFB10E3
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013082; cv=none; b=HgGGTBMQT1CNwhNPeYucFy8wqy+8yntOwsNMyv9ZY7Hhs9bAMmWirzUqvo9XkQtGn52MiUnXSRKuhuRIPgv7E6iFwcXJ00tgYPQlhA3Xzz8nBc+LF6PGipkwd4oM9jwILUuW+h+EGPE/t5QwGQFamPqXQybX06PPrZDmrOpSmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013082; c=relaxed/simple;
	bh=J8k9jzClXSZNkJ0K47x0UVRLYUcCO3C4lq/c7tuk38w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcahhF18jrHq8pe+Q52jWOvqheFrQuahSRvS5mwfaScsOGEqqI27CUGl7n/L+ffTQEvfNbYa0d/ZJXOKc48W7uMC/BIq8RU3u0CdoSsSyqydDCvOsbr5CVy+hiI4+EVkgkQBxSyUe/U5cjvVK26BnuMlyWv1eAowFa4HC6iR0Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eXfRhsSN; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <590a44a2-20a2-4a3f-b57f-5bf194712bf2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755013077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVS20g5BT1BM7m+YRgAX195K9V79YnewkSuGBlHYS24=;
	b=eXfRhsSN1BHo1ny1dpqr3LpVSdoEh1joTkzNRtWZUlHRRZCz7qidLLiOJO+y0AD07DqQlI
	M1BE9t8jOBxLLWnEV1txSBG1YxpsDheQYFLk3Pn8uqFyBPvRKJjjxZF2QK+sj9PFOotAuH
	C0VMjAu29+Z1b2a0cwYZLKi9VLcwnRA=
Date: Tue, 12 Aug 2025 16:37:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/5] net: rnpgbe: Add build support for rnpgbe
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
 <20250812093937.882045-2-dong100@mucse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250812093937.882045-2-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/08/2025 10:39, Dong Yibo wrote:
> Add build options and doc for mucse.
> Initialize pci device access for MUCSE devices.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---

[...]

> +/**
> + * rnpgbe_probe - Device initialization routine
> + * @pdev: PCI device information struct
> + * @id: entry in rnpgbe_pci_tbl
> + *
> + * rnpgbe_probe initializes a PF adapter identified by a pci_dev
> + * structure.
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	int err;
> +
> +	err = pci_enable_device_mem(pdev);
> +	if (err)
> +		return err;
> +
> +	err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(56));
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"No usable DMA configuration, aborting %d\n", err);
> +		goto err_dma;
> +	}
> +
> +	err = pci_request_mem_regions(pdev, rnpgbe_driver_name);
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"pci_request_selected_regions failed 0x%x\n", err);
> +		goto err_pci_req;
> +	}
> +
> +	pci_set_master(pdev);
> +	pci_save_state(pdev);
> +
> +	return 0;
> +err_dma:
> +err_pci_req:
> +	pci_disable_device(pdev);
> +	return err;
> +}

Why do you need 2 different labels pointing to the very same line? The
code is not changed through patchset, I see no reasons to have it like
this



