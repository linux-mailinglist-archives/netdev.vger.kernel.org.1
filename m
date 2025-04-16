Return-Path: <netdev+bounces-183282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2245A8B926
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BEC189A9EC
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327972914;
	Wed, 16 Apr 2025 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TblbM3nU"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6B81C27;
	Wed, 16 Apr 2025 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806773; cv=none; b=Dl2pwStq7QF/i31cAUlxy55VJmdmGKuTtybrQURM4cnEjbQQSk3pl0S2ej3tZgCAfBCtEdntTOSjJYKDaCUiUy8RgMkR7m4Tcjqph5wRgIE3I84rYYjwARftVVAV5B6VHHiI0T2i03KnCoE5Sn4MgHFq8R+XStXPxfGvPfP/7GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806773; c=relaxed/simple;
	bh=JXDUrWe6C6Wi7c1BLnRrBpSEUxUExiEHYNdRjhOLyYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2g3doeL9rmfAXUKfjYhEZqcKRPVRCdasm7llhT4NkrsvTLMg74ERBkteqgzr5tmmGm7qn/bHdBF/iZ4SM0D8YNfdGG41M5FkQ3eJXbK7Y1EO/c9eP7b2Q+40fYrzdlqOHtIWfje+DUAZUTIFhRvx0fj1Sut2zuCoAmb8agjj1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TblbM3nU; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA4C84384B;
	Wed, 16 Apr 2025 12:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744806763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXDUrWe6C6Wi7c1BLnRrBpSEUxUExiEHYNdRjhOLyYs=;
	b=TblbM3nUsgBxfYT/rGq/Izxvi6ro4NRDxEGvcDzs08TxhIa2+BEklnkTrBQRE7Smp5tO+P
	T8GytToun3CVArGQ/7yiP8+FAsYsB1iFqbBebTUGczu7Awfssie5TWoaQOdcuEW86dEtaR
	y8Ve9CUkaKYl0OEJmmavbqPMJGWPuXoER0DiGlSvARhIx9IiPiC/34CoiWYtYtn70l/dyG
	PfSrEzdAIao31KhcAGxuVNojaIjqGjFv5bicsRdw7YP9SX7vQtBltthqLZeaUw9jMncgfp
	FT3L7IddfXF3Z0yS94rJGkmdbRMU1eACX3pi/eoHRgatZH1mb3tmc2GeZjCsYQ==
Date: Wed, 16 Apr 2025 14:32:41 +0200
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
Subject: Re: [PATCH 0/2] Add Si3474 PSE controller driver
Message-ID: <20250416143241.73418fc6@kmaincent-XPS-13-7390>
In-Reply-To: <a92be603-7ad4-4dd3-b083-548658a4448a@adtran.com>
References: <a92be603-7ad4-4dd3-b083-548658a4448a@adtran.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeifeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepphhiohhtrhdrkhhusghikhesrgguthhrrghnrdgtohhmpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvt
 hdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 16 Apr 2025 10:47:12 +0000
Piotr Kubik <piotr.kubik@adtran.com> wrote:

> From: Piotr Kubik <piotr.kubik@adtran.com>
>=20
> These patch series provide support for Skyworks Si3474 I2C Power
> Sourcing Equipment controller.
>=20
> Based on the TPS23881 driver code.
>=20
> Supported features of Si3474:
> - get port status,
> - get port power,
> - get port voltage,
> - enable/disable port power

Nice to see a new PSE driver!

In net subsystem we add the "net-next" prefix to the subject when it is not=
 a
fix. Please see
https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/process/mai=
ntainer-netdev.rst#L61

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

