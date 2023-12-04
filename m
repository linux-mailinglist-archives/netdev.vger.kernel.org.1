Return-Path: <netdev+bounces-53696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98357804262
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 00:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A5E1F21331
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 23:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C2E23742;
	Mon,  4 Dec 2023 23:09:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30F7AC
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 15:09:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rAI3S-0001Kc-V9; Tue, 05 Dec 2023 00:08:46 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rAI3R-00Dc6M-MG; Tue, 05 Dec 2023 00:08:45 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rAI3R-005IUM-Ir; Tue, 05 Dec 2023 00:08:45 +0100
Date: Tue, 5 Dec 2023 00:08:45 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v2 7/8] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <20231204230845.GH981228@pengutronix.de>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-7-56d8cac607fa@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231201-feature_poe-v2-7-56d8cac607fa@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Dec 01, 2023 at 06:10:29PM +0100, Kory Maincent wrote:
> Add the PD692x0 I2C Power Sourcing Equipment controller device tree
> bindings documentation.
> 
> Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v2:
> - Enhance ports-matrix description.
> - Replace additionalProperties by unevaluatedProperties.
> - Drop i2c suffix.
> ---
>  .../bindings/net/pse-pd/microchip,pd692x0.yaml     | 77 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
> new file mode 100644
> index 000000000000..3ce81cf99215
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pse-pd/microchip,pd692x0.yaml#
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
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#pse-cells':
> +    const: 1
> +
> +  ports-matrix:
> +    description: each set of 48 logical ports can be assigned to one or two
> +      physical ports. Each physical port is wired to a PD69204/8 PoE
> +      manager. Using two different PoE managers for one RJ45 port
> +      (logical port) is interesting for temperature dissipation.
> +      This parameter describes the configuration of the port conversion
> +      matrix that establishes the relationship between the 48 logical ports
> +      and the available 96 physical ports. Unspecified logical ports will
> +      be deactivated.
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
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-pse@3c {
> +          compatible = "microchip,pd69200";
> +          reg = <0x3c>;
> +          #pse-cells = <1>;
> +          ports-matrix = <0 2 5
> +                          1 3 6
> +                          2 0 0xff
> +                          3 1 0xff>;

Hm... this will probably not scale.  PSE is kind of PMIC for ethernet. I
has bunch of regulators which can be grouped to one more powerful
regulator. Since it is regulators, we will wont to represent them in a
system as regulators too. We will probably have physical, board
specific limitation, so we will need to describe regulator limits for
each separate channel.

> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e3fd148d462e..b746684f3fd3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14235,6 +14235,12 @@ L:	linux-serial@vger.kernel.org
>  S:	Maintained
>  F:	drivers/tty/serial/8250/8250_pci1xxxx.c
>  
> +MICROCHIP PD692X0 PSE DRIVER
> +M:	Kory Maincent <kory.maincent@bootlin.com>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
> +
>  MICROCHIP POLARFIRE FPGA DRIVERS
>  M:	Conor Dooley <conor.dooley@microchip.com>
>  R:	Vladimir Georgiev <v.georgiev@metrotek.ru>
> 
> -- 
> 2.25.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

