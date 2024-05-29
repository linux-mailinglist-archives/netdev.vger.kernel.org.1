Return-Path: <netdev+bounces-99163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA028D3E2C
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 20:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB37B21F23
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761CC15B99D;
	Wed, 29 May 2024 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tAzpF/hQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA3BDDA1
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717006532; cv=none; b=DB8Z4qIocFjO8w3J+cO8GK0nHati+BB4LyAm8IbpwUkrypZKbJ85gvOCjFu+r3Ki+J+oW7qG6ESbICH4Tdmbt3yVuc5w87CKhX+prtLiNzfJwr+850xwXO8YyT+LcgMCtGe/4wmSg+2qShc8ephPMAtqRD0BbQm2Ds1k1GLkPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717006532; c=relaxed/simple;
	bh=HTLg8gpaySDZIn8hsaOA9Fcw46r5Vbl/FIqB2I6xCd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWaLIcWTLVsv3RB3PvBtdxJn98s+IYxQX9RUikvZz9NvXxmM9SYDLpd4fVURoXHcF8IVZU44XRbkUbXlVIkq5S/ny0vU4TlJyuwsg1y72Vl0ctRtz6lRprLlkcq9AVXl5tZg252dWB7roc0sxrryLsw+wtwLiJ2dBEsrHIbXCp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tAzpF/hQ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: michael.chan@broadcom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717006527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mLV8YG90+RW/NZMtQguI4MS1dEUDJxLqJpvYULeqJAM=;
	b=tAzpF/hQL9CFphPkBeGqG1kZivmYfTc9bbZ3GC7gAljdUcvH0bBh+PoKG71uYh6lx8RSO1
	u4anr2MS+hl4LyUEnlKUduUnRwDNDB3PH21+qWXtciB2MZva2pcVgzlvMpAiA2lQFkJRTP
	fUqlst/zpy/xFu6IfkUlUuQ+mVmVv5s=
X-Envelope-To: vadfed@meta.com
X-Envelope-To: davem@davemloft.net
X-Envelope-To: kuba@kernel.org
X-Envelope-To: richardcochran@gmail.com
X-Envelope-To: netdev@vger.kernel.org
Message-ID: <a26d530c-02c7-4e84-b014-561edbe0804e@linux.dev>
Date: Wed, 29 May 2024 11:15:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] bnxt_en: add timestamping statistics support
To: Michael Chan <michael.chan@broadcom.com>,
 Vadim Fedorenko <vadfed@meta.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
References: <20240529171946.2866274-1-vadfed@meta.com>
 <CACKFLi=Mf8o6hxNEEy+hKbNhi7V56hpQrwH+Vpy6SEm8z_3ipA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CACKFLi=Mf8o6hxNEEy+hKbNhi7V56hpQrwH+Vpy6SEm8z_3ipA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 29/05/2024 18:48, Michael Chan wrote:
> On Wed, May 29, 2024 at 10:19 AM Vadim Fedorenko <vadfed@meta.com> wrote:
>>
>> The ethtool_ts_stats structure was introduced earlier this year. Now
>> it's time to support this group of counters in more drivers.
>> This patch adds support to bnxt driver.
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   drivers/net/ethernet/broadcom/bnxt/bnxt.c      | 18 +++++++++++++-----
>>   .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c  | 18 ++++++++++++++++++
>>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c  | 18 ++++++++++++++++++
>>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h  |  8 ++++++++
>>   4 files changed, 57 insertions(+), 5 deletions(-)
>>
> 
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
>> index 2c3415c8fc03..589e093b1608 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
>> @@ -79,6 +79,12 @@ struct bnxt_pps {
>>          struct pps_pin pins[BNXT_MAX_TSIO_PINS];
>>   };
>>
>> +struct bnxt_ptp_stats {
>> +       u64             ts_pkts;
>> +       u64             ts_lost;
>> +       atomic64_t      ts_err;
>> +};
>> +
>>   struct bnxt_ptp_cfg {
>>          struct ptp_clock_info   ptp_info;
>>          struct ptp_clock        *ptp_clock;
>> @@ -125,6 +131,8 @@ struct bnxt_ptp_cfg {
>>          u32                     refclk_mapped_regs[2];
>>          u32                     txts_tmo;
>>          unsigned long           abs_txts_tmo;
>> +
>> +       struct bnxt_ptp_stats   *stats;
> 
> I think there is no need to allocate this small stats structure
> separately.  It can just be:
> 
> struct bnxt_ptp_stats    stats;
> 
> The struct bnxt_ptp_cfg will only be allocated if the device supports
> PTP.  So the stats can always be a part of struct bnxt_ptp_cfg.

Yeah, I was thinking about embedding the struct into bnxt_ptp_cfg.
Ok, I'll make v2 in 24hr then.

Thanks!

> Other than that, it looks good to me.  Thanks.
> 
>>   };
>>


