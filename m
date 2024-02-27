Return-Path: <netdev+bounces-75292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A48986902F
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D775CB26A41
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A04813AA43;
	Tue, 27 Feb 2024 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="jW9V5sTo"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027D413957E
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036053; cv=none; b=WkTK2Yvetpiviqi60ZL+RhcjjysGtDoKAhQbqP91JRSf/zFgdlJVwlWUiKP0s63FvtFeaeEAD6TlRt4eIlIYW9VQyUZ5qwGMffCI3GryeyI7w9KvZ5QcYgD2n7cBqTBlxGBt1fVLbi//kADUqo1tq0tUVKNOryA6WP1FQAtfsY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036053; c=relaxed/simple;
	bh=lQhHmfsRs1lh0CwlCj1icmvJHiByhDAM5a2KHLPkMKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5216nK41uJgE0wV07ISocJ8X/IEkG903e0RuCf5U2z5ep2qP/SYU+Q8V7wLHLYg936JhdlmeouOsnNzFf+k5MWtWw4QnwJCNW818tERvG6rVA5XlYYezHcuhddsiup0EYwUaX37+ruwgADJjfKmkgfBPMRP87hoH4pXiD5vxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=jW9V5sTo; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202402271214033baa7b460973686f75
        for <netdev@vger.kernel.org>;
        Tue, 27 Feb 2024 13:14:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=toN7HfNiKlGI5xVGmujp/mb++rT5Iw8jQXHWdwiVDFA=;
 b=jW9V5sTowZyAsvqghYoQEI4O+3b1/ory3zinshI2GYYpzhCm/jRl4QFMFpKKniTRd2zqQI
 fFh5p9JzASDWx4ZqobJkAGJiZVv11f5w7b+BPfEgeNw0RXxaW5TVucJ1uJu+iHMhSE9zCTbV
 XogSIrY0nlvwlJrJBXApvHZJr6ufQ=;
Message-ID: <e0ebe176-0e82-4fcf-b416-a906a897bea1@siemens.com>
Date: Tue, 27 Feb 2024 12:14:02 +0000
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
 <1963b69d-2656-40d1-9794-8d0a9a168eed@kernel.org>
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <1963b69d-2656-40d1-9794-8d0a9a168eed@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

On 2/26/24 18:41, Roger Quadros wrote:
> 
> 
> On 21/02/2024 17:24, Diogo Ivo wrote:
>> Add the functions to configure the SR1.0 packet classifier.
>>
>> Based on the work of Roger Quadros in TI's 5.10 SDK [1].
>>
>> [1]: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ti.com%2Fcgit%2Fti-linux-kernel%2Fti-linux-kernel%2Ftree%2F%3Fh%3Dti-linux-5.10.y&data=05%7C02%7Cdiogo.ivo%40siemens.com%7Ca43411e60ce048593e7408dc36fa7f73%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638445696707314198%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=v%2B%2FkgG1q31vJYa5a%2B5zYTbdxJbq5TKVOGT0Aavnk97Q%3D&reserved=0
>>
>> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
>> ---
>> Changes in v3:
>>   - Replace local variables in icssg_class_add_mcast_sr1()
>>     with eth_reserved_addr_base and eth_ipv4_mcast_addr_base
>>
>>   .../net/ethernet/ti/icssg/icssg_classifier.c  | 113 ++++++++++++++++--
>>   drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   2 +-
>>   drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   6 +-
>>   3 files changed, 110 insertions(+), 11 deletions(-)

...

> Build fails with
> 
> drivers/net/ethernet/ti/icssg/icssg_classifier.c:428:7: error: ‘eth_ipv4_mcast_addr_base’ undeclared (first use in this function)
>    428 |       eth_ipv4_mcast_addr_base, mask_addr);
>        |       ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Is there a dependency patch?

Yes, this patch depends on patch 02/10 of the series, apologies for not
mentioning it explicitly.

Best regards,
Diogo

