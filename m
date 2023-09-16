Return-Path: <netdev+bounces-34305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8767A30FD
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 16:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276AC282444
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 14:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB31426D;
	Sat, 16 Sep 2023 14:58:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D0413FFC;
	Sat, 16 Sep 2023 14:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4464EC433CD;
	Sat, 16 Sep 2023 14:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694876323;
	bh=nAF7SoFTTT83XlkIblCDfbKfQxBav5KTtp5o5xgO7po=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oEwdP5oMti3P64jbch9p6FOaETOHUjJQKR5UvTNtHvtuN+DXJR5HbnwvjDaIRhZfa
	 A98Cm5N3jQyHHfpnWjHm2+X8489WGwJBhV+/r59Q0e4t8pnIuJCIMlC/zBlznj0XJK
	 31PO+RtSZWpUwoZAJy7ibNjwHfANjpUbwmtXc0oI1vCXslNwGhtC4IMenRfSUc+t6W
	 kGd5M6YVCoFBuWEY+RH2y16XtJsDQHu8TVj2SFeHWfv+876YKkZsSGLH2EKHT6Yfu1
	 zbJlS3Xt40G/LX3D2UyOhFEroygf5zol0xRUWIDWX+B+lcBUZs7o1TQCiZ48sB6lTS
	 6aKdaF5nusdMA==
Received: (nullmailer pid 1637987 invoked by uid 1000);
	Sat, 16 Sep 2023 14:58:30 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Sean Wang <sean.wang@mediatek.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Woojung Huh <Woojung.Huh@microchip.com>, John Crispin <john@phrozen.org>, linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, Oleksij Rempel <linux@rempel-privat.de>, Shyam Pandey <radhey.shyam.pandey@xilinx.com>, Andrew Lunn <andrew@lunn.ch>, Steen Hegelund <steen.hegelund@microchip.com>, linux-kernel@vger.kernel.org, =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, Daniel Machon <daniel.machon@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, UNGLinuxDriver@microchip.com, Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Marcin Wojtas <mw@semihalf.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, "David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@mi
 crochip.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Vladimir Oltean <olteanv@gmail.com>, Claudiu Beznea <claudiu.beznea@microchip.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Golle <daniel@makrotopia.org>, Steen Hegelund <Steen.Hegelund@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-arm-kernel@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>, Rob Herring <robh+dt@kernel.org>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Marek Vasut <marex@denx.de>, Claudiu Manoil <claudiu.manoil@nxp.com>, Sekhar Nori <nsekhar@ti.com>, Lars Povlsen <lars.povlsen@microchip.com>, Kurt Kanzenbach <kurt@linutronix.de>, Jose Abreu <joabreu@synopsys.com>, Madalin Bucur <madalin.bucur@nxp.com>, netdev@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, Magnus Damm <magnus.damm@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Jakub Kicinski <
 kuba@kernel.org>, mithat.guner@xeront.com, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, Matthias Brugger <matthias.bgg@gmail.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, George McCollister <george.mccollister@gmail.com>, erkin.bozoglu@xeront.com, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20230916110902.234273-11-arinc.unal@arinc9.com>
References: <20230916110902.234273-1-arinc.unal@arinc9.com>
 <20230916110902.234273-11-arinc.unal@arinc9.com>
Message-Id: <169487631064.1637966.13545721653989465162.robh@kernel.org>
Subject: Re: [PATCH net-next v2 10/10] dt-bindings: net:
 marvell-armada-370-neta: convert to json-schema
Date: Sat, 16 Sep 2023 09:58:30 -0500


On Sat, 16 Sep 2023 14:09:02 +0300, Arınç ÜNAL wrote:
> Convert the document for Marvell Armada 370 / Armada XP / Armada 3700
> Ethernet Controller (NETA) to json-schema.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../bindings/net/marvell-armada-370-neta.txt  |  50 ---------
>  .../bindings/net/marvell-armada-370-neta.yaml | 102 ++++++++++++++++++
>  2 files changed, 102 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
>  create mode 100644 Documentation/devicetree/bindings/net/marvell-armada-370-neta.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell-armada-370-neta.yaml:
Unresolvable JSON pointer: '$defs/phylink'
Traceback (most recent call last):
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 966, in resolve_fragment
    document = document[part]
               ~~~~~~~~^^^^^^
KeyError: '$defs'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/bin/dt-validate", line 146, in <module>
    sg.check_dtb(filename)
  File "/usr/local/bin/dt-validate", line 96, in check_dtb
    self.check_subtree(dt, subtree, False, "/", "/", filename)
  File "/usr/local/bin/dt-validate", line 89, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
  File "/usr/local/bin/dt-validate", line 89, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
  File "/usr/local/bin/dt-validate", line 84, in check_subtree
    self.check_node(tree, subtree, disabled, nodename, fullname, filename)
  File "/usr/local/bin/dt-validate", line 40, in check_node
    for error in self.validator.iter_errors(node, filter=match_schema_file):
  File "/usr/local/lib/python3.11/dist-packages/dtschema/validator.py", line 391, in iter_errors
    for error in self.DtValidator(sch,
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 288, in iter_errors
    for error in errors:
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/_validators.py", line 414, in if_
    yield from validator.descend(instance, then, schema_path="then")
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 305, in descend
    for error in self.evolve(schema=schema).iter_errors(instance):
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 288, in iter_errors
    for error in errors:
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/_validators.py", line 362, in allOf
    yield from validator.descend(instance, subschema, schema_path=index)
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 305, in descend
    for error in self.evolve(schema=schema).iter_errors(instance):
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 288, in iter_errors
    for error in errors:
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/_validators.py", line 294, in ref
    scope, resolved = validator.resolver.resolve(ref)
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 898, in resolve
    return url, self._remote_cache(url)
                ^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 916, in resolve_from_url
    return self.resolve_fragment(document, fragment)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 968, in resolve_fragment
    raise exceptions.RefResolutionError(
jsonschema.exceptions.RefResolutionError: Unresolvable JSON pointer: '$defs/phylink'

doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/net/marvell-neta-bm.txt references a file that doesn't exist: Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
Documentation/devicetree/bindings/net/marvell-neta-bm.txt: Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230916110902.234273-11-arinc.unal@arinc9.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


