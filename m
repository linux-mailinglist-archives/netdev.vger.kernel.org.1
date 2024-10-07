Return-Path: <netdev+bounces-132810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9951599343A
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6861C23380
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4455B1DC067;
	Mon,  7 Oct 2024 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kS7fqN6s"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B31DBB20;
	Mon,  7 Oct 2024 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320260; cv=none; b=E1ikmxO2fubrzUt4SB4vDLGqvloW9vpy+Iw0saDoskWjelQ4xjMPh1l1RuJH6+3UQsn9VMh39gzGSoIodHRjZsnrVQtXIkBcPSjm8hiJlDJawBUf0QZCocUbpBauyWLR5zayLJ9OByV9tzB3cqWG3BLppvDX0jNFsFALQEPYZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320260; c=relaxed/simple;
	bh=yfRyAB3xOijwlnoxe03nZjku5m28Im9Zs4j9KZ2Qrlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4hluBCPmE2yG4sNjr5PCX8PpoDUW4qf8q2idRjxcvWGLtajlMgLbPdM3NmBmO6exBu55RYtEtMW671K2cOmf1UinI3B7bGaV3Yq/iUqC2xBC+WYcEuDP24EC8Cpyn1vOS6n0iDmN3CHLrefmTQhwjna7ltHONdZEKCl7wvO/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kS7fqN6s; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=/4zb+CNZ65QQblVRwLbBOPKFpFZ76Z32xRQ86mlA65E=; b=kS
	7fqN6sXpvUD+U/5isc3RbmM6m4z+3wojtCKq6xcyBVUS8REsHl3SP5ohIZl0qsVQWuvVDpm1Otr9H
	KJGG9ivz05dcvTEf4C1oTvaQQthi15BW7E3cqi7UZjgUCrLFOOj0w9dwTBsYCTjfHnsYinb0mHBXw
	2w1aRVV4r9DFb3U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxr33-009I0o-Sx; Mon, 07 Oct 2024 18:57:29 +0200
Date: Mon, 7 Oct 2024 18:57:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Robert Hancock <robert.hancock@calian.com>,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>,
	Tristram Ha <tristram.ha@microchip.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH] net: phy: disable eee due to errata on various KSZ
 switches
Message-ID: <ad44d06a-4d30-4696-bace-1a78a8bcfca6@lunn.ch>
References: <20241004213235.3353398-1-tharvey@gateworks.com>
 <a9467e93-3b35-4136-a756-2c0de2550500@lunn.ch>
 <CAJ+vNU2Hdo-J8HxVXG63AEauBXUdnuRViwmMmE1mNj30NcyF8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+vNU2Hdo-J8HxVXG63AEauBXUdnuRViwmMmE1mNj30NcyF8A@mail.gmail.com>

On Mon, Oct 07, 2024 at 09:38:59AM -0700, Tim Harvey wrote:
> On Sat, Oct 5, 2024 at 9:46 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Fri, Oct 04, 2024 at 02:32:35PM -0700, Tim Harvey wrote:
> > > The well-known errata regarding EEE not being functional on various KSZ
> > > switches has been refactored a few times. Recently the refactoring has
> > > excluded several switches that the errata should also apply to.
> >
> > Does the commit message say why?
> >
> > Does this need a Fixes: tag?
> >
> 
> Hi Andrew,
> 
> Good question. I couldn't really figure out what fixes tag would be
> appropriate as this code has changed a few times and broken in strange
> ways. Here's a history as best I can tell:
> 
> The original workaround for the errata was applied with a register
> write to manually disable the EEE feature in MMD 7:60 which was being
> applied for KSZ9477/KSZ9897/KSZ9567 switch ID's.
> 
> Then came commit ("26dd2974c5b5 net: phy: micrel: Move KSZ9477 errata
> fixes to PHY driver") and commit ("6068e6d7ba50 net: dsa: microchip:
> remove KSZ9477 PHY errata handling") which moved the errata from the
> switch driver to the PHY driver but only for PHY_ID_KSZ9477 (PHY ID)
> however that PHY code was dead code because an entry was never added
> for PHY_ID_KSZ9477 via MODULE_DEVICE_TABLE. So even if we add a
> 'Fixes: 6068e6d7ba50' it would not be fixed.
> 
> This was apparently realized much later and commit ("54a4e5c16382 net:
> phy: micrel: add Microchip KSZ 9477 to the device table") added the
> PHY_ID_KSZ9477 to the PHY driver. I believe the code was proper at
> this point.
> 
> Later commit ("6149db4997f5 net: phy: micrel: fix KSZ9477 PHY issues
> after suspend/resume") breaks this again for all but KSZ9897 by only
> applying the errata for that PHY ID.
> 
> The most recent time this was affected was with commit ("08c6d8bae48c
> net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)") which
> removes the blatant register write to MMD 7:60 and replaces it by
> setting phydev->eee_broken_modes = -1 so that the generic phy-c45 code
> disables EEE but this is only done for the KSZ9477_CHIP_ID (Switch ID)
> so its still broken at this point for the other switches that have
> this errata.
> 
> So at this point, the only commit that my patch would apply over is
> the most recent 08c6d8bae48c but that wouldn't fix any of the previous
> issues and it would be unclear what switch was broken at what point in
> time.

O.K, so its a mess :-(

Lets look at this from a different direction. Which stable kernels do
you actually care about? Is 6.6 enough for you? Do you need 6.1? 4.19?

You should use a Fixed tag which goes back far enough for you. The
patch itself might not apply that far back, but once you get it merged
and backported as far as it does go, you can submit ported versions
for older kernel, referencing the original fix commit hash number.

	Andrew



