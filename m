Return-Path: <netdev+bounces-195962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 225E4AD2E96
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38E73B1A3D
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 07:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EE927E7D9;
	Tue, 10 Jun 2025 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdJ99Gbl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADF922B8CB;
	Tue, 10 Jun 2025 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749540283; cv=none; b=a5w5T64sR80XZ2xpCiRNLowKynFPMgYdmfry18zi4OlXkXUWkImwDeR3IpdQMit0LHs4ygSZhBps8ylJFkwklnaPOorY0TN3oPeCGWd/5NfNeyccHR6rd9tEP7NISaZIMIcBKVVIsinncAGFYFMPtPY0waL5OvM9XqJm6SsOSlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749540283; c=relaxed/simple;
	bh=lc8UFtQQBjZAimb2twHYvmy8+mDtymOWgoS4qaJHG1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJVnT/FzSQvzd12zVZB7mB7FoD2XKsEGOHtnnQ0PKblQFqp2Nwq+MismI8pI8/QAHxA0W7FMMmuV55ppqgJyqevZfL5oqPGvU5/jGBq0JHsgK0TxxbCjm6d07xFfAEXiRWiHNLtGQ1CmVxQHO5joMFU9TFfCbv0u92kw9hLeipQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdJ99Gbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FC8C4CEEF;
	Tue, 10 Jun 2025 07:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749540282;
	bh=lc8UFtQQBjZAimb2twHYvmy8+mDtymOWgoS4qaJHG1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdJ99GblQqDmDeQjiQqHTN1/NuxDWFmZFZ/bda0ZG1QdUi3pBpQ5tXVbSn0D7f4kf
	 Xct4CyZAzfA2d2ivm0KkOm/dQXMQo8VUmhHSWH8EkPPQr7wSauBON4gRaE0f71sZu5
	 h0dkEvGY0o6YXF5tH6ZSrSxz4b34xkyAy2pDTmr4HCRL8Gf943jQC5X9mZ327fJ22+
	 CDm9yB5RnTRzcMQjztOow3EVG98qfU8LAWoAEd5DN9hHo6aByYYSjK+FRAf2r1/UH4
	 6yzhwWPgrAuYCDqfxzqJ3mmyvObuDDdS02sw6JLhsgWtXpf2C0D3qV7cEzqeRGInfV
	 fSVn14mi17zIw==
Date: Tue, 10 Jun 2025 09:24:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stefan Wahren <wahrenst@gmx.net>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: net: convert qca,qca7000.txt yaml
 format
Message-ID: <20250610-thick-gifted-tuna-7eab4f@kuoka>
References: <20250606155118.1355413-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250606155118.1355413-1-Frank.Li@nxp.com>

On Fri, Jun 06, 2025 at 11:51:17AM GMT, Frank Li wrote:
> +description: |
> +  The QCA7000 is a serial-to-powerline bridge with a host interface which could
> +  be configured either as SPI or UART slave. This configuration is done by
> +  the QCA7000 firmware.
> +
> +  (a) Ethernet over SPI
> +
> +  In order to use the QCA7000 as SPI device it must be defined as a child of a
> +  SPI master in the device tree.
> +
> +  (b) Ethernet over UART
> +
> +  In order to use the QCA7000 as UART slave it must be defined as a child of a
> +  UART master in the device tree. It is possible to preconfigure the UART
> +  settings of the QCA7000 firmware, but it's not possible to change them during
> +  runtime
> +
> +properties:
> +  compatible:
> +    const: qca,qca7000
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +if:

Please put this if: inside allOf: section, so you won't need to
re-indent it when adding one more if-clause.

> +  required:
> +    - reg
> +
> +then:
> +  properties:
> +    spi-cpha: true
> +
> +    spi-cpol: true
> +
> +    spi-max-frequency:
> +      default: 8000000
> +      maximum: 16000000
> +      minimum: 1000000
> +
> +    qca,legacy-mode:

This should be defined in top-level properties and you only do:
"foo: false" in "else:" part.

> +      $ref: /schemas/types.yaml#/definitions/flag
> +      description:
> +        Set the SPI data transfer of the QCA7000 to legacy mode.
> +        In this mode the SPI master must toggle the chip select
> +        between each data word. In burst mode these gaps aren't
> +        necessary, which is faster. This setting depends on how
> +        the QCA7000 is setup via GPIO pin strapping. If the
> +        property is missing the driver defaults to burst mode.
> +
> +  allOf:
> +    - $ref: /schemas/spi/spi-peripheral-props.yaml#

This should be part of top-level allOf.

> +
> +else:
> +  properties:
> +    current-speed:
> +      default: 115200
> +
> +  allOf:
> +    - $ref: /schemas/serial/serial-peripheral-props.yaml#

Same here.

> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet@0 {
> +            compatible = "qca,qca7000";
> +            reg = <0x0>;
> +            interrupt-parent = <&gpio3>;      /* GPIO Bank 3 */
> +            interrupts = <25 0x1>;            /* Index: 25, rising edge */
> +            spi-cpha;                         /* SPI mode: CPHA=1 */
> +            spi-cpol;                         /* SPI mode: CPOL=1 */
> +            spi-max-frequency = <8000000>;    /* freq: 8 MHz */
> +            local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
> +        };
> +    };
> +
> +  - |
> +    serial {
> +        ethernet {
> +            compatible = "qca,qca7000";
> +            local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
> +            current-speed = <38400>;
> +        };

Best regards,
Krzysztof


