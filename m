Return-Path: <netdev+bounces-202433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19408AEDEA5
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93A316587C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAAD28BA98;
	Mon, 30 Jun 2025 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="klaXRKJv"
X-Original-To: netdev@vger.kernel.org
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13AE285C90;
	Mon, 30 Jun 2025 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751289138; cv=none; b=BohmC43QP+YigtbYAkF7J1iY1LXpfpRJt1GOl3kKuhPWCxvYFFOofj3olFV+B9yFaK+8H/JW9B+C02AFuN7zdvapyKFDUgAFqLIGKoKG23mgn40FfPMUikdXriPcvWPHSClZQZJhavUUCckKprpbwIfghak78H9y7zHx6OUPGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751289138; c=relaxed/simple;
	bh=OHs81F/cs/WkB74kHSVhH4Jo4r1yqQvEoe3MyDgZJC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXEWmwnH5s5Z/7fh/g8WzEAcVBVk9izfbcmJy5i+5g4bellM2lOaNFHBCvLmNu2oTuxPWUYxoXRW/FbDiA0xmJbWHuQ98mvvjXdQR/MPokHEfqnq0yuY2hxbO7HkleRzc5GTttZnq+mhAi7B6drjVp7aMwCq7nrseqqrWpxTN84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=klaXRKJv; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C63D34495E;
	Mon, 30 Jun 2025 13:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751289128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHs81F/cs/WkB74kHSVhH4Jo4r1yqQvEoe3MyDgZJC8=;
	b=klaXRKJvmR7JDzCHXQtgLY/5uIDTXi6wnZXpinbV3pZeTjSpLgwrkCUf+GJYTFJ7eijZUC
	kRWKAd6QlBpZL0bGP33no8HfqyPpxgbW5R8UQMKen+sySy2Ni9ga9hq/r8alSwPn2yioNt
	0cJggjfxgUVRRhaCj5X1Kp5SrpmFOIlRymS5qk8XSE+SMy4H+atiMGzxkioXn9K10KK6tf
	fA2tJg5vPyono3UAdc1Ywvxs3KPXuCiveqZik3wMPAZTxf4ULLxZ3scFpbsm3NOziFH/73
	WMajfBOjtaiLS9lTcivGp5piPXW1fh025ev3xcmF+JDf9CaPwpQQoi/VfhsiEw==
Date: Mon, 30 Jun 2025 15:12:06 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Kamil =?UTF-8?B?SG9yw6Fr?= - 2N <kamilh@axis.com>
Cc: <florian.fainelli@broadcom.com>,
 <bcm-kernel-feedback-list@broadcom.com>, <andrew@lunn.ch>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <f.fainelli@gmail.com>, <robh@kernel.org>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net v3 2/4] dt-bindings: ethernet-phy: add MII-Lite phy
 interface type
Message-ID: <20250630151206.5ac6865c@fedora.home>
In-Reply-To: <20250630113033.978455-3-kamilh@axis.com>
References: <20250630113033.978455-1-kamilh@axis.com>
	<20250630113033.978455-3-kamilh@axis.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeuhfefgffgtdfhgffhvdfhhffhteeutdektefghfetveehheejjefgudeiudehudenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopehkrghmihhlhhesrgigihhsrdgtohhmpdhrtghpthhtohepfhhlohhrihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopegstghmqdhkvghrnhgvlhdqfhgvvggus
 ggrtghkqdhlihhsthessghrohgruggtohhmrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh

On Mon, 30 Jun 2025 13:30:31 +0200
Kamil Hor=C3=A1k - 2N <kamilh@axis.com> wrote:

> Some Broadcom PHYs are capable to operate in simplified MII mode,
> without TXER, RXER, CRS and COL signals as defined for the MII.
> The MII-Lite mode can be used on most Ethernet controllers with full
> MII interface by just leaving the input signals (RXER, CRS, COL)
> inactive. The absence of COL signal makes half-duplex link modes
> impossible but does not interfere with BroadR-Reach link modes on
> Broadcom PHYs, because they are all full-duplex only.
>=20
> Add new interface type "mii-lite" to phy-connection-type enum.
>=20
> Signed-off-by: Kamil Hor=C3=A1k - 2N <kamilh@axis.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

