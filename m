Return-Path: <netdev+bounces-34743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A90A67A5421
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B6B1C2105E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95C62869F;
	Mon, 18 Sep 2023 20:28:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE7F28686;
	Mon, 18 Sep 2023 20:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D942FC433C8;
	Mon, 18 Sep 2023 20:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695068931;
	bh=pUlBBuz1FK2J0cyfaQ4KvrItSJbWh9d+uorfnqujgLI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=L7UXMY1k5WmTCEz3nJJH5T79ESygRsChx6oSvJiO5+j6bg/BaSUmONosJP7oJsJt8
	 0d1wogo6meA3o4KKhq4ocspMuc1nK0WHf+g3qyCQbJYXJBr1RuL0b+D8XRrAhdDX+H
	 JNhKCCJIR3ouQCF6YXBoCZZjkpH5xi7NQchu+uQmxf9WnpAQcSjiiv0IyrkkiGUxbO
	 Nn5giMTbLxNvRNb4pWZn7cU+yYj+pto3gAHZRnEtqWsCCcDZb0t3U3gLd0FXCSrR72
	 4u4z76lOj7aRqVy1V5hEuUOpEDGrB+Ud2JU6H8ZNdoBKknw2rziHJEeoeSv/ddnlAs
	 YTigZMLrMFqhg==
Message-ID: <5194bd75-9562-8375-5748-ccce560b67cf@kernel.org>
Date: Mon, 18 Sep 2023 22:28:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] dt-bindings: net: Add onsemi NCN26010 ethernet
 controller
To: Jay Monkman <jtm@lopingdog.com>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Arndt Schuebel <Arndt.Schuebel@onsemi.com>
References: <ZQf1Mgb8lfHkB6rl@lopingdog.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <ZQf1Mgb8lfHkB6rl@lopingdog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2023 08:58, Jay Monkman wrote:
> 

Drop stray blank line.

> Add devicetree bindings for onsemi's NCN26010 10BASE-T1S
> ethernet controller.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC (and consider --no-git-fallback argument). It might
happen, that command when run on an older kernel, gives you outdated
entries. Therefore please be sure you base your patches on recent Linux
kernel.

> 
> Signed-off-by: Jay Monkman <jtm@lopingdog.com>
> ---
>  .../devicetree/bindings/net/onnn,macphy.yaml  | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/onnn,macphy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/onnn,macphy.yaml b/Documentation/devicetree/bindings/net/onnn,macphy.yaml
> new file mode 100644
> index 000000000000..1813da81b95f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/onnn,macphy.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/onnn,macphy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: onsemi 10BASE-T1S Ethernet Controller
> +
> +maintainers:
> +  - Jay Monkman <jtm@lopingdog.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Bindings for onsemi 10BASE-T1S ethernet controller.

Drop "bindings for" and instead describe the hardware.

> +
> +  Supported devices:
> +    ncn26010

Supported by what? By bindings? Or driver? Drop, instead, describe the
hardware.

> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: onnn,ncn26010
> +
> +  ctrl-protected:
> +    description: |

Do not need '|' unless you need to preserve formatting.

Is it a generic property? Does not look like. All non-standard
properties need vendor prefix.

> +      Enables control data read/write protection mode.

I don't understand this and it is very close to duplicate the property
name. Describe what it does in the hardware, not in the driver, so it
will be justified to have it in bindings in the first place.

> +    type: boolean
> +
> +  poll-interval:

Missing units.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Defines how often the MACPHY thread runs in milliseconds.

thread? So Linux kthread? Nope, not a bindings property.

> +      If not specified, a default value of 5 is used.
> +
> +  tx-fcs-calc:
> +    description: |
> +      Enables driver calculation of the FCS on transmitted frames.
> +    type: boolean

Driver? Not hardware? So drop the property.

> +
> +  rx-fcs-check:
> +    description: |
> +      Enables driver checking of the FCS on received frames
> +    type: boolean

Not a bindings property.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  mdio:
> +    $ref: mdio.yaml#
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible

Nothing else is required?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;

If this is a SPI device, then you miss spi-peripheral-props.

> +
> +      ethernet@0 {
> +        compatible = "onnn,ncn26010";
> +        reg = <0>; /* CE0 */

CE0? Isn't chip select obvious from the reg=0?


Best regards,
Krzysztof


