Return-Path: <netdev+bounces-231524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F76BF9F55
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 06:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EFDA4E03AB
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 04:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCC72D23B1;
	Wed, 22 Oct 2025 04:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="EvkABKX6"
X-Original-To: netdev@vger.kernel.org
Received: from mx18lb.world4you.com (mx18lb.world4you.com [81.19.149.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A3419DFA2;
	Wed, 22 Oct 2025 04:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107914; cv=none; b=HQ0xEeOdaLSl5GGORSObDNCojhbhMgj6auXSiB06G+ACM1pasAqmF7kKqC+wLFQ55goHjBfpNtwP8i12Q37dmH0weG7r4gEl6MG1CSNwiP/pRT0VpcDvX1ykWVusU/Js90e76ElqSrCEJpkUDU9JVLNUqP3bM0I0k4XdMQNlMHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107914; c=relaxed/simple;
	bh=18FlkdQsiJPJAWiBoXayMc4f6mpPL3bylWWf3NZHpQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTEmdbNwdpAZ9hyBBfurlKFeKOYNs19Y1NHwQK01SgpoE6NhRPWuBngBbbf2so7/3tVy8fWaU8UjoKgNdbyM76mb/+LAJ8KqS2NMDB9CfUkSHJfVlJNaSLrI6e7c/GxAoWyCbNNoWt1qsw7gOhK/soN6U7zPxe6PZpJbu572+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=EvkABKX6; arc=none smtp.client-ip=81.19.149.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IPRze5FkHFbMvW64NXYkFdwwtGyQKARdVchokBmbTF8=; b=EvkABKX6NTJPmt0vUcBCqtFoLw
	RUZ5gIj0bmZyrIJOZGxwV+RsMzeteXcxEoMdHsptAsliwAMnY3PNfPdAGzriJvV4r5ikwHwI1V4+7
	XND33w1ribTLm+6AuFL3oNbZahdZFz8ck8GHfkjC/CfrMYSa1YlZddrRFzX8Ydzg4uYk=;
Received: from [188.22.5.236] (helo=[10.0.0.160])
	by mx18lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vBQD2-000000001OC-0W5t;
	Wed, 22 Oct 2025 06:12:24 +0200
Message-ID: <4041a6f5-2033-47f8-9e33-69d7a5b3de04@engleder-embedded.com>
Date: Wed, 22 Oct 2025 06:12:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for non PTP SKUs
 for lan8814
To: Jakub Kicinski <kuba@kernel.org>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, richardcochran@gmail.com
References: <20251017074730.3057012-1-horatiu.vultur@microchip.com>
 <79f403f0-84ed-43fe-b093-d7ce122d41fd@engleder-embedded.com>
 <20251020063945.dwqgn5yphdwnt4vk@DEN-DL-M31836.microchip.com>
 <e0a8830e-6267-4b2a-b1fa-f3cbe34bd3ba@engleder-embedded.com>
 <20251021161447.311a3e0f@kernel.org>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20251021161447.311a3e0f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 22.10.25 01:14, Jakub Kicinski wrote:
> On Mon, 20 Oct 2025 20:11:13 +0200 Gerhard Engleder wrote:
>>>> Hasn't net also switched to the common kernel multiline comment style
>>>> starting with an empty line?
>>>
>>> I am not sure because I can see some previous commits where people used
>>> the same comment style:
>>> e82c64be9b45 ("net: stmmac: avoid PHY speed change when configuring MTU")
>>> 100dfa74cad9 ("net: dev_queue_xmit() llist adoption")
>>
>> The special coding style for multi line comments for net and drivers/net
>> has been removed with
>> 82b8000c28 ("net: drop special comment style")
>>
>> But I checked a few mails on the list and also found the old style in
>> new patches.
> 
> We removed the check that _suggests_ the use of the superior style.
> Aesthetic taste is not evenly distributed within the population.
> But we still prefer the old style in netdev.
> 
> That said I don't think nit picking on comment style is productive,
> in either direction.

I already had to remove the superior style on netdev. That's why I
commented it here. But I also like the old style more. Thank you for
the clarification!

Gerhard

