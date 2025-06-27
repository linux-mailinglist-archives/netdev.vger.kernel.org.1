Return-Path: <netdev+bounces-201885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B466AEB594
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 12:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873C24A4FAA
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D9829992E;
	Fri, 27 Jun 2025 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XHxE/uur"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5138A213245
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021966; cv=none; b=CsTL7SuZJCBMioTbTnKLPIuXRBAPBP9NzX/0h1B0RATtW6ymAuEQ0t7N07JSkRh7r8Kdq/hU5fOOrAlRGplxCHKQxXuiDM5krQBoBXTHkKh16H0OjKZW7cDaWJ3+jkATf4K5eWxHOptTjqdDzi7h61q4kdWzrL+ULuhhAeHJrqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021966; c=relaxed/simple;
	bh=39gN++uwgGwGLSo2gokp672iTbncWZeBhi5bw8aVGIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KcVcBnUCqhPrcfBL6jApXmazX+WpRRgs25pCh/QluZUrFPM2NvHwkCq7Yrg+Fi5RQb/+sZsVb1dr2rA+rb0eg4xYFlg0jMnzqPQvWclri5EdKtg4PPy+h2Z39ByfA5GR/G9lSEjOwwoV83P/hLLuGl2xiBWmKJ0Swz9QMTsHAnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XHxE/uur; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <99debaac-3768-45f5-b7e0-ec89704e39eb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751021962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JjguqjJZC4qCc9HtUNpoE0e/vnTdVxVLwPIy2Ll+L7w=;
	b=XHxE/uur93hLzj36h+LmCV8eehMuMM7Cq6rRf3AJmJ4uIK9hPJcLBSXXD/LJM61yoo9xcp
	O23Yiuv8UkhzT5JrwnUQ2mqaF9qidQBtUCpHllOE1yZkBSbrHJJlpJeaQA9AQx+bK9f05R
	AZZsSv9TQ0NrHWHJH8aUizEQbuRMxY4=
Date: Fri, 27 Jun 2025 11:59:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] ptp: add Alibaba CIPU PTP clock driver
To: Andrew Lunn <andrew@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250627072921.52754-1-guwen@linux.alibaba.com>
 <0b0d3dad-3fe2-4b3a-a018-35a3603f8c10@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <0b0d3dad-3fe2-4b3a-a018-35a3603f8c10@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 27/06/2025 08:57, Andrew Lunn wrote:

>> +static int ptp_cipu_enable(struct ptp_clock_info *info,
>> +			   struct ptp_clock_request *request, int on)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int ptp_cipu_settime(struct ptp_clock_info *p,
>> +			    const struct timespec64 *ts)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int ptp_cipu_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int ptp_cipu_adjtime(struct ptp_clock_info *ptp, s64 delta)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
> 
> I've not looked at the core. Are these actually required? Or if they
> are missing, does the core default to -EOPNOTSUPP?
> 

I was going to say that these are not needed because posix clocks do
check if callbacks are assigned and return -EOPNOTSUPP if they are not.
That's why ptp_clock_* functions do call these callbacks without checks.

