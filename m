Return-Path: <netdev+bounces-48375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF217EE2DF
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907B61F2705D
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E244328C5;
	Thu, 16 Nov 2023 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pafVVW2S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23BF196
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 06:31:44 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6707401e1edso4571086d6.1
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 06:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700145104; x=1700749904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ze34MzP6ZzMJQHTOgbQ+ZaBo2IhiBlOffFMR4boWctc=;
        b=pafVVW2Szad6C4pwuc5xf2rxCWR92qX0kCif6h3VDlJfmj7vweBt92h+Ixx/lYIc1e
         P+r452sBzPYGwxXiyl3Nm0vgesWwXmNxGObFPd6ejFq3Bi902pi64OkfzDXXStjVix/3
         wm2JvMRuoS6jjtRqwFNw6OYED9d6h1Ejuv+8Gt/37bVSpRqgFXJtP6p4Td9AkPBw/v6A
         F/gAyyGsN8l0YwOptwzqxF8cPXLKAMPE0lKAqH784gjZH9ma2i4CqqvM8nQxWOM/HW40
         OhI3Q3JbS0C/0aFUxizEnpYVkKIfKqB/TAm29P09yXg9uZaYZJQwz64/uYAN4lTu83YG
         3Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700145104; x=1700749904;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze34MzP6ZzMJQHTOgbQ+ZaBo2IhiBlOffFMR4boWctc=;
        b=Wc6HeJG7i7vNq4NMkuMLQ3A/BFWjRvOaIScyVmeq9q+1KpuhSf3doDGkop9kPIwK88
         WPhgFxrLWsfIJroTWCC7fJTT8dgazYn7a5TOMepjGnSojL1Mp8tsja4JxwG1B9Hgvix7
         rLWkfkPSSkeXlULFKcmjM1wr81RiR5WEVS2HLWJmDJC+K8YnBUIGSY/qF8PeCtVhT9fh
         oaYAdpCGXv1RRVwbShGoAw7idoQZyS5rxoys/KFrlD+G8wtV4xEHxRWrwbJZDp+HX936
         MGdSRmi0sxJvhJSZiYw5AQcVUWJk6Yb8Ho5KOI5eWGxwBqGHnye4kqnk6u3hn5HOoKOE
         2MPg==
X-Gm-Message-State: AOJu0YwQ+HX00WnAFGQ2wEzeXnv0Lh7fMlk9ZgB7jTD9KxewwyZw/eGo
	N7UhJqCoU/eaOuRoK+11ynh9yA==
X-Google-Smtp-Source: AGHT+IERuHXTJmKC9tmJtPGJkbsVbQWeftwOI0w7HvRGFXG9ymG+DUtOY7bCy0DxYQg3Lwha15fpcQ==
X-Received: by 2002:a05:6214:519a:b0:66f:ae60:8c51 with SMTP id kl26-20020a056214519a00b0066fae608c51mr10878210qvb.11.1700145104052;
        Thu, 16 Nov 2023 06:31:44 -0800 (PST)
Received: from [10.50.4.74] ([50.201.115.146])
        by smtp.gmail.com with ESMTPSA id jy8-20020a0562142b4800b0065d0d0c752csm1401427qvb.116.2023.11.16.06.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:31:43 -0800 (PST)
Message-ID: <6b39c522-1486-4e30-b958-b8a57104cede@linaro.org>
Date: Thu, 16 Nov 2023 15:31:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 8/9] dt-bindings: net: pse-pd: Add bindings for
 PD692x0 PSE controller
To: Kory Maincent <kory.maincent@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>,
 Russ Weight <russ.weight@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-8-be48044bf249@bootlin.com>
Content-Language: en-US
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
In-Reply-To: <20231116-feature_poe-v1-8-be48044bf249@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/11/2023 15:01, Kory Maincent wrote:
> Add the PD692x0 I2C Power Sourcing Equipment controller device tree
> bindings documentation.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  .../bindings/net/pse-pd/microchip,pd692x0_i2c.yaml | 70 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0_i2c.yaml b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0_i2c.yaml
> new file mode 100644
> index 000000000000..c42bbc427988
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0_i2c.yaml

Filename should match compatibles, so drop i2c suffix.

> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pse-pd/microchip,pd692x0_i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PD692x0 Power Sourcing Equipment controller
> +
> +maintainers:
> +  - Kory Maincent <kory.maincent@bootlin.com>
> +
> +allOf:
> +  - $ref: pse-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,pd69200
> +      - microchip,pd69210
> +      - microchip,pd69220

Your driver suggests these are compatible.

> +
> +  reg:
> +    maxItems: 1
> +
> +  '#pse-cells':
> +    const: 1
> +
> +  ports-matrix:
> +    description: Port conversion matrix configuration

I do not see such property defined anywhere. Your description should
explain what the purpose is and what it is exactly. Currently you just
repeat property name, so quite pointless.


> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    minItems: 1
> +    maxItems: 48
> +    items:
> +      items:
> +        - description: Logical port number
> +          minimum: 0
> +          maximum: 47
> +        - description: Physical port number A (0xff for undefined)
> +          oneOf:
> +            - minimum: 0
> +              maximum: 95
> +            - const: 0xff
> +        - description: Physical port number B (0xff for undefined)
> +          oneOf:
> +            - minimum: 0
> +              maximum: 95
> +            - const: 0xff
> +
> +additionalProperties: false

unevaluatedProperties: false instead

> +
> +required:
> +  - compatible
> +  - reg
> 

Best regards,
Krzysztof


