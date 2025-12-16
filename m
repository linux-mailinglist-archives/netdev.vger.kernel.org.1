Return-Path: <netdev+bounces-244902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C40FECC1484
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 08:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C17130285EE
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 07:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92958340286;
	Tue, 16 Dec 2025 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CycSzaRG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B874233FE01;
	Tue, 16 Dec 2025 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765869561; cv=none; b=LdFl5DYOnzESOPlzDsfnk+dFh0awS1jTxHxJwt63AZjOUbSaFEoqtTS2mCPuL1OXP83xJeblzegCEFFvRwCCOjTXUiD4cNd5DyHURJ2Il1ZRu18/84HJtf7G5CgcUaPDKenYGHATTBAOZ3jnsxI57H6rjRG0+8zinvo9oesAV3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765869561; c=relaxed/simple;
	bh=enGx+spkjw9ZLMOksCgrMtnhYpdWoNomFSpvU8FBTDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+OBWJ0MbHkpMxAlrP6L0RiMRUd3OiA004rrQfkuBgfegQvWRVBy0JnFqGyiffY2VESpZM5aG7ZFBRZX1KSCE6tIvhOPRQLsBjW8on62Tv3XK3c4OipH9emBcaAK8i742EVh2gYqQkEkE4XbFq9spIGrkrIl/SyBKIwicrDMNjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CycSzaRG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J6Ex6usF9sDIO0sFHxcJB61q9IPzuxfpeM970YgFvAo=; b=CycSzaRGBH0dYAhneUT/gYBByS
	KLuXDxNY0IAJoPqC8t6KKYQxTUcuVy4nrlejlwtyx9hrXKBIFb7K483SCuu+vSDM1dS7EkeOQ3hMH
	c2i9cAXJKR2M9A6Ciqf1Dh6UAIYe4Wg6XeCxWidPd/ULVscfXsWsBIVXlJWtumQTT3Pw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vVPKs-00H5Qr-Qx; Tue, 16 Dec 2025 08:19:06 +0100
Date: Tue, 16 Dec 2025 08:19:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	Frank.Sae@motor-comm.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, salil.mehta@huawei.com,
	shiyongbang@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 4/6] net: hibmcge: support get phy_leds_reg
 from spec register
Message-ID: <38e441ce-b67f-4ddb-940b-1e737a45225c@lunn.ch>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215125705.1567527-5-shaojijie@huawei.com>

On Mon, Dec 15, 2025 at 08:57:03PM +0800, Jijie Shao wrote:
> support get phy_leds_reg from spec register,

What is the spec register?

	Andrew

