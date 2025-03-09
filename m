Return-Path: <netdev+bounces-173365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A256EA58756
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 19:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB7C7A43F9
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DC120297A;
	Sun,  9 Mar 2025 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPxiRP5w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9840A2556E;
	Sun,  9 Mar 2025 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741546209; cv=none; b=TTjpEVjwfpqVE2aOrdujyf3kTnLLk3X7p1M82BYPYLGDdTV3kUIl5ttlyyFBXdhZqakMoXT6E7k6muhh4JzNBOd9dRbpnZq97dvnkaWyyvUAaYkT+80Z8KFHbwDe0GtZ4DRV8CDfGsKxjnTFRvBm/Vj+yWdKJ2pf+5/sHPPqsdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741546209; c=relaxed/simple;
	bh=DE7rxV5hRZWbRfzVNpNP3kMmumFkL5JphKjCeeXHOkA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=tavH+c4KW8fEFvdtCnUGVo43GnwjNaGTEUuzkrdebOYEWyb7JckNHBz5sTOwiNMaHdy/PxpR6e/3xRJ/kVLVT6jRx8SJxDEhpz3HSC6QOqkRf2cvb4roEw5uHBTlhQnCfLt+n+OeRiEEP/ADfnfmmdSoSuSlV1QTJeDnugjlg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPxiRP5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43868C4CEE3;
	Sun,  9 Mar 2025 18:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741546209;
	bh=DE7rxV5hRZWbRfzVNpNP3kMmumFkL5JphKjCeeXHOkA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=mPxiRP5wubFDs2aPs2uofBXSSevfhY1+Vm9j0ECn/EBxpR8GmpdAAS9JN9/M9jiCn
	 bXAdVXOtQA7TDMrMVZrWkoiOrH8W4VFYUB5+QgedAAAEu0FvBYYh/T/LvJk0Id6dOm
	 n1TOCKn3vIf+kEI+1+BzugoexCdqS1V8KvM4A8mBrtL6pv+lWRtxIN3LyG4Qik1/F7
	 T4NqvW5+siU69hRS6SDVjhKPWBjNWPe/EYL5WXGQ6YJAy52g11rbIVCP1cuDSlkk4r
	 ejdb/+osl4SG2D9m1hJQ6enPOVKfMLZzxGXfkuJjy8uMOPQ7MR/w0bevrgtyLQ1Y+j
	 bd+1kSKK2B3iw==
Date: Sun, 09 Mar 2025 13:50:07 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
 linux-mediatek@lists.infradead.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 upstream@airoha.com, linux-arm-kernel@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
 netdev@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Lee Jones <lee@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250309172717.9067-6-ansuelsmth@gmail.com>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
 <20250309172717.9067-6-ansuelsmth@gmail.com>
Message-Id: <174154620758.1888708.16493498235993467665.robh@kernel.org>
Subject: Re: [net-next PATCH v12 05/13] dt-bindings: mfd: Document support
 for Airoha AN8855 Switch SoC


On Sun, 09 Mar 2025 18:26:50 +0100, Christian Marangi wrote:
> Document support for Airoha AN8855 Switch SoC. This SoC expose various
> peripherals like an Ethernet Switch, a NVMEM provider and Ethernet PHYs.
> 
> It does also support i2c and timers but those are not currently
> supported/used.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/mfd/airoha,an8855.yaml           | 186 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 187 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/airoha,an8855.example.dtb: phy@1: $nodename:0: 'phy@1' does not match '^ethernet-phy(@[a-f0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/net/airoha,an8855-phy.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/airoha,an8855.example.dtb: phy@1: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/airoha,an8855-phy.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/airoha,an8855.example.dtb: phy@2: $nodename:0: 'phy@2' does not match '^ethernet-phy(@[a-f0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/net/airoha,an8855-phy.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/airoha,an8855.example.dtb: phy@2: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/airoha,an8855-phy.yaml#

doc reference errors (make refcheckdocs):
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.yaml
MAINTAINERS: Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250309172717.9067-6-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


