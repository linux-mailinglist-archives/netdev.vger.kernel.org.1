Return-Path: <netdev+bounces-170610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F2CA494D4
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BEC3B430D
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 09:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72FE2561B7;
	Fri, 28 Feb 2025 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A6B/FC7u"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAFE1EDA2F;
	Fri, 28 Feb 2025 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734711; cv=none; b=k884Mm575ENbcgY7boovo6ePy1UOgkIUzNwfKeUUdTgGF67CXLIcZXvfoQhag7o30CO2JdyJltJkgi6aSw7xiEu6rOrZk6gMWhssA/2DVwhN84HPIqrJXP9Z/9q0uEVrfCE2XhFbcD3tjY03LDXxEz4jQ7QV9BoNWDNYkUefEbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734711; c=relaxed/simple;
	bh=WBcFDJByMQMtWT0RXtUsFwuOqIlRxlxgPiBO43pa9/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CmNAJTzkTHRHPtvz0/PqES8+VpNgOSnFwxFJfGhyFTLcKxdDB0jSeIyjRh1jPu1mcsmygHvuH+/qD+7LCreGINtRHd9LR3YTYSIT/jWCRYU1X5RUUxra0V3RwLWgyKXYcGff5fLE2KLR1MgaXGidDjuE5x2vSPi7BJpjZkQBG0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A6B/FC7u; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 84D2E443DF;
	Fri, 28 Feb 2025 09:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740734706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBcFDJByMQMtWT0RXtUsFwuOqIlRxlxgPiBO43pa9/0=;
	b=A6B/FC7uNF+Sw7Y2G+M67FUaGF0x3XjICwzA7R9UX8puFZ5LIVhq55UrPsS3svQJYZGCMQ
	xGcMGr2ltvJTl8Q8vFcypdQcjJKjRXIK5ySUhT/3mLo9XRUxpoNfz74rtMvfrHFnNMbHa0
	+HloQwb+6fHM/hVmrugTqAINk+0pAQ4g/oup7T1E9ymwaz0uybJ1eFh7N227LdM6oFISsg
	KRcZ+MTVCae0ZUhBF7rwwLUTEoS0rUXS3mpjGtBNe3GUz6SqMep+glBJzQRmkRGRCJSZc5
	NWw5WHueSe6hatKuP2TZ//fEy57hUBHO9EfGDIOcjtmCas2ojZ2yFdG+c9K+mQ==
Date: Fri, 28 Feb 2025 10:25:03 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Kyle Hendry <kylehendrydev@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, noltari@gmail.com, jonas.gorski@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] net: phy: bcm63xx: add support for BCM63268 GPHY
Message-ID: <20250228102503.4a3014c2@kmaincent-XPS-13-7390>
In-Reply-To: <20250228002722.5619-1-kylehendrydev@gmail.com>
References: <20250228002722.5619-1-kylehendrydev@gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehkhihlvghhvghnughrhiguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtp
 hhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 27 Feb 2025 16:27:14 -0800
Kyle Hendry <kylehendrydev@gmail.com> wrote:

> Some BCM63268 bootloaders do not enable the internal PHYs by default.
> This patch series adds a phy driver to set the registers required=20
> for the gigabit PHY to work.=20

These are no fixes, you should add net-next prefix in your series.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

