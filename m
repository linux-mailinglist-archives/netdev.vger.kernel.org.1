Return-Path: <netdev+bounces-225293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC2DB91F83
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822502A41E8
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74342E88BB;
	Mon, 22 Sep 2025 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="W2Fqf7K0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC122E7BAA;
	Mon, 22 Sep 2025 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555305; cv=none; b=QevMgnBaVBnZzSQdEKwhENtyJkGwsi66iRHdeZo0eiPMHzFylIsJ+ALMK3SEd8FIxi/hL7YgujGfmOz0hzK1zkU2qJBMva+AJ45qzFjGVRhTsFtemXE1+6stmdlC0A3m1ICYzI6ghtoHXneZamJp5SvvI/gabwMmo8Tg6Ov0kbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555305; c=relaxed/simple;
	bh=S3nR08scvOYxQPr9SDbE350r0bvaB769ACMZhiLksS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpJymOuRYrlfKGLeiX6JU8tOw4fmTlN5UUwl+hRhnLWjVXdrSv618i8bX5e7fGyuzJP5uvLU4L9aI2NRSOKOmTOpPmao3eoN0xOwDdgSWpI4qyXcKmTgK2r0Yg4Cr1yg0nZXWzijzwNV3NCiX/cmJm/WdUyq0lMeB/k1V7YQVBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=W2Fqf7K0; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id 0iZ2vqcWnFsG90iZ2vKGzC; Mon, 22 Sep 2025 17:34:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1758555295;
	bh=3FaNLmFmhfEak/yzdIxKjy3ePRlrUJpce254WrXdU+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=W2Fqf7K0VzK9c4pK612dHLabrgEz35aD6e8QOKUy64xfSjBRQT/YLhKICZ2Zgh1Q2
	 SGx9BYA9o48DMqQbVGenaPHjHTWG+PoPdGb+HzNWY2DgMX1blgK9CSgOeKkZ+OEjH2
	 ZhaSlqOq/Wl7QzDPdDQkURFfgH3VJTvyKc5OzmJ59IcI/UH6pieB3TlzVlyT88ETLU
	 sWz1qLy3vtso87yexg2chFDGromRpfjYtoAJGmuKBeB/aIsPY30vCueG0rGYvsIcDM
	 6VijCYYYHNNu3WKwbqWiSKL2Ls6UAS0Kt7X33gB8ewtcu2OGwqG0fM61ncPJ0tE40v
	 fE4kPVEZqjvmA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 22 Sep 2025 17:34:55 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <233f751e-b7f3-452f-a9ac-9c88621badb4@wanadoo.fr>
Date: Mon, 22 Sep 2025 17:34:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: mv643xx_eth: Fix an error handling path in
 mv643xx_eth_probe()
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Lennert Buytenhek <buytenh@wantstofly.org>,
 Andy Fleming <afleming@freescale.com>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
References: <f1175ee9c7ff738474585e2e08bd78f93623216f.1758528456.git.christophe.jaillet@wanadoo.fr>
 <efff779e-96e1-473a-8b9c-114b090ff02c@lunn.ch>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <efff779e-96e1-473a-8b9c-114b090ff02c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 22/09/2025 à 14:53, Andrew Lunn a écrit :
> On Mon, Sep 22, 2025 at 10:08:28AM +0200, Christophe JAILLET wrote:
>> If an error occurs after calling phy_connect_direct(), phy_disconnect()
>> should be called, as already done in the remove function.
>>
>> Fixes: ed94493fb38a ("mv643xx_eth: convert to phylib")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> This patch is speculative and compile tested only.
>> Review with care.
>> ---
>>   drivers/net/ethernet/marvell/mv643xx_eth.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
>> index 0ab52c57c648..de6a683d7afc 100644
>> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
>> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
>> @@ -3263,6 +3263,8 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
>>   	return 0;
>>   
>>   out:
>> +	if (dev->phydev)
>> +		phy_disconnect(dev->phydev);
> 
> This is correct, but it is a little bit less obviously correct than it
> could be. Nothing in mv643xx_eth_probe sets dev->phydev. It happens
> deep down in the call chain of of_phy_connect(). Just using:
> 
> 	if (phydev)
> 		phy_disconnect(phydev);
> 
> would be more obvious for this probe function.
> 
> But since it is correct, Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> and i will leave you to decide if you want to change it.
> 
>      Andrew
> 
> 

In the (pd->phy_addr != MV643XX_ETH_PHY_NONE) case, phydev could be an 
error code.

So, we should do something like:
	if (!IS_ERR_OR_NULL(phydev))
		phy_disconnect(phydev);

Agree?

CJ




