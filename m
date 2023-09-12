Return-Path: <netdev+bounces-33357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5125C79D87E
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 20:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740AF1C20F1E
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14255947B;
	Tue, 12 Sep 2023 18:16:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926F91C04
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 18:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FEEC433C8;
	Tue, 12 Sep 2023 18:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694542573;
	bh=jh5T5UyTegwwkeivH1ZRwP9K8owrs1S2MNDdSEDICis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IR/OMxa+L/bn1llX2o1lzvlA23d6gd9+e4J/5n+gNZUlkl5qVwDFTgM229ZQ02Ic2
	 VfRf2BmYijB+VI6390vsTYIKDqeKXxto/q8crI/8TX8BxRjVK/RUxqRQZilOMBwi+/
	 2fYTPQIZB1wTptoIp/d6wiYH90WyhiRSdC5dtgSD0m37vpG/N/W97GXw0N/vMZlYMP
	 +zgqa/euRQfMYKkLwNBcIl87bdS28ZoeNUALmlv+5W5iYWqfRfXzFSKBu82MyvXjGe
	 4763B2z9gcCo2GD81Pa9cpgRE6z/q+0LRRpwbwuP5VcbDgpxxk7CpQ3EK+b4M3EHyG
	 HiyoyYLJ1g78Q==
Received: (nullmailer pid 1126678 invoked by uid 1000);
	Tue, 12 Sep 2023 18:16:08 -0000
Date: Tue, 12 Sep 2023 13:16:08 -0500
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
Message-ID: <20230912181608.GA1111902-robh@kernel.org>
References: <20230912081527.208499-1-herve.codina@bootlin.com>
 <20230912081527.208499-7-herve.codina@bootlin.com>
 <20230912175832.GA995540-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912175832.GA995540-robh@kernel.org>

On Tue, Sep 12, 2023 at 12:58:32PM -0500, Rob Herring wrote:
> On Tue, Sep 12, 2023 at 10:14:57AM +0200, Herve Codina wrote:
> > The given example mentions the 'fsl,mode' property whereas the
> > correct property name, the one described, is 'fsl,operational-mode'.
> > 
> > Fix the example to use the correct property name.
> > 
> > Fixes: a9b121327c93 ("dt-bindings: soc: fsl: cpm_qe: Add QMC controller")
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  .../bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml           | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> I have this same fix in my tree, but you missed something. Please add 
> additionalProperties or unevaluatedProperties to the child node schema 
> so that this error is flagged.

NM, I see the next patch now.

Acked-by: Rob Herring <robh@kernel.org>

