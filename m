Return-Path: <netdev+bounces-166806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3BFA375D5
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 17:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4AD3AC6AF
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C5F19AD48;
	Sun, 16 Feb 2025 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UJ59A9xI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DB818024;
	Sun, 16 Feb 2025 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723791; cv=none; b=Hg0/V6KA/wH7Q9g/EnBSi1PFed8//NlNAsZrBRZQ+sFcMjKAXOKTdKxy8Ejmy+D9OFT+ps3aKnz5NwZRInjei8smzCGXDLfQwbI6zTsJDaw13chFdUEacOQHeMFYskIiAL4aHHT1xLZ/LUy/rzAadjaepUfVf7y+Qn8gFf+yUmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723791; c=relaxed/simple;
	bh=ByXLAurH+1Re1vVJZ/BAA4HrNWB6FIi2AKVogbcsalw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ocy9dv3D6lbPQpSnELcCdsY6wc6u1W7VP6MSJxXDLJc0lUhAGdNIp6wdHEW9tR4IxSuSMdhKYK22tK4MuD8FWy+UmfXpge9/+o5Qb1Boc02hx5e2hzRGkTDzfYC9hv7t69AQuwu6qrCuLyjqT02WtoTbE5P3gxPFbhoXoPi32Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UJ59A9xI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZsOQcoouRE/mfiTFlVK+KMfUUssVnYx0z0OR3ds2eRM=; b=UJ59A9xIaPWrvFp/9acztvmD2r
	H1j65E31RNbmx78HtLmmgvzF+oNEU/h/bFAHaa5tewmZxE7PTFuQc8Y9s/g9MLpAteqq3fttnW0hN
	82o0GHAaHZtHMphzMW02dfF6tj/KwxO+mYafb6g3rv/MeGjmrESFL8+/xi8pZIB0yKcw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjhd0-00Ehal-SA; Sun, 16 Feb 2025 17:36:22 +0100
Date: Sun, 16 Feb 2025 17:36:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next] Documentation: net: phy: Elaborate on RGMII
 delay handling
Message-ID: <92111af4-c0d0-48bd-b774-0cac4f2abd13@lunn.ch>
References: <20250214094414.1418174-1-maxime.chevallier@bootlin.com>
 <Z68WDG_OzTDOBGY-@shell.armlinux.org.uk>
 <20250214114254.0b57693b@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214114254.0b57693b@fedora.home>

> Just to clarify, do you see that patch as useful ? seems to me like the
> original version is clear enough to you
> 
> Thanks for reviewing,

Is the problem that the documentation is confusing? Or that developers
don't actually read the documentation, nor the mailing list?

There is a point of diminishing returns with working on Documentation.

There might be more value in working on checkpatch, add a warning
about any patch adding phy-mode == 'rmgii' without a comment on the
line.

	Andrew



