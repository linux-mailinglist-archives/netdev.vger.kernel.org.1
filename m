Return-Path: <netdev+bounces-244631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63774CBBB54
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 15:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E8AA3003BD5
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 14:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3CD1E5B68;
	Sun, 14 Dec 2025 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fNf3DOHI"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798493B8D68;
	Sun, 14 Dec 2025 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765721051; cv=none; b=p8If9PH4LpSjXN0EWA0sO5hpxzoesfWoqMRHE1SdbduPYsgL3udXQxVOXJpGw2BeGUtJsNF+z4Ii+KQaMKDDTcyiac8EWgLyHYZ+s97Kl2FzzqJEOQTOZXINRLuG4PEyzZ5FSjl65GsndV/XY7zzoco13YI0Sir/W31eORF0ShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765721051; c=relaxed/simple;
	bh=eXX145i+DZx7UCFZb8hqnM/Nrp5M6/VGTiWZnmkfLIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnYbBTbQgxPOQf8bnmnqAOl4reeFtddns4rQRZgVCO70Yr18b/fqijQNL/vKKjk1SIaVnT91OauZEV6OBffFkfn7GfWlPZNxGnz2xJaIpPjgA/b1SYXNreiu7GrGXEmGcbtKr00rAHH2Tr2cWV8tfsABuG1Cf2JZ8xUm+zaZiy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fNf3DOHI; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765721039; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=L0lIEk74fxQ1+QFx9nQ74wuO+ycMoCiKrV1YvssNGvw=;
	b=fNf3DOHI26kZI1i9Jc1DD6n0rCNVIVCCGMMmcg/5/rgWRRJah11Lr5OSjm6Nr9I6Dmg61Isx0OYicjmFvRb4stYdC/F8ax+afABnox4Oe/ynPMUJkRnJQu7yiS+Mk+fy+qR/NYz6cmWsZxuXOvN/QVhYFC4rgXoYw43vV0IwTz8=
Received: from 30.180.98.196(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WukHqM._1765721037 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 14 Dec 2025 22:03:58 +0800
Message-ID: <fb01b35d-55a8-4313-ad14-b529b63c9e04@linux.alibaba.com>
Date: Sun, 14 Dec 2025 22:03:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251030121314.56729-1-guwen@linux.alibaba.com>
 <20251030121314.56729-2-guwen@linux.alibaba.com>
 <20251031165820.70353b68@kernel.org>
 <8a74f801-1de5-4a1d-adc7-66a91221485d@linux.alibaba.com>
 <20251105162429.37127978@kernel.org>
 <34b30157-6d67-46ec-abde-da9087fbf318@linux.alibaba.com>
 <20251127083610.6b66a728@kernel.org>
 <f2afb292-287e-4f2f-b131-50a1650bbb1d@linux.alibaba.com>
 <20251128102437.7657f88f@kernel.org>
 <9a75e3b2-4d1c-4911-81e4-cab988c24b77@linux.alibaba.com>
 <c92b47cf-3da0-446d-8b8f-674830256143@linux.alibaba.com>
 <20251213075028.2f570f23@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20251213075028.2f570f23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/13 06:50, Jakub Kicinski wrote:
> On Fri, 12 Dec 2025 14:50:13 +0800 Wen Gu wrote:
>> Given that net-next is closed and the EOY break is here, I was wondering
>> whether the review discussion might continue during this period or should
>> wait until after the break.
> 
> This is a somewhat frustrating thing to hear. My position is that
> net-next is not the right home for this work, so its status should
> be irrelevant.

Hi Jakub, I'm sorry, but I still don't understand why you object to
this being a PTP clock driver and to placing it under `drivers/ptp`.
Could you please explain your reasons?

You mentioned that it's unrelated to networking, but most of the drivers
under `drivers/ptp` are also unrelated to networking. PTP implementations
that are independent of network drivers are placed here.

If the PTP HARDWARE CLOCK SUPPORT maintainers don't review it, which
subsystem should I go to?

If you're suggesting creating a new subsystem, I think we should first
answer this question: why can't it be part of the current ptp subsystem,
and what are the differences between the drivers under `drivers/ptp`
and those in the new subsystem?

Thanks, and sorry for bothering you during your EOY break.

Regards.

