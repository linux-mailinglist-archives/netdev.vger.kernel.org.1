Return-Path: <netdev+bounces-118128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A225950A1F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 18:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3F31C21909
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9575F1A0B15;
	Tue, 13 Aug 2024 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fonaooj1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0B81A0B07;
	Tue, 13 Aug 2024 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566502; cv=none; b=KRKDtOM6/ZR0lanxBmMyFjaHBnTIMtrs/4g/8Ml1a86awA/Zdnp8Vk0j91VUItMqisPWuv1Qb5SreVrj6sRQ5guoXW9Vr4lxRsHaLXHRtZAsyr6ka9voqmY3EkX0Bp0KRwo+8H0HhOfef9Kl5LE/IYH/oVBKEMRMiecH3vG29Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566502; c=relaxed/simple;
	bh=dsZqYp25UA9vdx3g0iSwFq3PYSCy3RaVoy34nDKDsnM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=gc1gHrxodaoAxTgjBEorVjT+ggVyIpOxADj2TVvG37OqtgpCEsDUK8I+BH4C9UH46MXEwJGjAL6MrcJyULpR4GMU61T6utJdbHrt1vXJRG+DN26YJOTS8cMezMYpORZ38HusXWSzQrJLS4dK/kVOk78qzTnjHX6l7D9QxWh0mr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fonaooj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72615C4AF0B;
	Tue, 13 Aug 2024 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723566501;
	bh=dsZqYp25UA9vdx3g0iSwFq3PYSCy3RaVoy34nDKDsnM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Fonaooj1CKlwHGumBnLj6ZGxz39IxQJ3RRuoWZR5a3p0VHFaapaKuYyk7p6oa78P8
	 ZXsPSFLWf+zErEKYlovcluAe/Er6Y2fHnC0E0gX4xQEzTubvyN+GCGR9SpvRKX5fZK
	 LySxGt5O6mdmSDezefnHkEw4wDc9CGnG1aqQJuqW6HdS+IlhwrwvXzRJUdx9ZW9UeL
	 cO6RYvG7COMXDJwPWYTn68sx8a9uS1cWdWhObrj/9d5pW6ptpfvKm2tSNyRlL9/2N7
	 hUaHgUcWQXt+cB4oqQDiFkt4YnSG7yd0hG4RLDcutDheBcyaZY3xzcmhcBBux116bv
	 Q2GX4/vQGYHiQ==
Date: Tue, 13 Aug 2024 10:28:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
 devicetree@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, imx@lists.linux.dev, 
 netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Russell King <linux@armlinux.org.uk>
In-Reply-To: <20240813150615.3866759-1-Frank.Li@nxp.com>
References: <20240813150615.3866759-1-Frank.Li@nxp.com>
Message-Id: <172356649976.1163565.8068313360737284707.robh@kernel.org>
Subject: Re: [PATCH v2 1/1] dt-bindings: net: mdio: change nodename match
 pattern


On Tue, 13 Aug 2024 11:06:14 -0400, Frank Li wrote:
> Change mdio.yaml nodename match pattern to
> 	'^mdio(-(bus|external))?(@.+|-([0-9]+))$'
> 
> Fix mdio.yaml wrong parser mdio controller's address instead phy's address
> when mdio-mux exist.
> 
> For example:
> mdio-mux-emi1@54 {
> 	compatible = "mdio-mux-mmioreg", "mdio-mux";
> 
>         mdio@20 {
> 		reg = <0x20>;
> 		       ^^^ This is mdio controller register
> 
> 		ethernet-phy@2 {
> 			reg = <0x2>;
>                               ^^^ This phy's address
> 		};
> 	};
> };
> 
> Only phy's address is limited to 31 because MDIO bus definition.
> 
> But CHECK_DTBS report below warning:
> 
> arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: mdio-mux-emi1@54:
> 	mdio@20:reg:0:0: 32 is greater than the maximum of 31
> 
> The reason is that "mdio-mux-emi1@54" match "nodename: '^mdio(@.*)?'" in
> mdio.yaml.
> 
> Change to '^mdio(-(bus|external))?(@.+|-([0-9]+))$' to avoid wrong match
> mdio mux controller's node.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - use rob's suggest to fix node name pattern.
> ---
>  Documentation/devicetree/bindings/net/mdio.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mdio-gpio.example.dtb: mdio: $nodename:0: 'mdio' does not match '^mdio(-(bus|external))?(@.+|-([0-9]+))$'
	from schema $id: http://devicetree.org/schemas/net/mdio-gpio.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240813150615.3866759-1-Frank.Li@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


