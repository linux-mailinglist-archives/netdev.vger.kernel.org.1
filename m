Return-Path: <netdev+bounces-214857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C452B2B761
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 05:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CB6164145
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 03:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECA316F0FE;
	Tue, 19 Aug 2025 03:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EKWarGL3"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8142AE56A;
	Tue, 19 Aug 2025 03:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755572468; cv=none; b=j6n/kV5p9BuB6jDWz3QwxsYV+EG5E2dzl/NZDWO67cQRLTcCPIk204sCzLDl4oeP7711Dde/CNbhdJEUOVLx9v1MRGu1gyLY5tbwdzoiVmg+MlSF/k5Ix0+tSsw+CH/BYuEntRZsAF/WlRL0DEx78UJdb8EGRebgRxoQnOzQVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755572468; c=relaxed/simple;
	bh=S2mrSLLgb5YkwjOB9cipqyAZ89vRhjiX2j5trv8qS24=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QPZ0RjenBxoBR1uYwmbKL+di/6XpAEAlrdd79jqk5JUi5xgyib0sytBY6bqMlm1rG6aUgeURHC4P7Qb8HMc4r8d7wCacmFPFRzwMNt7gzqutLlQ5uvnvskkbxkMTTsPOjhjg/hORSvpGlm3TeK4vz0pl67hROF81Xk7fWFxcn7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EKWarGL3; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755572457; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=7u+LrepV3Ytt49+4fjFJTF23QIP2qtRaUyivbzbIHF4=;
	b=EKWarGL3SMWN8cPNC2qS10TV8aKYnr0RuvauFjORNSR8/kB8N5ifTJU7uGZjOP4qi0F3PHIlwNywuoRSMwnZoz6f3lpoRRZ21DhHewNianL9CDJpd8oI/riJq/1i2/QirAVOZy9z4A1+rCCJlM4+w8FEZDMQHB9imoGJyn6IOJM=
Received: from 30.221.128.226(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Wm50dN5_1755572447 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 Aug 2025 11:00:55 +0800
Message-ID: <429dfc47-50d8-43d1-b8cc-2b0689d0f089@linux.alibaba.com>
Date: Tue, 19 Aug 2025 11:00:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wen Gu <guwen@linux.alibaba.com>
Subject: Re: [PATCH net-next v4] ptp: add Alibaba CIPU PTP clock driver
To: David Woodhouse <dwmw2@infradead.org>, Jakub Kicinski <kuba@kernel.org>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
 dust.li@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20250812115321.9179-1-guwen@linux.alibaba.com>
 <20250815113814.5e135318@kernel.org>
 <0eb8283cfb0de9e4e5fd67b186b8b6c7aab80766.camel@infradead.org>
In-Reply-To: <0eb8283cfb0de9e4e5fd67b186b8b6c7aab80766.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/16 02:43, David Woodhouse wrote:
> On Fri, 2025-08-15 at 11:38 -0700, Jakub Kicinski wrote:
>> On Tue, 12 Aug 2025 19:53:21 +0800 Wen Gu wrote:
>>> This adds a driver for Alibaba CIPU PTP clock. The CIPU, an underlying
>>> infrastructure of Alibaba Cloud, synchronizes time with reference clocks
>>> continuously and provides PTP clocks for VMs and bare metals in cloud.
>>
>>> +static struct attribute *ptp_cipu_attrs[] = {
>>> +	&dev_attr_reg_dev_feat.attr,
>>> +	&dev_attr_reg_gst_feat.attr,
>>> +	&dev_attr_reg_drv_ver.attr,
>>> +	&dev_attr_reg_env_ver.attr,
>>> +	&dev_attr_reg_dev_stat.attr,
>>> +	&dev_attr_reg_sync_stat.attr,
>>> +	&dev_attr_reg_tm_prec_ns.attr,
>>> +	&dev_attr_reg_epo_base_yr.attr,
>>> +	&dev_attr_reg_leap_sec.attr,
>>> +	&dev_attr_reg_max_lat_ns.attr,
>>> +	&dev_attr_reg_mt_tout_us.attr,
>>> +	&dev_attr_reg_thresh_us.attr,
>>> +
>>> +	&dev_attr_ptp_gettm.attr,
>>> +	&dev_attr_ptp_gettm_inval_err.attr,
>>> +	&dev_attr_ptp_gettm_tout_err.attr,
>>> +	&dev_attr_ptp_gettm_excd_thresh.attr,
>>> +
>>> +	&dev_attr_dev_clk_abn.attr,
>>> +	&dev_attr_dev_clk_abn_rec.attr,
>>> +	&dev_attr_dev_maint.attr,
>>> +	&dev_attr_dev_maint_rec.attr,
>>> +	&dev_attr_dev_maint_tout.attr,
>>> +	&dev_attr_dev_busy.attr,
>>> +	&dev_attr_dev_busy_rec.attr,
>>> +	&dev_attr_dev_err.attr,
>>> +	&dev_attr_dev_err_rec.attr,
>>
>> This driver is lacking documentation. You need to describe how the user
>> is expected to interact with the device and document all these sysfs
>> attributes.
>>
>> Maybe it's just me, but in general I really wish someone stepped up
>> and created a separate subsystem for all these cloud / vm clocks.
>> They have nothing to do with PTP. In my mind PTP clocks are simple HW
>> tickers on which we build all the time related stuff. While this driver
>> reports the base year for the epoch and leap second status via sysfs.
> 
> None of it should exist in the cloud anyway. The *only* thing that
> makes sense for a VM is for the hypervisor to just *tell* the guest
> what the relationship is between the CPU's hardware counter (e.g. TSC)
> and real time. Which is what VMclock was invented for. Use that,
> instead of making *every* guest on the system duplicate the same work
> of synchronising the *same* underlying oscillator. Badly, with steal
> time in the mix.
> 

Our design is similar, but based on Alibaba CIPU[1].

The CIPU in cloud synchronizes time with the atomic clock and get
high-precision time value. It then virtualizes PCI devices and passes
them to VMs or bare metals. So VMs and bare metals can use these PCI
devices's timestamp registers to obtain the high-precision time.
The driver here exposes these devices as PTP clocks for use by VMs and
bare metals (e.g. chrony).

[1] https://www.alibabacloud.com/blog/a-detailed-explanation-about-alibaba-cloud-cipu_599183

> Given PCIe PTM to synchronize counters, you could even implement
> vmclock over PCI for bare metal.
> 

PCIe PTM is not supported by CIPU, so vmclock can't work for bare metals,
that's also one of the reasons why we choose current design.

Thanks.

