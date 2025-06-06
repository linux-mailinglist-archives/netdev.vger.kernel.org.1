Return-Path: <netdev+bounces-195444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2E9AD0330
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA6F189E889
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155C8289343;
	Fri,  6 Jun 2025 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rN8ugWxS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78CD288CB4;
	Fri,  6 Jun 2025 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749216501; cv=none; b=cPzqqEIDs5qAeaIFPGQ9zW8JwyC/BF3xDjgorlowp43nnondjO8hHsxT2l7z8Xcie6lq4krZN2hKsHPQUYmLDKB32y+akXgBmMxPGURNsgGgIqoEOXwGwvQTiSFrrFoT5aiCz8wAjX7jHHAa0fuiGB63o3Kww1gRFY65FWX6B+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749216501; c=relaxed/simple;
	bh=YgSQOMAF2b5WWx7Y03Wg5UQpUV9r7pptM31Y3UsFm78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0q/Gbj9z3CzWVZLi94D32wir9/jDCLgjOH8XAN48Cw23qEyjts2ORFHEoEuOUdQlYHzdQKszXZvB4egorQ7WW4z/qUs4Upj76BoeHvqGSFs+hnmIFiWaoBsEex0kRs+TfmYvb1kceyYBhvAzT9wYKuF82sYydDwhbaAmlDvBtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rN8ugWxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA8BC4CEEB;
	Fri,  6 Jun 2025 13:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749216500;
	bh=YgSQOMAF2b5WWx7Y03Wg5UQpUV9r7pptM31Y3UsFm78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rN8ugWxSko1Du8wyQZwMk9xXJz45NS6VyiTEPvYWNMtRn3xY8qTPvAwSlEk5juxLy
	 6aZGXIC3ShnkOldnw6uBPRDHwDCr7AaScNEqVzTAhis1wrPGmHIyJKBo1O0QNHvoVD
	 3wXQe0LzAWWdUImGcdGNHaY22PMKAZN4kxLdElVYJ1cDS//9gSxO4wNqmHb4eYvV+d
	 UOTGxpaE1NK4RJVae9px0rPmHbJJCiknMjP3LZrAmwbOcVhPPHnRmPv7K/3sXd7XYy
	 pzBxDVWZWcpXStnkX+1psNpVfpBViZnAdvpo2s9+BBw2GqVVX2J7NRNCK8qklRc1o0
	 KEPTwteWRB9Tg==
Date: Fri, 6 Jun 2025 08:28:18 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: net: convert qca,qca7000.txt yaml
 format
Message-ID: <20250606132818.GA1246648-robh@kernel.org>
References: <20250602224402.1047281-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602224402.1047281-1-Frank.Li@nxp.com>

