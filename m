Return-Path: <netdev+bounces-245561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CDDCD1D0B
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 21:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AFF23074AA6
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 20:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CB32F8BD3;
	Fri, 19 Dec 2025 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHSIbtKW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36E92EC54C;
	Fri, 19 Dec 2025 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766177007; cv=none; b=XURl9z1zQLE2PyRBarEXwRrqh+ElL4KNE/nOMxZIKJNQ6n3rMHp11SxgXfYglVwOTPvvdfim/do06tRRm9EKA4IWNAoiDWUVP1VF5vLW4zL7gR6M6ZqPY4y9AEZfwgcr6MaX+82o2QnQEC6DVhvYBbJ5hi2GJUYQU2ax0pCkhCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766177007; c=relaxed/simple;
	bh=utane5PV8rbdLmphiJcDwcNC+dLLsZXwPHUOqnPr+qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lp8ECrKn/SJE5r6Nnnxw/VWd3SVh6oZV55aGyS1dTMTSz7kQ69HuZHcyAqGYPVaJ4WgYEddENc+68+gVlqQr/2YUHc4FWNif4G/0CSH2gEJ9vMmWoPm0ScaoqEytDjoEZKqbnf36rdZFZgM+VNjwsk26nMbGCQ7oghsgR7zlc8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHSIbtKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB98FC4CEF1;
	Fri, 19 Dec 2025 20:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766177007;
	bh=utane5PV8rbdLmphiJcDwcNC+dLLsZXwPHUOqnPr+qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHSIbtKW7gg5mzc1IExMi12uGn4LA2wcUd2Mv81Y2df6+beF2e+VgsdssAzYa3wDp
	 rcgrBKj2CD1asx+YNdmMXXHUkg1bxDD0sNvqBurHQeMG+z0AFeECgLUpauvaBP5YWU
	 eSlvM1NM+4uDyfHqM+V5kv0G2z4cL/iPP+xCuUTydr2iaD8AqJ57+8WtrDlJWa+exM
	 LS3bGA6YkQVBXXTchVTWM/3rpmtB3n3V6lljUaATqs4tDeXePPlMCPiFA5jnVcUXlm
	 8XYKA1eJmR1AYdF5Fmbc/AXBqkufBqmZczgflLD636kt/JYNn64H/zqWHuqXvuY1M8
	 hrwgTwFct6BIA==
Date: Fri, 19 Dec 2025 14:43:24 -0600
From: Rob Herring <robh@kernel.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: dsa: lantiq,gswip: add
 MaxLinear R(G)MII slew rate
Message-ID: <20251219204324.GA3881969-robh@kernel.org>
References: <20251216121705.65156-1-alexander.sverdlin@siemens.com>
 <20251216121705.65156-2-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216121705.65156-2-alexander.sverdlin@siemens.com>

On Tue, Dec 16, 2025 at 01:17:00PM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Add new maxlinear,mii-slew-rate-slow boolean property. This property is
> only applicable for ports in R(G)MII mode and allows for slew rate
> reduction in comparison to "normal" default configuration with the purpose
> to reduce radiated emissions.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
> Changelog:
> v2:
> - unchanged
> 
>  Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> index 205b683849a53..6cd5c6152c9e9 100644
> --- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> @@ -106,6 +106,11 @@ patternProperties:
>          unevaluatedProperties: false
>  
>          properties:
> +          maxlinear,mii-slew-rate-slow:

I would just reuse the pinctrl "slew-rate" property here. The values are 
binding specific.

> +            type: boolean
> +            description:
> +              Configure R(G)MII TXD/TXC pads' slew rate to "slow" instead
> +              of "normal" to reduce radiated emissions.
>            maxlinear,rmii-refclk-out:
>              type: boolean
>              description:
> -- 
> 2.52.0
> 

