Return-Path: <netdev+bounces-100641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D770E8FB72E
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CE01C20A6C
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55236148307;
	Tue,  4 Jun 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPBsyvsi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292B41482FD;
	Tue,  4 Jun 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514933; cv=none; b=PL61RrDNqSgLtSbhGTfGTEV7mgjhNyiy7feV0Oi+KabftncATiyswPBYzBk1jzQoj93eOGMJS9eLvE/bGqdnsqsX5rDcyMzbGpcEBwAHy/KKreyEwxYg211O9KjYilRqM4XTQHuLvcdxHi59xJUFzgFvuV18W8yWDJYVx+ZD7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514933; c=relaxed/simple;
	bh=x/4us6GB27e8U5onR/kVn8KG91qTiGMupA4imljcjo0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=BTqpJ91kKh4s/QfUvxtO+Nxvm1jwqnIlOjLpRbWocKUqF4Zp0Lq6IQ9bOT3oUNHA5JAEOgK0lVneGcJO4bWhzIWoz6SOSg/QIzyE/9X+Ng+g+pLhFasL4phLcrXkpiIJ8nVt92wtQSJWWWnnSf92Q+rDqX0YDs+wW/xPWVyzUNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPBsyvsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC733C4AF07;
	Tue,  4 Jun 2024 15:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717514933;
	bh=x/4us6GB27e8U5onR/kVn8KG91qTiGMupA4imljcjo0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=YPBsyvsiAfAIWhD1hc0mcMqzQulHZF5EuqgnkBlF1c3YREo1nr0hU7Z9wZGAXGE9E
	 iOE8VyzF2NZLvKWXD2mKS8ZKZrmKzBCS7jyIQkAINe4FMx3gfmEyVbTW7jiOHrwsnR
	 yImw397ONLjUU0conlhC8sygyVPq9ZUGNnhBSiahO03yjPdmKXMWRuX9i2nALIodAr
	 8iteTWcYiF8YsNnNXd5xPHiskSoTmvelYkNgJpqIb6+nD0M/XOD6tX1qCe/kyulkhO
	 Rjj7sTArrnN63JO4WTzNpjIFXfkY1u2D2j9kWD2gver+G+7CePcEWxR0ID/gJrLVjl
	 zAEIkTvfaeaLA==
Date: Tue, 04 Jun 2024 10:28:51 -0500
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
Cc: Conor Dooley <conor+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 devicetree@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
 Marek Vasut <marex@denx.de>, Jose Abreu <joabreu@synopsys.com>, 
 netdev@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240603092757.71902-1-christophe.roullier@foss.st.com>
References: <20240603092757.71902-1-christophe.roullier@foss.st.com>
Message-Id: <171751454842.785918.9185314917748906790.robh@kernel.org>
Subject: Re: [PATCH v3 00/11] Series to deliver Ethernet for STM32MP13


On Mon, 03 Jun 2024 11:27:46 +0200, Christophe Roullier wrote:
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
>  .../devicetree/bindings/net/stm32-dwmac.yaml  |  41 +++-
>  arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi   |  71 +++++++
>  arch/arm/boot/dts/st/stm32mp131.dtsi          |  31 +++
>  arch/arm/boot/dts/st/stm32mp133.dtsi          |  30 +++
>  arch/arm/boot/dts/st/stm32mp135f-dk.dts       |  24 +++
>  arch/arm/configs/multi_v7_defconfig           |   1 +
>  .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 176 ++++++++++++++----
>  7 files changed, 327 insertions(+), 47 deletions(-)
> 
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


New warnings running 'make CHECK_DTBS=y st/stm32mp135f-dk.dtb' for 20240603092757.71902-1-christophe.roullier@foss.st.com:

arch/arm/boot/dts/st/stm32mp135f-dk.dtb: adc@48003000: 'ethernet@5800e000' does not match any of the regexes: '^adc@[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/adc/st,stm32-adc.yaml#






