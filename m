Return-Path: <netdev+bounces-216330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C06B3324C
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 21:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63A217A6A6
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 19:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A3614A09C;
	Sun, 24 Aug 2025 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cj0Sdvxs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E528F40;
	Sun, 24 Aug 2025 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756062975; cv=none; b=TSgZzi/1OJa0AqAhu7KYkTSry2bOtynPb73I5s0u0DCcwGyswAGU3K60q3DJkJRBu2I0G8/jeHxzYD5iBNjz/EzjsTGhWD9UpGyTJJBTwDjuzb/BLDFITonLikXO5M1RXDccTfSGwJ7lLM/HLnLfe0xzOOpXwXi6CPLQB+TTz2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756062975; c=relaxed/simple;
	bh=st9Ds3jobSfw9+5q7AG6j86m/j5n1M7RtSK7AnqNspM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXI62CdEr1ojUW7+Kpgcjb4N+n6mWuvEC5t4N4STkFl7X64Cmd+pVDiTzi/9A5ifMlIOwveXGBC4s9sAkI/faJnn4UtNQibWOFB699t0tZdvuKdBCmf2SSRqM390CvNzTzu4ixWvKBiAXzeXGN0dew1qWc5zPPmgv3u2mWOmU14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cj0Sdvxs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TvWEitKYaMPggTFJqji09zRtVLHG02IUVMr57KfVTJI=; b=cj0SdvxsXntwrah3q4bjaCkiAo
	A/4YS/bAKX8G7fw0d2188+6+mXlcvugqKTLYRq0XEHI7b3930sUUPvJ+XSYLEmDjE2+BUu8sxxD6U
	kiKFxKEmW2WfeZN+7H/Jl9tWsHa8B++zg30i68cGKcjvtYFZA9BDD1yxWeKh5CauIjWo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqGCE-005qyt-S2; Sun, 24 Aug 2025 21:16:06 +0200
Date: Sun, 24 Aug 2025 21:16:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Yangfl <mmyangfl@gmail.com>, netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <34f10173-0f88-43cf-81e6-744c73489574@lunn.ch>
References: <20250824005116.2434998-1-mmyangfl@gmail.com>
 <20250824005116.2434998-4-mmyangfl@gmail.com>
 <ad61c240-eee3-4db4-b03e-de07f3efba12@lunn.ch>
 <CAAXyoMP-Z8aYTSZwqJpDYRVcYQ9fzEgmDuAbQd=UEGp+o5Fdjg@mail.gmail.com>
 <aKtWej0nymW-baTC@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKtWej0nymW-baTC@shell.armlinux.org.uk>

> > They are locked wrappers for their unlocked counterparts. I'd like to
> > name the unlocked versions __yt921x_smi_read just like __mdiobus_read,
> > but that was turned down in the previous version, so I have to give
> > the locked versions a stranger marker since we use unlocked versions
> > more often.
> 
> Who turned it down, and what reason did they give, given that it's an
> established pattern in the phylib, mdiobus and mdiodev APIs.

I did. In general, DSA drivers don't use __ for their own functions,
but there are exceptions.

I also think this will all go away once the current problems with
locking in this driver are solved.

	Andrew

