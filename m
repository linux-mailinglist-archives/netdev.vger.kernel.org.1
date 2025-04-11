Return-Path: <netdev+bounces-181678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0654FA8613C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A3C19E8D76
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC37B20AF99;
	Fri, 11 Apr 2025 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDbAI+ZB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3F51F4CA9;
	Fri, 11 Apr 2025 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744383890; cv=none; b=mdHHO90UXj5Vp8JULPWmtLSEpcxlTs26ytJYlrBHswvLGbp4CC+CwKB57rCYzVSwnud46oR4IdNYhFk+dWbc7kw8V3voyIKeQshbYNk88l+zeaEwVBISZzASeXsJ48iXjk1TD5cCTnaMSZjLdnmNTbtgwaISQYIfS4smxqYBuEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744383890; c=relaxed/simple;
	bh=34rPtorzTUoCO3aLt2l9yvCOuNgkas861WqZJZQNEKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdQQlqCIs+V0rA0dmdTlS6uXI5I7T+sALAD8ngUbJpVcsoMGPi//JfEm4c7T+qz3EIAOgDCPz0bdSdrGQtZFoSfm1y90YqSJuxAom5EP5CA0CLy9eM7tDPauaDXDZKqdo1D47cridKe+rd0McrSe7E3hT1lRHv4Mzlkds3oTTbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDbAI+ZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4CFC4CEE2;
	Fri, 11 Apr 2025 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744383890;
	bh=34rPtorzTUoCO3aLt2l9yvCOuNgkas861WqZJZQNEKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDbAI+ZBF/+a+TS4pO/A3ZGxi+eY+4S9Mp3E4tPyntXHfrlVKRnrF8PuOGevL4YBs
	 cmWWBm0c/eKT6u258RIpB7vfCJsAGmoxPn39kX9hDch/eWxmNAJC/CU5JLuAKAI13S
	 /LsUt50GVb7Qx/SWQRTB23fGrJP1JpckqYSJJH63Nu7vRod+ftprXGXqDVMuG/9DjG
	 ZhoDpUkc+zGsnBo5Ier7Fj/njks8r/a00GX0U2O75ECUvzv6E2TndbDS/99jRgoPAU
	 7Zei8lofUZUsd3a4EpSrgRBQsHAR46J1/EzQU6J8mgSeB/F8etOnPWTPb7n58nbJmU
	 45cVs/bEdKz6Q==
Date: Fri, 11 Apr 2025 10:04:48 -0500
From: Rob Herring <robh@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"Fedrau Dimitri (LED)" <Dimitri.Fedrau@liebherr.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/3] net: phy: dp83822: Add support for
 changing the MAC termination
Message-ID: <20250411150448.GA3236749-robh@kernel.org>
References: <20250408-dp83822-mac-impedance-v2-0-fefeba4a9804@liebherr.com>
 <20250408-dp83822-mac-impedance-v2-3-fefeba4a9804@liebherr.com>
 <7dbf8923-ac78-47b8-8b9c-8f511a40dfa3@lunn.ch>
 <DB8P192MB0838E18B78149B3EC1E0F168F3B52@DB8P192MB0838.EURP192.PROD.OUTLOOK.COM>
 <04dc2856-f717-4d27-9e5c-5374bb01a322@lunn.ch>
 <20250408171831.GA4828@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250408171831.GA4828@debian>

On Tue, Apr 08, 2025 at 07:18:31PM +0200, Dimitri Fedrau wrote:
> On Tue, Apr 08, 2025 at 03:28:32PM +0200, Andrew Lunn wrote:
> > On Tue, Apr 08, 2025 at 01:01:17PM +0000, Fedrau Dimitri (LED) wrote:
> > > -----Ursprüngliche Nachricht-----
> > > Von: Andrew Lunn <andrew@lunn.ch> 
> > > Gesendet: Dienstag, 8. April 2025 14:47
> > > An: Fedrau Dimitri (LED) <dimitri.fedrau@liebherr.com>
> > > Cc: Heiner Kallweit <hkallweit1@gmail.com>; Russell King <linux@armlinux.org.uk>; David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Florian Fainelli <f.fainelli@gmail.com>; netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Dimitri Fedrau <dima.fedrau@gmail.com>
> > > Betreff: Re: [PATCH net-next v2 3/3] net: phy: dp83822: Add support for changing the MAC termination
> > > 
> > > > > +static const u32 mac_termination[] = {
> > > > > +	99, 91, 84, 78, 73, 69, 65, 61, 58, 55, 53, 50, 48, 46, 44, 43,
> > > > 
> > > > Please add this list to the binding.
> > > 
> > > Add this list to "ti,dp83822.yaml" ?
> > 
> > Yes please. Ideally we want the DT validation tools to pick up invalid
> > values before they reach the kernel.
> >
> Ok, but then I would have to add "mac-termination-ohms" property to
> "ti,dp83822.yaml" as well together with the allowed values ? Ending up in
> some sort of duplication, because the property is already defined in
> "ethernet-phy.yaml". Is this the right way to do it ?

It is not duplication because you are adding constraints. I was thinking 
the definition in ethernet-phy.yaml should have some logical limit. Say
200 ohms as termination resistance is typically 10s of ohms. 

Seems like a long list to define to me, but if the driver is going to 
reject unknown values it makes sense. You could also make the driver 
just pick the closest match rather than require an exact match. 
Resistance values are nominal anyways.

Rob


