Return-Path: <netdev+bounces-160672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4012A1AC93
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 23:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28253188DD2B
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 22:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2829B1CD213;
	Thu, 23 Jan 2025 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4R4wPYq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDF01CAA63;
	Thu, 23 Jan 2025 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737670632; cv=none; b=TrHuVy2Hgr4DGHA6WrWTOLojaPsYaYOlt2Mw3Q036Ayz8HHs8APHHdeWwr/lA6wQhPGop5JuFsv0Rjpcn801nJGv7ZWeQPGUXXv0aqtOUfY8EaGEPEZKesh5OYKHzY9JFwpL0XaSQPMGm+awkRDRS3AdZNbvvtJDPPMVFsulDUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737670632; c=relaxed/simple;
	bh=pcG2D2/E0u37nyJWQeA42BhrzuRLXs0n2hWP0puC9mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YioX8Nxt9Emy3aK30TjLCFnk9CnfvElkbdtcNZ7+b9TcCNDjCnGlykAeUGxLRGHk+GcUE9CMg7MP8lMiNLczG5RtG3D3otfGTDJEY2IxNjwtkpia/5LwHccbD66+pK1uGX0SAm9TbdDUs4VqO+wbj/Wv9LyUkbQi+z55y3sLHO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4R4wPYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA96C4CED3;
	Thu, 23 Jan 2025 22:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737670631;
	bh=pcG2D2/E0u37nyJWQeA42BhrzuRLXs0n2hWP0puC9mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4R4wPYqGTTiYnldH6jl4hR7pTwLxm1N71v7m5eehLbDNhx+4mJyeyqxiR4pFwI0h
	 BzRQ3n+ZUAgEwvc/4Y5lI7iZ+ncK5tubXKO7UKpRdK4bKBQm9EudmHDLsJXh5EwPOa
	 QjSuiqxT0/Hetex3f6MmQggKiggCAIBtUlqvdcDSscMT/Lve8uS38Wyg3GRSfyr6cD
	 bDZj4PoYC7S8FKd/BwB0XJ+jxpy83STlru5dq0DXwLPPRZFgUURvm70nA/IWJBegL3
	 WGwaeSntD53ucCbC2AqECdcEAHJftzwl/qu33tBvVmrOD/yqI95kMCNF4K3CKWszYS
	 C7GaiHLKajSaA==
Date: Thu, 23 Jan 2025 16:17:10 -0600
From: Rob Herring <robh@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: minyard@acm.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, eajames@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs
 parsing
Message-ID: <20250123221710.GA448645-robh@kernel.org>
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
 <20250116203527.2102742-4-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116203527.2102742-4-ninad@linux.ibm.com>

On Thu, Jan 16, 2025 at 02:35:18PM -0600, Ninad Palsule wrote:
> Allow parsing GPIO controller children nodes with GPIO hogs.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml       | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> index b9afd07a9d24..0497d19a60e9 100644
> --- a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> @@ -46,6 +46,12 @@ properties:
>      minimum: 12
>      maximum: 232
>  
> +patternProperties:
> +  "^(.+-hog(-[0-9]+)?)$":

This can be further simplified to: "-hog(-[0-9]+)?$"

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


BTW, no need to ping. You can check the status of binding patches in 
patchwork[1].

Rob

[1] https://patchwork.ozlabs.org/project/devicetree-bindings/list/

