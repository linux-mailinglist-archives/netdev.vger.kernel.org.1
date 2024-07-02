Return-Path: <netdev+bounces-108438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D68A2923D09
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890D51F2184A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F8315B14E;
	Tue,  2 Jul 2024 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="ORaQ7w0G"
X-Original-To: netdev@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3320D15B54B;
	Tue,  2 Jul 2024 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921559; cv=none; b=IglyUETLZuTfWxT/PT9lMCI+1DAV8rDOAOTWkkU3XLaO7w3uqXRbECUHm41H3eGmOkjE6pQnsvvpF1H6uYVuIrrnmfsAzIWQZg+hheTx2o3fh12eSVFwvXayZIjvtlVVBQ9li4d4xeWQkd7m0+D3qF+dgdqGw1ALtdsof+nPF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921559; c=relaxed/simple;
	bh=F++UahbENhm/ZjnaTLj0NSol7yay0twUWoVmOFZhbt4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Vmlr/h9XugSkwsOcVxOhl6qaGaT6ALzuFUVIaqmnmBsdtXwsJ9Sskvyc8zYVwp7GpJr8wKOyAmyo+Ig3q/svMJ4PwbAwIaqba/NMIdMO6WnsWGe9I6TsvGk+dI1k0wDnHFZU/PJwts69nwj2+82JmNDUA3ZWy7CLOZxzeGH11Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=ORaQ7w0G; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 0BB7655AC;
	Tue,  2 Jul 2024 13:59:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1719921548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyglTi9KHysASncK5Oh7S0RPke7ZcqfGxMohvs1cwTk=;
	b=ORaQ7w0G92jN8q9k5pOoJa6IydOKlhfIUZRCY74ZR5FVLG4lS5YV8/PfimWSojKHzsEQu/
	XNb0NC3aW2RUmVnTIxXK43TKi90qj0wfGEywTI+8onZ5yjHvSu81cv2N8ytsBJ08sp3s3r
	gscpcJbWCKA8Ewwxt9nrRvmm06oWxaje7ptX+udTUqqXXnUyGinpWDWaTfwEaGWWSFfKmu
	KWDwb49G9aye5011yEcYz6T9J/a8BrcjhZl4AWAXQZn2UFSOPRVclAgvRjRMpZXH/YEklK
	abeKUY5aN21Z9P/JWM2nvOqwfN8lHFOOM0GVUkvxQzTlbZEq114Bnu04yNV7yA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jul 2024 13:59:07 +0200
Message-Id: <D2F1AZ99RBVF.X9Z84Y6Q61SM@walle.cc>
Subject: Re: [PATCH net] net: phy: mscc-miim: Validate bus frequency
 obtained from Device Tree
Cc: "Andrew Lunn" <andrew@lunn.ch>, "Heiner Kallweit"
 <hkallweit1@gmail.com>, "Russell King" <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lvc-project@linuxtesting.org>
From: "Michael Walle" <michael@walle.cc>
To: "Aleksandr Mishin" <amishin@t-argos.ru>
X-Mailer: aerc 0.16.0
References: <20240702110650.17563-1-amishin@t-argos.ru>
In-Reply-To: <20240702110650.17563-1-amishin@t-argos.ru>

Hi,

On Tue Jul 2, 2024 at 1:06 PM CEST, Aleksandr Mishin wrote:
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
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/net/mdio/mdio-mscc-miim.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/mdio/mdio-mscc-miim.c b/drivers/net/mdio/mdio-ms=
cc-miim.c
> index c29377c85307..6380c22567ea 100644
> --- a/drivers/net/mdio/mdio-mscc-miim.c
> +++ b/drivers/net/mdio/mdio-mscc-miim.c
> @@ -254,6 +254,11 @@ static int mscc_miim_clk_set(struct mii_bus *bus)
>  	if (!miim->bus_freq)
>  		return 0;
> =20
> +	if (miim->bus_freq =3D=3D 2147483648) {

Please avoid magic numbers.

Instead of this, can we reorder the code and detect whether
2*bus_freq will overflow?

-michael

> +		dev_err(&bus->dev, "Incorrect bus frequency\n");
> +		return -EINVAL;
> +	}
> +
>  	rate =3D clk_get_rate(miim->clk);
> =20
>  	div =3D DIV_ROUND_UP(rate, 2 * miim->bus_freq) - 1;


