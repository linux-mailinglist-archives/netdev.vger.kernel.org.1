Return-Path: <netdev+bounces-245872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B564CD9B66
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 15:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4B143028319
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 14:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2469D3451C8;
	Tue, 23 Dec 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdigqN1V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC43534104C;
	Tue, 23 Dec 2025 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766501074; cv=none; b=Jv2sBg27370Eov9H0WjnaWDGX82UBkAbdSaSdRH/rs4qFISryPrbF+2F4HNGiQF9PecnozKcaAR1mlvtIbBvODMor1tXFF9GjPN6G1QHp8lMXoSnA5MgZD8j2uqkoch7zu/xEsc9ewQzBPsOsGxHtsq2BypJq3947BPPzL5Cn1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766501074; c=relaxed/simple;
	bh=0e8i/+zYOZa82CpwZOmg+9pj1LZxEOkKYgYx8ZI7HpE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ifgUuA1O1TA+vpKkMsTG4Ci4ESXIj8J+8lR1vpqLyYKiD+1SJE3XtlCqjljA0LX/lFmda8G0xK5Uqf9AEsBqe3dERvTqsqAkY9P/viWzIN/ExofliCV/jsfzXgo5nr0oSldtSUAW2nyHtHuzeR69o/DeVDH81MK01utOMWc1gXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdigqN1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E71CC113D0;
	Tue, 23 Dec 2025 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766501073;
	bh=0e8i/+zYOZa82CpwZOmg+9pj1LZxEOkKYgYx8ZI7HpE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=DdigqN1V0coElfWSnTjQggsI7MDF04hbrIlTItPkflHJf6+TYjhAIJj5YAqSHJkc4
	 IU2oUm/KIPZLr2WEqpIykW1r0+XS45Mxy42bDzjKhbTYHI9QNPp3aWse4kb+KpGeVF
	 x7gG7e6wCKUV33t03oTxL9I8c5JuLcKhG64b+Xgc3cKHCS2i40uEii2q+5hk/SdBlg
	 8y9n7Zfg54kgOo9a4hzLW9A6/wpSWmHvJAy9dKvjJ9ideyY5r6PbDQXbmUqoD2o9O0
	 yfvdnq1qLmSTP6jHne8GWhAOXX3o+2tZnWqiCL4ErcFPpY2xa6xn6E0r20dRQFmqZr
	 Yv2bFQ+zQfwUQ==
Date: Tue, 23 Dec 2025 08:44:32 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: kuba@kernel.org, davem@davemloft.net, conor+dt@kernel.org, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 linux-kernel@vger.kernel.org, horms@kernel.org, devicetree@vger.kernel.org, 
 pabeni@redhat.com, krzk+dt@kernel.org, edumazet@google.com, 
 netdev@vger.kernel.org, andrew+netdev@lunn.ch
To: Stefan Eichenberger <eichest@gmail.com>
In-Reply-To: <20251223133446.22401-2-eichest@gmail.com>
References: <20251223133446.22401-1-eichest@gmail.com>
 <20251223133446.22401-2-eichest@gmail.com>
Message-Id: <176650107245.3268721.11717483612280730663.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: net: micrel: Convert to DT schema


On Tue, 23 Dec 2025 14:33:39 +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Convert the devicetree bindings for the Micrel PHYs and switches to DT
> schema.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  .../devicetree/bindings/net/micrel.txt        |  57 --------
>  .../devicetree/bindings/net/micrel.yaml       | 132 ++++++++++++++++++
>  2 files changed, 132 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
>  create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/renesas,ether.example.dtb: ethernet-phy@1 (ethernet-phy-id0022.1537): compatible: ['ethernet-phy-id0022.1537', 'ethernet-phy-ieee802.3-c22'] is too long
	from schema $id: http://devicetree.org/schemas/net/micrel.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20251223133446.22401-2-eichest@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


