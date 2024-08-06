Return-Path: <netdev+bounces-116108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 572E99491E1
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A271F21073
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F351D61B7;
	Tue,  6 Aug 2024 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uATHyePt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E891B1D61A1;
	Tue,  6 Aug 2024 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951825; cv=none; b=eGzp43hp0wUJ3CZAQzUjK0SrwFVhL8aXB90ELQhZdEGxlgtxgV3o7SqbNJEiRsqfWvhu7bKDH49sN/5f6mC9zm6RH0Q69/XW2cZZh3WFzef/L7WzeoaePgPOgbkUr/oeNkpapEsN7gX2vzwZ7/xqcWdgiPwr2yc/udFZ5OP0bps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951825; c=relaxed/simple;
	bh=jLZ8/crj4eIQwfYXP+sNMTE8scOkvbmNX5FsTSwedS8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=nQUxeRRe1XQ72xGiGlURmX0EP3k2I8G8oj8LP2IrYKuXEmExmxEOqeB0XXLtH94TI6RrK0/FT15Ud+JLkHkG5EMPAHks7AJAunMDYgm33IXcncL6QYg+mG0MMx/78gu72Qw7uzN9Zu5pZCcv44OEdiSnnWpLs4c+CrJlnswqKPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uATHyePt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6082DC32786;
	Tue,  6 Aug 2024 13:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722951824;
	bh=jLZ8/crj4eIQwfYXP+sNMTE8scOkvbmNX5FsTSwedS8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=uATHyePtxkmuWED1PZfsxldEPKpj9cUVGy85ZA63fEyikFo/BXh9daSthWYIMHeHp
	 FfUIkVuewHYAGJZKproVZ/LNoCQ3/tV5gRlnZ+8DxpPYWkpe9MG9Fr0dp39APZpbsk
	 PIxugFjWdwgQ7UxOnwuX9ekE14dmByUUYysy0Ds7exflE0bDk/dzFAmVfM65d+MztZ
	 dEK1h5uH43FZtQEc3L9Bqa1ISDc11y3uzV3KBhaG6nyFGsM7ptE7fxGYABZ8sRWgy9
	 HTH4KEE8ah8wZxe6ipsnqjvupeU+gSKPP1yWcuIK73kzQS1joom8mDcGJSuu1fkQWP
	 l1ICY8c9PR7rg==
Date: Tue, 06 Aug 2024 07:43:43 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: devicetree@vger.kernel.org, kernel@pengutronix.de, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org, 
 David Jander <david@protonic.nl>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240806120332.405064-1-o.rempel@pengutronix.de>
References: <20240806120332.405064-1-o.rempel@pengutronix.de>
Message-Id: <172295171745.1220395.8839837354648720418.robh@kernel.org>
Subject: Re: [PATCH v1] arm: dts: st: Add MECIO1 and MECT1S board variants


On Tue, 06 Aug 2024 14:03:32 +0200, Oleksij Rempel wrote:
> From: David Jander <david@protonic.nl>
> 
> Introduce device tree support for the MECIO1 and MECT1S board variants.
> MECIO1 is an I/O and motor control board used in blood sample analysis
> machines. MECT1S is a 1000Base-T1 switch for internal machine networks
> of blood sample analysis machines.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/arm/stm32/stm32.yaml  |   8 +
>  arch/arm/boot/dts/st/Makefile                 |   3 +
>  arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts |  48 ++
>  arch/arm/boot/dts/st/stm32mp151c-mect1s.dts   | 297 ++++++++++
>  arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts |  48 ++
>  .../arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi | 533 ++++++++++++++++++
>  6 files changed, 937 insertions(+)
>  create mode 100644 arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts
>  create mode 100644 arch/arm/boot/dts/st/stm32mp151c-mect1s.dts
>  create mode 100644 arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts
>  create mode 100644 arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
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


New warnings running 'make CHECK_DTBS=y st/stm32mp151c-mecio1r0.dtb st/stm32mp151c-mect1s.dtb st/stm32mp153c-mecio1r1.dtb' for 20240806120332.405064-1-o.rempel@pengutronix.de:

arch/arm/boot/dts/st/stm32mp151c-mect1s.dtb: switch@0: Unevaluated properties are not allowed ('reset-gpios' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/dsa/nxp,sja1105.yaml#






