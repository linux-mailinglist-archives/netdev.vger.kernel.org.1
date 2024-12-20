Return-Path: <netdev+bounces-153640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AF09F8ED7
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 10:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B359F18929DF
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 09:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5798C1A83E6;
	Fri, 20 Dec 2024 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VVG2gYVY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E7A5588F
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734686524; cv=none; b=JuwE8VQ0Y1N+kEVyPNQkZMVsOagL0OEkujVcwd/c1QpxDliCiIl1AGDHr5bPlKOVFAAklArqWaq7sxro5YBenBXiMjutvCGOjOhuLBB5KygYV1TxvGP+rbX2xA9yOlVHqZjlcjFbbqC4ukLrETm0GrNwPz8XcVLmj6Qyj3pMhYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734686524; c=relaxed/simple;
	bh=S4dYKUblW8ylPchw0LwY1jQvZQO7o29xnY9qY+FFM2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pk51PvZUs3GQiHvg9xUmdRJEIETCkfny+E4ssmoLpx3j/uuJk2Vbnc2CaJVy37rwV9Fz0k9qaefPZZwdqxHeHMMTtgm+gmAJ9TavJN7xAs6fhRISeBMCADocq+lC4ehi/kUhRprwLezeJYH1LHlOqhmfrGdqIxOOh8Q+iILWic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VVG2gYVY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=TKCYnOODXRd1RtvDgL5yD4V3IoubZFDmMd4Uwe1tZmo=; b=VV
	G2gYVYInVdP0VBxe7x/n+gG/8oiweeUZ5cbu+HxLDOgcIfF38aDfeYoFCr5edjoT2ExIzNUDomwiM
	C5ZPyte+gGAOBTbKk5ewdy+qqeu3hVCnXsmVXEvBT5ySVV0HoljSWX58rACMNtDAX7o1Ft17fRN0h
	K5lrUPXDU8QDf2Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOZCn-001w9H-5F; Fri, 20 Dec 2024 10:21:57 +0100
Date: Fri, 20 Dec 2024 10:21:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: tianx <tianx@yunsilicon.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com
Subject: Re: [PATCH v1 00/16] net-next/yunsilicon: ADD Yunsilicon XSC
 Ethernet Driver
Message-ID: <cecb55e5-d1bb-4043-a193-13a9c0b741d1@lunn.ch>
References: <20241218105023.2237645-1-tianx@yunsilicon.com>
 <20241218163509.008d1787@kernel.org>
 <c39a3ba3-ab66-4b0f-9881-f5d98049949a@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c39a3ba3-ab66-4b0f-9881-f5d98049949a@yunsilicon.com>

On Fri, Dec 20, 2024 at 02:40:33PM +0800, tianx wrote:
> Thank you for the feedback. I will remove the last two patches as 
> requested. However, I would like to keep the third-to-last 
> patch(ndo_get_stats64), as it ensures "|ifconfig|/|ip||a|" display 
> correct pkt statistics for our interface. I hope that’s acceptable.

Please don't top post.

       Andrew

> 
> On 2024/12/19 8:35, Jakub Kicinski wrote:
> > On Wed, 18 Dec 2024 18:51:01 +0800 Xin Tian wrote:
> >>   45 files changed, 12723 insertions(+)
> > This is a lot of code and above our preferred patch limit.
> > Please exclude the last 3 patches from v2. They don't seem
> > strictly necessary for the initial driver.

