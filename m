Return-Path: <netdev+bounces-191168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9C5ABA4EB
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FD51BC17C8
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 21:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ECC1581F0;
	Fri, 16 May 2025 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="UbV7E42Q"
X-Original-To: netdev@vger.kernel.org
Received: from mx02lb.world4you.com (mx02lb.world4you.com [81.19.149.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC7D8488
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747429230; cv=none; b=Xnsoy64AILFJ4SBzdzh2hfMV72GeOzF186cREmlBauWMrHUKlqZ6zbvBkpyT4ypmAbqwOv97Uuu0rDWXr7SGmcGsOgOezmFb2GGfypg+y02deyx7RBwxV962Msm8lt9up5kyN70K+5w3jZE8st1O7ttICim/RzCUSXeIg1ukE5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747429230; c=relaxed/simple;
	bh=5vX4HQGo83/sXRyxrtyVZV3GkwDgtNiiXUpqJqyEJu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9sFbb64yigAcy6zne7i6AI1XyQ6tbb+pMFlErb/LcKdqQ1erqrG5iAOM/obkAKkscRuCHbqxpK/V23lxoA3Ft/ZTUoUsoto8N7yzMR2FAUfiwqViJZtI1fuPArFIYDS/tDT0OJfl3YOAc2RqB85gYPr09wWBYLR2UV8Eezg1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=UbV7E42Q; arc=none smtp.client-ip=81.19.149.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0eBCyFa5nJfNhXT3ROfPcm1WyDIyjNrZL9o5go0BOfQ=; b=UbV7E42QHi27obx+Pc8EoZRWDg
	zkF8s26+0KpTckB8QcWpprb5IyQH9tpKl+aFtAuuwK42ARm/Z6bZBALzxveSHxEHQU7ieGDB1AQuS
	3oiRCnzxRVgCJL8U/bjD8odaz1tgquU0ZKRUdDGZ4GrlKASUZV0EnUUVbuxoYniq/nQc=;
Received: from [188.22.4.212] (helo=[10.0.0.160])
	by mx02lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1uG1Po-000000006eh-0KYk;
	Fri, 16 May 2025 22:12:20 +0200
Message-ID: <6eb6d8fc-3d3d-491f-9b57-a859d39dabb4@engleder-embedded.com>
Date: Fri, 16 May 2025 22:12:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: tsnep: fix timestamping with a stacked DSA
 driver
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
References: <20250512132430.344473-1-vladimir.oltean@nxp.com>
 <532276c5-0c5f-41dd-add9-487f39ec1b3a@engleder-embedded.com>
 <20250512210942.2bvv466abjdswhay@skbuf>
 <76ce9b02-d809-4ccb-8f59-cb8f201e4496@engleder-embedded.com>
 <20250513200645.vxuevzz3hdtd56sc@skbuf>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250513200645.vxuevzz3hdtd56sc@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 13.05.25 22:06, Vladimir Oltean wrote:
> On Tue, May 13, 2025 at 08:34:17PM +0200, Gerhard Engleder wrote:
>> On 12.05.25 23:09, Vladimir Oltean wrote:
>>> On Mon, May 12, 2025 at 10:07:52PM +0200, Gerhard Engleder wrote:
>>>> On 12.05.25 15:24, Vladimir Oltean wrote:
>>>>> This driver seems susceptible to a form of the bug explained in commit
>>>>> c26a2c2ddc01 ("gianfar: Fix TX timestamping with a stacked DSA driver")
>>>>> and in Documentation/networking/timestamping.rst section "Other caveats
>>>>> for MAC drivers", specifically it timestamps any skb which has
>>>>> SKBTX_HW_TSTAMP, and does not consider adapter->hwtstamp_config.tx_type.
>>>>
>>>> Is it necessary in general to check adapter->hwtstamp_config.tx_type for
>>>> HWTSTAMP_TX_ON or only to fix this bug?
>>>
>>> I'll start with the problem description and work my way towards an answer.
>>
>> (...)
>>
>>>> I can take over this patch and test it when I understand more clearly
>>>> what needs to be done.
>>>>
>>>> Gerhard
>>>
>>> It would be great if you could take over this patch. After the net ->
>>> net-next merge I can then submit the ndo_hwtstamp_get()/ndo_hwtstamp_set()
>>> conversion patch for tsnep, the one which initially prompted me to look
>>> into how this driver uses the provided configuration.
>>
>> I will post a new patch version in the next days. You can send me the
>> ndo_hwtstamp_get()/ndo_hwtstamp_set() conversion patch for testing. I
>> have it on my list, but nothing done so far, so I feel responsible
>> for that too.
>>
>> Gerhard
> 
> See attached. It applies on top of this patch ("do_tstamp" is present in
> the context).

I tested the ndo_hwtstamp_get()/ndo_hwtstamp_set() conversion patch
successfully on top of the timestamping fix patch. Thank you for the
patch!

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Tested-by: Gerhard Engleder <gerhard@engleder-embedded.com>

