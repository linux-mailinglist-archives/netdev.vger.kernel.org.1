Return-Path: <netdev+bounces-202352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 163A7AED822
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DC81895665
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 09:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4543C2253AB;
	Mon, 30 Jun 2025 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XTghWyek"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D2521CA14;
	Mon, 30 Jun 2025 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274313; cv=none; b=KA5aPJmNzQQPYAjkny6YnFr/tZleeSu+Uuwjxd+xXFGc6kz55whUG4BjBH8LuMGa42F7wTcXsdC4++PunSAUtriSMv+lT5dJYcTvhJLN90jwRk3N5t8ZLNcaVyApFivY+9QURFRdNvy24VL7jBHmusxTEJZQhisXp8cmxqsimd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274313; c=relaxed/simple;
	bh=kuDYJ+7zM+E1cUZnWYhYVHSofZYP9lEztYtHByRSNwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCwiXIkgsCnJ0FcxuoxbG5Zv8kuByCDEfZSA+uU+/8SvWr7Fp58a1osoX1ko7V5x3eK8lECqKMxS5StFIxz9HiOBr5EmVRlv/EPaufLKtL8ogRRWnRsg1KahsSVMD0iJmdxB/GBUD9nEO/tivWi6vs3lXRYesI7pMqeYcjswtGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XTghWyek; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751274301; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Nbwiry03JbnKB/0fULaxAWQeikqp1at9hxA4fcZ4hps=;
	b=XTghWyek3KxdIy1vKt1PLI3kzE6Dp6Zy851Lkdzi9hoCcFGyZQzp5d87EFkhXiSwY50JCStaPQ1kEucOvrBE9Hg+PoTXk07zTX7Cpg/WMoSjC0wLV0TrAPayBH/5T0ukDvSbNQT1nQx+vEa9UvYgAiBNsjsfymEaIINsud22PMM=
Received: from 30.221.128.140(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Wg9W1DS_1751274290 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Jun 2025 17:05:01 +0800
Message-ID: <cf70f203-bb0e-4942-8f48-c34e269ce637@linux.alibaba.com>
Date: Mon, 30 Jun 2025 17:04:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ptp: add Alibaba CIPU PTP clock driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250627072921.52754-1-guwen@linux.alibaba.com>
 <69ee8a60-3134-4b7a-8217-be9bbc79a8fa@lunn.ch>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <69ee8a60-3134-4b7a-8217-be9bbc79a8fa@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/6/27 15:46, Andrew Lunn wrote:
>> +#define DRV_VER_MAJOR		1
>> +#define DRV_VER_MINOR		3
>> +#define DRV_VER_SUBMINOR	0
> 
>> +#define LINUX_UPSTREAM		0x1F
> 
>> +static int ptp_cipu_set_drv_version(struct ptp_cipu_ctx *ptp_ctx)
>> +{
>> +	struct ptp_cipu_regs *regs = &ptp_ctx->regs;
>> +	int version, patchlevel, sublevel;
>> +	u32 env_ver, drv_ver;
>> +	int rc;
>> +
>> +	if (sscanf(utsname()->release, "%u.%u.%u",
>> +		   &version, &patchlevel, &sublevel) != 3)
>> +		return -EINVAL;
>> +	sublevel = sublevel < 0xFF ? sublevel : 0xFF;
>> +
>> +	env_ver = (LINUX_UPSTREAM << 27) | (version << 16) |
>> +		  (patchlevel << 8) | sublevel;
>> +
>> +	rc = cipu_iowrite32_and_check(ptp_ctx->reg_addr +
>> +				      PTP_CIPU_REG(env_ver),
>> +				      env_ver, &regs->env_ver);
>> +	if (rc)
>> +		return rc;
>> +
>> +	drv_ver = (DRV_TYPE << 24) | (DRV_VER_MAJOR << 16) |
>> +		  (DRV_VER_MINOR << 8) | DRV_VER_SUBMINOR;
>> +
>> +	return cipu_iowrite32_and_check(ptp_ctx->reg_addr +
>> +					PTP_CIPU_REG(drv_ver), drv_ver,
>> +					&regs->drv_ver);
>> +}
> 
> Please could you explain what this is doing.
> 
> 	Andrew

Sure.

This provides informations to cloud ptp device, so that device
can decide whether to allow the initialization to continue.

It is expected to avoid loading a version that is found to have
serious defects after it is released.

Thanks,

