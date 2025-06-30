Return-Path: <netdev+bounces-202432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ABEAEDEAD
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316C71882A8D
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1AA28B7EB;
	Mon, 30 Jun 2025 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mQa/LtBc"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F4228B7D7;
	Mon, 30 Jun 2025 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751289089; cv=none; b=PnGAISDBlarEtlx5/PYj+CKyiOylquFu6c+Bq51UaMsPlwefYJW9EW+A64r3t0IerjE6TrSEwLr8zgaOsdWUO/Jmkt/KitNRKHFblfZ0R9kksTs7iMQHO+NoNliEc0lf0AcIKyiJM2dbi93PLBUCO0h7E/OrsOudS/GugYoH/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751289089; c=relaxed/simple;
	bh=vqa0KiwTFMzuHZ6USf9y0bqTn9C9j3I5YF/Sjk/rxHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAKfX17m5gCwJZDY3RnV/vE9gVNNPv2Xf22T5D12K8ubpv0+pUX4zZ+p+h+w4pwqT/nY4dypXAEwPerRDgPeYPE5NKppV7npbdRkKwZw3kpV27ZylqsjuPOri/KGAV0v79xq3A15nWyx1ELpB6qhFc2GXeuJC5XI3Dfnvepjw6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mQa/LtBc; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 92B3D44329;
	Mon, 30 Jun 2025 13:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751289085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqa0KiwTFMzuHZ6USf9y0bqTn9C9j3I5YF/Sjk/rxHQ=;
	b=mQa/LtBczRN2GdSEyB5C/bZSaYvHqw6rDo48SDXrMe4IJAm+XwtnDZRtPW1BJ1XOlp3piW
	reGcVLuCOaF1qHEflPDjM10EM8fA1uxkFEX/K4W8URS7ldMvOa7ggDdqX6iYPj3IswHB6W
	qgnH+dn+y5LyKauVeRbyPaXiW0IhSMsNraCnYM1W2wNi8wffI2N4G25QhOXPj+4/MRlw3h
	Hl4wKanJp8v0LkJlGxk+uDDdsBZgV4GA2ptM16gFbycB/0iM5JsnOitAsKYQRSQBjK8JOe
	n2EtaBEyQpH6Fu1Jk5sgJCrzlNItJ1eQ95ecKMazCh3CAfCFYBPcDNAYA70gew==
Date: Mon, 30 Jun 2025 15:11:22 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Kamil =?UTF-8?B?SG9yw6Fr?= - 2N <kamilh@axis.com>
Cc: <florian.fainelli@broadcom.com>,
 <bcm-kernel-feedback-list@broadcom.com>, <andrew@lunn.ch>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <f.fainelli@gmail.com>, <robh@kernel.org>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net v3 1/4] net: phy: MII-Lite PHY interface mode
Message-ID: <20250630151122.4bbe2725@fedora.home>
In-Reply-To: <20250630113033.978455-2-kamilh@axis.com>
References: <20250630113033.978455-1-kamilh@axis.com>
	<20250630113033.978455-2-kamilh@axis.com>
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
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Kamil,

On Mon, 30 Jun 2025 13:30:30 +0200
Kamil Hor=C3=A1k - 2N <kamilh@axis.com> wrote:

> Some Broadcom PHYs are capable to operate in simplified MII mode,
> without TXER, RXER, CRS and COL signals as defined for the MII.
> The MII-Lite mode can be used on most Ethernet controllers with full
> MII interface by just leaving the input signals (RXER, CRS, COL)
> inactive. The absence of COL signal makes half-duplex link modes
> impossible but does not interfere with BroadR-Reach link modes on
> Broadcom PHYs, because they are all full-duplex only.
>=20
> Add MII-Lite interface mode, especially for Broadcom two-wire PHYs.
>=20
> Signed-off-by: Kamil Hor=C3=A1k - 2N <kamilh@axis.com>

I'm OK with that :)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

