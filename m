Return-Path: <netdev+bounces-220617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDF7B476D4
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 21:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A717C3FD3
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 19:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4E1284B51;
	Sat,  6 Sep 2025 19:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rn5HF3f/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057231FBEB6;
	Sat,  6 Sep 2025 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757186239; cv=none; b=LboW9F1N9TPHzFmSwGEsoeE+KEykILlJX8t1kN93zB1jo6rdkjAdD/NzNLOCgcjHnwTOiRBI5j7/BnpIHGRc+86t8b85y/CoSPLaPZOXu7AOWUE7jpQObrTg5+erAD//jVxFRa4c+cZDGUD7sPPgoGVInjImMwUQ/u7JIrfcZRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757186239; c=relaxed/simple;
	bh=PIHt9qWHF0uha6ZXEr6wx9P1J0M5MOKU8PM2VawQnRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGDG2XV7lK316t7UQ/sdAXWySCkZCa7TojFpYGaPSqbVTi01quBvEA9siTNJ6OmTpjQxTAyKiT7aD0Mzlg9v0N7k1GFecrBv2vNKVCzC1jvCqTPXk07r6Eb/CJ9WWZteRtIrj7dAgSCSf+J2wT8IR7lDzN0tiWSAcGvXdrjz9PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rn5HF3f/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F0CC4CEF7;
	Sat,  6 Sep 2025 19:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757186238;
	bh=PIHt9qWHF0uha6ZXEr6wx9P1J0M5MOKU8PM2VawQnRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rn5HF3f/ZySMqQCcl8Gt2sNa034RPGm/Lgah8OwoA2FDrLOSOZqs62KbN+VtSJQO3
	 Ozk4ih1h0A74mDAgu4WwakXifYAIg/kyY10N2HbH1Ajgagbqh9hws7F8roIvkK2R2E
	 FH8hwgaOhmPqMeyiOqX161+mz7bj99JXKAqQElNMHaSUe0pCkNk0ZwqzgSCphZXvmt
	 XiEDH5jAPPfmkjgoFRT74vhWvO9p48K1/PbiaaAMN/mpTsYIoYu47l83IhXJ7fuQc4
	 hrnPBuP37QFel11vVD3j1Z74C1wjkWPxeOvWeVpfcz4VaeC5vtjpOQScIu1YL9SOU9
	 sojktmtwhi8wg==
Date: Sat, 6 Sep 2025 14:17:17 -0500
From: Rob Herring <robh@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v7 1/3] dt-bindings: net: dsa: yt921x: Add
 Motorcomm YT921x switch support
Message-ID: <20250906191717.GA1639859-robh@kernel.org>
References: <20250905181728.3169479-1-mmyangfl@gmail.com>
 <20250905181728.3169479-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905181728.3169479-2-mmyangfl@gmail.com>

On Sat, Sep 06, 2025 at 02:17:21AM +0800, David Yang wrote:
> The Motorcomm YT921x series is a family of Ethernet switches with up to
> 8 internal GbE PHYs and up to 2 GMACs.

A couple of nits below if you spin another version.

> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/net/dsa/motorcomm,yt921x.yaml    | 169 ++++++++++++++++++
>  1 file changed, 169 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
> new file mode 100644
> index 000000000000..275f5feb0160
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
> @@ -0,0 +1,169 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/motorcomm,yt921x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Motorcomm YT921x Ethernet switch family
> +
> +maintainers:
> +  - David Yang <mmyangfl@gmail.com>
> +
> +description: |
> +  The Motorcomm YT921x series is a family of Ethernet switches with up to 8
> +  internal GbE PHYs and up to 2 GMACs, including:
> +
> +    - YT9215S / YT9215RB / YT9215SC: 5 GbE PHYs (Port 0-4) + 2 GMACs (Port 8-9)
> +    - YT9213NB: 2 GbE PHYs (Port 1/3) + 1 GMAC (Port 9)
> +    - YT9214NB: 2 GbE PHYs (Port 1/3) + 2 GMACs (Port 8-9)
> +    - YT9218N: 8 GbE PHYs (Port 0-7)
> +    - YT9218MB: 8 GbE PHYs (Port 0-7) + 2 GMACs (Port 8-9)
> +
> +  Any port can be used as the CPU port.
> +
> +properties:
> +  compatible:
> +    const: motorcomm,yt9215
> +
> +  reg:
> +    enum: [0x0, 0x1d]
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    description: |

Don't need '|'.

> +      Internal MDIO bus for the internal GbE PHYs. PHYs 0-7 are used for Port
> +      0-7 respectively.
> +
> +  mdio-external:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    description: |

Don't need '|'.

> +      External MDIO bus to access external components. External PHYs for GMACs
> +      (Port 8-9) are expected to be connected to the external MDIO bus in
> +      vendor's reference design, but that is not a hard limitation from the
> +      chip.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: dsa.yaml#/$defs/ethernet-ports
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        switch@1d {
> +            compatible = "motorcomm,yt9215";
> +            /* default 0x1d, alternate 0x0 */
> +            reg = <0x1d>;
> +            reset-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
> +
> +            mdio {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                sw_phy0: phy@0 {
> +                    reg = <0x0>;
> +                };
> +
> +                sw_phy1: phy@1 {
> +                    reg = <0x1>;
> +                };
> +
> +                sw_phy2: phy@2 {
> +                    reg = <0x2>;
> +                };
> +
> +                sw_phy3: phy@3 {
> +                    reg = <0x3>;
> +                };
> +
> +                sw_phy4: phy@4 {
> +                    reg = <0x4>;
> +                };
> +            };
> +
> +            mdio-external {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                phy1: phy@b {
> +                    reg = <0xb>;
> +                };
> +            };
> +
> +            ports {

ethernet-ports

> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {

ethernet-port

> +                    reg = <0>;
> +                    label = "lan1";
> +                    phy-mode = "internal";
> +                    phy-handle = <&sw_phy0>;
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    label = "lan2";
> +                    phy-mode = "internal";
> +                    phy-handle = <&sw_phy1>;
> +                };
> +
> +                port@2 {
> +                    reg = <2>;
> +                    label = "lan3";
> +                    phy-mode = "internal";
> +                    phy-handle = <&sw_phy2>;
> +                };
> +
> +                port@3 {
> +                    reg = <3>;
> +                    label = "lan4";
> +                    phy-mode = "internal";
> +                    phy-handle = <&sw_phy3>;
> +                };
> +
> +                port@4 {
> +                    reg = <4>;
> +                    label = "lan5";
> +                    phy-mode = "internal";
> +                    phy-handle = <&sw_phy4>;
> +                };
> +
> +                /* CPU port */
> +                port@8 {
> +                    reg = <8>;
> +                    phy-mode = "sgmii";
> +                    ethernet = <&eth0>;
> +
> +                    fixed-link {
> +                        speed = <1000>;
> +                        full-duplex;
> +                        pause;
> +                        asym-pause;
> +                    };
> +                };
> +
> +                /* if external phy is connected to a MAC */
> +                port@9 {
> +                    reg = <9>;
> +                    label = "wan";
> +                    phy-mode = "rgmii";
> +                    phy-handle = <&phy1>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.50.1
> 

