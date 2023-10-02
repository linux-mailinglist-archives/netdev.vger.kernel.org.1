Return-Path: <netdev+bounces-37467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D792B7B5714
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 18:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B1DFB1C2081F
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 16:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5009F1D6BC;
	Mon,  2 Oct 2023 16:08:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD171D699;
	Mon,  2 Oct 2023 16:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAD3C433C7;
	Mon,  2 Oct 2023 16:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696262924;
	bh=A8RHgRJTdq1YDreXk6pMR2+4zGGe3daZlhUNpP+YvT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHpSZwV+lJDbbehLSb/Spt3d5nct5tqN+zguTdzkPGP78BtxJA5slWfkTHCE8nFQo
	 5Yp3/oCpoJUvujCt8oxxEYnhBkzbbfdWcUXXSLMC2qKfBUPFd2AhM75roBWtzG12r+
	 zyO3n4G2YX0Ps18ARR/RDgmN7gspcIylPGhayXOz1Z3HxoUpPcb7dfOrvn+RuO5jOI
	 k2O/32V4DaM8k2gyvWyggG3PutfRoMw1ofZehwhbd+Ft3ixdNjLhr1VYMPu4nJnQko
	 xeOCGFGk/lxGzbnX61GXQT0EuQIbzaoX+ArQPRhaz4CGLZCfceZXmw3nFUYhiiDYic
	 5M3ipz/e+xiTA==
Received: (nullmailer pid 1849866 invoked by uid 1000);
	Mon, 02 Oct 2023 16:08:40 -0000
Date: Mon, 2 Oct 2023 11:08:40 -0500
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: linux-kernel@vger.kernel.org, Xiubo Li <Xiubo.Lee@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org, "David S. Miller" <davem@davemloft.net>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, Qiang Zhao <qiang.zhao@nxp.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Li Yang <leoyang.li@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-gpio@vg.smtp.subspace.kernel.org,
	er.kernel.org@web.codeaurora.org, Takashi Iwai <tiwai@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v7 25/30] dt-bindings: net: Add the Lantiq PEF2256
 E1/T1/J1 framer
Message-ID: <169626292036.1849826.7381200671829119399.robh@kernel.org>
References: <20230928070652.330429-1-herve.codina@bootlin.com>
 <20230928070652.330429-26-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928070652.330429-26-herve.codina@bootlin.com>


On Thu, 28 Sep 2023 09:06:43 +0200, Herve Codina wrote:
> The Lantiq PEF2256 is a framer and line interface component designed to
> fulfill all required interfacing between an analog E1/T1/J1 line and the
> digital PCM system highway/H.100 bus.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  .../bindings/net/lantiq,pef2256.yaml          | 213 ++++++++++++++++++
>  1 file changed, 213 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/lantiq,pef2256.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


