Return-Path: <netdev+bounces-248296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00910D06AB1
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 02:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6863E3019887
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 00:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107F91D798E;
	Fri,  9 Jan 2026 00:59:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9DB1C3C08;
	Fri,  9 Jan 2026 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767920387; cv=none; b=Yuv1D6xPembyfqyuremzzELc+on0fslss0NVrJzXSXzU4QBm+VVHCarVa1D1JbX7yJCKTYl5VvdcaFWCkCDGEGZqBKWYE4L+nEySWGxB1HOh2mx1DUCFcMgQdG8Ns7sCgqGvdVluTNMIB5LcWYxcy/CZhD1hsBoakO/M67pgOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767920387; c=relaxed/simple;
	bh=tJsci8ts5VBXOELaDP09IiliX6G1igTyzNglsc4sHV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdYEjTQjagwpXbsGpFs9pFMZguM0JvnC8IXNjkXwvtYD0NrNs29FM5waOKk3EY0I/57T2g1LPg2XMKR/pbdop+NSxl3WVKRFqXu8O7jVIY6Fn3Zt8sbtNS2OzdpV2FIrRKl8Lkev7xIG3T7cQG8xu3zNKZ15f/aXKX3x6KTtR60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 09 Jan 2026 09:59:44 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id 2C5EF20695EB;
	Fri,  9 Jan 2026 09:59:44 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Fri, 9 Jan 2026 09:59:43 +0900
Received: from [10.212.247.110] (unknown [10.212.247.110])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id 355F210A003;
	Fri,  9 Jan 2026 09:59:43 +0900 (JST)
Message-ID: <c9b009a8-7077-4c37-9ebf-33ac86720d7e@socionext.com>
Date: Fri, 9 Jan 2026 09:59:45 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: ethernet: ave: Replace udelay with
 usleep_range
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260108064641.2593749-1-hayashi.kunihiko@socionext.com>
 <20260108064641.2593749-2-hayashi.kunihiko@socionext.com>
 <20260108090514.375a23fb@pumpkin>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20260108090514.375a23fb@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 2026/01/08 18:05, David Laight wrote:
> On Thu,  8 Jan 2026 15:46:41 +0900
> Kunihiko Hayashi <hayashi.kunihiko@socionext.com> wrote:
> 
>> Replace udelay() with usleep_range() as notified by checkpatch.pl.
> 
> Nak.
> Look at the code...

Thank you for reviewing.

Indeed, since this function is called from an interrupt context,
it was not allowed to use usleep_range().

I'll keep udelay() here and close this patch.

Thank you,

---
Best Regards
Kunihiko Hayashi

