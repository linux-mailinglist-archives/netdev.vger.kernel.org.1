Return-Path: <netdev+bounces-35816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8758B7AB22F
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 14:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id E7D001F22EA3
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 12:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A621DDEC;
	Fri, 22 Sep 2023 12:33:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B9225100;
	Fri, 22 Sep 2023 12:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68252C433C7;
	Fri, 22 Sep 2023 12:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695386016;
	bh=RzoEDKgXA9Plve5Vj9i1yQ82lvCPe4tIm9i1J+xrNbo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WXWXW5xBiYKZk3MrZ3MFLRAgcBn0R31B8ZNj2AuqPCzk+0Wzk6sgKzXf7UHDyh/n0
	 dV4FcaGJTmvygVdouHHwRcrTHWKun9ktn8gwloWlIF7vCBQS1eWCq/O5AKOlDJVmnt
	 XLNSnLPYo1j9Gug2yMjntpdQjIWXPUeFu5xqBC7rC2UnpsFat6nj8TcuhfXh01qJUC
	 jeZGohmVpJSgSmtql/ZqFWiYyvRnDAsPOAm1VZJFoYdvCRBTE1apiup+5laG9NfQ9O
	 01D9CnITZPeK7d4eGlyMYc7adVzZk112bEqkg6sTtQpxhWLKexeAtRKB2ViyP8mOuY
	 j4yZ3wRBvNfYQ==
Received: (nullmailer pid 2919399 invoked by uid 1000);
	Fri, 22 Sep 2023 12:33:32 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org, Randy Dunlap <rdunlap@infradead.org>, Takashi Iwai <tiwai@suse.com>, Simon Horman <horms@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, netdev@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Christophe Leroy <christophe.leroy@csgroup.eu>, Nicolin Chen <nicoleotsuka@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org, Paolo Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Rob Herring <robh+dt@kernel.org>, Shengjiu Wan
 g <shengjiu.wang@gmail.com>, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>
In-Reply-To: <20230922075913.422435-26-herve.codina@bootlin.com>
References: <20230922075913.422435-1-herve.codina@bootlin.com>
 <20230922075913.422435-26-herve.codina@bootlin.com>
Message-Id: <169538601225.2919383.2942072541503354871.robh@kernel.org>
Subject: Re: [PATCH v6 25/30] dt-bindings: net: Add the Lantiq PEF2256
 E1/T1/J1 framer
Date: Fri, 22 Sep 2023 07:33:32 -0500


On Fri, 22 Sep 2023 09:59:00 +0200, Herve Codina wrote:
> The Lantiq PEF2256 is a framer and line interface component designed to
> fulfill all required interfacing between an analog E1/T1/J1 line and the
> digital PCM system highway/H.100 bus.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  .../bindings/net/lantiq,pef2256.yaml          | 214 ++++++++++++++++++
>  1 file changed, 214 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/lantiq,pef2256.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/lantiq,pef2256.yaml: properties:lantiq,data-rate-bps: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230922075913.422435-26-herve.codina@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


