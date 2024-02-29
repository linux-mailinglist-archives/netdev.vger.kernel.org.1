Return-Path: <netdev+bounces-76118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9699486C6A4
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 11:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518DD28B589
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 10:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE1063517;
	Thu, 29 Feb 2024 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T33rGs7U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC776351E
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201798; cv=none; b=JT6FughH7YgSAOCxIoTsAi/BopAMpmpjRlAkSB59Iwz2rwPrSKnJN1cRqRgEh129d/uOrLPZjtEduIFGe4N/d06VmyBCi4xv/+QGsqw0EI+61l2bqUPzWKhNwllRVg3lW08maUuEUxx6gFGpykUkEVjVixoy3UBhtZcNcx7N6G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201798; c=relaxed/simple;
	bh=qnomwDP1vYp+lDFJEbp0uYqljU78IE66cOH4WBe0XNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNxoj6i6ie9kN6aDUU/GsUVhE/YOBB2k4BDZWKHYHMUc4v7GI7RjiAR53aADGoOE9y9OquNFgHXYt8Lju8cEHk2+78fr4N28CiTXk2nkGxC8tcEF6xqPiY9R22P53bElUrAQehDjBwGkNVnA9uqMB28I0fAWf+KdOxJ3r7KHJuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T33rGs7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A10C43390;
	Thu, 29 Feb 2024 10:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709201797;
	bh=qnomwDP1vYp+lDFJEbp0uYqljU78IE66cOH4WBe0XNU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T33rGs7UI4vizLB6Ksjh5Bnp7MXdL39484EAPmsHxLFMXikMf9izitqnybbkYB+18
	 cL+RJ37WFsDofMt25mNsoN+2Vrh27tZwqdyVniTkIZDB1W5dqCHOcikQstQr//lQZJ
	 SAOzms6gpUG40DmxB1/WudyIZoj2wO2JbKv8wyyKSsycLm75wK+/daZ4YxR/kNV/XS
	 G8oVbYwaSPclyGO1gkqgPD3/Am5emejlbx96XGUwGKPiwblcq519hJ2eZ0EK25BwFx
	 CQwQfzg+uwlKdko8iga0gbPypAKYR+IbOoqNTVIa6t5JB1HtiBmN16Qj+VpP1WMccj
	 +VORS0ugsDpnQ==
Message-ID: <547710c1-eba3-4006-9285-f2528fac3e1b@kernel.org>
Date: Thu, 29 Feb 2024 12:16:34 +0200
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
 <1963b69d-2656-40d1-9794-8d0a9a168eed@kernel.org>
 <e0ebe176-0e82-4fcf-b416-a906a897bea1@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <e0ebe176-0e82-4fcf-b416-a906a897bea1@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/02/2024 14:14, Diogo Ivo wrote:
> On 2/26/24 18:41, Roger Quadros wrote:
>>
>>
>> On 21/02/2024 17:24, Diogo Ivo wrote:
>>> Add the functions to configure the SR1.0 packet classifier.
>>>
>>> Based on the work of Roger Quadros in TI's 5.10 SDK [1].
>>>
>>> [1]: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ti.com%2Fcgit%2Fti-linux-kernel%2Fti-linux-kernel%2Ftree%2F%3Fh%3Dti-linux-5.10.y&data=05%7C02%7Cdiogo.ivo%40siemens.com%7Ca43411e60ce048593e7408dc36fa7f73%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638445696707314198%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=v%2B%2FkgG1q31vJYa5a%2B5zYTbdxJbq5TKVOGT0Aavnk97Q%3D&reserved=0
>>>
>>> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
>>> ---
>>> Changes in v3:
>>>   - Replace local variables in icssg_class_add_mcast_sr1()
>>>     with eth_reserved_addr_base and eth_ipv4_mcast_addr_base
>>>
>>>   .../net/ethernet/ti/icssg/icssg_classifier.c  | 113 ++++++++++++++++--
>>>   drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   2 +-
>>>   drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   6 +-
>>>   3 files changed, 110 insertions(+), 11 deletions(-)
> 
> ...
> 
>> Build fails with
>>
>> drivers/net/ethernet/ti/icssg/icssg_classifier.c:428:7: error: ‘eth_ipv4_mcast_addr_base’ undeclared (first use in this function)
>>    428 |       eth_ipv4_mcast_addr_base, mask_addr);
>>        |       ^~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Is there a dependency patch?
> 
> Yes, this patch depends on patch 02/10 of the series, apologies for not
> mentioning it explicitly.

You don't have to mention it explicitly. Patc 2 didn't arrive at my inbox and
I didn't notice it. It was my bad, sorry.

-- 
cheers,
-roger

