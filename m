Return-Path: <netdev+bounces-143529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B049C2E10
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 16:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F851F21C58
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 15:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394E019A281;
	Sat,  9 Nov 2024 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xRraR0Xg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2EA155C94;
	Sat,  9 Nov 2024 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731165226; cv=none; b=oMtCDg1cj54budFptAuYnYCn3pa8u84Noix0f26pASy6NdMzf4hwsX2lIr4YtydAhLMiDE62f0tH497odErapxOYNlkUARjtvWK7ApRyZeZA4K2lcuLWsG+c8jukNU3asgjObUfxmRwLS2SNBAh26b0sb5sAKjlpVzhniEq+bek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731165226; c=relaxed/simple;
	bh=JPuYZYFQoSS3IfqKdEvXWAGb671M99LKqnTQkNA0cDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuHTS28Pn3tAYZVFOz81U77IKQRPR3vXoZLcQ1iBe/N/y3hQNkw4yByeeQOobY1x4I59C0jVaxmHi8hC7sXKS6lZR01NtJJcckcgIf4wGRFhMt65kSOwLhaSzDuPd/qFYaoqIt/Y4BYOxrXb0o3W7yFeQixD/HVVTFNjZAggMGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xRraR0Xg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xyZTJo9f8gsK10SkI8qjNVOpiFFkSOls53vDKWxDbVo=; b=xRraR0XgPrKBa604t1HRU1Yt64
	yWeuU7ynYoJQ7iq2OrJI4nFN+M5RIHArwlj8j8F6tMVa+NfV1IBEUaBMzy/KKyuSNC8h+yW2/+5kw
	H8XdZloyyH1V+DN0mWh2lqEFaqviH8IMWAf+3dDFH4aYsicGCgXZKXM4hSiqvJI0l+lk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t9n9Q-00CiQC-16; Sat, 09 Nov 2024 16:13:24 +0100
Date: Sat, 9 Nov 2024 16:13:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Message-ID: <784a33e2-c877-4d0e-b3a5-7fe1a04c9217@lunn.ch>
References: <20241109015633.82638-1-Tristram.Ha@microchip.com>
 <20241109015633.82638-3-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109015633.82638-3-Tristram.Ha@microchip.com>

On Fri, Nov 08, 2024 at 05:56:33PM -0800, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The SGMII module of KSZ9477 switch can be setup in 3 ways: 0 for direct
> connect, 1 for 1000BaseT/1000BaseX SFP, and 2 for 10/100/1000BaseT SFP.

This naming is rather odd. First off, i would drop 'SFP'. It does not
have to be an SFP on the other end, it could be another switch for
example. 1 is PHY_INTERFACE_MODE_1000BASEX and 2 is
PHY_INTERFACE_MODE_SGMII.

> SFP is typically used so the default is 1.  The driver can detect
> 10/100/1000BaseT SFP and change the mode to 2.

phylink will tell you want mode to use. I would ignore what the
hardware detects, so this driver is just the same as every other
driver, making it easier to maintain.

	Andrew

