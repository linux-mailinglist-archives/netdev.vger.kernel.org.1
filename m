Return-Path: <netdev+bounces-57810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D03C8143E5
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EFF284121
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 08:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C699156E3;
	Fri, 15 Dec 2023 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eE9f1c1h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81911C83
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a1ceae92ab6so49100166b.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 00:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702630038; x=1703234838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4X2TbRDZyi/cqfvcJXvbOubzESHjoslHgG5U4+BcUyk=;
        b=eE9f1c1hcodQaYLIHHYA+oKgaYHRwx7uDI+yqX5jPcDHxXeOnvMVE4mhCVkSOHCoGK
         DtYDSO1f4viLQ9Scb50otba7MMidTQJQFWKG/JpFvaBjzlOWmmZntc0IqRVX7zzWyK5x
         j4sw1kh4tkNm5SP2l6h3bEaltszDmXfNTA9zY28MyCe9io/HIauTlFfmGVSh/VMK7AMK
         3amhg8VwXSmzau/Df3hcD8kWMWz62NKCfGd7K/g3Fqz1QJJIuh/cYlJVScoEj3yw/Z7A
         wIhgAFERyvdKdjt/oyzWKUWF/oC6G17+RUdsnNU/Vsc+c8/vrBE8qXGIgvPT+dJhQsw8
         lZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702630038; x=1703234838;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4X2TbRDZyi/cqfvcJXvbOubzESHjoslHgG5U4+BcUyk=;
        b=WUXarsHyWfrTCAVU+jchqE60AKpNc5mO5R+kQuaD1dDpyXt6sPkV3G+QlL9mNxPU8u
         bzQUB9EXIm0i9X0SXmgqbJyhtF00ZC+0YO6r9B3svCa5WjstuX5KK4ZkpACzROI9ST8x
         Wl5I9dxhlzvwjp9B9j0FQ84cxySWcd77jZChEzI8fuDHl8mL5lHhLuLBpH+rZgqcUJa5
         7U1mBSGV4nuFhxrgkXlhgter5OgSUCAbhUswGZ5oA+V+uQUYq2xqnmxyH13JP9NBtED1
         yWs06jj1WvV3qOoV2rJxU5PW7rBfKsyxA0ap1TN/x2jd6O6G6LJs6XF+vDv/IjmOJHIw
         iZ6A==
X-Gm-Message-State: AOJu0YxGEd8NhGq10NorXiYpgOAK0F6FvMaCKr2EXYlkX/wGbZAUJxDI
	jjwzsKeaQBPYDQn9+e8ZPJpU/1Vy27Eu73a8J5o=
X-Google-Smtp-Source: AGHT+IGpEU9yYlufXR4rjoH/r3nnzRoc7vaCeCeS2wNu6chy24htLqoGjO4eXuXFmWkvFuczdoovmg==
X-Received: by 2002:a17:907:7f87:b0:a17:8181:4f3 with SMTP id qk7-20020a1709077f8700b00a17818104f3mr6623646ejc.49.1702630038058;
        Fri, 15 Dec 2023 00:47:18 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id tx27-20020a1709078e9b00b00a1c85124b08sm10633350ejc.94.2023.12.15.00.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 00:47:17 -0800 (PST)
Message-ID: <777c33d6-49a6-47b5-8cdd-5e27c919c53b@linaro.org>
Date: Fri, 15 Dec 2023 09:47:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] dt-bindings: net: marvell10g: Document LED
 polarity
Content-Language: en-US
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux@armlinux.org.uk, kabel@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20231214201442.660447-1-tobias@waldekranz.com>
 <20231214201442.660447-5-tobias@waldekranz.com>
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
In-Reply-To: <20231214201442.660447-5-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/12/2023 21:14, Tobias Waldekranz wrote:
> Hardware supports multiple ways of driving attached LEDs, but this is
> not configurable via any sample-at-reset pins - rather it must be set
> via software.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  .../bindings/net/marvell,marvell10g.yaml      | 60 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/marvell,marvell10g.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/marvell,marvell10g.yaml b/Documentation/devicetree/bindings/net/marvell,marvell10g.yaml
> new file mode 100644
> index 000000000000..37ff7fdfdd3d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/marvell,marvell10g.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/marvell,marvell10g.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Alaska X 10G Ethernet PHY
> +
> +maintainers:
> +  - Tobias Waldekranz <tobias@waldekranz.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Bindings for Marvell Alaska X 10G Ethernet PHYs

Drop Bindings for and describe the hardware. You are repeating title, so
it is useless.

> +
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +
> +properties:

How is this schema selected/applied? I guess you have exactly the same
problem as recently talked about other ethernet PHY bindings.

See:
https://lore.kernel.org/linux-devicetree/20231209014828.28194-1-ansuelsmth@gmail.com/

> +  leds:
> +    type: object
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      '^led@[a-f0-9]+$':
> +        $ref: /schemas/leds/common.yaml#

Are you sure you need to repeat all this?

> +
> +        properties:
> +          marvell,polarity:
> +            description: |
> +              Electrical polarity and drive type for this LED. In the
> +              active state, hardware may drive the pin either low or
> +              high. In the inactive state, the pin can either be
> +              driven to the opposite logic level, or be tristated.
> +            $ref: /schemas/types.yaml#/definitions/string
> +            enum:
> +              - active-low
> +              - active-high
> +              - active-low-tristate
> +              - active-high-tristate
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-phy@0 {
> +            reg = <0>;
> +
> +            marvell,polarity = "active-low-tristate";

It is clearly visible here that your schema is an no-op. You do not
allow such property in the phy, but in leds!



Best regards,
Krzysztof


