Return-Path: <netdev+bounces-247210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D002FCF5CC8
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 23:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EA96300A98B
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 22:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF2C275AE4;
	Mon,  5 Jan 2026 22:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GSdG8/lj"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EC126ED35
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767651491; cv=none; b=FZVmQeNJDnpQps2WFD6cHCDXBNZOHd7QGTsXsEOClDd4Plhag4M7+mHdPerohSdcWi/CmzfFnRqHakyip5nkNgY7m7juVjS1O2tREV+5omUhyaZEXvZ1PYBy8bozFWU6Mo2oa7RmB6yUUKQWD7Ws2YanXTSns8UePKhrx+QZ2mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767651491; c=relaxed/simple;
	bh=ELJlN/aW98z3hyRwapUzHBjZko0gXZYuSJwENDaaCzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNBSdH1Zh8K5liC6SJqQfHhrhhWXooFbkmjuEkc58HU1LFqmH8+6MC1WHvzyaR5M3uppF/Hj+WobBYlIlcK5XDTNzc/qpe85yms6EF0805gU0kuUVwQmNQiaCdE7RcDXlm2LNHhgfV66Sw9BO+tKMTckU5SmC2GGH6WEQ0swsM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GSdG8/lj; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <312f85f4-119c-4e8c-aeac-1d7f0a04d6c8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767651487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnWAk0xQ4Jp8hS+DlmhPjGukEOU41gWTSA2XVWtsD5E=;
	b=GSdG8/ljcCy/m2jnGL9esXxJDb+VwiS2WYFXB7PBv9sO4CD0gelW9eBvAsz5tvXMG6nJjf
	YOD5Llwj6KsFM6TARYWrc6ut+tOATaUmGZhLAPrFqDSLap8ynWqQG2VevDY3wRKRUzEDoZ
	VCXiYCDnIDv+61y7Wp+YHjfpDFHtu4I=
Date: Mon, 5 Jan 2026 22:18:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/6] bnxt_en: Add PTP .getcrosststamp() interface
 to get device/host times
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Somnath Kotur <somnath.kotur@broadcom.com>
References: <20260105215833.46125-1-michael.chan@broadcom.com>
 <20260105215833.46125-3-michael.chan@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260105215833.46125-3-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/5/26 21:58, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> .getcrosststamp() helps the applications to obtain a snapshot of
> device and host time almost taken at the same time. This function
> will report PCIe PTM device and host times to any application using
> the ioctl PTP_SYS_OFFSET_PRECISE. The device time from the HW is
> 48-bit and needs to be converted to 64-bit.
> 
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> v2: Add check for x86 support
> 
> v1: https://lore.kernel.org/netdev/20251126215648.1885936-8-michael.chan@broadcom.com/
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +
>   drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 47 +++++++++++++++++++
>   3 files changed, 50 insertions(+)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

