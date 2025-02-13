Return-Path: <netdev+bounces-166040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6ACA340A1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FA13A91A7
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7133724BC05;
	Thu, 13 Feb 2025 13:44:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4039B24BBE3;
	Thu, 13 Feb 2025 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454255; cv=none; b=GuLmP7gSn9b/CIzBrJCtImjmHVngpiAhWOYW42TirG6YveGZfszrA4mhqNobEDukJiC2HQOVbNAXw2mINVGmKHw1eV+Ai8bzufr9j4GEPJg/zlXl2Kkx6zO/b+5d3Ih4ylWENkli5bj0H84ZmuaQ3Slu/hg6AY2UIfUICC4rWOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454255; c=relaxed/simple;
	bh=Gf5XlcBFsWN4QJsR+1HzM2Bgu+Zcav2L/l3H3ze+l0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQ2aBVr1DVcSvZbmgu4wY4tAh9CqkC1GxlVtvnE13B4q/nrubgbiEcXzAPDJxxcASg26v8p4kwB9yYVzOoRA7Kkgtlv6ghjmhc6tArapS0g3WT4WQhu8gJLbXANhwDgn9BnjLtNM1+q4yGVUbhEYAAZ/S88VJnhKL1BhcBVH6XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tiZVU-000000006S5-2pBC;
	Thu, 13 Feb 2025 13:43:56 +0000
Date: Thu, 13 Feb 2025 13:43:53 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH net-next 1/3] net: phy: mediatek: Add token ring access
 helper functions in mtk-phy-lib
Message-ID: <Z633GUUhyxinwWiP@makrotopia.org>
References: <20250116012159.3816135-1-SkyLake.Huang@mediatek.com>
 <20250116012159.3816135-2-SkyLake.Huang@mediatek.com>
 <5546788b-606e-489b-bb1a-2a965e8b2874@lunn.ch>
 <385ba7224bbcc5ad9549b1dfb60ace63e80f2691.camel@mediatek.com>
 <64b70b2d-b9b6-4925-b3f6-f570ddb70e95@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64b70b2d-b9b6-4925-b3f6-f570ddb70e95@lunn.ch>

On Thu, Feb 13, 2025 at 02:29:35PM +0100, Andrew Lunn wrote:
> On Thu, Feb 13, 2025 at 07:39:39AM +0000, SkyLake Huang (黃啟澤) wrote:
> > On Sun, 2025-01-19 at 18:12 +0100, Andrew Lunn wrote:
> > > 
> > > External email : Please do not click links or open attachments until
> > > you have verified the sender or the content.
> > > 
> > > 
> > > > +/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x1 */
> > > > +/* MrvlTrFix100Kp */
> > > > +#define MRVL_TR_FIX_100KP_MASK                       GENMASK(22,
> > > > 20)
> > > > +/* MrvlTrFix100Kf */
> > > > +#define MRVL_TR_FIX_100KF_MASK                       GENMASK(19,
> > > > 17)
> > > > +/* MrvlTrFix1000Kp */
> > > > +#define MRVL_TR_FIX_1000KP_MASK                      GENMASK(16,
> > > > 14)
> > > > +/* MrvlTrFix1000Kf */
> > > > +#define MRVL_TR_FIX_1000KF_MASK                      GENMASK(13,
> > > > 11)
> > > 
> > > What does the Mrvl prefix stand for?
> > > 
> > > This patch is pretty much impossible to review because it makes so
> > > many changes. Please split it up into lots of small simple changes.
> > > 
> > >     Andrew
> > > 
> > > ---
> > > pw-bot: cr
> > Those registers with Mrvl* prefix were originally designed for
> > connection with certain Marvell devices. It's our DSP parameters.
> 
> Will this code work with real Marvell devices? Is this PHY actually
> licensed from Marvell?

From what I understood the tuning of those parameters is required
to connect to a Marvell PHY link partner on the other end.

