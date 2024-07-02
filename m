Return-Path: <netdev+bounces-108463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26155923EA4
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F681C22C5C
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0531AD3EF;
	Tue,  2 Jul 2024 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="sk04YmNk"
X-Original-To: netdev@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B671ACE97;
	Tue,  2 Jul 2024 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926187; cv=none; b=p0pkcj8tUJB4bk85tz/O517y8qv8zGPWRnWWf01H0+JY8/J3FdgXj1o2W6f0TDchMHXjizjXe/Vbag/8ZAu6yTUdIZev+yQg6NOi3azxbN9FZMC1aR7eihJ3lsYkU+mTnKYKJcWXh6SpxI26lbfWMQyXiG/ZBUqQIuwf7QeYilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926187; c=relaxed/simple;
	bh=MDY8ecdXb/NSyqs6WxNmoPqHuIqePwiEKrrY0Kg3tfo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=jO88k13L1ejMRjuu1BzlwQ/gBcaTW6u3t9h2ZekZBpPr60qxPfwC2RZlp2x+XW9xJSCBxaeoytnDuDOSsIL5Khiqw/BIOsEshMUP5SLjaiyaDzryJFT/g4tIzq5URKfQg1MFunmqnvjqlxZNWTx5+NKqjfs8c4WvlZHlHsHp4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=sk04YmNk; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 21DCA1302;
	Tue,  2 Jul 2024 15:16:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1719926182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPtqbnLIuPypIQzyM7UQW85fKEOBMFybQLigjCASTCw=;
	b=sk04YmNkpd3ad4onJCjNhBAzxzT5PU3Moau+nJXonpzbwZJ2p+uPIRkf4/Ply3sLm4DnmQ
	jxj5xD0b4pobyK4BTM2TWo9cuQ8aVcfrkUbmGgtsrZFIE+y7jLDZoiSrteoA1xRM/MTsAB
	9hyTScexreNf9l1jaMR+S19pSdoAVA6UX20dbZWq32bZpt+Fuvw9xTRV7pA0R9bDC5C8VL
	5MdqnMZlaecI/jP3glI+ImkG2qZyCQUUiGGjP04SwW/+CFzFtnD0MKaew6SK5f4sPyrT/6
	aqw85xfTk9LEc+CL1kTDd5A+SA+o8wYwO06FnnQpj3vm6t47hRFbLgH7o2QS7A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jul 2024 15:16:21 +0200
Message-Id: <D2F2Y45Y1LQS.8GN3PG7ZYAPB@walle.cc>
Cc: "Andrew Lunn" <andrew@lunn.ch>, "Heiner Kallweit"
 <hkallweit1@gmail.com>, "Russell King" <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lvc-project@linuxtesting.org>
From: "Michael Walle" <michael@walle.cc>
To: "Aleksandr Mishin" <amishin@t-argos.ru>
Subject: Re: [PATCH net v2] net: phy: mscc-miim: Validate bus frequency
 obtained from Device Tree
X-Mailer: aerc 0.16.0
References: <20240702110650.17563-1-amishin@t-argos.ru>
 <20240702130247.18515-1-amishin@t-argos.ru>
In-Reply-To: <20240702130247.18515-1-amishin@t-argos.ru>

Hi,

Please post a new version of a patch at the earliest after 24 hours,
so reviewers got a chance to reply.

On Tue Jul 2, 2024 at 3:02 PM CEST, Aleksandr Mishin wrote:
> In mscc_miim_clk_set() miim->bus_freq is taken from Device Tree and can
> contain any value in case of any error or broken DT. A value of 214748364=
8
> multiplied by 2 will result in an overflow and division by 0.
>
> Add bus frequency value check to avoid overflow.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: bb2a1934ca01 ("net: phy: mscc-miim: add support to set MDIO bus fr=
equency")
> Suggested-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> v1->v2: Detect overflow event instead of using magic numbers as suggested=
 by Michael
>
>  drivers/net/mdio/mdio-mscc-miim.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/mdio/mdio-mscc-miim.c b/drivers/net/mdio/mdio-ms=
cc-miim.c
> index c29377c85307..b344d0b03d8e 100644
> --- a/drivers/net/mdio/mdio-mscc-miim.c
> +++ b/drivers/net/mdio/mdio-mscc-miim.c
> @@ -254,6 +254,11 @@ static int mscc_miim_clk_set(struct mii_bus *bus)
>  	if (!miim->bus_freq)
>  		return 0;
> =20
> +	if (2 * miim->bus_freq =3D=3D 0) {
> +		dev_err(&bus->dev, "Incorrect bus frequency\n");
> +		return -EINVAL;
> +	}

DRY. Save it in a variable and use it in DIV_ROUND_UP(). Also you
just check for the div-by-zero, but what if the value will overflow
beyond zero? The calculation will be wrong, right?

There's also check_mul_overflow() but not sure that's encouraged in
netdev.

-michael

> +
>  	rate =3D clk_get_rate(miim->clk);
> =20
>  	div =3D DIV_ROUND_UP(rate, 2 * miim->bus_freq) - 1;


