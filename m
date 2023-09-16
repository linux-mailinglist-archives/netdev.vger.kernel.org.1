Return-Path: <netdev+bounces-34306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A70C37A3102
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 16:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6842823F0
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 14:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD311427F;
	Sat, 16 Sep 2023 14:58:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805271427D;
	Sat, 16 Sep 2023 14:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF786C433B6;
	Sat, 16 Sep 2023 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694876330;
	bh=s3qKgkDQcOTLfmk3Vtd9Ln4ddC86Uw8bgcAEvHXf/og=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tA8GEMMEdOnIsbWQA5ho+sBZyHo2o7hiHsMRbHdh/UThjmWSb7PBhAk6IcuQLrfFu
	 ssdxlxB7rsFkI3P44jmZznVvI8R9O/2t2rkwbbvW9mTQt7F/FnDWGa4/VgfcFocMmf
	 JagWeITxDt+wYD6LrwxAyzP3fkXCt9YDK7Lp4gVhQr9DBRdo1bRIUssDork+uhgE0H
	 /M8fzH3xa2vIUnj1PMKBjmQW+wAjVaMnxno+5lt0GGZGxGO0TbGKM8xgeZXRkLExRm
	 +ZH7sO/uguQ803tKo2gy75SyYS8icdb997qyda2JZ+ILGVMSiR42S2ib+GkqxcYeso
	 9RqdHzDM56H8w==
Received: (nullmailer pid 1637985 invoked by uid 1000);
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
Cc: Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, mithat.guner@xeront.com, Woojung Huh <Woojung.Huh@microchip.com>, George McCollister <george.mccollister@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Oleksij Rempel <linux@rempel-privat.de>, Grygorii Strashko <grygorii.strashko@ti.com>, Kurt Kanzenbach <kurt@linutronix.de>, Steen Hegelund <steen.hegelund@microchip.com>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "David S. Miller" <davem@davemloft.net>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Paolo Abeni <pabeni@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmai
 l.com>, Lars Povlsen <lars.povlsen@microchip.com>, Marek Vasut <marex@denx.de>, Jose Abreu <joabreu@synopsys.com>, Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, Claudiu Beznea <claudiu.beznea@microchip.com>, netdev@vger.kernel.org, Shyam Pandey <radhey.shyam.pandey@xilinx.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, "Russell King (Oracle)" <linux@armlinux.org.uk>, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-arm-kernel@lists.infradead.org, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, erkin.bozoglu@xeront.com, Steen Hegelund <Steen.Hegelund@microchip.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Matthias Brugger <matthias.bgg@gmail.com>, Marcin Wojtas <mw@semihalf.com>, Felix Fietkau <nbd@nbd.name>, Horatiu Vultur <horatiu.vultur@microchip.com>, Eric Dumazet <edumazet@google.com>, Madalin Bucur <madalin.bucur@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Woojun
 g Huh <woojung.huh@microchip.com>, =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, Daniel Golle <daniel@makrotopia.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Sean Wang <sean.wang@mediatek.com>, Daniel Machon <daniel.machon@microchip.com>, Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, UNGLinuxDriver@microchip.com
In-Reply-To: <20230916110902.234273-9-arinc.unal@arinc9.com>
References: <20230916110902.234273-1-arinc.unal@arinc9.com>
 <20230916110902.234273-9-arinc.unal@arinc9.com>
Message-Id: <169487631004.1637924.11195328221220782623.robh@kernel.org>
Subject: Re: [PATCH net-next v2 08/10] dt-bindings: net: dsa: marvell:
 convert to json-schema
Date: Sat, 16 Sep 2023 09:58:30 -0500


On Sat, 16 Sep 2023 14:09:00 +0300, Arınç ÜNAL wrote:
> Convert the document for Marvell ethernet switches to json-schema.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../devicetree/bindings/net/dsa/marvell.txt   | 109 ----------
>  .../devicetree/bindings/net/dsa/marvell.yaml  | 204 ++++++++++++++++++
>  2 files changed, 204 insertions(+), 109 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/dsa/marvell.txt
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/marvell.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/marvell.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/marvell.yaml#
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
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/_validators.py", line 414, in if_
    yield from validator.descend(instance, then, schema_path="then")
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 305, in descend
    for error in self.evolve(schema=schema).iter_errors(instance):
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 288, in iter_errors
    for error in errors:
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/_validators.py", line 25, in patternProperties
    yield from validator.descend(
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 305, in descend
    for error in self.evolve(schema=schema).iter_errors(instance):
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 288, in iter_errors
    for error in errors:
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/_validators.py", line 25, in patternProperties
    yield from validator.descend(
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
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/net/dsa/marvell.txt
MAINTAINERS: Documentation/devicetree/bindings/net/dsa/marvell.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230916110902.234273-9-arinc.unal@arinc9.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


