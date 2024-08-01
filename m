Return-Path: <netdev+bounces-114923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F265944AF6
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFECA1C21702
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B9119F487;
	Thu,  1 Aug 2024 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FZOQHXRS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AE519F467;
	Thu,  1 Aug 2024 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722514074; cv=none; b=Z6Z1/l6Q8LgRsra2+avNtgTiXy35VeV2qzhdiPiLujsfaBSvqqmDSVHcdEv+2QUlw/Y34cvqrnuvrAnz5OdmNT6EeZzcBtTz/WOhas9ORp7LmHu1vYx++PVF6XULpqXs6XmrkDpYmWNrlDoXx/TbBES6TYyKfG1vu7wHFl9PzQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722514074; c=relaxed/simple;
	bh=gy0tw4NvdfoKfvQRoKSVw6iHZihKpKijFl217piJHwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGaMJ9YQyqgGXyWKL5fEaX9BZvAq8khd0HA0zamK1T7iXL8lHjoufOzPh3cSx1/SeoZXeKAYsMIUFeD/8D8FsVo0nt1pYb0l/PBinWLM/eyOb/HKJiYtWuNgAL/fLjmUPFaa9cy6JN6uEh1mSVqI7tc+S6TNZesTsSoHTHCy5VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FZOQHXRS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ssa17zqpv+KmMGK+HJxhChAbr5hH2QaoI2AfEE2Oms4=; b=FZOQHXRS/qgQeRrgGsQsMOTySO
	PhG9ypjkgW68z6iX9Xfct1eGROCFIDLNYB9TefufznhlaEg2mnKuzWJoa5FOsEKzmma9fUV+payn4
	Aui1bGlwEIx2Ze+Da6W5h6jzKAHiOVOmg9Tsg4Hf9Uupg6QLJNw/EYpA+ltggaXHtBg4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZUal-003ltH-7V; Thu, 01 Aug 2024 14:07:35 +0200
Date: Thu, 1 Aug 2024 14:07:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 03/10] net: hibmcge: Add mdio and hardware
 configuration supported in this module
Message-ID: <db012bd7-0d97-4040-bbca-e8f8b1093aad@lunn.ch>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-4-shaojijie@huawei.com>
 <ba5b8b48-64b7-417d-a000-2e82e242c399@lunn.ch>
 <746dfc27-f880-4bbe-b9bd-c8bb82303ffe@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <746dfc27-f880-4bbe-b9bd-c8bb82303ffe@huawei.com>

> > > +/* include phy link and mac link */
> > > +u32 hbg_get_link_status(struct hbg_priv *priv)
> > > +{
> > > +	struct phy_device *phydev = priv->mac.phydev;
> > > +	int ret;
> > > +
> > > +	if (!phydev)
> > > +		return HBG_LINK_DOWN;
> > > +
> > > +	phy_read_status(phydev);
> > > +	if ((phydev->state != PHY_UP && phydev->state != PHY_RUNNING) ||
> > > +	    !phydev->link)
> > > +		return HBG_LINK_DOWN;
> > > +
> > > +	ret = hbg_hw_sgmii_autoneg(priv);
> > > +	if (ret)
> > > +		return HBG_LINK_DOWN;
> > > +
> > > +	return HBG_LINK_UP;
> > > +}
> > There should not be any need for this. So why do you have it?
> 
> I'll move this to another patch where it's more appropriate.

That does not explain why it is needed. Generally, phylib tells you if
the link is up, as part of the adjust_link callback. Why do you need
to do something which no other driver does?

	Andrew

