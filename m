Return-Path: <netdev+bounces-230884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CCABF0FCC
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 14:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EF23AC102
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4783F2F3C19;
	Mon, 20 Oct 2025 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6d3ZFZQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A83E208D0;
	Mon, 20 Oct 2025 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961942; cv=none; b=izdAdomigohDJ6fHbQXDd7X+ioY34iJx1x+O9pySKQTjAlsV3ZpH6VbOXLmuroT4BPEn9CMhJpV4w2S3OmQOjs1QljfVpTxl1cGbfc7KOE+4xX4EbNnc7a0Mof8ZXt5Pp2yanguEjLmo1QKy/XyM++Uvt2PQ8coEzDr36A8mnCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961942; c=relaxed/simple;
	bh=E4WIZb94VFhTqzi+aDX1vJifr1WIC9U+ZUXLJ7Ld2B4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=nrF4PcMdVyEHSQocHGLU8OZW/6ZiqnkOqHEX7dVSdo/WBIz/BjgddcAxYRkx22pmb0uuBySGXagoITLqIof6IxKU7mqMvZT9uF9kzI4SJrgdGxa6kscoZpwo9CIB5kAr2NFolBc76rV5JmU3nNoSxqqZtE37HcTnfhUbUm5Q5Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6d3ZFZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F1BC4CEF9;
	Mon, 20 Oct 2025 12:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760961941;
	bh=E4WIZb94VFhTqzi+aDX1vJifr1WIC9U+ZUXLJ7Ld2B4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Y6d3ZFZQusyCn275mQM8m6fv+vlFbWdyQgK1qBx2RBm2w129gB3UGUUQqJrI1KbGh
	 dRLa8UTq7a2oN/8opFrWdcm7Tmjms5qQrNAlh/mBdBEN8ROsQ36K5Oirlzl9ZRhf/H
	 D01z3n2KpP0z+dCVufJVd9WShC1ESdYlxjefVp+CCApYiBlBIg0XnkeLuc+2RT49Gs
	 I2058kerY79xlKJkPvBYin5SSweaQrZH0AA9JLeoVAwCVOG8BtWcra57gnbQ8KCYFy
	 QfwFwrGGzqigceRLR+dkPdwH50dkcrl85WIsNpvuH9QfUx3BWm8WDdx+dURU11Roc2
	 sC9/lMNiMJs/w==
Date: Mon, 20 Oct 2025 07:05:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Icenowy Zheng <uwu@icenowy.me>, Han Gao <rabenda.cn@gmail.com>, 
 Yao Zi <ziyao@disroot.org>, linux-kernel@vger.kernel.org, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chen Wang <unicorn_wang@outlook.com>, sophgo@lists.linux.dev, 
 Vivian Wang <wangruikang@iscas.ac.cn>, Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org, 
 Yixun Lan <dlan@gentoo.org>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 linux-stm32@st-md-mailman.stormreply.com, Longbin Li <looong.bin@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>
To: Inochi Amaoto <inochiama@gmail.com>
In-Reply-To: <20251020095500.1330057-2-inochiama@gmail.com>
References: <20251020095500.1330057-1-inochiama@gmail.com>
 <20251020095500.1330057-2-inochiama@gmail.com>
Message-Id: <176096193973.211044.5323192704803945227.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: net: sophgo,sg2044-dwmac: add phy
 mode restriction


On Mon, 20 Oct 2025 17:54:57 +0800, Inochi Amaoto wrote:
> As the ethernet controller of SG2044 and SG2042 only supports
> RGMII phy. Add phy-mode property to restrict the value.
> 
> Also, since SG2042 has internal rx delay in its mac, make
> only "rgmii-txid" and "rgmii-id" valid for phy-mode.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../bindings/net/sophgo,sg2044-dwmac.yaml       | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml: allOf:1:then: 'anyOf' conditional failed, one must be fixed:
	'phy-mode' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251020095500.1330057-2-inochiama@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


