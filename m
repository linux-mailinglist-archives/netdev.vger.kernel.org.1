Return-Path: <netdev+bounces-155168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BDAA0156F
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 16:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7673A242C
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 15:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464621C8FBA;
	Sat,  4 Jan 2025 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S6PCl1Tl"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B238C1C5F0E;
	Sat,  4 Jan 2025 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736003798; cv=none; b=inPBEV0bWUzSl+IbG70c1liKpAwKRM9a6zj2ujDxsgtl+GvvQAthWILoGxAZ69VPjR+SqFoprIEf2p0fBrJNiE6xgGB6aPmrly5Jf8n+IHiHoU3tRODGfRcrTQzMiPprhSeruS50sbbc/CVAYtqivqTzgM1F62RjywozPd9/jo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736003798; c=relaxed/simple;
	bh=oPs4p93Ib0B5Me2dou5wIMwOuuoqXTZbEcFHYaPEolE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kP7rfYMpqfFDz8lTnFIau/75kXUstZCCIARA7Az61AvYCzsIQaHlkJexIZmUMLD7EKM06L+fUvMqhzyMrD/5YylYVoq3lCJaJ1ORPcw9oAISnBzHmxOctrXzRqEOQQgiKu7UbZRr/TevksIdzjBkhUnj5WK7pF2bMfrX9NZRX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S6PCl1Tl; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C06B9E0004;
	Sat,  4 Jan 2025 15:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736003787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPs4p93Ib0B5Me2dou5wIMwOuuoqXTZbEcFHYaPEolE=;
	b=S6PCl1TlMQkMyGHj26drjlCWfU9X01E4aogd/OQzkjb+JfB66w0rUNLFWQ4LoENuvMaXfS
	XbA6hdb0F25IYRmn9QyPD0qHSOwtIV/DxY8YOAkeatuN4RA/JRz501DQ7W6XUifGmqrf/w
	vMesHaOi32WG4qg2EKLgHbYVvSOnHkAtOMJVv4wrdcFwlsg9P7RFIWv5smUCKsJB6Ssxn0
	XjBk2zV14z/5re48BBGlQJgRBUw30o8hKQTOfGssfU8l7AbgNsfig+/FP59PLtTJBe4YpL
	79yGNjD++kWZTx6hLqRglf+dTLGXLXp+64IZ4/ZIYho/eV5Je7sZ3ZAFeH9hXg==
Date: Sat, 4 Jan 2025 16:16:22 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 devicetree@vger.kernel.org, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next v4 00/27] Add support for PSE budget evaluation
 strategy
Message-ID: <20250104161622.7b82dfdf@kmaincent-XPS-13-7390>
In-Reply-To: <Z3kdXIbKDLF1nP3f@pengutronix.de>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
	<Z3kdXIbKDLF1nP3f@pengutronix.de>
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
X-GND-Sasl: kory.maincent@bootlin.com

On Sat, 4 Jan 2025 12:37:00 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi Kory,
>=20
> please, split this patch set. Some of them can be already taken. The
> upper limit for the patch set is 15 patches.

Ack, I will!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

