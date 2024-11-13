Return-Path: <netdev+bounces-144327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 256A29C6923
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 07:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED7C28487F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0BD1632EE;
	Wed, 13 Nov 2024 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmCQpJzd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218555680;
	Wed, 13 Nov 2024 06:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731478544; cv=none; b=PwyLvtLJ8gH7fS6fXuTFG3xqDRK8NHLwC5eyDAZq1dO8oXM6LTdoQ9obiY7O4IqdRc7zTA5r7/19FAg7dJ2n3EaJ7r3eSFf7yP3WdLWkelQAvHYzGuwh5IJ82z+byM58EaQJmck+ddecMUs3gbbDML4xBMsuCM2IjcvXRoDM07Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731478544; c=relaxed/simple;
	bh=GjHWsGBW2+fujolM2tMANHwifuU0meTtmmBJ4b3ZT90=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=DwuAmxN7pKZPiDB7sQz+k5vGu2hhlf4zUxmtCEB8N69YY368mn/jeZVlrpMTVfeWcqqhM9LDrQQBqrwNwKtuLdJY7J9y86gigfGWxieHHjiDR6qhWuPugO9GqQJbIrPm2T2q/g1kz5sOGY75i9INV93yH3c6mkEmUDbJd9DIjn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmCQpJzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79179C4CECD;
	Wed, 13 Nov 2024 06:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731478543;
	bh=GjHWsGBW2+fujolM2tMANHwifuU0meTtmmBJ4b3ZT90=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=qmCQpJzd2ahwxFIOLRTrnGuJ+kFeMPsYIBS0aPzc4h3BS7MXPwxBhDuBL8P5XaAVZ
	 ABagjtywQEbi2AV19TGV+hMZuv1BAQm/m7PQ3X0xMx8RZoKhIjSZgsZR2Y2kxJlviP
	 awiL8oQ4Ow5oejzqmbTw1b1ZSiSncj/UAPO9/8WPAYy/NS0oPsBGMY3Vlgud8GBW1z
	 crzmwWXyqMqr4FtgIhDnkpiNeBkVZiK2OgEqFbei6V0tj6sgIZOAKw4NGehTYpWXZi
	 JFe8U+7qEtRnPbGFGznPKuQ12JJwPgCrsG4BE+fCaNz518ZMDIZ7pnY2xSV9Ri/qxX
	 QumlFfgbrpnSw==
Date: Wed, 13 Nov 2024 00:15:41 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, mcoquelin.stm32@gmail.com, davem@davemloft.net, 
 conor+dt@kernel.org, pabeni@redhat.com, richardcochran@gmail.com, 
 devicetree@vger.kernel.org, joabreu@synopsys.com, edumazet@google.com, 
 linux-kernel@vger.kernel.org, kuba@kernel.org, schung@nuvoton.com, 
 yclu4@nuvoton.com, ychuang3@nuvoton.com, 
 linux-stm32@st-md-mailman.stormreply.com, openbmc@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, alexandre.torgue@foss.st.com, 
 netdev@vger.kernel.org, andrew+netdev@lunn.ch
To: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <20241113051857.12732-2-a0987203069@gmail.com>
References: <20241113051857.12732-1-a0987203069@gmail.com>
 <20241113051857.12732-2-a0987203069@gmail.com>
Message-Id: <173147854152.3007386.10475661912425454611.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: net: nuvoton: Add schema for MA35
 family GMAC


On Wed, 13 Nov 2024 13:18:55 +0800, Joey Lu wrote:
> Create initial schema for Nuvoton MA35 family Gigabit MAC.
> 
> Signed-off-by: Joey Lu <a0987203069@gmail.com>
> ---
>  .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 170 ++++++++++++++++++
>  1 file changed, 170 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml: ignoring, error in schema: properties: compatible
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml: properties:compatible: [{'items': [{'enum': ['nuvoton,ma35d1-dwmac']}, {'const': 'snps,dwmac-3.70a'}]}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml: properties:compatible: [{'items': [{'enum': ['nuvoton,ma35d1-dwmac']}, {'const': 'snps,dwmac-3.70a'}]}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml: properties:clock-names: 'oneOf' conditional failed, one must be fixed:
	[{'const': 'stmmaceth'}, {'const': 'ptp_ref'}] is too long
	[{'const': 'stmmaceth'}, {'const': 'ptp_ref'}] is too short
	False schema does not allow 2
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml: properties:clocks: 'oneOf' conditional failed, one must be fixed:
	[{'description': 'MAC clock'}, {'description': 'PTP clock'}] is too long
	[{'description': 'MAC clock'}, {'description': 'PTP clock'}] is too short
	False schema does not allow 2
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.example.dtb: /example-0/ethernet@40120000: failed to match any schema with compatible: ['nuvoton,ma35d1-dwmac']
Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.example.dtb: /example-1/ethernet@40130000: failed to match any schema with compatible: ['nuvoton,ma35d1-dwmac']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241113051857.12732-2-a0987203069@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


