Return-Path: <netdev+bounces-244478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A29BCB89F5
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 11:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18ED730433C1
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 10:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB8B316909;
	Fri, 12 Dec 2025 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn4uPqVt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D386D3168F2;
	Fri, 12 Dec 2025 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765535391; cv=none; b=ReZw49XccYkV3KdodwWXG7/A3YM0Pzu3LLCp11ZZFdJdNnn/bXmER4yCBJ74dLfDORIBr49QdVij2bXAaEuTrA8jndOo8q/2TyFRimbN2lgW47vaXpMWsajHFSdIUBhavdqtMgIgwJ5ggA1jkJlo4YPM4vgGSR09pDP/5Cdf0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765535391; c=relaxed/simple;
	bh=8AU+2nFn4mNMq1b2sfU+FOX9v7gIi6t2Rn3vZZyjlxM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=rMwXIYQWrJUJkIsU6C/iD/gbIICU70Ws+FANNtjn2kYTxLhOpax9xMv+0jDeaGxwECiyvKAfhJndSLlkGooyJhYv7wY2J2C257S9oDMWOmSM2LtnInJX/0zheLLJtLwfMzalyU31dMxDNFurTDP+N3pF94C8FT5ogyguIeoRaKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jn4uPqVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3DBC4CEF5;
	Fri, 12 Dec 2025 10:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765535391;
	bh=8AU+2nFn4mNMq1b2sfU+FOX9v7gIi6t2Rn3vZZyjlxM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=jn4uPqVtDWHxrncbw8nIEh19p5Ao7Xkh1aTGxBbS0j/A0+D52+j24XKYczKya9I2n
	 pPAeKHplNsqKPxEo71JlPL+Cqsbji1qYCCVi2WYmwG+laSvXMqc1khv3OSJbc/42v4
	 9FV2Msgx4llzSL7paaondFg4v4H1KgiEgi5nzDcBBWoB++GMlXIlaAPMpt2MNcuZ5K
	 2yMfWEm8+96wJOacc75qcQ+y/hGIBL1yeugAU33h/x5dagZfVOWQ1Q90stvj0fE0yd
	 k0/FtGspKDqeUx35nGPjnKVlrF/KxwPGadARVuRYhsTnpjFK5ui+uRSvoJyh3UW9gp
	 HMlpsxVJiov9A==
Date: Fri, 12 Dec 2025 04:29:50 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: hkallweit1@gmail.com, krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
 rafael.beims@toradex.com, pabeni@redhat.com, ben.dooks@codethink.co.uk, 
 netdev@vger.kernel.org, francesco.dolcini@toradex.com, edumazet@google.com, 
 andrew+netdev@lunn.ch, conor+dt@kernel.org, linux@armlinux.org.uk, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 devicetree@vger.kernel.org, davem@davemloft.net, geert+renesas@glider.be, 
 kuba@kernel.org
To: Stefan Eichenberger <eichest@gmail.com>
In-Reply-To: <20251212084657.29239-2-eichest@gmail.com>
References: <20251212084657.29239-1-eichest@gmail.com>
 <20251212084657.29239-2-eichest@gmail.com>
Message-Id: <176553538695.3335118.18332220352949601890.robh@kernel.org>
Subject: Re: [PATCH net-next v1 1/3] dt-bindings: net: micrel: Convert to
 YAML schema


On Fri, 12 Dec 2025 09:46:16 +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Convert the devicetree bindings for the Micrel PHY to YAML schema. This
> also combines the information from micrel.txt and micrel-ksz90x1.txt
> into a single micrel.yaml file as this PHYs are from the same series.
> Use yaml conditions to differentiate the properties that only apply to
> specific PHY models.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  .../bindings/net/micrel-ksz90x1.txt           | 228 --------
>  .../devicetree/bindings/net/micrel.txt        |  57 --
>  .../devicetree/bindings/net/micrel.yaml       | 527 ++++++++++++++++++
>  3 files changed, 527 insertions(+), 285 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
>  delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
>  create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/micrel.yaml:504:1: [warning] too many blank lines (2 > 1) (empty-lines)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20251212084657.29239-2-eichest@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


