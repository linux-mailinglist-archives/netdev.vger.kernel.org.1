Return-Path: <netdev+bounces-190788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B01EAB8C92
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473BD3B3F99
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D050D221289;
	Thu, 15 May 2025 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="25fbgrkk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D87262B;
	Thu, 15 May 2025 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327002; cv=none; b=GX5WKz6Z5vv1tg+d5/xrSFLKz0Wg5BCyFHvd8XE9UF1mHrK/+manUNzkArfgZhxJy4T//6/wHfX2YYfYOwPLuKT54P1SKq4CemY3di+JTymHirYUxCPPO45U81YgYkowCdU7JyzMX2WIeRINWCIcj3NMsK3SnZoOehE+b0bNLhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327002; c=relaxed/simple;
	bh=TSl3DC/pqMdn7To1Rss+BzwoZqk36FZOrAZgK7swzMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Whie9j01jsZkpk7pscTIqbEkUkNa3zUQD1rFI2nZzsTIS0fvPE01J8pUOwFTSS+mRmymZvqDsTMf12oVUdiSrRu58YYtxBJN3WI6OkbeFawY5vKcF7rIWChh9YUFvlkimzR6GgZZL9p2MgTmX+q3vxrOGlTxseRdOUcraOtEIno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=25fbgrkk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=r7pP6GUkIR+18FjFOQ8+kO1OWajTGe96v6HC9Wo/dok=; b=25fbgrkkqSauN33CVhuZVi0jOE
	GJuEUOBvKKMehW2djKHAkQ09PjdO2TLznYUrY3+1kIxM29oIL5mCgdlQIkFwWbPAg+oLc1xpuMoyL
	TcRYZIfrgBoua1LX5s6JEv5pwqFKdDRI+MSkBgvxCzZlnQI9orBuVdRcl2qAlCe51rSg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uFbZX-00CgU3-0q; Thu, 15 May 2025 18:36:39 +0200
Date: Thu, 15 May 2025 18:36:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xu Liang <lxu@maxlinear.com>
Subject: Re: [PATCH] net: phy: add driver for MaxLinear MxL86110 PHY
Message-ID: <4249b016-34c3-4afc-831a-96ba61c3ffce@lunn.ch>
References: <20250515152432.77835-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515152432.77835-1-stefano.radaelli21@gmail.com>

> +/* delay can be adjusted in steps of about 150ps */
> +#define MXL86110_EXT_RGMII_CFG1_RX_NO_DELAY				(0x0 << 10)
> +#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_2250PS				(0xF << 10)

If the steps are 150ps, what you actually want is
#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_1950PS				(13 << 10)

since this is the closest you can get to 2000ps.

> +#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_150PS				(0x1 << 10)

And there should not be any need for this. Delays are either 0ps or
2000ps for the different RGMII modes.

       Andrew

