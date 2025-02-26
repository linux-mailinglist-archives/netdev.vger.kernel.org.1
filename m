Return-Path: <netdev+bounces-169865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9AEA460F5
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3F01897817
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 13:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2426153BF0;
	Wed, 26 Feb 2025 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjuupZf2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8596441C71;
	Wed, 26 Feb 2025 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576676; cv=none; b=sjOfJi5hCT0ZotJdWy9vGWYU/qrnzhU64FgRy8DWq81OnzcbTnCdvQxdjtP3MzBIobRHgyAyq0/FopOPo1ylHcBSQrUce8AoZuHicqD7V5YKJOHDXQHNNYTQMqeGeBgYizwhvUQBOPEC5ogdXQuEInlf/i6bUbiAqaIJoaoS6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576676; c=relaxed/simple;
	bh=Vp6HcTVpDk2h280Ok7uCeqD39E3wb4stZLrdzzwFkIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTcm+ymNBJ0hz3NeFtkUgrvtI8JM7hG1dAuN3Uyg1Oc+MqnRJFrocWumJASsQflyxmnkdJgekEygTDVSZMaYLZqODmMRd+GpJ4JB1zE7CDuZKT5WRZGV5WJL1+EbhTkGOPaERuYMvZfHD7emRuzfvwtQueTQKyp6rYLdzgRBScQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjuupZf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B096BC4CED6;
	Wed, 26 Feb 2025 13:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740576675;
	bh=Vp6HcTVpDk2h280Ok7uCeqD39E3wb4stZLrdzzwFkIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjuupZf2sJ92mIYEznNVlc0SUJC2XwBUEHGzvVHCTgdlkElb0JwdBPlZZ8QmTKdet
	 OT2AcUP7jPzqv4p/g4F/d3eAR7hSv+7bgRHyRPyYlxIiAtxzOgKZFoWwSWwnA0lw+u
	 gGOZtCt2TqUPfL3jFCp8bQAoXk08gbiCgy7k9Vzhs+uQGmP63hwSK4iHDBsjNEd+OE
	 Uu5pfpZjFRzIivwyh5MIMhpyYVHEWOSo4NOeNelGQ3H9i43qL1u5lCH0p84ZjPWtGk
	 1S4HPSzY8IDX8AJobXwIcK4n2IBwILdc3bWQ3jphcME4DQQExJ1TxkzTQDEeJpnAhv
	 X2v28lNEuqjFQ==
Date: Wed, 26 Feb 2025 07:31:14 -0600
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
Subject: Re: [PATCH 1/3] dt-bindings: net: Convert fsl,gianfar-{mdio,tbi} to
 YAML
Message-ID: <20250226133114.GA1771231-robh@kernel.org>
References: <20250220-gianfar-yaml-v1-0-0ba97fd1ef92@posteo.net>
 <20250220-gianfar-yaml-v1-1-0ba97fd1ef92@posteo.net>
 <20250221163651.GA4130188-robh@kernel.org>
 <Z7zdawaVsQbBML95@probook>
 <Z72lqrhs50NtoK8m@probook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z72lqrhs50NtoK8m@probook>

On Tue, Feb 25, 2025 at 11:12:42AM +0000, J. Neuschäfer wrote:
> On Mon, Feb 24, 2025 at 08:58:19PM +0000, J. Neuschäfer wrote:
> > On Fri, Feb 21, 2025 at 10:36:51AM -0600, Rob Herring wrote:
> > > On Thu, Feb 20, 2025 at 06:29:21PM +0100, J. Neuschäfer wrote:
> > > > Move the information related to the Freescale Gianfar (TSEC) MDIO bus
> > > > and the Ten-Bit Interface (TBI) from fsl-tsec-phy.txt to a new binding
> > > > file in YAML format, fsl,gianfar-mdio.yaml.
> > > > 
> > > > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > > > ---
> > [...]
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - fsl,gianfar-tbi
> > > > +      - fsl,gianfar-mdio
> > > > +      - fsl,etsec2-tbi
> > > > +      - fsl,etsec2-mdio
> > > > +      - fsl,ucc-mdio
> > > > +      - gianfar
> > > 
> > > Can you just comment out this to avoid the duplicate issue.
> > > 
> > > Though I think if you write a custom 'select' which looks for 
> > > 'device_type = "mdio"' with gianfar compatible and similar in the other 
> > > binding, then the warning will go away. 
> > 
> > I'm not sure how the 'select' syntax works, is there a reference
> > document I could read?
> 
> Ok, I think I figured it out, this seems to work as intended:
> 

Looks pretty good.

> 
> select:
>   oneOf:
>     - properties:
>         compatible:

Add "contains" here. That way if someone puts another string in with 
these we still match and then throw a warning.

>           enum:
>             - fsl,gianfar-tbi
>             - fsl,gianfar-mdio
>             - fsl,etsec2-tbi
>             - fsl,etsec2-mdio
>             - fsl,ucc-mdio
> 
>       required:
>         - compatible
> 
>     - properties:
>         compatible:
>           enum:
>             - gianfar
>             - ucc_geth_phy

You could move ucc_geth_phy because there's not a collision with it.

Add a comment somewhere that this is all because of a reuse of gianfar.

>         device_type:
>           const: mdio
> 
>       required:
>         - compatible
>         - device_type

You can move 'required: [compatible]' out of the oneOf.

> 
> properties:
>   compatible:
>     enum:
>       - fsl,gianfar-tbi
>       - fsl,gianfar-mdio
>       - fsl,etsec2-tbi
>       - fsl,etsec2-mdio
>       - fsl,ucc-mdio
>       - gianfar
>       - ucc_geth_phy
> 
>   reg:
>     ...
> 
> 
> 
> Best regards,
> J. Neuschäfer

