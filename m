Return-Path: <netdev+bounces-189252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FF6AB156D
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CEC1BC003F
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB9C291893;
	Fri,  9 May 2025 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xh+DCw0K"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED472139B;
	Fri,  9 May 2025 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798116; cv=none; b=Vtu4jK4F/u/e6tpnQBRaQvP5QXgoC4ti1qPBrp/krMa7vYb3Ps6BPozVzK5yD4y4s/5IGYNbBh+8S9bW2m2VKi5AOjQyRyLLmH9J7Eb2CruYurwP92LU7FDv2s1IYTLvyyYh17XmF+MBZLHsAxNFL/C8BXuaEhWj5T4tFgyLGXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798116; c=relaxed/simple;
	bh=ENdmeyVO+Q/f51831+cVkJnCzA+3uH28xZjh73MmqRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBG8hznPkZXqePDFvQ5WXE/iGCxmQhrC9CPludnwZ1jpy6pHEssF50sU5BXDQLeBtwGIpYdMTORYhZUNUPbE5bRYsV7o/pRulNdQLF/1Ry5/IWp9phd0E0J78HXZqgLwEtQ0ogBPtdqtw9RpaF3tV4Oo/2rW9x8e4PSNHjNrVWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xh+DCw0K; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FDVLEH5yV19CYxuquKl3nIjikRTaL0+5usSMY1mNDgc=; b=Xh+DCw0KyHP+ZudYA4iiAsyO9k
	ii1sMMbNTAd6BBRIcw6Vz2CBH/1JLIFrX905oGnYkZya6s5T/FUh64ZCi178u0RIbf7PA0zSCgkJJ
	jFzLg3eF+/V5pQfegU+Kuxzv6eYcF+fRYTNHqvya5krFkEbSSziMIMcQI+3hTB8G7Tdw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uDNyy-00C7Ec-Ov; Fri, 09 May 2025 15:41:44 +0200
Date: Fri, 9 May 2025 15:41:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next V3 3/6] net: vertexcom: mse102x: Drop invalid
 cmd stats
Message-ID: <30a4dccc-3e7a-4829-b927-9b6298a1ac23@lunn.ch>
References: <20250509120435.43646-1-wahrenst@gmx.net>
 <20250509120435.43646-4-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509120435.43646-4-wahrenst@gmx.net>

On Fri, May 09, 2025 at 02:04:32PM +0200, Stefan Wahren wrote:
> There are several reasons for an invalid command response
> by the MSE102x:
> * SPI line interferences
> * MSE102x is in reset or has no firmware
> * MSE102x is busy
> * no packet in MSE102x receive buffer
> 
> So the counter for invalid command isn't very helpful without
> further context. So drop the confusing statistics counter,
> but keep the debug messages about "unexpected response" in order
> to debug possible hardware issues.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

