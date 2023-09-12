Return-Path: <netdev+bounces-33360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A9779D8CF
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 20:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8558D1C21061
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6779567E;
	Tue, 12 Sep 2023 18:38:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5940944C
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 18:38:15 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C852A10E9
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:38:14 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id g8GzqaTAidUSag8GzqmwHQ; Tue, 12 Sep 2023 20:38:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1694543893;
	bh=gJjWjCvzjTWsQueLFBTaq3Sqnmya67aAWoGNbP8Czo4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fXyzuGJL535OOgG/gUoUYvhGpJSjMxj5+Ed+yyVpThO6lTRpKH7k1KKANGGSHVZA/
	 imnCaeFq7So19OjQawTGRRm8vjh6/mf4sqM6TqCHj5V/RrBIw1QxaTYHycwXsY5Akz
	 sbsmOPjfAMI54vFSppT7Y0lSuG1z4VazGb/t2VKy6XZF7DsFW2qiguOeZgbz/9r6kc
	 Z2OpymZVceBmy1ZHBtqUbR6m32LOnMggNcY97/ClnvD67ABlYqMlO7Nzjyv96DyWDt
	 Xrz0FPgG+7GKlNqUxo9AzNvxujyD0DZusSH8r815NVZ4X/UCbHl5tMNFoR/w/ChjM2
	 wcRrvSqhCkDPw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 12 Sep 2023 20:38:13 +0200
X-ME-IP: 86.243.2.178
Message-ID: <35c1c9ee-357f-4ba5-dd47-95d4c064e69b@wanadoo.fr>
Date: Tue, 12 Sep 2023 20:38:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH net-next v4 2/2] net: dsa: microchip: Add drive strength
 configuration
Content-Language: fr
To: Vladimir Oltean <olteanv@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Woojung Huh <woojung.huh@microchip.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, devicetree@vger.kernel.org
References: <20230912045459.1864085-1-o.rempel@pengutronix.de>
 <20230912045459.1864085-1-o.rempel@pengutronix.de>
 <20230912045459.1864085-3-o.rempel@pengutronix.de>
 <20230912045459.1864085-3-o.rempel@pengutronix.de>
 <20230912113553.fselyj2v5ynddme2@skbuf>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230912113553.fselyj2v5ynddme2@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/09/2023 à 13:35, Vladimir Oltean a écrit :
> On Tue, Sep 12, 2023 at 06:54:59AM +0200, Oleksij Rempel wrote:
>> Add device tree based drive strength configuration support. It is needed to
>> pass EMI validation on our hardware.
>>
>> Configuration values are based on the vendor's reference driver.
>>
>> Tested on KSZ9563R.
>>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> ---


>> +	if (!found)
>> +		return 0;
> 
> Maybe "have_any_prop" would be a better name to avoid Christophe's confusion?

Not sure it worth it.

Christophe should learn to read code or avoid some quick feed-back 
before morning coffee :)

'found' looks good enough.

CJ



