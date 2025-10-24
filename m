Return-Path: <netdev+bounces-232340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBBBC043D4
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 05:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7686354426
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB8626E146;
	Fri, 24 Oct 2025 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAZW1d9n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3F2248F48;
	Fri, 24 Oct 2025 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276213; cv=none; b=krRsHLvN0c1hWxmqcNCYdZUQAo2X9xA5c3B9IpV8Vx8nfXGUn1lYyZOe0WFVFDMLcch2GS1FTykTCv/MHoNyG4Re01YNZSN3mOmKR5g3+a69kZhgPXbbDfcaQ8m4H98aJ4cEpm2CnSSKUZw73WjWBe9rijOVS8b8Wup0ve+Okys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276213; c=relaxed/simple;
	bh=CNwnT8O4JG4Ottnhbl1cNUX0P6pAoK8TTMrHAWFkULg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=gDrTUt6jnCX7UkrRjSXj/0q7adxAyMHDwx4V9yWMawSe7Fi6YoZlS1gspEkxT9Pp9o6+sm8nLmTSrNRZQI4iA8APmZ+4hd5Pw3eSLYznLKEtkEGNFYy09+5T/s1xRq4UbD87FuuhGjaQGoayDPkOTVfc/j4J8c/ibUQqVHpC6mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAZW1d9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10ABC4CEE7;
	Fri, 24 Oct 2025 03:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761276212;
	bh=CNwnT8O4JG4Ottnhbl1cNUX0P6pAoK8TTMrHAWFkULg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=PAZW1d9nE4BKbSDO5YSLJIHFY7fvvq7/qb+KsjUsGRLmxi56jdxvmOARnYJv4d2ld
	 Ic/xOGBjxwDNwmiwJ7cwI4V+apON+qMOt3p6cSvOAfiZ8jtjp0hXvhPBg0AM77I1zp
	 g6i8gpSAFD7DosiR9Fi+RdTt41wplPyJOLqBMx3xzyWe4tOmA43TExpxPsd4IS8kb2
	 ffQAI4FNvAT46dKsdBSkShyj3Tac9+wpugnoPlwOkCefGTwchZzYXux2HTezbtbDFb
	 cD2F6SLTQmqfuVuj5vCgghi+8YZx5WXGvZntDmaWeqh9aFw3ZihEuSB6O7yksVD5ou
	 igWnqilxSCITA==
Date: Thu, 23 Oct 2025 22:23:30 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Icenowy Zheng <uwu@icenowy.me>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Eric Dumazet <edumazet@google.com>, Chen Wang <unicorn_wang@outlook.com>, 
 Yao Zi <ziyao@disroot.org>, linux-stm32@st-md-mailman.stormreply.com, 
 Longbin Li <looong.bin@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 sophgo@lists.linux.dev, Han Gao <rabenda.cn@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
In-Reply-To: <20251024015524.291013-2-inochiama@gmail.com>
References: <20251024015524.291013-1-inochiama@gmail.com>
 <20251024015524.291013-2-inochiama@gmail.com>
Message-Id: <176127621096.199631.1552825919177332173.robh@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: net: sophgo,sg2044-dwmac: add phy
 mode restriction


On Fri, 24 Oct 2025 09:55:22 +0800, Inochi Amaoto wrote:
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
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251024015524.291013-2-inochiama@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


