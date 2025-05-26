Return-Path: <netdev+bounces-193454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6520BAC41AB
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 16:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BCD3B919D
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A1020FAA4;
	Mon, 26 May 2025 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BELkQeUY"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1705B1EF36C;
	Mon, 26 May 2025 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748270576; cv=none; b=KrSWGgTIXjkkvyiELVtrKLWRQqvkrvd5HooGruRfF+yt4vrizNkgRDBoaUKv7/A24ul4QZcDckZO3Z2xcwpEq8w512VGEdyke45RIAb37l9uHf7nWmHq0u7rez0WrHpWw9HICrvxZ5nj0076DTt9HV6YTbj2ZrKW6VlrDFQwj6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748270576; c=relaxed/simple;
	bh=2re7boeytqH1ze4jSfdyO/nDEwx8RWmbmO83cuM5XmQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=rAhqFvF/v4KoirZVjfksnfdmNeLkL3bULOWi0qghnkz+UkhVMUk85fvRFUC1+w6nOQSFR2vMG+3FGye9wlKKXfYcLpv2tyyFj5tFbGsEYF1pncahvrbK25EEQDGp+UOLRi0d0lN9Ox6YyZjJqo6FW8pzsziexBcz+Y5uglPlvwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BELkQeUY; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 01A2F439AC;
	Mon, 26 May 2025 14:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748270565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbr5t4PGFq3eJGZHk+DUNUJrzlxkWy9snikx9mhwYS0=;
	b=BELkQeUY7THmMuVRkP+N4HdC1Lr5zPHIYYHtrR0qFZLRS8sz5Y13t9DjJqM4NG36gR9kQI
	hCPQ5ualzVOFms+l8O2joDdvzoKzbAyGqrOpi1vPmgQF7/FfHfOVoD3L5F9SLMZoVvOrnz
	zTSf/qZAuqbFXMm1ydNIwOPZaqFrcmhQO30IZCcve/hH8klVakvpqsQ3ItKUYaEbe63WYy
	lHNeo3ru3Bpqmk9Bc0Pug8tuoZiEU9BJZEDnUbhq19eD2XAGjGhb7KC3fJH7wTB5lLI0tK
	3zJwjfkiw0l6JLk+vLi12Xhb9stwbw5+HJi0V5vp0C5EC9/o9p1sfTwkHsG4IQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 May 2025 16:42:42 +0200
Message-Id: <DA666WVCP2OB.300LVHEGH5V4Y@bootlin.com>
Subject: Re: [PATCH] net: stmmac: add explicit check and error on invalid
 PTP clock rate
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Yanteng Si" <si.yanteng@linux.dev>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Jose Abreu" <joabreu@synopsys.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, "Richard Cochran"
 <richardcochran@gmail.com>
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250523-stmmac_tstamp_div-v1-1-bca8a5a3a477@bootlin.com>
 <8f1928e5-472e-4140-875c-6b5743be8fd3@linux.dev>
In-Reply-To: <8f1928e5-472e-4140-875c-6b5743be8fd3@linux.dev>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujeejleculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuhffvvefofhgjsehtqhertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptedugfevhfevueeggedutefhgfevhfeltefgieejjeeijeejveegtdehgeefkefhnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehsihdrhigrnhhtvghngheslhhinhhugidruggvvhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdhtohhrghhuvgesfhhoshhsrdhsthdrtghomhdprhgtphhtthhopehjohgrsghrvghusehshihnohhpshihshdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehlu
 hhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

On Mon May 26, 2025 at 4:22 AM CEST, Yanteng Si wrote:
> =E5=9C=A8 5/23/25 7:46 PM, Alexis Lothor=C3=83=C2=A9 =E5=86=99=E9=81=93:
>> While some platforms implementing dwmac open-code the clk_ptp_rate
>> value, some others dynamically retrieve the value at runtime. If the
>> retrieved value happens to be 0 for any reason, it will eventually
>> propagate up to PTP initialization when bringing up the interface,
>> leading to a divide by 0:

[...]

>  From your description, I cannot determine the scope
> of "some platforms". My point is: if there are only
> a few platforms, can we find a way to handle this in
> the directory of the corresponding platform?

From what I can see, it can affect any platform using the stmmac driver as
the platform driver (except maybe dwmac-qcom-ethqos.c, which enforces an
open-coded clk_ptp_rate after the stmmac_probe_config_dt call that sets
the clk_ptp_rate), if the platform declares a dedicated clk_ptp_ref clock.
So I would rather say that it can affect most of the platforms.

In my case, I have observed the issue with the dwmac-stm32.c driver, on an
STM32MP157a-dk1 platform.

> And there need a Fixes tag.

Ok, I'll add a relevant Fixes tag.

Alexis

>> Signed-off-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>=20
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers=
/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 918d7f2e8ba992208d7d6521a1e9dba01086058f..f68e3ece919cc88d0bf199a3=
94bc7e44b5dee095 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -835,6 +835,11 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *=
priv, u32 systime_flags)
>>   	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
>>   		return -EOPNOTSUPP;
>>  =20
>> +	if (!priv->plat->clk_ptp_rate) {
>> +		netdev_err(priv->dev, "Invalid PTP clock rate");
>> +		return -EINVAL;
>> +	}
>> +
>>   	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
>>   	priv->systime_flags =3D systime_flags;
>>  =20
>>=20
>> ---
>> base-commit: e0e2f78243385e7188a57fcfceb6a19f723f1dff
>> change-id: 20250522-stmmac_tstamp_div-f55112f06029
>>=20
>> Best regards,




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


