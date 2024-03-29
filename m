Return-Path: <netdev+bounces-83371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD31B892106
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9CC1F28284
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DA56A355;
	Fri, 29 Mar 2024 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKF8iGrY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D33458127;
	Fri, 29 Mar 2024 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711727795; cv=none; b=Gac01Crop7e71fpKUmjfP2oG2Wit4oUn1i/TKb/vgwfoCzB9/t0FFVcF6pZdgzhQR2LzlCqcMjm0ma20CUk8OIRitIBHUlNdI0kFspgbM6BgD30Cc7QEWpfn1HwjSGe/0jMGDJEQj0B/G5wUOXVt6a+ojS4bbLi+L3JNK6NjqgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711727795; c=relaxed/simple;
	bh=VA70TNqp6rYzQYotXWnZ+cUWcG2KLwGIWVRMg4W58hI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ga+dXH0WFBYqOQMwF/vhYPqDROZtou4zwyHZ0DBgosJbhPI/+4oX0a9JI20NoUbzFrR2UNAB4R14gIKwkEbF8yjmJnWDargQmzCl5oA6BKtritXdsPALwqqU4oX0hOosB0c5tlf0V+fvVh3uv09MWCCQ/f/BEpA5Oc6XMIl6PIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKF8iGrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5620BC433F1;
	Fri, 29 Mar 2024 15:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711727794;
	bh=VA70TNqp6rYzQYotXWnZ+cUWcG2KLwGIWVRMg4W58hI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YKF8iGrYZpeLAzpZzAjVwo8jER3GDAKAo/jvGZ1UIugsYar3NoYAWxlJpaAl7laWC
	 aJlB1viEM8FksuT3y32RSj9DPOwoI+M0cUQCF4ZJ9J2R705vArNy3RnjoymR4RrUjh
	 HqOfl9Pj6YIheIKJnOa6q4VrsD8vku3qnQBNG5+8xXumz3PoGiOZttcJnnjWSd8VgO
	 hUdLx64jOODV5wpWzwY3FQWESPokYUdoVSdXn8i5exbWhjENUN03b36VNrE9UZRk7k
	 1u6WDZf+qn3mxwnYc9YKO8AJcj1PKiMHgCFsfzkFyJLuo/7seaJyavE89mFyfxFYUl
	 E15HBw2b8IETA==
Date: Fri, 29 Mar 2024 08:56:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: aleksander.lobakin@intel.com, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, Taras Chornyi <taras.chornyi@plvision.eu>,
 quic_jjohnson@quicinc.com, kvalo@kernel.org, leon@kernel.org,
 dennis.dalessandro@cornelisnetworks.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/5] net: marvell: prestera: allocate dummy
 net_device dynamically
Message-ID: <20240329085633.2cfae5e5@kernel.org>
In-Reply-To: <20240328235214.4079063-3-leitao@debian.org>
References: <20240328235214.4079063-1-leitao@debian.org>
	<20240328235214.4079063-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 16:52:02 -0700 Breno Leitao wrote:
> -	init_dummy_netdev(&sdma->napi_dev);
> +	sdma->napi_dev = alloc_netdev_dummy(0);
> +	if (!sdma->napi_dev) {
> +		dev_err(dev, "not able to initialize dummy device\n");
> +		goto err_alloc_dummy;
> +	}
> +
>  

duplicated empty line here

> -	netif_napi_add(&sdma->napi_dev, &sdma->rx_napi, prestera_sdma_rx_poll);
> +	netif_napi_add(sdma->napi_dev, &sdma->rx_napi, prestera_sdma_rx_poll);
>  	napi_enable(&sdma->rx_napi);
>  
>  	return 0;
>  
> +err_alloc_dummy:
> +	prestera_hw_event_handler_unregister(sw, PRESTERA_EVENT_TYPE_RXTX,
> +					     prestera_rxtx_handle_event);
>  err_evt_register:
>  err_tx_init:
>  	prestera_sdma_tx_fini(sdma);
> @@ -682,6 +690,7 @@ static void prestera_sdma_switch_fini(struct prestera_switch *sw)
>  	prestera_sdma_tx_fini(sdma);
>  	prestera_sdma_rx_fini(sdma);
>  	dma_pool_destroy(sdma->desc_pool);
> +	kfree(sdma->napi_dev);

Why kfree()? Let's use free_netdev() consistently, in case one day
we have to undo something alloc_netdev_dummy() has done.

