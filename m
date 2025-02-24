Return-Path: <netdev+bounces-168946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D14A41B2B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 11:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3573616C6FB
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 10:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE5A2505C2;
	Mon, 24 Feb 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I3DKzfiM"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F2618DF81;
	Mon, 24 Feb 2025 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393144; cv=none; b=HmcWLiQ5jxPB+gqvZ5HfgCjfKT4gzsCQQrm8a+Hb9g9atawNlVjFJ+Ggq9KCPtc/H4zLT0/M4+uoQgHQ8IRk14u3XRzD9yZyCY1vJoVXgb59rb16KCcDT/Ih6VnRyyetfS9XGrnRLbY43fo1aGatT50+aXTTu8odPqTGPrjdSQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393144; c=relaxed/simple;
	bh=kmiUWottMqUmD9pwlq8LJWeLdJxkXiJtNLyDsa31Xag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCyiWKI8mKBLTDrzKBiUGU7NPdRt1nEsVFwodQ5p1k6WhrU2eTSDj88eh3i6MxUu2cgR60JdclsBXFzREDukVFXlCbleWqSHfeOXadO2J452ObABmgxbhO+cVixOq3GhBIVV1N+fW1iTxTUtmJrgJmVu2uLSqyLHixcYccRElww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I3DKzfiM; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E1F884330A;
	Mon, 24 Feb 2025 10:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740393139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5pZ4rGld7+wgJdWraoWb/RGBxY0COmg+Ax2pB/rA6w=;
	b=I3DKzfiMLNM+1NEqzs+4vFCf2r0HxwI4IjQv/XSGJkfnJIhNlB9Z8FCCzdqR5F1pjdFJ2e
	XOD1LX8/QHoMEhkUHxkA+hnJtdx6PA7M0h9tw5VKyrq4lVaDkg7AVdg9VIlnP0U1WPIfrc
	MM75ymYC6ztayFIGjCiEPNzmd0gcFvoePHfdk8Ray2qsccJ/pqxncERdk4kNqtohFX2GF7
	1beUfkaTQIm/wbbwWOe03vXCgSlh1/v55cmNGmxvpSbFdutpCq9p5JKpPvwt0Fl6zuGvn0
	BURQ7fyO7htlRg1EIAhpM9a75yU4aq399w69RnpA/ExdF1XolGJA9CgQFtRkaQ==
Date: Mon, 24 Feb 2025 11:32:17 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Harshal Chaudhari <hchaudhari@marvell.com>
Cc: <marcin.s.wojtas@gmail.com>, <linux@armlinux.org.uk>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] net: mvpp2: cls: Fixed Non IP flow, with vlan
 tag flow defination.
Message-ID: <20250224113217.18d3e0a8@fedora>
In-Reply-To: <20250224062927.2829186-1-hchaudhari@marvell.com>
References: <20250224062927.2829186-1-hchaudhari@marvell.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepfhgvughorhgrpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohephhgthhgruhguhhgrrhhisehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepmhgrrhgtihhnrdhsrdifohhjthgrshesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghml
 hhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

On Sun, 23 Feb 2025 22:29:27 -0800
Harshal Chaudhari <hchaudhari@marvell.com> wrote:

> Fixes: 1274daede3ef ("net: mvpp2: cls: Add steering based on vlan Id and priority.")
> 
> Non IP flow, with vlan tag not working as expected while
> running below command for vlan-priority. fixed that.
> 
> ethtool -N eth1 flow-type ether vlan 0x8000 vlan-mask 0x1fff action 0 loc 0
> 
> Change from v1:
> 	* Added the fixes tag
> 
> Signed-off-by: Harshal Chaudhari <hchaudhari@marvell.com>

Well spotted, thanks for fixing this

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

