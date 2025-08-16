Return-Path: <netdev+bounces-214256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A546B28A5F
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 05:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E728A25964
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 03:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F261D88A4;
	Sat, 16 Aug 2025 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="B+LtpeGw"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B983155333;
	Sat, 16 Aug 2025 03:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755316422; cv=none; b=Sk71SjzWjpQrDa+iQfXCRlTEj9uIWJJf9dUEaVgWYD+EFLIqnToqHHRSDsan5a3CQoBxl4SnPwa4tgk92VfibA0RRds7mFvwjKJ+4XFFaRMeSKYIwVhXtuM9VE+JgDjoIXLuZIafe/oecCr1q8omXfXSF1hP6HiEG6i6lptpmo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755316422; c=relaxed/simple;
	bh=sFof9ZJ265IZSD36dpzx06sjikw+apqRmtPD496v4Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgWERR84V+7rcQqU2lTDLM//8LbAx449GLRgZYxogs/x3gTCYLlwN8FXuYBqWmYoANxOPC2Y3GLoarTA1VkL5+rBf9rYrXLF3ciHaFBe/8auo1zyH0C5IA9gJ+7gTlTlZnfyw++y6oUKT4Z9AGFiHkQXXwYlrCnqoyGRUFLZ0iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=B+LtpeGw; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755316407; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JIZlq6Vx8PLQbzVJbIEl4PG97O7jQ5b2q+B6qeAr2Jc=;
	b=B+LtpeGwLF4PR5rKOMpfnaZlRBABz/F1h1aZl2UF2FT7VaG89zUQnZyQqkWXOrTcAHeV6MYKFHXdtDPxdP3z4KrmMw1zPCWxW3DbcaHZhc1K+lno1V8Hi7itnsviN7y7yUKWajoTRupPnXO/RgmiBvJadxTUpMvU5ng/BXEWTow=
Received: from 30.221.32.119(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WlqVtem_1755316338 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 16 Aug 2025 11:53:27 +0800
Message-ID: <2a98165b-a353-405d-83e0-ffbca1d41340@linux.alibaba.com>
Date: Sat, 16 Aug 2025 11:52:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] ptp: add Alibaba CIPU PTP clock driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
 dust.li@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw2@infradead.org>
References: <20250812115321.9179-1-guwen@linux.alibaba.com>
 <20250815113814.5e135318@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20250815113814.5e135318@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/16 02:38, Jakub Kicinski wrote:
> On Tue, 12 Aug 2025 19:53:21 +0800 Wen Gu wrote:
>> This adds a driver for Alibaba CIPU PTP clock. The CIPU, an underlying
>> infrastructure of Alibaba Cloud, synchronizes time with reference clocks
>> continuously and provides PTP clocks for VMs and bare metals in cloud.
> 
>> +static struct attribute *ptp_cipu_attrs[] = {
>> +	&dev_attr_reg_dev_feat.attr,
>> +	&dev_attr_reg_gst_feat.attr,
>> +	&dev_attr_reg_drv_ver.attr,
>> +	&dev_attr_reg_env_ver.attr,
>> +	&dev_attr_reg_dev_stat.attr,
>> +	&dev_attr_reg_sync_stat.attr,
>> +	&dev_attr_reg_tm_prec_ns.attr,
>> +	&dev_attr_reg_epo_base_yr.attr,
>> +	&dev_attr_reg_leap_sec.attr,
>> +	&dev_attr_reg_max_lat_ns.attr,
>> +	&dev_attr_reg_mt_tout_us.attr,
>> +	&dev_attr_reg_thresh_us.attr,
>> +
>> +	&dev_attr_ptp_gettm.attr,
>> +	&dev_attr_ptp_gettm_inval_err.attr,
>> +	&dev_attr_ptp_gettm_tout_err.attr,
>> +	&dev_attr_ptp_gettm_excd_thresh.attr,
>> +
>> +	&dev_attr_dev_clk_abn.attr,
>> +	&dev_attr_dev_clk_abn_rec.attr,
>> +	&dev_attr_dev_maint.attr,
>> +	&dev_attr_dev_maint_rec.attr,
>> +	&dev_attr_dev_maint_tout.attr,
>> +	&dev_attr_dev_busy.attr,
>> +	&dev_attr_dev_busy_rec.attr,
>> +	&dev_attr_dev_err.attr,
>> +	&dev_attr_dev_err_rec.attr,
> 
> This driver is lacking documentation. You need to describe how the user
> is expected to interact with the device and document all these sysfs
> attributes.
> 

OK. I will add the description.

Would you prefer me to create a related .rst file under Documentation/
(perhaps in a new Documentation/clock/ptp/ directory?), or add the
description comments directly in this driver source?

> Maybe it's just me, but in general I really wish someone stepped up
> and created a separate subsystem for all these cloud / vm clocks.
> They have nothing to do with PTP. In my mind PTP clocks are simple HW
> tickers on which we build all the time related stuff. While this driver
> reports the base year for the epoch and leap second status via sysfs.

These sysfs are intended to provide diagnostics and informations.
For users, interacting with this PTP clock works the same way as with other
PTP clock, through the exposed chardev. The 1588 protocol related work has
been done by the cloud infra so the driver only reads some registers.

Thanks.

