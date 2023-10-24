Return-Path: <netdev+bounces-43753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9667D48D9
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 09:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C417B20E77
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 07:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F5F14AAF;
	Tue, 24 Oct 2023 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iE9JU0nx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1A114A92
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 07:44:12 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A1DE8
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 00:44:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c3c8adb27so586567866b.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 00:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698133448; x=1698738248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WVYOASIzuBFwi1QKSZbJjKhuUaXTStfsDMB+e6q2nnY=;
        b=iE9JU0nxRBMhkJ7kU6gDKtYFd19Tm4TXjOnY7lx6qFNjJwFKdYt+dZxjwoKYAptEJr
         1Z7uNRA/dzwqfFN/L90LnONf4t64OmsfHAswuVWGKXyYzxP961rQWgvIwIYsK5/yX1K7
         EHxSSr0fmxI/BWSvNRQg+hL1nN0Epht4ID5Y6uPsApJz5GW1S7fJ+tz2VnCxFiPYU3U7
         iexYB5Tfi5HlxpSvgiGGGLGgTqWfvNxJc0fz8aVOPjxOQ3grFObyPlVmQONv9ADgjQs6
         tKws5wZ+f2LxD8JdZPBV5PN2XSYojeMS+oj1YWcx+UtBS0Om9ZoAGSpwM9RN85uOZs6E
         rjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698133448; x=1698738248;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVYOASIzuBFwi1QKSZbJjKhuUaXTStfsDMB+e6q2nnY=;
        b=XkMbais4Zf5CceEjCekbMd7eYs7D/+nHu1NBAuJ4s8cnMKdpn1xpWToVUFuCg36cg6
         pdmWfJi4BQUq0clIJJwKAtsD/qM3aiPghSaVuyaPQsD4qnMn1LOKyfDK0xdoXFfQY2aM
         4t/4vY44Hmr1ERUPOIDmJeqDR3xOnEXrOlr+G9YKr1qEr8nMyuwHwQ8z5h4bz0076M5R
         aUPzcEJSK+To/PPKNNZtUHpa2gWy323/s4eo5aFVlhpRdVyfZirdUr3PBruNMJQ+hcQU
         LIXDp/bgxwu0rZc2lBEU3znM4pZHm92wPxhZFhqwcBuInn2bkHP+GrxONrW8HqKW7yNC
         emLQ==
X-Gm-Message-State: AOJu0YyLCag6E6CCiG1aMgtLa9NuNRoQgzt3fkcazBn69J7T+/Xmiiwe
	B5odzi6GstAc+EK1h3CCzT1HPw==
X-Google-Smtp-Source: AGHT+IGQvoCfOIWz1cYhl/5uGXpvVsy/kTAD3TJhvpApW36moJG1M+i7L+yv28Xs600nYHlierB77w==
X-Received: by 2002:a17:907:9302:b0:9bf:f20:876d with SMTP id bu2-20020a170907930200b009bf0f20876dmr8432467ejc.75.1698133448052;
        Tue, 24 Oct 2023 00:44:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id e27-20020a170906749b00b0097404f4a124sm7850389ejl.2.2023.10.24.00.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 00:44:07 -0700 (PDT)
Message-ID: <478c0e7e-bdff-41af-a12f-f9930f1c665a@linaro.org>
Date: Tue, 24 Oct 2023 09:44:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/9] dt-bindings: net: add OPEN Alliance
 10BASE-T1x MAC-PHY Serial Interface
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
 <20231023154649.45931-5-Parthiban.Veerasooran@microchip.com>
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
In-Reply-To: <20231023154649.45931-5-Parthiban.Veerasooran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/10/2023 17:46, Parthiban Veerasooran wrote:
> Add DT bindings OPEN Alliance 10BASE-T1x MACPHY Serial Interface
> parameters. These are generic properties that can apply to any 10BASE-T1x
> MAC-PHY which uses OPEN Alliance TC6 specification.

Except that it was not tested at all few more issues.

> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  .../devicetree/bindings/net/oa-tc6.yaml       | 72 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/oa-tc6.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/oa-tc6.yaml b/Documentation/devicetree/bindings/net/oa-tc6.yaml
> new file mode 100644
> index 000000000000..9f442fa6cace
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/oa-tc6.yaml

Filename based on compatible.

> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/oa-tc6.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OPEN Alliance 10BASE-T1x MAC-PHY Specification Common Properties
> +
> +maintainers:
> +  - Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
> +
> +description:
> +  These are generic properties that can apply to any 10BASE-T1x MAC-PHY
> +  which uses OPEN Alliance TC6 specification.
> +
> +  10BASE-T1x MAC-PHY Serial Interface Specification can be found at:
> +    https://opensig.org/about/specifications/
> +
> +properties:
> +  $nodename:
> +    pattern: "^oa-tc6(@.*)?"

Drop

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

Why?

> +
> +  oa-cps:
> +    maxItems: 1
> +    description:
> +      Chunk Payload Size. Configures the data chunk payload size to 2^N,
> +      where N is the value of this bitfield. The minimum possible data
> +      chunk payload size is 8 bytes or N = 3. The default data chunk
> +      payload size is 64 bytes, or N = 6. The minimum supported data chunk
> +      payload size for this MAC-PHY device is indicated in the CPSMIN
> +      field of the CAPABILITY register. Valid values for this parameter
> +      are 8, 16, 32 and 64. All other values are reserved.
> +
> +  oa-txcte:
> +    maxItems: 1
> +    description:
> +      Transmit Cut-Through Enable. When supported by this MAC-PHY device,
> +      this bit enables the cut-through mode of frame transfer through the
> +      MAC-PHY device from the SPI host to the network.
> +
> +  oa-rxcte:
> +    maxItems: 1
> +    description:
> +      Receive Cut-Through Enable. When supported by this MAC-PHY device,
> +      this bit enables the cut-through mode of frame transfer through the
> +      MAC-PHY device from the network to the SPI host.
> +
> +  oa-prote:
> +    maxItems: 1
> +    description:
> +      Control data read/write Protection Enable. When set, all control
> +      data written to and read from the MAC-PHY will be transferred with
> +      its complement for detection of bit errors.
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    oa-tc6 {
> +        #address-cells = <1>;
> +	#size-cells = <0>;

That's some total mess in indentation.

> +	oa-cps = <64>;
> +	oa-txcte;
> +	oa-rxcte;
> +	oa-prote;
> +    };
Best regards,
Krzysztof


