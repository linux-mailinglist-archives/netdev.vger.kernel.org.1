Return-Path: <netdev+bounces-184088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA6EA934C4
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 10:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D417A7A630E
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 08:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9921E26E159;
	Fri, 18 Apr 2025 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="m7ymcOlG"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBAA1DFFD;
	Fri, 18 Apr 2025 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744965742; cv=none; b=G39VMv2HLVkHIXKY2DWX/9pLeOSTFLxwJKj9iZkumhxeR+cJEvTusV8PIGLkXqr/16DnbG/J7/vSjI+TsNZT3+aqgxLAKivu4HBvfBnXBbndGF/eh2Kjf2fNhThgxvHHhLU5PLsUTcO2WyBxkeDgjgeI2+GCzwRMsdfgl6eFioI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744965742; c=relaxed/simple;
	bh=ClutDN4LogIohfYqtvpgA8jjbMDkk3vdR6aY3nOoq/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSnCQ2vJei+RrKbnsQhLl7CfEkzTiqSDh08Fetibtbna307acE+AsQAgwhlUGcmZFuLIW+aTV23bWUfMhvyWe/BWcq3KbVU8enVqDZlYK7BMFPqp1jr52KHJXoAzD9KgKCpD9M9sZWPCyOGe2cUXctwWZsCFZv2uds6NciivGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=m7ymcOlG; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744965714; x=1745570514; i=wahrenst@gmx.net;
	bh=bJ/hT/ZT80TdjjDAggi4sJ5+WqriSpJ1jG8o55EVs90=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=m7ymcOlGLY4LffBB2dk7fhesz0jWScNmd8z6l4/oX4H8omR/yeZOGh9jLFqDbuCV
	 ZUqlk7GhI5mtAItRk3r/EaayIOL9W7TK0ljnf7ZHIXMFc/bqEQwpcMM8mGJGiKTRQ
	 uYt3ShTItIYdeh9TvwLuzPAplH2U8jiz+23wMnYFQ2TBtK+3RjC6ztWLA2NJoz3wb
	 WtlVBrzGppOyluHeSQXEcUi6nt1r1K6orvWJrFM57lf91xUXIv4Kh7kYQBqrw8y7f
	 /F9+TZvw4xjWeAXzHfHAsys34Hhn2L2dSeLv1hWX/6QSVqg0ef9H4d/HLOPxIClBf
	 udCCp+ogl90khyrdgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QwW-1v65gq0gsg-00z3Di; Fri, 18
 Apr 2025 10:41:54 +0200
Message-ID: <e4c7662f-4d10-4d45-843d-0a0f3c893a1f@gmx.net>
Date: Fri, 18 Apr 2025 10:41:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v6 1/7] dt-bindings: net: Add MTIP L2 switch
 description
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Simon Horman <horms@kernel.org>
References: <20250418060716.3498031-1-lukma@denx.de>
 <20250418060716.3498031-2-lukma@denx.de>
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
In-Reply-To: <20250418060716.3498031-2-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:puRbuHuDJUL4UBAwlEbPoCXrO7wrkqYvVnLveMrv4XVBg2CsJ0I
 Fe83jHvHdG8+q9ttRnOffxOpndWldPV5J8JikhvcuWXSKzHJ8jiJseqbXb0MrAqCfD8+i4c
 YKBDrV7XY8dHoxPleVsn7CV0q6pkw/cnnFFouzX+DwKpVbvtcFhHOfhnVw+xB9+IzxaLz8s
 sUS9ijySaFcCRt4ncOZsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IZ4aqZRe2YY=;zw9fIkzZW/AM236HsrvLO0zuy63
 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

Am 18.04.25 um 08:07 schrieb Lukasz Majewski:
> This patch provides description of the MTIP L2 switch available in some
> NXP's SOCs - e.g. imx287.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v2:
> - Rename the file to match exactly the compatible
>    (nxp,imx287-mtip-switch)
>
> Changes for v3:
> - Remove '-' from const:'nxp,imx287-mtip-switch'
> - Use '^port@[12]+$' for port patternProperties
> - Drop status =3D "okay";
> - Provide proper indentation for 'example' binding (replace 8
>    spaces with 4 spaces)
> - Remove smsc,disable-energy-detect; property
> - Remove interrupt-parent and interrupts properties as not required
> - Remove #address-cells and #size-cells from required properties check
> - remove description from reg:
> - Add $ref: ethernet-switch.yaml#
>
> Changes for v4:
> - Use $ref: ethernet-switch.yaml#/$defs/ethernet-ports and remove alread=
y
>    referenced properties
> - Rename file to nxp,imx28-mtip-switch.yaml
>
> Changes for v5:
> - Provide proper description for 'ethernet-port' node
>
> Changes for v6:
> - Proper usage of
>    $ref: ethernet-switch.yaml#/$defs/ethernet-ports/patternProperties
>    when specifying the 'ethernet-ports' property
> - Add description and check for interrupt-names property
> ---
>   .../bindings/net/nxp,imx28-mtip-switch.yaml   | 148 ++++++++++++++++++
>   1 file changed, 148 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/net/nxp,imx28-mti=
p-switch.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch=
.yaml b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> new file mode 100644
> index 000000000000..3e2d724074d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> @@ -0,0 +1,148 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/nxp,imx28-mtip-switch.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP SoC Ethernet Switch Controller (L2 MoreThanIP switch)
> +
> +maintainers:
> +  - Lukasz Majewski <lukma@denx.de>
> +
> +description:
> +  The 2-port switch ethernet subsystem provides ethernet packet (L2)
> +  communication and can be configured as an ethernet switch. It provide=
s the
> +  reduced media independent interface (RMII), the management data input
> +  output (MDIO) for physical layer device (PHY) management.
> +
> +properties:
> +  compatible:
> +    const: nxp,imx28-mtip-switch
> +
> +  reg:
> +    maxItems: 1
> +
> +  phy-supply:
> +    description:
> +      Regulator that powers Ethernet PHYs.
> +
> +  clocks:
> +    items:
> +      - description: Register accessing clock
> +      - description: Bus access clock
> +      - description: Output clock for external device - e.g. PHY source=
 clock
> +      - description: IEEE1588 timer clock
> +
> +  clock-names:
> +    items:
> +      - const: ipg
> +      - const: ahb
> +      - const: enet_out
> +      - const: ptp
> +
> +  interrupts:
> +    items:
> +      - description: Switch interrupt
> +      - description: ENET0 interrupt
> +      - description: ENET1 interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: mtipl2sw
Sorry for nitpicking, but could we name it similiar to something from=20
the i.MX28 reference manual like "switch" or "enet_switch"

