Return-Path: <netdev+bounces-33358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC3979D899
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 20:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C74B1C20F05
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621D6A921;
	Tue, 12 Sep 2023 18:23:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFEB8F7D
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 18:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8926BC433C7;
	Tue, 12 Sep 2023 18:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694543030;
	bh=9PjwsXYdvGXo7MUL7wecpovXv5ZiPln8ttPB8U75U30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WiVa/+22NCGW7IrffV01g/GdWC+ihuiANID47Be41qQQoSSJ9MWdaOfhEb9E0Q5VN
	 +r4kMs1yWdxu3fZxSMVAhcb1TNaDtndauRq5uWXU7mBetG9qmN4n6Ms8G4M3GnEpT6
	 IL8BpNw0B4f3QGsuR4iJODP+YKbeKGtOxcoRwXCmSfOmpw58KNwvZgqZoqFU46XehM
	 k5yjfS85vh+C4lBLsV3Gf18j3jx11EzTme/IAilZ+vPSeoagRxi7yNKtU2wB8T0SMM
	 fviEL+q+o20LzIhi5DMS0RPSpg2+62je5UWbBK2PUNRUJjbewFTZnJJWrRJjpUPVGS
	 Iyia4kBEwqV/g==
Received: (nullmailer pid 1158307 invoked by uid 1000);
	Tue, 12 Sep 2023 18:23:46 -0000
Date: Tue, 12 Sep 2023 13:23:46 -0500
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Nicolin Chen <nicoleotsuka@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Qiang Zhao <qiang.zhao@nxp.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Fabio Estevam <festevam@gmail.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Eric Dumazet <edumazet@google.com>, Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, devicetree@vger.kernel.org, Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Jaroslav Kysel
 a <perex@perex.cz>, Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v5 07/31] dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc:
 Add 'additionalProperties: false' in child nodes
Message-ID: <169454302597.1158257.5413851001884233921.robh@kernel.org>
References: <20230912081527.208499-1-herve.codina@bootlin.com>
 <20230912081527.208499-8-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912081527.208499-8-herve.codina@bootlin.com>


On Tue, 12 Sep 2023 10:14:58 +0200, Herve Codina wrote:
> Additional properties in child node should not be allowed.
> 
> Prevent them adding 'additionalProperties: false'
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


