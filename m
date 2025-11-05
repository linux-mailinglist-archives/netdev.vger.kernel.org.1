Return-Path: <netdev+bounces-235765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B101C35145
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 11:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C628718C84D8
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 10:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1F92FFDDC;
	Wed,  5 Nov 2025 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="l5Yf4g9g"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787202EC083;
	Wed,  5 Nov 2025 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338164; cv=none; b=R7SN0JfvtXGn9csz3yPElCd9ILMuax8p/myndfZ8JlmTFM7uc3kS5n/CGbkdfbINZ7SjkTewAcsrX7QnMQj7ZluFvpU6TQY9l7Kn8CCbteisvGUoX7kYSJn+0Kz1ZF3BOZFFs5mCwa0VE1/lHJ4O1A/VJf3cBhPRhhljzaYeP28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338164; c=relaxed/simple;
	bh=ItYXVK2PdUIcKip20t5lPFH0eehgUIl+xtt3Ngpl7Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvchVeAXIVXD2xLM5FkfHU9fTaSmMwgskSzGCBnE1RNFgVhw3hDsfcbRGJ5qfV0r5Khhg55hc/ysaFPee5EKYOKBfhfY5oQSU3LBNMN9gMxUk7zFtVjJEQBc/IOkN4A8laP/P303QQKt1Tq0W2DfQKs9QW856zGOZqoSbqsx/0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=l5Yf4g9g; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762338153; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wUXBxSgyHViOpb4J0afxMYP8uNQ8fKWBiLqr1WSZuQs=;
	b=l5Yf4g9gzAfiD2cmagb0T8aL1q+wDwfxJ3GcDSWp6R2jvtWUwuHWIQZo7Z3H981DfKLT1RqSrCtKYNh4dzbNDXW5hfSWn8UFiLpjToJBNU6LViZt5EESWmO/zeT0j1q6H72A6wD31446R+/EtBAStMK/xC3CRhVoWO95JnGebAk=
Received: from 30.50.177.113(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Wrl49Gy_1762338144 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Nov 2025 18:22:31 +0800
Message-ID: <8a74f801-1de5-4a1d-adc7-66a91221485d@linux.alibaba.com>
Date: Wed, 5 Nov 2025 18:22:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
 dust.li@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251030121314.56729-1-guwen@linux.alibaba.com>
 <20251030121314.56729-2-guwen@linux.alibaba.com>
 <20251031165820.70353b68@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20251031165820.70353b68@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/1 07:58, Jakub Kicinski wrote:
> On Thu, 30 Oct 2025 20:13:13 +0800 Wen Gu wrote:
>> This adds a driver for Alibaba CIPU PTP clock. The CIPU, an underlying
>> infrastructure of Alibaba Cloud, synchronizes time with atomic clocks
>> via the network and provides microsecond or sub-microsecond precision
>> timestamps for VMs and bare metals on cloud.
>>
>> User space processes, such as chrony, running in VMs or on bare metals
>> can get the high precision time through the PTP device exposed by this
>> driver.
> 
> As mentioned on previous revisions this is a pure clock device which has
> nothing to do with networking and PTP.

I don't quite agree that this has nothing to do with PTP.

What is the difference between this CIPU PTP driver and other PTP drivers
under drivers/ptp? such as ptp_s390, ptp_vmw, ptp_pch, and others. Most of
these PTP drivers do not directly involve IEEE 1588 or networking as well.

> There should be a separate class
> for "hypervisor clocks", if not a common driver.

'hypervisor clock' is not very accurate. CIPU PTP can be used in VM and
bare metal scenarios, and bare metals do not need hypervisors.

Regards.

