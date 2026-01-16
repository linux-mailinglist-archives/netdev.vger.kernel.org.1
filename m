Return-Path: <netdev+bounces-250372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B36D2984F
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFC513028545
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07EC316919;
	Fri, 16 Jan 2026 01:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JUkH8GxV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A165D302CDE
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 01:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525720; cv=none; b=c/JPoclVBZOstett7oyJT+bJq8uK0R8+q6yxFD/HsRW62ey0l4Foh7lb2Q+Y0HZvyJsqNZkuskx8Eg38d4VbqSssTlUZ2CS8wKiCjXgGGvVweuKdYvNrittoJFzYKJc57XGmBSVfZTXr4zoEAj1pxBPHOGdMAUodVkHTsO/6Kvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525720; c=relaxed/simple;
	bh=PBnLKOR8WDd2cJcejUobeQj3vlJXf1e8HYY+/BpYJQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYECCdcxKi3iCyvq+wxkob5Y11UmmbAEqPhsk4NBzJw+NipNw7BLkhNrHvwJDj0/xlM4b9WBLussUQ1Oa8JHCxFRkZSZ1AXF/4zcdNFrxaywNa0KjcDlK8mrmo1up6su1g28H5k+mF0T3ham1nGhPVyofjRqKW6H1xitOMSw8Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JUkH8GxV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LGiSUz37N9ovSZPw34TwWstspblmqZbHN8iTZJ4qCGU=; b=JUkH8GxV7ehKt+YzFs1LPmF3J7
	yZJdJP7NGpfeasSHg/nkXKNVRrqOa62ZUUCz5s/di26PwMOxmtS8V5mWv6RJbYPLTrfMU3NeiTTuy
	lzQYzN4FqZrFBU1XAWDJopXBwEitl44YxBUAh0kScCYJdOm1EypPoGBEomkMYpww5xKc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vgYKB-0030eW-2r; Fri, 16 Jan 2026 02:08:27 +0100
Date: Fri, 16 Jan 2026 02:08:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Sayantan Nandy <sayantann11@gmail.com>, lorenzo@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	sayantan.nandy@airoha.com, bread.hsu@airoha.com,
	kuldeep.malik@airoha.com, aniket.negi@airoha.com,
	rajeev.kumar@airoha.com
Subject: Re: [PATCH] net: airoha_eth: increase max mtu to 9220 for DSA jumbo
 frames
Message-ID: <ce42ade7-acd9-4e6f-8e22-bf7b34261ad9@lunn.ch>
References: <20260115084837.52307-1-sayantann11@gmail.com>
 <e86cea28-1495-4b1a-83f1-3b0f1899b85f@lunn.ch>
 <c69e5d8d-5f2b-41f5-a8e9-8f34f383f60c@genexis.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c69e5d8d-5f2b-41f5-a8e9-8f34f383f60c@genexis.eu>

On Thu, Jan 15, 2026 at 08:10:20PM +0100, Benjamin Larsson wrote:
> On 15/01/2026 18:41, Andrew Lunn wrote:
> > On Thu, Jan 15, 2026 at 02:18:37PM +0530, Sayantan Nandy wrote:
> > > The Industry standard for jumbo frame MTU is 9216 bytes. When using DSA
> > > sub-system, an extra 4 byte tag is added to each frame. To allow users
> > > to set the standard 9216-byte MTU via ifconfig,increase AIROHA_MAX_MTU
> > > to 9220 bytes (9216+4).
> > What does the hardware actually support? Is 9220 the real limit? 10K?
> > 16K?
> > 
> > 	Andrew
> > 
> Hi, datasheets say 16k and I have observed packet sizes close to that on the
> previous SoC generation EN7523 on the tx path.

Can you test 16K?

Does it make any difference to the memory allocation? Some drivers
allocate receive buffers based on the MAX MTU, not the current MTU, so
can eat up a lot of memory which is unlikely to be used. We should try
to avoid that.

Thanks
	Andrew

