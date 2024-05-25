Return-Path: <netdev+bounces-98069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E05CE8CF060
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 19:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B951F2155B
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 17:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B34285C65;
	Sat, 25 May 2024 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eLCgcJnB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0911D2AF1B
	for <netdev@vger.kernel.org>; Sat, 25 May 2024 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716657135; cv=none; b=jBSLTgRxM6/Y/EmxEOcoTs88O6VdKIupdtiM68laFz5BMbcm/HRudShwpQc38N7CfgCrPY53HVvHRLR2CYvvzFVRvRrpVYGOf4PMwa815UTPVB5nguExX1JGcbOM+mp4HsnhCcSsRYC9mgc0MNXr/8psJY03+ExgMf6p70PFNA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716657135; c=relaxed/simple;
	bh=vhIFB+U14L8vnFmTLKxIqVv/YXeUgl15JRABipaJGEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZXlrwWdKgd/wFeQYf1r5qqEWEkejekEsGBPMH2y7FvoIX8tevCoxGcpF5C6rEknZKidKfAzymx3AbQM4ALyd4a1EeCpXSBmnnyivwfIZ7J+mFoDw4R7VYlf+/qXImmiR5B/aVvWXeGleY+hqswYsitLvk2rkXdxSYP4pB7RGMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eLCgcJnB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=h4MWe5kG3jW3wOZpwNcVPmFi5xttqiGx7z+OFo9wpqM=; b=eL
	CgcJnBjsIxefyJYMW3nNLVy+ZNQq5ugVYFVsnUKSQHAONqo9cSvIeeuZWtrcRA7YXLTcH5vzZtDxf
	OkFavxA0D2st8JBtODNT/uKLtYt+b/bq2vRSH2WtIjvjhVWe0+OzWbF6jOla3WZQ285mZhfIk4IPO
	1+9GCoHB1jxkEB8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sAuw7-00G0O8-AY; Sat, 25 May 2024 19:12:03 +0200
Date: Sat, 25 May 2024 19:12:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?B?SG9y4Wss?= 2N <kamilh@axis.com>
Cc: netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] net: phy: bcm54811: New link mode for BroadR-Reach
Message-ID: <44c85449-1a9b-4a5e-8962-1d2c37138f97@lunn.ch>
References: <20240506144015.2409715-1-kamilh@axis.com>
 <20240506144015.2409715-2-kamilh@axis.com>
 <25798e60-d1cc-40ce-b081-80afdb182dd6@lunn.ch>
 <96a99806-624c-4fa4-aa08-0d5c306cff25@axis.com>
 <b5c6b65b-d4be-4ebc-a529-679d42e56c39@lunn.ch>
 <c39dd894-bd63-430b-a60c-402c04f5dbf7@axis.com>
 <1188b119-1191-4afa-8381-d022d447086c@lunn.ch>
 <ed59ba76-ea86-4007-9b53-ebeb02951b34@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed59ba76-ea86-4007-9b53-ebeb02951b34@axis.com>

> As far I understand it, the chip is not capable of attempting IEEE and
> BroadR-Reach modes at the same time, not even the BCM54810, which is capable
> of autoneg in BRR. One has to choose IEEE or BRR first then start the
> auto-negotiation (or attempt the link with forced master-slave/speed setting
> for BRR). There are two separate "link is up" bits, one if the IEEE
> registers, second in the BRR one. Theoretically, it should be possible to
> have kind of auto-detection of hardware - for example start with IEEE, if
> there is no link after a timeout, try BRR as well. But as for the circuitry
> necessary to do that, there would have to be something like hardware
> plug-in, as I was told by our HW team. In other words, it is not probable to
> have a device capable of both (IEEE+BRR) modes at once. Thus, having the
> driver to choose from a set containing IEEE and BRR modes makes little
> sense.

So IEEE and BRR autoneg are mutually exclusive. It would be good to
see if 802.3 actually says or implies that. Generic functions like
ksetting_set/get should be based on 802.3, so when designing the API
we should focus on that, not what the particular devices you are
interested in support.

We probably want phydev->supports listing all modes, IEEE and BRR. Is
there a bit equivalent to BMSR_ANEGCAPABLE indicating the hardware can
do BRR autoneg? If there is, we probably want to add a
ETHTOOL_LINK_MODE_Autoneg_BRR_BIT.

ksetting_set should enforce this mutual exclusion. So
phydev->advertise should never be set containing invalid combination,
ksetting_set() should return an error.

I guess we need to initialize phydev->advertise to IEEE link modes in
order to not cause regressions. However, if the PHY does not support
any IEEE modes, it can then default to BRR link modes. It would also
make sense to have a standardized DT property to indicate BRR should
be used by default.

> Our use case is fixed master/slave and fixed speed (10/100), and BRR on 1
> pair only with BCM54811.  I can imagine autoneg master/slave and 10/100 in
> the same physical media (one pair) but that would require BCM54810.
 


> Not sure about how many other drivers
> regularly used fit this scheme, it seems that vast majority prefers
> auto-negotiation... However, it could be even made so that direct linkmode
> selection would work everywhere, leaving to the phy driver the choice of
> whether start autoneg with only one option or force that option directly
> when there is no aneg at all (BCM54811 in BRR mode).

No, this is not correct. There is a difference between autoneg with a
single mode, and forced. forced does not attempt to perform autoneg,
the hardware is just configured to a particular link mode. autoneg
with a single link mode does perform autoneg, you get to see what the
link partner is advertising etc. Either you can resolve to a common
link code and autoneg is successful, or there are no common modes and
autoneg fails.

A driver does not have a choice here, it need to do what it is told to
do.

	Andrew

