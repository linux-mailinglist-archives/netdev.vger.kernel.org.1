Return-Path: <netdev+bounces-21484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE33C763B04
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8926C281280
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE1B253B8;
	Wed, 26 Jul 2023 15:28:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543851DA3F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B03C433C7;
	Wed, 26 Jul 2023 15:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690385309;
	bh=0x7P+VDJDVD5QuhGvIi2giCzmIJXH7saxma9w0XMV9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZ7w19RluYfbv+Dw7NYsEede8Nmhw13K4AASGUcjlWRAkbvfefbX4Y0RMh8mdZc0K
	 5RbKhxflx4zgwxdYcRSdS99f9KK04n0ctPOPyb1qfKwZTY8QAiMeIm5PmZJJyDdl+t
	 UedGwx6AqSmdu67xBWIfFzdnjdUU1wEzpuexErsDEbVxSnAHUG22Mjry+yUQfxBvW0
	 c+4wjeX6Noe9FE7OzvCq1u8qG9cpdcED8GUDIye9vypAjtBkeXxmiH8S9tj3MelVsT
	 XaTASh5QVa4TwfgMg8Tjv0AQAGFKH9Ov+ZXwX62PF7etXKFJnpVWJ1oDf4xLCbb2o6
	 ENRSd7HDusU+Q==
Received: (nullmailer pid 1478019 invoked by uid 1000);
	Wed, 26 Jul 2023 15:28:27 -0000
Date: Wed, 26 Jul 2023 09:28:27 -0600
From: Rob Herring <robh@kernel.org>
To: Ivan Mikhaylov <fr0st61te@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: net: ftgmac100: convert to yaml version
 from txt
Message-ID: <20230726152827.GA1474469-robh@kernel.org>
References: <20230723192030.33642-1-fr0st61te@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723192030.33642-1-fr0st61te@gmail.com>

On Sun, Jul 23, 2023 at 10:20:30PM +0300, Ivan Mikhaylov wrote:
> Conversion from ftgmac100.txt to yaml format version.
> 
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> ---
>  .../bindings/net/faraday,ftgmac100.yaml       | 103 ++++++++++++++++++
>  .../devicetree/bindings/net/ftgmac100.txt     |  67 ------------
>  2 files changed, 103 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/ftgmac100.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> new file mode 100644
> index 000000000000..92686caf251f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Faraday Technology FTGMAC100 gigabit ethernet controller
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +
> +maintainers:
> +  - Po-Yu Chuang <ratbert@faraday-tech.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: faraday,ftgmac100
> +      - items:
> +          - enum:
> +              - aspeed,ast2400-mac
> +              - aspeed,ast2500-mac
> +              - aspeed,ast2600-mac
> +          - const: faraday,ftgmac100
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: MAC IP clock
> +      - description: RMII RCLK gate for AST2500/2600
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
> +    contains:
> +      enum:
> +        - MACCLK
> +        - RCLK
> +
> +  phy-mode:
> +    enum:
> +      - rgmii
> +      - rmii
> +
> +  phy-handle: true
> +
> +  use-ncsi:
> +    description:
> +      Use the NC-SI stack instead of an MDIO PHY. Currently assumes
> +      rmii (100bT) but kept as a separate property in case NC-SI grows support
> +      for a gigabit link.
> +    type: boolean
> +
> +  no-hw-checksum:
> +    description:
> +      Used to disable HW checksum support. Here for backward
> +      compatibility as the driver now should have correct defaults based on
> +      the SoC.
> +    type: boolean

deprecated: true

> +
> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mac0: ethernet@1e660000 {

Drop unused labels.

> +        compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
> +        reg = <0x1e660000 0x180>;
> +        interrupts = <2>;
> +        use-ncsi;
> +    };
> +
> +    mac1: ethernet@1e680000 {
> +        compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
> +        reg = <0x1e680000 0x180>;
> +        interrupts = <2>;
> +
> +        phy-handle = <&phy>;
> +        phy-mode = "rgmii";
> +
> +        mdio {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            phy: ethernet-phy@1 {
> +                compatible = "ethernet-phy-ieee802.3-c22";
> +                reg = <1>;
> +            };
> +        };
> +    };

