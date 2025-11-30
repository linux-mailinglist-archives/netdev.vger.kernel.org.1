Return-Path: <netdev+bounces-242763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E87E2C94A39
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 02:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982043A635D
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 01:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D26721A457;
	Sun, 30 Nov 2025 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u84KKSLd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3945C36D508;
	Sun, 30 Nov 2025 01:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764467031; cv=none; b=EkIusCDhrUc36DYFTdd5RIvBICxZ1JQgKrO29CAEty4OBlK7oIrbU4PNRLdiT9WdNdBwJ1TWGNOHL2c2PvAlR84K1/M2SAo6LvTCQswkcBeXi6R+fj+xVkhD7wr3k00CgEH/UEp2EoGzJ5fFDNj0Grv2KIr6erxvBJwqDNW1IlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764467031; c=relaxed/simple;
	bh=P8Z5woiRy6EoTDvCQKM87i8WHxCI3afW2uLvRA08wVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhwMIkbW4MjWQ06ugG2KVeyEMSdPm9ZNZvvQzcSFUSk2HiPfpmW0sf0SIBVV6ZWy3slqjLCMrumC3u5syUYbsw5ueDVmW0+7nbkLJpmh4fi3spRTeApQkbnJlkVaJEy0SWswnWqXuz3s9Vlcc8jBGqCy0S00yk8CioGF3vw5aAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u84KKSLd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hOKba22rvQaW7Abhgc1ihsuiQLeitBhJdLwu9kx38lE=; b=u84KKSLdSJw+u2pQ2NP/2RKqnW
	t3aUz9qus+h6hJzQfXGC8FhE4Pf88GS1EByF+jkl6H9YbXODg8L7E2CwE1nqtaK/c/rXkJ65hinaN
	qnrwuIZUgQ8wjstlId+eZhI9y+0sN6B4KD990ubI2XjceYkknuFyRAMZz0tPMMI3g61Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vPWTH-00FRDv-B6; Sun, 30 Nov 2025 02:43:27 +0100
Date: Sun, 30 Nov 2025 02:43:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	devicetree@vger.kernel.org
Subject: Re: [net-next,PATCH 2/3] dt-bindings: net: realtek,rtl82xx: Document
 realtek,ssc-enable property
Message-ID: <a7f83059-76aa-44df-aeb5-41b5072dd0d1@lunn.ch>
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
 <20251130005843.234656-2-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130005843.234656-2-marek.vasut@mailbox.org>

On Sun, Nov 30, 2025 at 01:58:33AM +0100, Marek Vasut wrote:
> Document support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
> RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. Introduce new DT property
> 'realtek,ssc-enable' to enable SSC mode for both RXC and SYSCLK clock
> signals.
> 
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Michael Klein <michael@fossekall.de>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: devicetree@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> index eafcc2f3e3d66..f1bd0095026be 100644
> --- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> @@ -50,6 +50,11 @@ properties:
>      description:
>        Disable CLKOUT clock, CLKOUT clock default is enabled after hardware reset.
>  
> +  realtek,ssc-enable:
> +    type: boolean
> +    description:
> +      Enable SSC mode, SSC mode default is disabled after hardware reset.

Spread Spectrum Clocking is a generic concept, applicable to more than
Ethernet PHYs. Do we really need a vendor property for this? Or is
there a generic property already?

	Andrew

