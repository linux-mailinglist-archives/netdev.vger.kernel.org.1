Return-Path: <netdev+bounces-215736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BCBB3012B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 19:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96A21CC47FD
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92B5310647;
	Thu, 21 Aug 2025 17:35:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033BE2D7809;
	Thu, 21 Aug 2025 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797725; cv=none; b=osODu6kzVuOptrscrmOTt+89X7KZOHgEyhF7eJB2+i4aPMogzjQzj1nL0PpbNKGceM4NApAs+AmOslYCpTu62qZf/UR0v+w81AQk3nrNLrM3zG1SjjQr08m6GgurRwl1F0Ih2pBoceyqFGt0EER1t5FXD+TiN6t0f9gYFS8fvyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797725; c=relaxed/simple;
	bh=aPvclv0g9vnYnUAytZPnrVU42LnEZXqkPtskNPhfzzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WltH0L0Ax2kL7u1K1FYiCLXXr5+pfzOCM6a6irNRRoOyZkObuGfpeNZLUJhrYg9xl2xMWQytjrdwekLo1dD3FbQvKH2KuowiwlbnOm1Xhy4Ag8BxXjCo4BoJGDvkhCQ/ZE0gAlxWVcgScoqOaTvF4Y7zDndVobS5g/wTsdg+OaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb731caaaso189908266b.0;
        Thu, 21 Aug 2025 10:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755797722; x=1756402522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdTaXNoclBnm3V2d0XiE81O/Y9Qn4e3ZUPCR5QOVshk=;
        b=GY/MSJgtd8GpVJDvCUOoeEhTcRBMohW0AhnIlyo9X34PBmGfYlAOXHSj1MEdZmPJCJ
         K5SrlKQAUbr5HR6vmkFZu3WwIkZoPGw0uW5AzqVTZ4g9kdEIL2ugg//lXYEu9edZwgoG
         Eywh8sB+Ctmk9GkFDe+emM4glFLMpoNvBWvkFVEuea2SMIFYHT4/2jypaoSbzNX8LVXO
         qH9UCaWCyV1oH/8gcaDGC2FX4eD6U/tQ7gtHqSoCvl18Po2nlrDEThn7EBcQUI4KxAIM
         8ep87X7Sz50dCKILhj1TlfvPmQMGj4BlQvgYeVV8fjc7N5ZLVAIb6zR3jAWECYHDySdB
         wZ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvJZkjjwV/DnBi2UePj9WMnpEH80YKuZcLoFj7QWe83IvcPU3lJt0zwNi4hUmdex1ym0z5m2hTXds1/74=@vger.kernel.org, AJvYcCX+Q/mNcIe7TCl7Rk9x1hQ1h1Ut0LoCOhZg/9uSSfW5403DC5sle9WlbSZLh+Qs0QuGL4DPetKA@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCMFIrAlSuWRADQE+du1fVlb/TqXlfNIKAPSWsdiELqeEabq8
	nuI9FxxjpPPLwt/HmZZkJxpjTy0V884D73DdJ0BnFIqvryCUDFzRAbul
X-Gm-Gg: ASbGnctcZgPvM7ecBu5K8YmEVeDouMIzxM66jgiEDmGUk6JYE7uDNXjTuMXxLIAghzx
	lMGupeH+VuYZ6PQkgmTWj38AJeFef0/t/3VICuZPAWc3W/5vOxY6c+YBJ296V8NA52kIa5Vyb/s
	PUL/5GUBTUpZGPOzp/5PvjQFf49FEF4mF0mOxrmqlcze5+opepTCdOuf4i5cu1UEyKPg7emIwdg
	f0+xXhs32SJiofUo03nbeVtCJHCP624e/iReJc3zn+FUR33lMefU2zsVD/n4VyrYwnXXd/l83TZ
	34pWFx6DBYB9vp5hoUyxCuLQD2+zIOMrKYH6+CHIXkcPCA2C3Tffv4iRnwCN4B55Kwhn4hwZt6o
	k9eSjfNxCCPiNiMzSMVDx1nw=
X-Google-Smtp-Source: AGHT+IG38h0qzQaDwhajilK1WG5di3o7cc5owCDcodd5pmqmSvBirCdqVup8+/dN5qmTb9Ov2XzZjQ==
X-Received: by 2002:a17:907:3f91:b0:af9:9ab0:6f3a with SMTP id a640c23a62f3a-afe07a0e699mr323158566b.23.1755797722031;
        Thu, 21 Aug 2025 10:35:22 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded309ee8sm428802266b.27.2025.08.21.10.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 10:35:21 -0700 (PDT)
Date: Thu, 21 Aug 2025 10:35:19 -0700
From: Breno Leitao <leitao@debian.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Pavel Begunkov <asml.silence@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, paulmck@kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, boqun.feng@gmail.com
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
References: <3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
 <20250815094217.1cce7116@kernel.org>
 <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
 <3dd73125-7f9b-405c-b5cd-0ab172014d00@gmail.com>
 <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
 <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
 <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>

