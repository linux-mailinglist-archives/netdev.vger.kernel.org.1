Return-Path: <netdev+bounces-78827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7198C876B34
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 20:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22829282F6D
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 19:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9885A7A1;
	Fri,  8 Mar 2024 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDZmyNGM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422E3C32;
	Fri,  8 Mar 2024 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709926150; cv=none; b=n/mtu+uyQ7AzdXyGpl91bNNArVPQ7Y2AE+kIPgrRbnR/Dq+PVZqDIUsitpW4x1bDdPMI2CRwWeyedf6K2Lcg2K2yYaLlySELZGS3P9tcxbk/4VAH/yfCRL8B0vGlthpCf4duPnnpA8Oc4ORSOTzYJoKs+uAtIgVd76JfE8qTfBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709926150; c=relaxed/simple;
	bh=p2iVL3biQctSMB74BPfBVX2/QGAS8WA7RABXtsuQ3dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ua1/1QcoxtGBcfre3yoMG3mcCeQXy6QOEoftxa4HU7tNF2MJOjfl6SxVI7tETN1rsRYh9A+zdyGBf3Pal6TjsLLNFI1Ahfd8pWp8PhZjT5Kxzjz3msBYyeoR8N5Iz+x0byvrAmey3ldt4cEEgxBvQoSI+yBxVRE00k7TL8nK2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDZmyNGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C17C433C7;
	Fri,  8 Mar 2024 19:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709926149;
	bh=p2iVL3biQctSMB74BPfBVX2/QGAS8WA7RABXtsuQ3dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uDZmyNGM/xOGJTSghm8EmhT1uD/wobdPBa5W4R4BEPD2g/xtzmhwq8EqeSzHRIoxM
	 1VVdK/YHWH8SigDDLcZHBp9yt3qYWI/ZKblie/CHCA6qpDE9kV3MVlgj22mN1Pwm2q
	 yva5I7JvtTWupL2nO3z7FlJ/moMNFYeUBK2ffavrTYstmR7H/gKh6jIm6zL1hra2p1
	 4Zg2sLyXTd1ktKgQtfzu32f5X//GX6GBHIEAJJ52tl46+8+JRShWPQIgwUI0tLaFXe
	 u02T9+IJ/VP6zfQk64Cw06k62gpEvnrhQcCIVan45VborzoXsf9ZIc0H3s3YqdX+aq
	 BZFjpHEQNxf/w==
Date: Fri, 8 Mar 2024 19:27:35 +0000
From: Simon Horman <horms@kernel.org>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com,
	linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net] net: lan743x: Add set RFE read fifo threshold for
 PCI1x1x chips
Message-ID: <20240308192735.GA603911@kernel.org>
References: <20240307085823.403831-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307085823.403831-1-Raju.Lakkaraju@microchip.com>

On Thu, Mar 07, 2024 at 02:28:23PM +0530, Raju Lakkaraju wrote:
> The RFE (Receive Filtering Engine) read fifo threshold hardware default should
> be overwritten to 3 for PCI1x1x Rev B0 devices to prevent lockup during some
> stress tests using frames that include VLAN tags.
> Rev C0 and later hardware already defaults to 3.
> 
> Fixes: bb4f6bffe33c ("net: lan743x: Add PCI11010 / PCI11414 device IDs")
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 17 +++++++++++++++++
>  drivers/net/ethernet/microchip/lan743x_main.h |  5 +++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 45e209a7d083..aec2d100ab87 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -3272,6 +3272,22 @@ static void lan743x_full_cleanup(struct lan743x_adapter *adapter)
>  	lan743x_pci_cleanup(adapter);
>  }
>  
> +static int pci11x1x_set_rfe_rd_fifo_threshold(struct lan743x_adapter *adapter)
> +{
> +	u16 rev = adapter->csr.id_rev & ID_REV_CHIP_REV_MASK_;
> +
> +	if (rev == ID_REV_CHIP_REV_PCI11X1X_B0_) {
> +		int misc_ctl;
> +
> +		misc_ctl = lan743x_csr_read(adapter, MISC_CTL_0);
> +		misc_ctl &= ~MISC_CTL_0_RFE_READ_FIFO_MASK_;
> +		misc_ctl |= (0x3 << MISC_CTL_0_RFE_READ_FIFO_SHIFT_);
> +		lan743x_csr_write(adapter, MISC_CTL_0, misc_ctl);

Hi Raju,

Some minor nits from my side:

- misc_ctl could be an unsigned integer
- The above could probably use FIELD_PREP, which in turn
  probably means that MISC_CTL_0_RFE_READ_FIFO_SHIFT_ isn't needed
- 0x3 could be a #define - what does it mean?

> +	}
> +
> +	return 0;
> +}
> +
>  static int lan743x_hardware_init(struct lan743x_adapter *adapter,
>  				 struct pci_dev *pdev)
>  {

...

