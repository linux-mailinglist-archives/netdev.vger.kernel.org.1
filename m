Return-Path: <netdev+bounces-174491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9838A5EFCA
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913CA188C00B
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE28264617;
	Thu, 13 Mar 2025 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IV/6Tanm"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872D6265605
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858895; cv=none; b=U1qYFR5af5pD46tAAOSOgISrLgI5F2TW124b1LwLicHG4TSzpd70Wuu5Swupfq3g8oqcmEexhc8aCf1LlB2kN7GKnR64EnifD+osOmZmidcWiDIebFzBCAt0vMrQl+43Ux0/gpsT5Np2gFstMW6cYZfNEkOz2QEzsxA+FWIm5rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858895; c=relaxed/simple;
	bh=Tge9KDQJ6sWkc909LZwc/aDNaWXcEMDpAR4YNP8RDGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIIlg2LdPP7VDq+ABNVAmswqb/5yqBtMSVD5UCoYhgOsZn8jOq+QgS9+P0T57/pirJ77ntEm25dH5ld2pKNOmYC/QA/NyeOny3Uj62NNemykqex3m1eebG2OeaGA59HKCM8yvPe6KORe1UV5gG1cWkDZMJhD1QGFN2FZORNBVwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IV/6Tanm; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0782243400;
	Thu, 13 Mar 2025 09:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741858891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfu4t2FsVFjXF46lMfDJwja8O/f0SZHFctlQOfPnScI=;
	b=IV/6Tanm1dWQ1eeP0Bgz4SKnfR4vprBiiDVvtEiYehRKFXml1Wj+sVekjChWDuO15sHQBp
	R1E6X3CD3MiSkqWJNa1GOsgSerhnx4c9llf0E1fwWe9Xju12aAKSm1mUsUj5Hkf8d8+iwD
	0LpCiuzgcpEn1couPLnIOTEVHWvNDJwfkISOJR2y6CiolyAEV8P7pqhufg5vJyDUbUriKx
	1CyvfxWXW4umflgFTPIxjmO/Um6b7E4IneLDvX/yeKt3So8NfSRht9M/3cCD4VL6jiSjGC
	X7J6dcl/SZHiW3sRm9DS3xZz5TGmlWoPDFy0rrQDzMrHsYORECjm8JHYWbkvQw==
Date: Thu, 13 Mar 2025 10:41:28 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v10 3/5] net: phy: micrel: Add loopback support
Message-ID: <20250313104128.3f6cb9e3@fedora-2.home>
In-Reply-To: <9b61088921bafd7da5739c786274c083@engleder-embedded.com>
References: <20250312203010.47429-1-gerhard@engleder-embedded.com>
	<20250312203010.47429-4-gerhard@engleder-embedded.com>
	<20250313095729.53a621e0@fedora-2.home>
	<9b61088921bafd7da5739c786274c083@engleder-embedded.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdejiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdqvddrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehgvghrhhgrrhgusegvnhhglhgvuggvrhdqvghmsggvugguvggurdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgri
 hhlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Thu, 13 Mar 2025 10:35:47 +0100
Gerhard Engleder <gerhard@engleder-embedded.com> wrote:

> Am 13.03.2025 09:57, schrieb Maxime Chevallier:
> > Hello Gerhard,
> > 
> > On Wed, 12 Mar 2025 21:30:08 +0100
> > Gerhard Engleder <gerhard@engleder-embedded.com> wrote:
> >   
> >> The KSZ9031 PHYs requires full duplex for loopback mode. Add PHY
> >> specific set_loopback() to ensure this.
> >> 
> >> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> >> ---
> >>  drivers/net/phy/micrel.c | 24 ++++++++++++++++++++++++
> >>  1 file changed, 24 insertions(+)
> >> 
> >> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> >> index 289e1d56aa65..24882d30f685 100644
> >> --- a/drivers/net/phy/micrel.c
> >> +++ b/drivers/net/phy/micrel.c
> >> @@ -1032,6 +1032,29 @@ static int ksz9021_config_init(struct 
> >> phy_device *phydev)
> >>  #define MII_KSZ9031RN_EDPD		0x23
> >>  #define MII_KSZ9031RN_EDPD_ENABLE	BIT(0)
> >> 
> >> +static int ksz9031_set_loopback(struct phy_device *phydev, bool 
> >> enable,
> >> +				int speed)
> >> +{
> >> +	u16 ctl = BMCR_LOOPBACK;
> >> +	int val;
> >> +
> >> +	if (!enable)
> >> +		return genphy_loopback(phydev, enable, 0);
> >> +
> >> +	if (speed == SPEED_10 || speed == SPEED_100 || speed == SPEED_1000)
> >> +		phydev->speed = speed;
> >> +	else if (speed)
> >> +		return -EINVAL;
> >> +	phydev->duplex = DUPLEX_FULL;
> >> +
> >> +	ctl |= mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
> >> +
> >> +	phy_write(phydev, MII_BMCR, ctl);
> >> +
> >> +	return phy_read_poll_timeout(phydev, MII_BMSR, val, val & 
> >> BMSR_LSTATUS,
> >> +				     5000, 500000, true);  
> > 
> > Maybe I don't fully get it, but it looks to me that you poll, waiting
> > for the link to become up. As you are in local loopback mode, how does
> > that work ? Do you need connection to an active LP for loopback to
> > work, or does the BMSR_LSTATUS bit behave differently under local
> > loopback ?  
> 
> Yes I'm polling for link to come up. This is identical to 
> genphy_loopback().
> There is no need for a link partner to get a link up in loopback mode.
> BMSR_LSTATUS reflects the loopback as link in this case.
> 
> This series allows to configure a loopback with defined speed without 
> any
> link partner. Currently for PHY loopback a link partner is needed in 
> some
> cases (starting with 1 Gbps loopback).

Ok thanks a lot for the clarification ! It looks good to me in that
case :)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

