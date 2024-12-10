Return-Path: <netdev+bounces-150846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3FC9EBBFA
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95055284716
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF2D23979F;
	Tue, 10 Dec 2024 21:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGUlodse"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F5237A57;
	Tue, 10 Dec 2024 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866923; cv=none; b=k5M8NpeTaBTCcqHXzGdfze4n3yxzICRl2OlB0ygCcD7EE71kZCn0CnF+xm+SWqsLXaVxbM8PyPJ1G2GhfH6RxhnHl8L0SIHzUFiaW91CqwB0VUE8SZxLg+YBuhLw3nkqv5cU4hXTK9Ek/ZkX/Cwj/SEyH920HVmFqWbQ+D3tXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866923; c=relaxed/simple;
	bh=eMB4BERgg0UcMa0SMSP2cNR/GwixDiZtVw4VPXs5cTE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=OH8l0t0ryxpinTh+cAoVaFoTzzmbZIeGE6nj1y9XPMd7oCkH+lQjB6SVtg2JCiVEgceuEoL8H446mK8JO4OgvidI24egHDUn6Svv6EOBYLwpTAkDW8UsWfmwt/pI+ABYi5HDPuo78rCmSHx/jKGUvClGwRoD7geB6b+Ok8EZ+CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGUlodse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C22C4CED6;
	Tue, 10 Dec 2024 21:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733866922;
	bh=eMB4BERgg0UcMa0SMSP2cNR/GwixDiZtVw4VPXs5cTE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=CGUlodseObfVPj3hiYJxhiXbZsEPZpsH23S+zoCmMvLMQnnbIU0JLOP9hWJzmuRDx
	 RtC8q/UxA4NHet4EyYjfivZBBJB99SuL6jPhTnXBe7jy0S+5xx82g/g0IaHcKeQqG9
	 aUc6/dnLbUJxN8ek959LpitRRFEIWtwZ5RrZU37JPTxei3C6AZchUr0OoudUu11py9
	 ygJzjUdIhPClcWfe5OjpuItqxWMmLEdR/mfHFnPWsJBTBJsb6RAxqDePbe9Bk80MBR
	 GglhVj4D71ZQpTgCUAGsrEPAxLn5Z5bpu8irWqswMkC+z5arwkewHO9fIqL8vI5i2N
	 Yo4OuTxOOuOYg==
Date: Tue, 10 Dec 2024 15:42:00 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
 Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Woojung Huh <woojung.huh@microchip.com>, Conor Dooley <conor+dt@kernel.org>, 
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Eric Dumazet <edumazet@google.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
In-Reply-To: <20241209103434.359522-1-o.rempel@pengutronix.de>
References: <20241209103434.359522-1-o.rempel@pengutronix.de>
Message-Id: <173386568446.497546.553726469163110460.robh@kernel.org>
Subject: Re: [PATCH v2 0/4] Add support for Priva E-Measuringbox board


On Mon, 09 Dec 2024 11:34:30 +0100, Oleksij Rempel wrote:
> This patch series introduces support for the Priva E-Measuringbox board
> based on the ST STM32MP133 SoC. The set includes all the necessary
> changes for device tree bindings, vendor prefixes, thermal support, and
> board-specific devicetree to pass devicetree validation and checkpatch
> tests.
> 
> changes v2:
> - drop: dt-bindings: net: Add TI DP83TD510 10BaseT1L PHY
> 
> Oleksij Rempel (2):
>   dt-bindings: vendor-prefixes: Add prefix for Priva
>   dt-bindings: arm: stm32: Add Priva E-Measuringbox board
> 
> Roan van Dijk (2):
>   arm: dts: stm32: Add thermal support for STM32MP131
>   arm: dts: stm32: Add Priva E-Measuringbox devicetree
> 
>  .../devicetree/bindings/arm/stm32/stm32.yaml  |   6 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm/boot/dts/st/Makefile                 |   1 +
>  arch/arm/boot/dts/st/stm32mp131.dtsi          |  35 ++
>  arch/arm/boot/dts/st/stm32mp133c-prihmb.dts   | 496 ++++++++++++++++++
>  5 files changed, 540 insertions(+)
>  create mode 100644 arch/arm/boot/dts/st/stm32mp133c-prihmb.dts
> 
> --
> 2.39.5
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


New warnings running 'make CHECK_DTBS=y st/stm32mp133c-prihmb.dtb' for 20241209103434.359522-1-o.rempel@pengutronix.de:

arch/arm/boot/dts/st/stm32mp133c-prihmb.dtb: adc@48004000: adc@0:interrupts: 0 was expected
	from schema $id: http://devicetree.org/schemas/iio/adc/st,stm32-adc.yaml#
arch/arm/boot/dts/st/stm32mp133c-prihmb.dtb: adc@48003000: adc@0:interrupts: 0 was expected
	from schema $id: http://devicetree.org/schemas/iio/adc/st,stm32-adc.yaml#






