Return-Path: <netdev+bounces-229177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDBABD8E25
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BFCE3E351D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66892FC881;
	Tue, 14 Oct 2025 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F979ODvi"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E3325487B
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439960; cv=none; b=sSq+gUNer84Txd0dCAtsHtkz2mx+n26RvgxZeWXoLljvux5g3/mkTXd6LxmH/RfMJX0LDT8eKDTSzEogpq5YqUrJFmeTSWqB0PAG8xpWyy4nj2tYaVoY8tAlHDqbIuVHXf1ymyKygml6yvUZ1OMP8tlia9X08f9M0P4+ZLXJVyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439960; c=relaxed/simple;
	bh=SXEdUPXtMShsUsolJ8h/39la6QrRti+0/FCNR3ras7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2D4B5muXsXDfWrPBoTIySL+VLZ0q/f6wdtdjud0p81wXk/Vv+grdAXP/+DSApZJgTnKcFsW7SvojQmkzSv26nikEIs4ykWHtopvDK5wHEdDDauoEa1Z7318DCvOwA/YqDjUPbLh5e7cF5iS6itjsLCryK9ugYweVK6jVM3nH8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F979ODvi; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4ffafe38-3521-4af6-810b-d9fbfe0e2020@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760439956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWILKLJNQQnX38nP5u6X+CFbegKFJ5Dyzwex198U54Q=;
	b=F979ODviSh822ftjMIKqbO50tHNv2vwZUkCaAO9Fds83nEAWBy32vsMWWxdHvXTkO/3vbS
	uh4eWUAGzIP9dRLA/TnlLITMRIqYo1uBndBZuginlRHixozgcHaXIp/KRB0MozaAfjhMxe
	xjMQfkhnLtAUz+leDP5blF6KBe1NGWk=
Date: Tue, 14 Oct 2025 12:05:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] r8152: Advertise software timestamp information.
To: rawal.abhishek92@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: arawal@redhat.com, jamie.bainbridge@gmail.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251014055234.46527-1-rawal.abhishek92@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251014055234.46527-1-rawal.abhishek92@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14/10/2025 06:52, rawal.abhishek92@gmail.com wrote:
> From: Abhishek Rawal <rawal.abhishek92@gmail.com>
> 
> Driver calls skb_tx_timestamp(skb) in rtl8152_start_xmit(), but does not advertise the capability in ethtool.
> Advertise software timestamp capabilities on struct ethtool_ops.
> 
> Signed-off-by: Abhishek Rawal <rawal.abhishek92@gmail.com>
> Reviewed-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> ---
>   drivers/net/usb/r8152.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 44cba7acfe7d9bfbcc96a1e974762657bd1c3c33..f896e9f28c3b0ce2282912c9ea37820160df3a45 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -9311,6 +9311,7 @@ static const struct ethtool_ops ops = {
>   	.set_ringparam = rtl8152_set_ringparam,
>   	.get_pauseparam = rtl8152_get_pauseparam,
>   	.set_pauseparam = rtl8152_set_pauseparam,
> +	.get_ts_info = ethtool_op_get_ts_info,
>   };
>   
>   static int rtl8152_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

