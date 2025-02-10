Return-Path: <netdev+bounces-164642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D3CA2E948
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE53B18844B3
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922BA1E7C2E;
	Mon, 10 Feb 2025 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU1UcQgG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567CE1E7C1C;
	Mon, 10 Feb 2025 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739183043; cv=none; b=Qo6VyoJpiUUrJbYG13BrKqbMX8YvulSUDEHIUc2QjaPqM6vY0DtJTSZwy1BLCKqqDGIfHMVm21RpAWzzmkqG3zWbqk1cacVcdTTQmCASaGkzj5U8t9tbGV4j8e4BzIwWXzancE3bwtYCmwKVfpoBk9Umyp61FES+nfGZQDfqCHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739183043; c=relaxed/simple;
	bh=ntoOiImb78BlQL0UwLciwQEQuyzEUEb5lGqhwhFfqOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYOAtiY/Q1miyBYQUig5zbDXHFRGHY/ACzAEsIIcMqL6t8rGdWh7b4xP2r3T8AiHCZydxCo+civEwW6ye0oDblzlShQmQaEcSQT4MbF+sOpgVjnJIpMLgFMnNl8QN4JhB7yGp0t+fQX6oh6dRdjwp96MwonWcGrj7t4VccbXuow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OU1UcQgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DFAC4CEE6;
	Mon, 10 Feb 2025 10:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739183042;
	bh=ntoOiImb78BlQL0UwLciwQEQuyzEUEb5lGqhwhFfqOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OU1UcQgGxyej+8N/NmwfNcsGdxNkcP1SGRCUKpnbBQ7oZ2PJ4QiARn6GZ4a6RcwD6
	 4iSGfPnupJBMjbJPaJHTg3WdJxfIxGBJzw2PQ+YzWUyV0WcW8dAhjnXj00vD+1gkk6
	 l2bBHg4ypU1RLtwV/XWo/MK4DogN9ssAhHVBPcsajntu3//7yNGVYKbaq7oDrMJ8tX
	 wvvBAFbdVyiuT0XEUB7H57zvaSK15WkFQgjlNzrrWCTml7tJF/KrbcfBIGO7X16bGh
	 jxLqj3ryMjNXg+Os9cWQ39GF9ICamYNN5TBT1gOIgBE6DEnFZ4OPvKSbdj87NjnVfg
	 n9BgJsGhUByWQ==
Date: Mon, 10 Feb 2025 11:23:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dinh Nguyen <dinguyen@kernel.org>, kernel@pengutronix.de, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] dt-bindings: net: dwmac: add compatible for
 Agilex5
Message-ID: <20250210-hissing-discerning-vulture-d741cd@krzk-bin>
References: <20250205-v6-12-topic-socfpga-agilex5-v4-0-ebf070e2075f@pengutronix.de>
 <20250205-v6-12-topic-socfpga-agilex5-v4-3-ebf070e2075f@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250205-v6-12-topic-socfpga-agilex5-v4-3-ebf070e2075f@pengutronix.de>

On Wed, Feb 05, 2025 at 04:32:24PM +0100, Steffen Trumtrar wrote:
> The Agilex5 SoCs have three Synopsys DWXGMAC-compatible ethernet
> IP-cores.
> 
> Add a SoC-specific front compatible to the binding.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/socfpga-dwmac.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/socfpga-dwmac.yaml b/Documentation/devicetree/bindings/net/socfpga-dwmac.yaml
> index 2568dd90f4555485f18912b5352f191824bb918c..31c163bf1b59e14216d1fb4b4b9aaa747e1b19e2 100644
> --- a/Documentation/devicetree/bindings/net/socfpga-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/socfpga-dwmac.yaml
> @@ -21,6 +21,7 @@ select:
>          enum:
>            - altr,socfpga-stmmac # For Cyclone5/Arria5 SoCs
>            - altr,socfpga-stmmac-a10-s10 # For Arria10/Agilex/Stratix10 SoCs
> +          - altr,socfpga-stmmac-agilex5 # For Agilex5 SoCs
>    required:
>      - compatible
>  
> @@ -45,6 +46,12 @@ properties:
>                - altr,socfpga-stmmac-a10-s10
>            - const: snps,dwmac-3.74a
>            - const: snps,dwmac
> +      - items:
> +          - enum:
> +              - altr,socfpga-stmmac-agilex5
> +          - const: altr,socfpga-stmmac-a10-s10
> +          - const: snps,dwxgmac-2.10

No, don't grow this pattern. a10-s10 *MUST* be one specific device, so
it cannot be compatible with 3.72, 3.74 and 2.10 in the same time.

I understand that old DTS was here wrong, that ship has failed, but
don't grow it. All your compatibles must be specific, which means they
must represent one logical choice. You claim now that a10-s10 covers now
three entirely different devices.

Best regards,
Krzysztof


