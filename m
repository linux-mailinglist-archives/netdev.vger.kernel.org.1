Return-Path: <netdev+bounces-195813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C9DAD2526
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 19:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD373A2EC1
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59E521B8E0;
	Mon,  9 Jun 2025 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KL8UlAIY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F0F15B102;
	Mon,  9 Jun 2025 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490943; cv=none; b=tQD5m6AcjYsICwzF7G3nGBG3lTP6t63vAU1kjnlKL6C1RQHr/7ohsMev2xpHT/A/l3lS++z2Zz7i9vr4VatZPA9XBuTOFLCRVQgOmOyAMtBK06Tp8bZVJFKFjZFv2C6IvdZV3+5fYp4h96r0LkjwQgTAiaAwdvHw5HtTtbHaDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490943; c=relaxed/simple;
	bh=CJ+enGOlPPcRf65d70LImTv1T4lZDai57b0CXVchMaY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=YeVuKsw4WOyl43rq0eCkTvLRC0f8ozxPG82gUMYA1Aunv7WomuHxrnSqbhzDacwlCnYBQQejziVvzS2lhNilsSDpIiIQaOaMFBKw0zejE+PkaYTZxEtmJvQ8DAO7sFsKme/mAAyZsqwbub+zghitgKidkNdNVZGYzYh2t8xriCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KL8UlAIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDB2C4CEEB;
	Mon,  9 Jun 2025 17:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749490943;
	bh=CJ+enGOlPPcRf65d70LImTv1T4lZDai57b0CXVchMaY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=KL8UlAIYXxuC3o3B65WcdjwJ/LozRsxFo82zg0/eOSSO9OuEPiLhdAh0TJfUnZZo2
	 n/ZQ69r+zQHUW0TVwvxVlFj/FpBx0V8vIJuEg8PJ/8TiMszjt+18FoCre5ZuYNqdK3
	 iPNx/4iA9dTkzzyyAWvYgnUbEysv/YrvYAerGILBeI+ZYl5x+161w/AcVcrgXTj9cA
	 pcV+Z4WIEJnbbfJXsz2SWLPA8iv5/yW0Jt+mb6QADtN8W/t/tZD8JO7ZMOQLDF24qd
	 KnaM8ZwxmzP+Ook46yjJO6xfx99dEPkPcIPdkCTu7B290OBA6Y0NDjhVsYLZ0+jEd0
	 79m7VkDRo23gw==
Date: Mon, 09 Jun 2025 12:42:21 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, edumazet@google.com, 
 alexandre.torgue@foss.st.com, davem@davemloft.net, krzk+dt@kernel.org, 
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Mun Yew Tham <mun.yew.tham@altera.com>, 
 conor+dt@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
 richardcochran@gmail.com, kuba@kernel.org, maxime.chevallier@bootlin.com
To: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <20250609163725.6075-1-matthew.gerlach@altera.com>
References: <20250609163725.6075-1-matthew.gerlach@altera.com>
Message-Id: <174949094195.2609766.16547332627490920980.robh@kernel.org>
Subject: Re: [PATCH v4] dt-bindings: net: Convert socfpga-dwmac bindings to
 yaml


On Mon, 09 Jun 2025 09:37:25 -0700, Matthew Gerlach wrote:
> Convert the bindings for socfpga-dwmac to yaml. Since the original
> text contained descriptions for two separate nodes, two separate
> yaml files were created.
> 
> Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
> v4:
>  - Change filename from socfpga,dwmac.yaml to altr,socfpga-stmmac.yaml.
>  - Updated compatible in select properties and main properties.
>  - Fixed clocks so stmmaceth clock is required.
>  - Added binding for altr,gmii-to-sgmii.
>  - Update MAINTAINERS.
> 
> v3:
>  - Add missing supported phy-modes.
> 
> v2:
>  - Add compatible to required.
>  - Add descriptions for clocks.
>  - Add clock-names.
>  - Clean up items: in altr,sysmgr-syscon.
>  - Change "additionalProperties: true" to "unevaluatedProperties: false".
>  - Add properties needed for "unevaluatedProperties: false".
>  - Fix indentation in examples.
>  - Drop gmac0: label in examples.
>  - Exclude support for Arria10 that is not validating.
> ---
>  .../bindings/net/altr,gmii-to-sgmii.yaml      |  49 ++++++
>  .../bindings/net/altr,socfpga-stmmac.yaml     | 162 ++++++++++++++++++
>  .../devicetree/bindings/net/socfpga-dwmac.txt |  57 ------
>  MAINTAINERS                                   |   7 +-
>  4 files changed, 217 insertions(+), 58 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/altr,gmii-to-sgmii.yaml
>  create mode 100644 Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/altr,gmii-to-sgmii.example.dtb: /example-0/phy@ff000240: failed to match any schema with compatible: ['altr,gmii-to-sgmii-2.0']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250609163725.6075-1-matthew.gerlach@altera.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


