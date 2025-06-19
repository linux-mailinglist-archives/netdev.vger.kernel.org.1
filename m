Return-Path: <netdev+bounces-199441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9562AE053D
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D472189BE06
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19DF218EA8;
	Thu, 19 Jun 2025 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hX2FayJz"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567623A9A0
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335326; cv=none; b=jg1hnZfBy/RpQSvp72CjVcY1PRHNXjc94AARnTc72mojQazOzMqQQzaQNVxhyaJ00LHbwkclP1MJpUj9Sma73iVOEo1RgiRTYaNXFIRrKn11xAkP+y4LDnndKjKwLNgS4rdOyLAti1zMstk943ZPwIsvtgq7l+M/957MhXIqKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335326; c=relaxed/simple;
	bh=1ravPs/FMxL5LuoHuJXK+mU1twHGVx7Ojyt5HQnO1BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=soK/49Ae3rC0hAp6bjzAcOE5qo3vvM+xOip4AiMKLQXXOMEtyphbvCur+Ycg5KI8aHGGHKsUwXPW9Dg9Z1sCcF1ruKbng3Xn5GuddxSRb1OOv7e9WS5BAesPnR/sneccj5q2pc5k0/xd0jyHR6h8JIGuX7ANeJqyRUIKnYrh0s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hX2FayJz; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba027737-39df-4541-8fea-1c4cf489b43b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750335318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5tu14SfjOQv5TBx7EfkgfUxq/XAyStwsImnQzyxPqY=;
	b=hX2FayJz88BPRw7Yx23sBwK2HlaMWc7WrD5xufoIQxieXk3feCCpo6V78k6uSLItgcFPsE
	x1fCvcVembCR3QIZ/KPkzlmeNaDJQPeBdsqKboeVHFTrRzyFjEidyBPm5dV0OqdzEGubZP
	xApztwwVir8jr/6tE6Fqgyv28YHcjz0=
Date: Thu, 19 Jun 2025 13:15:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v11 13/14] dpll: zl3073x: Add support to get/set
 frequency on input pins
To: Paolo Abeni <pabeni@redhat.com>, Ivan Vecera <ivecera@redhat.com>,
 netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Shannon Nelson <shannon.nelson@amd.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250616201404.1412341-1-ivecera@redhat.com>
 <20250616201404.1412341-14-ivecera@redhat.com>
 <72bab3b2-bdd6-43f6-9243-55009f9c1071@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <72bab3b2-bdd6-43f6-9243-55009f9c1071@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/06/2025 12:15, Paolo Abeni wrote:
> On 6/16/25 10:14 PM, Ivan Vecera wrote:
>> +/**
>> + * zl3073x_dpll_input_ref_frequency_get - get input reference frequency
>> + * @zldpll: pointer to zl3073x_dpll
>> + * @ref_id: reference id
>> + * @frequency: pointer to variable to store frequency
>> + *
>> + * Reads frequency of given input reference.
>> + *
>> + * Return: 0 on success, <0 on error
>> + */
>> +static int
>> +zl3073x_dpll_input_ref_frequency_get(struct zl3073x_dpll *zldpll, u8 ref_id,
>> +				     u32 *frequency)
>> +{
>> +	struct zl3073x_dev *zldev = zldpll->dev;
>> +	u16 base, mult, num, denom;
>> +	int rc;
>> +
>> +	guard(mutex)(&zldev->multiop_lock);
>> +
>> +	/* Read reference configuration */
>> +	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
>> +			   ZL_REG_REF_MB_MASK, BIT(ref_id));
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Read registers to compute resulting frequency */
>> +	rc = zl3073x_read_u16(zldev, ZL_REG_REF_FREQ_BASE, &base);
>> +	if (rc)
>> +		return rc;
>> +	rc = zl3073x_read_u16(zldev, ZL_REG_REF_FREQ_MULT, &mult);
>> +	if (rc)
>> +		return rc;
>> +	rc = zl3073x_read_u16(zldev, ZL_REG_REF_RATIO_M, &num);
>> +	if (rc)
>> +		return rc;
>> +	rc = zl3073x_read_u16(zldev, ZL_REG_REF_RATIO_N, &denom);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Sanity check that HW has not returned zero denominator */
>> +	if (!denom) {
>> +		dev_err(zldev->dev,
>> +			"Zero divisor for ref %u frequency got from device\n",
>> +			ref_id);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Compute the frequency */
>> +	*frequency = base * mult * num / denom;
> 
> As base, mult, num and denom are u16, the above looks like integer
> overflow prone.
> 
> I think you should explicitly cast to u64, and possibly use a u64 frequency.

I might be a good idea to use mul_u64_u32_div together with mul_u32_u32?
These macroses will take care of overflow on 32bit platforms as well.

> 
> /P
> 


