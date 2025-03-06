Return-Path: <netdev+bounces-172408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A9AA547C4
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0A216EB08
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA621FE476;
	Thu,  6 Mar 2025 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mpXhhjB7"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB3F200B9B
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256907; cv=none; b=t8khZWoCrJIypkPdcw2HouRYu9IhBkA0nv2cJ6s0vG8oTov9Z/YyVEffnTEwDprdF3wP8jL981i9ALlyihbHwJD9/cPi5vy73TCx7SJTeUsfsapX3WlY3KvjUSEKtUgP597I2sVxCi1ay+22fRft5gB/buUnNz+zRpJ0Il+4nts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256907; c=relaxed/simple;
	bh=qI8it5A5hlwyHuUSeuaxgIYo1Ohc1NWkDcH6Dn5NCdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGdzl23PL2Du4qjSKetGgeawc5EpIVv6o2GKfQnfNbxO9nlYF0cAOlc5GqkYBHJomjkBv/J2m1oM5sF9QxIsdeksrFkEtX4Sk1cy2+56sMclAeQRCqshRRRR5JX/4Z0xh8ELc59YaT5T4GweSjWbIcxdJp7/fkA0Gtm1g4sQUZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mpXhhjB7; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6b4c0c8f-8d3a-4e10-840f-7f2fa1bc8800@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741256903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqWU0pywSUoU0LqWrGdm1CtIEy9jCGEQBVNyKe4FV4o=;
	b=mpXhhjB77skez3U0Dqjj8qBhagUhFdG0P5QdWkme940gWN7wKyYbLhQkkPUtt7auyoiNIM
	uFWxa84h9QxNhDghxTFH+wblg9cEs0doLCTFSRBWr6vlpUeOUMQKhkbEtrLtZlW8sSzbs9
	eBQd1AWoEKNCnkTIw9v/SghrYyOSquI=
Date: Thu, 6 Mar 2025 10:28:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ptp: ocp: Remove redundant check in _signal_summary_show
To: Ivan Abramov <i.abramov@mt-integration.ru>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20250305092520.25817-1-i.abramov@mt-integration.ru>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250305092520.25817-1-i.abramov@mt-integration.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/03/2025 09:25, Ivan Abramov wrote:
> In the function _signal_summary_show(), there is a NULL-check for
> &bp->signal[nr], which cannot actually be NULL.
> 
> Therefore, this redundant check can be removed.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
> ---
>   drivers/ptp/ptp_ocp.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index b651087f426f..34c616bd0a02 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -3959,9 +3959,6 @@ _signal_summary_show(struct seq_file *s, struct ptp_ocp *bp, int nr)
>   	bool on;
>   	u32 val;
>   
> -	if (!signal)
> -		return;
> -
>   	on = signal->running;
>   	sprintf(label, "GEN%d", nr + 1);
>   	seq_printf(s, "%7s: %s, period:%llu duty:%d%% phase:%llu pol:%d",

Thanks,

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

