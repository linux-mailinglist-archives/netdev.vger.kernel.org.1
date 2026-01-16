Return-Path: <netdev+bounces-250546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB566D328A1
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47C313004604
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F9133469F;
	Fri, 16 Jan 2026 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iDkurxCP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C617933375A
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573276; cv=none; b=oF70h3k19CqhGLfavLwu/29Z8Zm9DorfDfoMTy9sX6C1MaI9zo50KvR85xOWf86wvW1ZYY+8t3hacxoENxgZ+JWQ4dJwNEsN2JSjPAVQkH+AKKx8Yz7yO4IeZLRqrmOPhg9SiWUmreU/CHafEaxz8mwxfU3gmz4Uok+1hiaaQXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573276; c=relaxed/simple;
	bh=JDt1sx/w1xLcdyw8sAsDwouUmvVlIyLn09e8EsSf3jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqDK6sItEB8mPGHSOts3y7r4TZFG3IOJEXBtXwU1J5iIw/u3174Eru/LFotAzPRtTQxSVvSLo8qt/Qy9zZups4RBeCSuR2KInvjfQmiAV/LEcaqezmZwpryubYXqzVYifOGbRDapM5/EnKa06QZHtqqA6e9z36gLZrrZdS6pLFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iDkurxCP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mBPzmlCg+pA1yBRm8LZsOW5MfSNjVeQLA5Whqc6P6wM=; b=iDkurxCPyzhBsZsmRZU8E6OPGm
	/GRhjBxf63ELXOLdG09Kd2N3VvDk1xqq38gwGuNRGX0O5IXMUCPA3TivAJAAJCVLjvo863aUmCgGt
	55IahhnhJdM9vo+A8Zc4aj1b3xvXPbHwCJCob11sXv35xdeZMH6Jv6UJRQkAp+/Y+WIk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vgkhE-00359Y-5p; Fri, 16 Jan 2026 15:21:04 +0100
Date: Fri, 16 Jan 2026 15:21:04 +0100
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
Message-ID: <f0683837-73cd-4478-9f00-044875a0da75@lunn.ch>
References: <20260115084837.52307-1-sayantann11@gmail.com>
 <e86cea28-1495-4b1a-83f1-3b0f1899b85f@lunn.ch>
 <c69e5d8d-5f2b-41f5-a8e9-8f34f383f60c@genexis.eu>
 <ce42ade7-acd9-4e6f-8e22-bf7b34261ad9@lunn.ch>
 <aded81ea-2fca-4e5b-a3a1-011ec036b26b@genexis.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aded81ea-2fca-4e5b-a3a1-011ec036b26b@genexis.eu>

On Fri, Jan 16, 2026 at 11:48:30AM +0100, Benjamin Larsson wrote:
> Hi.
> 
> On 16/01/2026 02:08, Andrew Lunn wrote:
> > On Thu, Jan 15, 2026 at 08:10:20PM +0100, Benjamin Larsson wrote:
> > > On 15/01/2026 18:41, Andrew Lunn wrote:
> > > > On Thu, Jan 15, 2026 at 02:18:37PM +0530, Sayantan Nandy wrote:
> > > > > The Industry standard for jumbo frame MTU is 9216 bytes. When using DSA
> > > > > sub-system, an extra 4 byte tag is added to each frame. To allow users
> > > > > to set the standard 9216-byte MTU via ifconfig,increase AIROHA_MAX_MTU
> > > > > to 9220 bytes (9216+4).
> > > > What does the hardware actually support? Is 9220 the real limit? 10K?
> > > > 16K?
> > > > 
> > > > 	Andrew
> > > > 
> > > Hi, datasheets say 16k and I have observed packet sizes close to that on the
> > > previous SoC generation EN7523 on the tx path.
> > Can you test 16K?
> 
> I probably can but it would take some time (weeks) as I dont have any
> current setup with AN7581.
> 
> > 
> > Does it make any difference to the memory allocation? Some drivers
> > allocate receive buffers based on the MAX MTU, not the current MTU, so
> > can eat up a lot of memory which is unlikely to be used. We should try
> > to avoid that.
> > 
> > Thanks
> > 	Andrew
> 
> Larger packets will consume more dma descriptors (a larger packet will be
> split into several dma descriptors). So you dont allocate more memory to be
> able to send jumbo frames.

So it 'costs' nothing to declare the actual maximum.

For the moment, 9220 seems acceptable, but please include in the
commit message that the real maximum is higher, probably somewhere
around 16K.

	Andrew

