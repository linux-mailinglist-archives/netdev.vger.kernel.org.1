Return-Path: <netdev+bounces-249836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D343D1EE13
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED52F301EF03
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F439A7E0;
	Wed, 14 Jan 2026 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EkkhkKl8"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB0A399037;
	Wed, 14 Jan 2026 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394751; cv=none; b=pzwZMMs24u1mF1Vkgtz57PF2dRvNn3MLodLmjcQWQ7amhrtbf5eH+x7fVsmkd4nE/CMB9Hf8fWsaJH5QBaExtUZzi3YXPQkIFZs08fhGyphGeQcMtuyECv/oddFTeSQSEZqgpjPUeI4MSqcUKLQ0gG86o3QxefZ1t9/CcjUBTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394751; c=relaxed/simple;
	bh=vX/8Azbqx+q2cqqsokuMUDz1r5swWXuseYdw3/b29ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5KQXMQCoicnskqGuMDTrWMKdD38JGymPB5G+853ScsArfg8c9Ct2DKflzQDbLxzTgz/YcO3uTzExwZh1KKzMVJcSKQXbFa3SyNRJUtxPzaT/ERoP9H6YHzO7w4EsqgFOtWFNfbtH4hKw+SWLht2oB7yBNtE2T/luDcBPHz4xSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EkkhkKl8; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768394740; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tA0OUEdyVjHAlUZB1d999srJuWv325fcJ9F7cw3+x8I=;
	b=EkkhkKl8jU8iG0bpEcpQw7dFrXNGawDdty5b+VM4lMy3fy8gAV8iTrm3jbCwSJxuTbCeEU1kGyjxV2FWYUkVlSr99UwBBpvl9SHNAq0ob1HXvDKBGN/qRC+nYi58pViZM8cl/qzt4IwCecpSkJy5yktICNT6hKvhHZ3QAMlwSuE=
Received: from 30.221.145.108(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Wx2Lc3W_1768394738 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 20:45:39 +0800
Message-ID: <ad261f12-82a1-4a02-9abd-a7d7c7e771e8@linux.alibaba.com>
Date: Wed, 14 Jan 2026 20:45:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Richard Cochran <richardcochran@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Dust Li <dust.li@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David Woodhouse <dwmw2@infradead.org>,
 virtualization@lists.linux.dev, Nick Shi <nick.shi@broadcom.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-clk@vger.kernel.org,
 Sven Schnelle <svens@linux.ibm.com>, Andrew Lunn <andrew@lunn.ch>
References: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
 <yt9decnv6qpc.fsf@linux.ibm.com>
 <6a32849d-6c7b-4745-b7f0-762f1b541f3d@linux.dev>
 <7be41f07-50ab-4363-8a53-dcdda63b9147@lunn.ch>
 <87495044-59a3-49ed-b00c-01a7e9a23f6b@linux.dev>
 <b5a60753-85ed-4d61-a652-568393e0dff3@linux.alibaba.com>
 <c85c77bc-9a8c-4336-ab79-89a981c43e01@linux.dev>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <c85c77bc-9a8c-4336-ab79-89a981c43e01@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/14 18:50, Vadim Fedorenko wrote:
> On 14/01/2026 09:13, Wen Gu wrote:
>>
>> Thank you all for your suggestions.
>>
>> The drivers under drivers/ptp can be divided into (to my knowledge):
>>
>> 1. Network/1588-oriented clocks, which allow the use of tools like
>>     ptp4l to synchronize the local PHC with an external reference clock
>>     (based on the network or other methods) via the 1588 protocol to
>>     maintain accuracy. Examples include:
>>
>>     - ptp_dte
>>     - ptp_qoriq
>>     - ptp_ines
>>     - ptp_pch
>>     - ptp_idt82p33
>>     - ptp_clockmatrix
>>     - ptp_fc3
>>     - ptp_mock (mock/testing)
>>     - ptp_dfl_tod
>>     - ptp_netc
>>     - ptp_ocp (a special case which provides a grandmaster
>>                clock for a PTP enabled network, generally
>>                serves as the reference clock)
> 
> ptp_ocp is a timecard driver, which doesn't require calibration by
> ptp4l/ts2phc. OCP TimeCards have their own Atomic Clock onboard which
> is disciplined by 1-PPS or 10mhz signal from configurable source. The
> disciplining algorithm is implemented in Atomic Clock package
> controller. The driver exposes ptp device mostly for reading the time.
> So I believe it belongs to group 2 rather than 1588 group.
> 

Thank you for the correction and detailed explanation. I will move
ptp_ocp to group 2.

>>
>> 2. Platform/infrastructure/hypervisor-provided clocks. They don't
>>     require calibration by ptp4l based on 1588 and reference clocks,
>>     instead the underlay handle this. Users generally read the time.
>>     They include:
>>
>>     - ptp_kvm
>>     - ptp_vmclock
>>     - ptp_vmw
>>     - ptp_s390
>>     - ptp_cipu (upstreaming)
>>
>>  From this perspective, I agree that "emulating" could be an appropriate
>> name for the second ones.
>>
>> And I would like to further group the first ones to "1588", thus
>> divide drivers/ptp to:
>>
>> - drivers/ptp/core
>> - drivers/ptp/1588
>> - drivers/ptp/emulating
>>
>> Regards.


