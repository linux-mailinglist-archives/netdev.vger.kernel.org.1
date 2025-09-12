Return-Path: <netdev+bounces-222683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9055EB556E2
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D69AA06FE5
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7DD32A829;
	Fri, 12 Sep 2025 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5WpylJv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D59324B35
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757705167; cv=none; b=iM35GMTZr9jnBeSI9dso6xIUfI6GbYapqTmioiMkaoV24QcPRl75fdnG/2nZDjcMgPyXVFjQeYEBRSjUrPMJ9A+h/5Ut1pgWEGyYxI1MsZ6KB3ryb90JC96ZEU9v1DRevaG/IrHbWlwWQmpEwHNMAQt8xaxljqpxWYAq6y7MzZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757705167; c=relaxed/simple;
	bh=2Zsxl07W6nO0TgtVZQTj1gFVLM9WCUWa7vBd8AUepSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxNPqOSpqpcMgQ4ANX2hWvYrOsRTdk6qiiuN5euNr3U6wP1Z9v3dvrFT7raadx+LBl+316nEQbtLhtpwa05+14e9sa/pC9hgLH4wMadh8WHbeTwPI1LlS8J4C3WDS2PzLtorayEATw/tt9UKLNF6EDkBUGMEV2RgBK8UUoInRhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5WpylJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0D3C4CEF4;
	Fri, 12 Sep 2025 19:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757705167;
	bh=2Zsxl07W6nO0TgtVZQTj1gFVLM9WCUWa7vBd8AUepSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5WpylJvaX830QIxPWC/QvC8o2FyGi+DCCaVeLEBjR9VnlRgdnQrLUhodAfWfEJ6e
	 GRY9siz1QQQW8IYCjHmK+JgEWQxnoSp3OdqcP8COmkbXSw5Po25EJFo7o89/FDestl
	 hsgSAc2a3c0hodUknmc1LOZ4ym8azoAfEFg++SQ3WybsRoWXxY8kCV4a7ZtbtDoSLL
	 WxGEucRJcbwvrgeYGQeYVrEM6O/+2o0TSkvRy1Kh6S3y3nf6BV8BtriYai4+v8nP2A
	 R3g3MKmsOSn7VGxhXQd+3n82KGagOEQd1wcbjcmnEv3bLAaGyUZxou8CmLBz0b0gle
	 AjZ05wpCmvchw==
Date: Fri, 12 Sep 2025 20:26:03 +0100
From: Simon Horman <horms@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	willemb@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: Use NAPI_* in test_bit when stopping napi
 kthread
Message-ID: <20250912192603.GF224143@horms.kernel.org>
References: <20250910203716.1016546-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910203716.1016546-1-skhawaja@google.com>

On Wed, Sep 10, 2025 at 08:37:16PM +0000, Samiullah Khawaja wrote:
> napi_stop_kthread waits for the NAPI_STATE_SCHED_THREADED to be unset
> before stopping the kthread. But it uses test_bit with the
> NAPIF_STATE_SCHED_THREADED and that might stop the kthread early before
> the flag is unset.
> 
> Use the NAPI_* variant of the NAPI state bits in test_bit instead.

I think it would be useful to mention the difference between 
NAPI_STATE_SCHED_THREADED and NAPIF_STATE_SCHED_THREADED.

For me, that would be that one is a bit number, while
the other is a mask with only the corresponding bit set.

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

With the above addressed, feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>

...

