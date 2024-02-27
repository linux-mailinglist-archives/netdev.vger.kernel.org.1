Return-Path: <netdev+bounces-75290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A790869024
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA121F20419
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D7313F006;
	Tue, 27 Feb 2024 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="pFoFW4zk"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3FC152E15
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 12:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035875; cv=none; b=GpWkOT7T5UThmel+wKb7Qz1a/ZGjtG0uY2shYEvAwKLvbcNimg938euZ9EfpMdH85XXevAEoVLHxsU9E/LCV6vFO07mH5qbdnhBUIAxarYa1RdotMEYQVix6faDDWEtVc73Uc3iunbnHKj5lM/ZOPzJnX8XKX10oJWgS5aXIvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035875; c=relaxed/simple;
	bh=wWTB3jhcJ0oZeCQ+b5jX7kxughQcPsjLXE0O7Mg4Y7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBC+D7hOe9Q1gmg6V0k/zRsrFQXOnaNbWeeqiJYxFSBjqc8Hmh57B01AF+U345u0OdyfB/mrJPk+um7bFyZ7VgV4yQn7xXYneOWHaDACJf2547TRJg2P37+Ehag/0480TBl0vcJR0b0bzPSc5H+BsEMV+rMD7wo5FlEMmoHI5JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=pFoFW4zk; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024022712110731e122f39635ed4a49
        for <netdev@vger.kernel.org>;
        Tue, 27 Feb 2024 13:11:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=O4S0Er+CAc0f8Drx3m9bkNCFpGySo/QqbYv0Z8fVrCM=;
 b=pFoFW4zkFNKZwdelmHAg4DQd9e8i2/fZoKXMQv+hPir8zFwQIJ9SwQ/jUJ+Y3kYfugkREu
 w6ILhOcNiquG/uNfFGoz/n4ahptawGKQHVLU+1fESyUYm/pwLH/5tvtHIkbAWYZIlGEUEzyZ
 yrNRbJm4Tc9ulJs+QkN9rtq2GkYwY=;
Message-ID: <45e85d07-4cbc-47e7-a758-e4d666a3c3a9@siemens.com>
Date: Tue, 27 Feb 2024 12:11:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 08/10] net: ti: icssg-prueth: Add functions to
 configure SR1.0 packet classifier
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, dan.carpenter@linaro.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc: jan.kiszka@siemens.com, diogo.ivo@siemens.com
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
 <20240221152421.112324-9-diogo.ivo@siemens.com>
 <38090ee4-30c2-46b3-b16d-ae0836c640ca@kernel.org>
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <38090ee4-30c2-46b3-b16d-ae0836c640ca@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

On 2/26/24 17:26, Roger Quadros wrote:
> 
> 
> On 21/02/2024 17:24, Diogo Ivo wrote:
>> Add the functions to configure the SR1.0 packet classifier.
>>
>> Based on the work of Roger Quadros in TI's 5.10 SDK [1].
>>
>> [1]: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ti.com%2Fcgit%2Fti-linux-kernel%2Fti-linux-kernel%2Ftree%2F%3Fh%3Dti-linux-5.10.y&data=05%7C02%7Cdiogo.ivo%40siemens.com%7C5db0233cf1944b0b012808dc36f0214c%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638445652187413851%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=u4p0vZ6LCPScUuYuwCB2iJFm6uoz%2BDMesVWnTgwg1hs%3D&reserved=0
>>
>> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
>> ---
>> Changes in v3:
>>   - Replace local variables in icssg_class_add_mcast_sr1()
>>     with eth_reserved_addr_base and eth_ipv4_mcast_addr_base
>>

...

>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index e6eac01f9f99..7d9db9683e18 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -437,7 +437,7 @@ static int emac_ndo_open(struct net_device *ndev)
>>   	icssg_class_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
>>   	icssg_ft1_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
>>   
>> -	icssg_class_default(prueth->miig_rt, slice, 0);
>> +	icssg_class_default(prueth->miig_rt, slice, 0, false);
> 
> Should you be passing emac->is_sr1 instead of false?

Given that this is the SR2.0 driver we know that bool is_sr1 will always
be false, is there an advantage in passing emac->is_sr1 rather than
false directly?

Best regards,
Diogo

