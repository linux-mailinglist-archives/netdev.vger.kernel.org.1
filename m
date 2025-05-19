Return-Path: <netdev+bounces-191440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E783ABB7C8
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E869161B28
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F212E26657D;
	Mon, 19 May 2025 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZOZS/kBQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FD21FF1AD;
	Mon, 19 May 2025 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644420; cv=none; b=HMMPwA4yxR4cS5eoq2gsJbfqdyLbiR/zdeIh3H/tomuGaL3liFyP45iKPwbQHZ+K2Mik/zHrtzdSCEDgERAyLaS9nhoKZNXKfUkwI4CArXSz8UYZISljSIgabbgYhzl77AfJmIeXBJy2t1E7v4Rkb0/p3sRYSuk5Eh9+p83OTy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644420; c=relaxed/simple;
	bh=RMIb+gBLZ2tOwAf1C1veCR9fa0AbGZDVyWMqE7pxa+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uu79wC8pGrifAWUIUjuQQgRmpxC5V9+keT4ALlM8c4U4m26KHo1ilC80A+57w1k6k902MubG7GAziK16Nhm+5EpTe5HsFTU6WLcyubIeA/EM6RTgqCTovdIH40Fy9CIw7lk+YdPl5O59cuA/8TTUJ/hx+rhpA17KcC2ORO6yhZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZOZS/kBQ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3AABF43280;
	Mon, 19 May 2025 08:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747644410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMIb+gBLZ2tOwAf1C1veCR9fa0AbGZDVyWMqE7pxa+g=;
	b=ZOZS/kBQa0JKqrdwnfOeX3ZuEawpgYoyVJWNcImNj4fWFZ5tH2ZN4Qr3ol+dgSUZGWrLta
	2neBOBoZOTdrn630DDg/RqhAqijxylmTF/2R3XZ+KPlx7hlS8nU6EPtMZCAQA5ssXGnnCo
	vL9Fd+ZoBMAjsr6i9KIvfvCYhEarefgApLvJO67cAGmtbnN5WiW5mfw816aiELLQ+MEVP/
	fgfAZO7UqcrcMirBRa8oahvgvHD2taycr0J0Mb3rmx2orxtljj4rscdQDKGV6+/8jPYITc
	9n/MEmqTgo21BDL47ZkebPuE2BJq8Ikq9W9aIh+uDlGu0JF5vy2BPAOJAURPxg==
Date: Mon, 19 May 2025 10:46:47 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Piotr Kubik <piotr.kubik@adtran.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: pse-pd: Add bindings
 for Si3474 PSE controller
Message-ID: <20250519104647.19b15318@kmaincent-XPS-13-7390>
In-Reply-To: <ebe9a9f5-db9c-4b82-a5e9-3b108a0c6338@adtran.com>
References: <f975f23e-84a7-48e6-a2b2-18ceb9148675@adtran.com>
	<ebe9a9f5-db9c-4b82-a5e9-3b108a0c6338@adtran.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepphhiohhtrhdrkhhusghikhesrgguthhrrghnrdgtohhmpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvt
 hdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Fri, 16 May 2025 13:07:05 +0000
Piotr Kubik <piotr.kubik@adtran.com> wrote:

> From: Piotr Kubik <piotr.kubik@adtran.com>
>=20
> Add the Si3474 I2C Power Sourcing Equipment controller device tree
> bindings documentation.
>=20
> Signed-off-by: Piotr Kubik <piotr.kubik@adtran.com>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

