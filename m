Return-Path: <netdev+bounces-190407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E027AB6BDA
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7FBC16AECA
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83833279347;
	Wed, 14 May 2025 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hU3dXRFQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCC425C71A;
	Wed, 14 May 2025 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227241; cv=none; b=esDB1x5a8Ik3kpdsyjVw7WVDTftxymYE4w0hpkiyPC9maWR3byd0CH+ATV8c8bUsP+Ofe2KwFHpwHZUE14nyfw54Y73ZzN+cZVq5XQgtaWRoqTmSzKHs8a1+H4+Bc/lzbcYet1GMYBgV2WR06RvHoXe8VSCwnH0lnsRHFN1xEdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227241; c=relaxed/simple;
	bh=scugkR344tI8V7Z0hxaim6O4g7gQTV4zdpmzPnDsWhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwmR6RCJSxS/HHqiftF5PgxgOFuaTfEAwbY8SEGzhP4m8+tFvcj+Y7B1CKNFHzOsp5D/8g+WSsD5+DjFe2Do7Jk+Puz3I1X2iGXBYeqyjKa63K5f9nDx/U05Bejy9KflfV688u2ctH7f/Sj36YpDRVMtjlA00oO99KznzjdKv0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hU3dXRFQ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E16E1FD4C;
	Wed, 14 May 2025 12:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747227237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPtptJ2HNoiU8PMKYqOrssaWS6cta88HVQHAl0Pn9aw=;
	b=hU3dXRFQTHD3aiFxk4goUMdnyTgKFFjSv9ac6VTBUkjJeycYyAjqKxa5YvB8gOv5WvIjDX
	Ym5o2RpHZ88ERll2TbB5805wvy9HaSrbRMdxGSMLb8s6cSSE60jQ4nJkmMOvLrPeeiRKPT
	Cy3bnnw21GLJfJPSPk7VP8egScePCfEaLbX8I6iR+x8tdHHrRreHBoi/lSGivN5Yyd6LWP
	F1X/NmL/+/IfeLEODIHWH6uogJq4QX+8G8L6ZhwQQNZbbQ6pVLDAtMUh+e09J++n9DGitw
	wxA3XRsE/wl7rl8EO5tNIOFKAzjgqzMRDCEaeH+Wy0Nqjvp0sVyioBpGBz9kbw==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net-next 0/3] net: phy: dp83869: Support 1Gbps fiber SFP modules
Date: Wed, 14 May 2025 14:53:54 +0200
Message-ID: <1877501.VLH7GnMWUR@fw-rgant>
In-Reply-To:
 <20250514142019.56372b4e@2a02-8440-d105-dfa7-916a-7e1b-fec1-3a90.rev.sfr.net>
References:
 <20250514-dp83869-1000basex-v1-0-1bdb3c9c3d63@bootlin.com>
 <20250514142019.56372b4e@2a02-8440-d105-dfa7-916a-7e1b-fec1-3a90.rev.sfr.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8620414.NyiUUSuA9g";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejtdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhggtgesghdtreertddtjeenucfhrhhomheptfhomhgrihhnucfirghnthhoihhsuceorhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeetveeileegkeetvefgtdegffdviefgvdevkefhgfetieffvddvkedujeefvdfgtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehffidqrhhgrghnthdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigr
 dhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: romain.gantois@bootlin.com

--nextPart8620414.NyiUUSuA9g
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Wed, 14 May 2025 14:53:54 +0200
Message-ID: <1877501.VLH7GnMWUR@fw-rgant>
MIME-Version: 1.0

Hi Maxime,

On Wednesday, 14 May 2025 14:20:19 CEST Maxime Chevallier wrote:
> Hi Romain,
> 
> On Wed, 14 May 2025 09:49:56 +0200
> 
> Romain Gantois <romain.gantois@bootlin.com> wrote:
> > Hello everyone,
> > 
> > This is version one of my series which adds support for downstream
> > 1000Base-X SFP modules in the DP83869 PHY driver. It depends on the
> > following series from Maxime Chevallier, which introduces an ethernet port
> > representation and simplifies SFP support in PHY drivers:
> > 
> > https://lore.kernel.org/all/20250507135331.76021-1-maxime.chevallier@bootl
> > in.com/
> Thanks a lot for giving this work a shot ! Maybe a small nit, but as
> the dependency isn't merged yet, you should mark this series as RFC, as
> it will fail on the autobuilders.

Ah I see, I'll fix that in v2 then.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart8620414.NyiUUSuA9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEYFZBShRwOvLlRRy+3R9U/FLj284FAmgkkmIACgkQ3R9U/FLj
285jKw/+PKpg4jg8INKJQ0Mp53ofOft5er9GeMS8E7xBhcUHN2FugIo9xajYkIE8
3TL0+QvABBCpu6VhDoP3UZ+k5joEcpOU4WgS0G7hzrxK0shjSZsOK8DM+xZ1Trql
wlprLYM0oGu7tbk0KlBLPTZ2N8dNC6UAgnscykiBRDde+IbGmEELMmpJ3qr0Drz9
NouBsErwEBw933FwuTnC7PmUfkLEs0XR0wZWuvXDCsiBah1L/6Vi00/AiYr/Dcmk
jvR4x4E3oY8ovSqHmNK3G49yoxwyOXez6HARuixIBqx2M0wy6u4W7ce7GSqo5F0i
wsDqEI1WRqjazHR11Zu00ymjXpJJ7tc3S8whH08ox/VjiG6Djea8LxSJQANx9FvG
RQoLpszYDzt1EheQ4UXEDAIk9Mpxo8O/tnt5da7GwFG6uNoLG4aGG9VD9ayvb/df
B1/MQNvXtrsr2zOuA5VYLROynqATx+f6QWwVQ5O27+f2V3ChSI7tPUqoreQXUXpe
18DOS1NTqEiIGbdkvsM+Q8zAgYGDb3YIaXZD9o4kb3wdk/HR3eyzL1d/SL8H8chW
o/5VQhaWue/cVWhVu0MyoRLfWHQEGSu6zGr4oD1a0E1oyt4TQcy02STyulqidoFF
/auswQ0rkBI1ijzFNwiPCNKzjj8zXPTQRqkJ0dtaoXxH739S0hg=
=4Pp+
-----END PGP SIGNATURE-----

--nextPart8620414.NyiUUSuA9g--




