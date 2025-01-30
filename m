Return-Path: <netdev+bounces-161605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5ACA22A38
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 10:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476C63A604E
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 09:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DAA1B4152;
	Thu, 30 Jan 2025 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ol4GbfYT"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26951AB53A;
	Thu, 30 Jan 2025 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738229102; cv=none; b=Zq7uNf7P9yLUB6f6utqChHt/ULulhBJwEGpG0JYjqf1nkpornxXAs7RVg2Cxk2uDQgr2+gQRQJnpLsgNmtrMJ+Mq0VeE4c/hQZmFIu17j/Hk8sl+xDHJmSo1Q4U3+vGp1LJGW6e8BllgKOCI9AvB8uwb4y7P/NYsco+qXd4xyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738229102; c=relaxed/simple;
	bh=dGJVJ+aAk0MEZz8wKOpCiujn30vUAukIGzGEc+THQVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJ1UpT5zFuloSZVNMA/b5W4bWh94dSBG86gwHTYyGp8pXrtXUdWNcX5f33fe9vUUB9YxWMo06GVj1AVixuDPdCKHZbKTTZmoui1H7Wk/rGxOM51HmxVz9Y4skJroYqgPX5jpWVNP8FKOILuGi6R+KnJb51XzPhyNPsXfx1gnT3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ol4GbfYT; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7DAB143153;
	Thu, 30 Jan 2025 09:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738229093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGJVJ+aAk0MEZz8wKOpCiujn30vUAukIGzGEc+THQVs=;
	b=ol4GbfYTpGa+TNi5Wbsrvua1p8wnbi74Dhn5CFHdcOW4enrM1J9A48eNkjEDGhH42u0mUw
	PwNwMHbSeZUlrk81FMjx0LiYhoV2LfAYkyYg2Okp9xp9RmigFBGv+3dfA4w3xrazLwepUf
	Cx3uC3LZw1mwb0w4fH/4RXctpqkHpV7DJiFmzfj3kEE34dRDSOmjKsjhXdTkoDLD1wZMBP
	h3ah8jY5RhYSTR/fGml0ApHwUZwZcRlkXCOhYP2mZ8I1bXYG5g2wYYhXuIWxUK2iJzJ518
	vAeG60Ebs21QBm0AKMA6SN9ini09jkGTjVWWKnAEOUzMHrVjLwlW2ksJzEHwbA==
Date: Thu, 30 Jan 2025 10:24:51 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/3] net: ethtool: tsconfig: Fix ts filters and
 types enums size check
Message-ID: <20250130102451.46a4b247@kmaincent-XPS-13-7390>
In-Reply-To: <20250129164508.22351915@kernel.org>
References: <20250128-fix_tsconfig-v1-0-87adcdc4e394@bootlin.com>
	<20250128-fix_tsconfig-v1-2-87adcdc4e394@bootlin.com>
	<20250129164508.22351915@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehgeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrt
 ghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 29 Jan 2025 16:45:08 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 28 Jan 2025 16:35:47 +0100 Kory Maincent wrote:
> > Fix the size check for the hwtstamp_tx_types and hwtstamp_rx_filters
> > enumerations. =20
>=20
> This is just a code cleanup, the constants are way smaller than 32
> today. The assert being too restrictive makes no functional difference.

That's right, it was mainly for consistency with the other assert. And to a=
void
possible future mistake but indeed reaching 32 bit is not expected soon. Sh=
ould
I remove the patch as it is not a functional issue?

> > Align this check with the approach used in tsinfo for
> > consistency and correctness. =20
>=20
> First-principles based explanation of why 32 is the correct value would
> be much better than just alignment. Otherwise reviewer has to figure out
> whether we should be changing from >=3D to > or vice versa...

Ack, I will if I keep the patch.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

