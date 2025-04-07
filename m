Return-Path: <netdev+bounces-179821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ED9A7E93D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3F53B4EE2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0C92192E2;
	Mon,  7 Apr 2025 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DL1kOCSa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BF5214A7C;
	Mon,  7 Apr 2025 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744048893; cv=none; b=P6V3nddE9DgKoN9yORXIvFEAn8XZ2Pj1wLpjotEY6bhEmOttFi1MdY3FUA9vuZ+Xons7PNrK4aayU0hVqD/a5QYVfRp0TT4CYhr6JKb+YsuyyygquDnv9MpMU6bzlkps7uwnvEx12AJ9SlKqaU6XI21SQsHhp6HcywB5YkbVNM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744048893; c=relaxed/simple;
	bh=AUXsGZjrzl+9uecU7aWyoMTviryGOEav0GotuZj779s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qhy1Wjj8fJupahN66QcRAltVX41E0RNhRXC2VGSLPdbQqvl9WAXAJtziiBZFd/iAynauCTF3umOPfTPJrCW36klU39aleZZy3AXvr/1gn6/ubPKwoDtceBb0by3R1hvgU/wghxpg69uKEthqdETuh4ka5Mvt0ClBkf2oX1T4eog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DL1kOCSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B72C4CEDD;
	Mon,  7 Apr 2025 18:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744048892;
	bh=AUXsGZjrzl+9uecU7aWyoMTviryGOEav0GotuZj779s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DL1kOCSad7g7MNV8DsE7AIC7tK4dQRwqxjyv4JZHCEr6rKczG77O6kU3eUTM3oBI6
	 JFkG4r+0MksLamtd+dr1/1qAOE7Eq9FzOIpxp9bQuolXrz/Hw8UiTZtTvoYoDysnMn
	 32lpDFOGsquZHgsSgsS5m6qe3wKiPrGsZyrgslyVICNYC82i0HC2czmCWzhX2+fbZ1
	 HPPrvV/lgsEIvKIudDkOso+vGACWt3RPbKkaaoa2uBVKanlACdv61sEdjQqbSQio9T
	 ucAAZbUWUvEMqCYBpqBP584bo21W4PNuf4cJ2io/+zDQsPNJgbNuMlbxLv0IdKwL0n
	 BQdr9RoG5iiJg==
Message-ID: <74172acd-e649-4613-a408-d1f61ceeba8b@kernel.org>
Date: Mon, 7 Apr 2025 20:01:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/28] dt-bindings: dpll: Add device tree bindings for
 DPLL device and pin
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250407172836.1009461-1-ivecera@redhat.com>
 <20250407173149.1010216-6-ivecera@redhat.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250407173149.1010216-6-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/04/2025 19:31, Ivan Vecera wrote:
> This adds DT bindings schema for DPLL (device phase-locked loop)

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

A nit, subject: drop second/last, redundant "device tree bindings for".
The "dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> device and associated pin. The schema follows existing DPLL core API

What is core API in terms of Devicetree?

> and should be used to expose information that should be provided
> by platform firmware.
> 
> The schema for DPLL device describe a DPLL chip that can contain
> one or more DPLLs (channels) and platform can specify their types.
> For now 'pps' and 'eec' types supported and these values are mapped
> to DPLL core's enums.

Describe entire hardware, not what is supported.

> 
> The DPLL device can have optionally 'input-pins' and 'output-pins'
> sub-nodes that contain pin sub-nodes.
> 
> These pin sub-nodes follows schema for dpll-pin and can contain
> information about the particular pin.

Describe the hardware, not the schema. We can read the contents of
patch. What we cannot read is the hardware and why you are making all
these choices.

> 
> The pin contains the following properties:
> * reg - pin HW index (physical pin number of given type)
> * label - string that is used as board label by DPLL core
> * type - string that indicates pin type (mapped to DPLL core pin type)
> * esync-control - boolean that indicates whether embeddded sync control
>                   is allowed for this pin
> * supported-frequencies - list of 64bit values that represents frequencies
>                           that are allowed to be configured for the pin

