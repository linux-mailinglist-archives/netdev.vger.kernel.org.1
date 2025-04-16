Return-Path: <netdev+bounces-183247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71870A8B73E
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAC61904C87
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B73235C1E;
	Wed, 16 Apr 2025 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtSK99+4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D4323373F;
	Wed, 16 Apr 2025 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744801116; cv=none; b=SVkcx+0msf/tHAhknONHGcD2YjGVWVqM7Lns+ICI8J6lR1q6ltFvogLC/KXrfjwmCxJnumGgfycjBri13xj+PXLC2n7oWrQZauZtoMOG8PlgRWRj+Nq6Pb35z8Sl0i7gH2jMsfynV4uWOnjF03dCgIAPURxb4UduP2vR/JxSEdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744801116; c=relaxed/simple;
	bh=YDggfJCVe0iNJ1cTW6lKqXnq2uK5KeICHftjS4x8iSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AePDweHrB/nXkGfxpKSkgMYpY2iuVHT0lutZ5eL7uyl3PWpiZ8/TMalZTJyQHKCH24CBOZ2vm2Zc8Sl6je4Z5erzb+RlUj1/wiLZXiITrQN6iU072PeA93ADMxLz6TrFSDjpZZfIA5PK4CwtuyGx54+J/efBqFumQ/1BBsi/0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtSK99+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1230EC4CEE2;
	Wed, 16 Apr 2025 10:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744801115;
	bh=YDggfJCVe0iNJ1cTW6lKqXnq2uK5KeICHftjS4x8iSY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=PtSK99+4eLD4FRVYjR0c1AYq2rH3yYYfFcv7kzf3p7NPAKUJJqn1MEJ48L0RCS/p8
	 EZ8RHhDOe0/shMEKY4urlDMwcGscxG3BRMXLMdp3xSwA9+k6G9hcJSluDyFTJGNRiM
	 xEt8Uus196SHw4pi7KeoUClg54M1Cy26E6R+9ZbyXUg4cKYbmbNK3CJFFHnSfr8FsH
	 7iU9Oz0Nnk/X0hxm/t5Zu8BJ/kILbts6+8JWO1ZqbuMtszHqYvwVgzp7ifEHdffaai
	 lzEPbrx2F30AfkNPAL7Nikk10ooC5oT7NsLiskZfCWFqnJ0odbzoGWyKp9l85KA5yr
	 Wl5c6aP6Yxyhw==
Message-ID: <ee0599ad-7f67-46fb-aa60-32a1dac21bd0@kernel.org>
Date: Wed, 16 Apr 2025 12:58:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: net: pse-pd: Add bindings for Si3474 PSE
 controller
To: Piotr Kubik <piotr.kubik@adtran.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <a92be603-7ad4-4dd3-b083-548658a4448a@adtran.com>
 <4ddf2ede-3f40-438d-bae4-6f8b1c25e5eb@adtran.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <4ddf2ede-3f40-438d-bae4-6f8b1c25e5eb@adtran.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/04/2025 12:47, Piotr Kubik wrote:
> From: Piotr Kubik <piotr.kubik@adtran.com>
> 
> Add the Si3474 I2C Power Sourcing Equipment controller device tree
> bindings documentation.
> 
> Signed-off-by: Piotr Kubik <piotr.kubik@adtran.com>
> ---
>  .../bindings/net/pse-pd/skyworks,si3474.yaml  | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/net/pse-pd/skyworks,si3474.yaml

Also looks like corrupted patch.

> 
> diff --git
> a/Documentation/devicetree/bindings/net/pse-pd/skyworks,si3474.yaml
> b/Documentation/devicetree/bindings/net/pse-pd/skyworks,si3474.yaml
> new file mode 100644
> index 000000000000..fd48eeb2f79b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pse-pd/skyworks,si3474.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pse-pd/skyworks,si3474.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Skyworks Si3474 Power Sourcing Equipment controller
> +
> +maintainers:
> +  - Kory Maincent <kory.maincent@bootlin.com>

This should be someone interested in this hardware, not subsystem
maintainer.

> +
> +allOf:
> +  - $ref: pse-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - skyworks,si347
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#pse-cells':
> +    const: 1
> +
> +  channels:
> +    description: Each Si3474 is divided into two quad PoE controllers
> +      accessible on different i2c addresses. Each set of quad ports can be
> +      assigned to two physical channels (currently 4p support only).

What this "currently" means? Limitation of hardware or Linux? If the
latter, then drop.

> +      This parameter describes the configuration of the ports conversion
> +      matrix that establishes relationship between the logical ports and
> +      the physical channels.
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      '^channel@[0-3]$':
> +        type: object
> +        additionalProperties: false
> +
> +        properties:
> +          reg:
> +            maxItems: 1
> +
> +        required:
> +          - reg
> +
> +    required:
> +      - "#address-cells"
> +      - "#size-cells"
> +
> +unevaluatedProperties: false

This goes after required: block.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ethernet-pse@26 {
> +        compatible = "skyworks,si3474";
> +        reg = <0x26>;
> +
> +        channels {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          phys0_0: channel@0 {
> +            reg = <0>;
> +          };
> +          phys0_1: channel@1 {
> +            reg = <1>;
> +          };
> +          phys0_2: channel@2 {
> +            reg = <2>;
> +          };
> +          phys0_3: channel@3 {
> +            reg = <3>;
> +          };
> +        };
> +        pse-pis {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          pse_pi2: pse-pi@2 {
> +            reg = <2>;
> +            #pse-cells = <0>;
> +            pairset-names = "alternative-a", "alternative-b";
> +            pairsets = <&phys0_0>, <&phys0_1>;
> +            polarity-supported = "MDI-X", "S";
> +            vpwr-supply = <&reg_pse>;
> +          };
> +          pse_pi3: pse-pi@3 {
> +            reg = <3>;
> +            #pse-cells = <0>;
> +            pairset-names = "alternative-a", "alternative-b";
> +            pairsets = <&phys0_2>, <&phys0_3>;
> +            polarity-supported = "MDI-X", "S";
> +            vpwr-supply = <&reg_pse>;
> +          };
> +        };
> +      };
> +
> +      ethernet-pse@27 {
> +        compatible = "skyworks,si3474";


This is the same as other example, so drop and keep only one.


Best regards,
Krzysztof

