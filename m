Return-Path: <netdev+bounces-244827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A18CBF63A
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 19:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C865B3058E4B
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 18:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17976338904;
	Mon, 15 Dec 2025 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzOopvwP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4C338582;
	Mon, 15 Dec 2025 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765822182; cv=none; b=SkD4Ve5BLfiefMrSz8d+o9sVMmG1GcB+9gFJnO3qzvYpjGnXYRqWb4uOFQConu+RwY33T6GLkV4GiZ5eejj3EpXP0juw6e53qdpsY9TYqy2kwNVXHtDhWmOKJbsxVdlNPy+TVF0UPsad9VN/nDcH7LXbnAzNyMMe+jpSDTgsoPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765822182; c=relaxed/simple;
	bh=sJ0PanZdlGRt6sE05Z//hl9xXWQ8gP2sHeCPp+9cNxU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=pdRWd1G/MhKXdzpIG7oBkrMjVgQc/ifzY69ZV7AJ3iLhGER/mHksktdfA8SHpiKShcy/JUDIGASCtCMP2uhkLjvI8mdLaz1A7d4ERWbZ8CC/eVD/cZ0QvpecNf+dIelkBj8H4fG/5YNuzE1ixbXSvOC8q5o+SE5L44e5I8f4r98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzOopvwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15912C4CEF5;
	Mon, 15 Dec 2025 18:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765822181;
	bh=sJ0PanZdlGRt6sE05Z//hl9xXWQ8gP2sHeCPp+9cNxU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=mzOopvwPU06fZET1fGgc81omur+ilBqKE/gwOHBKK2/m+tqXHJ/fPogQbHHDBSDqY
	 k2I2Gk2eZKPb1QMeM/woGiSgPimAA7KT7pBj1ODgKIAB4CO6nEvrnxaqvzkoSPHnDg
	 WaXrXRxMt+JZgW5547zfjtIGTvFlewpbxg9Jzrael5Utudzwg7f4tDGt9mzN+9jEqC
	 c6ehZ1pN+53tCpdcipvNKNAdAc9Kn39/ttnjctzlnw2qhj0qsEDieOk3TqAb2F0zLR
	 f4vTiDRuzKardG6Bg3z+IoVlHpmaIFtUSeh6ZmhQe5fSgcyjeWmVI9L1MDjvJB/lEp
	 3Ok0ToWxDdbWQ==
Date: Mon, 15 Dec 2025 12:09:39 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Chester Lin <chester62515@gmail.com>, 
 Matthias Brugger <mbrugger@suse.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 linux-kernel@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, imx@lists.linux.dev, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 Conor Dooley <conor+dt@kernel.org>
To: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
In-Reply-To: <20251214-dwmac_multi_irq-v1-2-36562ab0e9f7@oss.nxp.com>
References: <20251214-dwmac_multi_irq-v1-0-36562ab0e9f7@oss.nxp.com>
 <20251214-dwmac_multi_irq-v1-2-36562ab0e9f7@oss.nxp.com>
Message-Id: <176582217911.3066791.4926710165988218857.robh@kernel.org>
Subject: Re: [PATCH RFC 2/4] dt-bindings: net: nxp,s32-dwmac: Declare
 per-queue interrupts


