Return-Path: <netdev+bounces-170392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21E6A487C6
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 19:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66D41886BA7
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF53B1F417F;
	Thu, 27 Feb 2025 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UgMIkYq/"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27D1B424D;
	Thu, 27 Feb 2025 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680807; cv=none; b=f96o/Ev6KpG5S3vzmwrivtv6oc2DGSjuChEkbzgJp8bUnYwfsbL1nR6a+t1nW19qCdGM5LRPzQ9SMD+BpM2zdFzdSqEjgTKhIJk2Go6WX0qkBcIYnLoxdUpldMUEpXW2BGOxx6Thewjwk8wywXZQLO0/yunILH5WfieufiqJiwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680807; c=relaxed/simple;
	bh=H+wBhynRPEUMANfE9ELqFbSyNT6n8X9fiPEn2VlWHlU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M11ac70dMWF1ZuChEWKRpQ5y/NLuRiGy2VhU2eFheiSyVBjVrni2v7AY+P5FNMJF5VFitWlbkYISS+bbfk2NE6b3CMwZMPKiygMwWwfFUKvUeeq2zPfC13yflJGnSqqrcQOPY24lsIapt7Nuj6/BUy7WuyEdT5j+P/vJVj5sfWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UgMIkYq/; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3EC654452A;
	Thu, 27 Feb 2025 18:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740680803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5OHpeTevapjpXns0af8rWtmgUSNADa+twmLoVsFzfNw=;
	b=UgMIkYq/Rap3m9+gQ9n+sDO3Y1wOZBbkadd0W0TL65PmbZ3GvZHxeFV2bl47/RbsjWBge2
	LgfBvhxPC+Qr4O45KflSGhWdvvmGwq6tQ7rTupYX9msZzavgTMjz1b4Of9E+bCqhyjHhKr
	CtReEKOs4uG4ZxZRB9cIpf7HeLxcOnyWMVy3o/VyqY3caHrXNly/+oncTCvCXxCMgycKJg
	+0/56YhTqGNHFV9aqzjq8awPHBPM3YMR5ejcROz2/pEXtAP4YJsKacC1VqbOF9SvzhN+N3
	FmJa45GmMgdiBFhBJEBmuFb60B2U67C7EvSOFoPl8ZT+u8vKWFKTegCNsAtA+g==
Date: Thu, 27 Feb 2025 19:26:40 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, Parthiban
 Veerasooran <parthiban.veerasooran@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net 0/2] net: ethtool: netlink: Fix notifications for
Message-ID: <20250227192640.01bae3b4@fedora.home>
In-Reply-To: <20250227182454.1998236-1-maxime.chevallier@bootlin.com>
References: <20250227182454.1998236-1-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughum
 hgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehprghrthhhihgsrghnrdhvvggvrhgrshhoohhrrghnsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

On Thu, 27 Feb 2025 19:24:50 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

Oops subject got truncated, should be :

net: ethtool: netlink: Fix notifications for PHY commands 

Maxime :(

