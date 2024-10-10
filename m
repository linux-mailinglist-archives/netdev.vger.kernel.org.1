Return-Path: <netdev+bounces-134371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 278B6998F33
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 20:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6881F22BF3
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 18:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF2E1CCEDF;
	Thu, 10 Oct 2024 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etvIoIqg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F202C19D880;
	Thu, 10 Oct 2024 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583237; cv=none; b=gAdw8bKGVz5wbT6/cZP4b7E71c8luwCcmrJGh6vnm+/R5svqpriF9Cvxt60xeA4kmRs9qec+ZUNbNo0xQ5nJj1rutI7/MwB+pq4DUKJM7sFd4VZs291l42wbfMC9gydYEWr7CvhZE05GWIw6vbop+1rZf5k3QU6SwWb8Zx+z5F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583237; c=relaxed/simple;
	bh=vnXCeY/eIb6pDREyFMJGaK+pFEB8fxIiROrKc/YO4eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf+mF3g9lSddpT3y+98wFwOI39x+Zbeb9OQlnwZnYqe3Fwxq8E2TGjTcmiYHZVL1HTsvZv4TBFHFs+qmB4axekhOY9tW7vzPORH/Mwdx6FauqNRuA7Y99gl6erAOPMo5a1FtduwxbOSCbZuG4RXRXy5D5txykY3OsG3rxjPeg4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etvIoIqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7AAC4CEC6;
	Thu, 10 Oct 2024 18:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728583236;
	bh=vnXCeY/eIb6pDREyFMJGaK+pFEB8fxIiROrKc/YO4eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=etvIoIqgciTpA/ZXHpxMX1IfEQEmJV86AHXQPf+6ONCaV6uR9nNqfWhTsGrbM9R/8
	 qvrsieY4P+Bt8l7BFMdxjSNKLI93qigtaFV1/fdH4VcSwAEtugBWeGgIPJtTx5zKVy
	 6GWYd32euVFTKwvdgJxCB6581EoEOUPnXNCQOH7CT/Zoy5jY7J4AQXdk5XDRkDrFm0
	 xbwmhgb0l+ozeMtEKbsCzyIDj0LBCkSQgvBzjZ93upXBahY/xREpjhrI62Agt1WSZq
	 EJbQ+TEEy5tkpFhhoIFCbSzvRPhGZOAbM/Fd2nwpSdoVDPsWn8SmIbXic5pJMBtC6R
	 fKXVP7Ej4jLYg==
Date: Thu, 10 Oct 2024 13:00:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, andrew@lunn.ch,
	andrei.botila@oss.nxp.com, horms@kernel.org,
	devicetree@vger.kernel.org, kuba@kernel.org, imx@lists.linux.dev,
	davem@davemloft.net, pabeni@redhat.com, hkallweit1@gmail.com,
	edumazet@google.com, netdev@vger.kernel.org, f.fainelli@gmail.com
Subject: Re: [PATCH v5 net-next 1/2] dt-bindings: net: tja11xx: add
 "nxp,rmii-refclk-out" property
Message-ID: <172858323378.2094687.9350859179293389445.robh@kernel.org>
References: <20241010061944.266966-1-wei.fang@nxp.com>
 <20241010061944.266966-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010061944.266966-2-wei.fang@nxp.com>


On Thu, 10 Oct 2024 14:19:43 +0800, Wei Fang wrote:
> Per the RMII specification, the REF_CLK is sourced from MAC to PHY
> or from an external source. But for TJA11xx PHYs, they support to
> output a 50MHz RMII reference clock on REF_CLK pin. Previously the
> "nxp,rmii-refclk-in" was added to indicate that in RMII mode, if
> this property present, REF_CLK is input to the PHY, otherwise it
> is output. This seems inappropriate now. Because according to the
> RMII specification, the REF_CLK is originally input, so there is
> no need to add an additional "nxp,rmii-refclk-in" property to
> declare that REF_CLK is input.
> Unfortunately, because the "nxp,rmii-refclk-in" property has been
> added for a while, and we cannot confirm which DTS use the TJA1100
> and TJA1101 PHYs, changing it to switch polarity will cause an ABI
> break. But fortunately, this property is only valid for TJA1100 and
> TJA1101. For TJA1103/TJA1104/TJA1120/TJA1121 PHYs, this property is
> invalid because they use the nxp-c45-tja11xx driver, which is a
> different driver from TJA1100/TJA1101. Therefore, for PHYs using
> nxp-c45-tja11xx driver, add "nxp,rmii-refclk-out" property to
> support outputting RMII reference clock on REF_CLK pin.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> V2 changes:
> 1. Change the property name from "nxp,reverse-mode" to
> "nxp,phy-output-refclk".
> 2. Simplify the description of the property.
> 3. Modify the subject and commit message.
> V3 changes:
> 1. Keep the "nxp,rmii-refclk-in" property for TJA1100 and TJA1101.
> 2. Rephrase the commit message and subject.
> V4 changes:
> 1. Change the property name from "nxp,phy-output-refclk" to
> "nxp,rmii-refclk-out", which means the opposite of "nxp,rmii-refclk-in".
> 2. Refactor the patch after fixing the original issue with this YAML.
> V5 changes:
> 1. Reword the description of "nxp,rmii-refclk-out" property.
> ---
>  .../devicetree/bindings/net/nxp,tja11xx.yaml     | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