On Mon, Jun 02, 2025 at 06:44:01PM -0400, Frank Li wrote:
> Convert qca,qca7000.txt yaml format.
> 
> Additional changes:
> - add refs: spi-peripheral-props.yaml, serial-peripheral-props.yaml and
>   ethernet-controller.yaml.
> - simple spi and uart node name.
> - use low case for mac address in examples.
> - add check reg choose spi-peripheral-props.yaml or
>   spi-peripheral-props.yaml.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - add Ethernet over UART" description here back
> - add add check reg choose spi-peripheral-props.yaml
> - move spi related properties in if-then branch
> - move uart related properies in if-else branch
> ---
>  .../devicetree/bindings/net/qca,qca7000.txt   |  87 ---------------
>  .../devicetree/bindings/net/qca,qca7000.yaml  | 104 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 105 insertions(+), 88 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/qca,qca7000.txt
>  create mode 100644 Documentation/devicetree/bindings/net/qca,qca7000.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/qca,qca7000.txt b/Documentation/devicetree/bindings/net/qca,qca7000.txt
> deleted file mode 100644
> index 8f5ae0b84eec2..0000000000000
> --- a/Documentation/devicetree/bindings/net/qca,qca7000.txt
> +++ /dev/null
> @@ -1,87 +0,0 @@
> -* Qualcomm QCA7000
> -
> -The QCA7000 is a serial-to-powerline bridge with a host interface which could
> -be configured either as SPI or UART slave. This configuration is done by
> -the QCA7000 firmware.
> -
> -(a) Ethernet over SPI
> -
> -In order to use the QCA7000 as SPI device it must be defined as a child of a
> -SPI master in the device tree.
> -
> -Required properties:
> -- compatible	    : Should be "qca,qca7000"
> -- reg		    : Should specify the SPI chip select
> -- interrupts	    : The first cell should specify the index of the source
> -		      interrupt and the second cell should specify the trigger
> -		      type as rising edge
> -- spi-cpha	    : Must be set
> -- spi-cpol	    : Must be set
> -
> -Optional properties:
> -- spi-max-frequency : Maximum frequency of the SPI bus the chip can operate at.
> -		      Numbers smaller than 1000000 or greater than 16000000
> -		      are invalid. Missing the property will set the SPI
> -		      frequency to 8000000 Hertz.
> -- qca,legacy-mode   : Set the SPI data transfer of the QCA7000 to legacy mode.
> -		      In this mode the SPI master must toggle the chip select
> -		      between each data word. In burst mode these gaps aren't
> -		      necessary, which is faster. This setting depends on how
> -		      the QCA7000 is setup via GPIO pin strapping. If the
> -		      property is missing the driver defaults to burst mode.
> -
> -The MAC address will be determined using the optional properties
> -defined in ethernet.txt.
> -
> -SPI Example:
> -
> -/* Freescale i.MX28 SPI master*/
> -ssp2: spi@80014000 {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	compatible = "fsl,imx28-spi";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi2_pins_a>;
> -
> -	qca7000: ethernet@0 {
> -		compatible = "qca,qca7000";
> -		reg = <0x0>;
> -		interrupt-parent = <&gpio3>;      /* GPIO Bank 3 */
> -		interrupts = <25 0x1>;            /* Index: 25, rising edge */
> -		spi-cpha;                         /* SPI mode: CPHA=1 */
> -		spi-cpol;                         /* SPI mode: CPOL=1 */
> -		spi-max-frequency = <8000000>;    /* freq: 8 MHz */
> -		local-mac-address = [ A0 B0 C0 D0 E0 F0 ];
> -	};
> -};
> -
> -(b) Ethernet over UART
> -
> -In order to use the QCA7000 as UART slave it must be defined as a child of a
> -UART master in the device tree. It is possible to preconfigure the UART
> -settings of the QCA7000 firmware, but it's not possible to change them during
> -runtime.
> -
> -Required properties:
> -- compatible        : Should be "qca,qca7000"
> -
> -Optional properties:
> -- local-mac-address : see ./ethernet.txt
> -- current-speed     : current baud rate of QCA7000 which defaults to 115200
> -		      if absent, see also ../serial/serial.yaml
> -
> -UART Example:
> -
> -/* Freescale i.MX28 UART */
> -auart0: serial@8006a000 {
> -	compatible = "fsl,imx28-auart", "fsl,imx23-auart";
> -	reg = <0x8006a000 0x2000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&auart0_2pins_a>;
> -
> -	qca7000: ethernet {
> -		compatible = "qca,qca7000";
> -		local-mac-address = [ A0 B0 C0 D0 E0 F0 ];
> -		current-speed = <38400>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/net/qca,qca7000.yaml b/Documentation/devicetree/bindings/net/qca,qca7000.yaml
> new file mode 100644
> index 0000000000000..5258288132968
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/qca,qca7000.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/qca,qca7000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QCA7000
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
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
> +    - $ref: ethernet-controller.yaml#

ethernet-controller.yaml should be moved out of the 'if' schemas.

> +
> +else:
> +  properties:
> +    current-speed:
> +      default: 115200
> +
> +  allOf:
> +    - $ref: /schemas/serial/serial-peripheral-props.yaml#
> +    - $ref: ethernet-controller.yaml#
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
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c14da518a214c..6416ada9900af 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20295,7 +20295,7 @@ QUALCOMM ATHEROS QCA7K ETHERNET DRIVER
>  M:	Stefan Wahren <wahrenst@gmx.net>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/net/qca,qca7000.txt
> +F:	Documentation/devicetree/bindings/net/qca,qca7000.yaml
>  F:	drivers/net/ethernet/qualcomm/qca*
>  
>  QUALCOMM BAM-DMUX WWAN NETWORK DRIVER
> -- 
> 2.34.1
> 

