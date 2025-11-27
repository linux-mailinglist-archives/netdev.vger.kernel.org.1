Return-Path: <netdev+bounces-242163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A992DC8CE0B
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 06:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A7C134B5A5
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 05:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF31271443;
	Thu, 27 Nov 2025 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="D/lHJoiu"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E52222C8;
	Thu, 27 Nov 2025 05:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764222539; cv=none; b=sBVMKAnkiCpQ7osFLPZeIIkZ1HGRf3u/8lf7j2aHceWPoYUkKKARud4GFgsM0c/eKOlIOWDrL73TLQin96bFfGQQMVw7agmeotNvd6KE7PcSQH87XwZmBjzzAYUx6U8+6Sj2V7Jy5dWcDCcW/e96+/OG4VJwAvKUVQBUBwWfjkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764222539; c=relaxed/simple;
	bh=Py2YiWs8cF5O0eUyYLj1hK4QFKhPEbxIeYOJ3hkCibs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qq2Udv6FNJsqWS4g7Z80oramf9pLNa/weI5gKPA2lHbV8v9VDYacYOx4irjCjMKlLaCTnm9jXH1lxne7PiaTgZRtOW6/+XwBW6Tf1Q71YrIsRBbkyF/InFfgQOf71naNom7jQ6p+Y0HKdoDXiHexRP4KX2JoBeWWmNag9B9a36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=D/lHJoiu; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764222529; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=CY0MUl2egl6z58i2a4LkDtU35iyhPW0STYeV0S/ftNQ=;
	b=D/lHJoiuwQ4ScjFYzvke5/OQVhgl/zzxKJqbY/Mw5kbTSbpu8tkCfxVQDZVYqJmpj0MONadOMRajs0ulX4Ayz7e43tZgOsTO8S30E6psFt499mtWFZJmyPZcF62t9qwhU9hNKF9Qu2al1cD9KUILiVFITpM9psTyxS9xoZ/nejY=
Received: from 30.221.144.80(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WtVusyr_1764222527 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Nov 2025 13:48:48 +0800
Message-ID: <34b30157-6d67-46ec-abde-da9087fbf318@linux.alibaba.com>
Date: Thu, 27 Nov 2025 13:48:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wen Gu <guwen@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
 dust.li@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251030121314.56729-1-guwen@linux.alibaba.com>
 <20251030121314.56729-2-guwen@linux.alibaba.com>
 <20251031165820.70353b68@kernel.org>
 <8a74f801-1de5-4a1d-adc7-66a91221485d@linux.alibaba.com>
 <20251105162429.37127978@kernel.org>
In-Reply-To: <20251105162429.37127978@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/6 08:24, Jakub Kicinski wrote:
> On Wed, 5 Nov 2025 18:22:19 +0800 Wen Gu wrote:
>> On 2025/11/1 07:58, Jakub Kicinski wrote:
>>> On Thu, 30 Oct 2025 20:13:13 +0800 Wen Gu wrote:
>>>> This adds a driver for Alibaba CIPU PTP clock. The CIPU, an underlying
>>>> infrastructure of Alibaba Cloud, synchronizes time with atomic clocks
>>>> via the network and provides microsecond or sub-microsecond precision
>>>> timestamps for VMs and bare metals on cloud.
>>>>
>>>> User space processes, such as chrony, running in VMs or on bare metals
>>>> can get the high precision time through the PTP device exposed by this
>>>> driver.
>>>
>>> As mentioned on previous revisions this is a pure clock device which has
>>> nothing to do with networking and PTP.
>>
>> I don't quite agree that this has nothing to do with PTP.
>>
>> What is the difference between this CIPU PTP driver and other PTP drivers
>> under drivers/ptp? such as ptp_s390, ptp_vmw, ptp_pch, and others. Most of
>> these PTP drivers do not directly involve IEEE 1588 or networking as well.
> 

Sorry for the late reply due to a vacation.

> We can't delete existing drivers. It used to be far less annoying
> until every cloud vendor under the sun decided to hack up their own
> implementation of something as simple as the clock.
> 

So what kind of drivers do you think are qualified to be placed in the
drivers/ptp? I checked some docs, e.g.[1], and codes in drivers/ptp,
but I am not sure what the deciding factor is, assuming that exposing
a PTP character device is not sufficient.

[1] https://docs.kernel.org/driver-api/ptp.html

Regards.

>>> There should be a separate class
>>> for "hypervisor clocks", if not a common driver.
>>
>> 'hypervisor clock' is not very accurate. CIPU PTP can be used in VM and
>> bare metal scenarios, and bare metals do not need hypervisors.
> 
> I know.


