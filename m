Return-Path: <netdev+bounces-129144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B20897DD49
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 14:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC941F21853
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 12:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2267516C6A6;
	Sat, 21 Sep 2024 12:53:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489CC13A884;
	Sat, 21 Sep 2024 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726923221; cv=none; b=YPISZ3cXVUcgl0tyTCTa+lEVXMYklvj3iKEH2lFx+dZmXdaywSMIQPC9vF6gfQ+Ubiactq8KLUOASSkS6LQuT9DwWttIwWEu9dN1l/aGRpI8eSz+pkj3OJUhsa61FdGz8pCIipt0NnrxEHNzT3vQpaWyfIMbSfxRWgtI/wTd4v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726923221; c=relaxed/simple;
	bh=sVVc6Io7LOqjEWZQZ81U4xPQK8aE5utAl5Ey3hBZSWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=IM79TryraYNwjSa/hfkC6rmMyp2lmCC3vXtbIbsNGbxJMi3TVroQX3FsgWs8rJY1rMEqE09FcZM8GM2wKBzOBJLDnGjN92sxDQrbwFYm1SYkWbKn01FzMZLudbJQWL8pESA53RClqqkksgu8V8OVkWhryh5U3kBTaImEyRs7Ehg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5aef34.dynamic.kabel-deutschland.de [95.90.239.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4670161E5FE05;
	Sat, 21 Sep 2024 14:52:56 +0200 (CEST)
Message-ID: <7e2c75bf-3ec5-4202-8b69-04fce763e948@molgen.mpg.de>
Date: Sat, 21 Sep 2024 14:52:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 2/2] igbvf: remove unused spinlock
To: Wander Lairson Costa <wander@redhat.com>
References: <20240920185918.616302-1-wander@redhat.com>
 <20240920185918.616302-3-wander@redhat.com>
Content-Language: en-US
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240920185918.616302-3-wander@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Wander,


Thank you for your patch.

Am 20.09.24 um 20:59 schrieb Wander Lairson Costa:
> tx_queue_lock and stats_lock are declared and initialized, but never
> used. Remove them.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

It’d be great if you added a Fixes: tag.

> ---
>   drivers/net/ethernet/intel/igbvf/igbvf.h  | 3 ---
>   drivers/net/ethernet/intel/igbvf/netdev.c | 3 ---
>   2 files changed, 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igbvf/igbvf.h b/drivers/net/ethernet/intel/igbvf/igbvf.h
> index 6ad35a00a287..ca6e44245a7b 100644
> --- a/drivers/net/ethernet/intel/igbvf/igbvf.h
> +++ b/drivers/net/ethernet/intel/igbvf/igbvf.h
> @@ -169,8 +169,6 @@ struct igbvf_adapter {
>   	u16 link_speed;
>   	u16 link_duplex;
>   
> -	spinlock_t tx_queue_lock; /* prevent concurrent tail updates */
> -
>   	/* track device up/down/testing state */
>   	unsigned long state;
>   
> @@ -220,7 +218,6 @@ struct igbvf_adapter {
>   	/* OS defined structs */
>   	struct net_device *netdev;
>   	struct pci_dev *pdev;
> -	spinlock_t stats_lock; /* prevent concurrent stats updates */
>   
>   	/* structs defined in e1000_hw.h */
>   	struct e1000_hw hw;
> diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
> index 925d7286a8ee..02044aa2181b 100644
> --- a/drivers/net/ethernet/intel/igbvf/netdev.c
> +++ b/drivers/net/ethernet/intel/igbvf/netdev.c
> @@ -1656,12 +1656,9 @@ static int igbvf_sw_init(struct igbvf_adapter *adapter)
>   	if (igbvf_alloc_queues(adapter))
>   		return -ENOMEM;
>   
> -	spin_lock_init(&adapter->tx_queue_lock);
> -
>   	/* Explicitly disable IRQ since the NIC can be in any state. */
>   	igbvf_irq_disable(adapter);
>   
> -	spin_lock_init(&adapter->stats_lock);
>   	spin_lock_init(&adapter->hw.mbx_lock);
>   
>   	set_bit(__IGBVF_DOWN, &adapter->state);

With that addressed:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

