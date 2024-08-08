Return-Path: <netdev+bounces-116742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4E194B8E1
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 10:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5224D1C243C3
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA1A187FF1;
	Thu,  8 Aug 2024 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="rHGw5Cy5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64F013A257;
	Thu,  8 Aug 2024 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723105178; cv=none; b=qvMSMXsGJ/a/5Sso0wGDRgnJygLMGeK7/UHVu9kBu40jKiUheH8KFf8jIgO2Qho523Jq3gvc146HgrzjXN10VuRtWi0GcdzDZ+3idlPTTBzfRneI8gDVo04R/HE3xyp1lwhEN6Fpb4Bq+TFhZDuIAZ1bAFp+8hzYlHtxvL+9j2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723105178; c=relaxed/simple;
	bh=qbJ7dN7e+uZ8fuFbCcFT9ahVqVTb6MUcGkj1m+Sk0bI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z79WQDNl8SDD81/Cems4FGwrEcrJnuM8Gqnj+Xc6Obg9Zmwex4YJd2iBEbDZmblG4yWgPgDQahABmXz4LQIOzqG8NLVPHsx1Vrago0M/7EeBDTlr8uo5CfmufGdE0aWRLfNJOC9PK49S0p0wCbWbhxJRjraJB0GKdfPNQ4SjdjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=rHGw5Cy5; arc=none smtp.client-ip=80.12.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id byLnsogIFJ0ftbyLnsRa7A; Thu, 08 Aug 2024 10:18:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723105105;
	bh=IUGtwqA57bNMl8U0gXXJ7dXBlmL4os0bhNqnaul8Aoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=rHGw5Cy5JsBG38rKIv0pTOZuox4Heq4inFREen4EFbYmOlLZmiBQldfOaoSUHkiUQ
	 zDh/OKd2OSBzm5iB/BtRWl5w4jFm+7/xwZo6+krDsErbavhAXKh6oOzojK9pNdh4A2
	 /Dfx6gTWvO5YzIW3L3YPjN3WrJQBm4zgh9LPMo/aWaSR08HoFwOlUvw/7Ka9DmANZm
	 MewA1J/rjxHqnqHnIpZBzrUJQUg2RpsRSTYLUZalZW/TTCHAlWts1ynZGayIFU1Ts1
	 mS1S7nnTHJoFjsto/PEjUIOpp0Q40dAG6YgsTaBRe9MT0/3210mmdThRwjO4lKDMUA
	 yI3nuHCv+zmMQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 08 Aug 2024 10:18:25 +0200
X-ME-IP: 90.11.132.44
Message-ID: <acb8e8cc-ebc1-4542-a880-8bb081e1a4c7@wanadoo.fr>
Date: Thu, 8 Aug 2024 10:18:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: moxart_ether: use devm in probe
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: u.kleine-koenig@pengutronix.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
References: <20240808040425.5833-1-rosenp@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240808040425.5833-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/08/2024 à 06:03, Rosen Penev a écrit :
> alloc_etherdev and kmalloc_array are called first and destroyed last.
> Safe to use devm to remove frees.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Hi,

using dmam_alloc_coherent() would go even one step further I think.
It would remove moxart_mac_free_memory() completely.

Then IIUC, using devm_register_netdev() would keep things ordered and 
moxart_remove() could also be removed completely.

(by inspection only)

CJ


>   drivers/net/ethernet/moxa/moxart_ether.c | 19 ++++++-------------
>   1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/moxa/moxart_ether.c b/drivers/net/ethernet/moxa/moxart_ether.c
> index 96dc69e7141f..06c632c90494 100644
> --- a/drivers/net/ethernet/moxa/moxart_ether.c
> +++ b/drivers/net/ethernet/moxa/moxart_ether.c
> @@ -81,9 +81,6 @@ static void moxart_mac_free_memory(struct net_device *ndev)
>   		dma_free_coherent(&priv->pdev->dev,
>   				  RX_REG_DESC_SIZE * RX_DESC_NUM,
>   				  priv->rx_desc_base, priv->rx_base);
> -
> -	kfree(priv->tx_buf_base);
> -	kfree(priv->rx_buf_base);
>   }
>   
>   static void moxart_mac_reset(struct net_device *ndev)
> @@ -461,15 +458,14 @@ static int moxart_mac_probe(struct platform_device *pdev)
>   	unsigned int irq;
>   	int ret;
>   
> -	ndev = alloc_etherdev(sizeof(struct moxart_mac_priv_t));
> +	ndev = devm_alloc_etherdev(p_dev, sizeof(struct moxart_mac_priv_t));
>   	if (!ndev)
>   		return -ENOMEM;
>   
>   	irq = irq_of_parse_and_map(node, 0);
>   	if (irq <= 0) {
>   		netdev_err(ndev, "irq_of_parse_and_map failed\n");
> -		ret = -EINVAL;
> -		goto irq_map_fail;
> +		return -EINVAL;
>   	}
>   
>   	priv = netdev_priv(ndev);
> @@ -511,15 +507,15 @@ static int moxart_mac_probe(struct platform_device *pdev)
>   		goto init_fail;
>   	}
>   
> -	priv->tx_buf_base = kmalloc_array(priv->tx_buf_size, TX_DESC_NUM,
> -					  GFP_KERNEL);
> +	priv->tx_buf_base = devm_kmalloc_array(p_dev, priv->tx_buf_size,
> +					       TX_DESC_NUM, GFP_KERNEL);
>   	if (!priv->tx_buf_base) {
>   		ret = -ENOMEM;
>   		goto init_fail;
>   	}
>   
> -	priv->rx_buf_base = kmalloc_array(priv->rx_buf_size, RX_DESC_NUM,
> -					  GFP_KERNEL);
> +	priv->rx_buf_base = devm_kmalloc_array(p_dev, priv->rx_buf_size,
> +					       RX_DESC_NUM, GFP_KERNEL);
>   	if (!priv->rx_buf_base) {
>   		ret = -ENOMEM;
>   		goto init_fail;
> @@ -553,8 +549,6 @@ static int moxart_mac_probe(struct platform_device *pdev)
>   init_fail:
>   	netdev_err(ndev, "init failed\n");
>   	moxart_mac_free_memory(ndev);
> -irq_map_fail:
> -	free_netdev(ndev);
>   	return ret;
>   }
>   
> @@ -565,7 +559,6 @@ static void moxart_remove(struct platform_device *pdev)
>   	unregister_netdev(ndev);
>   	devm_free_irq(&pdev->dev, ndev->irq, ndev);
>   	moxart_mac_free_memory(ndev);
> -	free_netdev(ndev);
>   }
>   
>   static const struct of_device_id moxart_mac_match[] = {


