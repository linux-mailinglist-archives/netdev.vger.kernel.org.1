Return-Path: <netdev+bounces-249513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCBBD1A5F5
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04AB7308458C
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF903112C4;
	Tue, 13 Jan 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RI1Q6VtU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC4F309EF1;
	Tue, 13 Jan 2026 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322490; cv=none; b=PANaHr2LnRAp3Tl4cb6rCTLgI2pd/qjCU/uDcEjvI9LEWhO5GQo1ei9B6Go0cvYA7VRNhNDOPBPK2hvPjYuA6hX7k7lxR45kjfv8C/XSBEhajEvimHHSfRAv6O8c6GI93b2rSDLSRMMtyvpqWcwIJhwD65mN/zUZ7AvLnXfp1FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322490; c=relaxed/simple;
	bh=mqf7Xjbgmdf/GisuGgR4ZHA9B9VPATNl3k7bfZ5I5fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYuwHmR3Cil/v43mXHZJVovMRL9beW4i1LpI8Zns6/eH3l+FVx72vBLGU3xShaQ3leDUmiF3UZrMYhMrTm68mY5eHdpA3PWcSYM2iMwhCK0oqFTyBsph9g1Wo2kyhCXboC/EvuUDSoHTGoH7HaZJQ8IwAn1Zda8Yoyb7qQWhM6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RI1Q6VtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D397C116C6;
	Tue, 13 Jan 2026 16:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768322489;
	bh=mqf7Xjbgmdf/GisuGgR4ZHA9B9VPATNl3k7bfZ5I5fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RI1Q6VtUi5dILH0XazL42EXgxgosH82mBwZ/4viXoZRFDck3b1WY5EfKHTs3L5yfc
	 9S2cG00gAtCV4TlkwL+FgrrDwHhemBWly5j+wACT12NTTY92FHZqTgHEhHZyX0rt2Q
	 ODlWrajnV/M9szygXXX135h0V22eCT67aksi6lwoal5lt9IicWESQeGnBUGEXPNrcO
	 Zy6y8APgpoXtMMVcdSa9DedJZ2w6dtTKCQYx/+Mxkq34OsAiHYYVi91HxuRliwHlkf
	 Zp4mVeQ8nkfzEKj90R1olRJckMufMHvd38cyaxJCV6GGufaXF68nkNSuXSmB/s7wqm
	 +fioJO/t5/LOA==
Date: Tue, 13 Jan 2026 10:41:28 -0600
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
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: dsa: lantiq,gswip: add
 MaxLinear R(G)MII slew rate
Message-ID: <20260113164128.GA3919887-robh@kernel.org>
References: <20260107090019.2257867-1-alexander.sverdlin@siemens.com>
 <20260107090019.2257867-2-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107090019.2257867-2-alexander.sverdlin@siemens.com>

On Wed, Jan 07, 2026 at 10:00:16AM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Add new maxlinear,slew-rate-txc and maxlinear,slew-rate-txd uint32
> properties. The properties are only applicable for ports in R(G)MII mode
> and allow for slew rate reduction in comparison to "normal" default
> configuration with the purpose to reduce radiated emissions.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
> Changelog:
> v4:
> - separate properties for TXD and TXC pads ("maxlinear," prefix re-appears)
> v3:
> - use [pinctrl] standard "slew-rate" property as suggested by Rob
>   https://lore.kernel.org/all/20251219204324.GA3881969-robh@kernel.org/
> v2:
> - unchanged
> 
>  .../devicetree/bindings/net/dsa/lantiq,gswip.yaml  | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> index 205b683849a53..747106810cc17 100644
> --- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> @@ -106,6 +106,20 @@ patternProperties:
>          unevaluatedProperties: false
>  
>          properties:
> +          maxlinear,slew-rate-txc:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1]

default: 0

> +            description: |
> +              RMII/RGMII TX Clock Slew Rate:

blank line
> +              0: "Normal"
> +              1: "Slow"

Indent lists by 2 more spaces. Drop the quotes.

> +          maxlinear,slew-rate-txd:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1]
> +            description: |
> +              RMII/RGMII TX Non-Clock PAD Slew Rate:
> +              0: "Normal"
> +              1: "Slow"
>            maxlinear,rmii-refclk-out:
>              type: boolean
>              description:
> -- 
> 2.52.0
> 

