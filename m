Return-Path: <netdev+bounces-101717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044888FFDAC
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FF4288686
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9BA15A876;
	Fri,  7 Jun 2024 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o+yaSPp5"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DEB155324;
	Fri,  7 Jun 2024 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717747046; cv=none; b=PdKZtC5K1r3eI3pyfdUOo2ZyR+hLf/d7qC46PZgobAXkKivVbiqgS3c2vs089UyZXRtojCN9BCsVIohEJQrmjQt7sZkTEf+0KcVNvPWY1YWib+77NAZPPepQDCkWG0E1rd4EyruRtSFJhMObEKn2YFtS7uY++0DGx4q9f6/sEyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717747046; c=relaxed/simple;
	bh=/rVVT93v1VgA2sZlK0W8IMOluwnn164CpDFtGBdE3ww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imnLuh3zuOOumEe5iX8STvKdoiQChmYXHrfLNmlSkTNN3v2d8iubYR88IJk/Vx/wDLhDrrlRpx3jM9cQ1wslWg9N0xn4InlsKCv7Bp5BuoKOrhXSgEdUkJ2mOLpS8YckZlhAxjHsXCL8fNj43jW+Y8q5aoKpoZ9xcFc2XKN1YhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o+yaSPp5; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7049820002;
	Fri,  7 Jun 2024 07:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717747036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0iQZF+fCUGILMJfsI2XW5jxgsXGqak3K4quThjAXuY=;
	b=o+yaSPp5GSiAk5XrXWOc4/wuaulu7pPFfkMsGzE+Fe8I7uASyQpXwPs0wXZ3Y4KBzUWUfJ
	qaykxdmuLRick47EMukQ0UXJH/z/b1GiWSYAX0IcG0/LYfvH7lJA3Ij6XEsiN5TfIc0iKc
	izgcx9i0V2hqRkd02JGaClSNNqZzzh+pZJ/vorUdinu5dwzCJ7GuUFMyokDPqDVCy+OkuP
	mOOlZy2uDqvaK1AXlj5YC65KgXJyvxCdmaGEmcogOekUcu/sm1iTfNSWzPZwOTTrvm962O
	5vDY1oaY7zRq+HxBsweJgseSySdzx+O3gud8aLImXDiKAoLQap3l06pn122m1w==
Date: Fri, 7 Jun 2024 09:57:12 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Alexandra Winter
 <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v14 00/14] net: Make timestamping selectable
Message-ID: <20240607095712.386c2b8c@kmaincent-XPS-13-7390>
In-Reply-To: <eb5da634b85993977f086ee72c2a1056ea0f6bfc.camel@redhat.com>
References: <20240604-feature_ptp_netnext-v14-0-77b6f6efea40@bootlin.com>
	<eb5da634b85993977f086ee72c2a1056ea0f6bfc.camel@redhat.com>
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

Hello Paolo,

On Thu, 06 Jun 2024 15:28:28 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On Tue, 2024-06-04 at 12:39 +0200, Kory Maincent wrote:
>  [...] =20
>=20
> I'm sorry to ask the question this late, but are there any plan to
> introduce self-tests, eventually in a follow-up patch/series?

There was no plan about it but it could change if it is needed.
rxtimestamp.sh and txtimestammp.sh should still work. I will verify that ne=
xt
week.
Before writing tests the next patch series will be in ethtool.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

