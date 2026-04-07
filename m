Return-Path: <netdev+bounces-276098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCGRFjU41WlY3AcAu9opvQ
	(envelope-from <netdev+bounces-276098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:00:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F19A73B2270
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F3DA301DA4A
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 17:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0289635A948;
	Tue,  7 Apr 2026 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJ+i+zB3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D186F24E4C4;
	Tue,  7 Apr 2026 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775581235; cv=none; b=dG+82PPhv3hBslOB9bYzoxC0/btGlDrvvxz5Kb/YUgeMId9VYY0pIL7SGZ+xjoELVNnI7ADNhKXJ+l/XeQHwluQ7YlBwgDHYocu/b9BB7XN77Y1JdCLPBsu33ux9jaSwZ82Jy2p+A9/+Xp5ZHoMXH1qD14ppSkrdSrfRcdcRjkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775581235; c=relaxed/simple;
	bh=4P69iXazPb0En0giTPtrTHJjHjDtStci7tqDau5W66o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lt3b0KhaHjvsSwgfZpaegZ7jj4vbFGGbaPICyEvwC0XWZsFKoyUnZ2LmhLjoaVSGAtXHWVKWyxOHN0VSREbdWJ4gsqghHUTNpzrQkjpbYGwgVeo7m09d0EsIBwR1WSJy/b+g4kruz8aJZuZ3nkw1X7dmDYTkbLB7Qttg09gSnD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJ+i+zB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E1AC116C6;
	Tue,  7 Apr 2026 17:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775581235;
	bh=4P69iXazPb0En0giTPtrTHJjHjDtStci7tqDau5W66o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJ+i+zB3QP55Zsq+EjTcJn0lKADyO46c8aM6jpk48g6m9ZWeib31dqRV60F/a8Jla
	 21913Pr4DTfjtCuNt4KkoXPhNms4/NhlZUdbm30XygvoDOFp2KXjeWJBiKOgFMR5P9
	 gk49yvDMaHMiDnwVRbA+Q7UtL8UbKuIB+nwCvsZQ06p/kZ5QJKyjHQ4VhqBrZfZhwm
	 sVUPCIdJomtBQa/MVj6qCGiCD5FRLr4SiKbgCkGVkh3y11uNeyPPhymIpHpUVG9L18
	 x+6kTPITaB5ic7JgwlyElv8Sba3Vx3Xd1mNCuIxnMwcH/6UDL/L+fUDI9OWEHwxxCy
	 5+toqcer41ZhQ==
Date: Tue, 7 Apr 2026 12:00:33 -0500
From: Rob Herring <robh@kernel.org>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: document Microchip
 PIC64-HPSC/HX MDIO controller
Message-ID: <20260407170033.GA2954294-robh@kernel.org>
References: <20260323220254.3822444-1-charles.perry@microchip.com>
 <20260323220254.3822444-2-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323220254.3822444-2-charles.perry@microchip.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-276098-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,0.0.0.0:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,4000c21e000:email]
X-Rspamd-Queue-Id: F19A73B2270
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 03:02:53PM -0700, Charles Perry wrote:
> This MDIO hardware is based on a Microsemi design supported in Linux by
> mdio-mscc-miim.c. However, The register interface is completely different
> with pic64hpsc, hence the need for separate documentation.
> 
> The hardware supports C22 and C45.
> 
> The documentation recommends an input clock of 156.25MHz and a prescaler
> of 39, which yields an MDIO clock of 1.95MHz.
> 
> The hardware supports an interrupt pin to signal transaction completion
> which is not strictly needed as the software can also poll a "TRIGGER"
> bit for this.
> 
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
> 
> Notes:
>     Changes in v2:
>       - Make "clocks" and "interrupts" required (Andrew)
>       - Add a default value to "clock-frequency" (Andrew)
> 
>  .../net/microchip,pic64hpsc-mdio.yaml         | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml b/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
> new file mode 100644
> index 000000000000..d690afe3d3cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/microchip,pic64hpsc-mdio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PIC64-HPSC/HX MDIO controller
> +
> +maintainers:
> +  - Charles Perry <charles.perry@microchip.com>
> +
> +description: |

Don't need '|' if no formatting to preserve.

> +  Microchip PIC64-HPSC/HX SoCs have two MDIO bus controller. This MDIO bus

s/controller/controllers/

Though how many instances there are is not really applicable to the 
binding unless there is some difference.

> +  controller supports C22 and C45 register access. It is named "MDIO Initiator"
> +  in the documentation.
> +
> +allOf:
> +  - $ref: mdio.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: microchip,pic64hpsc-mdio
> +      - items:
> +          - const: microchip,pic64hx-mdio
> +          - const: microchip,pic64hpsc-mdio
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    default: 2500000
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        mdio@4000C21E000 {

Unit-addresses are lower case hex.

> +            compatible = "microchip,pic64hpsc-mdio";
> +            reg = <0x400 0x0C21E000 0x0 0x1000>;

And generally we use lower case here too.

> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            clocks = <&svc_clk>;
> +            interrupt-parent = <&saplic0>;
> +            interrupts = <168 IRQ_TYPE_LEVEL_HIGH>;
> +
> +            phy0: ethernet-phy@0 {

Drop unused labels.

> +                reg = <0>;
> +            };
> +        };
> +    };
> -- 
> 2.47.3
> 

