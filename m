Return-Path: <netdev+bounces-29437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF697833CF
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6481C209C8
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C4D11737;
	Mon, 21 Aug 2023 20:43:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2F411733
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0D4C433C8;
	Mon, 21 Aug 2023 20:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692650582;
	bh=P41CM/OE8qR2Gp1s+g6+GSL1DglIHghUvEzQuODVkmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UOml1bli7gpAXd/J8eSKV26mhi+K1Qkfswc3XkPFfbyVV5Ok3TQT7Z/JDWQop/uWz
	 iS+AzrUyvjliyoAd40oHLcUxTl3RVeshK/tZDCSBTTmjLjZFcbUTIelydTK+L0T5Bb
	 FnGg0AjSO+MjT4uimnJxVSXHlmf7jH81RZ2ftlfiGdC+6Gkq9RCuzblpSqczXAyY7+
	 qFazrV2lS835EOF2VaXPwPPwkGyt/0UVDM3uDcNL6gd3FN3KqTHJIdGvVMLudARvV2
	 rIavmg1onrMgqE+ej6mZc7Wwgp7yiXLGRsRhsWvWoohfvBlPZ9Svy2t977WWKD0mA/
	 8PLW6le92tJ8g==
Received: (nullmailer pid 2260072 invoked by uid 1000);
	Mon, 21 Aug 2023 20:42:58 -0000
Date: Mon, 21 Aug 2023 15:42:58 -0500
From: Rob Herring <robh@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Herve Codina <herve.codina@bootlin.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Thomas Petazzoni <thomas
 .petazzoni@bootlin.com>
Subject: Re: [PATCH v4 06/28] dt-bindings: net: Add support for QMC HDLC
Message-ID: <20230821204258.GA2253571-robh@kernel.org>
References: <cover.1692376360.git.christophe.leroy@csgroup.eu>
 <817d1418fa1e9e689375177bee4bdc68ceeab7be.1692376361.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <817d1418fa1e9e689375177bee4bdc68ceeab7be.1692376361.git.christophe.leroy@csgroup.eu>

On Fri, Aug 18, 2023 at 06:39:00PM +0200, Christophe Leroy wrote:
> From: Herve Codina <herve.codina@bootlin.com>
> 
> The QMC (QUICC mutichannel controller) is a controller present in some
> PowerQUICC SoC such as MPC885.
> The QMC HDLC uses the QMC controller to transfer HDLC data.
> 
> Additionally, a framer can be connected to the QMC HDLC.
> If present, this framer is the interface between the TDM bus used by the
> QMC HDLC and the E1/T1 line.
> The QMC HDLC can use this framer to get information about the E1/T1 line
> and configure the E1/T1 line.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  .../devicetree/bindings/net/fsl,qmc-hdlc.yaml | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml b/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
> new file mode 100644
> index 000000000000..13f3572f0feb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/fsl,qmc-hdlc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale/NXP QUICC Multichannel Controller (QMC) HDLC
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description: |

Don't need '|'

> +  The QMC HDLC uses a QMC (QUICC Multichannel Controller) channel to transfer
> +  HDLC data.
> +
> +properties:
> +  compatible:
> +    const: fsl,qmc-hdlc
> +
> +  fsl,qmc-chan:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to QMC node
> +          - description: Channel number
> +    description:
> +      Should be a phandle/number pair. The phandle to QMC node and the QMC
> +      channel to use.
> +
> +  framer:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to the framer node

What's the framer? 

> +
> +required:
> +  - compatible
> +  - fsl,qmc-chan
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    hdlc {
> +        compatible = "fsl,qmc-hdlc";
> +        fsl,qmc-chan = <&qmc 16>;

Where does this node live? 

QMC is this[1]? Why don't you just add the compatible to channel@10 in 
the QMC node?

Rob

[1] Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml

