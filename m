Return-Path: <netdev+bounces-186418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF282A9F085
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 14:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E158E3BFCCB
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 12:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA13265CA8;
	Mon, 28 Apr 2025 12:22:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC3886323;
	Mon, 28 Apr 2025 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745842930; cv=none; b=PeBmYDsYU3NmxiJJ/ywlvsRLnnFFZj6/DYFX/7dsfu2FFcNap2HZVpX6Vtt8lh4W5RJDBKbqj/cY8fkLrQqUtKwnvfbhlCJO7JQlrB/xgvHWQ45zRPgNSt154yyFTz6nELTelkTJKs6PLzprDm0JbgI9sFZcv5NhfydQzqjJNuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745842930; c=relaxed/simple;
	bh=iwCPnTEcqWtPPjwYKnp06t41X8Wuxu0DmYdPFC3IXto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnpM5ha4mqrVS6WWjhhYoBF8ZifuFQSUkZKVA3aq8mSw4wEFq5JkmK7SpHcAUNe6RDUQJmAtq8Z+qaxEPVaXZ3q3VjsTWJ8x2XXFE9tk2C+U8u3U9kx4Z6MhLuqTm4oiSmmKPsRmle+uk0t3y5lViQTngDlEiIPCODQnylH+efk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id A4D2134307B;
	Mon, 28 Apr 2025 12:22:07 +0000 (UTC)
Date: Mon, 28 Apr 2025 12:21:56 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: sram: sunxi-sram: Add A523 compatible
Message-ID: <20250428122156-GYA56330@gentoo>
References: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
 <20250424-01-sun55i-emac0-v2-1-833f04d23e1d@gentoo.org>
 <20250428-vegan-stoic-flamingo-1d1a2a@kuoka>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-vegan-stoic-flamingo-1d1a2a@kuoka>

Hi Krzysztof,

On 09:21 Mon 28 Apr     , Krzysztof Kozlowski wrote:
> On Thu, Apr 24, 2025 at 06:08:39PM GMT, Yixun Lan wrote:
> > The Allwinner A523 family of SoCs have their "system control" registers
> > compatible to the A64 SoC, so add the new SoC specific compatible string.
> > 
> > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > ---
> >  .../devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml     | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> > index a7236f7db4ec34d44c4e2268f76281ef8ed83189..e7f7cf72719ea884d48fff69620467ff2834913b 100644
> > --- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> > +++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> > @@ -50,6 +50,7 @@ properties:
> >            - enum:
> >                - allwinner,sun50i-a100-system-control
> >                - allwinner,sun50i-h6-system-control
> > +              - allwinner,sun55i-a523-system-control
> >            - const: allwinner,sun50i-a64-system-control
> 
> No update for the children (sram)?
> 
No, I don't think there is sub node for sram
From address map of A527, there is total 4KB size space of
this section which unlikely has sram available.

but I do see some BROM/SRAM space from 0x0000 0000 - 0x0006 3FFF ..
(which should not be relavant to this patch series..)

-- 
Yixun Lan (dlan)

