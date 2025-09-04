Return-Path: <netdev+bounces-219857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A56B43816
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8BA161FC3
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020872FB60F;
	Thu,  4 Sep 2025 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="XSTBQnft"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DDE2F83DC;
	Thu,  4 Sep 2025 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980654; cv=none; b=e0eqrw/ZPdXAvhPp3ewwZgVij4tHpFS/3tmv5scgeBRy/5OLwObQyAQ048XC8V/J2zBnOq+3bTjd28Wihb5yzQKrccRPIBLeusoQ04bwFI85Qb0TY3crHIkn0Pc6u8XCz75qr4uIArv4VBU6ITAH5z9c9xtnjudUJvVsoGmonAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980654; c=relaxed/simple;
	bh=q0xjFKgA1oVufeQPUoXAmkmO47WBeoCpahTTRsgkiR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6Y8Be5wBrffDTNh3xGKzplT5ivfhwkccBhV2B3ZgafXI7xx/rCgfvSoym2nd4o/rsJ6C9coWhE63gRcpS15cFoO0mPyeepvZjpN0v0amV8Mp1EIlDWIc4yjZtfk/m2eB/PWkHVfMLmkgPPGoFM+YYLMlQUof/j2aAjmL+iypsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=XSTBQnft; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id BCB6C208A0;
	Thu,  4 Sep 2025 12:10:49 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1UU3Ew3pXPsJ; Thu,  4 Sep 2025 12:10:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1756980648; bh=q0xjFKgA1oVufeQPUoXAmkmO47WBeoCpahTTRsgkiR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XSTBQnftWTw5Waqb0LaFONAC+OOADo9mLP+BlBUs/gbK6ewyZIAB9nFN+f9mpImYk
	 nL2acTDzMutg2GaKAos6V29QppDeYoVLWeeUFGYKTSA0Ebt6/F3GhbirdVTpStc6Af
	 lsVX1+ZeBnougiAbxi3Ma33WAUlqaFmZgf/oPsnPJKfTd2K5llFOzRtb8WlGyj6Tc3
	 Msa0Km1jWvsp8EWTKdyy3GCIJJnnAxe3+7iHW8RIdgBcSGwLa1EaqGk4AjzwTNUii3
	 wNG57odu38jms6/e2aIdKTZJPkI+nJjkoy5sS3YpDmCYdJ4V1U0tmcicVoxzC6+m+u
	 4Ni9uzE4n0Q4g==
Date: Thu, 4 Sep 2025 10:10:01 +0000
From: Yao Zi <ziyao@disroot.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: Ensure clk_phy doesn't
 contain invalid address
Message-ID: <aLlleb271owHNIbt@pie>
References: <20250904031222.40953-3-ziyao@disroot.org>
 <20250904095457.GE372207@horms.kernel.org>
 <20250904095657.GF372207@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904095657.GF372207@horms.kernel.org>

On Thu, Sep 04, 2025 at 10:56:57AM +0100, Simon Horman wrote:
> On Thu, Sep 04, 2025 at 10:54:57AM +0100, Simon Horman wrote:
> > On Thu, Sep 04, 2025 at 03:12:24AM +0000, Yao Zi wrote:
> > > We must set the clk_phy pointer to NULL to indicating it isn't available
> > > if the optional phy clock couldn't be obtained. Otherwise the error code
> > > returned by of_clk_get() could be wrongly taken as an address, causing
> > > invalid pointer dereference when later clk_phy is passed to
> > > clk_prepare_enable().
> > > 
> > > Fixes: da114122b831 ("net: ethernet: stmmac: dwmac-rk: Make the clk_phy could be used for external phy")
> > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > 
> > ...
> > 
> > Hi,
> > 
> > I this patch doesn't seem to match upstream code.
> > 
> > Looking over the upstream code, it seems to me that
> > going into the code in question .clk_phy should
> > be NULL, as bsp_priv it is allocated using devm_kzalloc()
> > over in rk_gmac_setup()
> > 
> > While the upstream version of the code your patch modifies
> > is as follows. And doesn't touch .clk_phy if integrated_phy is not set.
> > 
> >         if (plat->phy_node && bsp_priv->integrated_phy) {
> >                 bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
> >                 ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
> >                 if (ret)
> >                         return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
> >                 clk_set_rate(bsp_priv->clk_phy, 50000000);
> >         }
> > 
> > Am I missing something?
> 
> Oops, I missed that da114122b831 is present in net-next (but not net).
> Let me look over this a second time.

Oops, yes. Though this is a fix patch, it should target net-next instead
of net since the commit causing problems hasn't landed in net. Sorry for
the confusion.

Best regards,
Yao Zi

