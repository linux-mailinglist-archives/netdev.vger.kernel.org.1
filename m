Return-Path: <netdev+bounces-97818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945518CD5B8
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 114ACB20C08
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EC214BF91;
	Thu, 23 May 2024 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cXJtThFA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FA913DBA0
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474468; cv=none; b=uF9wv/O7hXql5yPzCciM/wpU2bVgA9t6bi+K5Gf344ovw/zRSIjIi4F95Wq+Ul2qZZvFO2et9wQa5qqv5yf/kXtITWAJb+oEnH3N05/b8T2MkVurIAymEkBL4u3uVrK2TweqEhVg9+cgt0o4Okvhe6GaG/RP0tmfnMx6qOHdFxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474468; c=relaxed/simple;
	bh=1UaA+79OZl6slUAnMMkcGFQkPb6eA9brORisF7b2uLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIpXqhahI9JV6KKeji6Y7v6h0sxLTUG9NRtvI2+5ufyfNfQ6zE3Hl5OMVzc4zx9UhuRfo8q1Wk/RMisrAB7puG0obOivQTq5qfICSE4+vjTHMJ1WC9N0yrLSsbCAQf15YdbYdPJG8HBVfT8pehiAn2ImJqYsSgvVtLWn5Lict/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cXJtThFA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=9pHVZV3h7qNjpvm+fZfv7cWHmrzSwhz3wlkr4i754lY=; b=cX
	JtThFAUuvrvHPVe8bif9LDXYfZjy5S18jc31KeRTGQ3wlGs5HLvIh4FuLBb9Oa2hy6osTllYby1cw
	TvC7VSu2q4Txz773JG9lK18+PLDesNLh8ORnKoCu9OmDkOq1lf36wAlXeZ0O+dZgCHP06OtBjIWab
	29kLUkFtwrfoWks=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sA9Py-00FtmW-Ou; Thu, 23 May 2024 16:27:42 +0200
Date: Thu, 23 May 2024 16:27:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?B?SG9y4Wss?= 2N <kamilh@axis.com>
Cc: netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] net: phy: bcm54811: New link mode for BroadR-Reach
Message-ID: <1188b119-1191-4afa-8381-d022d447086c@lunn.ch>
References: <20240506144015.2409715-1-kamilh@axis.com>
 <20240506144015.2409715-2-kamilh@axis.com>
 <25798e60-d1cc-40ce-b081-80afdb182dd6@lunn.ch>
 <96a99806-624c-4fa4-aa08-0d5c306cff25@axis.com>
 <b5c6b65b-d4be-4ebc-a529-679d42e56c39@lunn.ch>
 <c39dd894-bd63-430b-a60c-402c04f5dbf7@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c39dd894-bd63-430b-a60c-402c04f5dbf7@axis.com>

> > ethtool -s eth42 autoneg off linkmode 1BR10
> 
> This sounds perfect to me. The second (shorter) way is better because, at
> least with BCM54811, given the link mode, the duplex and speed are also
> determined. All BroadR-Reach link modes are full duplex, anyway.

Great.

> > You can probably add a new member to ethtool_link_ksettings to pass it
> > to phylib. From there, it probably needs putting into a phy_device
> > member, next to speed and duplex. The PHY driver can then use it to
> > configure the hardware.
> I did not dare to cut this deep so far, but as I see there is a demand,
> let's go for it!

It also seems quite a generic feature. e.g. to select between
1000BaseT_FULL and 1000BaseT1_FULL. So it should get reused for other
use cases.

> > 
> > 2) Invalid combinations of link modes when auto-neg is
> > enabled. Probably the first question to answer is, is this specific to
> > this PHY, or generic across all PHYs which support BR and IEEE
> > modes. If it is generic, we can add tests in
> > phy_ethtool_ksettings_set() to return EINVAL. If this is specific to
> > this PHY, it gets messy. When phylib call phy_start_aneg() to
> > configure the hardware, it does not expect it to return an error. We
> > might need to add an additional op to phy_driver to allow the PHY
> > driver to validate settings when phy_ethtool_ksettings_set() is
> > called. This would help solve a similar problem with a new mediatek
> > PHY which is broken with forced modes.
> Regarding the specificity, it definitely touches the BCM54811 and even more
> BCM54810, because the ...810 supports autoneg  in BroadR-Reach mode too.

That was what i did not know. Does 802.3 allow auto-neg for these
BroadR-Reach modes at the same time as 'normal' modes. And it seems
like the ..810 supports is, and i assume it conforms to 802.3? So we
cannot globally return an error in ethtool_ksetting_set() with a mix
or modes, it needs to be the driver which decides.

   Andrew

