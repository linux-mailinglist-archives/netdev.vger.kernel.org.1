Return-Path: <netdev+bounces-193908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D8BAC63A6
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 10:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5ED416E005
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EEA2459EA;
	Wed, 28 May 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H0WSSbSh"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354BC244677;
	Wed, 28 May 2025 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419590; cv=none; b=n8bkoO+ZNkoPqeIQyfXcYdVV/cpJB0vUV6J9Rzxq3tlShYKDRj8TVYEG+cDi3ZIYKHTLiHCgnoa0s8OMuL8zV7h4S4883xgFzelzv4V/P0MI1GyvqNgZATdXmv/WX3F4OeqHzGsUMCF6qoPJ6aFDcqIrMQJJI/GVZ3VpC2fAZHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419590; c=relaxed/simple;
	bh=5wzSer57ZtS3RP0AmDkAKyNzrSWEp8TBPzOL/QWmaqg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cteWHXrDJt0NIunbq4XYOzZ0A9teZeUXdcEEjIM6f1x/naTAqheWbAQC+Bd/wyukqBlCVCiQXju6P0Nuq9zJ4uMn/2IM83+SgJN4Z5A7+d+SwGcaYsZAdBxgeiUH6ugqh5FGgBtrA01As8pG6LPQqymRH/QHWamreYSGhP+5IZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H0WSSbSh; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9370A44393;
	Wed, 28 May 2025 08:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748419586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8Snn3M2Xto80GFCTzGDH4eMJtf9SvjbeLQR53HTuGQ=;
	b=H0WSSbShJ0Gz7Vg8g+HKsOFdUBIafPRnGn2jUS3PRcl77WiUdJ9uR25cfFiY7ItPIDyii/
	gppDVRhJ/E+EiQx2GzxL/QxaIylJmxFNR8xsY5x5UqkpWbQfyAgVLQ0jq7JCE95lsooIL4
	QV0kYkFlCSVo0RDy3BGQK0+36/6pMrHGVySCDuQbk1Z8tJPL/YicoKHGZ0oR4fGJF00K9f
	loiiuW0yTVcTH+XXAI14PJROcA3E1HMWlO4t1VV4x4Y9xSu1negVKjX+EFApwCfZuBQoqb
	akMwK1VWuR5S1uEz1ESV/mFcLaOnDptzmhJrUPbOXs8ueYrooE10alPOZDnmyA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 May 2025 10:06:23 +0200
Message-Id: <DA7N0K4FSI14.QARGA1ALU2XV@bootlin.com>
Cc: "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Jose Abreu"
 <joabreu@synopsys.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, "Richard Cochran"
 <richardcochran@gmail.com>, "Phil Reid" <preid@electromag.com.au>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, <netdev@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: stmmac: add explicit check and error on invalid
 PTP clock rate
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Maxime Chevallier" <maxime.chevallier@bootlin.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250527-stmmac_tstamp_div-v2-1-663251b3b542@bootlin.com>
 <20250527183105.7c4bad49@device-24.home>
In-Reply-To: <20250527183105.7c4bad49@device-24.home>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvvdejfeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleekheeihfefheevhfdtgeeuleekheffffffuedvkeekkeduvdeugeeugfeiueeknecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghlvgigrghnughrvgdrthhorhhguhgvsehfohhsshdrshhtrdgtohhmpdhrtghpthhtohepjhhorggsrhgvuhesshihnhhophhshihsrdgtohhmpdhrtghpthhtoheprghnughrvgifo
 dhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

Hey Maxime,

On Tue May 27, 2025 at 6:31 PM CEST, Maxime Chevallier wrote:
> Hi Alexis,
>
> On Tue, 27 May 2025 08:33:44 +0200
> Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> wrote:

[...]

>> +	if (!priv->plat->clk_ptp_rate) {
>> +		netdev_err(priv->dev, "Invalid PTP clock rate");
>> +		return -EINVAL;
>> +	}
>> +
>>  	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
>>  	priv->systime_flags =3D systime_flags;
>
> This may be some nitpick that can be addressed at a later point, but we
> now have a guarantee that when stmmac_ptp_register() gets called,
> priv->ptp_clk_rate is non-zero, right ? If so, we can drop the test in
> said function :
>
> 	if (priv->plat->has_gmac4 && priv->plat->clk_ptp_rate)
> 		priv->plat->cdc_error_adj =3D (2 * NSEC_PER_SEC) / priv->plat->clk_ptp_=
rate;

You are right, my series makes this check a duplicate, I'll remove it.

> There is another spot in the code, like in the EST handling, where we
> divide by priv->plat->ptp_clk_rate :
>
> stmmac_adjust_time(...)
> 	stmmac_est_configure(priv, priv, priv->est,
> 			     priv->plat->clk_ptp_rate)
> 		.est_configure()
> 			ctrl |=3D ((NSEC_PER_SEC / ptp_rate) [...]
>
> Maybe we should fail EST configuration as well if ptp_clk_rate is 0
> (probably in stmmac_tc.c's tc_taprio_configure or in the
> .est_configure). That can be a step for later as well, as I don't know
> if the setup you found this bug on even supports taprio/EST, and setups
> that do didn't seem to encounter the bug yet.

I guess you are right as well, it may not make sense to try to configure
EST if we have a bogus clk_ptp_rate value. est_configure seems to be called
in both tc_taprio_configure and stmmac_adjust_time, so I'll add the check
in est_configure.

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


