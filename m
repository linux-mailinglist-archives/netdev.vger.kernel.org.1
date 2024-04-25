Return-Path: <netdev+bounces-91463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4937E8B2A88
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 23:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDA81C21227
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 21:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8175B15664C;
	Thu, 25 Apr 2024 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RfpwOz33"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E1D155A5C
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079590; cv=none; b=hkHifwRbonN93NeKlqU0wH1pn7jufSq9DcGzN6OEN6paceStQpQJTzikaSs3fed/41R1IJTH2aehi7qOWhrgJxMT8fMglfUbxJpuQ2g1fLNrTUr4NLPsnflF8mwuLTtBeys9oaMq0w8yAxyn77Nj6xyHxkSJeJGI6Yvci2rxLA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079590; c=relaxed/simple;
	bh=15oNxw9cg0Ma0JAvL/e0lrUAsZCU9MZqJWan96tMgLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/yOKZZKT+S6crQrLEGHBxwE1dhXOxmHXMclM3RkdZ9uikmf6oF08JlxmnpXm0IGLfZWl93/Z59MLbdSgZ4bNHJeUF51tPp6b/OpTQYiQg6fRhgzSGmwbE6MPCIChyn3wfJTfTPoOulWdTO1CILnX9gSbK6HBYAQq7rFuPDBWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RfpwOz33; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=w+WgeDsu9DFEJSzfwsPaQlOJZo9+5UWwccwLiLn4630=; b=Rf
	pwOz33ENnOxQMx2kSB0dLIFQbSP21fuG6YrWwzSPhmCP+8RbEAhoWDxOXkLpED2aGV1pxTUSc10+7
	xlkw1xMcUtiRGcvgsp6vzH969xPD67lsQkCr9WnbgQRLWcoZHCOE6f06wcx8um2Hy/5JCgY/mgiS6
	q4mGHBNY64QHldw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s06Ov-00E1TD-V3; Thu, 25 Apr 2024 23:13:05 +0200
Date: Thu, 25 Apr 2024 23:13:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SIMON BABY <simonkbaby@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: ping test with DSA ports failing
Message-ID: <08c97a2e-9060-4fac-9471-520f1401f300@lunn.ch>
References: <CAEFUPH1q9MPNBrfzhSmCawM4y+A6SKe47Pc1PjqShy-0Oo4-2w@mail.gmail.com>
 <05b24725-f266-4360-b8af-fd299fbff5be@lunn.ch>
 <CAEFUPH0KNr=tOTpSX5ZrjiwHNMeZgGWroS7PR5YwX2=W7=1TdA@mail.gmail.com>
 <11c3fe04-7aea-44eb-8f02-28bbe0c5ec03@lunn.ch>
 <CAEFUPH0d5UA5KjFaUK-2Mng=e+on7=qCENtUyLmuVEGCw4Qncg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEFUPH0d5UA5KjFaUK-2Mng=e+on7=qCENtUyLmuVEGCw4Qncg@mail.gmail.com>

On Thu, Apr 25, 2024 at 01:47:37PM -0700, SIMON BABY wrote:
> Yes, I used cat6 cable to connect RGMII ports between CPU and Marvel PHY. 
> 
> So if there is a physical cable between the PHYs, can the MAC talk to the PC ?
> Can this be the issue ?

Physical cable should not be a problem, so long as it is less than
100m long. Its just Ethernet, nothing special.

> Currently both sides have PHYs. In our actual board, on the SoC side there will
> not be any PHY and it will be wired with a high speed RGMII connector between
> MAC and Marvel PHY. 

That is how most systems work. But back to back PHYs is also
supported. However, you probably need different RGMII delays for each
configuration.

	Andrew

