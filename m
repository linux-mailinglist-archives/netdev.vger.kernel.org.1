Return-Path: <netdev+bounces-163394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ED6A2A1C4
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440B21680CE
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09703195FEC;
	Thu,  6 Feb 2025 07:05:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F01FC0A;
	Thu,  6 Feb 2025 07:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738825550; cv=none; b=p3vGj0hJZ+Ov8xY8DJ+fYdBccKc6qpZqtNKbgYKzUysl9QftbBtmi9dEPqoSL+MTxplFd6l18n/7lcR/Ou/f50EV7DO1gPk5IJyUDwfYJB1vs+GZ9uoq5goL/gB5j1DO8PPoPgKZwVeg6GHQianiGmIs/SL8kX/aK/xtoyAzaiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738825550; c=relaxed/simple;
	bh=8+jUVZiYKGnZrclx7DOOFWR+vHgGDmVWRoQmfd56CBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANi2CbXhCpcVzDUDlQ61j98MllJGuOs7Eub1VKMtG+j37mMDgZ+bD+8+40HlZRJJ7vKbeY8OAnk7ERaCeK2aSGeoVAq1NQiEli/qnIMztn7isRj8Jscxy/Ms197JLJZiM6LpZJ1NVvcrWnGL5UbLCZ9ekKVjguWBNXuzjwCILe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 06 Feb 2025 16:05:41 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 139D8200705C;
	Thu,  6 Feb 2025 16:05:41 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Thu, 6 Feb 2025 16:05:41 +0900
Received: from [192.168.1.141] (unknown [10.213.44.71])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id 14A9CAB188;
	Thu,  6 Feb 2025 16:05:40 +0900 (JST)
Message-ID: <ac319cf8-5501-40f2-bf23-fc04a91d4f1f@socionext.com>
Date: Thu, 6 Feb 2025 16:05:39 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: Allow zero for [tr]x_fifo_size
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Yanteng Si <si.yanteng@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Steven Price <steven.price@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Jose Abreu <joabreu@synopsys.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Furong Xu <0x1207@gmail.com>, Petr Tesarik <petr@tesarici.cz>,
 Serge Semin <fancer.lancer@gmail.com>, Xi Ruoyao <xry111@xry111.site>
References: <20250203093419.25804-1-steven.price@arm.com>
 <Z6CckJtOo-vMrGWy@shell.armlinux.org.uk>
 <811ea27c-c1c3-454a-b3d9-fa4cd6d57e44@arm.com>
 <Z6Clkh44QgdNJu_O@shell.armlinux.org.uk> <20250203142342.145af901@kernel.org>
 <f728a006-e588-4eab-b667-b1ff7dfd66c5@linux.dev>
 <Z6N4J-_C3lq5a_VQ@shell.armlinux.org.uk>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <Z6N4J-_C3lq5a_VQ@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Russell,

On 2025/02/05 23:39, Russell King (Oracle) wrote:
> On Wed, Feb 05, 2025 at 10:22:00PM +0800, Yanteng Si wrote:
>>
>> 在 2/4/25 06:23, Jakub Kicinski 写道:
>>> On Mon, 3 Feb 2025 11:16:34 +0000 Russell King (Oracle) wrote:
>>>>> I've no opinion whether the original series "had value" - I'm just
>>>>> trying to fix the breakage that entailed. My first attempt at a
>>>>> patch
>>>>> was indeed a (partial) revert, but Andrew was keen to find a better
>>>>> solution[1].
>>>> There are two ways to fix the breakage - either revert the original
>>>> patches (which if they have little value now would be the sensible
>>>> approach IMHO)
>>> +1, I also vote revert FWIW
>>
>> +1, same here.
>>
>>
>> For a driver that runs on so much hardware, we need to act
>>
>> cautiously. A crucial prerequisite is that code changes must
>>
>> never cause some hardware to malfunction. I was too simplistic
>>
>> in my thinking when reviewing this before, and I sincerely
>>
>> apologize for that.
>>
>>
>> Steven, thank you for your tests, Let's revert it.
> 
> https://lore.kernel.org/r/E1tfeyR-003YGJ-Gb@rmk-PC.armlinux.org.uk

I'm sorry to bother you. Thanks for posting revert.

There are variations in the capabilities that the hardware has, and more
hardware needs to be verified to show that they work correctly, so it had
to be handled carefully. Reports that the change patch "worked" or
"didn't work" on any hardware are helpful.

I apologize that posting this change to "-net" was inappropriate
because I added a completely new feature.

Thank you,

---
Best Regards
Kunihiko Hayashi

