Return-Path: <netdev+bounces-166463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4D0A360F1
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C2A189500B
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4BE2641FA;
	Fri, 14 Feb 2025 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o8ZCLj+O"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ABC1862A;
	Fri, 14 Feb 2025 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739545344; cv=none; b=ILgcsxFWijL6ORgs9Y/hiFo2s8qOGMvooemqRHaZAM+oJY9Bcpk1fTXrR7kY1RhigSK7VEB+ALHQExvC8Kr9LxOoY/SJCMo2Gy7ZE4E5C5f1N+dLGzOY2TYgi9pIFcawbdurhxZaNNTg+4xy5sw9925MmG3mJNXvOyINfprPNkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739545344; c=relaxed/simple;
	bh=c+hKjlXUh3vmeoBXIH+WnhBb2eaR+k7dUrLHl5n3JdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxDADtzjx1cr434uc8US51fTh0XRMyS+LU99wr9H5Vud0HfR3UhxfKO9DRSgeO7jXjdfnCw9zdVR6TkhRF7j1SqpbruDkbe+J718U08TbEi5lt9Cp3vg/2GggWrGcSDdCa6q0OMcB4Ntsa5wZq/XP9bn3PK8k91wASwT3F3Wrww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o8ZCLj+O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=toTGovKSUsy54iHA+P8q9j1fvWiVfvEo6sn+LhC8T38=; b=o8ZCLj+OzfRXjX90B2XHWoFtuf
	hbb75XpLtIelDiGN/4aerCSC9gmU16Qg1DglvOp+DBgoUYEenVeZfu0mrk3qXFcmxLmRpll0K70gC
	/enhxbhKvRi7e0vkwfxfiaxbkkdCmGAzjW2E6zxQaVDNwV/IV3C1DW+v8YYD1qiLfVVo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tixCk-00E6JC-RS; Fri, 14 Feb 2025 16:02:10 +0100
Date: Fri, 14 Feb 2025 16:02:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: Remove redundant variable declaration in
 __dev_change_flags()
Message-ID: <943abc29-d5af-4064-8853-5f3c365bf6d6@lunn.ch>
References: <20250214-old_flags-v1-1-29096b9399a9@debian.org>
 <1d7e3018-9c82-4a00-8e10-3451b4a19a0d@lunn.ch>
 <20250214-civet-of-regular-refinement-23b247@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-civet-of-regular-refinement-23b247@leitao>

> But I agree with you, if you needed to look at it, it means the message
> is NOT good enough. I will update it.

Thanks.

> 
> > > Fixes: 991fb3f74c142e ("dev: always advertise rx_flags changes via netlink")
> > 
> > I suppose there is also a danger here this code has at some point in
> > the past has been refactored, such that the outer old_flags was used
> > at some point? Backporting this patch could then break something?  Did
> > you check for this? Again, a comment in the commit message that you
> > have checked this is safe to backport would be nice.
> 
> I haven't look at this, and I don't think this should be backported,
> thus, that is why I sent to net-next and didn't cc: stable.
> 
> That said, I don't think this should be backported, since it is not
> a big deal. Shouldn't I add the Fixes: in such case?

The danger of adding a Fixes: is that the ML bot will see the Fixes:
tag and might select it for backporting, even if we did not explicitly
queue it up for back porting. So i suggest dropping the tag.

    Andrew

