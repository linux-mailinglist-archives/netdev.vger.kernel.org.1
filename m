Return-Path: <netdev+bounces-232710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9E6C082D0
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 23:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5613E1A66307
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 21:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F0F303A1C;
	Fri, 24 Oct 2025 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loj6ikfp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637443009FE;
	Fri, 24 Oct 2025 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341245; cv=none; b=i5MzZOslbilsiG+vyWrcnctGS6B4TCbXo5EYhVF+TMADUSI7nAWmvPMzVylUK+s9Z5WJx4PVs926/rfVwBEPtt8QWiXIDW6m/icc4v2lZPZznxXyawAYxxjTTMkyAS2GR/Ldi0LPXhDfT0/jU6tkbv7BzBCnVV2CW1avIou8k90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341245; c=relaxed/simple;
	bh=SOsXi9j2Xro3BDVetx3/mLyXF373AEJb7bAdZlo5x6Q=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=UeutxztBBZEMZVUKA1es6wJtJaTgvK8Jx0NN4HMDKYTRphr9nE+u4tWiUh61yc773NTklRK4zHOIBbzjfPs4zP6xPRyf1R2Po37LGz8djtyaNoOSwzsMpjvV2euDsUNN+Fl1WxjAmmFEJFtAgLs/ec8KeWchhL9/F4SH97fpZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loj6ikfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBDAC4CEF1;
	Fri, 24 Oct 2025 21:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761341244;
	bh=SOsXi9j2Xro3BDVetx3/mLyXF373AEJb7bAdZlo5x6Q=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=loj6ikfpQSrjlgOlv8QPAvS8lAF20CqwEFjOAv19NvZVvBTwLCtnTbn7XZXXt0GBx
	 TUANAs5Tv3Gf/jYLAIfbQ2jQ4KajWg5WHi1zPD+7v/ZHQihAcX8DVc3RI/BSzGL3yI
	 mw3Ze9rqDBAlosxRvdlEWkJeWqUIGP3h+5u1PU0hud9FwcRMx4sY3p4W1n7cr2mqrP
	 bIZtmJDrRlL8PO3J7etRE/1GoNswVgmlANTcQs2RACLRv4AzWzATdf4qWhZJvbxqmo
	 0LbWS+vjDkjdu5aJ5O7bm4ETJg7NsepE4bSFrpTf357s1J4t02gZLZuLxgdClBvvyd
	 AMyj9PspmuTlA==
Date: Fri, 24 Oct 2025 16:27:22 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 "David S. Miller" <davem@davemloft.net>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
In-Reply-To: <20251024201836.317324-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251024201836.317324-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-Id: <176134124286.2841725.8990137232361008022.robh@kernel.org>
Subject: Re: [PATCH net-next] dt-bindings: net: phy: vsc8531: Convert to DT
 schema


On Fri, 24 Oct 2025 21:18:36 +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Convert VSC8531 Gigabit ethernet phy binding to DT schema format. While
> at it add compatible string for VSC8541 PHY which is very much similar
> to the VSC8531 PHY and is already supported in the kernel. VSC8541 PHY
> is present on the Renesas RZ/T2H EVK.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Inspired from the DT warnings seen while running dtbs check [0],
> took an opportunity to convert this binding to DT schema format.
> As there was no entry in the maintainers file Ive added myself
> as the maintainer for this binding.
> [0] https://lore.kernel.org/all/176073765433.419659.2490051913988670515.robh@kernel.org/
> 
> Note,
> 1] dt_binding_check reports below warnings. But this looks like
> the same for other DT bindings too which have dependencies defined.
> ./Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml:99:36: [warning] too few spaces after comma (commas)
> <path>/mscc-phy-vsc8531.example.dtb: ethernet-phy@0 (ethernet-phy-id0007.0772): 'vsc8531' is a dependency of 'vsc8531,edge-slowdown'
> 	from schema $id: http://devicetree.org/schemas/net/mscc-phy-vsc8531.yaml
> <path>/mscc-phy-vsc8531.example.dtb: ethernet-phy@0 (ethernet-phy-id0007.0772): 'vddmac' is a dependency of 'vsc8531,edge-slowdown'
> 2] As there is no entry in maintainers file for this binding, Ive added myself
> as the maintainer for this binding.
> ---
>  .../bindings/net/mscc-phy-vsc8531.txt         |  73 ----------
>  .../bindings/net/mscc-phy-vsc8531.yaml        | 125 ++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +-
>  3 files changed, 126 insertions(+), 74 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
>  create mode 100644 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml:99:36: [warning] too few spaces after comma (commas)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.example.dtb: ethernet-phy@0 (ethernet-phy-id0007.0772): 'vsc8531' is a dependency of 'vsc8531,edge-slowdown'
	from schema $id: http://devicetree.org/schemas/net/mscc-phy-vsc8531.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.example.dtb: ethernet-phy@0 (ethernet-phy-id0007.0772): 'vddmac' is a dependency of 'vsc8531,edge-slowdown'
	from schema $id: http://devicetree.org/schemas/net/mscc-phy-vsc8531.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251024201836.317324-1-prabhakar.mahadev-lad.rj@bp.renesas.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


