Return-Path: <netdev+bounces-162571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED19A273F5
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55478169537
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BE6215055;
	Tue,  4 Feb 2025 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xp/KHitl"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943B214A84
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677613; cv=none; b=pJsOQ+9mtfEinnODcRbqGb923yyfxJT095AkQX5efwUwS0QoKqcdfpLx8zzgnIaiwB9xnNCplgEneZHDLALXv5V5oJAkh6eFY6B8jmiyRp7liH7g5ErIdeNES0/pGMUSmvSKNFEdsDXLvt+o9DmbekBZlsiJ+EdCOH+0Bcu+CoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677613; c=relaxed/simple;
	bh=H2dqxb1Sz88HzAOTntMVJjR18R9jlbZxS7s0Pa/uYt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYboIJ4D33lgTev0TVs9i/dJfBkxhwmbzgjrVapWlVcY5ASvh3EluwnfdgVPPC+DqxkYRwKuFKWKhyU5Kfz30UDgdN6IPqnNuB6/tKazKP3JUo/4YmAE+SlAFa2+EObxXnGrdO4/USuzP5SPvoWee7Z6O01YSH8CE6vDTJDPa5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xp/KHitl; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <16199c68-3a65-456f-8d52-9a98be3d73f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738677609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZYDnDLUKi7bxWkgiLPMmgIvqJsM+fRlwM/bXWBTMlE=;
	b=xp/KHitlFO2w6LEHZM5+iK6AhmEHnwtpWZb5niHUn3W0dzPXWkblxrmk7l0WsBRZ2a67nP
	bGgbqC7J7coZoJl0s2T3wIxKDvyha4JsLTNlLK/QW+YsRT2u8erB8tcQuFSkP63DoBC1eO
	JIFjbkdWvtMWMY4wZNrn23jwJWRDXzw=
Date: Tue, 4 Feb 2025 14:00:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Intel-wired-lan] [PATCH] net: e1000e: convert to
 ndo_hwtstamp_get() and ndo_hwtstamp_set()
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 Piotr Wejman <piotrwejman90@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250202170839.47375-1-piotrwejman90@gmail.com>
 <32579b22-a213-4e97-a816-66d0bb301f92@molgen.mpg.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <32579b22-a213-4e97-a816-66d0bb301f92@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 03/02/2025 16:41, Paul Menzel wrote:
> Dear Piotr,
> 
> 
> Thank you for your patch.
> 
> Am 02.02.25 um 18:08 schrieb Piotr Wejman:
>> Update the driver to the new hw timestamping API.
> 
> Could you please elaborate. Maybe a pointer to the new API, and what 
> commit added it, and what tests were done, and/or are needed?

The new API was added in 66f7223039c0 ("net: add NDOs for configuring
hardware timestamping") back in 2023, the old ioctl interface is in
deprecated state now.

> 
>> Signed-off-by: Piotr Wejman <piotrwejman90@gmail.com>
>> ---
>>   drivers/net/ethernet/intel/e1000e/e1000.h  |  2 +-
>>   drivers/net/ethernet/intel/e1000e/netdev.c | 52 ++++++++--------------
>>   2 files changed, 20 insertions(+), 34 deletions(-)
> 
> 
> Kind regards,
> 
> Paul


