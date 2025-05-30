Return-Path: <netdev+bounces-194329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E33AC89EF
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 10:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C714A30D7
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 08:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C48218E81;
	Fri, 30 May 2025 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="CqdzUzG7"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F5721578F;
	Fri, 30 May 2025 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748594024; cv=none; b=uri4HlC8foAnoaY/7EXATuwxe98fkC5PK82+xZ0f8qWefX7A1le5BH7raG3+IOO8d7dLSCpIa3tQETIZpKFu2uM1Up9aUg3cGFDlpW0Q3nzpQE6J4uKDrLQkSpRTNpAcBwTYvSM+jLunbuW8KVRczAkt3Tl91Q7CpjNMC41Oyr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748594024; c=relaxed/simple;
	bh=lKLqZSSked+vdkCWaAgIsLAmGzJ6HjOLpIP3Jr7GRF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o83jnbkqjC8Pxp3QBBlBRBt5zfMUCHB9gIxq6BLjZWDCd9MGgke6dfe21MMBw7gsA52/RSEHiADaaZhHKfsnaDLDVtSVZxIqG2Ib6r+Umv+VhgEw1T8bQvrWNGVwoXySrd1X5bHcG1Y6x39/uC56jlxMWUDk4uRRI05AHHiGJZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=CqdzUzG7; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1748594010; x=1749198810; i=wahrenst@gmx.net;
	bh=2/p2El0dWEgypg+Jj8YhT/c1tRaeZcl4lGb7TDH06KY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CqdzUzG7cteFLc3309P1Csiv80NJjzX9rfHi9e9nvFLlpmYm1WLyvHlQ37QX8eCT
	 /RZFnIiI6Cz1Zp1EP6DeGLx3QcjD85290vcQtXk4J6iOHRuaTis1hstX78NN1CKZG
	 tPT4MdM26nTvruDr/8Am9A39FwNQ2ijuZadP+kVTrT3Qf9nazj/ml/IVoTypxqJGT
	 9YJdYbT/qCnYYGzNXDssYQXEzlLw1pRmsI1R+yKlKPmTshUwt7Aal4NQ6nP9iy4ql
	 QQ3dpWuXHigfFuC+K9WKelEtJ7CwLy/dkZanoWKt9QiuxP6Ff85Sr8Byps3BUXKFI
	 3EE2+DyHm2c9FearvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKsj7-1ub3v50UJx-00Rwqx; Fri, 30
 May 2025 10:33:30 +0200
Message-ID: <047fb49e-1ca8-43a6-b122-0d6fa9a61c74@gmx.net>
Date: Fri, 30 May 2025 10:33:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: net: convert qca,qca7000.txt yaml format
To: Frank Li <Frank.Li@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20250529191727.789915-1-Frank.Li@nxp.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20250529191727.789915-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:isti/zcoHy0BEPlRv23mXJO9AD6oexaCEeq77RC7QWT+4jf8EII
 XErB8E55qPRLDnleeDzx7sG70eOhbf8l5z9dZVPBZBNskaFb31/hqXg/NwTAXfeHGFyV7gX
 Iy3DNfhycz/As7Hfnb7byZru2eRVw7DFpWn6WBQNWlVSTtExGsEWY0jbaBcaoURifbWdkKM
 6fO8/ZktLeaHPHmAHrPVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HdZVyM2zHok=;AO9swPmz1nmw6FhCXNGHJV28Nxs
 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
 T1CYeJG

Hi Frank,

thanks for this patch.

Am 29.05.25 um 21:17 schrieb Frank Li:
> Convert qca,qca7000.txt yaml format.
>
> Additional changes:
> - add refs: spi-peripheral-props.yaml, serial-peripheral-props.yaml and
>    ethernet-controller.yaml.
> - simple spi and uart node name.
> - use low case for mac address in examples.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>   .../devicetree/bindings/net/qca,qca7000.txt   | 87 -------------------
>   .../devicetree/bindings/net/qca,qca7000.yaml  | 86 ++++++++++++++++++
>   MAINTAINERS                                   |  2 +-
>   3 files changed, 87 insertions(+), 88 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/net/qca,qca7000.t=
xt
>   create mode 100644 Documentation/devicetree/bindings/net/qca,qca7000.y=
aml
>
> diff --git a/Documentation/devicetree/bindings/net/qca,qca7000.txt b/Doc=
umentation/devicetree/bindings/net/qca,qca7000.txt
> deleted file mode 100644
> index 8f5ae0b84eec2..0000000000000
> --- a/Documentation/devicetree/bindings/net/qca,qca7000.txt
> +++ /dev/null
> @@ -1,87 +0,0 @@
> -* Qualcomm QCA7000
> -
> -The QCA7000 is a serial-to-powerline bridge with a host interface which=
 could
> -be configured either as SPI or UART slave. This configuration is done b=
y
> -the QCA7000 firmware.
> -
> -(a) Ethernet over SPI
> -
> -In order to use the QCA7000 as SPI device it must be defined as a child=
 of a
