Return-Path: <netdev+bounces-170491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 763ADA48DE6
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67AEE7A50EA
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF1A35280;
	Fri, 28 Feb 2025 01:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwC/DW5S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0180FDF42;
	Fri, 28 Feb 2025 01:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740705952; cv=none; b=nfvWD4igcOA/CVIaAeleDJNcxY3L4plt9CLCBSe1Y0qVvBrMjXJgxp+nX7VSCrCmKjFqPHvfTfS0LcNh4nA+8N8vrH3r6AU0limvJCPjv27Mb2fMszEc1OPK+G7CopyrWVKTeRqe6aD/iYwELEO4K3jyDdeQLDUQFbHrO2IsjlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740705952; c=relaxed/simple;
	bh=xcDqeZCf41T+MlGm7yohZGZ8ilerz9IIxzHO/8x/mDI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=BXFjCFOd/NzDi4IxSTV11aFkxTPaOrOe2rhkaTiGSvoPwCwIg9eEiDUDyXYkHe5ZTQKUqfpilxxYDTLdOWUH3AGwQM+xLza4JA1ePtBVMv9bWn8Bh58daXgqoP7n+kZF5mleiCwMVMocAr7xTSWkthobRFm5GoZBhIpXwNzi1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwC/DW5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F6DC4CEDD;
	Fri, 28 Feb 2025 01:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740705951;
	bh=xcDqeZCf41T+MlGm7yohZGZ8ilerz9IIxzHO/8x/mDI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=hwC/DW5S2U4nB9Ci3hMWNwmDmdWFt6kvcPzg/81seza7Vl4FInyV/FbcCQjs3jOcI
	 skSABr7VkSk2D6liCtmf6QhoRIk81JFm+OH/MVh3N7km0J80QxOMI8l/HMT1hQVVi0
	 qoY9IAM8TPeVqdJHh33cm07c5WGygBXDzt9UhK0a/YD2/G3LWztOJDSJUgN6Vh4R1Y
	 PFmFoNbN5WDh0eb8ksfSQq+jx1sw8bAjD3NkVMfKCjk+4DxMMKi5U8jOY4BuRSgzlm
	 Kh7KJxq9QahUq+Y9/QAcQDdyBWheB+w1letSRjooa47OFKenKVXpAtVnt4LrMooGNm
	 4ewYSs3nEGkJA==
Date: Thu, 27 Feb 2025 19:25:49 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 jonas.gorski@gmail.com, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 netdev@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 linux-kernel@vger.kernel.org, noltari@gmail.com, 
 "David S. Miller" <davem@davemloft.net>, 
 Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 devicetree@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
To: Kyle Hendry <kylehendrydev@gmail.com>
In-Reply-To: <20250228002722.5619-4-kylehendrydev@gmail.com>
References: <20250228002722.5619-1-kylehendrydev@gmail.com>
 <20250228002722.5619-4-kylehendrydev@gmail.com>
Message-Id: <174070594941.726878.5388041268672454945.robh@kernel.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: net: phy: add BCM63268 GPHY


On Thu, 27 Feb 2025 16:27:17 -0800, Kyle Hendry wrote:
> Add YAML bindings for BCM63268 internal GPHY
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
> ---
>  .../bindings/net/brcm,bcm63268-gphy.yaml      | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.yaml: maintainers:0: 'TBD' does not match '@'
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
Error: Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.example.dts:26.39-40 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1511: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250228002722.5619-4-kylehendrydev@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


