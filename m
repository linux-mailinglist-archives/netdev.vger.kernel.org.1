Return-Path: <netdev+bounces-35911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C16B7ABB03
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 23:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 814EE1C20905
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 21:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657EE47372;
	Fri, 22 Sep 2023 21:22:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C94D9CA5C;
	Fri, 22 Sep 2023 21:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73FFC433C8;
	Fri, 22 Sep 2023 21:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695417737;
	bh=lmE8y4Naioq26myIwcGDskn3NlpSCo/s3ZeWn2dloK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nv4Cz9sw3ckJXfg8gZo7FWOFFfqKqYySpjfLY7cZhQEb3LyIpaBvywrHA5M7C21Gc
	 mcsEqkC8cx13Dy8R/0X9lYJTpyRNr1qeElcsH00EHluLpOe3wRmDsUaEfIDdc00HgN
	 YZ5dnQxIkGqFegnvjx8fmrE8SjNnqVDUNMtF6lnOb5ybGvy1egpqEP36TNfvlgqqAO
	 kv5OnNDigOmYh5tnIGwghQpSuqDTEEDzwtyzW8MsyYi2xdU3YdARgKPEIx0roJsDT1
	 QMAlycnsTsH07IM9iuVX100coPa5Ms77i08JVt5XAfgf3pojKcODfR7zRW+tGBrVPO
	 6Cus0vP5Brspw==
Received: (nullmailer pid 3638530 invoked by uid 1000);
	Fri, 22 Sep 2023 21:22:12 -0000
Date: Fri, 22 Sep 2023 16:22:12 -0500
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Jakub Kicinski <kuba@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>, Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, netdev@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Mark Brown <broonie@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Krzysztof K
 ozlowski <krzysztof.kozlowski+dt@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Jaroslav Kysela <perex@perex.cz>, Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH v6 08/30] dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc:
 Add support for QMC HDLC
Message-ID: <169541773236.3638470.1013241809358556101.robh@kernel.org>
References: <20230922075913.422435-1-herve.codina@bootlin.com>
 <20230922075913.422435-9-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922075913.422435-9-herve.codina@bootlin.com>


On Fri, 22 Sep 2023 09:58:43 +0200, Herve Codina wrote:
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
> ---
>  .../soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml      | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


