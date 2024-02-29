Return-Path: <netdev+bounces-76117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BF886C69E
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 11:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CE2BB26CB7
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 10:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5C56350F;
	Thu, 29 Feb 2024 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXtKLGvO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C28F63502
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201749; cv=none; b=A4v06CQG6Mr0D5AfeMK6mZH0LQ/sO4V37Orlgvwp0fgm0x25gYR3GwVKpKG7ukUVRg4y1KYRv5kFtlU7upjM7vVP4Il22TciCdBlM3/SaCZO7HdUbwsA+P5co2yXBDfwzERHFad48zebOnLkLaFPDZO2BRfzb2ob8OxId5FyaWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201749; c=relaxed/simple;
	bh=trsCa4dbSgURqOCF1pcH2X+XbVGCG6hwi/VRAKk5x24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNNsw8nCFCn3HwG5wZtTjuVtibaYA43zilBRbZwyCBhD3Ri3dz1vHv5rHmcZRE0+aDYiA0S8e3SOuiFQa7Apj3LCSZsno8laCPvB2TzNMY1XCdh1ay462rgLSj/gx+rX5VmugfSUFwBuf9Ve7rjED5wrS40t5Lg5z8lVKVtUo1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXtKLGvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FE6C433C7;
	Thu, 29 Feb 2024 10:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709201748;
	bh=trsCa4dbSgURqOCF1pcH2X+XbVGCG6hwi/VRAKk5x24=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PXtKLGvORCL506Z8EwQTfraSvZlCG1/oL3AW4eCg/ZGxekGtchtH/zOEGkqO5qudA
	 wWkkFY63FCuai3wacWnZYzOpHF4DJ3a425qZdIaiicj4B7qNzzs8MoQ22B0Ww04WE8
	 Rt+PaoLdbr2WMG/tjLUIPR6lwDv2iBJ8ddwC0aE+SofaTPIqzd/kG0JGstmgi+y3Uj
	 HThlEoifYv1VcZS0GPiVAn6bUqKW2bOEZEYfaG9xMyduNGjhyJ9mQyIFqUNQitBmym
	 ypcHtKkeZCUrJ8ZpmmmApj9ErLG7YmQ5TbW+zmKx+SNnYc3v7hFYeFy+F6cnMZCxu9
	 6ftWpKcdZAuLA==
Message-ID: <69db7d23-6c24-4b44-9222-94560b6c065b@kernel.org>
Date: Thu, 29 Feb 2024 12:15:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/10] net: ti: icssg-prueth: Add functions to
 configure SR1.0 packet classifier
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@siemens.com>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, dan.carpenter@linaro.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc: jan.kiszka@siemens.com
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
 <20240221152421.112324-9-diogo.ivo@siemens.com>
 <38090ee4-30c2-46b3-b16d-ae0836c640ca@kernel.org>
 <45e85d07-4cbc-47e7-a758-e4d666a3c3a9@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <45e85d07-4cbc-47e7-a758-e4d666a3c3a9@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/02/2024 14:11, Diogo Ivo wrote:
> On 2/26/24 17:26, Roger Quadros wrote:
>>
>>
>> On 21/02/2024 17:24, Diogo Ivo wrote:
>>> Add the functions to configure the SR1.0 packet classifier.
>>>
>>> Based on the work of Roger Quadros in TI's 5.10 SDK [1].
>>>
>>> [1]: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ti.com%2Fcgit%2Fti-linux-kernel%2Fti-linux-kernel%2Ftree%2F%3Fh%3Dti-linux-5.10.y&data=05%7C02%7Cdiogo.ivo%40siemens.com%7C5db0233cf1944b0b012808dc36f0214c%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638445652187413851%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=u4p0vZ6LCPScUuYuwCB2iJFm6uoz%2BDMesVWnTgwg1hs%3D&reserved=0
>>>
>>> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
>>> ---
>>> Changes in v3:
>>>   - Replace local variables in icssg_class_add_mcast_sr1()
>>>     with eth_reserved_addr_base and eth_ipv4_mcast_addr_base
>>>
> 
> ...
> 
>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>> index e6eac01f9f99..7d9db9683e18 100644
>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>> @@ -437,7 +437,7 @@ static int emac_ndo_open(struct net_device *ndev)
>>>       icssg_class_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
>>>       icssg_ft1_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
>>>   -    icssg_class_default(prueth->miig_rt, slice, 0);
>>> +    icssg_class_default(prueth->miig_rt, slice, 0, false);
>>
>> Should you be passing emac->is_sr1 instead of false?
> 
> Given that this is the SR2.0 driver we know that bool is_sr1 will always
> be false, is there an advantage in passing emac->is_sr1 rather than
> false directly?

Ah, no there isn't. You can leave it as it is.

-- 
cheers,
-roger

