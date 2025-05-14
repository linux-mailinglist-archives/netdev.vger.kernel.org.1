Return-Path: <netdev+bounces-190554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FAEAB7813
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 23:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635B73A8DF1
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 21:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB2B204098;
	Wed, 14 May 2025 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4kDQHin"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E0A2AF10;
	Wed, 14 May 2025 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747258729; cv=none; b=m/9DszC2tULh4Rfp6gN2RCGiC12UjgPiUPZfUck9+31v4yHiGmB94hExseOFUj/0SM+6NlscjQ16medi1pl6CrMUH4Cwn8ap1Srv7uhCu+f7G/qKRTL7IKMnASA+Ax8VLQ8soB5vsGSOHbzXhMraAHm4eVhHoI0oEthJJDZdpmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747258729; c=relaxed/simple;
	bh=hNb5jPe/smvHt5E9ANEvzYRWRCRcmC33IKRuFFhQTBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExGGcFJVJ4MdDxT43BmqUcjFz5aez3YaDv+bgG2/y9QPoKQ9LdaJ6828fwsOrhwZ8Nu6OkyAI1mGjWXEhX9Ojn6hud4/Fo5roao7rLVdG16BOniEtktQ6Utz8wp033NFi4kb7F4y/AipmW17Vjg9B2jDlqOSvVwMJUDPQ7jA8W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4kDQHin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1283CC4CEE3;
	Wed, 14 May 2025 21:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747258728;
	bh=hNb5jPe/smvHt5E9ANEvzYRWRCRcmC33IKRuFFhQTBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q4kDQHinFMHdDSOL/WxL8/jRZy1/5inVjfVeU0U/E9uQHTG7bviMmf9ftrEP2F0qA
	 4+di/4MA/Ufb3aaLsHEIRnH6/pHydGvfEI1vtdUNyQoAkHX1rLm7pWyu68HmGtkHuZ
	 RpCBCjsPhdn2HFoPocB5s5NfnpnqopASVErlt8auGunyg/e5fcy8c5UiV4B+MBVXvx
	 z3DUjlUEFR8cbNr9QiOArQBHjk4MFckDkk5VzexjMIEqgnRmaPk+o5T38inGJ+ib6v
	 w0kTgH+0UFpcvbt0LJTDkYnIYmAx31ES01gpAHmIuE4wgmCsQz8YWSzpHnxqWmGWkg
	 8I0IfG9yggAxg==
Date: Wed, 14 May 2025 16:38:46 -0500
From: Rob Herring <robh@kernel.org>
To: Damien =?iso-8859-1?Q?Ri=E9gel?= <damien.riegel@silabs.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Silicon Labs Kernel Team <linux-devel@silabs.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 13/15] dt-bindings: net: cpc: add
 silabs,cpc-spi.yaml
Message-ID: <20250514213846.GA3076991-robh@kernel.org>
References: <20250512012748.79749-1-damien.riegel@silabs.com>
 <20250512012748.79749-14-damien.riegel@silabs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512012748.79749-14-damien.riegel@silabs.com>

On Sun, May 11, 2025 at 09:27:46PM -0400, Damien Riégel wrote:
> Document device tree bindings for Silicon Labs CPC over a SPI bus. This
> device requires both a chip select and an interrupt line to be able to
> work.

What's CPC? Never defined here.

Bindings are for devices, not a SPI protocol. What if the device needs 
reset or power or ??? before you can talk to it. Maybe it's a situation 
where that will never matter, but you've got to spell it out here.

> 
> Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
> ---
>  .../bindings/net/silabs,cpc-spi.yaml          | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/silabs,cpc-spi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/silabs,cpc-spi.yaml b/Documentation/devicetree/bindings/net/silabs,cpc-spi.yaml
> new file mode 100644
> index 00000000000..82d3cd47daa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/silabs,cpc-spi.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2024 Silicon Labs Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/silabs,cpc-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI driver for CPC
> +
> +maintainers:
> +  - Damien Riégel <damien.riegel@silabs.com>
> +
> +description: |

Don't need '|'

> +  This binding is for the implementation of CPC protocol over SPI. The protocol
> +  consists of a chain of header+payload frames. The interrupt is used by the
> +  device to signal it has a frame to transmit, but also between headers and
> +  payloads to signal that it is ready to receive payload.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - silabs,cpc-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            cpcspi@0 {
> +                  compatible = "silabs,cpc-spi";
> +                  reg = <0>;
> +                  spi-max-frequency = <1000000>;
> +                  interrupt-parent = <&gpio>;
> +                  interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
> +            };
> +    };
> -- 
> 2.49.0
> 

