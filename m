Return-Path: <netdev+bounces-103231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFA5907374
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD831C218DC
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91CF143895;
	Thu, 13 Jun 2024 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r3qudwBb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5847E1E49B;
	Thu, 13 Jun 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284838; cv=none; b=J7hMGUYaEK2wmYZHt6ElnJxw2aHiKMClIDaMKlVCWHWkziJ3FGlSpcBK3mHC0fKb+vgL+2O2k9T1wKey678msiItoZnHkVePWEgOjwZNnrhJ1NqAOGTfPd5oHJuiyoZGdCA/LpG6qsSopZP3ZncMzm/kBdKSq7eWzwHY86l0X5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284838; c=relaxed/simple;
	bh=FzuExro4uIk2k4nbCaMBLzMpn3nswdMSJP/uZuRxQcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3VLX2ntG/ZYhK/U5GgN4tMKHeRA+LQ/bMZoYUnPe1GvCYziF3QJGJ5dkJ/jqFtCqw/+5GjOgJfGBYDa//0HK/HufrT3m66LUDXUq7V45cBAn+hukJGZX4YlIiFPjX5yUK7qed8yG/DEXzobjj4kSBn++vxdl+NMMbj/tYCgJns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r3qudwBb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i8688szl63D6YrLGnRIooiIsp6+nFmLFeRCBfFgsByc=; b=r3qudwBbL4o1y1p8mcjNYDxXFF
	ueDu4ieFTVSOuQBcmFHbO15jg7yMxyGrN5izHaDomvtD1TXMp/Ti6Rl5vmYIZytujOwf7QMdRS1KN
	RU6vN3cmSHtPFV5PciMk25jRZ1gYGrDPuo0ZqrSdOeDNsIUTaKu7DKyNkFdoisj4HG3o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sHkNN-00HZ8R-V9; Thu, 13 Jun 2024 15:20:25 +0200
Date: Thu, 13 Jun 2024 15:20:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - May 7th
Message-ID: <b8cfe2c0-751b-4fbd-9819-b6fdb6dde724@lunn.ch>
References: <20240506075257.0ebd3785@kernel.org>
 <2730a628-88c8-4f46-a78d-03f96b3ec3e2@lunn.ch>
 <4a2236c6-1a1a-45bb-89d5-bbb66a8e79b3@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a2236c6-1a1a-45bb-89d5-bbb66a8e79b3@intel.com>

On Thu, Jun 13, 2024 at 02:11:11PM +0200, Przemek Kitszel wrote:
> On 5/7/24 16:05, Andrew Lunn wrote:
> > On Mon, May 06, 2024 at 07:52:57AM -0700, Jakub Kicinski wrote:
> > > Hi!
> > > 
> > > The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) /
> > > 5:30 pm (~EU). Last call before the merge window. No agenda
> > > items have been submitted so far.
> > > 
> > > See you at https://bbb.lwn.net/b/jak-wkr-seg-hjn
> > 
> > Maybe we can have a quick discussion and poll about:
> > 
> > https://patchwork.kernel.org/project/netdevbpf/patch/20240507090520.284821-1-wei.fang@nxp.com/
> > 
> > Do we want patches like this? What do people think about guard() vs
> > scoped_guard().
> > 
> > 	Andrew
> > 
> Was it discussed? Any conclusions?

Sorry, i should of submitted a netdev FAQ Documentation patch by now.

The summary is: scoped_guard() is O.K. for new code. guard() is too
magical, and should not be used. Neither should be used in old code,
where we perceive a danger it will actually cause more bugs when back
porting fixes.

We do acknowledge these mechanisms could be useful at avoiding bugs,
but want to wait and see how they work out in practice. It could be
the restrictions on reworking old code is lifted, and guard() allowed,
in a few years.

  Andrew

