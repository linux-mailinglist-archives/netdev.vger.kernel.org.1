Return-Path: <netdev+bounces-71003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E50985189A
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 17:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2E09B21677
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F773CF79;
	Mon, 12 Feb 2024 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DJxiDpXH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736BF3D0A8
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753781; cv=none; b=cOaSEH9cL20xR3KYBi2ZPXcTC+HbErjzoCmOgOSFrUQDZBUhdrvjyXQVExlMUsuQPZNqmINUd0rAoAgTNdIZk2dpHseasMOEWXuHUsoB4WwBevxZPlsqHVCPTG1Mqux4YtxvfnHzNjJcWXglsnZi24yLl46WSUYq246EcuQBWLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753781; c=relaxed/simple;
	bh=9Qg7T7gXvDGdU+s1cI0p7bNXkHGFM5nIY7fb0pMifis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJl5Ru9WsnKVUd9V2OsovCN5oIeRyuXTrDHIBU4soDzFoxsuxDiyY71spHy9i904aq1T/1Tv4PgNNkptCusRXAnEpgwad63eLnzWlX86LE2vaFSLqqeoA/spTx2406bs/Vs4mzSrnk3YelvH4sFB8tZ/n+/WLbreCOeZB9SErqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DJxiDpXH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=GGRNhtImw23IeTXqJfseijocYQv8qaezIL2MsjtXEbM=; b=DJ
	xiDpXHf/QsK1YTykumsYyn0PE4NinxjIOyRJHFvyayumwcilKL/MsepNg8pk9mnqdXb3dTfiy9kG6
	Ur8wfetrmpzxb3lRrMzzfyMJ2KjX8OCSmOrbe8yV4TSnoHyzYJVT4V3Xo9bR7iQf1byVIkBJVDJWO
	cwaQI0MUIzyvV2E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZYls-007aYN-3t; Mon, 12 Feb 2024 17:03:04 +0100
Date: Mon, 12 Feb 2024 17:03:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] net: fec: Refactor: #define magic constants
Message-ID: <2880cd18-a0a8-473e-b21a-0dba043302ea@lunn.ch>
References: <20240209091100.5341-1-csokas.bence@prolan.hu>
 <2f855efe-e16f-4fcb-8992-b9f287d4bc22@lunn.ch>
 <a7b8df0b-fc24-441e-b735-7bf319608e99@prolan.hu>
 <cfc31be3-935d-432f-aa7a-38976c7ca954@lunn.ch>
 <41e96e5e-2184-4ac0-886f-2da18b726783@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41e96e5e-2184-4ac0-886f-2da18b726783@prolan.hu>

On Mon, Feb 12, 2024 at 04:11:10PM +0100, Csókás Bence wrote:
> 
> 
> 2024. 02. 12. 16:04 keltezéssel, Andrew Lunn írta:
> > On Mon, Feb 12, 2024 at 03:49:42PM +0100, Csókás Bence wrote:
> > > Hi!
> > > 
> > > 2024. 02. 09. 14:53 keltezéssel, Andrew Lunn írta:
> > > > > @@ -1181,7 +1194,7 @@ fec_restart(struct net_device *ndev)
> > > > >    	if ((fep->pause_flag & FEC_PAUSE_FLAG_ENABLE) ||
> > > > >    	    ((fep->pause_flag & FEC_PAUSE_FLAG_AUTONEG) &&
> > > > >    	     ndev->phydev && ndev->phydev->pause)) {
> > > > > -		rcntl |= FEC_ENET_FCE;
> > > > > +		rcntl |= FEC_RCR_FLOWCTL;
> > > > 
> > > > This immediately stood out to me while looking at the diff. Its not
> > > > obvious why this is correct. Looking back, i see you removed
> > > > FEC_ENET_FCE, not renamed it.
> > > 
> > > What do you mean? I replaced FEC_ENET_FCE with FEC_RCR_FLOWCTL, to make it
> > > obvious that it represents a bit in RCR (or `rcntl` as it is called on this
> > > line). How is that not "renaming" it?
> > 
> > Going from FEC_NET_ to FEC_RCR_ in itself makes me ask questions. Was
> > it wrong before? Is this actually a fix? Is it correct now, or is this
> > a cut/paste typo? Looking at the rest of the patch there is no obvious
> > answer. As i said, you deleted FEC_ENET_FCE, but there is no
> > explanation why.
> 
> The name `FEC_ENET_FCE` does not tell us that this is the FCE (Flow Control
> Enable) bit (1 << 5) of the RCR (Receive Control Register). I added
> FEC_RCR_* macros for all RCR bits, and I named BIT(5) FEC_RCR_FLOWCTL, a
> much more descriptive name (in my opinion, at least).

Some form of that would be good in the commit message. It explains the
'Why?' of the change.

> So, a separate patch just for removing FEC_ENET_FCE and replacing all usages
> with FEC_RCR_FLOWCTL? And the rest can stay as-is?

A few others made review comments as well. It could be addressing
those comments also requires more small patches. Sometimes you can
avoid review comments by thinking, what are reviewers going to ask,
and putting the answer to those questions in the commit message. This
might all seam like a lot of hassle now, but it will help getting your
future patchsets merged if you follow this advice.

      Andrew

