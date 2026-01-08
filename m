Return-Path: <netdev+bounces-248103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F14D04582
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E52232F7318
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7755078FB;
	Thu,  8 Jan 2026 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YH4XZg4h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C65078DE;
	Thu,  8 Jan 2026 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882348; cv=none; b=U7sVoGfbR7cbhyFaYhxNe+q4kjAfz2Ui6Wu+ztecJeZHXg00HybfTvaLqW0ivNRAV+1go+lU4vwsD92l6dAEFDIOmSU7oPj2A1/kH038c80ifCe7PRWmmXBTlDkVPPLz8P5B5hxliWV83AF7hc6SJ7Kp4kzw6AFl9sokcQwIGpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882348; c=relaxed/simple;
	bh=F13uKkukZXofZUBYaNqrE+dWSP1fqQkxZdlgcTwh0ko=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=m7WNVn+SuNy8LAWWBLrn79ucwt0/1till3ZJIGBy8U5FKyrln6CWGuuLP+NkRGyXRGKvNL+A3ZDvl3WoxA/4pA/MkZ/ICJVEl8JdoGaYXCTJq7MZIgxoyQR6xkvdPEDblAiWgBoRG0x/Wvnz/TVBIUcghZGBAO1XJWpBEnk2Z68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YH4XZg4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A58AC116C6;
	Thu,  8 Jan 2026 14:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767882348;
	bh=F13uKkukZXofZUBYaNqrE+dWSP1fqQkxZdlgcTwh0ko=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=YH4XZg4hu7qDLTlUAWnnk+IScfeVKZniaLj09ytWaARbv75UD8nZvEtaTe80xOejN
	 g6zpoHBVuIM882dgo8CzYhvculGHyddTrWsHbWJ+dMD4GKLhoAZ46mtj/IXX7FFBln
	 udJXKcPZ5RQaSoUfkwI3ZCeDwyBIOcpUrLsHRt9u91BZzig+3iQ7JI904U5Z/UlxF0
	 txfUv/fmIxGcjZTvRrxvjCBcfd7xiajaOUz5c7IoB2KJMlyOh8aKsf6OqdFgUooC+m
	 Qrg+3kaLcIfzQB155wUwZo6dLeb8mnMvaF7msq0MFbjb2Fmi3Cbqsfwl7AQvbbgGxi
	 vXDjvxb0nv8AA==
Date: Thu, 08 Jan 2026 08:25:47 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, pabeni@redhat.com, 
 davem@davemloft.net, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 conor+dt@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
 andrew+netdev@lunn.ch, edumazet@google.com
To: Stefan Eichenberger <eichest@gmail.com>
In-Reply-To: <20260108125208.29940-2-eichest@gmail.com>
References: <20260108125208.29940-1-eichest@gmail.com>
 <20260108125208.29940-2-eichest@gmail.com>
Message-Id: <176788234726.4064937.7806181035120642054.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: micrel: Convert to DT schema


On Thu, 08 Jan 2026 13:51:27 +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Convert the devicetree bindings for the Micrel PHYs and switches to DT
> schema.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  .../devicetree/bindings/net/micrel.txt        |  57 --------
>  .../devicetree/bindings/net/micrel.yaml       | 133 ++++++++++++++++++
>  2 files changed, 133 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
>  create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/renesas,ether.example.dtb: ethernet-phy@1 (ethernet-phy-id0022.1537): compatible: ['ethernet-phy-id0022.1537', 'ethernet-phy-ieee802.3-c22'] is too long
	from schema $id: http://devicetree.org/schemas/net/micrel.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260108125208.29940-2-eichest@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


