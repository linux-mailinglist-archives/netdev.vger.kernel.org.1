Return-Path: <netdev+bounces-288352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJfHLFBDB2oCvAIAu9opvQ
	(envelope-from <netdev+bounces-288352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:01:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F484552969
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB0413097007
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F295305679;
	Fri, 15 May 2026 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dXj/FTEg"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CA517C220;
	Fri, 15 May 2026 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860399; cv=none; b=cvTxD+D1uKYDrRBPTmYOhwJUKH+B4otJm2eQTXWAPPkqparargg0w0ToGSflnXzW0hfdLfHaSbBjbD/XJN9QTM+KQN7EQeRZmsG0uH0LD6yaM8VSwok1Cm48PivwAH5fHnj41FSEpMf9QWFEM4KoZx1pw1Pwl5uGwSaU8eIk1qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860399; c=relaxed/simple;
	bh=Bd05Y2DGQYHi7NJY2grwSkItczOV51BKttvp5or6Ing=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vd9a5NWB0E3nnxVRtx72UGBOIlZcg99VGYy/nm8Y/tTJZSoqEY220KZSVHP8RTM6dxo/VPsJBAProLlmRHvAQCb0dPYGhhoL3atoQ6BEoqHNwyFPDK+s9cen09++TgUp7khmgyywBeTEYisBSZsDuBJIujqcU2SVrEHcNGa9OgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dXj/FTEg; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id ADD734E42CAD;
	Fri, 15 May 2026 15:53:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 71750606FD;
	Fri, 15 May 2026 15:53:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CD44C11AF82F1;
	Fri, 15 May 2026 17:53:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778860394; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=AIcZgrBpnI0H/y6z0YcYVG3RFVPMDM2NzjOXjmWhTEg=;
	b=dXj/FTEgUdJ3Uv8jF4f0YIKEv6sIKoqEJC77S6jEtK0+LFqbDpFmZZpHYlzd3ZdqyPtopx
	eX+ceRi3886g8oqD1qDXRDRX7pkNpvlfZHFZF8gj8qT4goq0Ei9Szln6ySstA70lAE3ZTH
	fLNK8W9pSrfX3TkYW7LlNjVQXUxrlQKgoIE9ub1zXnfUCvAGlJMytxI4Hg63RLUQMTxbKr
	YyzhOrwRbqgIVT4lbW1URR/N/rbd0k5yrJUswHfchw1/JgT77xgGlBD5gykxnnRAYkdgmj
	ZYg2I1ZExTjxbLyn8FbDqcgWrPDO4S0vmv4OjgAf6XUZCsQuS9WlJ/EwvV8tKw==
Message-ID: <15543e63-5c95-4558-9a95-3e9d051d67bc@bootlin.com>
Date: Fri, 15 May 2026 17:53:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3 net-next] net: mdio: mscc-miim: Use
 devm_clk_get_optional_enabled()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <cover.1778856199.git.christophe.jaillet@wanadoo.fr>
 <542f88aee5de2ac24fca58001eab24ac817abee9.1778856199.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <542f88aee5de2ac24fca58001eab24ac817abee9.1778856199.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 2F484552969
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288352-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[wanadoo.fr,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

On 5/15/26 16:50, Christophe JAILLET wrote:
> Use devm_clk_get_optional_enabled() instead of clk_prepare_enable() and
> clk_disable_unprepare().
> 
> This saves some lines of code and simplifies error handling in the probe.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> 
> In the remove sequence, clk_disable_unprepare() and mdiobus_unregister()
> are not called with the same order anymore. I don't think that it matters.

If anything, I'd say this is better as the original ordering, as the 
remove path now mirrors the probe one.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>   drivers/net/mdio/mdio-mscc-miim.c | 20 ++++----------------
>   1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-mscc-miim.c b/drivers/net/mdio/mdio-mscc-miim.c
> index 03878bd9091d..4d8f60d458b8 100644
> --- a/drivers/net/mdio/mdio-mscc-miim.c
> +++ b/drivers/net/mdio/mdio-mscc-miim.c
> @@ -307,7 +307,7 @@ static int mscc_miim_probe(struct platform_device *pdev)
>   	if (!miim->info)
>   		return -EINVAL;
>   
> -	miim->clk = devm_clk_get_optional(dev, NULL);
> +	miim->clk = devm_clk_get_optional_enabled(dev, NULL);
>   	if (IS_ERR(miim->clk))
>   		return PTR_ERR(miim->clk);
>   
> @@ -318,35 +318,23 @@ static int mscc_miim_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   
> -	ret = clk_prepare_enable(miim->clk);
> -	if (ret)
> -		return ret;
> -
>   	ret = mscc_miim_clk_set(bus);
>   	if (ret)
> -		goto out_disable_clk;
> +		return ret;
>   
>   	ret = of_mdiobus_register(bus, np);
> -	if (ret < 0) {
> -		dev_err_probe(dev, ret, "Cannot register MDIO bus\n");
> -		goto out_disable_clk;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Cannot register MDIO bus\n");
>   
>   	platform_set_drvdata(pdev, bus);
>   
>   	return 0;
> -
> -out_disable_clk:
> -	clk_disable_unprepare(miim->clk);
> -	return ret;
>   }
>   
>   static void mscc_miim_remove(struct platform_device *pdev)
>   {
>   	struct mii_bus *bus = platform_get_drvdata(pdev);
> -	struct mscc_miim_dev *miim = bus->priv;
>   
> -	clk_disable_unprepare(miim->clk);
>   	mdiobus_unregister(bus);
>   }
>   


