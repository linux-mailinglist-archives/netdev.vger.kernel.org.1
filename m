Return-Path: <netdev+bounces-166807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7C6A375DC
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 17:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1FF16A951
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D9B19ADA2;
	Sun, 16 Feb 2025 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TnqXdLS5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A95618DB21;
	Sun, 16 Feb 2025 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739724000; cv=none; b=Z4m/Y0g8QCxxEvRjxNjI3pL7W9lb6/uAfZUgqtX8vA5DbAso32VVRsgm+PQinI+nBgszrB7siPZ7B6VZvXXjMhG39JxN9yBm6Uj+0F9xhEaFdzUL6yYsQ6SlwRjoeZAedd3MC86nH3LVOgUMwB2OfZc0rNEoHynI1qt5AYOCo0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739724000; c=relaxed/simple;
	bh=cv5EOH+N+QjpDHLVR3ttgMrKK0wRCoDgfy5bp2fw/II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCytZX0IUeVy8f9p+NIoAd3hd+oqy/Z4kpaW/l+rn8cX60aPztYmiWn80s68GhjrOZ5DCVzdb8VPW0QsT6s0kG3+/7naS2e9WPQLZiIjIh/qjoo+Kux22vw6xmtUYElEln2mVy6KRX/iheI6pKS4db5x4sX700QuD+DjQXjTM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TnqXdLS5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Ui7HEUJhEQf9Ds/ECcnB0minOtGYjZZ90SeYLQsSlUw=; b=Tn
	qXdLS5oE5zr4X/BKFyfbTLBPyRQnjEEEE+6IOI4N4TUmlx4pmDBdKCfMTX8IkxB2Mphf5neeQPE1L
	QXoyTXni+ghDDX/hh6v0/8sem8mFgGzC/3unW6xWd4FdDVTcKU2nXaKuAJrIL3UaKEXthOnMBAixt
	A1o30917TYG4+qU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjhgC-00Ehdh-2m; Sun, 16 Feb 2025 17:39:40 +0100
Date: Sun, 16 Feb 2025 17:39:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net-next 1/3] net: phy: mediatek: Add token ring access
 helper functions in mtk-phy-lib
Message-ID: <1b4c3254-c596-486a-bde9-d4737dfc5a48@lunn.ch>
References: <20250116012159.3816135-1-SkyLake.Huang@mediatek.com>
 <20250116012159.3816135-2-SkyLake.Huang@mediatek.com>
 <5546788b-606e-489b-bb1a-2a965e8b2874@lunn.ch>
 <385ba7224bbcc5ad9549b1dfb60ace63e80f2691.camel@mediatek.com>
 <64b70b2d-b9b6-4925-b3f6-f570ddb70e95@lunn.ch>
 <Z633GUUhyxinwWiP@makrotopia.org>
 <81234e04-f37c-4b10-81e6-d8508c9fb487@lunn.ch>
 <ea348d0a4b30c4926ba16a6e79cb52196aebcf47.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea348d0a4b30c4926ba16a6e79cb52196aebcf47.camel@mediatek.com>

On Fri, Feb 14, 2025 at 03:35:10AM +0000, SkyLake Huang (黃啟澤) wrote:
> On Thu, 2025-02-13 at 16:34 +0100, Andrew Lunn wrote:
> > 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > 
> > 
> > > > > Those registers with Mrvl* prefix were originally designed for
> > > > > connection with certain Marvell devices. It's our DSP
> > > > > parameters.
> > > > 
> > > > Will this code work with real Marvell devices? Is this PHY
> > > > actually
> > > > licensed from Marvell?
> > > 
> > > > From what I understood the tuning of those parameters is required
> > > to connect to a Marvell PHY link partner on the other end.
> > 
> > If so, the naming is bad. I assume you need the same settings for
> > Microchip, Atheros, Broadcom, etc. These settings just tune the
> > hardware to be standards conforming?
> > 
> >         Andrew
> > 
> This part is pretty old old old design. Some compatibility issues were
> firstly found on Marvell link partners, so the registers are named
> accordingly. And yes, now, those Kf/Kp settings will be used for
> connection with other link partners. However, if I change the register
> names, it violates our hardware register map application note. If this
> does bother, I can add some comments before these macros like:
> 
> /* Mrvl* prefix only means that in the very beginning we tune the
>  * parameters with Marvell link partners. These settings will be used
>  * for all link partners now.
>  */

A comment would be good. The current names lead the questions....

	Andrew

