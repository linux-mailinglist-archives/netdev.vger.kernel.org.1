Return-Path: <netdev+bounces-213450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71196B24FF6
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 18:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85BF17AA908
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8F12877D0;
	Wed, 13 Aug 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omjkMhQD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57901287510;
	Wed, 13 Aug 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755103202; cv=none; b=l+00+oOzZ8R43/rcxDmSvwzN12geGqipbv8e3/C1jbHYIZagtQPxe7h74ig5+1Ut8vCuABC95TxELqrqQfSpIKYabNx1VaMvNzk40vjqYh+oTK4MxOWdDEwVprulpz0R6JKn1Lxpnv0jSduIdp4JC6GUAzqFvvIb0+CTmPY0LlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755103202; c=relaxed/simple;
	bh=s8ZXEipGSIJlMDIb18naqDV3kZSHdB/qD0ILmHJeqbs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ecQcjjxOf9d1FToKA9pQp8cwJYguRdZP5AQrXzKYkaCn2zDdxk7GYmYhFaHj199PkUamWxWwEn+MtJMYdSEUSxd50WAV3dTxWdleaqawGaeUKFxrXqRL3/hzGGmLd/voEVp56qWbQRaLQpE+bk47uF91aXlCIE71EJFrPEk+Vhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omjkMhQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C198EC4CEEB;
	Wed, 13 Aug 2025 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755103201;
	bh=s8ZXEipGSIJlMDIb18naqDV3kZSHdB/qD0ILmHJeqbs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=omjkMhQD9oRe4bVtEyTDH44yDFKboKpOGtcbD8GT9O8J352gBe6l8mq2PUjcuwAcU
	 8ibfOwvFrmjsvzbFS6QHEhUOniPp/bBUG6U0B0RhmxCJy8c9YG8LsX5OJMHzKVllLd
	 M49oGrDfr/dl9kC0aV2OSF6sJ1H2VLKNIMvAhLoHWaHjpZoTuTUy85g4HcymGPfokP
	 ybRp0b5p3By1kpX0tHtrBcx5UIdIhtggKG1tdMEPu3E39ZauYxLd+N3fL3Yh/59aMh
	 bdA0AfNLGPluOs/0AYYw+WNIjuwcsOlzND96burMON257vVCbGDUXo1L/tJ0UKGXrb
	 GDnvh28lixVDQ==
Date: Wed, 13 Aug 2025 11:40:00 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jernej Skrabec <jernej@kernel.org>, linux-kernel@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Paolo Abeni <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org, 
 Samuel Holland <samuel@sholland.org>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 Conor Dooley <conor+dt@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
In-Reply-To: <20250813145540.2577789-2-wens@kernel.org>
References: <20250813145540.2577789-1-wens@kernel.org>
 <20250813145540.2577789-2-wens@kernel.org>
Message-Id: <175510320095.362031.4736054030445457554.robh@kernel.org>
Subject: Re: [PATCH net-next v2 01/10] dt-bindings: net: sun8i-emac: Add
 A523 GMAC200 compatible


