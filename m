Return-Path: <netdev+bounces-117210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B02394D1BB
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 16:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00BB5B20B4B
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3428F1922F5;
	Fri,  9 Aug 2024 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xSyUs0dB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2EA1D551;
	Fri,  9 Aug 2024 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212069; cv=none; b=Do/DE/6lmrPOL4LkqSYUEuvrOvEQpuq7xasuRuR0zZfNxm/V9fuY9MPuGUO5MlW7LFoRB4p/RkIs9G5dJ8tpnzli62P9fz0dNK3UHotRpFrneFWKK8dZON6o4P9dfGtQ/7tnUahEOVc2yPI6IdK7hmzx59nsupv86W7COsSpNEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212069; c=relaxed/simple;
	bh=wOBtner8hi1K5hkgNsMPMhY123WSzOtLtLL/HsSyKuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ed3CsRmkX8O3LyOs3EUNj8dpXJcQOj/echh21VFq5vANhX2BiSIF8Crx3R768kWae5DGrzKw6nUmkBw3ADvDrrtXcasGUasnoW2NVNNILf+2SosKS7m0ICjvFx4xsG5wSKOpdznGcsfkUN1wc23VEAyhD1KmNn7Bw2+QdRCntvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xSyUs0dB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=MzghURwGNLdztqm2bXnd89oEb6Aby1XcEnDVCDSneaI=; b=xS
	yUs0dB42NB9mokFGZ7CTSPapz+5wlI/gS4bDwB9Oe9omiFY7GnWemfhKeOAXb+LoY4Znv07jeRLJC
	uTg/wkJHgjr0eglQbYOxgTsFTKGYUhoaIx3zSNSISgkqHkZ4jW1HLvjWv0IIjY+gfgC+BAKwOEvNf
	ydrycuTX5RtbKZo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1scQAn-004Nmy-U2; Fri, 09 Aug 2024 16:00:53 +0200
Date: Fri, 9 Aug 2024 16:00:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] phy: Add Open Alliance helpers for the
 PHY framework
Message-ID: <5d62cf99-c025-42f1-99db-f1f872d1650a@lunn.ch>
References: <20240808130833.2083875-1-o.rempel@pengutronix.de>
 <20240808130833.2083875-2-o.rempel@pengutronix.de>
 <eab136c5-ef49-4d4e-860c-c56840747199@lunn.ch>
 <ZrWmfqtYICzaj-HY@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrWmfqtYICzaj-HY@pengutronix.de>

On Fri, Aug 09, 2024 at 07:17:50AM +0200, Oleksij Rempel wrote:
> On Thu, Aug 08, 2024 at 03:54:06PM +0200, Andrew Lunn wrote:
> 
> > Please could you give a reference to the exact standard. I think this
> > is "Advanced diagnostic features for 1000BASE-T1 automotive Ethernet
> > PHYs TC12 - advanced PHY features" ?
> > 
> > The standard seem open, so you could include a URL:
> > 
> > https://opensig.org/wp-content/uploads/2024/03/Advanced_PHY_features_for_automotive_Ethernet_v2.0_fin.pdf
> 
> I already started to implement other diagnostic features supported by the
> TI DP83TG720 PHY. For example following can be implemented too:
> 6.3 Link quality – start-up time and link losses (LQ)
> 6.3.1 Link training time (LTT)
> 6.3.2 Local receiver time (LRT)
> 6.3.3 Remote receiver time (RRT)

These three are the time it takes for some action. Not really a
statistic in the normal netdev sense, since it does not count up. But
they are kind of statistics, so it is probably not abusing statistics
too much, so maybe O.K.

> 6.3.4 Link Failures and Losses (LFL)

This is a count, so does fit statistics. 

> 6.3.5 Communication ready status (COM)

Similar to the BMSR link bit. Do it add anything useful?

> 6.4 Polarity Detection and Correction (POL)
> 6.4.1 Polarity Detection (DET)
> 6.4.2 Polarity Correction (COR)

Could these be mapped to ETH_TP_MDI* ? 

      Andrew

