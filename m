Return-Path: <netdev+bounces-109465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28696928917
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BD2288A08
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA03714A62F;
	Fri,  5 Jul 2024 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NXUgf4BJ"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE6413C8F9;
	Fri,  5 Jul 2024 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184134; cv=none; b=KUmdS1EMjGFP4Ib7GW31lVR5ejF7a72Pz5aO1vxWQYGNzWkRoE0imLLqoF/YuV/lGgomtdpvutFUGDqGUhGkTtVNeOAkHIFd3vZ85r1228EjFEV+/XFkBy7CvIwANRq1Eg5N2euyopVeC7wIKwCRhbbDSXffeonZmC9jvTK2E3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184134; c=relaxed/simple;
	bh=Z5KVVpVzJXWZTDYsocGuEMhDUmkZAVHCjL4h2Uv1m1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C+nl1gCWpGTt1IvM05l0SbJLXzDf5mmqZhFmFNwA8U2cwQxEyVj9jRhya9Fo7g3TXwIDsPUCRvt1m3tdX9KgaYL9njhkttnG+MxO3QImcoPZSUi6I1sIm33bRNT678Q1FSaHw7fgiV3PhDQOm+GCYY2VGdCOS1l3ClSBv7wCtiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NXUgf4BJ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A52D1BF203;
	Fri,  5 Jul 2024 12:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720184130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lkgdhWZpV73wja8j2NNVmvhUuPQEYOksDpCMcDjmmaU=;
	b=NXUgf4BJj0wmKWhJnyfVixE2x94XeGk/xAfGBuP1f7ziJ7A4z5MFm+lXPEYxXp28SieMER
	HYti3Q4/Zyd/kHK23zeKlKLfi8Of58Ss3MQiGCUvmRW765bv2URtYnMQQ+N4SYJRTP3YVI
	GDRxQ+74Ngx0kynw+unwWLpcAQWEGVHupZe856UUX3WC0QfM8HAU+YU+jsdE5af75LTqvA
	2DpNBtJyN182bwC5qf9rNjyS4RMX2EZMOD1gHlGkyE0E+TvtgoHz06DD+GMJlnmYJzx0KW
	XviMTHzayaCTBdlSNcUNR3P5MdaXtTm8q4YbBrMl5MGhWSF9mF1ZGzuGumAPWg==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Richard Cochran <richardcochran@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Josua Mayer
 <josua@solid-run.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 0/5] arm64: dts: add description for solidrun cn9130
 som and clearfog boards
In-Reply-To: <20240704-cn9130-som-v7-0-eea606ba5faa@solid-run.com>
References: <20240704-cn9130-som-v7-0-eea606ba5faa@solid-run.com>
Date: Fri, 05 Jul 2024 14:55:29 +0200
Message-ID: <8734ooj8vy.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Josua Mayer <josua@solid-run.com> writes:

> SolidRun CN9130 SoM is a mostly pin-comptible replacement for Armada 388
> SoM used in Clearfog and Clearfog Pro boards.
>
> 1. Add new binding for compatible strings closely matching the original.
>
> 2. Add device-tree includes for SoM and carrier shared design.
>
> 3. Add device-tree for both Clearfog Base and Pro.
>
> While dtbs_check is happy with LED descriptions behind dsa switch,
> functionally they require supporting code by Andrew Lunn:
> https://lore.kernel.org/r/20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch
>
> NOTICE IN CASE ANYBODY WANTS TO SELF-UPGRADE:
> CN9130 SoM has a different footprint from Armada 388 SoM.
> Components on the carrier board below the SoM may collide causing
> damage, such as on Clearfog Base.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Seriues applied on mvebu/dt64

Thanks,

