Return-Path: <netdev+bounces-170917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF7CA4AA3E
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 11:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FA33BACE8
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 10:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EEE1C07F6;
	Sat,  1 Mar 2025 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KqrgluW3"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196BE1E49F;
	Sat,  1 Mar 2025 10:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740825537; cv=none; b=hlqc+0TpHZSghemcQlAUn53jUzJzMTCAIpp975JQWws5CwbxlDoM+COx+trC4kZi88UYE0rzKKSlEnKIt1aRy/UGR0j8qVlN7uWUUa35OCRekcc8FhMLThXLuSOojsm9PgnqvU/lzbLkejPvhr+a5XDsWO0Qe6bcfWAic06ZgOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740825537; c=relaxed/simple;
	bh=JQTs9bUhqydxLMWgj3vjSgvpLViqdm/Zd29g09a7KWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FnUrzCMG2XTb6zL7unkJpsx1dLC6vxLZASoVWYShvz2FTt1Nsx7p2gSYHRin+mYBMUAWv9sW1bN1UbRaZXwe360N/I8z60n+nnBs+jXWNIZnrbaR9TAN44nDchnP1A0U6ccZaHZfWj/Mhhb7y/kUyXNR0VX57NaeZiIa4IURIN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KqrgluW3; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7478E43319;
	Sat,  1 Mar 2025 10:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740825527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnlxC8ZW/CfqDjl5QKxrbPd8VoYU7dt7zFWgQ1CDGLw=;
	b=KqrgluW3hC8SfIGrUKkMKKLadJ1eu2tJh+1OKwN8pLZ5ENFClQlIrao6JGWw2C3gsdpNQu
	0G7xW9aXdBnDd6Et46S01DCo2N+WTw4OHKnjhpY+QoR/dwU0Va3ov3eB0RvImmMpm47fSv
	NYsUh0Klq7BvPIULXisXYYyG8RGPqMZgOINXbBEYG2wnpbyvD85Ej6rsrjatSn2R/RbiBh
	GjL8kPHVxYxwBb2f65GC0aNe2Rug8j2bEzOaJKqH17t1M3GRSZ271Ktmo8xpZvtjT3N/2F
	DD5faTJSD49wgxQns2R+Q2GacNNIr+DBmk7PNSvRpEDuMVU5wjaoPmjYysr5gQ==
Date: Sat, 1 Mar 2025 11:38:43 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Parthiban Veerasooran
 <parthiban.veerasooran@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net 2/2] net: ethtool: netlink: Pass a context for
 default ethnl notifications
Message-ID: <20250301113843.3b9df0fe@fedora.home>
In-Reply-To: <20250228182440.3c7f4709@kernel.org>
References: <20250227182454.1998236-1-maxime.chevallier@bootlin.com>
	<20250227182454.1998236-3-maxime.chevallier@bootlin.com>
	<20250228182440.3c7f4709@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelfedtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegvughum
 hgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehprghrthhhihgsrghnrdhvvggvrhgrshhoohhrrghnsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 28 Feb 2025 18:24:40 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 27 Feb 2025 19:24:52 +0100 Maxime Chevallier wrote:
> > The only relevant user for now is PLCA, and it very likely that we never
> > ended-up in a situation where the follow-up notif wasn't targeting the
> > correct PHY as :  
> 
> PLCA uses the ethnl_default_* handlers but it seems to operate on PHYs
> now. How does the dump work? Shoehorning the PHY support into
> the ethnl_default_* handlers is starting to look pretty messy.

Thinking more about this, this patch shouldn't have targetted -net in
the first place, as no usecase regressed yet (we don't have any
multi-PHY PLCA setup that exists). The DUMP keeps working as it did
before for that command, in that we dump the PLCA info for
netdev->phydev.

That DUMP / notify situation needs to be addressed as tome point thouh,
before the multi-PHY support through muxes lands (haven't sent it yet,
I'm still on the preliminary series for phy_ports).

So I think that indeed, I'll resend patch 1, and find a more graceful
solution for the phy-targetting commands in a separate series.

Maxime

