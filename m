Return-Path: <netdev+bounces-206975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F88B04F97
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 05:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD25189EAC9
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 03:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C88A2D1925;
	Tue, 15 Jul 2025 03:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAQxvwGm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422072309B0;
	Tue, 15 Jul 2025 03:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551853; cv=none; b=KK1fOeEEfO8DPLtV1IX6jLgHyMWrfUMRVxtr4o2w1AE3sG4Sp8KgOCXY32QNC7Wh8N8yTsb5CCkkkjylCTmP0o2nejKbeESJXWNrvzVwuf3bbUZokFH15qqcU7KxJ8XGe5tGtIAL6VpsXPjTRgth6F5lwkYeLqN3TtwV0jwSBRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551853; c=relaxed/simple;
	bh=yNYf/5GrOEloApVhcJRWeVo8jGDjSwjPC5llKFeyqjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbiNV/2eeYmIExGMeoEaBr334vSNApiRSH9XYff05slT48oGmgUCtQwAJAdaElxJnLJzBnQc+O1NstDzd3qTGI+8CxHDopgYx/hnalfN+xi2n9xZmazJ4n473lG8G/7hZRqTw6M6M93REjw39jICRbQPCJpnKvG/sfg1AnT38m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAQxvwGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F93C4CEE3;
	Tue, 15 Jul 2025 03:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752551852;
	bh=yNYf/5GrOEloApVhcJRWeVo8jGDjSwjPC5llKFeyqjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IAQxvwGm7T8NCV72OekW63lZSdHOrDZ7rOLs43Md28ykY5+1th5ETo1YyxM13FG/t
	 d4RCfn1PhESPtTyi8lZUrcWwF54bJKHCxfWO7UZ25//F6s2fdhCH91UuVfyZKyO1ay
	 zPhpY3Vc/PrVNY3jL2v9QT+1bg8e1A/nX4Mb8t6ZPbcF31VUbL8nZjAQ7FACfv3fXp
	 UnMK0tYTh+rWIpaKLNX1NdRrDmOc1/XLcruFHTrbSvJwJ4lUFsoETCBdvFFsCETNah
	 Upvg9HObSABmdYJq1yL6702X18GN+kfwW+tJVfoahJjXV8Rk6ztizGxrT8IWYtTFPv
	 yg+svbHcO/73w==
Date: Mon, 14 Jul 2025 22:57:31 -0500
From: Rob Herring <robh@kernel.org>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, dinguyen@kernel.org,
	maxime.chevallier@bootlin.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: net: altr,socfpga-stmmac: Add
 compatible string for Agilex5
Message-ID: <20250715035731.GA14648-robh@kernel.org>
References: <20250714152528.311398-1-matthew.gerlach@altera.com>
 <20250714152528.311398-2-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714152528.311398-2-matthew.gerlach@altera.com>

On Mon, Jul 14, 2025 at 08:25:25AM -0700, Matthew Gerlach wrote:
> Add compatible string for the Altera Agilex5 variant of the Synopsys DWC
> XGMAC IP version 2.10.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
>  .../devicetree/bindings/net/altr,socfpga-stmmac.yaml     | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> index ec34daff2aa0..6d5c31c891de 100644
> --- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> +++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> @@ -11,8 +11,8 @@ maintainers:
>  
>  description:
>    This binding describes the Altera SOCFPGA SoC implementation of the
> -  Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, and Agilex7 families
> -  of chips.
> +  Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, Agilex5 and Agilex7
> +  families of chips.
>    # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
>    # does not validate against net/snps,dwmac.yaml.
>  
> @@ -23,6 +23,7 @@ select:
>          enum:
>            - altr,socfpga-stmmac
>            - altr,socfpga-stmmac-a10-s10
> +          - altr,socfpga-stmmac-agilex5
>  
>    required:
>      - compatible
> @@ -42,6 +43,10 @@ properties:
>            - const: altr,socfpga-stmmac-a10-s10
>            - const: snps,dwmac-3.74a
>            - const: snps,dwmac
> +      - items:
> +          - const: altr,socfpga-stmmac-agilex5

> +          - const: snps,dwxgmac-2.10
> +          - const: snps,dwxgmac

Is the distinction here useful? I doubt it, so I'd just drop the last 
one. Generally, we've moved away from any generic compatible for 
licensed IP like this because there's *always* some SoC specific 
difference. 

Rob