Drop. Describe the hardware.


> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>

Did this really happen?

> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  .../devicetree/bindings/dpll/dpll-device.yaml | 84 +++++++++++++++++++
>  .../devicetree/bindings/dpll/dpll-pin.yaml    | 43 ++++++++++
>  MAINTAINERS                                   |  2 +
>  3 files changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
>  create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml

Filenames matching compatibles... unless this is common schema, but
commit description did not mention it.

> 
> diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> new file mode 100644
> index 0000000000000..e6c309abb857f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dpll/dpll-device.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Digital Phase-Locked Loop (DPLL) Device
> +
> +maintainers:
> +  - Ivan Vecera <ivecera@redhat.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Digital Phase-Locked Loop (DPLL) device are used for precise clock
> +  synchronization in networking and telecom hardware. The device can
> +  have one or more channels (DPLLs) and one or more input and output
> +  pins. Each DPLL channel can either produce pulse-per-clock signal
> +  or drive ethernet equipment clock. The type of each channel is
> +  indicated by dpll-types property.
> +
> +properties:
> +  $nodename:
> +    pattern: "^dpll(@.*)?$"
> +
> +  "#address-cells":
> +    const: 0
> +
> +  "#size-cells":
> +    const: 0

Why do you need these cells?

> +
> +  num-dplls:
> +    description: Number of DPLL channels in this device.

Why this is not deducible from compatible?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +
> +  dpll-types:
> +    description: List of DPLL types, one per DPLL instance.
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    items:
> +      enum: [pps, eec]

Why this is not deducible from compatible?

> +
> +  input-pins:
> +    type: object
> +    description: DPLL input pins
> +    unevaluatedProperties: false

So this is all for pinctrl? Or something else? Could not figure out from
commit msg. This does not help me either.

> +
> +    properties:
> +      "#address-cells":
> +        const: 1

Why?

> +      "#size-cells":
> +        const: 0

Why? I don't see these being used.

> +
> +    patternProperties:
> +      "^pin@[0-9]+$":
> +        $ref: /schemas/dpll/dpll-pin.yaml
> +        unevaluatedProperties: false
> +
> +    required:
> +      - "#address-cells"
> +      - "#size-cells"
> +
> +  output-pins:
> +    type: object
> +    description: DPLL output pins
> +    unevaluatedProperties: false
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      "^pin@[0-9]+$":
> +        $ref: /schemas/dpll/dpll-pin.yaml
> +        unevaluatedProperties: false
> +
> +    required:
> +      - "#address-cells"
> +      - "#size-cells"
> +
> +dependentRequired:
> +  dpll-types: [ num-dplls ]
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/dpll/dpll-pin.yaml b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
> new file mode 100644
> index 0000000000000..9aea8ceabb5af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dpll/dpll-pin.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DPLL Pin
> +
> +maintainers:
> +  - Ivan Vecera <ivecera@redhat.com>
> +
> +description: |
> +  Schema for defining input and output pins of a Digital Phase-Locked Loop (DPLL).
> +  Each pin can have a set of supported frequencies, label, type and may support
> +  embedded sync.
> +
> +properties:
> +  reg:
> +    description: Hardware index of the pin.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  esync-control:
> +    description: Indicates whether the pin supports embedded sync functionality.
> +    type: boolean
> +
> +  label:
> +    description: String exposed as the pin board label
> +    $ref: /schemas/types.yaml#/definitions/string
> +
> +  supported-frequencies:
> +    description: List of supported frequencies for this pin, expressed in Hz.
> +    $ref: /schemas/types.yaml#/definitions/uint64-array

Use common property suffixes and drop ref.

> +
> +  type:
> +    description: Type of the pin
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ext, gnss, int, mux, synce]
> +
> +

Just one blank line


I bet that half of my questions could be answered with proper hardware
description which is missing in commit msg and binding description.
Instead your commit msg explains schema which makes no sense - I
mentioned, we can read the schema.
> +required:
> +  - reg
Best regards,
Krzysztof

