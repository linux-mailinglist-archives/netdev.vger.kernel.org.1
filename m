Return-Path: <netdev+bounces-204855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D400AFC488
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370AC172988
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 07:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E2B29A9D2;
	Tue,  8 Jul 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDdV7w3t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DED299A98;
	Tue,  8 Jul 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961003; cv=none; b=qD95ecw2fXhhtvz2947FGKkVLbGD8imUtoC3qiOwKmmxu4Yd9Io9Bsp0Eakc3kKPzWblvN3+aTCaiaUw9Rtar0HhxyJeyHIOeVXSjh+ERtgxs3mB/LulUWvodO6sav8hJnqT/DX1fWUM/VdGvMVHTz3kHaYqRkieZA3DkXalRJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961003; c=relaxed/simple;
	bh=XacCg/pWwY0SSi8ng2IgCqBPKaxCukK1XmMQWs135yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxaxrpkqxM8C2i+mqiBQs4iSbVwY6UwAUg3a1ipyZH0gp0m1GoptpOCNHrEe9zS8fCzxTSERn6dAOJlZuOl4Ct7GjlSuwbR1cQgXbS+pSEW5CBUWFYWKAcTVqNjj1cIDKVKM2NY+t0L9T830Th6QuJi1UTg5tVHpK+I0Bi+jDzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDdV7w3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B661EC4CEED;
	Tue,  8 Jul 2025 07:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751961003;
	bh=XacCg/pWwY0SSi8ng2IgCqBPKaxCukK1XmMQWs135yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SDdV7w3twz3NWsBoHo6KNql/vvPCHZe3XbFqCc1ZOPS8Ueze9S97eLF+LJh7Xe88/
	 3JM75pI782wgmDYJ6BUEhIbgtUp2/7xbZPw3K9180EAEt89kPIAeEcqJv8B1ze6WVZ
	 q/LoKNeeV4eb3zEH9eVKQf+fuHAb1P8dHjdapDqTJpfNsE/hs3tllMfu328o9PJTsJ
	 UgUS4CdDif74FHqsWC9S0xvJyg9dCjAMIowJHwLThkDmtp3cI9eV1rtUsnd4gFCpN6
	 UTRtHpvg0QGJ5yOBfYQKPgPr8jxAGJIZHurW1j1ZpA7PdlYPiMyKKov/pOJde+LbXW
	 aY2KQ9fu3FQBQ==
Date: Tue, 8 Jul 2025 09:50:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, horms@kernel.org, 
	jacob.e.keller@intel.com, u.kleine-koenig@baylibre.com, hkallweit1@gmail.com, 
	BMC-SW@aspeedtech.com
Subject: Re: [net-next v3 1/4] dt-bindings: net: ftgmac100: Add resets
 property
Message-ID: <20250708-termite-of-legal-imagination-826a9d@krzk-bin>
References: <20250708065544.201896-1-jacky_chou@aspeedtech.com>
 <20250708065544.201896-2-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708065544.201896-2-jacky_chou@aspeedtech.com>

On Tue, Jul 08, 2025 at 02:55:41PM +0800, Jacky Chou wrote:
> Add optional resets property for Aspeed SoCs to reset the MAC and

s/Aspeed SoCs/Aspeed AST2600 SoCs/

> RGMII/RMII.

... because ? It was missing? Incomplete? You changed hardware?

Make the commits useful, explain WHY you are doing, not repeating WHAT
you are doing. What is obvious from the diff. You already got this
feedback with other patches.

> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../bindings/net/faraday,ftgmac100.yaml       | 23 ++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index 55d6a8379025..a2e7d439074a 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Faraday Technology FTGMAC100 gigabit ethernet controller
>  
> -allOf:
> -  - $ref: ethernet-controller.yaml#
> -
>  maintainers:
>    - Po-Yu Chuang <ratbert@faraday-tech.com>
>  
> @@ -35,6 +32,11 @@ properties:
>        - description: MAC IP clock
>        - description: RMII RCLK gate for AST2500/2600
>  
> +  resets:
> +    maxItems: 1
> +    description:
> +      Optional reset control for the MAC controller

Drop description, redundant and obvious form the schema. It cannot be a
reset for anything else than MAC controller, because this is the MAC
controller. It cannot be "non optional" because schema says it is
optional.

Write concise and USEFUL descriptions/commit messages, not just
something to satisfy line/patch count.

Best regards,
Krzysztof


