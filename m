Return-Path: <netdev+bounces-155835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8A9A0400C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25DCF166564
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8E81E570D;
	Tue,  7 Jan 2025 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZDb97mVc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492FD1CD1F;
	Tue,  7 Jan 2025 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254629; cv=none; b=uUdT/EJxKXN8LIgb9kk6vemAY8hWuF3Z4KDowaY97n7dvYPdPZwgeC0CmQfkDsEAXXF8Q1vw4o02FTQeBZlfJ1agFJpy988M2Xsbmsa90X+FrdVdiDaM6MCn7cz6l6CWpPZOiX/ftnmtfZfXdHHYcJ9r7GKppj1jJ2Z8lQaXGVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254629; c=relaxed/simple;
	bh=oHNnOKxhScA5SC9geq9riFXnKbwiNmcYGTOYDg+1MXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBHWgNwLw1CIkMCJHVciKVJM62Ofq5NfWQT97GaWy3gTZwZDecx77YbTZcRthuAgU0iMe65gYoyHKmtTkRRQk+VT5T8wkOIbVRPAdrncvFhEtG/J33SP5scI/cgi5dMpIIaX0awk9Odzk3cjK7ADfRJjBl5nFvCOdrPrbqeExP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZDb97mVc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w7tutdgxhUe91jBswOXcqrGHfVAK226Wg+nsrpBVnc0=; b=ZDb97mVchKBW8gmMxKTlsOZl5g
	mHZV7XiGzR87hckmYN4DCSXPU4+Bkvd8FyIJ/eNvSPlJCZBC4b36c7MtGvjSl+BZyKiRT8JfrPH5W
	fPPonTOGLz7+aftvNo3vnIkOYFhLLsvOVJ7Z6vDRhX6Mn7EOxXlvqmN6ZXqkrDb1g4L4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tV98m-002EM7-ML; Tue, 07 Jan 2025 13:57:00 +0100
Date: Tue, 7 Jan 2025 13:57:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: EEE unsupported on enetc
Message-ID: <99eb663b-02c5-4ddb-b1d4-743baf2cc06d@lunn.ch>
References: <965a1d69-d1fb-4433-b312-086ffd2a4c12@gmail.com>
 <PAXPR04MB8510A9A1597FEB4037E76DDB88112@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB8510028FA548562F1A7B7A1688112@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510028FA548562F1A7B7A1688112@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Tue, Jan 07, 2025 at 02:19:53AM +0000, Wei Fang wrote:
> > > In enetc_phylink_connect() we have the following:
> > >
> > > /* disable EEE autoneg, until ENETC driver supports it */
> > > memset(&edata, 0, sizeof(struct ethtool_keee));
> > > phylink_ethtool_set_eee(priv->phylink, &edata);
> > >
> > > Is it a hw constraint (if yes, on all IP versions?) that EEE isn't supported,
> > > or is just some driver code for lpi timer handling missing?
> > > Any plans to fix EEE in this driver?
> > 
> > Hi Heiner,
> > 
> > Currently, there are two platforms use the enetc driver, one is LS1028A,
> > whose ENETC version is v1.0, and the other is i.MX95, whose version is
> > v4.1. As far as I know, the ENETC hardware of both platforms supports
> > EEE, but the implementation is different. As the maintainer of i.MX
> > platform, I definitely sure Clark will add the EEE support for i.MX95 in the
> > future. But for LS1028A, it is not clear to me whether Vladimir has plans
> > to support EEE.
> 
> By the way, I am confirming with NETC architect internally whether LS1028A
> ENETC supports dynamic LPI mode like i.MX95 (RM does not indicate this,
> but the relevant registers exist). If it does, we can add EEE support to
> LS1028A and i.MX95 together.

Do you know what the reset defaults are? Can you confirm it is
disabled in the MAC by default. We have the issue that we suspect some
MACs have EEE support enabled by default using some default LPI timer
value. If we disable EEE advertisement in the PHY by default for MACs
which don't say they support EEE, we potentially cause regressions for
those which are active by default, but without any control plane.

	Andrew

