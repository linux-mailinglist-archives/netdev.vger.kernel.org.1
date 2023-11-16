Return-Path: <netdev+bounces-48317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE4A7EE09E
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FB4EB20B29
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 12:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63E42FE16;
	Thu, 16 Nov 2023 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kkh3CDwx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4730319B
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 04:22:13 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-677a0ac3797so3923786d6.1
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 04:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700137332; x=1700742132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XL1Z/QpFliLdzdX0taXYAxayrOcSdxeyem6XYBHhdFM=;
        b=kkh3CDwxG3IjCr7knMbwRieTx7+tsl1Ew4BSnQ+eTMbts37lY57y0IyB1qUopb6QwO
         NO6EACnMDMa7rhaBuLztgo5qIU+PEUome0IKqSY7vodZN9GtkkPGaiYNPHtsaP2l9H6P
         YxPs1dww0GQBEwX6GEW46RJbSvCDkJNJ/zvc0c0CRCntIhBEtsgvbclBGWbats6GeHH9
         mW8tFxgxhY1UyNEta+efr0dygyLOJbcWoduEumZv+x+Zr1DmzQzIIqbna3LWE2os7ncy
         AIHj+jFYdsZjl+Fs6K7Tm2quVJEeMBHFr6szb5BJMMP4rR/WV7CDDZehYm5LvjWXtbPR
         XuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700137332; x=1700742132;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XL1Z/QpFliLdzdX0taXYAxayrOcSdxeyem6XYBHhdFM=;
        b=paA4it/hGlJiTkGfQaJLrPNCKA/L5RyxXs7uX3GqSy6uH/iHJpAwE+FeJ2Da9ONQOs
         qXZ4ZamPm9p8/I5AccwSQAZiOrmGujXrhu+LlfvJHHvniabks9Ldg2meaFsqWrfnY1Or
         vfv4aInE7TRGJ2V4m06XSalihNOBAdF7nvEIfplOm2vspJbeB6tqnkSs/Rl8brHXozqz
         S6lzlRC/hrmXyCe8v4IDcpOBj5wSAB5sRnViL0ik+KmLZLdJwqymHk2nq+wIE2XxXhrF
         wYcBW3ZkBBjM9JBHes1ftN7FEiYPuvXrrJEadFEntWE6efPOj9hLKnwbZ1+d76uSGqwO
         xfvA==
X-Gm-Message-State: AOJu0YwAF3NVgN2Bc2kI4Ixf8BDyq0q13mU4TXGElRFMAWeeXUPQdWfx
	jPbV3SoL5fKpuHrSLUhaq6fuPQ==
X-Google-Smtp-Source: AGHT+IGDJN1VhusBzDBHuieitjUTsvdFyfwMpBWQ77RuX11KQU8NdaGeOMUxH5NKplk9CP/XYKgL1Q==
X-Received: by 2002:ad4:4ea5:0:b0:66c:ffe1:e244 with SMTP id ed5-20020ad44ea5000000b0066cffe1e244mr11627741qvb.62.1700137332397;
        Thu, 16 Nov 2023 04:22:12 -0800 (PST)
Received: from [192.168.212.13] ([12.191.197.195])
        by smtp.gmail.com with ESMTPSA id g2-20020a0ce742000000b0066d1bae2326sm1335363qvn.57.2023.11.16.04.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 04:22:11 -0800 (PST)
Message-ID: <c8f721b5-4f66-4e38-b8ab-ee71b55c1a32@linaro.org>
Date: Thu, 16 Nov 2023 13:22:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/8] dt-bindings: net: Introduce the Qualcomm
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
 Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com>
 <20231114105600.1012056-2-romain.gantois@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231114105600.1012056-2-romain.gantois@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/11/2023 11:55, Romain Gantois wrote:
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
> index 000000000000..85dff85e50b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-ess.yaml
> @@ -0,0 +1,152 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/qcom,ipq4019-ess.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm IPQ4019 Ethernet Switch Subsystem
> +
> +maintainers:
> +  - Romain Gantois <romain.gantois@bootlin.com>
> +
> +$ref: ethernet-switch.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,ipq4019-ess
> +
> +  reg:
> +    items:
> +      - description: Base ESS registers, which configure the integrated QCA8K switch.
> +      - description: ESS PSGMII-related registers, which control VCO calibration and link
> +                     modes.
> +      - description: ESS EDMA controller registers. The EDMA controller is an Ethernet
> +                     controller connected to the integrated switch's CPU port.

Blank line

> +  reg-names:
> +    items:
> +      - const: base
> +      - const: psgmii_phy
> +      - const: edma
> +
> +  resets:
> +    items:
> +      - description: Handle to the PSGMII reset line.

Don't describe Devicetree, so handle (assuming you speak about phandle)
is redundant, so:
PSGMII reset line

If it is some other handle, please explain.

But then isn't PSGMII reset property of MDIO or PHY? It looks like you
add here properties from the PHY...

> +      - description: Handle to the ESS reset line.

ESS reset line


> +
> +  reset-names:
> +    items:
> +      - const: psgmii
> +      - const: ess
> +
> +  clocks:
> +    maxItems: 1
> +    description: Handle to the GCC ESS clock

Drop description.

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

Best regards,
Krzysztof


