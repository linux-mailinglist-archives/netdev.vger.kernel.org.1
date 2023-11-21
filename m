Return-Path: <netdev+bounces-49556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0A67F267E
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 08:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683DB1C20F31
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 07:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A5F30675;
	Tue, 21 Nov 2023 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jqEEDPya"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8730512E
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 23:39:59 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50aabfa1b75so2827578e87.3
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 23:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700552398; x=1701157198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FdPdCCCHELZuZbE+Nx/X7BcWbDYhnSVo4Jlo0Z3ZPDU=;
        b=jqEEDPyamswyc/BHS2vnewRBmTbPf5qDH1yNxTV0MjBtY6Lck/xjPwyNBkvwEI66vE
         DlOGYqX5wmMf9P+xmhtZz8k+NvnyoPWmLdG0Oa/jW5VrU73kA9OC4qRv8xEVh5FXudkA
         5mdzY+XrjDRESBnkBHLflBgA8QKPVq10Hvo3mgHXP7FkSxMWOgeQujOWv8VB/Cvyh5bO
         Ij1f5FXG8MJCkQ9eL+Vew+nmukUxgWzZdLB2338wCgqy1nBQyeIOyxN3UuIj+CYTZY+v
         8XlpWS8uykiGWtC7iwtbP5AorKwV1sV86k5bl8QRLV3fN1cowxRZQCEidCoLBOJW6v99
         ChXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700552398; x=1701157198;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdPdCCCHELZuZbE+Nx/X7BcWbDYhnSVo4Jlo0Z3ZPDU=;
        b=YZuuc/kLIt2z/RGssC/QWd4bAkl+W1/hO93jw6cuNNMZHLQmYGKnj0UUBfsvzYocHu
         BctIOqWg3oAl8kyzKa+9mMDKGkyV1zJSlAXmgxtmFJh6LiOHdGn/fcL8eMBJHMEwd6iA
         XT4sLvQ/xTByduM/rZmIH0XKIcQ6HBB5k5618M+6MpDyWL64vkPfxmENpbZqMIpHfkEK
         6R2dBphYp0Arj74lHCTdM5NJ1A2FLQrxIS7gLX7buKxH7Ua0s1saqsDUdNeVrp5llFBL
         UjG0ez1MN3ea0qkC88nD50b0HZ7tDWowGzLemMHfxugwgr07TUzZJaSNOKz0CYMqSfxQ
         3Paw==
X-Gm-Message-State: AOJu0YycCBcqdwFcGJsT9AG06TLIyCePeJEqF0PlePRM7zLt9y8Yt0uL
	j5s1sC6feJx4DyFmJKorDux7QA==
X-Google-Smtp-Source: AGHT+IEPHsZObDjx4bw5s0XBThPc/nHG46dXuW4hQgzNxNLedU3lmi9/YgNLlDQD3OCIXzKLH04FHw==
X-Received: by 2002:a05:6512:39c5:b0:50a:a940:2d81 with SMTP id k5-20020a05651239c500b0050aa9402d81mr7755021lfu.68.1700552397619;
        Mon, 20 Nov 2023 23:39:57 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id b15-20020a056000054f00b0031980294e9fsm13563542wrf.116.2023.11.20.23.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 23:39:57 -0800 (PST)
Message-ID: <c6e1461a-fd75-4525-8888-0ffef626b77e@linaro.org>
Date: Tue, 21 Nov 2023 08:39:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: clock: mediatek: add clock
 controllers of MT7988
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Jianhui Zhao <zhaojh329@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
 "Garmin.Chang" <Garmin.Chang@mediatek.com>,
 Edward-JW Yang <edward-jw.yang@mediatek.com>,
 Johnson Wang <johnson.wang@mediatek.com>, Sam Shih <sam.shih@mediatek.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 James Liao <jamesjj.liao@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
 netdev@vger.kernel.org
References: <b277c5f084ff35849efb8250510b2536053d1316.1700498124.git.daniel@makrotopia.org>
 <8a30ae45b55842bc04f57714c8e0a962f3288a67.1700498124.git.daniel@makrotopia.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <8a30ae45b55842bc04f57714c8e0a962f3288a67.1700498124.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/11/2023 18:18, Daniel Golle wrote:
