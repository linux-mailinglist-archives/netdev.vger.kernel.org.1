Return-Path: <netdev+bounces-169423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D675DA43D15
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDCF188BF50
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C8D207A11;
	Tue, 25 Feb 2025 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="EhIZH8hs"
X-Original-To: netdev@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A655933CFC
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481968; cv=none; b=jOnT54nn72TsZWjRERwSW6hT+Z/o5OuSG6K77LHJ6dX7xaWTkun6GbH0AiUP4waayoa8K6CbonXmzHHWp220xaJQF9D/cNqytgbR3V7hhICc29w9GXWG8o75v/pQ3hVZZ9RKzm50jOfrgnQiNY7WLankdCcbb3ipvdlC8WlV1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481968; c=relaxed/simple;
	bh=rZvIG9n9FNdpcEfyyXYKwUcmzUi8Kx09rg3zVUfKq8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KF39blPJEuW2ua1n4YtGSrEHemY24wem5owEWXiM+aTBztHOBkqjnd5Ut6RWf3kghLuJSirnIZx5A+PxuBLXYtfwxfBo8/ByEcKenR1S8gcFqbUVaAKsA1whnPsTcJFr4+4XK6EFdFykhJwkl9FiAm65tOZNIGBQCm2QvlFYBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=EhIZH8hs; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id A54CC240027
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:12:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1740481964; bh=rZvIG9n9FNdpcEfyyXYKwUcmzUi8Kx09rg3zVUfKq8I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=EhIZH8hs/aMR450/GimsVhqbpgAON1uB5v2XPJuAL0PYwaOqXmnbJmhYonF3/f3WB
	 ipBbh1duVftQ1cstlq/r0pCmf+RZ4sf1KV6F2+72xMBmnFCAfKHORtThuIfOPQ2uHX
	 92+bBH6dHjPDyEV3JppnYtfySYoI60qifkU+SEAoD0j3VTrRGQFdrcWGK6OuWGlCBc
	 UhmvmdSpggkWPS1GBZOSFp47tSu+3bxgsmvxmwn9vouP9dcFS5SNTlGw6L3ZmEac4k
	 JNXJQPhYJIpx/rZ8/VDqE3X4O5eu/+1ahxP1O8lgOSmhnXLdYu1q/T07MHFDvBg2iy
	 51Hth7ZvNjJmQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Z2FLy4hhMz6txf;
	Tue, 25 Feb 2025 12:12:42 +0100 (CET)
Date: Tue, 25 Feb 2025 11:12:42 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: net: Convert fsl,gianfar-{mdio,tbi} to
 YAML
Message-ID: <Z72lqrhs50NtoK8m@probook>
References: <20250220-gianfar-yaml-v1-0-0ba97fd1ef92@posteo.net>
 <20250220-gianfar-yaml-v1-1-0ba97fd1ef92@posteo.net>
 <20250221163651.GA4130188-robh@kernel.org>
 <Z7zdawaVsQbBML95@probook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7zdawaVsQbBML95@probook>

On Mon, Feb 24, 2025 at 08:58:19PM +0000, J. Neuschäfer wrote:
> On Fri, Feb 21, 2025 at 10:36:51AM -0600, Rob Herring wrote:
> > On Thu, Feb 20, 2025 at 06:29:21PM +0100, J. Neuschäfer wrote:
> > > Move the information related to the Freescale Gianfar (TSEC) MDIO bus
> > > and the Ten-Bit Interface (TBI) from fsl-tsec-phy.txt to a new binding
> > > file in YAML format, fsl,gianfar-mdio.yaml.
> > > 
> > > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > > ---
> [...]
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - fsl,gianfar-tbi
> > > +      - fsl,gianfar-mdio
> > > +      - fsl,etsec2-tbi
> > > +      - fsl,etsec2-mdio
> > > +      - fsl,ucc-mdio
> > > +      - gianfar
> > 
> > Can you just comment out this to avoid the duplicate issue.
> > 
> > Though I think if you write a custom 'select' which looks for 
> > 'device_type = "mdio"' with gianfar compatible and similar in the other 
> > binding, then the warning will go away. 
> 
> I'm not sure how the 'select' syntax works, is there a reference
> document I could read?

Ok, I think I figured it out, this seems to work as intended:



select:
  oneOf:
    - properties:
        compatible:
          enum:
            - fsl,gianfar-tbi
            - fsl,gianfar-mdio
            - fsl,etsec2-tbi
            - fsl,etsec2-mdio
            - fsl,ucc-mdio

      required:
        - compatible

    - properties:
        compatible:
          enum:
            - gianfar
            - ucc_geth_phy

        device_type:
          const: mdio

      required:
        - compatible
        - device_type

properties:
  compatible:
    enum:
      - fsl,gianfar-tbi
      - fsl,gianfar-mdio
      - fsl,etsec2-tbi
      - fsl,etsec2-mdio
      - fsl,ucc-mdio
      - gianfar
      - ucc_geth_phy

  reg:
    ...



Best regards,
J. Neuschäfer

