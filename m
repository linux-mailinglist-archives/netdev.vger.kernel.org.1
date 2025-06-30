Return-Path: <netdev+bounces-202383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C62AEDACB
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 228DD7A7BC9
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348582580FB;
	Mon, 30 Jun 2025 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PV9lopcf"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4757724467A;
	Mon, 30 Jun 2025 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751282637; cv=none; b=FhwSJQf05PDr4YuQDBevzW0a3ppQVd7qXSQjT+7WyTERNoL5lp9WkXCIIFhx73N+VE2migjGQ4HF0bjUXAWKm1Lgt+2HCQdvEEdS7uGR+s2A/6nXer6SNG0IDJwokWA33uv2UnqL5H7yKLtBicIOOkZ/kw/5feO/OOUkPo9Zpcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751282637; c=relaxed/simple;
	bh=aBMCVDnfYyty8SNzfmAEaV6AVMGfaRiFDoCm+qZ/g1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzd2pLuBNKjdJ5BnJwUGUhKH1i9NTyk6+vwFCj3P39gs/mRYJd1TUqLC5mg/0FjbU6Kts+6vmEsI/jNf3yJm2Yo24t77XgTas9mWIB1Y++ZIcCZLP6jRQkKvApbbthvKizcQP/7vK3KXNYaB4P/IlW+eyNeEYRQ3m1kgJjRtQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PV9lopcf; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751282630; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BfH8Hrzvd1gCdLyLYHKn/jiJuwKhUgQolaRTiwi77X8=;
	b=PV9lopcfDd2/2/bigEgboPIslWJyF9BYEV1Sg+Ym4Z9feOkfJzjWF622rVH/adeVlCvRss/2FxBSKQSUaXy3IEjLPUd+r2G0jnrnE7ZEoQVvGO49EPEIE13Vl4ZvMkceKPCByTbLWhGxLmQ6p/zv4HRGh4NwQmVRDOWu9kZw9RU=
Received: from 30.221.128.140(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WgBiejV_1751282629 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Jun 2025 19:23:50 +0800
Message-ID: <ea85f778-a2d4-439c-abbd-2a8ecea0e928@linux.alibaba.com>
Date: Mon, 30 Jun 2025 19:23:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ptp: add Alibaba CIPU PTP clock driver
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250627072921.52754-1-guwen@linux.alibaba.com>
 <0b0d3dad-3fe2-4b3a-a018-35a3603f8c10@lunn.ch>
 <99debaac-3768-45f5-b7e0-ec89704e39eb@linux.dev>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <99debaac-3768-45f5-b7e0-ec89704e39eb@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/6/27 18:59, Vadim Fedorenko wrote:
> On 27/06/2025 08:57, Andrew Lunn wrote:
> 
>>> +static int ptp_cipu_enable(struct ptp_clock_info *info,
>>> +               struct ptp_clock_request *request, int on)
>>> +{
>>> +    return -EOPNOTSUPP;
>>> +}
>>> +
>>> +static int ptp_cipu_settime(struct ptp_clock_info *p,
>>> +                const struct timespec64 *ts)
>>> +{
>>> +    return -EOPNOTSUPP;
>>> +}
>>> +
>>> +static int ptp_cipu_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
>>> +{
>>> +    return -EOPNOTSUPP;
>>> +}
>>> +
>>> +static int ptp_cipu_adjtime(struct ptp_clock_info *ptp, s64 delta)
>>> +{
>>> +    return -EOPNOTSUPP;
>>> +}
>>
>> I've not looked at the core. Are these actually required? Or if they
>> are missing, does the core default to -EOPNOTSUPP?
>>
> 
> I was going to say that these are not needed because posix clocks do
> check if callbacks are assigned and return -EOPNOTSUPP if they are not.
> That's why ptp_clock_* functions do call these callbacks without checks.

Hi Vadim, do you mean posix clock functions like this:

e.g. posix-clock.c:

static int pc_clock_settime(clockid_t id, const struct timespec64 *ts)
{
<...>
	if (cd.clk->ops.clock_settime)
		err = cd.clk->ops.clock_settime(cd.clk, ts);
	else
		err = -EOPNOTSUPP;
<...>
}

In ptp_clock.c, ops.clock_settime() is assigned to ptp_clock_settime(),
and it will call ptp->info->settime64() without checks. So I think these
'return -EOPNOTSUPP' functions are needed. Did I miss something?

Thanks!


