Return-Path: <netdev+bounces-171341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E14AA4C969
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1B23B25B1
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E40D22759C;
	Mon,  3 Mar 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J4SGNnw2"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91EB214A80;
	Mon,  3 Mar 2025 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021410; cv=none; b=tKKiPgAJvmz75py+GMTCrRH22PMAMnURF6pdlXVH4JgZeemCrfeX5CnNnMecIxNUR7TvJwawYDzKh6UAimD3UnvY9D9fD8xqPXXTm5psBk1w4I61b7zwfgTVy6qbXVQ/HVvvQvj8/1v4MxkCz2Z46jwGozy5xdR4J6VMY1gLPJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021410; c=relaxed/simple;
	bh=Q8x9V52Wo07ayFgUjbDQy5gks+1d8BUCRccch+DGgHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgs8BqMPwqZcF6s+ToYk3FctIrJ/NkqevczGvCWqcVz7i4yNvPwmqyTo6fUV4V4OEdl1F1hBznEsLWU016iDGlesLLRCtM4EuCNhYDILwC1EXQ91YwpqnhrpvZWByamr34rtmkvc/rSuV16yLqcJ47SWK1VYx2ScXaugT0CBlq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J4SGNnw2; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3511144414;
	Mon,  3 Mar 2025 17:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741021406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YIhKVawvCB2Aqegf19Ipa1qkc8vmMbU4kU/Udk1Ums=;
	b=J4SGNnw2hL8GLotOrJNM0lbYBpcpXS/bs7Kvr8hZDymHa7TZJ3ifXuKx5XVLzEwoQlVVCh
	5vJvq54ZtBMsh8fz6pigCr0XkgTuiuwtjaZKIviRKgHPZ64ungq6FNszJft688orkFTL0K
	dMC7GUKWgROnTIVAjzvFimWMc2b8N3BaUghCWsZ+vPxQC5kYdE6sFMZhXX4/i+CZgm1rS2
	hZiErf1iB8WOhzo2sJO6I5Hb2ft5PauOiaIQ9kvy6NgK/EkPl0ETXnPaF1YFgZTn0M0oFd
	Uvpt7P5V/ulKbRVXwmueZWFfvAG+EineFjX5iHF3a6W4huI9zZ0lXGMrqoKtpw==
Date: Mon, 3 Mar 2025 18:03:23 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: <javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
 <horms@kernel.org>, <jacob.e.keller@intel.com>, <richardcochran@gmail.com>,
 <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
 <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH net-next v3 1/2] net: ti: icss-iep: Add pwidth
 configuration for perout signal
Message-ID: <20250303180323.1d9b51de@kmaincent-XPS-13-7390>
In-Reply-To: <20250303135124.632845-2-m-malladi@ti.com>
References: <20250303135124.632845-1-m-malladi@ti.com>
	<20250303135124.632845-2-m-malladi@ti.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopehmqdhmrghllhgrughisehtihdrtghomhdprhgtphhtthhopehjrghvihgvrhdrtggrrhhrrghstghordgtrhhuiiesghhmrghilhdrtghomhdprhgtphhtthhopeguihhoghhordhivhhosehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtohepjhgrtghosgdrvgdrkhgvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtoheprhhitghhrghruggtohgthhhrrghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 3 Mar 2025 19:21:23 +0530
Meghana Malladi <m-malladi@ti.com> wrote:

> icss_iep_perout_enable_hw() is a common function for generating
> both pps and perout signals. When enabling pps, the application needs
> to only pass enable/disable argument, whereas for perout it supports
> different flags to configure the signal.
>=20
> But icss_iep_perout_enable_hw() function is missing to hook the
> configuration params passed by the app, causing perout to behave
> same a pps (except being able to configure the period). As duty cycle
> is also one feature which can configured for perout, incorporate this
> in the function to get the expected signal.

...

> IEP_SYNC_CTRL_SYNC_EN); @@ -474,7 +484,38 @@ static int
> icss_iep_perout_enable_hw(struct icss_iep *iep, static int
> icss_iep_perout_enable(struct icss_iep *iep, struct ptp_perout_request *r=
eq,
> int on) {
> -	return -EOPNOTSUPP;
> +	int ret =3D 0;
> +
> +	mutex_lock(&iep->ptp_clk_mutex);
> +
> +	/* Reject requests with unsupported flags */
> +	if (req->flags & ~PTP_PEROUT_DUTY_CYCLE) {
> +		ret =3D -EOPNOTSUPP;
> +		goto exit;
> +	}

The flags check does not need to be in the mutex lock.
With this change:
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

> +	if (iep->pps_enabled) {
> +		ret =3D -EBUSY;
> +		goto exit;
> +	}
> +
> +	if (iep->perout_enabled =3D=3D !!on)
> +		goto exit;
> +
> +	/* Set default "on" time (1ms) for the signal if not passed by the
> app */
> +	if (!(req->flags & PTP_PEROUT_DUTY_CYCLE)) {
> +		req->on.sec =3D 0;
> +		req->on.nsec =3D NSEC_PER_MSEC;
> +	}
> +
> +	ret =3D icss_iep_perout_enable_hw(iep, req, on);
> +	if (!ret)
> +		iep->perout_enabled =3D !!on;
> +
> +exit:
> +	mutex_unlock(&iep->ptp_clk_mutex);
> +
> +	return ret;
>  }
> =20
>  static void icss_iep_cap_cmp_work(struct work_struct *work)
> @@ -553,6 +594,8 @@ static int icss_iep_pps_enable(struct icss_iep *iep, =
int
> on) rq.perout.period.nsec =3D 0;
>  		rq.perout.start.sec =3D ts.tv_sec + 2;
>  		rq.perout.start.nsec =3D 0;
> +		rq.perout.on.sec =3D 0;
> +		rq.perout.on.nsec =3D NSEC_PER_MSEC;
>  		ret =3D icss_iep_perout_enable_hw(iep, &rq.perout, on);
>  	} else {
>  		ret =3D icss_iep_perout_enable_hw(iep, &rq.perout, on);



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