On Wed, 13 Aug 2025 22:55:31 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The Allwinner A523 SoC family has a second Ethernet controller, called
> the GMAC200 in the BSP and T527 datasheet, and referred to as GMAC1 for
> numbering. This controller, according to BSP sources, is fully
> compatible with a slightly newer version of the Synopsys DWMAC core.
> The glue layer around the controller is the same as found around older
> DWMAC cores on Allwinner SoCs. The only slight difference is that since
> this is the second controller on the SoC, the register for the clock
> delay controls is at a different offset. Last, the integration includes
> a dedicated clock gate for the memory bus and the whole thing is put in
> a separately controllable power domain.
> 
> Add a compatible string entry for it, and work in the requirements for
> a second clock and a power domain.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes since v1:
> - Switch to generic (tx|rx)-internal-delay-ps properties
> ---
>  .../net/allwinner,sun8i-a83t-emac.yaml        | 81 ++++++++++++++++++-
>  1 file changed, 79 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.example.dtb: ethernet@28000000 (toshiba,visconti-dwmac): clock-names: ['stmmaceth', 'phy_ref_clk'] is too long
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.example.dtb: ethernet@28000000 (toshiba,visconti-dwmac): clocks: [[4294967295, 28], [4294967295, 118]] is too long
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.example.dtb: ethernet@28000000 (toshiba,visconti-dwmac): compatible: 'oneOf' conditional failed, one must be fixed:
	['toshiba,visconti-dwmac', 'snps,dwmac-4.20a'] is too long
	'allwinner,sun8i-a83t-emac' was expected
	'allwinner,sun8i-h3-emac' was expected
	'allwinner,sun8i-r40-gmac' was expected
	'allwinner,sun8i-v3s-emac' was expected
	'allwinner,sun50i-a64-emac' was expected
	'toshiba,visconti-dwmac' is not one of ['allwinner,sun20i-d1-emac', 'allwinner,sun50i-a100-emac', 'allwinner,sun50i-h6-emac', 'allwinner,sun50i-h616-emac0', 'allwinner,sun55i-a523-gmac0']
	'allwinner,sun55i-a523-gmac200' was expected
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.example.dtb: ethernet@28000000 (toshiba,visconti-dwmac): 'resets' is a required property
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.example.dtb: ethernet@28000000 (toshiba,visconti-dwmac): 'reset-names' is a required property
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.example.dtb: ethernet@28000000 (toshiba,visconti-dwmac): 'syscon' is a required property
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000 (st,stm32mp1-dwmac): clock-names: ['stmmaceth', 'mac-clk-tx', 'mac-clk-rx', 'ethstp', 'eth-ck'] is too long
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000 (st,stm32mp1-dwmac): clocks: [[4294967295, 105], [4294967295, 103], [4294967295, 104], [4294967295, 112], [4294967295, 123]] is too long
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000 (st,stm32mp1-dwmac): clock-names: ['stmmaceth', 'mac-clk-tx', 'mac-clk-rx', 'ethstp', 'eth-ck'] is too long
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000 (st,stm32mp1-dwmac): clocks: [[4294967295, 105], [4294967295, 103], [4294967295, 104], [4294967295, 112], [4294967295, 123]] is too long
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000 (st,stm32mp1-dwmac): compatible: 'oneOf' conditional failed, one must be fixed:
	['st,stm32mp1-dwmac', 'snps,dwmac-4.20a'] is too long
	'allwinner,sun8i-a83t-emac' was expected
	'allwinner,sun8i-h3-emac' was expected
	'allwinner,sun8i-r40-gmac' was expected
	'allwinner,sun8i-v3s-emac' was expected
	'allwinner,sun50i-a64-emac' was expected
	'st,stm32mp1-dwmac' is not one of ['allwinner,sun20i-d1-emac', 'allwinner,sun50i-a100-emac', 'allwinner,sun50i-h6-emac', 'allwinner,sun50i-h616-emac0', 'allwinner,sun55i-a523-gmac0']
	'allwinner,sun55i-a523-gmac200' was expected
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000 (st,stm32mp1-dwmac): 'resets' is a required property
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000 (st,stm32mp1-dwmac): 'reset-names' is a required property
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000 (st,stm32mp1-dwmac): 'phy-handle' is a required property
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000 (st,stm32mp1-dwmac): 'syscon' is a required property
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000 (st,stm32mp1-dwmac): Unevaluated properties are not allowed ('reg-names', 'st,syscon' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mediatek-dwmac.example.dtb: ethernet@1101c000 (mediatek,mt2712-gmac): clock-names:0: 'stmmaceth' was expected
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mediatek-dwmac.example.dtb: ethernet@1101c000 (mediatek,mt2712-gmac): clock-names: ['axi', 'apb', 'mac_main', 'ptp_ref', 'rmii_internal'] is too long
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mediatek-dwmac.example.dtb: ethernet@1101c000 (mediatek,mt2712-gmac): clocks: [[4294967295, 34], [4294967295, 37], [4294967295, 154], [4294967295, 155], [4294967295, 158]] is too long
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mediatek-dwmac.example.dtb: ethernet@1101c000 (mediatek,mt2712-gmac): power-domains: False schema does not allow [[4294967295, 4]]
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mediatek-dwmac.example.dtb: ethernet@1101c000 (mediatek,mt2712-gmac): clock-names: ['axi', 'apb', 'mac_main', 'ptp_ref', 'rmii_internal'] is too long
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mediatek-dwmac.example.dtb: ethernet@1101c000 (mediatek,mt2712-gmac): clocks: [[4294967295, 34], [4294967295, 37], [4294967295, 154], [4294967295, 155], [4294967295, 158]] is too long
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mediatek-dwmac.example.dtb: ethernet@1101c000 (mediatek,mt2712-gmac): compatible: 'oneOf' conditional failed, one must be fixed:
	['mediatek,mt2712-gmac', 'snps,dwmac-4.20a'] is too long
	'allwinner,sun8i-a83t-emac' was expected
	'allwinner,sun8i-h3-emac' was expected
	'allwinner,sun8i-r40-gmac' was expected
	'allwinner,sun8i-v3s-emac' was expected
	'allwinner,sun50i-a64-emac' was expected
	'mediatek,mt2712-gmac' is not one of ['allwinner,sun20i-d1-emac', 'allwinner,sun50i-a100-emac', 'allwinner,sun50i-h6-emac', 'allwinner,sun50i-h616-emac0', 'allwinner,sun55i-a523-gmac0']
	'allwinner,sun55i-a523-gmac200' was expected
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mediatek-dwmac.example.dtb: ethernet@1101c000 (mediatek,mt2712-gmac): 'resets' is a required property
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mediatek-dwmac.example.dtb: ethernet@1101c000 (mediatek,mt2712-gmac): 'reset-names' is a required property
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mediatek-dwmac.example.dtb: ethernet@1101c000 (mediatek,mt2712-gmac): 'phy-handle' is a required property
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mediatek-dwmac.example.dtb: ethernet@1101c000 (mediatek,mt2712-gmac): 'syscon' is a required property
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mediatek-dwmac.example.dtb: ethernet@1101c000 (mediatek,mt2712-gmac): Unevaluated properties are not allowed ('mediatek,pericfg', 'mediatek,tx-delay-ps' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250813145540.2577789-2-wens@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


