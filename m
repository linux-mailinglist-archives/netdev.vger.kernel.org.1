Return-Path: <netdev+bounces-222717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838F4B55792
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330065C0B03
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA85F2C235A;
	Fri, 12 Sep 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3n0n82Af"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05854758;
	Fri, 12 Sep 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708727; cv=none; b=Fqr92VOVp8QaNjiG3RcsYohAaTsoh6Ohxgj+TavqNQgr7+nL4CeGkMGSZv9VKB3MA2f/9nMKurQZyrNX4HMebMXP1b2NGGy2Tcc6tN3Mxy/3tAcLrKthJNt575HuymH2ZZPjQsJhAjLaWHV36bt7ICjiMPge+PsJ39lIac5R0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708727; c=relaxed/simple;
	bh=g8WNYH9RqPXur9BjUQmdxzi2NjxDHFqudF13MOYfUio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PArZLgn54c3hZQ1oXxa7NlPGhAdjudgWMu8l0D/1w+UkDIcTt538KD6kAokmexszUVUz3mQLaWmr3wiX+arns6pd+1fEymjnjElxEjyVkkw0VI2wBymSQJOWtdEsRZagZBxKDOmp3O/UioI9HInAddsdR2U5keNeGaMKQkLC0wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3n0n82Af; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Dx+/46BV1vrN+YR+wu1GIFwb+V4rD3RumjoIebB3vvQ=; b=3n0n82AfAe6lVf6UmJtgXutFkA
	25LIiIzIVULMGWTLAYRtKVpZNV337xXxEon3q3COcP/xKAEQYaGgDS2Ga3ZgBhItYE+49MhBgUQiz
	a0lvOhUxkXbigj+Mw4AiIxo6K0+VTX8d7Zqpozz6X390np8OySf49RC/HYoJbuZPat74=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxAKI-008Fk6-O5; Fri, 12 Sep 2025 22:24:58 +0200
Date: Fri, 12 Sep 2025 22:24:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jian Zhang <zhangjian.3032@bytedance.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
	guoheyi@linux.alibaba.com, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacky Chou <jacky_chou@aspeedtech.com>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Revert "drivers/net/ftgmac100: fix DHCP potential
 failure with systemd"
Message-ID: <4a639a86-37e2-4b3d-b870-f85f2c86cb81@lunn.ch>
References: <20250912034538.1406132-1-zhangjian.3032@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912034538.1406132-1-zhangjian.3032@bytedance.com>

On Fri, Sep 12, 2025 at 11:45:38AM +0800, Jian Zhang wrote:
> This reverts commit 1baf2e50e48f10f0ea07d53e13381fd0da1546d2.

> * rtnetlink is setting the link down
> * the PHY state_queue is triggered and calls ftgmac100_adjust_link
> -	/* Release phy lock to allow ftgmac100_reset to acquire it, keeping lock
> -	 * order consistent to prevent dead lock.
> -	 */
> -	if (netdev->phydev)
> -		mutex_unlock(&netdev->phydev->lock);
> -
> -	ftgmac100_reset(priv);
> -
> -	if (netdev->phydev)
> -		mutex_lock(&netdev->phydev->lock);
> -
> +	/* Reset the adapter asynchronously */
> +	schedule_work(&priv->reset_task);
>  }

So we are swapping one set of bugs for another set of bugs.

No other adjust_link callback messes with locks like this.  Have you
investigated what actually needs to be done by adjust_link?

Determining maccr in ftgmac100_reset_and_config_mac() look relevant.
Does it actually need a reset, or is it sufficient to just set the
bits in FTGMAC100_OFFSET_MACCR?

ftgmac100_config_pause() is called from ftgmac100_set_pauseparam()
suggesting it can be called at any time.

So i think the crux of the problem is what needs to happen to set bits
in MACCR.

	Andrew

