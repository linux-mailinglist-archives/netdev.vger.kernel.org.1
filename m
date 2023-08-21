Return-Path: <netdev+bounces-29367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C380C782F37
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02F81C2091B
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 17:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691B68C00;
	Mon, 21 Aug 2023 17:12:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2E2F2B
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A083C433C8;
	Mon, 21 Aug 2023 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692637967;
	bh=pecT+7jt2WFbXfJOVTRSd9o3RBK/Imr4a3p3S+M/2x4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4U/ZhLydZ7TzaxBv+r0Ch2NVqY7bI4P84YF474cteSwc/8gpGPpXXr5iKbPPHc3Q
	 CzWJg3qW2J9WktqjWOKHZMOyvto9vQNEyWcCPjCyx+aABrFoaPcO2pKsZgSRoHtgwU
	 tM/Suhol2ESmfpub9Jiypc7ok56BnzExf039SiXVTigfExNTHbOz6eTegmmcB7l5md
	 GTazQjsnarYCoQhfjMcbJ2AWtOlatA5JowGK6WkDc9qJQOEyZmCaurB2g2guXabLBL
	 cgpRxS98pCfScD2RFFQMLIrcqxuy5FdfaCiDpwk/FYlBJDZcBNqQgdXE2mbfNieLeX
	 IJqlKMF+abvIw==
Received: (nullmailer pid 1975482 invoked by uid 1000);
	Mon, 21 Aug 2023 17:12:44 -0000
Date: Mon, 21 Aug 2023 12:12:44 -0500
From: Rob Herring <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: display: imx: hdmi: Allow 'reg' and
 'interrupts'
Message-ID: <20230821171244.GA1963855-robh@kernel.org>
References: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
 <20230810144451.1459985-4-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810144451.1459985-4-alexander.stein@ew.tq-group.com>

On Thu, Aug 10, 2023 at 04:44:48PM +0200, Alexander Stein wrote:
> Although defined in synopsys,dw-hdmi.yaml, they need to explicitly allowed
> in fsl,imx6-hdmi.yaml. Fixes the warning:
> arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dtb: hdmi@120000: 'interrupts',
>  'reg' do not match any of the regexes: 'pinctrl-[0-9]+'
>  From schema: Documentation/devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml
> 
> Fixes: b935c3a2e07b ("dt-bindings: display: imx: hdmi: Convert binding to YAML")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  .../devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml         | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml
> index af7fe9c4d196..d6af28e86ab4 100644
> --- a/Documentation/devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml
> @@ -22,6 +22,9 @@ properties:
>        - fsl,imx6dl-hdmi
>        - fsl,imx6q-hdmi
>  
> +  reg: true
> +  interrupts: true
> +

You should change additionalProperties to unevaluatedProperties instead.

Rob

