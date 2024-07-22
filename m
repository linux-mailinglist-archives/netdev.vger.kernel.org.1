Return-Path: <netdev+bounces-112448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA749391D4
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 17:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C9A1C20833
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 15:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA682208E;
	Mon, 22 Jul 2024 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkWQLooI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF9C2FD
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662255; cv=none; b=OomjNgMHr5J6siKY0TzOx29NHbKWdvYN1X5RhgS6JXXjqrRGybzMkEKanvuetxaWYcvcT55iIGRJRKaQ1gwjU15zRXVAnQJtRW5G++SgPeIyBS8N0U7txBIpLxQTlJ3CfiXCARb4AbpNuXAWbqYTWYcKMIa3XI1gL3QZPaKkllE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662255; c=relaxed/simple;
	bh=3ZuYvxpGZRq8ltKLeh3deg8veDCO4XoOOF+PLJM4Jds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHQqC0M8BwadkVepIgMlqhh7UzTnrstX8zMp+/IVudb3/N2OHoQnSMwLW3sMOpOOqXYGNRdHzHjD94YnHaaQW5aLElhVTHswH1u4e49w7vUriK8bJFp1iUvmRC51+vCeZUDb6ujw73/AixcHa09u4DFdN96SdD0hrHH6LUgdduQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkWQLooI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B168C116B1;
	Mon, 22 Jul 2024 15:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721662254;
	bh=3ZuYvxpGZRq8ltKLeh3deg8veDCO4XoOOF+PLJM4Jds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XkWQLooI+fUGTqhBrWAvS8exSuf5b9JL7niNi1HpbnV4KKxOR4NEWY9UgzHCHMaVb
	 Cmknluwvp/kc2r2+A7HYVxS/gP7AfO4yGXHYY0w31cQdXJ/Z27cKSwr/bnxohv93V1
	 xNJC+ilpeJBhGu6XpsMoUuAgTKW70GZiVIThheWWGk1UPVwFBrY+2lu5DYT6w/F5gy
	 9RIF35lPQDqHral/5t+DW6F6Y708iJklBainc/B8xh+iCmB3IS5sq/42Hbl+aqroMD
	 l0qcQU8st+3qa8qxO3xvJFVHPE67ITodrQKqg/6RNOtKhIt5cX9KttjtOhG/g384AR
	 /ujk1TCw7cM6A==
Date: Mon, 22 Jul 2024 16:30:49 +0100
From: Simon Horman <horms@kernel.org>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, diasyzhang@tencent.com,
	Jose.Abreu@synopsys.com, chenhuacai@kernel.org,
	linux@armlinux.org.uk, guyinggang@loongson.cn,
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
	si.yanteng@linux.dev, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH net-next RFC v15 12/14] net: stmmac: dwmac-loongson: Add
 Loongson Multi-channels GMAC support
Message-ID: <20240722153049.GB15209@kernel.org>
References: <cover.1721645682.git.siyanteng@loongson.cn>
 <210517d4a8a2b63fd0aa9e57b1df91fcfe64fc2a.1721645682.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <210517d4a8a2b63fd0aa9e57b1df91fcfe64fc2a.1721645682.git.siyanteng@loongson.cn>

