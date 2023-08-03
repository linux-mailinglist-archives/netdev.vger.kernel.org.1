Return-Path: <netdev+bounces-23822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3DB76DCC7
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC52281ECB
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 00:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB35436B;
	Thu,  3 Aug 2023 00:40:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FE07F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 00:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4CAC433C8;
	Thu,  3 Aug 2023 00:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691023257;
	bh=tEp/sWbVfougAhFALnHoiMdyK5GfeRdB+ZlM8F4WUxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlveRzwuiCkUf9rLurdfAD1zIUqUpry4CUC/Y7eW4CbExBd+y3jafFVo+SDH+JQq7
	 jWxKb8a+j5gZHoylDfbVjZoN+iSHni65+tST7wxryKBhM510xfCA5KGkd3oYa+zcf3
	 M2/lMMLd9PWBeR5+viMZoWrYEfARi772F1oH/Sxp2eiTkBVzUM9YKNbCx7+Tm1Mgtc
	 p44YFoWSGLLwg5JoIezZ72wFmgNepeDJJJGCFSWVvV9Oj8JYlrQ2G6qjXxlxuxZQhO
	 mkwJ95cZUo1PP06BfMdV2mCmjPs26nphir37iDlvgcZ8p/JBkuQzmFZpGsJN5CrWaA
	 6fuhVEdw4mUtQ==
Received: (nullmailer pid 1598337 invoked by uid 1000);
	Thu, 03 Aug 2023 00:40:54 -0000
Date: Wed, 2 Aug 2023 18:40:54 -0600
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Thomas Petazzoni 
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 21/28] dt-bindings: net: Add the Lantiq PEF2256
 E1/T1/J1 framer
Message-ID: <20230803004054.GA1593620-robh@kernel.org>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
 <20230726150225.483464-22-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726150225.483464-22-herve.codina@bootlin.com>

On Wed, Jul 26, 2023 at 05:02:17PM +0200, Herve Codina wrote:
> The Lantiq PEF2256 is a framer and line interface component designed to
> fulfill all required interfacing between an analog E1/T1/J1 line and the
> digital PCM system highway/H.100 bus.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/net/lantiq,pef2256.yaml          | 226 ++++++++++++++++++
>  1 file changed, 226 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/lantiq,pef2256.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/lantiq,pef2256.yaml b/Documentation/devicetree/bindings/net/lantiq,pef2256.yaml
> new file mode 100644
> index 000000000000..b369a20d61b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/lantiq,pef2256.yaml
> @@ -0,0 +1,226 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/lantiq,pef2256.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lantiq PEF2256
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description:
> +  The Lantiq PEF2256, also known as Infineon PEF2256 or FALC56, is a framer and
> +  line interface component designed to fulfill all required interfacing between
> +  an analog E1/T1/J1 line and the digital PCM system highway/H.100 bus.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: lantiq,pef2256
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Master clock
> +      - description: Receive System Clock
> +      - description: Transmit System Clock
> +
> +  clock-names:
> +    items:
> +      - const: mclk
> +      - const: sclkr
> +      - const: sclkx
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      GPIO used to reset the device.
> +    maxItems: 1
> +
> +  '#framer-cells':

Looks generic, but no such property is defined. You don't need something 
like this unless there are multiple providers and you need each 
provider to define the number of cells.

> +    const: 0
> +
> +  pinctrl:
> +    $ref: /schemas/pinctrl/pinctrl.yaml#
> +    additionalProperties: false
> +
> +    patternProperties:
> +      '-pins$':
> +        type: object
> +        $ref: /schemas/pinctrl/pincfg-node.yaml#
> +        additionalProperties: false
> +
> +        properties:
> +          pins:
> +            enum: [ RPA, RPB, RPC, RPD, XPA, XPB, XPC, XPD ]
> +
> +          function:
> +            enum: [ SYPR, RFM, RFMB, RSIGM, RSIG, DLR, FREEZE, RFSP, LOS,
> +                    SYPX, XFMS, XSIG, TCLK, XMFB, XSIGM, DLX, XCLK, XLT,
> +                    GPI, GPOH, GPOL ]
> +
> +        required:
> +          - pins
> +          - function
> +
> +  lantiq,data-rate-bps:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [2048000, 4096000, 8192000, 16384000]
> +    default: 2048000
> +    description:
> +      Data rate (bit per seconds) on the system highway.
> +
> +  lantiq,clock-falling-edge:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Data is sent on falling edge of the clock (and received on the rising
> +      edge). If 'clock-falling-edge' is not present, data is sent on the
> +      rising edge (and received on the falling edge).
> +
> +  lantiq,channel-phase:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
> +    default: 0
> +    description:
> +      The pef2256 delivers a full frame (32 8bit time-slots in E1 and 24 8bit
> +      time-slots 8 8bit signaling in E1/J1) every 125us. This lead to a data
> +      rate of 2048000 bit/s. When lantiq,data-rate-bps is more than 2048000
> +      bit/s, the data (all 32 8bit) present in the frame are interleave with
> +      unused time-slots. The lantiq,channel-phase property allows to set the
> +      correct alignment of the interleave mechanism.
> +      For instance, suppose lantiq,data-rate-bps = 8192000 (ie 4*2048000), and
> +      lantiq,channel-phase = 2, the interleave schema with unused time-slots
> +      (nu) and used time-slots (XX) for TSi is
> +        nu nu XX nu nu nu XX nu nu nu XX nu
> +        <-- TSi --> <- TSi+1 -> <- TSi+2 ->
> +      With lantiq,data-rate-bps = 8192000, and lantiq,channel-phase = 1, the
> +      interleave schema is
> +        nu XX nu nu nu XX nu nu nu XX nu nu
> +        <-- TSi --> <- TSi+1 -> <- TSi+2 ->
> +      With lantiq,data-rate-bps = 4096000 (ie 2*2048000), and
> +      lantiq,channel-phase = 1, the interleave schema is
> +        nu    XX    nu    XX    nu    XX
> +        <-- TSi --> <- TSi+1 -> <- TSi+2 ->
> +
> +patternProperties:
> +  '^codec(-([0-9]|[1-2][0-9]|3[0-1]))?$':
> +    type: object
> +    $ref: /schemas/sound/dai-common.yaml
> +    unevaluatedProperties: false
> +    description:
> +      Codec provided by the pef2256. This codec allows to use some of the PCM
> +      system highway time-slots as audio channels to transport audio data over
> +      the E1/T1/J1 lines.
> +      The time-slots used by the codec must be set and so, the properties
> +      'dai-tdm-slot-num', 'dai-tdm-slot-width', 'dai-tdm-slot-tx-mask' and
> +      'dai-tdm-slot-rx-mask' must be present in the sound card node for
> +      sub-nodes that involve the codec. The codec uses 8bit time-slots.
> +      'dai-tdm-tdm-slot-with' must be set to 8.
> +      The tx and rx masks define the pef2256 time-slots assigned to the codec.
> +
> +    properties:
> +      compatible:
> +        const: lantiq,pef2256-codec
> +
> +      '#sound-dai-cells':
> +        const: 0
> +
> +      framer:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description:
> +          phandle to the framer node

That's just the parent. Why do you need this?

Rob


