Return-Path: <netdev+bounces-244477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E126CB89F0
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 11:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDB78300986C
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 10:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9511C314D0A;
	Fri, 12 Dec 2025 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUks2+T9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DC2309F02;
	Fri, 12 Dec 2025 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765535391; cv=none; b=VaAsrGdojGcFUS3Ld83/86ogKJBJjwDuBzFGT8jdnDaB3Sli/HjPRcRhUFW72BxJ7p/yfVQzxwg89sliRBRHCYVay8WMjgiNWGjXE6OpDXmnrxiVqqRemeNE5aFG8DAExiwNbkNuMAgcxHjpvVVrYkrkYyHPdyrV//ThbRiHKsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765535391; c=relaxed/simple;
	bh=4x7gvl8Pcdg6DrRkR8n/Ln3XNmU3RDU1c2ARw9mcN5g=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=fU4KIkkhlP/NSMu5aViVVLpOpSN6ZVEHVbquCq3x8+Z4bCQhJ+n+sFRAhuA8YTdqZWV36LpIa0qyl14x+8yjYC35lnHIyBJy6Kt2PqMnrMjlpcl6xT1SGbL9C7udOWgS4lOvPayvEN4nlPITrx6+t77RCGydhlI6HsSHt8oz+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUks2+T9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A57C4CEF1;
	Fri, 12 Dec 2025 10:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765535390;
	bh=4x7gvl8Pcdg6DrRkR8n/Ln3XNmU3RDU1c2ARw9mcN5g=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=iUks2+T9pLFHHUS1zdcHORK+NJec6bufwbsJsnA2S9ZORubV5fgV3qxbmwXW8B8Sd
	 +8lJQMb53BiEkUzF1TYdp93MpuLMzM7ZXNLCMM2XJRO043gF6YkEAu5+eYfq0wHmTP
	 xRm0U9FXI+ixN2ajLlcDrnDqLLKz8xFehDne0eIyf9BbvcGgyJv8EJsWhK/aLmwxro
	 098djJQ2/k3/JBa3RlzYoyBJibOCdeILzN/Wgu3/8d8t07fLAQ89TNYHgZLBp+5mIY
	 h2tOYeHOgxbu2Nu6RcpsoIfRRniqkI/4bX8ZLk84xtijjB8fIRJOOCA65xjQEM3xTm
	 on0xCD+q8ZyRQ==
Date: Fri, 12 Dec 2025 04:29:47 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: kuba@kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, davem@davemloft.net, geert+renesas@glider.be, 
 francesco.dolcini@toradex.com, conor+dt@kernel.org, 
 rafael.beims@toradex.com, ben.dooks@codethink.co.uk, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, hkallweit1@gmail.com, 
 edumazet@google.com, devicetree@vger.kernel.org, andrew+netdev@lunn.ch, 
 pabeni@redhat.com, linux@armlinux.org.uk
To: Stefan Eichenberger <eichest@gmail.com>
In-Reply-To: <20251212084657.29239-3-eichest@gmail.com>
References: <20251212084657.29239-1-eichest@gmail.com>
 <20251212084657.29239-3-eichest@gmail.com>
Message-Id: <176553538562.3334907.2349485324753514759.robh@kernel.org>
Subject: Re: [PATCH net-next v1 2/3] dt-bindings: net: micrel: Add
 keep-preamble-before-sfd


On Fri, 12 Dec 2025 09:46:17 +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Add a property to activate a Micrel PHY feature that keeps the preamble
> enabled before the SFD (Start Frame Delimiter) is transmitted.
> 
> This allows to workaround broken Ethernet controllers as found on the
> NXP i.MX8MP. Specifically, errata ERR050694 that states:
> ENET_QOS: MAC incorrectly discards the received packets when Preamble
> Byte does not precede SFD or SMD.
> 
> The bit which disables this feature is not documented in the datasheet
> from Micrel, but has been found by NXP and Micrel following this
> discussion:
> https://community.nxp.com/t5/i-MX-Processors/iMX8MP-eqos-not-working-for-10base-t/m-p/2151032
> 
> It has been tested on Verdin iMX8MP from Toradex by forcing the PHY to
> 10MBit. Withouth this property set, no packets are received. With this
> property set, reception works fine.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  Documentation/devicetree/bindings/net/micrel.yaml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/micrel.yaml:517:1: [warning] too many blank lines (2 > 1) (empty-lines)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/renesas,ether.example.dtb: ethernet-phy@1 (ethernet-phy-id0022.1537): compatible: ['ethernet-phy-id0022.1537', 'ethernet-phy-ieee802.3-c22'] is too long
	from schema $id: http://devicetree.org/schemas/net/micrel.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20251212084657.29239-3-eichest@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


