Return-Path: <netdev+bounces-100642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 172D68FB747
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56AB286BF0
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436CB1494BF;
	Tue,  4 Jun 2024 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV1rv3A1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0DD1494BB;
	Tue,  4 Jun 2024 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514943; cv=none; b=ldOvyZWXw30G0fcmTrswgd7wcdp3f3R6G8ox3eHLJVuXNyd+jt1ivUMTaiX7uRRHRZFfEoH3Q1guAR2xKPb1hkkDAAwAjtS7bTvOWvivVSjZLcnHbvVM8fFkDtUEapVjzL9KmCGbYInt94e3N0FUpfCEec/tmbLctgw6MaHsceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514943; c=relaxed/simple;
	bh=mOFKrU1+xbr+7FRYDRPFe8CRuMGHStfbcrXzy2CW69g=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=TIta2D20GJ+X0nhhrKfhguWMYEku38s2mg1etEsGO2yuSlgYJw6nJAMZmqGE04DMvmHqJ2JV7Oca5lTejK3Goa81gTTIbQ5U3RBsimqBRBIEkqsVqloivCYjL6zNeTOif406YkUFSD3HkpZF8WpXNAVbqBh0K2zOsu9Fnf1zUM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV1rv3A1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE64C2BBFC;
	Tue,  4 Jun 2024 15:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717514942;
	bh=mOFKrU1+xbr+7FRYDRPFe8CRuMGHStfbcrXzy2CW69g=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BV1rv3A1+lQV2Ab/cP/MpyUxP6dTV1G+1bnBGzg/vOgsfLGBibmrZk1RkocktwkfT
	 f9ISfL49Bb1hy1Hu7webPq85z1U6ZPN83F0M5Hj5LFLRedBFYAsXXB7nnzLJx13cI7
	 uEhRzbj2drwz7IhWhs4abuP/n+NNS3y+9284sHuuMDvNz4U9pxVZWgIBhH6GB+p3lg
	 EyzbP3SQlM1exPk9/BAJFAKug5F52VXDxJv9+jFZ1MQYT0xwNvNykBxcIJIJ0wXBlN
	 rppDhKVis0U8tUn87VNopvcSh2LfMeMICfuctUDhBZIAXAxD1apspg5cSROzuwo0ed
	 VpsNJPaw7J9Jw==
Date: Tue, 04 Jun 2024 10:29:00 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: devicetree@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 Marek Vasut <marex@denx.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Mark Brown <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Jose Abreu <joabreu@synopsys.com>
In-Reply-To: <20240604143502.154463-1-christophe.roullier@foss.st.com>
References: <20240604143502.154463-1-christophe.roullier@foss.st.com>
Message-Id: <171751455073.786330.16354287861829975663.robh@kernel.org>
Subject: Re: [PATCH v4 00/11] Series to deliver Ethernet for STM32MP13


On Tue, 04 Jun 2024 16:34:51 +0200, Christophe Roullier wrote:
> STM32MP13 is STM32 SOC with 2 GMACs instances
>     GMAC IP version is SNPS 4.20.
>     GMAC IP configure with 1 RX and 1 TX queue.
>     DMA HW capability register supported
>     RX Checksum Offload Engine supported
>     TX Checksum insertion supported
>     Wake-Up On Lan supported
>     TSO supported
> Rework dwmac glue to simplify management for next stm32 (integrate RFC from Marek)
> 
> V2: - Remark from Rob Herring (add Krzysztof's ack in patch 02/11, update in yaml)
>       Remark from Serge Semin (upate commits msg)
> V3: - Remove PHY regulator patch and Ethernet2 DT because need to clarify how to
>       manage PHY regulator (in glue or PHY side)
>     - Integrate RFC from Marek
>     - Remark from Rob Herring in YAML documentation
> V4: - Remark from Marek (remove max-speed, extra space in DT, update commit msg)
>     - Remark from Rasmus (add sign-off, add base-commit)
>     - Remark from Sai Krishna Gajula
> 
> Christophe Roullier (6):
>   dt-bindings: net: add STM32MP13 compatible in documentation for stm32
>   net: ethernet: stmmac: add management of stm32mp13 for stm32
>   ARM: dts: stm32: add ethernet1 and ethernet2 support on stm32mp13
>   ARM: dts: stm32: add ethernet1/2 RMII pins for STM32MP13F-DK board
>   ARM: dts: stm32: add ethernet1 for STM32MP135F-DK board
>   ARM: multi_v7_defconfig: Add MCP23S08 pinctrl support
> 
> Marek Vasut (5):
>   net: stmmac: dwmac-stm32: Separate out external clock rate validation
>   net: stmmac: dwmac-stm32: Separate out external clock selector
>   net: stmmac: dwmac-stm32: Extract PMCR configuration
>   net: stmmac: dwmac-stm32: Clean up the debug prints
>   net: stmmac: dwmac-stm32: Fix Mhz to MHz
> 
>  .../devicetree/bindings/net/stm32-dwmac.yaml  |  41 ++++-
>  arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi   |  71 ++++++++
>  arch/arm/boot/dts/st/stm32mp131.dtsi          |  38 ++++
>  arch/arm/boot/dts/st/stm32mp133.dtsi          |  31 ++++
>  arch/arm/boot/dts/st/stm32mp135f-dk.dts       |  23 +++
>  arch/arm/configs/multi_v7_defconfig           |   1 +
>  .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 172 ++++++++++++++----
>  7 files changed, 330 insertions(+), 47 deletions(-)
> 
> 
> base-commit: cd0057ad75116bacf16fea82e48c1db642971136
> --
> 2.25.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y st/stm32mp135f-dk.dtb' for 20240604143502.154463-1-christophe.roullier@foss.st.com:

arch/arm/boot/dts/st/stm32mp135f-dk.dtb: adc@48003000: 'ethernet@5800e000' does not match any of the regexes: '^adc@[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/adc/st,stm32-adc.yaml#