Gregory
> ---
> Changes in v7:
> - dropped dt-bindings for usb phy and adc which were picked into their
>   respective trees
> - Link to v6: https://lore.kernel.org/r/20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com
>
> Changes in v6:
> - add device-tree for cn9132 clearfog and CEX-7 module
> - add dt compatible for tla2021 adc
>   --> I don't plan to submit a driver patch because I can't test it
>   --> might share untested patch
> - add dt property for swapping d+-/d- on cp110 utmi phy
>   --> I plan to submit a driver patch, already prototyped
> - removed duplicate node reference / status=okay for cp0_utmi from
>   cn9131-cf-solidwan.dts
> - rebased on 6.10-rc1
> - Link to v5: https://lore.kernel.org/r/20240509-cn9130-som-v5-0-95493eb5c79d@solid-run.com
>
> Changes in v5:
> - replaced *-gpio properties with preferred *-gpios
>   (Reported-by: robh@kernel.org)
> - removed fixed-regulator regulator-oc-protection-microamp properties
>   This property is intended to set a configurable over-current limit to
>   a particular value. The physical component however is not
>   configurable, remove the property.
> - kept all review tags since the changes were minor, hope that is okay
>   with everybody.
> - Link to v4: https://lore.kernel.org/r/20240502-cn9130-som-v4-0-0a2e2f1c70d8@solid-run.com
>
> Changes in v4:
> - Picked up reviewed-by tags by Andrew Lunn.
> - fixed a typo and changed 3-line comment into single-line comment
>   for clearfog-base/-pro dts, but kept review tags since change was
>   minor.
> - Updated SFP led labels to use "sfp?:colour" without "color" property,
>   to avoid duplicate labels while reflecting they are each dual-colour.
> - Link to v3: https://lore.kernel.org/r/20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com
>
> Changes in v3:
> - picked up acked-by for dt-bindings
> - skipped acked-by for dts because additional changes were made:
>   - moved legacy netdev aliases to carrier dts
>   - fix status property style errors
>   - add pinctrl for secondary spi chip-select on mikrobus header (& som)
>   - specify spi bus frequency limits for som
> - Added CN9131 SolidWAN board
> - Link to v2: https://lore.kernel.org/r/20240404-cn9130-som-v2-0-3af2229c7d2d@solid-run.com
>
> Changes in v2:
> - rewrote dt bindings dropping unnecessary compatibles
>   (Reported-By: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>)
> - added bindings for two additional boards (cn9131/9132)
>   support planned for the coming weeks, mostly serves
>   illustrational purposes, to understand cn913x variants
> - cf-pro: add description for LEDs behind DSA switch
> - cf-base: add description for LEDs behind PHYs
>   (Reported-By: Andrew Lunn <andrew@lunn.ch>)
> - Link to v1: https://lore.kernel.org/r/20240321-cn9130-som-v1-0-711127a409ae@solid-run.com
>
> ---
> Josua Mayer (5):
>       dt-bindings: arm64: marvell: add solidrun cn9130 som based boards
>       dt-bindings: arm64: marvell: add solidrun cn9132 CEX-7 evaluation board
>       arm64: dts: add description for solidrun cn9130 som and clearfog boards
>       arm64: dts: add description for solidrun cn9131 solidwan board
>       arm64: dts: add description for solidrun cn9132 cex7 module and clearfog board
>
>  .../bindings/arm/marvell/armada-7k-8k.yaml         |  18 +
>  arch/arm64/boot/dts/marvell/Makefile               |   4 +
>  arch/arm64/boot/dts/marvell/cn9130-cf-base.dts     | 178 ++++++
>  arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts      | 375 +++++++++++
>  arch/arm64/boot/dts/marvell/cn9130-cf.dtsi         | 197 ++++++
>  arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi     | 160 +++++
>  arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 637 ++++++++++++++++++
>  arch/arm64/boot/dts/marvell/cn9132-clearfog.dts    | 673 +++++++++++++++++++
>  arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi    | 712 +++++++++++++++++++++
>  9 files changed, 2954 insertions(+)
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240318-cn9130-som-848e86acb0ac
>
> Sincerely,
> -- 
> Josua Mayer <josua@solid-run.com>

