Return-Path: <netdev+bounces-127484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF459758D0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455751F23EDE
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03B21AE874;
	Wed, 11 Sep 2024 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="p0oRs4e/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875554D8B9
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726073709; cv=none; b=ppvWRD2WPzvqHkbH3SWPj4Gg2kSFKZ1O8Eqli8Rb+bT7OHQ2gfBALxXTvWTxebF81uuBLOq5g9dnFv7OF3ZfaYnAV5ZV5Z7/mbbTP/Qdds1a72zgQfK9hdeumfMV6/pCiswIiuUvkrOvFSKW8+Tmy9YBte7oLiniT4S6f5rMKkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726073709; c=relaxed/simple;
	bh=9dcc6fkzl8d+j8O7Bw9HalFyhrgYU4oAOwS94xlH1sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5JcQHiy/OWIGXm4R5mQktgNC18H3rRLhlX0wHlxq9y72cX/XkDFpkoMogLhgJBekY3OdQcygQiNFnA4H3VVPT75gOyytDKb8thBS6K+5yL3+MUm4qUmUpjFwgg4GLtTDrHKqzM1OtuNY/woI2rx/l7YKq9xm/jVQaqROvQR22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=p0oRs4e/; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id oQcIs05NoeJiWoQcJsyQpz; Wed, 11 Sep 2024 18:55:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726073700;
	bh=XjhHU3LuhocUqb+TAqSulXBB+7sRbtrotXKds67f2kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=p0oRs4e/QLmXuTMehacYdeVnWDcE7igWHAZZFt7s3VVmkRF1SWdGS+tjAeuwK5pCu
	 UTa4xpdDJHATcEWfOJhaFDGOMzu8DILpTju8DvE8NuXTlQmeo+loGXBsPvvhUVZZ4R
	 ljsxkgzJyF2rgzq4pwn7Tc79F10da6dBFEaMLtofeBQjYSF148W5Thopnej++KI+FQ
	 DWrawxPWAu0fyKWpFn6WGmnZPLmypc21a6K0z5Jaj222QJz1fbBvKC56TvpTTVzjF+
	 4Erqbqho9ZLrFnBzC1FDEi0xu05jXilafqMQ5JQ4SwlIMga4sC2UOUeIEZ8R1hD3xS
	 xLzXP7Tfrx22A==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 11 Sep 2024 18:55:00 +0200
X-ME-IP: 90.11.132.44
Message-ID: <c93c4fe2-e3bb-4ee9-be17-ca8cb9206386@wanadoo.fr>
Date: Wed, 11 Sep 2024 18:54:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 2/5] net: lan743x: Add support to
 software-nodes for sfp
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
 maxime.chevallier@bootlin.com, rdunlap@infradead.org, andrew@lunn.ch,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 linux-kernel@vger.kernel.org
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-3-Raju.Lakkaraju@microchip.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240911161054.4494-3-Raju.Lakkaraju@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/09/2024 à 18:10, Raju Lakkaraju a écrit :
> Register software nodes and define the device properties.
> software-node contains following properties.
>    - gpio pin details
>    - i2c bus information
>    - sfp signals
>    - phylink mode
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>

Hi,

...

> +static int pci1xxxx_i2c_adapter_get(struct lan743x_adapter *adapter)
> +{
> +	struct pci1xxxx_i2c *i2c_drvdata;
> +
> +	i2c_drvdata = pci1xxxx_perif_drvdata_get(adapter, PCI1XXXX_PERIF_I2C_ID);
> +	if (!i2c_drvdata)
> +		return -EPROBE_DEFER;
> +
> +	adapter->i2c_adap = &i2c_drvdata->adap;
> +	snprintf(adapter->nodes->i2c_name, sizeof(adapter->nodes->i2c_name),
> +		 adapter->i2c_adap->name);

strscpy() ?

> +	netif_dbg(adapter, drv, adapter->netdev, "Found %s\n",
> +		  adapter->i2c_adap->name);
> +
> +	return 0;
> +}
> +
> +static int pci1xxxx_gpio_dev_get(struct lan743x_adapter *adapter)
> +{
> +	struct aux_bus_device *aux_bus;
> +	struct device *gpio_dev;
> +
> +	aux_bus = pci1xxxx_perif_drvdata_get(adapter, PCI1XXXX_PERIF_GPIO_ID);
> +	if (!aux_bus)
> +		return -EPROBE_DEFER;
> +
> +	gpio_dev = &aux_bus->aux_device_wrapper[1]->aux_dev.dev;
> +	snprintf(adapter->nodes->gpio_name, sizeof(adapter->nodes->gpio_name),
> +		 dev_name(gpio_dev));

strscpy() ?

> +	netif_dbg(adapter, drv, adapter->netdev, "Found %s\n",
> +		  adapter->nodes->gpio_name);
> +	return 0;
> +}
> +

...

