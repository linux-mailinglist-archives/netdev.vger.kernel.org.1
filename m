Return-Path: <netdev+bounces-209335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F62EB0F3B5
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0311C7B1269
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 13:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0C92E5B2F;
	Wed, 23 Jul 2025 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LPn4V8ME"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07411474CC;
	Wed, 23 Jul 2025 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276731; cv=none; b=bzmIgDeSP2M2k6tKDGKap8Ph+3Oz46to1P5TW8Sjs2p3AOe1DWk5ppwRZvWvoiQChI9xiGYkuwJInkN2PorTXNpEmB6Q9GSkxthIz1pSd5NhEPz9wDFv06/zqfSvRUqCCxqvUAiSNY8kFWBxy7nNt77eZxNLHGAVImiPXoSMRro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276731; c=relaxed/simple;
	bh=CGXxYHL7p7FQlIZkP3MXIk7AkiTNhzQW8eA0AkhISK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2U8i/KeVFqnT751SZoy5HhaOo6v4ykNbC6FXtLzejRq5HZYyanUR/CRPYgiwD9ZtuB1gZDL33VXas6WUCCoaZuUGSsZmN9CzsSTpFL16NrfE+KiryHyBPIBLg8yZGi2oempV4h6Tu38KSSKfr5JL/TRIZ2JaZVPeJx2A7WdBDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LPn4V8ME; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753276723; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=L4SalSJjDu44fjPwLSYDuzaOpmD0jMVAwMvkOA162RY=;
	b=LPn4V8MEDap13hLFIY14gMricbt9eVfWwgp1wfxYrqVUb1F1RqupkkbpCBv3V5lWO/OYB3wxnKU3MYfqeIL/fodaQNm8bsR60sHmXwP1y8BiP6gerMh5oal4JpmpzlPY5D2gnFloXFoI7yIhgFtJPURQzPaXnLYdIqfhz4LPPDo=
Received: from 30.221.128.98(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WjdaegZ_1753276722 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Jul 2025 21:18:43 +0800
Message-ID: <a2078275-641c-41ef-afc1-5e391f4d62f4@linux.alibaba.com>
Date: Wed, 23 Jul 2025 21:18:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] ptp: add Alibaba CIPU PTP clock driver
To: Paolo Abeni <pabeni@redhat.com>, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250717075734.62296-1-guwen@linux.alibaba.com>
 <49c4e674-ab1e-4947-9885-5c73810368eb@redhat.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <49c4e674-ab1e-4947-9885-5c73810368eb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/22 17:13, Paolo Abeni wrote:
> On 7/17/25 9:57 AM, Wen Gu wrote:
>> +#define PTP_CIPU_BAR_0	0
>> +#define PTP_CIPU_REG(reg) \
>> +	offsetof(struct ptp_cipu_regs, reg)
> 
> Minor nit: no need to use a multiple line macro above
> 

Ok, will fix it.

> [...]
>> +static void ptp_cipu_clear_context(struct ptp_cipu_ctx *ptp_ctx)
>> +{
>> +	cancel_delayed_work_sync(&ptp_ctx->gen_timer);
>> +	cancel_delayed_work_sync(&ptp_ctx->mt_timer);
>> +	cancel_work_sync(&ptp_ctx->sync_work);
> 
> You need to use the 'disable_' variant of the above helper, to avoid the
> work being rescheduled by the last iteration.
> 

Ok, will use new helpers.

Thanks!
Wen Gu

> Other than that LGTM, thanks.
> 
> Paolo


