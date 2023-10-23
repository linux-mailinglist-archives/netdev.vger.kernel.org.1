Return-Path: <netdev+bounces-43555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5417D3DE8
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E745B20C23
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FF9210F2;
	Mon, 23 Oct 2023 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X/2caegp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC152210E9
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 17:37:37 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BAB94
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 10:37:36 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso547248266b.2
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698082654; x=1698687454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpIxc8lRkjmGHBrOrWkUutSpPEIyuqpJsUF79g+Yai8=;
        b=X/2caegpxNZNOcEnZTD1VqbE/++yQuOtxJuJgUs8PGdvlqcGEaTNNonU8W+WeBDmEQ
         JcCBi3tOQZ4wgNMLoJVgC/R9VGE4YNMdWbnzPzih5rY6GjtVdDhCW7yUC0Ji/8hfbFi2
         h60e++NbET6pXi2NXwmiIewfTXc87UzdIdDq7yXx/mnI0X2sMfI/+EtivGX+SIkxIEBQ
         bGZQyTMwS1ChBL9pnMLTiWk/AfDTo2AIF2Gz8bnHI0/JGrnV4VZJOpyiiUq0gr+zHqs8
         S1XLziFEm/WikOVzKKcz4O6EmXi2uVcoBVOJ/fIzFpHiRQsa8XJEDETeJc6aEU1jXQLa
         8BRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082654; x=1698687454;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpIxc8lRkjmGHBrOrWkUutSpPEIyuqpJsUF79g+Yai8=;
        b=OVtppCZxlKM25BHwffd2SCam1pBtgx9z/c2jSeg+QlY9HBTB9Yfm905BKeFJNDqu7Z
         smh6h4mS2qGbGNOm7Okfe/BcEmvF0tEmUGYv8cXShp9ETgppWJKOKhQhhvEdnB2abQIU
         KFzm4Yc3Au8TeEDXW00OEH/56ifCeNTqgtaKDdkjRyCQgnS1gmzwWbNpoFvGiOdpD/ML
         tDSknmK5v5skCGVdhOPfkns9vDMqZtIdWkHYv4tlDkuaRdQwd1ZpdjoYkkIFQ6Gb+bKd
         nw7q1P5xAXb2bF3YDrBVxHjLSfIRe1eadfe2/JzUpCrNZxlN+X+rtZdmWBmpZrsaYdMM
         bXTQ==
X-Gm-Message-State: AOJu0YyYGIvnes8X/D6kz1qJLp1+AKtmEXIlIKpqkQDpJDMD8SjfV0z2
	OflHv0HoLgD2hcNqRef/FknPTg==
X-Google-Smtp-Source: AGHT+IHidXufr99BQROxxi52qKHN2SrRZZW3iTTaRWOviu76uWx6FNOrVRKkBZbn8xpDn1uAO5YmAg==
X-Received: by 2002:a17:907:c386:b0:9c7:fd91:4309 with SMTP id tm6-20020a170907c38600b009c7fd914309mr4570701ejc.0.1698082653885;
        Mon, 23 Oct 2023 10:37:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id k17-20020a1709063e1100b009b2cc87b8c3sm6940519eji.52.2023.10.23.10.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 10:37:33 -0700 (PDT)
Message-ID: <81d7b86e-aee2-4222-8c7a-52d0b710a2f2@linaro.org>
Date: Mon, 23 Oct 2023 19:37:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: dt-bindings: Introduce the Qualcomm
 IPQESS Ethernet switch
Content-Language: en-US
To: Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Luka Perkov <luka.perkov@sartura.hr>, Robert Marko
 <robert.marko@sartura.hr>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20231023155013.512999-1-romain.gantois@bootlin.com>
 <20231023155013.512999-2-romain.gantois@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231023155013.512999-2-romain.gantois@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/10/2023 17:50, Romain Gantois wrote:
> Add the DT binding for the IPQESS Ethernet switch subsystem, that
> integrates a modified QCA8K switch and an EDMA MAC controller. It inherits
> from a basic ethernet switch binding and adds three regmaps, a phandle and
> reset line for the PSGMII, a phandle to the MDIO bus, a clock, and 32
> interrupts.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  .../bindings/net/qcom,ipq4019-ess.yaml        | 152 ++++++++++++++++++
>  1 file changed, 152 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/qcom,ipq4019-ess.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-ess.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-ess.yaml
> new file mode 100644
> index 000000000000..9bb6b010ea6a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-ess.yaml
> @@ -0,0 +1,152 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/qcom,ipq4019-ess.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm IPQ4019 Ethernet switch subsystem driver

Bindings should be about hardware. Please drop "driver". "Subsystem"
also sounds like Linuxism.

> +
> +maintainers:
> +  - Romain Gantois <romain.gantois@bootlin.com>
> +
> +$ref: ethernet-switch.yaml#
> +
> +properties:
> +  compatible:
> +    const: qca,ipq4019-qca8337n


What do you want to express here? ipq4019 is not qca. This is Qualcomm
(so qcom) SoC.

> +
> +  reg:
> +    maxItems: 3
> +    description: Base ESS registers, PSGMII registers and EDMA registers

You need to describe the items, so:
items:
 - description: foo
 - description: foo
 - description: foo

> +
> +  reg-names:
> +    maxItems: 3

You need to list items instead.

> +
> +  resets:
> +    maxItems: 2
> +    description: Handles to the PSGMII and ESS reset lines

You need to list items instead.

> +
> +  reset-names:
> +    maxItems: 2

You need to list items instead.


> +
> +  clocks:
> +    maxItems: 1
> +    description: Handle to the GCC ESS clock
> +
> +  clock-names:
> +    maxItems: 1

Drop clock-names, useless for one entry.

> +
> +  psgmii-ethphy:
> +    maxItems: 1
> +    description: Handle to the MDIO bus node corresponding to the PSGMII

That's a bit odd property. Where is it defined?

> +
> +  mdio:
> +    maxItems: 1
> +    description: Handle to the IPQ4019 MDIO Controller
> +
> +  interrupts:
> +    maxItems: 32
> +    description: One interrupt per tx and rx queue, the first 16 are rx queues
> +                 and the last 16 are the tx queues
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - resets
> +  - reset-names
> +  - clocks
> +  - clock-names
> +  - mdio
> +  - interrupts
> +
> +unevaluatedProperties: false


Best regards,
Krzysztof


