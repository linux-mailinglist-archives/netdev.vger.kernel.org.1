Return-Path: <netdev+bounces-232517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A58D6C06279
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D911C007A1
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D381313523;
	Fri, 24 Oct 2025 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtzvBRZ2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0C825228D;
	Fri, 24 Oct 2025 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761307524; cv=none; b=mzYT8h7+ZE+PKOY8cqRbFmFyNydw20ZHhbGl9UZkRGS3j5nPmKy82nO+Osge2vYU1JSzmVrhJa6RrT3BjjwQ67bC9cWvgZcTgmPXoym2KW6vKNqhuiBdvKCAdQr8GTXCoR4WAvNM4AxjDcHrFjWVWCo3J4Nwf0/YXwxcWeDNfe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761307524; c=relaxed/simple;
	bh=SoTqsQyeJsNHR+NjV5RVJfzLtjEZs9jDVX9K8tQd7VQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCojMBNrbCru26o6i/DmAituFOlhkfDZkra/PYLCy7InA1ZdykL0/idyi9vCYEYkGwmKbleIq/81mQ5eJ+HKT1TJoqG4p1OEgmJOdcB5q89rdbP8OWFdElYNqM7neMdilFCWpbXWUxYC2+QyCCUaj0GhE1DO+K8QAXFSfO3WgG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtzvBRZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC34C4CEF1;
	Fri, 24 Oct 2025 12:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761307523;
	bh=SoTqsQyeJsNHR+NjV5RVJfzLtjEZs9jDVX9K8tQd7VQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MtzvBRZ2QznIMWkDD8LXC05vVfSz54eV+CSiyFUDrQpPPDKOy274P9UHODkl8bzRw
	 XLpz4bQi/UlOmqd1+PiFh1mv48mQtysnDrKWluwlZ1RwZvHu5tmO6VDIfva8YhUh0M
	 Pgg9cgsSdMPsNNOmvSK1IdrStowqm3dxiixgC7o/36+MB8+CiYC5RA/vAEjtbLc148
	 l6XtgEQFMhcCaSVpio+X4tstvezR/mDrzl8ROAbZpKfRCaMqnenvdZW9b1YVSkS62z
	 Gj8MZQwyfEQexesICFIKXxvRN6ihqs1yDG7/eY5QB7xxEhRZvqADN1TeoW4LqNDoUF
	 pw8BRS6IB2XYA==
Message-ID: <9559cde8-8dc4-4f4b-8e9f-973656bb575c@kernel.org>
Date: Fri, 24 Oct 2025 07:05:21 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] arm64: dts: socfpga: agilex5: smmu enablement
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Matthew Gerlach <matthew.gerlach@altera.com>
Cc: kernel@pengutronix.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Austin Zhang <austin.zhang@intel.com>,
 Adrian Ng Ho Yin <adrian.ho.yin.ng@intel.com>
References: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
 <20251024-v6-12-topic-socfpga-agilex5-v5-4-4c4a51159eeb@pengutronix.de>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20251024-v6-12-topic-socfpga-agilex5-v5-4-4c4a51159eeb@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/24/25 06:49, Steffen Trumtrar wrote:
> From: Austin Zhang <austin.zhang@intel.com>
> 
> Add iommu property for peripherals connected to TBU.
> 
> Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@intel.com>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>   arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> index 4f7ed20749927..4ccfebfd9d322 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> @@ -303,6 +303,7 @@ nand: nand-controller@10b80000 {
>   			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&clkmgr AGILEX5_NAND_NF_CLK>;
>   			cdns,board-delay-ps = <4830>;
> +			iommus = <&smmu 4>;
>   			status = "disabled";
>   		};
>   
> @@ -329,6 +330,7 @@ dmac0: dma-controller@10db0000 {
>   			snps,block-size = <32767 32767 32767 32767>;
>   			snps,priority = <0 1 2 3>;
>   			snps,axi-max-burst-len = <8>;
> +			iommus = <&smmu 8>;
>   		};
>   
>   		dmac1: dma-controller@10dc0000 {
> @@ -346,6 +348,7 @@ dmac1: dma-controller@10dc0000 {
>   			snps,block-size = <32767 32767 32767 32767>;
>   			snps,priority = <0 1 2 3>;
>   			snps,axi-max-burst-len = <8>;
> +			iommus = <&smmu 9>;
>   		};
>   
>   		rst: rstmgr@10d11000 {
> @@ -468,6 +471,7 @@ usb0: usb@10b00000 {
>   			reset-names = "dwc2", "dwc2-ecc";
>   			clocks = <&clkmgr AGILEX5_USB2OTG_HCLK>;
>   			clock-names = "otg";
> +			iommus = <&smmu 6>;
>   			status = "disabled";
>   		};
>   
> @@ -553,6 +557,7 @@ gmac0: ethernet@10810000 {
>   			snps,tso;
>   			altr,sysmgr-syscon = <&sysmgr 0x44 0>;
>   			snps,clk-csr = <0>;
> +			iommus = <&smmu 1>;
>   			status = "disabled";
>   
>   			stmmac_axi_emac0_setup: stmmac-axi-config {
> @@ -665,6 +670,7 @@ gmac1: ethernet@10820000 {
>   			snps,tso;
>   			altr,sysmgr-syscon = <&sysmgr 0x48 0>;
>   			snps,clk-csr = <0>;
> +			iommus = <&smmu 2>;
>   			status = "disabled";
>   
>   			stmmac_axi_emac1_setup: stmmac-axi-config {
> @@ -777,6 +783,7 @@ gmac2: ethernet@10830000 {
>   			snps,tso;
>   			altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
>   			snps,clk-csr = <0>;
> +			iommus = <&smmu 3>;
>   			status = "disabled";
>   
>   			stmmac_axi_emac2_setup: stmmac-axi-config {
> 


I have a similar patches for this and 3/10 queued up for v6.19.

The DTS patches are staged in my repo under the branch 
socfpga_updates_for_v6.19

Dinh