> Add various clock controllers found in the MT7988 SoC to existing
> bindings (if applicable) and add files for the new ethwarp, mcusys
> and xfi-pll clock controllers not previously present in any SoC.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2:
>  * dropped unused labels
>  * add 'type: object' declaration for reset-controller found in new
>    ethwarp controller and represented as ti,syscon-reset
>  * rebase on top of
>    "dt-bindings: arm: mediatek: move ethsys controller & convert to DT schema"
> 
>  .../arm/mediatek/mediatek,infracfg.yaml       |  1 +
>  .../arm/mediatek/mediatek,mt7988-ethwarp.yaml | 61 +++++++++++++++++++
>  .../arm/mediatek/mediatek,mt7988-mcusys.yaml  | 46 ++++++++++++++
>  .../arm/mediatek/mediatek,mt7988-xfi-pll.yaml | 49 +++++++++++++++
>  .../bindings/clock/mediatek,apmixedsys.yaml   |  1 +
>  .../bindings/clock/mediatek,ethsys.yaml       |  1 +
>  .../bindings/clock/mediatek,topckgen.yaml     |  1 +
>  .../bindings/net/pcs/mediatek,sgmiisys.yaml   |  2 +
>  8 files changed, 162 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-ethwarp.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-mcusys.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-xfi-pll.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
> index ea98043c6ba3d..230b5188a88db 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
> @@ -30,6 +30,7 @@ properties:
>                - mediatek,mt7629-infracfg
>                - mediatek,mt7981-infracfg
>                - mediatek,mt7986-infracfg
> +              - mediatek,mt7988-infracfg
>                - mediatek,mt8135-infracfg
>                - mediatek,mt8167-infracfg
>                - mediatek,mt8173-infracfg
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-ethwarp.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-ethwarp.yaml
> new file mode 100644
> index 0000000000000..5b988efe0cb74
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-ethwarp.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt7988-ethwarp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT7988 ethwarp Controller
> +
> +maintainers:
> +  - Daniel Golle <daniel@makrotopia.org>
> +
> +description:
> +  The Mediatek MT7988 ethwarp controller provides clocks and resets for the
> +  Ethernet related subsystems found the MT7988 SoC.

Clock controller bindings should be placed in clocks. Definitely not in arm.

> +  The reset-controller can be represented using the ti,syscon-reset bindings.

? Why do you rely on TI properties? How is this relevant? Describe here
hardware, not bindings.

> +  The clock values can be found in <dt-bindings/clock/mt*-clk.h>.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt7988-ethwarp
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-controller:
> +    type: object

Need $ref.

> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/reset/ti-syscon.h>
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clock-controller@15031000 {
> +            compatible = "mediatek,mt7988-ethwarp", "syscon", "simple-mfd";
> +            reg = <0 0x15031000 0 0x1000>;
> +            #clock-cells = <1>;
> +
> +            reset-controller {
> +                compatible = "ti,syscon-reset";

??? You do not have TI.

> +                #reset-cells = <1>;
> +                ti,reset-bits = <
> +                    0x8 9 0x8 9 0 0 (ASSERT_SET | DEASSERT_CLEAR | STATUS_NONE)
> +                >;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-mcusys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-mcusys.yaml
> new file mode 100644
> index 0000000000000..b30bd13616875
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-mcusys.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt7988-mcusys.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT7988 MCU System Clock Controller
> +
> +maintainers:
> +  - Daniel Golle <daniel@makrotopia.org>
> +
> +description:
> +  The Mediatek mcusys controller provides ARM and bus clocks to the system.
> +  The clock values can be found in <dt-bindings/clock/mt*-clk.h>.

This binding looks like several other Mediatek bindings. Add it to some
existing binding instead.

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt7988-mcusys
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +

...


> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #define MT7988_TOPRGU_XFI_PLL_GRST              16

If you do not have header, use number directly.

> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        clock-controller@11f40000 {
> +            compatible = "mediatek,mt7988-xfi-pll";
> +            reg = <0 0x11f40000 0 0x1000>;
> +            resets = <&watchdog MT7988_TOPRGU_XFI_PLL_GRST>;
> +            #clock-cells = <1>;
> +        };
> +    };



Best regards,
Krzysztof


