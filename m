Return-Path: <netdev+bounces-184446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26072A9592B
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B201760D3
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B38820FAB2;
	Mon, 21 Apr 2025 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv0RpuRU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37456BA4A;
	Mon, 21 Apr 2025 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274028; cv=none; b=mbyzPIdT42UmSg5HgGde7BzTruWG3C7mJ9xit0SnDY9WbBCuaFzAjMt6DBTujTtEAbMNs6MGThPLru+8bGh9FWnFAG18I/E3YdPM5qfCN79ixkx1/XLv6rvZHLnzy5TbHuR53pPSy7DW0iMVzT4cwM5QqmTYeTjrrL7gypQ0iyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274028; c=relaxed/simple;
	bh=Dlk2kizodiJSpWj38CgCmp8e9t/53aVYjJzM1ShlIZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQ/rWdKjfdMe4+cQapD+QxdizwDmwiii9MO7jntqq6/muD80iOl9vx+p9a8P4e6YttwBVLgPU9CwKTvjL3Q0RW65CnPNX7VVjgQH0MfXRWs6YHBcIURNde7CXJEjntHuNX/rZJOwxam3cfEwtxYqeq77byeeZAPjXFff5L68u6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv0RpuRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E5DC4CEE4;
	Mon, 21 Apr 2025 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274027;
	bh=Dlk2kizodiJSpWj38CgCmp8e9t/53aVYjJzM1ShlIZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rv0RpuRUEeZRiX6bijYPzFedpo0g7rL8/nRQBAxmgwGkOake7QNYqwE1aBUg1tqzv
	 dOoIF2quCoa+snIjRSHuN4R8z7ykr6UB4z8KyTCz0WbUMhoEVRDweAOk4pakQJu+aR
	 y/ciSnGQlp2/l5JIYwliUpSKRAb2ihEaMX3ztMW7xVBtUWHx+96a8PtFVh0gbGALOM
	 AcKey8Bbvsayca1qYI3TsrKrpmQJ7UYIQDg/9pJv2LDXWKHNzHdUgOM1ijexxOC4dL
	 d2WBBgdUzHCdFMRtjFOATtTxHUBCnj66dzwbNuAO/5/ZyJ9wWjWu44TJ8UNu9O5mF/
	 ee0XO3TbwfuGA==
Date: Mon, 21 Apr 2025 17:20:25 -0500
From: Rob Herring <robh@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 net-next 1/8] dt-bindings: dpll: Add device tree
 bindings for DPLL device and pin
Message-ID: <20250421222025.GA3015001-robh@kernel.org>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416162144.670760-2-ivecera@redhat.com>

On Wed, Apr 16, 2025 at 06:21:37PM +0200, Ivan Vecera wrote:
> Add a common DT schema for DPLL device and associated pin.
> The DPLL (device phase-locked loop) is a device used for precise clock
> synchronization in networking and telecom hardware.

In the subject, drop 'device tree binding for'. You already said that 
with 'dt-bindings'.

> 
> The device itself is equipped with one or more DPLLs (channels) and
> one or more physical input and output pins.
> 
> Each DPLL channel is used either to provide pulse-per-clock signal or
> to drive ethernet equipment clock.
> 
> The input and output pins have a label (specifies board label),
> type (specifies its usage depending on wiring), list of supported
> or allowed frequencies (depending on how the pin is connected and
> where) and can support embedded sync capability.

Convince me this is something generic... Some example parts or 
datasheets would help. For example, wouldn't these devices have 1 or 
more power supplies or a reset line?

> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
> v1->v3:
> * rewritten description for both device and pin
> * dropped num-dplls property
> * supported-frequencies property renamed to supported-frequencies-hz
> ---
>  .../devicetree/bindings/dpll/dpll-device.yaml | 76 +++++++++++++++++++
>  .../devicetree/bindings/dpll/dpll-pin.yaml    | 44 +++++++++++
>  MAINTAINERS                                   |  2 +
>  3 files changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
>  create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> new file mode 100644
> index 0000000000000..11a02b74e28b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> @@ -0,0 +1,76 @@
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
> +description:
> +  Digital Phase-Locked Loop (DPLL) device is used for precise clock
> +  synchronization in networking and telecom hardware. The device can
> +  have one or more channels (DPLLs) and one or more physical input and
> +  output pins. Each DPLL channel can either produce pulse-per-clock signal
> +  or drive ethernet equipment clock. The type of each channel can be
> +  indicated by dpll-types property.
> +
> +properties:
> +  $nodename:
> +    pattern: "^dpll(@.*)?$"

There's no 'reg' property, so you can't ever have a unit-address. I 
suppose you can have more than 1, so you need a '-[0-9]+' suffix.

> +
> +  "#address-cells":
> +    const: 0
> +
> +  "#size-cells":
> +    const: 0
> +
> +  dpll-types:
> +    description: List of DPLL channel types, one per DPLL instance.
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    items:
> +      enum: [pps, eec]
> +
> +  input-pins:
> +    type: object
> +    description: DPLL input pins
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

Unit-addresses are generally hex.

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
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/dpll/dpll-pin.yaml b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
> new file mode 100644
> index 0000000000000..44af3a4398a5f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
> @@ -0,0 +1,44 @@
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
> +  The DPLL pin is either a physical input or output pin that is provided
> +  by a DPLL( Digital Phase-Locked Loop) device. The pin is identified by
> +  its physical order number that is stored in reg property and can have
> +  an additional set of properties like supported (allowed) frequencies,
> +  label, type and may support embedded sync.

blank line here if this is a separate paragraph:

> +  Note that the pin in this context has nothing to do with pinctrl.
> +
> +properties:
> +  reg:
> +    description: Hardware index of the DPLL pin.
> +    $ref: /schemas/types.yaml#/definitions/uint32

'reg' already has a type. You need to say how many entries (i.e. 
'maxItems: 1')

> +
> +  esync-control:
> +    description: Indicates whether the pin supports embedded sync functionality.
> +    type: boolean
> +
> +  label:
> +    description: String exposed as the pin board label
> +    $ref: /schemas/types.yaml#/definitions/string
> +
> +  supported-frequencies-hz:
> +    description: List of supported frequencies for this pin, expressed in Hz.
> +
> +  type:

'type' is too generic of a property name.

> +    description: Type of the pin
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ext, gnss, int, mux, synce]
> +
> +required:
> +  - reg
> +
> +additionalProperties: false
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1248443035f43..f645ef38d2224 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7187,6 +7187,8 @@ M:	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>  M:	Jiri Pirko <jiri@resnulli.us>
>  L:	netdev@vger.kernel.org
>  S:	Supported
> +F:	Documentation/devicetree/bindings/dpll/dpll-device.yaml
> +F:	Documentation/devicetree/bindings/dpll/dpll-pin.yaml
>  F:	Documentation/driver-api/dpll.rst
>  F:	drivers/dpll/*
>  F:	include/linux/dpll.h
> -- 
> 2.48.1
> 

