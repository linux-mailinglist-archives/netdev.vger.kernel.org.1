Return-Path: <netdev+bounces-43756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 019E17D4936
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110D71C20BCB
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 08:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F8615E92;
	Tue, 24 Oct 2023 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UMOrs8rb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3E415490
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 08:03:45 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D54211A
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 01:03:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so6730265a12.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 01:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698134619; x=1698739419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ql5Q8FOWaOd+nb6/H3/ESaBIL30yXZyLnkCaJtQzqT0=;
        b=UMOrs8rb5G2bZCm/pJc6O2B3+lANiBcJDN3j551uW2GjuYertlu3Boc4wB4wNS118c
         FtEpaBby1YHMCR1Jst1/BVolTh9YbQ3J6AilU9HyOvrbn5h6BrURsxt8wcnqYd3Dcodu
         iYhrBZjlnPta6j9EXKI1HR1gTBz428ull4vSgCod8n3fljPrIZqbM0Uil6wRfD0buBwl
         2c4dJeXYzEU6SvAlV//GtfG1RzME7QDWRGbZhXuNy3MldxDDpP8AZ1jOuMcNfdWoDW4Z
         wHrdzJYq3vGQOzBFdDWaeKwJJaz83jlX6W9xWmyNbZydg/f0Sk0ucaCjh4iuZSQXBFJU
         tkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698134619; x=1698739419;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ql5Q8FOWaOd+nb6/H3/ESaBIL30yXZyLnkCaJtQzqT0=;
        b=e/Xcb6WOxUGOaI6sPmECuOA37rH4Cwx5PS2oX/bDbdc/5+t1lfXk1YYfXtQMteLtY9
         l8BX9Uv3POA8KfbBXZNphIo2fUhicbDxcvvBO15xAh6AFO/kq7NnUDWa2wLCHR2HeUBx
         l67VmXedwrsjCESVtk0oFgfU7sLhWkrNpRaTFsVs/JwC0VOEN2GXyqs8p7DQ2px5CIoC
         Brw9s2fXD7/1yIY7vrdwVUugH69ujxof2cHxe9jweRmcCudYsJomskZmDu/doTjaod3d
         H3KT1GIB2QOdD8TpvzRKFoqKSdgsHeqCXSILTb6Y0V1zD9C6iRlooONLsyLEW+R5H9Eq
         s/IA==
X-Gm-Message-State: AOJu0YywZT6k9Z9iDpcrJas1TNkzx6G7upkn/2wwzZPu1Dwf3ro+gVlH
	S5SP4FZv05pZKUEP70rz1DdbL7gD1stFCq8zveg=
X-Google-Smtp-Source: AGHT+IFVooAJl5fWHgr45jmFwB8Oe4BFvAgfTrtsvxzZZRlzL56/Mb5UBFVMkGxIF7wMbXAgxUggCA==
X-Received: by 2002:a17:907:7251:b0:9ad:e298:a5d with SMTP id ds17-20020a170907725100b009ade2980a5dmr10917817ejc.19.1698134619544;
        Tue, 24 Oct 2023 01:03:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906075000b009a5f1d1564dsm7806148ejb.126.2023.10.24.01.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 01:03:38 -0700 (PDT)
Message-ID: <91764d23-eed2-48f9-97c5-ac6a44f48f2b@linaro.org>
Date: Tue, 24 Oct 2023 10:03:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 9/9] dt-bindings: net: add Microchip's LAN865X
 10BASE-T1S MACPHY
Content-Language: en-US
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, corbet@lwn.net, steen.hegelund@microchip.com,
 rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
 andrew@lunn.ch
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
 Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
 Thorsten.Kummermehr@microchip.com
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-10-Parthiban.Veerasooran@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231023154649.45931-10-Parthiban.Veerasooran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/10/2023 17:46, Parthiban Veerasooran wrote:
> Add DT bindings for Microchip's LAN865X 10BASE-T1S MACPHY. The LAN8650/1
> combines a Media Access Controller (MAC) and an Ethernet PHY to enable
> 10BASE‑T1S networks. The Ethernet Media Access Controller (MAC) module
> implements a 10 Mbps half duplex Ethernet MAC, compatible with the IEEE
> 802.3 standard and a 10BASE-T1S physical layer transceiver integrated
> into the LAN8650/1. The communication between the Host and the MAC-PHY is
> specified in the OPEN Alliance 10BASE-T1x MACPHY Serial Interface (TC6).

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  .../bindings/net/microchip,lan865x.yaml       | 101 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/microchip,lan865x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/microchip,lan865x.yaml b/Documentation/devicetree/bindings/net/microchip,lan865x.yaml
> new file mode 100644
> index 000000000000..974622dd6846
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/microchip,lan865x.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/microchip,lan865x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip LAN8650/1 10BASE-T1S MACPHY Ethernet Controllers
> +
> +maintainers:
> +  - Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
> +
> +description:
> +  The LAN8650/1 combines a Media Access Controller (MAC) and an Ethernet
> +  PHY to enable 10BASE‑T1S networks. The Ethernet Media Access Controller
> +  (MAC) module implements a 10 Mbps half duplex Ethernet MAC, compatible
> +  with the IEEE 802.3 standard and a 10BASE-T1S physical layer transceiver
> +  integrated into the LAN8650/1. The communication between the Host and
> +  the MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
> +  Interface (TC6).
> +
> +  Specifications about the LAN8650/1 can be found at:
> +    https://www.microchip.com/en-us/product/lan8650
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: microchip,lan865x

No wildcards in compatibles.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Interrupt from MAC-PHY asserted in the event of Receive Chunks
> +      Available, Transmit Chunk Credits Available and Extended Status
> +      Event.
> +    maxItems: 1
> +
> +  local-mac-address:

Drop property, not needed.

> +    description:
> +      Specifies the MAC address assigned to the network device.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 6
> +    maxItems: 6
> +
> +  spi-max-frequency:
> +    minimum: 15000000
> +    maximum: 25000000
> +
> +  oa-tc6:
> +    $ref: oa-tc6.yaml#
> +    unevaluatedProperties: true

This must be false.

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - pinctrl-names
> +  - pinctrl-0
> +  - interrupts
> +  - interrupt-parent
> +  - local-mac-address
> +  - spi-max-frequency
> +  - oa-tc6
> +
> +additionalProperties: false

Instead:
unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ethernet@0 {
> +        compatible = "microchip,lan865x";
> +        reg = <0>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&eth0_pins>;
> +        interrupt-parent = <&gpio>;
> +        interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
> +        local-mac-address = [04 05 06 01 02 03];
> +        spi-max-frequency = <15000000>;
> +        status = "okay";

Drop status.

> +        oa-tc6 {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          oa-cps = <64>;
> +          oa-txcte;
> +	  oa_rxcte;
> +	  oa-prote;
> +	  oa-dprac;

Again totally mixed up indentation.

> +        };
> +      };
> +    };

Best regards,
Krzysztof


