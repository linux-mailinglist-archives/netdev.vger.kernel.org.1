Return-Path: <netdev+bounces-246719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA673CF0A67
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 07:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99FA9300955D
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 06:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB4123BD17;
	Sun,  4 Jan 2026 06:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QtmG8iAm"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47B818DB1E;
	Sun,  4 Jan 2026 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767507114; cv=none; b=g3iBNy3wYl2pNOdEFyvGKTriHgB0j11RFFOzrWOa3p1cQdwKo4/siDFW1aQSXENcAZIDg4oEa0fTvN9hlt5rtT5rqM/ANKfEQtrvMX6GSW7oyRnI5jqKbePie5bOrAqlTQBeZqpr0NraNygnIr4TWUzlAGk6a3HM8IfZ2JqaMX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767507114; c=relaxed/simple;
	bh=rrd9lboWYZZQM5pEY65P23Na+YFCjllKTLngJuC8eH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4gh3eyHQmCkDXvFH0e2yUJf6mTCcjagIrQzyqsChSl2L398LBZMp/biUNsDE0L6VlBx3jvOPt7mCiHdcmGnIpWhY3vw67rjJamkf/2TmvzNOzOSVP3sc2jSbhfQE2GYcp9HXqR8s8KVfkpM9GulcCC/rmiuOD4pHuKuiwQY4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QtmG8iAm; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767507105; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7WXvX/ek+elCslbBd4lwuFqV8nNC6GMkulHsfFTCGPc=;
	b=QtmG8iAm0LaC/2CvbqDm6AHCIdeoSRkUC9mCwLgGYT45CvyEduMOkqaRRDjd7sHQ1VSMZShxrXI1ctW3TIhWci5ljcSg4W52AsQqURAaeaEdMTIEo8HCjbc6oOh+PPhD2W3DWqDrNq8WJGqJD5zpav55PnhumkcUUpZsLdmSSqA=
Received: from 30.221.145.203(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WwBx0bC_1767507104 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 04 Jan 2026 14:11:44 +0800
Message-ID: <3e137dbb-4299-4adf-9e19-b78ce6cfe4c8@linux.alibaba.com>
Date: Sun, 4 Jan 2026 14:11:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Richard Cochran <richardcochran@gmail.com>, andrew+netdev@lunn.ch,
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
 <fb01b35d-55a8-4313-ad14-b529b63c9e04@linux.alibaba.com>
 <20251216135848.174e010f@kernel.org>
 <957500e7-5753-488d-872d-4dbbdcac0bb2@linux.alibaba.com>
 <20260102115136.239806fa@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20260102115136.239806fa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/3 03:51, Jakub Kicinski wrote:
> On Mon, 22 Dec 2025 15:18:19 +0800 Wen Gu wrote:
>> The same applies to ptp_cipu, since it is already used and relies on
>> exposing /dev/ptpX.
> 
> IIUC you mean that the driver is already used downstream and abandoning
> PTP will break the OOT users? This is a non-argument upstream.
> 

I know.

My point is that I hope ptp_cipu can use the PTP interface as these
existing drivers, because many user programs and their ecosystems
depend on the PTP interface, such as chrony, or other user programs
based on `/dev/ptp*`. A new clock class device node will break this,
requiring changes to all these user programs, otherwise they can't
use the clock.

>> Given the historical baggage, it seems better to keep using the
>> existing ptp framework, but separate these pure phc drivers into a
>> new subsystem with a dedicated directory (e.g. drivers/phc/) and a
>> MAINTAINERS entry, moving them out of the netdev maintenance scope.
>> This should also address the concern that these pure phc drivers are
>> not a good fit to be maintained under the networking subsystem.
> 
> I'd rather you left PTP completely alone with your funny read only
> clocks. Please and thank you.

What you call 'funny' read only clocks have existed as PTP clocks for
a long time, and there are many examples, such as ptp_kvm, ptp_vmw
and ptp_s390. It also exists outside the drivers/ptp directory, such
as drivers/hv/hv_util.c[1]. And there are also recent examples, such
as drivers/virtio/virtio_rtc_ptp.c[2]. Even the PTP interface definition
does not require that the ability to set the time must be supported.
So I think the clock itself, as well as the use of the PTP interface
is reasonable and not funny.

IIUC, the main block is that you don't want to maintain these pure
phc clocks, as you mentioned in [3]. I agree with this as well. So I
propose to group these pure phc drivers together (e.g. drivers/phc)
and move them from the network maintenance domain to the clock maintenance
domain.

What's your new concern?

[1] https://lore.kernel.org/all/20170130110716.16795-4-vkuznets@redhat.com/
[2] https://lore.kernel.org/all/20250509160734.1772-3-quic_philber@quicinc.com/
[3] https://lore.kernel.org/all/20251127083610.6b66a728@kernel.org/

Regards.


