Return-Path: <netdev+bounces-149979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4969E85ED
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 16:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FD8163AD7
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 15:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAD915350B;
	Sun,  8 Dec 2024 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Dn8KWRVs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07D414F9FF;
	Sun,  8 Dec 2024 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733671615; cv=none; b=s7LR1+aC6bjVHnyrTak09zxFBZt+94zBuYEctuh3kPDT3Jkz8AiAz6+pW3kKMCRiWpKZKKLNBIjP917B/MYabsiTjraPfsuAu1VOkH2Y3bKM9b5O9bPohzEtql4kPl1Ekokna5Na0mkubYEtG7A2r73H8X477Oz33wcC6zRDlwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733671615; c=relaxed/simple;
	bh=AZoi0XZVF4cYMk5HBsVPYwuVPV/Ylxm5DdyCSLCNVVs=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=KxpE25ZRzDbR5OpvGN0teypBaNg4aDeJrV8RoBJaYPvbm4Ev4DwcYbu9QsDx6hslxtvgnk1Ph+Z/Z50o8biTN8/kQJnWgOoslDSa6Ey3s6KbB4mWB0yq/YcTOsyJYzR7d9peWrTSONBwjAuFR2hsitAGWnIsouuBe7fOgNbMvvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Dn8KWRVs; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id KJBGtwSuVqhuoKJBGtLLZl; Sun, 08 Dec 2024 16:26:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733671610;
	bh=VVlq2KdrmbfOW86CMGQBu5vttyCc5rsOJolnA5rzBIk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=Dn8KWRVsKQrdEj1cVfH9KGP3vdTtQX3bBcFfNlISnT2UtzDMpJ1PNPUBZRXixCQn+
	 uJ6bIcL1s3iHJMSrpeOceQnsSc/jUwI0lGEG19YMIF5uumgfP0l2uLDh9trY/JYrfR
	 FOim+Qk//jZBt/0TI2guKmq17F97VVeQNsq8Hmhc+YIaofT+qHTgaeIVV7j9p6aHfp
	 4ITSpVrTgHUi7reH71c04BqTswwzfULvqb2n2FNTeRym+haSa/1jlGSE74DMPDBElA
	 slfNd/JhiX2U34JgvwS8pBjx0zmVY3GDgoYpqRZ0Y9jmLgjPETZtysu6r61d9iBm4Y
	 Fms4mMJ1oqjjw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 08 Dec 2024 16:26:50 +0100
X-ME-IP: 90.11.132.44
Message-ID: <d205aae9-68d5-41f1-8739-779b2d9a6664@wanadoo.fr>
Date: Sun, 8 Dec 2024 16:26:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v10 8/9] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
References: <20241208002105.18074-1-ansuelsmth@gmail.com>
 <20241208002105.18074-9-ansuelsmth@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>,
 "AngeloGioacchino Del Regno," <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@airoha.com
In-Reply-To: <20241208002105.18074-9-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/12/2024 à 01:20, Christian Marangi a écrit :
> Add Airoha AN8855 5-Port Gigabit DSA switch. Switch can support
> 10M, 100M, 1Gb, 2.5G and 5G Ethernet Speed but 5G is currently error out
> as it's not currently supported as requires additional configuration for
> the PCS.
> 
> The switch is also a nvmem-provider as it does have EFUSE to calibrate
> the internal PHYs.
> 
> Signed-off-by: Christian Marangi <ansuelsmth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---

...

> +static int an8855_read_switch_id(struct an8855_priv *priv)
> +{
> +	u32 id;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, AN8855_CREV, &id);
> +	if (ret)
> +		return ret;
> +
> +	if (id != AN8855_ID) {
> +		dev_err(priv->dev,
> +			"Switch id detected %x but expected %x",

missing \n

> +			id, AN8855_ID);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}

...

> +static void an8855_switch_remove(struct platform_device *pdev)
> +{
> +	struct an8855_priv *priv = dev_get_drvdata(&pdev->dev);
> +
> +	if (!priv)
> +		return;

I don't think this can happen. So it could be removed?

> +
> +	dsa_unregister_switch(priv->ds);
> +}

...

CJ