On Sun, 14 Dec 2025 23:15:38 +0100, Jan Petrous (OSS) wrote:
> The DWMAC IP on supported SoCs has connected queue-based IRQ lines.
> 
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---
>  .../devicetree/bindings/net/nxp,s32-dwmac.yaml     | 40 +++++++++++++++++++---
>  1 file changed, 36 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: ignoring, error in schema: properties: interrupt-names
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: properties:interrupt-names: [{'items': [{'const': 'macirq'}, {'const': 'rx-queue-0'}, {'const': 'tx-queue-0'}, {'const': 'rx-queue-1'}, {'const': 'tx-queue-1'}, {'const': 'rx-queue-2'}, {'const': 'tx-queue-2'}, {'const': 'rx-queue-3'}, {'const': 'tx-queue-3'}, {'const': 'rx-queue-4'}, {'const': 'tx-queue-4'}]}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: properties:interrupt-names: [{'items': [{'const': 'macirq'}, {'const': 'rx-queue-0'}, {'const': 'tx-queue-0'}, {'const': 'rx-queue-1'}, {'const': 'tx-queue-1'}, {'const': 'rx-queue-2'}, {'const': 'tx-queue-2'}, {'const': 'rx-queue-3'}, {'const': 'tx-queue-3'}, {'const': 'rx-queue-4'}, {'const': 'tx-queue-4'}]}] is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: properties:interrupt-names: [{'items': [{'const': 'macirq'}, {'const': 'rx-queue-0'}, {'const': 'tx-queue-0'}, {'const': 'rx-queue-1'}, {'const': 'tx-queue-1'}, {'const': 'rx-queue-2'}, {'const': 'tx-queue-2'}, {'const': 'rx-queue-3'}, {'const': 'tx-queue-3'}, {'const': 'rx-queue-4'}, {'const': 'tx-queue-4'}]}] is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: properties:interrupt-names: [{'items': [{'const': 'macirq'}, {'const': 'rx-queue-0'}, {'const': 'tx-queue-0'}, {'const': 'rx-queue-1'}, {'const': 'tx-queue-1'}, {'const': 'rx-queue-2'}, {'const': 'tx-queue-2'}, {'const': 'rx-queue-3'}, {'const': 'tx-queue-3'}, {'const': 'rx-queue-4'}, {'const': 'tx-queue-4'}]}] is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: properties:interrupt-names: [{'items': [{'const': 'macirq'}, {'const': 'rx-queue-0'}, {'const': 'tx-queue-0'}, {'const': 'rx-queue-1'}, {'const': 'tx-queue-1'}, {'const': 'rx-queue-2'}, {'const': 'tx-queue-2'}, {'const': 'rx-queue-3'}, {'const': 'tx-queue-3'}, {'const': 'rx-queue-4'}, {'const': 'tx-queue-4'}]}] is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: properties:interrupt-names: [{'items': [{'const': 'macirq'}, {'const': 'rx-queue-0'}, {'const': 'tx-queue-0'}, {'const': 'rx-queue-1'}, {'const': 'tx-queue-1'}, {'const': 'rx-queue-2'}, {'const': 'tx-queue-2'}, {'const': 'rx-queue-3'}, {'const': 'tx-queue-3'}, {'const': 'rx-queue-4'}, {'const': 'tx-queue-4'}]}] is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: properties:interrupt-names: [{'items': [{'const': 'macirq'}, {'const': 'rx-queue-0'}, {'const': 'tx-queue-0'}, {'const': 'rx-queue-1'}, {'const': 'tx-queue-1'}, {'const': 'rx-queue-2'}, {'const': 'tx-queue-2'}, {'const': 'rx-queue-3'}, {'const': 'tx-queue-3'}, {'const': 'rx-queue-4'}, {'const': 'tx-queue-4'}]}] is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: properties:interrupt-names: [{'items': [{'const': 'macirq'}, {'const': 'rx-queue-0'}, {'const': 'tx-queue-0'}, {'const': 'rx-queue-1'}, {'const': 'tx-queue-1'}, {'const': 'rx-queue-2'}, {'const': 'tx-queue-2'}, {'const': 'rx-queue-3'}, {'const': 'tx-queue-3'}, {'const': 'rx-queue-4'}, {'const': 'tx-queue-4'}]}] is not of type 'object', 'boolean'
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 8, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/doc_validate.py", line 66, in main
    ret |= check_doc(f)
           ~~~~~~~~~^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/doc_validate.py", line 37, in check_doc
    dtsch.check_schema_refs()
    ~~~~~~~~~~~~~~~~~~~~~~~^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 241, in check_schema_refs
    self._check_schema_refs(resolver, self)
    ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 212, in _check_schema_refs
    self._check_schema_refs(resolver, v, parent=k, is_common=is_common,
    ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                            has_constraint=has_constraint)
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 216, in _check_schema_refs
    self._check_schema_refs(resolver, schema[i], parent=parent, is_common=is_common,
    ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                            has_constraint=has_constraint)
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 203, in _check_schema_refs
    ref_sch = resolver.lookup(schema['$ref']).contents
              ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 682, in lookup
    retrieved = self._registry.get_or_retrieve(uri)
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 422, in get_or_retrieve
    registry = self.crawl()
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 500, in crawl
    id = resource.id()
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 231, in id
    id = self._specification.id_of(self.contents)
  File "/usr/local/lib/python3.13/dist-packages/referencing/jsonschema.py", line 50, in _dollar_id
    return contents.get("$id")
           ^^^^^^^^^^^^
AttributeError: 'list' object has no attribute 'get'
Lexical error: Documentation/devicetree/bindings/net/nxp,s32-dwmac.example.dts:58.13-17 Unexpected 'snps'
Error: Documentation/devicetree/bindings/net/nxp,s32-dwmac.example.dts:58.13-17 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:141: Documentation/devicetree/bindings/net/nxp,s32-dwmac.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1559: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20251214-dwmac_multi_irq-v1-2-36562ab0e9f7@oss.nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


