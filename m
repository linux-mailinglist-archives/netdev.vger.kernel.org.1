Return-Path: <netdev+bounces-108368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F60923915
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E88DB24C12
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03DC1514DA;
	Tue,  2 Jul 2024 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SvYnMbo3"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC27150991;
	Tue,  2 Jul 2024 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719911035; cv=none; b=m15dP0zAY762Iq2BMLy2LPBYG/tTDJbfJrLmzkPAQIfTBxZJtwSVUBs+2/JbGLX8qmVRB4+qMW8HKUrRz6XzangaS5eE7fJcOVTNCfjszVAGEWHESluSX3BEDAa9qL2dcnjTrKhCtJYsowJ+bRgGHHE6FTKKfQ1mqAEG9IXlY+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719911035; c=relaxed/simple;
	bh=YEXOMHw/lotc3rT5a8xlE7JlHDosPHJ8mSGnl9JHG8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8UIBgZ8Nzp8Xgk3PeAn4EDdnHc+ccOP+mVHBjQKC77Sr38WJ0b+Z29eHtpD0wAPgYCRnvmrIcVr6ndxqHrVFpjXQw4GSPxq2L2sY3LfzF6qNqFn4uSgTf0QPPVvF9QVT5fFrPx5vE3g6Iv6/JNyQJPcX+WicBskM81YoomKJ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SvYnMbo3; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39D3A240004;
	Tue,  2 Jul 2024 09:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719911032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSdrsQgymj8BJO7hni97fua9Gnf8/hUWnIpei5HqtXs=;
	b=SvYnMbo354C9fH9oRETvgoj0YxWPei9t+r6uBmv/3/mvfagU8+10tBCx1IoGWWjWlxkSpQ
	vZUBg/YHlQ/gOqf6XGqR0js0n6uJlJQNgHFvEaI3Zj11d70x4JJa1P8sAIsmlDmGPwV58r
	lMswKs5fxy58/NnM2mKdGe+WphPHm17B6DWWkvBDa+WoYrTl6VXVaGiIeDMmJttKo8pKah
	q/6X962qNR9XrxvtUdEqjMmvwtn3vohqyvTPXo8CYmtsUySrRTkj21IdTqSBEgxdTp5vr2
	rvKZL4yGhaB02dFJ0keRBC2wF4Jrqf/FLia34jdbYTZNdQcY1H1DuToBrgCQoA==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net-next 6/6] net: phy: dp83869: Fix link up reporting in SGMII
 bridge mode
Date: Tue, 02 Jul 2024 11:04:37 +0200
Message-ID: <8435724.NyiUUSuA9g@fw-rgant>
In-Reply-To: <289c5122-759f-408a-a48a-a3719f0331f9@lunn.ch>
References:
 <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
 <20240701-b4-dp83869-sfp-v1-6-a71d6d0ad5f8@bootlin.com>
 <289c5122-759f-408a-a48a-a3719f0331f9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-GND-Sasl: romain.gantois@bootlin.com

On lundi 1 juillet 2024 19:09:40 UTC+2 Andrew Lunn wrote:
> > +			if (dp83869->mod_phy) {
> > +				ret = phy_read_status(dp83869->mod_phy);
> > +				if (ret)
> > +					return ret;
> 
> Locking? When phylib does this in phy_check_link_status(), we have:
> 
> 	lockdep_assert_held(&phydev->lock);
> 
> I don't see anything which takes the downstreams PHY lock.
> 
> Is this also introducing race conditions? What happens if the link
> just went down? phy_check_link_status() takes actions. Will they still
> happen when phylib next talks to the downstream PHY? It is probably
> safer to call phy_check_link_status() than phy_read_status().

Given that the phylib state machine will call phy_check_link_status() itself,
I think that this call to phy_read_status() could be dropped entirely and that
dp83869_read_status() could just directly read mod_phy->{link,speed,duplex}.

This raises the question of a potential race condition when reading
mod_phy->{link, speed, duplex}. I haven't seen any kind of locking used in
other parts of the net subsystem when reading these parameters.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




