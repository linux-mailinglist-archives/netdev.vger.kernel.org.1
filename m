Return-Path: <netdev+bounces-159352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFDEA153AE
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 17:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838BB188B711
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 16:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886E419D092;
	Fri, 17 Jan 2025 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="irlFD+LH"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117EE13CA81
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737129824; cv=none; b=VtBYCbVwKNzlZxnMGe7lvvxjauscsYJxjlZOTLZPGJ20AOgn2BMjeW0yxfSz8MNfYU9WCocWPR5Uy0Vzs1sw+oSu+mJXjmAUlwk7fwLtPgYQuyldOWPP4QO8o+QrwwA1rLK3pPsCoshhpreLJEEezFNSUHFEHcejoGHyhl7xY4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737129824; c=relaxed/simple;
	bh=M6Shu4apvhl9uI8Sjly+/pQFSAZeH6Fu3jETQYaNYPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZhfEkP6tluvPgqK2uAzWY1chbTP0OwG2/qVkxMh0Uf5Go3eWGiQMmc78M2y7NHnAE9eS09VS0kWzUlzd/RWNri1yuzMxKHbxU5Xbiq/yUYQBsHabf2xbS5J5KnzlSwR0zZDIMq8rv2VlzUrNYwescPa7fA1JGZqR5c0k/MhTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=irlFD+LH; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <df736add-784b-40c8-9982-ed8821a8bcb6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737129818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4oRBQwoB/XNbmuywEqFIlHrwwfxoygNfyYaNW7wDjqA=;
	b=irlFD+LHNbI33wRBfCvOrTE2gHN0/xk0o2QeRbHJPFbm6mLz2bWayz63jn1QnsH509XNkb
	YJTkv09h8Fpya5Rred4Q3QlJP7vXd/6boR8lPB31GmW1ETdEOlwYvHx4zvlxIb7wC1l5rk
	GS0SOZ35sG1uHGMSgzVdKlcxDc7V4/M=
Date: Fri, 17 Jan 2025 16:03:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 1/4] net: wangxun: Add support for PTP clock
To: Richard Cochran <richardcochran@gmail.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, horms@kernel.org,
 jacob.e.keller@intel.com, netdev@vger.kernel.org, mengyuanlou@net-swift.com
References: <20250117062051.2257073-1-jiawenwu@trustnetic.com>
 <20250117062051.2257073-2-jiawenwu@trustnetic.com>
 <9390f920-a89f-43d3-a75f-664fd05df655@linux.dev>
 <Z4p8ZuQaUe86Em9_@hoboy.vegasvil.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <Z4p8ZuQaUe86Em9_@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/01/2025 15:51, Richard Cochran wrote:
> On Fri, Jan 17, 2025 at 02:15:01PM +0000, Vadim Fedorenko wrote:
> 
>> there is no way ptp_clock_register() will return NULL,
> 
> Really?
> 
> include/linux/ptp_clock_kernel.h:
> 
>   400 static inline struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>   401                                                    struct device *parent)
>   402 { return NULL; }
> 
> Also, sometimes the kernelDoc comments are correct, like in this case:
> 
>   304 /**
>   305  * ptp_clock_register() - register a PTP hardware clock driver
>   306  *
>   307  * @info:   Structure describing the new clock.
>   308  * @parent: Pointer to the parent device of the new clock.
>   309  *
>   310  * Returns a valid pointer on success or PTR_ERR on failure.  If PHC
>   311  * support is missing at the configuration level, this function
>   312  * returns NULL, and drivers are expected to gracefully handle that
>   313  * case separately.
>   314  */
> 
> 
> Thanks,
> Richard

Well, yes, this case is a special one. Then maybe it's better to adjust
Kconfig and Makefile to avoid it?

