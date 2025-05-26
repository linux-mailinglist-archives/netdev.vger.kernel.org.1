Return-Path: <netdev+bounces-193498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529B8AC440C
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 21:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4A23B844F
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 19:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9BA1F03C5;
	Mon, 26 May 2025 19:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoHTb2Mf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AFD72607;
	Mon, 26 May 2025 19:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748287581; cv=none; b=Afx5rZ4BlxYbgnyDh96C9jFYyHMuOw5CiQ3QTosDCXVQzucPZY9AgGM2VQItrCQgrZe/ewn67QITLOkmL+OzJ+lHYqs5Wn+wM3z2Kjukk6H4fOGq98ltKlEzZjrFhgdNI0keScawG/Ua0D2ihRCFqWmAm5EnSZDz7NOrQ9d4xg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748287581; c=relaxed/simple;
	bh=FaL621iJbj/67K/Av8Le03EGK0pHPFx/zpQdIWk/TYY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=raTAGCGKXByEFlPLLSz9x4D/GWVd8m9X+2MB2b9ogNNQxApASahcaCBTgOzkTJhMbZMgVHg9Dc7W28LjmrO7xE7OB4WBeyBU6u70JJoxRdudQMYQZsiw4bZCydZMhO1uhYpQeULkli/Kzau8r8g7gjIuyOU2F9vP/3OK5l75NqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoHTb2Mf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8ABC4CEE7;
	Mon, 26 May 2025 19:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748287581;
	bh=FaL621iJbj/67K/Av8Le03EGK0pHPFx/zpQdIWk/TYY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=VoHTb2Mf099/zglBpx1ECF8UqZrtYZLkXKlHE9VLsMGd/wpLIgJaBD+uJvdbrFNKP
	 5/OYLBHG3jfTOUuKoajriDsjOsScVYJj1+z1aKXyn194xaoC1MBAl4oElXvtF3KgJz
	 frJiTXEpUA1c6jbjR2sMbdGvds4O+/HKAww05iW3R2MSKY/BsSH/VdOqWVKWpIkOe4
	 4EGi1vlVcbb4tQTDBuaB+fjjGlptyMvOd4jwsOiaXKtJWpgiIZHu0XMZJ2BUxfgEcG
	 FmXeFpWig2tcgxTzfTR1gMdaRuXd/6WFBj/xCBU8h5vc1YtF//UYdNMk7yFGeXtJZS
	 9vY7WAAeqdb7w==
Date: Mon, 26 May 2025 14:26:19 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 Samuel Holland <samuel@sholland.org>, Paolo Abeni <pabeni@redhat.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 devicetree@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, netdev@vger.kernel.org
To: James Hilliard <james.hilliard1@gmail.com>
In-Reply-To: <20250526182939.2593553-3-james.hilliard1@gmail.com>
References: <20250526182939.2593553-1-james.hilliard1@gmail.com>
 <20250526182939.2593553-3-james.hilliard1@gmail.com>
Message-Id: <174828757941.2206833.11560250898621466497.robh@kernel.org>
Subject: Re: [PATCH v1 3/3] dt-bindings: net: sun8i-emac: Add AC300 EMAC1
 nvmem phy selection


On Mon, 26 May 2025 12:29:36 -0600, James Hilliard wrote:
> The Allwinner H616 EMAC1 can be connected to an on-die AC200 or AC300
> PHY depending upon the silicon variant.
> 
> Add a new allwinner,sun50i-h616-emac1 compatible and example, support
> for the allwinner,sun50i-h616-emac1 will be added later on.
> 
> Add nvmem-cells and nvmem-cell-names properties for the ac300 efuse
> based phy selection.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  .../net/allwinner,sun8i-a83t-emac.yaml        | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.example.dts:219.27-28 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1519: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250526182939.2593553-3-james.hilliard1@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


