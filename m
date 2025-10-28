Return-Path: <netdev+bounces-233672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 712FFC17372
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9321C6214C
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 22:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC683570A4;
	Tue, 28 Oct 2025 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="npzPWHl5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514623563FD
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761691221; cv=none; b=oki4NsOEIrizbM8OeHfix8nWsh31RMFPKMxwWcJewJ3OUjLkIzYdxHEdlLQ16YzOKcC2wqPaENjqX2X8RNlVesY4J68yZnwGu86qRIEUN7jeQ84BnMO+I+Qi0ZqppUl0xHh7jqSAQ+idSVj5vYX9q3b+N0NSCNLHNwl8VmoLUGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761691221; c=relaxed/simple;
	bh=9qPGT5/hyQCqOkmnpFMkk14KvZOwJ3zgv3UXYB/0Ta4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/xYkJheFDQ8Wu7GDi9AMbCnH3wNazUM0hzjiEzOVkU89Hqkh48N7xcHqd7nYOlUveqXjSby52butGI7n9LYNyNGvTbUK1JbiX/cnjm+olQUPM9sUgpQID8rQI4uv9tVh89AnnCwE5KXxuWeldnA3IWbvhla4u0i9E0SZl+1z94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=npzPWHl5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Tbwe1MrTnwet8PXUX0le34BIelpr3J1l3iqS0vSOdNc=; b=npzPWHl5Bf1voLCiP8nTa0a1wL
	O5CzHwxro9h3YRxCkaHFT2Ys973WmNkdduW82uu3KLuga5pAzteHyU+zBd/FWDj2D/sIVEnpsYoym
	CqbSLjyQCPicaJzXmQc48H7zYbo48waBjk/zllFLIufmXXKyyH1LAhwDPiK88/PZBp3I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDsMQ-00CKzm-6w; Tue, 28 Oct 2025 23:40:14 +0100
Date: Tue, 28 Oct 2025 23:40:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
	hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
	davem@davemloft.net
Subject: Re: [net-next PATCH 3/8] net: phy: Add 25G-CR, 50G-CR, 100G-CR2
 support to C45 genphy
Message-ID: <b1a3229b-50cc-4f99-a5fd-54335f1a8f83@lunn.ch>
References: <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
 <176133845391.2245037.2378678349333571121.stgit@ahduyck-xeon-server.home.arpa>
 <c06dc4a6-85b4-41e9-9060-06303f7bbdbc@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c06dc4a6-85b4-41e9-9060-06303f7bbdbc@bootlin.com>

On Tue, Oct 28, 2025 at 08:32:03AM +0100, Maxime Chevallier wrote:
> Hi Alexander,
> 
> On 24/10/2025 22:40, Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>
> > 
> > Add support for 25G-CR, 50G-CR, 50G-CR2, and 100G-CR2 the c45 genphy. Note
> > that 3 of the 4 are IEEE compliant so they are a direct copy from the
> > clause 45 specification, the only exception to this is 50G-CR2 which is
> > part of the Ethernet Consortium specification which never referenced how to
> > handle this in the MDIO registers.
> > 
> > Since 50GBase-CR2 isn't an IEEE standard it doesn't have a value in the
> > extended capabilities registers. To account for that I am adding a define
> > that is aliasing the 100GBase-CR4 to represent it as that is the media type
> > used to carry data for 50R2, it is just that the PHY is carrying two 2 with
> > 2 lanes each over the 4 lane cable. For now I am representing it with ctrl1
> > set to 50G and ctrl2 being set to 100R4, and using the 100R4 capability to
> > identify if it is supported or not.I
> 
> If 50GBase-CR2 isn't part of IEEE standards and doesn't appear in the
> C45 ext caps, does it really belong in a genphy helper ?

I agree with you here. We should not pollute our nice clean 802.3
implementation. If the Ethernet Consortium had defined how these modes
are represented in MDIO registers, we could of added helpers which
look at the vendor registers they chose to use. We have done this in
the past, for the Open Alliance TC14 10BASE-T1S PLCA. But since each
vendor is going to implement this differently, it should not be in the
core.

> You should be able to support it through the .config_aneg() callback in
> the PHY driver.

It is probably a little more than .config_aneg(), but yes.

I assume FB/META have an OUI for their MAC addresses? I _think_ the
same OUI can be used for registers 2 and 3 in MDIO. So your fake PHY
can indicate it is a FB/META PHY and cause the FB/META PHY driver to
load. The .get_features callback can append this 50GBase-CR2 link
mode. The .read_status() can indicate if it is in use etc. And you can
do all the other link modes by just calling the helpers. I assume you
are currently using the genphy_c45_driver? That can be used as a
template.

	Andrew

