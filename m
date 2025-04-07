Return-Path: <netdev+bounces-179669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0E0A7E0C5
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFEA63B24CB
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE591C54A6;
	Mon,  7 Apr 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L4XVTbFJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6601C5D6A;
	Mon,  7 Apr 2025 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034895; cv=none; b=LYpvrSSECOP6/61wpGzRsfUCBe3e9+DKGlkaiIPg/oDBLgtwUOMtmjJcyNnLf+c+XonGfDnahs0ECX83L5TuIMsXNiTaLKB0wV//fpG3q7fDx5aZg9cvi5Y/1/4LSlITogEeS/MrokswlqTPaoaBKOCrKzF8U+xxrf3k23ThEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034895; c=relaxed/simple;
	bh=5Ybx/iOk+2GUXHdmzGiKkhK+smCndiqXpTBToD/+yAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9PWhrhTy4UPz3BrBKiZyl2PUq7ycVsELEAyaaRwpW70j1UHYlBrtuW1ZHPE1ASCkvVnreDOTEk9qpKmwfguRKvJNEbF3yTO0yKz+BJqCABg7M8alUVCY/Se+dLKsjixrNNlb79Vkq+ldmR/HzBVhQkK+9zPNW2od6tjo1lgcoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=L4XVTbFJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MtwfmjXfQNUVZqbiDeY9oM+qm820t7eNIzvQ5yyWlhM=; b=L4XVTbFJplMI/iy67enp9jpKyw
	0op+AcLA7KqrPDGGUjvrE9AQQba2NqZ/ylurfFa/TxomDCg8uZJ2Z7t9HCZh39uTQwXx6wTmv4XYP
	nUMJgmzdsYNfQJ/B3hlsBIVW/Lrl/bPS5sYx5C9H5maKIOCz9OMESRl0gNaBqdHLZ2MI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u1n8u-008F08-UT; Mon, 07 Apr 2025 16:08:04 +0200
Date: Mon, 7 Apr 2025 16:08:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH net-next v2 0/2] Add Marvell PHY PTP support
Message-ID: <fdfef9fd-6f9a-428f-b97f-deb52186e2f8@lunn.ch>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>

On Mon, Apr 07, 2025 at 04:02:59PM +0200, Kory Maincent wrote:
> Add PTP basic support for Marvell 88E151x PHYs.

Russell has repeatedly said this will cause regressions in some setups
where there are now two PTP implementations, and the wrong one will be
chosen by default. I would expect some comments in the commit message
explaining how this has been addressed, so it is clear a regression
will not happen.

     Andrew

