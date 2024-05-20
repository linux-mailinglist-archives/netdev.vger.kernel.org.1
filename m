Return-Path: <netdev+bounces-97194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618818C9DC6
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 15:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890211C20BEA
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A35135A58;
	Mon, 20 May 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UN2Dj719"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765DF13440A;
	Mon, 20 May 2024 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716210165; cv=none; b=lrFdFvGFciXbGt/6A2ZrNI7AYy8rdIVGOOnMYBUASGCm5+2YhZhO4bFW5rHwYcoIkotKDxtsgWAGrFFqMeiljupFA+64s81vmGWKDzx9RQ8KK4dJyqib/QB4+NPXR9pGoAmjSN9VBO4JeZ0HZx4eY8XSJCA4Ei6U6/RlJOtZH9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716210165; c=relaxed/simple;
	bh=NqFfNspuNN/u5d6QKlAxvgR1hDJF0mvILHw8f7JFhmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0QK/e2x9Kjn+8NzcRnNbZ0vokRMAfxNxPFixAz5QMAR+JuzIeLNYWwCGfWl75+Or+O9qvjx2AGp2aNnPybb5OAqI1/e6X1NKybM7cdJONNEoKBURCjCVdcP3MZ/W93kPpOLsEcbAhJzlon6pMljIec+51uyYf7ssfVbTQ/ah6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UN2Dj719; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j0jIAAuXSP3n0MB/pRJJ3f6EEsygUxZ+BPC7VxBGXp8=; b=UN2Dj7198lyU3K4EVT86LEI9IQ
	cdtpjZUJU1lns6OAl9EJhTDzjCIZ6Amc/gU+q4KDrYk/EKjrZ5/cOduBfsuv5zno3WL2ocpqj6mjH
	c7IU4uWoyZtQm4NTJxf5g4ntGMbjOrfxZ6ix/ZG8fj1o2PGdp4DGWTOG0LN5/REsWfl8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s92ej-00FhFN-La; Mon, 20 May 2024 15:02:21 +0200
Date: Mon, 20 May 2024 15:02:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v2 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <8a5f14f4-4cd9-48b5-a62c-711800cee942@lunn.ch>
References: <20240517102908.12079-1-SkyLake.Huang@mediatek.com>
 <20240517102908.12079-6-SkyLake.Huang@mediatek.com>
 <cc0f67de-171e-45e1-90d9-b6b40ec71827@lunn.ch>
 <283c893aa17837e7189a852af4f88662cda5536f.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <283c893aa17837e7189a852af4f88662cda5536f.camel@mediatek.com>

> > Is there a version available anywhere for the firmware?
> > 
> Currently, I use "$md5sum /lib/firmware/mediatek/mt7988/i2p5ge-phy-
> pmb.bin" command to check version.

An md5sum is not really a version. How do you tell if one md5sum is
newer or older than another?

Is there is an MDIO register you can read to get the version? Or a
version in a header in the firmware file?

> > > +static int mt798x_2p5ge_phy_get_features(struct phy_device
> > *phydev)
> > > +{
> > > +int ret;
> > > +
> > > +ret = genphy_c45_pma_read_abilities(phydev);
> > > +if (ret)
> > > +return ret;
> > > +
> > > +/* We don't support HDX at MAC layer on mt7988.
> > 
> > That is a MAC limitation, so it should be the MAC which disables
> > this,
> > not the Phy.
> > 
> Actually this phy is strictly binded to (XFI)MAC on this platform.
> So I directly disable HDX feature of PHY.

Sorry, i don't follow your answer:

Can the PHY do half duplex?
Can the MAC do half duplex?

The part which cannot do half-duplex should be the part which disables
half-duplex.

You should be able to take any vendors MAC and any vendors PHY and put
them together, if they have the same MII interface. Say this PHY does
support half duplex. And some other vendors MAC supports half
duplex. We want it to work.

	Andrew

