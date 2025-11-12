Return-Path: <netdev+bounces-237994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9893C528B4
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7463B96E8
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 13:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61A13376A0;
	Wed, 12 Nov 2025 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V+0H9syV"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F146BF
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954578; cv=none; b=NjLUf0T5Pq14dFVA7bs6HO1Pv24TV/NswKhTedAFPYY1GwA4tuzoBLyPzs+pbX2CngqyJ3NuD4QCVluYy0jDjFKErg5gMxH00r046KDcyrA6xEzXe6sSZufZ2WCx+Z9CDEVIq8xm0z+JokfTnf/gmKfTUAlg4sIc+fpKvJ3+gh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954578; c=relaxed/simple;
	bh=yEdtEk4Y1pGalLRJ66amY8wYXlb4o1bTksU55cAXcOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQV4NcKM4YMMwkQ7HBBdRVYOm70vGnLY4PurOuuh9D9bDPYkE8VfPCHNr9DEqOGQBHRK4UZs6ceJt+LzCzSTfiAsQX0stQS47Z30XMg7+PFbqnCOVRCpFD+08iTpS9RzOLq2EgaLBmIq9VLGvMVain6bQHb3aVkspPPho0ug3d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V+0H9syV; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <04628c49-e92f-4787-931b-c1b37611da00@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762954574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jFC9ij4kYE1838JfCsZsrgKXBw2RNJhomIfr8pgmAvc=;
	b=V+0H9syVFeUsVy2hRpWnKU6rJGuZlUEPRg2So67OycVHizxld1lAYoagsEWe1btT0UWwDh
	xy9/+GniM/tOXHwpnC3qjfXbLpWpofzML21jvoUZtHEBVSlLjw4T7CEAVHNpTPTdwjLaEw
	iTreEGuZuZmhcvOwzhS7Pzwok+cQZns=
Date: Wed, 12 Nov 2025 13:36:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v1 4/7] ptp: ocp: Apply standard pattern for
 cleaning up loop
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20251111165232.1198222-1-andriy.shevchenko@linux.intel.com>
 <20251111165232.1198222-5-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251111165232.1198222-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/11/2025 16:52, Andy Shevchenko wrote:
> The while (i--) is a standard pattern for the cleaning up loops.
> Apply this pattern where it makes sense in the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/ptp/ptp_ocp.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 1dbbca4197bc..67a4c60cbbcd 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -4821,8 +4821,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   
>   	return 0;
>   out_dpll:
> -	while (i) {
> -		--i;
> +	while (i--) {
>   		dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);
>   		dpll_pin_put(bp->sma[i].dpll_pin);
>   	}

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

