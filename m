Return-Path: <netdev+bounces-33351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A51979D832
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 19:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162171C20C3C
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 17:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F95944D;
	Tue, 12 Sep 2023 17:58:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D84F9448
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 17:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2528FC433C7;
	Tue, 12 Sep 2023 17:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694541516;
	bh=JEv/PdS67apPPBjdgQMt1j8LrthrJDQTeiNjt0wyv5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ithTbuEXHG9CuKyDzU3aAaCHAG1P5uJ5YZbd/qweVdrPAF5pV7q7RtR/HDfMyoDOP
	 H822WkrV5CX4Fq+iFeCsXJMz6BnLIRGwSZYcP9aLlnEZn+VGPTqWZwMDnA/4VTCMhL
	 RLWVZq784lcSovlKvyvzkikfqvqSPOGJ2kBqOc4ciFw49KfsGmoqipaSJf7O28ZeN6
	 Ec3DP2VTHfvStE6eYO90HFNMGgq5SSVEeaOppqUqVhAZP+STV1pZJ398noPJDUdqFX
	 fLqH+2Mch4T41Qw/5FTmWDbezjrCBXuiZlwAyQ23NO0J1w9sN0D4Ywp4Vq4VtwwhJR
	 pREO8HFu0mPfA==
Received: (nullmailer pid 998213 invoked by uid 1000);
	Tue, 12 Sep 2023 17:58:32 -0000
Date: Tue, 12 Sep 2023 12:58:32 -0500
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	Simon Horman <"hor ms"@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 06/31] dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc:
 Fix example property name
Message-ID: <20230912175832.GA995540-robh@kernel.org>
References: <20230912081527.208499-1-herve.codina@bootlin.com>
 <20230912081527.208499-7-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912081527.208499-7-herve.codina@bootlin.com>

On Tue, Sep 12, 2023 at 10:14:57AM +0200, Herve Codina wrote:
> The given example mentions the 'fsl,mode' property whereas the
> correct property name, the one described, is 'fsl,operational-mode'.
> 
> Fix the example to use the correct property name.
> 
> Fixes: a9b121327c93 ("dt-bindings: soc: fsl: cpm_qe: Add QMC controller")
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml           | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I have this same fix in my tree, but you missed something. Please add 
additionalProperties or unevaluatedProperties to the child node schema 
so that this error is flagged.

> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
> index ec888f48cac8..450a0354cb1d 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
> +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
> @@ -137,7 +137,7 @@ examples:
>          channel@16 {
>              /* Ch16 : First 4 even TS from all routed from TSA */
>              reg = <16>;
> -            fsl,mode = "transparent";
> +            fsl,operational-mode = "transparent";
>              fsl,reverse-data;
>              fsl,tx-ts-mask = <0x00000000 0x000000aa>;
>              fsl,rx-ts-mask = <0x00000000 0x000000aa>;
> @@ -146,7 +146,7 @@ examples:
>          channel@17 {
>              /* Ch17 : First 4 odd TS from all routed from TSA */
>              reg = <17>;
> -            fsl,mode = "transparent";
> +            fsl,operational-mode = "transparent";
>              fsl,reverse-data;
>              fsl,tx-ts-mask = <0x00000000 0x00000055>;
>              fsl,rx-ts-mask = <0x00000000 0x00000055>;
> @@ -155,7 +155,7 @@ examples:
>          channel@19 {
>              /* Ch19 : 8 TS (TS 8..15) from all routed from TSA */
>              reg = <19>;
> -            fsl,mode = "hdlc";
> +            fsl,operational-mode = "hdlc";
>              fsl,tx-ts-mask = <0x00000000 0x0000ff00>;
>              fsl,rx-ts-mask = <0x00000000 0x0000ff00>;
>          };
> -- 
> 2.41.0
> 

