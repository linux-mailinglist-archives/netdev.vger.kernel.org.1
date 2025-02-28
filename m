Return-Path: <netdev+bounces-170720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DA4A49AFB
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C32317470A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F1526D5A5;
	Fri, 28 Feb 2025 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE7bCFAs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6E1B960;
	Fri, 28 Feb 2025 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750757; cv=none; b=KDhMfCDT5iXvsUnOGx2IqHWfJuTQMIag22S3C/53bvoG0O+lH/eTy81fIik/EG0pY/GoMjl5GOaTVchHux4JBkt46RpCUju515whwIBqq/QFnPOuPFN1+hzisDfJ2RCiZNNIi9oBknx35G5xG+ZwRfbpIdDXZ0BQNMC1tpJhRhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750757; c=relaxed/simple;
	bh=V6oY9tzTMb/i0MQ73doFoT6+xPZ1RD1feBCIh6cAyjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BonbszuOZs+9+WP7FJcRj1VyVFiLrMfBUEvHn8x586r1hR19cqoKsH+bfam6zeGLG6Jjib3c7sk4adO+dp1pL6rwFYEeaGlSTu97dDPPr1pluus9ihdWuChn117KNy7zSD+1g9kY6Whas2i9IcH6G8bp9GXYfbm9Hk+hkM20VRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE7bCFAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43728C4CED6;
	Fri, 28 Feb 2025 13:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740750756;
	bh=V6oY9tzTMb/i0MQ73doFoT6+xPZ1RD1feBCIh6cAyjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VE7bCFAs/H4IvLRMMCe8mg9gL0g+1V6jQghKw2N81DISx4rISP2NHb6mvbcJtWIkq
	 83D77HdF9Pu37U6nUNiz4YVQqJG9s6vDJtmx6EFgUYROVXGU17hJzbab4xJ8fj+Osy
	 z5j0sO3QkD6uITImX5pq5wdw/WdEp6cHKNRRhxWelMeAQ4oy3iFF/p3OKRQSbjbadG
	 MsByQFXztHARHPZBHXg9aKkw5d3c+Az72mcGGt9idvytlz3TsIvk/lSZ8wyHYxcgPC
	 jXJQ2mgjcEm+0u44K1cvTHLQdL7G36Xn3mu3YdSii5qQ6xITitI5CHpQCzxlYw9zSj
	 O/Hh+Vbp2S5XA==
Date: Fri, 28 Feb 2025 07:52:34 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: net: Convert fsl,gianfar to YAML
Message-ID: <20250228135234.GB2579246-robh@kernel.org>
References: <20250220-gianfar-yaml-v1-0-0ba97fd1ef92@posteo.net>
 <20250220-gianfar-yaml-v1-3-0ba97fd1ef92@posteo.net>
 <20250221233523.GA372501-robh@kernel.org>
 <Z72fJSqng8od-5Z7@probook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z72fJSqng8od-5Z7@probook>

On Tue, Feb 25, 2025 at 10:44:53AM +0000, J. Neuschäfer wrote:
> On Fri, Feb 21, 2025 at 05:35:23PM -0600, Rob Herring wrote:
> > On Thu, Feb 20, 2025 at 06:29:23PM +0100, J. Neuschäfer wrote:
> > > Add a binding for the "Gianfar" ethernet controller, also known as
> > > TSEC/eTSEC.
> > > 
> > > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > > ---
> > >  .../devicetree/bindings/net/fsl,gianfar.yaml       | 242 +++++++++++++++++++++
> > >  .../devicetree/bindings/net/fsl-tsec-phy.txt       |  39 +---
> > >  2 files changed, 243 insertions(+), 38 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/fsl,gianfar.yaml b/Documentation/devicetree/bindings/net/fsl,gianfar.yaml
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..dc75ceb5dc6fdee8765bb17273f394d01cce0710
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/fsl,gianfar.yaml
> > > @@ -0,0 +1,242 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/net/fsl,gianfar.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Freescale Three-Speed Ethernet Controller (TSEC), "Gianfar"
> [...]
> > > +  "#address-cells": true
> > 
> > enum: [ 1, 2 ]
> > 
> > because 3 is not valid here.
> > 
> > > +
> > > +  "#size-cells": true
> > 
> > enum: [ 1, 2 ]
> > 
> > because 0 is not valid here.
> 
> Good point.
> 
> > 
> > 
> > > +
> > > +  cell-index:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +
> > > +  interrupts:
> > > +    maxItems: 3
> > 
> > Based on the if/then schema, you need 'minItems' here if the min is not 3.
> > 
> > Really, move the descriptions here and make them work for the combined 
> > interrupt case (just a guess).
> 
> The difference here (as previously documented in prose) is by device
> variant:
> 
>  for FEC:
> 
>    - one combined interrupt
> 
>  for TSEC, eTSEC:
> 
>    - transmit interrupt
>    - receive interrupt
>    - error interrupt
> 
> Combining these cases might look like this, not sure if it's good:
> 
>   interrupts:
>     minItems: 1
>     description:
>       items:
>         - Transmit interrupt or combined interrupt
>         - Receive interrupt
>         - Error interrupt

Yep, that's good. I would say 'single combined' to make it abundantly 
clear.

Rob

