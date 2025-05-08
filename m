Return-Path: <netdev+bounces-189045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CBFAB0094
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 18:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461EC179C38
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEEB283146;
	Thu,  8 May 2025 16:40:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052E378F32;
	Thu,  8 May 2025 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746722452; cv=none; b=No4ksBXwqaNYlJb1eYqivfPFJVPZ9RVfg6KKd8PfUJGN+iX3G6xnelYEqFIhyia4TBwbQjkxEIcf+PVyL8SSjg2oVM9gLpEhpGWEZWZH+OT6vA57py00P6fO6KJbQFXgqKMJwjjA9xQJ+2Bf28X3xj2rgBrqDi4k+XnoZhcVd5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746722452; c=relaxed/simple;
	bh=JcfkLXi4OXLFFiEXO9+/CIIzo5G/jTTXDJTLclvLOuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKzsB+LRXr8McQ4rhU70RIk4sKzlKXo/pDafdm2+wt18A3Z0aJ3YsmfaG2Mjo47ZvI2UriQcg1q4KEPQmOIr69AKfeAKDnksSn5RJU357vSJvSOa6+2Uq9d9GpwL+a4f7FxzP5ctAJQiWFfHJSQm6lvNcq+uMwldjQg39IMwy6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.107] (p57bd98e4.dip0.t-ipconnect.de [87.189.152.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4CE8A61E6479C;
	Thu, 08 May 2025 18:39:48 +0200 (CEST)
Message-ID: <8a9fda50-6040-4cca-b99f-46bb9258a6f0@molgen.mpg.de>
Date: Thu, 8 May 2025 18:39:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v1] e1000e: Replace schedule_work with
 delayed workqueue for watchdog.
To: Jagadeesh Yalapalli <jagadeesharm14@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jagadeesh <jagadeesh.yalapalli@einfochips.com>
References: <20250508061439.8900-1-jagadeesharm14@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250508061439.8900-1-jagadeesharm14@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Jagadeesh,


Thank you for your patch.

Am 08.05.25 um 08:14 schrieb Jagadeesh Yalapalli:
> From: Jagadeesh <jagadeesh.yalapalli@einfochips.com>

Is this your full name, or should *Jagadeesh Yalapalli* be used?

     git config --global user.name "Jagadeesh Yalapalli"

> 
>      Replace direct schedule_work() usage with queue_delayed_work() to allow
>      better timing control for the watchdog task. This resolves potential
>      race conditions during interface reset operations.

What error do you get (without your patch)?

>      - Added watchdog_wq workqueue_struct and watchdog_dq delayed_work
>      - Updated e1000_watchdog() to use queue_delayed_work()
>      - Removed obsolete TODO comment about delayed workqueue
> 
>      Tested in Qemu :
>      / # for i in {1..1000}; do
>      >     echo 1 > /sys/class/net/eth0/device/reset
>      >     sleep 0.1
>      > done
>      [  726.357499] e1000e 0000:00:02.0: resetting
>      [  726.390737] e1000e 0000:00:02.0: reset done

Please do not copy the output of git show, but send the patch with `git 
format-patch` and `git send-email`.

> Signed-off-by: Jagadeesh <jagadeesh.yalapalli@einfochips.com>
> ---
>   drivers/net/ethernet/intel/e1000e/e1000.h  | 2 ++
>   drivers/net/ethernet/intel/e1000e/netdev.c | 3 +--
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
> index ba9c19e6994c..1e7b365c4f31 100644
> --- a/drivers/net/ethernet/intel/e1000e/e1000.h
> +++ b/drivers/net/ethernet/intel/e1000e/e1000.h
> @@ -194,6 +194,8 @@ struct e1000_adapter {
>   	struct timer_list blink_timer;
>   
>   	struct work_struct reset_task;
> +	struct workqueue_struct *watchdog_wq;
> +	struct delayed_work watchdog_dq;
>   	struct work_struct watchdog_task;
>   
>   	const struct e1000_info *ei;
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 8ebcb6a7d608..87a915d09f4e 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -5178,9 +5178,8 @@ static void e1000_watchdog(struct timer_list *t)
>   	struct e1000_adapter *adapter = from_timer(adapter, t, watchdog_timer);
>   
>   	/* Do the rest outside of interrupt context */
> -	schedule_work(&adapter->watchdog_task);
> +	queue_delayed_work(adapter->watchdog_wq, &adapter->watchdog_dq, 0);
>   
> -	/* TODO: make this use queue_delayed_work() */
>   }
>   
>   static void e1000_watchdog_task(struct work_struct *work)


Kind regards,

Paul

