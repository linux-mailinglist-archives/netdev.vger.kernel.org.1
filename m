Return-Path: <netdev+bounces-176752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0692EA6BFD0
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E250188D4E7
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 16:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BAC1E3774;
	Fri, 21 Mar 2025 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9hAxhUj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F044414601C;
	Fri, 21 Mar 2025 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574148; cv=none; b=lnm+EyNpvuaSqwkdXpLkAhYbEQlK/ndakE9PmJwz8pcSl3djz5ImWTmYvgwDtVFSizh89OBWsxD86vcSrYZ11PKUTHr/RTMbnhoADJKa85cVT/Nn0cY1h+E/V3klDhdt/1KBlGNEbXQdUD0J7FRWyE8HktbdipgYim7NDZ1O0g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574148; c=relaxed/simple;
	bh=BVHJeIjPOcoptXmVK10MS67GAYq8d6EXNUvf5ugsuhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObVdtFvi1U7Y2zOrcYnii2GUIbd5hzd/vc9trYFHG30kSXIDnjuCAKhejbgX6H1+BgillcZaxW9HEdHl8u0NHWPHyXOjsAjD6BZ4hqckpjI0K2QLFfX+pa1JdF8iwzXAhd7UyPwAK3z3w0VKQHMjMvJzIJtkNMvbZbMWUzrgfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9hAxhUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D31EC4CEE3;
	Fri, 21 Mar 2025 16:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742574147;
	bh=BVHJeIjPOcoptXmVK10MS67GAYq8d6EXNUvf5ugsuhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L9hAxhUjN9aDKSnmf4Un/E/lfR6d/emDNCb3yMIGSlnOyBHUwpYdgEQKZ4JrMkUK7
	 hY5f1SGmmNYj3N0kFSb9D9Pb/vVNrssUiASF0rxN/lQ35PJVFtOjNfG7H/ktLXNFy/
	 toJAMTtrh0rTQR9Nvk+uk2VdTq1qAtZ5jSqWL05KHZXG+5xMZsAjuTvnS1FHJrZnEn
	 K1yZNDvGst8NeuSVD2Xnx+3Nnx3mj+eIWjsnC5bmkG6XWrjK9xKgqbL/CS0jY5dgzp
	 /Rl1aCqRK0J6AGqa+BGzkoVIB5qinrf8Deg9wVJvrg7DSDvljhdkue9CM4kwZwx3QB
	 xQLpge/W2cp2w==
Date: Fri, 21 Mar 2025 11:22:26 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH 6/6] dt-bindings: net: pcs: Document support for
 Airoha Ethernet PCS
Message-ID: <20250321162226.GA3472739-robh@kernel.org>
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
 <20250318235850.6411-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318235850.6411-7-ansuelsmth@gmail.com>

On Wed, Mar 19, 2025 at 12:58:42AM +0100, Christian Marangi wrote:
> Document support for Airoha Ethernet PCS for AN7581 SoC.
> 
> Airoha AN7581 SoC expose multiple Physical Coding Sublayer (PCS) for
> the various Serdes port supporting different Media Independent Interface
> (10BASE-R, USXGMII, 2500BASE-X, 1000BASE-X, SGMII).
> 
> This follow the new PCS provider with the use of #pcs-cells property.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/net/pcs/airoha,pcs.yaml          | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml b/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
> new file mode 100644
> index 000000000000..8bcf7757c728
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pcs/airoha,pcs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha Ethernet PCS and Serdes
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description:
> +  Airoha AN7581 SoC expose multiple Physical Coding Sublayer (PCS) for
> +  the various Serdes port supporting different Media Independent Interface
> +  (10BASE-R, USXGMII, 2500BASE-X, 1000BASE-X, SGMII).
> +
> +properties:
> +  compatible:
> +    enum:
> +      - airoha,an7581-pcs-eth
> +      - airoha,an7581-pcs-pon
> +
> +  reg:
> +    items:
> +      - description: XFI MAC reg
> +      - description: HSGMII AN reg
> +      - description: HSGMII PCS reg
> +      - description: MULTI SGMII reg
> +      - description: USXGMII reg
> +      - description: HSGMII rate adaption reg
> +      - description: XFI Analog register

Is that just 1 register? Or should be 'registers'?

Please be consistent with reg and register.

> +      - description: XFI PMA (Physical Medium Attachment) register
> +
> +  reg-names:
> +    items:
> +      - const: xfi_mac
> +      - const: hsgmii_an
> +      - const: hsgmii_pcs
> +      - const: multi_sgmii
> +      - const: usxgmii
> +      - const: hsgmii_rate_adp
> +      - const: xfi_ana
> +      - const: xfi_pma
> +
> +  resets:
> +    items:
> +      - description: MAC reset
> +      - description: PHY reset
> +
> +  reset-names:
> +    items:
> +      - const: mac
> +      - const: phy
> +
> +  "#pcs-cells":
> +    const: 0

So you did add something. But why if you only need 0 cells? That was 
what was already supported.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - resets
> +  - reset-names
> +  - "#pcs-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/reset/airoha,en7581-reset.h>
> +
> +    pcs@1fa08000 {
> +        compatible = "airoha,an7581-pcs-pon";
> +        reg = <0x1fa08000 0x1000>,
> +              <0x1fa80000 0x60>,
> +              <0x1fa80a00 0x164>,
> +              <0x1fa84000 0x450>,
> +              <0x1fa85900 0x338>,
> +              <0x1fa86000 0x300>,
> +              <0x1fa8a000 0x1000>,
> +              <0x1fa8b000 0x1000>;
> +        reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
> +                    "multi_sgmii", "usxgmii",
> +                    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
> +
> +        resets = <&scuclk EN7581_XPON_MAC_RST>,
> +                 <&scuclk EN7581_XPON_PHY_RST>;
> +        reset-names = "mac", "phy";
> +
> +        #pcs-cells = <0>;
> +    };
> +
> +    pcs@1fa09000 {
> +        compatible = "airoha,an7581-pcs-eth";
> +        reg = <0x1fa09000 0x1000>,
> +              <0x1fa70000 0x60>,
> +              <0x1fa70a00 0x164>,
> +              <0x1fa74000 0x450>,
> +              <0x1fa75900 0x338>,
> +              <0x1fa76000 0x300>,
> +              <0x1fa7a000 0x1000>,
> +              <0x1fa7b000 0x1000>;
> +        reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
> +                    "multi_sgmii", "usxgmii",
> +                    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
> +
> +        resets = <&scuclk EN7581_XSI_MAC_RST>,
> +                 <&scuclk EN7581_XSI_PHY_RST>;
> +        reset-names = "mac", "phy";
> +
> +        #pcs-cells = <0>;
> +    };
> -- 
> 2.48.1
> 

