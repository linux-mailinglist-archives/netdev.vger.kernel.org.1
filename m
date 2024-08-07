Return-Path: <netdev+bounces-116578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B64D394B080
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4E9283BBA
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 19:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1A21422AD;
	Wed,  7 Aug 2024 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2BvOXyLG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B288558203
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723059492; cv=none; b=S2i5snR0GJ3lVm1kihkRwThmxCgLUOVaPxtVa7gDmrhNhvTmNz2GRCfycX2wCJynRcwbK6q0j52//H2DrN32YwtSq0CeKmgr/uDVmnilHCQ0f11dXTYn+Yx5n3iF/waqf3CzKnEqwNOYgaOD3AHy3vJLsplcq09tyfqHTTywAMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723059492; c=relaxed/simple;
	bh=dAG4TiLnHspCcKyjLG2ixoUsYxoiDOi5surxaRYbRuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rup77yuO+p3vPI1V4U9yFdyx9ElHiPLeQpjsdfcktWvZTdIK0aQCmU6vNyC6ShtB9uCDC/4hRiP2rtXLyZlysIwE8LzTo3yL6wUwcBvxZUBK3NfWbiyDSssw6mMr7Wpsl4BeniLnv04IrCJXEljSnhPiklJ/tNZEfUiMagdr0bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2BvOXyLG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3XXP6n4udDsjEw1sVkZgke1Pyp6dpRfYKHh10OzbARM=; b=2BvOXyLGjvsaeD8BLVkdpMjuQo
	hmmwdSFvIFougLgZoIJfmm740anw+FguPAJDOEBVWJEycFgDX8KjiTS0bgxGjy+cVUAcdUnMRR98G
	3tehmcIMYGrtzOEfj3tRaapLvzyAZSV1Jy5fEWV0y9v8d9QTjVoB07MqXMFa+NL1tsV8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sbmU1-004ECh-A9; Wed, 07 Aug 2024 21:38:05 +0200
Date: Wed, 7 Aug 2024 21:38:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] net: ag71xx: use phylink_mii_ioctl
Message-ID: <64e1f8a2-ba01-402f-81e1-e51da76a5db0@lunn.ch>
References: <20240807185918.5815-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807185918.5815-1-rosenp@gmail.com>

On Wed, Aug 07, 2024 at 11:58:46AM -0700, Rosen Penev wrote:
> f1294617d2f38bd2b9f6cce516b0326858b61182 removed the custom function for
> ndo_eth_ioctl and used the standard phy_do_ioctl which calls
> phy_mii_ioctl. However since then, this driver was ported to phylink
> where it makes more sense to call phylink_mii_ioctl.
> 
> Bring back custom function that calls phylink_mii_ioctl.
> 
> Fixes: 892e09153fa3 ("net: ag71xx: port to phylink")

I don't think the fixes tag is justified. phy_do_ioctl() should work,
although i agree your change is the better way to do this. So for me,
this patch is an improvement, not a fix. Or have you seen a real
problem?

Please read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

and mark this patch for net-next, without the Fixes tag.

    Andrew

---
pw-bot: cr

