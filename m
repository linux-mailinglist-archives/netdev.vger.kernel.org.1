Return-Path: <netdev+bounces-229686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39840BDFC17
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBBAE3E07AD
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBF22BD5B3;
	Wed, 15 Oct 2025 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUxAGSU3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B78347C7;
	Wed, 15 Oct 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547000; cv=none; b=NlHFktXFkqJS7Md8n766/Orm9Cqu3jXgJ7s6RjmeU++5hD+730qlY7fqFhhwRPU5LXPp+I3zd+zOKEywrUyQ0IdIQtGNiiUMzX3LjyKRnOhRKesNM2Z4Tb/B+2kne4w5mM8LH7rcwrJJcSObCC7NYfCLKX5Nd0Q7XWWPOOzX2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547000; c=relaxed/simple;
	bh=jHn8mBTmQDsers17Sc22lz/OU2GHErVRpMh14tH0dTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWy6q8WeKBjZDqjZS67FSwBlvxrEEYiK10gJNLg9cODTojax+m3XHqPg/FyJ5EXcpjCBKqAzFyvoQp94rjza7vqkiv5sxd5CAZJxA3i+VCTTyudUxPmGNHpqwFO5jSb0z6qEgrSSVCQtAv0X3drhtdus9SovhP1wXCMXYSMkYI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUxAGSU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DABC4CEF8;
	Wed, 15 Oct 2025 16:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760546999;
	bh=jHn8mBTmQDsers17Sc22lz/OU2GHErVRpMh14tH0dTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUxAGSU3nPV3urotXuxZIAo8PEzSkNs7oylf/pifc6hd1vMqsTRC9QJdoAQCQPm1m
	 bUdYs8A768fWWFwXy3cEey3CzQqmcOQV2Q4QzYoNt70jjgSSKONfb+RcaFCwiS+nB8
	 GhcVtHa4bNdVCSM1kntsSZejXd4NYdsJ4XklyJ1WW/lFo/0Jci5mDtpRwjy5QfAzm0
	 dDOVIQm5jvqBHU9qSqD1rCNa4PWeCb9fyFXAFUVDpFcEGpW38ivXDfO1D5hzIqAbLe
	 nrGlUNvmobPiG/YPt3R5nc7gFYCPvjspJx5FC6NhCJIEwK+BDo51cRTm3b2OcMAF6k
	 kGhhh7bwTVSOw==
Date: Wed, 15 Oct 2025 17:49:55 +0100
From: Simon Horman <horms@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: Eric Dumazet <edumazet@google.com>, Wang Liang <wangliang74@huawei.com>,
	nhorman@tuxdriver.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH RFC net-next] net: drop_monitor: Add debugfs support
Message-ID: <aO_Qs9jzbguNrTjV@horms.kernel.org>
References: <20251015101417.1511732-1-wangliang74@huawei.com>
 <CANn89iLZBMWpU7kMjd8akT+L8FbsnO+wqgjCaXF2KOCFz9Hiag@mail.gmail.com>
 <aO-CJ7caP083oBJg@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO-CJ7caP083oBJg@strlen.de>

On Wed, Oct 15, 2025 at 01:14:47PM +0200, Florian Westphal wrote:
> Eric Dumazet <edumazet@google.com> wrote:
> > I do not understand the fascination with net/core/drop_monitor.c,
> > which looks very old school to me,
> > and misses all the features,  flexibility, scalability  that 'perf',
> > eBPF tracing, bpftrace, .... have today.
> > 
> > Adding  /sys/kernel/debug/drop_monitor/* is even more old school.
> > 
> > Not mentioning the maintenance burden.
> > 
> > For me the choice is easy :
> > 
> > # CONFIG_NET_DROP_MONITOR is not set
> > 
> > perf record -ag -e skb:kfree_skb sleep 1
> > 
> > perf script # or perf report
> 
> Maybe:
> 
> diff --git a/net/Kconfig b/net/Kconfig
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -400,15 +400,15 @@ config NET_PKTGEN
>           module will be called pktgen.
> 
>  config NET_DROP_MONITOR
> -       tristate "Network packet drop alerting service"
> +       tristate "Legacy network packet drop alerting service"

+1

...

