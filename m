Return-Path: <netdev+bounces-166035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B13A34062
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D47188C8D5
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7532F227EAA;
	Thu, 13 Feb 2025 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ODzZaBT/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26A223F405;
	Thu, 13 Feb 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453397; cv=none; b=KKFk7XlBUtmk85QNN7sh61o6gZpYEsjRs2D9JHV08lxG5pnJ1esh4yp0qCuboT7UJJvBP9sdNV1mM+z0Xit9om2mTYy02YrXYrOkgQafbHeimsTVE/d+4V8nRropG+/PyZWQG2o/osiMS8oDfkA73foFDvJWt2FdQubq8wejzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453397; c=relaxed/simple;
	bh=u+0TFlvAcTgqS+Pq+6Q91tIBM3Sa6hihqUkBue9AVGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJJkbaGLGNh5bBnCp2uxJC7sVgT9rT4BJdRY8PxZF7PgYkW7ABotSLM2wqTIBv9Uo1RH9xdySCJmBWkAeKQ/nu30jNqcvQJVt37+31gkoGhK3dL+aFs2a6qWCgiFImX3GfH9bMKFmB4pePvXlv3g3/ytWw3yiWEXZRAMp8ESWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ODzZaBT/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=LofFdn71YhJEfg4gK8mqJ2EQ/Xufw9Ujp/0BZNUiuSw=; b=OD
	zZaBT/rDCeCpGiGnVgl4VG7kyi4r7LH/9K2ox5F62nicWoK8i2mLmNKkByiaAy2NSuSk8r3qvc5ch
	ENTTTHgM30/v41WWLAEXjHmi7Mek6IZjtfCR/+O9p3Rd5TEjR8gtzOterexQlXHMnelpHb9xYAt/p
	EGpe3aVaxfoZOZM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiZHb-00DkP8-9Z; Thu, 13 Feb 2025 14:29:35 +0100
Date: Thu, 13 Feb 2025 14:29:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH net-next 1/3] net: phy: mediatek: Add token ring access
 helper functions in mtk-phy-lib
Message-ID: <64b70b2d-b9b6-4925-b3f6-f570ddb70e95@lunn.ch>
References: <20250116012159.3816135-1-SkyLake.Huang@mediatek.com>
 <20250116012159.3816135-2-SkyLake.Huang@mediatek.com>
 <5546788b-606e-489b-bb1a-2a965e8b2874@lunn.ch>
 <385ba7224bbcc5ad9549b1dfb60ace63e80f2691.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <385ba7224bbcc5ad9549b1dfb60ace63e80f2691.camel@mediatek.com>

On Thu, Feb 13, 2025 at 07:39:39AM +0000, SkyLake Huang (黃啟澤) wrote:
> On Sun, 2025-01-19 at 18:12 +0100, Andrew Lunn wrote:
> > 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > 
> > 
> > > +/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x1 */
> > > +/* MrvlTrFix100Kp */
> > > +#define MRVL_TR_FIX_100KP_MASK                       GENMASK(22,
> > > 20)
> > > +/* MrvlTrFix100Kf */
> > > +#define MRVL_TR_FIX_100KF_MASK                       GENMASK(19,
> > > 17)
> > > +/* MrvlTrFix1000Kp */
> > > +#define MRVL_TR_FIX_1000KP_MASK                      GENMASK(16,
> > > 14)
> > > +/* MrvlTrFix1000Kf */
> > > +#define MRVL_TR_FIX_1000KF_MASK                      GENMASK(13,
> > > 11)
> > 
> > What does the Mrvl prefix stand for?
> > 
> > This patch is pretty much impossible to review because it makes so
> > many changes. Please split it up into lots of small simple changes.
> > 
> >     Andrew
> > 
> > ---
> > pw-bot: cr
> Those registers with Mrvl* prefix were originally designed for
> connection with certain Marvell devices. It's our DSP parameters.

Will this code work with real Marvell devices? Is this PHY actually
licensed from Marvell?

	Andrew

