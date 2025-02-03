Return-Path: <netdev+bounces-162171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EACA25EEC
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35D63A41AA
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99050209F51;
	Mon,  3 Feb 2025 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENwwrB+P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0A6209F35;
	Mon,  3 Feb 2025 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738597028; cv=none; b=edKSKfdiewCFHRBfM2DDz+vS1ycXhARFLgDIiDv2NaoVxDwo3+gzBBg6ZnrMcZsH7li+tLzwTcA7M+oVPtKxBZ+HmMsjnF6x4HXrOIzTpoQGkJs2wnjkAobYJpUqDfiT1ACcSfLon6dGQ5OJ3qRprFo4MIdFxaB14jDgQzqb5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738597028; c=relaxed/simple;
	bh=PzVDimxpMVmqHkj6Wi8NHyIcxugKilb5dXJ7vtyncGw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=W9vtVVaSA2zY4GdubDvbRH/rkbuUoqbSFdK6BHkZeV3BSRMlG/185jNkeDxwL42KlfrJLGXHOPpOwFwVa3d4Sw6RVsy0kMc+R7KINsyuMByah6SPU3gJ7K+beNi90/V8Nf1+i5stSjxPA+6OgX9ASTdq6KL6ikLnduFb66t9W90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENwwrB+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9637AC4CED2;
	Mon,  3 Feb 2025 15:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738597027;
	bh=PzVDimxpMVmqHkj6Wi8NHyIcxugKilb5dXJ7vtyncGw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ENwwrB+P1O9DXWFXtTId6TOjG5TTATnupf0gmJ2sTRcTu4lyUdFovAU/eUzQ33KvV
	 gRd01o1WzL2QjEYeKoUUeLTzTOiUHINKsc0bmUDKRASlB5KS8X52jggQMAtAKQPjHK
	 OGkJD0YddrfzUFnV9miCIWB2uDXB0eBeVREQGZZGL9xmmUewJBxnX85+kZc6fysa19
	 VsXdYm6D/BHqd5K/d8g0dX5zwIKdNpyq0F+JMOOE1vwva9qDOgsjceU4u+OihF+4HK
	 sNtXJSfA5S7pFdTaxzEEDBEvK7x+tFkN4LuxRIG5LjAI/5EzMiy0QRweHAh51v2Npj
	 nJxB4nWaXaz6w==
Date: Mon, 03 Feb 2025 09:37:06 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Woojung Huh <woojung.huh@microchip.com>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, devicetree@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 netdev@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 kernel@pengutronix.de
To: Oleksij Rempel <o.rempel@pengutronix.de>
In-Reply-To: <20250203085820.609176-1-o.rempel@pengutronix.de>
References: <20250203085820.609176-1-o.rempel@pengutronix.de>
Message-Id: <173859694746.2601652.11244969424431209545.robh@kernel.org>
Subject: Re: [PATCH v3 0/4] Add support for Priva E-Measuringbox board


On Mon, 03 Feb 2025 09:58:16 +0100, Oleksij Rempel wrote:
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


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/st/' for 20250203085820.609176-1-o.rempel@pengutronix.de:

arch/arm/boot/dts/st/stm32mp133c-prihmb.dtb: adc@48004000: adc@0:interrupts: 0 was expected
	from schema $id: http://devicetree.org/schemas/iio/adc/st,stm32-adc.yaml#
arch/arm/boot/dts/st/stm32mp133c-prihmb.dtb: adc@48003000: adc@0:interrupts: 0 was expected
	from schema $id: http://devicetree.org/schemas/iio/adc/st,stm32-adc.yaml#






