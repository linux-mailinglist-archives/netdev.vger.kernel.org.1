Return-Path: <netdev+bounces-86243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920F289E2CC
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 20:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FF71C214E4
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 18:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEFF156F3F;
	Tue,  9 Apr 2024 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma4i4AIG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EDC130A72
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689095; cv=none; b=qaKOacDpsI2RQoAcF8gJKMahIHS1op7RghpMdWAIhBewzpXTKmxtVrigIl1Iigf50/7zGYdxoSCKxFtCQHdtb8u+rxYfAFdXuzXnBeoukaAk2XIqKfui/wyt+r7J0p6wqyLUywHY5md7Oiud1+GGLh4gSdzsNpW9/6zrgRM+ig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689095; c=relaxed/simple;
	bh=TmVtodn7Pkv2k4A8Eo4kdnyfy+pkPXpL2fW0LH0hSPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcfBnshCapnjOW2fGGuPS7SG4TPB/xMIVBhfLZ8yvNJTqSHKs4FkONcZGz9COf0Yxe0KNWUgf/VHUnMmb0joKcL1lYSChXV9xpVAdPEtPibV3F+0CsoO134jSqGr1e5VmycNjudZDgtsCuib6w49YkRfBrMWxYrNHU6WSuG5B/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma4i4AIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C78FC433C7;
	Tue,  9 Apr 2024 18:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712689095;
	bh=TmVtodn7Pkv2k4A8Eo4kdnyfy+pkPXpL2fW0LH0hSPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ma4i4AIGsHCZaZ6d5SqgdS6YAjTvqCK5rNGnYInnq9SLan1gbS9lO3o2NeFNf7uV0
	 IpvamegJb3Desw541qdcvlR2BaDWlsE9dg5IubAWUvB9fRGsFNKKJ1+JQlUeCZMGKg
	 tE6IlZVcHwZFx3C3z7AvQP0sWBvzW4hnEgCKEY389TZ/C5UGSnBQOUFf4g7gGPN7xu
	 BVUxZljq4/5H1S15WMbKgD4Dd0rTWNqWwe425wZ8V3dUroWF9Abhi7j7wIiiziOjKR
	 0wbTopCp5sauPhn93g+0iF5ilV5FOgZ6HxB03rskRfNtRqolIuvFPu3/iXDWNvBMtk
	 FKe6zAe8Vv5Mg==
Date: Tue, 9 Apr 2024 19:58:09 +0100
From: Simon Horman <horms@kernel.org>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org, linux@armlinux.org.uk,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v10 6/6] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
Message-ID: <20240409185809.GN26556@kernel.org>
References: <cover.1712668711.git.siyanteng@loongson.cn>
 <77daabe9ca5c62168d9e54a81b5822e9b898eeb3.1712668711.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77daabe9ca5c62168d9e54a81b5822e9b898eeb3.1712668711.git.siyanteng@loongson.cn>

On Tue, Apr 09, 2024 at 10:04:34PM +0800, Yanteng Si wrote:

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c

...

> @@ -145,42 +568,37 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  			goto err_disable_device;
>  		}
>  		plat->phy_interface = phy_mode;
> -
> -		res.irq = of_irq_get_byname(np, "macirq");
> -		if (res.irq < 0) {
> -			dev_err(&pdev->dev, "IRQ macirq not found\n");
> -			ret = -ENODEV;
> -			goto err_disable_msi;
> -		}
> -
> -		res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> -		if (res.wol_irq < 0) {
> -			dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
> -			res.wol_irq = res.irq;
> -		}
> -
> -		res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
> -		if (res.lpi_irq < 0) {
> -			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> -			ret = -ENODEV;
> -			goto err_disable_msi;
> -		}
> -	} else {
> -		res.irq = pdev->irq;
>  	}
>  
> -	pci_enable_msi(pdev);
>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
>  
> +	ld->dev = &pdev->dev;
> +	plat->bsp_priv = ld;
> +	loongson_gmac = readl(res.addr + GMAC_VERSION) & 0xff;
> +
> +	switch (loongson_gmac) {
> +	case LOONGSON_DWMAC_CORE_1_00:
> +		plat->setup = loongson_gnet_setup;
> +		/* Only channel 0 of the 0x10 device supports checksum,
> +		 * so turn off checksum to enable multiple channels.
> +		 */
> +		for (i = 1; i < CHANNEL_NUM; i++) {
> +			plat->tx_queues_cfg[i].coe_unsupported = 1;
> +		};

nit: '}' rather than '};'

> +		ret = loongson_dwmac_config_msi(pdev, plat, &res, np);
> +		break;
> +	default:	/* 0x35 device and 0x37 device. */
> +		ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
> +		break;
> +	}
> +
>  	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>  	if (ret)
> -		goto err_disable_msi;
> +		goto err_disable_device;
>  
>  	return ret;
>  
> -err_disable_msi:
> -	pci_disable_msi(pdev);
>  err_disable_device:
>  	pci_disable_device(pdev);
>  err_put_node:

...

