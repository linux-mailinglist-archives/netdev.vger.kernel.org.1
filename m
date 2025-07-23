Return-Path: <netdev+bounces-209287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F77B0EE95
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 11:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765831AA4DB2
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9A7285C8C;
	Wed, 23 Jul 2025 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dFRM+tpN"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C824284694
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753263467; cv=none; b=KbTOVus+Ccf3JuPwmYi6yLS5bX1Z4ZKsDckgq/W+0s9j0tvNsIOvzJXRZ0vwpMqnGxmAbUtsU2vO4GBZ7NWIsdKDUHpXJPidBr0N2gQGuuC+NFMRj+5FoSWvQAA8OF2KpG+KyB+RaVwJD8H+5goWzxVmKAGuY5FhrWBHFFDQ1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753263467; c=relaxed/simple;
	bh=Q66xsA1c5vWlizutLgsD2be+4pQ8rZeycqCEKNYGQIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iz2cJBRKMMl0HmECFcIVBgnlOpq1Dxd4zbJb9axYFOk1xbpczqjJmP5KQ3QgmmQw1w/OJA8A6kilT4zp1wnukFLdHabeKCPnavea0lyvlFlL8MojSCR01vSPxwohXZ819Ao7OkELR/AcrS6H4YWpUVQQFAVXWF1xzsdaj38k5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dFRM+tpN; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b33f5cee-d3de-4cbd-8eeb-214ba6b42cb7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753263453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BmHpTBjJA4deSSRvm8BefbJLyr67VvXXsw2bU3lFe7g=;
	b=dFRM+tpNPT7p9UgKAuDbizJDaaH7rRV5TdcekszlC1wNKSxpudvxz2O8QJjjxFzAJ8pUph
	+oMTfP+kdVMDtA8N4roTeDqLrTRrH/XHJNG/yjF0Qm9cFxyOrzhb768pZm0C5864VeuWdL
	qYoHBAYxPwRzcSHhwZvYtt/gOhSRZsc=
Date: Wed, 23 Jul 2025 10:37:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] pch_gbe: Add NULL check for ptp_pdev in pch_gbe_probe()
To: Chenyuan Yang <chenyuan0y@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, mingo@kernel.org,
 tglx@linutronix.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250723034105.2939635-1-chenyuan0y@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250723034105.2939635-1-chenyuan0y@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/07/2025 04:41, Chenyuan Yang wrote:
> Since pci_get_domain_bus_and_slot() can return NULL for PCI_DEVFN(12, 4),
> add NULL check for adapter->ptp_pdev in pch_gbe_probe().
> 
> This change is similar to the fix implemented in commit 9af152dcf1a0
> ("drm/gma500: Add NULL check for pci_gfx_root in mid_get_vbt_data()").
> 
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> ---
>   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> index e5a6f59af0b6..10b8f1fea1a2 100644
> --- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> +++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> @@ -2515,6 +2515,11 @@ static int pch_gbe_probe(struct pci_dev *pdev,
>   		pci_get_domain_bus_and_slot(pci_domain_nr(adapter->pdev->bus),
>   					    adapter->pdev->bus->number,
>   					    PCI_DEVFN(12, 4));
> +	if (!adapter->ptp_pdev) {
> +		dev_err(&pdev->dev, "PTP device not found\n");
> +		ret = -ENODEV;
> +		goto err_free_netdev;
> +	}

Why is this error fatal? I believe the device still can transmit and
receive packets without PTP device. If this situation is really possible
I would suggest you to add checks to ioctl function to remove
timestamping support if there is no PTP device found

>   
>   	netdev->netdev_ops = &pch_gbe_netdev_ops;
>   	netdev->watchdog_timeo = PCH_GBE_WATCHDOG_PERIOD;


