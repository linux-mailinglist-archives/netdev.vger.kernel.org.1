Return-Path: <netdev+bounces-170718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E71A49AB0
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D563BA3F9
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C9E26B2B5;
	Fri, 28 Feb 2025 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeVdeGL9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7220F1E4A9;
	Fri, 28 Feb 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749898; cv=none; b=Nl0BbQKabbbELlv7TKnMCwKgBpkwzOl7dr8OBwQNl0hMFVcZotBlfcl8G/yViSAAvZgKni78PCX1SousEfxOxhnjbl19PCgWR4IeH5bFOtOCTsJa9CBMZvbDpMgcwh//wlMJKKpNmRffowr2tZHJwxesKyf9WZS1YETtJBVitXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749898; c=relaxed/simple;
	bh=0mnDp5t6ahjG2frprA1XDZG1zKgNmFNkH0FBio58rNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CU3h+PKhqBbtd+7yz8Yl+cQ7dDHdDz1hZSJ9I+RBu1WluXAntLwPHmRw4n61G3qz0MsKlqW5/Nxfs7ujP4ULTR9MKOR8O0yB4Tm/9ZcQu5Mp7jyBhWJ9Tnvm6QY3nkCwWRX+G0tMs25R78cToVEX+g2EafigWQIcDFONUCy1CEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeVdeGL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B04C4CED6;
	Fri, 28 Feb 2025 13:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740749893;
	bh=0mnDp5t6ahjG2frprA1XDZG1zKgNmFNkH0FBio58rNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YeVdeGL9eIF+ruseMnB3dZ3p8hntl0E85vK3P744e71EWCVFjxAAoNHZRxQt9yAgq
	 dEpbHkfhWv+uridWc8fWBmcHTNGHY+w14upM2GEiSRYfh4ojS3/bqW3r5xCqkw/EVl
	 hyY+f2E7UlwBU5H25VZgZhhpN0zXzX3z0xXVbB/Kobvr6Z93utNjPfBrgI9rODenKL
	 49LkbNs5S2sucpDAug3X6qkMCFDS58/B7jTFBRCG9loo7A/WlRfTWI3UGG8zBXMiv8
	 GKMUSrYQsPhuST+D+KDXkUUKG9cdS90ORWdMGXBnRecnSkREBr2RYDysj2PDzAGQZU
	 edoBS3xEzlJhw==
Date: Fri, 28 Feb 2025 07:38:11 -0600
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
Message-ID: <20250228133811.GA2579246-robh@kernel.org>
References: <20250220-gianfar-yaml-v1-0-0ba97fd1ef92@posteo.net>
 <20250220-gianfar-yaml-v1-1-0ba97fd1ef92@posteo.net>
 <20250221163651.GA4130188-robh@kernel.org>
 <Z7zdawaVsQbBML95@probook>
 <Z72lqrhs50NtoK8m@probook>
 <20250226133114.GA1771231-robh@kernel.org>
 <Z78sOtFfNC8i2amq@probook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z78sOtFfNC8i2amq@probook>

On Wed, Feb 26, 2025 at 02:59:06PM +0000, J. Neuschäfer wrote:
> On Wed, Feb 26, 2025 at 07:31:14AM -0600, Rob Herring wrote:
> > On Tue, Feb 25, 2025 at 11:12:42AM +0000, J. Neuschäfer wrote:
> > > On Mon, Feb 24, 2025 at 08:58:19PM +0000, J. Neuschäfer wrote:
> > > > On Fri, Feb 21, 2025 at 10:36:51AM -0600, Rob Herring wrote:
> > > > > On Thu, Feb 20, 2025 at 06:29:21PM +0100, J. Neuschäfer wrote:
> > > > > > Move the information related to the Freescale Gianfar (TSEC) MDIO bus
> > > > > > and the Ten-Bit Interface (TBI) from fsl-tsec-phy.txt to a new binding
> > > > > > file in YAML format, fsl,gianfar-mdio.yaml.
> > > > > > 
> > > > > > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > > > > > ---
> > > > [...]
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    enum:
> > > > > > +      - fsl,gianfar-tbi
> > > > > > +      - fsl,gianfar-mdio
> > > > > > +      - fsl,etsec2-tbi
> > > > > > +      - fsl,etsec2-mdio
> > > > > > +      - fsl,ucc-mdio
> > > > > > +      - gianfar
> > > > > 
> > > > > Can you just comment out this to avoid the duplicate issue.
> > > > > 
> > > > > Though I think if you write a custom 'select' which looks for 
> > > > > 'device_type = "mdio"' with gianfar compatible and similar in the other 
> > > > > binding, then the warning will go away. 
> > > > 
> > > > I'm not sure how the 'select' syntax works, is there a reference
> > > > document I could read?
> > > 
> > > Ok, I think I figured it out, this seems to work as intended:
> > > 
> > 
> > Looks pretty good.
> > 
> > > 
> > > select:
> > >   oneOf:
> > >     - properties:
> > >         compatible:
> > 
> > Add "contains" here. That way if someone puts another string in with 
> > these we still match and then throw a warning.
> 
> Good idea.
> 
> > 
> > >           enum:
> > >             - fsl,gianfar-tbi
> > >             - fsl,gianfar-mdio
> > >             - fsl,etsec2-tbi
> > >             - fsl,etsec2-mdio
> > >             - fsl,ucc-mdio
> > > 
> > >       required:
> > >         - compatible
> > > 
> > >     - properties:
> > >         compatible:
> > >           enum:
> > >             - gianfar
> > >             - ucc_geth_phy
> > 
> > You could move ucc_geth_phy because there's not a collision with it.
> 
> ucc_geth_phy also requires device_type = "mdio". It is more compact
> to write it like this, but perhaps clarity wins out here, and this
> requirement should be expressed with an "if:"?

Yes, an if/then schema outside of the select would be fine.

Rob