On Thu, Aug 21, 2025 at 05:51:59AM +0200, Mike Galbraith wrote:
> On Thu, 2025-08-21 at 05:37 +0200, Mike Galbraith wrote:
> > 
> > > What is this patch you have?
> > 
> > Make boxen stop bitching at NETCONSOLE_NBCON version below.
> 
> Grr, whitespace damaged. Doesn't really matter given it's not a
> submission, but it annoys me when I meet it on lkml, so take2.
> 
> netpoll: Make it RT friendly
> 
> PREEMPT_RT cannot alloc/free memory when not preemptible, making
> disabling of IRQs across transmission an issue for RT.
> 
> Use local_bh_disable() to provide local exclusion for RT (via
> softirq_ctrl.lock) for normal and fallback transmission paths
> instead of disabling IRQs. Since zap_completion_queue() callers
> ensure pointer stability, replace get_cpu_var() therein with
> this_cpu_ptr() to keep it preemptible across kfree().
> 
> Disable a couple warnings for RT, and we're done.
> 
> v0.kinda-works -> v1:
>     remove get_cpu_var() from zap_completion_queue().
>     fix/test netpoll_tx_running() to work for RT/!RT.
>     fix/test xmit fallback path for RT.
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> ---
>  drivers/net/netconsole.c |    4 ++--
>  include/linux/netpoll.h  |    4 +++-
>  net/core/netpoll.c       |   47 ++++++++++++++++++++++++++++++++++++-----------
>  3 files changed, 41 insertions(+), 14 deletions(-)
> 
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -1952,12 +1952,12 @@ static void netcon_write_thread(struct c
>  static void netconsole_device_lock(struct console *con, unsigned long *flags)
>  {
>  	/* protects all the targets at the same time */
> -	spin_lock_irqsave(&target_list_lock, *flags);
> +	spin_lock(&target_list_lock);

I personally think this target_list_lock can be moved to an RCU lock. 

If that is doable, then we probably make netconsole_device_lock()
to a simple `rcu_read_lock()`, which would solve this problem as well.

>  static void netconsole_device_unlock(struct console *con, unsigned long flags)
>  {
> -	spin_unlock_irqrestore(&target_list_lock, flags);
> +	spin_unlock(&target_list_lock);
>  }
>  #endif
>  
> --- a/include/linux/netpoll.h
> +++ b/include/linux/netpoll.h
> @@ -100,9 +100,11 @@ static inline void netpoll_poll_unlock(v
>  		smp_store_release(&napi->poll_owner, -1);
>  }
>  
> +DECLARE_PER_CPU(int, _netpoll_tx_running);
> +
>  static inline bool netpoll_tx_running(struct net_device *dev)
>  {
> -	return irqs_disabled();
> +	return this_cpu_read(_netpoll_tx_running);
>  }
>  
>  #else
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -58,6 +58,29 @@ static void zap_completion_queue(void);
>  static unsigned int carrier_timeout = 4;
>  module_param(carrier_timeout, uint, 0644);
>  
> +DEFINE_PER_CPU(int, _netpoll_tx_running);
> +EXPORT_PER_CPU_SYMBOL(_netpoll_tx_running);
> +
> +#define netpoll_tx_begin(flags)					\
> +	do {							\
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT) ||		\
> +		    IS_ENABLED(CONFIG_NETCONSOLE_NBCON))	\
> +			local_bh_disable();			\
> +		else						\
> +			local_irq_save(flags);			\
> +		this_cpu_write(_netpoll_tx_running, 1);		\
> +	} while (0)

Why can't we just use local_bh_disable() in both cases?

> +
> +#define netpoll_tx_end(flags)					\
> +	do {							\
> +		this_cpu_write(_netpoll_tx_running, 0);		\
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT) ||		\
> +		    IS_ENABLED(CONFIG_NETCONSOLE_NBCON))	\
> +			local_bh_enable();			\
> +		else						\
> +			local_irq_restore(flags);		\
> +	} while (0)
> +
>  static netdev_tx_t netpoll_start_xmit(struct sk_buff *skb,
>  				      struct net_device *dev,
>  				      struct netdev_queue *txq)
> @@ -90,7 +113,7 @@ static void queue_process(struct work_st
>  	struct netpoll_info *npinfo =
>  		container_of(work, struct netpoll_info, tx_work.work);
>  	struct sk_buff *skb;
> -	unsigned long flags;
> +	unsigned long __maybe_unused flags;
>  
>  	while ((skb = skb_dequeue(&npinfo->txq))) {
>  		struct net_device *dev = skb->dev;
> @@ -102,7 +125,7 @@ static void queue_process(struct work_st
>  			continue;
>  		}
>  
> -		local_irq_save(flags);

It is unclear to me why we have irqs disabled in here. Nothing below
seems to depend on irq being disabled?

> +		netpoll_tx_begin(flags);
>  		/* check if skb->queue_mapping is still valid */
>  		q_index = skb_get_queue_mapping(skb);
>  		if (unlikely(q_index >= dev->real_num_tx_queues)) {
> @@ -115,13 +138,13 @@ static void queue_process(struct work_st
>  		    !dev_xmit_complete(netpoll_start_xmit(skb, dev, txq))) {
>  			skb_queue_head(&npinfo->txq, skb);
>  			HARD_TX_UNLOCK(dev, txq);

It seems the queue is already protected in here, so, why do we need to
local_irq_save above?

> -			local_irq_restore(flags);
> +			netpoll_tx_end(flags);
>  
>  			schedule_delayed_work(&npinfo->tx_work, HZ/10);
>  			return;
>  		}
>  		HARD_TX_UNLOCK(dev, txq);
> -		local_irq_restore(flags);
> +		netpoll_tx_end(flags);
>  	}
>  }
>  
> @@ -246,7 +269,7 @@ static void refill_skbs(struct netpoll *
>  static void zap_completion_queue(void)
>  {
>  	unsigned long flags;
> -	struct softnet_data *sd = &get_cpu_var(softnet_data);
> +	struct softnet_data *sd = this_cpu_ptr(&softnet_data);

How do I check if this is safe to do ?

