Return-Path: <netdev+bounces-237176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96723C469A6
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 13:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B1C3B3ECD
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C61D3093C0;
	Mon, 10 Nov 2025 12:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vojs3Ny7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9F42FE585;
	Mon, 10 Nov 2025 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777786; cv=none; b=bd60k5uwBmRF3qNf2q2tuH5jPb0iVo9TEABDPaerQQCMsBD4dzXMTZv+NKXVmh0j+ZYPnqUBqF/SjSOYXqzhhSHQ4G6YsducrGC8EBoOnY6vE/dKTyrExI18/xbJp0P3lLnwJBGC94miImfazq/Bag7BeRBUWH4c0b4H2rkzn/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777786; c=relaxed/simple;
	bh=CHqHQvKuqRvxJRHlw0G9YM2cvk8+dDccmko+WcI99KA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ppM1OBJDbmTsEuOtQEURYcw4fAq0lVQiQO5SEDk7Dxke2h7/2GQn3GQwh1tJGBEcBOxOQ+3QTmc7h6wSCW+FmgquG8B3ISHLhvtp2VYAaLvcq3lEhuL8/tHaH+3z49mII3MiATS+fht15br6iemUwsU6CAZ1PnwZRCFvn/CwIZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vojs3Ny7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384CFC16AAE;
	Mon, 10 Nov 2025 12:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762777785;
	bh=CHqHQvKuqRvxJRHlw0G9YM2cvk8+dDccmko+WcI99KA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Vojs3Ny7+r1bvs7xTzB+Em17tnHg4ejqwiAsKUBRNYBKq2ESJ8HM7869IXkyne2Ic
	 kQYYlyBmu1zFWRa+XAKfg+syhhn8K7Ke/Aot2v11KTSHp0E+iUNBkh4cD9IDovyqLm
	 I3qy+942BJ+DIqcDZ5xo75PyknQcArDRNJRFGjwoGZrHJkkyzGqNWYn6yS5v1Sfu+F
	 T3edgQ6vZ1QXPQogA+ippFN1frbOwGnby77b3KjRDBEAT/mjKLLSmsiCAn4JPUwmez
	 yfrUUnoHWOXIgAiE4QYBaHHoDbQ7usE/VbAQ4+F+cBaKnNnNbymnEDKXE29apneaw/
	 xxSWFOH6NdReg==
Date: Mon, 10 Nov 2025 06:29:43 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, netdev@vger.kernel.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 taoren@meta.com, Po-Yu Chuang <ratbert@faraday-tech.com>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-aspeed@lists.ozlabs.org
To: Jacky Chou <jacky_chou@aspeedtech.com>
In-Reply-To: <20251110-rgmii_delay_2600-v4-1-5cad32c766f7@aspeedtech.com>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-1-5cad32c766f7@aspeedtech.com>
Message-Id: <176277778351.3693581.6347765163045847296.robh@kernel.org>
Subject: Re: [PATCH net-next v4 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600


On Mon, 10 Nov 2025 19:09:25 +0800, Jacky Chou wrote:
> The AST2600 contains two dies, each with its own MAC, and these MACs
> require different delay configurations.
> Previously, these delay values were configured during the bootloader
> stage rather than in the driver. This change introduces the use of the
> standard properties defined in ethernet-controller.yaml to configure
> the delay values directly in the driver.
> 
> Add the new property, "aspeed,rgmii-delay-ps", to specify per step of
> RGMII delay in different MACs. And for Aspeed platform, the total steps
> of RGMII delay configuraion is 32 steps, so the total delay is
> "apseed,rgmii-delay-ps' * 32.
> Default delay values are declared so that tx-internal-delay-ps and
> rx-internal-delay-ps become optional. If these properties are not present,
> the driver will use the default values instead.
> Add conditional schema constraints for Aspeed AST2600 MAC controllers:
> - For MAC0/1, aspeed,rgmii-delay-ps property is 45 ps
> - For MAC2/3, aspeed,rgmii-delay-ps property is 250 ps
> - Both require the "aspeed,scu" and "aspeed,rgmii-delay-ps" properties.
> Other compatible values remain unrestricted.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../devicetree/bindings/net/faraday,ftgmac100.yaml | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml: properties:aspeed,rgmii-delay-ps: 'anyOf' conditional failed, one must be fixed:
	'maxItems' is a required property
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'type' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('type' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'type' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/cell.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml: properties:aspeed,rgmii-delay-ps:type: 'integer' is not one of ['boolean', 'object']
	from schema $id: http://devicetree.org/meta-schemas/core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251110-rgmii_delay_2600-v4-1-5cad32c766f7@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


