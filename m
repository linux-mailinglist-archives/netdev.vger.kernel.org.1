Return-Path: <netdev+bounces-112447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5429391C4
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 17:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24121F21E96
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 15:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7892B16E863;
	Mon, 22 Jul 2024 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="of/IaUFN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5410616DEDD
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662070; cv=none; b=cJ6wMY4InKerDzEQ1wM+bz+S2CGfJvLtEFymozadk11FLtuLXXPaA0XXSc1zS4KJlB1YeIUVylI8rZs/XmoYbqb6Kc/L+qxH//MyeCpgCOKqu+rKGeQ3wiATkHAxygPSycHrSmOva0ULrrjEE7mkll7LLM0V2zkCdVVhnaFGV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662070; c=relaxed/simple;
	bh=CAMKUMbLEt8QbY8Je94AUIS6dKuWUKYhwa1NBEdOgXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTRbknbaS607l6Hcd6bkRRuDVGc6liqZmqkVKzKhOih33LwsFgMBHlvHppLvSlaM5lCjTiTnf/3ErhEyE/1cd7SnDzx4DPfirzIEJusaHfmDUlUzXBW9pi0mFRc1DbAI48Yy3/494iaG4bIXc6Rb9hA76Z32UYTTl9oKicCXs9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=of/IaUFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF299C116B1;
	Mon, 22 Jul 2024 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721662069;
	bh=CAMKUMbLEt8QbY8Je94AUIS6dKuWUKYhwa1NBEdOgXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=of/IaUFN7rJA2ZwiyjAvG21TyUlraL2n3k9h0cBnppaKTacEnEVX2NyrDnFRGn+v+
	 QtNZLITmoT+wf24vO4wEv4TUCXNre42SKXCYRp8qpqtPqK1MmVwT263+WtxJGv14x6
	 ErkXxvlz84l9ZhTa/Y9z+V9+k1tEGXpEcD+YsuU1bTRGQ9lPBrzSKoGaSSSseU7CFj
	 B7yl60IJQrxEosnNLjBX1cS74ot11NTgKE5Tn42o/jLBKQsGJvhhjtl8eoqHg7rEm4
	 Te93jAvTu76hAtqQ7OH9Tq5dPlFcjsfaL7b/gJHhYhVf+qfOmXzuFveGtsCPpYCbC3
	 Y7kgOA/e8DQVA==
Date: Mon, 22 Jul 2024 16:27:44 +0100
From: Simon Horman <horms@kernel.org>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, diasyzhang@tencent.com,
	Jose.Abreu@synopsys.com, chenhuacai@kernel.org,
	linux@armlinux.org.uk, guyinggang@loongson.cn,
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
	si.yanteng@linux.dev, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH net-next RFC v15 11/14] net: stmmac: dwmac-loongson: Add
 DT-less GMAC PCI-device support
Message-ID: <20240722152744.GA15209@kernel.org>
References: <cover.1721645682.git.siyanteng@loongson.cn>
 <69b137e3ee5917264d3278d4091770aca891d21e.1721645682.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b137e3ee5917264d3278d4091770aca891d21e.1721645682.git.siyanteng@loongson.cn>

On Mon, Jul 22, 2024 at 07:01:09PM +0800, Yanteng Si wrote:
> The Loongson GMAC driver currently supports the network controllers
> installed on the LS2K1000 SoC and LS7A1000 chipset, for which the GMAC
> devices are required to be defined in the platform device tree source.
> But Loongson machines may have UEFI (implies ACPI) or PMON/UBOOT
> (implies FDT) as the system bootloaders. In order to have both system
> configurations support let's extend the driver functionality with the
> case of having the Loongson GMAC probed on the PCI bus with no device
> tree node defined for it. That requires to make the device DT-node
> optional, to rely on the IRQ line detected by the PCI core and to
> have the MDIO bus ID calculated using the PCIe Domain+BDF numbers.
> 
> In order to have the device probe() and remove() methods less
> complicated let's move the DT- and ACPI-specific code to the
> respective sub-functions.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 160 +++++++++++-------
>  1 file changed, 101 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c

...

> @@ -90,25 +158,20 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	if (!plat->mdio_bus_data)
>  		return -ENOMEM;
>  
> -	plat->mdio_node = of_get_child_by_name(np, "mdio");
> -	if (plat->mdio_node) {
> -		dev_info(&pdev->dev, "Found MDIO subnode\n");
> -		plat->mdio_bus_data->needs_reset = true;
> -	}
> -
>  	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
> -	if (!plat->dma_cfg) {
> -		ret = -ENOMEM;
> -		goto err_put_node;
> -	}
> +	if (!plat->dma_cfg)
> +		return -ENOMEM;
>  
>  	/* Enable pci device */
>  	ret = pci_enable_device(pdev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "%s: ERROR: failed to enable device\n", __func__);
>  		goto err_put_node;
> +		return ret;

This seems incorrect: this line will never be executed.

Flagged by Smatch.

>  	}
>  
> +	pci_set_master(pdev);
> +
>  	/* Get the base address of device */
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		if (pci_resource_len(pdev, i) == 0)

...

