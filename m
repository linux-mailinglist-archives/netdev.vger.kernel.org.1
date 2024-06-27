Return-Path: <netdev+bounces-107472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B19491B1FB
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 00:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD4328766A
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 22:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522AC1A08DA;
	Thu, 27 Jun 2024 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tufEBZ2Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F5F3FBA5;
	Thu, 27 Jun 2024 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719526212; cv=none; b=Fey7BgxHf6v/7fq7CfZBihEuotuDH5/bWIqwOEueNHCVpucrILX7rEP/ac7n7WTIREagvVRPIlyZkhCKsBHfHBV9lqfF1uiCrbnxyfV8NWBZz461KbvLE+SLfWxRCWEJuClmnFYJ37hDWg6jT/WNeGaGWVpf8NJp2yNIjHkvHxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719526212; c=relaxed/simple;
	bh=iVuyxyONPpxpjzkSJYMe8dZcdQ1/BDg5Bz+mkpj2D10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhsuQMc55DhGfUvQq+rpL51v/oE4DYTaKDW1PR7kZzzq3tRuLzZ3UouQAqi5LginWW9Lx2BuhuYwRSiJiU2eXWBYYqWsZCGG7PTb7FcQFt62fMibBqgKpZY2plfFavaEHgC8h29ptN9BAk3bgZE0lC4e+8Ax+KrdR1gaAmob0Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tufEBZ2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C322C2BBFC;
	Thu, 27 Jun 2024 22:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719526211;
	bh=iVuyxyONPpxpjzkSJYMe8dZcdQ1/BDg5Bz+mkpj2D10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tufEBZ2ZFfIAy2AL4INm7po81Gxl39+5QqY4R/IltiFsTqZ8U3SVINEaZzAD/7gn6
	 0OpYX9RFKibygDlhQKwikKRMQjd9t5mUcDGDEJhhLpMt2DwtQ18CJP8ezpDpX5UYFj
	 O6KDGFZ7QLNryAm8EALz0SITM4KrPlFb3sOplEazp3SYxcJ61twwVxDO7ERXNWYOaa
	 SB7n+3YwKXREUEOHhbG9kjQ0vJtzSWtGjEMP5Y+Y740f0u1gKPVhEhWse6PRZwhEcF
	 Y2Fqh8VNukZL/blf43Izvd2iy4R5mQ64S0TwDmKpLKs9/1C+cNyfWpK711DYGWmAwZ
	 O2eNdYdfHsptQ==
Date: Thu, 27 Jun 2024 16:10:07 -0600
From: Rob Herring <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, andrew@lunn.ch
Subject: Re: [PATCH v3 net-next 1/2] dt-bindings: net: airoha: Add EN7581
 ethernet controller
Message-ID: <20240627221007.GA646876-robh@kernel.org>
References: <cover.1719159076.git.lorenzo@kernel.org>
 <ec00d7042f43d289f7a88e0fed70a68905db0bde.1719159076.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec00d7042f43d289f7a88e0fed70a68905db0bde.1719159076.git.lorenzo@kernel.org>

On Sun, Jun 23, 2024 at 06:19:56PM +0200, Lorenzo Bianconi wrote:
> Introduce device-tree binding documentation for Airoha EN7581 ethernet
> mac controller.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/net/airoha,en7581-eth.yaml       | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> new file mode 100644
> index 000000000000..e25a462a75d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/airoha,en7581-eth.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha EN7581 Frame Engine Ethernet controller
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +
> +maintainers:
> +  - Lorenzo Bianconi <lorenzo@kernel.org>
> +
> +description:
> +  The frame engine ethernet controller can be found on Airoha SoCs.
> +  These SoCs have dual GMAC ports.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - airoha,en7581-eth
> +
> +  reg:
> +    items:
> +      - description: Frame engine base address
> +      - description: QDMA0 base address
> +      - description: QDMA1 base address
> +
> +  reg-names:
> +    items:
> +      - const: fe
> +      - const: qdma0
> +      - const: qdma1
> +
> +  interrupts:
> +    maxItems: 10

You need to define what each interrupt is. Just like 'reg'.

> +
> +  resets:
> +    maxItems: 8
> +
> +  reset-names:
> +    items:
> +      - const: fe
> +      - const: pdma
> +      - const: qdma
> +      - const: xsi-mac
> +      - const: hsi0-mac
> +      - const: hsi1-mac
> +      - const: hsi-mac
> +      - const: xfp-mac
> +

> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

What are these for? You have no child nodes to use them.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - resets
> +  - reset-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/en7523-clk.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      eth0: ethernet@1fb50000 {
> +        compatible = "airoha,en7581-eth";
> +        reg = <0 0x1fb50000 0 0x2600>,
> +              <0 0x1fb54000 0 0x2000>,
> +              <0 0x1fb56000 0 0x2000>;
> +        reg-names = "fe", "qdma0", "qdma1";
> +
> +        resets = <&scuclk 44>,
> +                 <&scuclk 30>,
> +                 <&scuclk 31>,
> +                 <&scuclk 6>,
> +                 <&scuclk 15>,
> +                 <&scuclk 16>,
> +                 <&scuclk 17>,
> +                 <&scuclk 26>;
> +        reset-names = "fe", "pdma", "qdma", "xsi-mac",
> +                      "hsi0-mac", "hsi1-mac", "hsi-mac",
> +                      "xfp-mac";
> +
> +        interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +      };
> +    };
> -- 
> 2.45.2
> 