> -SPI master in the device tree.
> -
> -Required properties:
> -- compatible	    : Should be "qca,qca7000"
> -- reg		    : Should specify the SPI chip select
> -- interrupts	    : The first cell should specify the index of the sourc=
e
> -		      interrupt and the second cell should specify the trigger
> -		      type as rising edge
> -- spi-cpha	    : Must be set
> -- spi-cpol	    : Must be set
> -
> -Optional properties:
> -- spi-max-frequency : Maximum frequency of the SPI bus the chip can ope=
rate at.
> -		      Numbers smaller than 1000000 or greater than 16000000
> -		      are invalid. Missing the property will set the SPI
> -		      frequency to 8000000 Hertz.
> -- qca,legacy-mode   : Set the SPI data transfer of the QCA7000 to legac=
y mode.
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
> -	#address-cells =3D <1>;
> -	#size-cells =3D <0>;
> -	compatible =3D "fsl,imx28-spi";
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&spi2_pins_a>;
> -
> -	qca7000: ethernet@0 {
> -		compatible =3D "qca,qca7000";
> -		reg =3D <0x0>;
> -		interrupt-parent =3D <&gpio3>;      /* GPIO Bank 3 */
> -		interrupts =3D <25 0x1>;            /* Index: 25, rising edge */
> -		spi-cpha;                         /* SPI mode: CPHA=3D1 */
> -		spi-cpol;                         /* SPI mode: CPOL=3D1 */
> -		spi-max-frequency =3D <8000000>;    /* freq: 8 MHz */
> -		local-mac-address =3D [ A0 B0 C0 D0 E0 F0 ];
> -	};
> -};
> -
> -(b) Ethernet over UART
> -
> -In order to use the QCA7000 as UART slave it must be defined as a child=
 of a
> -UART master in the device tree. It is possible to preconfigure the UART
> -settings of the QCA7000 firmware, but it's not possible to change them =
during
> -runtime.
> -
> -Required properties:
> -- compatible        : Should be "qca,qca7000"
> -
> -Optional properties:
> -- local-mac-address : see ./ethernet.txt
> -- current-speed     : current baud rate of QCA7000 which defaults to 11=
5200
> -		      if absent, see also ../serial/serial.yaml
> -
> -UART Example:
> -
> -/* Freescale i.MX28 UART */
> -auart0: serial@8006a000 {
> -	compatible =3D "fsl,imx28-auart", "fsl,imx23-auart";
> -	reg =3D <0x8006a000 0x2000>;
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&auart0_2pins_a>;
> -
> -	qca7000: ethernet {
> -		compatible =3D "qca,qca7000";
> -		local-mac-address =3D [ A0 B0 C0 D0 E0 F0 ];
> -		current-speed =3D <38400>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/net/qca,qca7000.yaml b/Do=
cumentation/devicetree/bindings/net/qca,qca7000.yaml
> new file mode 100644
> index 0000000000000..348b8e9af975b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/qca,qca7000.yaml
> @@ -0,0 +1,86 @@
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
> +  The QCA7000 is a serial-to-powerline bridge with a host interface whi=
ch could
> +  be configured either as SPI or UART slave. This configuration is done=
 by
> +  the QCA7000 firmware.
> +
> +  (a) Ethernet over SPI
> +
> +  In order to use the QCA7000 as SPI device it must be defined as a chi=
ld of a
> +  SPI master in the device tree.
Could you please add the dropped "(b) Ethernet over UART" description here=
?
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
> +  spi-cpha: true
> +
> +  spi-cpol: true
In case of a SPI setup these properties should be required.=20
Unfortunately i'm not sure how to enforce this. Maybe depending on the=20
presence of "reg"?

Regards
> +
> +  spi-max-frequency:
> +    default: 8000000
> +    maximum: 16000000
> +    minimum: 1000000
> +
> +  qca,legacy-mode:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Set the SPI data transfer of the QCA7000 to legacy mode.
> +      In this mode the SPI master must toggle the chip select
> +      between each data word. In burst mode these gaps aren't
> +      necessary, which is faster. This setting depends on how
> +      the QCA7000 is setup via GPIO pin strapping. If the
> +      property is missing the driver defaults to burst mode.
> +
> +  current-speed:
> +    default: 115200
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - $ref: /schemas/serial/serial-peripheral-props.yaml#
> +  - $ref: ethernet-controller.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        ethernet@0 {
> +            compatible =3D "qca,qca7000";
> +            reg =3D <0x0>;
> +            interrupt-parent =3D <&gpio3>;      /* GPIO Bank 3 */
> +            interrupts =3D <25 0x1>;            /* Index: 25, rising ed=
ge */
> +            spi-cpha;                         /* SPI mode: CPHA=3D1 */
> +            spi-cpol;                         /* SPI mode: CPOL=3D1 */
> +            spi-max-frequency =3D <8000000>;    /* freq: 8 MHz */
> +            local-mac-address =3D [ a0 b0 c0 d0 e0 f0 ];
> +        };
> +    };
> +
> +  - |
> +    serial {
> +        ethernet {
> +            compatible =3D "qca,qca7000";
> +            local-mac-address =3D [ a0 b0 c0 d0 e0 f0 ];
> +            current-speed =3D <38400>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7761b5ef87674..c163c80688c23 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20295,7 +20295,7 @@ QUALCOMM ATHEROS QCA7K ETHERNET DRIVER
>   M:	Stefan Wahren <wahrenst@gmx.net>
>   L:	netdev@vger.kernel.org
>   S:	Maintained
> -F:	Documentation/devicetree/bindings/net/qca,qca7000.txt
> +F:	Documentation/devicetree/bindings/net/qca,qca7000.yaml
>   F:	drivers/net/ethernet/qualcomm/qca*
>  =20
>   QUALCOMM BAM-DMUX WWAN NETWORK DRIVER


