Return-Path: <netdev+bounces-145493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0D59CFA83
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D6D1F21837
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 22:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1622D1917D6;
	Fri, 15 Nov 2024 22:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eu4cs5Wf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEAB1DA23;
	Fri, 15 Nov 2024 22:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731711561; cv=none; b=jECfpJolNfN8ei6aX2/mq1Zj9D/kRYWF6lmYkrl9t58r80Q9jbPQda+oK0rBiwYaVNbVVhzBebRa5ZBbIg/qiFDT0Xg9SBnDUA5L+A4Wz5pxipnhcdwztyERVsHamM/LMPuD+GsiA7dO+R21H9EjqmJcvHqEUu8q40pGkNkVUxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731711561; c=relaxed/simple;
	bh=fUh5s7BsCwoaZmYFGIY2veyC4azYYi1dCvhz9yokXG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fel/4/kiVni3OXL4k+OOZ8Qh+glEQC4CUEAn90ZYTDtfDqPoYEsLhifQaOikbqNfY5SfdmSJkPsREzreMz/XzwoWZEq2Svvj+rOyqsYpYJgGWm/MkCw0HVxGMsudUd6hGvk8FAIsYiMZUG9t+soyAC0xouXudCymEXbW68vkU8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eu4cs5Wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B642EC4CECF;
	Fri, 15 Nov 2024 22:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731711560;
	bh=fUh5s7BsCwoaZmYFGIY2veyC4azYYi1dCvhz9yokXG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eu4cs5Wf05VYisSHEwhIeVyub9YTwSD6bDuvbIuAC+BhUmUpPzMeybF4t20rSew0k
	 eAp+tOXT1vRizIbTAeM5kZ9qJ8pWIWwTbyAAnzbAA5cs/aQnaOCkLNdBS4dR+S/eG5
	 pYxHNlclxuoUjkpHSdGDi6RBZ+do8EovBK2pooEO3b/cznfsvGh+X7XVy3KYwx3qx3
	 yUQdEHosRJ0W1x13K+leNe8DHoVIZ7NxeVUDhuHx+yb/qMK+Mx+plzTiuLRjGn915E
	 7n2jtcBIyVSXjC/1b1IpdU7wWRTNvo7A9TdZcs2mWtZVIcYVo30HAsyt2H2OoqUVyB
	 MVmD+rElBmTdg==
Date: Fri, 15 Nov 2024 14:59:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@airoha.com
Subject: Re: [net-next PATCH v5 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <20241115145918.5ed4d5ec@kernel.org>
In-Reply-To: <6737c439.5d0a0220.d7fe0.2221@mx.google.com>
References: <20241112204743.6710-1-ansuelsmth@gmail.com>
	<20241112204743.6710-4-ansuelsmth@gmail.com>
	<20241114192202.215869ed@kernel.org>
	<6737c439.5d0a0220.d7fe0.2221@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 22:59:18 +0100 Christian Marangi wrote:
> On Thu, Nov 14, 2024 at 07:22:02PM -0800, Jakub Kicinski wrote:
> > On Tue, 12 Nov 2024 21:47:26 +0100 Christian Marangi wrote:  
> > > +	MIB_DESC(1, 0x00, "TxDrop"),
> > > +	MIB_DESC(1, 0x04, "TxCrcErr"),  
> > 
> > What is a CRC Tx error :o 
> > Just out of curiosity, not saying its worng.
> >  
> 
> From Documentation, FCS error frame due to TX FIFO underrun.

Interesting

> > > +	MIB_DESC(1, 0x08, "TxUnicast"),
> > > +	MIB_DESC(1, 0x0c, "TxMulticast"),
> > > +	MIB_DESC(1, 0x10, "TxBroadcast"),
> > > +	MIB_DESC(1, 0x14, "TxCollision"),  
> > 
> > Why can't these be rtnl stats, please keep in mind that we ask that
> > people don't duplicate in ethtool -S what can be exposed via standard
> > stats
> >   
> 
> Ok I will search for this but it does sounds like something new and not
> used by other DSA driver, any hint on where to look for examples?

It's relatively recent but I think the ops are plumbed thru to DSA.
Take a look at all the *_stats members of struct dsa_switch_ops, most
of them take a fixed format struct to fill in and the struct has some
extra kdoc on which field is what.

