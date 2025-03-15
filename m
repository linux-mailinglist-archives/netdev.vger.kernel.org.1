Return-Path: <netdev+bounces-175073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62556A63086
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 18:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601AB1896289
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 17:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3870202F88;
	Sat, 15 Mar 2025 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQOVZk/f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E984BA3F;
	Sat, 15 Mar 2025 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742058738; cv=none; b=IKbl2OhxB8ZeKnG8RlngcWfa7a5TcXvJZ+6pfcwJSDh5SnrJ+CI3+cZLfrKMTOScLoYfs3XDrhQlYXoGCxVWFEiC3XECfRq8+s6fzUeKXwOsSQ5YTTRFxdRJHKmArfDJO6PDC7xTg+QGOqSSjcIl/3GAjYEGvHGw/lX0vXVOvJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742058738; c=relaxed/simple;
	bh=TAGSXpXNt+/x3uk6tc75dLbGfKv+LBmzv0BZheJ4OhM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Y8FS5lwY/xPhIETTJWtM4h5t/TwezZzHKUUBUMAuDL++3MeErropXuWJbk/FfYxkvMLVOyeMh0qdBLthCp86atN/SlQC+CgFxwYraArkHGAjRPxUoAFTC99IlHf9ZGNFRg0WcLerV7xNnNgvNgzPc7082ie2Oubqrw3V8W1wvyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQOVZk/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD39C4CEE5;
	Sat, 15 Mar 2025 17:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742058734;
	bh=TAGSXpXNt+/x3uk6tc75dLbGfKv+LBmzv0BZheJ4OhM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=KQOVZk/fN4mnPBUj7zObUCAOTzYH07FpvRS3NiGw9KhKmckav2nGnZhFSviF70S38
	 ABS77iPHzZUpfeBHw/nlquL0mh46+LeVPnHYUm3hOctvdBFGn0DB/K10VXtTH8OlkF
	 OQKk+fXxSLi4mfOyyc0ADd7BelPfMpHgGdEutvvPvnqn4UwZ0R0EZYKHVF3z9DgF8E
	 w22GOdJjzJf63TyoynEIyfUbLz0HMcmZzgTKBK2HSLVnNJwty6ZqSAYwvdNLfbsNAw
	 uw43pONGXMZjQTUcRH+keLJ2OUcx7GkCW1R3BiZFRdKslGCo55wZmIfzY2PLlgEZUz
	 viaus37Bpynvw==
Date: Sat, 15 Mar 2025 12:12:13 -0500
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
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Russell King <linux@armlinux.org.uk>, Vladimir Oltean <olteanv@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
 upstream@airoha.com, Conor Dooley <conor+dt@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Eric Dumazet <edumazet@google.com>, Lee Jones <lee@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Jakub Kicinski <kuba@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250315154407.26304-6-ansuelsmth@gmail.com>
References: <20250315154407.26304-1-ansuelsmth@gmail.com>
 <20250315154407.26304-6-ansuelsmth@gmail.com>
Message-Id: <174205873356.67148.10337205475865865960.robh@kernel.org>
Subject: Re: [net-next PATCH v13 05/14] dt-bindings: mfd: Document support
 for Airoha AN8855 Switch SoC


On Sat, 15 Mar 2025 16:43:45 +0100, Christian Marangi wrote:
> Document support for Airoha AN8855 Switch SoC. This SoC expose various
> peripherals like an Ethernet Switch, a NVMEM provider and Ethernet PHYs.
> 
> It does also support i2c and timers but those are not currently
> supported/used.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/mfd/airoha,an8855.yaml           | 182 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 183 insertions(+)
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250315154407.26304-6-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


