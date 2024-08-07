Return-Path: <netdev+bounces-116496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353BC94A92B
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D3A281CFD
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F060200128;
	Wed,  7 Aug 2024 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yQwlyq35"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FBD77F08;
	Wed,  7 Aug 2024 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039052; cv=none; b=L5WnL1etDJzgm+4kihbptYa8dsjCX0D9TGQEYmsNDrhbs1ndD8ixIbYwHqMGXWTCeUhfBBnAC0OaZHMtQn7qSlimnNSxxMoNh2mI+1xlXPQEM8PE9WjJRPqwGtu6m91m9mBAeZmHMwKeZeTIDQoMJOWpmhcnM9TNhJCH6Z3gaMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039052; c=relaxed/simple;
	bh=4vf9UHFVD7pU/WfmlCDriW6urLsiqgHGYKl3mixRAWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxQCbzpM6JjFnf0Kaa41ohu2/QKffoI4jqWJFw8kf2wEd3NWsNFSPwQMmOwBJdA9jRk7eK44u8g49uxhr9HrwZ5xw8kPdEU1hAN/HCvSAJowDB9Rjrtlb/TlgyObDjNO32XQ2BKfyUZwPKBxxvavDr0mXSoGOFzpYxg8lRvCSrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yQwlyq35; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hVzLyxL3dr6NhOAib+Jn8ddIOC2zFbHUyyfxq+uVlXA=; b=yQwlyq35lyhMsm90NH7aeWTqge
	dn37RpeWa1nJy88HRCR/I4rOpL4Vh8Jx7WnNK32gbio+6nVDO+ogRhyBhocv9YLCgg7Dm/FbYran4
	OSmHTvpXu5bQBLSkwfPxM0xWZQLuSi3b1bV+9Gl2JxgHGFJKjOYdUAW8LL1BXDepK0cw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sbhAI-004CtV-Qe; Wed, 07 Aug 2024 15:57:22 +0200
Date: Wed, 7 Aug 2024 15:57:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: ibm/emac: Constify struct mii_phy_def
Message-ID: <02886a16-e37a-4d31-a98a-e101458ecdfd@lunn.ch>
References: <dfc7876d660d700a840e64c35de0a6519e117539.1723031352.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfc7876d660d700a840e64c35de0a6519e117539.1723031352.git.christophe.jaillet@wanadoo.fr>

On Wed, Aug 07, 2024 at 01:50:31PM +0200, Christophe JAILLET wrote:
> 'struct mii_phy_def' are not modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increase overall security.
> 
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    4901	    464	      0	   5365	   14f5	drivers/net/ethernet/ibm/emac/phy.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>    5127	    240	      0	   5367	   14f7	drivers/net/ethernet/ibm/emac/phy.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

