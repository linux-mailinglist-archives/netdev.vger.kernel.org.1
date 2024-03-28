Return-Path: <netdev+bounces-82830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4449988FE17
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DD2291288
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D1864CF3;
	Thu, 28 Mar 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwh6Uk3Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B82A1AA
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625527; cv=none; b=OpJmAdYk2P+w+r+gSqwXmpjHFcXL+RrNSsB3J5kTjrehaBZVzzvJdv8t9u6JNLET10uOg1fDLKiz4syUFkL+/MtbXFah2l+k8m/dCFw3myBadjlTa+mKnZ2TI28ttryJYNeGfdg1p3Sg+W21ZH8Dx2P/wVF1Ipbsr857LjDagH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625527; c=relaxed/simple;
	bh=s1Kbht052+Q3EYXLA3+hm7ApiGwdjm7g8WW19YP5C6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkkuQMbZNAxb8EG+bvR3yRKMMlWKjTY38ncnUqp9dmYqoE+C8Ze14sSAtuynyF3tNxs2fns2lqmQtKEH1BWaIqAYRxovrfsEKpZ4FxRqkS6o2doJQ0N+R8H98fRNRbm9dB8TE2BFygYscJYNsogeIbwH6aafDb52R52YMPMuXwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwh6Uk3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B50C433F1;
	Thu, 28 Mar 2024 11:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711625527;
	bh=s1Kbht052+Q3EYXLA3+hm7ApiGwdjm7g8WW19YP5C6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwh6Uk3ZRyOSlz/Or4Da1ULl71LQUnrLGlaxQA8U0S3NRmJIEUBeqhwBJlb57Rzd3
	 w6KhpDYV/AhkKd0OshpY7KcSxVZkJvfq51/esQwWZ4OT8GVZv1SzySiBibc4jsoRaa
	 Vqy8pavoaz/X9xRer/fc7ZBsJO4IpEfU9i5VkWS+DdekYDj6R0Wvggb7SFkKnnf+J+
	 hCw8WWm2G9kogAd9gFDQoZje26shpas497IwDnXODo30bfFXoW0IacEC7DzCV3Tf0z
	 g+MSODMq8aBtznJIVmQd7mQ93qGQixuH+875jjBKKkD3P/uA9wIo5nOVjUpgUElVr8
	 K3UT7/jzDXxhA==
Date: Thu, 28 Mar 2024 11:32:02 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, Alexander Lobakin <aleksander.lobakin@intel.com>,
	alexs@kernel.org, siyanteng@loongson.cn, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v2] net: remove gfp_mask from napi_alloc_skb()
Message-ID: <20240328113202.GH403975@kernel.org>
References: <20240327040213.3153864-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327040213.3153864-1-kuba@kernel.org>

On Tue, Mar 26, 2024 at 09:02:12PM -0700, Jakub Kicinski wrote:
> __napi_alloc_skb() is napi_alloc_skb() with the added flexibility
> of choosing gfp_mask. This is a NAPI function, so GFP_ATOMIC is
> implied. The only practical choice the caller has is whether to
> set __GFP_NOWARN. But that's a false choice, too, allocation failures
> in atomic context will happen, and printing warnings in logs,
> effectively for a packet drop, is both too much and very likely
> non-actionable.
> 
> This leads me to a conclusion that most uses of napi_alloc_skb()
> are simply misguided, and should use __GFP_NOWARN in the first
> place. We also have a "standard" way of reporting allocation
> failures via the queue stat API (qstats::rx-alloc-fail).
> 
> The direct motivation for this patch is that one of the drivers
> used at Meta calls napi_alloc_skb() (so prior to this patch without
> __GFP_NOWARN), and the resulting OOM warning is the top networking
> warning in our fleet.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


