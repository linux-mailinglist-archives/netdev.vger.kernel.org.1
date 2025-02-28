Return-Path: <netdev+bounces-170597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A40A4931C
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 09:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF881894C70
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 08:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E642B204845;
	Fri, 28 Feb 2025 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GLOqmQrX"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F4A1DE4F8;
	Fri, 28 Feb 2025 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730447; cv=none; b=FSYM+bg8K96uubqdDPwEQQMIfYkysP34Bm8ZrX9ucDQRmiADDqCBRx0LtqIPyk0hX3AU+IxmTK3RhshqCminW3VIyUUJFTDVcmHpTxToyEDm7FIddcMIZOE9rGBeV3ZN6igHKmy7ELZ/Jizz14q4SBkLzb2cky448KftENAuc70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730447; c=relaxed/simple;
	bh=uZFik38ukK67rSB3UbsyYb8IO5hHzu6g1JwC/lW210U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iH26sTMRm8vLYMqSOJXN309CDkfXbpXo/ZwBvijDVpln4cBmBLcgeEAjohusiAA7BN4orNdDiO1JEv68fD9xXgBLCYGtVlRa6vu+m/ptW7+BJsWH7TCVjxK6gmt+7ckL0R6zlcDJuDSGM1z7mVss2pCmxBzTok2TvqghuYgah20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GLOqmQrX; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4C8B4452E;
	Fri, 28 Feb 2025 08:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740730443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOa3s22YAm/GS76NctbdlTN04itDWk+8Ouif3lZJgQ8=;
	b=GLOqmQrXUKtxZL+GRVzAyv1Mj0DEAQcSkiraYQ0fH0XoogpE7H53q4W40Y4kK58LVLSt4a
	4iAGeQGRMndlOVFbbW3oIpfeyqb9c8WbK/eaxfroxXX5nAQRpw2j9VFFNRL3umEFkqMjyb
	TIPrcZdTLBqr1YXB4VGu0zlOr6cct5NDux3Bbntk+SzTW2IjaIki2KwPT//8jpsy4iu3Ig
	7VRJddudCQb9+2gT1iuBFBqCCHdA88CW7ShHX4fXpBcbCqnWbxDP9kfrP62UHP3b4KCJxo
	xQ4RnWQ99rs1q/P4AyRtF8MS+9/v8yc+ypK14Wv2QJgHV8k9Tg/2QxiZ+fyd2Q==
Date: Fri, 28 Feb 2025 09:14:00 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: <Parthiban.Veerasooran@microchip.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <thomas.petazzoni@bootlin.com>, <linux-arm-kernel@lists.infradead.org>,
 <christophe.leroy@csgroup.eu>, <herve.codina@bootlin.com>,
 <f.fainelli@gmail.com>, <vladimir.oltean@nxp.com>,
 <kory.maincent@bootlin.com>, <o.rempel@pengutronix.de>, <horms@kernel.org>,
 <romain.gantois@bootlin.com>, <piergiorgio.beruto@gmail.com>,
 <davem@davemloft.net>, <andrew@lunn.ch>, <kuba@kernel.org>,
 <edumazet@google.com>, <pabeni@redhat.com>, <hkallweit1@gmail.com>
Subject: Re: [PATCH net 0/2] net: ethtool: netlink: Fix notifications for
Message-ID: <20250228091400.7ed7237c@fedora.home>
In-Reply-To: <c6df7040-40d2-46e0-b8f3-a28227d2d98c@microchip.com>
References: <20250227182454.1998236-1-maxime.chevallier@bootlin.com>
	<c6df7040-40d2-46e0-b8f3-a28227d2d98c@microchip.com>
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
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekleekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtoheprfgrrhhthhhisggrnhdrgggvvghrrghsohhorhgrnhesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghupdhrtghpthhtohephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepfhdrfhgrihhnvghllhhisehgmhgrihhlrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 28 Feb 2025 06:19:18 +0000
<Parthiban.Veerasooran@microchip.com> wrote:

> Hi Maxime,
> 
> I did a quick test with your patches and it seems working fine without 
> kernel crash.
> 
> Best regards,
> Parthiban V

Thanks for testing, good to hear that this solves the issue :)

Maxime

