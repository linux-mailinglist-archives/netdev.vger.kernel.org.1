Return-Path: <netdev+bounces-243328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F1BC9D311
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 23:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85D7B4E1594
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 22:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD398286405;
	Tue,  2 Dec 2025 22:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WmbHnlKr"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCB217BED0
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764713900; cv=none; b=tnXVK4BUi7t58yZ404UVokxdwXs4UugqOZnHGiTYW9yquxpzQtowhqHsvXK2FG2PJNcsbtxadD4J7VQsa8VrpBGWmbEtZ6QXU83eB+kJmd47FfG7JYaMOcu84CmjT27GmavPw/HR7+/lH5eZWLtl76TdQHiLZLVHqi/mif9BSk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764713900; c=relaxed/simple;
	bh=HWLwlI5rw/xnaZsJkqafuUEVDQ0o5XFXHRkJG3Viio8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uqlz+4AHbBCcJK48kslD39uquUiLWicV2VsqTxT9cmd6OBISm/qL09hxjaKdKIQL4f4CGqwZJ8351MkbZLekbMJgFKYcFulArfD7iXL7kU13bz6VgJJ/9VNe7LMNJsrKK27CEjHdZapiIynx6n3y9LGrT87T6BDe7ppICKf8zRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WmbHnlKr; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2969879b-c536-47b5-b03f-e5428a0db5c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764713896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lv1wdEOmm+CiaMo2wKi2zaylvvAcwapxQs+OneHFKhQ=;
	b=WmbHnlKrH616coOr7UCEIupVwdfIzQJ2satG83IwHR/1xb/BudtNU0zgyPlCTrg3Lu7FjP
	LPjBHVW8Bb+tBH/uQ+mlHkUfcN3mtppbCBeoWv7hjd8uuq3VaBgAfG4OjVxz3OXKpoYBSY
	xsgXJEpV+F99vyr22cPcy0lPPb2f5u8=
Date: Tue, 2 Dec 2025 22:18:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 7/7] bnxt_en: Add PTP .getcrosststamp() interface
 to get device/host times
To: Jakub Kicinski <kuba@kernel.org>, Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Somnath Kotur <somnath.kotur@broadcom.com>
References: <20251126215648.1885936-1-michael.chan@broadcom.com>
 <20251126215648.1885936-8-michael.chan@broadcom.com>
 <20251127185909.3bbb5da4@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251127185909.3bbb5da4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/11/2025 02:59, Jakub Kicinski wrote:
> On Wed, 26 Nov 2025 13:56:48 -0800 Michael Chan wrote:
>> +	ptm_local_ts = le64_to_cpu(resp->ptm_local_ts);
>> +	*device = ns_to_ktime(bnxt_timecounter_cyc2time(ptp, ptm_local_ts));
>> +	/* ptm_system_ts is 64-bit */
>> +	system->cycles = le64_to_cpu(resp->ptm_system_ts);
>> +	system->cs_id = CSID_X86_ART;
>> +	system->use_nsecs = true;
> 
> Non-x86 hosts exist? Also, I'd like to give Vadim F a chance to TAL
> and he's out for the rest of the week. So perhaps we can hold this
> one off until after the MW?
> 
> I'll apply up to this point in the meantime.

I did test this code, but only on x86 platform, unfortunately.


