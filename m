Return-Path: <netdev+bounces-222143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C23B53404
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B21394E01E6
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2349C338F5E;
	Thu, 11 Sep 2025 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I729FcCZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A64338F55
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598023; cv=none; b=XK/B8tckdputmlsJ6WiduJYR+SfV/AVvODU8Qgo7MolgvTNQFnbqJJyF/z6N5iJ3VkfpoLuK8dgDWSLqR8CwvWIMrofZOvhDbOdZBsKIeKKippk4eGwlkX98ayN2KlNh6YDNP2Vv1oNN8BX8acU9RztVWI2ZKK3lGrjIGU6/NvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598023; c=relaxed/simple;
	bh=k+AwP+Z8KbyaIwb8eKGCi8qnaBoAmcTFFD/Bl1o8oXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oz9l4oaXqGbAvryIgbQcH+giDpmUGdhw/Pm9Q04nNpEtJXnA8yi2TXaLJB1lB4UxDFZmzcxZqW5mAZLvX+AGk61YUaA9jiAK5TxMgfUPE8+9yYkXDfRr+VLxN/XsUPE6ISNBeghu1BRy9g9OIFVQYv5VpzCrPoMndBmkvIY4xcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I729FcCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358E3C4CEF1;
	Thu, 11 Sep 2025 13:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757598022;
	bh=k+AwP+Z8KbyaIwb8eKGCi8qnaBoAmcTFFD/Bl1o8oXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I729FcCZr+AQnf88UgBcPJOKQ5AdAJNWVkIJHwBKgS+MbKp8V7UEHmxU38ztyrtoH
	 aB9OOtFsyAMgAD6dK7KlTSkMVWZfnn2S92KjuXPnbBAKwQMJdEp0bN3mRCUlR0HIUH
	 NuxRJnk5nwZXfsl52rs/9DPYc6yDZyiEo/L0JLzyUxE/fWFv3k0s2pwVdg4VXwHiCB
	 PEbiZpVtrAtI6Qjcow5pCB4LKDHsLtm3oWcjoioYhHJdWZwufJ5pd9PRguEsjA4YMF
	 6JOOYe2bJLjR9ki6I2wudX4Q0/WF8PNcAh4+So++V/sZ97KRwZRAkzrLknD7OSnoBm
	 QUpp7RPYLwqNw==
Date: Thu, 11 Sep 2025 06:40:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "David S . Miller " <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, willemb@google.com,
 netdev@vger.kernel.org, mkarsten@uwaterloo.ca
Subject: Re: [PATCH net] net: Use NAPI_* in test_bit when stopping napi
 kthread
Message-ID: <20250911064021.026ad6f2@kernel.org>
In-Reply-To: <20250910203716.1016546-1-skhawaja@google.com>
References: <20250910203716.1016546-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 20:37:16 +0000 Samiullah Khawaja wrote:
> napi_stop_kthread waits for the NAPI_STATE_SCHED_THREADED to be unset
> before stopping the kthread. But it uses test_bit with the
> NAPIF_STATE_SCHED_THREADED and that might stop the kthread early before
> the flag is unset.
> 
> Use the NAPI_* variant of the NAPI state bits in test_bit instead.
> 
> Tested:
>  ./tools/testing/selftests/net/nl_netdev.py
>  TAP version 13
>  1..7
>  ok 1 nl_netdev.empty_check
>  ok 2 nl_netdev.lo_check
>  ok 3 nl_netdev.page_pool_check
>  ok 4 nl_netdev.napi_list_check
>  ok 5 nl_netdev.dev_set_threaded
>  ok 6 nl_netdev.napi_set_threaded
>  ok 7 nl_netdev.nsim_rxq_reset_down
>  # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
>  ./tools/testing/selftests/drivers/net/napi_threaded.py
>  TAP version 13
>  1..2
>  ok 1 napi_threaded.change_num_queues
>  ok 2 napi_threaded.enable_dev_threaded_disable_napi_threaded
>  # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Fixes: 689883de94dd ("net: stop napi kthreads when THREADED napi is disabled")
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

Is this basically addressing the bug that Martin run into?

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 93a25d87b86b..8d49b2198d07 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6965,7 +6965,7 @@ static void napi_stop_kthread(struct napi_struct *napi)
>  	 * the kthread.
>  	 */
>  	while (true) {
> -		if (!test_bit(NAPIF_STATE_SCHED_THREADED, &napi->state))
> +		if (!test_bit(NAPI_STATE_SCHED_THREADED, &napi->state))
>  			break;
>  
>  		msleep(20);


