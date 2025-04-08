Return-Path: <netdev+bounces-180240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7885A80C40
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93FF77B8CEC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AF51ADC6C;
	Tue,  8 Apr 2025 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WvQYQVXL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC71A8F68;
	Tue,  8 Apr 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118924; cv=none; b=Ztj3WgUbXX2jE1WJLwhyoMPU6qeNH2QJrC8Jk85xqTNEaXrRB9MMTtQhf/2MnnkiLaf4zzesw1PcXaXRMySyxjg/5eJ4M3Uthm1wpf4CPWeodyt4QEipFVNPewT57DwWuhFLV+1u+SVY+7SHdYuAfkOX9+Gpc9KuzX7bXydwBpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118924; c=relaxed/simple;
	bh=FOEfsdtggZpueu42qCVL9YDUw6hhgAGwnCwWUW7mVy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNifqsn362BuzP77i0XCZfOpap26OlOsivY4AYMPK5TTMINOtYCiFmQugHxXrqDKbk0TyEg0CYFlN529edjw8+ffAIkZdPvs4Z67/ccbyCuHQtlwmCnMGup3QOlRMX2+pl36ZiyTlMPGvTslTsb/oi47jx8z7Y/jWYFj82TqgaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WvQYQVXL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=yNmt2P/R29qfDB07hCARjvDDMhO5YVvydaAbFo0JqDg=; b=Wv
	QYQVXLRHxunB2Wazfuj140N86KF8BZBODgTOJjxE95LZDjvstKOVF9lzmS30P1Z1gxWvZfud2U7Cx
	QyMjyd8YdmT1xnuDHf4d07XXh60+FLrB3hhvHWOMN8pp2vIawMbJjwgioRT86VbFI/fND9zfWTJ5e
	Lr+F0lWVy8EGDCA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u290C-008OZj-MU; Tue, 08 Apr 2025 15:28:32 +0200
Date: Tue, 8 Apr 2025 15:28:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Fedrau Dimitri (LED)" <Dimitri.Fedrau@liebherr.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: phy: dp83822: Add support for
 changing the MAC termination
Message-ID: <04dc2856-f717-4d27-9e5c-5374bb01a322@lunn.ch>
References: <20250408-dp83822-mac-impedance-v2-0-fefeba4a9804@liebherr.com>
 <20250408-dp83822-mac-impedance-v2-3-fefeba4a9804@liebherr.com>
 <7dbf8923-ac78-47b8-8b9c-8f511a40dfa3@lunn.ch>
 <DB8P192MB0838E18B78149B3EC1E0F168F3B52@DB8P192MB0838.EURP192.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB8P192MB0838E18B78149B3EC1E0F168F3B52@DB8P192MB0838.EURP192.PROD.OUTLOOK.COM>

On Tue, Apr 08, 2025 at 01:01:17PM +0000, Fedrau Dimitri (LED) wrote:
> -----Ursprüngliche Nachricht-----
> Von: Andrew Lunn <andrew@lunn.ch> 
> Gesendet: Dienstag, 8. April 2025 14:47
> An: Fedrau Dimitri (LED) <dimitri.fedrau@liebherr.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>; Russell King <linux@armlinux.org.uk>; David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Florian Fainelli <f.fainelli@gmail.com>; netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Dimitri Fedrau <dima.fedrau@gmail.com>
> Betreff: Re: [PATCH net-next v2 3/3] net: phy: dp83822: Add support for changing the MAC termination
> 
> > > +static const u32 mac_termination[] = {
> > > +	99, 91, 84, 78, 73, 69, 65, 61, 58, 55, 53, 50, 48, 46, 44, 43,
> > 
> > Please add this list to the binding.
> 
> Add this list to "ti,dp83822.yaml" ?

Yes please. Ideally we want the DT validation tools to pick up invalid
values before they reach the kernel.

    Andrew

