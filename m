Return-Path: <netdev+bounces-211361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D652B18303
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 15:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F4F5A03FD
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7332561D4;
	Fri,  1 Aug 2025 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYVLna3I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBD411CA0;
	Fri,  1 Aug 2025 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754056630; cv=none; b=d+uO977n+2oMfceOdXrLgPQh4+lus5rt1BPy66NMGRIT6XqCD6n9yF7ROIvhUypMmfNfxpyEjOycMqnfTpmVJmypjWvJky4ugsVsrx5KUDjCN2nmoI6zRTknTeDoKLMTux2IAP5UMXY2Fa4TU9J/2RB1808yA4q+G13Xy869MVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754056630; c=relaxed/simple;
	bh=ODFfb+QAAqr6E6So/c4wBLjAbythTMbcmohhbIRP7Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpTuik2xBWUMAyKBOyEILeIwM55Gbxyonjzqe158L9+zK3S6EW1OnkUluDAon2Pw8pBLEw8KMJV/kn2bRvhqfv+bVNXwCoh/IUjzNarQlU9xnJJIKh0xWQBN+atQlr5GaSUU0XyRQ+GGjTtW/u9KyFZQsYb97kHtXODgCKYMPkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYVLna3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC78C4CEE7;
	Fri,  1 Aug 2025 13:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754056630;
	bh=ODFfb+QAAqr6E6So/c4wBLjAbythTMbcmohhbIRP7Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HYVLna3I2WaENWcmwrOtQHlnHx9n5kSO61/R3IwON8bfkhKmTH5gg/W51WKGenC6K
	 ftQW4jUfeVAezxjBp/tQ7NzkUv5moGiHVAXVR4J9jTWPOM5zUjtTg02uicu7kR01fP
	 ERq8Tw2/2u0crORVkjSpEhy+oe/bTUujY2qtq/SUWsiO+4Xd0anTZXK5F+B2g6X0mD
	 Zxx1SciqjzRF5V2A4rRKT9G5ICLCfr/yg+U4N5B0JzyyrUpSqCFJYT4ON/zDMjEO0M
	 JwYPSGKiowhLEUtZWPO7atEaRjk2FhNhs3lu+4rMkVDgR/lkVY5NplpQzBQG1quCFJ
	 woym3/NjsyI3g==
Date: Fri, 1 Aug 2025 08:57:09 -0500
From: Rob Herring <robh@kernel.org>
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de,
	richardcochran@gmail.com, guangjie.song@mediatek.com,
	wenst@chromium.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	kernel@collabora.com,
	=?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH v3 09/27] dt-bindings: clock: mediatek: Describe MT8196
 clock controllers
Message-ID: <20250801135604.GA3045005-robh@kernel.org>
References: <20250730105653.64910-1-laura.nao@collabora.com>
 <20250730105653.64910-10-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250730105653.64910-10-laura.nao@collabora.com>

On Wed, Jul 30, 2025 at 12:56:35PM +0200, Laura Nao wrote:
> Add new binding documentation for system clocks, functional clocks and
> PEXTP0/1 and UFS reset controllers on MediaTek MT8196.
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  .../bindings/clock/mediatek,mt8196-clock.yaml |  86 ++
>  .../clock/mediatek,mt8196-sys-clock.yaml      |  81 ++
>  .../dt-bindings/clock/mediatek,mt8196-clock.h | 802 ++++++++++++++++++
>  .../reset/mediatek,mt8196-resets.h            |  26 +
>  4 files changed, 995 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml
>  create mode 100644 include/dt-bindings/clock/mediatek,mt8196-clock.h
>  create mode 100644 include/dt-bindings/reset/mediatek,mt8196-resets.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml
> new file mode 100644
> index 000000000000..03ee0dff464b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/mediatek,mt8196-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Functional Clock Controller for MT8196
> +
> +maintainers:
> +  - Guangjie Song <guangjie.song@mediatek.com>
> +  - Laura Nao <laura.nao@collabora.com>
> +
> +description: |
> +  The clock architecture in MediaTek SoCs is structured like below:
> +  PLLs -->
> +          dividers -->
> +                      muxes
> +                           -->
> +                              clock gate
> +
> +  The device nodes provide clock gate control in different IP blocks.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8196-imp-iic-wrap-c
> +          - mediatek,mt8196-imp-iic-wrap-e
> +          - mediatek,mt8196-imp-iic-wrap-n
> +          - mediatek,mt8196-imp-iic-wrap-w
> +          - mediatek,mt8196-mdpsys0
> +          - mediatek,mt8196-mdpsys1
> +          - mediatek,mt8196-pericfg-ao
> +          - mediatek,mt8196-pextp0cfg-ao
> +          - mediatek,mt8196-pextp1cfg-ao
> +          - mediatek,mt8196-ufscfg-ao
> +          - mediatek,mt8196-vencsys
> +          - mediatek,mt8196-vencsys-c1
> +          - mediatek,mt8196-vencsys-c2
> +          - mediatek,mt8196-vdecsys
> +          - mediatek,mt8196-vdecsys-soc
> +          - mediatek,mt8196-vdisp-ao
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +    description:
> +      Reset lines for PEXTP0/1 and UFS blocks.
> +
> +  mediatek,hardware-voter:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      On the MT8196 SoC, a Hardware Voter (HWV) backed by a fixed-function
> +      MCU manages clock and power domain control across the AP and other
> +      remote processors. By aggregating their votes, it ensures clocks are
> +      safely enabled/disabled and power domains are active before register
> +      access.

I thought this was going away based on v2 discussion?

Rob