On Mon, Jul 22, 2024 at 07:01:10PM +0800, Yanteng Si wrote:
> The Loongson DWMAC driver currently supports the Loongson GMAC
> devices (based on the DW GMAC v3.50a/v3.73a IP-core) installed to the
> LS2K1000 SoC and LS7A1000 chipset. But recently a new generation
> LS2K2000 SoC was released with the new version of the Loongson GMAC
> synthesized in. The new controller is based on the DW GMAC v3.73a
> IP-core with the AV-feature enabled, which implies the multi
> DMA-channels support. The multi DMA-channels feature has the next
> vendor-specific peculiarities:
> 
> 1. Split up Tx and Rx DMA IRQ status/mask bits:
>        Name              Tx          Rx
>   DMA_INTR_ENA_NIE = 0x00040000 | 0x00020000;
>   DMA_INTR_ENA_AIE = 0x00010000 | 0x00008000;
>   DMA_STATUS_NIS   = 0x00040000 | 0x00020000;
>   DMA_STATUS_AIS   = 0x00010000 | 0x00008000;
>   DMA_STATUS_FBI   = 0x00002000 | 0x00001000;
> 2. Custom Synopsys ID hardwired into the GMAC_VERSION.SNPSVER register
> field. It's 0x10 while it should have been 0x37 in accordance with
> the actual DW GMAC IP-core version.
> 3. There are eight DMA-channels available meanwhile the Synopsys DW
> GMAC IP-core supports up to three DMA-channels.
> 4. It's possible to have each DMA-channel IRQ independently delivered.
> The MSI IRQs must be utilized for that.
> 
> Thus in order to have the multi-channels Loongson GMAC controllers
> supported let's modify the Loongson DWMAC driver in accordance with
> all the peculiarities described above:
> 
> 1. Create the multi-channels Loongson GMAC-specific
>    stmmac_dma_ops::dma_interrupt()
>    stmmac_dma_ops::init_chan()
>    callbacks due to the non-standard DMA IRQ CSR flags layout.
> 2. Create the Loongson DWMAC-specific platform setup() method
> which gets to initialize the DMA-ops with the dwmac1000_dma_ops
> instance and overrides the callbacks described in 1. The method also
> overrides the custom Synopsys ID with the real one in order to have
> the rest of the HW-specific callbacks correctly detected by the driver
> core.
> 3. Make sure the platform setup() method enables the flow control and
> duplex modes supported by the controller.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c

> +static struct mac_device_info *loongson_dwmac_setup(void *apriv)
> +{
> +	struct stmmac_priv *priv = apriv;
> +	struct mac_device_info *mac;
> +	struct stmmac_dma_ops *dma;
> +	struct loongson_data *ld;
> +	struct pci_dev *pdev;
> +
> +	ld = priv->plat->bsp_priv;
> +	pdev = to_pci_dev(priv->device);

nit: pdev is set but otherwise unused.

     Flagged by allmodconfig W=1 builds

> +
> +	mac = devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
> +	if (!mac)
> +		return NULL;
> +
> +	dma = devm_kzalloc(priv->device, sizeof(*dma), GFP_KERNEL);
> +	if (!dma)
> +		return NULL;
> +
> +	/* The Loongson GMAC devices are based on the DW GMAC
> +	 * v3.50a and v3.73a IP-cores. But the HW designers have changed the
> +	 * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the
> +	 * network controllers with the multi-channels feature
> +	 * available to emphasize the differences: multiple DMA-channels,
> +	 * AV feature and GMAC_INT_STATUS CSR flags layout. Get back the
> +	 * original value so the correct HW-interface would be selected.
> +	 */
> +	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN) {
> +		priv->synopsys_id = DWMAC_CORE_3_70;
> +		*dma = dwmac1000_dma_ops;
> +		dma->init_chan = loongson_dwmac_dma_init_channel;
> +		dma->dma_interrupt = loongson_dwmac_dma_interrupt;
> +		mac->dma = dma;
> +	}
> +
> +	priv->dev->priv_flags |= IFF_UNICAST_FLT;
> +
> +	/* Pre-initialize the respective "mac" fields as it's done in
> +	 * dwmac1000_setup()
> +	 */
> +	mac->pcsr = priv->ioaddr;
> +	mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
> +	mac->unicast_filter_entries = priv->plat->unicast_filter_entries;
> +	mac->mcast_bits_log2 = 0;
> +
> +	if (mac->multicast_filter_bins)
> +		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
> +
> +	/* Loongson GMAC doesn't support the flow control. */
> +	mac->link.caps = MAC_10 | MAC_100 | MAC_1000;
> +
> +	mac->link.duplex = GMAC_CONTROL_DM;
> +	mac->link.speed10 = GMAC_CONTROL_PS;
> +	mac->link.speed100 = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
> +	mac->link.speed1000 = 0;
> +	mac->link.speed_mask = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
> +	mac->mii.addr = GMAC_MII_ADDR;
> +	mac->mii.data = GMAC_MII_DATA;
> +	mac->mii.addr_shift = 11;
> +	mac->mii.addr_mask = 0x0000F800;
> +	mac->mii.reg_shift = 6;
> +	mac->mii.reg_mask = 0x000007C0;
> +	mac->mii.clk_csr_shift = 2;
> +	mac->mii.clk_csr_mask = GENMASK(5, 2);
> +
> +	return mac;
> +}

...

